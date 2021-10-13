Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7800642BC1B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhJMJwN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 05:52:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:51040 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239187AbhJMJv7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Oct 2021 05:51:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207506725"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="207506725"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="491390570"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2021 02:49:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4FBFD37B; Wed, 13 Oct 2021 12:49:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
Date:   Wed, 13 Oct 2021 12:49:22 +0300
Message-Id: <20211013094923.2473-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
References: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

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
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4209e933ab80..bb181d11573c 100644
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
2.33.0

