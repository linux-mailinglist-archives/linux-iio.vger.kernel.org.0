Return-Path: <linux-iio+bounces-11986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F4C9C0792
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA031F235D1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F115214400;
	Thu,  7 Nov 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="B1Ul9Dlp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7D213131;
	Thu,  7 Nov 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986308; cv=none; b=SnajU3z/Mgs18gbgFEgNH+zRnsE89VhZ+rZq4Rd0ikZ2C1n9SV0BV2z3/WccnaLIhYewh7/u8MqjrkvQ/t3BzSSz80nAUKjHsHvm12XAP6O6u+2i4wc3Li0iO+u//M+NbsmSjlipEITTvAf06siFnFzbfj41Kp6LGLGDDdomei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986308; c=relaxed/simple;
	bh=p4PjpjcqpCEPNzrgmswyZPMDezWrhYJ+ylCNWP+vmvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7iJAhSAhJAAlTBFfBB4+p2TdyrwNomrGEMXCPyY6yN1LsAmfyy6PU2yNOgz6joDjNm6LPyIShY+HTjW8mb4fPIRLC1kNLl99gnQOZudZTpGiSq/XBcQp7F/Fks0yraDt5KvYZAJa3NjXWYIjhSf6U87/BNzhQWAGa+zCyrG8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=B1Ul9Dlp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A77hHHW004489;
	Thu, 7 Nov 2024 08:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t/IMl
	0HSm9codHlXaYZxU/5gmAvY2mQhj3VuhnnB8BQ=; b=B1Ul9Dlp6XkPr0gt4UtV2
	LxD1GlKjhahsoCSAvG2IwjIq5OKrJ2coNoy+jS1PRQgj/KmrOkN9FKTHNrJotWLP
	P4S6IrVspZUCrQGkZuzsdbgKE6BxXdIHuR7mnwLVFKBgivK3VrjZWQUlcxmSfJRl
	5bvc99g2DNfM9dCBCgCqOBCsf5ZOqz12hUgJxSNGHF9EFur2EuqkLomZ12EmhwZ6
	hIMwhEWRC8+zbbAnfyyGjn9uJc7AObq7Nj3HwBUiKkiDxA8Yls4bTtcRePE1JLDV
	9DRNvpiskSCP1gR8bRkVZbXYZaLdRcjHMWrCdceniBwSzMDC4HEky6s+yKPxgvTw
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42rsdks7ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:31:44 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A7DVg2g032070
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 08:31:42 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Nov 2024 08:31:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Nov 2024 08:31:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Nov 2024 08:31:42 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A7DVUGr019172;
	Thu, 7 Nov 2024 08:31:35 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <darius.berghe@analog.com>
Subject: [PATCH v2 1/3] iio: imu: adis16480: add devices to adis16480 driver
Date: Thu, 7 Nov 2024 15:45:15 +0200
Message-ID: <20241107134517.3089112-2-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107134517.3089112-1-darius.berghe@analog.com>
References: <20241107134517.3089112-1-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ehTKG8jr1jXK9DXbUReHW5nB-aKFI-TN
X-Proofpoint-ORIG-GUID: ehTKG8jr1jXK9DXbUReHW5nB-aKFI-TN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070105

Add support for adis16486, adis16487 and adis16489 Six Degrees
of Freedom Inertial Sensors into the existing adis16480 iio
subsystem driver.

adis16486 is similar to adis16485, has the exact same channels
but acceleration and delta velocity scales are different.

adis16487 is fallback compatible with adis16485.

adis16489 is similar to adis16488 but lacks the magnetometer
and has a different accelerometer scale.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 drivers/iio/imu/adis16480.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 7bfda7133a96..03a2f21dd779 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -912,6 +912,24 @@ static const struct iio_chan_spec adis16485_channels[] = {
 	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
 };
 
+static const struct iio_chan_spec adis16489_channels[] = {
+	ADIS16480_GYRO_CHANNEL(X),
+	ADIS16480_GYRO_CHANNEL(Y),
+	ADIS16480_GYRO_CHANNEL(Z),
+	ADIS16480_ACCEL_CHANNEL(X),
+	ADIS16480_ACCEL_CHANNEL(Y),
+	ADIS16480_ACCEL_CHANNEL(Z),
+	ADIS16480_PRESSURE_CHANNEL(),
+	ADIS16480_TEMP_CHANNEL(),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTANG_CHANNEL_NO_SCAN(Z),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(X),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Y),
+	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
+};
+
 static const struct iio_chan_spec adis16495_channels[] = {
 	ADIS16480_GYRO_CHANNEL(X),
 	ADIS16480_GYRO_CHANNEL(Y),
@@ -952,7 +970,10 @@ enum adis16480_variant {
 	ADIS16375,
 	ADIS16480,
 	ADIS16485,
+	ADIS16486,
+	ADIS16487,
 	ADIS16488,
+	ADIS16489,
 	ADIS16490,
 	ADIS16495_1,
 	ADIS16495_2,
@@ -1108,6 +1129,38 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.filter_freqs = adis16480_def_filter_freqs,
 		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0, 0),
 	},
+	[ADIS16486] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = 22500 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(450),
+		.accel_max_val = IIO_M_S_2_TO_G(20000 << 16),
+		.accel_max_scale = 18,
+		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
+		.int_clk = 2460000,
+		.max_dec_rate = 2048,
+		.has_sleep_cnt = true,
+		.filter_freqs = adis16480_def_filter_freqs,
+		.adis_data = ADIS16480_DATA(16486, &adis16480_timeouts, 0, 0),
+	},
+	[ADIS16487] = {
+		.channels = adis16485_channels,
+		.num_channels = ARRAY_SIZE(adis16485_channels),
+		.gyro_max_val = 22500 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(450),
+		.accel_max_val = IIO_M_S_2_TO_G(20000 << 16),
+		.accel_max_scale = 5,
+		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 50,
+		.int_clk = 2460000,
+		.max_dec_rate = 2048,
+		.has_sleep_cnt = true,
+		.filter_freqs = adis16480_def_filter_freqs,
+		.adis_data = ADIS16480_DATA(16487, &adis16485_timeouts, 0, 0),
+	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
 		.num_channels = ARRAY_SIZE(adis16480_channels),
@@ -1124,6 +1177,22 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.filter_freqs = adis16480_def_filter_freqs,
 		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0, 0),
 	},
+	[ADIS16489] = {
+		.channels = adis16489_channels,
+		.num_channels = ARRAY_SIZE(adis16489_channels),
+		.gyro_max_val = 22500 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(450),
+		.accel_max_val = IIO_M_S_2_TO_G(20000 << 16),
+		.accel_max_scale = 18,
+		.temp_scale = 5650, /* 5.65 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 200,
+		.int_clk = 2460000,
+		.max_dec_rate = 2048,
+		.has_sleep_cnt = true,
+		.filter_freqs = adis16480_def_filter_freqs,
+		.adis_data = ADIS16480_DATA(16489, &adis16480_timeouts, 0, 0),
+	},
 	[ADIS16490] = {
 		.channels = adis16485_channels,
 		.num_channels = ARRAY_SIZE(adis16485_channels),
@@ -1841,7 +1910,10 @@ static const struct spi_device_id adis16480_ids[] = {
 	{ "adis16375", ADIS16375 },
 	{ "adis16480", ADIS16480 },
 	{ "adis16485", ADIS16485 },
+	{ "adis16486", ADIS16486 },
+	{ "adis16487", ADIS16487 },
 	{ "adis16488", ADIS16488 },
+	{ "adis16489", ADIS16489 },
 	{ "adis16490", ADIS16490 },
 	{ "adis16495-1", ADIS16495_1 },
 	{ "adis16495-2", ADIS16495_2 },
@@ -1863,7 +1935,10 @@ static const struct of_device_id adis16480_of_match[] = {
 	{ .compatible = "adi,adis16375" },
 	{ .compatible = "adi,adis16480" },
 	{ .compatible = "adi,adis16485" },
+	{ .compatible = "adi,adis16486" },
+	{ .compatible = "adi,adis16487" },
 	{ .compatible = "adi,adis16488" },
+	{ .compatible = "adi,adis16489" },
 	{ .compatible = "adi,adis16490" },
 	{ .compatible = "adi,adis16495-1" },
 	{ .compatible = "adi,adis16495-2" },
-- 
2.46.1


