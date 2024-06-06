Return-Path: <linux-iio+bounces-5952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF688FF6B9
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FD42855F8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F619AD88;
	Thu,  6 Jun 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcR6tosv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97319AA76;
	Thu,  6 Jun 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709044; cv=none; b=H10OhSSngirxfCXpxh20PUsfM0bM73rqMgDEjlHCNHE0Hwb+JRZbCj7feibplwGC/ZCRlu3CqfZy/nHRTzEA7bKKPtxpWyGzhWodZA6U4WJlHcO0CbwpJZyK1vXLzIijSJxJgyvsoDiT1e3VigbfN+oalYb/+0qALaY1KjYtvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709044; c=relaxed/simple;
	bh=XRjEdmjbl3tze6WqILeOK/Eq4Lz2TZ780ENtcA87L6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axssteXlNry8rRvDCfXRSFq+kksnSu73ae8uPJhWiMtopMg62apfvmIsA5w1Kn6uQQ3tSgB5dBUGb0OGNJociCf/Dygp3fD5hY5qs2bjM5kB5SOgPKMJHyGmKaTSYRV9gtDa/NAF0e+LqwYZ5q7gtXJ7Dq6+kNgv0CyAyhqIrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcR6tosv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso1838686a12.1;
        Thu, 06 Jun 2024 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709041; x=1718313841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkKE8KGpoBxtr96EwcylIF0dTKX3Ea9TXgIZr2Hk6I4=;
        b=AcR6tosv2uowIZiN79OgZqE/DlIg8xTLsLFxFnnPKL6R1M+YPvXmCSPPYxKh22LAdM
         U9tulh1F2GcYod17kbC6UCFk60e4MFrLUMAnhFqhmRqr0DB2rx0XH++oxBiglFMqyXTu
         A8D2KS8KaMnnAuP2yLkb2Fv9e/9VSWyXiaMOUijvRI1NOXe8Qwe8Pg446KNzd50Zaoc7
         7skGWkY0AbLv9q1/Ymg+uWb4PwwLM7rlb9EPI5Pn2mbBICv6D562o6yv8L5ktPSeMOhM
         SXSpMTUYyhKzchmvM10cVhhoJ+h9ocdYpvIPCWWlepEmsBofrFAlcoL6j/TnI9plsYte
         nZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709041; x=1718313841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkKE8KGpoBxtr96EwcylIF0dTKX3Ea9TXgIZr2Hk6I4=;
        b=jIGp6FNc13Mkau1yWnu7pFCqvetcjDCGYwaBRKsD9tisK19/gf3Jdld5zBQW3PtuVu
         99tfK7+4Pc9DBqIwTuoivZtulLCY9J6ilYI6Cy0Z4A9V77HIwfSuucCQPIqmAgbtaw3I
         pE/EoUtJSB0TzeaWZyrTHaezZn556VwkcPPsf6W96A4irdQDbjrVISDIJeWVh9oVfSuC
         /WgeTMFzJsOwiciwB9B5eUvqHkpYneGFQfArGs4BVwC8WRGvdyShcxX6IlR0SmVuDd56
         dFohNKfcUn0NJMlyGPFEugZXgjjnwB46eVsrhtHtVMosBfqcJoWQgx4AE7f//YAwSfgA
         KLYg==
X-Forwarded-Encrypted: i=1; AJvYcCXRjA1tg4NmRw60VKdsMP1UYSjNDktiMU2d2xof1du/mq8h6pUzay4Y4cx/P3O6IgKgvBtEtYBkxVZXlpaCb4KZmvi3JEwcV6zfdWf8WipwcT7JQJo8KSGCLj8gJs6NlDY0IBd3Lbw2
X-Gm-Message-State: AOJu0YzePHmq4QIm1LW9Mz3ruVjfuezDiQlD/Pf8SweQIp3tusFlW9os
	ptkFVtlFxneIkkpEnrwBrGs2fUV2EtT4fTRhl12Nh6GHi7dFPZjo
X-Google-Smtp-Source: AGHT+IH6yk6WxvT6aFN/dXKSVGI9afrPiiB7CvqU4TJYrzJdlt7UvHLyk+iiMH95jh+qTP76LxkFkQ==
X-Received: by 2002:a17:906:22d0:b0:a68:ed0b:8924 with SMTP id a640c23a62f3a-a6cd560fab8mr45684566b.16.1717709040805;
        Thu, 06 Jun 2024 14:24:00 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:00 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 07/19] iio: chemical: bme680: Drop unnecessary casts and correct adc data types
Date: Thu,  6 Jun 2024 23:22:59 +0200
Message-Id: <20240606212313.207550-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
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
index 92359032254a..acca2e516157 100644
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
@@ -654,7 +654,7 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	__be32 tmp = 0;
-	s32 adc_temp;
+	u32 adc_temp;
 	s16 comp_temp;
 
 	/* set forced mode to trigger measurement */
@@ -700,7 +700,7 @@ static int bme680_read_press(struct bme680_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	__be32 tmp = 0;
-	s32 adc_press;
+	u32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
 	ret = bme680_read_temp(data, NULL);
@@ -732,7 +732,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	__be16 tmp = 0;
-	s32 adc_humidity;
+	u16 adc_humidity;
 	u32 comp_humidity;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-- 
2.25.1


