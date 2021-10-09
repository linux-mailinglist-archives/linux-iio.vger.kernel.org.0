Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF0C4277C1
	for <lists+linux-iio@lfdr.de>; Sat,  9 Oct 2021 08:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhJIGeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Oct 2021 02:34:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23358 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhJIGeP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Oct 2021 02:34:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HRFVJ36HNzYkMC;
        Sat,  9 Oct 2021 14:27:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 14:31:56 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 9 Oct 2021
 14:31:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: fix double free in iio_device_unregister_sysfs()
Date:   Sat, 9 Oct 2021 14:39:35 +0800
Message-ID: <20211009063935.3187803-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I got the double free report:

[   68.308365][  T359] BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390
[   68.309532][  T359]
[   68.309886][  T359] CPU: 0 PID: 359 Comm: xrun Tainted: G        W         5.15.0-rc3-00109-g4dfd49fafc4d-dirty #474 523b7f3c65c42247635e2ac04a95f61f9f36678d
[   68.312059][  T359] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   68.313566][  T359] Call Trace:
[   68.314063][  T359]  dump_stack_lvl+0xe2/0x152
[   68.314793][  T359]  print_address_description.constprop.7+0x21/0x150
[   68.315842][  T359]  ? kfree+0xce/0x390
[   68.316444][  T359]  kasan_report_invalid_free+0x6f/0xa0
[   68.317289][  T359]  ? kfree+0xce/0x390
[   68.317902][  T359]  __kasan_slab_free+0x125/0x140
[   68.318660][  T359]  slab_free_freelist_hook+0x10d/0x240
[   68.319497][  T359]  ? iio_device_unregister_sysfs+0x108/0x13b [industrialio]
[   68.321179][  T359]  kfree+0xce/0x390
[   68.321781][  T359]  iio_device_unregister_sysfs+0x108/0x13b [industrialio]
[   68.323438][  T359]  iio_dev_release+0x9e/0x10e [industrialio]
[   68.324902][  T359]  ? iio_device_unregister_sysfs+0x13b/0x13b [industrialio]
[   68.326550][  T359]  device_release+0xa5/0x240
[   68.327258][  T359]  kobject_put+0x1e5/0x540
[   68.327954][  T359]  put_device+0x20/0x30
[   68.328612][  T359]  devm_iio_device_release+0x21/0x30 [industrialio]
[   68.330172][  T359]  release_nodes+0xc3/0x3b0
[   68.330874][  T359]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[   68.331765][  T359]  ? _raw_spin_unlock_irqrestore+0x4b/0x5d
[   68.332668][  T359]  ? trace_hardirqs_on+0x63/0x2d0
[   68.333509][  T359]  devres_release_group+0x1da/0x2c0
[   68.334325][  T359]  ? release_nodes+0x3b0/0x3b0
[   68.335069][  T359]  ? __devm_iio_device_register+0x36/0x80 [industrialio]
[   68.336721][  T359]  ? max517_probe+0x3df/0x6b0 [max517]
[   68.338122][  T359]  i2c_device_probe+0x628/0xbb0
[   68.338886][  T359]  ? i2c_device_match+0x110/0x110
[   68.339674][  T359]  really_probe+0x285/0xc30

If __iio_device_register() fails, iio_dev_opaque->groups will be freed
in error path in iio_device_unregister_sysfs(), then iio_dev_release()
will call iio_device_unregister_sysfs() again, it causes double free.
Set iio_dev_opaque->groups to NULL when it's freed to fix this double free.

Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
Reported-by: Hulk Robot <hulkci@huawei.com>
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

