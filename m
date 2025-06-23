Return-Path: <linux-iio+bounces-20925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FCAAE4DF8
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 22:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B31898950
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488E1E5B71;
	Mon, 23 Jun 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA6Du2VM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D515D5B6
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709748; cv=none; b=eu+SXA2i3vHK70/r78FFquCyWjJY4erSsYCIMq+nw62iTwqbMo+YpZmlYUGx9+WvplQXLNC+14ShyXEhVwU0GCCoDCgYfFyjPjWk9m3F41xKaj4N1BtFoc3XiMVv/BythXs7QLp/dba76Y+o7vWNnrD2QLNWumlrTlHS3kVzwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709748; c=relaxed/simple;
	bh=MNeIDc41t2NITdv4R617R0WUzwLpWiNFX64vjrBtVV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ohRftmuiPXBpPn0t0S6sKvRVIRjwSKiVpmD7N9cNOMDsvQbzD2rgI36dXqzXD9rSGhXhoBteHzkBVY2rvVaPqaJUGIDSSFGQmm1k1OIF7OlbFR71WLkAFJrWCuVTlI31iKSZrzCsmm/io60kEslXhM/0Pos4Jak/ypVV84KyxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA6Du2VM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313b6625cf1so3261971a91.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750709745; x=1751314545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=jA6Du2VMomRQupTqNHk6OLUXKhMTJ8j6Bw2HDXSFag2em1uPrpmF2XmNcqaSNHNuSi
         62X61AHsnEzgLToBJU6/hlPyKI73+7+EH2vWxQNMqIWGXg5iFPcyhnDtB1BBuBY/1Ifk
         ydLaQZpqR/J+bZaeywPyRU42OvnSm2kN6W/vsRgXe6dvUWttMX4HacBdJGNI4uV06WiP
         fSqmKQFuc11vf9IH11B/856lzLTB9dY8JM7C9RuIAo8qVC9ZIbjU4HjikOySah+W7Pwe
         5ekeK7zXqpXX26fRW5uIp8Fgu+4CPhcpDrHh5x5AAGIQJyFyKN2VW6ojIxwIQ7kUWEWo
         FXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750709745; x=1751314545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZlptV9/sCjlvE3bk4diN1kDUJBo41N2P+D0AwdZId0=;
        b=eCKQsFMgPbdgpXuzLrU+jjsB2OKgL7cjgCD7AV+l3KqCrJE3DQX/3125GF1Bh8vu0+
         oMBz/ZtqzzZiK24DVuMxQ0M8tps4/bg+WxmFTWWwswkZ+0voBRtP1b1KDcllFt+2qW/d
         4CKLFTSF0xPkQ/m0yCJqh8SkYFAkWIthLG4jeds2nwXgDUtvagMpc9K9ilLi8OY7a0UD
         rGmdYZssPo9hOGMhpCvi4jfG7Lb6okOaKWzIKBixy8RnMBGisnxJLuU8oB9lzg9VavcZ
         ysXncM1tvWUAEIKX2YUN57SpVh+rJ4/ITgWGImedhuOw6oUTOlfmRyzQwUFp6+cSUjbh
         1Qqw==
X-Gm-Message-State: AOJu0Yz/JeY01/4af4tVDwMSyEYCjK5KdNlvgHM6EgqchZbkEg+qlVft
	Q8+/ZHpu1+WFqUEMRRwprDfv5TleZhxB43T/zviqSQe9NZ8i9YV+XRbW2/N94ZRw36s=
X-Gm-Gg: ASbGnct/o0VulkhZaBhH4jUXN7h0lQ793zaQ9N6ndBRMT01YMSjrh042r9jhRkJFYtw
	jLDzOFXf0P0L0IHbqIR94ZzmqnNaYUYPkLr6nLzEI7NGOK6b0SdUn5DE6uKnVoV3BiKPRBelpIg
	AG3jnEG/2E3QW579budjI5xSGB+1VdNt9OLojkpdoXvvVFnQTdAngTLaqOkb00GqVj6U/Xsjmyj
	CnxRIKLXVsRALWznFOg/9jtDg87AGRnQ4pX9Posurb90nz2LUvR40LeLQfcQsGIkPpKDIm4s0JI
	7PPuWdSPHykVYe7o5TQKvdeJSjnzagGjbPMUZe28PHfC5Ihpc34qtRjq8ehUOT32mv7jt/aed9T
	6y8fDfYGN/MdPJ5A=
X-Google-Smtp-Source: AGHT+IGq8yjTJdM8uLPmzVY68Ayd7EA9GtexhkIp+ePctyYDwPifUpQPVbisxqUpejVJfmkX4mT+aA==
X-Received: by 2002:a17:90b:1f8d:b0:30a:9feb:1e15 with SMTP id 98e67ed59e1d1-315ccc4da71mr1194654a91.8.1750709745393;
        Mon, 23 Jun 2025 13:15:45 -0700 (PDT)
Received: from localhost.localdomain ([189.33.3.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a331426sm11378255a91.44.2025.06.23.13.15.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Jun 2025 13:15:45 -0700 (PDT)
From: Gabriel Lima de Moraes <gabriellimamoraes@gmail.com>
To: linux-iio@vger.kernel.org
Cc: gabriellimamoraes@ime.usp.br,
	Vitor Marques <vitor.marques@ime.usp.br>,
	=?UTF-8?q?Gabriel=20Jos=C3=A9?= <gabrieljpe@ime.usp.br>
Subject: [PATCH] iio: light : veml6030 Remove code duplication
Date: Mon, 23 Jun 2025 17:15:39 -0300
Message-ID: <20250623201539.16148-1-gabriellimamoraes@gmail.com>
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


