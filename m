Return-Path: <linux-iio+bounces-24543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5BBBA757F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7134E13ED
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB52222A9;
	Sun, 28 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="gu0HK6QT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C822D7B5
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080940; cv=none; b=cWN+nKkOHCBkA+L+5UmZ2veg01jW7Bo+h1KVp7kMTGsPBl4kLDLlS6RTVb0+O1YHqSQ/VCgTLb+lRNb7y+K5wnRgu94jk8e3abE/Tsc0uRLu6QVZxj5DWsDVOzu2JfKgrnxgTTD8Z0LZI3SHS+hvAzuYhaoFtTpfzeiChr7n6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080940; c=relaxed/simple;
	bh=8gTrcOPASguYBp3HirbAwqUXdpo3xmoMG8dBERGGSpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqczQ2gaLXyF5IlizZvp0qD8lgUQNXHntoCDrsg7rszETFIVbeB47EI8gCWNPLm/QEbAV5fmtMZ3z+12FOem23C7+bYunUSKuag/5kCkxzA4PDVkeIKZ1eot8XSgjq1itObc+wE3eDUx7iveIDRwXppnMv5rocmd+TjaJRoV9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=gu0HK6QT; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 82BED240C13;
	Sun, 28 Sep 2025 19:27:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id E04C9240456;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dR3RgH39+OBYSC/nc/JbsYevwg7nlREEzdqKARHtSwc=;
	b=gu0HK6QTftsl9Kuln2fS4ZT/M6wp6J8VhjxX4pHTBCRi79uOGa6sRpbexmzwiov+DEjBVf
	Q80YbCjFt7pDo0l4uXF1M8eyjvdM3tTKl7FEt9+S4iVDpPcsPf9n9A6w7Qgo8i28fVVz+M
	FmyY6Ctt7drH9vv76F9QGKMPnMzX0ofZxHA+BfqWmKl+s8PDeDxIeTFc8ipcjFqoSUi7xQ
	O5MLDkwC1nifC2Ve7fzZ6dIo6ZDVIWlPAe6sty8AemwMBmxk9jC13x6kPG75gcoCraj72a
	6loDSgUSnKy+ZhoKck+IgOwtZIuWoxUffUeb7lKevjEexE+G8wLT4MxBisHMcQ==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 9A1AB240165;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 7/9] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Sun, 28 Sep 2025 19:26:35 +0200
Message-ID: <20250928172637.37138-9-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: f29bd0
X-Rspamd-UID: 759796

As was already commented in bm280.h:468, sampling_frequency can be
emulated on BMx280 devices indirectly via t_standby configuration.
Actually implement it to enable this useful feature.  This allows to
switch between MODE_FORCED and MODE_NORMAL operation and use the same
sysfs read implementations for both modes.  As MODE_FORCED is a driver
feature, the corresponding entry in the ODR table has to be added
after the actual register settings.  The resulting register setting is
either masked by the driver or clamped to a permissible value on
device, so does not disturb the device operation.  MODE_FORCE is
triggered by setting a sampling frequency of 0Hz, following the
precedent of stm32_timer_trigger.

The bmp[235]_conv() functions check if the sensor already operates in
NORMAL_MODE and skip waiting for measurement completion to save the
overhead of the superfluous mode seting.

The actual sampling frequency depends on the oversampling_ratio
settings. In order to keep the constant ODR tables, the available
sampling frequency values are fixed and have been calculated for
oversampling_ratio=1 on all available channels assuming maximum
measurement duration per the data sheet truncated to three significant
digits; corresponding to the minimum achievable sampling frequency for
the highest measurement speed configuration.

The ODR tables for the BM[35]80 devices have been extended to allow
for MODE_FORCED operation also and the handling of the table values in
chip_config is adapted accordingly.

Report of the actual sampling frequency via sysfs is possible, but not
yet implemented.  In preparation for that implementation the
calculation of measurement time has previously been factored out from
bmp280_conv into bmp280_calc_meas_time_us.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

---

BME280 redefines the last two ODR register settings vs. BMP280, which
are therefore out of order w.r.t. the other values.

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
| 2000.0 |   0.498 |     --- |
| 4000.0 |   0.250 |     --- |
|   10.0 |     --- |  51.813 |
|   20.0 |     --- |  34.130 |
|--------+---------+---------|

Proper consideration of the OSR when setting sampling_frequency could
be introduced in a later patch after discussion of how to handle the
combinatorial explosion of the table size or alternatively a
complicated on-the-fly computation that also depends on the device
type.  Note in particular that there are combinations of OSR and ODR
settings for the BMP580 at least that are illegal and hence replaced
by the device with a default setting, something this driver also
currently does not check for or handle.

This driver currently also lacks the the *_available attributes and
all associated implementation for all supported devices.  This should
be introduced in conjunction with the previously mentioned patch, so
that the available settings for the current configuration can be
obtained from user space.
---
 drivers/iio/pressure/bmp280-core.c | 297 ++++++++++++++++++++---------
 drivers/iio/pressure/bmp280.h      |  22 ++-
 2 files changed, 228 insertions(+), 91 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e72cfd4c10b9..9ade6d9e047b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -64,7 +64,53 @@
  */
 enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
 
+/*
+ * Output Data Rate of 0Hz is indicating operation in MODE_FORCED,
+ * otherwise ODR = 1/(t_meas + t_stby) (truncated to three digits)
+ *
+ * t_meas is the maximum data sheet value calculated for an
+ * oversampling ratio of 1 for all available channels of the
+ * respective device
+ *
+ * ODR tables start with ODR_FORCED == 0Hz, which is not a register
+ * setting.  Any non-zero value indicates a valid setting that will
+ * have to be decremented to get the respective register value.
+ */
+enum bmp280_odr {
+	/* BMP280_ODR_FORCED is a driver feature, not a register setting */
+	BMP280_ODR_FORCED,
+	BMP280_ODR_144HZ,	/* t_meas = 6.425ms, t_sb =  0.5ms */
+	BMP280_ODR_14_5HZ,	/* t_meas = 6.425ms, t_sb = 62.5ms */
+	BMP280_ODR_7_60HZ,	/* t_meas = 6.425ms, t_sb =  125ms */
+	BMP280_ODR_3_90HZ,	/* t_meas = 6.425ms, t_sb =  250ms */
+	BMP280_ODR_1_97HZ,	/* t_meas = 6.425ms, t_sb =  500ms */
+	BMP280_ODR_0_994HZ,	/* t_meas = 6.425ms, t_sb = 1000ms */
+	BMP280_ODR_0_498HZ,	/* t_meas = 6.425ms, t_sb = 2000ms */
+	BMP280_ODR_0_250HZ,	/* t_meas = 6.425ms, t_sb = 4000ms */
+};
+
+/*
+ * BME280 redefines the meaning of the last two register settings
+ * vs. BMP280, which are now out of order with the other values but
+ * need to be in that exact position as they are used as the register
+ * setting
+ */
+enum bme280_odr {
+	/* BME280_ODR_FORCED is a driver feature, not a register setting */
+	BME280_ODR_FORCED,
+	BME280_ODR_102HZ,	/* t_meas = 9.300ms, t_sb =  0.5ms */
+	BME280_ODR_13_9HZ,	/* t_meas = 9.300ms, t_sb = 62.5ms */
+	BME280_ODR_7_44HZ,	/* t_meas = 9.300ms, t_sb =  125ms */
+	BME280_ODR_3_85HZ,	/* t_meas = 9.300ms, t_sb =  250ms */
+	BME280_ODR_1_96HZ,	/* t_meas = 9.300ms, t_sb =  500ms */
+	BME280_ODR_0_991HZ,	/* t_meas = 9.300ms, t_sb = 1000ms */
+	BME280_ODR_51_8HZ,	/* t_meas = 9.300ms, t_sb =   10ms */
+	BME280_ODR_34_1HZ,	/* t_meas = 9.300ms, t_sb =   20ms */
+};
+
 enum bmp380_odr {
+	/* BMP380_ODR_FORCED is a driver feature, not a register setting */
+	BMP380_ODR_FORCED,
 	BMP380_ODR_200HZ,
 	BMP380_ODR_100HZ,
 	BMP380_ODR_50HZ,
@@ -86,6 +132,8 @@ enum bmp380_odr {
 };
 
 enum bmp580_odr {
+	/* BMP380_ODR_FORCED is a driver feature, not a register setting */
+	BMP580_ODR_FORCED,
 	BMP580_ODR_240HZ,
 	BMP580_ODR_218HZ,
 	BMP580_ODR_199HZ,
@@ -159,7 +207,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -175,7 +224,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -195,7 +245,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -211,7 +262,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -227,7 +279,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 2,
 		.scan_type = {
 			.sign = 'u',
@@ -816,7 +869,7 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
 	return -EINVAL;
 }
 
-static int bmp280_write_sampling_frequency(struct bmp280_data *data,
+static int bmp280_write_sampling_freq(struct bmp280_data *data,
 					   int val, int val2)
 {
 	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
@@ -893,7 +946,7 @@ static int bmp280_write_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return bmp280_write_sampling_frequency(data, val, val2);
+		return bmp280_write_sampling_freq(data, val, val2);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return bmp280_write_iir_filter_coeffs(data, val);
 	default:
@@ -971,6 +1024,34 @@ static const unsigned long bme280_avail_scan_masks[] = {
 	0
 };
 
+static const int bmp280_odr_table[][2] = {
+	/* BMP280_ODR_FORCED is a driver feature, not a register setting */
+	[BMP280_ODR_FORCED]	= {   0,      0 },
+	[BMP280_ODR_155HZ]	= { 155,      0 },
+	[BMP280_ODR_144HZ]	= { 144,      0 },
+	[BMP280_ODR_14_5HZ]	= {  14, 500000 },
+	[BMP280_ODR_7_60HZ]	= {   7, 600000 },
+	[BMP280_ODR_3_90HZ]	= {   3, 900000 },
+	[BMP280_ODR_1_97HZ]	= {   1, 970000 },
+	[BMP280_ODR_0_99HZ]	= {   0, 990000 },
+	[BMP280_ODR_0_498HZ]	= {   0, 498000 },
+	[BMP280_ODR_0_250HZ]	= {   0, 250000 },
+};
+
+static const int bme280_odr_table[][2] = {
+	/* BMP380_ODR_FORCED is a driver feature, not a register setting */
+	[BME280_ODR_FORCED]	= {   0,      0 },
+	[BME280_ODR_107HZ]	= { 107,      0 },
+	[BME280_ODR_102HZ]	= { 102,      0 },
+	[BME280_ODR_13_9HZ]	= {  13, 900000 },
+	[BME280_ODR_7_44HZ]	= {   7, 440000 },
+	[BME280_ODR_3_85HZ]	= {   3, 850000 },
+	[BME280_ODR_1_96HZ]	= {   1, 960000 },
+	[BME280_ODR_0_991HZ]	= {   0, 991000 },
+	[BME280_ODR_51_8HZ]	= {  51, 800000 },
+	[BME280_ODR_34_1HZ]	= {  34, 100000 },
+};
+
 static int bmp280_preinit(struct bmp280_data *data)
 {
 	struct device *dev = data->dev;
@@ -1008,6 +1089,9 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 {
 	int ret;
 
+	/* Ensure a mode transition on next measurement if we take an error exit */
+	data->op_mode = BMP280_SLEEP;
+
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				BMP280_MODE_MASK, bmp280_operation_mode[mode]);
 	if (ret) {
@@ -1051,12 +1135,15 @@ static int bmp280_conv(struct bmp280_data *data)
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
 
@@ -1098,24 +1185,28 @@ static int bmp280_conv(struct bmp280_data *data)
 
 static int bmp280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
-		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
-	u8 filter = FIELD_PREP(BMP280_FILTER_MASK, data->iir_filter_coeff;
+	u8 osr_temp  = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1);
+	u8 osr_press = FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 filter    = FIELD_PREP(BMP280_FILTER_MASK, data->iir_filter_coeff);
+	u8 tstby     = FIELD_PREP(BMP280_TSTBY_MASK, (data->sampling_freq ?: 1) - 1);
+	u8 mode      = FIELD_PREP(BMP280_MODE_MASK, data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP);
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | BMP280_MODE_SLEEP);
+				osr_temp | osr_press | mode);
+	if (ret)
+		return ret;
 	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
 	}
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
-				 BMP280_FILTER_MASK,
-				 filter);
+				 BMP280_FILTER_MASK | BMP280_TSTBY_MASK,
+				 filter             | tstby);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
@@ -1214,6 +1305,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_avail = bmp280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
+	.sampling_freq_default = BMP280_ODR_FORCED,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1233,7 +1328,7 @@ EXPORT_SYMBOL_NS(bmp280_chip_info, "IIO_BMP280");
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = FIELD_PREP(BME280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
+	u8 osr_humid = FIELD_PREP(BME280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
 	int ret;
 
 	/*
@@ -1241,7 +1336,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 	 * temperature/pressure is set to become effective.
 	 */
 	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
-				 BME280_OSRS_HUMIDITY_MASK, osrs);
+				 BME280_OSRS_HUMIDITY_MASK, osr_humid);
 	if (ret) {
 		dev_err(data->dev, "failed to set humidity oversampling");
 		return ret;
@@ -1400,6 +1495,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_avail = bme280_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
+	.sampling_freq_default = BME280_ODR_FORCED,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1675,24 +1774,26 @@ static int bmp380_read_calib(struct bmp280_data *data)
 }
 
 static const int bmp380_odr_table[][2] = {
-	[BMP380_ODR_200HZ]	= {200, 0},
-	[BMP380_ODR_100HZ]	= {100, 0},
-	[BMP380_ODR_50HZ]	= {50, 0},
-	[BMP380_ODR_25HZ]	= {25, 0},
-	[BMP380_ODR_12_5HZ]	= {12, 500000},
-	[BMP380_ODR_6_25HZ]	= {6, 250000},
-	[BMP380_ODR_3_125HZ]	= {3, 125000},
-	[BMP380_ODR_1_5625HZ]	= {1, 562500},
-	[BMP380_ODR_0_78HZ]	= {0, 781250},
-	[BMP380_ODR_0_39HZ]	= {0, 390625},
-	[BMP380_ODR_0_2HZ]	= {0, 195313},
-	[BMP380_ODR_0_1HZ]	= {0, 97656},
-	[BMP380_ODR_0_05HZ]	= {0, 48828},
-	[BMP380_ODR_0_02HZ]	= {0, 24414},
-	[BMP380_ODR_0_01HZ]	= {0, 12207},
-	[BMP380_ODR_0_006HZ]	= {0, 6104},
-	[BMP380_ODR_0_003HZ]	= {0, 3052},
-	[BMP380_ODR_0_0015HZ]	= {0, 1526},
+	/* BMP380_ODR_FORCED is a driver feature, not a register setting */
+	[BMP380_ODR_FORCED]	= {   0,      0 },
+	[BMP380_ODR_200HZ]	= { 200,      0 },
+	[BMP380_ODR_100HZ]	= { 100,      0 },
+	[BMP380_ODR_50HZ]	= {  50,      0 },
+	[BMP380_ODR_25HZ]	= {  25,      0 },
+	[BMP380_ODR_12_5HZ]	= {  12, 500000 },
+	[BMP380_ODR_6_25HZ]	= {   6, 250000 },
+	[BMP380_ODR_3_125HZ]	= {   3, 125000 },
+	[BMP380_ODR_1_5625HZ]	= {   1, 562500 },
+	[BMP380_ODR_0_78HZ]	= {   0, 781250 },
+	[BMP380_ODR_0_39HZ]	= {   0, 390625 },
+	[BMP380_ODR_0_2HZ]	= {   0, 195313 },
+	[BMP380_ODR_0_1HZ]	= {   0,  97656 },
+	[BMP380_ODR_0_05HZ]	= {   0,  48828 },
+	[BMP380_ODR_0_02HZ]	= {   0,  24414 },
+	[BMP380_ODR_0_01HZ]	= {   0,  12207 },
+	[BMP380_ODR_0_006HZ]	= {   0,   6104 },
+	[BMP380_ODR_0_003HZ]	= {   0,   3052 },
+	[BMP380_ODR_0_0015HZ]	= {   0,   1526 },
 };
 
 static int bmp380_preinit(struct bmp280_data *data)
@@ -1730,12 +1831,19 @@ static int bmp380_conv(struct bmp280_data *data)
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
+	ret = data->chip_info->set_mode(data, data->op_mode);
 	if (ret)
 		return ret;
 
@@ -1807,7 +1915,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 	/* Configure output data rate */
 	ret = regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
-				       BMP380_ODRS_MASK, data->sampling_freq,
+				       BMP380_ODRS_MASK, (data->sampling_freq ?: 1) - 1,
 				       &aux);
 	if (ret) {
 		dev_err(data->dev, "failed to write ODR selection register\n");
@@ -2061,7 +2169,7 @@ static int bmp580_soft_reset(struct bmp280_data *data)
 	fsleep(2000);
 
 	/* Dummy read of chip_id */
-	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
+	ret = regmap_read(data->regmap, BMP580_REG_ID, &reg);
 	if (ret) {
 		dev_err(data->dev, "failed to reestablish comms after reset\n");
 		return ret;
@@ -2205,38 +2313,40 @@ static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 }
 
 static const int bmp580_odr_table[][2] = {
-	[BMP580_ODR_240HZ] =	{240, 0},
-	[BMP580_ODR_218HZ] =	{218, 0},
-	[BMP580_ODR_199HZ] =	{199, 0},
-	[BMP580_ODR_179HZ] =	{179, 0},
-	[BMP580_ODR_160HZ] =	{160, 0},
-	[BMP580_ODR_149HZ] =	{149, 0},
-	[BMP580_ODR_140HZ] =	{140, 0},
-	[BMP580_ODR_129HZ] =	{129, 0},
-	[BMP580_ODR_120HZ] =	{120, 0},
-	[BMP580_ODR_110HZ] =	{110, 0},
-	[BMP580_ODR_100HZ] =	{100, 0},
-	[BMP580_ODR_89HZ] =	{89, 0},
-	[BMP580_ODR_80HZ] =	{80, 0},
-	[BMP580_ODR_70HZ] =	{70, 0},
-	[BMP580_ODR_60HZ] =	{60, 0},
-	[BMP580_ODR_50HZ] =	{50, 0},
-	[BMP580_ODR_45HZ] =	{45, 0},
-	[BMP580_ODR_40HZ] =	{40, 0},
-	[BMP580_ODR_35HZ] =	{35, 0},
-	[BMP580_ODR_30HZ] =	{30, 0},
-	[BMP580_ODR_25HZ] =	{25, 0},
-	[BMP580_ODR_20HZ] =	{20, 0},
-	[BMP580_ODR_15HZ] =	{15, 0},
-	[BMP580_ODR_10HZ] =	{10, 0},
-	[BMP580_ODR_5HZ] =	{5, 0},
-	[BMP580_ODR_4HZ] =	{4, 0},
-	[BMP580_ODR_3HZ] =	{3, 0},
-	[BMP580_ODR_2HZ] =	{2, 0},
-	[BMP580_ODR_1HZ] =	{1, 0},
-	[BMP580_ODR_0_5HZ] =	{0, 500000},
-	[BMP580_ODR_0_25HZ] =	{0, 250000},
-	[BMP580_ODR_0_125HZ] =	{0, 125000},
+	/* BMP580_ODR_FORCED is a driver feature, not a register setting */
+	[BMP580_ODR_FORCED] =	{   0,      0 },
+	[BMP580_ODR_240HZ] =	{ 240,	    0 },
+	[BMP580_ODR_218HZ] =	{ 218,	    0 },
+	[BMP580_ODR_199HZ] =	{ 199,	    0 },
+	[BMP580_ODR_179HZ] =	{ 179,	    0 },
+	[BMP580_ODR_160HZ] =	{ 160,	    0 },
+	[BMP580_ODR_149HZ] =	{ 149,	    0 },
+	[BMP580_ODR_140HZ] =	{ 140,	    0 },
+	[BMP580_ODR_129HZ] =	{ 129,	    0 },
+	[BMP580_ODR_120HZ] =	{ 120,	    0 },
+	[BMP580_ODR_110HZ] =	{ 110,	    0 },
+	[BMP580_ODR_100HZ] =	{ 100,	    0 },
+	[BMP580_ODR_89HZ] =	{  89,	    0 },
+	[BMP580_ODR_80HZ] =	{  80,	    0 },
+	[BMP580_ODR_70HZ] =	{  70,	    0 },
+	[BMP580_ODR_60HZ] =	{  60,	    0 },
+	[BMP580_ODR_50HZ] =	{  50,	    0 },
+	[BMP580_ODR_45HZ] =	{  45,	    0 },
+	[BMP580_ODR_40HZ] =	{  40,	    0 },
+	[BMP580_ODR_35HZ] =	{  35,	    0 },
+	[BMP580_ODR_30HZ] =	{  30,	    0 },
+	[BMP580_ODR_25HZ] =	{  25,	    0 },
+	[BMP580_ODR_20HZ] =	{  20,	    0 },
+	[BMP580_ODR_15HZ] =	{  15,	    0 },
+	[BMP580_ODR_10HZ] =	{  10,	    0 },
+	[BMP580_ODR_5HZ] =	{   5,	    0 },
+	[BMP580_ODR_4HZ] =	{   4,	    0 },
+	[BMP580_ODR_3HZ] =	{   3,	    0 },
+	[BMP580_ODR_2HZ] =	{   2,	    0 },
+	[BMP580_ODR_1HZ] =	{   1,	    0 },
+	[BMP580_ODR_0_5HZ] =	{   0, 500000 },
+	[BMP580_ODR_0_25HZ] =	{   0, 250000 },
+	[BMP580_ODR_0_125HZ] =	{   0, 125000 },
 };
 
 static const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
@@ -2403,7 +2513,7 @@ static int bmp580_preinit(struct bmp280_data *data)
 		return ret;
 
 	/* Post powerup sequence */
-	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
+	ret = regmap_read(data->regmap, BMP580_REG_ID, &reg);
 	if (ret) {
 		dev_err(data->dev, "failed to establish comms with the chip\n");
 		return ret;
@@ -2478,13 +2588,17 @@ static int bmp580_conv(struct bmp280_data *data)
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
 
@@ -2552,7 +2666,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 	/* Configure output data rate */
 	ret = regmap_update_bits_check(data->regmap, BMP580_REG_ODR_CONFIG, BMP580_ODR_MASK,
-				       FIELD_PREP(BMP580_ODR_MASK, data->sampling_freq),
+				       FIELD_PREP(BMP580_ODR_MASK, data->sampling_freq ?: 1) - 1,
 				       &aux);
 	if (ret) {
 		dev_err(data->dev, "failed to write ODR configuration register\n");
@@ -2707,7 +2821,7 @@ static const int bmp580_temp_coeffs[] = { 125, 13 };
 static const int bmp580_press_coeffs[] = { 1, 64000};
 
 const struct bmp280_chip_info bmp580_chip_info = {
-	.id_reg = BMP580_REG_CHIP_ID,
+	.id_reg = BMP580_REG_ID,
 	.chip_id = bmp580_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
 	.regmap_config = &bmp580_regmap_config,
@@ -3367,10 +3481,13 @@ static int bmp280_runtime_suspend(struct device *dev)
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
index df90ed720bc6..8e05cdf869e7 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -13,7 +13,7 @@
 #define BMP580_REG_OSR_CONFIG		0x36
 #define BMP580_REG_IF_CONFIG		0x13
 #define BMP580_REG_REV_ID		0x02
-#define BMP580_REG_CHIP_ID		0x01
+#define BMP580_REG_ID			0x01
 /* OOR allows to configure a pressure alarm */
 #define BMP580_REG_OOR_CONFIG		0x35
 #define BMP580_REG_OOR_RANGE		0x34
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
+#define BME280_TSTBY_10			6
+#define BME280_TSTBY_20			7
+
 #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
 #define BME280_OSRS_HUMIDITY_SKIP	0
 #define BME280_OSRS_HUMIDITY_1X		1
-- 
2.51.0


