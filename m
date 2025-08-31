Return-Path: <linux-iio+bounces-23521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD63B3D239
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E75D7A13E1
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC31253356;
	Sun, 31 Aug 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGSbyXFk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0B1E502
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637315; cv=none; b=lj2tXjQ60SBgUYu8XYW/Ocj2DU/tn5I5eLv9ClxdW2CzoY0KH9b2rHlUnurOG+stXRINjv02iNPsfFuegJ0AREWzgHLjd9Oh+MlxpES8aC3imXeuR9vZ+9bcMMAyMrmaUk7ruqWRcW1PiBI7P8Xr0p8jRJacAcAxBs8yLxBpofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637315; c=relaxed/simple;
	bh=lmvcoR9jZZj/HJwz98uEYohs74IszFM+mHy0jeYOrBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R23JMhsG2P63JVl8Dj8mW/VlzujuVYIwfITT0eCZgVG6flvO0HMXwDMoTEwt+yRSbWZwyJ6EVocx6zE7p8iOxvMc9dS7Os1UeyL+Db0GOXgzRvRIbapvf6XyBeGwDWngncB/5zLX70nhwJLJII0hJk+eDLQHN4Ng3G8Xl5GsA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGSbyXFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6235AC4CEED;
	Sun, 31 Aug 2025 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637314;
	bh=lmvcoR9jZZj/HJwz98uEYohs74IszFM+mHy0jeYOrBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGSbyXFknXkdYYyxqD9tnHb66hxwGlhcwxhKArzFhhnxLJs8w+Z42kUZyV09JtmSZ
	 1jptAx3rytlGYddhs2p4ylffb9xmbkjMcTGBWYH9FQrKiWA9Kd5siHMnduyKw2poxu
	 6aUJGhLYGai6yoxhlu/qLj1nNdJLCRCQhqDc6z0+BlGwrpg84jkaih8az276rxFaLJ
	 M5zauGKiccXuHbLWwt0CGyVXO1Y2PS14grQonvdrzLcS+ggLofhj6Mww0vdlxUEXIV
	 ajNoU/8St/ChBAFrS4S/ZVfxpVZSw0b5pKvzKn4OEBEa/zwKGRSlVKb2tJoiVqhl50
	 YqfKLFGl8IVKw==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 3/6] iio: consumers: Add an iio_multiply_value() helper function
Date: Sun, 31 Aug 2025 12:48:22 +0200
Message-ID: <20250831104825.15097-4-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831104825.15097-1-hansg@kernel.org>
References: <20250831104825.15097-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The channel-scale handling in iio_convert_raw_to_processed() in essence
does the following:

processed  = raw * caller-provided-scale * channel-scale

Which can also be written as:

multiplier = raw * caller-provided-scale
iio-value  = channel-scale
processed  = multiplier * iio-value

Where iio-value is a set of IIO_VAL_* type + val + val2 integers, being
able to handle multiplication of iio-values like this is something
which is useful to have in general and, as previous bugfixes to
iio_convert_raw_to_processed() have shown, also tricky to implement.

Split the iio-value multiplication code from iio_convert_raw_to_processed()
out into a new iio_multiply_value() helper. This serves multiple purposes:

1. Having this split out allows writing a KUnit test for this.
2. Having this split out allows re-use to get better precision
   when scaling values in iio_read_channel_processed_scale().

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v5:
- Use IIO_UNIT_TEST module-namespace for iio_multiply_value()

Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/inkern.c         | 72 +++++++++++++++++++++---------------
 include/linux/iio/consumer.h | 18 +++++++++
 2 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 642beb4b3360..158d54de14a7 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -599,13 +599,50 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 
+int iio_multiply_value(int *result, s64 multiplier,
+		       unsigned int type, int val, int val2)
+{
+	s64 denominator;
+
+	switch (type) {
+	case IIO_VAL_INT:
+		*result = multiplier * val;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_MICRO:
+	case IIO_VAL_INT_PLUS_NANO:
+		switch (type) {
+		case IIO_VAL_INT_PLUS_MICRO:
+			denominator = MICRO;
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			denominator = NANO;
+			break;
+		}
+		*result = multiplier * abs(val);
+		*result += div_s64(multiplier * abs(val2), denominator);
+		if (val < 0 || val2 < 0)
+			*result *= -1;
+		return IIO_VAL_INT;
+	case IIO_VAL_FRACTIONAL:
+		*result = div_s64(multiplier * val, val2);
+		return IIO_VAL_INT;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		*result = (multiplier * val) >> val2;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(iio_multiply_value, "IIO_UNIT_TEST");
+
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 						 int raw, int *processed,
 						 unsigned int scale)
 {
 	int scale_type, scale_val, scale_val2;
 	int offset_type, offset_val, offset_val2;
-	s64 denominator, raw64 = raw;
+	s64 raw64 = raw;
+	int ret;
 
 	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
 				       IIO_CHAN_INFO_OFFSET);
@@ -644,35 +681,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		return 0;
 	}
 
-	switch (scale_type) {
-	case IIO_VAL_INT:
-		*processed = raw64 * scale_val * scale;
-		break;
-	case IIO_VAL_INT_PLUS_MICRO:
-	case IIO_VAL_INT_PLUS_NANO:
-		switch (scale_type) {
-		case IIO_VAL_INT_PLUS_MICRO:
-			denominator = MICRO;
-			break;
-		case IIO_VAL_INT_PLUS_NANO:
-			denominator = NANO;
-			break;
-		}
-		*processed = raw64 * scale * abs(scale_val);
-		*processed += div_s64(raw64 * scale * abs(scale_val2), denominator);
-		if (scale_val < 0 || scale_val2 < 0)
-			*processed *= -1;
-		break;
-	case IIO_VAL_FRACTIONAL:
-		*processed = div_s64(raw64 * (s64)scale_val * scale,
-				     scale_val2);
-		break;
-	case IIO_VAL_FRACTIONAL_LOG2:
-		*processed = (raw64 * (s64)scale_val * scale) >> scale_val2;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = iio_multiply_value(processed, raw64 * scale,
+				 scale_type, scale_val, scale_val2);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6a4479616479..a38b277c2c02 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -381,6 +381,24 @@ int iio_read_channel_offset(struct iio_channel *chan, int *val,
 int iio_read_channel_scale(struct iio_channel *chan, int *val,
 			   int *val2);
 
+/**
+ * iio_multiply_value() - Multiply an IIO value
+ * @result:	Destination pointer for the multiplication result
+ * @multiplier:	Multiplier.
+ * @type:	One of the IIO_VAL_* constants. This decides how the @val and
+ *		@val2 parameters are interpreted.
+ * @val:	Value being multiplied.
+ * @val2:	Value being multiplied. @val2 use depends on type.
+ *
+ * Multiply an IIO value with a s64 multiplier storing the result as
+ * IIO_VAL_INT. This is typically used for scaling.
+ *
+ * Returns:
+ * IIO_VAL_INT on success or a negative error-number on failure.
+ */
+int iio_multiply_value(int *result, s64 multiplier,
+		       unsigned int type, int val, int val2);
+
 /**
  * iio_convert_raw_to_processed() - Converts a raw value to a processed value
  * @chan:		The channel being queried
-- 
2.51.0


