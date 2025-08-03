Return-Path: <linux-iio+bounces-22216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D7B19429
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811AB1731B0
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C3200BAE;
	Sun,  3 Aug 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="pBa5Cfa2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A491607AB
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230160; cv=none; b=iO50nisy0WtNOrLXNr0ersjmyDnfPfUP9gkn6QNqEgoS+i6EhnDIMAsZUmMQgKmbpLKsnE1CzWwCzK2HZHMRRknA8cKcXIUn7uKA/1WWzJhXZAohZeUxRAhcdcuWF5HhIHfT0y0Iw1WiMPB7cpl191JXuJ8YZt0gnVqV5fcOQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230160; c=relaxed/simple;
	bh=B2eDO8jzbuvpKuS2bZq7PFl+gutSeNL33Xjv+sSpti4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjRYhMsH0ST1f5N18huJLrmbTF//Ra+oE9vxFQFbtjg0Ooq+jSPKrIgJWo5Tn4209xzY2ThgkD3vuqbKXHNaqgrN4uIpFcPD42wqXR1bSnF/C/nDBOwpOwFcrHmkn6GFnETqNszA9EwtZYnB41e99CWqi68G/2aPupXPyv4OCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=pBa5Cfa2; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 4214A2407EF;
	Sun,  3 Aug 2025 16:09:17 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id A86162402E7;
	Sun,  3 Aug 2025 16:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754230155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uqGkLadJW+gutmAEVnzug4O48VLhjadzJfe+ZsyUZo=;
	b=pBa5Cfa2Ml9tqO02TEGToP6cjdWM7uotgt0tKZ/0Y6olRm9J09SHKmsTIWPPtuBdPf/lHF
	nxy3b9SwZ7t3gc2iCWSXtUL0WYtecduDHx6eRIzckzIpEZmO95wdLQNvQZCQIDBD3QC/X+
	fT5C7wRg2pLvqycocJMUdZeOpB863/y6Ul1ylbrPa9LHfohterPoWqtWiFjO0DqOlptJRF
	d6Oc6itVPZiBMUZL4wsutGQci/wsjTZ2BiMJZWC51E35ZoAlWLI5J2SqvznepJbDGgL5+a
	j26OT0r8pYUbrlTSb+D2389rOpC7kZoxR565AuPiCRrBxhq1+HRH2/vU4FQA9w==
Received: from Gerda.fritz.box (p54a0c634.dip0.t-ipconnect.de [84.160.198.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 67176240206;
	Sun,  3 Aug 2025 16:09:15 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings for BMx280
Date: Sun,  3 Aug 2025 16:08:00 +0200
Message-ID: <20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: b7db4a
X-Rspamd-UID: ce79d1

These devices were using a hardcoded IIR filter of length 4.  Enable
filter_low_pass_3db_frequency settings to control the filter length
settings of the device (as done already for the BMx380 and BMx580
devices, even though the 3dB corner has an inverse relation to the
filter length).  Remove an offset of 1 from the internal handling of
the available values.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 36 +++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4efdbfc3ac2c..b3dcee3fe9b3 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -185,7 +185,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -201,7 +202,8 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -221,7 +223,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -237,7 +240,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -253,7 +257,8 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.scan_index = 2,
 		.scan_type = {
 			.sign = 'u',
@@ -856,7 +861,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 		if (!data->chip_info->iir_filter_coeffs_avail)
 			return -EINVAL;
 
-		*val = (1 << data->iir_filter_coeff) - 1;
+		*val = data->chip_info->iir_filter_coeffs_avail[data->iir_filter_coeff];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -999,7 +1004,7 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	int i;
 
 	for (i = 0; i < n; i++) {
-		if (avail[i] - 1  == val) {
+		if (avail[i]  == val) {
 			prev = data->iir_filter_coeff;
 			data->iir_filter_coeff = i;
 
@@ -1281,9 +1286,9 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	}
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
-				 BMP280_FILTER_MASK |
-				 BMP280_TSTBY_MASK,
-				 tstby | BMP280_FILTER_4X);
+				 BMP280_TSTBY_MASK |
+				 BMP280_FILTER_MASK,
+				 tstby | data->iir_filter_coeff);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
@@ -1348,6 +1353,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 static const int bmp280_temp_coeffs[] = { 10, 1 };
 static const int bmp280_press_coeffs[] = { 1, 256000 };
+static const int bmp280_iir_filter_coeffs_avail[] = { 0, 2, 4, 8, 16 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -1381,6 +1387,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_sampling_freq_avail = ARRAY_SIZE(bmp280_odr_table) * 2,
 	.sampling_freq_default = BMP280_ODR_0HZ, /* MODE_FORCED */
 
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1567,6 +1577,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_sampling_freq_avail = ARRAY_SIZE(bme280_odr_table) * 2,
 	.sampling_freq_default = BME280_ODR_0HZ, /* MODE_FORCED */
 
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -2155,7 +2169,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 }
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
-static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
+static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 static const int bmp380_temp_coeffs[] = { 10, 1 };
 static const int bmp380_press_coeffs[] = { 1, 100000 };
-- 
2.50.1


