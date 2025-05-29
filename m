Return-Path: <linux-iio+bounces-20024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390AAC8490
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D8E4E5685
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9422ACDC;
	Thu, 29 May 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="thbp7do7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44110221265;
	Thu, 29 May 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748559010; cv=none; b=jOPP1VCMr175owWaGNE4mEfdrm4TBY+U9UJTrIt+g8SfKEDZar/i60LYQxtUvuWN9wOh3lCWq2f41hq3PKt4K3oVkwYXGFSOyPPNB4MuIeeexLO15C9weLZ/X0CUStW9vKvNX+CW+A2TgZL+hITqqHW6AjGMrurb0YHPKlx6bvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748559010; c=relaxed/simple;
	bh=j4PNnmBGvCguvq79hsl4x09AVpJfuy4K0XjSS5AywL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlE6ryEG84ATVdyXFk3nn9asO7bsSlQYZS9kl8KeouWWTKwpR3DeoxOAd3oA70VGGiEh4ZXo5W+rHQCV5xQ0VSfw5/Wk7L8hewaG2ydAWbq3lWcf33v6YPJ/LROO9LVrqDxtkYz+sUkJ3dMbRXeCN2IMdaUhYrtB7tJPeq4RTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=thbp7do7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TJwkb4022878;
	Thu, 29 May 2025 18:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WH2Y4
	SwvShVQdCzUe2usL0jfrh4xsef92AcW+fb9+vM=; b=thbp7do7Mzd+H9IL6csQM
	Sz8GWAihMcso16pW11ri8QJxqBZ1o3BZygIjU2X0ftUhqcC4Gc5iQgKW/UdOUJ2S
	SEEtNkA/A5tX48YhfDU7q0RLsmm821+FEXPTi04NhQ5wX3PLQAZFAuLp/zo5Y2cw
	2UCo4F6YPbaw4tOD2tSKuw0/Rwvl3ewtunbfGf/8ACDFe+uFAcva2QJQKzd24hXm
	MQp6wt7BF4fEwwJSD414v/XAmi+GlL9UBKPBP+m11INsNU6lWn0UF5mbL6xGXEb9
	injs6+VnqgNynmpQFGbchfCtBT4tAZlRFCfT1qro04+ksK+tNrRQJd9ywLrliVSI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46wu5837fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:50:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54TMo0tp010318
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:50:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 May
 2025 18:50:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:50:00 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMneW5017154;
	Thu, 29 May 2025 18:49:43 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <djrscally@gmail.com>
Subject: [PATCH v9 06/12] iio: adc: ad7768-1: add regulator to control VCM output
Date: Thu, 29 May 2025 19:49:40 -0300
Message-ID: <2888e1164bcffb76508a0d613efdebff7a7999f8.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMiBTYWx0ZWRfX0uyU1cXFj4Q1
 U2GqXfK8SY2xAPoROz1escp6Al6ekcdXwMkBqq5/OeSkXas7SGhcUFlPN1Utw+rdxxflt8HHULH
 cUgM/B1PnqLBcW1JrEu6D8IYMxKXD1lQQ54PrmRhKcjSzGic3n6S0oSUHncPbe1YMFGMOMtiX/u
 c9pn9T0DoGYmwwDqNWZomYvTeQ7SG2EyiNTz2H0RqyPg7AtFquNDmp/0/Ob8jh5CfdQGzKucwoc
 9fPHLdGY9z2NVomo6PYrMKghnYsnMykeZt8DyBM+1h/7pcV8rR29Mgg0MHIxnRG8vqjgYS4X8tU
 f6koH9NapbcFiEptMFSvZJ9mqizXBUnsNLnzKAUz9U/BQxJk1pMVJ8eaX/3+Bk+vb9X0F9b/NaC
 zsOM8N+P1rxkuXnQ0CDhH7vNquTWi0l69f/SAab0le7lASeClJz/39lA8BW6m1NnoFN8hFqF
X-Authority-Analysis: v=2.4 cv=FZ03xI+6 c=1 sm=1 tr=0 ts=6838e499 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=lA8crIeKp1-K9khhi1AA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: CCJGqFvanL5O5gdxs1LOg86fbkJjvB-s
X-Proofpoint-ORIG-GUID: CCJGqFvanL5O5gdxs1LOg86fbkJjvB-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=6 malwarescore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505290222

The VCM output voltage can be used as a common-mode voltage within the
amplifier preconditioning circuits external to the AD7768-1.

This change allows the user to configure VCM output using the regulator
framework.

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
index ad06cf556785..8dc4cc4c25af 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -329,6 +329,7 @@ config AD7766
 config AD7768_1
 	tristate "Analog Devices AD7768-1 ADC driver"
 	depends on SPI
+	select REGULATOR
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGER
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index e90bb5d50076..cd5ce774df72 100644
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
@@ -646,6 +656,150 @@ static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
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
@@ -710,6 +864,11 @@ static int ad7768_probe(struct spi_device *spi)
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


