Return-Path: <linux-iio+bounces-5962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81578FF6CD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A2DB2504A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8519EEAE;
	Thu,  6 Jun 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt9B9M45"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73219E7CC;
	Thu,  6 Jun 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709054; cv=none; b=R3FDaE33LhG+WYetqF85wh/zGUKmbKGb1I2M/EPEwWP2xIMBRsi0ylHeOL2wbPfRe+DzbkHLnyfUIsB9RDmhtkh2xDtVTZu4WmmSnI9V2fd628nNepHH5t2tnapu9punPrtAk7Wa1Dt2QtChqCSsXf5s4p+Von4TkVWCxUtTM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709054; c=relaxed/simple;
	bh=kzbAH1/qm6sKoaFLom2XqF1d9lKnuwIKy3IanCKqJkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXC37xIX9BVk0MxTbyzFi8NYw5T3y6NAO7xuuQ6X8EjzY9q+AXv2bRkX5xgnm1/rTnKUrEJYQ70moAo1HnUsc+jjuydP16XDQ90rMQxWJ6E9iz85Y2ejG3M5HY44anF3U+ExFfYb3aF66woc87EhjoYipahyDeCcHD91OTwLFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt9B9M45; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so4867838a12.1;
        Thu, 06 Jun 2024 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709051; x=1718313851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG8ZX4YUUuDYrxuB6YPc+RSBqPz2gypGLp3b2Zlmu98=;
        b=Pt9B9M45ipWvfkRQwJ3YrAX8K+FObWg5Om7w5Qr3RQNEp4GX//DdG2FD3uhXQ760vp
         w693tJtkDEu/RgtON9Ar2pEugCuaR1EHFcOoyazR6pwgDfYlrKYhpD/kpP1T8hUQyVE1
         UL1fROxGUD1Oo9lnOpDroMIFJZ0kV+bDuoIjWnjSPFR8WVaXiJbNRn15A0lmr9rA2/ou
         8RGA9zgjl7r0hyQXB18JOeMhNMk8YIWnpnLXifkP0MSZtfkF28vCy0FGsQAHw+gg7dMk
         OLatRqAoox8eqCWwX0F/B1UyKmj/0JzXJj8kIQ+rd3uWfWvhOkAEI/J+L2Xfy+XBZidm
         9kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709051; x=1718313851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG8ZX4YUUuDYrxuB6YPc+RSBqPz2gypGLp3b2Zlmu98=;
        b=dSe9tZA0i8IRrMfoi6mK1/oBBbF9EIsIwhLNLlT8Chd2AVKADOcbJSsRiH+E40jMYz
         D+cMJOElSXeJZxSgNOGtdwEq04/oqZ9kFFnoznIohPC/B+8Ov7nrTESYjak/0XytuhAO
         FgkI8y5sQOjJ/tf6THqDJ/5fklOuyzsq9cEgTsEKTxXVXbdedQ3c1JadlMnFWebkM6cC
         Eob2rN8+hcxZfMEfBxHAieabPQ6T6jCkfvFmtMuMazciADkYgFa0naczd/ghT3CAdDpY
         Sa4ziQW2cSpoI1s2xAI8MRolmU3RKmKLHqx/fXem41et6fWRR7AFImtEqxhqbASKz9TV
         99Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVNipTXzz0hHkNt5iwsN3iFlh6xNTGtjXzK3EYTTxRWvsvhm6a4usN5IFnCPTA+u8qtbKdS0ZNWiaOpwZJ89l/lLXLwTQNlcJFqiZkKrGY7XwkpfdwazQjbRJk+/aZGjdbEd7uxAHBG
X-Gm-Message-State: AOJu0YwLVsroOiTBt6ksK9jVOWH//g3nVeZW36XDNGpDdqpETiK65RNB
	PGutFqKJYDGAXx3MhG5nYbBPy7BMVQR3wNjB693gP2gXBJFfhvjB
X-Google-Smtp-Source: AGHT+IGEGYqtlcVG1uxFAcsk+g3K137p+AuBgPOVdRT2g/mYOuB1z1TIIbqAoAVuHcc2hrcjasJwmQ==
X-Received: by 2002:a17:906:7749:b0:a61:7f85:e31c with SMTP id a640c23a62f3a-a6cba5962damr67000466b.12.1717709051335;
        Thu, 06 Jun 2024 14:24:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:10 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 15/19] iio: chemical: bme680: Modify startup procedure
Date: Thu,  6 Jun 2024 23:23:09 +0200
Message-Id: <20240606212313.207550-18-vassilisamir@gmail.com>
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
index 25d128e1ddcf..e354eaa34d59 100644
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


