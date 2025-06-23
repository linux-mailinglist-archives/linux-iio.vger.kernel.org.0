Return-Path: <linux-iio+bounces-20924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98EAE4DF5
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6817B70F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B02D5414;
	Mon, 23 Jun 2025 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AppH38oF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1242D321D
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709664; cv=none; b=LWtof32PLOBgc/9Is2spnGjYGlB1gcavF7q1bAyEcVS93S+n+AxHt677l968EDdC7T0Nudn/668lnXA5esJW0Ar5778DxMW4CzmQlRJAJ26foEt3RcpVDPrzhuqu2mKb4l2ZzGvGP/QeIsaIv0XCquEFy3DzfioS9973XU0jK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709664; c=relaxed/simple;
	bh=MNeIDc41t2NITdv4R617R0WUzwLpWiNFX64vjrBtVV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q0JwVS57x8WCJSR+3xjJXTjlkgfjhdYJRbnP7xa3RfUZPJlWv0DCuzrDUVncSKyPsnn4fMXXyrYUP9hNU07SDrGadTGf4qJQee+OsSafJJD4RTCGekU8rnGM+GSdo5Y3ml9sLOEd4HVDyOhSh/0PtRHXpp0d68x9iUR1DlOstIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AppH38oF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748f5a4a423so2825705b3a.1;
        Mon, 23 Jun 2025 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750709662; x=1751314462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=AppH38oFDWnGYnK+paknvvQYT6H6td+20Q8V4vSqTDXjnj6BhwlDz7bXuTTUkO0wCG
         yCzbdbJJE2kHl4D8x3+otgiS57Y7g4xUfUY7TRdO3eFE/zjNnA4u04TftzlNypnUWRC1
         L3lBR1jn4H+xA5BlqHSN599smanmYmxgia/Bi5aGbCqiqk9EKr1V5vBMx4NzkPa6QiP7
         bdAvKtAyPaFzk21AkHo10XrmpzIQW+SxGIkOQBjiWBi/PIxdiKO5sgNodaFuW2UywL/w
         EG6F93UEPV9epexwTko2zf7sws9TQYvy4DfXZmqYzJQ7/bRH+1ArtsmRXI2aM42y84v5
         qaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750709662; x=1751314462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=idt3Sc7eXybVNwfmKb9EpbRc8AMNRQqnZjWyjxQwXJBkTx76/QhTolcZcR4nB5WzdE
         2Dm5fW1DDuEyXr+p3rv4q3w6qgVr3UW69qVQ/nPsLF9IzswZpPHnHw40ny008saO/x5x
         T0qei4+dAENbm+aZNY8k7BjwWVHVX5gfoRIWnhUfIV23kCy+bKR0foSyJxJgoW8wifN2
         Z+SRU+6nYF9FtUKZDi4AWwWwhOkIlldmxMfYLd4bcrMLNMPursZKfps+si37ZF8hKcex
         u7p4nr1cqc41Q1Lnw/MuULs1a35p7IazW5tYZDADMdN7xmljpx+QrkC69gOJBxgrehyF
         OZmw==
X-Gm-Message-State: AOJu0YwFAOR/TliClQIdkQ95gkd+u/WsKtKDdBVRBnlOtTA8soU/e1In
	KljKciPYaeQyGoPSUInHLp6tixPqNheH2LcxgYnnaFZXHiKRy4OvN0mbg8lf1t1eIrM=
X-Gm-Gg: ASbGncvF+GRzx8AjaVtAoZlRLGlyx1oHWec1NSntdz4zKNGQLbnCQR0uU08bJtP1leB
	xeiVSgEIfnGEOP4DXNpYSgxFlEZlQjLtim8wgtdYVrKjW3bAF7kgYe+FgWyXMtgcLUz7t81RbbL
	UkMhZuI7PxG77s2SLkz15PTWn9Gu/GzaW4nQKMtHhPsj2vwcwLIAIzQC+OmvE6dSJKQUAbV3341
	8t5yztLq6I0H4e9A/lo4lTWu8frfKvjStFPOihQZu8tZmfqjTeAED1t0xxS5TuzwVom+1vVEDjr
	oYNvghJ6HnOzXGqSNBFklv8SragDXkKXyHnBHRlZHPBmL6GOVz5Z+gfkIcikig9ldTlo3zXBs8N
	mKgleq0II/3ZokX0=
X-Google-Smtp-Source: AGHT+IHs1HMbQbS8zI7elYdhMd2ui7W0e/WmYCliVwhaeOC5A/U2TO+NITm1wSMcO54Mw15RLCnngA==
X-Received: by 2002:a05:6a00:1ac9:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-7490d6fa556mr20140346b3a.12.1750709661705;
        Mon, 23 Jun 2025 13:14:21 -0700 (PDT)
Received: from localhost.localdomain ([189.33.3.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08c67sm4467b3a.17.2025.06.23.13.14.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Jun 2025 13:14:21 -0700 (PDT)
From: Gabriel Lima de Moraes <gabriellimamoraes@gmail.com>
To: iio@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	gabriellimamoraes@ime.usp.br,
	Vitor Marques <vitor.marques@ime.usp.br>,
	=?UTF-8?q?Gabriel=20Jos=C3=A9?= <gabrieljpe@ime.usp.br>
Subject: [PATCH] iio: light : veml6030 Remove code duplication
Date: Mon, 23 Jun 2025 17:14:14 -0300
Message-ID: <20250623201414.15764-1-gabriellimamoraes@gmail.com>
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


