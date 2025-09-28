Return-Path: <linux-iio+bounces-24535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E573BA7557
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD46163BB7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3963E1FF60A;
	Sun, 28 Sep 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="LQMpGugG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EF4A01
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080454; cv=none; b=dSD40Df3uuOsLexESVUmEOiol7dZz600LC00LPSW9TA+yUK2JVblgu9RmRhZPUaDlOxEXLJQIhfbPY2u8fDF5DOVox4/5Fls1tEoDZ3E4Qk/DMszImDZ4aZdRx1Dr+hIs5Mhz5ZrJUmQ4mlYCIQF0V7JtF2aoVhbPf8Tcc0AtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080454; c=relaxed/simple;
	bh=Zczg2aqyItWxLyMoKjL7rBT9Uu/tnqe2WUypOW3Q+G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX3CdVDHGUMJsG8nY5HRP/86qgsVPfr1yrRXkPWPVJuCANoELYPlj+mja72Zja8pkC5zzY38wKVpqiDs0TM9I62ujW8DInPzFp3OYCijXDggKAVV9qIX2ljzU+Lu7SygsD+/RQc/4Y9vLSCo948E6AFPKr7GNHy5fwXW7Ljiu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=LQMpGugG; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id B5003240CEB;
	Sun, 28 Sep 2025 19:27:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 23D20240518;
	Sun, 28 Sep 2025 19:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rddXC3lcssMOweppRjnEH2N//R04ipDheHcXHeLJ9Bk=;
	b=LQMpGugG5HFueS4Z/gpPbi/T0mF57h5WfTGv/gnMm2mAXeJ0ycuU4EQSsDavGjPqCtMcjO
	rc0psQVb+dL0vVkKbP/9/2BvwAJtgDVN2a/hT5bbn/v22akbDxRXpx2RFEVf7C3Mf56hy7
	uQ5mNacTbLwI7IBXRULBTxc9KoUtpoVIgU4VB6gRZyqrDL/LU6SYWnFWvDsTGEG3ZCGFLh
	uV7mR7AqMLg0QiWMi6DgKMh+zExnhg+jNQ52clGkbBQCbwLacqOjiAfSp5uid+iY3iEnfA
	FNRG4JNA2hJzgpOT73aQeidiOT1tnWnXuWBeaPgYekTu+SpfVDP0V8xf2AFwxw==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id DAA7F24012F;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 8/9] iio: pressure: bmp280: implement sampling_frequency calculation for BMx280
Date: Sun, 28 Sep 2025 19:26:36 +0200
Message-ID: <20250928172637.37138-10-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: cdd27a
X-Rspamd-UID: c556bd

Report of the actual sampling frequency via sysfs is implemented based
on the maximum measurement cycle time, depending on oversampling_ratio
and t_standby settings.  If the device dependent table for the
t_standby values is missing, the reported value is taken from the ODR
table as before, which enables the support for the BMx[35]80 devices
to be unchanged.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 60 +++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  2 +
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 9ade6d9e047b..4edabdd17f57 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -55,6 +55,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #include <linux/unaligned.h>
+#include <linux/units.h>
 
 #include "bmp280.h"
 
@@ -764,9 +765,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -1027,21 +1026,33 @@ static const unsigned long bme280_avail_scan_masks[] = {
 static const int bmp280_odr_table[][2] = {
 	/* BMP280_ODR_FORCED is a driver feature, not a register setting */
 	[BMP280_ODR_FORCED]	= {   0,      0 },
-	[BMP280_ODR_155HZ]	= { 155,      0 },
 	[BMP280_ODR_144HZ]	= { 144,      0 },
 	[BMP280_ODR_14_5HZ]	= {  14, 500000 },
 	[BMP280_ODR_7_60HZ]	= {   7, 600000 },
 	[BMP280_ODR_3_90HZ]	= {   3, 900000 },
 	[BMP280_ODR_1_97HZ]	= {   1, 970000 },
-	[BMP280_ODR_0_99HZ]	= {   0, 990000 },
+	[BMP280_ODR_0_994HZ]	= {   0, 990000 },
 	[BMP280_ODR_0_498HZ]	= {   0, 498000 },
 	[BMP280_ODR_0_250HZ]	= {   0, 250000 },
 };
+static const int bmp280_tstby_table[] = {
+	/* BMP280_ODR_FORCED is a driver feature, not a register setting */
+	[BMP280_ODR_FORCED]	=   0,
+	[BMP280_ODR_144HZ]	=   0.5*USEC_PER_MSEC,
+	[BMP280_ODR_14_5HZ]	=  62.5*USEC_PER_MSEC,
+	[BMP280_ODR_7_60HZ]	= 125*USEC_PER_MSEC,
+	[BMP280_ODR_3_90HZ]	= 250*USEC_PER_MSEC,
+	[BMP280_ODR_1_97HZ]	= 500*USEC_PER_MSEC,
+	[BMP280_ODR_0_994HZ]	=   1*USEC_PER_SEC,
+	[BMP280_ODR_0_498HZ]	=   2*USEC_PER_SEC,
+	[BMP280_ODR_0_250HZ]	=   4*USEC_PER_SEC,
+};
+static_assert(ARRAY_SIZE(bmp280_odr_table) == ARRAY_SIZE(bmp280_tstby_table),
+	      "BMP280 ODR and t_stby table sizes don't match!");
 
 static const int bme280_odr_table[][2] = {
 	/* BMP380_ODR_FORCED is a driver feature, not a register setting */
 	[BME280_ODR_FORCED]	= {   0,      0 },
-	[BME280_ODR_107HZ]	= { 107,      0 },
 	[BME280_ODR_102HZ]	= { 102,      0 },
 	[BME280_ODR_13_9HZ]	= {  13, 900000 },
 	[BME280_ODR_7_44HZ]	= {   7, 440000 },
@@ -1051,6 +1062,20 @@ static const int bme280_odr_table[][2] = {
 	[BME280_ODR_51_8HZ]	= {  51, 800000 },
 	[BME280_ODR_34_1HZ]	= {  34, 100000 },
 };
+static const int bme280_tstby_table[] = {
+	/* BMP380_ODR_FORCED is a driver feature, not a register setting */
+	[BME280_ODR_FORCED]	=   0,
+	[BME280_ODR_102HZ]	=   0.5*USEC_PER_MSEC,
+	[BME280_ODR_13_9HZ]	=  62.5*USEC_PER_MSEC,
+	[BME280_ODR_7_44HZ]	= 125*USEC_PER_MSEC,
+	[BME280_ODR_3_85HZ]	= 250*USEC_PER_MSEC,
+	[BME280_ODR_1_96HZ]	= 500*USEC_PER_MSEC,
+	[BME280_ODR_0_991HZ]	=   1*USEC_PER_SEC,
+	[BME280_ODR_51_8HZ]	=  10*USEC_PER_MSEC,
+	[BME280_ODR_34_1HZ]	=  20*USEC_PER_MSEC,
+};
+static_assert(ARRAY_SIZE(bme280_odr_table) == ARRAY_SIZE(bme280_tstby_table),
+	      "BME280 ODR and t_stby table sizes don't match!");
 
 static int bmp280_preinit(struct bmp280_data *data)
 {
@@ -1130,6 +1155,23 @@ static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
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
 static int bmp280_conv(struct bmp280_data *data)
 {
 	unsigned int reg, meas_time_us, initial_wait;
@@ -1197,6 +1239,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
 				osr_temp | osr_press | mode);
+	/* Ensure a mode transition on next measurement */
+	data->op_mode = BMP280_SLEEP;
 	if (ret)
 		return ret;
 	if (ret) {
@@ -1305,6 +1349,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_tstby = bmp280_tstby_table,
 	.sampling_freq_avail = bmp280_odr_table,
 	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
 	.sampling_freq_default = BMP280_ODR_FORCED,
@@ -1320,6 +1365,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_calib = bmp280_read_calib,
 	.set_mode = bmp280_set_mode,
 	.conv = bmp280_conv,
+	.calc_sampling_freq = bmp280_calc_sampling_freq,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1495,6 +1541,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.sampling_freq_tstby = bme280_tstby_table,
 	.sampling_freq_avail = bme280_odr_table,
 	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
 	.sampling_freq_default = BME280_ODR_FORCED,
@@ -1513,6 +1560,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_calib = bme280_read_calib,
 	.set_mode = bmp280_set_mode,
 	.conv = bmp280_conv,
+	.calc_sampling_freq = bmp280_calc_sampling_freq,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 8e05cdf869e7..ed7c5ad7d568 100644
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
 	int (*conv)(struct bmp280_data *data);
+	void (*calc_sampling_freq)(struct bmp280_data *data, int *val, int *val2);
 
 	int (*trigger_probe)(struct iio_dev *indio_dev);
 	irqreturn_t (*trigger_handler)(int irq, void *p);
-- 
2.51.0


