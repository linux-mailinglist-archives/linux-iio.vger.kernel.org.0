Return-Path: <linux-iio+bounces-14328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1EA0C3F1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E37168360
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7AA1F892E;
	Mon, 13 Jan 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KR3dIgEh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055C1DE4D5
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804609; cv=none; b=BMFYamH8+doRwW01WzKwi0XkcZrTkWILLQyJhzSz83NIUJ/QSmiBhjg+T8fq0+hcZQrZWRV0V7BeP+aD5kLplre1gg5wMY9rZeECTymSOm2fkmynAcye+p924vTEeY/QWTd5PAb6TfzUChaVml6UeA6c/oC11le2ZGOTonpz3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804609; c=relaxed/simple;
	bh=5iT11eG/HgQs3YWkbiQr+0bGcmFtfNDAIhVxz74R5Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNGmYTyMCc+QSKT64MJIPY3xwbgtYlxHQPUtrgCKRi2I98HOeQnbLSDx/qEqJo5Vhs9kLYFf94P94XYg2AT4ogKWWw9CD4z1MnfpyySBM2W+AHXRiBWhziCa2c026bKG7ItyQ28KRNF73PRGMVK/so02SLQ4eiyTjlXjlCuSw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KR3dIgEh; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb9101419cso2745401b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736804606; x=1737409406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxRWCgdwbsoP98leMR38NpBPw2TRSdUfugz5uC3OaZw=;
        b=KR3dIgEhoFs80Y/j/hrxLpUZLqr+KICtn5K95qyiW9F6COoZ5d/Idn8WTKYQAyK1sV
         zZTUCEhJlBJN5T96F26ZrCY2IjNuER+AWpvD076KR0SOgSOog1AigiHDaASPPk1NcIpV
         lCG4Ay5hpmtx59RJ3ukznDbiqdS6bSDu26QEKO5YPpB02aRDnlYzRQsIfoWr3kA73HKn
         nHYAz4wG5p2rp1/uyXxQgTZDs/C9v9TXHFu6atX2h3SVJq9Ft5WWgmvSTJcbHiHmq3go
         Q70c5laHmMZ8I4iJ5T4Wu36iNedBNsixLeTNvQd6atXGE1icV4kY9bigQ83u+XkkUuKH
         o/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736804606; x=1737409406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxRWCgdwbsoP98leMR38NpBPw2TRSdUfugz5uC3OaZw=;
        b=aP7/TN6xjvTLpwaGHxvUduWoGoAzBk0RZhqO0L8/eqEmu8i9VTw/eG75IHdlTTIeuY
         mHxloK3KrbgVGblWhxNeclum66vB/2t2xCDd1+jmWDRqbvxcNonBFRj1C6ebxkpj6tLU
         6IvjCWNUTVSivNeixt6I5kAan2lOk8B1I7X1zCtGNuLuSKIvENm1NAU3jbe7A2m8R9mK
         ZL+jcy31o3ARg04/Y27dTC7g4CntcYQ0yAXQN5P/OysZcWyHXv5Jqua7U2q/4MdIDIjD
         tzVOYFbHKz0gOgZpUT9v1Tu9J+9RUUnCu76HOJoZGcqNM258Vbar/+HznrzBdq/WPFGk
         YTUg==
X-Forwarded-Encrypted: i=1; AJvYcCXNvZHeu1Nz2YoKQQyh7JgO34F9EeTvMnmkJN2H5EIPgyzHwjxYpwurwwTsdcHi+UbQYgiPpLlFbo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0y4uDR53QYRy+KlLZ7ss7LSQJugpj6Uhh1JhFi35HYISTQ4D
	et4qTfwF7+UqJnW7649Z03mliepylCkjp3RZ1canIIa/7viA9jLiH7uyyeLm71M=
X-Gm-Gg: ASbGncso265JfIwHeMpVzptiSRt6AF3XezrrPeDs8gfR9wtUksiofuF1cYIh/dhUbS4
	swssOkOXUbm3hs2EEEsBVx7hSTVlMeuWMN7zYcnc/8ggOzJ2f//+2gM8gy4qwqEg+ueHLaXTA2B
	keYP5K/sVfS8lI+yJkeXOpwQeshBAO5sZWgvqLfoSfJFOXmus8ITIwmFLkfax8YaEFCrFL4dOnf
	wpBo1GdppdX7Oq3QTHj7mAurIar7GllE+eyWaDWIFE2nbZilQ2f2wbY6/WywOYqQDXby6HFtYQm
	GOo2HWHsxrk/
X-Google-Smtp-Source: AGHT+IGPRNB8LbJw1tytimz7TILkld4KGNDg40MFGgHC2c1apyw7NF6yt5quUyzlhSfejj3b42ZdCw==
X-Received: by 2002:a05:6808:1a1a:b0:3eb:39f5:de8b with SMTP id 5614622812f47-3ef2eda1cf2mr15484912b6e.32.1736804606299;
        Mon, 13 Jan 2025 13:43:26 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882624f77sm3606806eaf.7.2025.01.13.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:43:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:43:18 -0600
Subject: [PATCH v4 1/2] iio: adc: ad7173: move fwnode_irq_get_byname() call
 site
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-1-b63be3ecac4a@baylibre.com>
References: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-0-b63be3ecac4a@baylibre.com>
In-Reply-To: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-0-b63be3ecac4a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Move the call to fwnode_irq_get_byname() from the driver-specific
ad7173_fw_parse_device_config() to the shared ad_sd_init() function.

The main reason for this is that we want struct ad_sigma_delta_info to
be static const data that describes the actual ADC chip, not the
application-specific configuration or any runtime state.

Previously, this struct was being used to pass the IRQ number to the
shared ad_sd_init() function. Now, this is replaced by a boolean flag
that is set at compile time and the ad_sd_init() function handles
looking up the IRQ number instead. This also has the added benefit that
if any other drivers need to make use of this in the future, they just
have to set the flag and the shared code will take care of the rest
rather than duplicating the code in each driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* New patch - replaces "iio: adc: ad7173: remove special handling for
  irq number"
---
 drivers/iio/adc/ad7173.c               |  7 +------
 drivers/iio/adc/ad_sigma_delta.c       | 11 ++++++++---
 include/linux/iio/adc/ad_sigma_delta.h |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 6c4ed10ae580d66287857252ce9a69cfaa45db0b..bb9cddd8c9d33f81df95e5001d62a8ceb684d348 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -871,6 +871,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.disable_one = ad7173_disable_one,
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
+	.has_named_irqs = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -1515,12 +1516,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	ret = fwnode_irq_get_byname(dev_fwnode(dev), "rdy");
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
-
-	st->sigma_delta_info.irq_line = ret;
-
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d5d81581ab34099cef30ec63944ce1171c80ec14..10e635fc4fa4bf0ecad279962a2b944153b436be 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -801,10 +801,15 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 
 	spin_lock_init(&sigma_delta->irq_lock);
 
-	if (info->irq_line)
-		sigma_delta->irq_line = info->irq_line;
-	else
+	if (info->has_named_irqs) {
+		sigma_delta->irq_line = fwnode_irq_get_byname(dev_fwnode(&spi->dev),
+							      "rdy");
+		if (sigma_delta->irq_line < 0)
+			return dev_err_probe(&spi->dev, sigma_delta->irq_line,
+					     "Interrupt 'rdy' is required\n");
+	} else {
 		sigma_delta->irq_line = spi->irq;
+	}
 
 	sigma_delta->rdy_gpiod = devm_gpiod_get_optional(&spi->dev, "rdy", GPIOD_IN);
 	if (IS_ERR(sigma_delta->rdy_gpiod))
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 417073c52380f60a1a45a4924f4f556b64832295..f242b285081b8d304ca25ae95337425e5842269a 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -46,6 +46,7 @@ struct iio_dev;
  *		modify or drop the sample data, it, may be NULL.
  * @has_registers: true if the device has writable and readable registers, false
  *		if there is just one read-only sample data shift register.
+ * @has_named_irqs: Set to true if there is more than one IRQ line.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
  * @status_ch_mask: Mask for the channel number stored in status register.
@@ -53,7 +54,6 @@ struct iio_dev;
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
- * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
  * @num_resetclks: Number of SPI clk cycles with MOSI=1 to reset the chip.
  */
 struct ad_sigma_delta_info {
@@ -64,13 +64,13 @@ struct ad_sigma_delta_info {
 	int (*disable_one)(struct ad_sigma_delta *, unsigned int chan);
 	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
 	bool has_registers;
+	bool has_named_irqs;
 	unsigned int addr_shift;
 	unsigned int read_mask;
 	unsigned int status_ch_mask;
 	unsigned int data_reg;
 	unsigned long irq_flags;
 	unsigned int num_slots;
-	int irq_line;
 	unsigned int num_resetclks;
 };
 

-- 
2.43.0


