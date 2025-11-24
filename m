Return-Path: <linux-iio+bounces-26422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2EC81208
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 233F0341261
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05728C862;
	Mon, 24 Nov 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qC1F0Fx6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F6287276;
	Mon, 24 Nov 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995733; cv=none; b=oHtuaSlFM1PKFPprb2114RFkykFgCS40H6cCEOdlcYOEX9BcGUwsrRhH2PAXAypnEwGPvHKWExaaKfNSwNfP/lh1kX4KhkyOZ68YtXplUs1aRlzvmUMAxLakaQciTgyFFh5oaC9+vEneAdFNNsyXXsTZUU7ne8JS3jJpZ+f9oXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995733; c=relaxed/simple;
	bh=2OU3XBZR/ypvsRf32D7ISP6bwNiqrP+3DRPVvliThS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FbjnpsHMeR55rvxLhFrSDczn+mv4myoSEoWJXPo3kwlvmOaTj2rSRGCwW9+gRQ0IeZiYMyNW0d0OpXesX5ztUzW1ZeQavUUbV6NUoapnlnkb1XRjDs7EXPEx+d9Emwbk7WS5V6z5QOehjTtShxOC1Gkkk1YLe2And7ZsCH7lnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qC1F0Fx6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 608E1C139AF;
	Mon, 24 Nov 2025 14:48:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 022A2606FC;
	Mon, 24 Nov 2025 14:48:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B030103719DA;
	Mon, 24 Nov 2025 15:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763995728; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zyUY+UF5WbIzqUe+eO/QgydzfxczM+858fxLCRThNrk=;
	b=qC1F0Fx6OVEFK/bZgOsQxDo2NwZyakJsBlpujOS3JFXQ6ZUutFuzSwTU6UXOQJ75JlnwKl
	e21tI+MfDcN4RMYY37xSjntPgbP080IM3c+6kUNkM8rNQkNMEXkz7ozzHygi8pdx5RmRVP
	5cWiAswwIu+8DcgLS2KwMkI2l2Y1n2tIraGhYjI3xx/37EicW1sDtgF1W5uTxl4kYwMp58
	t7vXFliVE5+d4rCfS1ckV9kL8/TiAXZbQ76k6+BFjq6Jt7LP3+2Mk8YOfz5pKE0Z1WL5Ow
	a6VfYE6xUdMlCRYb6JF4K07HE3hkopiX74+3Lp09SkTfSd9q7aqagICAcC1zTQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 24 Nov 2025 15:48:07 +0100
Subject: [PATCH v4 3/6] iio: add processed write API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-ltm8054-driver-v4-3-107a8a814abe@bootlin.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
In-Reply-To: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add a function to allow IIO consumers to write a processed value to a
channel.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/inkern.c         | 127 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h |  36 ++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 70b6f589f37a..6667e8e7648b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -635,6 +635,54 @@ int iio_multiply_value(int *result, s64 multiplier,
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
+		tmp_num = numerator * MICRO;
+		/* Cast inside abs() to avoid undefined behavior if val* == -INT_MIN. */
+		tmp_den = abs((s64)val) * MICRO + abs((s64)val2);
+
+		if (val < 0 || val2 < 0)
+			tmp_num *= -1;
+
+		break;
+	case IIO_VAL_INT_PLUS_NANO:
+		tmp_num = numerator * NANO;
+		tmp_den = abs((s64)val) * NANO + abs((s64)val2);
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
+		return -EDOM;
+
+	*result = div64_s64(tmp_num, tmp_den);
+
+	return IIO_VAL_INT;
+}
+EXPORT_SYMBOL_NS_GPL(iio_divide_by_value, "IIO_UNIT_TEST");
+
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 						 int raw, int *processed,
 						 unsigned int scale)
@@ -703,6 +751,66 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 }
 EXPORT_SYMBOL_NS_GPL(iio_convert_raw_to_processed, "IIO_CONSUMER");
 
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
+		return -EDOM;
+
+	*raw = div_s64(*raw, scale);
+
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+
+	switch (offset_type) {
+	case IIO_VAL_INT:
+	case IIO_VAL_INT_PLUS_MICRO:
+		half_step = MICRO / 2;
+		break;
+	case IIO_VAL_INT_PLUS_NANO:
+		half_step = NANO / 2;
+		break;
+	case IIO_VAL_FRACTIONAL:
+		offset_val = DIV_ROUND_CLOSEST(offset_val, offset_val2);
+		break;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		offset_val >>= offset_val2;
+		break;
+	default:
+		if (offset_type >= 0)
+			return -EINVAL;
+
+		offset_val = 0;
+	}
+
+	/* Round fractional part to closest to reduce rounding bias. */
+	if (half_step) {
+		if (offset_val2 >= half_step)
+			*raw -= 1;
+		else if (offset_val2 <= -half_step)
+			*raw += 1;
+	}
+
+	*raw -= offset_val;
+
+	return 0;
+}
+
 int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 			       enum iio_chan_info_enum attribute)
 {
@@ -1039,3 +1147,22 @@ ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
 	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
 }
 EXPORT_SYMBOL_NS_GPL(iio_read_channel_label, "IIO_CONSUMER");
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
+EXPORT_SYMBOL_NS_GPL(iio_write_channel_processed_scale, "IIO_CONSUMER");
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index a38b277c2c02..f80ab1b80234 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -399,6 +399,24 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_multiply_value(int *result, s64 multiplier,
 		       unsigned int type, int val, int val2);
 
+/**
+ * iio_divide_by_value() - Divide by an IIO value
+ * @result:	Destination pointer for the division result
+ * @numerator:	Numerator.
+ * @type:	One of the %IIO_VAL_* constants. This decides how the @val
+ *		and @val2 parameters are interpreted.
+ * @val:	Denominator.
+ * @val2:	Denominator. @val2 use depends on type.
+ *
+ * Divide @numerator by an IIO value, storing the result as
+ * %IIO_VAL_INT. This is typically used for scaling.
+ *
+ * Returns:
+ * %IIO_VAL_INT on success or a negative error-number on failure.
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
+ * @scale:		Processed value is divided by this scale factor during the conversion.
+ *
+ * This function writes a processed value to a channel. A processed value means
+ * that this value will have the correct unit and not some device internal
+ * representation. If the device does not support writing a processed value, the
+ * function will query the channel's scale and offset and write an appropriately
+ * transformed raw value.
+ *
+ * Returns:
+ * 0 or a negative error-number on failure.
+ */
+int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
+				      unsigned int scale);
+
 #endif

-- 
2.51.2


