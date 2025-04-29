Return-Path: <linux-iio+bounces-18836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7AAA0D2B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4C4188D0D5
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB762D4B5E;
	Tue, 29 Apr 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PwqnmTnY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AF2D1934
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745932090; cv=none; b=n5Ff/YdJec5Bdjd8+uzbW7D3ddr2Zpp7DmU49AfBDvaAb4i5TTmjmg5rYumxB4HRDxMz4Z1Pqc2WRisnVyMQ17roRb5wQCQhppvTwriTmEp1XvDVQFv+WO+1paYgSSYwlaNOxXmrI+WjQHPRLsOm5r2XBsYioEu0JhlVj/dpDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745932090; c=relaxed/simple;
	bh=dMMXbPk/Hq/FX9WY7l+LEsB/nW8zuvdbt6eejkvbA1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFKl8h3lGfKqYAwCZ8TQrSS/soZzW7Q6P1EBTB/gDtm1P6n5kqU9pu1U00n6tmU+b44d95Fzi+ko56oyc3SYqc++XiGN5tSN3DiYgmxEIjaJVRIKXLKFITRNzPe7+yYTtuV5kDTW2wD0/HxMtsgk0jyTw8u2f0pyndTwjCIUewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PwqnmTnY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so14074935e9.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745932086; x=1746536886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3hbPy+6S/vUkcY3xyn0qHp6go2W/iLOvnFGZ2qM7pk=;
        b=PwqnmTnYR9/7viz+cZV+BQE31bWSK07kz74Fi0PJ7d3+Bc/B2kjm5Kw+ETA88/b35O
         tnkAiEoYJXQmNh1DYZaH0mRMtMHYPToU/5TXyR2dMrLaniB08L2Wz1jF8S8onnnjiEiD
         NOttehZONRg930Tc1HW+XdZ7dkdBuxmXBJyrngdyl2ag32PCeVQwv8ZTgcnFxZsfLnFP
         q/aYZvmmlwHrrAjAwHVyW1pn4A15A148krY+F5iLxvgVSsnaMDFRrjKhHJZrJOEeiz44
         KSqxvYVtOmcaVAY5MT8hgKeaOCb+ssALHjQXHABQRgQRlJles6lm/XKsjK4qAFatdgUa
         uQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745932086; x=1746536886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3hbPy+6S/vUkcY3xyn0qHp6go2W/iLOvnFGZ2qM7pk=;
        b=ueTF9VdSyDhmaSlJ1/8nuze6GArUT1ADZIB2Xpuui/hLSg7y9U5ZAwr0ZaLAmbl7Hk
         HYPSSVl6cM1R29fWjsGTuo2BhA5kn6EPn7vN1UHYjOyO1cighe+o3LJslvsX9mtW19NY
         Nxd35TEByeHEwUnravQqhMe4cSSc20tU5gU/exyLHvsj1xW0Ai+HX0XlAlprnneJXT7e
         mWtPGXE7Ow9lagaWVHkfujIvVl093Yd0GIg8n73XEeVGOPKbRTRuG9/K+YUy7JCt/HUK
         0MCA0evLFzSkdsleuSZ42oF+nV/iRQLK/SVRYzo6+ppKLxNgj6eida9zdV++HSiPWPH8
         sMlw==
X-Gm-Message-State: AOJu0Yw6W4cYps1XFfCkOA5qayeia0S8oz1jHfcHHuFOYX1eziIijr1N
	l5+SrIJXVxt2dgnPhZobiLWJjPtwrU4diRXUB5mzxoKZS5sT+4Kr+4JPckAHZeY=
X-Gm-Gg: ASbGnct9F0eojyiVZ1sabt7UwWEKLKU5KO5u2KF6lJhNAigNe6uYgfU6GHyf1VsV3iv
	Mj8KsqUJ6s3dGS1PuwFk2T+yMHRYkQYdSdp6xWfgCg2Y72TGnmf6qnV74Q+RU8MVJjMerxsBbo/
	YjGS38MpT/vmProbYXSL190m6+UcZomWeQ3XVjQgR+bznntj6uxSviSVJD45KjjmeNMBzIThG+V
	HtHBLBGTzu4rg7piTbCGqVHGytnD727MYJCx8J5iucH1qCdwJ/3i5Qan7eoHv9M7czBz5R6CI5y
	EUxb28KBehScltfXiimXlPwvNP9NfHsYsXTyGQsIJlcQwzJBUQqMmpUxQLR9hDnp3LOcOhYoYV7
	SR6m2439LZrXZ
X-Google-Smtp-Source: AGHT+IHfszf3HIWyRmq7nLOXxB3rcayqSzw/ilkJ4uh8tcAyzsRYcLkmYtE1YR/xACtyoWIxprWLyA==
X-Received: by 2002:a05:600c:a44:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-441ad4fee66mr21405945e9.29.1745932085692;
        Tue, 29 Apr 2025 06:08:05 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5310ad2sm155550565e9.21.2025.04.29.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:08:05 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 29 Apr 2025 15:06:47 +0200
Subject: [PATCH 3/5] iio: adc: ad7606: add offset and phase calibration
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9380;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=cXG/R3iK8ET2AJqQpTOCo9ElRAQZ22TPBNWduqK/wxU=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgQOPeinElJZJ516sxcvpSdNjJ7c40EVa/3HOy8J7Jlr
 vlzd5OOjlIWBjEuBlkxRZa6xAiT0NuhUsoLGGfDzGFlAhnCwMUpABM5fpyR4ZzM2nUhizrXq6/I
 b66UYdm+dNZ2vS6vw/6uP0v2rOHJ/8/w32WqVMfs2Mg7+438fOznL/9nqHvpH6fk1Ec7A3auMzg
 exQMA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for offset and phase calibration, only for
devices that support software mode, that are:

ad7606b
ad7606c-16
ad7606c-18

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |   9 +++
 2 files changed, 169 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ad5e6b5e1d5d2edc7f8ac7ed9a8a4e6e43827b85..ec063dd4a67eb94610c41c473e2d8040c91974cf 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -95,6 +95,22 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
+static const int ad7606_calib_offset_avail[3] = {
+	-128, 1, 127,
+};
+
+static const int ad7606c_18bit_calib_offset_avail[3] = {
+	-512, 4, 511,
+};
+
+static const int ad7606b_calib_phase_avail[][2] = {
+	{ 0, 0 }, { 0, 1250 }, { 0, 318750 },
+};
+
+static const int ad7606c_calib_phase_avail[][2] = {
+	{ 0, 0 }, { 0, 1000 }, { 0, 255000 },
+};
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan);
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
@@ -164,6 +180,8 @@ const struct ad7606_chip_info ad7606b_info = {
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_offset_avail = ad7606_calib_offset_avail,
+	.calib_phase_avail = ad7606b_calib_phase_avail,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
@@ -177,6 +195,8 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_offset_avail = ad7606_calib_offset_avail,
+	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
@@ -226,6 +246,8 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
+	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
@@ -683,6 +705,40 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	return ret;
 }
 
+static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int *val)
+{
+	int ret;
+
+	ret = st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
+	if (ret < 0)
+		return ret;
+
+	*val = st->chip_info->calib_offset_avail[0] +
+		ret * st->chip_info->calib_offset_avail[1];
+
+	return 0;
+}
+
+static int ad7606_get_calib_phase(struct ad7606_state *st, int ch, int *val,
+				  int *val2)
+{
+	int ret;
+
+	ret = st->bops->reg_read(st, AD7606_CALIB_PHASE(ch));
+	if (ret < 0)
+		return ret;
+
+	*val = 0;
+
+	/*
+	 * ad7606b: phase delay from 0 to 318.75 μs in steps of 1.25 μs.
+	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
+	 */
+	*val2 = ret * st->chip_info->calib_phase_avail[1][1];
+
+	return 0;
+}
+
 static int ad7606_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -717,6 +773,22 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
 		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_get_calib_offset(st, chan->scan_index, val);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBPHASE_DELAY:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_get_calib_phase(st, chan->scan_index, val, val2);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT_PLUS_NANO;
 	}
 	return -EINVAL;
 }
@@ -767,6 +839,64 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 	return 0;
 }
 
+static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int val)
+{
+	int start_val, step_val, stop_val;
+
+	start_val = st->chip_info->calib_offset_avail[0];
+	step_val = st->chip_info->calib_offset_avail[1];
+	stop_val = st->chip_info->calib_offset_avail[2];
+
+	if (val < start_val || val > stop_val)
+		return -EINVAL;
+
+	val += start_val;
+	val /= step_val;
+
+	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);
+}
+
+static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int val,
+				  int val2)
+{
+	int wreg, start_ns, step_ns, stop_ns;
+
+	if (val != 0)
+		return -EINVAL;
+
+	start_ns = st->chip_info->calib_phase_avail[0][1];
+	step_ns = st->chip_info->calib_phase_avail[1][1];
+	stop_ns = st->chip_info->calib_phase_avail[2][1];
+
+	/*
+	 * ad7606b: phase dielay from 0 to 318.75 μs in steps of 1.25 μs.
+	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
+	 */
+	if (val2 < start_ns || val2 > stop_ns)
+			return -EINVAL;
+
+	wreg = val2 / step_ns;
+
+	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
+}
+
+static int ad7606_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBPHASE_DELAY:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -820,6 +950,18 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 && val2 != 0)
 			return -EINVAL;
 		return ad7606_set_sampling_freq(st, val);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_set_calib_offset(st, chan->scan_index, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_CALIBPHASE_DELAY:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_set_calib_phase(st, chan->scan_index, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -998,6 +1140,14 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = st->chip_info->calib_offset_avail;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBPHASE_DELAY:
+		*vals = (const int *)st->chip_info->calib_phase_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_RANGE;
 	}
 	return -EINVAL;
 }
@@ -1060,6 +1210,7 @@ static const struct iio_info ad7606_info_sw_mode = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.read_avail = &ad7606_read_avail,
+	.write_raw_get_fmt = ad7606_write_raw_get_fmt,
 	.debugfs_reg_access = &ad7606_reg_access,
 	.validate_trigger = &ad7606_validate_trigger,
 	.update_scan_mode = &ad7606_update_scan_mode,
@@ -1252,6 +1403,15 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 			chan->info_mask_separate_available |=
 				BIT(IIO_CHAN_INFO_SCALE);
 
+			if (st->chip_info->calib_offset_avail) {
+				chan->info_mask_separate |=
+					BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					BIT(IIO_CHAN_INFO_CALIBPHASE_DELAY);
+				chan->info_mask_separate_available |=
+					BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					BIT(IIO_CHAN_INFO_CALIBPHASE_DELAY);
+			}
+
 			/*
 			 * All chips with software mode support oversampling,
 			 * so we skip the oversampling_available check. And the
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 89d49551eaf515bab9706c12bff056dfcb707b67..4c39de36154ffb80dfbb01bb4f812826bdc55967 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,6 +40,11 @@
 #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
 #define AD7606_OS_MODE			0x08
 
+#define AD7606_CALIB_GAIN(ch)		(0x09 + (ch))
+#define AD7606_CALIB_GAIN_MASK		GENMASK(5, 0)
+#define AD7606_CALIB_OFFSET(ch)		(0x11 + (ch))
+#define AD7606_CALIB_PHASE(ch)		(0x19 + (ch))
+
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
@@ -61,6 +66,8 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  * @offload_storagebits: storage bits used by the offload hw implementation
+ * @calib_offset_avail: pointer to offset calibration range/limits array
+ * @calib_phase_avail:  pointer to phase calibration range/limits array
  */
 struct ad7606_chip_info {
 	unsigned int			max_samplerate;
@@ -74,6 +81,8 @@ struct ad7606_chip_info {
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
 	u8				offload_storagebits;
+	const int			*calib_offset_avail;
+	const int			(*calib_phase_avail)[2];
 };
 
 /**

-- 
2.49.0


