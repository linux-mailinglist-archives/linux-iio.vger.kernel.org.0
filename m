Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5143108E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJRGb7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 02:31:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14823 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJRGb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 02:31:59 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HXn0g6P86z90Ff;
        Mon, 18 Oct 2021 14:24:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 14:29:45 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 14:29:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <ardeleanalex@gmail.com>
Subject: [PATCH v2] iio: buffer: Fix memory leak in iio_buffers_alloc_sysfs_and_mask()
Date:   Mon, 18 Oct 2021 14:37:18 +0800
Message-ID: <20211018063718.1971240-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When 'iio_dev_opaque->buffer_ioctl_handler' alloc fails in
iio_buffers_alloc_sysfs_and_mask(), the 'attrs' allocated in
iio_buffer_register_legacy_sysfs_groups() will be leaked:

unreferenced object 0xffff888108568d00 (size 128):
  comm "88", pid 2014, jiffies 4294963294 (age 26.920s)
  hex dump (first 32 bytes):
    80 3e da 02 80 88 ff ff 00 3a da 02 80 88 ff ff  .>.......:......
    00 35 da 02 80 88 ff ff 00 38 da 02 80 88 ff ff  .5.......8......
  backtrace:
    [<0000000095a9e51e>] __kmalloc+0x1a3/0x2f0
    [<00000000faa3735e>] iio_buffers_alloc_sysfs_and_mask+0xfa3/0x1480 [industrialio]
    [<00000000a46384dc>] __iio_device_register+0x52e/0x1b40 [industrialio]
    [<00000000210af05e>] __devm_iio_device_register+0x22/0x80 [industrialio]
    [<00000000730d7b41>] adjd_s311_probe+0x195/0x200 [adjd_s311]
    [<00000000c0f70eb9>] i2c_device_probe+0xa07/0xbb0

The iio_buffer_register_legacy_sysfs_groups() is
called in __iio_buffer_alloc_sysfs_and_mask(),
so move the iio_buffer_unregister_legacy_sysfs_groups()
into __iio_buffer_free_sysfs_and_mask(), then the memory
will be freed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  move iio_buffer_unregister_legacy_sysfs_groups() into
  __iio_buffer_free_sysfs_and_mask()
---
 drivers/iio/industrialio-buffer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a95cc2da56be..b29d105a75fe 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1583,8 +1583,12 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	return ret;
 }
 
-static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer,
+					     struct iio_dev *indio_dev,
+					     int index)
 {
+	if (index == 0)
+		iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
 	bitmap_free(buffer->scan_mask);
 	kfree(buffer->buffer_group.name);
 	kfree(buffer->buffer_group.attrs);
@@ -1638,7 +1642,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 error_unwind_sysfs_and_mask:
 	for (; unwind_idx >= 0; unwind_idx--) {
 		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
-		__iio_buffer_free_sysfs_and_mask(buffer);
+		__iio_buffer_free_sysfs_and_mask(buffer, indio_dev, unwind_idx);
 	}
 	return ret;
 }
@@ -1655,11 +1659,9 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
 	kfree(iio_dev_opaque->buffer_ioctl_handler);
 
-	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
-
 	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
 		buffer = iio_dev_opaque->attached_buffers[i];
-		__iio_buffer_free_sysfs_and_mask(buffer);
+		__iio_buffer_free_sysfs_and_mask(buffer, indio_dev, i);
 	}
 }
 
-- 
2.25.1

