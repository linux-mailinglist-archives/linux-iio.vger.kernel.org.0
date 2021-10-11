Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F81428EC7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhJKNvt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 09:51:49 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24241 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbhJKNvK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 09:51:10 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSg9F61Qtz8tYT;
        Mon, 11 Oct 2021 21:48:01 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 21:49:06 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 21:49:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <ars@metafoo.de>, <jic23@kernel.org>,
        <alexandru.ardelean@analog.com>, <andy.shevchenko@gmail.com>
Subject: [PATCH] iio: core: do not create debugfs when has no dev name
Date:   Mon, 11 Oct 2021 21:56:54 +0800
Message-ID: <20211011135654.282958-1-yangyingliang@huawei.com>
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

I got a null-ptr-deref report when doing fault injection test:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP KASAN PTI
RIP: 0010:strlen+0x0/0x20
Call Trace:
 start_creating+0x199/0x2f0
 debugfs_create_dir+0x25/0x430
 __iio_device_register+0x4da/0x1b40 [industrialio]
 __devm_iio_device_register+0x22/0x80 [industrialio]
 max1027_probe+0x639/0x860 [max1027]
 spi_probe+0x183/0x210
 really_probe+0x285/0xc30

If dev_set_name() fails, the dev_name() is null, add check for
device name before creating debugfs.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e553f182d55b ("staging: iio: core: Introduce debugfs support...")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2dc837db50f7..8974490ad536 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -466,7 +466,7 @@ static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 	if (indio_dev->info->debugfs_reg_access == NULL)
 		return;
 
-	if (!iio_debugfs_dentry)
+	if (!iio_debugfs_dentry || !dev_name(&indio_dev->dev))
 		return;
 
 	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-- 
2.25.1

