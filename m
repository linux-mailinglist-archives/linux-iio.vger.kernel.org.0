Return-Path: <linux-iio+bounces-26231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E1C5F7CA
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 23:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEED835E758
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6AE3451AB;
	Fri, 14 Nov 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x79ID1Q7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640430DD21;
	Fri, 14 Nov 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158467; cv=none; b=Fp1wEUKAJF4FmTZXukqgoYx2sw2SpBghJbSD/p3pUy6CCNpIVy4V3tZmpvO9ddHNF5G37Q1tEk4JOZV4KR/gUS75hO2BFEvhP1VkuhP68/XDVZ8ios01mi5Qqq1Q5JaEMavi4GsFqW0GY0A6ycFmQO6Rt6kmzzDolMxCCSQsmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158467; c=relaxed/simple;
	bh=4b7KoQzePjKkzLh1qdBljbeKVRp4bcbbeAwKjldO+XI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J84UjZeRrnyturDnuk4eSbyEh1/MyDBD0idU7YvCKjb2hE7r+vKG58UsDfgz7ecH2iS4Me+syPy9rIVJ4Qcjo36F4aoUJUGqRcNs+m3dVfyXLKv2INvRTOHAa0IAetuoWF2hSg107tpHCfi8Da7BD0BJy5tQfJWLyw6YLkFte6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x79ID1Q7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEKUmpZ3284220;
	Fri, 14 Nov 2025 17:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LS10h
	r9DehV95HTlL43FzIGHIptI90LuJhinPd8ThxQ=; b=x79ID1Q78qGG7zHn+KcGZ
	KfNXxuy0JCHqre541KMFUEyqLR6ECSqnau6yCNsZqe1/ZAo5VueEYrkSso3iByFl
	WJ/01NYAHyuyeagZfApnpRQLVr1BHHLRxFz7X9fUQhthG2Y4ezgoZyIQiB/vPPTF
	7nIl8IFf0Db1mr5gDQMuRQZtIh/QugCcWaRE0J6PHKHEgzcI/TjqF4MEWaYT5aW7
	S74WlkdQ4EH6xrxmzho/glREGAsD3NoJp/tEy7MVHcK/A8cwqWcCYAyHD1LCtMMD
	9S02kKPILMvlxAzlMRpvgv1kM5cJj82V1lKBeqyOwhDyRKDh6ZiFuJ0k+FU8dQuw
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4adr7uwter-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 17:14:18 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AEMEFNl005546
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 17:14:15 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 14 Nov
 2025 17:14:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 17:14:15 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEME3bA030870;
	Fri, 14 Nov 2025 17:14:05 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <ramona.gradinariu@analog.com>,
        <antoniu.miclaus@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v2 2/2] iio: accel: adxl380: add support for ADXL318 and ADXL319
Date: Fri, 14 Nov 2025 19:14:02 -0300
Message-ID: <94f1c01bdaea81a1a5f14df6aa95bc2b209165e9.1763134751.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <27fdb3b85015d29c01b804e7f1de5fa615cf9f5f.1763134751.git.Jonathan.Santos@analog.com>
References: <27fdb3b85015d29c01b804e7f1de5fa615cf9f5f.1763134751.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: aIwLpj0CCzQMBqTBapvChXXOMBHQIADs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDE4MSBTYWx0ZWRfXz3/uOPELy/AB
 7eVkZ+E8JikW9B4xVMaoIzZMZMobO8Dly16Wz/WDV9H1z1w8Tazu74cDnkxj2++JsNRrTHSt5s/
 isKyJgvAxRqC3Us1p8B0POJkgCY75RW/7qG7XWZjvFmZF/oN1tOEWid9ZQ7iGnRyXmn0DW0vc/G
 ewY/3ml9vCo2sMFQYe8jNZ0LOYBC/bNhzE6aNK0LjuzKtQpPO8wU4RBZy/rg53FLC1g1uk07Lkk
 ssDxM9dNzp78GcDTj1wl0HVxa7z8v2LeOB2DgJ4Ps8mvLBTbp8+Ryf7OFf+Kwx0q32okI40Gmkv
 eGY6eMaun+9h3VAVPxnxRfANlxAMPPA3XznRpptFdXACfOloQZCKYI+UfIIbBDBGp9hChvXc1X4
 ELJFa6tr05+iSNlFxhysVFZ47UYEMQ==
X-Proofpoint-ORIG-GUID: aIwLpj0CCzQMBqTBapvChXXOMBHQIADs
X-Authority-Analysis: v=2.4 cv=NLTYOk6g c=1 sm=1 tr=0 ts=6917a9ba cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=IgsPIOQ7CyMxhxFOnYkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140181

The ADXL318 and ADXL319 are low noise density, low power, 3-axis
accelerometers based on ADXL380 and ADXL382, respectively. The main
difference between the new parts and the existing ones are the absence
of interrupts and events like tap detection, activity/inactivity, and
free-fall detection.

Other differences in the new parts are fewer power modes, basically
allowing only idle and measurement modes, and the removal of the 12-bit
SAR ADC path for the 3-axis signals (known as lower signal chain),
being excluisive for the temperature sensor in the ADXL318/319.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
- resorted the new parts references by numerical order
- Rearranged the new elements in adxl380_chip_info struct using pahole
  to improve memory alignment.
---
 drivers/iio/accel/adxl380.c     | 134 ++++++++++++++++++++++----------
 drivers/iio/accel/adxl380.h     |   4 +
 drivers/iio/accel/adxl380_i2c.c |   4 +
 drivers/iio/accel/adxl380_spi.c |   4 +
 4 files changed, 107 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 0cf3c6815829..4f6b33a8a34a 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -26,7 +26,9 @@
 #include "adxl380.h"
 
 #define ADXL380_ID_VAL				380
+#define ADXL318_ID_VAL				380
 #define ADXL382_ID_VAL				382
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
@@ -1618,6 +1590,15 @@ static int adxl380_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	return 0;
 }
 
+static const struct iio_info adxl318_info = {
+	.read_raw = adxl380_read_raw,
+	.read_avail = &adxl380_read_avail,
+	.write_raw = adxl380_write_raw,
+	.write_raw_get_fmt = adxl380_write_raw_get_fmt,
+	.debugfs_reg_access = &adxl380_reg_access,
+	.hwfifo_set_watermark = adxl380_set_watermark,
+};
+
 static const struct iio_info adxl380_info = {
 	.read_raw = adxl380_read_raw,
 	.read_avail = &adxl380_read_avail,
@@ -1632,6 +1613,81 @@ static const struct iio_info adxl380_info = {
 	.hwfifo_set_watermark = adxl380_set_watermark,
 };
 
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
index a683625d897a..e67c5aab8efc 100644
--- a/drivers/iio/accel/adxl380.h
+++ b/drivers/iio/accel/adxl380.h
@@ -12,10 +12,14 @@ struct adxl380_chip_info {
 	const char *name;
 	const int scale_tbl[3][2];
 	const int samp_freq_tbl[3];
+	const struct iio_info *info;
 	const int temp_offset;
 	const u16 chip_id;
+	const bool has_low_power;
 };
 
+extern const struct adxl380_chip_info adxl318_chip_info;
+extern const struct adxl380_chip_info adxl319_chip_info;
 extern const struct adxl380_chip_info adxl380_chip_info;
 extern const struct adxl380_chip_info adxl382_chip_info;
 
diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_i2c.c
index b4f86f972361..bd8782d08c7d 100644
--- a/drivers/iio/accel/adxl380_i2c.c
+++ b/drivers/iio/accel/adxl380_i2c.c
@@ -33,6 +33,8 @@ static int adxl380_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl380_i2c_id[] = {
+	{ "adxl318", (kernel_ulong_t)&adxl318_chip_info },
+	{ "adxl319", (kernel_ulong_t)&adxl319_chip_info },
 	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
 	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
 	{ }
@@ -40,6 +42,8 @@ static const struct i2c_device_id adxl380_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
 
 static const struct of_device_id adxl380_of_match[] = {
+	{ .compatible = "adi,adxl318", .data = &adxl318_chip_info },
+	{ .compatible = "adi,adxl319", .data = &adxl319_chip_info },
 	{ .compatible = "adi,adxl380", .data = &adxl380_chip_info },
 	{ .compatible = "adi,adxl382", .data = &adxl382_chip_info },
 	{ }
diff --git a/drivers/iio/accel/adxl380_spi.c b/drivers/iio/accel/adxl380_spi.c
index 6edd0d211ffa..4ead949b24f1 100644
--- a/drivers/iio/accel/adxl380_spi.c
+++ b/drivers/iio/accel/adxl380_spi.c
@@ -35,6 +35,8 @@ static int adxl380_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adxl380_spi_id[] = {
+	{ "adxl318", (kernel_ulong_t)&adxl318_chip_info },
+	{ "adxl319", (kernel_ulong_t)&adxl319_chip_info },
 	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
 	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
 	{ }
@@ -42,6 +44,8 @@ static const struct spi_device_id adxl380_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, adxl380_spi_id);
 
 static const struct of_device_id adxl380_of_match[] = {
+	{ .compatible = "adi,adxl318", .data = &adxl318_chip_info },
+	{ .compatible = "adi,adxl319", .data = &adxl319_chip_info },
 	{ .compatible = "adi,adxl380", .data = &adxl380_chip_info },
 	{ .compatible = "adi,adxl382", .data = &adxl382_chip_info },
 	{ }
-- 
2.34.1


