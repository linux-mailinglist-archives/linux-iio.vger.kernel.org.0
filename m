Return-Path: <linux-iio+bounces-10029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AAC98EE6C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520521F242AD
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372B17A5BE;
	Thu,  3 Oct 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eMuR90CD"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECC161310;
	Thu,  3 Oct 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956013; cv=none; b=NRxFlitkQDtRXSPxEmpRJb84LmLeqBQHmR5NB3/4IKIjZ7ThA3TAcLYAW6Dd6BzQx9AY2DR1pJoAYJmWY2fJeKTyK+3ZbQ8b/jF/lzMVqZ30ACSpC3FX5z3Oc0z2f5z05CGWa5aRLBab3cyZ5epIyZylgyv3KSw7rvQf++rlUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956013; c=relaxed/simple;
	bh=wTEmwBj8zmnWMsxPDvDa9/qESvHneb47rmv6v4zw5dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkH3LpodiPoGkhk5gLOpNeZaSUr84Mmw/xnuymGgBncHBmt+lhIE/K//CCkorkEBt9qFh5/RWbrT/1zKa4b4bS4p+fXTYbwmQwU25XTzNvLrwlyffVXs2uazPO93giCW1CnUjT/ZoVGnIVG6yGYaU+lTpMAYSRL+m/P+CBvIsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eMuR90CD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5D85CC000A;
	Thu,  3 Oct 2024 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727956009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdxN7iYl8GGlNdvRLtUhc9B30FDhzLCrq44oPUZRrO0=;
	b=eMuR90CDfHhC8rnME8cG1ao7Pa+gp3ZyqXJNBpMAicqLXltHng0DEEBPSWyhB6Bk1R3HKV
	ZGJFrPMG/BKJKqE0+onCuKYWsoG3B3WMlCw2sROVVZGryIertAb9jT8DyLaNETHP9+k54W
	qUV4SJp2rMf4CTGguwTdZnzhF5Ls7LNbuc9huwbgP2hggMwuYSJ9s1Ly34bDJC7rSlrwwU
	c1Ca+o9EddWEYAUgne57QBNJGQGFuX0/op5yc9heuiiepNDdpdXTyVxJIpwv83wKoOFrAI
	1JOdRlbYS3ojcug3IjRH7vsD5NcdPY6WTQQu+H2WzzwiJfzOofON5bSLAfYrRg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
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
Subject: [PATCH v2 3/4] iio: adc: Add support for the GE HealthCare PMC ADC
Date: Thu,  3 Oct 2024 13:46:40 +0200
Message-ID: <20241003114641.672086-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003114641.672086-1-herve.codina@bootlin.com>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
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
 drivers/iio/adc/gehc-pmc-adc.c | 227 +++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)
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
index 000000000000..c70a93f4a61b
--- /dev/null
+++ b/drivers/iio/adc/gehc-pmc-adc.c
@@ -0,0 +1,227 @@
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
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),		\
+	.datasheet_name = (_ds_name),					\
+}
+
+#define PMC_ADC_CURRENT_CHANNEL(_ch, _ds_name) {			\
+	.type = IIO_CURRENT,						\
+	.indexed = 1,							\
+	.channel = (_ch),						\
+	.address = PMC_ADC_CMD_READ_CURRENT(_ch),			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),		\
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
+	*val = sign_extend32(ret, 15);
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
+	case IIO_CHAN_INFO_PROCESSED:
+		/* Values are directly read in mV or mA */
+		ret = pmc_adc_read_raw_ch(pmc_adc, chan->address, val);
+		if (ret)
+			return ret;
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
+	if (val != 0x01)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Unsupported protocol version 0x%02x\n", val);
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


