Return-Path: <linux-iio+bounces-14034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52062A06376
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F423A819F
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FC200BA2;
	Wed,  8 Jan 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sOxSlhA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE34202F7E
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357446; cv=none; b=ayWRL/7O0w9f/8mAYOw/hnJUBuf//r09ZrI1VxCWSQtCxDCPxkFYG37B7xkGn/BeC7LrBXey0e9L/jdPBIUFFhewLM4r5yvq6QCGEeQyZisZ3i03LVFb0T8WtNPCpZZF6NIb4mUeZZ/NbGXB8x5VsHmz/2CdthGdUXn7VFwswQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357446; c=relaxed/simple;
	bh=T6i3t0gkmspAQpLvDBy59RH0XXVU3fyslIP9/NkPmzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SW80mizFQOIT/X1b7p9HK2l9O9Yis/kCOrfXUG8VcjJmme4dHfYXsUHywlSpF7DHuhssW6hPyEy0pkVAigfVE4JEkxO/C0UFbeajkbuzFyXAGU+nKhmzkEdDow1MNgOPFsKymTxKe/7u8n5mpXUKpOz1eFs/rOPo0Y8oag2t9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sOxSlhA0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so24861f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357443; x=1736962243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63sUA66Ctgyf7KL2tc561CUvyyC0coEhZW4ecsp3aQg=;
        b=sOxSlhA0/tlGSO/VGi0tk0PoX0Q1AgFDEfob5mDHa5U80tTu7IU4VR2HAymsknT/n0
         ooKuzUzXeo+rNjWrHw4aVIZmNevFUj2uvO88/ng66rxd2T+5XXokuid0Awd5iP+ko8Ms
         wFo1NDHIHTUE2bexUlDNGF6qdeushdSnpxTrXNEObgqrAnFVVbfTK3tl4owwrenEOCcO
         wvfjndSgdb2hkBiPrbWqYlOp2Yi5f/kzLGl31D/xbsPGA6cb4NowCzOONMHrc/ngjiyS
         1EqIaxg5ARHHktmWJowZxY0F572yHrgEmhMQGj51lxiN4pXAIgUQi6Tft1TkSQgLelJQ
         PI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357443; x=1736962243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63sUA66Ctgyf7KL2tc561CUvyyC0coEhZW4ecsp3aQg=;
        b=cC204aNe4p0fs7LRNa827u5N0RJNLghCgTOPFbJERDmcSYbSz/HVukYWfUg6iHtdNq
         0MH07I6Ln6BXDFmsCfCjQzk3Vz14+XSKvHQXTjkaOt6vdlbEjnZlC1LzWT8Hno0yRicz
         j+Khd81ET73P/PASl5HoQQVKN90rltsJ+ghtWmXxS63k+aaCYGiansFH9eTcKaWK/AeR
         GkOK2EEbUHL07T9soiM25AlL4nDKeX7s5zQ0Q/bPoMgKSg+l8S7ahHhMntIDpaeI3Z1J
         /AhInSbB/8HCHSR+62DxYL6XCxudrdmXU2FVOjjlYiw3YOM1xilGCq8Z0aRMyOtgeWEM
         186A==
X-Forwarded-Encrypted: i=1; AJvYcCWDwA3D/SqGBTk+FXCjc4B7GyAn4YObcHBPFxrcVAw8AQfYCoZtQObVe9bd+DpLnXwVkS8Xmohe6X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7XPHPBRqpBRWuPTi3QbnQEDroF1ZBgIiiDcq3h8glLkF2jPJ
	bONhd1xScdwisQC86erR510M4m/jrkDawt1ZS8ZbaXLmGBEiBFeSNOHDxDhzYaY=
X-Gm-Gg: ASbGncv/k8UuDrmyPF3w7INg+/tJfA/usbsPHE54qnnvsSP+WRiTuGchl7UJyKeywfm
	61ESeuB5oJ3k7/jVpAllQkQOuXhlH2AesKnDRkKjnD+iv+cwqhuRyuk824P42hph5m2k7iCpq7T
	mT7NfsGk6/mhyN/uWoiapgZN6utn0KjB7Zmwb9twRiEkmzblDNQDOUXjEDjNX+oxnyV20Z0Yjb/
	e1hXQ96/ue0TVoqWp0KghzP0W1RJjghBM7LH+OKlwad/MQlzMboYuxr+lw=
X-Google-Smtp-Source: AGHT+IGzdj5Cb9f/UsfLaSyFl+zkmljSKvG6y4+kUJdZtYo99f9dUTCsFvgvvixfxjqKsbmZuOxeYw==
X-Received: by 2002:a5d:64eb:0:b0:38a:50fa:d582 with SMTP id ffacd0b85a97d-38a87363364mr2332840f8f.59.1736357443074;
        Wed, 08 Jan 2025 09:30:43 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:42 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:23 +0100
Subject: [PATCH v2 9/9] iio: dac: ad3552r-hs: update function name (non
 functional)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-9-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Update ad3552r_qspi_update_reg_bits function name to a more
generic name, since used mode can be SIMPLE/DUAL/QUAD SPI.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 58 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 5995bab6a9b1..53ab912eea11 100644
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
 	 * and keeping loop len value so it's not cleared hereafter when
 	 * enabling streaming mode (cleared by CS_ up).
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
 
@@ -247,7 +245,6 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	ret = st->data->bus_reg_write(st->back,
 				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
 				      st->config_d, 1);
-
 	if (ret)
 		goto exit_err_streaming;
 
@@ -257,7 +254,7 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 
 	/*
 	 * From here onward mode is DDR, so reading any register is not
-	 * possible anymore, including calling "ad3552r_qspi_update_reg_bits"
+	 * possible anymore, including calling "ad3552r_update_reg_bits"
 	 * function.
 	 */
 
@@ -359,10 +356,9 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	 * Back to simple SPI for secondary region too now,
 	 * so to be able to dump/read registers there too if needed.
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
 
@@ -386,10 +382,10 @@ static inline int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
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
@@ -405,10 +401,10 @@ static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
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
@@ -541,19 +537,17 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
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


