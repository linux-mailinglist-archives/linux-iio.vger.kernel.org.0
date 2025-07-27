Return-Path: <linux-iio+bounces-22078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD937B131F5
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38501895C93
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D421239E64;
	Sun, 27 Jul 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUY/miFY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C3155326
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650412; cv=none; b=ZaN56vs/3nVlRDJ2Z+xwi+ZL6R4eARkRVsPGs46wxp/+7aj93r63kfaArO9rj61AnvZTt3m7jELzEwQsTK57L9QSyoWGSy1x2Oq3BuQnTIcr8Lu2PoxZSzSYH7uNvmBt7NkSpUBuKWzSteRxbc6kfNauUCi8RK5yDRfX8VqjyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650412; c=relaxed/simple;
	bh=hcEOAViDdoDomiEIo9qEA+PnzyX15LcxbMLpFszObF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtZE/6/bRvQwE2zyawsHARx2frTqa1nuT2ywdru26RDdJTRbkvvmIEIkcHAsTPLHxwtFWEqYqmaYC3PM8ohmuRUT9oQBTRkPaE2rBGBSxxh2fn/U65u+W7MF57vaAvwZYui195VVYHcVKpzfvBJg+CHavez7tgt2f3lMSQ42vQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUY/miFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D24EC4CEEB;
	Sun, 27 Jul 2025 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753650411;
	bh=hcEOAViDdoDomiEIo9qEA+PnzyX15LcxbMLpFszObF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUY/miFYKjyJ5Q3WRTGDUHaARvaavMgevdI6YndgE/9SOQzTCfeY0DTzGVGs17WVI
	 Kt0TY70/PogTMAWivOnGzTKyyOYYlSE81Rpgzpu/AHMfxinJiVjqtkdNeMi6u/N7bG
	 VDjx9CQyl9Yv22OkJCOn6wRm5zvt43K8wrtOZ7EQHXmPz0g8HaSMQT951oGRi0Mjuo
	 lSudL7INgszce6aSXgUOjkZYLOSploK/fwN8HPhxepHUIm/QB3geU1QLWLdMVoOfHV
	 0VdnsV/GNS9moV6Z13Vm57TP9sfzZ7vab4Fp7CG+e8xSjwGSatMt9GYg6DXxGVfaut
	 w/FhmxSFh0F4Q==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Date: Sun, 27 Jul 2025 23:06:39 +0200
Message-ID: <20250727210639.196351-3-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250727210639.196351-1-hansg@kernel.org>
References: <20250727210639.196351-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
The AXP288's GPADC is already supported by the X-Powers AXP288 ADC driver.

The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".

Add a driver for the Intel Dollar Cove TI PMIC's general purpose ADC,
binding to the "chtdc_ti_adc" MFD cell of the MFD driver.

The "cht" in the cell name comes from Cherry Trail, but it turns out that
just like the AXP288 the Intel Dollar Cove TI PMIC is also used with both
Intel Bay Trail and Intel Cherry Trail SoCs, so this new ADC driver does
not include the cht part in its name.

This is loosely based on kernel/drivers/iio/adc/iio_dc_ti_gpadc.c
from the Acer A1-840 Android kernel source-code archive named:
"App. Guide_Acer_20151221_A_A.zip"
which is distributed by Acer from the Acer A1-840 support page:
https://www.acer.com/us-en/support/product-support/A1-840/downloads

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v3:
- Use new more compact DC_TI_ADC_DATA_REG_CH(x) macro
- Use regmap_set_bits() regmap_clear_bits() where applicable
- Use regmap_bulk_read() + be16_to_cpu() to read ADC value
- Use sign_extend32() for vbat_zse and vbat_ge reading in probe()

Changes in v2:
- Add IIO_CHAN_INFO_SCALE and provide ADC scale info for Vbat
- Add IIO_CHAN_INFO_PROCESSED which applies calibration and
  scaling for the VBat channel
- Address some other small review remarks
---
 drivers/iio/adc/Kconfig           |  11 +
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/intel_dc_ti_adc.c | 327 ++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ea3ba1397392..51a5fc6efbe1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -723,6 +723,17 @@ config INGENIC_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called ingenic_adc.
 
+config INTEL_DC_TI_ADC
+	tristate "Intel Bay / Cherry Trail Dollar Cove TI ADC driver"
+	depends on INTEL_SOC_PMIC_CHTDC_TI
+	help
+	  Say yes here to have support for the Dollar Cove TI PMIC ADC device.
+	  Depending on platform configuration, this general purpose ADC can be
+	  used for sensors such as battery voltage and thermal resistors.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called intel_dc_ti_adc.
+
 config INTEL_MRFLD_ADC
 	tristate "Intel Merrifield Basin Cove ADC driver"
 	depends on INTEL_SOC_PMIC_MRFLD
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 09ae6edb2650..da99ba88b4e1 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
 obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
+obj-$(CONFIG_INTEL_DC_TI_ADC) += intel_dc_ti_adc.o
 obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
diff --git a/drivers/iio/adc/intel_dc_ti_adc.c b/drivers/iio/adc/intel_dc_ti_adc.c
new file mode 100644
index 000000000000..fcf76e651135
--- /dev/null
+++ b/drivers/iio/adc/intel_dc_ti_adc.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Dollar Cove TI PMIC GPADC Driver
+ *
+ * Copyright (C) 2014 Intel Corporation (Ramakrishna Pallala <ramakrishna.pallala@intel.com>)
+ * Copyright (C) 2024 - 2025 Hans de Goede <hansg@kernel.org>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/wait.h>
+
+#include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/machine.h>
+
+#define DC_TI_ADC_CNTL_REG			0x50
+#define DC_TI_ADC_START				BIT(0)
+#define DC_TI_ADC_CH_SEL			GENMASK(2, 1)
+#define DC_TI_ADC_EN				BIT(5)
+#define DC_TI_ADC_EN_EXT_BPTH_BIAS		BIT(6)
+
+#define DC_TI_VBAT_ZSE_GE_REG			0x53
+#define DC_TI_VBAT_GE				GENMASK(3, 0)
+#define DC_TI_VBAT_ZSE				GENMASK(7, 4)
+
+/* VBAT GE gain correction is in 0.0015 increments, ZSE is in 1.0 increments */
+#define DC_TI_VBAT_GE_STEP			15
+#define DC_TI_VBAT_GE_DIV			10000
+
+#define DC_TI_ADC_DATA_REG_CH(x)		(0x54 + 2 * (x))
+
+enum dc_ti_adc_id {
+	DC_TI_ADC_VBAT,
+	DC_TI_ADC_PMICTEMP,
+	DC_TI_ADC_BATTEMP,
+	DC_TI_ADC_SYSTEMP0,
+};
+
+struct dc_ti_adc_info {
+	struct mutex lock; /* Protects against concurrent accesses to the ADC */
+	wait_queue_head_t wait;
+	struct device *dev;
+	struct regmap *regmap;
+	int vbat_zse;
+	int vbat_ge;
+	bool conversion_done;
+};
+
+static const struct iio_chan_spec dc_ti_adc_channels[] = {
+	{
+		.indexed = 1,
+		.type = IIO_VOLTAGE,
+		.channel = DC_TI_ADC_VBAT,
+		.address = DC_TI_ADC_DATA_REG_CH(0),
+		.datasheet_name = "CH0",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_PROCESSED),
+	}, {
+		.indexed = 1,
+		.type = IIO_TEMP,
+		.channel = DC_TI_ADC_PMICTEMP,
+		.address = DC_TI_ADC_DATA_REG_CH(1),
+		.datasheet_name = "CH1",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.indexed = 1,
+		.type = IIO_TEMP,
+		.channel = DC_TI_ADC_BATTEMP,
+		.address = DC_TI_ADC_DATA_REG_CH(2),
+		.datasheet_name = "CH2",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.indexed = 1,
+		.type = IIO_TEMP,
+		.channel = DC_TI_ADC_SYSTEMP0,
+		.address = DC_TI_ADC_DATA_REG_CH(3),
+		.datasheet_name = "CH3",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}
+};
+
+static struct iio_map dc_ti_adc_default_maps[] = {
+	IIO_MAP("CH0", "chtdc_ti_battery", "VBAT"),
+	IIO_MAP("CH1", "chtdc_ti_battery", "PMICTEMP"),
+	IIO_MAP("CH2", "chtdc_ti_battery", "BATTEMP"),
+	IIO_MAP("CH3", "chtdc_ti_battery", "SYSTEMP0"),
+	{ }
+};
+
+static irqreturn_t dc_ti_adc_isr(int irq, void *data)
+{
+	struct dc_ti_adc_info *info = data;
+
+	info->conversion_done = true;
+	wake_up(&info->wait);
+	return IRQ_HANDLED;
+}
+
+static int dc_ti_adc_scale(struct dc_ti_adc_info *info,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2)
+{
+	if (chan->channel != DC_TI_ADC_VBAT)
+		return -EINVAL;
+
+	/* Vbat ADC scale is 4.6875 mV / unit */
+	*val = 4;
+	*val2 = 687500;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int dc_ti_adc_raw_to_processed(struct dc_ti_adc_info *info,
+				      struct iio_chan_spec const *chan,
+				      int raw, int *val, int *val2)
+{
+	if (chan->channel != DC_TI_ADC_VBAT)
+		return -EINVAL;
+
+	/* Apply calibration */
+	raw -= info->vbat_zse;
+	raw = raw * (DC_TI_VBAT_GE_DIV - info->vbat_ge * DC_TI_VBAT_GE_STEP) /
+	      DC_TI_VBAT_GE_DIV;
+	/* Vbat ADC scale is 4.6875 mV / unit */
+	raw *= 46875;
+
+	/* raw is now in 10000 units / mV, convert to milli + milli/1e6 */
+	*val = raw / 10000;
+	*val2 = (raw % 10000) * 100;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int dc_ti_adc_sample(struct dc_ti_adc_info *info,
+			    struct iio_chan_spec const *chan, int *val)
+{
+	int ret, ch = chan->channel;
+	__be16 buf;
+
+	info->conversion_done = false;
+
+	/*
+	 * As per TI (PMIC Vendor), the ADC enable and ADC start commands should
+	 * not be sent together. Hence send the commands separately
+	 */
+	ret = regmap_set_bits(info->regmap, DC_TI_ADC_CNTL_REG, DC_TI_ADC_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+				 DC_TI_ADC_CH_SEL,
+				 FIELD_PREP(DC_TI_ADC_CH_SEL, ch));
+	if (ret)
+		return ret;
+
+	/*
+	 * As per PMIC Vendor, a minimum of 50 micro seconds delay is required
+	 * between ADC Enable and ADC START commands. This is also recommended
+	 * by Intel Hardware team after the timing analysis of GPADC signals.
+	 * Since the I2C Write transaction to set the channel number also
+	 * imparts 25 micro seconds of delay, so we need to wait for another
+	 * 25 micro seconds before issuing ADC START command.
+	 */
+	fsleep(25);
+
+	ret = regmap_set_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+			      DC_TI_ADC_START);
+	if (ret)
+		return ret;
+
+	/* TI (PMIC Vendor) recommends 5 sec timeout for conversion */
+	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
+	if (ret == 0) {
+		ret = -ETIMEDOUT;
+		goto disable_adc;
+	}
+
+	ret = regmap_bulk_read(info->regmap, chan->address, &buf, sizeof(buf));
+	if (ret)
+		goto disable_adc;
+
+	/* The ADC values are 10 bits */
+	*val = be16_to_cpu(buf) & GENMASK(9, 0);
+
+disable_adc:
+	regmap_clear_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+			  DC_TI_ADC_START | DC_TI_ADC_EN);
+	return ret;
+}
+
+static int dc_ti_adc_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct dc_ti_adc_info *info = iio_priv(indio_dev);
+	int ret;
+
+	if (mask == IIO_CHAN_INFO_SCALE)
+		return dc_ti_adc_scale(info, chan, val, val2);
+
+	guard(mutex)(&info->lock);
+
+	/*
+	 * If channel BPTHERM has been selected, first enable the BPTHERM BIAS
+	 * which provides the VREF Voltage reference to convert BPTHERM Input
+	 * voltage to temperature.
+	 * As per PMIC Vendor specifications, BPTHERM BIAS should be enabled
+	 * 35 ms before ADC_EN command.
+	 */
+	if (chan->channel == DC_TI_ADC_BATTEMP) {
+		ret = regmap_set_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+				      DC_TI_ADC_EN_EXT_BPTH_BIAS);
+		if (ret)
+			return ret;
+		msleep(35);
+	}
+
+	ret = dc_ti_adc_sample(info, chan, val);
+
+	if (chan->channel == DC_TI_ADC_BATTEMP)
+		regmap_clear_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+				  DC_TI_ADC_EN_EXT_BPTH_BIAS);
+
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PROCESSED:
+		return dc_ti_adc_raw_to_processed(info, chan, *val, val, val2);
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info dc_ti_adc_iio_info = {
+	.read_raw = dc_ti_adc_read_raw,
+};
+
+static int dc_ti_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
+	struct dc_ti_adc_info *info;
+	struct iio_dev *indio_dev;
+	unsigned int val;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+
+	ret = devm_mutex_init(dev, &info->lock);
+	if (ret)
+		return ret;
+
+	init_waitqueue_head(&info->wait);
+
+	info->dev = dev;
+	info->regmap = pmic->regmap;
+
+	indio_dev->name = "dc_ti_adc";
+	indio_dev->channels = dc_ti_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(dc_ti_adc_channels);
+	indio_dev->info = &dc_ti_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = regmap_read(info->regmap, DC_TI_VBAT_ZSE_GE_REG, &val);
+	if (ret)
+		return ret;
+
+	info->vbat_zse = sign_extend32(FIELD_GET(DC_TI_VBAT_ZSE, val), 3);
+	info->vbat_ge = sign_extend32(FIELD_GET(DC_TI_VBAT_GE, val), 3);
+
+	dev_dbg(dev, "vbat-zse %d vbat-ge %d\n", info->vbat_zse, info->vbat_ge);
+
+	ret = devm_iio_map_array_register(dev, indio_dev, dc_ti_adc_default_maps);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, dc_ti_adc_isr,
+					IRQF_ONESHOT, indio_dev->name, info);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id dc_ti_adc_ids[] = {
+	{ .name = "chtdc_ti_adc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, dc_ti_adc_ids);
+
+static struct platform_driver dc_ti_adc_driver = {
+	.driver = {
+		.name	= "dc_ti_adc",
+	},
+	.probe		= dc_ti_adc_probe,
+	.id_table	= dc_ti_adc_ids,
+};
+module_platform_driver(dc_ti_adc_driver);
+
+MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
+MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
+MODULE_DESCRIPTION("Intel Dollar Cove (TI) GPADC Driver");
+MODULE_LICENSE("GPL");
-- 
2.49.0


