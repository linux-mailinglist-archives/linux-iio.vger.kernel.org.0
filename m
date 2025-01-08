Return-Path: <linux-iio+bounces-14019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A9A05C0B
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 13:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98561652C2
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804C1FC7F4;
	Wed,  8 Jan 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YbeNM4CF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211851FBC99
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340590; cv=none; b=djGW7FeaTmDjZk854j1l1xRrT3TfJBBOQJTdfRlmx3JbwfQxxIdZWMSNBh7bSJSty3I97Iu3weXFvSmuLpiZuR6l9b04RP4RtgLmecJlJdPX3tgYMJczsROc6Ov2EH8sguBK+3J3/N05fucY+368kEEjV4GJrJCn1MLOOKDAqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340590; c=relaxed/simple;
	bh=KA1qdqsZfJYL0paJzWnR8IkBa4kpVbH9E0CtFYIh3OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLlhZg35mmVfTwcswEBgIOmDjqFhCvwOeF/UqwcicoiSiAaC8wo8hSrfjWa7+iPeXEGrUm+9Lmq30EOD8MW+DtOg371YKl91YqXe1JJctYMBYmyhlbF380JiSitBxLoa7T4/ovXfgW7ZP97BX9cUYoTRsm68JMe5KOYv3O09a0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YbeNM4CF; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3862f32a33eso7524003f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736340586; x=1736945386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJ+zcxHZ3EsxL3ZXdjUwAasoZIJYeKInjwJt+E7P06g=;
        b=YbeNM4CFTi9mrSf/ppPNfri3rE/gTUGeXka/hDVc56OxXzTGJF7/V03BY+Ir3DS6qd
         8Po4Kp3tADiY5C+o6Q0AuhT7riJH2A+PXwStw/QaRe7xUvT9xwZcxnWAlBqALMVKKWVz
         ONDS8wb8m//F0BE9AU1Uubd5sOqIlFZ967q2thp/NfUcrR9sPptf7Ok3ZWYLwFqk/Qv6
         MjLsPYR/Ngqi7Ib3rMNg5R6qHynlHqXvpWlpq4zhXNnNVX7L8lkpXlmMupdFFVTkiPE6
         Yw+S6j0ldBk7w8/45iBiQC8UAnJ6NQjBlIXjSEUjFuUZxVAm50p5BRFZRTqwYGIFz0jV
         ByZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340586; x=1736945386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ+zcxHZ3EsxL3ZXdjUwAasoZIJYeKInjwJt+E7P06g=;
        b=jcvwowqxDpLFRJoqeG/SUyMfgxT5hk7+mtwFondwGQ2QJO0jJ5McEU+nhEqyKxJxmI
         YA5KdLuvuqAY+Ed3OkmcEGdAg9/6gc8i2AMAxiYBSvYrsp8iKRzhmYRQZ8eu1sApppfH
         K2MfNICZjUmjGHkz0ZjX4hCXViGuw+zzs/hJRcDyI0C8Q1mEmrzu9JzWGQbCpcZECjnY
         xkupwGeHnaAbnxHbtmU/yVJtIqUYn8+DyD3BOQF5HoNO1Jw6It2yUTQtvqLsIaby8+Ca
         y3P539R76ADUF7JU4GwEeV8N+bMPQCe4JG1H4etaQLqVj3JfJkkpLJdhHLgBl4Nk6ZTr
         tOVg==
X-Gm-Message-State: AOJu0YyWU1WNxk1ZvcazEEwVpCY8hoUJJDRZzr6MHXS23M1RcCG1vEU3
	VASemvCLSjuB6cffHZx+FtR57+K7oRVk2BWlvY4UvAhxVeg9RlusGuR0Hadwjw8=
X-Gm-Gg: ASbGncti3nVGX+kmGCINZzlcbnYIvwqKSkqtXRQCoe/LviL413Ny41OagLcqG7cQTQG
	hswdj2wxkdk/1f0ULno3QizEerw0Ac55LTnVg5rnRcmYZ/r4CnqsuGT9UYmfRZN3m5UBpSQJtbi
	wdRMOcS5n46jAs+Q8XOf/jur+eH9AYg2kIWFmDBO3QEWp7lIpG5iFTfKufQ72KaB9DPpew/W87U
	Z+K2jOLgZwcPqC3691QycUj/UvaVsr7cIj6wEgou3AJPit/yECSLKsBxS97V4+EK9T2pGjYpzSU
	rGzyxDT2VeTXy37L+cYqW1Mfhfxwfc3atjax7zX1U0mtGB+liKulBw==
X-Google-Smtp-Source: AGHT+IGTO0/JVXTiLRNDx/Ud4GZVUE6svyHOPNwrUyxK5M5DnPTxtJnvZiHZd6iqkTFwo2fqQEjgJQ==
X-Received: by 2002:a05:6000:18a8:b0:388:c790:1dff with SMTP id ffacd0b85a97d-38a8733fd71mr1798784f8f.47.1736340586500;
        Wed, 08 Jan 2025 04:49:46 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da63eesm19846805e9.3.2025.01.08.04.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:49:45 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jan 2025 13:49:36 +0100
Subject: [PATCH v4 4/5] iio: adc: ad7380: add alert support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-ad7380-add-alert-support-v4-4-1751802471ba@baylibre.com>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
In-Reply-To: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
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
 drivers/iio/adc/ad7380.c | 197 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index a532de4422082df8503454d66fc49f75b52cff68..cedd45556ee38b3197f8dd7edea162c3f4ba1563 100644
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
@@ -1157,12 +1178,188 @@ static int ad7380_get_current_scan_type(const struct iio_dev *indio_dev,
 					    : AD7380_SCAN_TYPE_NORMAL;
 }
 
+static int ad7380_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int tmp, ret;
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
+	return FIELD_GET(AD7380_CONFIG1_ALERTEN, tmp);
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
+	return ret;
+}
+
+static int ad7380_get_alert_th(struct ad7380_state *st,
+			       enum iio_event_direction dir,
+			       int *val)
+{
+	int ret, tmp;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(st->regmap,
+				  AD7380_REG_ADDR_ALERT_HIGH_TH,
+				  &tmp);
+		if (ret)
+			return ret;
+
+		*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_read(st->regmap,
+				  AD7380_REG_ADDR_ALERT_LOW_TH,
+				  &tmp);
+		if (ret)
+			return ret;
+
+		*val = FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
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
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_get_alert_th(st, dir, val);
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7380_set_alert_th(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_direction dir,
+			       int val)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	u16 th;
+
+	/*
+	 * According to the datasheet,
+	 * AD7380_REG_ADDR_ALERT_HIGH_TH[11:0] are the 12 MSB of the
+	 * 16-bits internal alert high register. LSB are set to 0xf.
+	 * AD7380_REG_ADDR_ALERT_LOW_TH[11:0] are the 12 MSB of the
+	 * 16 bits internal alert low register. LSB are set to 0x0.
+	 *
+	 * When alert is enabled the conversion from the adc is compared
+	 * immediately to the alert high/low thresholds, before any
+	 * oversampling. This means that the thresholds are the same for
+	 * normal mode and oversampling mode.
+	 */
+
+	/* Extract the 12 MSB of val */
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	th = val >> (scan_type->realbits - 12);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return regmap_write(st->regmap,
+				    AD7380_REG_ADDR_ALERT_HIGH_TH,
+				    th);
+	case IIO_EV_DIR_FALLING:
+		return regmap_write(st->regmap,
+				    AD7380_REG_ADDR_ALERT_LOW_TH,
+				    th);
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
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_set_alert_th(indio_dev, chan, dir, val);
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


