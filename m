Return-Path: <linux-iio+bounces-13950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBBA03A22
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651973A5261
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702281E3772;
	Tue,  7 Jan 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C3DYJO4L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48C1E0E01
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239714; cv=none; b=cq9Wr6yO61bnYBEs7p4rf9afi+TdxeE0CE5rUT/vjJgkF4z+clhFR3reHmTAzSJeydbv9a8T05W4fqfhtTZ1IY+2kteLFlHvhcxWJ77jF+gqCaLy1ZDd1Nq4Rt/DQSZtx9gSQFNh/f4MUk50PELVrLVzB5Y6+r6idYHXugL6Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239714; c=relaxed/simple;
	bh=OpXFBqIRxayWYy838v0tIReyzOHoFPXkfb3RieMBDm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIot6e7mqWmxcgDsmcrcONReOYepsCyLzS55cBo2JQTkANhpmlkLdqZq8E5whC1qhHfHS9PJ+qTz3sp18hoecxYNpjW45g3MDi5iLu/0PlSz9xfrEH3exoDNBlYhqMSUPNEsxsFSilX62XcLpgi8OsxgObGgGLvqvRejMZ4YWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C3DYJO4L; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4361f796586so156982475e9.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 00:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736239709; x=1736844509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQojh4vJndN41Gj34B/frazp8U3nnF6i/HJBJX4kBzw=;
        b=C3DYJO4L3pN+pAM+7BvaLyNePlU7cTdRTQS6LIEaG0pdFyffq3Gj48fYlkQ3JQ2bIX
         mUFPkI/av7KE6x3SeXSieM13TD6DMygrIpdcAJDvEbMF5AnxJ7p2SC+9csbzsAQHfXcH
         BNomysibtaiJAFLlZ5zQudmkBwOkNT86CbxfLQ5zbw4MxbdI0J8OgzKHugocKARD9yit
         pF1WBpPTPY5TTifjTtpRYdAtU2apzjDrhWzYTohj2Sc97bPSPQ+Nyzrdo245dv4o003Q
         Wf3yj3o6H/1yxcsJ7QI+CE8sZrRT2qxVUfLtC8uw7u4WWLGJ67jB4nHSt4QVb8Y12640
         nmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239709; x=1736844509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQojh4vJndN41Gj34B/frazp8U3nnF6i/HJBJX4kBzw=;
        b=KiBqWbCSTGEzsIhDjiZBoE42xpFPSPV5tcTN1EQTegg8a559Ps/kTo92ixJ6uBp1Wn
         ztBCy0fO46WRM8XDAgxDWJItsBozsLBDbgSsKFVcqBwnS++j5aC2EG17mSz0Dec3vrSa
         WHYGznSxHd6DXl12bCBIfRpN0x6V2CxFm2BhPgMU2h6SjHRfChgR1G56ZaEM8ypXF2id
         nTEzNHNz4i0F+K+QjyP9/NUcN9ILqYeZNK/CTGvM2nNefz+4JWRqnJgeUe/396TjRkMk
         AQwwj5NKJfMqKBxqoSD6FZ53L3A2XhxJX4PLtl3U8AcmW+uo+l2dZcq3p2NxC+n3t5x0
         eirw==
X-Gm-Message-State: AOJu0Yx0O5d3kaco/kuKNyDuPBH3tzJj61z93A3Dfre0S+jD2Dvf8LCY
	JATfr7RegBIfNO9UAzr63SRkWyn1LsII+Ot4MRDckl9nKadxfcOSQOgCM+0tcEI=
X-Gm-Gg: ASbGncv6H3uj4iN6mIH/TXYieQ8AxjQAIqfpxIk/jdpr9EK81yc7FrS0b37o7oh5o5z
	wOP6eJdafDoZFGhyRvSzhMUfJFyMjbZSOLS+3XDHINcrCUtRskdykQtR1Qji2xfo6fzoMIth/Nu
	4pC5ki0E+3Hf5W85SFXTFNzCfY6LBqxWDg8Ksz3aFBUfZMJYlZbTWJhhbQ8oMx5pC6TANjuB3Xc
	Zi/UvyzFr445qDa/f72UK5DarIPWkEyBKkMuEid5RN67ONPOwz9tbm6N5YcrnUaTmIp4Irxr+K+
	y4Nd+dV0NvfIUSYHFhsCosNKQypYnnBWsGCBxEj6sj4bboqdDw==
X-Google-Smtp-Source: AGHT+IEWVn/IlSWfib9pQwA3jHGI2sLUhKtfgApNDeKG4eEkxqTaxRrq6BjH7PlJzVCaWSGLc9PRjg==
X-Received: by 2002:a05:600c:4709:b0:436:1ac2:1acf with SMTP id 5b1f17b1804b1-43668a3a35dmr460164025e9.20.1736239709462;
        Tue, 07 Jan 2025 00:48:29 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm50722280f8f.1.2025.01.07.00.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:48:28 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 07 Jan 2025 09:48:28 +0100
Subject: [PATCH v3 4/5] iio: adc: ad7380: add alert support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-ad7380-add-alert-support-v3-4-bce10afd656b@baylibre.com>
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
In-Reply-To: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

The alert functionality is an out of range indicator and can be used as
an early indicator of an out of bounds conversion result.

ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to all
channels.

When using 1 SDO line (only mode supported by the driver right now), i.e
data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
used as an alert pin. The alert pin is updated at the end of the
conversion (set to low if an alert occurs) and is cleared on a falling
edge of CS.

The ALERT register contains information about the exact alert status:
channel and direction. ALERT register can be accessed using debugfs if
enabled.

User can set high/low thresholds and enable alert detection using the
regular iio events attributes:

  events/in_thresh_falling_value events/in_thresh_rising_value
  events/thresh_either_en

In most use cases, user will hardwire the alert pin to trigger a shutdown.

In theory, we could generate userspace IIO events for alerts, but this
is not implemented yet for several reasons [1]. This can be implemented
later if a real use case actually requires it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>

[1] https://lore.kernel.org/all/4be16272-5197-4fa1-918c-c4cdfcaee02e@baylibre.com/
---
 drivers/iio/adc/ad7380.c | 189 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index a532de4422082df8503454d66fc49f75b52cff68..1fc694c1557cead906ce199c7777bddf9d29d400 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -34,6 +34,7 @@
 #include <linux/util_macros.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -112,6 +113,24 @@ struct ad7380_chip_info {
 	const struct ad7380_timing_specs *timing_specs;
 };
 
+static const struct iio_event_spec ad7380_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_dir = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_dir = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 enum {
 	AD7380_SCAN_TYPE_NORMAL,
 	AD7380_SCAN_TYPE_RESOLUTION_BOOST,
@@ -214,6 +233,8 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
 	.has_ext_scan_type = 1,							\
 	.ext_scan_type = ad7380_scan_type_##bits##_##sign,			\
 	.num_ext_scan_type = ARRAY_SIZE(ad7380_scan_type_##bits##_##sign),	\
+	.event_spec = ad7380_events,						\
+	.num_event_specs = ARRAY_SIZE(ad7380_events),				\
 }
 
 #define AD7380_CHANNEL(index, bits, diff, sign)		\
@@ -1157,12 +1178,180 @@ static int ad7380_get_current_scan_type(const struct iio_dev *indio_dev,
 					    : AD7380_SCAN_TYPE_NORMAL;
 }
 
+static int ad7380_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int alert_en, tmp, ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	if (ret)
+		return ret;
+
+	alert_en = FIELD_GET(AD7380_CONFIG1_ALERTEN, tmp);
+
+	return alert_en;
+}
+
+static int ad7380_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_ALERTEN,
+				 FIELD_PREP(AD7380_CONFIG1_ALERTEN, state));
+
+	iio_device_release_direct_mode(indio_dev);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ad7380_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret, tmp;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(st->regmap,
+					  AD7380_REG_ADDR_ALERT_HIGH_TH,
+					  &tmp);
+			if (ret)
+				return ret;
+
+			*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(st->regmap,
+					  AD7380_REG_ADDR_ALERT_LOW_TH,
+					  &tmp);
+			if (ret)
+				return ret;
+
+			FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7380_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	int ret;
+	u16 th;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		/*
+		 * According to the datasheet,
+		 * AD7380_REG_ADDR_ALERT_HIGH_TH[11:0] are the 12 MSB of the
+		 * 16-bits internal alert high register. LSB are set to 0xf.
+		 * AD7380_REG_ADDR_ALERT_LOW_TH[11:0] are the 12 MSB of the
+		 * 16 bits internal alert low register. LSB are set to 0x0.
+		 *
+		 * When alert is enabled the conversion from the adc is compared
+		 * immediately to the alert high/low thresholds, before any
+		 * oversampling. This means that the thresholds are the same for
+		 * normal mode and oversampling mode.
+		 */
+
+		/* Extract the 12 MSB of val */
+		scan_type = iio_get_current_scan_type(indio_dev, chan);
+		if (IS_ERR(scan_type))
+			return PTR_ERR(scan_type);
+
+		th = val >> (scan_type->realbits - 12);
+
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_write(st->regmap,
+					   AD7380_REG_ADDR_ALERT_HIGH_TH,
+					   th);
+			if (ret)
+				return ret;
+
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_write(st->regmap,
+					   AD7380_REG_ADDR_ALERT_LOW_TH,
+					   th);
+			if (ret)
+				return ret;
+
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad7380_info = {
 	.read_raw = &ad7380_read_raw,
 	.read_avail = &ad7380_read_avail,
 	.write_raw = &ad7380_write_raw,
 	.get_current_scan_type = &ad7380_get_current_scan_type,
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
+	.read_event_config = &ad7380_read_event_config,
+	.write_event_config = &ad7380_write_event_config,
+	.read_event_value = &ad7380_read_event_value,
+	.write_event_value = &ad7380_write_event_value,
 };
 
 static int ad7380_init(struct ad7380_state *st, bool external_ref_en)

-- 
2.47.1


