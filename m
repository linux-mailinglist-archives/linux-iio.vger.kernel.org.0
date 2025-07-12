Return-Path: <linux-iio+bounces-21593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F18B02B83
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 16:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B601560160
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65331DFD96;
	Sat, 12 Jul 2025 14:49:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4327FB2A
	for <linux-iio@vger.kernel.org>; Sat, 12 Jul 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752331766; cv=none; b=PMhtAyHnjeUySUOCCv4Bzs3TvEjUSOSuBhXZTGrZeyOoDbU+pY12x07yqpyRO7cQEBSN8XKpvvvRYqVK3XY9dVnWcobHkXoN10npDno9o7EX1uQnIMjZwjB0q9sp61JnButtPYAgOZ1eUuXjez0vZYK/V3X4XXaUlnsPRjhKU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752331766; c=relaxed/simple;
	bh=joYgwIwJumk8hVsmpEMFt+8rhjZ79GEu9HrwbJjmqEg=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=KAKK7xqlfZ5IocYvkAaloJjqUfyYd8f4kb18uQvzR0bZ58+D/fAphYi2nRaZ20cftpYrp9dCT+g2iNLQNpKNy2MgYp01dC+DOvlRCUwQPI26uPCUjEeYu0/7s3SVnZ4/VhpqaliXSwAg4+8Z0sRzeu9DGDneJnzOFKcwJ03vwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1uabXT-00057m-Cf
	for linux-iio@vger.kernel.org; Sat, 12 Jul 2025 16:49:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Sat, 12 Jul 2025 16:49:13 +0200
Organization: Linux Private Site
Message-ID: <875xfx8nx2.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20241017233022.238250-2-vassilisamir@gmail.com>
	<875xgfg0wz.fsf@Gerda.invalid>
	<c894cfda-a775-4598-ac3b-b3d35c6a84b3@baylibre.com>
	<87a55azgdr.fsf@Gerda.invalid>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:lFsEGxI2f0DejaACBa4UkupL0rE=

ASSI writes:
> I'll try my suggestion of a tapered wait later, perhaps over the
> weekend, now that I don't need to reboot to play around with the module
> code.

That works and indeed even slightly reduces the acquisition times with
my slow sensor specimen, so it does not always need the maximum time
(but very close).  I've also implemented switching off unused channels
during the read through the simple sysfs interface, which does not
support to read all channels in a single measurement.  The temperature
reading is required for both humidity and pressure compensation so it
can only be set to oversampling=1 but not switched off.  For
oversampling=1 on all channels unfortunately the overhead of doing this
almost compensates for the savings made in measurement time, but any
other setting will be a net win:

| oversampling | max/full | max/skip | time/full | time/skip |
|              |     [ms] |     [ms] |      [ms] |      [ms] |
|--------------+----------+----------+-----------+-----------|
|           16 |      339 |      120 |       315 |       127 |
|            8 |      174 |       65 |       166 |        76 |
|            4 |       90 |       38 |        94 |        53 |
|            2 |       49 |       24 |        59 |        41 |
|            1 |       28 |       17 |        36 |        33 |

I suspect the overhead at lower oversampling factors is significantly
lower for SPI interfaced sensors that I cannot currently test.  I've
left a constant in the code to control the skip threshold if anybody
wants to play with it, but the final solution will probably be to either
skip always or make it even more configurable by exposing this facility
via sysfs.  Getting the original channel config restored on all exit
paths is a bit stilted and calls for a bit of refactoring (or even a
goto) but for now this should suffice. Patch:

--8<---------------cut here---------------start------------->8---
--- /usr/src/linux-6.15.5-1//drivers/iio/pressure/bmp280-core.c
+++ bmp280-6.15.5-1/bmp280-core.c
@@ -618,19 +618,77 @@
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int chan_value;
 	int ret;
+	int prev_oversampling_humid, prev_oversampling_press, prev_oversampling_temp;
+	int temp_oversampling_humid, temp_oversampling_press, temp_oversampling_temp;
+	int switch_off, switch_threshold = -1;
 
 	guard(mutex)(&data->lock);
 
+	prev_oversampling_humid = temp_oversampling_humid = data->oversampling_humid;
+	prev_oversampling_press = temp_oversampling_press = data->oversampling_press;
+	prev_oversampling_temp  = temp_oversampling_temp  = data->oversampling_temp;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
+		/* switch off unused channels */
+		switch_off = 0;
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			temp_oversampling_press = 0-1;
+			switch_off |= (prev_oversampling_press > switch_threshold);
+			temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+			break;
+		case IIO_PRESSURE:
+			temp_oversampling_humid = 0-1;
+			switch_off |= (prev_oversampling_humid > switch_threshold);
+			temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+			break;
+		case IIO_TEMP:
+			temp_oversampling_humid = 0-1;
+			temp_oversampling_press = 0-1;
+			switch_off = (prev_oversampling_humid > switch_threshold)  |  (prev_oversampling_press > switch_threshold);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (switch_off) {
+			data->oversampling_humid = temp_oversampling_humid;
+			data->oversampling_press = temp_oversampling_press;
+			data->oversampling_temp  = temp_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				data->oversampling_humid = prev_oversampling_humid;
+				data->oversampling_press = prev_oversampling_press;
+				data->oversampling_temp  = prev_oversampling_temp;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+		}
+
 		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
+		if (ret) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			data->chip_info->chip_config(data);
 			return ret;
+		}
 
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
 			return ret;
 
+		/* restore channel configuration */
+		if (switch_off) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				return ret;
+			}
+		}
+
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
 			ret = data->chip_info->read_humid(data, &chan_value);
@@ -660,13 +718,60 @@
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
+		/* switch off unused channels */
+		switch_off = 0;
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			temp_oversampling_press = 0-1;
+			switch_off |= (prev_oversampling_press > switch_threshold);
+			temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+			break;
+		case IIO_PRESSURE:
+			temp_oversampling_humid = 0-1;
+			switch_off |= (prev_oversampling_humid > switch_threshold);
+			temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+			break;
+		case IIO_TEMP:
+			temp_oversampling_humid = 0-1;
+			temp_oversampling_press = 0-1;
+			switch_off = (prev_oversampling_humid > switch_threshold)  |  (prev_oversampling_press > switch_threshold);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (switch_off) {
+			data->oversampling_humid = temp_oversampling_humid;
+			data->oversampling_press = temp_oversampling_press;
+			data->oversampling_temp  = temp_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				data->oversampling_humid = prev_oversampling_humid;
+				data->oversampling_press = prev_oversampling_press;
+				data->oversampling_temp  = prev_oversampling_temp;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+		}
 
 		ret = data->chip_info->wait_conv(data);
-		if (ret)
+		if (ret) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			data->chip_info->chip_config(data);
 			return ret;
+		}
+
+		/* restore channel configuration */
+		if (switch_off) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				return ret;
+			}
+		}
 
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -1040,15 +1145,15 @@
 {
 	unsigned int reg, meas_time_us;
 	int ret;
+	int meas_cycles = 4;
+
+	meas_time_us = BMP280_MEAS_OFFSET;
 
 	/* Check if we are using a BME280 device */
 	if (data->oversampling_humid)
-		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
 				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
 
-	else
-		meas_time_us = 0;
-
 	/* Pressure measurement time */
 	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
 			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
@@ -1056,14 +1161,18 @@
 	/* Temperature measurement time */
 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
 
-	/* Waiting time according to the BM(P/E)2 Sensor API */
-	fsleep(meas_time_us);
+	do {
+		/* Waiting time according to the BM(P/E)2 Sensor API */
+		fsleep(meas_time_us);
+
+		ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+		if (ret) {
+			dev_err(data->dev, "failed to read status register.\n");
+			return ret;
+		}
 
-	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
-	if (ret) {
-		dev_err(data->dev, "failed to read status register.\n");
-		return ret;
-	}
+		meas_time_us >>= 3;
+	} while ((reg & BMP280_REG_STATUS_MEAS_BIT) && --meas_cycles);
 
 	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
 		dev_err(data->dev, "Measurement cycle didn't complete.\n");

--- /usr/src/linux-6.15.5-1//drivers/iio/pressure/bmp280.0
+++ bmp280-6.15.5-1/bmp280.h
@@ -269,9 +269,9 @@
 #define BMP280_MODE_FORCED		1
 #define BMP280_MODE_NORMAL		3
 
-#define BMP280_MEAS_OFFSET		1250
-#define BMP280_MEAS_DUR			2300
-#define BMP280_PRESS_HUMID_MEAS_OFFSET	575
+#define BMP280_MEAS_OFFSET		1095 /* ceil(1250/(1+2^-3+2^-6+2^-9) */
+#define BMP280_MEAS_DUR			2013 /* ceil(2300/(1+2^-3+2^-6+2^-9) */
+#define BMP280_PRESS_HUMID_MEAS_OFFSET	504  /* ceil( 575/(1+2^-3+2^-6+2^-9) */
 
 /* BME280 specific registers */
 #define BME280_REG_HUMIDITY_LSB		0xFE
--8<---------------cut here---------------end--------------->8---


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds


