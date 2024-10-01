Return-Path: <linux-iio+bounces-9951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478998B607
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 09:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC2B217E8
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2F1BC9EB;
	Tue,  1 Oct 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EUgc8Rqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD81BDAB1;
	Tue,  1 Oct 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768791; cv=none; b=ObtcC8hL91YtSvaqE1DQld4BFz1qqcij7m/cvOgyEM3dZ9QiQtM4/8e0cBhd+bx128PRy3pT4WnxFb21KURqOo2VUzUM6oEBHq0hLL63G5oKsyUaW6XzuYp++/6VeTUMXWO4hYjzPNYnGDey8pNlD/QtsIfW665bfeIk98yjzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768791; c=relaxed/simple;
	bh=/fhciwkduaS+CJJULr1HGfLeN30SAc7pUOKwTX7L8wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cosfpZ0cDClrhRxB2rRIXasPJQp9NwiWRP+9PqOB4VBP1VcrlKmz2WqgyY+8he/eSyzqweG7frQWkZb+kwP+j6E6s/uTC2e5J2PLIKuzeOM0iGCUNoZM7fcnKvPSwq/sQ4tRqdljjxtbQJAQhMWzF6BqtfyqUEAyj4jvyLlIuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EUgc8Rqr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AC8FE60012;
	Tue,  1 Oct 2024 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727768787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVNoaQH2nC7DoJ26S81muHdAjfS+RK97ymnAf6x6iLY=;
	b=EUgc8RqrZdOVaFHBTQiqCUCrrBN0iAIeiMR+IwjdiOxJmCR+XzfZNjhn440txnerpAlj7L
	ZK9JTATH4kQ1Eg6q9XnRyMLv5Cd6oNJtTG+5/ay/sFrTjC+eee5ZdbPSyzFFHE35C0cSgn
	i65uENhTgyQD5fFXLlbHyyMqHEi4gqvXVs766o9QTUUfh3iBIYUIxVuQnz26YBZi/85LKn
	vGltoO6IkCFx/JE7zTUehouIapblAxOWJVxR1OyrDtiJEQJTHLGgsGs8t9srRUFmwkQFBV
	Us+tBRaLOQvsEcNo2Q07g+LuA+GIaI8c6IaRDaXtLa4mCSrEwijLkZ2e7DKoGw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 3/4] iio: adc: Add support for the GE HealthCare PMC ADC
Date: Tue,  1 Oct 2024 09:46:17 +0200
Message-ID: <20241001074618.350785-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001074618.350785-1-herve.codina@bootlin.com>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
(voltage and current), 16-Bit ADC with an I2C Interface.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/iio/adc/Kconfig        |  10 ++
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/gehc-pmc-adc.c | 233 +++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/iio/adc/gehc-pmc-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 97ece1a4b7e3..87b20f972c25 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -571,6 +571,16 @@ config FSL_MX25_ADC
 	  Generic Conversion Queue driver used for general purpose ADC in the
 	  MX25. This driver supports single measurements using the MX25 ADC.
 
+config GEHC_PMC_ADC
+	tristate "GE HealthCare PMC ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the GE HealthCare PMC 16-bit
+	  16-Channel ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gehc-pmc-adc.
+
 config HI8435
 	tristate "Holt Integrated Circuits HI-8435 threshold detector"
 	select IIO_TRIGGERED_EVENT
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7b91cd98c0e0..66b36dfe9a28 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ENVELOPE_DETECTOR) += envelope-detector.o
 obj-$(CONFIG_EP93XX_ADC) += ep93xx_adc.o
 obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
 obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
+obj-$(CONFIG_GEHC_PMC_ADC) += gehc-pmc-adc.o
 obj-$(CONFIG_HI8435) += hi8435.o
 obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
diff --git a/drivers/iio/adc/gehc-pmc-adc.c b/drivers/iio/adc/gehc-pmc-adc.c
new file mode 100644
index 000000000000..c46c2fb84d35
--- /dev/null
+++ b/drivers/iio/adc/gehc-pmc-adc.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The GE HealthCare PMC ADC is a 16-Channel (Voltage and current), 16-Bit
+ * ADC with an I2C Interface.
+ *
+ * Copyright (C) 2024, GE HealthCare
+ *
+ * Authors:
+ * Herve Codina <herve.codina@bootlin.com>
+ */
+#include <dt-bindings/iio/adc/gehc,pmc-adc.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+struct pmc_adc {
+	struct i2c_client *client;
+};
+
+#define PMC_ADC_CMD_REQUEST_PROTOCOL_VERSION	0x01
+#define PMC_ADC_CMD_READ_VOLTAGE(_ch)		(0x10 | (_ch))
+#define PMC_ADC_CMD_READ_CURRENT(_ch)		(0x20 | (_ch))
+
+#define PMC_ADC_VOLTAGE_CHANNEL(_ch, _ds_name) {			\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = (_ch),						\
+	.address = PMC_ADC_CMD_READ_VOLTAGE(_ch),			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.datasheet_name = (_ds_name),					\
+}
+
+#define PMC_ADC_CURRENT_CHANNEL(_ch, _ds_name) {			\
+	.type = IIO_CURRENT,						\
+	.indexed = 1,							\
+	.channel = (_ch),						\
+	.address = PMC_ADC_CMD_READ_CURRENT(_ch),			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.datasheet_name = (_ds_name),					\
+}
+
+static const struct iio_chan_spec pmc_adc_channels[] = {
+	PMC_ADC_VOLTAGE_CHANNEL(0, "CH0_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(1, "CH1_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(2, "CH2_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(3, "CH3_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(4, "CH4_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(5, "CH5_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(6, "CH6_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(7, "CH7_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(8, "CH8_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(9, "CH9_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(10, "CH10_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(11, "CH11_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(12, "CH12_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(13, "CH13_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(14, "CH14_V"),
+	PMC_ADC_VOLTAGE_CHANNEL(15, "CH15_V"),
+
+	PMC_ADC_CURRENT_CHANNEL(0, "CH0_I"),
+	PMC_ADC_CURRENT_CHANNEL(1, "CH1_I"),
+	PMC_ADC_CURRENT_CHANNEL(2, "CH2_I"),
+	PMC_ADC_CURRENT_CHANNEL(3, "CH3_I"),
+	PMC_ADC_CURRENT_CHANNEL(4, "CH4_I"),
+	PMC_ADC_CURRENT_CHANNEL(5, "CH5_I"),
+	PMC_ADC_CURRENT_CHANNEL(6, "CH6_I"),
+	PMC_ADC_CURRENT_CHANNEL(7, "CH7_I"),
+	PMC_ADC_CURRENT_CHANNEL(8, "CH8_I"),
+	PMC_ADC_CURRENT_CHANNEL(9, "CH9_I"),
+	PMC_ADC_CURRENT_CHANNEL(10, "CH10_I"),
+	PMC_ADC_CURRENT_CHANNEL(11, "CH11_I"),
+	PMC_ADC_CURRENT_CHANNEL(12, "CH12_I"),
+	PMC_ADC_CURRENT_CHANNEL(13, "CH13_I"),
+	PMC_ADC_CURRENT_CHANNEL(14, "CH14_I"),
+	PMC_ADC_CURRENT_CHANNEL(15, "CH15_I"),
+};
+
+static int pmc_adc_read_raw_ch(struct pmc_adc *pmc_adc, u8 cmd, int *val)
+{
+	s32 ret;
+
+	ret = i2c_smbus_read_word_swapped(pmc_adc->client, cmd);
+	if (ret < 0) {
+		dev_err(&pmc_adc->client->dev, "i2c read word failed (%d)\n", ret);
+		return ret;
+	}
+
+	*val = sign_extend32(ret, 16);
+	return 0;
+}
+
+static int pmc_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pmc_adc *pmc_adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = pmc_adc_read_raw_ch(pmc_adc, chan->address, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1; /* Raw values are directly read in mV or mA */
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int pmc_adc_fwnode_xlate(struct iio_dev *indio_dev,
+				const struct fwnode_reference_args *iiospec)
+{
+	enum iio_chan_type expected_type;
+	unsigned int i;
+
+	/*
+	 * args[0]: Acquisition type (i.e. voltage or current)
+	 * args[1]: PMC ADC channel number
+	 */
+	if (iiospec->nargs != 2)
+		return -EINVAL;
+
+	switch (iiospec->args[0]) {
+	case GEHC_PMC_ADC_VOLTAGE:
+		expected_type = IIO_VOLTAGE;
+		break;
+	case GEHC_PMC_ADC_CURRENT:
+		expected_type = IIO_CURRENT;
+		break;
+	default:
+		dev_err(&indio_dev->dev, "Invalid channel type %llu\n",
+			iiospec->args[0]);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].type == expected_type &&
+		    indio_dev->channels[i].channel == iiospec->args[1])
+			return i;
+
+	dev_err(&indio_dev->dev, "Invalid channel type %llu number %llu\n",
+		iiospec->args[0], iiospec->args[1]);
+	return -EINVAL;
+}
+
+static const struct iio_info pmc_adc_info = {
+	.read_raw = pmc_adc_read_raw,
+	.fwnode_xlate = pmc_adc_fwnode_xlate,
+};
+
+static const char *const pmc_adc_regulator_names[] = {
+	"vdd",
+	"vdda",
+	"vddio",
+	"vref",
+};
+
+static int pmc_adc_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct pmc_adc *pmc_adc;
+	struct clk *clk;
+	s32 val;
+	int ret;
+
+	ret = devm_regulator_bulk_get_enable(&client->dev, ARRAY_SIZE(pmc_adc_regulator_names),
+					     pmc_adc_regulator_names);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
+
+	clk = devm_clk_get_optional_enabled(&client->dev, "osc");
+	if (IS_ERR(clk))
+		return dev_err_probe(&client->dev, PTR_ERR(clk), "Failed to get osc clock\n");
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*pmc_adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	pmc_adc = iio_priv(indio_dev);
+	pmc_adc->client = client;
+
+	val = i2c_smbus_read_byte_data(pmc_adc->client, PMC_ADC_CMD_REQUEST_PROTOCOL_VERSION);
+	if (val < 0)
+		return dev_err_probe(&client->dev, val, "Failed to get protocol version\n");
+
+	if (val != 0x01) {
+		dev_err(&client->dev, "Unsupported protocol version 0x%02x\n", val);
+		return -EINVAL;
+	}
+
+	indio_dev->name = "pmc_adc";
+	indio_dev->info = &pmc_adc_info;
+	indio_dev->channels = pmc_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(pmc_adc_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id pmc_adc_of_match[] = {
+	{ .compatible = "gehc,pmc-adc"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmc_adc_of_match);
+
+static const struct i2c_device_id pmc_adc_id_table[] = {
+	{ "pmc-adc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pmc_adc_id_table);
+
+static struct i2c_driver pmc_adc_i2c_driver = {
+	.driver  = {
+		.name = "pmc-adc",
+		.of_match_table = pmc_adc_of_match,
+	},
+	.id_table = pmc_adc_id_table,
+	.probe  = pmc_adc_probe,
+};
+
+module_i2c_driver(pmc_adc_i2c_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("GE HealthCare PMC ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.46.1


