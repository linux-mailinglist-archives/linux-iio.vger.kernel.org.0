Return-Path: <linux-iio+bounces-18437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E5A95171
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527617A79F5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC126561A;
	Mon, 21 Apr 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPp/hyWx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C81DED63;
	Mon, 21 Apr 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241358; cv=none; b=gs60abVRGx8w9hHgMFnCXScF6fo6FGPOrqaXT0yvYQoxt2NZFLbhN/8H6mhv0lVSaVdGmMvbFsbYJA/irBlFvakMHyNO1JptfdpuvMKO+heRuhuFp+axNGMCYdCS49UtCIJTlSOrsPESGBsmAs3tEHd7agvkYMWiX8pMmfnGJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241358; c=relaxed/simple;
	bh=vqIN4spBQeK7QHzc7uNdXC3miJFucfrtR29H2awIC94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h99Ok0TGmxxo7oOt+XFe4s9JajUtoBkzFXWAhep8SzU5dsC3DIB6nCeBKtDloATG84LS4EWzkLq/csLOS+HfFM2zMt/A+MyC2jQ5pHmW0177NPHHhChwDQDkpCQS2JYcbuIXV8y1PehAOgT17n16o20XQrTTHeMTUdst2htcZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPp/hyWx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f2b05f87bcso40056776d6.3;
        Mon, 21 Apr 2025 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745241356; x=1745846156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o004w6PxOK9088i8LiB4BRrBgsNqHpUt0xgvZEh56tg=;
        b=YPp/hyWxi4mWAwKi5e5zSQW+TmuYs5Sy/1YeYhYP2NdKb3CduVOIbuQS1ayueOE3cX
         Po3Txje6GN861fovswnZo9G+vUNI8ciDqv8WNXQRU3YiyFoPCf59BNb3fjhI6Ys1F7oF
         EaLcYnplVK30lgvrpoAinaM10yV0DLCRdOleR4KW+bACrzAfXPmHSI7UebHwCuoiR2ve
         Cx63B1g6fp0mAHQzVYQEOVhx9Hp/amuIDEwQ8BhWJpZbTupQQAactMxl7TMxX/PPlRV8
         Ev8NUC6c/sdmrL9D//Dm+HH/JUrWDC+IBsq9/WS4+ipcAdBDeKlUt2W//IAXd1jKVTwS
         XS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745241356; x=1745846156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o004w6PxOK9088i8LiB4BRrBgsNqHpUt0xgvZEh56tg=;
        b=gKdxLYzAXc8QQhzqVxpH2f1awgB8rsFCDS2+nHX9tbek9es+2hgnUbrIB6YRqft2Xv
         IKCIUkrJ1nPjJbTdW1hDJtUFNRA/lvlZnEXxISogtYiYQZ3XSU66s+673s6kxgAokva3
         BZAbAPdQsDK+ur1pDfTLQsae1XnchS0Jsv1Gis4YdehaEXCeChnYJMv/uwEq4HBmsl4T
         QRx2oakksHrT+seI0xE/pvXm2zppcbKvzkzUu+/GHZRmseuy31Sv4y/kEFs5pL7UGgeg
         6GjWc/VMXPdKyjOH/iB18YUNDL6acnN5vjaEVhj6ZFJuJLXmWGJhYtDuisvB2HM9tlX6
         +SVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCqjw+6albbW6gIXQSt1WzA72DQ+REEQXud2/M0gv2tOS8aIV0aueNoiAn4bRBBhrekXyzXY2c@vger.kernel.org, AJvYcCVz2HCW7xDVVrqOsaut9Y2hizJaG7AqJZAKk0CFh/CuSpWU3aFzkxX2eSeY9qDQOqV48azba3VuClNJOrcB@vger.kernel.org, AJvYcCXPZp5uDHjEg9iSvABjtuVB8D3G0OvJgqbJY5lk/CbCbaHs4PQdRHzhqkkb79R3GqcmJoe1Bfo3nPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5H10L8HpWygxP1r+uTXZHqa/QSYKTCbcEz71/yrBry/hit1Y
	g6Y+f/PmTM9bxvifIjnkLcqKn3xaexnPBBmAg7qjM8a/9hqWhNJC
X-Gm-Gg: ASbGncs53HgbirSPk87fOHjTxUomOX70mc2vILQbEluCxIEbXChLw+y3USs+iwFpk2I
	brsvZVwIMPFuHfDw4GzckjkchrkFPJZynl4zPsHbcd3Fux8EiGvla0E7SV+EkUkmbANX67IZvMc
	LHwkfn9Mu8hORg8s9tsIS5a0BONTXwUUfq2qOWXzAmvMv11HC7fYPZdQTgciF+QVxgxODMf7mZu
	3xUTSOtxgAwkR1dORJ7GJkeMrglJDsVDTGfb9oN5qAtBsqPqmDWrbhrsiyDjv7dLriKLRaKUyVW
	xUPwdi4rjKkhmNmoKSMkJPn9c/pIg6nTgGVUK17Zm/FV76B1tTWKe+G74CY1wL4rGg==
X-Google-Smtp-Source: AGHT+IEWBfCVAOXcUeFF/010CnRUb7fPPxCRQbrwrjJ+7VllZ6Ahm19o/N9f/euG42Wg9GTMhpL5NQ==
X-Received: by 2002:ad4:5d43:0:b0:6e6:602f:ef68 with SMTP id 6a1803df08f44-6f2c455698bmr277444346d6.10.1745241355667;
        Mon, 21 Apr 2025 06:15:55 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21d3asm43579276d6.100.2025.04.21.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:15:55 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	marcelo.schmitt1@gmail.com,
	Gabriel Shahrouzi <gshahrouzi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Date: Mon, 21 Apr 2025 09:15:39 -0400
Message-ID: <20250421131539.912966-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421124915.32a18d36@jic23-huawei>
References: <20250421124915.32a18d36@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inclinometer channels were previously defined with 14 realbits.
However, the ADIS16201 datasheet states the resolution for these output
channels is 12 bits (Page 14, text description; Page 15, table 7).

Correct the realbits value to 12 to accurately reflect the hardware.

Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/iio/accel/adis16201.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 982b33f6eccac..dcc8d9f2ee0f1 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16201_channels[] = {
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-- 
2.43.0


