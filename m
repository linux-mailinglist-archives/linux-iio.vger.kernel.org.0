Return-Path: <linux-iio+bounces-8866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB3964480
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4023C1C24731
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278711A4F2D;
	Thu, 29 Aug 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q3m7R+V8"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B31195FF1;
	Thu, 29 Aug 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934729; cv=none; b=jwysdCmdlAvcFgi5wKEQyNgd/iaUtdl1M+EiPZVE5wB3oJtwLfBIJJ95JUaYivJaPEAsd0NvdhkdGlu/G8ZJEFXsl77Oavyk4M5Z6XBsfYljAMkl54PJS0IJPMvCQ7lFPBsC3hGLAgEAzOiHDTOXfOGArI5xPuWk2CaDoR6c6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934729; c=relaxed/simple;
	bh=c9oX4Z2GuO5mis0hHIYhVujHcM442NdvRqb8uaqvjPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBo6IvfxaqIaCNFyDr7+/NGPdoUaaMik1w9xFArnewN1uVNROrB5EtQaeiSMOrLc2LCjzie1/pfhGvFI5bzaTUkTNBWsdajVsdQid3locOfN1OTOVwNNzZtXNQf2gFRkfoWJEZHgfj8SLcdZ/mK8LD0mESJ6TscxA0upB5doECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q3m7R+V8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4AA01C0008;
	Thu, 29 Aug 2024 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724934725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1V6nak1uzU7aSo/ZPtJjhUGrBEZ/xxKZ0bhyJyeSq/s=;
	b=Q3m7R+V8+6lzZa66iHc6WKDp6zVacsy9m9q8z7VB5fc8e5z8fVLUAyoR/9i5mQCKrPmIKW
	QklO5JMWoYbs/FZD4F/JklIemxqLeFeiIPQ5IR9EiUr7WLEvAd2SO4/Ri/XhNeC8oIpctD
	UszyK16rJRqQeC+30Au9b7z7ypkj2NyVfEaDUcdmU3uCy04xlWl50z+lpn4AsR/CZxMQg9
	SxCbCXPxxb85aB1red9v3JPzALtoqp084qH+lnCwe6/x/n+lRfsfHdygUoU+3cIwHOOD1Z
	LrHmz79lW3X4fu0BawpWTyk8C3drsuub95JAUYWnofU4jFAYS3hYI5LDUqJU4w==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 29 Aug 2024 14:31:51 +0200
Subject: [PATCH v5 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV1800B SARADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
In-Reply-To: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.bonnefille@bootlin.com

This adds a driver for the Sophgo CV1800B SARADC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 drivers/iio/adc/Kconfig              |  10 ++
 drivers/iio/adc/Makefile             |   1 +
 drivers/iio/adc/sophgo-cv1800b-adc.c | 218 +++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f60fe85a30d5..b081cfd0ab26 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1156,6 +1156,16 @@ config SC27XX_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called sc27xx_adc.
 
+config SOPHGO_CV1800B_ADC
+	tristate "Sophgo CV1800B SARADC"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Say yes here to build support for the SARADC integrated inside
+	  the Sophgo CV1800B SoC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called sophgo_cv1800b_adc.
+
 config SPEAR_ADC
 	tristate "ST SPEAr ADC"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d370e066544e..c4d362a99674 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
+obj-$(CONFIG_SOPHGO_CV1800B_ADC) += sophgo-cv1800b-adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
diff --git a/drivers/iio/adc/sophgo-cv1800b-adc.c b/drivers/iio/adc/sophgo-cv1800b-adc.c
new file mode 100644
index 000000000000..f4cdec966694
--- /dev/null
+++ b/drivers/iio/adc/sophgo-cv1800b-adc.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Sophgo CV1800B SARADC Driver
+ *
+ *  Copyright (C) Bootlin 2024
+ *  Author: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/iio/iio.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#define CV1800B_ADC_CTRL_REG				0x04
+#define	  CV1800B_ADC_EN				BIT(0)
+#define	  CV1800B_ADC_SEL(x)				BIT((x) + 5)
+#define CV1800B_ADC_STATUS_REG				0x08
+#define	  CV1800B_ADC_BUSY				BIT(0)
+#define CV1800B_ADC_CYC_SET_REG				0x0C
+#define   CV1800B_MASK_STARTUP_CYCLE			GENMASK(4, 0)
+#define   CV1800B_MASK_SAMPLE_WINDOW			GENMASK(11, 8)
+#define   CV1800B_MASK_CLKDIV				GENMASK(15, 12)
+#define   CV1800B_MASK_COMPARE_CYCLE			GENMASK(19, 16)
+#define CV1800B_ADC_CH_RESULT_REG(x)			(0x14 + 4 * (x))
+#define	  CV1800B_ADC_CH_RESULT				GENMASK(11, 0)
+#define	  CV1800B_ADC_CH_VALID				BIT(15)
+#define CV1800B_ADC_INTR_EN_REG				0x20
+#define CV1800B_ADC_INTR_CLR_REG			0x24
+#define	  CV1800B_ADC_INTR_CLR_BIT			BIT(0)
+#define CV1800B_ADC_INTR_STA_REG			0x28
+#define	  CV1800B_ADC_INTR_STA_BIT			BIT(0)
+#define CV1800B_READ_TIMEOUT_MS				1000
+#define CV1800B_READ_TIMEOUT_US				(CV1800B_READ_TIMEOUT_MS * 1000)
+
+#define CV1800B_ADC_CHANNEL(index)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = index,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.scan_index = index,					\
+	}
+
+struct cv1800b_adc {
+	struct completion completion;
+	void __iomem *regs;
+	struct mutex lock; /* ADC Control and Result register */
+	struct clk *clk;
+	int irq;
+};
+
+static const struct iio_chan_spec sophgo_channels[] = {
+	CV1800B_ADC_CHANNEL(0),
+	CV1800B_ADC_CHANNEL(1),
+	CV1800B_ADC_CHANNEL(2),
+};
+
+static void cv1800b_adc_start_measurement(struct cv1800b_adc *saradc,
+					  int channel)
+{
+	writel(0, saradc->regs + CV1800B_ADC_CTRL_REG);
+	writel(CV1800B_ADC_SEL(channel) | CV1800B_ADC_EN,
+	       saradc->regs + CV1800B_ADC_CTRL_REG);
+}
+
+static int cv1800b_adc_wait(struct cv1800b_adc *saradc)
+{
+	if (saradc->irq < 0) {
+		u32 reg;
+
+		return readl_poll_timeout(saradc->regs + CV1800B_ADC_STATUS_REG,
+					  reg, !(reg & CV1800B_ADC_BUSY),
+					  500, CV1800B_READ_TIMEOUT_US);
+	}
+
+	return wait_for_completion_timeout(&saradc->completion,
+					  msecs_to_jiffies(CV1800B_READ_TIMEOUT_MS)) > 0
+					  ? 0 : -ETIMEDOUT;
+}
+
+static int cv1800b_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct cv1800b_adc *saradc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:{
+		u32 sample;
+
+		scoped_guard(mutex, &saradc->lock) {
+			int ret;
+
+			cv1800b_adc_start_measurement(saradc, chan->scan_index);
+			ret = cv1800b_adc_wait(saradc);
+			if (ret < 0)
+				return ret;
+
+			sample = readl(saradc->regs + CV1800B_ADC_CH_RESULT_REG(chan->scan_index));
+		}
+		if (!(sample & CV1800B_ADC_CH_VALID))
+			return -ENODATA;
+
+		*val = sample & CV1800B_ADC_CH_RESULT;
+		return IIO_VAL_INT;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 3300;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		u32 status_reg = readl(saradc->regs + CV1800B_ADC_CYC_SET_REG);
+		int clk_div = (1 + FIELD_GET(CV1800B_MASK_CLKDIV, status_reg));
+		int freq = clk_get_rate(saradc->clk) / clk_div;
+		int nb_startup_cycle = 1 + FIELD_GET(CV1800B_MASK_STARTUP_CYCLE, status_reg);
+		int nb_sample_cycle = 1 + FIELD_GET(CV1800B_MASK_SAMPLE_WINDOW, status_reg);
+		int nb_compare_cycle = 1 + FIELD_GET(CV1800B_MASK_COMPARE_CYCLE, status_reg);
+
+		*val = freq / (nb_startup_cycle + nb_sample_cycle + nb_compare_cycle);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t cv1800b_adc_interrupt_handler(int irq, void *private)
+{
+	struct cv1800b_adc *saradc = private;
+	u32 reg = readl(saradc->regs + CV1800B_ADC_INTR_STA_REG);
+
+	if (!(FIELD_GET(CV1800B_ADC_INTR_STA_BIT, reg)))
+		return IRQ_NONE;
+
+	writel(CV1800B_ADC_INTR_CLR_BIT, saradc->regs + CV1800B_ADC_INTR_CLR_REG);
+	complete(&saradc->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info cv1800b_adc_info = {
+	.read_raw = &cv1800b_adc_read_raw,
+};
+
+static int cv1800b_adc_probe(struct platform_device *pdev)
+{
+	struct cv1800b_adc *saradc;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	saradc = iio_priv(indio_dev);
+	indio_dev->name = "sophgo-cv1800b-adc";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &cv1800b_adc_info;
+	indio_dev->num_channels = ARRAY_SIZE(sophgo_channels);
+	indio_dev->channels = sophgo_channels;
+
+	saradc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(saradc->clk))
+		return PTR_ERR(saradc->clk);
+
+	saradc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(saradc->regs))
+		return PTR_ERR(saradc->regs);
+
+	saradc->irq = platform_get_irq_optional(pdev, 0);
+	if (saradc->irq >= 0) {
+		init_completion(&saradc->completion);
+		ret = devm_request_irq(&pdev->dev, saradc->irq,
+				       cv1800b_adc_interrupt_handler, 0,
+				       dev_name(&pdev->dev), saradc);
+		if (ret)
+			return ret;
+
+		writel(1, saradc->regs + CV1800B_ADC_INTR_EN_REG);
+	}
+
+	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
+	if (ret)
+		return ret;
+	writel(FIELD_PREP(CV1800B_MASK_STARTUP_CYCLE, 15) |
+	       FIELD_PREP(CV1800B_MASK_SAMPLE_WINDOW, 15) |
+	       FIELD_PREP(CV1800B_MASK_CLKDIV, 1) |
+	       FIELD_PREP(CV1800B_MASK_COMPARE_CYCLE, 15),
+	       saradc->regs + CV1800B_ADC_CYC_SET_REG);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct of_device_id cv1800b_adc_match[] = {
+	{ .compatible = "sophgo,cv1800b-saradc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cv1800b_adc_match);
+
+static struct platform_driver cv1800b_adc_driver = {
+	.driver	= {
+		.name		= "sophgo-cv1800b-saradc",
+		.of_match_table	= cv1800b_adc_match,
+	},
+	.probe = cv1800b_adc_probe,
+};
+module_platform_driver(cv1800b_adc_driver);
+
+MODULE_AUTHOR("Thomas Bonnefille <thomas.bonnefille@bootlin.com>");
+MODULE_DESCRIPTION("Sophgo CV1800B SARADC driver");
+MODULE_LICENSE("GPL");

-- 
2.46.0


