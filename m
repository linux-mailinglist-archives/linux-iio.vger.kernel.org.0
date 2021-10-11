Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1A428976
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhJKJO5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 05:14:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24236 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhJKJO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 05:14:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSY2b1XngzQjBW;
        Mon, 11 Oct 2021 17:11:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 17:12:53 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 17:12:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <ars@metafoo.de>, <jic23@kernel.org>,
        <alexandru.ardelean@analog.com>, <andy.shevchenko@gmail.com>
Subject: [PATCH v2] iio: core: fix double free in iio_device_unregister_sysfs()
Date:   Mon, 11 Oct 2021 17:20:28 +0800
Message-ID: <20211011092028.2310144-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I got the double free report:

BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390

CPU: 0 PID: 359 Comm: xrun Tainted: G        W         5.15.0-rc3-00109-g4dfd49fafc4d-dirty #474 523b7f3c65c42247635e2ac04a95f61f9f36678d
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 dump_stack_lvl+0xe2/0x152
 print_address_description.constprop.7+0x21/0x150
 kasan_report_invalid_free+0x6f/0xa0
 __kasan_slab_free+0x125/0x140
 slab_free_freelist_hook+0x10d/0x240
 kfree+0xce/0x390
 iio_device_unregister_sysfs+0x108/0x13b [industrialio]
 iio_dev_release+0x9e/0x10e [industrialio]
 device_release+0xa5/0x240
 kobject_put+0x1e5/0x540
 put_device+0x20/0x30
 devm_iio_device_release+0x21/0x30 [industrialio]
 release_nodes+0xc3/0x3b0
 devres_release_group+0x1da/0x2c0
 i2c_device_probe+0x628/0xbb0
 really_probe+0x285/0xc30

If __iio_device_register() fails, iio_dev_opaque->groups will be freed
in error path in iio_device_unregister_sysfs(), then iio_dev_release()
will call iio_device_unregister_sysfs() again, it causes double free.
Set iio_dev_opaque->groups to NULL when it's freed to fix this double free.

Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
Reported-by: Hulk Robot <hulkci@huawei.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2dbb37e09b8c..2dc837db50f7 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1600,6 +1600,7 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 	kfree(iio_dev_opaque->chan_attr_group.attrs);
 	iio_dev_opaque->chan_attr_group.attrs = NULL;
 	kfree(iio_dev_opaque->groups);
+	iio_dev_opaque->groups = NULL;
 }
 
 static void iio_dev_release(struct device *device)
-- 
2.25.1

