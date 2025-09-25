Return-Path: <linux-iio+bounces-24431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02447B9F49E
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2AD173683
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35222494F0;
	Thu, 25 Sep 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ki/0x7oT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE218C02E;
	Thu, 25 Sep 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803879; cv=none; b=tF7oMFamjGocNLI4O/JbC2uM8hYG9QYzZa25t5/dy05ty4WsZzDS2iexoxl7UUY5tvoEygqyn819XirukKIQhuWRfhMCv1toZ0vduohu3RVhO74MK6WP9LQtRN3EzHALFTFbjLt1rPRLoeXu9aE8ATuXY4ciaJW3dfhHQvox1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803879; c=relaxed/simple;
	bh=nq8yvrCq4BHSVH81mDwXPtdNyjSh2WWWKD7668zP+PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TC531ifUUE86atME0mKJgY8xAkzwYpuK8iDF5l/sv6xEt5Xu+oMe0qlk30GrDd06KOlRpD00OfGKFAXRoyQXSYSevdJ0AWSF/wVawjEzE9+kQxR9bkkuX92Kzh8j6iQlY8+3QKFn9E3jTG0B0YYDLYDlcHGTXkiLR0j298CizGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ki/0x7oT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3E53EC011E6;
	Thu, 25 Sep 2025 12:37:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 823096062C;
	Thu, 25 Sep 2025 12:37:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97A1C102F1895;
	Thu, 25 Sep 2025 14:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758803874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=30C/Rm/y1QtLYOy3aNA1T8D9WKuvuDfHijiy4zbDhrA=;
	b=ki/0x7oT+OUAv0qV4C8vI3Wa5SToC8StIAusWr/Wsd9DNtJ1yZ1xipi2wMbZFEq01Uus29
	QjVFay6ujMqP8Z4SOoFdIMdixvei+n74bX3/eCU7B4r+j5wCOrZiGSI3oNHyXAu0U1ZE3X
	8G01lP5WbDPZw93RSE3FgTAVUc2uZKXl8Hu+w79/hP5YKfYVpfZ2Cn/BxFIhrIQFisQzEG
	D8DuG/LdQQCPO5dnQZxjEKYEc54KkCz7CsXJHt/z10cAp4St4se88MXS6eKuj5ia+DfrDu
	h6e6YIdEGmnkEPMuq6O+u3YjVg3J+NevWJsIMpFj8kuaFW9SbWOnVj5v+KGxoA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 25 Sep 2025 14:37:34 +0200
Subject: [PATCH v2 2/5] iio: add processed write API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-ltm8054-driver-v2-2-bb61a401a0dc@bootlin.com>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
In-Reply-To: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Add a function to allow IIO consumers to write a processed value to a
channel.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/inkern.c         | 120 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h |  36 +++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 2a1ecef2b82007f5ee8e8d0f8b35846bc4d2f94a..a6ec724b7c1fb197e6261c1162f8315deda20fd7 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -631,6 +631,57 @@ int iio_multiply_value(int *result, s64 multiplier,
 }
 EXPORT_SYMBOL_GPL(iio_multiply_value);
 
+int iio_divide_by_value(int *result, s64 numerator,
+			unsigned int type, int val, int val2)
+{
+	s64 tmp_num, tmp_den;
+
+	switch (type) {
+	case IIO_VAL_INT:
+		tmp_num = numerator;
+		tmp_den = val;
+		break;
+	case IIO_VAL_INT_PLUS_MICRO:
+	case IIO_VAL_INT_PLUS_NANO:
+		switch (type) {
+		case IIO_VAL_INT_PLUS_MICRO:
+			tmp_num = MICRO;
+			tmp_den = MICRO;
+			break;
+
+		case IIO_VAL_INT_PLUS_NANO:
+			tmp_num = NANO;
+			tmp_den = NANO;
+			break;
+		}
+
+		tmp_num *= (s64)numerator;
+		tmp_den = (s64)abs(val) * tmp_den + (s64)abs(val2);
+
+		if (val < 0 || val2 < 0)
+			tmp_num *= -1;
+
+		break;
+	case IIO_VAL_FRACTIONAL:
+		tmp_num = (s64)numerator * (s64)val2;
+		tmp_den = val;
+		break;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp_num = (s64)numerator << val2;
+		tmp_den = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!tmp_den)
+		return -ERANGE;
+
+	*result = div64_s64(tmp_num, tmp_den);
+
+	return IIO_VAL_INT;
+}
+
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 						 int raw, int *processed,
 						 unsigned int scale)
@@ -699,6 +750,53 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 }
 EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
+static int iio_convert_processed_to_raw_unlocked(struct iio_channel *chan,
+						 int processed, int *raw,
+						 unsigned int scale)
+{
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
+	int ret;
+
+	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
+				      IIO_CHAN_INFO_SCALE);
+	if (scale_type >= 0) {
+		ret = iio_divide_by_value(raw, processed, scale_type, scale_val, scale_val2);
+		if (ret < 0)
+			return ret;
+	} else {
+		*raw = processed;
+	}
+
+	if (!scale)
+		return -ERANGE;
+
+	*raw = div_s64(*raw, scale);
+
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+	if (offset_type >= 0) {
+		switch (offset_type) {
+		case IIO_VAL_INT:
+		case IIO_VAL_INT_PLUS_MICRO:
+		case IIO_VAL_INT_PLUS_NANO:
+			break;
+		case IIO_VAL_FRACTIONAL:
+			offset_val /= offset_val2;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			offset_val >>= offset_val2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*raw -= offset_val;
+	}
+
+	return 0;
+}
+
 int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 			       enum iio_chan_info_enum attribute)
 {
@@ -1035,3 +1133,25 @@ ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
 	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_label);
+
+int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
+				      unsigned int scale)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
+	int ret, processed;
+
+	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
+		if (!chan->indio_dev->info)
+			return -ENODEV;
+
+		ret = iio_convert_processed_to_raw_unlocked(chan, val, &processed, scale);
+		if (ret)
+			return ret;
+
+		ret = iio_channel_write(chan, processed, 0, IIO_CHAN_INFO_RAW);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_write_channel_processed_scale);
+
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index c8c6261c81f934480e16854412e269207be60adc..dc84b8b4c61911d1a58427f1a9c798cae3954ac1 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -399,6 +399,24 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_multiply_value(int *result, s64 multiplier,
 		       unsigned int type, int val, int val2);
 
+/**
+ * iio_divide_by_value() - Divide by an IIO value
+ * @result:	Destination pointer for the division result
+ * @numerator:	Numerator.
+ * @type:	One of the IIO_VAL_* constants. This decides how the @val
+ *		and @val2 parameters are interpreted.
+ * @val:	Denominator.
+ * @val2:	Denominator. @val2 use depends on type.
+ *
+ * Divide an s64 number by an IIO value, storing the result as
+ * IIO_VAL_INT. This is typically used for scaling.
+ *
+ * Returns:
+ * IIO_VAL_INT on success or a negative error-number on failure.
+ */
+int iio_divide_by_value(int *result, s64 numerator,
+			unsigned int type, int val, int val2);
+
 /**
  * iio_convert_raw_to_processed() - Converts a raw value to a processed value
  * @chan:		The channel being queried
@@ -469,4 +487,22 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
  */
 ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
 
+/**
+ * iio_write_channel_processed_scale() - scale and write processed value to a given channel
+ * @chan:		The channel being queried.
+ * @val:		Value to write.
+ * @scale:		Scale factor to apply during the conversion
+ *
+ * This function writes a processed value to a channel. A processed value means
+ * that this value will have the correct unit and not some device internal
+ * representation. If the device does not support writing a processed value, the
+ * function will query the channel's scale and offset and write an appropriately
+ * transformed raw value.
+ *
+ * Return: an error code or 0.
+ *
+ */
+int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
+				      unsigned int scale);
+
 #endif

-- 
2.51.0


