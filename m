Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AA36B853
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhDZRvW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237515AbhDZRvW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64252611C1;
        Mon, 26 Apr 2021 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459440;
        bh=3vo7ZXahI7wAgRzB8k4gdspnJcSE5+quAxe5UH+JBvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wv5uCeUhN0g1P6fzpS7x34AjISmxweeHgH4NAu7kCu/0bQjM0lp1E95vrocPHLAvk
         zaLMF62BEGzW8/iV0N9MGid0FjoFVe5ynygQRTAnqLN6mNVNKHYnmTlijqTpqTok+u
         fYIe0z90u3OWQTrHMr4j/WmwjYKMjLPOs3Hpqvs9cLN4I1VMQTRKqrPqL6OFBhqKSk
         qIRvzmMzzVTrglbUz4j2kc4pzV4sVu5MU6A04WXvj8t+BUhFkUE9Y0eviTZdHhJ9ud
         nN5zHZBl1kLa2iwh6l+CKlVVALgSnASE3oh2cBHkufEb+grFDs9xXAbRk6BxbzKx5m
         /cvN/OzVrNYzQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/9] iio: core: move @scan_index_timestamp to struct iio_dev_opaque
Date:   Mon, 26 Apr 2021 18:49:07 +0100
Message-Id: <20210426174911.397061-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174911.397061-1-jic23@kernel.org>
References: <20210426174911.397061-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No reason for this cached value to be exposed to drivers so move it
to the opaque structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 7 +++++--
 include/linux/iio/iio-opaque.h    | 4 ++++
 include/linux/iio/iio.h           | 2 --
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 9a8e16c7e9af..9ecb3c58d94c 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -601,8 +601,10 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 
 static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
 	return iio_storage_bytes_for_si(indio_dev,
-					indio_dev->scan_index_timestamp);
+					iio_dev_opaque->scan_index_timestamp);
 }
 
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
@@ -1469,6 +1471,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 					     struct iio_dev *indio_dev,
 					     int index)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_dev_attr *p;
 	struct attribute **attr;
 	int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
@@ -1495,7 +1498,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 				goto error_cleanup_dynamic;
 			scan_el_attrcount += ret;
 			if (channels[i].type == IIO_TIMESTAMP)
-				indio_dev->scan_index_timestamp =
+				iio_dev_opaque->scan_index_timestamp =
 					channels[i].scan_index;
 		}
 		if (indio_dev->masklength && buffer->scan_mask == NULL) {
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 10aa97239117..02038fb2d291 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -22,6 +22,7 @@
  * @groupcounter:		index of next attribute group
  * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
  * @legacy_buffer_group:	attribute group for legacy buffer attributes group
+ * @scan_index_timestamp:	cache of the index to the timestamp
  * @debugfs_dentry:		device specific debugfs dentry
  * @cached_reg_addr:		cached register address for debugfs reads
  * @read_buf:			read buffer to be used for the initial reg read
@@ -44,6 +45,9 @@ struct iio_dev_opaque {
 	int				groupcounter;
 	struct attribute_group		legacy_scan_el_group;
 	struct attribute_group		legacy_buffer_group;
+
+	unsigned int			scan_index_timestamp;
+
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 672f141f74c5..cbc9e9ece0a6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -501,7 +501,6 @@ struct iio_buffer_setup_ops {
  *			channels
  * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers
  * @scan_timestamp:	[INTERN] set if any buffers have requested timestamp
- * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
  * @trig:		[INTERN] current device trigger (buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @pollfunc_event:	[DRIVER] function run on events trigger being received
@@ -532,7 +531,6 @@ struct iio_dev {
 	unsigned			masklength;
 	const unsigned long		*active_scan_mask;
 	bool				scan_timestamp;
-	unsigned			scan_index_timestamp;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 	struct iio_poll_func		*pollfunc_event;
-- 
2.31.1

