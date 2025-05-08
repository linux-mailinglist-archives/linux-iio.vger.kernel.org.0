Return-Path: <linux-iio+bounces-19324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAEBAB00F5
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F814C2B3D
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01028688B;
	Thu,  8 May 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="s+KGomUQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2322286431;
	Thu,  8 May 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723873; cv=none; b=dCK6N+YbHB7ufnJcJfIH9KfoWniCd4n4l8eY2qkPyNCwDUeQf5TutWOqLKk8lqc7xUUKmyp13N/PpJUlNInbxQKVvbk4BXWoPRubnsAABodz9ijbC5n3XO+RYtj4JX7czRFlMOPlmSdZRz08GhsBgF3jikmqekJvVYuzRMvFp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723873; c=relaxed/simple;
	bh=DhuNtQzbQhCnom9EJRpJrTUUJJ0NN0NXH0T5CAnr7D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fL7J1P6p1poPwpO1u+qOHCqKJvmma0m1dteJUs4cN6LrgklsCr+CXT9ineKMTI1bBzuYM0+9xCX1cyS3Ckx34Tj5tAwx5lcRp+REdm40YuockwfyUMf7SfGvQbhJcMVKODzC+6rX58nh1X5xvvni0MSLy0DG6NVeQxmBGFayOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=s+KGomUQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Dh17w023915;
	Thu, 8 May 2025 13:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mPaIc
	kpZdJAKLhwpv5vLy81wUhLhiPrB1ozUXZs/S2U=; b=s+KGomUQEhVRU4nyKxLAL
	7wm4JMOwimwaV+nCuj6KhrVto1id60JFw3FAfMWExppdFUb3iTXlbIBm2pe2Gqsu
	8NbatIOuOdXFpjryQ77a5TQuyshiR9qX5Yxlvm58L6FY64v+b+fT29ZG9kvw8r7e
	oyNerR6sCNPapGxr/XRZzBGOTuEpbTUe4Bxmln72r8T6wk/o8Qxa+GngekCqZI5h
	m/qVc2I99ch57SzXw3jUdD7Mbl4B3vSITaLv0zoUPK4Q1PuRmUHQlhBLgtQ0Yp1P
	uYARm8hJC5CHAzXyebvYPElMlbnywfqa8c/JQnHBzfo2mEMOufd3s2GpYC/EHAl3
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpctb1qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:04:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 548H4Qr1052751
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:04:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:04:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:04:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:04:26 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H4CUD015889;
	Thu, 8 May 2025 13:04:14 -0400
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
Subject: [PATCH v7 06/12] iio: adc: ad7768-1: add regulator to control VCM output
Date: Thu, 8 May 2025 14:04:12 -0300
Message-ID: <70b0a3b31ae5b4cbeff7b776e2e528c9df41529e.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXxMrR/2+hXp0W
 D/wRfotBcdww1qgAN/b//rsisaIlcYdSa8roeOiDCmGaBKUapi/q6uKhezapEi1iTVBMC8YnBBX
 jYjZ72SxcFk3OyxOBfFq3BcTgbe62RMB86TgTeZne+Yyk/J2h+ZV9H5TG2/QEGg5aO1orJ+qd9m
 hDb01bExM9rFBrG0epgeW5FBlZ9yUKIW1LW6sYQeWU/hM81xqSggKEVBe32n9sY97+g+8MqUGnY
 BSWb5TtVDuM1QWqWd5ENfQfkFfJBBT8JgrWoFOHTN3aaUM0a65Y6OT6DjCTO/Iu+IUH2iv9kCqJ
 EdekNHXPHS/mfHX7KF0JjWzygY+slvulH8r6Q+K2jx5jatKWU7hb+Ic7GYLvJmYBgGrQCm+XGJ8
 rjOR89erXGv01tDn4QQgmXq6X9iYnlWI6/VmHyb37MOW1XShN2+swpizg95/K1tQ/22cIZOX
X-Authority-Analysis: v=2.4 cv=Ur5jN/wB c=1 sm=1 tr=0 ts=681ce41c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=lA8crIeKp1-K9khhi1AA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: OI6ldSp2aEyTPWO-cbCbNvkUxa2-b-Fe
X-Proofpoint-ORIG-GUID: OI6ldSp2aEyTPWO-cbCbNvkUxa2-b-Fe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=6 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080149

The VCM output voltage can be used as a common-mode voltage within the
amplifier preconditioning circuits external to the AD7768-1.

This change allows the user to configure VCM output using the regulator
framework.

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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


