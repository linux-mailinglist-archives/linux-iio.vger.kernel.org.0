Return-Path: <linux-iio+bounces-3908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F4890C5A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 22:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641721C28A7F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4EB136E2D;
	Thu, 28 Mar 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nUdD/skX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6513A3FF
	for <linux-iio@vger.kernel.org>; Thu, 28 Mar 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660630; cv=none; b=dPop3lXucrlK+zwxUlasMhlnd1KB0vYhf+KaNNvT+IQagMbAbdtzCJcNcP3SBrwXtG9DEkmknpRLJPhpkMIn9yygsqyXS8qGFedjlEyGMZterNTrQFWiORZkFvPalhb/HJ8bqmRP4as8dXJT2qtXWVLjXmeYlSElbPe2upR8XNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660630; c=relaxed/simple;
	bh=R9tvs0YEbLb0IcFKPyCsYPU6XePRpPjzPOoYnJ+tx4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZQimgJ+JI8XHjZrJhUA4bOkLLGxEz/ykcZYNt7vZGSBL4jxtsW3mtxDyZSDqRLOpaPl15PnT7SQaokVoXtRqtQPNteXnUAPNtzGGJDMmETBmWjT8dO9GtewBrPWlCInIBKzM8cH/vVZMwmdjFx3wDTyaD4fkNAtdZLEQpLvslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nUdD/skX; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-229a90b7aa9so712713fac.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Mar 2024 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711660627; x=1712265427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3A5gu7uqa4mwgO3Pcy/PGFp7hCbrmNXtdjALJmM9qE=;
        b=nUdD/skX4uKCeVM+X3AF+uhi9nBzhS1xMbcV6/zrYddC0lLf4pv1f3RreEiWqodev0
         sOK2kQSEzwje6mliJLQpgntOId/6fXPO8o8xWziZQah8JbTUEHyqgU/M8kYOvAHJlHoQ
         770x34G1tAOyODyN40TOIsJnOsrc806diEqxz5UqQYglzw8yZ07L1W0j2ABPRG0BdIf9
         +D25mA4vEUWby1GpJUjD9kzMh0QYuqyd43liLOOdg1nlaDrlpYdVFz+nNPqhyiaGvjvp
         lPU3ABDikwIez0bELh2U6k/B4ABPUOIpUJnWylWjqFTJLkA+xY45LRo0EYO4yBi4813/
         nYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660627; x=1712265427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3A5gu7uqa4mwgO3Pcy/PGFp7hCbrmNXtdjALJmM9qE=;
        b=OxyxH+deY+ifmRSsv3j5vLZEPycF/OG/elPUirgaBSxbVgMhZH6R8I+72tFaWIWV/M
         z4XxLZyyeFzlTG6Q+sCxyAZ2sa3MPUyDSpMfTPNrBXwvjCYPg1L+O4cPiVnCwzVL5PFQ
         PQ/+2vVY+HRfp08BdcnrPqGfbgf4PFbv4rnjfc4uVfqZXBKPnIH1h/q5CFsB5VHLytTj
         PfJ5VlScdBM/f6pIlbjNLkFATVo10SuYPdlthShCvvfW8iu5AqVhQrtPWYVPaQ06KVYO
         +BlpmEsLJYpdoHS2W7deena/7cktBSnor3zcVGQZcCz8y42YNrPTYEWIhzybHIHb0yAM
         wiUw==
X-Forwarded-Encrypted: i=1; AJvYcCUkOEkGDiTAUmltDbk+7k/7HmriLCsIsAmjnfFgk4FSeYGKkx/HYoQvpi4E8WNnlm97xrWFVg/j7wOP8r5RARLnyggkPfJR0AoZ
X-Gm-Message-State: AOJu0YzUoBoEkaOgKKZr9cLfhiSSx85xh2WEHE4z7zp1zf9DWKa1Dniq
	1a7x0J5viRO8P6MrXRh+zPgZpoOW00ee+yS+mRhPnqoI5QO+PyXQ5F9vAd582F8=
X-Google-Smtp-Source: AGHT+IEVJ8YJ4y66ExO7KPduVCi8GbCu6OnRINivNLND7nZBQCBwHlfk0bY8nUUZ8FhSx7jFoj+V1w==
X-Received: by 2002:a05:6870:e983:b0:22d:f675:d525 with SMTP id r3-20020a056870e98300b0022df675d525mr310840oao.48.1711660627305;
        Thu, 28 Mar 2024 14:17:07 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ny21-20020a056871751500b00221df0eb6f9sm577360oac.28.2024.03.28.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:17:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: ad7944: use spi_optimize_message()
Date: Thu, 28 Mar 2024 16:16:59 -0500
Message-ID: <20240328-ad7944-spi-optimize-message-v2-1-a142b2576379@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This modifies the ad7944 driver to use spi_optimize_message() to reduce
CPU usage and increase the max sample rate by avoiding repeating
validation of the spi message on each transfer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Fix wrong array index in ad7944_3wire_cs_mode_init_msg()
- Fixed wrong number of xfers in ad7944_4wire_mode_init_msg()
- Link to v1: https://lore.kernel.org/r/20240325-ad7944-spi-optimize-message-v1-1-cded69b9e27f@baylibre.com
---
 drivers/iio/adc/ad7944.c | 177 +++++++++++++++++++++++++++--------------------
 1 file changed, 103 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 261a3f645fd8..e09ab0c842d3 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -51,6 +51,8 @@ static const char * const ad7944_spi_modes[] = {
 struct ad7944_adc {
 	struct spi_device *spi;
 	enum ad7944_spi_mode spi_mode;
+	struct spi_transfer xfers[3];
+	struct spi_message msg;
 	/* Chip-specific timing specifications. */
 	const struct ad7944_timing_spec *timing_spec;
 	/* GPIO connected to CNV pin. */
@@ -130,6 +132,88 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
 /* fully differential */
 AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 
+static void ad7944_unoptimize_msg(void *msg)
+{
+	spi_unoptimize_message(msg);
+}
+
+static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
+					 const struct iio_chan_spec *chan)
+{
+	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
+						   : adc->timing_spec->conv_ns;
+	struct spi_transfer *xfers = adc->xfers;
+	int ret;
+
+	/*
+	 * NB: can get better performance from some SPI controllers if we use
+	 * the same bits_per_word in every transfer.
+	 */
+	xfers[0].bits_per_word = chan->scan_type.realbits;
+	/*
+	 * CS is tied to CNV and we need a low to high transition to start the
+	 * conversion, so place CNV low for t_QUIET to prepare for this.
+	 */
+	xfers[0].delay.value = T_QUIET_NS;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	/*
+	 * CS has to be high for full conversion time to avoid triggering the
+	 * busy indication.
+	 */
+	xfers[1].cs_off = 1;
+	xfers[1].delay.value = t_conv_ns;
+	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
+	xfers[1].bits_per_word = chan->scan_type.realbits;
+
+	/* Then we can read the data during the acquisition phase */
+	xfers[2].rx_buf = &adc->sample.raw;
+	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[2].bits_per_word = chan->scan_type.realbits;
+
+	spi_message_init_with_transfers(&adc->msg, xfers, 3);
+
+	ret = spi_optimize_message(adc->spi, &adc->msg);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+}
+
+static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
+				      const struct iio_chan_spec *chan)
+{
+	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
+						   : adc->timing_spec->conv_ns;
+	struct spi_transfer *xfers = adc->xfers;
+	int ret;
+
+	/*
+	 * NB: can get better performance from some SPI controllers if we use
+	 * the same bits_per_word in every transfer.
+	 */
+	xfers[0].bits_per_word = chan->scan_type.realbits;
+	/*
+	 * CS has to be high for full conversion time to avoid triggering the
+	 * busy indication.
+	 */
+	xfers[0].cs_off = 1;
+	xfers[0].delay.value = t_conv_ns;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	xfers[1].rx_buf = &adc->sample.raw;
+	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].bits_per_word = chan->scan_type.realbits;
+
+	spi_message_init_with_transfers(&adc->msg, xfers, 2);
+
+	ret = spi_optimize_message(adc->spi, &adc->msg);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+}
+
 /*
  * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
  *                                   acquisition
@@ -145,48 +229,7 @@ AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
 					   const struct iio_chan_spec *chan)
 {
-	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
-						   : adc->timing_spec->conv_ns;
-	struct spi_transfer xfers[] = {
-		{
-			/*
-			 * NB: can get better performance from some SPI
-			 * controllers if we use the same bits_per_word
-			 * in every transfer.
-			 */
-			.bits_per_word = chan->scan_type.realbits,
-			/*
-			 * CS is tied to CNV and we need a low to high
-			 * transition to start the conversion, so place CNV
-			 * low for t_QUIET to prepare for this.
-			 */
-			.delay = {
-				.value = T_QUIET_NS,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-
-		},
-		{
-			.bits_per_word = chan->scan_type.realbits,
-			/*
-			 * CS has to be high for full conversion time to avoid
-			 * triggering the busy indication.
-			 */
-			.cs_off = 1,
-			.delay = {
-				.value = t_conv_ns,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-		},
-		{
-			/* Then we can read the data during the acquisition phase */
-			.rx_buf = &adc->sample.raw,
-			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
-			.bits_per_word = chan->scan_type.realbits,
-		},
-	};
-
-	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
+	return spi_sync(adc->spi, &adc->msg);
 }
 
 /*
@@ -200,33 +243,6 @@ static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
 static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
 					const struct iio_chan_spec *chan)
 {
-	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
-						   : adc->timing_spec->conv_ns;
-	struct spi_transfer xfers[] = {
-		{
-			/*
-			 * NB: can get better performance from some SPI
-			 * controllers if we use the same bits_per_word
-			 * in every transfer.
-			 */
-			.bits_per_word = chan->scan_type.realbits,
-			/*
-			 * CS has to be high for full conversion time to avoid
-			 * triggering the busy indication.
-			 */
-			.cs_off = 1,
-			.delay = {
-				.value = t_conv_ns,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-
-		},
-		{
-			.rx_buf = &adc->sample.raw,
-			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
-			.bits_per_word = chan->scan_type.realbits,
-		},
-	};
 	int ret;
 
 	/*
@@ -234,7 +250,7 @@ static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
 	 * and acquisition process.
 	 */
 	gpiod_set_value_cansleep(adc->cnv, 1);
-	ret = spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
+	ret = spi_sync(adc->spi, &adc->msg);
 	gpiod_set_value_cansleep(adc->cnv, 0);
 
 	return ret;
@@ -395,10 +411,6 @@ static int ad7944_probe(struct spi_device *spi)
 		adc->spi_mode = ret;
 	}
 
-	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
-		return dev_err_probe(dev, -EINVAL,
-				     "chain mode is not implemented\n");
-
 	/*
 	 * Some chips use unusual word sizes, so check now instead of waiting
 	 * for the first xfer.
@@ -491,6 +503,23 @@ static int ad7944_probe(struct spi_device *spi)
 		return dev_err_probe(dev, -EINVAL,
 			"cannot have both chain mode and always turbo\n");
 
+	switch (adc->spi_mode) {
+	case AD7944_SPI_MODE_DEFAULT:
+		ret = ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
+		if (ret)
+			return ret;
+
+		break;
+	case AD7944_SPI_MODE_SINGLE:
+		ret = ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
+		if (ret)
+			return ret;
+
+		break;
+	case AD7944_SPI_MODE_CHAIN:
+		return dev_err_probe(dev, -EINVAL, "chain mode is not implemented\n");
+	}
+
 	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7944_iio_info;

---
base-commit: 526f7f17b651c78ead26fea7cea20948c00e47a5
change-id: 20240325-ad7944-spi-optimize-message-82debaa2a5a7

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


