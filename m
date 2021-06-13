Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B49A3A593A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhFMPKv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhFMPKv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 995376128A;
        Sun, 13 Jun 2021 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623596929;
        bh=TftDME3258diEPPsF5wBkvYXL7CwJi11GQ4g7EHXE28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTmzIc0vP6dSWnukkuLtzGPlmDxAu5yqzVmnB+D7FyfvRky55GOFQ0eUugOcQTUZH
         WhDXsJ5kG91GkuWXVfLbm3GcRtosg99Us7oOPLCmIsau15uOkYC8YBIm5YjOm4x5f/
         PK+8brVU2SKXeOpq9siGaP/SszPgipkc//6kv+tfcrPpd+7qFxTLvr1kyUXQ5ZXYsN
         WGQdICoVphs4GPn9T3B/eHUFn/deNMPTER135gt86OTzdt4q+dcmYoRdX7Vnf2ROrr
         kXncA+aFRnLm1V9bx9RNnM67zaa7qX8re8vjWLZr3t/tQ0qf/cdGzlI0CGrfQPYqNe
         67lh+rlt8YELA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/4] iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()
Date:   Sun, 13 Jun 2021 16:10:36 +0100
Message-Id: <20210613151039.569883-2-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613151039.569883-1-jic23@kernel.org>
References: <20210613151039.569883-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst it is almost always possible to arrange for scan data to be
read directly into a buffer that is suitable for passing to
iio_push_to_buffers_with_timestamp(), there are a few places where
leading data needs to be skipped over.

For these cases introduce a function that will allocate an appropriate
sized and aligned bounce buffer (if not already allocated) and copy
the unaligned data into that before calling
iio_push_to_buffers_with_timestamp() on the bounce buffer.
We tie the lifespace of this buffer to that of the iio_dev.dev
which should ensure no memory leaks occur.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 46 +++++++++++++++++++++++++++++++
 include/linux/iio/buffer.h        |  4 +++
 include/linux/iio/iio-opaque.h    |  4 +++
 3 files changed, 54 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index fdd623407b96..5241b5a5c6c0 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1730,6 +1730,52 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 }
 EXPORT_SYMBOL_GPL(iio_push_to_buffers);
 
+/**
+ * iio_push_to_buffers_with_ts_unaligned() - push to registered buffer,
+ *    no alignment or space requirements.
+ * @indio_dev:		iio_dev structure for device.
+ * @data:		channel data excluding the timestamp.
+ * @data_sz:		size of data.
+ * @timestamp:		timestamp for the sample data.
+ *
+ * This special variant of iio_push_to_buffers_with_timestamp() does
+ * not require space for the timestamp, or 8 byte alignment of data.
+ * It does however require an allocation on first call and additional
+ * copies on all calls, so should be avoided if possible.
+ */
+int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
+					  const void *data,
+					  size_t data_sz,
+					  int64_t timestamp)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	/*
+	 * Conservative estimate - we can always safely copy the minimum
+	 * of either the data provided or the length of the destination buffer.
+	 * This relaxed limit allows the calling drivers to be lax about
+	 * tracking the size of the data they are pushing, at the cost of
+	 * unnecessary copying of padding.
+	 */
+	data_sz = min_t(size_t, indio_dev->scan_bytes, data_sz);
+	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {
+		void *bb;
+
+		bb = devm_krealloc(&indio_dev->dev,
+				   iio_dev_opaque->bounce_buffer,
+				   indio_dev->scan_bytes, GFP_KERNEL);
+		if (!bb)
+			return -ENOMEM;
+		iio_dev_opaque->bounce_buffer = bb;
+		iio_dev_opaque->bounce_buffer_size = indio_dev->scan_bytes;
+	}
+	memcpy(iio_dev_opaque->bounce_buffer, data, data_sz);
+	return iio_push_to_buffers_with_timestamp(indio_dev,
+						  iio_dev_opaque->bounce_buffer,
+						  timestamp);
+}
+EXPORT_SYMBOL_GPL(iio_push_to_buffers_with_ts_unaligned);
+
 /**
  * iio_buffer_release() - Free a buffer's resources
  * @ref: Pointer to the kref embedded in the iio_buffer struct
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index b6928ac5c63d..451379a3984a 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -38,6 +38,10 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
+int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
+					  const void *data, size_t data_sz,
+					  int64_t timestamp);
+
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 				   const unsigned long *mask);
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index c9504e9da571..2be12b7b5dc5 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -23,6 +23,8 @@
  * @groupcounter:		index of next attribute group
  * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
  * @legacy_buffer_group:	attribute group for legacy buffer attributes group
+ * @bounce_buffer:		for devices that call iio_push_to_buffers_with_timestamp_unaligned()
+ * @bounce_buffer_size:		size of currently allocate bounce buffer
  * @scan_index_timestamp:	cache of the index to the timestamp
  * @clock_id:			timestamping clock posix identifier
  * @chrdev:			associated character device
@@ -50,6 +52,8 @@ struct iio_dev_opaque {
 	int				groupcounter;
 	struct attribute_group		legacy_scan_el_group;
 	struct attribute_group		legacy_buffer_group;
+	void				*bounce_buffer;
+	size_t				bounce_buffer_size;
 
 	unsigned int			scan_index_timestamp;
 	clockid_t			clock_id;
-- 
2.32.0

