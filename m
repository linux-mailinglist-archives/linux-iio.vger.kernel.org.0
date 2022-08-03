Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B324588972
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiHCJ3U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiHCJ3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 05:29:11 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCF5A15D;
        Wed,  3 Aug 2022 02:29:09 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F83120089C;
        Wed,  3 Aug 2022 11:29:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0259200891;
        Wed,  3 Aug 2022 11:29:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2E6901820F56;
        Wed,  3 Aug 2022 17:29:06 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        haibo.chen@nxp.com
Subject: [PATCH 1/3] iio: adc: add imx93 adc support
Date:   Wed,  3 Aug 2022 17:12:25 +0800
Message-Id: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The ADC in i.mx93 is a total new ADC IP, add a driver to support
this ADC.

Currently, only support one shot normal conversion triggered by
software. For other mode, will add in future.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 MAINTAINERS                 |   4 +-
 drivers/iio/adc/Kconfig     |  10 +
 drivers/iio/adc/Makefile    |   1 +
 drivers/iio/adc/imx93_adc.c | 448 ++++++++++++++++++++++++++++++++++++
 4 files changed, 462 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/adc/imx93_adc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 779f599f9abf..b0724635fb49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14620,14 +14620,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 F:	drivers/iio/adc/imx8qxp-adc.c
 
-NXP i.MX 7D/6SX/6UL AND VF610 ADC DRIVER
+NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
 L:	linux-iio@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
 F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
+F:	Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
 F:	drivers/iio/adc/imx7d_adc.c
+F:	drivers/iio/adc/imx93_adc.c
 F:	drivers/iio/adc/vf610_adc.c
 
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7fe5930891e0..95399a0acbf4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -550,6 +550,16 @@ config IMX8QXP_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called imx8qxp-adc.
 
+config IMX93_ADC
+	tristate "IMX93 ADC driver"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to build support for IMX93 ADC.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called imx93_adc.
+
 config LP8788_ADC
 	tristate "LP8788 ADC driver"
 	depends on MFD_LP8788
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1772a549a3c8..64e17b21228b 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_HI8435) += hi8435.o
 obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
+obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
 obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
new file mode 100644
index 000000000000..6e3cf6d3e629
--- /dev/null
+++ b/drivers/iio/adc/imx93_adc.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP i.MX93 ADC driver
+ *
+ * Copyright 2022 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#define IMX93_ADC_DRIVER_NAME	"imx93-adc"
+
+/* Register map definition */
+#define IMX93_ADC_MCR		0x00
+#define IMX93_ADC_MSR		0x04
+#define IMX93_ADC_ISR		0x10
+#define IMX93_ADC_IMR		0x20
+#define IMX93_ADC_CIMR0		0x24
+#define IMX93_ADC_CTR0		0x94
+#define IMX93_ADC_NCMR0		0xA4
+#define IMX93_ADC_PCDR0		0x100
+#define IMX93_ADC_PCDR1		0x104
+#define IMX93_ADC_PCDR2		0x108
+#define IMX93_ADC_PCDR3		0x10c
+#define IMX93_ADC_PCDR4		0x110
+#define IMX93_ADC_PCDR5		0x114
+#define IMX93_ADC_PCDR6		0x118
+#define IMX93_ADC_PCDR7		0x11c
+#define IMX93_ADC_CALSTAT	0x39C
+
+/* ADC bit shift */
+#define IMX93_ADC_MCR_MODE_MASK			BIT(29)
+#define IMX93_ADC_MCR_NSTART_MASK		BIT(24)
+#define IMX93_ADC_MCR_CALSTART_MASK		BIT(14)
+#define IMX93_ADC_MCR_ADCLKSE_MASK		BIT(8)
+#define IMX93_ADC_MCR_PWDN_MASK			BIT(0)
+#define IMX93_ADC_MSR_CALFAIL_MASK		BIT(30)
+#define IMX93_ADC_MSR_CALBUSY_MASK		BIT(29)
+#define IMX93_ADC_MSR_ADCSTATUS_MASK		GENMASK(2, 0)
+#define IMX93_ADC_ISR_EOC_MASK			BIT(1)
+#define IMX93_ADC_IMR_JEOC_MASK			BIT(3)
+#define IMX93_ADC_IMR_JECH_MASK			BIT(2)
+#define IMX93_ADC_IMR_EOC_MASK			BIT(1)
+#define IMX93_ADC_IMR_ECH_MASK			BIT(0)
+#define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
+
+/* ADC status */
+#define IDLE			0
+#define POWER_DOWN		1
+#define WAIT_STATE		2
+#define BUSY_IN_CALIBRATION	3
+#define SAMPLE			4
+#define CONVERSION		6
+
+#define IMX93_ADC_TIMEOUT		msecs_to_jiffies(100)
+
+struct imx93_adc {
+	struct device *dev;
+	void __iomem *regs;
+	struct clk *ipg_clk;
+	struct regulator *vref;
+	struct mutex lock;
+	struct completion completion;
+};
+
+#define IMX93_ADC_CHAN(_idx) {					\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+static const struct iio_chan_spec imx93_adc_iio_channels[] = {
+	IMX93_ADC_CHAN(0),
+	IMX93_ADC_CHAN(1),
+	IMX93_ADC_CHAN(2),
+	IMX93_ADC_CHAN(3),
+};
+
+static void imx93_adc_power_down(struct imx93_adc *adc)
+{
+	u32 mcr, msr;
+	int ret;
+
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr |= FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	ret = readl_poll_timeout(adc->regs + IMX93_ADC_MSR, msr,
+		((msr & IMX93_ADC_MSR_ADCSTATUS_MASK) == POWER_DOWN), 1, 50);
+	if (ret == -ETIMEDOUT)
+		dev_warn(adc->dev,
+			 "ADC do not in power down mode, current MSR is %x\n",
+			 msr);
+}
+
+static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
+{
+	u32 mcr;
+
+	/* put adc in power down mode */
+	imx93_adc_power_down(adc);
+
+	/* config the AD_CLK equal to bus clock */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr |= FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	/* bring ADC out of power down state, in idle state */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+}
+
+static int imx93_adc_calibration(struct imx93_adc *adc)
+{
+	u32 mcr, msr, adc_status;
+	int ret;
+
+	/* make sure ADC in power down mode */
+	msr = readl(adc->regs + IMX93_ADC_MSR);
+	adc_status = FIELD_GET(IMX93_ADC_MSR_ADCSTATUS_MASK, msr);
+	if (adc_status != POWER_DOWN)
+		imx93_adc_power_down(adc);
+
+	/* config SAR controller operating clock */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	/* bring ADC out of power down state */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	/*
+	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
+	 * can add the setting of these bit if need in future.
+	 */
+
+	/* run calibration */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr |= FIELD_PREP(IMX93_ADC_MCR_CALSTART_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	/* wait calibration to be finished */
+	ret = readl_poll_timeout(adc->regs + IMX93_ADC_MSR, msr,
+		!(msr & IMX93_ADC_MSR_CALBUSY_MASK), 1000, 2000000);
+	if (ret == -ETIMEDOUT) {
+		dev_warn(adc->dev, "ADC do not finish calibration in 1 min!\n");
+		return ret;
+	}
+
+	/* check whether calbration is success or not */
+	msr = readl(adc->regs + IMX93_ADC_MSR);
+	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
+		dev_warn(adc->dev, "ADC calibration failed!\n");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static int imx93_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct imx93_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+	u32 channel;
+	u32 imr, mcr, pcda;
+	long ret;
+	u32 vref_uv;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		pm_runtime_get_sync(dev);
+		mutex_lock(&adc->lock);
+
+		reinit_completion(&adc->completion);
+
+		/* config channel mask register */
+		channel = 1 << chan->channel;
+		writel(channel, adc->regs + IMX93_ADC_NCMR0);
+
+		/* TODO: can config desired sample time in CTRn if need */
+
+		/* config interrupt mask */
+		imr = FIELD_PREP(IMX93_ADC_IMR_EOC_MASK, 1);
+		writel(imr, adc->regs + IMX93_ADC_IMR);
+		writel(channel, adc->regs + IMX93_ADC_CIMR0);
+
+		/* config one-shot mode */
+		mcr = readl(adc->regs + IMX93_ADC_MCR);
+		mcr &= ~FIELD_PREP(IMX93_ADC_MCR_MODE_MASK, 1);
+		writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+		/* start normal conversion */
+		mcr = readl(adc->regs + IMX93_ADC_MCR);
+		mcr |= FIELD_PREP(IMX93_ADC_MCR_NSTART_MASK, 1);
+		writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+		ret = wait_for_completion_interruptible_timeout(&adc->completion,
+								IMX93_ADC_TIMEOUT);
+		if (ret == 0) {
+			mutex_unlock(&adc->lock);
+			return -ETIMEDOUT;
+		}
+		if (ret < 0) {
+			mutex_unlock(&adc->lock);
+			return ret;
+		}
+
+		pcda = readl(adc->regs + IMX93_ADC_PCDR0 + chan->channel * 4);
+
+		*val = FIELD_GET(IMX93_ADC_PCDR_CDATA_MASK, pcda);
+
+		mutex_unlock(&adc->lock);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_sync_autosuspend(dev);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		vref_uv = regulator_get_voltage(adc->vref);
+		*val = vref_uv / 1000;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(adc->ipg_clk);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t imx93_adc_isr(int irq, void *dev_id)
+{
+	struct imx93_adc *adc = dev_id;
+	u32 isr;
+
+	isr = readl(adc->regs + IMX93_ADC_ISR);
+	writel(isr, adc->regs + IMX93_ADC_ISR);
+
+	if (FIELD_GET(IMX93_ADC_ISR_EOC_MASK, isr))
+		complete(&adc->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info imx93_adc_iio_info = {
+	.read_raw = &imx93_adc_read_raw,
+};
+
+static int imx93_adc_probe(struct platform_device *pdev)
+{
+	struct imx93_adc *adc;
+	struct iio_dev *indio_dev;
+	struct device *dev = &pdev->dev;
+	int irq, ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!indio_dev) {
+		dev_err(dev, "Failed allocating iio device\n");
+		return -ENOMEM;
+	}
+
+	adc = iio_priv(indio_dev);
+	adc->dev = dev;
+
+	mutex_init(&adc->lock);
+	adc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(adc->regs))
+		return PTR_ERR(adc->regs);
+
+	/* The third irq is for ADC conversion usage */
+	irq = platform_get_irq(pdev, 2);
+	if (irq < 0)
+		return irq;
+
+	adc->ipg_clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(adc->ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(adc->ipg_clk),
+				     "Failed getting clock\n");
+
+	adc->vref = devm_regulator_get(dev, "vref");
+	if (IS_ERR(adc->vref))
+		return dev_err_probe(dev, PTR_ERR(adc->vref),
+				     "Failed getting reference voltage\n");
+
+	ret = regulator_enable(adc->vref);
+	if (ret) {
+		dev_err(dev, "Can't enable adc reference top voltage\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	init_completion(&adc->completion);
+
+	indio_dev->name = IMX93_ADC_DRIVER_NAME;
+	indio_dev->info = &imx93_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = imx93_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(imx93_adc_iio_channels);
+
+	ret = clk_prepare_enable(adc->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not prepare or enable the clock.\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(dev, irq, imx93_adc_isr, 0, IMX93_ADC_DRIVER_NAME, adc);
+	if (ret < 0) {
+		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
+		goto error_ipg_clk_disable;
+	}
+
+	ret = imx93_adc_calibration(adc);
+	if (ret < 0)
+		goto error_ipg_clk_disable;
+
+	imx93_adc_config_ad_clk(adc);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "Couldn't register the device.\n");
+		goto error_ipg_clk_disable;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+
+error_ipg_clk_disable:
+	clk_disable_unprepare(adc->ipg_clk);
+	regulator_disable(adc->vref);
+
+	return ret;
+}
+
+static int imx93_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct imx93_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+
+	pm_runtime_get_sync(dev);
+
+	iio_device_unregister(indio_dev);
+	imx93_adc_power_down(adc);
+	clk_disable_unprepare(adc->ipg_clk);
+	regulator_disable(adc->vref);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+
+	return 0;
+}
+
+static int imx93_adc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx93_adc *adc = iio_priv(indio_dev);
+
+	imx93_adc_power_down(adc);
+	clk_disable_unprepare(adc->ipg_clk);
+	regulator_disable(adc->vref);
+
+	return 0;
+}
+
+static int imx93_adc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx93_adc *adc = iio_priv(indio_dev);
+	int ret;
+	u32 mcr;
+
+	ret = regulator_enable(adc->vref);
+	if (ret) {
+		dev_err(dev,
+			"Can't enable adc reference top voltage, err = %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(adc->ipg_clk);
+	if (ret) {
+		dev_err(dev, "Could not prepare or enable clock.\n");
+		goto err_disable_reg;
+	}
+
+	/* bring ADC out of power down state, in idle state */
+	mcr = readl(adc->regs + IMX93_ADC_MCR);
+	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_PWDN_MASK, 1);
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	return 0;
+
+err_disable_reg:
+	regulator_disable(adc->vref);
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(imx93_adc_pm_ops,
+				 imx93_adc_runtime_suspend,
+				 imx93_adc_runtime_resume, NULL);
+
+static const struct of_device_id imx93_adc_match[] = {
+	{ .compatible = "nxp,imx93-adc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx93_adc_match);
+
+static struct platform_driver imx93_adc_driver = {
+	.probe		= imx93_adc_probe,
+	.remove		= imx93_adc_remove,
+	.driver		= {
+		.name	= IMX93_ADC_DRIVER_NAME,
+		.of_match_table = imx93_adc_match,
+		.pm	= pm_ptr(&imx93_adc_pm_ops),
+	},
+};
+
+module_platform_driver(imx93_adc_driver);
+
+MODULE_DESCRIPTION("NXP i.MX93 ADC driver");
+MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

