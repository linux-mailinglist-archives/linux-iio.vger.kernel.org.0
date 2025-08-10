Return-Path: <linux-iio+bounces-22532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125FDB1FBD6
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1583A7A24B4
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D751FECDD;
	Sun, 10 Aug 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="neI8qOKG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46E1F7910
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852372; cv=none; b=Rt5vi/xIctUOLbEos/VNi+FHfuXHJyceaXytHYXFd+A7OP3N3y+yzUyKkzQ/GXkjx7P+MXXJNDkfRtTsUuggdvgPEqwjGgaCFzerNzMVO7ezaxCUDpM+3RHnJ18FDFPWXovtOxGWmdcrtXE1fEPDnyHHYc37DsyIIYjXnaGjWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852372; c=relaxed/simple;
	bh=RJUNwHUKfd3htDC0+HB8qBD1ZL8WaAeKHYFOKNxNeu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmvHYslyJafbUI8xkxS6aj9vNrXfQFNfxYPbByNq7i1KRXyCd+EiwxioZg9fdYylK2CDpWkixt6d5L5UHw9IYk0mN63Phld8iE4F24Z9M0MRVdjphunSqEIKo/nTLlaH1iUnL5RB+2i4HjmIrqTq3fq7t0TQKCZKUe6yJyAaaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=neI8qOKG; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 721A7240DBA;
	Sun, 10 Aug 2025 20:59:23 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id D5DCD240266;
	Sun, 10 Aug 2025 20:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhsUSn6TFycQA7RENeJrimrXf9Z/sCckzzaBpPnDhOI=;
	b=neI8qOKG8cANt7d0gG8+l8ZqTa8oDOeFP1557NM0jT5Qz3VD00oQAzWS2jKWvk4nzSnw5P
	Fq29o+ZCQrAtD49E+FRcHEkw2stlA7xxFsc8y+wFw1efMcgtNzV3g6rzdfNgd3KfdBB/Jy
	BG4YNDAEuc6JKrN+HNw2DJZu4WtBbFSIiZgGB6x/ySkc+aQu6ATpAmiFT7qUoyKU1cF2RI
	MFrPcSNj9WXvRD4L5d8AuqmP+NKRukPx8bqO7732F4iQt5qFUzW19mF4Jelq40uGVNEHmS
	MiyEl2RXjmP4rKKAQLg+FY1mgj9pThyXv+p/BxFf+clskFUgfivJa5lFw/RFJw==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 99782240166;
	Sun, 10 Aug 2025 20:59:21 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 6/9] iio: pressure: bmp280: enable filter settings for BMx280
Date: Sun, 10 Aug 2025 20:58:43 +0200
Message-ID: <20250810185846.114355-7-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: 499f45
X-Rspamd-UID: b5a927

These devices were using a hardcoded IIR filter of length 4.  Enable
filter_low_pass_3db_frequency settings to control the filter length
settings of the device as done already for the BMx380 and BMx580
devices, even though the 3dB corner has an inverse relation to the
filter length.  Remove a superfluous offset of -1 from the internal
handling of the available values and use the table entries directly.
Keep the default value at the previous hardcoded value to keep
identical device behaviour after module load.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fbecee9928e8..0ee40b6abb44 100644
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
 
@@ -1104,7 +1109,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
 				 BMP280_FILTER_MASK,
-				 BMP280_FILTER_4X);
+				 data->iir_filter_coeff);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
@@ -1169,6 +1174,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 static const int bmp280_temp_coeffs[] = { 10, 1 };
 static const int bmp280_press_coeffs[] = { 1, 256000 };
+static const int bmp280_iir_filter_coeffs_avail[] = { 0, 2, 4, 8, 16 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -1198,6 +1204,10 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1383,6 +1393,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.iir_filter_coeffs_avail = bmp280_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp280_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.temp_coeffs = bmp280_temp_coeffs,
 	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
 	.press_coeffs = bmp280_press_coeffs,
@@ -1980,7 +1994,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 }
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
-static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
+static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 static const int bmp380_temp_coeffs[] = { 10, 1 };
 static const int bmp380_press_coeffs[] = { 1, 100000 };
-- 
2.50.1


