Return-Path: <linux-iio+bounces-20922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EEFAE4DCF
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56FF3BC081
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95C2D3A65;
	Mon, 23 Jun 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPF6WXa+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D12609E4
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750708739; cv=none; b=OZdCOcoAUo3QTfzYuSIyETmievVh0xNMVbfFrA44ZOkTOfwMYB0Lz3FilkgfKHHdzp4Zz6fkwP5zE+CE2YCMxqlC/2Pg9x84+2MRWWGakHV6wHP8Qnxq2OL7LUzXgBhZoWlWvPHCxUjMGcNRHPa4rB6vhxKu5c1JSjuexaRdInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750708739; c=relaxed/simple;
	bh=MNeIDc41t2NITdv4R617R0WUzwLpWiNFX64vjrBtVV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5oPShLOXYptPTA1g8kAKvAMnQJuftUpGRupxU6sKFq1UYg4V3NjX94wodB1to9SAu6a+QiAwCbDF5xknZQif7yjPGH/s1rGv3B/MO2Bfr2L50n38udZY7aW8gMQWqNvs2+m+BuPSm04al6GhFzfx346dClg8r5BeIt6barnvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPF6WXa+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234d366e5f2so60637455ad.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750708737; x=1751313537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=jPF6WXa+Z5koCTVDr2elmk2kaj16o1gMA7WeYd53zw1Bsiom5pAAkFYIQdK7FgSj8v
         0bsvQeTEF6VnjNhfUXAwpGp/7B58MmHJF8qw5hn+ITs6PPmr6OAB0J+DKeqDhSEw3gIH
         39D69gFFYcxO+hHlPuMZJpvQQjBIrbjDmRRDBIRSuB5FN6NlxKyhxmYtC7mcTfh/APil
         T9mejEndl1yEIRYYbs0bx4Zt6Cki+6HbieclJESuQeCOWt+KjG0tXE9Z4G/ycAP6LTgK
         6+181UXN/AaHkt4mZNO1q5UZZA4QZ+j7IF2C0JGgcRLqSQDb6G7/R3u0MkjFNzUxQW6I
         8fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750708737; x=1751313537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=lFA5ltv7RgEbxr5+1huwWiNaCfgEVndyQcjrqsbjyKkA5gBHVfEydIt31LCTOweWMU
         Uxi7b546SnEyELr+cahmWEUYKixWr6KolDdbWI81YLl12s55QJTz8jofBeiV5dJ3ydk6
         1VmdQIN2AY1Gw2RyevwSfLFanBIz09g4+Ubqk0aeYLrvbEQzoco8cJLBvX7P2ciJMiTy
         Dh5p7VBcnm5ThUlMlB+ru4NnAWhr3wW6EQAv/SsRY9L8iYaxACumavmV2DNgRFHRmbz6
         OmXoKZJU1L/xJBzP8ZCud514N1IOSIwZUWEx5yxtBnrAGGZl/FEA75A3XhCmzYlkk/WJ
         yVvg==
X-Gm-Message-State: AOJu0Yz68yuLDJLMftCQdbzcFXAYjZD83CYSpVL++gEebq6/BeALKETB
	0TJtyqy3IlT5oJD1XI958Bcfp/Tg6+Xa14WkjerYS8TaOyjCaGahy62Q
X-Gm-Gg: ASbGncuhm/CdWCK/sMJUuSaBEKYPmMefyPaGExMAVzwLnt3MfT5o0c5ykI6jfnJDIA6
	7LTcq0LhMq6RP8G9RutCRcQaIBaVS9Bn1H868kt0LUAs1ekRT8iU2VgE6SMkC92Hu59ndFtch6T
	FrKkKyhycGk64YeF0vC1Vo0g0AYB81LtY9zAMWcuDpyy7I9lRcjnEFSWykBcea8QaU1BRot0XED
	66DGXvjdTg4Fva2OnuoYkEl1mO46egKK33RejiyDhtl/DpDudeDPa3lYLUvzUrv8pOQGTpOkFdF
	BKbA4CgGj0r1XRGaM9l/ETKxDX22TiHrGFsqDk1/OUgckQuFZC8d7Yc9dbrdzJpmE1Fd4sWpgVs
	HfEPUHPas8BikMAI=
X-Google-Smtp-Source: AGHT+IHjRgnKUrORphjXIM5Tqt8LY74ATtHJ5wPenylv6ntx+ueozicpP9TAQSebuFwgQqS3or3mYA==
X-Received: by 2002:a17:903:18e:b0:234:9094:3fb1 with SMTP id d9443c01a7336-237d9a7321dmr243546895ad.35.1750708736582;
        Mon, 23 Jun 2025 12:58:56 -0700 (PDT)
Received: from localhost.localdomain ([189.33.3.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8391574sm92528595ad.28.2025.06.23.12.58.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Jun 2025 12:58:56 -0700 (PDT)
From: Gabriel Lima de Moraes <gabriellimamoraes@gmail.com>
To: iio@lists.linux.dev
Cc: linux-iio@vger.kernel.org,
	gabriellimamoraes@ime.usp.br,
	Vitor Marques <vitor.marques@ime.usp.br>,
	=?UTF-8?q?Gabriel=20Jos=C3=A9?= <gabrieljpe@ime.usp.br>
Subject: [PATCH] iio: light : veml6030 Remove code duplication
Date: Mon, 23 Jun 2025 16:58:50 -0300
Message-ID: <20250623195850.11585-1-gabriellimamoraes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vitor Marques <vitor.marques@ime.usp.br>

veml6030_hw_init() and veml6035_hw_init() have very similar bodies.

Reduce code duplication by creating a common initialization function veml603x_hw_common_init().

Signed-off-by: Vitor Marques <vitor.marques@ime.usp.br>
Co-developed-by: Gabriel Lima <gabriellimamoraes@ime.usp.br>
Co-developed-by: Gabriel José <gabrieljpe@ime.usp.br>
---
 drivers/iio/light/veml6030.c | 187 ++++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 92 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 473a9c3e32a3..7959075b1ae8 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -33,6 +33,18 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+int veml603x_hw_common_init(
+    struct iio_dev *indio_dev, 
+    struct device *dev,
+    int iio_init_val1,
+    int iio_init_val2,
+    const struct iio_gain_sel_pair *gain_sel,
+    size_t gain_sel_size,
+    const struct iio_itime_sel_mul *it_sel,
+    size_t it_sel_size,
+    int als_conf_val2
+);
+
 /* Device registers */
 #define VEML6030_REG_ALS_CONF   0x00
 #define VEML6030_REG_ALS_WH     0x01
@@ -248,6 +260,66 @@ static void veml6030_als_shut_down_action(void *data)
 	veml6030_als_shut_down(data);
 }
 
+int veml603x_hw_common_init(
+    struct iio_dev *indio_dev, 
+    struct device *dev,
+    int iio_init_val1,
+    int iio_init_val2,
+    const struct iio_gain_sel_pair *gain_sel,
+    size_t gain_sel_size,
+    const struct iio_itime_sel_mul *it_sel,
+    size_t it_sel_size,
+    int als_conf_val2
+)
+{
+	int ret, val;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = devm_iio_init_iio_gts(dev, iio_init_val1, iio_init_val2,
+			gain_sel, gain_sel_size,
+			it_sel, it_sel_size,
+			&data->gts);
+	if (ret)
+	return dev_err_probe(dev, ret, "failed to init iio gts\n");
+
+	ret = veml6030_als_shut_down(data);
+	if (ret)
+	return dev_err_probe(dev, ret, "can't shutdown als\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, als_conf_val2);
+	if (ret)
+	return dev_err_probe(dev, ret, "can't setup als configs\n");
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
+		VEML6030_PSM | VEML6030_PSM_EN, 0x03);
+	if (ret)
+	return dev_err_probe(dev, ret, "can't setup default PSM\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
+	if (ret)
+	return dev_err_probe(dev, ret, "can't setup high threshold\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
+	if (ret)
+	return dev_err_probe(dev, ret, "can't setup low threshold\n");
+
+	ret = veml6030_als_pwr_on(data);
+	if (ret)
+	return dev_err_probe(dev, ret, "can't poweron als\n");
+
+	ret = devm_add_action_or_reset(dev, veml6030_als_shut_down_action, data);
+	if (ret < 0)
+	return ret;
+
+	/* Clear stale interrupt status bits if any during start */
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
+	if (ret < 0)
+	return dev_err_probe(dev, ret,
+			"can't clear als interrupt status\n");
+
+	return ret;
+}
+
 static const struct iio_event_spec veml6030_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -973,52 +1045,17 @@ static int veml6030_regfield_init(struct iio_dev *indio_dev)
  */
 static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 {
-	int ret, val;
-	struct veml6030_data *data = iio_priv(indio_dev);
-
-	ret = devm_iio_init_iio_gts(dev, 2, 150400000,
-				    veml6030_gain_sel, ARRAY_SIZE(veml6030_gain_sel),
-				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
-				    &data->gts);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to init iio gts\n");
-
-	ret = veml6030_als_shut_down(data);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't shutdown als\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup als configs\n");
-
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
-				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup default PSM\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup high threshold\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup low threshold\n");
-
-	ret = veml6030_als_pwr_on(data);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't poweron als\n");
-
-	ret = devm_add_action_or_reset(dev, veml6030_als_shut_down_action, data);
-	if (ret < 0)
-		return ret;
-
-	/* Clear stale interrupt status bits if any during start */
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
-	if (ret < 0)
-		return dev_err_probe(dev, ret,
-				     "can't clear als interrupt status\n");
-
-	return ret;
+	return veml603x_hw_common_init(
+		indio_dev,
+		dev,
+		2,
+		150400000,
+		veml6030_gain_sel,
+		ARRAY_SIZE(veml6030_gain_sel),
+		veml6030_it_sel,
+		ARRAY_SIZE(veml6030_it_sel),
+		0x1001
+	);
 }
 
 /*
@@ -1029,52 +1066,18 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
  * update registers and then power on the sensor.
  */
 static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
-{
-	int ret, val;
-	struct veml6030_data *data = iio_priv(indio_dev);
-
-	ret = devm_iio_init_iio_gts(dev, 0, 409600000,
-				    veml6035_gain_sel, ARRAY_SIZE(veml6035_gain_sel),
-				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
-				    &data->gts);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to init iio gts\n");
-
-	ret = veml6030_als_shut_down(data);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't shutdown als\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
-			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup als configs\n");
-
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
-				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup default PSM\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup high threshold\n");
-
-	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't setup low threshold\n");
-
-	ret = veml6030_als_pwr_on(data);
-	if (ret)
-		return dev_err_probe(dev, ret, "can't poweron als\n");
-
-	ret = devm_add_action_or_reset(dev, veml6030_als_shut_down_action, data);
-	if (ret < 0)
-		return ret;
-
-	/* Clear stale interrupt status bits if any during start */
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
-	if (ret < 0)
-		return dev_err_probe(dev, ret,
-				     "can't clear als interrupt status\n");
+{	
+	veml603x_hw_common_init(
+        indio_dev,
+        dev,
+        0,
+        409600000,
+        veml6035_gain_sel,
+        ARRAY_SIZE(veml6035_gain_sel),
+        veml6030_it_sel,
+        ARRAY_SIZE(veml6030_it_sel),
+        VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD
+	);
 
 	return 0;
 }
-- 
2.43.0


