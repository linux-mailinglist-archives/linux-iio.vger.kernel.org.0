Return-Path: <linux-iio+bounces-23719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DC3B4428D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 18:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4BA5A44B6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CC23278D;
	Thu,  4 Sep 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gOnlJOjf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562621FF47
	for <linux-iio@vger.kernel.org>; Thu,  4 Sep 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002816; cv=none; b=PLrX8Zi15PDC2/RnrqYaDdAXRg3QgxyRXtvQutP6BR1KteIf/VyQCNzoqdfbp3J+/8tll3SYLCE7+BbcQZzPcNakWiNJgetxeeMAXstm+UfavakOPU5VmEVDhGkl53wWbcayc6hAMFQvgkG8i19qNISaP98GkEx5bWLHhcJZRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002816; c=relaxed/simple;
	bh=oSrD5LZfhiTCWWEOnz+EwIH9Y5NWdWGaTMnBwoCG7LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=upIOyYJ3jjcCBDJ15LUBp9qtvHJxuODnu1nm4Te11URB9Kgz4/cAq3ago1qqD0cGOZ2pX3I5bXQ9in4U9RoxOoZdPWWytQlPlaFpAliTqdEpwEYOQxV7VDR6P0xHVJYj+lDkqOgp53dOQYVUnEZEf1+FvCIBBCWiVk9OPpDtYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gOnlJOjf; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61ff35a56d3so336791eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Sep 2025 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757002812; x=1757607612; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGm2zkf/9oCXstTLHB+DCMbzA3eLiIfoAHdNUhFK2K8=;
        b=gOnlJOjfjONbPz0q0HnXf4qwvbSXT+8YNugvlKekqUrl40SSjXMtKSr54zeV/7I77G
         VUxwwuqnDl2px3blUo6x08gDcHAVPV1tzUJ0p41+m7f/fvnE3o5nvoYcDU5bwB/NVbie
         pNEgkbf1yWtuiuF2ExilPaE+uvSMa3rTvbCz8bDgHaqccj8k2+FW8mqwP5Vm0P5ZyOmH
         v9PT08khsNHYGvDYEli1Sq14wxEwuE40KNohBsL8eDwK9AF43ndBuWSU513R6fvEkz+V
         MYIi9nPyCdfIUDyGbLMXDy1o/kwzxV8FDIEVwpx4UH6O1UX19Ak+znXTqKTsd3NDx1+I
         Gl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002812; x=1757607612;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGm2zkf/9oCXstTLHB+DCMbzA3eLiIfoAHdNUhFK2K8=;
        b=YZU+8eI15+Oxx49qe9lOO/7Z+t+EBbtnOiRcqVa5GjxIFqqgMR4sRcqPuWiLnE9UYM
         UW07NS9fpoknBDWM+0dwnSxsbigMpCcD8h9M0kpGWBgws0HurPksbODZ2Z8mCPGuaMSA
         TqCLcFNzZaQNs//7MAvaEqKHYyELNXXSOFkYGNhhOgeF198w7nchTMk4z4UopKhBeNxU
         WwrWBHIP0VxXEJJZ42aa5H5zVhaAeynVkKlTEG4fOagVNlCUsQLQFp7DFvxNvmBcdG9w
         SKGiPbbq8ylkThj9/Hxkf/mP9kwZmb3g7lDtUTTSFdJtSJhIypkIsXszfTNkvYoAM7ie
         KMuA==
X-Gm-Message-State: AOJu0YzWiCiL6hPHiIZzDLfdzrfMjHQC7DY3YC2FryF54QkJzXbQzjO/
	oklCvruu6mhdc/zLo9OWnlqsH0fSaQr1w5UjagJFLjplFfRnYFAlVVXZJzpLkxcXKIU=
X-Gm-Gg: ASbGncuqjLmcQa9JqKH90IULpR3svXHB94imGt/o+5ew3m2nTsE5gkPNjI3fzOb7uX3
	B3sq8aph/q7GyAMDXxqcSs5wpf5st/HH2wwQUhfeWrTrKKl3atLboooeMztagVB0BGAOEeA9NJ5
	f+Qxm1hqnZBDrXf5QopxBIyC3PJBKAhGUEAGXrmD9LweZGJzo2PUG4lc87i3a9mBMTosWYRt5im
	GNsEXBA0dHKjtRFslWEpFaeyDidcdXv4gXCs0aAs1vJ/KcG9ghHliTDAa+AIoa3RM7UpKLaMA+5
	nkj+8aQavlHTGTAS6ZgmOP3k8JbbSrNNpj4ooDq7Um9TO9G5rlqc0OzfsqDftstlvvNbOr05Q5x
	NmM+2+pU5K2Tl8sFGELnBwlcqFAaN
X-Google-Smtp-Source: AGHT+IHhgRzYKeua/z36tVDbnAK6UMOmH+rcUGmHZ+yOFWcr95caq9un7W7t88zd/ILCeK5ed3wrsg==
X-Received: by 2002:a05:6808:898b:b0:437:e7c1:7d91 with SMTP id 5614622812f47-437f7de1535mr9428497b6e.26.1757002812002;
        Thu, 04 Sep 2025 09:20:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61e357137d6sm1702491eaf.4.2025.09.04.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:20:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 04 Sep 2025 11:19:56 -0500
Subject: [PATCH v2] iio: adc: ad7124: fix sample rate for multi-channel use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACu8uWgC/52OQY6DMAxFr4K8Hg8QMTOhq96jYpEEp7VESJukq
 Kji7nXpDWZhWd/28/9PyJSYMhyqJyRaOHOcRaivCtzFzGdCHkWDatRPo5VG5ohmdFJ/rerQ8wO
 zCVf0iW7oY8JwnwrjG55pQm2Vcp222rsG5Ok1kSC74Wn4aAHv4ls+Q7AmE7oYApdDJde5ThSib
 GuxrqUXns/wZi+cS0zrnn1pd/i/MZcWW/R67FyvGvPb90dr1oltom+JAsO2bS9vpiiHKwEAAA=
 =
X-Change-ID: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7021; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=oSrD5LZfhiTCWWEOnz+EwIH9Y5NWdWGaTMnBwoCG7LU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoubw04FF7FjxOyiOLqlnRJiirNnSa/iFefbsQj
 8Dsx8UrZemJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLm8NAAKCRDCzCAB/wGP
 wCFxB/48z09RE0GdDD3DJl3cqac93uCpkK7NofoFaYT4P8luNZ9pUaA4MQtzkIkbzRfxSh3xko1
 wfA+4VZNjpMmZk74lgQ+z7wopr7tXyC0A4dKqEQHSo1fPE2dQFZP151pl8MtVVhpq/CNpIe6nUP
 oDFK5AJbm9afrWs8R1wwjRfFMi/tS9GgQwDfcxBsPStyR6f04hGvOe9LIFpkHQwZxJ3iaXwNxTa
 aN1MbgQL5IGJUjZz0dW1jM0wlRc9stVGTvi/8C94LWVWlBePp28D2DgFL1l1fNHuSFwyzsY04Dz
 fiEl1t8rjvRNqoCATAiOH+HX7H+ZVsBhXe4p+Tx4X5BlElRj
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

    fADC = fCLK / (FS[10:0] x 32 x (4 + AVG - 1))

where AVG depends on the filter type selected and the power mode.

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

Technically, the sincx+sinc1 filter modes can't currently be selected
so there is some temporarily dead code in ad7124_get_avg() until filter
support is added.

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
Changes in v2:
- Improved comment explaining why the new factor always applies.
- Fixed merge conflict with iio/testing branch.
- Replaced avg parameter with ad7124_get_avg() function.
- Link to v1: https://lore.kernel.org/r/20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com
---
 drivers/iio/adc/ad7124.c | 49 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c6435327d431e5f4ba28aa3332ec6eb90da7c83d..5121a4457feab0dd65766558b30c9f0c6e8d1bd4 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -93,10 +93,13 @@
 #define AD7124_CONFIG_PGA		GENMASK(2, 0)
 
 /* AD7124_FILTER_X */
-#define AD7124_FILTER_FS		GENMASK(10, 0)
 #define AD7124_FILTER_FILTER		GENMASK(23, 21)
 #define AD7124_FILTER_FILTER_SINC4		0
 #define AD7124_FILTER_FILTER_SINC3		2
+#define AD7124_FILTER_FILTER_SINC4_SINC1	4
+#define AD7124_FILTER_FILTER_SINC3_SINC1	5
+#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
+#define AD7124_FILTER_FS		GENMASK(10, 0)
 
 #define AD7124_MAX_CONFIGS	8
 #define AD7124_MAX_CHANNELS	16
@@ -283,11 +286,36 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
 	return fclk_hz;
 }
 
+static int ad7124_get_avg(struct ad7124_state *st, unsigned int channel)
+{
+	/*
+	 * The number of averaged samples depends on the selected filter and
+	 * the current power mode.
+	 */
+	switch (st->channels[channel].cfg.filter_type) {
+	case AD7124_FILTER_FILTER_SINC4_SINC1:
+	case AD7124_FILTER_FILTER_SINC3_SINC1: {
+		enum ad7124_power_mode power_mode =
+			FIELD_GET(AD7124_ADC_CONTROL_POWER_MODE, st->adc_control);
+
+		switch (power_mode) {
+		case AD7124_LOW_POWER:
+			return 8;
+		default:
+			return 16;
+		}
+	}
+	default:
+		return 1;
+	}
+}
+
 static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
 {
-	unsigned int fclk, odr_sel_bits;
+	unsigned int fclk, avg, factor, odr_sel_bits;
 
 	fclk = ad7124_get_fclk_hz(st);
+	avg = ad7124_get_avg(st, channel);
 
 	/*
 	 * FS[10:0] = fCLK / (fADC x 32) where:
@@ -295,8 +323,15 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 	 * fCLK is the master clock frequency
 	 * FS[10:0] are the bits in the filter register
 	 * FS[10:0] can have a value from 1 to 2047
+	 * When multiple channels are enabled in the sequencer, the SINGLE_CYCLE
+	 * bit is set and only one channel is enabled in the sequencer, or when
+	 * a fast settling filter mode is enabled on any channel, there is an
+	 * extra factor of (4 + AVG - 1) on all channels to allow for settling
+	 * time. We ensure that at least one of these is always true so that we
+	 * always use the same factor.
 	 */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
+	factor = 32 * (4 + avg - 1);
+	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
 	if (odr_sel_bits < 1)
 		odr_sel_bits = 1;
 	else if (odr_sel_bits > 2047)
@@ -306,7 +341,8 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 		st->channels[channel].cfg.live = false;
 
 	/* fADC = fCLK / (FS[10:0] x 32) */
-	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
+	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
+								factor);
 	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
 }
 
@@ -440,9 +476,12 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 		return ret;
 
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
base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
change-id: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


