Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2D9342C14
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCTLYq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCTLYc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:24:32 -0400
Received: from www381.your-server.de (www381.your-server.de [IPv6:2a01:4f8:d0a:52ac::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D8FC0613AB
        for <linux-iio@vger.kernel.org>; Sat, 20 Mar 2021 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=1VrxMafwnGhSkCKJIjhWihd6ydGQeNI9teEVKqZOQ3w=; b=M3g85cCOABLG04O3IInDO6CruU
        tGg/0qEGhDcxP0GsDXxAVwNqkch3FMBC/lQmuyjsx2YQyEbApiLJLnrTtkFWUqvxvg7nS+ZoChVws
        Pk+qQN8JeXJSQBedIXkScxKiHPvrKDZU2bkODtP4d3Oyz7LNDKqQYLwHW44MHR6ftM2l4ujItU1qy
        h/H853emSmG3X7x49Rs18Tu3WR+owONcALzpi3XGrKRZFO3m2aTgiSjsO4kB/FXOsrkPaFtLZMl0C
        uq5WcZigXVVAcxyMeLgEb+iiA4SMxthKs34cO/3PAXJnzjvXvEdaA2o3cvurU2l0KFPnZ49TplXxQ
        OW1E5xpA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNVoj-000AyI-Vn; Sat, 20 Mar 2021 08:14:38 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNVoj-000Vc8-RD; Sat, 20 Mar 2021 08:14:37 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] iio: core: Use sysfs_emit() (trivial bits)
Date:   Sat, 20 Mar 2021 08:14:02 +0100
Message-Id: <20210320071405.9347-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210320071405.9347-1-lars@metafoo.de>
References: <20210320071405.9347-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26114/Sat Mar 20 04:43:32 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
knows about the sysfs buffer specifics and has some built-in sanity checks.

This patch converts the places in the iio core that follow the pattern of

   return s*printf(...)

to

   return sysfs_emit(...)

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c  | 20 ++++++++++----------
 drivers/iio/industrialio-core.c    | 16 ++++++++--------
 drivers/iio/industrialio-event.c   |  2 +-
 drivers/iio/industrialio-trigger.c |  4 ++--
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ee5aab9d4a23..ccc8a8cae604 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -260,7 +260,7 @@ static ssize_t iio_show_scan_index(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	return sprintf(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
+	return sysfs_emit(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
 }
 
 static ssize_t iio_show_fixed_type(struct device *dev,
@@ -278,15 +278,15 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 #endif
 	}
 	if (this_attr->c->scan_type.repeat > 1)
-		return sprintf(buf, "%s:%c%d/%dX%d>>%u\n",
+		return sysfs_emit(buf, "%s:%c%d/%dX%d>>%u\n",
 		       iio_endian_prefix[type],
 		       this_attr->c->scan_type.sign,
 		       this_attr->c->scan_type.realbits,
 		       this_attr->c->scan_type.storagebits,
 		       this_attr->c->scan_type.repeat,
 		       this_attr->c->scan_type.shift);
-		else
-			return sprintf(buf, "%s:%c%d/%d>>%u\n",
+	else
+		return sysfs_emit(buf, "%s:%c%d/%d>>%u\n",
 		       iio_endian_prefix[type],
 		       this_attr->c->scan_type.sign,
 		       this_attr->c->scan_type.realbits,
@@ -305,7 +305,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
 		       buffer->scan_mask);
 
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 /* Note NULL used as error indicator as it doesn't make sense. */
@@ -449,7 +449,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
-	return sprintf(buf, "%d\n", buffer->scan_timestamp);
+	return sysfs_emit(buf, "%d\n", buffer->scan_timestamp);
 }
 
 static ssize_t iio_scan_el_ts_store(struct device *dev,
@@ -541,7 +541,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
-	return sprintf(buf, "%d\n", buffer->length);
+	return sysfs_emit(buf, "%d\n", buffer->length);
 }
 
 static ssize_t iio_buffer_write_length(struct device *dev,
@@ -583,7 +583,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
-	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
+	return sysfs_emit(buf, "%d\n", iio_buffer_is_active(buffer));
 }
 
 static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
@@ -1227,7 +1227,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
-	return sprintf(buf, "%u\n", buffer->watermark);
+	return sysfs_emit(buf, "%u\n", buffer->watermark);
 }
 
 static ssize_t iio_buffer_store_watermark(struct device *dev,
@@ -1271,7 +1271,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
-	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
+	return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
 
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b5750edf935c..058874af1242 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -234,7 +234,7 @@ ssize_t iio_read_const_attr(struct device *dev,
 			    struct device_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%s\n", to_iio_const_attr(attr)->string);
+	return sysfs_emit(buf, "%s\n", to_iio_const_attr(attr)->string);
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
@@ -529,7 +529,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
 	else if (i >= e->num_items || !e->items[i])
 		return -EINVAL;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
+	return sysfs_emit(buf, "%s\n", e->items[i]);
 }
 EXPORT_SYMBOL_GPL(iio_enum_read);
 
@@ -580,10 +580,10 @@ ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
 	if (!mtx)
 		mtx = &iio_mount_idmatrix;
 
-	return snprintf(buf, PAGE_SIZE, "%s, %s, %s; %s, %s, %s; %s, %s, %s\n",
-			mtx->rotation[0], mtx->rotation[1], mtx->rotation[2],
-			mtx->rotation[3], mtx->rotation[4], mtx->rotation[5],
-			mtx->rotation[6], mtx->rotation[7], mtx->rotation[8]);
+	return sysfs_emit(buf, "%s, %s, %s; %s, %s, %s; %s, %s, %s\n",
+			  mtx->rotation[0], mtx->rotation[1], mtx->rotation[2],
+			  mtx->rotation[3], mtx->rotation[4], mtx->rotation[5],
+			  mtx->rotation[6], mtx->rotation[7], mtx->rotation[8]);
 }
 EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
 
@@ -1369,7 +1369,7 @@ static ssize_t iio_show_dev_name(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n", indio_dev->name);
+	return sysfs_emit(buf, "%s\n", indio_dev->name);
 }
 
 static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
@@ -1379,7 +1379,7 @@ static ssize_t iio_show_dev_label(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n", indio_dev->label);
+	return sysfs_emit(buf, "%s\n", indio_dev->label);
 }
 
 static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index a30e289fc362..1b3a15bc75fe 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -297,7 +297,7 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	if (val < 0)
 		return val;
 	else
-		return sprintf(buf, "%d\n", val);
+		return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t iio_ev_value_show(struct device *dev,
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 32ac1bec25e3..efeb5e2eca8a 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -50,7 +50,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
 				     char *buf)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
-	return sprintf(buf, "%s\n", trig->name);
+	return sysfs_emit(buf, "%s\n", trig->name);
 }
 
 static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
@@ -375,7 +375,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 
 	if (indio_dev->trig)
-		return sprintf(buf, "%s\n", indio_dev->trig->name);
+		return sysfs_emit(buf, "%s\n", indio_dev->trig->name);
 	return 0;
 }
 
-- 
2.20.1

