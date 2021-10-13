Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D473342C36F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhJMOh0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 10:37:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25133 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhJMOhZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 10:37:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HTw522xvyz1DHR6;
        Wed, 13 Oct 2021 22:33:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 22:35:19 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 22:35:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <ardeleanalex@gmail.com>
Subject: [PATCH] iio: buffer: Fix memory leak in iio_buffer_register_legacy_sysfs_groups()
Date:   Wed, 13 Oct 2021 22:42:42 +0800
Message-ID: <20211013144242.1685060-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If the second iio_device_register_sysfs_group() fails,
'legacy_buffer_group.attrs' need be freed too or it will
cause memory leak:

unreferenced object 0xffff888003618280 (size 64):
  comm "xrun", pid 357, jiffies 4294907259 (age 22.296s)
  hex dump (first 32 bytes):
    80 f6 8c 03 80 88 ff ff 80 fb 8c 03 80 88 ff ff  ................
    00 f9 8c 03 80 88 ff ff 80 fc 8c 03 80 88 ff ff  ................
  backtrace:
    [<00000000076bfd43>] __kmalloc+0x1a3/0x2f0
    [<00000000c32e4886>] iio_buffers_alloc_sysfs_and_mask+0xc31/0x1290 [industrialio]
    [<000000002fcd0bb8>] __iio_device_register+0x52e/0x1b40 [industrialio]
    [<000000008116530c>] __devm_iio_device_register+0x22/0x80 [industrialio]
    [<000000008a47327c>] adjd_s311_probe+0x195/0x200 [adjd_s311]
    [<00000000f8eeb456>] i2c_device_probe+0xa07/0xbb0
    [<000000000e86686c>] really_probe+0x285/0xc30
    [<00000000a49db55c>] __driver_probe_device+0x35f/0x4f0
    [<00000000d1fd43a1>] driver_probe_device+0x4f/0x140
    [<000000008cdafdfa>] __device_attach_driver+0x24c/0x330
    [<000000006466e92e>] bus_for_each_drv+0x15d/0x1e0
    [<00000000154fbb1c>] __device_attach+0x267/0x410
    [<000000007c84d5d1>] bus_probe_device+0x1ec/0x2a0
    [<0000000019967467>] device_add+0xc3d/0x2020
    [<00000000a16d2d51>] i2c_new_client_device+0x614/0xb00
    [<00000000a56a901d>] new_device_store+0x1f4/0x410

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ba1c5c898e53..88741385764e 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1367,10 +1367,10 @@ static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
 
 	return 0;
 
-error_free_buffer_attrs:
-	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
 error_free_scan_el_attrs:
 	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
+error_free_buffer_attrs:
+	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
 
 	return ret;
 }
-- 
2.25.1

