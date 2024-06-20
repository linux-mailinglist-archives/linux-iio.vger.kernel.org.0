Return-Path: <linux-iio+bounces-6649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F5911424
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 23:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C51F22F74
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C180055;
	Thu, 20 Jun 2024 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EwH9ZkNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9427D08D;
	Thu, 20 Jun 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918002; cv=none; b=Zid7EDJPo0lcHX+2KNdF96063oq02aKeaQXOM3kpQRC4ENA5Et4dAXjKpIkQPluC8OrlGG7Vy/vYfJgjKlgOvxg1EhsnAfBoQFyV2JsVJRAF/RF8cF6YkYbmaNuUU8bexUEm3xsOeFQojEtnzTUOREf/sdvpyXa4G3cOirpd2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918002; c=relaxed/simple;
	bh=5U0JMS1qKtEI0jgQfGnO0+3LZoZwFo98W1uh4S/PyXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJd5zQURLT3DskQ5orgA6P4h3rZevAma8mPfrtZEl23kvlEBzhZlJ7dnA9TYfLTuYLsDd7AkZLRrDkmLXdjq3/wJZkzwUscdkqxNrbmn4uF3FwrrjNV6US5vzrY6SxSe4jvoyewMeEow4o/OGaXmGkZUQKNEvn9OvDEJy0uO/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EwH9ZkNq; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jic23@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718917998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diqZ1ViR0KFVR0ivUHMVSAgU7kmt1CdyucMuc2uIrwE=;
	b=EwH9ZkNqLCtHYtsL0MzHzaqu9otKIR/2y9zx6DlXeruZZ/ZkZMDfeoQmX0GvD3dsbTEmEa
	2hqvcLFqHNTElhoNx94U5JBD1x3q9BAPablY1rPKPvPQtN7K5YKsbNYnBuM8NxbmdybTvE
	GaFsoMmegoFN4qCc7Kck0U/RKnM9v5U=
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux@roeck-us.net
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/2] iio: Add iio_read_channel_label to inkern API
Date: Thu, 20 Jun 2024 17:13:08 -0400
Message-Id: <20240620211310.820579-2-sean.anderson@linux.dev>
In-Reply-To: <20240620211310.820579-1-sean.anderson@linux.dev>
References: <20240620211310.820579-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It can be convenient for other in-kernel drivers to reuse IIO channel
labels. Export the iio_read_channel_label function to allow this. The
signature is different depending on where we are calling it from, so
the meat is moved to do_iio_read_channel_label.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/iio/iio_core.h          |  4 ++++
 drivers/iio/industrialio-core.c | 23 ++++++++++++++---------
 drivers/iio/inkern.c            |  6 ++++++
 include/linux/iio/consumer.h    | 10 ++++++++++
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 1a38b1915e7a..b7d5f4f0fada 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -34,6 +34,10 @@ void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
 				       struct iio_ioctl_handler *h);
 void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
 
+ssize_t do_iio_read_channel_label(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *c,
+				  char *buf);
+
 int __iio_add_chan_devattr(const char *postfix,
 			   struct iio_chan_spec const *chan,
 			   ssize_t (*func)(struct device *dev,
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2f185b386949..0f6cda7ffe45 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -727,22 +727,27 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 }
 EXPORT_SYMBOL_GPL(iio_format_value);
 
-static ssize_t iio_read_channel_label(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+ssize_t do_iio_read_channel_label(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *c,
+				  char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
 	if (indio_dev->info->read_label)
-		return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
+		return indio_dev->info->read_label(indio_dev, c, buf);
 
-	if (this_attr->c->extend_name)
-		return sysfs_emit(buf, "%s\n", this_attr->c->extend_name);
+	if (c->extend_name)
+		return sysfs_emit(buf, "%s\n", c->extend_name);
 
 	return -EINVAL;
 }
 
+static ssize_t iio_read_channel_label(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return do_iio_read_channel_label(dev_to_iio_dev(dev),
+					 to_iio_dev_attr(attr)->c, buf);
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 39cf26d69d17..9f484c94bc6e 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -1010,3 +1010,9 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
 			       chan->channel, buf, len);
 }
 EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
+
+ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
+{
+	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_label);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e9910b41d48e..333d1d8ccb37 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -441,4 +441,14 @@ ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
 ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
 				   const char *buf, size_t len);
 
+/**
+ * iio_read_channel_label() - read label for a given channel
+ * @chan:		The channel being queried.
+ * @buf:		Where to store the attribute value. Assumed to hold
+ *			at least PAGE_SIZE bytes.
+ *
+ * Returns the number of bytes written to buf, or an error code.
+ */
+ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
+
 #endif
-- 
2.35.1.1320.gc452695387.dirty


