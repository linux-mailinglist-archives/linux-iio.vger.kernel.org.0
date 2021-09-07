Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D0402222
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 04:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbhIGB6t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 21:58:49 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56782 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237547AbhIGB6r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Sep 2021 21:58:47 -0400
Received: from BC-Mail-Ex25.internal.baidu.com (unknown [172.31.51.19])
        by Forcepoint Email with ESMTPS id 6E68A7D0953808D2F6F5;
        Tue,  7 Sep 2021 09:57:38 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex25.internal.baidu.com (172.31.51.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 09:57:38 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 09:57:37 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
Date:   Tue, 7 Sep 2021 09:57:21 +0800
Message-ID: <20210907015724.1377-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907015724.1377-1-caihuoqing@baidu.com>
References: <20210907015724.1377-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex12.internal.baidu.com (172.31.51.52) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC has a new ADC IP. These patches add
driver support for this ADC.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2:	*Squash patches 1, 2, 3, and 5 into a single patch.
	*Add device specific prefix.
	*Remove the brackets around individual numbers.
	*Make use of FIELD_PREP() and FIELD_GET().
	*Remove a lot of cache values.
	*Replace mlock with adc->lock.
	*Move adc->value read from isr to the completion.
	*Set pm_runtime_disable/_put_noidle() before adc_disable.
	*Add error handler-err_disable_reg/err_unprepare_clk.
v2->v3:	*Add "return 0" to adc_runtime_resume().
v1 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-4-caihuoqing@baidu.com/

 drivers/iio/adc/Kconfig       |  10 +
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/imx8qxp-adc.c | 470 ++++++++++++++++++++++++++++++++++
 3 files changed, 481 insertions(+)
 create mode 100644 drivers/iio/adc/imx8qxp-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af168e1c9fdb..fa8ad63d6ac2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -530,6 +530,16 @@ config IMX7D_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called imx7d_adc.
 
+config IMX8QXP_ADC
+	tristate "NXP IMX8QXP ADC driver"
+	depends on ARCH_MXC_ARM64 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to build support for IMX8QXP ADC.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called imx8qxp-adc.
+
 config LP8788_ADC
 	tristate "LP8788 ADC driver"
 	depends on MFD_LP8788
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d68550f493e3..d3f53549720c 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
 obj-$(CONFIG_HI8435) += hi8435.o
 obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
+obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
 obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
new file mode 100644
index 000000000000..9ba77af360f3
--- /dev/null
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP i.MX8QXP ADC driver
+ *
+ * Based on the work of Haibo Chen <haibo.chen@nxp.com>
+ * The initial developer of the original code is Haibo Chen.
+ * Portions created by Haibo Chen are Copyright (C) 2018 NXP.
+ * All Rights Reserved.
+ *
+ * Copyright (C) 2018 NXP
+ * Copyright (C) 2021 Cai Huoqing
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/sysfs.h>
+
+#define ADC_DRIVER_NAME		"imx8qxp-adc"
+
+/* Register map definition */
+#define IMX8QXP_ADR_ADC_CTRL		0x10
+#define IMX8QXP_ADR_ADC_STAT		0x14
+#define IMX8QXP_ADR_ADC_IE		0x18
+#define IMX8QXP_ADR_ADC_DE		0x1c
+#define IMX8QXP_ADR_ADC_CFG		0x20
+#define IMX8QXP_ADR_ADC_FCTRL		0x30
+#define IMX8QXP_ADR_ADC_SWTRIG		0x34
+#define IMX8QXP_ADR_ADC_TCTRL(tid)	(0xc0 + tid * 4)
+#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x100 + cid * 8)
+#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x104 + cid * 8)
+#define IMX8QXP_ADR_ADC_RESFIFO		0x300
+#define IMX8QXP_ADR_ADC_TST		0xffc
+
+/* ADC bit shift */
+#define IMX8QXP_ADC_IE_FWMIE_MASK		GENMASK(1, 0)
+#define IMX8QXP_ADC_CTRL_FIFO_RESET_MASK	BIT(8)
+#define IMX8QXP_ADC_CTRL_SOFTWARE_RESET_MASK	BIT(1)
+#define IMX8QXP_ADC_CTRL_ADC_EN_MASK		BIT(0)
+#define IMX8QXP_ADC_TCTRL_TCMD_MASK		GENMASK(31, 24)
+#define IMX8QXP_ADC_TCTRL_TDLY_MASK		GENMASK(23, 16)
+#define IMX8QXP_ADC_TCTRL_TPRI_MASK		GENMASK(15, 8)
+#define IMX8QXP_ADC_TCTRL_HTEN_MASK		GENMASK(7, 0)
+#define IMX8QXP_ADC_CMDL_CSCALE_MASK		GENMASK(13, 8)
+#define IMX8QXP_ADC_CMDL_MODE_MASK		BIT(7)
+#define IMX8QXP_ADC_CMDL_DIFF_MASK		BIT(6)
+#define IMX8QXP_ADC_CMDL_ABSEL_MASK		BIT(5)
+#define IMX8QXP_ADC_CMDL_ADCH_MASK		GENMASK(2, 0)
+#define IMX8QXP_ADC_CMDH_NEXT_MASK		GENMASK(31, 24)
+#define IMX8QXP_ADC_CMDH_LOOP_MASK		GENMASK(23, 16)
+#define IMX8QXP_ADC_CMDH_AVGS_MASK		GENMASK(15, 12)
+#define IMX8QXP_ADC_CMDH_STS_MASK		BIT(8)
+#define IMX8QXP_ADC_CMDH_LWI_MASK		GENMASK(7, 7)
+#define IMX8QXP_ADC_CMDH_CMPEN_MASK		GENMASK(0, 0)
+#define IMX8QXP_ADC_CFG_PWREN_MASK		BIT(28)
+#define IMX8QXP_ADC_CFG_PUDLY_MASK		GENMASK(23, 16)
+#define IMX8QXP_ADC_CFG_REFSEL_MASK		GENMASK(7, 6)
+#define IMX8QXP_ADC_CFG_PWRSEL_MASK		GENMASK(5, 4)
+#define IMX8QXP_ADC_CFG_TPRICTRL_MASK		GENMASK(3, 0)
+#define IMX8QXP_ADC_FCTRL_FWMARK_MASK		GENMASK(20, 16)
+#define IMX8QXP_ADC_FCTRL_FCOUNT_MASK		GENMASK(4, 0)
+#define IMX8QXP_ADC_RESFIFO_VAL_MASK		GENMASK(18, 3)
+
+/* ADC PARAMETER*/
+#define IMX8QXP_ADC_CMDL_CHANNEL_SCALE_FULL		GENMASK(5, 0)
+#define IMX8QXP_ADC_CMDL_SEL_A_A_B_CHANNEL		0
+#define IMX8QXP_ADC_CMDL_STANDARD_RESOLUTION		0
+#define IMX8QXP_ADC_CMDL_MODE_SINGLE			0
+#define IMX8QXP_ADC_CMDH_LWI_INCREMENT_DIS		0
+#define IMX8QXP_ADC_CMDH_CMPEN_DIS			0
+#define IMX8QXP_ADC_PAUSE_EN				BIT(31)
+#define IMX8QXP_ADC_TCTRL_TPRI_PRIORITY_HIGH		0
+
+#define IMX8QXP_ADC_TCTRL_HTEN_HW_TIRG_DIS		0
+
+#define IMX8QXP_ADC_TIMEOUT		msecs_to_jiffies(100)
+
+struct imx8qxp_adc {
+	struct device *dev;
+	void __iomem *regs;
+	struct clk *clk;
+	struct clk *ipg_clk;
+	struct regulator *vref;
+	struct mutex lock;
+	struct completion completion;
+};
+
+#define IMX8QXP_ADC_CHAN(_idx) {				\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+static const struct iio_chan_spec imx8qxp_adc_iio_channels[] = {
+	IMX8QXP_ADC_CHAN(0),
+	IMX8QXP_ADC_CHAN(1),
+	IMX8QXP_ADC_CHAN(2),
+	IMX8QXP_ADC_CHAN(3),
+	IMX8QXP_ADC_CHAN(4),
+	IMX8QXP_ADC_CHAN(5),
+	IMX8QXP_ADC_CHAN(6),
+	IMX8QXP_ADC_CHAN(7),
+};
+
+static void imx8qxp_adc_reset(struct imx8qxp_adc *adc)
+{
+	u32 ctrl;
+
+	/*software reset, need to clear the set bit*/
+	ctrl = readl(adc->regs + IMX8QXP_ADR_ADC_CTRL);
+	ctrl |= FIELD_PREP(IMX8QXP_ADC_CTRL_SOFTWARE_RESET_MASK, 1);
+	writel(ctrl, adc->regs + IMX8QXP_ADR_ADC_CTRL);
+	udelay(10);
+	ctrl &= ~FIELD_PREP(IMX8QXP_ADC_CTRL_SOFTWARE_RESET_MASK, 1);
+	writel(ctrl, adc->regs + IMX8QXP_ADR_ADC_CTRL);
+
+	/* reset the fifo */
+	ctrl |= FIELD_PREP(IMX8QXP_ADC_CTRL_FIFO_RESET_MASK, 1);
+	writel(ctrl, adc->regs + IMX8QXP_ADR_ADC_CTRL);
+}
+
+static void imx8qxp_adc_reg_config(struct imx8qxp_adc *adc, int channel)
+{
+	u32 adc_cfg, adc_tctrl, adc_cmdl, adc_cmdh;
+
+	/* ADC configuration */
+	adc_cfg = FIELD_PREP(IMX8QXP_ADC_CFG_PWREN_MASK, 1) |
+		  FIELD_PREP(IMX8QXP_ADC_CFG_PUDLY_MASK, 0x80)|
+		  FIELD_PREP(IMX8QXP_ADC_CFG_REFSEL_MASK, 0) |
+		  FIELD_PREP(IMX8QXP_ADC_CFG_PWRSEL_MASK, 3) |
+		  FIELD_PREP(IMX8QXP_ADC_CFG_TPRICTRL_MASK, 0);
+	writel(adc_cfg, adc->regs + IMX8QXP_ADR_ADC_CFG);
+
+	/* config the trigger control */
+	adc_tctrl = FIELD_PREP(IMX8QXP_ADC_TCTRL_TCMD_MASK, 1) |
+		    FIELD_PREP(IMX8QXP_ADC_TCTRL_TDLY_MASK, 0) |
+		    FIELD_PREP(IMX8QXP_ADC_TCTRL_TPRI_MASK, IMX8QXP_ADC_TCTRL_TPRI_PRIORITY_HIGH) |
+		    FIELD_PREP(IMX8QXP_ADC_TCTRL_HTEN_MASK, IMX8QXP_ADC_TCTRL_HTEN_HW_TIRG_DIS);
+	writel(adc_cfg, adc->regs + IMX8QXP_ADR_ADC_TCTRL(0));
+
+	/* config the cmd */
+	adc_cmdl = FIELD_PREP(IMX8QXP_ADC_CMDL_CSCALE_MASK, IMX8QXP_ADC_CMDL_CHANNEL_SCALE_FULL) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDL_MODE_MASK, IMX8QXP_ADC_CMDL_STANDARD_RESOLUTION) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDL_DIFF_MASK, IMX8QXP_ADC_CMDL_MODE_SINGLE) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDL_ABSEL_MASK, IMX8QXP_ADC_CMDL_SEL_A_A_B_CHANNEL) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDL_ADCH_MASK, channel);
+	writel(adc_cmdl, adc->regs + IMX8QXP_ADR_ADC_CMDL(0));
+
+	adc_cmdh = FIELD_PREP(IMX8QXP_ADC_CMDH_NEXT_MASK, 0) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDH_LOOP_MASK, 0) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDH_AVGS_MASK, 7) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDH_STS_MASK, 0) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDH_LWI_MASK, IMX8QXP_ADC_CMDH_LWI_INCREMENT_DIS) |
+		   FIELD_PREP(IMX8QXP_ADC_CMDH_CMPEN_MASK, IMX8QXP_ADC_CMDH_CMPEN_DIS);
+	writel(adc_cmdh, adc->regs + IMX8QXP_ADR_ADC_CMDH(0));
+}
+
+static void imx8qxp_adc_fifo_config(struct imx8qxp_adc *adc)
+{
+	u32 fifo_ctrl, interrupt_en;
+
+	fifo_ctrl = readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL);
+	fifo_ctrl &= ~IMX8QXP_ADC_FCTRL_FWMARK_MASK;
+	/* set the watermark level to 1 */
+	fifo_ctrl |= FIELD_PREP(IMX8QXP_ADC_FCTRL_FWMARK_MASK, 0);
+	writel(fifo_ctrl, adc->regs + IMX8QXP_ADR_ADC_FCTRL);
+
+	/* FIFO Watermark Interrupt Enable */
+	interrupt_en = readl(adc->regs + IMX8QXP_ADR_ADC_IE);
+	interrupt_en |= FIELD_PREP(IMX8QXP_ADC_IE_FWMIE_MASK, 1);
+	writel(interrupt_en, adc->regs + IMX8QXP_ADR_ADC_IE);
+}
+
+static void imx8qxp_adc_disable(struct imx8qxp_adc *adc)
+{
+	u32 ctrl;
+
+	ctrl = readl(adc->regs + IMX8QXP_ADR_ADC_CTRL);
+	ctrl &= ~FIELD_PREP(IMX8QXP_ADC_CTRL_ADC_EN_MASK, 1);
+	writel(ctrl, adc->regs + IMX8QXP_ADR_ADC_CTRL);
+}
+
+static int imx8qxp_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct imx8qxp_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+
+	u32 ctrl, vref_uv;
+	long ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		pm_runtime_get_sync(dev);
+
+		mutex_lock(&adc->lock);
+		reinit_completion(&adc->completion);
+
+		imx8qxp_adc_reg_config(adc, chan->channel);
+
+		imx8qxp_adc_fifo_config(adc);
+
+		/* adc enable */
+		ctrl = readl(adc->regs + IMX8QXP_ADR_ADC_CTRL);
+		ctrl |= FIELD_PREP(IMX8QXP_ADC_CTRL_ADC_EN_MASK, 1);
+		writel(ctrl, adc->regs + IMX8QXP_ADR_ADC_CTRL);
+		/* adc start */
+		writel(1, adc->regs + IMX8QXP_ADR_ADC_SWTRIG);
+
+		ret = wait_for_completion_interruptible_timeout(&adc->completion,
+								IMX8QXP_ADC_TIMEOUT);
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_sync_autosuspend(dev);
+
+		if (ret == 0) {
+			mutex_unlock(&adc->lock);
+			return -ETIMEDOUT;
+		}
+		if (ret < 0) {
+			mutex_unlock(&adc->lock);
+			return ret;
+		}
+
+		*val = FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
+				 readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
+
+		mutex_unlock(&adc->lock);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		vref_uv = regulator_get_voltage(adc->vref);
+		*val = vref_uv / 1000;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(adc->clk) / 3;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
+{
+	struct imx8qxp_adc *adc = (struct imx8qxp_adc *)dev_id;
+
+	u32 fifo_count;
+
+	fifo_count = FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
+			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
+
+	if (fifo_count)
+		complete(&adc->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int imx8qxp_adc_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				  unsigned int writeval, unsigned int *readval)
+{
+	struct imx8qxp_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+
+	if (!readval || reg % 4 || reg > IMX8QXP_ADR_ADC_TST)
+		return -EINVAL;
+
+	pm_runtime_get_sync(dev);
+
+	*readval = readl(adc->regs + reg);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_sync_autosuspend(dev);
+
+	return 0;
+}
+
+static const struct iio_info imx8qxp_adc_iio_info = {
+	.read_raw = &imx8qxp_adc_read_raw,
+	.debugfs_reg_access = &imx8qxp_adc_reg_access,
+};
+
+static int imx8qxp_adc_probe(struct platform_device *pdev)
+{
+	struct imx8qxp_adc *adc;
+	struct iio_dev *indio_dev;
+	struct device *dev = &pdev->dev;
+	int irq;
+	int ret;
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
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	adc->clk = devm_clk_get(dev, "per");
+	if (IS_ERR(adc->clk)) {
+		ret = PTR_ERR(adc->clk);
+		dev_err(dev, "Failed getting clock, err = %d\n", ret);
+		return ret;
+	}
+
+	adc->ipg_clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(adc->ipg_clk)) {
+		ret = PTR_ERR(adc->ipg_clk);
+		dev_err(dev, "Failed getting clock, err = %d\n", ret);
+		return ret;
+	}
+
+	adc->vref = devm_regulator_get(dev, "vref");
+	if (IS_ERR(adc->vref)) {
+		ret = PTR_ERR(adc->vref);
+		dev_err(dev,
+			"Failed getting reference voltage, err = %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	init_completion(&adc->completion);
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &imx8qxp_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = imx8qxp_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(imx8qxp_adc_iio_channels);
+
+	ret = devm_request_irq(dev, irq, imx8qxp_adc_isr, 0, dev_name(dev), adc);
+	if (ret < 0) {
+		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
+		return ret;
+	}
+
+	imx8qxp_adc_reset(adc);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		imx8qxp_adc_disable(adc);
+		dev_err(dev, "Couldn't register the device.\n");
+		return ret;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int imx8qxp_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct imx8qxp_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+
+	pm_runtime_get_sync(dev);
+
+	iio_device_unregister(indio_dev);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+
+	imx8qxp_adc_disable(adc);
+
+	return 0;
+}
+
+static int imx8qxp_adc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx8qxp_adc *adc = iio_priv(indio_dev);
+
+	imx8qxp_adc_disable(adc);
+
+	clk_disable_unprepare(adc->clk);
+	clk_disable_unprepare(adc->ipg_clk);
+	regulator_disable(adc->vref);
+
+	return 0;
+}
+
+static int imx8qxp_adc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx8qxp_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(adc->vref);
+	if (ret) {
+		dev_err(dev, "Can't enable adc reference top voltage, err = %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(adc->clk);
+	if (ret) {
+		dev_err(dev, "Could not prepare or enable clock.\n");
+		goto err_disable_reg;
+	}
+
+	ret = clk_prepare_enable(adc->ipg_clk);
+	if (ret) {
+		dev_err(dev, "Could not prepare or enable clock.\n");
+		goto err_unprepare_clk;
+	}
+	imx8qxp_adc_reset(adc);
+	return 0;
+err_unprepare_clk:
+	clk_disable_unprepare(adc->clk);
+
+err_disable_reg:
+	regulator_disable(adc->vref);
+
+	return ret;
+}
+
+static const struct dev_pm_ops imx8qxp_adc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx8qxp_adc_runtime_suspend, imx8qxp_adc_runtime_resume, NULL)
+};
+
+static const struct of_device_id imx8qxp_adc_match[] = {
+	{ .compatible = "nxp,imx8qxp-adc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx8qxp_adc_match);
+
+static struct platform_driver imx8qxp_adc_driver = {
+	.probe		= imx8qxp_adc_probe,
+	.remove		= imx8qxp_adc_remove,
+	.driver		= {
+		.name	= ADC_DRIVER_NAME,
+		.of_match_table = imx8qxp_adc_match,
+		.pm	= &imx8qxp_adc_pm_ops,
+	},
+};
+
+module_platform_driver(imx8qxp_adc_driver);
+
+MODULE_DESCRIPTION("i.MX8QuadXPlus ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

