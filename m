Return-Path: <linux-iio+bounces-6121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CF9018A8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC116B20CF2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E476612EB;
	Sun,  9 Jun 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsmjDCgz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3055897;
	Sun,  9 Jun 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976316; cv=none; b=EZhkWMIaSAKk2SvkgXOqZ2mPm2wQbzt3aFT/ocsNeaMCi6nEmKhFKiywsoXH2woZhxfMTLOjprzaI4INFCHFASIGhay7Q8SN5ldPHpP9LKA8O/yiiuFUi5IzcJ98aXlU+mSEabpbd6/XninHFJNFEPOow4lpW0E0a1Fh+wuknr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976316; c=relaxed/simple;
	bh=1pI+RskQLYcBfoBZQPErDhhZ4If3D3khsanqjKzqRIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSx1fyXwX/b7gilACAgSv1gxzosLtIzhiUY5gbJRgO45xgBeO5Y+B71TMsRxf8g6Wh7H8hFWFaBoR/uTFhDaLYr08YWUGSL7tbM3QO3qAKz0JYrRHYGuHEbzEo4xK0yy3/kfyVZEWbMShv/4lby2m4yVkVi3nyKL50S6Olcb91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsmjDCgz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso387154166b.0;
        Sun, 09 Jun 2024 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976313; x=1718581113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmGe6IgaisQ6yWQUR4FLY7pJHbk0UKhP5AWLH74fYp0=;
        b=dsmjDCgzjwv6Jmcgif+udcZyIXTI1wXApTTFr5cZsfxJrsX7RgILkMtpxSRMoDLehJ
         8Q10NHkfbTHd3MLOmYHy6W4bqG8dnuY+Nde3QmFnypFRiZOOJ5tJ7nRu6UvboT2mu+Oe
         NSdMoXEqBZJ2aW+cf1YgFiPRh+yCIqcrRqcSSQKbtx1Td1uya7+J3182pDcno5AflMc4
         hFn9HTLdrcMFaA0a370DXwCaJv0MWIRN0GzwU/XbamEKUvojfghIw7dQIvkxpXM+bF4R
         fNEwp/YCz3BZVGX/QgzBAQ7/JgQG94xP/dgOcjp0uOTcBT9nE4cQSHoJa3vrTc7kCdc+
         sQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976313; x=1718581113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmGe6IgaisQ6yWQUR4FLY7pJHbk0UKhP5AWLH74fYp0=;
        b=iqN+7xzGdkQuUb+AS12rBNpo0KcyEAu1IUSVF4pCME2f+B+zK4LrKRGKoYFK6w1XB3
         5I/kR8qNUP0La/DS6CkY9FhV49dJMBwI2JIY64rnlHvXgPPgeNEVFTw9oYdIcBsmdzx5
         0STG2Y9NK445SEtDnxUpFNqeJkAFyxoiQ/BqGZos4dQBYdTLb61i2CvUEb22b5H9U/eH
         auTZqQJwJ7KSplYcZ3rYa+FsUTdz9KoGqJ03DZlYP9uXOSnZzQMY1QajutIJSXrDzXO9
         TbvldOeEbaqxzmjKBASrQ2pqzwSYjNsY9P9hHS/6zHTBK60VqQaH/Bx2gM99sN+dkTx7
         wC9A==
X-Forwarded-Encrypted: i=1; AJvYcCUbIJn33V3xeO3pi46MRZopqdJ4asbqNOKzZN+YFAs0KTywsxRAPQ9T9yt5YXxW9o5R2Hz0hHvd7g8cb8byjyxXlbtjU9lZ5gjla61w/gTsYArbHQDG2q61xL7eUFWzCw9+LfMCPlH9
X-Gm-Message-State: AOJu0Yz8cJmpAilOGry7HI3jbtrwD9S9y0QC2LHqXD3+qtFpBy5USPY7
	/+yShOj2Od8L755hbAGXBOAMw8W23XV31uYhBIp2egHlJStwBjdN
X-Google-Smtp-Source: AGHT+IEO8c9kuDxYfO+kLN5cE7CdYnL2Lshd1/TpbN4uKYjiE4UXKqPgWt/IEBexslWnZvaW2oL7pA==
X-Received: by 2002:a17:906:fd85:b0:a5c:fc25:2730 with SMTP id a640c23a62f3a-a6cd560faa1mr633129166b.4.1717976313579;
        Sun, 09 Jun 2024 16:38:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:33 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 03/15] iio: chemical: bme680: Drop unnecessary casts and correct adc data types
Date: Mon, 10 Jun 2024 01:38:14 +0200
Message-Id: <20240609233826.330516-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete any redundant casts in the code and use unsigned integers for the
raw adc values.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index c1a9ead1397e..577237d4c9f3 100644
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


