Return-Path: <linux-iio+bounces-25964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D56FC3BA9E
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C011F3BFF91
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6A33DEDE;
	Thu,  6 Nov 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sp0CUhs5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21E335067
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438320; cv=none; b=iyA2wXs5IT2gL2MwOVqA4giuSxu8f2DY4i03MRtgJnVuyZmPeTE9/EPhtm9qjZOVRpYRD6c1WacDxTr8Kjc3sV6bgzhff2Nvg4ev293CwzEhnKh1d5k+FzJbeEFBr+G9jvWTudFdXfZILm8lxQSdsFh5Aqy89zs6VG2QcX4BiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438320; c=relaxed/simple;
	bh=rOo5MltLrdmDrYc6NQrTGXqBhoCeH9F49xDdyJh/GR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdcL52dolGw8U1U11zJi0gV+Qt1+GMzzHrSjRTVJlsAkqNp1lGkdDTjQQgoxBi/cMRDc1cCz+ZfSzwUzOxWJSg6qXIK+RKkTkXi3FNgjlPFIs28RPkSa+XLpVgWpbdRQ/Uaib4B4uJMhEYdYE9VQMk0vKK/tMFKYiCMCbGP8dGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sp0CUhs5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 59D104E4156F;
	Thu,  6 Nov 2025 14:11:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 300996068C;
	Thu,  6 Nov 2025 14:11:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E359311850837;
	Thu,  6 Nov 2025 15:11:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762438315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XDLg7NMQMzVNMtuCaTNCwQAMAalsvgOyuQ+Sw7NpVlM=;
	b=Sp0CUhs5pTUtFqsx3RI8QxgoMbPOO7IudArJzJb3uPqUXiZERvOn5gC86vCQ0hekEem5KJ
	WSrBITumwXuc2jXUzWCDc6EGk7JbluvvgjuKf/uMQ4WzhPKiLcAQQ2+Kc/qqoZ4PHziSeU
	X63stTUZTvTdks1eeyi1PNLOiQ1dAIqwmQgAnmlh96raDDnFu5urDiov0sKMH2sgR72CsX
	6xRXzDSCR8V2kiWN6qCPyHmrgXCcPS2HVTCc+ChhbMCsfwQkYsCp/JOunnroX9qQ2/RGCJ
	O4XBFFqc1h3o/X5+Y7cnElD47Now6WEnzZ0GdtGmd7/k2v0tFvorGRkxqYEwZg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 06 Nov 2025 15:11:47 +0100
Subject: [PATCH v3 2/5] iio: add processed write API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ltm8054-driver-v3-2-fd1feae0f65a@bootlin.com>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
In-Reply-To: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
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
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add a function to allow IIO consumers to write a processed value to a
channel.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/inkern.c         | 129 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h |  37 +++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1e5eb5a41271..bd0bbaef6045 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -635,6 +635,57 @@ int iio_multiply_value(int *result, s64 multiplier,
 }
 EXPORT_SYMBOL_NS_GPL(iio_multiply_value, "IIO_UNIT_TEST");
 
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
+		tmp_num *= numerator;
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
@@ -703,6 +754,64 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 }
 EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
 
+static int iio_convert_processed_to_raw_unlocked(struct iio_channel *chan,
+						 int processed, int *raw,
+						 unsigned int scale)
+{
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
+	int ret, half_step = 0;
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
+			half_step = MICRO / 2;
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			half_step = NANO / 2;
+			break;
+		case IIO_VAL_FRACTIONAL:
+			offset_val = DIV_ROUND_CLOSEST(offset_val, offset_val2);
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			offset_val >>= offset_val2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/* Round fractional part to closest to reduce rounding bias. */
+		if (half_step) {
+			if (offset_val2 >= half_step)
+				*raw -= 1;
+			else if (offset_val2 <= -half_step)
+				*raw += 1;
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
@@ -1039,3 +1148,23 @@ ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
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
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
+
+	if (!chan->indio_dev->info)
+		return -ENODEV;
+
+	ret = iio_convert_processed_to_raw_unlocked(chan, val, &processed, scale);
+	if (ret)
+		return ret;
+
+	return iio_channel_write(chan, processed, 0, IIO_CHAN_INFO_RAW);
+}
+EXPORT_SYMBOL_GPL(iio_write_channel_processed_scale);
+
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index a38b277c2c02..29d08b57bac9 100644
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
@@ -469,4 +487,23 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
  */
 ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
 
+/**
+ * iio_write_channel_processed_scale() - scale and write processed value to a given channel
+ * @chan:		The channel being queried.
+ * @val:		Value to write.
+ * @scale:		Processed value is divided by this scale factor during the conversion.
+ *
+ * This function writes a processed value to a channel. A processed value means
+ * that this value will have the correct unit and not some device internal
+ * representation. If the device does not support writing a processed value, the
+ * function will query the channel's scale and offset and write an appropriately
+ * transformed raw value.
+ *
+ * Context: May sleep.
+ * Return: an error code or 0.
+ *
+ */
+int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
+				      unsigned int scale);
+
 #endif

-- 
2.51.2


