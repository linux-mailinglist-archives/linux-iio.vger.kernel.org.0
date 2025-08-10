Return-Path: <linux-iio+bounces-22528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA8B1FBD1
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3163B35E2
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86721FCCF8;
	Sun, 10 Aug 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="KLjjA8YB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCD1FDA82
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852368; cv=none; b=fYm0SVJaqXNimXvqcOdogNEL2IbDiut9Wl9/R4UUnZAulLsBrb9WwFH9d4Cjhwcm99u7+xphqEIMO9aCIKptYmnwN2g5GVczGJ211MrKKXUaHbJfZuW7hpye6GzcxKBxt3w2+nJ0x6+C6t/UgMViifeuU4atYuermhK43g+MLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852368; c=relaxed/simple;
	bh=9q0+MkIbWhveRcHErFj8111dggrnqK3NI1zcyf1Hnx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbLGucFqvBfdwTawtPo2ONw8qVRURJqHYYgfJTihXW/6ZoyIQ0cPdz4D3Z+MdqKGWlr/phmXZCQX2AveeLhIQx80usaMjBvf3Ij95zOrkFK1KPJsmj4kEA+EaWkLRsQNpZk9HHnfqvFaVCIVLk5iJnnutr6ySUc7iDFE9bOQhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=KLjjA8YB; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id 38CE02405BD;
	Sun, 10 Aug 2025 20:59:25 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 9B2C4240166;
	Sun, 10 Aug 2025 20:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omd3eMC/BjIHTSy4POH+blt3EWtwRa0U3K9nenHol0w=;
	b=KLjjA8YBzC8+fi3IGqNyilHY1KigDVk9ecuWmhvn1/Po2ZxxBwNOV5f5ONqKD/2ITm6UQy
	csyLtFYwyerISFUhQlNMo7Pu2FpujTbJjOirR1riq56NIwVfY4992WUdQDY7k0by+YkqFC
	z2xJs8m+SA6UbHvIdaJQKLf7ZpjZTZ2JNTfSOtZq2tyTCPnFO2Uh2jQcge3Z0YSg94YboF
	uP6LA7SV0x4XazKsi9JxgEs772niWszO41er5CBTHtrfv6dz2x+vtle4l7pXhWmx0+244W
	luGWWxpsWw1LswN86E0EP4GPs0CkKmFfcS/v2x9/aoau6HMHiIe9vGQeu1sXEA==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 59E5A24026C;
	Sun, 10 Aug 2025 20:59:23 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 7/9] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Sun, 10 Aug 2025 20:58:44 +0200
Message-ID: <20250810185846.114355-8-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: b5c129
X-Rspamd-UID: 47d5ef

As was already commented in bm280.h:468, sampling_frequency can be
emulated on BMx280 devices indirectly via t_standby configuration.
Actually implement it to enable this useful feature.  This allows to
switch between MODE_FORCED and MODE_NORMAL operation and use the same
sysfs read implementations for both modes.

the bmp[235]_wait_conv() functions check if the sensor already
operates in NORMAL_MODE and skips the wait for measurement complettion
unless a mode transition is required to save the overhead of
re-setting the same mode superfluously.

The actual sampling frequency depends on the oversampling_ratio
settings. In order to not complicate the code too much, the available
sampling frequency values are fixed and have been calculated for
oversampling_ratio=1 on all available channels assuming maximum
measurement duration per the data sheet, corresponding to the minimum
achievable sampling frequency for the highest measurement speed
configuration.

THe ODR tables for the BM[35]80 devices have been extended to allow
for MODE_FORCED operation also and the handling of the table values is
adapted accordingly.

Report of the actual sampling frequency via sysfs is possible, but not
yet implemented.  In preparation for that implementation the
calculation of measurement time has previously been factored out from
bmp280_wait_conv into bmp280_calc_meas_time_us.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

---

Calculated ODR values:
|--------+---------+---------|
|   t_sb | min ODR | min ODR |
|   [ms] |  BMP280 |  BME280 |
|--------+---------+---------|
|      0 | 155.642 | 107.527 |
|    0.5 | 144.404 | 102.041 |
|   62.5 |  14.509 |  13.928 |
|  125.0 |   7.609 |   7.446 |
|  250.0 |   3.900 |   3.857 |
|  500.0 |   1.975 |   1.963 |
| 1000.0 |   0.994 |   0.991 |
| 2000.0 |   0.498 |   0.498 |
| 4000.0 |   0.250 |   0.249 |
|   10.0 |  60.883 |  51.813 |
|   20.0 |  37.843 |  34.130 |
|--------+---------+---------|
---
 drivers/iio/pressure/bmp280-core.c | 165 +++++++++++++++++++++++------
 drivers/iio/pressure/bmp280.h      |  20 ++++
 2 files changed, 155 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 0ee40b6abb44..a66b90b3ddb8 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -64,7 +64,47 @@
  */
 enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
 
+/*
+ * Output Data Rate of 0Hz is indicating operation in MODE_FORCED,
+ * otherwise ODR = 1/(t_meas + t_stby) (rounded down to three digits)
+ *
+ * t_meas is the maximum data sheet value calculated for an
+ * oversampling ratio of 1 for all available channels of the
+ * respective device
+ */
+enum bmp280_odr {
+	BMP280_ODR_0HZ,
+	BMP280_ODR_155HZ,	/* t_meas_max = 6.425ms, t_sb =  0.0ms */
+	BMP280_ODR_144HZ,	/* t_meas_max = 6.425ms, t_sb =  0.5ms */
+	BMP280_ODR_14_5HZ,	/* t_meas_max = 6.425ms, t_sb = 62.5ms */
+	BMP280_ODR_7_60HZ,	/* t_meas_max = 6.425ms, t_sb =  125ms */
+	BMP280_ODR_3_90HZ,	/* t_meas_max = 6.425ms, t_sb =  250ms */
+	BMP280_ODR_1_97HZ,	/* t_meas_max = 6.425ms, t_sb =  500ms */
+	BMP280_ODR_0_99HZ,	/* t_meas_max = 6.425ms, t_sb = 1000ms */
+	BMP280_ODR_0_49HZ,	/* t_meas_max = 6.425ms, t_sb = 2000ms */
+	BMP280_ODR_0_24HZ,	/* t_meas_max = 6.425ms, t_sb = 4000ms */
+};
+
+/*
+ * BME280 redefines the meaning of the last two register settings
+ * vs. BMP280, which are now out of order with the other values but
+ * need to be in that exact position
+ */
+enum bme280_odr {
+	BME280_ODR_0HZ,
+	BME280_ODR_107HZ,	/* t_meas_max = 9.300ms, t_sb =  0.5ms */
+	BME280_ODR_102HZ,	/* t_meas_max = 9.300ms, t_sb =  0.5ms */
+	BME280_ODR_13_9HZ,	/* t_meas_max = 9.300ms, t_sb = 62.5ms */
+	BME280_ODR_7_44HZ,	/* t_meas_max = 9.300ms, t_sb =  125ms */
+	BME280_ODR_3_85HZ,	/* t_meas_max = 9.300ms, t_sb =  250ms */
+	BME280_ODR_1_96HZ,	/* t_meas_max = 9.300ms, t_sb =  500ms */
+	BME280_ODR_0_99HZ,	/* t_meas_max = 9.300ms, t_sb = 1000ms */
+	BME280_ODR_51_8HZ,	/* t_meas_max = 9.300ms, t_sb =   10ms */
+	BME280_ODR_34_1HZ,	/* t_meas_max = 9.300ms, t_sb =   20ms */
+};
+
 enum bmp380_odr {
+	BMP380_ODR_0HZ,
 	BMP380_ODR_200HZ,
 	BMP380_ODR_100HZ,
 	BMP380_ODR_50HZ,
@@ -86,6 +126,7 @@ enum bmp380_odr {
 };
 
 enum bmp580_odr {
+	BMP580_ODR_0HZ,
 	BMP580_ODR_240HZ,
 	BMP580_ODR_218HZ,
 	BMP580_ODR_199HZ,
@@ -159,7 +200,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -175,7 +217,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -195,7 +238,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -211,7 +255,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -227,7 +272,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 2,
 		.scan_type = {
 			.sign = 'u',
@@ -816,7 +862,7 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
 	return -EINVAL;
 }
 
-static int bmp280_write_sampling_frequency(struct bmp280_data *data,
+static int bmp280_write_sampling_freq(struct bmp280_data *data,
 					   int val, int val2)
 {
 	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
@@ -893,7 +939,7 @@ static int bmp280_write_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return bmp280_write_sampling_frequency(data, val, val2);
+		return bmp280_write_sampling_freq(data, val, val2);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return bmp280_write_iir_filter_coeffs(data, val);
 	default:
@@ -971,6 +1017,32 @@ static const unsigned long bme280_avail_scan_masks[] = {
 	0
 };
 
+static const int bmp280_odr_table[][2] = {
+	[BMP280_ODR_0HZ]	= {0,       0},
+	[BMP280_ODR_155HZ]	= {155,     0},
+	[BMP280_ODR_144HZ]	= {144,     0},
+	[BMP280_ODR_14_5HZ]	= {14, 500000},
+	[BMP280_ODR_7_60HZ]	= {7,  600000},
+	[BMP280_ODR_3_90HZ]	= {3,  900000},
+	[BMP280_ODR_1_97HZ]	= {1,  970000},
+	[BMP280_ODR_0_99HZ]	= {0,  990000},
+	[BMP280_ODR_0_49HZ]	= {0,  490000},
+	[BMP280_ODR_0_24HZ]	= {0,  240000},
+};
+
+static const int bme280_odr_table[][2] = {
+	[BME280_ODR_0HZ]	= {0,       0},
+	[BME280_ODR_107HZ]	= {107,     0},
+	[BME280_ODR_102HZ]	= {102,     0},
+	[BME280_ODR_13_9HZ]	= {13, 900000},
+	[BME280_ODR_7_44HZ]	= {7,  440000},
+	[BME280_ODR_3_85HZ]	= {3,  850000},
+	[BME280_ODR_1_96HZ]	= {1,  960000},
+	[BME280_ODR_0_99HZ]	= {0,  990000},
+	[BME280_ODR_51_8HZ]	= {51, 800000},
+	[BME280_ODR_34_1HZ]	= {34, 100000},
+};
+
 static int bmp280_preinit(struct bmp280_data *data)
 {
 	struct device *dev = data->dev;
@@ -1008,6 +1080,9 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 {
 	int ret;
 
+	/* Ensure a mode transition on next measurement if we take an error exit */
+	data->op_mode = BMP280_SLEEP;
+
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				BMP280_MODE_MASK, bmp280_operation_mode[mode]);
 	if (ret) {
@@ -1051,12 +1126,15 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	unsigned int reg, meas_time_us, initial_wait;
 	int ret;
 
-	/*
-	 * Each new measurement requires mode setting, as at the end
-	 * of the measurement cycle the sensor enters MODE_SLEEP
-	 * again.
-	 */
-	ret = data->chip_info->set_mode(data, BMP280_FORCED);
+	/* No mode transition and already in NORMAL_MODE, skip wait */
+	if (data->sampling_freq && data->op_mode == BMP280_NORMAL)
+		return 0;
+
+	/* switch mode based on sampling_freq */
+	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
+
+	/* Mode transition or measurement in MODE_FORCED */
+	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED);
 	if (ret)
 		return ret;
 
@@ -1078,6 +1156,7 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 				       !(reg & BMP280_REG_STATUS_MEAS_BIT),
 				       MIN((2 * USEC_PER_MSEC), (meas_time_us >> 1)),
 				       (2 * USEC_PER_MSEC + meas_time_us));
+
 	if (ret) {
 		dev_err(data->dev, "failed to read status register.\n");
 		return ret;
@@ -1095,21 +1174,24 @@ static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
 		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 tstby = FIELD_PREP(BMP280_TSTBY_MASK, (data->sampling_freq ?: 1) - 1);
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | BMP280_MODE_SLEEP);
+				osrs | (data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP));
+	if (ret)
+		return ret;
 	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
 	}
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
-				 BMP280_FILTER_MASK,
-				 data->iir_filter_coeff);
+				 BMP280_FILTER_MASK | BMP280_TSTBY_MASK,
+				 tstby              | BMP280_FILTER_4X);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
@@ -1208,6 +1290,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_avail = bmp280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
+	.sampling_freq_default = BMP280_ODR_0HZ,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1397,6 +1483,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_avail = bme280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
+	.sampling_freq_default = BME280_ODR_0HZ,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1727,12 +1817,20 @@ static int bmp380_wait_conv(struct bmp280_data *data)
 	unsigned int reg, meas_time_us, initial_wait;
 	int ret;
 
-	/*
-	 * Each new measurement requires mode setting, as at the end
-	 * of the measurement cycle the sensor enters MODE_SLEEP
-	 * again.
-	 */
-	ret = data->chip_info->set_mode(data, BMP280_FORCED);
+	/* nothing to wait for, read already available data */
+	if (data->op_mode == BMP280_NORMAL)
+		return 0;
+
+	/* switch mode based on sampling_freq */
+	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
+
+	/* Mode transition or measurement in MODE_FORCED */
+	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED);
+	if (ret)
+		return ret;
+
+	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
+	ret = data->chip_info->set_mode(data, data->op_mode);
 	if (ret)
 		return ret;
 
@@ -2475,13 +2573,17 @@ static int bmp580_wait_conv(struct bmp280_data *data)
 		21840,
 	};
 	unsigned int meas_time_us;
+	int ret;
 
-	/*
-	 * Each new measurement requires mode setting, as at the end
-	 * of the measurement cycle the sensor enters MODE_SLEEP
-	 * again.
-	 */
-	ret = data->chip_info->set_mode(data, BMP280_FORCED);
+	/* nothing to wait for, read already available data */
+	if (data->op_mode == BMP280_NORMAL)
+		return 0;
+
+	/* switch mode based on sammpling_freq */
+	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
+
+	/* Mode transition or measurement in MODE_FORCED */
+	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED);
 	if (ret)
 		return ret;
 
@@ -3363,10 +3465,13 @@ static int bmp280_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
-
-	data->chip_info->set_mode(data, BMP280_SLEEP);
+	int ret;
 
 	fsleep(data->start_up_time_us);
+	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP);
+	if (ret)
+		return ret;
+
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 25bb9c743a05..c15d0c74d4b6 100644
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
-- 
2.50.1


