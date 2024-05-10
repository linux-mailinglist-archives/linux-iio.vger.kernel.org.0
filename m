Return-Path: <linux-iio+bounces-4926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC2D8C2695
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 16:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEF81C21881
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B94116E890;
	Fri, 10 May 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yLVn5E+6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B712CDBE
	for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350760; cv=none; b=H4TfKBJdWmjsmVfQQ5kaS7fhTEgnni4n0e6IKyqfCZqvv1m5mU2WOsjJ4Cp44sW3QC8JbnRATRyzC5VWM4W4vH1oz9lel0OgpRdEop0kVesZvPsm4+4gL6hNwNw+6nZHjgoNQLPdVjO+ffhYlWoGrWF0HnaL8maWjpkQWxsAcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350760; c=relaxed/simple;
	bh=NlQ/Ug7dz4K2c2zWHyPJUr2k+IfziswsplWQ7RQc/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpURJFwtZ88EHwZr9gRKKP6HVou2wlc+sj2Ak7Z4ouIq0umkLMvdpuiqveb6g6QqGC/muk/HvgSrVaHfUoKhSq3VF11UVKhN0McjLCJ4OigFLRlXi5ACUtfM+1i4TEXz56t9xYNm4kptuTsjVWFpYbpenj8w/AdFNIw7tD66h9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yLVn5E+6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so1707784f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715350756; x=1715955556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBayFo9ABt7YlFjmk+ws+uzVFbLXwJ+VUXfXdiBtu3U=;
        b=yLVn5E+672NVDcUuZ5BM9pqUiQ51PD0bYvsxde4oKfhH58dUTDwa7EJ/YV5wd2UZ+R
         eH9fhGEjWqOVGY+dM/kb/6H0jSj91zknOZXoM4TZ67I3ozYssnfhoS8wTZ/NBdBQZIm5
         bv81b7/jLbupL/+KYSndc6ixpctxX8WfWrjCbVZeSupcS+lUDT6M0XwHpSYMm2cbg4jL
         /Jij+sL8dPrVJkO0wiZs9vP/m8inRb1OFwMSUREFJwVYl6HCFpMh6XlZbAqhjLQ0Egeb
         DeD3hyZF04ZFwsNiGWcX0H2/tn/rskfphj7yWihS3SN8bPLwiMVP1EdoQGxuPmJPsOro
         x+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350756; x=1715955556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBayFo9ABt7YlFjmk+ws+uzVFbLXwJ+VUXfXdiBtu3U=;
        b=K+iOrwhbonGcXtV51gTF7UZdoFYrxuJ63NsaubPSgrDN557+3UMbnNY4nINnHiTZqb
         aJWeeZQB3+YhcY9XvDBCsYsng4K3uz1mPfEpHMDkvGU3g0K5UOFN97XrQroBY+lshkWJ
         yEtLWu9uMc+wjg6i/bJ2mn5mrhB+9WztcZYoeDhuIattiJDn4TYvEnwfZ7ItpaR7U4ae
         K7s/SFsbajabb+xHpo2p0H3XjWqQrcWR4NZlNaPgqBVj3XVbFBp/Vys9TzWO2yTwGZ3Y
         Jm/9S0KH35ORdBagajLTxIF5MBR5w2XxXfAtIjyJ8K1LU51ilGoWeDrWem1CW/f/szKp
         SYyw==
X-Forwarded-Encrypted: i=1; AJvYcCXNxz89WlpMSKyMz8R4amNHWdZ9TQvIsYWR5BTdXXkC3T1Mt/Nu4NK5uTKLJQy4NXVFtBYjwzdlmrNJ0CSbTMoecx4C70HhtWW0
X-Gm-Message-State: AOJu0YyAPk0UclwRLl4IvVL0hdJv44MfDc/+JkcCaYBu+UTJDBZE0x7e
	TfnWB0RYHhWCwtz6Qr9qHOOtRG66v7VL2b0SAn8oDwWiaox6NROM+kaJEIGHufs=
X-Google-Smtp-Source: AGHT+IGJ7nj5x+rqDdO1Ls7q9E9QWTgWjhPJK1qtXFrn9CBOM7ecq92CKF5mEejihS5rabgpVGfggw==
X-Received: by 2002:a05:6000:181a:b0:34c:fa08:791c with SMTP id ffacd0b85a97d-3504a969487mr2456273f8f.45.1715350756294;
        Fri, 10 May 2024 07:19:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-39-74.retail.telecomitalia.it. [79.47.39.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd97e842csm56111875e9.24.2024.05.10.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:19:15 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH 2/3] iio: dac: ad3552r: add support for ad3541r and ad3551r
Date: Fri, 10 May 2024 16:18:35 +0200
Message-ID: <20240510141836.1624009-2-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
In-Reply-To: <20240510141836.1624009-1-adureghello@baylibre.org>
References: <20240510141836.1624009-1-adureghello@baylibre.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for single-output dac variants.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index a492e8f2fc0f..0dd6f995c3e2 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -140,7 +140,9 @@ enum ad3552r_ch_vref_select {
 };
 
 enum ad3542r_id {
+	AD3541R_ID = 0x400b,
 	AD3542R_ID = 0x4009,
+	AD3551R_ID = 0x400a,
 	AD3552R_ID = 0x4008,
 };
 
@@ -745,7 +747,8 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
 	} else {
 		/* Normal range */
 		idx = dac->ch_data[ch].range;
-		if (dac->chip_id == AD3542R_ID) {
+		if (dac->chip_id == AD3541R_ID ||
+		    dac->chip_id == AD3542R_ID) {
 			v_min = ad3542r_ch_ranges[idx][0];
 			v_max = ad3542r_ch_ranges[idx][1];
 		} else {
@@ -780,7 +783,7 @@ static int ad3552r_find_range(u16 id, s32 *vals)
 	int i, len;
 	const s32 (*ranges)[2];
 
-	if (id == AD3542R_ID) {
+	if (id == AD3541R_ID || id == AD3542R_ID) {
 		len = ARRAY_SIZE(ad3542r_ch_ranges);
 		ranges = ad3542r_ch_ranges;
 	} else {
@@ -955,9 +958,10 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 			dev_err(dev, "mandatory reg property missing\n");
 			goto put_child;
 		}
-		if (ch >= AD3552R_NUM_CH) {
-			dev_err(dev, "reg must be less than %d\n",
-				AD3552R_NUM_CH);
+		if (ch >= AD3552R_NUM_CH ||
+			(dac->chip_id == AD3541R_ID && ch) ||
+			(dac->chip_id == AD3551R_ID && ch)) {
+			dev_err(dev, "channel %d is not supported\n", ch);
 			err = -EINVAL;
 			goto put_child;
 		}
@@ -987,9 +991,10 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 				goto put_child;
 
 			dac->ch_data[ch].range = val;
-		} else if (dac->chip_id == AD3542R_ID) {
+		} else if (dac->chip_id == AD3541R_ID ||
+			   dac->chip_id == AD3542R_ID) {
 			dev_err(dev,
-				"adi,output-range-microvolt is required for ad3542r\n");
+				"adi,output-range-microvolt is required for ad354xr\n");
 			err = -EINVAL;
 			goto put_child;
 		} else {
@@ -1088,10 +1093,20 @@ static int ad3552r_probe(struct spi_device *spi)
 		return err;
 
 	/* Config triggered buffer device */
-	if (dac->chip_id == AD3552R_ID)
-		indio_dev->name = "ad3552r";
-	else
+	switch (dac->chip_id) {
+	case AD3541R_ID:
+		indio_dev->name = "ad3541r";
+		break;
+	case AD3542R_ID:
 		indio_dev->name = "ad3542r";
+		break;
+	case AD3551R_ID:
+		indio_dev->name = "ad3551r";
+		break;
+	case AD3552R_ID:
+		indio_dev->name = "ad3552r";
+		break;
+	}
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad3552r_iio_info;
 	indio_dev->num_channels = dac->num_ch;
@@ -1110,14 +1125,18 @@ static int ad3552r_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad3552r_id[] = {
+	{ "ad3541r", AD3541R_ID },
 	{ "ad3542r", AD3542R_ID },
+	{ "ad3551r", AD3551R_ID },
 	{ "ad3552r", AD3552R_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3552r_id);
 
 static const struct of_device_id ad3552r_of_match[] = {
+	{ .compatible = "adi,ad3541r"},
 	{ .compatible = "adi,ad3542r"},
+	{ .compatible = "adi,ad3551r"},
 	{ .compatible = "adi,ad3552r"},
 	{ }
 };
-- 
2.45.0.rc1


