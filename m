Return-Path: <linux-iio+bounces-22530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0DAB1FBD4
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202327A241C
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E71FDA8E;
	Sun, 10 Aug 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="NZ9R7n0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334051FBEB1
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852370; cv=none; b=DsoIdzow3hRmvSIAJqIbQ5My2Ga3Pdem4v9TW8eM6KENO20cRhyte8ETsTAn6jbd70eoZxJZ8emgvAYDjF+UEHgXh5InJ1p2BqK2cNgYX+iuanrNOpK3zUgfNNcbkv7nrdc8LSeO6+vKW4TQ+/xnLcDr+pe/j1+mkp7p8t7HlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852370; c=relaxed/simple;
	bh=3+J4NJCIoRwq75goSb0WmmcgZiF5oMgF4vzoaatWBik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG1ErrjrhYLGe5OWsXRkvdVogNmopsJLEzT7K7m73pqQIWKrqvMUUNLAyfU5F7m0UT4kSOv5n6w4nZSCcErYmXiKjksMHa4GS6goRT/s5bAZ3X8jbGx+/VaX3TTpcgpseDM8Q8BR4iYUcpLHPzl/3MP15FRZ0WU61HY1WcHS1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=NZ9R7n0F; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id B9CCC240854;
	Sun, 10 Aug 2025 20:59:27 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 2B2D3240166;
	Sun, 10 Aug 2025 20:59:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7klgJW3YD2M9TrPuDKpxI5HAMxkojxjuXRnhpW4gScA=;
	b=NZ9R7n0F/GxR2D6xeQ4WKN0DYuZyJlpLlCQjPJOfV2FJwvfrE+1B+NARy7oDQjIXcwCu/h
	JjW49f5DXhhs9hsdiXmKy/4p8lmIobT3STSIOPUlN9hFxHemetLcg2x8z83qj+t6unRy3L
	abQx5m8ClTK9aA0b2krbluTAlBY48e7HPKPHw5s6hEwrLHOy0dK1TuzOtg0Bwgj3BZgfv7
	DxayhEWDEXxRHysk+wEOt8d0NVKqED0MEHC194BhQ7nqV4O7R9aUxxjysQzY9mwU8uYJDj
	ndYFEX4JVPDoxNYQarcOtzHQ5LFwsbqiovvYoAOFnK7ryg0/adh9ajtbT6Gx+Q==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id E3D84240159;
	Sun, 10 Aug 2025 20:59:25 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 8/9] iio: pressure: bmp280: implement sampling_frequency calculation for BMx280
Date: Sun, 10 Aug 2025 20:58:45 +0200
Message-ID: <20250810185846.114355-9-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: dd41e6
X-Rspamd-UID: 920e3b

Report of the actual sampling frequency via sysfs is implemented based
on the maximum measurement cycle time, depending on oversampling_ratio
and t_standby settings.  If the device dependent table for the
t_standby values is missing, the reported value is taken from the ODR
table as before, which enables the support for the BMx[35]80 devices
to be unchanged.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 58 +++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  2 ++
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a66b90b3ddb8..5c4126e4eccd 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -55,6 +55,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #include <linux/unaligned.h>
+#include <linux/units.h>
 
 #include "bmp280.h"
 
@@ -757,9 +758,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!data->chip_info->sampling_freq_avail)
 			return -EINVAL;
-
-		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
-		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
+		data->chip_info->calc_sampling_freq(data, val, val2);
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (!data->chip_info->iir_filter_coeffs_avail)
@@ -1029,6 +1028,20 @@ static const int bmp280_odr_table[][2] = {
 	[BMP280_ODR_0_49HZ]	= {0,  490000},
 	[BMP280_ODR_0_24HZ]	= {0,  240000},
 };
+static const int bmp280_tstby_table[] = {
+	[BMP280_ODR_0HZ]	=       0,
+	[BMP280_ODR_155HZ]	=       0,
+	[BMP280_ODR_144HZ]	=     500,
+	[BMP280_ODR_14_5HZ]	=   62500,
+	[BMP280_ODR_7_60HZ]	=  125000,
+	[BMP280_ODR_3_90HZ]	=  250000,
+	[BMP280_ODR_1_97HZ]	=  500000,
+	[BMP280_ODR_0_99HZ]	= 1000000,
+	[BMP280_ODR_0_49HZ]	= 2000000,
+	[BMP280_ODR_0_24HZ]	= 4000000,
+};
+static_assert(ARRAY_SIZE(bmp280_odr_table) == ARRAY_SIZE(bmp280_tstby_table),
+	      "BMP280 ODR and t_stby table sizes don't match!");
 
 static const int bme280_odr_table[][2] = {
 	[BME280_ODR_0HZ]	= {0,       0},
@@ -1042,6 +1055,20 @@ static const int bme280_odr_table[][2] = {
 	[BME280_ODR_51_8HZ]	= {51, 800000},
 	[BME280_ODR_34_1HZ]	= {34, 100000},
 };
+static const int bme280_tstby_table[] = {
+	[BME280_ODR_0HZ]	=       0,
+	[BME280_ODR_107HZ]	=       0,
+	[BME280_ODR_102HZ]	=     500,
+	[BME280_ODR_13_9HZ]	=   62500,
+	[BME280_ODR_7_44HZ]	=  125000,
+	[BME280_ODR_3_85HZ]	=  250000,
+	[BME280_ODR_1_96HZ]	=  500000,
+	[BME280_ODR_0_99HZ]	= 1000000,
+	[BME280_ODR_51_8HZ]	=   10000,
+	[BME280_ODR_34_1HZ]	=   20000,
+};
+static_assert(ARRAY_SIZE(bme280_odr_table) == ARRAY_SIZE(bme280_tstby_table),
+	      "BME280 ODR and t_stby table sizes don't match!");
 
 static int bmp280_preinit(struct bmp280_data *data)
 {
@@ -1121,6 +1148,23 @@ static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
 	return meas_time_us;
 }
 
+static void bmp280_calc_sampling_freq(struct bmp280_data *data, int *val, int *val2)
+{
+	unsigned int cycle_time_us;
+	unsigned long freq_uHz;
+
+	if (data->chip_info->sampling_freq_tstby) {
+		cycle_time_us  = bmp280_calc_meas_time_us(data);
+		cycle_time_us += data->chip_info->sampling_freq_tstby[data->sampling_freq];
+		freq_uHz = MICROHZ_PER_HZ*USEC_PER_SEC / cycle_time_us;
+		*val  = freq_uHz / MICROHZ_PER_HZ;
+		*val2 = freq_uHz % MICROHZ_PER_HZ;
+	} else {
+		*val  = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
+		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
+	}
+}
+
 static int bmp280_wait_conv(struct bmp280_data *data)
 {
 	unsigned int reg, meas_time_us, initial_wait;
@@ -1181,7 +1225,9 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | (data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP));
+				osrs | BMP280_SLEEP);
+	/* Ensure a mode transition on next measurement */
+	data->op_mode = BMP280_SLEEP;
 	if (ret)
 		return ret;
 	if (ret) {
@@ -1290,6 +1336,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_tstby = bmp280_tstby_table,
 	.sampling_freq_avail = bmp280_odr_table,
 	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
 	.sampling_freq_default = BMP280_ODR_0HZ,
@@ -1305,6 +1352,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_calib = bmp280_read_calib,
 	.set_mode = bmp280_set_mode,
 	.wait_conv = bmp280_wait_conv,
+	.calc_sampling_freq = bmp280_calc_sampling_freq,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1483,6 +1531,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_tstby = bme280_tstby_table,
 	.sampling_freq_avail = bme280_odr_table,
 	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
 	.sampling_freq_default = BME280_ODR_0HZ,
@@ -1501,6 +1550,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_calib = bme280_read_calib,
 	.set_mode = bmp280_set_mode,
 	.wait_conv = bmp280_wait_conv,
+	.calc_sampling_freq = bmp280_calc_sampling_freq,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index c15d0c74d4b6..19420709162c 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -521,6 +521,7 @@ struct bmp280_chip_info {
 	int num_iir_filter_coeffs_avail;
 	int iir_filter_coeff_default;
 
+	const int *sampling_freq_tstby;
 	const int (*sampling_freq_avail)[2];
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
@@ -540,6 +541,7 @@ struct bmp280_chip_info {
 	int (*preinit)(struct bmp280_data *data);
 	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
 	int (*wait_conv)(struct bmp280_data *data);
+	void (*calc_sampling_freq)(struct bmp280_data *data, int *val, int *val2);
 
 	int (*trigger_probe)(struct iio_dev *indio_dev);
 	irqreturn_t (*trigger_handler)(int irq, void *p);
-- 
2.50.1


