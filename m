Return-Path: <linux-iio+bounces-24537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F119EBA756F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386051895209
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400BB2367B8;
	Sun, 28 Sep 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="tbGjeHtZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581D2236E0
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080939; cv=none; b=NpVU92+2995BHNqM1cEB+98kVu4gzM4oFtlCKzLqrPvNKM4eKUTMrDDK5DJxDnBNoMDHViFfuitVoKWn5gKLMmS3SLyhVqdULmEczI5JEyTg0Eja3Ulaxs7k2WEGUPoBrDHw2FzQcwtndLda9+cQRX7Lh+hzU5uTcva0lMDXA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080939; c=relaxed/simple;
	bh=gWf5qAilobcgmPTM2Z+P+zeX37K+HBy4FL/xYa6CYEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyG0iY1kkn0EYDREnm4fa1QvUv8EKTDXfaXLlOGp6nbNf6CcHpyXL1nZBDpRQAVjnV88RZWh1FGtZYeo2+5JzlFBwQLwk2FR8Qhtm5pd9CCNMRc6kPggbYkqfeag77YfZtPQSArm3eRa7OzCQ0BGqqAXmkBXFaNqFJHLq9MvB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=tbGjeHtZ; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id 8337E240CDC;
	Sun, 28 Sep 2025 19:27:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id E1F9F240834;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq8XgSsz4CZw0UYpuowTcHs/8vp4eoIvJsB8MnF7E5g=;
	b=tbGjeHtZMIn6Wr4/+xtMmJjN1y+n/lHTz91i6h8uO1zse1EZtGaftXdABF7fxmVf467XuA
	mqFZnA+pUyGg4Ne6mBeHQ+tQxMP3dA8zminY+Yr/MxQlyJMYo+ZwboSxnTsip+vH/zRaY0
	X7rQj9fo2vCh2RV63kdzApAj1wMpVOvTKIobbIvlr+0cRhbbFLdG7g0TpMBO1cQ17mDUYA
	1FYzI2fCRbgr9Rz03Kuj80w2KW+ajGOp5ATIbqnE8AU4Vmj7NECZxxQT0GNNYrXy3LQj5D
	FxsZGcpqBgX3wXOJ6r7DjCfzsOQB1Ul2shuR5xDX8nZUGn0w4dxdncfCZPTpdQ==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 5213924081C;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 6/9] iio: pressure: bmp280: enable filter settings for BMx280
Date: Sun, 28 Sep 2025 19:26:34 +0200
Message-ID: <20250928172637.37138-8-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: c99caf
X-Rspamd-UID: 134216

Follow the existing implementation for the BMx380 and BMx580 devices
even though it doesn't conform to the API: The BMx280 devices were
using a hardcoded value of 4, corresponding to the lowest corner
frequency.  Enable filter_low_pass_3db_frequency settings to control
the filter settings of the device.  The actual 3dB corner freqquency
has an inverse relation to the value, which represents approximately
the tau of the filter (for which the iio framework does not seem to
have a suitable parameter).  Remove a superfluous offset of -1 from
the internal handling of the available values and use the table
entries directly.  Keep the default value at the previous hardcoded
value to ensure identical device behaviour after module load.

A change of the implementation to actually follow the API (breaking
existing userspace) requires further discussion and more extensive
changes elsewhere in the code and are left for later.

---

Filter coefficient settings in hardware: off, 2, 4, 8, 16, mapped to
register values 0, 1, 2, 3, 4 (that's i and 2**i below), per the
datasheet, the actual filter is:

  y(t) = ( (y(t-1) << i) - y(t-1) + x(t) ) >> i
       = 2**-i * x(t) (2**i-1)*2**-i * y(t-1) )

That's the simplest filter that can be implemented in hardware,
really; the canonical recursive single-pole LP with no gain has two
coefficients, which should be 1-d and d (d because it's the sample
decay).

   2**-i + (2**i-1)*2**-i = 2**-1 * ( 1 + 2**i - 1 ) = 1

so check that.  The time constant (rise time to 63%) is then

  tau = -1/ln(d)

Oddly enough the data sheet gives time to >75%, but that is just a
scaling factor of ln(0.25) on the tau.  The nomalized corner frequency then is:

  fc/fs = -ln(d)/(2pi)

So lets check that:

|---+------+--------+--------+--------+--------+-----------+----------|
| i | 2**i |    1-d |      d |    tau |  t>75% | datasheet |    fc/fs |
|---+------+--------+--------+--------+--------+-----------+----------|
| 0 |    1 |      1 |      0 |    --- |    --- |         1 |        1 |
| 1 |    2 |    0.5 |    0.5 |  1.443 |  2.000 |         2 | 0.110318 |
| 2 |    4 |   0.25 |   0.75 |  3.476 |  4.819 |         5 | 0.045786 |
| 3 |    8 |  0.125 |  0.875 |  7.489 | 10.382 |        11 | 0.021252 |
| 4 |   16 | 0.0625 | 0.9375 | 15.495 | 21.481 |        22 | 0.010272 |
|---+------+--------+--------+--------+--------+-----------+----------|

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4f5c4bd89067..e72cfd4c10b9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -159,6 +159,7 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -174,6 +175,7 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -193,6 +195,7 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -208,6 +211,7 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -223,6 +227,7 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 2,
 		.scan_type = {
 			.sign = 'u',
@@ -714,7 +719,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 		if (!data->chip_info->iir_filter_coeffs_avail)
 			return -EINVAL;
 
-		*val = (1 << data->iir_filter_coeff) - 1;
+		*val = data->chip_info->iir_filter_coeffs_avail[data->iir_filter_coeff];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -844,7 +849,7 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	int i;
 
 	for (i = 0; i < n; i++) {
-		if (avail[i] - 1  == val) {
+		if (avail[i] == val) {
 			prev = data->iir_filter_coeff;
 			data->iir_filter_coeff = i;
 
@@ -1095,6 +1100,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
 		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 filter = FIELD_PREP(BMP280_FILTER_MASK, data->iir_filter_coeff;
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
@@ -1109,7 +1115,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
 				 BMP280_FILTER_MASK,
-				 BMP280_FILTER_4X);
+				 filter);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
@@ -1174,6 +1180,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 static const int bmp280_temp_coeffs[] = { 10, 1 };
 static const int bmp280_press_coeffs[] = { 1, 256000 };
+static const int bmp280_iir_filter_coeffs_avail[] = { 0, 2, 4, 8, 16 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -1203,6 +1210,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1385,6 +1396,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1982,7 +1997,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 }
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
-static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
+static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 static const int bmp380_temp_coeffs[] = { 10, 1 };
 static const int bmp380_press_coeffs[] = { 1, 100000 };
-- 
2.51.0


