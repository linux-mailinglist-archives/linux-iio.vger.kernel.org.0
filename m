Return-Path: <linux-iio+bounces-17864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE7BA820E2
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E6A7AE129
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21725D8E2;
	Wed,  9 Apr 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vq4FT1kf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9825C70B
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190305; cv=none; b=TKNmMLID6jiU1PTtGu7D0lYqWnRuH69PyEivDj2KV/3YsfVP8Dp2c2/uVi5MAlFIzrpeyuFj4IR3fzSd2RlCe7GWvpkPYJfvsWHc9CPamZmYoCEe8azzMScc3a2LDdwt83imXHPhMbQ+4wr2LTXpd63RoL5ddZwO/vDRh/Y3lwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190305; c=relaxed/simple;
	bh=NG1MiZ8QoHdfM4LL/T1Mwz1rfI46rSp8UGN1xISLuOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YY5SVI/OkM6dyfgsU1RDXpQgh4PWyyPgC98TlNPzYPINS+jSVPotZ6/ut46Xa9Y6d6+YsSPMX4J0bKv6HTKd03A5IDmdVUCI/EMvnN0xd/qo7T8XsOegqqZXBwZkMWO0+swcCGsylb24P6sQzvqsx0tt3mGrtpd60huA+Y90zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vq4FT1kf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso59752765e9.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744190301; x=1744795101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlPB95+nNbpSrQR/17f9mkYUcS57VR6pMZGMLuAt+fI=;
        b=Vq4FT1kfawyd2KPpYUCemNyhSXrXtS6aatHNhGayNURjQX5Xw3wk25wDHFgrpV/dh1
         2aioFYqitvQgjGg4T0b/mKF1w/tEj9DK9QrmijrP0fw8AeeCFaulpMNM3YvyQ212l5tZ
         OXpuAAufGd0xyAOSvuNzNHb/DVHc9Ga5/z4WcwxMYMkXNz13Rdf7wF29tyZ1d+Gw5OD2
         l7Rk5Bdv4AvLqJjKsAkHOEMxCLgacKdiXMDxT2qp6MYSJBMPcE3aHYYYvUJo+fx5awWJ
         JGNhefATYyIDD26C1OGSUz63XfchqQzUelWf4P84nmAzs4cBxP4C5ZuAIo9Edi4T/HTm
         tXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744190301; x=1744795101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlPB95+nNbpSrQR/17f9mkYUcS57VR6pMZGMLuAt+fI=;
        b=UBYg21cn7PkkvU29XC0qMqdIK+SSLLyxDoQPL84OffG3Kjyt3DsCL9hXEvuZ5ghAQz
         GOqxMBQ9BE3gBJkcnscjkxrPPncuggREq+tfndR2g1QoXFg5znYopPHKNDVlSGb20M8Z
         nc+hw3qp1648HoiihY8lK2UFK3XrvOZ1QuImPftB2pR3y7EoZydYMXuiks2lzBcvxSfk
         3RS58ffId6K5vv4KKJtQZusj8VQFCIeQj4Db9Q6d0eGDY8TLQeWgHrOpxRVn8S8b0wpS
         nMCvGt6ZrjrT8WqvAnqkmmbnncnfcxqHAtR9tMmaMMYb2nXa1pzTRPnwnfjzl08Im8Ml
         YlGQ==
X-Gm-Message-State: AOJu0YxiHQs78b2UH/RIhVfqTdormNbmCsuxKjbjxosdVfND0yaV9ooa
	yntKZ39dyO+viMvcUTSL0R/zdOqIP6YcWJ/hLdve5ZzEehqpx439ms89PuQoAFQ=
X-Gm-Gg: ASbGncu8I75rNTW1qkdJw1CuaHrv0HIJOKFxSEbU3L9vX15YwE+5cPSvW6R4CvfX7ES
	AcoZ6FSNdPoXjCUdAXWXHSHqVYxfIiHLLuk5ZUyPXg3oYG4OIxJST+nRJjxKVxSFqeMCDUX8vr+
	lYA0qr5egaVh5nAh+XIN1ymTWWNUypLAgFXghMFAg1fpL1gh3HV8H0SmE11AZHo5zH8+g9GyLW9
	Ztq/Z6ck+KXy+emuAvbDGpWuSNCM8/iz+YoKpHKMxK/wLe/ASOVo5Wl2/VyKtlqpKCpOhY1WSFR
	ECUOJnJLpfiL0oaHevdiyhCKE3n9LUlzKKilBDtOn+fQMZsjUCt5+0wCVjkraPZ2m8qsmKgHJ/p
	rIqdvp86PheFoQdj73w==
X-Google-Smtp-Source: AGHT+IHBgHm7S+F2IYQk1anaMogHD/QOIQQpmEO8FEr2SU2kU7dz99RQQgB2BRWWmRKjCZv3j9FE0w==
X-Received: by 2002:a05:600c:46cc:b0:43d:94:cff0 with SMTP id 5b1f17b1804b1-43f1fe842c1mr14689485e9.19.1744190301444;
        Wed, 09 Apr 2025 02:18:21 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938b7afsm1069482f8f.58.2025.04.09.02.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:18:20 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 09 Apr 2025 11:16:55 +0200
Subject: [PATCH v2 2/2] iio: dac: adi-axi-dac: use unique bus free check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-ad3552r-fix-bus-read-v2-2-34d3b21e8ca0@baylibre.com>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
In-Reply-To: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3184;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=snSdIkD56Gw2eWhp5aB0J9MJe2j1bu6zf+pLUOWWZYw=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/Zs13zvdtw5l//AdzJ/vJNXEkTFryfmJIJ7tRZmvEs
 Ztm1r+WdpSyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZhIaDHDX8FQ9hma+14+EAiz
 67vjtHS+wGXt3u0Tr+n9ELbpOjmpX4/hn1FP0S7d1AlN90P/zX48r9iK3bL23v4FomUz+y77Lv9
 awgAA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Use a unique function for the bus free check by polling, to reduce
duplicated code. An error is always thrown in case of timeout.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 5ee077c58d7f9730aec8a9c9dff5b84108b3a47e..c90068693e9989a49e4c035eecb69606bdcbb196 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -635,15 +635,26 @@ static int axi_dac_ddr_disable(struct iio_backend *back)
 			       AXI_DAC_CNTRL_2_SDR_DDR_N);
 }
 
+static int axi_dac_wait_bus_free(struct axi_dac_state *st)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, val,
+		FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == -1, 10,
+		100 * KILO);
+	if (ret == -ETIMEDOUT)
+		dev_err(st->dev, "AXI bus timeout\n");
+
+	return ret;
+}
+
 static int axi_dac_data_stream_enable(struct iio_backend *back)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
-	int ret, val;
+	int ret;
 
-	ret = regmap_read_poll_timeout(st->regmap,
-				AXI_DAC_UI_STATUS_REG, val,
-				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0,
-				10, 100 * KILO);
+	ret = axi_dac_wait_bus_free(st);
 	if (ret)
 		return ret;
 
@@ -734,12 +745,9 @@ static int __axi_dac_bus_reg_write(struct iio_backend *back, u32 reg,
 	if (ret)
 		return ret;
 
-	ret = regmap_read_poll_timeout(st->regmap,
-				AXI_DAC_UI_STATUS_REG, ival,
-				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
-				10, 100 * KILO);
-	if (ret == -ETIMEDOUT)
-		dev_err(st->dev, "AXI read timeout\n");
+	ret = axi_dac_wait_bus_free(st);
+	if (ret)
+		return ret;
 
 	/* Cleaning always AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA */
 	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
@@ -760,7 +768,6 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 	int ret;
-	u32 ival;
 
 	guard(mutex)(&st->lock);
 
@@ -773,10 +780,7 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	if (ret)
 		return ret;
 
-	ret = regmap_read_poll_timeout(st->regmap,
-				AXI_DAC_UI_STATUS_REG, ival,
-				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
-				10, 100 * KILO);
+	ret = axi_dac_wait_bus_free(st);
 	if (ret)
 		return ret;
 
@@ -787,7 +791,7 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
 				   enum ad3552r_io_mode mode)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
-	int ival, ret;
+	int ret;
 
 	if (mode > AD3552R_IO_MODE_QSPI)
 		return -EINVAL;
@@ -800,9 +804,7 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
 	if (ret)
 		return ret;
 
-	return regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, ival,
-			FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0, 10,
-			100 * KILO);
+	return axi_dac_wait_bus_free(st);
 }
 
 static void axi_dac_child_remove(void *data)

-- 
2.49.0


