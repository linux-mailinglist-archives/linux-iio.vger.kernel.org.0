Return-Path: <linux-iio+bounces-21207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC4AF05B4
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B355E44838B
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E68302CC7;
	Tue,  1 Jul 2025 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oSoQxzOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E3302058
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405976; cv=none; b=h0ZHchiSL4ViTUCjLTb3PYdg0ZPRJZSb1hR0XN8IwzBn+JzC6aPYtuE7mM7cXVQhVP9ukKqOiTGn+ogMZtMCT0JSmul/tmi26czESB38hbTDN2ErxKwCOhfa+wPRYjeDZwBXNTauZQUY5Xnp8GXBNHpcCU8nsvgvvonluBmJuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405976; c=relaxed/simple;
	bh=FtjSefgJ38MUOtssdwwTVZxqFU2P60mzs7S3a2VVXcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZYYRLbTkIb+XHkPqgL9cfaLBTOvF/wtFTH7nUxr2HTlWJHK0K5303QlJ9cd3LJoTx7iGPYcP3aPSwzkLCy6/Q3ImndhQoZuG327FAev1asm/udN7wzthTSmwT89L4tUAlAxdC54W/g5BkSdpgP/aLfw2kaMEklN4noIIz7gBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oSoQxzOf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40b32b6af9eso2821619b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405973; x=1752010773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL6Ufncylm91/QYr6Kod6l5M+E3FlraXlz8+iem4HYU=;
        b=oSoQxzOfIE8OiJfLxp0Unm2fJnkK9z2Um5LdSqijwmVkl05wJrSiCEAgM/NUJIeW9y
         xoxop4WsCqOslJY3KO5/lom3n3xx+C+uOIUIS36JV6+ErpMTqekwSWYs/lLsev5HCo7b
         WJBWGPiiQGGfRmDjKQBm+U+WwKi+mwHHscaYDy8CfwYYhVe41yI8Y1NTAe21uYxCjTML
         Jth4yQjlRPWzwAhkJG2h4sxxePdeUUnZKxteHKTbRx5Ko26AfBCNEGffIjv2c4RQK6pG
         9IgvhabQ0OOcDQD0RH61MIn8MuVnHjtrzQhCwIC5YbowBGagOHRDrFq1ITo9Lr/qa+Zb
         KPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405973; x=1752010773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL6Ufncylm91/QYr6Kod6l5M+E3FlraXlz8+iem4HYU=;
        b=lH+/AHgVyYVdGJ73dbBAwh2s5egot8BwwHKTBHFzQLBOhBi8SgXtoAmW6Mvov7PdM5
         dt/fKWop4iO0XFKN9SGFL5VfX9mrRiYTosj6OwQt0MNXhag1jubWJHnDmMlHU7jgh9bP
         5p0CRuTNvM5b5JTAP9rupHI8XM7pdj95twEyItqZ5vlU2Pv+BJwxcOi5qM6BcSY3SKkY
         PAcmdht99jQYQ65c6lUmT4i1WcFCRti38NxVe37KSlZrM+ny50yxtOFfON5RUL384oUA
         IgUynHgbqv3xowcwB9B4LMZNOjq9mJViNxKlkmpNomSYwhNcpGYjhNODZtBPLnv8My+0
         7yzQ==
X-Gm-Message-State: AOJu0YxYy3PiqSl0cMOS3xAt4rkTMMFJc7E0X/ObDJQWbq8E3eBMA/uV
	9uS8wytzh336lDwfB1a9Rr7LStxx6ER/8ym91eNoV4mkB+yIqJKNxUJ0Yp5m6yJjk9s=
X-Gm-Gg: ASbGncs69OOO55wlbNRMIvkc4vjocad/qE5wp+MA5qsqaBwl4q8CULIkXLvOGQRfnjZ
	HWl4p0NK/6Y3CI7lOev+8tcU7DN2P+kfekzFYo7x2inp4ztcUhj6GKJEXz3t3gXBU21GEegEIcP
	iAz2TMudXeDO8iYoKrqO/lh3a4UsoO2XKLCjdnZrXmrJotxrOq4YWA/mAxKy71f3Yx+ps2zy3w+
	jLJHpnNq2ZQMQUCy5jdkfxcdKBHcjvFc4pzVLd86mM858y4WO79M8lFwHPv/xoMS6TRZX6WpNgd
	ZQI2Ovk+cOM7SR3y33Z0CM96gVDg2aTlchpL/fEKP7msvXfvOjZj1ZAZQ24ZO3tPK1Km
X-Google-Smtp-Source: AGHT+IFPLpGlQzR3j7kaW4n/Pqc3/Q6LASGd88cjHqp7yJPIT8kSoq4bcJprhlxmKWGS/E0s1JApjw==
X-Received: by 2002:a05:6808:130f:b0:409:f8e:726f with SMTP id 5614622812f47-40b8881832amr242630b6e.25.1751405973087;
        Tue, 01 Jul 2025 14:39:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:51 -0500
Subject: [PATCH v3 03/12] iio: adc: ad_sigma_delta: use u8 instead of
 uint8_t
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-3-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5301; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=FtjSefgJ38MUOtssdwwTVZxqFU2P60mzs7S3a2VVXcU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVO09pl3X9dfHB8dEJtTortsapcFVhaYcaxb
 ZP834aYu+eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVTgAKCRDCzCAB/wGP
 wOMHB/9clEf7mm/2AnqkayHgZUQcPbtjvar4tPyhxrdO7bPQ2NixAHgXZ8OgLCWT/alB+SdFO/Y
 wJ6+m5nDLFavvyluv/75j86akbfvlTn51EraqcawOIqU+vPROQ1IJZfx5x8yefJLn7nNdpmqt8N
 Wtakd2g6istk2GCpNoT2LrsHk51IhsPVsAAok25Lw6wWWrjHD+ETkJxg4sbU1OKDbEqtyIOeKOx
 I/MdNFtLv/R8V1gSbyhQ4mFgw8YwWbya9bEBsG1lqLkt7yDALUlAlccueJg6ToxeQCGfxwU6i/7
 IsJqM+AztiQ99ILdshq7VhraupPiRUAcsZ9Khp4B3G6Ipo9v
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace uint8_t with u8 in the ad_sigma_delta driver.

Technically, uint8_t comes from the C standard library, while u8 is a
Linux kernel type. Since we don't use the C standard library in the
kernel, we should use the kernel types instead.

There is also one instance where int64_t is replaced with s64.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 17 +++++++++--------
 include/linux/iio/adc/ad_sigma_delta.h | 10 +++++-----
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 5cdd73160c6d6d4d9308eaa3a5aec14529475676..5362157966d89cbf0e602716aaaf0b78f3921b11 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/adc/ad_sigma_delta.h>
@@ -38,7 +39,7 @@
  * @sigma_delta: The sigma delta device
  * @comm: New value for the communications register
  */
-void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm)
+void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, u8 comm)
 {
 	/* Some variants use the lower two bits of the communications register
 	 * to select the channel */
@@ -59,7 +60,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_set_comm, "IIO_AD_SIGMA_DELTA");
 int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int val)
 {
-	uint8_t *data = sigma_delta->tx_buf;
+	u8 *data = sigma_delta->tx_buf;
 	struct spi_transfer t = {
 		.tx_buf		= data,
 		.len		= size + 1,
@@ -99,9 +100,9 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 EXPORT_SYMBOL_NS_GPL(ad_sd_write_reg, "IIO_AD_SIGMA_DELTA");
 
 static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
-	unsigned int reg, unsigned int size, uint8_t *val)
+			      unsigned int reg, unsigned int size, u8 *val)
 {
-	uint8_t *data = sigma_delta->tx_buf;
+	u8 *data = sigma_delta->tx_buf;
 	int ret;
 	struct spi_transfer t[] = {
 		{
@@ -185,8 +186,8 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, "IIO_AD_SIGMA_DELTA");
 int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
 	unsigned int reset_length = sigma_delta->info->num_resetclks;
-	uint8_t *buf;
 	unsigned int size;
+	u8 *buf;
 	int ret;
 
 	size = DIV_ROUND_UP(reset_length, 8);
@@ -454,7 +455,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int i, slot, samples_buf_size;
 	unsigned int channel;
-	uint8_t *samples_buf;
+	u8 *samples_buf;
 	int ret;
 
 	if (sigma_delta->num_slots == 1) {
@@ -488,7 +489,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
-	samples_buf_size += sizeof(int64_t);
+	samples_buf_size += sizeof(s64);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
 				    samples_buf_size, GFP_KERNEL);
 	if (!samples_buf)
@@ -543,7 +544,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	uint8_t *data = sigma_delta->rx_buf;
+	u8 *data = sigma_delta->rx_buf;
 	unsigned int transfer_size;
 	unsigned int sample_size;
 	unsigned int sample_pos;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f242b285081b8d304ca25ae95337425e5842269a..5056677c9941afadc2383febbcafeb02e23a4f44 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -94,7 +94,7 @@ struct ad_sigma_delta {
 	bool			bus_locked;
 	bool			keep_cs_asserted;
 
-	uint8_t			comm;
+	u8			comm;
 
 	const struct ad_sigma_delta_info *info;
 	unsigned int		active_slots;
@@ -105,7 +105,7 @@ struct ad_sigma_delta {
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;
-	uint8_t			*samples_buf;
+	u8			*samples_buf;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -114,8 +114,8 @@ struct ad_sigma_delta {
 	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
 	 * rounded to 16 bytes to take into account padding.
 	 */
-	uint8_t				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
-	uint8_t				rx_buf[16] __aligned(8);
+	u8				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
+	u8				rx_buf[16] __aligned(8);
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
@@ -177,7 +177,7 @@ static inline int ad_sigma_delta_postprocess_sample(struct ad_sigma_delta *sd,
 	return 0;
 }
 
-void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm);
+void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, u8 comm);
 int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int val);
 int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,

-- 
2.43.0


