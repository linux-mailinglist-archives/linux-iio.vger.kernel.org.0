Return-Path: <linux-iio+bounces-12800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC40A9DBE1D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 00:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D51C282294
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 23:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A407F1C760D;
	Thu, 28 Nov 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/BYAoHF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB71CB50E;
	Thu, 28 Nov 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836312; cv=none; b=LEQaY0ZasVQku6jqzXJlIqEg6yZOzarWsTdrOZoC3Np+EffICbvDn53NbvISqZBrQIti9Z1f2e2/ouvv72VXW1TZSOk8cCp/fJMgu7PCUjJJe7sUeHjSpKJZTqa1MuB1RoZETeVR89ew44FwwDTYlp0iqqQ+8de2y1zdOZmSIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836312; c=relaxed/simple;
	bh=/dCE5jtTkrfmNN2qX5Te3n2ZNlxnl5+2YcieRX+C2vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5AoweQGUjNPezv3+vVqzizPgGKIqq6dPhjADzGn/M8YMCr9L9LNG42zZPxsL+3fDSDleN/F+PpFzkWRKCyv0AKtp3kNvCDcqHFmQEqEEasAbotnpfOGSx+lWSyatLECSKRigYmYkVuvvXm8UyeCH+IxY6P9quBWNsBiNQnhOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/BYAoHF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3824709ee03so973235f8f.2;
        Thu, 28 Nov 2024 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732836309; x=1733441109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjF5NHMyK7y7jg65uvCn9MXduypsA+uz1rOx/op7hXs=;
        b=Q/BYAoHFWd3ZyLWhTizPr+7d4Q+BwUPGwJ+19ZtWDhviLD2gQLuO6tG4lI7KPrmKcg
         lNdat5C1xKuNSYn/vudBPRu1WrHkooxZp6YQ2ukxig8F/LTBLKgudVGVIkXuEKngaz8R
         QKe9UAMLbDZkkbJtxTnbvnCrVnD8jLnmMSq52rTGx1CKonC8u3o+L7JH0wtO8OxrcoNv
         lDvTO8+hzlAyd9AW4gN/f5Ri+Cj/9jmPqNEp3jUc7lcPrVAinv+selenH0a+uP1DxATM
         A/h1OvcnhN8bQdBbzUh7vTPtjOIjXKc587zxh04tb+a6r4RYNNeGhRD8LytXihWA2e7T
         FNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836309; x=1733441109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjF5NHMyK7y7jg65uvCn9MXduypsA+uz1rOx/op7hXs=;
        b=aJfltAdG4w2TDbt1eH/IGmL7pKUILLDKPtgFEkk6XtnbcWNeYZFjhBeg/X1fbJYpAR
         Smwm1gRM534G5cUwKBvuOHZAayCLrYCWRooE4CX+LcDVLv0jpf3v8H6nJoGD9RxXtQQS
         QzVcHgVuzk7m0rhUO1+5js9c2W1qpVSSvsaFGCFEwVXYfCs6zgfxjYJtC2phz+ndPzVD
         IGFG2cdZSO/TYttLYEpkeZVy1jzWVwiL2/XswodMrrDtTqz0v6NK7kvGS99znL4pB8B2
         hUFEjf2wookXHTLz2JCZF3vntQxplTXrdDdxUe246PJ5L14STCgJO2l9+BqWCmq4udQe
         FZVg==
X-Forwarded-Encrypted: i=1; AJvYcCVUm2jzrPgEpqZVnd2/XD+SfWJvyFlNDY1eo9N9lYl6bhwTT6kUwzPcSLZ52nVr297/ClA53cX0efS4vXDH@vger.kernel.org, AJvYcCW1dmmUu1zozZCdOBK/bKEMLXgexGSTvJyacc38qh3KjDibUnbPlYPBu0DvmOPvSfGfqIOCThjOsApO@vger.kernel.org, AJvYcCXkepjS1AjzwdNG43r9vN6Fbf+nWw5ay+zGkTod5IqQw72psab5oV6ecq4AFwwcroqmCN7pOVbZPiUl@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxfJt20t8zT8mMhAL/NvNZnFjajWLsU80lrjJe8hYW5K/LUmi
	+jrYfPymYTsgtbAEDGriH5LGUTdyBUCWFwTR1YPFosFoLgZD3Z8Y
X-Gm-Gg: ASbGncuBfQDxXFvbbdt6XrmciFHD+6wixOZzFK+lk+OAdPDwhn5tylV0krTq3JY7M+l
	GWed0Il3HxWo43ZrwDeVECnymrQKIuETBoiakR0kdSWoFvplQRZ/r9bcg//t+baXTaLpG2/gqaB
	ocItwWRxuWUQ2/JPo1xcBu7evEc+D+GQdpaG2rQWkeuD+Cjn1jNxOfNShxH03F0StYRfaSs763R
	0/318pA4/4PL1h/1nnHerbz4c5+5SG6qZasAfk/XeUwTp8HvVsggauhmyTvrq4=
X-Google-Smtp-Source: AGHT+IF7PABYTFt/ac8JsqDV2vx86JPxSSJFTTicJkXfV2C4thQXeUmt7NvdeZKFM+6o1EDES/0xPg==
X-Received: by 2002:a05:6000:280c:b0:382:420e:5cc0 with SMTP id ffacd0b85a97d-385c6eba973mr5376179f8f.30.1732836308952;
        Thu, 28 Nov 2024 15:25:08 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd3690dsm2765594f8f.35.2024.11.28.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 15:25:07 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: ajarizzo@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v1 3/3] iio: pressure: bmp280: Make time vars intuitive and move to fsleep
Date: Fri, 29 Nov 2024 00:24:50 +0100
Message-ID: <20241128232450.313862-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128232450.313862-1-vassilisamir@gmail.com>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add time unit abbreviation in the end of the variables to make the names
more intuitive. While at it, move to new fsleep().

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 39 +++++++++++++++---------------
 drivers/iio/pressure/bmp280.h      |  4 +--
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e5ec8137961f..b39ef30f8eda 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1002,7 +1002,7 @@ static int bmp280_preinit(struct bmp280_data *data)
 	 * after resetting, the device uses the complete power-on sequence so
 	 * it needs to wait for the defined start-up time.
 	 */
-	fsleep(data->start_up_time);
+	fsleep(data->start_up_time_us);
 
 	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
 	if (ret)
@@ -1161,7 +1161,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.chip_id = bmp280_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
-	.start_up_time = 2000,
+	.start_up_time_us = 2000,
 	.channels = bmp280_channels,
 	.num_channels = ARRAY_SIZE(bmp280_channels),
 	.avail_scan_masks = bmp280_avail_scan_masks,
@@ -1347,7 +1347,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.chip_id = bme280_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bme280_regmap_config,
-	.start_up_time = 2000,
+	.start_up_time_us = 2000,
 	.channels = bme280_channels,
 	.num_channels = ARRAY_SIZE(bme280_channels),
 	.avail_scan_masks = bme280_avail_scan_masks,
@@ -1414,7 +1414,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 		return ret;
 	}
 	/* Wait for 2ms for command to be processed */
-	usleep_range(data->start_up_time, data->start_up_time + 100);
+	fsleep(data->start_up_time_us);
 	/* Check for command processing error */
 	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
 	if (ret) {
@@ -1806,7 +1806,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		 * formula in datasheet section 3.9.2 with an offset of ~+15%
 		 * as it seen as well in table 3.9.1.
 		 */
-		msleep(150);
+		fsleep(150 * USEC_PER_MSEC);
 
 		/* Check config error flag */
 		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
@@ -1957,7 +1957,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
 	.regmap_config = &bmp380_regmap_config,
 	.spi_read_extra_byte = true,
-	.start_up_time = 2000,
+	.start_up_time_us = 2000,
 	.channels = bmp380_channels,
 	.num_channels = ARRAY_SIZE(bmp380_channels),
 	.avail_scan_masks = bmp280_avail_scan_masks,
@@ -2006,7 +2006,8 @@ static int bmp580_soft_reset(struct bmp280_data *data)
 		dev_err(data->dev, "failed to send reset command to device\n");
 		return ret;
 	}
-	usleep_range(2000, 2500);
+	/* From datasheet's table 4: electrical characteristics */
+	fsleep(2000);
 
 	/* Dummy read of chip_id */
 	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
@@ -2208,7 +2209,7 @@ static int bmp580_nvmem_read_impl(void *priv, unsigned int offset, void *val,
 		goto exit;
 	}
 	/* Wait standby transition time */
-	usleep_range(2500, 3000);
+	fsleep(2500);
 
 	while (bytes >= sizeof(*dst)) {
 		addr = bmp580_nvmem_addrs[offset / sizeof(*dst)];
@@ -2274,7 +2275,7 @@ static int bmp580_nvmem_write_impl(void *priv, unsigned int offset, void *val,
 		goto exit;
 	}
 	/* Wait standby transition time */
-	usleep_range(2500, 3000);
+	fsleep(2500);
 
 	while (bytes >= sizeof(*buf)) {
 		addr = bmp580_nvmem_addrs[offset / sizeof(*buf)];
@@ -2458,7 +2459,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		return ret;
 	}
 	/* From datasheet's table 4: electrical characteristics */
-	usleep_range(2500, 3000);
+	fsleep(2500);
 
 	/* Set default DSP mode settings */
 	reg_val = FIELD_PREP(BMP580_DSP_COMP_MASK, BMP580_DSP_PRESS_TEMP_COMP_EN) |
@@ -2649,7 +2650,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_id = bmp580_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
 	.regmap_config = &bmp580_regmap_config,
-	.start_up_time = 2000,
+	.start_up_time_us = 2000,
 	.channels = bmp580_channels,
 	.num_channels = ARRAY_SIZE(bmp580_channels),
 	.avail_scan_masks = bmp280_avail_scan_masks,
@@ -2720,7 +2721,7 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 			delay_us =
 				conversion_time_max[data->oversampling_press];
 
-		usleep_range(delay_us, delay_us + 1000);
+		fsleep(delay_us);
 	}
 
 	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
@@ -2988,7 +2989,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.chip_id = bmp180_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
 	.regmap_config = &bmp180_regmap_config,
-	.start_up_time = 2000,
+	.start_up_time_us = 2000,
 	.channels = bmp280_channels,
 	.num_channels = ARRAY_SIZE(bmp280_channels),
 	.avail_scan_masks = bmp280_avail_scan_masks,
@@ -3066,7 +3067,7 @@ const struct bmp280_chip_info bmp085_chip_info = {
 	.chip_id = bmp180_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
 	.regmap_config = &bmp180_regmap_config,
-	.start_up_time = 2000,
+	.start_up_time_us = 2000,
 	.channels = bmp280_channels,
 	.num_channels = ARRAY_SIZE(bmp280_channels),
 	.avail_scan_masks = bmp280_avail_scan_masks,
@@ -3175,7 +3176,7 @@ int bmp280_common_probe(struct device *dev,
 	data->oversampling_temp = chip_info->oversampling_temp_default;
 	data->iir_filter_coeff = chip_info->iir_filter_coeff_default;
 	data->sampling_freq = chip_info->sampling_freq_default;
-	data->start_up_time = chip_info->start_up_time;
+	data->start_up_time_us = chip_info->start_up_time_us;
 
 	/* Bring up regulators */
 	regulator_bulk_set_supply_names(data->supplies,
@@ -3201,7 +3202,7 @@ int bmp280_common_probe(struct device *dev,
 		return ret;
 
 	/* Wait to make sure we started up properly */
-	usleep_range(data->start_up_time, data->start_up_time + 100);
+	fsleep(data->start_up_time_us);
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
@@ -3287,7 +3288,7 @@ int bmp280_common_probe(struct device *dev,
 	 * Set autosuspend to two orders of magnitude larger than the
 	 * start-up time.
 	 */
-	pm_runtime_set_autosuspend_delay(dev, data->start_up_time / 10);
+	pm_runtime_set_autosuspend_delay(dev, data->start_up_time_us / 10);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
@@ -3306,7 +3307,7 @@ static int bmp280_runtime_suspend(struct device *dev)
 
 	data->chip_info->set_mode(data, BMP280_SLEEP);
 
-	fsleep(data->start_up_time);
+	fsleep(data->start_up_time_us);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
@@ -3320,7 +3321,7 @@ static int bmp280_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	usleep_range(data->start_up_time, data->start_up_time + 100);
+	fsleep(data->start_up_time_us);
 
 	ret = data->chip_info->chip_config(data);
 	if (ret)
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a3631bc0e188..5b2ee1d0ee46 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -434,7 +434,7 @@ struct bmp280_data {
 		struct bmp380_calib bmp380;
 	} calib;
 	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
-	unsigned int start_up_time; /* in microseconds */
+	unsigned int start_up_time_us;
 
 	/* log of base 2 of oversampling rate */
 	u8 oversampling_press;
@@ -490,7 +490,7 @@ struct bmp280_chip_info {
 
 	const struct iio_chan_spec *channels;
 	int num_channels;
-	unsigned int start_up_time;
+	unsigned int start_up_time_us;
 	const unsigned long *avail_scan_masks;
 
 	const int *oversampling_temp_avail;
-- 
2.43.0


