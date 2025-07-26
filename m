Return-Path: <linux-iio+bounces-22028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21033B12BDB
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 20:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1BE177323
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481528643F;
	Sat, 26 Jul 2025 18:34:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1E645
	for <linux-iio@vger.kernel.org>; Sat, 26 Jul 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753554869; cv=none; b=AiCK6hAKGRgiNM7ZpzE4exYrJ1XrFxDAmgVrQYgXIkC/PvpqycTCjjwzTcSD2jzJol0VqH4SbCB6uMBhYNgNAWp5IUOFaA5XVl7Ze5yiEeZuQa00oSfAwyAgLz1i+facpB0YkMZXo35iqxDf6PnYdAASQ/GA0mHdlNf1tgnfCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753554869; c=relaxed/simple;
	bh=iJfeOSq4+Yhn5gpvwoBzGDQlN3zGEYD2jEqRvKBin9A=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=JW9q2KM0FbwqYoRJgtjyTArWNmuTloBr0x1I691GyUWyS2idj7YSUeQep0YKaz32iNkMtVc9D2RnnRLZ+/qZNfN+tGb+cXfPcCyXPnoepLxQa/PATcwCt2bIZZ1DJ7YTmddyypiVJYImbF57cIfuYChjdcn0ezUtIYxIiLzOmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ufjis-0008GX-4G
	for linux-iio@vger.kernel.org; Sat, 26 Jul 2025 20:34:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Sat, 26 Jul 2025 20:34:12 +0200
Organization: Linux Private Site
Message-ID: <87pldm244b.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20241017233022.238250-2-vassilisamir@gmail.com>
	<875xgfg0wz.fsf@Gerda.invalid>
	<c894cfda-a775-4598-ac3b-b3d35c6a84b3@baylibre.com>
	<87a55azgdr.fsf@Gerda.invalid> <875xfx8nx2.fsf@Gerda.invalid>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:J7tzt/BLkjr53YNwPiR9tDwrko0=

ASSI writes:
> That works and indeed even slightly reduces the acquisition times with
> my slow sensor specimen, so it does not always need the maximum time
> (but very close).  I've also implemented switching off unused channels
> during the read through the simple sysfs interface, which does not
> support to read all channels in a single measurement.  The temperature
> reading is required for both humidity and pressure compensation so it
> can only be set to oversampling=1 but not switched off.  For
> oversampling=1 on all channels unfortunately the overhead of doing this
> almost compensates for the savings made in measurement time, but any
> other setting will be a net win:
>
> | oversampling | max/full | max/skip | time/full | time/skip |
> |              |     [ms] |     [ms] |      [ms] |      [ms] |
> |--------------+----------+----------+-----------+-----------|
> |           16 |      339 |      120 |       315 |       127 |
> |            8 |      174 |       65 |       166 |        76 |
> |            4 |       90 |       38 |        94 |        53 |
> |            2 |       49 |       24 |        59 |        41 |
> |            1 |       28 |       17 |        36 |        33 |
>
> I suspect the overhead at lower oversampling factors is significantly
> lower for SPI interfaced sensors that I cannot currently test.  I've
> left a constant in the code to control the skip threshold if anybody
> wants to play with it, but the final solution will probably be to either
> skip always or make it even more configurable by exposing this facility
> via sysfs.  Getting the original channel config restored on all exit
> paths is a bit stilted and calls for a bit of refactoring (or even a
> goto) but for now this should suffice. Patch:

As the acquisition times were still more than four times higher than
before, I've implemented the sampling_frequency endpoint for the BMx280
devices and only use the forced measurement mode when it is set to zero
(which is the default to keep the userspace behaviour identical to the
previous version).  That gets me back to ~9ms read of all three channels
since I no longer need to wait for the measurements, almost like it was
before the change to forced mode.  The extra 2ms probably come from the
unconditional set_mode call, which I inserted since otherwise the chip
would sometimes get stuck in the wrong mode and not do any measurements
until I wrote to sampling_frequency again.

Since the BMx280 don't actually have a frequency setting and need to set
standby times between measurements instead (for which I haven't found an
easily usable parameter in the IIO framework), the permissible frequency
settings are calculated for the lowest possible measurement time
(oversampling=1 for all channels).  The actual frequencies could be
caclulated from the current settings and made available on read, but I
haven't implemented that yet -- at the moment you'll get back the value
you have set independent of the actual oversampling ratios.

Another issue I found while perusing the sources is that the filter has
a fixed setting of 4 for these chips, which might be made changeable by
using the filter_coefficient.  Not looked at what that entails, though.

I've got a sparse checkout of the kernel repo now, so if you think that
this may be acceptable I can work on getting that into the form you are
expecting (either a single commit or a series) and iron out any kinks
you see.

--8<---------------cut here---------------start------------->8---
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f37f20776c89..79bd2bba22ca 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -64,7 +64,32 @@
  */
 enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
 
+enum bmp280_odr {
+	BMP280_ODR_0HZ,		/* MODE_FORCED */
+	BMP280_ODR_110HZ,	/* t_sb =  0.5ms */
+	BMP280_ODR_14HZ,	/* t_sb = 62.5ms */
+	BMP280_ODR_7_5HZ,	/* t_sb =  125ms */
+	BMP280_ODR_3_85HZ,	/* t_sb =  250ms */
+	BMP280_ODR_1_96HZ,	/* t_sb =  500ms */
+	BMP280_ODR_0_99HZ,	/* t_sb = 1000ms */
+	BMP280_ODR_0_49HZ,	/* t_sb = 2000ms */
+	BMP280_ODR_0_24HZ,	/* t_sb = 4000ms */
+};
+
+enum bme280_odr {
+	BME280_ODR_0HZ,		/* MODE_FORCED */
+	BME280_ODR_110HZ,	/* t_sb =  0.5ms */
+	BME280_ODR_14HZ,	/* t_sb = 62.5ms */
+	BME280_ODR_7_5HZ,	/* t_sb =  125ms */
+	BME280_ODR_3_85HZ,	/* t_sb =  250ms */
+	BME280_ODR_1_96HZ,	/* t_sb =  500ms */
+	BME280_ODR_0_99HZ,	/* t_sb = 1000ms */
+	BME280_ODR_51HZ,	/* t_sb =   10ms */
+	BME280_ODR_34HZ,	/* t_sb =   20ms */
+};
+
 enum bmp380_odr {
+	BMP380_ODR_0HZ,		/* MODE_FORCED */
 	BMP380_ODR_200HZ,
 	BMP380_ODR_100HZ,
 	BMP380_ODR_50HZ,
@@ -86,6 +111,7 @@ enum bmp380_odr {
 };
 
 enum bmp580_odr {
+	BMP580_ODR_0HZ,		/* MODE_FORCED */
 	BMP580_ODR_240HZ,
 	BMP580_ODR_218HZ,
 	BMP580_ODR_199HZ,
@@ -159,6 +185,7 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -174,6 +201,7 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -193,6 +221,7 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -208,6 +237,7 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -223,6 +253,7 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 2,
 		.scan_type = {
 			.sign = 'u',
@@ -619,18 +650,65 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
+	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
+		switch_off = 0;
+		if (data->op_mode == BMP280_FORCED) {
+			/* switch off unused channels */
+			switch (chan->type) {
+			case IIO_HUMIDITYRELATIVE:
+				temp_oversampling_press = 0-1;
+				switch_off |= (prev_oversampling_press > switch_threshold);
+				temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+				break;
+			case IIO_PRESSURE:
+				temp_oversampling_humid = 0-1;
+				switch_off |= (prev_oversampling_humid > switch_threshold);
+				temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+				break;
+			case IIO_TEMP:
+				temp_oversampling_humid = 0-1;
+				temp_oversampling_press = 0-1;
+				switch_off = (prev_oversampling_humid > switch_threshold)  |  (prev_oversampling_press > switch_threshold);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+		if (switch_off) {
+			data->oversampling_humid = temp_oversampling_humid;
+			data->oversampling_press = temp_oversampling_press;
+			data->oversampling_temp  = temp_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret)
+				goto restore;
+		}
 
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
-			return ret;
+			goto restore;
+
+		if (switch_off) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			data->chip_info->chip_config(data);
+			if (ret) {
+				return ret;
+			}
+		}
 
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -661,13 +739,51 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
+		switch_off = 0;
+		if (data->op_mode == BMP280_FORCED) {
+			/* MODE_FORCED, switch off unused channels */
+			switch (chan->type) {
+			case IIO_HUMIDITYRELATIVE:
+				temp_oversampling_press = 0-1;
+				switch_off |= (prev_oversampling_press > switch_threshold);
+				temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+				break;
+			case IIO_PRESSURE:
+				temp_oversampling_humid = 0-1;
+				switch_off |= (prev_oversampling_humid > switch_threshold);
+				temp_oversampling_temp  = 1-1; /* can't be switched off as it is needed for compensation */
+				break;
+			case IIO_TEMP:
+				temp_oversampling_humid = 0-1;
+				temp_oversampling_press = 0-1;
+				switch_off = (prev_oversampling_humid > switch_threshold)  |  (prev_oversampling_press > switch_threshold);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+		if (switch_off) {
+			data->oversampling_humid = temp_oversampling_humid;
+			data->oversampling_press = temp_oversampling_press;
+			data->oversampling_temp  = temp_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret)
+				goto restore;
+		}
 
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
-			return ret;
+			goto restore;
+
+		if (switch_off) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			data->chip_info->chip_config(data);
+			if (ret) {
+				return ret;
+			}
+		}
 
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -741,6 +857,15 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
+	restore:
+	if (switch_off) {
+	/* restore channel configuration */
+		data->oversampling_humid = prev_oversampling_humid;
+		data->oversampling_press = prev_oversampling_press;
+		data->oversampling_temp  = prev_oversampling_temp;
+		data->chip_info->chip_config(data);
+	}
+	return ret;
 }
 
 static int bmp280_read_raw(struct iio_dev *indio_dev,
@@ -852,6 +977,10 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
 				data->chip_info->chip_config(data);
 				return ret;
 			}
+			ret = data->chip_info->set_mode(data, (i ? BMP280_NORMAL : BMP280_FORCED));
+			if (ret)
+				return ret;
+
 			return 0;
 		}
 	}
@@ -988,6 +1117,30 @@ static const unsigned long bme280_avail_scan_masks[] = {
 	0
 };
 
+static const int bmp280_odr_table[][2] = {
+	[BMP280_ODR_0HZ]	= {0,       0}, /* MODE_FORCED */
+	[BMP280_ODR_110HZ]	= {110,     0},
+	[BMP280_ODR_14HZ]	= {14,      0},
+	[BMP280_ODR_7_5HZ]	= {7,  500000},
+	[BMP280_ODR_3_85HZ]	= {3,  850000},
+	[BMP280_ODR_1_96HZ]	= {1,  960000},
+	[BMP280_ODR_0_99HZ]	= {0,  990000},
+	[BMP280_ODR_0_49HZ]	= {0,  490000},
+	[BMP280_ODR_0_24HZ]	= {0,  240000},
+};
+
+static const int bme280_odr_table[][2] = {
+	[BME280_ODR_0HZ]	= {0,       0}, /* MODE_FORCED */
+	[BME280_ODR_110HZ]	= {110,     0},
+	[BME280_ODR_14HZ]	= {14,      0},
+	[BME280_ODR_7_5HZ]	= {7,  500000},
+	[BME280_ODR_3_85HZ]	= {3,  850000},
+	[BME280_ODR_1_96HZ]	= {1,  960000},
+	[BME280_ODR_0_99HZ]	= {0,  990000},
+	[BME280_ODR_51HZ]	= {51,      0},
+	[BME280_ODR_34HZ]	= {34,      0},
+};
+
 static int bmp280_preinit(struct bmp280_data *data)
 {
 	struct device *dev = data->dev;
@@ -1037,19 +1190,15 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 	return 0;
 }
 
-static int bmp280_wait_conv(struct bmp280_data *data)
+static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
 {
-	unsigned int reg, meas_time_us;
-	int ret;
+	unsigned int meas_time_us = BMP280_MEAS_OFFSET;
 
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
@@ -1057,14 +1206,38 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	/* Temperature measurement time */
 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
 
-	/* Waiting time according to the BM(P/E)2 Sensor API */
-	fsleep(meas_time_us);
+	/* nominal value */
+	return meas_time_us;
+}
 
-	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
-	if (ret) {
-		dev_err(data->dev, "failed to read status register.\n");
+static int bmp280_wait_conv(struct bmp280_data *data)
+{
+	unsigned int reg, meas_time_us;
+	int ret;
+	int meas_cycles = 4;
+
+	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
+	ret = data->chip_info->set_mode(data, data->op_mode);
+	if (ret)
 		return ret;
-	}
+
+	if (data->op_mode == BMP280_NORMAL)
+		return 0;
+
+	meas_time_us = bmp280_calc_meas_time_us(data);
+
+	do {
+		/* Waiting time according to the BM(P/E)2 Sensor API */
+		fsleep(meas_time_us);
+
+		ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+		if (ret) {
+			dev_err(data->dev, "failed to read status register.\n");
+			return ret;
+		}
+
+		meas_time_us >>= 3;
+	} while ((reg & BMP280_REG_STATUS_MEAS_BIT) && --meas_cycles);
 
 	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
@@ -1078,6 +1251,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
 		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 tstby = FIELD_PREP(BMP280_TSTBY_MASK, (data->sampling_freq ? data->sampling_freq - 1 : 0));
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
@@ -1091,8 +1265,9 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	}
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
-				 BMP280_FILTER_MASK,
-				 BMP280_FILTER_4X);
+				 BMP280_FILTER_MASK |
+				 BMP280_TSTBY_MASK,
+				 tstby | BMP280_FILTER_4X);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
@@ -1186,6 +1361,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.sampling_freq_avail = bmp280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
+	.sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1371,6 +1550,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.sampling_freq_avail = bme280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
+	.sampling_freq_default = BME280_ODR_0HZ, /* MODE_FORCED */
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1701,6 +1884,11 @@ static int bmp380_wait_conv(struct bmp280_data *data)
 	unsigned int reg;
 	int ret, meas_time_us;
 
+	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
+	ret = data->chip_info->set_mode(data, data->op_mode);
+	if (ret)
+		return ret;
+
 	/* Offset measurement time */
 	meas_time_us = BMP380_MEAS_OFFSET;
 
@@ -2435,6 +2623,12 @@ static int bmp580_wait_conv(struct bmp280_data *data)
 		21840,
 	};
 	int meas_time_us;
+	int ret;
+
+	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
+	ret = data->chip_info->set_mode(data, data->op_mode);
+	if (ret)
+		return ret;
 
 	meas_time_us = 4 * USEC_PER_MSEC +
 		       time_conv_temp[data->oversampling_temp] +
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 25bb9c743a05..0ec8a8e142f0 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -248,6 +248,16 @@
 #define BMP280_FILTER_8X		3
 #define BMP280_FILTER_16X		4
 
+#define BMP280_TSTBY_MASK		GENMASK(7, 5)
+#define BMP280_TSTBY_0_5		0
+#define BMP280_TSTBY_62_5		1
+#define BMP280_TSTBY_125		2
+#define BMP280_TSTBY_250		3
+#define BMP280_TSTBY_500		4
+#define BMP280_TSTBY_1000		5
+#define BMP280_TSTBY_2000		6
+#define BMP280_TSTBY_4000		7
+
 #define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
 #define BMP280_OSRS_TEMP_SKIP		0
 #define BMP280_OSRS_TEMP_1X		1
@@ -269,9 +279,9 @@
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
@@ -294,6 +304,16 @@
 
 #define BME280_CONTIGUOUS_CALIB_REGS	7
 
+#define BME280_TSTBY_MASK		GENMASK(7, 5)
+#define BME280_TSTBY_0_5		0
+#define BME280_TSTBY_62_5		1
+#define BME280_TSTBY_125		2
+#define BME280_TSTBY_250		3
+#define BME280_TSTBY_500		4
+#define BME280_TSTBY_1000		5
+#define BME280_TSTBY_1			6
+#define BME280_TSTBY_20			7
+
 #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
 #define BME280_OSRS_HUMIDITY_SKIP	0
 #define BME280_OSRS_HUMIDITY_1X		1
--8<---------------cut here---------------end--------------->8---


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


