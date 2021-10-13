Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F442C35B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhJMOft (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 10:35:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25132 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbhJMOfo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 10:35:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HTw330XSpz1DGkp;
        Wed, 13 Oct 2021 22:31:59 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 22:33:36 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 22:33:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <ardeleanalex@gmail.com>
Subject: [PATCH] iio: buffer: Fix memory leak in iio_buffers_alloc_sysfs_and_mask()
Date:   Wed, 13 Oct 2021 22:41:20 +0800
Message-ID: <20211013144120.1684413-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
    [<00000000b721e9ec>] really_probe+0x285/0xc30
    [<00000000e6690642>] __driver_probe_device+0x35f/0x4f0
    [<000000003ee4152f>] driver_probe_device+0x4f/0x140
    [<0000000055cfdd2f>] __device_attach_driver+0x24c/0x330
    [<0000000098033282>] bus_for_each_drv+0x15d/0x1e0
    [<00000000fa1876f5>] __device_attach+0x267/0x410
    [<00000000838ca724>] bus_probe_device+0x1ec/0x2a0
    [<00000000f4ce978e>] device_add+0xc3d/0x2020
    [<000000000ee12e9b>] i2c_new_client_device+0x614/0xb00
    [<00000000fc5d3221>] new_device_store+0x1f4/0x410

Call iio_buffer_unregister_legacy_sysfs_groups() in error path
to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ae0912a14578..ba1c5c898e53 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1630,7 +1630,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
 	if (!iio_dev_opaque->buffer_ioctl_handler) {
 		ret = -ENOMEM;
-		goto error_unwind_sysfs_and_mask;
+		goto error_unregister_legacy_sysfs_groups;
 	}
 
 	iio_dev_opaque->buffer_ioctl_handler->ioctl = iio_device_buffer_ioctl;
@@ -1639,6 +1639,8 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 	return 0;
 
+error_unregister_legacy_sysfs_groups:
+	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
 error_unwind_sysfs_and_mask:
 	for (; unwind_idx >= 0; unwind_idx--) {
 		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
-- 
2.25.1

