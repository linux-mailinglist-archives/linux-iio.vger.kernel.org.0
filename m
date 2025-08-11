Return-Path: <linux-iio+bounces-22585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C13CB21115
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421EC188B0AB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17144296BA3;
	Mon, 11 Aug 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddmkc5TM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA094296BA4
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927708; cv=none; b=N8gagvMXUB9figrI3ZMmPy6hhevJ+E3KrHcgJEQ7Etdf6oxSMfO6if4bAu2YoukalI6y1i374NuQvpKk9NAkmshyUUet3cEJ4ZMEV6eKDgAGCIUrFOV5T2BOXFSWuofKxeuN/+/+YWd8OW1ncnCxFTccE0ykgoIAsHgGDrNT4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927708; c=relaxed/simple;
	bh=KX5+7E60tBR+xNrgxvpKh2LIex5Xj1Xp2vGSvUXSyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4nZJFcveomr7Yz8ZSYPmLlhgnxqlj7brrUhslCR97g6aWyRbbOe53Sq3iJR9gFu5BqpZtrSABBvhsbz4I/bqDuvHPGnfssaYlnAYO9VG3IQ0LWbfurap2wGxsMcBH0nuL4X/QolMN/LGsfSCbXPW5EcTzgIWgnTYXprTpxoR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddmkc5TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7BBC4CEED;
	Mon, 11 Aug 2025 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927708;
	bh=KX5+7E60tBR+xNrgxvpKh2LIex5Xj1Xp2vGSvUXSyh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ddmkc5TM0kQAtaDAT55g8179xrSIz1k/D7W6YTXwDdj7WqA9D0zjDG2HB7nT5MUQ8
	 4v0gh8KbCYJWv5rjyq9x3MTFfxt87ZUBxso0acLtsG3K+Enjn5P6mwPkzNz8UAqXbI
	 P6lpf8mku6/C2geVUdIeEdY+XRX428Q8znf4ygV0JheLo7lntFaEnme5vy48xa6WCg
	 keD7keceZD4MzITGgM4+n87Uc5eN6cgkkqgSikQDWEwRhSRwa90m/zEjoNKT+xyf6D
	 bFTbghqPiRmXIg4wlrXSIzbtL5CZdSuXAU9HeQZchbZjkOVkkh4MzocAh+u65tDiGi
	 0b+dgpVkFiuiQ==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 3/6] iio: consumers: Add an iio_multiply_value() helper function
Date: Mon, 11 Aug 2025 17:54:50 +0200
Message-ID: <20250811155453.31525-4-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811155453.31525-1-hansg@kernel.org>
References: <20250811155453.31525-1-hansg@kernel.org>
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
iio-val    = channel-scale
processed  = multiplier * iio-val

Where iioval is a set of IIO_VAL_* type + val + val2 integers, being
able to handle multiplication of iio-values like this is something
which is useful to have in general and as previous bugfixes to
iio_convert_raw_to_processed() have shown also tricky to implement.

Split the iio-value multiplication code from iio_convert_raw_to_processed()
out into a new iio_multiply_value() helper. This serves multiple purposes:

1. Having this split out allows writing a kunit test for this.
2. Having this split out allows re-use to get better precision
   when scaling values in iio_read_channel_processed_scale().

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v4:
- New patch in v4 of this patch-set
---
 drivers/iio/inkern.c         | 64 +++++++++++++++++++++---------------
 include/linux/iio/consumer.h | 18 ++++++++++
 2 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index a75f53d11937..af1da729d18e 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -599,13 +599,46 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
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
+		case IIO_VAL_INT_PLUS_MICRO: denominator = MICRO; break;
+		case IIO_VAL_INT_PLUS_NANO: denominator = NANO; break;
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
+EXPORT_SYMBOL_GPL(iio_multiply_value);
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
@@ -644,31 +677,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		return 0;
 	}
 
-	switch (scale_type) {
-	case IIO_VAL_INT:
-		*processed = raw64 * scale_val * scale;
-		break;
-	case IIO_VAL_INT_PLUS_MICRO:
-	case IIO_VAL_INT_PLUS_NANO:
-		switch (scale_type) {
-		case IIO_VAL_INT_PLUS_MICRO: denominator = MICRO; break;
-		case IIO_VAL_INT_PLUS_NANO: denominator = NANO; break;
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
index 6a4479616479..c8c6261c81f9 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -381,6 +381,24 @@ int iio_read_channel_offset(struct iio_channel *chan, int *val,
 int iio_read_channel_scale(struct iio_channel *chan, int *val,
 			   int *val2);
 
+/**
+ * iio_multiply_value() - Multiply an iio value
+ * @result:	Destination pointer for the multiplication result
+ * @multiplier:	Multiplier.
+ * @type:	One of the IIO_VAL_* constants. This decides how the val
+ *		and val2 parameters are interpreted.
+ * @val:	Value being multiplied.
+ * @val2:	Value being multiplied. val2 use depends on type.
+ *
+ * Multiply an iio value with a s64 multiplier storing the result as
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
2.49.0


