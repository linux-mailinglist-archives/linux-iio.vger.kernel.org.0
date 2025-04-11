Return-Path: <linux-iio+bounces-17965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A2A86289
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9A64E08BB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41E221D3EE;
	Fri, 11 Apr 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Nxx+sw5Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88CB21ABBA;
	Fri, 11 Apr 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387100; cv=none; b=MhYHyXbBBS/5yzT32rRGpXQgCoekKJp9U4D8UzuUFx9cuqf1kjrkim0ypdJnMNfaJepsxySyBcJGNSDXCBiKmmU7OkclGqfwSE2QqhOuzoet32fjAimrTeADakoPGOvOV1pO1XhULgbqs/wWFDgnSBWS6gf8U231OM59pQr/Ju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387100; c=relaxed/simple;
	bh=o9lAcDux9AoWMcVTY0+mZlPRtg6tqToNLxKzfnXtaEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqlfNZtlsVocjjPJH9qLJH5xv1PABqR/1unHdA8hOZfPZgnGHgQ+8qmfwWQzrvisNuXDytgSbG8t2kVoeL6O9ZZBf5AvHpQ1dcy4hdT7qvemCJPIMNVJvEKslvX0nAqtXoHjQpZMykiFadsoWL11OjKep5Ycy+01YQtAv7Fsrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Nxx+sw5Q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BF48Fc001758;
	Fri, 11 Apr 2025 11:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GSYOx
	Xt0BgQHbFHmQxTYzOEIlxzvUVyXnmnqX4MEanc=; b=Nxx+sw5QElSLPwaxojgjL
	24UK1yzJ2nGsg4WFvcN+T29wtyKCB40HMju48ZLSflK3hA/h068jCD3hI8ZrY6Kg
	e+PjXWcVkCIGgJAMplISzk+Meg3iuJDTl9i+HVZGgZRG0nSSLMFvEmpl0CYYdwSP
	GC9hSMZu7YH0rCe2h6dUAPfhTzYnr7l3Ag3sAENEg2Xy84aw4YNjt1FrggFKk1pN
	psyefJvA5bPWzdP9jdPhtMUURrfhmIPQhGBeQ9LE+r+p9AXgLfUN42rcYVivYVfn
	7dP2+Saij4iYZ+alU3qTRoJxmVWVTCmyoZTfB+vbgore6RE8tNr3ZPPQ8CR5ener
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp16yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:58:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFw1en022323
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:58:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:58:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:58:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:58:01 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFvgBw015631;
	Fri, 11 Apr 2025 11:57:45 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v5 08/14] iio: adc: ad7768-1: add regulator to control VCM output
Date: Fri, 11 Apr 2025 12:57:42 -0300
Message-ID: <7753dcd690f07f855100fc28e7b8ae746082de1c.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: EzHR_j1qD6dz6pORbgUK6DxnNK0UHdzX
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f93c0a cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=JVNCGbOEr6ZHtlgbtb4A:9
X-Proofpoint-GUID: EzHR_j1qD6dz6pORbgUK6DxnNK0UHdzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

The VCM output voltage can be used as a common-mode voltage within the
amplifier preconditioning circuits external to the AD7768-1.

This change allows the user to configure VCM output using the regulator
framework.

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v5 Changes:
* enforce AD7768_REG_ANALOG2_VCM macro argument evaluation.
* switched to the new iio_device_claim/release_direct() functions.

v4 Changes:
* Added iio_device_claim_direct_mode() to regulator callbacks to avoid register access
  while in buffered mode.
* Changed regulator name to "ad7768-1-vcm".
* When regulator enable is called, it will set the last voltage selector configured.
* Disabled regulator before configuring it.
* Adressed other nits.

v3 Changes:
* Register VCM output via the regulator framework for improved flexibility
  and external integration.

v2 Changes:
* VCM output support is now defined by a devicetree property, instead of 
  and IIO attribute.
---
 drivers/iio/adc/Kconfig    |   1 +
 drivers/iio/adc/ad7768-1.c | 176 +++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index da3463a1d0bc..f1600a0fa5f2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -322,6 +322,7 @@ config AD7766
 config AD7768_1
 	tristate "Analog Devices AD7768-1 ADC driver"
 	depends on SPI
+	select REGULATOR
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGER
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 66087fabe181..13d17a13b6ea 100644
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
 
@@ -80,6 +82,12 @@
 #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
 #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
 
+/* AD7768_REG_ANALOG2 */
+#define AD7768_REG_ANALOG2_VCM_MSK	GENMASK(2, 0)
+#define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, (x))
+
+#define AD7768_VCM_OFF			0x07
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -157,6 +165,8 @@ struct ad7768_state {
 	struct regmap *regmap;
 	struct regmap *regmap24;
 	struct regulator *vref;
+	struct regulator_dev *vcm_rdev;
+	unsigned int vcm_output_sel;
 	struct clk *mclk;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
@@ -644,6 +654,167 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
 					       &ad7768_buffer_ops);
 }
 
+static int ad7768_vcm_enable(struct regulator_dev *rdev)
+{
+	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret, regval;
+
+	if (!indio_dev)
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	/* To enable, set the last selected output */
+	regval = AD7768_REG_ANALOG2_VCM(st->vcm_output_sel + 1);
+	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+				 AD7768_REG_ANALOG2_VCM_MSK, regval);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad7768_vcm_disable(struct regulator_dev *rdev)
+{
+	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!indio_dev)
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+				 AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
+{
+	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret, val;
+
+	if (!indio_dev)
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
+	if (ret)
+		goto err_release;
+
+	ret = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) != AD7768_VCM_OFF;
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad7768_set_voltage_sel(struct regulator_dev *rdev,
+				  unsigned int selector)
+{
+	unsigned int regval = AD7768_REG_ANALOG2_VCM(selector + 1);
+	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!indio_dev)
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+				 AD7768_REG_ANALOG2_VCM_MSK, regval);
+	iio_device_release_direct(indio_dev);
+	st->vcm_output_sel = selector;
+
+	return ret;
+}
+
+static int ad7768_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret, val;
+
+	if (!indio_dev)
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
+	if (ret)
+		goto err_release;
+
+	val = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val);
+	ret = clamp(val, 1, (int)rdev->desc->n_voltages) - 1;
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
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
+	.name = "ad7768-1-vcm",
+	.of_match = of_match_ptr("vcm-output"),
+	.regulators_node = of_match_ptr("regulators"),
+	.n_voltages = ARRAY_SIZE(vcm_voltage_table),
+	.volt_table = vcm_voltage_table,
+	.ops = &vcm_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int ad7768_register_regulators(struct device *dev, struct ad7768_state *st,
+				      struct iio_dev *indio_dev)
+{
+	struct regulator_config config = {
+		.dev = dev,
+		.driver_data = indio_dev,
+	};
+	int ret;
+
+	/* Disable the regulator before registering it */
+	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+				 AD7768_REG_ANALOG2_VCM_MSK, AD7768_VCM_OFF);
+	if (ret)
+		return -EINVAL;
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
@@ -708,6 +879,11 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	/* Register VCM output regulator */
+	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = ad7768_setup(st);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
-- 
2.34.1


