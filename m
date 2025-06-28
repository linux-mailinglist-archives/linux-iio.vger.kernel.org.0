Return-Path: <linux-iio+bounces-21078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8820AEC98A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BC33BF369
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7401E286D7A;
	Sat, 28 Jun 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0u/vyFaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114525A2A7
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751133179; cv=none; b=fZDzBQ3AaOKE/UsR7I2fWju6jAwIBjP4K+FsXPuhUy3wmaoxjLi81wxxsLvRX3OLPUM68pExWMJpPCni9GXYlJ3DyIgS9zhSKWjeZSs3nm1WUw8UT1v9c2gkNA1AMzkF1ICWgteqHC45eulY2nf0lElv4wEPm8tacNIPGPSjK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751133179; c=relaxed/simple;
	bh=HwZVNJRHlmnj9p9W6rHIwbWpVKaSVUJWBS6DuaB3HeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHf/mR+k0zwmZ4TOR3r/ljkfkL2/1BJ42iCjYH6sE3ZlvjLZIiVRiTys2hnpYnzHPNKFEiqR3r8r54pBKlGuykD1AMXXIwJAYUEbxull7PAf0pINH9JZhhIwo+8Xmp+Kf5/I2T8FUgclfhpU7Ifp5n3LnJWEsHdpTlIdtTrBDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0u/vyFaq; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea34731c5dso521323fac.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751133175; x=1751737975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuUZifK2n0avjWFvzjHdGhgHXYgsXuK/FTKAkLBN1FM=;
        b=0u/vyFaqDJJjhpEfOWmk5W8u5ihubD7Irzwy77MKxtU0n2gcHqGzjNC66qg/E5o9gh
         U6nC1qJm+yEJ6V7pRvrEuj8ok/ZmEXiDkc+/Mc3GbQuWw9RwPJfLzR1b63Eqx8BQh7Ao
         he7PYNf1MYpe8uGqb4eMDIoWxzQALsinIKoE/XSEDl+tOhJ91+Q8K6joWorM/mDthLTO
         2BybzaDRVNDAZg8nCF3cA5x70ItOQZTXSImbYdMbhjiG+01vOMUtnyhXQALMB2zPJzvG
         Aq6UupcBy74vpaBvz7y2K3hQdFD4Pa2BFSjBgTbKUqOtQij6BkKzpKotuyeBxEVfTwDx
         im3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751133175; x=1751737975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuUZifK2n0avjWFvzjHdGhgHXYgsXuK/FTKAkLBN1FM=;
        b=oxDKygFadPJoCG/NN+qJX9ANSM7EZSePilz8jYqvn00yTmMFx8uo8zU6/6ekbJsg7j
         iI8fzu/uNJqYi8nq0ozNoh2VUKsZd1psYdlCXev66hoH6W63/e5If+fwmlgtQKUC/FPy
         +qR1wkpNxdDTr6IS/LMtcstmxYjRoBHDfS/pZLBJhRxa9rLvEzhzTJySN3GCHYoO5vz5
         dniBJ7NcFm/UiSPLvXdi5ntI7ogzRbTjWs1WPDUTY7ev5tNGNfQMJCtUmKN5jM65OmdU
         L7JhbiUP48B8bYrULUtf36AWWbxL9wLfqqpG8DQFicZLBsBsPw6aG7FHL8W8aYsHMwtE
         Mdyw==
X-Gm-Message-State: AOJu0YxKRqwsyMDPS2BkcGA+GRutvjYu7XcArpGEbmpjoiwHJtR7i/C/
	CUvBwbkzD0AX4N4sokxY3g+WERqGDQN6fc6W0AM+S7Izpqr9xZ1W0dQU1Fq7JP3vixk=
X-Gm-Gg: ASbGnctpqj0uOA0l/8/71E2Dfd0lwEWV/ikyLhLlyAJN1M/a+1aZCmfvhKtDe7XS1qx
	p+CXrQ0ZaZsjraiixVY8Xh8kizM8daR9Lv6xRmGF1+msPlaeVTaMuKG4Fx2RJYjTE+6mlEgdBG2
	JeL6tLxvqUbOUERYPzfH41YR+51E4Gnl2/GAWHF/puCDWhxoTlON7N5vtSseghY9wD8bS6SUQ10
	aLLPRccVLwbZw/p2oZaYmTVVuyEQm29ZVUckD1Cwl9BokEeIQMKFJDfinGUQBuTaTnrt2c0/SkK
	w3MWEy6mZwFf+SgngrpxITqi66U3/jde7cPR9vslJ0P+rBSHooh5iiEPvn//m+4GhRvd
X-Google-Smtp-Source: AGHT+IFV1BzZ4kGHJ8cX8++Ttrj1FNUBznzNCJSgyL5m3JIEqd0UkaCsyuFgEBReyQPOCaGQMfUKEA==
X-Received: by 2002:a05:6870:610b:b0:2d5:ba2d:80dd with SMTP id 586e51a60fabf-2efed474d8amr4775499fac.12.1751133175567;
        Sat, 28 Jun 2025 10:52:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b4d84sm1593530fac.23.2025.06.28.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:52:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:52:30 -0500
Subject: [PATCH 1/2] iio: light: cm3232: move calibscale to struct
 cm3232_chip
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-20-v1-1-2bf90b03f9f1@baylibre.com>
References: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
In-Reply-To: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
To: Kevin Tsai <ktsai@capellamicro.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HwZVNJRHlmnj9p9W6rHIwbWpVKaSVUJWBS6DuaB3HeQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCvn66JVEyxft9qnR8O8M1QWUxrQs0q4EuVvb
 0talSGYXGiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAr5wAKCRDCzCAB/wGP
 wDAZB/oCHCsvhEZzwlg+zP1GMIVVIl/5iSOMpHhqw+08H1G+2RMpZ7pQyEp2SJITveI1yi4shtF
 veWuH6Ve+N0W6ORoYwZNnHiuBEm9W51kjDfhgonTrDILeuGEbLB3C28B23sRZT6SbbtJYpx6MyZ
 4DfZKC8pcQJ8J/zEZJufdwPE6fIX0Ur0riKfjjNf4BNPBH5ZXtEZ5jVRPZe0h5zMIFeP9yK30eO
 agorW2DbK6eqHhUdZQ4iEqFBlPZWt3yU1dznpHT4hJ6Tosb2EPggy76hK99f11+c8Hfuwel8/YM
 mjbaZ/ih/ywerka79Gqoqs7TkOW9K+jHncqiWEJzNeD0u+sP
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Move the calibscale field from struct cm3232_als_info to struct
cm3232_chip. The chip info struct is supposed to be const while the
driver data struct should contain mutable fields. Since calibscale
is a mutable field, it should be in the driver data struct.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/cm3232.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index e864d2ef036e87b7a3ca286770594681eacd8e58..b6823a5a0860a32a65b6e3e76b4e22bc9cd14312 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -54,7 +54,6 @@ static const struct {
 struct cm3232_als_info {
 	u8 regs_cmd_default;
 	u8 hw_id;
-	int calibscale;
 	int mlux_per_bit;
 	int mlux_per_bit_base_it;
 };
@@ -62,7 +61,6 @@ struct cm3232_als_info {
 static struct cm3232_als_info cm3232_als_info_default = {
 	.regs_cmd_default = CM3232_CMD_DEFAULT,
 	.hw_id = CM3232_HW_ID,
-	.calibscale = CM3232_CALIBSCALE_DEFAULT,
 	.mlux_per_bit = CM3232_MLUX_PER_BIT_DEFAULT,
 	.mlux_per_bit_base_it = CM3232_MLUX_PER_BIT_BASE_IT,
 };
@@ -70,6 +68,7 @@ static struct cm3232_als_info cm3232_als_info_default = {
 struct cm3232_chip {
 	struct i2c_client *client;
 	struct cm3232_als_info *als_info;
+	int calibscale;
 	u8 regs_cmd;
 	u16 regs_als;
 };
@@ -222,7 +221,7 @@ static int cm3232_get_lux(struct cm3232_chip *chip)
 
 	chip->regs_als = (u16)ret;
 	lux *= chip->regs_als;
-	lux *= als_info->calibscale;
+	lux *= chip->calibscale;
 	lux = div_u64(lux, CM3232_CALIBSCALE_RESOLUTION);
 	lux = div_u64(lux, CM3232_MLUX_PER_LUX);
 
@@ -237,7 +236,6 @@ static int cm3232_read_raw(struct iio_dev *indio_dev,
 			int *val, int *val2, long mask)
 {
 	struct cm3232_chip *chip = iio_priv(indio_dev);
-	struct cm3232_als_info *als_info = chip->als_info;
 	int ret;
 
 	switch (mask) {
@@ -248,7 +246,7 @@ static int cm3232_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBSCALE:
-		*val = als_info->calibscale;
+		*val = chip->calibscale;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
 		return cm3232_read_als_it(chip, val, val2);
@@ -262,11 +260,10 @@ static int cm3232_write_raw(struct iio_dev *indio_dev,
 			int val, int val2, long mask)
 {
 	struct cm3232_chip *chip = iio_priv(indio_dev);
-	struct cm3232_als_info *als_info = chip->als_info;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
-		als_info->calibscale = val;
+		chip->calibscale = val;
 		return 0;
 	case IIO_CHAN_INFO_INT_TIME:
 		return cm3232_write_als_it(chip, val, val2);
@@ -339,6 +336,7 @@ static int cm3232_probe(struct i2c_client *client)
 	chip = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	chip->client = client;
+	chip->calibscale = CM3232_CALIBSCALE_DEFAULT;
 
 	indio_dev->channels = cm3232_channels;
 	indio_dev->num_channels = ARRAY_SIZE(cm3232_channels);

-- 
2.43.0


