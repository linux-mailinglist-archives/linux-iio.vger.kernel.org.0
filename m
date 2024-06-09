Return-Path: <linux-iio+bounces-6129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4069018B8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587F028135D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1FB73539;
	Sun,  9 Jun 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxS+UQab"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC5757EB;
	Sun,  9 Jun 2024 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976326; cv=none; b=t8oIA8X51MuV77Q/hi407UYLX8EN6r5Vz+Pa7H2282Dnt3RiW3A0lZUErD6hOTeiwwAfXVuiO5F+cairIVBDvdCVv8g1fX5ikm76+/kE77I2iSjcbVrkiagF5ckvoPR2sB25gC1M0MQZ2UcKfc0wIJn/KzxtayObS6YJzDkwP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976326; c=relaxed/simple;
	bh=RAiHcJ9tHa+nC+dRPDlW+bAqYvbDn5cPKJAZ7OBuvNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7wSSRNmG0qTNp97q9WQCC347uHrInbVveiwrLpjSh72Ny1ml/1UHBFb7gDQ+uhpCch2dkyUhV8Hwda7eHwYH0+NioW0F7YlMQ6gOq4z68T4pgWifYJs6EXHv8sqyB1UcXIOsS9PLN7dIVmiZMFP3ABZ+XXG3NWeaDtP4dCYmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxS+UQab; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f1dc06298so45344366b.1;
        Sun, 09 Jun 2024 16:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976323; x=1718581123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrA4sW4L1vNj/722AeitV6Faiop+SaS3a8sMsMKTUK4=;
        b=dxS+UQabA6wdwXo58la+2+6NDjyiz24wXZrk+IgpvWMKSVuPLXLEurfMdxHwfAsCZA
         4sfATpTYKFU54jD0Z1VrAUW2HCQtDwQhSaBm2FTXyaYuJ9hB71L8fQ/SLrJbHb4gRl/b
         qHjJMpmcPtFYrxTj+akcFr0940ALJA15bsu9go4xIC1YMA2CeiOlQ9xIqCot0OLDTXul
         uRAxEf0DgGFxSQYgWqB8rupGl/1UwXyq/slKiJcnTwFtppsJGznVTrIaA5oPlDwAi5oD
         NDJYfUyV1/oy3ZpLT37thGzsu9vIQsgId+Qe7djTsna6hkGMvY/bJdqp5EbRd1vxkaKz
         qh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976323; x=1718581123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrA4sW4L1vNj/722AeitV6Faiop+SaS3a8sMsMKTUK4=;
        b=QSUAVs/N3StI3Ay1LUblvJQXpob1hJVH1tKHcIeU7jp+PnPadB8J3x6vYg85VJYKps
         BPkBubLxjiYuCum2YWe7uX2BAa8QjvJjPfC2+V6dLt7TZGBwEEyRxVWCgDej5F1fVyOD
         sIhCWml3mHEgj+kQZwo4CLKRzLSOZJntyQP9J+YWVLKbx9QEA0tylGnOlcO0T5ANQwNB
         u07k+XmppV9+YVRBhBaAqXN6aFPTqOczV6CMkdoNADyR/tQg44mO7M4Ip9Z43o0s2sUH
         pKNTTUarNhM9WN8vEjlxRZRMN2gQRpw+42ldXaWYaJRtIdi+TGTc0+dLqk2eZTJSi7RI
         ebkw==
X-Forwarded-Encrypted: i=1; AJvYcCVyZuu/qe4NK8WkQUIfD0mfCMp2bx28XeJRrOUYm/Y4gSUXGbAVw7HtB8D6eoav0vRmk64lquYcVF8UtFDXCgbfp3AvrGoyqeh/LkPej8JO3fPT0MDyfH2mswGsoFkDTaNm3cNZHTgI
X-Gm-Message-State: AOJu0YxwPGFmit4YlhA/XjnDJTTWOGq0p+wyrpLd06kxYE2lc0QryECU
	fRC33Idp/F9KCF5CuPILu/DnmbuQWFfLtvB1YZ0vl38OjrGRhLW2fDdgsQ==
X-Google-Smtp-Source: AGHT+IGjaQwY7Q/KXmsNgV0fDaTuO9+3AAizakP30iJJAnZoT87Bm+2VP/gv2MZWVSZaLd9hro9O/Q==
X-Received: by 2002:a17:907:7290:b0:a6f:1e97:b17e with SMTP id a640c23a62f3a-a6f1e97b2bemr99639066b.76.1717976322955;
        Sun, 09 Jun 2024 16:38:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 11/15] iio: chemical: bme680: Modify startup procedure
Date: Mon, 10 Jun 2024 01:38:22 +0200
Message-Id: <20240609233826.330516-12-vassilisamir@gmail.com>
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

Modify the startup procedure to reflect the procedure of the Bosch BME68x
Sensor API. The initial readings and configuration of the sensor need to
happen in the following order:

1) Read calibration data [1,2]
2) Chip general configuration [3]
3) Gas configuration [4]

After the chip configuration it is necessary to ensure that the sensor is
in sleeping mode, in order to apply the gas configuration settings [5].

Also, after the soft reset, it is advised to wait for 5ms [6].

Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L162 # [1]
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L44 # [2]
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L53 # [3]
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L60 # [4]
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L640 # [5]
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L294 # [6]
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  2 ++
 drivers/iio/chemical/bme680_core.c | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 7d0ff294725a..b2c547ac8d34 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -63,6 +63,8 @@
 
 #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
 
+#define BME680_STARTUP_TIME_US			5000
+
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
 #define BME680_H2_MSB_REG	0xE1
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index a54460fddc91..0390c298fdd8 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -531,6 +531,11 @@ static int bme680_gas_config(struct bme680_data *data)
 	int ret;
 	u8 heatr_res, heatr_dur;
 
+	/* Go to sleep */
+	ret = bme680_set_mode(data, false);
+	if (ret < 0)
+		return ret;
+
 	heatr_res = bme680_calc_heater_res(data, data->heater_temp);
 
 	/* set target heater temperature */
@@ -866,6 +871,8 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
+
 	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
 	if (ret < 0) {
 		dev_err(dev, "Error reading chip ID\n");
@@ -878,22 +885,22 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	}
 
-	ret = bme680_chip_config(data);
+	ret = bme680_read_calib(data, &data->bme680);
 	if (ret < 0) {
-		dev_err(dev, "failed to set chip_config data\n");
+		dev_err(dev,
+			"failed to read calibration coefficients at probe\n");
 		return ret;
 	}
 
-	ret = bme680_gas_config(data);
+	ret = bme680_chip_config(data);
 	if (ret < 0) {
-		dev_err(dev, "failed to set gas config data\n");
+		dev_err(dev, "failed to set chip_config data\n");
 		return ret;
 	}
 
-	ret = bme680_read_calib(data, &data->bme680);
+	ret = bme680_gas_config(data);
 	if (ret < 0) {
-		dev_err(dev,
-			"failed to read calibration coefficients at probe\n");
+		dev_err(dev, "failed to set gas config data\n");
 		return ret;
 	}
 
-- 
2.25.1


