Return-Path: <linux-iio+bounces-14096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5EA08DF0
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26B71886CBA
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440720DD40;
	Fri, 10 Jan 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qhXsHZaB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68E20ADD6
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504762; cv=none; b=ULrH9/7jr6M4i/AB5clv0oedja7nJXTzoapu6a429ehsyysSDHwZsnD4VgdijObSsBt1tPwPm5DZ3rBU22xg51fXL5h3u4z8hd5VqBhWLdd+PTkXWBuUA7JvAmspHZF9JXjV7olviZn+Qja0scKGa+2hktHVwDdTTYQrUxR6TUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504762; c=relaxed/simple;
	bh=Cetkvl4PSgSp8r4LBcQ/oO5ROIb21xyaaDHdT7rDFbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMdwv/x2qEhnQEJfgz5KC62k43S5Mvyjrn/VrVtBdehARg6y0tXpr5EPm8raLwWw12Tn78muA2Z6KSeF5aCNIeGBEaSROD9Es/njMUdGBAhEQZ68OgXOGTbuRBX/SZCoF6kgx82G1UB6p1o0FdwqS7BSAEDC0C7AQJWqAcr9bLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qhXsHZaB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1012168f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504759; x=1737109559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzJfdRltAIOkuP5dMKF44Xk1jV6rv0f5zBzA2zGr32Y=;
        b=qhXsHZaB2e/hNb6M+DeZNjEDJ/eZanhG0r+PHWF+KUwGmxH1UUsb85x7XzEdo7sSXc
         k2Xn1vrefHdQKUvctd2udWo+3NUGwVZfuLmUs67CIV1jC/V0onssngBvNEFzI0hfBqTx
         SjfNg34sTZnzhUDMMeF3mNGU0mB1NHNuzpAhvuN//URIKjA4UP0EpJS/UxIXyIwe5Bz8
         CK2fTHvEWw4ErTvkBfeTo7nfyh+RLpvY4E1uQ59MHVJpSCc+YtNcBpO5jTlCg6AiccTp
         L0zvZT2u2B1wCWgEvwKhb/Y+jQfyczzgM0cto2JjIWTuYw5Q+dZ5MwsBeRAHSfFB0dTO
         bR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504759; x=1737109559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzJfdRltAIOkuP5dMKF44Xk1jV6rv0f5zBzA2zGr32Y=;
        b=erokiN/R+5ftm+B73R9Cjfow0iECDKtahqXAkZsA8IqPnQjCmed8hjU2AVIeQSOLIf
         KijV9MPcIFf1KK/dc2HoE0GrqhDdRId2dPZB9osjm2JvrF+9eDslEkwIw/dP/BRK++fb
         8czRy/w1S4uJbWj3o6R6dBfSdxRcmrIJwU1STury6vjN4bfieUFvlm7MeZNBS1keUvUS
         xsOnDYSaa2yFZmqbhgeqNiRZMCdUszeIm3FVeJIglb+yvGWTmDVI0PAld6Zg0chpjffL
         UM5MzUotRf7OZBIIhng2k5cbw0lWnr9Y7Sfl8bzbmapbyWqzlcYQZDCG+0ex4Vbm1ryz
         Z3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3xLQ/40RRLSRGMG4HrSY0xA7Ej/hcTI2IEV8n+4rBoeBrZ01jj2mqh6PjJ1An5CPFVrDSwRvGJd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKjNvhYqGpg4gGI1IfmNnQQuYRyieiduS+R84AgeFRqv6wEqN
	GsRinxZObGPwlzYBg1VtgvcW8IUDSRDhwl0Fi5GKdKYbXI3MT6UNimOJ4QJK01o=
X-Gm-Gg: ASbGncsFDau+//KyVs3mhOmu4bIkCa+rgJuMsKBJmnNE1EjZR8uzbMsFKwG7jFjZHeF
	jhVznE+yeDz1StshycvN2zRI5W4C9yEeXtw0WeIXBVXgvYNuvohRdPm8fBJJkAk9CgS1uwxUMZ/
	/vP2a3tsOAbZ66vALRw3rt3U2FqMp8bmjSNuEJi6ofze+bbUxtragsx9u6DDV0ADDUhkxmd3Jbn
	5l7XuXnfsxBFcg0ACSDA5VigFTFLeivE6Lc2Z/dUqV5w9MuSqmaSXOazmg=
X-Google-Smtp-Source: AGHT+IE8AWi1rJIsWVBQxRjhyCoBqve14gftE1xdxrCjFpQzufHJpWFgUOLqlAFdwMxWeSN3m8Twnw==
X-Received: by 2002:a05:6000:4102:b0:38a:8b4c:886d with SMTP id ffacd0b85a97d-38a8b4c88b7mr4952227f8f.46.1736504758945;
        Fri, 10 Jan 2025 02:25:58 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:58 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:21 +0100
Subject: [PATCH v3 9/9] iio: dac: ad3552r-hs: update function name (non
 functional)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-9-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Update ad3552r_qspi_update_reg_bits function name to a more
generic name, since used mode can be SIMPLE/DUAL/QUAD SPI.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 64 ++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 4600a9e84dfc..7f3a70cfbef8 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -56,9 +56,9 @@ struct ad3552r_hs_state {
 	u32 config_d;
 };
 
-static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
-					u32 reg, u32 mask, u32 val,
-					size_t xfer_size)
+static int ad3552r_update_reg_bits(struct ad3552r_hs_state *st,
+				   u32 reg, u32 mask, u32 val,
+				   size_t xfer_size)
 {
 	u32 rval;
 	int ret;
@@ -206,9 +206,8 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	 */
 
 	/* Primary region access, set streaming mode (now in SPI + SDR). */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
-					   AD3552R_MASK_SINGLE_INST, 0, 1);
+	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				      AD3552R_MASK_SINGLE_INST, 0, 1);
 	if (ret)
 		return ret;
 
@@ -217,10 +216,9 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	 * len value so it's not cleared hereafter when enabling streaming mode
 	 * (cleared by CS_ up).
 	 */
-	ret = ad3552r_qspi_update_reg_bits(st,
-		AD3552R_REG_ADDR_TRANSFER_REGISTER,
-		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
-		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
+	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
+				      AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
+				      AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
 	if (ret)
 		goto exit_err_streaming;
 
@@ -250,7 +248,7 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 
 	/*
 	 * From here onward mode is DDR, so reading any register is not possible
-	 * anymore, including calling "ad3552r_qspi_update_reg_bits" function.
+	 * anymore, including calling "ad3552r_update_reg_bits" function.
 	 */
 
 	/* Set target to best high speed mode (D or QSPI). */
@@ -351,18 +349,16 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	 * Back to simple SPI for secondary region too now, so to be able to
 	 * dump/read registers there too if needed.
 	 */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_TRANSFER_REGISTER,
-					   AD3552R_MASK_MULTI_IO_MODE,
-					   AD3552R_SPI, 1);
+	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
+				      AD3552R_MASK_MULTI_IO_MODE,
+				      AD3552R_SPI, 1);
 	if (ret)
 		return ret;
 
 	/* Back to single instruction mode, disabling loop. */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
-					   AD3552R_MASK_SINGLE_INST,
-					   AD3552R_MASK_SINGLE_INST, 1);
+	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				      AD3552R_MASK_SINGLE_INST,
+				      AD3552R_MASK_SINGLE_INST, 1);
 	if (ret)
 		return ret;
 
@@ -379,10 +375,10 @@ static inline int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
 	else
 		val = FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode);
 
-	return ad3552r_qspi_update_reg_bits(st,
-					AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
-					AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
-					val, 1);
+	return ad3552r_update_reg_bits(st,
+				       AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+				       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
+				       val, 1);
 }
 
 static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
@@ -398,10 +394,10 @@ static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
 		fsleep(10);
 		gpiod_set_value_cansleep(st->reset_gpio, 0);
 	} else {
-		ret = ad3552r_qspi_update_reg_bits(st,
-					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
-					AD3552R_MASK_SOFTWARE_RESET,
-					AD3552R_MASK_SOFTWARE_RESET, 1);
+		ret = ad3552r_update_reg_bits(st,
+			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
+			AD3552R_MASK_SOFTWARE_RESET,
+			AD3552R_MASK_SOFTWARE_RESET, 1);
 		if (ret)
 			return ret;
 	}
@@ -534,19 +530,17 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	val = ret;
 
-	ret = ad3552r_qspi_update_reg_bits(st,
-				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
-				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
-				val, 1);
+	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				      AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+				      val, 1);
 	if (ret)
 		return ret;
 
 	ret = ad3552r_get_drive_strength(st->dev, &val);
 	if (!ret) {
-		ret = ad3552r_qspi_update_reg_bits(st,
-					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-					AD3552R_MASK_SDO_DRIVE_STRENGTH,
-					val, 1);
+		ret = ad3552r_update_reg_bits(st,
+			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+			AD3552R_MASK_SDO_DRIVE_STRENGTH, val, 1);
 		if (ret)
 			return ret;
 	}

-- 
2.47.0


