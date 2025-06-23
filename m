Return-Path: <linux-iio+bounces-20923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A3DAE4DEE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 22:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D38A17AE09
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914002D4B7E;
	Mon, 23 Jun 2025 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0oM1FfB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F821F5617
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709444; cv=none; b=Mpzrc5zx8LyJavqf49KMwNHgr6YjHCYmuyDSiBhhVKVUpwgRaMi9DiYT+OMn0bfYn1rzvWsLgivH+WAlQD2ewnRvRjYfseOACSoFxboYtHAFmVuc7Clv4i171hPoWNwvyK9KA+7EWt8vECxS2Hh/8xVPtspeO8lr8RVcpu9NiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709444; c=relaxed/simple;
	bh=MNeIDc41t2NITdv4R617R0WUzwLpWiNFX64vjrBtVV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cEe+tfLZ4viKSBYaRiqSy76ZJiNdpk03kCdyLBLlRKiIM+92fNnaTGjX/Rjt5e0edEfhFd76blt2ibty7K+ArnGGJPS9ShsafyQX5zpGTiNmKWzPfKcuBba9Q25fZKN+zy+Qf0AZg04l64RaT3zz/Y1ZQ0AsZ/1UQ7d5PiQeGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0oM1FfB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31f22d706aso2992867a12.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750709442; x=1751314242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=f0oM1FfBu61oAegzYN6h/+64s/GuORvttVjzdgs9oyIA8W8VtcpvKlCgmUqc0lwDBM
         rK2FilT/wZamUTdVFSCw5cCAmw+C1EfJ7uRY470jDTLz7+AzvmawMgy6IC337I7yGhFV
         3fQO1Y2thoZ1+KktbbcIycFalRidi/LcJCV7pFGtGTj9R6DteXwU6Z7VsOIahOiJp1GL
         YNtvGRaCMWdst5OGQmfYw/Tr0q55I/71esMhClSTwcSbQAOnZPISvMGTZZqdaZY3sGHR
         zqEzoQFbC8S4W0TuNxsI1EBN22qa7bkp3tFN5y6xd8OZRv6T+JHXtYCFSLccVhSawdzI
         FvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750709442; x=1751314242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=p8GeRR027PTWSEUGTD1QwHedmTv/Q3FN/IrHoqWeE43VXbkU9DPVT05Ii9FREudmtz
         +5mH3ML+JWAMpZM4nj8gu5NvBRDkIXq5weGwRCnTwPdSKKGRplpvQ8B/zpzEcLaHY6R4
         CCnyttAvgdzoTwDmJkmvDdFDwjuZRmAmWFFshbSbznhz9p5jYqOO0JslGtXpzLz8ymW+
         KU14U3ympwZIMJLAoUPGb6zhsim3mltHvO172Qb6S/hyJ9yZT+yA5NkDeu5fBfZTfGmF
         O69QrnKTlqzxGUUVwm0mGxdvxzueFEiD4+PxZs0BCU/DPzBh0bR2Y/dy/6++6yOUedoT
         h7Lg==
X-Gm-Message-State: AOJu0YxojMvWVQ9Mzl1TXw3Ut9QUixKNRwHjoKm/ibUNPatrpYHtv7Sq
	SKF03R55HJYiISKECxak/GqOj9cHiPbZvNjQwbNCvLkfBfydtFbwTne1
X-Gm-Gg: ASbGncs2zOPJqdq+sdvxxmgmHzMN3X5IJUwK5VbL/ja12ub6IBvOYR+7HFtlyHmJVED
	6wzJaP6p6r6POBpmDtHnjsiWBqQBVx/WrWHzGyK16xsZ/bCoGntRKpKskF13kEjvhwGFn7GgWa3
	vcViRoI4HOif3geIdFGrqFy0YOi9iyfHn9Vn/l2OxDV2Mh4r9jzKl0aMnfQ3S612oihxtfwzRLU
	wQ2VGrXQ/9pfegBKMk97GhGk0E0j7S2s2Rsq5WQxFlwRAzpgk50+Az3Qb8UnTDWK2F2l9fbnFef
	M3ma7xnmzaZWgTdwK/vFM+QE5hEZmw+YDfmNmc+WGJ/0QMhCQa6zMrWvUcns5aqon/6Mo8RpqA6
	eHxFUeEqegnaE+4A=
X-Google-Smtp-Source: AGHT+IGrd0/dDX6m3c9osDgIyHJpg5JzA3gJNJkvmYZJVwhv+YMtLC6resvLnkj4/WhW7pcqAWJhyA==
X-Received: by 2002:a17:90b:3802:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-3159d64cb4cmr22614097a91.13.1750709441666;
        Mon, 23 Jun 2025 13:10:41 -0700 (PDT)
Received: from localhost.localdomain ([189.33.3.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8608d4asm89453985ad.128.2025.06.23.13.10.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Jun 2025 13:10:41 -0700 (PDT)
From: Gabriel Lima de Moraes <gabriellimamoraes@gmail.com>
To: iio@lists.linux.dev
Cc: linux-iio@vger.kernel.org,
	gabriellimamoraes@ime.usp.br,
	Vitor Marques <vitor.marques@ime.usp.br>,
	=?UTF-8?q?Gabriel=20Jos=C3=A9?= <gabrieljpe@ime.usp.br>
Subject: [PATCH] iio: light : veml6030 Remove code duplication
Date: Mon, 23 Jun 2025 17:10:35 -0300
Message-ID: <20250623201035.14775-1-gabriellimamoraes@gmail.com>
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


