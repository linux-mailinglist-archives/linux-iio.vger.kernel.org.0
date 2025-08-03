Return-Path: <linux-iio+bounces-22217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7131FB1942A
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F91E3B6037
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DED220686;
	Sun,  3 Aug 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="Cky8TDT8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B147DF71
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230161; cv=none; b=JtgigCZ8UdRbxFD/OWyA+5RFvm3v4C0B/K8TZtfl7xx0n+6CrrfoRe1H7Xxk/q2VVRW3l3pM5YA9fXIAHaF+TkJq6i2NFjd9vltDv1ZBXe8vuTMpGYRxBNjc4lN5UuqucTbxB4/jLOp7nVKo3wnX6P1mWV/zk9UOhYi/LiZRHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230161; c=relaxed/simple;
	bh=Fs8NuUucjVb7RG9B5/jWDCvRv2TqfAYgd0He0NdEYds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVMHTTCI251j03zfY+3xSa/fABAf25QYtzh+ipf1BVGzPX3ZndSyDtzLthSrdBDW6rPT02D7H2qATFd3D9axd1+tcbQFypF9pQQx5HFRhzSZngXslzJMKFMDgz4C20jaDEn8uZF+gj1lDO5p7PgVi6d8jpyO8OwWDbs9pfRX+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=Cky8TDT8; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 9B113240713;
	Sun,  3 Aug 2025 16:09:15 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 053FE240517;
	Sun,  3 Aug 2025 16:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754230154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8rosDpARKABKLhpKWnShvoWEy2ipCWO/xHtT6X7dsE=;
	b=Cky8TDT87WxzFvxbKLNClB9oZy3yAGFcagLlK+6rqq0tfq4PNxkQJxGUbTBpforrSxO3sR
	rmP2ROYtWEB504rzjOigxLXKdAX4q6oVjHtJKSAL500HIHevAV7NBM2ah5gTCS4TaFrkTn
	84aZ378xSguSnDr+noY+4xCzStWmI7T34+Imx5j7FCAKofQ22eI20aciTHdmQq41pqWShW
	IlpdXoVEv4I2PE7fwx4E1gawZ5AhWAZEhXIbpo7Ovms6s03uh250esW/G2IxyyDqGmJbWX
	4WEkhIr4bULYKH/lOG9A9qDrYfGjvA5qTiURRroV4CZkBH9CGz5kogUBLixh2g==
Received: from Gerda.fritz.box (p54a0c634.dip0.t-ipconnect.de [84.160.198.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id AE59F240513;
	Sun,  3 Aug 2025 16:09:13 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [bmp280 v1 3/6] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Sun,  3 Aug 2025 16:07:59 +0200
Message-ID: <20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 81eaa3
X-Rspamd-UID: 9e33bf

As was already commented in bm280.h:468, sampling_frequency can be
emulated on BMx280 devices indirectly via t_standby configuration.
Actually implement it to enable this useful feature.  This allows to
switch between MODE_FORCED and MODE_NORMAL operation and use the same
sysfs reads for both modes.

The actual sampling frequency depends on the oversampling_ratio
settings. In order to not complicate the code too much, the available
sampling frequency values are fixed and have been calculated for
oversampling_ratio=1 on all three channels assuming maximum
measurement duration per the data sheet, corresponding to the minimum
achievable sampling frequency for the highest measurement speed
configuration.

THe ODR tables for the BM[35]80 devices have been extended to allow
for MODE_FORCED operation also and the handling of the table values
adapted accordingly.

Report of the actual sampling frequency via sysfs is possible, but not
yet implemented.  In preparation for that implementation the
calculation of measurement time has been factored out from
bmp280_wait_conv into bmp280_calc_meas_time_us.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 219 +++++++++++++++++++++--------
 drivers/iio/pressure/bmp280.h      |  20 +++
 2 files changed, 179 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 858974a64306..4efdbfc3ac2c 100644
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
@@ -629,31 +660,35 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	prev_oversampling_press = temp_oversampling_press = data->oversampling_press;
 	prev_oversampling_temp  = temp_oversampling_temp  = data->oversampling_temp;
 
+	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		/* switch off unused channels */
 		switch_off = 0;
-		switch (chan->type) {
-		case IIO_HUMIDITYRELATIVE:
-			temp_oversampling_press = 0-1;
-			switch_off |= (prev_oversampling_press > switch_threshold);
-			/* can't be switched off as it is needed for compensation */
-			temp_oversampling_temp  = 1-1;
-			break;
-		case IIO_PRESSURE:
-			temp_oversampling_humid = 0-1;
-			switch_off |= (prev_oversampling_humid > switch_threshold);
-			/* can't be switched off as it is needed for compensation */
-			temp_oversampling_temp  = 1-1;
-			break;
-		case IIO_TEMP:
-			temp_oversampling_humid = 0-1;
-			temp_oversampling_press = 0-1;
-			switch_off = (prev_oversampling_humid > switch_threshold) |
-				     (prev_oversampling_press > switch_threshold);
-			break;
-		default:
-			return -EINVAL;
+		if (data->op_mode == BMP280_FORCED) {
+			/* switch off unused channels */
+			switch (chan->type) {
+			case IIO_HUMIDITYRELATIVE:
+				temp_oversampling_press = 0-1;
+				switch_off |= (prev_oversampling_press > switch_threshold);
+				/* can't be switched off as it is needed for compensation */
+				temp_oversampling_temp  = 1-1;
+				break;
+			case IIO_PRESSURE:
+				temp_oversampling_humid = 0-1;
+				switch_off |= (prev_oversampling_humid > switch_threshold);
+				/* can't be switched off as it is needed for compensation */
+				temp_oversampling_temp  = 1-1;
+				break;
+			case IIO_TEMP:
+				temp_oversampling_humid = 0-1;
+				temp_oversampling_press = 0-1;
+				switch_off = (prev_oversampling_humid > switch_threshold) |
+					     (prev_oversampling_press > switch_threshold);
+				break;
+			default:
+				return -EINVAL;
+			}
 		}
 		if (switch_off) {
 			data->oversampling_humid = temp_oversampling_humid;
@@ -664,9 +699,6 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 				goto restore;
 		}
 
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			goto restore;
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
 			goto restore;
@@ -709,29 +741,31 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
-		/* switch off unused channels */
 		switch_off = 0;
-		switch (chan->type) {
-		case IIO_HUMIDITYRELATIVE:
-			temp_oversampling_press = 0-1;
-			switch_off |= (prev_oversampling_press > switch_threshold);
-			/* can't be switched off as it is needed for compensation */
-			temp_oversampling_temp  = 1-1;
-			break;
-		case IIO_PRESSURE:
-			temp_oversampling_humid = 0-1;
-			switch_off |= (prev_oversampling_humid > switch_threshold);
-			/* can't be switched off as it is needed for compensation */
-			temp_oversampling_temp  = 1-1;
-			break;
-		case IIO_TEMP:
-			temp_oversampling_humid = 0-1;
-			temp_oversampling_press = 0-1;
-			switch_off = (prev_oversampling_humid > switch_threshold) |
-				     (prev_oversampling_press > switch_threshold);
-			break;
-		default:
-			return -EINVAL;
+		if (data->op_mode == BMP280_FORCED) {
+			/* MODE_FORCED, switch off unused channels */
+			switch (chan->type) {
+			case IIO_HUMIDITYRELATIVE:
+				temp_oversampling_press = 0-1;
+				switch_off |= (prev_oversampling_press > switch_threshold);
+				/* can't be switched off as it is needed for compensation */
+				temp_oversampling_temp  = 1-1;
+				break;
+			case IIO_PRESSURE:
+				temp_oversampling_humid = 0-1;
+				switch_off |= (prev_oversampling_humid > switch_threshold);
+				/* can't be switched off as it is needed for compensation */
+				temp_oversampling_temp  = 1-1;
+				break;
+			case IIO_TEMP:
+				temp_oversampling_humid = 0-1;
+				temp_oversampling_press = 0-1;
+				switch_off = (prev_oversampling_humid > switch_threshold) |
+					     (prev_oversampling_press > switch_threshold);
+				break;
+			default:
+				return -EINVAL;
+			}
 		}
 		if (switch_off) {
 			data->oversampling_humid = temp_oversampling_humid;
@@ -742,9 +776,6 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 				goto restore;
 		}
 
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			goto restore;
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
 			goto restore;
@@ -754,9 +785,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			data->oversampling_press = prev_oversampling_press;
 			data->oversampling_temp  = prev_oversampling_temp;
 			data->chip_info->chip_config(data);
-			if (ret) {
+			if (ret)
 				return ret;
-			}
 		}
 
 		switch (chan->type) {
@@ -951,6 +981,10 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
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
@@ -1087,6 +1121,30 @@ static const unsigned long bme280_avail_scan_masks[] = {
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
@@ -1124,6 +1182,8 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 {
 	int ret;
 
+	data->op_mode = BMP280_SLEEP;
+
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				BMP280_MODE_MASK, bmp280_operation_mode[mode]);
 	if (ret) {
@@ -1136,13 +1196,9 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 	return 0;
 }
 
-static int bmp280_wait_conv(struct bmp280_data *data)
+static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
 {
-	unsigned int reg, meas_time_us;
-	int wait_cycles = BMP280_MEAS_WAITCYCLES;
-	int ret;
-
-	meas_time_us = BMP280_MEAS_OFFSET;
+	unsigned int meas_time_us = BMP280_MEAS_OFFSET;
 
 	/* Check if we are using a BME280 device */
 	if (data->chip_info->oversampling_humid_avail)
@@ -1156,6 +1212,25 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	/* Temperature measurement time */
 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
 
+	/* nominal value */
+	return meas_time_us;
+}
+
+static int bmp280_wait_conv(struct bmp280_data *data)
+{
+	unsigned int reg, meas_time_us;
+	int wait_cycles = BMP280_MEAS_WAITCYCLES;
+	int ret;
+
+	ret = data->chip_info->set_mode(data, data->op_mode);
+	if (ret)
+		return ret;
+
+	if (data->op_mode == BMP280_NORMAL)
+		return 0;
+
+	meas_time_us = bmp280_calc_meas_time_us(data);
+
 	do {
 		/*
 		 * Waiting time according to the BM(P/E)2 Sensor API.
@@ -1177,6 +1252,8 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 		 --wait_cycles &&
 		 (meas_time_us >>= 3));
 
+	data->op_mode = BMP280_SLEEP;
+
 	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
 		return -EBUSY;
@@ -1189,6 +1266,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
 		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 tstby = FIELD_PREP(BMP280_TSTBY_MASK,
+			      (data->sampling_freq ? data->sampling_freq - 1 : 0));
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
@@ -1202,8 +1281,9 @@ static int bmp280_chip_config(struct bmp280_data *data)
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
@@ -1297,6 +1377,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.sampling_freq_avail = bmp280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
+	.sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1479,6 +1563,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.sampling_freq_avail = bme280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
+	.sampling_freq_default = BME280_ODR_0HZ, /* MODE_FORCED */
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1809,6 +1897,11 @@ static int bmp380_wait_conv(struct bmp280_data *data)
 	unsigned int reg;
 	int ret, meas_time_us;
 
+	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
+	ret = data->chip_info->set_mode(data, data->op_mode);
+	if (ret)
+		return ret;
+
 	/* Offset measurement time */
 	meas_time_us = BMP380_MEAS_OFFSET;
 
@@ -2543,6 +2636,12 @@ static int bmp580_wait_conv(struct bmp280_data *data)
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
index 88f5898282ec..e5cb2a52126d 100644
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
@@ -295,6 +305,16 @@
 
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
-- 
2.50.1


