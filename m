Return-Path: <linux-iio+bounces-10709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A900C9A3B28
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E1828417C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 10:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DAE202625;
	Fri, 18 Oct 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbanhXqX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92220126D;
	Fri, 18 Oct 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246623; cv=none; b=S9yM6OJMhdC/KS2FbIjZJwAO8XnJLU+o282LtB78Z83Wbtqy3tuMkl2ZgKTIu88mnqU1xVJ/GzuhJlBw2YwmRzTk+ACOH2EnOshypnCH7jolrCw2tVJxG1f7eRUKOG9Ha42d0vWQxwmGdBlcXpTXleEgAk3JcYSZIFytes00Ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246623; c=relaxed/simple;
	bh=QdYDXg+F9crN+GcA1VSjP47ejtoSADQbLgM8+WYO3yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpC33R/laa7/wP1XK/diV9RzIbK6ZUYGNccQK0FaCpgjSiURUz1XhxOj4s+iS6RGVSMm8fTxonG5mE/V4RiPzcgLePVY3tETz+416UGvP/krOgQ8KYNaTZUPcMVbMFbqqqB8vRC0A1Z0NPP3jtcPkNwVd+HjR0X7igsNz7Bf7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbanhXqX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4c482844so1370114f8f.0;
        Fri, 18 Oct 2024 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729246620; x=1729851420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBrQ02u0x+gOef7QkcexjhixwvYLcPbk6l/zE/g/i1o=;
        b=DbanhXqXUH3ISikTIe3B+GML8kPFd5ib9TlAyC0TLlsSRrKVCzFRdvhiEc/oqL0mzP
         MUC0t2TG1CFcuhrIr3VdaHbRlb6ZOTf5fu+7vPaSl75r10G/DbfS8AJPJDjf3dydebUz
         OaEM/bcwL9kKftf5Ge0UblGbu6h59JGqVhrD5zmBHWtdPWWANbMuh0Rs1CRo8Z1uCvJc
         MpCJec/2s3jhkqNekUfuLQfSnVyhonnLpx2Vq6up4yjMeP4T28qtoVIGsiZb6bzxe2dz
         bIHfhQrIcm8GcvWn9Zw6NB5tItHTyP1ou3baS3DxsvSkrJBaLBwNmYSXNLz/RTT4ZbAm
         bzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246620; x=1729851420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBrQ02u0x+gOef7QkcexjhixwvYLcPbk6l/zE/g/i1o=;
        b=EIrsAliH/O7mYGekDZ+AzmNRPPFKGIzVpHeFrtklyK8nWYFLAwgO9IQ9x1s2dqGfZH
         yCWoNZlX7vmE30mJJ0CDPPOx3K653WPGYvyexNoi6jD5ZXZaYMqMwEoQrg3GTiCXu8lT
         1PJeiA1DTE3MYwmdCOUzoCtrM+CmFNDg3jrthEVGR7DxiI0JPa2Lvy06kQke9ZLg4PJE
         Zu46soSPyzhLMp+waeCoUSIXedBiWEsZq12TBIkDm7njTak/O2zkasGw80WHdCn9zy8A
         Pk9IRxnjNYPUM2pjma2E/7vzuhXv3y+buon8Jxg1m+GonRYRsFE/1zxWaWeFEL66GWUD
         7b3w==
X-Forwarded-Encrypted: i=1; AJvYcCUTFTGxGUx/YhIhmWZMTfcXzpUf/nje2qnyGuJjcfbVp95kDyPqo3JKxO9oAZc7kgvYFIDCEbCsFutTkg==@vger.kernel.org, AJvYcCVU07dkHXxCi2OkT8BQSa3E7+Rxr6685oONj5c3mNT/UuwY5BgP78jFG1tHF8oMZQ7y5bhIdPCVh1Pa1+M=@vger.kernel.org, AJvYcCWMB6mU02nk3visRYXyZUhm71dZKxKnOEPrmlu6XeUdqXU+t9Alf9r4DgdM4PfS1YtHQgNgMi9zPqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaYmR3x+1SSWdAj4pS+GLhzo1yc+VD3vjC/ecSAKE4lmGua3W
	UlSsvuRRVQBfl0Yd6VXAYmeksw5oFo7vKZL8dee5Was2kel3Gym6urKQwFfajYo=
X-Google-Smtp-Source: AGHT+IEWRXU4xyknVixAqH/dHVbkeIzgabgehIuumuZvx5wOOxzWL621sJYBa6pc1pakcMDimDc95A==
X-Received: by 2002:adf:e9c2:0:b0:37d:493c:f7b8 with SMTP id ffacd0b85a97d-37eab72779emr1350142f8f.2.1729246619450;
        Fri, 18 Oct 2024 03:16:59 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf066600sm1522219f8f.37.2024.10.18.03.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:16:59 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Fri, 18 Oct 2024 12:16:42 +0200
Subject: [PATCH v4 3/5] iio: pac1921: use read_avail+release APIs instead
 of custom ext_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-iio-read-avail-release-v4-3-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
In-Reply-To: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

The pac1921 driver was exposing the available scale info via an ad-hoc
ext_info attribute instead of using the read_avail API. This to avoid a
possible race condition: while the available current scales were being
printed to sysfs by iio core (iio_read_channel_info_avail), the shunt
resistor might have been changed concurrently.

Switch to the read_avail+release APIs now that the race condition has
been addressed.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/adc/pac1921.c | 128 ++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 83 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index a96fae546bc1e6d1bf3a0dbe67204c191d77a3ee..f6f8f9122a78d1b5e63d8184203eb3dae55eb560 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -444,11 +444,52 @@ static int pac1921_read_avail(struct iio_dev *indio_dev,
 		*vals = pac1921_int_num_samples;
 		*length = ARRAY_SIZE(pac1921_int_num_samples);
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case PAC1921_CHAN_VBUS:
+			*vals = (const int *)pac1921_vbus_scales;
+			*length = ARRAY_SIZE(pac1921_vbus_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+			return IIO_AVAIL_LIST;
+
+		case PAC1921_CHAN_VSENSE:
+			*vals = (const int *)pac1921_vsense_scales;
+			*length = ARRAY_SIZE(pac1921_vsense_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+			return IIO_AVAIL_LIST;
+
+		case PAC1921_CHAN_CURRENT: {
+			struct pac1921_priv *priv = iio_priv(indio_dev);
+
+			*length = ARRAY_SIZE(priv->current_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+
+			guard(mutex)(&priv->lock);
+
+			*vals = kmemdup_array((int *)priv->current_scales,
+					      *length, sizeof(int), GFP_KERNEL);
+			if (!*vals)
+				return -ENOMEM;
+
+			return IIO_AVAIL_LIST;
+		}
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
 }
 
+static void pac1921_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	if (mask == IIO_CHAN_INFO_SCALE &&
+	    chan->channel == PAC1921_CHAN_CURRENT)
+		kfree(vals);
+}
+
 /*
  * Perform configuration update sequence: set the device into read state, then
  * write the config register and set the device back into integration state.
@@ -748,6 +789,7 @@ static int pac1921_read_event_value(struct iio_dev *indio_dev,
 static const struct iio_info pac1921_iio = {
 	.read_raw = pac1921_read_raw,
 	.read_avail = pac1921_read_avail,
+	.read_avail_release_resource = pac1921_read_avail_release_res,
 	.write_raw = pac1921_write_raw,
 	.write_raw_get_fmt = pac1921_write_raw_get_fmt,
 	.read_label = pac1921_read_label,
@@ -805,88 +847,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	return len;
 }
 
-/*
- * Emit on sysfs the list of available scales contained in scales_tbl
- *
- * TODO:: this function can be replaced with iio_format_avail_list() if the
- * latter will ever be exported.
- *
- * Must be called with lock held if the scales_tbl can change runtime (e.g. for
- * the current scales table)
- */
-static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
-					  size_t size, char *buf)
-{
-	ssize_t len = 0;
-
-	for (unsigned int i = 0; i < size; i++) {
-		if (i != 0) {
-			len += sysfs_emit_at(buf, len, " ");
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-		}
-		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
-				     scales_tbl[i][1]);
-		if (len >= PAGE_SIZE)
-			return -EFBIG;
-	}
-
-	len += sysfs_emit_at(buf, len, "\n");
-	return len;
-}
-
-/*
- * Read available scales for a specific channel
- *
- * NOTE: using extended info insted of iio.read_avail() because access to
- * current scales must be locked as they depend on shunt resistor which may
- * change runtime. Caller of iio.read_avail() would access the table unlocked
- * instead.
- */
-static ssize_t pac1921_read_scale_avail(struct iio_dev *indio_dev,
-					uintptr_t private,
-					const struct iio_chan_spec *chan,
-					char *buf)
-{
-	struct pac1921_priv *priv = iio_priv(indio_dev);
-	const int (*scales_tbl)[2];
-	size_t size;
-
-	switch (chan->channel) {
-	case PAC1921_CHAN_VBUS:
-		scales_tbl = pac1921_vbus_scales;
-		size = ARRAY_SIZE(pac1921_vbus_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-
-	case PAC1921_CHAN_VSENSE:
-		scales_tbl = pac1921_vsense_scales;
-		size = ARRAY_SIZE(pac1921_vsense_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-
-	case PAC1921_CHAN_CURRENT: {
-		guard(mutex)(&priv->lock);
-		scales_tbl = priv->current_scales;
-		size = ARRAY_SIZE(priv->current_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-	}
-	default:
-		return -EINVAL;
-	}
-}
-
-#define PAC1921_EXT_INFO_SCALE_AVAIL {					\
-	.name = "scale_available",					\
-	.read = pac1921_read_scale_avail,				\
-	.shared = IIO_SEPARATE,						\
-}
-
-static const struct iio_chan_spec_ext_info pac1921_ext_info_voltage[] = {
-	PAC1921_EXT_INFO_SCALE_AVAIL,
-	{}
-};
-
 static const struct iio_chan_spec_ext_info pac1921_ext_info_current[] = {
-	PAC1921_EXT_INFO_SCALE_AVAIL,
 	{
 		.name = "shunt_resistor",
 		.read = pac1921_read_shunt_resistor,
@@ -910,6 +871,7 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -927,12 +889,12 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.indexed = 1,
 		.event_spec = pac1921_overflow_event,
 		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
-		.ext_info = pac1921_ext_info_voltage,
 	},
 	{
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -950,12 +912,12 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.indexed = 1,
 		.event_spec = pac1921_overflow_event,
 		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
-		.ext_info = pac1921_ext_info_voltage,
 	},
 	{
 		.type = IIO_CURRENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.47.0


