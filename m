Return-Path: <linux-iio+bounces-20189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D1ACC94E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688451634F1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC1923BF9C;
	Tue,  3 Jun 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V4sISict"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D423A9B3
	for <linux-iio@vger.kernel.org>; Tue,  3 Jun 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961482; cv=none; b=ltbZlmo4yX3wKWXlouknce2PQ6QDPvYcoHjnucvDielKdQAOFabTc1yosGAChhzMVftE7HkJ9khyzyPACoiKKwP6M1+V9Xa4dYY1xCVrn3vQeXrAtTtn3iaIjNEbRvl1NEVyOQz3gaTtoWq52/gHOFU/wjV03HFoMIR1BMlWTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961482; c=relaxed/simple;
	bh=2azLLT6Wl9lmdAY2gUDc3q4we51Qw8kCL+zkngW3kNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZI/INW/shC7fc1T2tR4qT0qKShTzANV9twWffZHFN8M4Lt8+6A2PiOT1/xY7HoEWqGTxeHpZaBsBQe1dPSOvQ3yBGswxCVoMhD1ZPdnb7H0PAHANZSRr0UE2Jn10nMnfPPXVf2LVwOL68uL6qivNJqhF+J+PImidjNROrK9UMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V4sISict; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d3f72391so37918685e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748961477; x=1749566277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMvWRztU2bT3jdc78LuAKwUny9eARoeuG/PTskSOq+A=;
        b=V4sISictPhPUni4wpLDdc9FYrcEtDgWxQiTMbPaTvtYPR1zJk/Leia3lmM+uh5kUKh
         joeRhNWq2YNeseVgTJaFY5krSisor0RP0su+JZrCMW+8zG/jPY8paGsRjy55DbRyclXC
         MSA0j1YIRu7PlIQ+LvDkO8VAhkSxfQxlAbxMHZrjoeizLvl9C6GbtnICkjF8mRogIr5H
         Y0+QVjKWMU+yblFuxL118DhLO/UN/rsgbB9D6EQ80WIX3BBVV0cC0unM1htM6FiH5xHJ
         n3RTDajeD2G9FVwMQ8eNNjBzkdnioub5bOYvpHEULdCpw/2FPsbGQFr9wQbGYYJ21t07
         satA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961477; x=1749566277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMvWRztU2bT3jdc78LuAKwUny9eARoeuG/PTskSOq+A=;
        b=jZnyBd7hYYGiZHBcGNPR2QZTk8th22OzcIl6DHqrydpOsJfWajYcm2QiejxzvWqTSK
         tRlU0BsmLFFBRceufKdtCMc5wRnp8GjtbAj8QX+r0hVzcZD0DTS4loB/3U5Z4wIp0OuF
         ypu0jtB5tdcAhOjpOy6fp42mN+Yv6G1bElOQxEgPID4Cey2nYPhjMpmar5Y3VCtIS9rT
         wcRRNW+Hn9FICZ4nLeUlNXOh5wve82CTCXnuF/NwdR/QdQy2bo0stKmahgTgnmUIOARN
         v9vjegYtbghSa1HhY2Jx8OVjkojRoS1o0wbZWZbF4D6FdETpdiFTunX35nVflxS2N+cJ
         LFww==
X-Gm-Message-State: AOJu0Yycyb4RoyjCv+K6TT66ReAykZH3G2CelxcdJ4dVa0ogfo8TWgwc
	YBMu0xSgjxLYzcJwPXx+kM/wnqQRSLW76g45XcjqtRoO/AftAg7bTM1AuLj5skAxq3o=
X-Gm-Gg: ASbGncsIsXd/jjHLN9wZqRW2zijird1M1FXK3hIVvnGYfzJH15FV1Wc++FBWmxH5tyr
	kceEJ3ZxcFkKe7cabfn5eh8Pf+uof8/FJAhZZM3OvKR7ZFJQT1mmKrTZvky7UqtbvSe80g4Zvqr
	dg+Urn2ymk6W4yVoiweRlZJBW+68VtZ7+YcpuFAcnC92U1rRfA4UCWrrj1D53r2OYoAS7L95NJT
	9/Ftx9cHtMv4NkAjid0RE41xgfA4ZvLteIegM1rjshdRxL+tipr11+SQm+QwZqD1fN5GcX/Ztb/
	pgMedSR9nfILopjENmZHLoWPgP3UHZDNqv6AYl1RyoOR8pGr6cota6sWBURG7joZzQ928cFIP6V
	dLKbjXHEcq3RKQTO9dhQSHwNBFh7/NPcUSq8=
X-Google-Smtp-Source: AGHT+IGb/oH1H/ucPYo01Wkv7/3C428zLK1Dr9TJgPfvzBJ23bdx0xSfNz9vjbYwUsq6HpqO/ytSzQ==
X-Received: by 2002:a05:600c:3b10:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-450d885e485mr178692375e9.17.1748961476999;
        Tue, 03 Jun 2025 07:37:56 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f1afebsm164430945e9.0.2025.06.03.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:37:56 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 03 Jun 2025 16:36:25 +0200
Subject: [PATCH v8 3/6] iio: adc: ad7606: add offset and phase calibration
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-wip-bl-ad7606-calibration-v8-3-2371e7108f32@baylibre.com>
References: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
In-Reply-To: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9455;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=m8KvlzK04oJDHf4rtyOO7VisfkGK5WgMZB7GZsUOf6s=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiw56iIuJJWyTf3dUVMQOqfxV9PHfBdvcewRm3housGw
 mU25XeSO0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAEzkei0jw8Ebx6O3mD9r+Pb3
 yjG7m/G7rc3Wp59NC11yYV2ccKoX12yGfzpVTvzJCfMY1mjtuP9qgoZ56qelxosaG80OdW5u+zn
 1MR8A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for offset and phase calibration, only for
devices that support software mode, that are:

ad7606b
ad7606c-16
ad7606c-18

Tested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |   9 +++
 2 files changed, 169 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 185243dee86ed2e9ebc43b578003d0c010e97a9f..9a9bef0cfbb37138f71ba5b1babeaa423eaf4d5a 100644
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
+	-512, 4, 508,
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
 
@@ -681,6 +703,40 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
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
+	       ret * st->chip_info->calib_offset_avail[1];
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
@@ -715,6 +771,22 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
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
+	case IIO_CHAN_INFO_CONVDELAY:
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
@@ -765,6 +837,64 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 	return 0;
 }
 
+static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int val)
+{
+	int start_val, step_val, stop_val;
+	int offset;
+
+	start_val = st->chip_info->calib_offset_avail[0];
+	step_val = st->chip_info->calib_offset_avail[1];
+	stop_val = st->chip_info->calib_offset_avail[2];
+
+	if (val < start_val || val > stop_val)
+		return -EINVAL;
+
+	offset = (val - start_val) / step_val;
+
+	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), offset);
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
+	 * ad7606b: phase delay from 0 to 318.75 μs in steps of 1.25 μs.
+	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
+	 */
+	if (val2 < start_ns || val2 > stop_ns)
+		return -EINVAL;
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
+	case IIO_CHAN_INFO_CONVDELAY:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -818,6 +948,18 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 && val2 != 0)
 			return -EINVAL;
 		return ad7606_set_sampling_freq(st, val);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_set_calib_offset(st, chan->scan_index, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_CONVDELAY:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_set_calib_phase(st, chan->scan_index, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -996,6 +1138,14 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = st->chip_info->calib_offset_avail;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CONVDELAY:
+		*vals = (const int *)st->chip_info->calib_phase_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_RANGE;
 	}
 	return -EINVAL;
 }
@@ -1058,6 +1208,7 @@ static const struct iio_info ad7606_info_sw_mode = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.read_avail = &ad7606_read_avail,
+	.write_raw_get_fmt = ad7606_write_raw_get_fmt,
 	.debugfs_reg_access = &ad7606_reg_access,
 	.validate_trigger = &ad7606_validate_trigger,
 	.update_scan_mode = &ad7606_update_scan_mode,
@@ -1250,6 +1401,15 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 			chan->info_mask_separate_available |=
 				BIT(IIO_CHAN_INFO_SCALE);
 
+			if (st->chip_info->calib_offset_avail) {
+				chan->info_mask_separate |=
+					BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					BIT(IIO_CHAN_INFO_CONVDELAY);
+				chan->info_mask_separate_available |=
+					BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					BIT(IIO_CHAN_INFO_CONVDELAY);
+			}
+
 			/*
 			 * All chips with software mode support oversampling,
 			 * so we skip the oversampling_available check. And the
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 441e62c521bcbea69b4f70bb2d55f65334d22276..f613583a7fa4095115b0b28e3f8e51cd32b93524 100644
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


