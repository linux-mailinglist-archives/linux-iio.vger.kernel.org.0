Return-Path: <linux-iio+bounces-5370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2F78D09F8
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616671F22D3B
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342151649CC;
	Mon, 27 May 2024 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX2DVLdD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D8161310;
	Mon, 27 May 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835103; cv=none; b=Kl9/OLNw9kXfASd7OtudgGWu8rGWyLKYYnudm6/kkTYVVzdyDOmIZ5aN+YRjsXlWq9oe0fTAilEzohZe5AGyG7NRqVa2M7EQUiHiOmGv9QXSV1Q8MY1zTEJM+YI/UTqKmJcyzpXOiMEm7UOblyFnk45bVTvq/fIr/KhhSPhZbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835103; c=relaxed/simple;
	bh=l75cUOo2NDHJxIM4ha1/avmw+UeLGzAofdLHBtFREIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awI7DZa1U5WvtU0n943cIcVrQvnmNtxBTBtZVGKDA4Yj2Aco6gSCVbgEk+zI67tnRR3LLqgeDV++1obghOxCbHxQBcXuF4BjEbrGMDljMoisARHX3Tyt+VxnB+0q/KdgAIby5Ut9f3FzsgZ2ijxd8fWXvZQDsjpUlY9fsGADiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX2DVLdD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6269885572so571876666b.1;
        Mon, 27 May 2024 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835100; x=1717439900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuqlsXLohE6qQ71Dzy+mKgn30/PQTvYM4hBsATK0ajQ=;
        b=NX2DVLdDFsYRvWB3x+PH4bwrsNZ/rs3+iWqCXKvpLhXIvk3STu0IPxgC+BU/II9QoZ
         5szlZWP8+qfIdn+fuAOVBnlCBxBei0FuC2quA5RZsMhgyGWEWzwOq2od8t5t8Azwx5Fs
         Ygxzg/sB12aAd8wvjdvavhwY/y64JI3zoeWtmUp1iVOnNTrwwvouzpeELX1k3/H3LOdl
         JrJ5PaeOzz+UmfUZfnQeUG+Y+xIf8GKzNTCKSVHz/0N5mc4SOMdFvIrOUVVYIi3tkn2i
         IbxY4mvE8IgWAMWaGCcjJAej7VrrMzRFko8YooJ8aCldbqfkFz4S6FkqF9tgWLIxp4UW
         i0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835100; x=1717439900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuqlsXLohE6qQ71Dzy+mKgn30/PQTvYM4hBsATK0ajQ=;
        b=nLoN8MQtxpXbyA4FmBgQ/kCrvVuxKHAFKZr/zAvIeWYG9cFmVOOE7hhI/4uZ9Fkhwb
         vh3dLjqkL1ciINstBg5t+NsmRN7BuBGOMDaQ79/MN269lIqqsbHYtQJ01Dqy4cROxFGJ
         KFnS6c0nr2suEt5awJ5fH013Si0UGRAmkQAdGaHYam403XWsPw3GzodoYdGnlI80Nxq7
         4IXaviQ/fpTfyerfqKhWg3bxHNTTwBXzDyX5VQpx7yDsxTgB8IyiUHZmC1xLLBImVYvZ
         gL8R/IMJUDDo0+3UaJoYaciGE0DipEThX4v8JlPETE643QRZqBsk5n6rA98ci7qefNRj
         WDDg==
X-Forwarded-Encrypted: i=1; AJvYcCWweMXjF2ELRCxAxom2EkOuYl6M9klrP1Y+DxurxNBiuwrLxi73bmDrLRwy9e8QI7eyR8KGcJjFuH63jcOj97QL45duRqM8yjgRIYNiH8tIB7JX+xASOB8PX6P3mK3fp11qCR53kJED
X-Gm-Message-State: AOJu0YyojJ7i6AZxGgrntGBBh0FDB3/HWTjW/5FOFI+zcmRTUuxiaV6B
	yT3jiN3yZDASelodrDU8AI/lE098u5Z3d5BCpqdtURzSAtH2Vnaf
X-Google-Smtp-Source: AGHT+IFqKc1xrLmvQjz5yRBer9pPgikq9Y1bUIhZGytj8irOag4w79YZBeoVZvTnzMo08dftx0Ewiw==
X-Received: by 2002:a17:906:6a25:b0:a62:e450:b147 with SMTP id a640c23a62f3a-a62e450b652mr463276066b.29.1716835099744;
        Mon, 27 May 2024 11:38:19 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:19 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 07/17] iio: chemical: bme680: Drop unnecessary casts and correct adc data types
Date: Mon, 27 May 2024 20:37:55 +0200
Message-Id: <20240527183805.311501-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete any redundant casts in the code and use unsigned integers for
the raw adc values.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2ef3fc7effc6..7607c3167e24 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -335,7 +335,7 @@ static int bme680_read_calib(struct bme680_data *data,
  * output value of "3233" represents 32.33 DegC.
  */
 static s16 bme680_compensate_temp(struct bme680_data *data,
-				  s32 adc_temp)
+				  u32 adc_temp)
 {
 	struct bme680_calib *calib = &data->bme680;
 	s64 var1, var2, var3;
@@ -345,7 +345,7 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	if (!calib->par_t2)
 		bme680_read_calib(data, calib);
 
-	var1 = (adc_temp >> 3) - ((s32)calib->par_t1 << 1);
+	var1 = ((s32)adc_temp >> 3) - ((s32)calib->par_t1 << 1);
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
 	var3 = (var3 * ((s32)calib->par_t3 << 4)) >> 14;
@@ -410,9 +410,9 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 	s32 var1, var2, var3, var4, var5, var6, temp_scaled, calc_hum;
 
 	temp_scaled = (data->t_fine * 5 + 128) >> 8;
-	var1 = (adc_humid - ((s32) ((s32) calib->par_h1 * 16))) -
-		(((temp_scaled * (s32) calib->par_h3) / 100) >> 1);
-	var2 = ((s32) calib->par_h2 *
+	var1 = (adc_humid - (((s32)calib->par_h1 * 16))) -
+		(((temp_scaled * calib->par_h3) / 100) >> 1);
+	var2 = (calib->par_h2 *
 		(((temp_scaled * calib->par_h4) / 100) +
 		 (((temp_scaled * ((temp_scaled * calib->par_h5) / 100))
 		   >> 6) / 100) + (1 << 14))) >> 10;
@@ -637,7 +637,7 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	__be32 tmp = 0;
-	s32 adc_temp;
+	u32 adc_temp;
 	s16 comp_temp;
 
 	/* set forced mode to trigger measurement */
@@ -681,7 +681,7 @@ static int bme680_read_press(struct bme680_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	__be32 tmp = 0;
-	s32 adc_press;
+	u32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
 	ret = bme680_read_temp(data, NULL);
@@ -713,7 +713,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	__be16 tmp = 0;
-	s32 adc_humidity;
+	u16 adc_humidity;
 	u32 comp_humidity;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-- 
2.25.1


