Return-Path: <linux-iio+bounces-6831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515919155AE
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7434B1C22CDC
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161CF19FA68;
	Mon, 24 Jun 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u7C0L2Ol"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661619F476
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251190; cv=none; b=uKhhZyRTaYoQqaS0dp8Jc+Wi99wskzoZhQmy2/LQ3cm7cInrgjlCblr6jWgXscb29hS3Q5EgGO2uc/RoTD8BxFZCUOuWyvvx3J28UOT3xcsBNhjtWSBgoYGUQn2QzlIKCWr6izcFb0gbeUkPDf9WESp+cvrxTGE+i9046xwZu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251190; c=relaxed/simple;
	bh=wejDnFkIHlBIhIot9CtzBrJmkO8rWvq2lRq5kHDRBSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjvmxHlfkritnbKD6gAkz3+d62vtqdpJvalmii98w6RbKY0vSRKy2IcKLS/2A1Yz2U6OEPYXd+QB2W6kjX1KS//OVPUcKEmKHH28kUJIWm63dv3jvhBMVsmRbnEr7I1Pwum0yYDMItNc9nR8PVkxnBNnu6bprr8iZ9PAv2LZEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u7C0L2Ol; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jic23@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719251185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdQIawjGALB68yh7k2xfDgOAVt1XzSJ4v8yH3dVsoZc=;
	b=u7C0L2OlX8TsMGuCt/RuP3dYqRT2sMnrUFkrVXbes03Lr5OBnPi+IscUYm1f1RhzBFoGSs
	ti3qAIpBiLO8FAxXUvv6Uk/iNHa+V0/IlOb2YT4jHj5jZvDkc8GM0xy26J203uPm+gF0n5
	5VaJVF+RQrDq1e+87OFHaWlsroQEmNw=
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux@roeck-us.net
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: sean.anderson@linux.dev
X-Envelope-To: jonathan.cameron@huawei.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Anderson <sean.anderson@linux.dev>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/2] iio: Add iio_read_channel_label to inkern API
Date: Mon, 24 Jun 2024 13:46:00 -0400
Message-Id: <20240624174601.1527244-2-sean.anderson@linux.dev>
In-Reply-To: <20240624174601.1527244-1-sean.anderson@linux.dev>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

(no changes since v1)

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


