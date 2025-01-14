Return-Path: <linux-iio+bounces-14362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C344A10AEE
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A77168AB5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A761F9AA5;
	Tue, 14 Jan 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BiL9ZafD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9B1B86D5
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868719; cv=none; b=ZhqGXm9UegxAG56BIXpOp/8SIImEqXheJJIp3KWkibAgOmS+ylqB2UfL5O84+S4OtWH2AtKaGgiGvtEdeM8OevSiEnip2S6Nk8Tl+Qmvxw5hOYlBqCCFv7Dm4Q6gVXO2GDPVDQo2nJ4T8pXEySoXckj3FX78m5geEtP1Qd3ijz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868719; c=relaxed/simple;
	bh=qYyzsrOrzx5St4FThuHvNxAMEp85//w2zLTC8Y3IIIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffZ31a1fg1/GbCk4IcL6yOhmcR1H4aCxsPbZPNDb4P5mtpf2DniDc1Cj3SZEtxnKrju2C9hhJDk/nyJh3G/YVEsHHzb0BLFSQl7UyjqxCEgOSCac7rInpB2tquSZ3QwXUmFjQddafnJtj0x6q/5nRn0cxqyZTIfIBcET3pu+noQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BiL9ZafD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so40521315e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868716; x=1737473516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylCBASlMPJkZHv6GhjEiCkHB/0+Vz29gsqJdZKd5MdM=;
        b=BiL9ZafD5bf+6j7JrIAiCjJcNrdDSrm0Xul3MKobnYOc6qu2HsAkTQWcFHfIa/Q0Nz
         LDLxLRlh4p3hrwU8FOm+u/EZfH1ZGKnlFq2yTK+dW7tXpK8B3b/QUpEKyWUJMIoI10F1
         sYWcG3F3g+sUCEhLKMO4QC/Hg9IJv8A7WJt1V5gjzLElnT6LKTW9a/mf1AL6sXh0qoHx
         GxaCoepbuiVyz+w7/p/fzD6A8mv14GjwAVm6qCG8dLzVlvuDgMexFinU2Cfc/uWiHktD
         Ho7/K+RId2mZ1v+zZaw/ctOHhKkw7L1zZzQZ5XaeiiE3pCebdfI2viyZaFdCNOks2SKT
         kU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868716; x=1737473516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylCBASlMPJkZHv6GhjEiCkHB/0+Vz29gsqJdZKd5MdM=;
        b=ZYaPGwjK6/5wUpK7nBIgqNHj7roUvV7oGK6tDaxZhl1QE887+0+9s8GyqkXbTJezbJ
         SB1RakmroQ4BD3K9Yy1cWbhLOyEdhMbxjUeHK2fCVceWYDkZgI853jznuP6uS5FgOnjq
         Rbu7wjiB7PVgBza2ZYDbHSgQVsByoGTVLmbeYwRK1Xvg3iRI1Kz5C/qb07370eOT1ZDz
         MeA5SCdW+DATcPx96JVyV1OHHkbYuMKefiQJzoHinJGAbyJEFlGZ4DRvC1Gu13/nrscz
         1TxQtv/WKtKira+ECdHjfhLRJIfr+h3GshA87UEdWCcMsRYakPqIF8qWYzCQFO9dZMho
         kffQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkKPfUa2taqinuHHzwKtBSaRicAsy75Am1TypRrcmk4K4scFlpl5SFv509sSUL604D2YSprdpX9Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUbd8Qwa8DfQ5EMJlzDDYlUMDgu8gfAwghMLAgkfCtcXwl2B/
	zR84yroZ0wjCobw1Tu/dXrnLU8zPjyn0VNM7K4QpO9/vfsi3zqMda1bedWrWTz8=
X-Gm-Gg: ASbGncuQtST6cbREEbm3OgGtq0V37vXGOo+7Bdljsq1BFxVePKsK30jsf1x2Ou3e0Ax
	AR9LU+fNumV6+Onf8RZ3nvnM6frtNC50nM99ZZvWj9s6UkgfsYPAFMogt9jK2+ECIhzQdir4+5b
	oKjsxNRi756kNqe+SHJ9/N+AVVzlsfZ+mb9nplzKeVZBsZuLFcq9pSLzaoLj+KL6hvVrn0jU94E
	HKDcpcQ9w5Wh9AGqnUGnJKFLaiOoC4n+SAMEyFiCCDO3+yp3HO9PuXoPN8=
X-Google-Smtp-Source: AGHT+IHGq0wfH03pxXCXZ0hcHDHI669Hj0ZbP8/2Zn0o0ALPUihu4LyMgScyCO3Pg4kIgBtCvARAqw==
X-Received: by 2002:a05:6000:1787:b0:38a:41b6:d685 with SMTP id ffacd0b85a97d-38a872f6f17mr23199035f8f.3.1736868715927;
        Tue, 14 Jan 2025 07:31:55 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:55 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:18 +0100
Subject: [PATCH v4 9/9] iio: dac: ad3552r-hs: update function name (non
 functional)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-9-979402e33545@baylibre.com>
References: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
In-Reply-To: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 60 +++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index e8e309046f11..c1dae58c1975 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -65,9 +65,8 @@ static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg, u32 *val,
 	return st->data->bus_reg_read(st->back, reg, val, xfer_size);
 }
 
-static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
-					u32 reg, u32 mask, u32 val,
-					size_t xfer_size)
+static int ad3552r_hs_update_reg_bits(struct ad3552r_hs_state *st, u32 reg,
+				      u32 mask, u32 val, size_t xfer_size)
 {
 	u32 rval;
 	int ret;
@@ -215,9 +214,9 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	 */
 
 	/* Primary region access, set streaming mode (now in SPI + SDR). */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
-					   AD3552R_MASK_SINGLE_INST, 0, 1);
+	ret = ad3552r_hs_update_reg_bits(st,
+					 AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					 AD3552R_MASK_SINGLE_INST, 0, 1);
 	if (ret)
 		return ret;
 
@@ -226,10 +225,10 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	 * 0x2c or 0x2a, in descending loop (2 or 4 bytes), keeping loop len
 	 * value so that it's not cleared hereafter when _CS is deasserted.
 	 */
-	ret = ad3552r_qspi_update_reg_bits(st,
-		AD3552R_REG_ADDR_TRANSFER_REGISTER,
-		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
-		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
+	ret = ad3552r_hs_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
+					 AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
+					 AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
+					 1);
 	if (ret)
 		goto exit_err_streaming;
 
@@ -252,7 +251,7 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 
 	/*
 	 * From here onward mode is DDR, so reading any register is not possible
-	 * anymore, including calling "ad3552r_qspi_update_reg_bits" function.
+	 * anymore, including calling "ad3552r_hs_update_reg_bits" function.
 	 */
 
 	/* Set target to best high speed mode (D or QSPI). */
@@ -353,18 +352,17 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	 * Back to simple SPI for secondary region too now, so to be able to
 	 * dump/read registers there too if needed.
 	 */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_TRANSFER_REGISTER,
-					   AD3552R_MASK_MULTI_IO_MODE,
-					   AD3552R_SPI, 1);
+	ret = ad3552r_hs_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
+					 AD3552R_MASK_MULTI_IO_MODE,
+					 AD3552R_SPI, 1);
 	if (ret)
 		return ret;
 
 	/* Back to single instruction mode, disabling loop. */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
-					   AD3552R_MASK_SINGLE_INST,
-					   AD3552R_MASK_SINGLE_INST, 1);
+	ret = ad3552r_hs_update_reg_bits(st,
+					 AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					 AD3552R_MASK_SINGLE_INST,
+					 AD3552R_MASK_SINGLE_INST, 1);
 	if (ret)
 		return ret;
 
@@ -381,10 +379,10 @@ static inline int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
 	else
 		val = FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode);
 
-	return ad3552r_qspi_update_reg_bits(st,
-					AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
-					AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
-					val, 1);
+	return ad3552r_hs_update_reg_bits(st,
+					  AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+					  AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
+					  val, 1);
 }
 
 static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
@@ -400,10 +398,10 @@ static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
 		fsleep(10);
 		gpiod_set_value_cansleep(st->reset_gpio, 0);
 	} else {
-		ret = ad3552r_qspi_update_reg_bits(st,
-					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
-					AD3552R_MASK_SOFTWARE_RESET,
-					AD3552R_MASK_SOFTWARE_RESET, 1);
+		ret = ad3552r_hs_update_reg_bits(st,
+			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
+			AD3552R_MASK_SOFTWARE_RESET,
+			AD3552R_MASK_SOFTWARE_RESET, 1);
 		if (ret)
 			return ret;
 	}
@@ -544,10 +542,10 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	val = ret;
 
-	ret = ad3552r_qspi_update_reg_bits(st,
-				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
-				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
-				val, 1);
+	ret = ad3552r_hs_update_reg_bits(st,
+					 AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+					 AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+					 val, 1);
 	if (ret)
 		return ret;
 

-- 
2.47.0


