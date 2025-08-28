Return-Path: <linux-iio+bounces-23337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39983B3A6B4
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EB918874B9
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B931322778;
	Thu, 28 Aug 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Xsl4dkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F7326D54
	for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399367; cv=none; b=L/7ixpbcg1+VSiyBXlwiI6V6UzUQI2ZJA6jbdzm6yBgM67M9aZFYWvmYDD3Mq4WLohCWIWuGPV3mz9RAJsc1HYt71mkJ0/xFtnyxVnOVWpOtMMy0XV1FTKUqEc5sDfSeuR6NLPnyT5Qx7hvT/X/OPnAJ9482SPkmleR8R1CXSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399367; c=relaxed/simple;
	bh=iuA0XWSQzN3EGM6KPWoPiR1QVAFS6Z3SNXmmTvkJD6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E1YtclszZrDvlJ25XJPZllv16ub8bFxoPXTkGLPJaXHBDbtqmBTG3VPZ0Qo1//Vv2p0asHpd+Rcs/XXPeHOpJ7pW4GBVF7oDMPIW8gAzpMePQyFlT1PRuEcQzytCWZsW9uMkn8VcbigQq3KtP6jQPPDICqfVgA1NrZQcu7CjKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Xsl4dkO; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30ccec2515dso1019769fac.3
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756399363; x=1757004163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K6Shuflgt5tkdQc3aXskmyvjKHCg+il6Bxo1safNW3M=;
        b=3Xsl4dkOzBNzqTsD9mXcDzYW5IHASiKt2MuYxvsPNQ5RRE/+UCdFabely/PXq0Styl
         OUDQAl4yIgP7tlhuaqUwrFhXHKDfssJUMc2JFfWDnEB/GxAj1i2TsBO5vUZSCgXwmbsJ
         qqEoINVXo3DtIUHlgFzG9coDQ4igc8Z7LFDejmmyaRt1b37MqtE1zvTHjVosfaUg7EkS
         hH5A8NGr4Ej9dKBDwUJOOGRvXcuAuhkwub6PL3I+AYTSi3qOKK5eQvVj3/2ORe0AQ3Fa
         Pd1nSy2f9VdYIVtnbh0FKjlP6mFNvG9qRlA0BnuGY5jnIPrFtCSndmfQEhxWNl6yBcmm
         U8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399363; x=1757004163;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Shuflgt5tkdQc3aXskmyvjKHCg+il6Bxo1safNW3M=;
        b=YP2T075UNuh0erY5EMFVfCAIZc99G0MrEtQVQEEc3llangoOqK+TtSG8Lv6pspHT1w
         CYYx5XC6q8fcCLJq5Qmvnaw6dasgoJrw4lhqYb2dIVQhAlZ0ez0jJFepdrwnUlgeT3jW
         kboJruDelSENJErWhJI3lN5NAWPUaJmKjJeZjmsZtbjGY8N9/fQbnc5Ps9sGt4kRbD4z
         K280uPRRy653V/FDAumQVUq8I/LmovvZY5hp4ZGUWReWAtEK/986YjAUZ2BJE8DmRr86
         jsCpDnroN0kffm8KJy45+KoaAPEqW6VMsUAfgOM3u9E7bnQdX/XnSdGD8PxjASQ91Uvt
         1MUg==
X-Gm-Message-State: AOJu0YxBxmjQbp+JrNYANH/BdyeNvLCPF0/RG5oiTRGCrr+mCon9lEOW
	xMEsQcm4mHaKzGnhO/xO+ycqRpJxezBgzDBJ0joJQhRqFnhG1LkHvff08SQcqKtNdg0=
X-Gm-Gg: ASbGncscJ8MZx8e4H7hQHi+JSwvcSms/JtUUBP0XgeVUTZdJmrj5sZahPhUxAKf2I+v
	5IzijnHr8diAxOiiMDoYhUMhlsfxRnTMScdq2NqETbc0jHLmVVytxRHIeygdHg3eczWoMZo0A1F
	o5GjLPEZ3uwtu3Hp5+SOjJuPo41oTmJzIEfxzOzehhwyDgcDM9d4lF7/s3dtRBiVCJH2nmcN/Yn
	sKRiVz0Ps2dWtGcpswFIMpy48UR2cFYBcnbze3dGnGoaYFl/cggxjrUu/YPjGTFQ2TGEKalBfop
	we5PEoPQlgtJ6k1Mv1k2RxEw1o+9cJB2fDg0jkBOpMkoLxWqZqQFqY2FuWEDD9VIcD1TVDnXhhW
	fw+qVbCNsnRWWSH0WIkEMxWLSorH7bzkWCfdjsdI=
X-Google-Smtp-Source: AGHT+IFCeg7nbNtWsPGJyDZ7J/ZwlXb8NFpZluPTrsQHpG4xe11Fo0rDP1O0oCB1x+kTPSMtVwpiNQ==
X-Received: by 2002:a05:6870:f14a:b0:314:b635:d7ab with SMTP id 586e51a60fabf-314dce188b5mr12926969fac.45.1756399363224;
        Thu, 28 Aug 2025 09:42:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:aa84:2d2c:f28c:4102])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe64bbcsm94867fac.24.2025.08.28.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:42:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 28 Aug 2025 11:42:28 -0500
Subject: [PATCH] iio: adc: ad7124: fix sample rate for multi-channel use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPOGsGgC/yWN0QqDMAxFf0XyvKAWx4q/MnyoNXUB27q2ykD89
 2XzIYST5OQekCkxZeirAxLtnDkGgfZWgX2ZMBPyJAyqUfdGK43MEc1kpR6t6tDxB7PxK7pEb3Q
 xod+WwviTAy2oR6Vsp0ftbAPydE0kyj/wOVws4ia55RrCaDKhjd5z6Su5znUiH2VbS3QtvXCYY
 TjPL6ZWpyy8AAAA
X-Change-ID: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7043; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=iuA0XWSQzN3EGM6KPWoPiR1QVAFS6Z3SNXmmTvkJD6s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBosIb3EVyak2FzYf1MzN4AF5xF6QaHodpZ66T6K
 iNCx2tmiX2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLCG9wAKCRDCzCAB/wGP
 wFNyB/4pnCyX1bo8f4ZK8hWve4edLgqavR9yYMC5+ePgVWIoBkWP8HAB17Fobw6fSXYUPsERHmH
 VtPV1uiNXATo639seSGS5/bXVenmZcgJWcrhsy3CrFkM+p3+CpZFe2tW7oUYe/7v4Rles3oHiah
 BeJq0AVURWSFFaYeGDZTGvqbi6WaRULueaxoF7o5Dl/JgQBd4gqr7rrFYfsrao+sntdYRLhmLLE
 HqxKDkhEMVqg38AURWxG2vTyVyjYAc7y/zYwRG2I2w4WOLkpYXHOHoxo+dAzgZYpClghHqz7eh3
 TxplgsJtqOAHRHDxlcwt0iwyQe4SynPYqDUkIEGVJnmwHuZi
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

Technically, introducing the avg parameter is not needed at this time
since we currently only support a single filter mode which always has an
AVG value of 1. But it helps to show where the factor comes from in the
datasheet and will be used in the future when supporting additional
filter types.

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

I also have a plan to resolve things if we do find we broke someone and
need to revert the change. We have a recent devicetree fix [1] for these
chips that would allow us to detect "new" users using the correct DT
bindings and "old" users using the buggy bindings. So we could use this
as a way to also enable the old buggy sampling frequency behavior only
for "old" users while allowing "new" users to get the correct behavior.

[1] https://lore.kernel.org/linux-iio/20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com/
---
 drivers/iio/adc/ad7124.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3fc24f5fffc8f200c8656cb97f9e7f80546f688b..d75ef4d5de233c2a548c732b36440d0d82c86f34 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -84,10 +84,11 @@
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
@@ -250,9 +251,10 @@ static int ad7124_set_mode(struct ad_sigma_delta *sd,
 	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
 }
 
-static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
+static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel,
+				   unsigned int odr, unsigned int avg)
 {
-	unsigned int fclk, odr_sel_bits;
+	unsigned int fclk, factor, odr_sel_bits;
 
 	fclk = clk_get_rate(st->mclk);
 	/*
@@ -261,8 +263,12 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 	 * fCLK is the master clock frequency
 	 * FS[10:0] are the bits in the filter register
 	 * FS[10:0] can have a value from 1 to 2047
+	 * When multiple channels in the sequencer or the SINGLE_CYCLE bit is
+	 * or when certain filter modes are enabled, there is an extra factor
+	 * of (4 + AVG - 1) to allow for settling time.
 	 */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
+	factor = 32 * (4 + avg - 1);
+	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
 	if (odr_sel_bits < 1)
 		odr_sel_bits = 1;
 	else if (odr_sel_bits > 2047)
@@ -272,7 +278,8 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 		st->channels[channel].cfg.live = false;
 
 	/* fADC = fCLK / (FS[10:0] x 32) */
-	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
+	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
+								factor);
 	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
 }
 
@@ -406,9 +413,12 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
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
 
@@ -678,7 +688,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		ad7124_set_channel_odr(st, chan->address, val);
+		ad7124_set_channel_odr(st, chan->address, val, 1);
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		if (val != 0) {
@@ -1148,7 +1158,7 @@ static int ad7124_setup(struct ad7124_state *st)
 		 * regardless of the selected power mode. Round it up to 10 and
 		 * set all channels to this default value.
 		 */
-		ad7124_set_channel_odr(st, i, 10);
+		ad7124_set_channel_odr(st, i, 10, 1);
 	}
 
 	ad7124_disable_all(&st->sd);

---
base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
change-id: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


