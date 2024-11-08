Return-Path: <linux-iio+bounces-12032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837969C1D3F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339DAB2313A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E61E885B;
	Fri,  8 Nov 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SgFKiUtD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF14194A48;
	Fri,  8 Nov 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069891; cv=none; b=WHchEF+DY8F+5DV0gLww7oWdR7oel016jBq+CAt8oXz0u3qTFIKP0+iIRtLp8301XiVP4WpTDKyH5kBrk7vUqcNmaB7hESJ4uMQKdwyywXLEgnjoAfE352KNb7G9D+nr37ut0/cRnWkXK56F08XeTtCP1RaZqVA4k2bP3qQ9SAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069891; c=relaxed/simple;
	bh=+hM9oCycKPG2Im2P+cJRs2fmrNK6J8jyE9AeCDkvaTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMujzaiwUopXww8x6VyNoT2+gzu9SZyl7/ygbiHhQvl3vSj2aNrExJjwS0vxPTYIC05boIeQynpHcor8/QrHU/SQDV/us4+6ZlmAZxrGBSI0GbNcNty08q7b/ohQFBvw8RQjUD23V+2SRWSnta/fSc+FfzezxpVG/MW49zvasVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SgFKiUtD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AWrCp031703;
	Fri, 8 Nov 2024 07:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TwImk
	MgddOJq5AUfqyWJs3Vg3f7JD+1MRKYO0nkHslY=; b=SgFKiUtDy90fBBAiJyINu
	NKQb4GLLbYMcdmYlEA7LIYPwfXfTL1+r6EdTYxr290vKUjVSjhkUrOP5h0pVzY3L
	DrvSNqZyZSW/9Ic0K6G1UDSFzp2CNu/fMkMZdeDm6Hnxr3aQx2oVWu2+rheL4Vs9
	Gnjg6wnWnwvMl0kI6p3S/33Jp46NOhA/pAhLGRQKKWrJVKLQpNk3Qwd6rlJCJ7/0
	+qMsV0xtv27SaDIq4/SWcRTxDSN81Bzz5aGNVFbNrrB1ryDTcxpxSb8+tdE/t0oM
	aCluwB05M6t5GHiQfgMBB0GNqzYi/Jy0M3oQ8YneTPmtb7e0XZWvT1Q9wRCwFyLS
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42s6jd363q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 07:44:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A8CiZ7Q020350
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 07:44:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 8 Nov 2024
 07:44:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Nov 2024 07:44:35 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A8CiNcY003412;
	Fri, 8 Nov 2024 07:44:31 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>,
        <alexandru.tachici@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <darius.berghe@analog.com>
Subject: [PATCH v3 1/3] iio: imu: adis16480: add devices to adis16480 driver
Date: Fri, 8 Nov 2024 14:58:12 +0200
Message-ID: <20241108125814.3097213-2-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108125814.3097213-1-darius.berghe@analog.com>
References: <20241108125814.3097213-1-darius.berghe@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TgHj85ePiDPIy4mYN0ZeXtXOeWFmjzIh
X-Proofpoint-GUID: TgHj85ePiDPIy4mYN0ZeXtXOeWFmjzIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080106

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
index 294181f2fcb3..569a03598952 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -878,11 +878,32 @@ static const struct iio_chan_spec adis16545_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(17),
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
 enum adis16480_variant {
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
@@ -1038,6 +1059,38 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
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
@@ -1054,6 +1107,22 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
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
@@ -1741,7 +1810,10 @@ static const struct spi_device_id adis16480_ids[] = {
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
@@ -1763,7 +1835,10 @@ static const struct of_device_id adis16480_of_match[] = {
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


