Return-Path: <linux-iio+bounces-15468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF6A32E6F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F98188B7FA
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3604262812;
	Wed, 12 Feb 2025 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LOZ8OZVg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E15263C77;
	Wed, 12 Feb 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384307; cv=none; b=B4qrs8GMFbDsaCWgz9V13/ZGHAmDviylHjpcolGce+Zy/GzjaUCDpv6g3A+2cueYdiHanOV1kTD9cTkIEcWeJ7x1wShAxsE3M9wmnH92kNXU+5R4wRmbRjaA3HwDl1Bm2RMeouuaw4/2OFgNqzKtU/MPraHCftCI6pFhybiNyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384307; c=relaxed/simple;
	bh=MuGV4IhtOfAJ9RA9UOzLzJdpzJsnSkEe6UX0H6I0L9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwv5W4+Nt2uzXaIxB1HV6RR9i+4u+KAs2N+Ma4DUHZFO/RnCqCxikk/mOCP/zd3njuVB08/tM8Kbx6EEJcYjhOTYOQi8VEnzTdgGOAtZVaQDnrHgzK8N3Bp5aQUCa4n/zHfk+UPRQwtDDz5hr95TfurTAJt0ertcVyoyyY06omA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LOZ8OZVg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFqqcv023425;
	Wed, 12 Feb 2025 13:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PSTd9
	5JftdHqSKf7z6QNKXm9ItWs9qslhTF0XNoU9OY=; b=LOZ8OZVgnJE8AjcykW2Lb
	TijKY1o02iYm0whNpIlQZ5AxI+IUmbO9WQC96SYcNj9kjTSGQZIZrXMTl5LaDyNW
	VMwcDOPguq4EWcHi20vOLLYIc/i00MvczzCsnrcQWbEi7N0qfalCLqkPhAiORwy4
	rPKdXPh2mCX33gwteEraY8ZyoLypJ1QtkB1VE7s0zkVz62svFhR6uw8BGjcaYTWp
	YxaX57vtc2h7ara46lOaWGIscZFVFhot12VsREChtr97ecXcB03cDVe9JkLRXhjC
	aZcDENLTv/aVpNMRl7SPIptpBeKL39hU9Siy2+eIrvitavYW34GIe1PfgLjmadbN
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44rnspk2sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:18:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51CIIAF4046531
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:18:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Feb
 2025 13:18:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:18:10 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIHspc017494;
	Wed, 12 Feb 2025 13:17:56 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 11/17] iio: adc: ad7768-1: add regulator to control VCM output
Date: Wed, 12 Feb 2025 15:17:54 -0300
Message-ID: <3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RZxqC0tv c=1 sm=1 tr=0 ts=67ace5e3 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=G_ErP6J3UNgZdrWCQQ8A:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: JsDYr-mSoXuC6zqCVnheMfii7qXaGDDo
X-Proofpoint-ORIG-GUID: JsDYr-mSoXuC6zqCVnheMfii7qXaGDDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

The VCM output voltage can be used as a common-mode voltage within the
amplifier preconditioning circuits external to the AD7768-1.

This change allows the user to configure VCM output using the regulator
framework.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Register VCM output via the regulator framework for improved flexibility
  and external integration.

v2 Changes:
* VCM output support is now defined by a devicetree property, instead of 
  and IIO attribute.
---
 drivers/iio/adc/ad7768-1.c | 138 +++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 378245bce199..a359cd8fceca 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -12,8 +12,10 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 
@@ -80,9 +82,15 @@
 #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
 #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
 
+/* AD7768_REG_ANALOG2 */
+#define AD7768_REG_ANALOG2_VCM_MSK	GENMASK(2, 0)
+#define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, x)
+
 #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
 #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
 
+#define AD7768_VCM_OFF			0x08
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -160,6 +168,7 @@ struct ad7768_state {
 	struct regmap *regmap;
 	struct regmap *regmap24;
 	struct regulator *vref;
+	struct regulator_dev *vcm_rdev;
 	struct clk *mclk;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
@@ -643,6 +652,130 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
 					       &ad7768_buffer_ops);
 }
 
+static int ad7768_vcm_enable(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret, val;
+
+	if (!st)
+		return -EINVAL;
+
+	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
+	if (ret)
+		return ret;
+
+	/* if regulator is off, turn it on */
+	if (FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) == AD7768_VCM_OFF)
+		return regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+					  AD7768_REG_ANALOG2_VCM_MSK, 0x00);
+
+	return 0;
+}
+
+static int ad7768_vcm_disable(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+
+	if (!st)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+				  AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
+}
+
+static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret, val;
+
+	if (!st)
+		return -EINVAL;
+
+	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) == AD7768_VCM_OFF)
+		return 0;
+
+	return 1;
+}
+
+static int ad7768_set_voltage_sel(struct regulator_dev *rdev,
+				  unsigned int selector)
+{
+	unsigned int regval = AD7768_REG_ANALOG2_VCM(selector + 1);
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+
+	if (!st)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+				  AD7768_REG_ANALOG2_VCM_MSK, regval);
+}
+
+static int ad7768_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret, val;
+
+	if (!st)
+		return -EINVAL;
+
+	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) - 1;
+	val = clamp(val, 0, 8);
+
+	return val;
+}
+
+static const struct regulator_ops vcm_regulator_ops = {
+	.enable = ad7768_vcm_enable,
+	.disable = ad7768_vcm_disable,
+	.is_enabled = ad7768_vcm_is_enabled,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = ad7768_set_voltage_sel,
+	.get_voltage_sel = ad7768_get_voltage_sel,
+};
+
+static const unsigned int vcm_voltage_table[] = {
+	2500000,
+	2050000,
+	1650000,
+	1900000,
+	1100000,
+	900000,
+};
+
+static const struct regulator_desc vcm_desc = {
+	.name = "vcm_output",
+	.of_match = of_match_ptr("vcm_output"),
+	.regulators_node = of_match_ptr("regulators"),
+	.n_voltages = ARRAY_SIZE(vcm_voltage_table),
+	.volt_table = vcm_voltage_table,
+	.ops = &vcm_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int ad7768_register_regulators(struct device *dev, struct ad7768_state *st)
+{
+	struct regulator_config config = {
+		.dev = dev,
+		.driver_data = st,
+	};
+
+	st->vcm_rdev = devm_regulator_register(dev, &vcm_desc, &config);
+	if (IS_ERR(st->vcm_rdev))
+		return dev_err_probe(dev, PTR_ERR(st->vcm_rdev),
+				     "failed to register VCM regulator\n");
+
+	return 0;
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -707,6 +840,11 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	/* Register VCM output regulator */
+	ret = ad7768_register_regulators(&spi->dev, st);
+	if (ret)
+		return ret;
+
 	ret = ad7768_setup(st);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
-- 
2.34.1


