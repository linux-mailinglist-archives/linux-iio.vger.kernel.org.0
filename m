Return-Path: <linux-iio+bounces-5949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257DE8FF6B3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70592B261CA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7919AA41;
	Thu,  6 Jun 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBXBm0sA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D636199EA6;
	Thu,  6 Jun 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709040; cv=none; b=VjVZXx0sFB2adYQS8ZY+M2oxFdojBTm+cO0P9EtkE7qHox3DFxeGMMA6cGTYNzUyC9oLyfni9h+LTATGJunLhtH02gPfzAx32CG3P0s3gUSPz1xyfDrLJORuIxUszO01R+Q2uOr3d5bx86+ND7btNVHRzFiawrG5lJCDljo5vMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709040; c=relaxed/simple;
	bh=G+wiotSXKZcg++7yKvAwTOIUfX5xJOJl6Q/Dy/ME73I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhiqCBdtdDjwppxFAJZypgIlK4l3+ynxwrN8qb+7j/MAvByPEQbXo8Q9KBARyn3eR+YJR3Q5p0IWNYmxkqeW+JXFP609hVlwKylhM2xflOlETKTupoaPzBojAQA2rSvQfzIEk4B0OWhYyc8xXoBCuq1GK/2JEp+5Fj6mxq5ZOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBXBm0sA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4214f52b810so17983005e9.1;
        Thu, 06 Jun 2024 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709037; x=1718313837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdKudJ8sQ9GAJhWY55rXwQitu4hCnSMzh79rjzP2BTI=;
        b=ZBXBm0sAWsUFSYtVjM7NA9JWvf7s2dLmZHNisA1j0MNmfUrZIC/BBgme/mvaGi4vkM
         rrg8ugEyQgmG8vsmqHo0tLGi8tl6hHPcOBMH5dnC1yaeDRnhFlNAZYB6ktVhQ3GgmITI
         /P62jhd98nZWwLPOa+VgcLRrAYrtqefmC8oC7L93ygFjfcc8lu0q5jVVSXEDbLgqIQl3
         j7AggGhfZQpTEzxxPa9wR/Fkp24wFzEg70wIekysHefCemLOUagFuyyh9InRBrZgpaCM
         f1mexlWmM9DeXbnFzrn14oFzYAOUNK2s8yqk4Ti1Lc6Rmnh4RuyWqeHVYhQmAXtgDN4t
         5UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709037; x=1718313837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdKudJ8sQ9GAJhWY55rXwQitu4hCnSMzh79rjzP2BTI=;
        b=jIYkQb0VRoA7wfJxO3byeXVKz0ZU7BU7y/ELFLvfJvggu/p533sXctwTHZ3ImgaKHP
         0cMSDDPxUZnBNZurc1aTJBtMY8PYLQ/w+L+h7ljXc4U2WSAqPriYWe1zK5NQZqnvy1Ry
         hpm3mEa6tRh4bsqvk5klQfJj7HtnBcTnx+01ZbOSika8DC4WWWXPH3N1jwq9dBYpFltn
         EL6pGSVev9Ifn/SDf+0PR952w3SknmHFICtEGFACiDJdUZJbYg4d66EG49lPJxMi3odL
         hpwY/D56Or7nHJoCkHTmcEko2/3UJx2RGRNoC4V0818jkn5Pu/f4/Vfe6PPf7mih0BZX
         bBPw==
X-Forwarded-Encrypted: i=1; AJvYcCXTBwaLDiMZKCbxxqk4sk8Z+7aSVAXLPP/ElsfIO1Ns/NZbsdPXDbwCb+swGnFU50SkXbYCGkAcNH0HXPn6nW0nUKB9DsDFpgzAVt4FMI9UkuoKZBFLw4lmx/SGnpW6o+ntmWa8intO
X-Gm-Message-State: AOJu0YxE+nD2vtSCfCsO+7RQMqFQCtnRHW6SIPiJysyl5wMgxYxIesAf
	f6kTggJ8/3OqckP0LhfPnZHNm4OUDO8Py+J4QAXyJPvlvi9VsUVHQUMM+9GcBZ4=
X-Google-Smtp-Source: AGHT+IECtjVjvQ7tGvHnICpHzvSyy7CbplUSFdmcv/KOvtGplWJvKsweztIDOUn8YK5mWPtcMNfvZw==
X-Received: by 2002:a05:600c:384f:b0:421:5d4a:7286 with SMTP id 5b1f17b1804b1-421649fbb37mr8858805e9.14.1717709037536;
        Thu, 06 Jun 2024 14:23:57 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:23:57 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 04/19] iio: chemical: bme680: Fix sensor data read operation
Date: Thu,  6 Jun 2024 23:22:56 +0200
Message-Id: <20240606212313.207550-5-vassilisamir@gmail.com>
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

A read operation is happening as follows:

a) Set sensor to forced mode
b) Sensor measures values and update data registers and sleeps again
c) Read data registers

In the current implementation the read operation happens immediately
after the sensor is set to forced mode so the sensor does not have
the time to update properly the registers. This leads to the following
2 problems:

1) The first ever value which is read by the register is always wrong
2) Every read operation, puts the register into forced mode and reads
the data that were calculated in the previous conversion.

This behaviour was tested in 2 ways:

1) The internal meas_status_0 register was read before and after every
read operation in order to verify that the data were ready even before
the register was set to forced mode and also to check that after the
forced mode was set the new data were not yet ready.

2) Physically changing the temperature and measuring the temperature

This commit adds the waiting time in between the set of the forced mode
and the read of the data. The function is taken from the Bosch BME68x
Sensor API [1].

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  2 ++
 drivers/iio/chemical/bme680_core.c | 46 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 4edc5d21cb9f..f959252a4fe6 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -54,7 +54,9 @@
 #define   BME680_NB_CONV_MASK			GENMASK(3, 0)
 
 #define BME680_REG_MEAS_STAT_0			0x1D
+#define   BME680_NEW_DATA_BIT			BIT(7)
 #define   BME680_GAS_MEAS_BIT			BIT(6)
+#define   BME680_MEAS_BIT			BIT(5)
 
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 5db48f6d646c..500f56834b01 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/log2.h>
@@ -532,6 +533,43 @@ static u8 bme680_oversampling_to_reg(u8 val)
 	return ilog2(val) + 1;
 }
 
+/*
+ * Taken from Bosch BME680 API:
+ * https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
+ */
+static int bme680_wait_for_eoc(struct bme680_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int check;
+	int ret;
+	/*
+	 * (Sum of oversampling ratios * time per oversampling) +
+	 * TPH measurement + gas measurement + wait transition from forced mode
+	 * + heater duration
+	 */
+	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
+			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   (477 * 5) + 1000 + (data->heater_dur * 1000);
+
+	usleep_range(wait_eoc_us, wait_eoc_us + 100);
+
+	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
+	if (ret) {
+		dev_err(dev, "failed to read measurement status register.\n");
+		return ret;
+	}
+	if (check & BME680_MEAS_BIT) {
+		dev_err(dev, "Device measurement cycle incomplete.\n");
+		return -EBUSY;
+	}
+	if (!(check & BME680_NEW_DATA_BIT)) {
+		dev_err(dev, "No new data available from the device.\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
 static int bme680_chip_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -622,6 +660,10 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       &tmp, 3);
 	if (ret < 0) {
@@ -738,6 +780,10 @@ static int bme680_read_gas(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
 	if (check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
-- 
2.25.1


