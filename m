Return-Path: <linux-iio+bounces-19157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01BAA9C78
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A25C17EBE6
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1B2701C9;
	Mon,  5 May 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gor1w3At"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F19270ED2
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472948; cv=none; b=hvWhlynb1Ycwh14iTB50D87pn/D1DmFZ5OXfR2BMGy94aDTVbZr37U8f6z6MZjkx8gzKOV2ize8fnlXLOW3L6YWTp4bYoRyElOHPaFqYo7fUo6r6/ITJATFcxKT8VUrGbdLsl0SrnKXv+v07fwvSSP+0DMY0hBUE3o3ncHJCRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472948; c=relaxed/simple;
	bh=xdk6B06tmgY9ATiah0v7Z3HUvSY740OqYH7HU5ty4LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=takmdoUHHv4e7+wmexd3p+BFJqjSxwBsCmREaPb3AK1OsNBXQXpEZhcM3/W/MHPisDi7ejJndzgOZ0PVfknSR0YV++762o0HiVIMzCv3y+r2l67x0M50pXJjPC1/cRHG6hQ6icNfyhZSRK2WahWe6NLOsF9QOO5JlEDgVuWNEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gor1w3At; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72fffa03ac6so3631251a34.3
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472946; x=1747077746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/a0RBhJEx7535RC8mznuBrCzNJFxgM/NdcfXT6UDhw=;
        b=Gor1w3AtyjHgb+sbqubhkWPfIBjT+RNkml4VfmoMfO++X6Am/PwIvLfFtJme/023Ft
         iMbfTkoIBjNXaX2TkjinOxiWF67nid9mDMWsCumLKgzYW86kfV0r8v8I/IjYSlw6U6oe
         2ZzrbHqHHGOSpHbWVRke8voL1H1fyeC7Vs/QSqEIvYj+FI1KY985mVp+nmttaSC6VDpZ
         ZIYTBChvtOCogLZxpjaDobrdmGPmKO/ZVPe9Eo7Jb6GHyGdkqxgeJyBA5Nh/x1/EmOTP
         6wPO/lSfAuzdXwNIax4U4FBg7glUiakkLDTBC/552v3g8N2bMoasAPYj04OU4KItmmpu
         +PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472946; x=1747077746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/a0RBhJEx7535RC8mznuBrCzNJFxgM/NdcfXT6UDhw=;
        b=ZLFiqZra7g7qGlcsb93Nalpur0LD747EngDRFSfH9/R2yY5k2gWVkywZAD9BsQVD/Y
         pS3KkJaQTcuFR4MufQGJFVlBEE275bhMxukyqOHjBU0Ds8g4BCND9gx+XCfGsNxp4UfN
         bhbTlSWmXGoYtntxLHEKDzSEeLkVYvAG1ry9EGAcVP623o9Ly4EhYRlorTZ4+PU56y0Y
         rOhqX1ZQB4g05GfRNJ1MNXZocj4NSNy9R22h1qjMAHmybwt0rogMnc/h2O+pNTFnIR5w
         gmx8xKLnvU4jWp6x9D8J1eyRmOANbbd28+i/+s8IJzFQVs3DI5jtdRSaZQQmX1dF09Pw
         iydA==
X-Gm-Message-State: AOJu0YwCmwU/DXAKkuRDMK7fHAfZCIRWFP0+h+Ph/TpmXyuPWo19d+sB
	eXiU9O5ceNfvG/bZA27MMuuvYWIIboQBQp3q3AR1HvtKWEMxg8f2IB+mZM66bKM=
X-Gm-Gg: ASbGnctatqUiIcZSa8Y0tIVeMJBOcg7h0SrBgfjEcYJgPikY9Zo2mU7S4L6cRBBh1Un
	YzDuhAre+qVCWWYLXJFD4p0E+ehJ0nZ54VrubEvhai/stYMh2zo9ksCBmmUuaCa6RtBtApwm2BF
	INWsIh5/FC5nEGT6utyBDPEz4sQxNc43LbU1CnHsfKHWP8El/3OLqb8liLeE2uaHYqtVWthHTh1
	zDyXJECJTusZkzc47rv458xhvG5YzAtKmwwlVEFAZ4LnvAPaIRQtAl09OuttOemlkpGt30Z+4Ld
	XIkMT8cw/tzU7jihW6l6L3nB8F9Z1sJj8z7vNp8cxVhVOg==
X-Google-Smtp-Source: AGHT+IGGrCMpDLPuOKXRI9c15nzmf/zL9tTSR1Gyg2mvogBPUEvxj42pzNLFt45pqx90ZIYzRcx2TA==
X-Received: by 2002:a05:6830:6217:b0:72a:e8b:a849 with SMTP id 46e09a7af769-731da21544bmr8445427a34.27.1746472946121;
        Mon, 05 May 2025 12:22:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:30 -0500
Subject: [PATCH 03/14] iio: chemical: bme680_spi: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-3-341f85fcfe11@baylibre.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xdk6B06tmgY9ATiah0v7Z3HUvSY740OqYH7HU5ty4LY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ+Z7KBtGvLxLyq1Yo2htifNTcYQScR2HsMvu
 T1/+EukjfyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkPmQAKCRDCzCAB/wGP
 wLGaB/9tomxJ+n/af60AzYPWMhlVzVNLVA52YqetGotOXkFfxOzYV+lXg4jyD2UE6iZzm17Kv1b
 BLbesYITByhPQiw6nIXtzcIWlHZghnKCIZLt+0HIB0TEXR93euuynFZRrxkcQ1B9RWbgogbYr6+
 Lyeh4x5DGr117k2OqqGAAxiiVGRNDIgEMv23m4Iq9TlttcXX8e0+sGjAfJZj8z+7lqKvXbGM4tZ
 kbbVa9Sx8UNj2qFiLq3BydC5qj71h9xEBC+lxedccihcFKLt7Pyl5S3hApSk6k9kxseL2bNVum2
 2TgvG2gogmQc+jM0qbcCnbYVTg2lG2Y4VAP/NHjBxNJBCoAu
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the bme680 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Since no other SPI settings are changed, we can also remove the call to
spi_setup().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/chemical/bme680_spi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index ced5af23846a73e0378dc936b2cf8c9508760301..aa97645ba539f6a591112d6554b893814d1ac418 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -112,14 +112,6 @@ static int bme680_spi_probe(struct spi_device *spi)
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct bme680_spi_bus_context *bus_context;
 	struct regmap *regmap;
-	int ret;
-
-	spi->bits_per_word = 8;
-	ret = spi_setup(spi);
-	if (ret < 0) {
-		dev_err(&spi->dev, "spi_setup failed!\n");
-		return ret;
-	}
 
 	bus_context = devm_kzalloc(&spi->dev, sizeof(*bus_context), GFP_KERNEL);
 	if (!bus_context)

-- 
2.43.0


