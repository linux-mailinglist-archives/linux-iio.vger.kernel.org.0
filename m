Return-Path: <linux-iio+bounces-20220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49DACE4F4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A498C3A13E5
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67991213E90;
	Wed,  4 Jun 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ul3TE1Xi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687951714C6;
	Wed,  4 Jun 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065815; cv=none; b=o9I9mR/P+b5AIJLmMZ5Cm87NodAwM35goTNDCvI8VeIll7xdoMH/qv7o6fYgKQcw1b3ePWMaVNXxLQl/DuTUfc2zkqu5mve8nKYp2MxAqA3s9wrWuUxm5+A4ilm+6/lsaz9o2QkFooGbmtmHdLmLRCyyOpteJ1IFfLDH9ICbx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065815; c=relaxed/simple;
	bh=MamPwV9PP4ioCACVe68Gh53byvhXNjH7uE6NAkR04kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avzJTCF+6Ohw3cbBtkcs/9dTEipQPgqDoJnRyBD0g7tYwV9fTNtF7iDolDBOygznw+ZvaSfrUrlbm4Nr6Nmd9ih5Uodvu9mvO8VHA/UwvzLNHyobgZgA0wJDT+AlkDGSBqoEwl0qddi+gtQVPswTwRb3bVYoZxZXxfeDQyQrCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ul3TE1Xi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554ImETC028924;
	Wed, 4 Jun 2025 15:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FVwUI
	yObjHyL8p0strjqEUl0LvuBLiJCmmFf3Jeo2q8=; b=Ul3TE1XinSGG6+SzJFjyC
	5hcR8ULIvPVXwn0yG4PUPUzyBK8gHRLG3nFZ24Lkud8u4rRNbha76sOpSyc1pZk7
	Q/Tsk/MCpZVu4EXVmLsHJXnISaOPjYBf6X3X70QaqtiBuCfTGxKh81ml9huyDiNN
	uiTzxAHrE+iaZmaSck/x1jQE6VmW120dOzw7E3IS2Tmy6ZlrsPGMXO9pwUydHIEn
	VKPUSfmN2KvS8NwDrK5N9RkpQz6WGuQJ9l3GkMRA/8i9ox1goQif/2BVs7QEgf5n
	8EC0EcYrGvVpXwf0uM4w0geIr2MRuQDSAy9ExUWmZUNUIaO3+j9GZmBXoU3oeRop
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 471g9j42en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:36:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554JajuB053771
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:36:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:36:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:36:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:36:45 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JaVk7014328;
	Wed, 4 Jun 2025 15:36:33 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v10 06/12] iio: adc: ad7768-1: add regulator to control VCM output
Date: Wed, 4 Jun 2025 16:36:29 -0300
Message-ID: <008390cf0a63645d9e0cc85b4256e2e35433940d.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 61S3vi4_y12Y9eB9y4nLo-xrD5_ZvscJ
X-Authority-Analysis: v=2.4 cv=DfIXqutW c=1 sm=1 tr=0 ts=6840a04f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=lA8crIeKp1-K9khhi1AA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 61S3vi4_y12Y9eB9y4nLo-xrD5_ZvscJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfX+RoFV/EAPcPY
 /vIwow0fxM/SC5jnqjdn1iGVSmY9IrPbUKxT5183T1c6SLQFcCcyeomad1hPmK1pgiSKvNhj9OP
 umbBXD4k6BxoNumSUiZ7K2vecJ88Q0KZRf+u7F166WVMHNuUTNhfQqJ96gG/89GWIn0sc7nGR9h
 8eXLbN4MFC8BbMPhh8N1hxzatn6ZmiL9jVB39VjWuy7PmmPCzptZcaCqdha14jLkbEVEqBWnuIN
 elTj3mtEXrk8JxaxMqz2HpgLMK6t6HB3iCnKcvpJsIx6OsQF7fLFmKeOTixzT9h1GGeEtSDVE32
 o+oxPvq9c1/d06YVspDFXfBpqTVAjsW38z8ED5N6A9NiAh9MV4TAEo5P7o2kbpYCSbnyZH16gsP
 4jidri25FWzNooN/DEalxy4h9rYKiHR+TGjgTaI8SX6CuucEvuUD2NQ9LFLTY2ghY1nFN3or
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=6 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040155

The VCM output voltage can be used as a common-mode voltage within the
amplifier preconditioning circuits external to the AD7768-1.

This change allows the user to configure VCM output using the regulator
framework.

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v10 Changes:
* None.

v9 Changes:
* None.

v8 Changes:
* None.

v7 Changes:
* removed dead code.
* removed of.h header.
* removed explicit casting in the clamp function.

v6 Changes:
* Rearranged iio_device_release_direct() calls to avoid
 some gotos.
* removed of_match_ptr() from regulator_desc.
* Addressed other nits.

v5 Changes:
* enforce AD7768_REG_ANALOG2_VCM macro argument evaluation.
* switched to the new iio_device_claim/release_direct() functions.

v4 Changes:
* Added iio_device_claim_direct_mode() to regulator callbacks to avoid register access
  while in buffered mode.
* Changed regulator name to "ad7768-1-vcm".
* When regulator enable is called, it will set the last voltage selector configured.
* Disabled regulator before configuring it.
* Addressed other nits.

v3 Changes:
* Register VCM output via the regulator framework for improved flexibility
  and external integration.

v2 Changes:
* VCM output support is now defined by a devicetree property, instead of 
  and IIO attribute.
---
 drivers/iio/adc/Kconfig    |   1 +
 drivers/iio/adc/ad7768-1.c | 159 +++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3bd03df9a976..c68918fb4cfe 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -344,6 +344,7 @@ config AD7766
 config AD7768_1
 	tristate "Analog Devices AD7768-1 ADC driver"
 	depends on SPI
+	select REGULATOR
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGER
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 8b414a102864..68f876e5d31c 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -13,9 +13,11 @@
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 
@@ -82,6 +84,12 @@
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
@@ -159,6 +167,8 @@ struct ad7768_state {
 	struct regmap *regmap;
 	struct regmap *regmap24;
 	struct regulator *vref;
+	struct regulator_dev *vcm_rdev;
+	unsigned int vcm_output_sel;
 	struct clk *mclk;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
@@ -662,6 +672,150 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
 					       &ad7768_buffer_ops);
 }
 
+static int ad7768_vcm_enable(struct regulator_dev *rdev)
+{
+	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret, regval;
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
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
+	iio_device_release_direct(indio_dev);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val) != AD7768_VCM_OFF;
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
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_update_bits(st->regmap, AD7768_REG_ANALOG2,
+				 AD7768_REG_ANALOG2_VCM_MSK, regval);
+	iio_device_release_direct(indio_dev);
+	if (ret)
+		return ret;
+
+	st->vcm_output_sel = selector;
+
+	return 0;
+}
+
+static int ad7768_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct iio_dev *indio_dev = rdev_get_drvdata(rdev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret, val;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD7768_REG_ANALOG2, &val);
+	iio_device_release_direct(indio_dev);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD7768_REG_ANALOG2_VCM_MSK, val);
+
+	return clamp(val, 1, rdev->desc->n_voltages) - 1;
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
+	.of_match = "vcm-output",
+	.regulators_node = "regulators",
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
+		return ret;
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
@@ -726,6 +880,11 @@ static int ad7768_probe(struct spi_device *spi)
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


