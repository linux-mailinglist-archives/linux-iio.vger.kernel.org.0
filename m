Return-Path: <linux-iio+bounces-13691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A99649F884F
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 00:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864A618918B4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B91B041E;
	Thu, 19 Dec 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI2zK/7K"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EFE1DC9B8
	for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649237; cv=none; b=kCsQRC2rFu/atKdClC9Tc3kJYzRv8a6jrIXKi5uWB1oG6v3EU3lrP8G1Wy/wESWz9LK9ciQ/kbI8ofDp2odebdhLtx5Ig9m6XJZo+sp3g0J9rSS9aYic1EGNOpBi/kdhLlPe6MMhCudjsS6PWAij1QX8KR6dW1zvX/aDYvzb/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649237; c=relaxed/simple;
	bh=O/I7wUnd/YDwTy17jj/DLIvxD00Oxc0k+/6m687Ziqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjMpcpZb9/dG29uhExgt2lKGGwFLhfjqCNlotGC2QsR0pRIX5C3HZqAKLQKV7Z8TMGjcT0YXc4WuuJWKQF1VuOdPVyj92EmOssJSd+XxWQKEqn/0XRwgvFTu0CU7NTsAeEz/OH5Grmy1Me+xfPd1lJrRLilJW4c916KFW5SmEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI2zK/7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734649234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HcfDId1dxH0d/NLoFDJUy8JErIvd8xvqs2kvrOWIhcI=;
	b=cI2zK/7KwbjOQrcLvKD+JA4NnvmNDTfVULhiX5Ak8J9KCZi/CFaMHDxqK+Nyho4yWq5xGF
	2VgClPh/yPYIt9ONQ8ux1fsR7AaSdk8bgAowpu1sxsKW0j9fG8NalUEBJHsvEtsBzWrhlP
	NaaXw3sqSMpQKYtTyGPHWyvpOpEZBuc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-74fLnAYdNiq0p9l8o_6S-w-1; Thu,
 19 Dec 2024 18:00:32 -0500
X-MC-Unique: 74fLnAYdNiq0p9l8o_6S-w-1
X-Mimecast-MFC-AGG-ID: 74fLnAYdNiq0p9l8o_6S-w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FF5A19560B5;
	Thu, 19 Dec 2024 23:00:31 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.73])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7CC319560A2;
	Thu, 19 Dec 2024 23:00:29 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Date: Fri, 20 Dec 2024 00:00:28 +0100
Message-ID: <20241219230028.55987-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/adc/Kconfig           |  11 ++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/intel_dc_ti_adc.c | 258 ++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..8fd69edb057c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -678,6 +678,17 @@ config INTEL_MRFLD_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called intel_mrfld_adc.
 
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
 config IMX7D_ADC
 	tristate "Freescale IMX7D ADC driver"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7..607d13c93c76 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
 obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
+obj-$(CONFIG_INTEL_DC_TI_ADC) += intel_dc_ti_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
diff --git a/drivers/iio/adc/intel_dc_ti_adc.c b/drivers/iio/adc/intel_dc_ti_adc.c
new file mode 100644
index 000000000000..c286f72cfb08
--- /dev/null
+++ b/drivers/iio/adc/intel_dc_ti_adc.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Dollar Cove TI PMIC GPADC Driver
+ *
+ * Copyright (C) 2014 Intel Corporation (Ramakrishna Pallala <ramakrishna.pallala@intel.com>)
+ * Copyright (C) 2024 Hans de Goede <hansg@kernel.org>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/intel_soc_pmic.h>
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
+#define DC_TI_ADC_CH0_DATAH_REG			0x54
+#define DC_TI_ADC_CH0_DATAL_REG			0x55
+#define DC_TI_ADC_CH1_DATAH_REG			0x56
+#define DC_TI_ADC_CH1_DATAL_REG			0x57
+#define DC_TI_ADC_CH2_DATAH_REG			0x58
+#define DC_TI_ADC_CH2_DATAL_REG			0x59
+#define DC_TI_ADC_CH3_DATAH_REG			0x5A
+#define DC_TI_ADC_CH3_DATAL_REG			0x5B
+
+#define DEV_NAME				"chtdc_ti_adc"
+
+enum dc_ti_adc_id {
+	DC_TI_ADC_VBAT,
+	DC_TI_ADC_PMICTEMP,
+	DC_TI_ADC_BATTEMP,
+	DC_TI_ADC_SYSTEMP0,
+};
+
+struct dc_ti_adc_info {
+	struct mutex lock;
+	wait_queue_head_t wait;
+	struct device *dev;
+	struct regmap *regmap;
+	bool conversion_done;
+};
+
+static const struct iio_chan_spec dc_ti_adc_channels[] = {
+	{
+		.indexed = 1,
+		.type = IIO_VOLTAGE,
+		.channel = DC_TI_ADC_VBAT,
+		.address = DC_TI_ADC_CH0_DATAH_REG,
+		.datasheet_name = "CH0",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.indexed = 1,
+		.type = IIO_TEMP,
+		.channel = DC_TI_ADC_PMICTEMP,
+		.address = DC_TI_ADC_CH1_DATAH_REG,
+		.datasheet_name = "CH1",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.indexed = 1,
+		.type = IIO_TEMP,
+		.channel = DC_TI_ADC_BATTEMP,
+		.address = DC_TI_ADC_CH2_DATAH_REG,
+		.datasheet_name = "CH2",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.indexed = 1,
+		.type = IIO_TEMP,
+		.channel = DC_TI_ADC_SYSTEMP0,
+		.address = DC_TI_ADC_CH3_DATAH_REG,
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
+	{}
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
+static int dc_ti_adc_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct dc_ti_adc_info *info = iio_priv(indio_dev);
+	int ret, ch = chan->channel;
+	unsigned int lsb, msb;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	guard(mutex)(&info->lock);
+
+	info->conversion_done = false;
+
+	/*
+	 * If channel BPTHERM has been selected, first enable the BPTHERM BIAS
+	 * which provides the VREFT Voltage reference to convert BPTHERM Input
+	 * voltage to temperature.
+	 * As per PMIC Vendor specifications, BPTHERM BIAS should be enabled
+	 * 35 ms before ADC_EN command.
+	 */
+	if (ch == DC_TI_ADC_BATTEMP) {
+		ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+					 DC_TI_ADC_EN_EXT_BPTH_BIAS,
+					 DC_TI_ADC_EN_EXT_BPTH_BIAS);
+		if (ret < 0)
+			return ret;
+		msleep(35);
+	}
+
+	/*
+	 * As per TI (PMIC Vendor), the ADC enable and ADC start commands should
+	 * not be sent together. Hence send the commands separately
+	 */
+	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+				 DC_TI_ADC_EN, DC_TI_ADC_EN);
+	if (ret < 0)
+		goto disable_adc;
+
+	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+				 DC_TI_ADC_CH_SEL, FIELD_PREP(DC_TI_ADC_CH_SEL, ch));
+	if (ret < 0)
+		goto disable_adc;
+
+	/*
+	 * As per PMIC Vendor, a minimum of 50 micro seconds delay is required
+	 * between ADC Enable and ADC START commands. This is also recommended
+	 * by Intel Hardware team after the timing analysis of GPADC signals.
+	 * Since the I2C Write transaction to set the channel number also
+	 * imparts 25 micro seconds of delay, so we need to wait for another
+	 * 25 micro seconds before issuing ADC START command.
+	 */
+	usleep_range(25, 40);
+
+	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+				 DC_TI_ADC_START, DC_TI_ADC_START);
+	if (ret < 0)
+		goto disable_adc;
+
+	/* TI (PMIC Vendor) recommends 5 sec timeout for conversion */
+	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
+	if (ret == 0) {
+		dev_err(info->dev, "Error sample timeout\n");
+		ret = -ETIMEDOUT;
+		goto disable_adc;
+	}
+
+	ret = regmap_read(info->regmap, chan->address, &msb);
+	if (ret)
+		goto disable_adc;
+
+	ret = regmap_read(info->regmap, chan->address + 1, &lsb);
+	if (ret)
+		goto disable_adc;
+
+	*val = ((msb << 8) | lsb) & 0x3ff;
+	ret = IIO_VAL_INT;
+
+disable_adc:
+	regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+			   DC_TI_ADC_START | DC_TI_ADC_EN, 0);
+
+	if (ch == DC_TI_ADC_BATTEMP)
+		regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
+				   DC_TI_ADC_EN_EXT_BPTH_BIAS, 0);
+
+	return ret;
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
+	indio_dev->name = pdev->name;
+	indio_dev->channels = dc_ti_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(dc_ti_adc_channels);
+	indio_dev->info = &dc_ti_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_map_array_register(dev, indio_dev, dc_ti_adc_default_maps);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, dc_ti_adc_isr,
+					IRQF_ONESHOT, DEV_NAME, info);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct platform_driver dc_ti_adc_driver = {
+	.probe = dc_ti_adc_probe,
+	.driver = {
+		.name = DEV_NAME,
+	},
+};
+
+module_platform_driver(dc_ti_adc_driver);
+
+MODULE_ALIAS("platform:" DEV_NAME);
+MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
+MODULE_DESCRIPTION("Intel Dollar Cove (TI) GPADC Driver");
+MODULE_LICENSE("GPL");
-- 
2.47.1


