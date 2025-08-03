Return-Path: <linux-iio+bounces-22219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E364B1942B
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 16:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BD217328B
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073D25EFB6;
	Sun,  3 Aug 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="HCUwTinm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFBB2248A3
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230164; cv=none; b=HKOxqeKFfrjfQ/UB+XF7bEZNpffy7ghFF2eLaBBrc4hklq/j8ebM5RFGbAlxyuiybKGnRvf7vzfz7jWVKJar19Q91wp+tXxUf1mtl7QwrU7IqOdRyKs4PlD/Ea2Lh8j87o6OH9/Xn6m+WvPrYAn+4AfOEsxEYdbny3oIp8QsbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230164; c=relaxed/simple;
	bh=G+V9qu+VBifZsR8JHjfNfUJ9L3pmcOaNTrclU8rAd2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKK64rTC3Dj2TzsufBlmKH7HsCkRc/0LVNasnN1t7zwgDqfplkNbIu/EI+gHcByJWlULdDTVPazBdnKhrSCcfGdW2mtYKdgYwOpaMpu6X9u7ZXqST/8wwr9cZapUH6K6viAhzHbYzntAZGoDs/okuClru5S7Cy8eICqF8RnGVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=HCUwTinm; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id C5BC52405D3;
	Sun,  3 Aug 2025 16:09:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 361D7240206;
	Sun,  3 Aug 2025 16:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754230159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y53ihokkXpunOEZy7k5QpeZBj7C4R/uorXLJsgVSDWk=;
	b=HCUwTinmJk+X50Zk/zFdz45h6JY93tNMJ92gQIvxobrGJWuiz+x6+J6Xji+voFLGrDH4GZ
	+9b0xhh+LCo1wSQ8GyOzQ5yOcT1sjfTePmHxofeTpjIJBWqGpEhoKB2oo5z+Lqb18HZdYU
	0VTVfss1kVPZT5WfCL3o/VfONWLU+0ke4gcOvJy+9HHzZnZMacDb1bi+H2rBmIt6GFKsX1
	BwBZ6T79yjnHIE++53ZvEuonx42CTv5srLdmTcQ9M8SSZEsIcgB/DWLhP5KPkTzor4x7EB
	P93FD8NVKoRTWk/hYfVkPXn8mPswWD7ucx/rfG9/7iUQd9VQwLgKwiZrIuEbrw==
Received: from Gerda.fritz.box (p54a0c634.dip0.t-ipconnect.de [84.160.198.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id EB757240165;
	Sun,  3 Aug 2025 16:09:18 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [bmp280 v1 6/6] iio: pressure: bmp280: implement sampling_frequency calculation for BMx280
Date: Sun,  3 Aug 2025 16:08:02 +0200
Message-ID: <20250803140802.36888-7-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: 56db6a
X-Rspamd-UID: 3c2bbc

Report of the actual sampling frequency via sysfs is implemented based
on the nominal measurement cycle time, depending on oversampling_ratio
and t_standby settings.  If the device dependent table for the
t_standby values is missing, the reported value is taken from the ODR
table as before.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 90 ++++++++++++++++++++++--------
 drivers/iio/pressure/bmp280.h      |  1 +
 2 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 5cdaf7516940..3be22e2b777a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -648,6 +648,45 @@ static int bme280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
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
@@ -671,6 +710,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		raw = 1;
+		fallthrough;
 	case IIO_CHAN_INFO_PROCESSED:
 		switch_off = 0;
 		if (data->op_mode == BMP280_FORCED) {
@@ -794,9 +834,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -1078,6 +1116,18 @@ static const int bmp280_odr_table[][2] = {
 	[BMP280_ODR_0_49HZ]	= {0,  490000},
 	[BMP280_ODR_0_24HZ]	= {0,  240000},
 };
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
 
 static const int bme280_odr_table[][2] = {
 	[BME280_ODR_0HZ]	= {0,       0}, /* MODE_FORCED */
@@ -1090,6 +1140,18 @@ static const int bme280_odr_table[][2] = {
 	[BME280_ODR_51HZ]	= {51,      0},
 	[BME280_ODR_34HZ]	= {34,      0},
 };
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
 
 static int bmp280_preinit(struct bmp280_data *data)
 {
@@ -1142,26 +1204,6 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 	return 0;
 }
 
-static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
-{
-	unsigned int meas_time_us = BMP280_MEAS_OFFSET;
-
-	/* Check if we are using a BME280 device */
-	if (data->chip_info->oversampling_humid_avail)
-		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
-				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
-
-	/* Pressure measurement time */
-	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
-			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
-
-	/* Temperature measurement time */
-	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
-
-	/* nominal value */
-	return meas_time_us;
-}
-
 static int bmp280_wait_conv(struct bmp280_data *data)
 {
 	unsigned int reg, meas_time_us;
@@ -1324,6 +1366,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.sampling_freq_tstby = bmp280_tstby_table,
 	.sampling_freq_avail = bmp280_odr_table,
 	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
 	.sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */
@@ -1514,6 +1557,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.sampling_freq_tstby = bme280_tstby_table,
 	.sampling_freq_avail = bme280_odr_table,
 	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
 	.sampling_freq_default = BME280_ODR_0HZ, /* MODE_FORCED */
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index e5cb2a52126d..89dbf19c9ee9 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -522,6 +522,7 @@ struct bmp280_chip_info {
 	int num_iir_filter_coeffs_avail;
 	int iir_filter_coeff_default;
 
+	const int *sampling_freq_tstby;
 	const int (*sampling_freq_avail)[2];
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
-- 
2.50.1


