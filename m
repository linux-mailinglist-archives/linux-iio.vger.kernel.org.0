Return-Path: <linux-iio+bounces-8635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE8958BCE
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3705B22D5E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AFC1B86F8;
	Tue, 20 Aug 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gDBZaDyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA6194ADB
	for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169538; cv=none; b=d8em1aVivoRE+XhN+JZ44+3nWLLndqRASOSybsC/LUureWfp2VteMEgx4SbTcqIzZnhJ2p93xLwvhdgSvbMFNIOweQNfQdFFkPMh7KA1/yrY/5KmezraaJjF2wFLSt+umVg58jM1JotkgeD9IlcS+UdpK2EGbHl+l/6G3GmHBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169538; c=relaxed/simple;
	bh=oaJmi/ZJxtUimFsdNU5rkHVdgv/yFGZx1cME/QQcQl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbdwTQlJfnhwg37+ySCQWK8HVtq2qSdpkqSRu/z8x/IbOQpeP2A7WrMchq4mVtMt96khdWn372h0VXk21MScki1mWqt00APFq/FX3jM6IZw21aENJvpc8cd37U5fz0+1i4A9IIYUEc5i0V4QCjGseG/Wqov+kKHRap2Xy4rc8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gDBZaDyx; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db1d0fca58so3403578b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724169534; x=1724774334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HECI8r7T3u0JJ5Sp0TIQJdhUl6oQitYnZhldhbcQNd4=;
        b=gDBZaDyx/B8rLKbArX27DDnjyZuPyQlWPxhjVduEZO8pVGLu8xEtkHiF1t6M/USsfA
         I41M3NoJewibYYsop7nCwS84z56g8DTlwrv04grKTibOorqXIZ/LqRIOJ/rSz3tg/QI2
         MfVHTcDn2++E5xHOtv172unTGk2eqgWA1UY1rDGTMQUtwN0OjmUnyd69GGlsvXCO9oZ0
         KpTySUBaxlyLq7YtN0k88Sz+i3jxTyF4mgylvG08w/o3RKeFudvHehXXn1SVNap/ywqt
         3Yu0HZzB4VkW80M8zdoAtowl6abRiTTttnLcawI1flzrh76lBuC/3Xi3WSHg6GOnJGMB
         Khig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169534; x=1724774334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HECI8r7T3u0JJ5Sp0TIQJdhUl6oQitYnZhldhbcQNd4=;
        b=jUDn9mYd6y3Fw+Xoz8imjTvJ62q9duxxqcjr+h5zwYFeuf78sppdAy6BVHwPa05ol5
         KC0lfiC2TmY+F9yx7/IYxKfDrMS7mBaxIGRFjI3FO+NMnCfwHWivkQcDSauAxfaNA/Gm
         ELG2wb6Vj3l78LPzjH4HzDRL8Tn8yiGezdKsVXCda6QB2zIHbgECFznU6JULdIviv7C1
         YZj69XpXRRUrLFyOH7dRf2MdWyMZXvsxM4lMzt26QnXuD8uuGxGAbmDQZHoN9B0xA9KU
         tzLlwvkrb0I2RyTJxO9s9bbnxd/0C1mzeTIWtYb2WFZ6nTPt1gU2OKVHX+WCE0UjHJkH
         7l4A==
X-Forwarded-Encrypted: i=1; AJvYcCXgo02dTsqA1m3xQ9r8x4AFmCXEWMEbf/mEqBXF9ALYlRs2RfKwtNAqGzB09Q7v6A1nhTsXiz8QdZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhot/ei87MMQkeLWj31TOcZEmBAhQjKYwQTpiEFUKPl4GPQcFZ
	BuPEc1dET9VsAX1gtfWJISfJh4J8y7GRuFUlscusMOd882u2upRwCzHFgi/L4/Q=
X-Google-Smtp-Source: AGHT+IHIkAhI9bCg/czmhOwJ00jGYFHqeuQAh3GUl0mP8FSSaKUHPiSl0FgDu1UYYUa+B/YzS+e4WQ==
X-Received: by 2002:a05:6808:238f:b0:3dc:1b05:73fd with SMTP id 5614622812f47-3dd3acf921dmr18073312b6e.10.1724169534171;
        Tue, 20 Aug 2024 08:58:54 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d5a3efsm2872718b6e.17.2024.08.20.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:58:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 20 Aug 2024 10:58:36 -0500
Subject: [PATCH 2/4] iio: adc: ad4695: implement calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
In-Reply-To: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

The AD4695 has a calibration feature that allows the user to compensate
for variations in the analog front end. This implements this feature in
the driver using the standard `calibgain` and `calibbias` attributes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 63d816ad2d1f..181c4146188c 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -23,6 +23,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/minmax.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -225,7 +226,11 @@ static const struct iio_chan_spec ad4695_channel_template = {
 	.indexed = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
-			      BIT(IIO_CHAN_INFO_OFFSET),
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					BIT(IIO_CHAN_INFO_CALIBBIAS),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 16,
@@ -619,7 +624,8 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 	struct ad4695_state *st = iio_priv(indio_dev);
 	struct ad4695_channel_config *cfg = &st->channels_cfg[chan->scan_index];
 	u8 realbits = chan->scan_type.realbits;
-	int ret;
+	unsigned int reg_val;
+	int ret, tmp;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -670,6 +676,153 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_CALIBSCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				ret = regmap_read(st->regmap16,
+					AD4695_REG_GAIN_IN(chan->scan_index),
+					&reg_val);
+				if (ret)
+					return ret;
+
+				*val = reg_val;
+				*val2 = 15;
+
+				return IIO_VAL_FRACTIONAL_LOG2;
+			}
+			unreachable();
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				ret = regmap_read(st->regmap16,
+					AD4695_REG_OFFSET_IN(chan->scan_index),
+					&reg_val);
+				if (ret)
+					return ret;
+
+				tmp = sign_extend32(reg_val, 15);
+
+				*val = tmp / 4;
+				*val2 = abs(tmp) % 4 * MICRO / 4;
+
+				if (tmp < 0 && *val2) {
+					*val *= -1;
+					*val2 *= -1;
+				}
+
+				return IIO_VAL_INT_PLUS_MICRO;
+			}
+			unreachable();
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4695_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		switch (mask) {
+		case IIO_CHAN_INFO_CALIBSCALE:
+			switch (chan->type) {
+			case IIO_VOLTAGE:
+				if (val < 0 || val2 < 0)
+					reg_val = 0;
+				else if (val > 1)
+					reg_val = U16_MAX;
+				else
+					reg_val = (val * (1 << 16) +
+						   mul_u64_u32_div(val2, 1 << 16,
+								   MICRO)) / 2;
+
+				return regmap_write(st->regmap16,
+					AD4695_REG_GAIN_IN(chan->scan_index),
+					reg_val);
+			default:
+				return -EINVAL;
+			}
+		case IIO_CHAN_INFO_CALIBBIAS:
+			switch (chan->type) {
+			case IIO_VOLTAGE:
+				if (val2 >= 0 && val > S16_MAX / 4)
+					reg_val = S16_MAX;
+				else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
+					reg_val = S16_MIN;
+				else if (val2 < 0)
+					reg_val = clamp_t(int,
+						-(val * 4 + -val2 * 4 / MICRO),
+						S16_MIN, S16_MAX);
+				else if (val < 0)
+					reg_val = clamp_t(int,
+						val * 4 - val2 * 4 / MICRO,
+						S16_MIN, S16_MAX);
+				else
+					reg_val = clamp_t(int,
+						val * 4 + val2 * 4 / MICRO,
+						S16_MIN, S16_MAX);
+
+				return regmap_write(st->regmap16,
+					AD4695_REG_OFFSET_IN(chan->scan_index),
+					reg_val);
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	}
+	unreachable();
+}
+
+static int ad4695_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	static const int ad4695_calibscale_available[6] = {
+		/* Range of 0 (inclusive) to 2 (exclusive) */
+		0, 15, 1, 15, U16_MAX, 15
+	};
+	static const int ad4695_calibbias_available[6] = {
+		/*
+		 * Datasheet says FSR/8 which translates to signed/4. The step
+		 * depends on oversampling ratio which is always 1 for now.
+		 */
+		S16_MIN / 4, 0, 0, MICRO / 4, S16_MAX / 4, S16_MAX % 4 * MICRO / 4
+	};
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*vals = ad4695_calibscale_available;
+			*type = IIO_VAL_FRACTIONAL_LOG2;
+			return IIO_AVAIL_RANGE;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*vals = ad4695_calibbias_available;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_RANGE;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -705,6 +858,8 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad4695_info = {
 	.read_raw = &ad4695_read_raw,
+	.write_raw = &ad4695_write_raw,
+	.read_avail = &ad4695_read_avail,
 	.debugfs_reg_access = &ad4695_debugfs_reg_access,
 };
 

-- 
2.43.0


