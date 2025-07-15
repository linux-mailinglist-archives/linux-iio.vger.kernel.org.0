Return-Path: <linux-iio+bounces-21653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91461B04D58
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 03:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84331A672E5
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51DB126BFF;
	Tue, 15 Jul 2025 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U0VyMGcc"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F741EA7D2
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542445; cv=none; b=I8sJz/rEDD3Qr6LCTAjSO0oeJvlIwRayxoCAO+XLjypuzndvDj4cXkQqG2emOY9NYmWUrMVf3y58seWahbjruvga9JMx8M4xYf4y+yraFEO0KEyOMhlndh4CACkuwG10IVB3a9GDPbk5lfc989EUnD4Nz74YtTqsU9VORxt18CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542445; c=relaxed/simple;
	bh=2QaFyI8ILVBS5g97+jOxADYG68AZSIqZdeO851iUE2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXTP9LRBMpZ4vg0wVMHOvAvmoT00eZleNFzmfNA68w60AaMS2NXoxqJhol5nzInNjIqq8WTpK77z62QfHIrLITvZIayhYt2+muwg887/aPlmKObmOh66UhDjrZdPLChJ6n4lsObuQDuHm1wRhLgoQZM1O0vwFFfk81ML/prnGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U0VyMGcc; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752542441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWv0qdWMnYbMo4uu7JsXsvkSPvGdLSsaNbuCjmIdofU=;
	b=U0VyMGccatnYZXKK7QZOeV5HqGQ9aJrnHMNtd453oWH8QDgTh6Sh4aWaun1iDw7MGghQNh
	Ht2V7nlVpnX2P5cId5YP+unEO3Qiz+Q3FfcKefkTJmLqr9F9uzhY85B0zzaOklbaxDarXP
	ZAVzwCL+p9GGHb/l7CXjNGD+sIWPqAc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 5/7] hwmon: iio: Add helper function for creating attributes
Date: Mon, 14 Jul 2025 21:20:21 -0400
Message-Id: <20250715012023.2050178-6-sean.anderson@linux.dev>
In-Reply-To: <20250715012023.2050178-1-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a helper function to create attributes and initialize their fields.
This reduces repetition when creating several attributes per channel.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/hwmon/iio_hwmon.c | 78 +++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index bba8919377eb..7dc156d2aea4 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -24,13 +24,15 @@
  * @attr_group:		the group of attributes
  * @groups:		null terminated array of attribute groups
  * @attrs:		null terminated array of attribute pointers.
+ * @num_attrs:          length of @attrs
  */
 struct iio_hwmon_state {
 	struct iio_channel *channels;
-	int num_channels;
 	struct attribute_group attr_group;
 	const struct attribute_group *groups[2];
 	struct attribute **attrs;
+	size_t num_attrs;
+	int num_channels;
 };
 
 static ssize_t iio_hwmon_read_label(struct device *dev,
@@ -93,12 +95,39 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
 	return sprintf(buf, "%d\n", result);
 }
 
+static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
+			   ssize_t (*show)(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf),
+			   int i, const char *fmt, ...)
+{
+	struct sensor_device_attribute *a;
+	va_list ap;
+
+	a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	sysfs_attr_init(&a->dev_attr.attr);
+	va_start(ap, fmt);
+	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
+	va_end(ap);
+	if (!a->dev_attr.attr.name)
+		return -ENOMEM;
+
+	a->dev_attr.show = show;
+	a->dev_attr.attr.mode = 0444;
+	a->index = i;
+
+	st->attrs[st->num_attrs++] = &a->dev_attr.attr;
+	return 0;
+}
+
 static int iio_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iio_hwmon_state *st;
-	struct sensor_device_attribute *a;
-	int ret, i, attr = 0;
+	int ret, i;
 	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
 	enum iio_chan_type type;
 	struct iio_channel *channels;
@@ -136,11 +165,6 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		const char *prefix;
 		int n;
 
-		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
-		if (a == NULL)
-			return -ENOMEM;
-
-		sysfs_attr_init(&a->dev_attr.attr);
 		ret = iio_get_channel_type(&st->channels[i], &type);
 		if (ret < 0)
 			return ret;
@@ -170,36 +194,18 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-						       "%s%d_input",
-						       prefix, n);
-		if (a->dev_attr.attr.name == NULL)
-			return -ENOMEM;
-
-		a->dev_attr.show = iio_hwmon_read_val;
-		a->dev_attr.attr.mode = 0444;
-		a->index = i;
-		st->attrs[attr++] = &a->dev_attr.attr;
+		ret = add_device_attr(dev, st, iio_hwmon_read_val, i,
+				      "%s%d_input", prefix, n);
+		if (ret)
+			return ret;
 
 		/* Let's see if we have a label... */
-		if (iio_read_channel_label(&st->channels[i], buf) < 0)
-			continue;
-
-		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
-		if (a == NULL)
-			return -ENOMEM;
-
-		sysfs_attr_init(&a->dev_attr.attr);
-		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-						       "%s%d_label",
-						       prefix, n);
-		if (!a->dev_attr.attr.name)
-			return -ENOMEM;
-
-		a->dev_attr.show = iio_hwmon_read_label;
-		a->dev_attr.attr.mode = 0444;
-		a->index = i;
-		st->attrs[attr++] = &a->dev_attr.attr;
+		if (iio_read_channel_label(&st->channels[i], buf) >= 0) {
+			ret = add_device_attr(dev, st, iio_hwmon_read_label,
+					      i, "%s%d_label", prefix, n);
+			if (ret)
+				return ret;
+		}
 	}
 
 	devm_free_pages(dev, (unsigned long)buf);
-- 
2.35.1.1320.gc452695387.dirty


