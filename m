Return-Path: <linux-iio+bounces-21073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C1AEC95E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D8D17079B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351CE270EA4;
	Sat, 28 Jun 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3FN/ZGnb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AD248F47
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131682; cv=none; b=OATmIVL2R0Em+Hr+gdWUUBnQCSNkv4Jfy7hOPnXwHfz4zTX9tybMWibhaU49pYCQcjhJs2d5YOUoCC7l8vkJm993vtW6bvTFsNmdpoEwdNe/FqUVmNYReMfkYvpvoH0HEdCzX5loeUb9OnQd6C/f46l6xGa+XLPcVsFXE81bBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131682; c=relaxed/simple;
	bh=EmltBKfHj5g75aO6COI1jvnMBDJqwWHFLAwBDTwW8nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pKBo6Tq3d8sWc5AyCOsND9h3aSKz7Me0XwPWQdqdKZJQb5CtT/z4tZP2BU/yyJQsM6MSISFcY0hBNWCmYM5+pbcydIVx0QqKJuQ5Y6OFKeljlJXLDnRkb3qj4YyQLkA88oFZaM92/NbgnQbqg7FqkWhkoTSB7wIYozzxRqixjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3FN/ZGnb; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73a45bb28f1so2234496a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751131677; x=1751736477; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6M6p0rWJ9SqRjH24WTa0Ow33kY4G+RyGuhKovp2iAU=;
        b=3FN/ZGnbOCt5hZC+CWlba2ndRj8viVo0SVcWRwNqUXdJzx9Yx0/p5DRU9vxTMFTh2q
         5MVP2EJyegDGLvMaOhnbDk955Qr2kNxMfYA/ENFba797vmsWxbBbTYY26jndveY3Xioy
         iEwLmbc33ef+NtkuOKEI9vQO5K9KrG0PIBPgq6/o/N7LPL/Q1fHF3z+LROa1ZMzphhtt
         xH7YkgsHsFwVbB1W946o9GNt4rOShBJH1krP/pGXs2KOcUUHuHw8nVYxvjyDSvGzdqoG
         4XDGFWhXwm/C+jbSdTLTokWN937OBwXZ1Ot96URPRcldplVV2Vu8aqhbFzVl25MmoSPg
         Nu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751131677; x=1751736477;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6M6p0rWJ9SqRjH24WTa0Ow33kY4G+RyGuhKovp2iAU=;
        b=nvb79XqBhBLd/d8ACJttQULYuJwTBVlX1VuxoUJ4fmJ/jV4CN6Dsawaq3DLCMzeERH
         f5xQsRFL/hILuw7Bw0hRhabHFebWmuRmVivkhDV96k1OE8vp0mH/qDjb3QvuWBSwn/uW
         M6fi5TNYfVXHMltixnxic51xgtLV3qVzNnxR+w+sKRrkmhSgMMJEFwjkiZZOT//YQaxw
         +kQQioN+z5PR3aMvlt8HHdYUSIC3M7ZS4MmU314XmxNPOt4tGQc6TLn5SxLAoOjZ5jHp
         Fns6Fv/LhawWk6tumpk+l7f25z2Fv9bfxmPGMOkwayfycVh24lwIJl7jAZ5UZnDJUISZ
         V2JQ==
X-Gm-Message-State: AOJu0YyfWsrDoABGlFrCEXLB+TVpgK0phwGhTvf1Q0ErchB4T4NZg1Lu
	mrbrx44S3QQbaezSFAWckoiz9qYonQ/+chyXSs+ajse9LH4fuIuSWbP8mj5kM8bHKkUD3y7GNA8
	gd3BK4WU=
X-Gm-Gg: ASbGncuq9O6m1VUfzGq4PoSN33d6eWPX4g4wUTiqsKYejj2kROiZkzKP9XPszyfoKqJ
	ZyzwoyTr0M8CGmfJa6KOsDB+9e+i6QRnN+lo9avDE9aP5YoXhbao3UqT5B8kO0uBW1tzu8l/6GG
	6WHz/vq2ROEfgpnfDPquczEpvY/LtwMcSpUIr01haG+dr3W+H8AT9sqs9j2tjk6y4vhyXoUWqXH
	XePSGYc/rBVt6RwoRzlS0GDf2/BdfGRidh0gDQ8Dq4Rw64Emi30BUE31sdawGRm9HKarNUratjM
	ytymK4orQgUjTQHC6BRazspF3QX1KdbYWqOav223eyDWro8pHwzjB/o9FjuKuB4dyc9t
X-Google-Smtp-Source: AGHT+IFtdxCEo+30Rr04xKRBABvAiy3QFIEoRr5lo+tTjUlIMIX1fd7eQMXR4lLfU47fzQBIJ8E/vQ==
X-Received: by 2002:a05:6808:1913:b0:409:f8e:72bd with SMTP id 5614622812f47-40b1c8abbd7mr9855415b6e.6.1751131677000;
        Sat, 28 Jun 2025 10:27:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322892c8sm887073b6e.5.2025.06.28.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:27:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:27:46 -0500
Subject: [PATCH] iio: imu: adis16400: drop use of chip info array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-17-v1-1-a215ebb653ec@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABEmYGgC/x3MTQqAIBBA4avErBvwh1K7SrSQmmo2GhoRiHdPW
 n6L9wpkSkwZpq5Aooczx9Ag+w7W04eDkLdmUEINYlQWmSOuMeQbN397lAZJeW2FE9oaB627Eu3
 8/s95qfUDd8sGCmMAAAA=
X-Change-ID: 20250628-iio-const-data-17-e2a380903879
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15248;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=EmltBKfHj5g75aO6COI1jvnMBDJqwWHFLAwBDTwW8nc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCYTKp6ecqBsm0FYqBCMY12akA7MFJQf9h7Vx
 hzTOnqtpeCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAmEwAKCRDCzCAB/wGP
 wD8TCACFShU+87c7RFPDZ9Sh3XY4Wh7TBMnG3ERg3pLkTmxtoHynhdS1XWwyLKXsgWExjEd+y2m
 HNIHz94SQvMhoVaETDLJ/YRnkLTqNCVj7gSYeQpjgjPAwurTFph1x/jytEplrJNAc6cVbcH2sw2
 4nI7upgoyvrItEX1rJOAotN4/UQgVy0/emhnKuo/5p8+afD8kNbfqlQJPDXruLASHVc7hBHiaUh
 4x/+THXzkS2NkCo0RKzaOZmP4c5Wr+YxvkHWEmLhDyaQnPDuhv0CTATCkPivWe8O/0GYjqenJxA
 1swbqTk+3+KfU+k+PrN4S4HCNYUGhQ0h+8JrpyztwO7Ogpr1
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the adis16400 driver to use individual chip info structures
instead of an array. This reduces the verbosity of the code. Also, the
data is now const as it should have been in the first place.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/adis16400.c | 314 +++++++++++++++++++++-----------------------
 1 file changed, 153 insertions(+), 161 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 90ed3f9bb39c502996161d9df3addcb093ccd11a..36323ad149e04de69f58403cb39d41df64564201 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -170,7 +170,7 @@ struct adis16400_chip_info {
  *			that must be enabled together
  **/
 struct adis16400_state {
-	struct adis16400_chip_info	*variant;
+	const struct adis16400_chip_info *variant;
 	int				filt_int;
 
 	struct adis adis;
@@ -289,19 +289,6 @@ static void adis16400_debugfs_init(struct iio_dev *indio_dev)
 			d, st, &adis16400_flash_count_fops);
 }
 
-enum adis16400_chip_variant {
-	ADIS16300,
-	ADIS16334,
-	ADIS16350,
-	ADIS16360,
-	ADIS16362,
-	ADIS16364,
-	ADIS16367,
-	ADIS16400,
-	ADIS16445,
-	ADIS16448,
-};
-
 static int adis16334_get_freq(struct adis16400_state *st)
 {
 	int ret;
@@ -984,137 +971,142 @@ static const struct adis_timeout adis16448_timeouts = {
 	.self_test_ms = 45,
 };
 
-static struct adis16400_chip_info adis16400_chips[] = {
-	[ADIS16300] = {
-		.channels = adis16300_channels,
-		.num_channels = ARRAY_SIZE(adis16300_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
-				ADIS16400_HAS_SERIAL_NUMBER,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
-		.accel_scale_micro = 5884,
-		.temp_scale_nano = 140000000, /* 0.14 C */
-		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 18),
-	},
-	[ADIS16334] = {
-		.channels = adis16334_channels,
-		.num_channels = ARRAY_SIZE(adis16334_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_NO_BURST |
-				ADIS16400_HAS_SERIAL_NUMBER,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
-		.temp_scale_nano = 67850000, /* 0.06785 C */
-		.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
-		.set_freq = adis16334_set_freq,
-		.get_freq = adis16334_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16334_timeouts, 0),
-	},
-	[ADIS16350] = {
-		.channels = adis16350_channels,
-		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(73260), /* 0.07326 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(2522), /* 0.002522 g */
-		.temp_scale_nano = 145300000, /* 0.1453 C */
-		.temp_offset = 25000000 / 145300, /* 25 C = 0x00 */
-		.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 0),
-	},
-	[ADIS16360] = {
-		.channels = adis16350_channels,
-		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
-				ADIS16400_HAS_SERIAL_NUMBER,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
-		.temp_scale_nano = 136000000, /* 0.136 C */
-		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
-	},
-	[ADIS16362] = {
-		.channels = adis16350_channels,
-		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
-				ADIS16400_HAS_SERIAL_NUMBER,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(333), /* 0.333 mg */
-		.temp_scale_nano = 136000000, /* 0.136 C */
-		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
-	},
-	[ADIS16364] = {
-		.channels = adis16350_channels,
-		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
-				ADIS16400_HAS_SERIAL_NUMBER,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
-		.temp_scale_nano = 136000000, /* 0.136 C */
-		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
-	},
-	[ADIS16367] = {
-		.channels = adis16350_channels,
-		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
-				ADIS16400_HAS_SERIAL_NUMBER,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(2000), /* 0.2 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
-		.temp_scale_nano = 136000000, /* 0.136 C */
-		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
-	},
-	[ADIS16400] = {
-		.channels = adis16400_channels,
-		.num_channels = ARRAY_SIZE(adis16400_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
-		.temp_scale_nano = 140000000, /* 0.14 C */
-		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
-		.set_freq = adis16400_set_freq,
-		.get_freq = adis16400_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16400_timeouts, 24),
-	},
-	[ADIS16445] = {
-		.channels = adis16445_channels,
-		.num_channels = ARRAY_SIZE(adis16445_channels),
-		.flags = ADIS16400_HAS_PROD_ID |
-				ADIS16400_HAS_SERIAL_NUMBER |
-				ADIS16400_BURST_DIAG_STAT,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(250), /* 1/4000 g */
-		.temp_scale_nano = 73860000, /* 0.07386 C */
-		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
-		.set_freq = adis16334_set_freq,
-		.get_freq = adis16334_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16445_timeouts, 16),
-	},
-	[ADIS16448] = {
-		.channels = adis16448_channels,
-		.num_channels = ARRAY_SIZE(adis16448_channels),
-		.flags = ADIS16400_HAS_PROD_ID |
-				ADIS16400_HAS_SERIAL_NUMBER |
-				ADIS16400_BURST_DIAG_STAT,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(40000), /* 0.04 deg/s */
-		.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
-		.temp_scale_nano = 73860000, /* 0.07386 C */
-		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
-		.set_freq = adis16334_set_freq,
-		.get_freq = adis16334_get_freq,
-		.adis_data = ADIS16400_DATA(&adis16448_timeouts, 24),
-	}
+static const struct adis16400_chip_info adis16300_chip_info = {
+	.channels = adis16300_channels,
+	.num_channels = ARRAY_SIZE(adis16300_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+		 ADIS16400_HAS_SERIAL_NUMBER,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
+	.accel_scale_micro = 5884,
+	.temp_scale_nano = 140000000, /* 0.14 C */
+	.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
+	.set_freq = adis16400_set_freq,
+	.get_freq = adis16400_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 18),
+};
+
+static const struct adis16400_chip_info adis16334_chip_info = {
+	.channels = adis16334_channels,
+	.num_channels = ARRAY_SIZE(adis16334_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_NO_BURST |
+		 ADIS16400_HAS_SERIAL_NUMBER,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
+	.temp_scale_nano = 67850000, /* 0.06785 C */
+	.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
+	.set_freq = adis16334_set_freq,
+	.get_freq = adis16334_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16334_timeouts, 0),
+};
+
+static const struct adis16400_chip_info adis16350_chip_info = {
+	.channels = adis16350_channels,
+	.num_channels = ARRAY_SIZE(adis16350_channels),
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(73260), /* 0.07326 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(2522), /* 0.002522 g */
+	.temp_scale_nano = 145300000, /* 0.1453 C */
+	.temp_offset = 25000000 / 145300, /* 25 C = 0x00 */
+	.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
+	.set_freq = adis16400_set_freq,
+	.get_freq = adis16400_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 0),
+};
+
+static const struct adis16400_chip_info adis16360_chip_info = {
+	.channels = adis16350_channels,
+	.num_channels = ARRAY_SIZE(adis16350_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+		 ADIS16400_HAS_SERIAL_NUMBER,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
+	.temp_scale_nano = 136000000, /* 0.136 C */
+	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
+	.set_freq = adis16400_set_freq,
+	.get_freq = adis16400_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
+};
+
+static const struct adis16400_chip_info adis16362_chip_info = {
+	.channels = adis16350_channels,
+	.num_channels = ARRAY_SIZE(adis16350_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+		 ADIS16400_HAS_SERIAL_NUMBER,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(333), /* 0.333 mg */
+	.temp_scale_nano = 136000000, /* 0.136 C */
+	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
+	.set_freq = adis16400_set_freq,
+	.get_freq = adis16400_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
+};
+
+static const struct adis16400_chip_info adis16364_chip_info = {
+	.channels = adis16350_channels,
+	.num_channels = ARRAY_SIZE(adis16350_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+		 ADIS16400_HAS_SERIAL_NUMBER,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
+	.temp_scale_nano = 136000000, /* 0.136 C */
+	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
+	.set_freq = adis16400_set_freq,
+	.get_freq = adis16400_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
+};
+
+static const struct adis16400_chip_info adis16367_chip_info = {
+	.channels = adis16350_channels,
+	.num_channels = ARRAY_SIZE(adis16350_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+		 ADIS16400_HAS_SERIAL_NUMBER,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(2000), /* 0.2 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
+	.temp_scale_nano = 136000000, /* 0.136 C */
+	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
+	.set_freq = adis16400_set_freq,
+	.get_freq = adis16400_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
+};
+
+static const struct adis16400_chip_info adis16400_chip_info = {
+	.channels = adis16400_channels,
+	.num_channels = ARRAY_SIZE(adis16400_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
+	.temp_scale_nano = 140000000, /* 0.14 C */
+	.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
+	.set_freq = adis16400_set_freq,
+	.get_freq = adis16400_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16400_timeouts, 24),
+};
+
+static const struct adis16400_chip_info adis16445_chip_info = {
+	.channels = adis16445_channels,
+	.num_channels = ARRAY_SIZE(adis16445_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SERIAL_NUMBER |
+		 ADIS16400_BURST_DIAG_STAT,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(250), /* 1/4000 g */
+	.temp_scale_nano = 73860000, /* 0.07386 C */
+	.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
+	.set_freq = adis16334_set_freq,
+	.get_freq = adis16334_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16445_timeouts, 16),
+};
+
+static const struct adis16400_chip_info adis16448_chip_info = {
+	.channels = adis16448_channels,
+	.num_channels = ARRAY_SIZE(adis16448_channels),
+	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SERIAL_NUMBER |
+		 ADIS16400_BURST_DIAG_STAT,
+	.gyro_scale_micro = IIO_DEGREE_TO_RAD(40000), /* 0.04 deg/s */
+	.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
+	.temp_scale_nano = 73860000, /* 0.07386 C */
+	.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
+	.set_freq = adis16334_set_freq,
+	.get_freq = adis16334_get_freq,
+	.adis_data = ADIS16400_DATA(&adis16448_timeouts, 24),
 };
 
 static const struct iio_info adis16400_info = {
@@ -1157,7 +1149,7 @@ static int adis16400_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 
 	/* setup the industrialio driver allocated elements */
-	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
+	st->variant = spi_get_device_match_data(spi);
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->channels = st->variant->channels;
 	indio_dev->num_channels = st->variant->num_channels;
@@ -1197,21 +1189,21 @@ static int adis16400_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adis16400_id[] = {
-	{"adis16300", ADIS16300},
-	{"adis16305", ADIS16300},
-	{"adis16334", ADIS16334},
-	{"adis16350", ADIS16350},
-	{"adis16354", ADIS16350},
-	{"adis16355", ADIS16350},
-	{"adis16360", ADIS16360},
-	{"adis16362", ADIS16362},
-	{"adis16364", ADIS16364},
-	{"adis16365", ADIS16360},
-	{"adis16367", ADIS16367},
-	{"adis16400", ADIS16400},
-	{"adis16405", ADIS16400},
-	{"adis16445", ADIS16445},
-	{"adis16448", ADIS16448},
+	{ "adis16300", (kernel_ulong_t)&adis16300_chip_info },
+	{ "adis16305", (kernel_ulong_t)&adis16300_chip_info },
+	{ "adis16334", (kernel_ulong_t)&adis16334_chip_info },
+	{ "adis16350", (kernel_ulong_t)&adis16350_chip_info },
+	{ "adis16354", (kernel_ulong_t)&adis16350_chip_info },
+	{ "adis16355", (kernel_ulong_t)&adis16350_chip_info },
+	{ "adis16360", (kernel_ulong_t)&adis16360_chip_info },
+	{ "adis16362", (kernel_ulong_t)&adis16362_chip_info },
+	{ "adis16364", (kernel_ulong_t)&adis16364_chip_info },
+	{ "adis16365", (kernel_ulong_t)&adis16360_chip_info },
+	{ "adis16367", (kernel_ulong_t)&adis16367_chip_info },
+	{ "adis16400", (kernel_ulong_t)&adis16400_chip_info },
+	{ "adis16405", (kernel_ulong_t)&adis16400_chip_info },
+	{ "adis16445", (kernel_ulong_t)&adis16445_chip_info },
+	{ "adis16448", (kernel_ulong_t)&adis16448_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16400_id);

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-17-e2a380903879

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


