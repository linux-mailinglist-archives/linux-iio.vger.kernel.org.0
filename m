Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980811413DC
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2020 23:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgAQWBP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 17:01:15 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38436 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbgAQWBC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jan 2020 17:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yp952S67t8igdlhwL6BKSjjzjVsHtNTYI/WRBkhhXzE=; b=S1J1EoH4d0lGEk40rC8Zch6zAI
        mhtBRLJVLc77ZLpDEu3p6A3pp5GBvDdHVIc5RjTA8magiNfpkqKqKbrKgs8Ge60mTW1pllXAC8krQ
        S0Wd+UqmSMnBCmHu64sIL+eTuIdEYDUGJFSt8bEj97gfaesrm2AGMRtVfuEb56u2KdY8=;
Received: from p200300ccff371b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:1b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfl-00077m-R2; Fri, 17 Jan 2020 23:00:58 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfl-0003yd-Hq; Fri, 17 Jan 2020 23:00:57 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: [PATCH 3/5] iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619
Date:   Fri, 17 Jan 2020 22:59:24 +0100
Message-Id: <20200117215926.15194-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117215926.15194-1-andreas@kemnade.info>
References: <20200117215926.15194-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Both chips have an A/D converter capable of measuring
things like VBAT, VUSB and analog inputs.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/iio/adc/Kconfig       |  10 ++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/rn5t618-adc.c | 266 ++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 drivers/iio/adc/rn5t618-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f0af3a42f53c..9ea9489e3f0a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -735,6 +735,16 @@ config RCAR_GYRO_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rcar-gyroadc.
 
+config RN5T618_ADC
+	tristate "ADC for the RN5T618/RC5T619 family of chips"
+	depends on MFD_RN5T618
+	help
+	  Say yes here to build support for the integrated ADC inside the
+	  RN5T618/619 series PMICs:
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rn5t618-adc.
+
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ef9cc485fb67..2aea70556ed0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
 obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
+obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
new file mode 100644
index 000000000000..81f872a7ad7f
--- /dev/null
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADC driver for the RICOH RN5T618 power management chip family
+ *
+ * Copyright (C) 2019 Andreas Kemnade
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mfd/rn5t618.h>
+#include <linux/platform_device.h>
+#include <linux/completion.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/slab.h>
+#include <linux/irqdomain.h>
+
+#define RN5T618_ADC_CONVERSION_TIMEOUT   (msecs_to_jiffies(500))
+#define REFERENCE_VOLT 2500
+
+/* mask for selecting channels for single conversion */
+#define ADCCNT3_CHANNEL_MASK 0x7
+/* average 4-time conversion mode */
+#define ADCCNT3_AVG BIT(3)
+/* set for starting a single conversion, gets cleared by hw when done */
+#define ADCCNT3_GODONE BIT(4)
+/* automatic conversion, period is in ADCCNT2, selected channels are
+ * in ADCCNT1
+ */
+#define ADCCNT3_AUTO BIT(5)
+#define ADCEND_IRQ BIT(0)
+
+struct rn5t618_adc_data {
+	struct device *dev;
+	struct rn5t618 *rn5t618;
+	struct completion conv_completion;
+	int irq;
+};
+
+struct rn5t618_channel_ratios {
+	u16 numerator;
+	u16 denominator;
+};
+
+static const struct rn5t618_channel_ratios rn5t618_ratios[8] = {
+	{50, 32}, /* LIMMON measured across 20mOhm, amplified by 32 */
+	{2, 1}, /* VBAT */
+	{3, 1}, /* VADP */
+	{3, 1}, /* VUSB */
+	{3, 1}, /* VSYS */
+	{1, 1}, /* VTHM */
+	{1, 1}, /* AIN1 */
+	{1, 1}, /* AIN0 */
+};
+
+static int rn5t618_read_adc_reg(struct rn5t618 *rn5t618, int reg, u16 *val)
+{
+	unsigned int h;
+	unsigned int l;
+	int ret;
+
+	ret = regmap_read(rn5t618->regmap, reg, &h);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(rn5t618->regmap, reg + 1, &l);
+	if (ret < 0)
+		return ret;
+
+	h <<= 4;
+	h |= (l & 0xF);
+	h &= 0xFFF;
+	*val = h;
+
+	return 0;
+}
+
+static irqreturn_t rn5t618_adc_irq(int irq, void *data)
+{
+	struct rn5t618_adc_data *adc = data;
+	unsigned int r = 0;
+	int ret;
+
+	/* clear low & high threshold irqs */
+	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC1, 0);
+	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC2, 0);
+
+	ret = regmap_read(adc->rn5t618->regmap, RN5T618_IR_ADC3, &r);
+	if (ret < 0)
+		dev_err(adc->dev, "failed to read IRQ status: %d\n", ret);
+
+	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC3, 0);
+
+	if (r & ADCEND_IRQ)
+		complete(&adc->conv_completion);
+
+	return IRQ_HANDLED;
+}
+
+static int rn5t618_adc_read(struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct rn5t618_adc_data *adc = iio_priv(iio_dev);
+	u16 raw;
+	int ret;
+
+	/* select channel */
+	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
+				 ADCCNT3_CHANNEL_MASK,
+				 chan->channel);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(adc->rn5t618->regmap, RN5T618_EN_ADCIR3, ADCEND_IRQ);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
+				 ADCCNT3_AVG,
+				 mask == IIO_CHAN_INFO_AVERAGE_RAW ?
+				 ADCCNT3_AVG : 0);
+	if (ret < 0)
+		return ret;
+
+	init_completion(&adc->conv_completion);
+	/* single conversion */
+	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
+				 ADCCNT3_GODONE, ADCCNT3_GODONE);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_timeout(&adc->conv_completion,
+					  RN5T618_ADC_CONVERSION_TIMEOUT);
+	if (ret == 0) {
+		dev_warn(adc->dev, "timeout waiting for adc result\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = rn5t618_read_adc_reg(adc->rn5t618,
+				   RN5T618_ILIMDATAH + 2 * chan->channel,
+				   &raw);
+	if (ret < 0)
+		return ret;
+
+	*val = raw;
+	if (mask == IIO_CHAN_INFO_PROCESSED)
+		*val = *val * REFERENCE_VOLT *
+		       rn5t618_ratios[chan->channel].numerator /
+		       rn5t618_ratios[chan->channel].denominator / 4095;
+
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info rn5t618_adc_iio_info = {
+	.read_raw = &rn5t618_adc_read,
+};
+
+#define RN5T618_ADC_CHANNEL(_channel, _type, _name) { \
+	.type = _type, \
+	.channel = _channel, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
+			      BIT(IIO_CHAN_INFO_PROCESSED), \
+	.datasheet_name = _name, \
+	.indexed = 1. \
+}
+
+static const struct iio_chan_spec rn5t618_adc_iio_channels[] = {
+	RN5T618_ADC_CHANNEL(0, IIO_CURRENT, "LIMMON"),
+	RN5T618_ADC_CHANNEL(1, IIO_VOLTAGE, "VBAT"),
+	RN5T618_ADC_CHANNEL(2, IIO_VOLTAGE, "VADP"),
+	RN5T618_ADC_CHANNEL(3, IIO_VOLTAGE, "VUSB"),
+	RN5T618_ADC_CHANNEL(4, IIO_VOLTAGE, "VSYS"),
+	RN5T618_ADC_CHANNEL(5, IIO_VOLTAGE, "VTHM"),
+	RN5T618_ADC_CHANNEL(6, IIO_VOLTAGE, "AIN1"),
+	RN5T618_ADC_CHANNEL(7, IIO_VOLTAGE, "AIN0")
+};
+
+static int rn5t618_adc_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct iio_dev *iio_dev;
+	struct rn5t618_adc_data *adc;
+	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
+
+	iio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
+	if (!iio_dev) {
+		dev_err(&pdev->dev, "failed allocating iio device\n");
+		return -ENOMEM;
+	}
+
+	adc = iio_priv(iio_dev);
+	adc->dev = &pdev->dev;
+	adc->rn5t618 = rn5t618;
+	adc->irq = -ENOENT;
+
+	if (rn5t618->irq_data)
+		adc->irq = regmap_irq_get_virq(rn5t618->irq_data,
+					       RN5T618_IRQ_ADC);
+
+	if (adc->irq  < 0) {
+		dev_err(&pdev->dev, "get virq failed\n");
+		return adc->irq;
+	}
+
+	init_completion(&adc->conv_completion);
+
+	iio_dev->name = dev_name(&pdev->dev);
+	iio_dev->dev.parent = &pdev->dev;
+	iio_dev->info = &rn5t618_adc_iio_info;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->channels = rn5t618_adc_iio_channels;
+	iio_dev->num_channels = ARRAY_SIZE(rn5t618_adc_iio_channels);
+
+	/* stop any auto-conversion */
+	ret = regmap_write(rn5t618->regmap, RN5T618_ADCCNT3, 0);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, iio_dev);
+
+	ret = request_threaded_irq(adc->irq, NULL,
+				   rn5t618_adc_irq,
+				   IRQF_ONESHOT, dev_name(adc->dev),
+				   adc);
+	if (ret < 0) {
+		dev_err(adc->dev, "request irq %d failed: %d\n", adc->irq, ret);
+		return ret;
+	}
+
+	ret = iio_device_register(iio_dev);
+	if (ret < 0)
+		free_irq(adc->irq, adc);
+
+	return ret;
+}
+
+static int rn5t618_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *iio_dev = platform_get_drvdata(pdev);
+	struct rn5t618_adc_data *adc = iio_priv(iio_dev);
+
+	iio_device_unregister(iio_dev);
+	free_irq(adc->irq, adc);
+
+	return 0;
+}
+
+static struct platform_driver rn5t618_adc_driver = {
+	.driver = {
+		.name   = "rn5t618-adc",
+	},
+	.probe = rn5t618_adc_probe,
+	.remove = rn5t618_adc_remove,
+};
+
+module_platform_driver(rn5t618_adc_driver);
+MODULE_ALIAS("platform:rn5t618-adc");
+MODULE_DESCRIPTION("RICOH RN5T618 ADC driver");
+MODULE_LICENSE("GPL");
+
-- 
2.20.1

