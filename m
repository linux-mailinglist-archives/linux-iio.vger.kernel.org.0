Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0047542A0D9
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhJLJTv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 05:19:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14334 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhJLJTu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 05:19:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HT91Q0RNmz908x;
        Tue, 12 Oct 2021 17:12:58 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 17:17:46 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 17:17:46 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <andy.shevchenko@gmail.com>
Subject: [PATCH] iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
Date:   Tue, 12 Oct 2021 17:25:13 +0800
Message-ID: <20211012092513.1349295-1-yangyingliang@huawei.com>
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

When __iio_buffer_alloc_sysfs_and_mask() failed, 'unwind_idx' should be
set to 'i - 1' to prevent double-free when cleanup resources.

BUG: KASAN: double-free or invalid-free in __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
Call Trace:
 kfree+0x117/0x4c0
 __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
 iio_buffers_alloc_sysfs_and_mask+0x60d/0x1570 [industrialio]
 __iio_device_register+0x483/0x1a30 [industrialio]
 ina2xx_probe+0x625/0x980 [ina2xx_adc]

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ee708e6baacd ("iio: buffer: introduce support for attaching more IIO buffers")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a95cc2da56be..5f4bd0b73d03 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1616,7 +1616,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		buffer = iio_dev_opaque->attached_buffers[i];
 		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
 		if (ret) {
-			unwind_idx = i;
+			unwind_idx = i - 1;
 			goto error_unwind_sysfs_and_mask;
 		}
 	}
-- 
2.25.1

