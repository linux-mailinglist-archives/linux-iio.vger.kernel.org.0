Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E020D37083D
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEAR1b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhEAR1a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 502A861352;
        Sat,  1 May 2021 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619890000;
        bh=FUch7K2YPak34gEMoFnxZ2XFRa3bDN6RsgpW16M1uz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6FjrSVBep2SyD6fLbVX9IZo048J7b6K1POpaQnU6nKiVjPY/ADDdG5eteWZjod4F
         ujZhRE0Erx8ewtyVBDObQyqaQc5lEQKJc6irDRGg0sjVneodMic3m1+xUM0Brgc4Lo
         1AXzx1bcUDegAgZzuIFJOU18KBZ4iIXomApxdCqk9t35SSFmepc2pkgnIpvq9503u3
         8vAeNHQPtxtJf0kDrQL/3Z3ZFS4Je618NJalP1VZ9Yg8P/qoQhFBppzSsJQscfiXnw
         t99lj8g6/3bTmo3TEagPiFMaAr6odOXRreZfT09zbXLoDxb39Klc/nLHk1Dy8X0+AQ
         zYPsKnzs6siLQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/4] iio: core: Introduce iio_push_to_buffers_with_ts_na() for non aligned case.
Date:   Sat,  1 May 2021 18:25:12 +0100
Message-Id: <20210501172515.513486-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501172515.513486-1-jic23@kernel.org>
References: <20210501172515.513486-1-jic23@kernel.org>
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
 drivers/iio/industrialio-buffer.c | 36 +++++++++++++++++++++++++++++++
 include/linux/iio/buffer.h        |  4 ++++
 include/linux/iio/iio-opaque.h    |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 9a8e16c7e9af..818dfaa73665 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1727,6 +1727,42 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 }
 EXPORT_SYMBOL_GPL(iio_push_to_buffers);
 
+/**
+ * iio_push_to_buffers_with_ts_na() - push to registered buffer,
+ *    no alignment or space requirements.
+ * @indio_dev:		iio_dev structure for device.
+ * @data:		channel data excluding the timestamp.
+ * @data_sz:		size of data.
+ * @timestamp:		timestamp for the sample data.
+ *
+ * This special variant of iio_push_to_buffers_with_timetamp() does
+ * not require space for the timestamp, or 8 byte alignment of data.
+ * It does however require an allocation on first call and additional
+ * coppies on all calls, so should be avoided if possible
+ */
+int iio_push_to_buffers_with_ts_na(struct iio_dev *indio_dev,
+				   const void *data,
+				   size_t data_sz,
+				   int64_t timestamp)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	data_sz = min_t(size_t, indio_dev->scan_bytes, data_sz);
+	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {
+		iio_dev_opaque->bounce_buffer =
+			devm_krealloc(&indio_dev->dev,
+				      iio_dev_opaque->bounce_buffer,
+				      indio_dev->scan_bytes, GFP_KERNEL);
+		if (!iio_dev_opaque)
+			return -ENOMEM;
+	}
+	memcpy(iio_dev_opaque->bounce_buffer, data, data_sz);
+	return iio_push_to_buffers_with_timestamp(indio_dev,
+						  iio_dev_opaque->bounce_buffer,
+						  timestamp);
+}
+EXPORT_SYMBOL_GPL(iio_push_to_buffers_with_ts_na);
+
 /**
  * iio_buffer_release() - Free a buffer's resources
  * @ref: Pointer to the kref embedded in the iio_buffer struct
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index b6928ac5c63d..4ea9027ad2bf 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -38,6 +38,10 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
+int iio_push_to_buffers_with_ts_na(struct iio_dev *indio_dev,
+				   const void *data, size_t data_sz,
+				   int64_t timestamp);
+
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 				   const unsigned long *mask);
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 32addd5e790e..70ca58e66c0a 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -19,6 +19,8 @@
  * @groupcounter:		index of next attribute group
  * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
  * @legacy_buffer_group:	attribute group for legacy buffer attributes group
+ * @bounce_buffer:		for devices that call iio_push_to_buffers_with_timestamp_na
+ * @bounce_buffer_size:		size of currently allocate bounce buffer
  * @debugfs_dentry:		device specific debugfs dentry
  * @cached_reg_addr:		cached register address for debugfs reads
  * @read_buf:			read buffer to be used for the initial reg read
@@ -38,6 +40,8 @@ struct iio_dev_opaque {
 	int				groupcounter;
 	struct attribute_group		legacy_scan_el_group;
 	struct attribute_group		legacy_buffer_group;
+	void				*bounce_buffer;
+	size_t				bounce_buffer_size;
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
-- 
2.31.1

