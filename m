Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB19142BC18
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 11:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbhJMJwG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 05:52:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:42669 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239227AbhJMJvy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Oct 2021 05:51:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="208191045"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="208191045"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="524571237"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 13 Oct 2021 02:49:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 45E97361; Wed, 13 Oct 2021 12:49:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] iio: buffer: Use dedicated variable in iio_buffers_alloc_sysfs_and_mask()
Date:   Wed, 13 Oct 2021 12:49:23 +0300
Message-Id: <20211013094923.2473-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
References: <20211013094923.2473-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use dedicated variable for index in the loop in the
iio_buffers_alloc_sysfs_and_mask(). This will make code cleaner and
less error prone as proved by previous changes done in this function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-buffer.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index bb181d11573c..d53f8e6d5935 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1596,8 +1596,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	const struct iio_chan_spec *channels;
 	struct iio_buffer *buffer;
-	int unwind_idx;
-	int ret, i;
+	int ret, i, idx;
 	size_t sz;
 
 	channels = indio_dev->channels;
@@ -1612,15 +1611,12 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!iio_dev_opaque->attached_buffers_cnt)
 		return 0;
 
-	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
-		buffer = iio_dev_opaque->attached_buffers[i];
-		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
-		if (ret) {
-			unwind_idx = i - 1;
+	for (idx = 0; idx < iio_dev_opaque->attached_buffers_cnt; idx++) {
+		buffer = iio_dev_opaque->attached_buffers[idx];
+		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, idx);
+		if (ret)
 			goto error_unwind_sysfs_and_mask;
-		}
 	}
-	unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
 
 	sz = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
 	iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
@@ -1636,8 +1632,8 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return 0;
 
 error_unwind_sysfs_and_mask:
-	for (; unwind_idx >= 0; unwind_idx--) {
-		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
+	while (idx--) {
+		buffer = iio_dev_opaque->attached_buffers[idx];
 		__iio_buffer_free_sysfs_and_mask(buffer);
 	}
 	return ret;
-- 
2.33.0

