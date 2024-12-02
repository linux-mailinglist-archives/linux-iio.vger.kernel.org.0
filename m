Return-Path: <linux-iio+bounces-12962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D639E0BCA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D1BB81EF7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3CF1DE4C1;
	Mon,  2 Dec 2024 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5d19WzV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438941DE2B9;
	Mon,  2 Dec 2024 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163565; cv=none; b=VQfO7SBSyduAUTBnTOgrY0WKh3PFbQLr+yT5aCr8SkPfOe24YKpDElPbfl6z435mndbwl6AzAS3y5uqxdut0tszckykJkN1eBqzTc37wIvhOxKmzJ31Z+PtR5/UfluOEmV+5iPSgJvy09Ms3kIEShaw4l6dY2IJ0xMu1LM7Kpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163565; c=relaxed/simple;
	bh=LEz00guzn4qhDaTRkau3I6J2YUsYaVQ4/yPuVJabF3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7r18T79bbk5yQXZ8/NBAwjRnysFdw7CCO6ifN5At/jaHBBUMvLvrRcXfoK6UTDgx2sOTvOfJmyntNdEia5Rn2+Ylfphl5QU62oFAb7XfHCLZwqn5lfaH7fcUJ0oH/6NYbyVa4qDnrsVrunRqJbLniuvROHCkUxBJUwg+4TZEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5d19WzV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e2880606so2813809f8f.3;
        Mon, 02 Dec 2024 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733163561; x=1733768361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJHG5zlnZJREAPBRYLvXNSMO/bhsEbMFRfOYHRsgKio=;
        b=h5d19WzVbICgxNI+cXBwNqs6yiR652qKlBnjs9nCcC/ddqvoBuRrXDSfM2DdUEgXH+
         JQIv/uszUTd+tuRedM//PMzf1hIcgXuF/oT1LymV1WUXLltAqbcGp5OwfllLu4vU1Waa
         8Qa08rwE0thsPYAOqyqQut/6twd9xabQNhCUm5nPI1AtS+/BFqhwKVZ0SBM/ubvcg9FF
         yBZiXqWz2OyaZKjdSrYKwOhfXXQLcoDsnvGRkPvUD8eM4acOSIZ4pYZXbiva62CPZBBw
         nyKZumJHkU+T7GrKYo3yzjhz0XGV8mcWJJuDXMctZZVMKG4ufpKNLAyCpYgb57w7OKzl
         BHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163561; x=1733768361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJHG5zlnZJREAPBRYLvXNSMO/bhsEbMFRfOYHRsgKio=;
        b=brprlJGLzxA1nNJxKEp4h+aUhop7gx6eTXzMwbya7z+7oBuvWXn0da0SxbJpCqCC1T
         aHzVnEsGh/8LNdgS/vSNcccZOqlRpIow0j/GeeqKcPEhvoLId4i3Q8QFQrUtUv2sKdxA
         Ckta8pGn010PUJM456CGQaAhVoVdS+wWnWFBFnq0xNPrilp4kX7gIkz8jyuATmCSP+jq
         8qYBatMNibH+xUANXI9yj9+oE5/+nmQF4h9fRVuKEv/5IjT/xilJOx53VPXUobsDsikZ
         lSDvB/ZUxwobGTsC5tvP6FyFSyxnvGe+4jTMJmisiuUGBPg/pva97VxSWGCa7skUoUK2
         I6cg==
X-Forwarded-Encrypted: i=1; AJvYcCUigZwftEep7U8UD9bxEbFMh7THwS2tMLFm3fCpoC2/DSmIfuEtG1+ESdgL7lKRjidhXbErUQWi5Yda48AH@vger.kernel.org, AJvYcCVuADgzA9VhtzLbz6N38wt74GnjrNVcb3QMDGiFS+sAHzSbgE5B7gIjdlAwUIz6bsiMGn2dunTLWnrN@vger.kernel.org, AJvYcCW+pRGm2hJHmwkhd5ijkerzZ+quocn7LRAkulxskcL4/5f+dQ7DYOeRtK9Q2MIYaBPeFNdxbtBZ6DS8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjt1sE7L4n1d/XamYFEtFX1imVQ2NG08H2nYA4vZRjLTixL31F
	hRf60O2xQ4jNyeJ4632aNm21ErNUNDoPJt/Uc/nWrkWcIdFZhOTq
X-Gm-Gg: ASbGncsIAMFWmDUuXYH+ri2x92JW6oInx4xQsYL7lyszjp8JqsRM8tv2q7Pzf8F1l1F
	R7NwhsEHgPWTeojHg5/0CYEuUjvXWeU97+nWC+bdjr6GipNRq4w2li2YW31LL8dks3muQhP32K6
	8MuzGRaPOcUkgClhFTzJjus/eEFFw194swWjWL0V4pvVKCBnpORfpKvaGbgHmzp/I3eQN2WBTbJ
	kx0pUycrNbjXr2tngaqNf1gCSrhtMFF06cXJR5GSo/hjMlGd9Ho9J12V/DsUFM=
X-Google-Smtp-Source: AGHT+IHdUWWloiPXzF8xdcj4H3ESL9UrWjJZlQq0Z2MrJ9KvIQZGpdTjb+XnCqw3qQIW1vUc+qOYJw==
X-Received: by 2002:a05:6000:2a2:b0:385:e877:c037 with SMTP id ffacd0b85a97d-385e877c2abmr10956444f8f.42.1733163561425;
        Mon, 02 Dec 2024 10:19:21 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385d7d4d9b0sm11659108f8f.65.2024.12.02.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:19:20 -0800 (PST)
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
Date: Mon,  2 Dec 2024 19:19:07 +0100
Message-ID: <20241202181907.21471-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202181907.21471-1-vassilisamir@gmail.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sleep functions to the new fsleep() implementation. While at it,
add time unit abbreviation as a suffix of time describing variables to
make them more intuitive.

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


