Return-Path: <linux-iio+bounces-20807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA12FAE25AF
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 00:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6547A43E5
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 22:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F298262FDB;
	Fri, 20 Jun 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wBXFihOF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9052620E9
	for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458102; cv=none; b=gJt80iH06WPjEce/pEZZFJ4ejHKtoNI3F2x98v63fjXkWiJcmqtRO9dvmEiWhMPtVDV0E9wYptHR3sPE1p7294/NW+lnVkwCvff8mFBx0w4R+iXUPnvMjCC/RMjTQ34IG6KUnyXEn7YGXdeOBFGJc2IMR1vP2iUA8QaU/GoBzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458102; c=relaxed/simple;
	bh=x4deODr2J/B/ZfZk3+/1/BV8bYxvy5G2y6ggy6cAeUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHJfI+aRZyFucObJcAmIJyMxSbBhRcwaiVcV6ed9z9wQwW2ubeclmgZT5ao4my3b4KFzPPR1LYXV07WGtBVIRMUpsAosXTD/cTVLs6JXEOScgu2ldt0oLr4YAh90gCkQwPdsrHKfGu/IoqJXMLQnFAPBYbXHh1K9NKmAaeuzlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wBXFihOF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c09f8369cso645417a34.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458099; x=1751062899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suln3ZPyOtbgf+467Jl0jyyrQzWY3/ACSgQiyK4V5QE=;
        b=wBXFihOFLTvQbqVvK/Mu067ef9/6E2ZX887LJFi74M12RFxgU5ZYf71gHFk23oR/F5
         maAQPC6xg4P+hloJfIaL1S55ZBt684Uhs2dmFhxfpDfH3JYZHHR14U962m0qNVXpjh9z
         ZNKKbazxwBlFhLntOzByyrBv8hltAOEF6nYc6HcfoRqMKDEMeN12oRFuBQBYhGm7VNaz
         v9RnpVjEYH2cCPEYTuJjwupP+8gF1OaqoPHEcTw9BQdWeodO3tpCeDdW1+giQYPcGYwz
         W3l6Sru/woLlVgSxY9dfPtVTExJAmb9K0mw9XD2aCElZ1lulin3waH3yS3ouQ8ll/GQM
         C3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458099; x=1751062899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suln3ZPyOtbgf+467Jl0jyyrQzWY3/ACSgQiyK4V5QE=;
        b=IChAt2zEN5x7cGSyZRgF06lKvYyOnnrcjgXEErmA0o5ELHyWZgHmlfGtqqLjx4jPeW
         QDnqfphM229dPclqrj8KCg+MLpzY4GaAPmC78SS3t5gfA6FvP2R/CR6Qxqxl4AyAkKMf
         sUh43aOAhf8Ycj4EQGDx1K/5tQ8yFfCJg0L6Khxlw8e2rha0SE0msU//7b8g6MrIoeaD
         C68TYaJ43ENC7iGNSKUr1p8zadooqFzf0r0GRK68uR54LFRTWb6BkwjYhH5ar9FbTyya
         0X6VZoD5UQ1TABAS9mB0F3WuOeOYjWR8rtW5cDsDEIOOyBJNGQwROuV+CXDxmpTB5fN5
         TvNg==
X-Gm-Message-State: AOJu0Yx44RMbS6fIpRzCJzLw3nY/CRQD6fXk/m7NshJlakGG9hkJDtqC
	U4TT2T3xkgoMwaxE+utyd9JE3HKk9LArL5ORnI/5P1F0GX9qIWgiwtGl59a5I8gJgfE=
X-Gm-Gg: ASbGnculb2UA4qMc9Kn1fBJnP/QoFZLuyukLOrg1frp+5XfjrxHyqBhrSAcOO+onJC8
	iJyNxNDyeU5JIraMQ7ccU231Zv+WEUF5v2XCV1dHTkm5Aq95ERtS0qX01ovbCTihtoclHGh2CLq
	CdBMFZIu2WObnRznsbrN5zEB9rMna0DAL33GzkgNekRVhhOTRsrrNRtSyyS8EMK/cJn9R1fAuXs
	FbuQvDq7w9cK4PeEfwRUYMtSj4KrSQs1koHgo6TMyM8af5wWngvD38NKlf30gVXdviHM/F6xP0/
	hwHH/abEibWjsAC0WQII1lTXsCrjQYdFP1lkr905wCJFCMumCJDkB9ytI4ivFw+u35PB
X-Google-Smtp-Source: AGHT+IFFZ+omLsO7ZuSN1mPRtGWTSm0ZzIFm+TkweJtrK0ojyctWLeY95qYERn4eblsassMxLl2d4g==
X-Received: by 2002:a05:6871:d082:b0:2d4:e420:926c with SMTP id 586e51a60fabf-2eed96fd963mr3180391fac.0.1750458098820;
        Fri, 20 Jun 2025 15:21:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:15 -0500
Subject: [PATCH 9/9] iio: adc: ad7173: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-9-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=x4deODr2J/B/ZfZk3+/1/BV8bYxvy5G2y6ggy6cAeUc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd7X1mOWlAqdTIO8E8YQGWhnDdCYn3sWy4agB
 JECUdf0nY+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXe1wAKCRDCzCAB/wGP
 wIXeB/0cCZLaVXucuun4F3NuAOcZU4Z6XVqoy07XZgydMW8uAoRFh9Smjm8a2yuZ89fNsezuGDs
 p2VD/kJxzwjq29+7Dh7rAMJK9R6QQHvl/JS5jC09PQz8G2xWut4W7gDLfVVYEui6pNRrzB4pDON
 BO151qy8G+Nu2VrofSepYqirPoFAJDaC1akxcLPrBjuPxTlrbBVYIyBg07xyPyJaeXD1JhoBoB1
 OvTWmEVak1PusFL/ETcJsuqtt4F4v4Fax0ueYutobWoern8Q9aHu7Uvon0JR5Nk9omjsAH3gfZT
 HefEfAdSDzo9otlQIPhuHy/Dw8qW2N0sioE4LURsFoIVL0g+
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Enable SPI offload support for the AD7173 ADC driver.

The scan_type used for SPI offload is assuming that we are using the
ad411x_ad717x HDL project [1] which always stores data words in 32-bits.

Link: https://analogdevicesinc.github.io/hdl/projects/ad411x_ad717x/index.html [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 010339c2b7044da4b36dc894a38a145c2fcccd6a..580d4bf3366b193fa0f13d0a28886d390e1295b8 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -748,6 +748,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -764,6 +765,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -1585,6 +1587,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 
@@ -1675,6 +1682,12 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		/* Assuming SPI offload is ad411x_ad717x HDL project. */
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 	return 0;

-- 
2.43.0


