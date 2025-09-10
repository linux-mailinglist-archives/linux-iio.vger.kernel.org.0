Return-Path: <linux-iio+bounces-23951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37873B51F07
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C317A84FF
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089E31D738;
	Wed, 10 Sep 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O1M5Dfoi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429413774D
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525634; cv=none; b=Rq3EyxE+LIMXMEtLDn9Gno4Pz+eMH9iUSYRj6N19SzAsdmf9XJhlR4/LdNuYHMz0RVruXFpwGrfS5jqMrRjMFYcCabDoY0zV66s5/1BPb4EHH6okrIFolu5H4OtaCo8G+aSpgmKzl1p2J4rklfs1ywehO1RVvP3yGeoVgv/RFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525634; c=relaxed/simple;
	bh=J7gB9Z38NODsqaTbWLcs+XK+Ps9YUEGTomCZhU0fQzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SglJlMHpbMhVwu3xPXCaH8gZD5QYWO3bzKiTps9u5Zq6NRrsgfLvAJdCHMLLG3tOJtvHMipuHgh0O3EvSwbrMfi9zDGlyh9Bhp5VGA1IDnsv1f06scTwXTIJaWfST1sRgAKDujshkyRlCTps9fW+hdFFNqHJubX1L4imONudxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O1M5Dfoi; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74ed00220f6so1341343a34.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757525630; x=1758130430; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N2Xb0Z0taUQW7f25FPwYUA0qCuGXG5HY2O077HuGpHw=;
        b=O1M5DfoiH4mWWsM1R7bHUE/6yKrICeoAFNGKikfxhdWD2oE3dR9KIZc+1sL/wibFkw
         h1DVUOnLpMIKTrUE+EP8kdIdteD2bgC86JVe2mLigfKI5hJecLwg+RpqCjSHJ2nlVeRK
         oTvAZrnGK4h2AZjpvcJe5lYvusLIyzO2QrBDlbOqud+8SmlVOIjQgOfpYr7MjcOPCpmy
         cK8taW2EbCnvhgkO+Fph1VQlRE4VKj8MYrjZz3/Cvla9L6flHaxdobwMIbcen+qJg6rC
         mlV1S8cE2bYD+lDqdo8U71uGw+6XuuVPi+GioUp1N1vSrUf8CcntKH2iOTna4mPzZ9Js
         Jjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757525630; x=1758130430;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2Xb0Z0taUQW7f25FPwYUA0qCuGXG5HY2O077HuGpHw=;
        b=VpVf0ElXFDyaOUlpbW57VhqB4BFkiMHig0pBukWx/cfnu/mnWeesUV/KaG0oOUpdk4
         9zwpM4ltn9MvZOAptaC59noDlFjTRtCghiAZjo92yrHftOA6rtyRTRCRbuFA+Wjf1+SU
         ysVLqgua8mvIu4q0UVy18gfyHniGL0snkD3c8Xa4v/g1gw7WIR8rgwuLFcYohvRBFVO6
         CvMKWhHwVAH4e3ltzsZ6cnEmEcgP46G0aa263PhxFM8m1NqrEEV4y0kcDe9RKUXlUASj
         riDyGZgYhsYodbNZQcInhVzKDSjQfW9UYJ5M3501J48jS0wSkzOBXFxm9hykGJ1Jz9p2
         tLEA==
X-Gm-Message-State: AOJu0YzXzKlk3OGMGa5Q6kHPTiqNm2PiorxFAlCzg7JWrAsHWA7ZkStu
	NhzP+tVH53usNtJW4htsXt7SdqSKWUeXxULKOsI6InPnz/klQv/peQ38riAqBkhYMAl8/XhIGEx
	uk/YW
X-Gm-Gg: ASbGnctnppr2q8CRGtii8I729+wk2imTnCnYcnV3Jp5X4L533y/6fzK+mU7SGjmQQLx
	ZbQC/IDFpEDSB+rZj84wvnjDlJX8MUuzPuCQA9jOas1bE3/YUwGYVCNas1pRMx9+VDlSlskZORi
	GJw+Wgw5rH9MfV9WwktnH4QxDr1yG7NZUsdbXt/BvB8dq1/IhoAjhIx8wLLw0g5JvZK769mL6hs
	aZfMCKo4L0iJsFgnNiAC2Ge4OU1T/Eg/0gHftugf79fTz2FOpBNWpn/Lra2UWVHtMs2SkWzIVfM
	0RDx+8JuIOLfl+3f8nNVwdWnMb84U/ES2frl6zMVQmmTcNSdvmwjscKjPF/DeOQDw7Pz3vYA1gz
	ehqzaQ53XXYbn+y29yfdypYrtXiM=
X-Google-Smtp-Source: AGHT+IHwxhIvt5PLXpTXwHQhyJxRLqO+skdbWcLPjSCafGejX4kGmiQpDD5IwbTqDvgaXQzUCem4EQ==
X-Received: by 2002:a05:6830:915:b0:746:d7f2:b735 with SMTP id 46e09a7af769-74c771b8c18mr7855259a34.27.1757525630221;
        Wed, 10 Sep 2025 10:33:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:21f9:be5b:476:1ae3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-746d6647459sm5540595a34.21.2025.09.10.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:33:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 10 Sep 2025 12:33:29 -0500
Subject: [PATCH v4] iio: adc: ad7124: fix sample rate for multi-channel use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v4-1-8ca624c6114c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGi2wWgC/53OQW7DIBAF0KtYrDs1EBKbrHqPqgvAQzKSbRJwr
 EaR796Js2hVdZMuEBrg8/5NFMyEReyrm8g4U6E08mBeKhGObjwgUMez0FJvZatbIErgusCrUdp
 ApE8objhBzHiGmDIMl34iuIdH7KH1WgfT+jYGKfjTU0aOrOD7x2Pm4IXd6XEovCsIIQ0DTfuKX
 5c645D4tma65n2i8SDu2SOVKeXr2n1Wa/i/NWcFCmLbmWC1dDtr37y79uQzvnKVVZv1t2CleVr
 QLHgfdZSdtQ26P4TNT2H7tLBhoZE6RqkMhp36JSzL8gX/uvRu7wEAAA==
X-Change-ID: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6666; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=J7gB9Z38NODsqaTbWLcs+XK+Ps9YUEGTomCZhU0fQzY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBowbZtkvd73eSOKh3OBWb5pmn1jnoYJXzTW9RFV
 JRLoFI7A9iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMG2bQAKCRDCzCAB/wGP
 wPIVB/462Rbel/ux9/NS+/FxKElSN5YgOSls+JEHcAdH4/Tn7eUsPgEoFnEyeyTYQma9bEYsuKy
 ZAfuJybYvJqi2B/pr3G5FG91xEap0dvvM6+b0noJGTt5XihLGyHGaucUsQMEOA7QoqosaFNPMnW
 5g2R96+X7WQrwNKlqYu4F39aJNyav3/KPkRdeSquHk1PNt8bEpby25mruuBeMOp2dAtwe5uJ0dX
 2ul3swB5ZarulPctOHIXnEC/hR+ZtxjQtAWd/tpHD3Ktr6ZiKf8y5oTgnvAGFysDLZbN7QQWH5a
 FoHvZYUY07X0TJcxHLfIaj9kPLYz37omFam03mmJn39P6j9k
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change how the FS[10:0] field of the FILTER register is calculated to
get consistent sample rates when only one channel is enabled vs when
multiple channels are enabled in a buffered read.

By default, the AD7124 allows larger sampling frequencies when only one
channel is enabled. It assumes that you will discard the first sample or
so to allow for settling time and then no additional settling time is
needed between samples because there is no multiplexing due to only one
channel being enabled. The conversion formula to convert between the
sampling frequency and the FS[10:0] field is:

    fADC = fCLK / (FS[10:0] x 32)

which is what the driver has been using.

On the other hand, when multiple channels are enabled, there is
additional settling time needed when switching between channels so the
calculation to convert between becomes:

    fADC = fCLK / (FS[10:0] x 32 x N)

where N depends on if SINGLE_CYCLE is set, the selected filter type and,
in some cases, the power mode.

The FILTER register has a SINGLE_CYCLE bit that can be set to force the
single channel case to use the same timing as the multi-channel case.

Before this change, the first formula was always used, so if all of the
in_voltageY_sampling_frequency attributes were set to 10 Hz, then doing
a buffered read with 1 channel enabled would result in the requested
sampling frequency of 10 Hz. But when more than one channel was
enabled, the actual sampling frequency would be 2.5 Hz per channel,
which is 1/4 of the requested frequency.

After this change, the SINGLE_CYCLE flag is now always enabled and the
multi-channel formula is now always used. This causes the sampling
frequency to be consistent regardless of the number of channels enabled.

For now, we are hard-coding N = 4 since the driver doesn't yet support
other filter types other than the default sinc4 filter.

The AD7124_FILTER_FS define is moved while we are touching this to
keep the bit fields in descending order to be consistent with the rest
of the file.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is one of those unfortunate cases where we are fixing a bug but we
risk breaking userspace that may be depending on the buggy behavior.

I intentionally didn't include a Fixes: tag for this reason.

Given some of the other shortcomings of this driver, like using an
integer IIO_CHAN_INFO_SAMP_FREQ value when it really needs to allow a
fractional values, it makes me hopeful that no one is caring too much
about the exact value of the sampling frequency. So I'm more willing
than I would normally be to take a risk on making this change.

[1] https://lore.kernel.org/linux-iio/20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com/
---
Changes in v4:
- Removed unused macros.
- Fixed typo in comment.
- Link to v3: https://lore.kernel.org/r/20250905-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v3-1-702ff014ec61@baylibre.com

Changes in v3:
- Removed the ad7124_get_avg() and harded-coded N = 4 for now.
- Link to v2: https://lore.kernel.org/r/20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com

Changes in v2:
- Improved comment explaining why the new factor always applies.
- Fixed merge conflict with iio/testing branch.
- Replaced avg parameter with ad7124_get_avg() function.
- Link to v1: https://lore.kernel.org/r/20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com
---
 drivers/iio/adc/ad7124.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c6435327d431e5f4ba28aa3332ec6eb90da7c83d..15d98b78ec2709e14c354a64f14e7deefc3bcb56 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -93,10 +93,11 @@
 #define AD7124_CONFIG_PGA		GENMASK(2, 0)
 
 /* AD7124_FILTER_X */
-#define AD7124_FILTER_FS		GENMASK(10, 0)
 #define AD7124_FILTER_FILTER		GENMASK(23, 21)
 #define AD7124_FILTER_FILTER_SINC4		0
 #define AD7124_FILTER_FILTER_SINC3		2
+#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
+#define AD7124_FILTER_FS		GENMASK(10, 0)
 
 #define AD7124_MAX_CONFIGS	8
 #define AD7124_MAX_CHANNELS	16
@@ -285,18 +286,20 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
 
 static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
 {
-	unsigned int fclk, odr_sel_bits;
+	unsigned int fclk, factor, odr_sel_bits;
 
 	fclk = ad7124_get_fclk_hz(st);
 
 	/*
-	 * FS[10:0] = fCLK / (fADC x 32) where:
+	 * FS[10:0] = fCLK / (fADC x 32 * N) where:
 	 * fADC is the output data rate
 	 * fCLK is the master clock frequency
+	 * N is number of conversions per sample (depends on filter type)
 	 * FS[10:0] are the bits in the filter register
 	 * FS[10:0] can have a value from 1 to 2047
 	 */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
+	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
+	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
 	if (odr_sel_bits < 1)
 		odr_sel_bits = 1;
 	else if (odr_sel_bits > 2047)
@@ -306,7 +309,8 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 		st->channels[channel].cfg.live = false;
 
 	/* fADC = fCLK / (FS[10:0] x 32) */
-	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
+	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
+								factor);
 	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
 }
 
@@ -439,10 +443,20 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * NB: AD7124_FILTER_SINGLE_CYCLE is always set so that we get the same
+	 * sampling frequency even when only one channel is enabled in a
+	 * buffered read. If it was not set, the N in ad7124_set_channel_odr()
+	 * would be 1 and we would get a faster sampling frequency than what
+	 * was requested.
+	 */
 	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
+		AD7124_FILTER_SINGLE_CYCLE |
 		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);
 	return ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot),
-				     AD7124_FILTER_FILTER | AD7124_FILTER_FS,
+				     AD7124_FILTER_FILTER |
+				     AD7124_FILTER_SINGLE_CYCLE |
+				     AD7124_FILTER_FS,
 				     tmp, 3);
 }
 

---
base-commit: b8902d55155cec7bd743dc1129e0b32e70b1751f
change-id: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


