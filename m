Return-Path: <linux-iio+bounces-22062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E836FB13178
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E573B7A13B9
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014901CAA85;
	Sun, 27 Jul 2025 19:08:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BE19A2A3
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753643336; cv=none; b=hRf3XZ6IFrCVLMrg3kf8InxMpZyRQ3CmlEg9Uy1FjgHO36FiQXCKJg4Wr4K8L/PrQvYy6OY6pvSIMh8TrKoDqhV3YXo4oMQSI5R+DIAtc4WB0V+EJDn1se6KRP+TpuF6QlWJk5LuKRhlpxpWHIk7CyQSQZ9UWR4PjkjNwnkUrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753643336; c=relaxed/simple;
	bh=zxK9vf2HAXuqZuJqxUUfW0oxpcW67KzqUaMiF12bYNE=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=HhFR86uCFVXyvLRFw9G7bA1BQt3DhER3xdukTGn0uG0jrNszip5YsCeeviMkGXLEjDRhfZt7Lu59cp8pQgankEmiPDQS6Bojn7XJmeZbOE/A7i70TfBO7Jvey5rO9cKHSnL5KyQIEWESLmwOCgOHVf58FPeHxmtwoWXBfDs2Ni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ug6jl-000ADX-4n
	for linux-iio@vger.kernel.org; Sun, 27 Jul 2025 21:08:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Sun, 27 Jul 2025 21:08:39 +0200
Organization: Linux Private Site
Message-ID: <87ldo9wix4.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20241017233022.238250-2-vassilisamir@gmail.com>
	<875xgfg0wz.fsf@Gerda.invalid>
	<c894cfda-a775-4598-ac3b-b3d35c6a84b3@baylibre.com>
	<87a55azgdr.fsf@Gerda.invalid> <875xfx8nx2.fsf@Gerda.invalid>
	<87pldm244b.fsf@Gerda.invalid>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:fYerhLk7TUXnNm+K5T/k8M51x38=

ASSI writes:
> ASSI writes:
> Since the BMx280 don't actually have a frequency setting and need to set
> standby times between measurements instead (for which I haven't found an
> easily usable parameter in the IIO framework), the permissible frequency
> settings are calculated for the lowest possible measurement time
> (oversampling=1 for all channels).  The actual frequencies could be
> caclulated from the current settings and made available on read, but I
> haven't implemented that yet -- at the moment you'll get back the value
> you have set independent of the actual oversampling ratios.

Implemented and that actually helped find another bug hiding in plain
sight in the original code…

> Another issue I found while perusing the sources is that the filter has
> a fixed setting of 4 for these chips, which might be made changeable by
> using the filter_coefficient.  Not looked at what that entails,
> though.

Implemented.

> I've got a sparse checkout of the kernel repo now, so if you think that
> this may be acceptable I can work on getting that into the form you are
> expecting (either a single commit or a series) and iron out any kinks
> you see.

I have a patch series that checkpatch.pl no longer complains about, but
I'll probably go over it at least one more time before submission.

Full patch for anybody wanting to give it a try (BMx[135]80 need testing
since I don't have any):

--8<---------------cut here---------------start------------->8---
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f37f20776c89..22a49356ca9c 100644
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
@@ -159,6 +185,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -174,6 +202,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -193,6 +223,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -208,6 +240,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -223,6 +257,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 2,
 		.scan_type = {
 			.sign = 'u',
@@ -612,6 +648,45 @@ static int bme280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
 	return 0;
 }
 
+static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
+{
+	unsigned int meas_time_us = BMP280_MEAS_OFFSET;
+
+	meas_time_us = BMP280_MEAS_OFFSET;
+
+	/* Check if we are using a BME280 device */
+	if (data->chip_info->oversampling_humid_avail)
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
+
+	/* Pressure measurement time */
+	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
+
+	/* Temperature measurement time */
+	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
+
+	/* nominal value */
+	return meas_time_us;
+}
+
+static void bmp280_calc_sampling_frequency(struct bmp280_data *data, int *val, int *val2)
+{
+	unsigned int cycle_time_us;
+	unsigned long freq_uHz;
+
+	if (data->chip_info->sampling_freq_tstby) {
+		cycle_time_us  = bmp280_calc_meas_time_us(data);
+		cycle_time_us += data->chip_info->sampling_freq_tstby[data->sampling_freq];
+		freq_uHz = 1000000000000L / cycle_time_us;
+		*val  = freq_uHz / 1000000L;
+		*val2 = freq_uHz % 1000000L;
+	} else {
+		*val  = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
+		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
+	}
+}
+
 static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -619,55 +694,68 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int chan_value;
 	int ret;
+	int prev_oversampling_humid, prev_oversampling_press, prev_oversampling_temp;
+	int temp_oversampling_humid, temp_oversampling_press, temp_oversampling_temp;
+	int switch_off, switch_threshold = -1;
+	int raw = 0;
 
 	guard(mutex)(&data->lock);
 
+	prev_oversampling_humid = temp_oversampling_humid = data->oversampling_humid;
+	prev_oversampling_press = temp_oversampling_press = data->oversampling_press;
+	prev_oversampling_temp  = temp_oversampling_temp  = data->oversampling_temp;
+
+	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
+
 	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		raw = 1;
+		fallthrough;
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
 
-		switch (chan->type) {
-		case IIO_HUMIDITYRELATIVE:
-			ret = data->chip_info->read_humid(data, &chan_value);
-			if (ret)
-				return ret;
-
-			*val = data->chip_info->humid_coeffs[0] * chan_value;
-			*val2 = data->chip_info->humid_coeffs[1];
-			return data->chip_info->humid_coeffs_type;
-		case IIO_PRESSURE:
-			ret = data->chip_info->read_press(data, &chan_value);
-			if (ret)
-				return ret;
-
-			*val = data->chip_info->press_coeffs[0] * chan_value;
-			*val2 = data->chip_info->press_coeffs[1];
-			return data->chip_info->press_coeffs_type;
-		case IIO_TEMP:
-			ret = data->chip_info->read_temp(data, &chan_value);
+		if (switch_off) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
 			if (ret)
 				return ret;
-
-			*val = data->chip_info->temp_coeffs[0] * chan_value;
-			*val2 = data->chip_info->temp_coeffs[1];
-			return data->chip_info->temp_coeffs_type;
-		default:
-			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_RAW:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
-
-		ret = data->chip_info->wait_conv(data);
-		if (ret)
-			return ret;
 
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -675,22 +763,40 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
-			*val = chan_value;
-			return IIO_VAL_INT;
+			if (raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			} else {
+				*val = data->chip_info->humid_coeffs[0] * chan_value;
+				*val2 = data->chip_info->humid_coeffs[1];
+				return data->chip_info->humid_coeffs_type;
+			}
 		case IIO_PRESSURE:
 			ret = data->chip_info->read_press(data, &chan_value);
 			if (ret)
 				return ret;
 
-			*val = chan_value;
-			return IIO_VAL_INT;
+			if (raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			} else {
+				*val = data->chip_info->press_coeffs[0] * chan_value;
+				*val2 = data->chip_info->press_coeffs[1];
+				return data->chip_info->press_coeffs_type;
+			}
 		case IIO_TEMP:
 			ret = data->chip_info->read_temp(data, &chan_value);
 			if (ret)
 				return ret;
 
-			*val = chan_value;
-			return IIO_VAL_INT;
+			if (raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			} else {
+				*val = data->chip_info->temp_coeffs[0] * chan_value;
+				*val2 = data->chip_info->temp_coeffs[1];
+				return data->chip_info->temp_coeffs_type;
+			}
 		default:
 			return -EINVAL;
 		}
@@ -728,19 +834,26 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!data->chip_info->sampling_freq_avail)
 			return -EINVAL;
-
-		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
-		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
+		bmp280_calc_sampling_frequency(data, val, val2);
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (!data->chip_info->iir_filter_coeffs_avail)
 			return -EINVAL;
 
-		*val = (1 << data->iir_filter_coeff) - 1;
+		*val = data->chip_info->iir_filter_coeffs_avail[data->iir_filter_coeff];
 		return IIO_VAL_INT;
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
@@ -852,6 +965,10 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
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
@@ -866,7 +983,7 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	int i;
 
 	for (i = 0; i < n; i++) {
-		if (avail[i] - 1  == val) {
+		if (avail[i]  == val) {
 			prev = data->iir_filter_coeff;
 			data->iir_filter_coeff = i;
 
@@ -988,6 +1105,54 @@ static const unsigned long bme280_avail_scan_masks[] = {
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
+/* must be the same size as the ODR table */
+static const int bmp280_tstby_table[] = {
+	[BMP280_ODR_0HZ]	=       0,
+	[BMP280_ODR_110HZ]	=     500,
+	[BMP280_ODR_14HZ]	=   62500,
+	[BMP280_ODR_7_5HZ]	=  125000,
+	[BMP280_ODR_3_85HZ]	=  250000,
+	[BMP280_ODR_1_96HZ]	=  500000,
+	[BMP280_ODR_0_99HZ]	= 1000000,
+	[BMP280_ODR_0_49HZ]	= 2000000,
+	[BMP280_ODR_0_24HZ]	= 4000000,
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
+/* must be the same size as the ODR table */
+static const int bme280_tstby_table[] = {
+	[BME280_ODR_0HZ]	=       0,
+	[BME280_ODR_110HZ]	=     500,
+	[BME280_ODR_14HZ]	=   62500,
+	[BME280_ODR_7_5HZ]	=  125000,
+	[BME280_ODR_3_85HZ]	=  250000,
+	[BME280_ODR_1_96HZ]	=  500000,
+	[BME280_ODR_0_99HZ]	= 1000000,
+	[BME280_ODR_51HZ]	=   10000,
+	[BME280_ODR_34HZ]	=   20000,
+};
+
 static int bmp280_preinit(struct bmp280_data *data)
 {
 	struct device *dev = data->dev;
@@ -1025,6 +1190,8 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 {
 	int ret;
 
+	data->op_mode = BMP280_SLEEP;
+
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				BMP280_MODE_MASK, bmp280_operation_mode[mode]);
 	if (ret) {
@@ -1041,30 +1208,32 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 {
 	unsigned int reg, meas_time_us;
 	int ret;
+	int meas_cycles = 4;
 
-	/* Check if we are using a BME280 device */
-	if (data->oversampling_humid)
-		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
-				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
+	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
+	ret = data->chip_info->set_mode(data, data->op_mode);
+	if (ret)
+		return ret;
 
-	else
-		meas_time_us = 0;
+	if (data->op_mode == BMP280_NORMAL)
+		return 0;
 
-	/* Pressure measurement time */
-	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
-			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
+	meas_time_us = bmp280_calc_meas_time_us(data);
 
-	/* Temperature measurement time */
-	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
+	do {
+		/* Waiting time according to the BM(P/E)2 Sensor API */
+		fsleep(meas_time_us);
 
-	/* Waiting time according to the BM(P/E)2 Sensor API */
-	fsleep(meas_time_us);
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
+
+       	data->op_mode = BMP280_SLEEP;
 
 	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
@@ -1078,6 +1247,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
 		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 tstby = FIELD_PREP(BMP280_TSTBY_MASK, (data->sampling_freq ? data->sampling_freq - 1 : 0));
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
@@ -1091,8 +1261,9 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	}
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
+				 BMP280_TSTBY_MASK |
 				 BMP280_FILTER_MASK,
-				 BMP280_FILTER_4X);
+				 tstby | data->iir_filter_coeff);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
@@ -1157,6 +1328,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 static const int bmp280_temp_coeffs[] = { 10, 1 };
 static const int bmp280_press_coeffs[] = { 1, 256000 };
+static const int bmp280_iir_filter_coeffs_avail[] = { 0, 2, 4, 8, 16 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -1186,6 +1358,15 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.sampling_freq_tstby = bmp280_tstby_table,
+	.sampling_freq_avail = bmp280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
+	.sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */
+
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1371,6 +1552,15 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.sampling_freq_tstby = bme280_tstby_table,
+	.sampling_freq_avail = bme280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
+	.sampling_freq_default = BME280_ODR_0HZ, /* MODE_FORCED */
+
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1701,6 +1891,11 @@ static int bmp380_wait_conv(struct bmp280_data *data)
 	unsigned int reg;
 	int ret, meas_time_us;
 
+	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
+	ret = data->chip_info->set_mode(data, data->op_mode);
+	if (ret)
+		return ret;
+
 	/* Offset measurement time */
 	meas_time_us = BMP380_MEAS_OFFSET;
 
@@ -1954,7 +2149,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 }
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
-static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
+static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 static const int bmp380_temp_coeffs[] = { 10, 1 };
 static const int bmp380_press_coeffs[] = { 1, 100000 };
@@ -2435,6 +2630,12 @@ static int bmp580_wait_conv(struct bmp280_data *data)
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
index 25bb9c743a05..990ccb38da13 100644
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
@@ -501,6 +521,7 @@ struct bmp280_chip_info {
 	int num_iir_filter_coeffs_avail;
 	int iir_filter_coeff_default;
 
+	const int *sampling_freq_tstby;
 	const int (*sampling_freq_avail)[2];
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
--8<---------------cut here---------------end--------------->8---


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+



