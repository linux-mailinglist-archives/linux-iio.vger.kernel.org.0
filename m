Return-Path: <linux-iio+bounces-25912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D18C35AEB
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D95F562279
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4623148A4;
	Wed,  5 Nov 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oqgzt5c9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DB2641FB;
	Wed,  5 Nov 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346454; cv=none; b=bHv9zTH/IovmQLh8af3VQYfnpuznO/62AWj0pyTPi02Gt1BuaIzqLlJhhCc/OobPqHfEP066TlgTXHER+kTZvACXjrp3fz7BVDI8Szdbus3q73DIbTWHkO6yP4Sa7G5ve982e4QhU4e8MiLbWVlw7f/RDDvfBx1A8i8+wpQHFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346454; c=relaxed/simple;
	bh=yBGn2o6SAOiEdTu/kjX7xZ/z5cxzY/oVSmghtPn0zao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNKp2oRcNGD+1BZJAbd7J8et4ndB951EDqgzJhHSa/AlX5S8lmQ53ufiAqh7KR2rnOPp0k2SCmXFdTiNLo7PCffVdrNfmqiOYrVTayrMN6mc6hFN0iVKvdIpkXMROfRjnN4Z5Q/fVrqvWB9WTS1VC5xdgxJF1okuq5Bpqzf3qW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oqgzt5c9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5ANhWU1904284;
	Wed, 5 Nov 2025 07:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zVQqw
	YjdtzNE74BGbD/C1sxPnGIyaaBrjtZrNoei9J0=; b=oqgzt5c9vlTmM4kWfJZUZ
	ejOgR5ygzSG1mL2QYzL7uLF2eHnjQFuLF+0f9SIfSY61EDDzC9DNV+WWjwMhDxUw
	DwNtk3cZo9WNkiS9jU14g+dxc8NCr3RLgaerwXDhngisQaqDirZMkrFvkxQEw6Nv
	BOQ7ySRi+MeQo8qjndpdlMej2CglwDCS6nOiJLomADCMM6I3qHnAzDvRYX9XmgR4
	GPcaUNnFvAW/OA1ssmjdSJQy7cQLqHoxRwkwpfIRKH84ESDgNqMkghyU+E1D8kgS
	B7ux/r+rE3aGAZETLhswBIhXm9AXt+n8HNnQ67gcdYIs+0g0MFxnrWRW3h/dH58v
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4a7s763ws7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 07:40:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5A5CemcH044385
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Nov 2025 07:40:48 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 5 Nov
 2025 07:40:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:47 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5A5CeYo9007842;
	Wed, 5 Nov 2025 07:40:37 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <ramona.gradinariu@analog.com>,
        <antoniu.miclaus@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH 2/2] iio: accel: adxl380: add support for ADXL318 and ADXL319
Date: Wed, 5 Nov 2025 09:40:34 -0300
Message-ID: <7d990c72acca31b2fe6c7685fd13ef5284c7646f.1762281527.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2b8fc2ea006d06660c83f1e9e1ccfc865803dafb.1762281527.git.Jonathan.Santos@analog.com>
References: <2b8fc2ea006d06660c83f1e9e1ccfc865803dafb.1762281527.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vMJmfmMCb1t6JmCTE8wA7FLpKIEKTxnI
X-Authority-Analysis: v=2.4 cv=U8GfzOru c=1 sm=1 tr=0 ts=690b45d1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=IgsPIOQ7CyMxhxFOnYkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA5NSBTYWx0ZWRfX9C2obt0lS8hE
 nC6ktWafYyPr4y21UA82e0SaF+AUkEFGGStI+mQoL25QuLBS12nElS/RQreouZD+6gl3OB0SNh4
 bLCrU1csDpR1quPfO4TXQFNMXETJEDYWuvsuMoiimd7EmcnSCijtro5EH5uZqHZvgK9TVOaQiJL
 K6bIAWtne3HB0vlEp5TsyZtuY603a/09N+XfvjrW3R65cNrfiQ+aMrxeltyl7pPEtymZBTHeW/w
 u+dvOxkCjgY84YJ4JbujWbX0ZYfLMTe/uZ8prSE+YRVP5gIb1F31OWUpiqsmhQuigMS09oehGFk
 tNlRFCMCVXiUEdRfKD+fEHZ3HtLxNNiwfjDBSYFBy4K3My82YKN4tudijfvHAcaKSuaJq8lbAEb
 aMSHtQKWz3+9uHD7J1LTJnLIHdmHlQ==
X-Proofpoint-ORIG-GUID: vMJmfmMCb1t6JmCTE8wA7FLpKIEKTxnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050095

The ADXL318 and ADXL319 are low noise density, low power, 3-axis
accelerometers based on ADXL380 and ADXL382, respectively. The main
difference between the new parts and the existing ones are the absence
of interrupts and events like tap detection, activity/inactivity, and
free-fall detection.

Other differences in the new parts are fewer power modes, basically
allowing only idle and measurement modes, and the removal of the 12-bit
SAR ADC path for the 3-axis signals (known as lower signal chain),
being excluisive for the temperature sensor in the ADXL318/319.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/accel/adxl380.c     | 134 ++++++++++++++++++++++----------
 drivers/iio/accel/adxl380.h     |   4 +
 drivers/iio/accel/adxl380_i2c.c |   4 +
 drivers/iio/accel/adxl380_spi.c |   4 +
 4 files changed, 107 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 0cf3c6815829..7733a0902afa 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -27,6 +27,8 @@
 
 #define ADXL380_ID_VAL				380
 #define ADXL382_ID_VAL				382
+#define ADXL318_ID_VAL				380
+#define ADXL319_ID_VAL				382
 
 #define ADXL380_DEVID_AD_REG			0x00
 #define ADLX380_PART_ID_REG			0x02
@@ -178,41 +180,6 @@ enum adxl380_tap_time_type {
 
 static const int adxl380_range_scale_factor_tbl[] = { 1, 2, 4 };
 
-const struct adxl380_chip_info adxl380_chip_info = {
-	.name = "adxl380",
-	.chip_id = ADXL380_ID_VAL,
-	.scale_tbl = {
-		[ADXL380_OP_MODE_4G_RANGE] = { 0, 1307226 },
-		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
-		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
-	},
-	.samp_freq_tbl = { 8000, 16000, 32000 },
-	/*
-	 * The datasheet defines an intercept of 470 LSB at 25 degC
-	 * and a sensitivity of 10.2 LSB/C.
-	 */
-	.temp_offset =  25 * 102 / 10 - 470,
-
-};
-EXPORT_SYMBOL_NS_GPL(adxl380_chip_info, "IIO_ADXL380");
-
-const struct adxl380_chip_info adxl382_chip_info = {
-	.name = "adxl382",
-	.chip_id = ADXL382_ID_VAL,
-	.scale_tbl = {
-		[ADXL382_OP_MODE_15G_RANGE] = { 0, 4903325 },
-		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
-		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
-	},
-	.samp_freq_tbl = { 16000, 32000, 64000 },
-	/*
-	 * The datasheet defines an intercept of 570 LSB at 25 degC
-	 * and a sensitivity of 10.2 LSB/C.
-	 */
-	.temp_offset =  25 * 102 / 10 - 570,
-};
-EXPORT_SYMBOL_NS_GPL(adxl382_chip_info, "IIO_ADXL380");
-
 static const unsigned int adxl380_th_reg_high_addr[2] = {
 	[ADXL380_ACTIVITY] = ADXL380_THRESH_ACT_H_REG,
 	[ADXL380_INACTIVITY] = ADXL380_THRESH_INACT_H_REG,
@@ -276,9 +243,14 @@ static int adxl380_set_measure_en(struct adxl380_state *st, bool en)
 		if (ret)
 			return ret;
 
-		/* Activity/ Inactivity detection available only in VLP/ULP mode */
-		if (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
-		    FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl))
+		/*
+		 * Activity/Inactivity detection available only in VLP/ULP
+		 * mode and for devices that support low power modes. Otherwise
+		 * go straight to measure mode (same bits as ADXL380_OP_MODE_HP).
+		 */
+		if (st->chip_info->has_low_power &&
+		    (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
+		    FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl)))
 			op_mode = ADXL380_OP_MODE_VLP;
 		else
 			op_mode = ADXL380_OP_MODE_HP;
@@ -1632,6 +1604,90 @@ static const struct iio_info adxl380_info = {
 	.hwfifo_set_watermark = adxl380_set_watermark,
 };
 
+static const struct iio_info adxl318_info = {
+	.read_raw = adxl380_read_raw,
+	.read_avail = &adxl380_read_avail,
+	.write_raw = adxl380_write_raw,
+	.write_raw_get_fmt = adxl380_write_raw_get_fmt,
+	.debugfs_reg_access = &adxl380_reg_access,
+	.hwfifo_set_watermark = adxl380_set_watermark,
+};
+
+const struct adxl380_chip_info adxl380_chip_info = {
+	.name = "adxl380",
+	.chip_id = ADXL380_ID_VAL,
+	.scale_tbl = {
+		[ADXL380_OP_MODE_4G_RANGE] = { 0, 1307226 },
+		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
+		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
+	},
+	.samp_freq_tbl = { 8000, 16000, 32000 },
+	/*
+	 * The datasheet defines an intercept of 470 LSB at 25 degC
+	 * and a sensitivity of 10.2 LSB/C.
+	 */
+	.temp_offset =  25 * 102 / 10 - 470,
+	.has_low_power = true,
+	.info = &adxl380_info,
+
+};
+EXPORT_SYMBOL_NS_GPL(adxl380_chip_info, "IIO_ADXL380");
+
+const struct adxl380_chip_info adxl382_chip_info = {
+	.name = "adxl382",
+	.chip_id = ADXL382_ID_VAL,
+	.scale_tbl = {
+		[ADXL382_OP_MODE_15G_RANGE] = { 0, 4903325 },
+		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
+		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
+	},
+	.samp_freq_tbl = { 16000, 32000, 64000 },
+	/*
+	 * The datasheet defines an intercept of 570 LSB at 25 degC
+	 * and a sensitivity of 10.2 LSB/C.
+	 */
+	.temp_offset =  25 * 102 / 10 - 570,
+	.has_low_power = true,
+	.info = &adxl380_info,
+};
+EXPORT_SYMBOL_NS_GPL(adxl382_chip_info, "IIO_ADXL380");
+
+const struct adxl380_chip_info adxl318_chip_info = {
+	.name = "adxl318",
+	.chip_id = ADXL318_ID_VAL,
+	.scale_tbl = {
+		[ADXL380_OP_MODE_4G_RANGE] = { 0, 1307226 },
+		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
+		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
+	},
+	.samp_freq_tbl = { 8000, 16000, 32000 },
+	/*
+	 * The datasheet defines an intercept of 550 LSB at 25 degC
+	 * and a sensitivity of 10.2 LSB/C.
+	 */
+	.temp_offset =  25 * 102 / 10 - 550,
+	.info = &adxl318_info,
+};
+EXPORT_SYMBOL_NS_GPL(adxl318_chip_info, "IIO_ADXL380");
+
+const struct adxl380_chip_info adxl319_chip_info = {
+	.name = "adxl319",
+	.chip_id = ADXL319_ID_VAL,
+	.scale_tbl = {
+		[ADXL382_OP_MODE_15G_RANGE] = { 0, 4903325 },
+		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
+		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
+	},
+	.samp_freq_tbl = { 16000, 32000, 64000 },
+	/*
+	 * The datasheet defines an intercept of 550 LSB at 25 degC
+	 * and a sensitivity of 10.2 LSB/C.
+	 */
+	.temp_offset =  25 * 102 / 10 - 550,
+	.info = &adxl318_info,
+};
+EXPORT_SYMBOL_NS_GPL(adxl319_chip_info, "IIO_ADXL380");
+
 static const struct iio_event_spec adxl380_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -1866,7 +1922,7 @@ int adxl380_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = adxl380_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl380_channels);
 	indio_dev->name = chip_info->name;
-	indio_dev->info = &adxl380_info;
+	indio_dev->info = chip_info->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_regulator_get_enable(dev, "vddio");
diff --git a/drivers/iio/accel/adxl380.h b/drivers/iio/accel/adxl380.h
index a683625d897a..5d88c111d616 100644
--- a/drivers/iio/accel/adxl380.h
+++ b/drivers/iio/accel/adxl380.h
@@ -14,10 +14,14 @@ struct adxl380_chip_info {
 	const int samp_freq_tbl[3];
 	const int temp_offset;
 	const u16 chip_id;
+	const struct iio_info *info;
+	const bool has_low_power;
 };
 
 extern const struct adxl380_chip_info adxl380_chip_info;
 extern const struct adxl380_chip_info adxl382_chip_info;
+extern const struct adxl380_chip_info adxl318_chip_info;
+extern const struct adxl380_chip_info adxl319_chip_info;
 
 int adxl380_probe(struct device *dev, struct regmap *regmap,
 		  const struct adxl380_chip_info *chip_info);
diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_i2c.c
index b4f86f972361..1851bef0b0d3 100644
--- a/drivers/iio/accel/adxl380_i2c.c
+++ b/drivers/iio/accel/adxl380_i2c.c
@@ -35,6 +35,8 @@ static int adxl380_i2c_probe(struct i2c_client *client)
 static const struct i2c_device_id adxl380_i2c_id[] = {
 	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
 	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
+	{ "adxl318", (kernel_ulong_t)&adxl318_chip_info },
+	{ "adxl319", (kernel_ulong_t)&adxl319_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
@@ -42,6 +44,8 @@ MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
 static const struct of_device_id adxl380_of_match[] = {
 	{ .compatible = "adi,adxl380", .data = &adxl380_chip_info },
 	{ .compatible = "adi,adxl382", .data = &adxl382_chip_info },
+	{ .compatible = "adi,adxl318", .data = &adxl318_chip_info },
+	{ .compatible = "adi,adxl319", .data = &adxl319_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl380_of_match);
diff --git a/drivers/iio/accel/adxl380_spi.c b/drivers/iio/accel/adxl380_spi.c
index 6edd0d211ffa..9076890bbb5f 100644
--- a/drivers/iio/accel/adxl380_spi.c
+++ b/drivers/iio/accel/adxl380_spi.c
@@ -37,6 +37,8 @@ static int adxl380_spi_probe(struct spi_device *spi)
 static const struct spi_device_id adxl380_spi_id[] = {
 	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
 	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
+	{ "adxl318", (kernel_ulong_t)&adxl318_chip_info },
+	{ "adxl319", (kernel_ulong_t)&adxl319_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl380_spi_id);
@@ -44,6 +46,8 @@ MODULE_DEVICE_TABLE(spi, adxl380_spi_id);
 static const struct of_device_id adxl380_of_match[] = {
 	{ .compatible = "adi,adxl380", .data = &adxl380_chip_info },
 	{ .compatible = "adi,adxl382", .data = &adxl382_chip_info },
+	{ .compatible = "adi,adxl318", .data = &adxl318_chip_info },
+	{ .compatible = "adi,adxl319", .data = &adxl319_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl380_of_match);
-- 
2.34.1


