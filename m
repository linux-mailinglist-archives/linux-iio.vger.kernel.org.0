Return-Path: <linux-iio+bounces-13559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42039F3AFF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C858916DE3B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20A1D90A7;
	Mon, 16 Dec 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FLnZuw0X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A11D88D0
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381483; cv=none; b=ZFzqDXLb23OnJdA9XzXihwih+fW99ybccRLEMT/v9V69NB16/LBa8UB8I+aR7G3e+oBmwbWPg6QkXYIypRc3qepvFjW8Hm6ETKOlnhOs/N+ddeca4ot9PXKbamlqAkIAxSQKXchw5OkdyPBsrRpZIsAUb5mKAmhRBfEoctL3Aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381483; c=relaxed/simple;
	bh=0QC7SV6nyXpJIUcRr898xLH08tl8UtEZm2jBCkTN0+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cu42DXkIivqy9RIIYJNXD51XrRmt692IY5pPJNKmS1rM7qulX32bHRg35R4N9s/1MMCGvUYgX+i9wn1r3Eq25R53oR2o3PncqGjQnl2yHG5U633kohGdmVtEFPK2mX2ARb6bFtZebGB/yOCMo7wbiWBZubQx4KlPIvE5kfal2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FLnZuw0X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-432d86a3085so30018855e9.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381479; x=1734986279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrfrvfU/2evsLsBATZKsTGTAlHOssFQ+sotMC8zWiDk=;
        b=FLnZuw0XyRAatTajOTLw7UpdzW0ge8d/zUvJfemZLa1ZCehr5DSElqujGuifsguOCa
         JRHGaCO7hR62O4//XArpKwfKjPiaHxHOitnaHsJcQRJTY261tPwGFWGbdjBdnlx+zIYM
         VXGnUDXLNwBFiQyO5ZgjyFm1oo68K9tVdzbLkfC8Xnn4K4fe0LDFrs97g3avJjftirCF
         FDxP7G5IzqXTM9dB++YScMgRqSZRCmPNa0T2lA4ZyR4aFqyxYhUvZ99/7xyjKAG9y4tv
         tSqLVLubQGM6GpRrA/QnQtDjx/uHfOTPCAqylddIWj1lJ7jFg48u+XYL28ywKgB3RPPI
         ZntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381479; x=1734986279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrfrvfU/2evsLsBATZKsTGTAlHOssFQ+sotMC8zWiDk=;
        b=FlJ0PgEF5cwJNmw3I+fHmPnPh/LkdCTcTKS8l4OqDaapmElck+1Dnu0kc6qGQpS9Cv
         4zu1tyl2JwzAWBBjMta4Qe3iYIBXxtvdyy5YUeteFtplyqqV2730KK5mSNsdTNolzcdB
         05t4s8gKRI4rS14137X/3sRW6aIebmI5qUUtw8hoFEmQBXWo34ix0FscGnFugOLMJbxc
         eLPay6LykNd90rvqw+QSfStRWJFfkZ/NraZ8PzWUw2dMDAF4LHZJRRZi7KTucpb21Qvi
         t7araYWqkT1Uhoy6VML+l2z9YPf3v6H/dTJ5I3NQaNwZ1hWGK7FF8CrzngbDB/mTOwAz
         N88Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZU+Vz83aagLfE+24Z0DGFi+Ws/xvRPksflXbmXyXfi4iwdu+PrjVMlhrmeSGrQUdmz8KFwJm+b7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nmoS2vb0fEM8ZBfk85YrF+ndbhx27unhU5FYy/wOQQ3MxfX4
	+ss6GTWOAoCede1wMvdbv1k2wNDZTNAVvTIqL2A7MrmIu6cPOgmr40W0hQH3iFA=
X-Gm-Gg: ASbGncsUWq6jNf9oxSt9y94aaeGFEINVv7K11Pxv1PGc4hrsGWvoTfG0rzebMn1iBrE
	IrtqkxHrVamChB3Ed47SJ2zEFxocLpob6N2JAKZz9+mXxVmfJvmptZjG8ZtDPHmwTFTMjeVOfAx
	iPhiwDYbl8wqbi0lpGgVmh0zL8kXMS0AsFLFX+3dteYxZCBwYMGkNwEY06z7FPzPItnvu7uI4XP
	ZxPXBDLaJyNfl4glPdgD9kTvHjrV0I80+fwuxsble4cuWYMFa30v3U7byb3xXJJ+AheEa6vl4qV
	3NHIYkUUAZTF92Z4H/tgpqyBJJalcPOJTA==
X-Google-Smtp-Source: AGHT+IEAWCFuyxYbcxOlpOnZ/8Hs8oy3p+JGPHazCNbcvlDF62NHMtN9A47cpecbrGjqdbmO2ircCw==
X-Received: by 2002:a05:600c:3b0f:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-4362aa153camr123528135e9.6.1734381479528;
        Mon, 16 Dec 2024 12:37:59 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:59 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:28 +0100
Subject: [PATCH 8/8] iio: dac: ad3552r-hs: update function name (non
 functional)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-8-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
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
index 58c8661f483b..931e6036da36 100644
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
 
@@ -361,10 +358,9 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
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
 
@@ -388,10 +384,10 @@ static inline int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
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
@@ -407,10 +403,10 @@ static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
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
@@ -543,19 +539,17 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
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


