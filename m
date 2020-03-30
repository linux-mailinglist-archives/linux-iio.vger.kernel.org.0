Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852B1197F25
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgC3O5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:57:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36005 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgC3O5N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:57:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so22333065wme.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2020 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THBgijMeTsQhmRlHJJQGOZTi5oSExeeftI6N99Yve68=;
        b=SQF1pcV5sgJXGt0RHnqI6LUtpnAUc0EOjeie0sNmVfETwsOBxqzFWpONKddX8nnOrK
         BLYzG8zI54/d+ghA6/pJ2EA8m+OoftPKs10ptlkUjyWqWmTQdrBW3TtHG4jf/xUotHoj
         4wI6ZGT+B0Jh7E3nThvFd5Ditixx6X9GBkBUhlKvr16Use3AQtpu2VPsFSWkMETiihvW
         jisAUCpQqeKKFSB0wQMhUDJGZH8QmRPnRit+fSS97WvsCtmUe6mNZCmHbw/iNrH7nmcq
         +/cZpt34y5oh1RoMoKOJvmq/KCBVU73g2LOfNbytJ64LJGlqizipt4+hEfUgztTnt2Wn
         EdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THBgijMeTsQhmRlHJJQGOZTi5oSExeeftI6N99Yve68=;
        b=UY/Jnc5VJAgy+TlhF1/VVKFnTbyKMa4gNEAR5aElGjj2vb0uczBovflYH+8u65dOZV
         x5WCxaJUuCmIguZWXmt3hyxnq4PoiSPML4gcwCYMzz+k5vee7M+6scZQq2B9nMmN58xp
         zDtK+vzmJ/zHeDdyaMvVx3vc/gP6c/vly28YLnr0ONo0W/xlgmfvnH4Pm48GmaW6C7NC
         HJzTHD61ePtos9ZuJSB6ZkFKv3RbVRlFDUb11u1dxD7AYrE07OWkotFFSiYNgknqQVaa
         rXTE6qyP5ee2Vv8mwiNdDLIZ3yHNvAXukLYgzlXav03kCyllmJh5hcV/638gGiE971P9
         6q4g==
X-Gm-Message-State: ANhLgQ3HIZ15F4XzCMD9TwBoKXyMWExBb87gtnlGyBdBT2WTHl8+uugc
        Ht14GSJu3ly5a9BIkUZpbpWviJgH
X-Google-Smtp-Source: ADFU+vuQ04QHS/revrEtQc0QMzYpUr8XosB4xp2GvZRo2wRd/nyt6gmK8aOqkfECfygsunm/HYWMHA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr12979502wmk.125.1585580230468;
        Mon, 30 Mar 2020 07:57:10 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id y200sm21584944wmc.20.2020.03.30.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:57:10 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
        lars@metafoo.de, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 2/3] iio: buffer: extend short-hand use for 'indio_dev->buffer'
Date:   Mon, 30 Mar 2020 17:57:04 +0300
Message-Id: <20200330145705.29447-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330145705.29447-1-alexandru.ardelean@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change is both cosmetic and a prequel to adding support for attaching
multiple buffers per IIO device.

The IIO buffer sysfs attrs are mostly designed to support only one attached
buffer, and in order to support more, we need to centralize [in each attr
function] the buffer which is being accessed.

This also makes it a bit more uniform, as in some functions there is a
short-hand 'buffer' variable and at the same time the 'indio_dev->buffer'
is still access directly.

In the 'iio_buffer_add_channel_sysfs()' the 'buffer' is passed as a
parameter. This gives control to 'iio_buffer_alloc_sysfs_and_mask()' over
which buffer gets accessed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 55 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a585c304cad4..c6af18448dd5 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -262,10 +262,11 @@ static ssize_t iio_scan_el_show(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
 
 	/* Ensure ret is 0 or 1. */
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
-		       indio_dev->buffer->scan_mask);
+		       buffer->scan_mask);
 
 	return sprintf(buf, "%d\n", ret);
 }
@@ -381,7 +382,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -410,7 +411,9 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	return sprintf(buf, "%d\n", indio_dev->buffer->scan_timestamp);
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	return sprintf(buf, "%d\n", buffer->scan_timestamp);
 }
 
 static ssize_t iio_scan_el_ts_store(struct device *dev,
@@ -420,6 +423,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
 	bool state;
 
 	ret = strtobool(buf, &state);
@@ -427,11 +431,11 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	indio_dev->buffer->scan_timestamp = state;
+	buffer->scan_timestamp = state;
 error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
@@ -439,10 +443,10 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 }
 
 static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
+					struct iio_buffer *buffer,
 					const struct iio_chan_spec *chan)
 {
 	int ret, attrcount = 0;
-	struct iio_buffer *buffer = indio_dev->buffer;
 
 	ret = __iio_add_chan_devattr("index",
 				     chan,
@@ -518,7 +522,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 		return len;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 	} else {
 		buffer->access->set_length(buffer, val);
@@ -539,7 +543,9 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 				      char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
 }
 
 static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
@@ -1129,6 +1135,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	int ret;
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -1138,17 +1145,15 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 
 	/* Find out if it is in the list */
-	inlist = iio_buffer_is_active(indio_dev->buffer);
+	inlist = iio_buffer_is_active(buffer);
 	/* Already in desired state */
 	if (inlist == requested_state)
 		goto done;
 
 	if (requested_state)
-		ret = __iio_update_buffers(indio_dev,
-					 indio_dev->buffer, NULL);
+		ret = __iio_update_buffers(indio_dev, buffer, NULL);
 	else
-		ret = __iio_update_buffers(indio_dev,
-					 NULL, indio_dev->buffer);
+		ret = __iio_update_buffers(indio_dev, NULL, buffer);
 
 done:
 	mutex_unlock(&indio_dev->mlock);
@@ -1190,7 +1195,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 		goto out;
 	}
 
-	if (iio_buffer_is_active(indio_dev->buffer)) {
+	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1207,11 +1212,9 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 						char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	size_t bytes;
-
-	bytes = iio_buffer_data_available(indio_dev->buffer);
+	struct iio_buffer *buffer = indio_dev->buffer;
 
-	return sprintf(buf, "%zu\n", bytes);
+	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
 
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
@@ -1297,7 +1300,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 			if (channels[i].scan_index < 0)
 				continue;
 
-			ret = iio_buffer_add_channel_sysfs(indio_dev,
+			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
 							 &channels[i]);
 			if (ret < 0)
 				goto error_cleanup_dynamic;
@@ -1340,20 +1343,22 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	bitmap_free(buffer->scan_mask);
 error_cleanup_dynamic:
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
-	kfree(indio_dev->buffer->buffer_group.attrs);
+	kfree(buffer->buffer_group.attrs);
 
 	return ret;
 }
 
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
-	if (!indio_dev->buffer)
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (!buffer)
 		return;
 
-	bitmap_free(indio_dev->buffer->scan_mask);
-	kfree(indio_dev->buffer->buffer_group.attrs);
-	kfree(indio_dev->buffer->scan_el_group.attrs);
-	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
+	bitmap_free(buffer->scan_mask);
+	kfree(buffer->buffer_group.attrs);
+	kfree(buffer->scan_el_group.attrs);
+	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
 /**
-- 
2.20.1

