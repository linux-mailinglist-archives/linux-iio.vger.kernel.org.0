Return-Path: <linux-iio+bounces-5367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C878D09F3
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F231F22CCD
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3316087B;
	Mon, 27 May 2024 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIMX75OC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323215FCE9;
	Mon, 27 May 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835100; cv=none; b=TWQ4S3FzEX/xbTuVAnMmtcaufb24g6ZlkrziQqCmnL2XNl3cufUinusVabgbE6YAV4mptjFXygXQvtDXAhGiATulW4bsbpHdTZaVRka2/EpVwPvxL+KHhgibpbqDvzfaJpPg0mPyD65cRlf+RdaId6GdxIoWDvOuT9dwV+C2C54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835100; c=relaxed/simple;
	bh=6tZ+4GXcun28L9aV4/ePGyVestfvIxHwozTMhv4DqEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0RaTK6WL3hnIRGzHTZyTUUQ42BVOAv7Tuk2JA1MvkkcYJJ0xGwraycw6PjK/czs1Jm0IQDDdPszmdrAxxVPdl06AOcyRgSD3AQDbHeMukt0KjU7BKWllYOaWmP44eEF7RvtHdMfZtTUcgYQbnhQ89vo07i2kY1/L/dWpK9+FBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIMX75OC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a61b70394c0so9044466b.1;
        Mon, 27 May 2024 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835097; x=1717439897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaLc3nntzqGGZfLdlaeumzg71QFyUXK+JAO+p8PtAy4=;
        b=CIMX75OCGFsv1kuzuqbFt3u0OYMgwowOmZxazFnsDu7kcnxnWSSiKZdwq2aSmbZxbX
         eeFTPdRt5cvzviadTfbHYQY313OZhGxLfnKlIS+R6/ZMGN7+8v7kqV+V0mU2sk2GwSM+
         GuF5zhHfTud9b/0TB//reMvDUdaUeOe+BithTmv7EeM7OGrzGnpz3lUztfBriyoEnlnB
         BYlwpxe88n6AbpvK1yKD1ZZlShU7hhVXGr4fsuxxm8P0n+Ekx0f5ZxZxMEPqK9iZUucS
         W2luc2DPDYJt7xcLD56X9wxLQT+b+ehdxm8x1ElFzTsb75p++hvccAJ65AVDbmYxBqS0
         +ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835097; x=1717439897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaLc3nntzqGGZfLdlaeumzg71QFyUXK+JAO+p8PtAy4=;
        b=NDk2f4RuqrTHNiMMBuusfI796eoumb7peF9tCpl/XkVROGeLB3L1iihyACmE+3duKJ
         gJ/8cOvz0GTADD2P3KbkPZ13wIW5Jhhp14JAatBoxET7Vy4IQdV6sqbEimIQSG81mA9I
         Im+wqpukUxkuTn4X8oGCDLvQCxSjrHX9/pCtlj/78quVmKxbV13r6TAK1x7Zmo5kmMA6
         b7N5gk41jluXKizIAG59yT8I9jxnCbvEcJ8TExfTnxtDanCedQzBuHxpsUvE+EvCyP/9
         W8NGF1Oj4n8Z56tDCw57jWNWQtjZG+XQM/Eih2/CMEr63MQ4N1B/e885v24U9SK04a0V
         owtA==
X-Forwarded-Encrypted: i=1; AJvYcCV/qIZNdiR+DWz2v6nu32Xqpl7fm8QRBqMT7/qJQzisNNbZyBmRrJB00WwijUjSBgp2vx9fQTTneEueKk4zzmrw1Skui/NmkXOPOw4Q2tyHfeUwbFUjnbdJFlXChNsfhUow6EKrwpu1
X-Gm-Message-State: AOJu0Yxj539FWNhwsd8wFBkRB85eXKkw05R67Q50M6Nc/lMqAiOo4dTv
	yfQCP4+zPuI7Qq+6DNQOei0yPbJFsoKb6VoEl6NV8CnmHDzxlU3b
X-Google-Smtp-Source: AGHT+IEM1YMHXHJ+E04vq+C50SXX9r98TrLnL5H1/IkU+k61KI5VbCHLhgb8N7oTN9h32gDeQ9ehyQ==
X-Received: by 2002:a17:906:4c49:b0:a63:3702:def1 with SMTP id a640c23a62f3a-a633702dff6mr1647766b.72.1716835097255;
        Mon, 27 May 2024 11:38:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:16 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 04/17] iio: chemical: bme680: Fix sensor data read operation
Date: Mon, 27 May 2024 20:37:52 +0200
Message-Id: <20240527183805.311501-5-vassilisamir@gmail.com>
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
 drivers/iio/chemical/bme680_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 5db48f6d646c..dd2cd11b6dd3 100644
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
@@ -532,6 +533,26 @@ static u8 bme680_oversampling_to_reg(u8 val)
 	return ilog2(val) + 1;
 }
 
+/*
+ * Taken from Bosch BME680 API:
+ * https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
+ */
+static int bme680_conversion_time_us(u8 meas, u8 dur)
+{
+	/* Oversampling + TPH meas + Gas meas + Forced mode + heater duration */
+	return (meas * 1936) + (477 * 4) + (477 * 5) + 1000 + (dur * 1000);
+}
+
+static void bme680_wait_for_eoc(struct bme680_data *data)
+{
+	int wait_eoc = bme680_conversion_time_us(data->oversampling_temp +
+						 data->oversampling_press +
+						 data->oversampling_press,
+						 data->heater_dur);
+
+	usleep_range(wait_eoc, wait_eoc + 100);
+}
+
 static int bme680_chip_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -622,6 +643,8 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	if (ret < 0)
 		return ret;
 
+	bme680_wait_for_eoc(data);
+
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       &tmp, 3);
 	if (ret < 0) {
@@ -738,6 +761,8 @@ static int bme680_read_gas(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
+	bme680_wait_for_eoc(data);
+
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
 	if (check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
-- 
2.25.1


