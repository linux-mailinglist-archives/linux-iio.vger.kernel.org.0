Return-Path: <linux-iio+bounces-5377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B1E8D0A07
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C299B21DD5
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269D168C03;
	Mon, 27 May 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfbXhcrN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA4167D83;
	Mon, 27 May 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835109; cv=none; b=J4Hql7d9ALNagpfNUwCVPbsWmiwqvkZTvD/Dv7BYF0gdmU9VBedxIj8eLkxOqEVf+nOnrKy3VWvNFZaL9w6qoe56HNLOaBcJB2ix1RJLpBkR8tRDt9X6xYe4idMC21aR95to95nfJkbRdI918STJDvmYpk85xY6En7OSxlLbFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835109; c=relaxed/simple;
	bh=cFHf0/kIR90lrbrVUhcY+LUmF5u/hR7m0XYJLD/mjQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwSQ5AYg5LOmYtmbljqXEJgN74oJnegit4o4ALUypWGXpzaipVeuOp3KW97I93BlkSeIC/OogzE3wLYDTU0kw5bDU+JLe/wXLLvEVde7vQffIh2cPf3lPbMDH/zSSeaaW3ZGL6spCS48aX5hQJZnG9DbI/qLJDLKbgv+PA2fJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfbXhcrN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5320so26947a12.0;
        Mon, 27 May 2024 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835106; x=1717439906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+GhNLj18UStaf7z+31r3e+sQGnYbNlK51WS2O+sgMA=;
        b=CfbXhcrN2G5IHYzC615qLhMIeUiSL+XxzyCwLfe70LeUuVirVc1qiWHneB03CqplkL
         uGhAx3PmCoyJZ7rH5qUALFsEB55VL0ksxPVj/M6iWID16k8SuCBsGWt0yYys9FpEhRxk
         4rfJBXtQOeNKPoJ6oYZjNu1JUWSn0ihFNxvGTf+4UYdG+9GzMD3XCCOF+qZk1HEnx4jp
         OYfG701krKPjUP/No0CRftlSsRgZrHMxm3yWAo8aCNxxoMVK8Jq0ZBkVG/KuDdi0wC+4
         n31mjODoIGG29tubndmWtAka7ADLHsoyXXLwJR5a7SlP/gJISyMUCN9YnRd8HpxxTMj9
         cwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835106; x=1717439906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+GhNLj18UStaf7z+31r3e+sQGnYbNlK51WS2O+sgMA=;
        b=rDsSE6H2VmY2rofFP2hwc2LFTSzNtPROusZQ5Vjl3498xAyRVAwiIqK8sd/urVd816
         KogRYEAC4gpMa55z/MEHJbEkPYgaohyI0jT8mSjBm3Zo1MK3Wz/v0C+GbtTdpHpxqZrB
         O99ylGc4GojP60FHLHvChI/2X++FGbMnYoRM4Tl18KoWQuML5mvvpvdtE2NrmmGj37jl
         5qO3199OzMXbo2SNGy5wn/7MTy4auFFu9+2Vz4z1kOcnBTd9s4VzGRjOMYM/f/nBNmUg
         i/fNAlQLSW6qATckzGDW43F0XBAiS0P7jTP9+l4K364P9pVrFTjJYcahZzYJO/xQLaDB
         0qsw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8Qv3+FdcJNr5l2oRkrKqDBbDhhot2rq7eahAtUV87r7uLEVuYw7QeMfBUm/hDtssI69BNL3tGLxqaxM39xFl2BFbPM/QdXjHkSrbqFUfH0gYy/+KYz2sri8YuFMnB81d4D9cvQCF
X-Gm-Message-State: AOJu0YxgGH7FRzvtb1UM1CaGRXGF4c12uUcOpa8Py6qoNJ2cJ9MdjzXd
	qPtTyA+A1Xm1dnNtIkNVcADdqxYhWgXCdAKmho8f6m4UDd9vXnjR
X-Google-Smtp-Source: AGHT+IEOGRPHlK5STicxRJPpyGUnP3mg/Bamc0N15D3QHY1a9CyPeq8/S0NYlewTBOcG2pdNbLqEqg==
X-Received: by 2002:a17:907:512:b0:a59:29ea:ed1d with SMTP id a640c23a62f3a-a62641ce042mr562592666b.22.1716835105841;
        Mon, 27 May 2024 11:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 14/17] iio: chemical: bme680: Modify startup procedure
Date: Mon, 27 May 2024 20:38:02 +0200
Message-Id: <20240527183805.311501-15-vassilisamir@gmail.com>
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

Modify the startup procedure to reflect the procedure of
the Bosch BME68x Sensor API. The initial readings and
configuration of the sensor need to happen in the
following order:

1) Read calibration data [1,2]
2) Chip general configuration [3]
3) Gas configuration [4]

After the chip configuration it is necessary to ensure that
the sensor is in sleeping mode, in order to apply the gas
configuration settings [5].

Also, after the soft reset, it is advised to wait for 5ms [6].

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L162
[2]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L44
[3]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L53
[4]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L60
[5]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L640
[6]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L294
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  2 ++
 drivers/iio/chemical/bme680_core.c | 27 ++++++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 17ea59253923..3be2f76a5bfb 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -61,6 +61,8 @@
 
 #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
 
+#define BME680_STARTUP_TIME_US			5000
+
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
 #define BME680_H2_MSB_REG	0xE1
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index b055eeee8f1c..afaa43ec3241 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -505,10 +505,12 @@ static int bme680_chip_config(struct bme680_data *data)
 	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
 				BME680_OSRS_TEMP_MASK | BME680_OSRS_PRESS_MASK,
 				osrs);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to write ctrl_meas register\n");
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int bme680_gas_config(struct bme680_data *data)
@@ -517,6 +519,11 @@ static int bme680_gas_config(struct bme680_data *data)
 	int ret;
 	u8 heatr_res, heatr_dur;
 
+	/* Go to sleep */
+	ret = bme680_set_mode(data, false);
+	if (ret < 0)
+		return ret;
+
 	heatr_res = bme680_calc_heater_res(data, data->heater_temp);
 
 	/* set target heater temperature */
@@ -847,6 +854,8 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
+
 	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
 	if (ret < 0) {
 		dev_err(dev, "Error reading chip ID\n");
@@ -859,22 +868,22 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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


