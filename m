Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC542BBB9
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 11:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhJMJiN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 05:38:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28932 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhJMJiK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 05:38:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTnNV0TLdzbn85;
        Wed, 13 Oct 2021 17:31:38 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:35:58 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 17:35:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <ardeleanalex@gmail.com>
Subject: [PATCH] iio: buffer: Fix memory leak in __iio_buffer_alloc_sysfs_and_mask()
Date:   Wed, 13 Oct 2021 17:43:43 +0800
Message-ID: <20211013094343.315275-1-yangyingliang@huawei.com>
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

When iio_buffer_wrap_attr() returns NULL or buffer->buffer_group.name alloc
fails, the 'attr' which is allocated in __iio_buffer_alloc_sysfs_and_mask()
is not freed, and cause memory leak.

unreferenced object 0xffff888014882a00 (size 64):
  comm "i2c-adjd_s311-8", pid 424, jiffies 4294907737 (age 44.396s)
  hex dump (first 32 bytes):
    00 0f 8a 15 80 88 ff ff 00 0e 8a 15 80 88 ff ff  ................
    80 04 8a 15 80 88 ff ff 80 05 8a 15 80 88 ff ff  ................
  backtrace:
    [<0000000021752e67>] __kmalloc+0x1af/0x3c0
    [<0000000043e8305c>] iio_buffers_alloc_sysfs_and_mask+0xe73/0x1570 [industrialio]
    [<00000000b7aa5a17>] __iio_device_register+0x483/0x1a30 [industrialio]
    [<000000003fa0fb2f>] __devm_iio_device_register+0x23/0x90 [industrialio]
    [<000000003ab040cf>] adjd_s311_probe+0x19c/0x200 [adjd_s311]
    [<0000000080458969>] i2c_device_probe+0xa31/0xbe0
    [<00000000e20678ad>] really_probe+0x299/0xc30
    [<000000006bea9b27>] __driver_probe_device+0x357/0x500
    [<00000000e1df10d4>] driver_probe_device+0x4e/0x140
    [<0000000003661beb>] __device_attach_driver+0x257/0x340
    [<000000005bb4aa26>] bus_for_each_drv+0x166/0x1e0
    [<00000000272c5236>] __device_attach+0x272/0x420
    [<00000000d52a96ae>] bus_probe_device+0x1eb/0x2a0
    [<00000000129f7737>] device_add+0xbf0/0x1f90
    [<000000005eed4e52>] i2c_new_client_device+0x622/0xb20
    [<00000000b85a9c43>] new_device_store+0x1fa/0x420

This patch fix to free it before the error return.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 547a92d469ae..ae0912a14578 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1536,6 +1536,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		       sizeof(struct attribute *) * buffer_attrcount);
 
 	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
+	buffer->buffer_group.attrs = attr;
 
 	for (i = 0; i < buffer_attrcount; i++) {
 		struct attribute *wrapped;
@@ -1543,7 +1544,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		wrapped = iio_buffer_wrap_attr(buffer, attr[i]);
 		if (!wrapped) {
 			ret = -ENOMEM;
-			goto error_free_scan_mask;
+			goto error_free_buffer_attrs;
 		}
 		attr[i] = wrapped;
 	}
@@ -1558,8 +1559,6 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		goto error_free_buffer_attrs;
 	}
 
-	buffer->buffer_group.attrs = attr;
-
 	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
 	if (ret)
 		goto error_free_buffer_attr_group_name;
-- 
2.25.1

