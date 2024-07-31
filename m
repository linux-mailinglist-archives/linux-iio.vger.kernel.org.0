Return-Path: <linux-iio+bounces-8093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92862942E60
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCAF1F25EF0
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A11B29A4;
	Wed, 31 Jul 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AbeWo9nT"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B071B143F;
	Wed, 31 Jul 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428673; cv=none; b=bRoDPixLocL1LGxRzZqJ5BVNQ0nR3k2jYxdmoawjQHeR86JbrCdVwDOwTuCmvUIVu7xigAlsYTl3FpdjFD0UPsJp4+q7CiUK3fO8DYNdDDMM1z46lFWOhabdgSVnb8Ra/2IsVr6BWCRp9MgGMEPF7J9PVau/rpeZnpSaiTrNRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428673; c=relaxed/simple;
	bh=VGBmEQo2nn7LVz+FCdOawH68ueBW58buK4ypsx2P334=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqBOq7GwNl9afu8lLZluzm8PuQWx1haWdS/OHV2+3SBd+yiyyg10uAkDGkPLPcwosRs9rXeYikuV8FJ/zF4J+1o6yhWnI11xoC1thipWWkzu1NwEi2L/9L/YejyF6JSgF0UOwu/wXwuLiZto9PIEayFQm+ste7yFZF/ZgTWe00M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AbeWo9nT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91A08FF803;
	Wed, 31 Jul 2024 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722428661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYEIoC2tisBYOJ0m+sWdZe9mFaWjS8rQTyx2a5mnQVo=;
	b=AbeWo9nT3W3E5+C+C0FJU+Jq+0zlfbsGhP0tlV6b6nUVhCLPCkFjOv3Vk/0JzrxFUcS6Y2
	tXtsICSzjW2L6/m9TgyIK0Acydi70L0Dz6b1/nb9OdxnM/4wmZusnMZ/tSNFPef8bD5a14
	7zOpCZSGNdVeTOKSyqRaiThkpjYebNkfP4SZT7PIZ1BAHccmycH6ZxXgjrlKRvAC8XB4Ne
	tsNvd4E3U/Y8AzMrDSILPl3tRC0xruM9AZCpmXqF5ImttBBRYFhSE7ydQ2PIOWm535eKIo
	lh/RV4t2+cb4YwsX7QBRKvn/cijRV9WSBYlInclpJfAs5+cniuRPqG+pK8ADjg==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 31 Jul 2024 14:24:15 +0200
Subject: [PATCH v3 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 SARADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-sg2002-adc-v3-2-5ac40a518c0a@bootlin.com>
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
In-Reply-To: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
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

This adds a driver for the common Sophgo SARADC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 drivers/iio/adc/Kconfig             |  10 ++
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/sophgo-cv18xx-adc.c | 206 ++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f60fe85a30d5..10d6570233f5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1156,6 +1156,16 @@ config SC27XX_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called sc27xx_adc.
 
+config SOPHGO_CV18XX_ADC
+	tristate "Sophgo CV18XX series SARADC"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Say yes here to build support for the SARADC integrated inside
+	  the Sophgo CV18XX series SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called sophgo_adc.
+
 config SPEAR_ADC
 	tristate "ST SPEAr ADC"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d370e066544e..24c241b12ef0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
+obj-$(CONFIG_SOPHGO_CV18XX_ADC) += sophgo-cv18xx-adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
diff --git a/drivers/iio/adc/sophgo-cv18xx-adc.c b/drivers/iio/adc/sophgo-cv18xx-adc.c
new file mode 100644
index 000000000000..27e1aac9560f
--- /dev/null
+++ b/drivers/iio/adc/sophgo-cv18xx-adc.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Sophgo CV18XX series SARADC Driver
+ *
+ *  Copyright (C) Bootlin 2024
+ *  Author: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/interrupt.h>
+#include <linux/iio/iio.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#define CV18XX_ADC_CTRL_REG			0x04
+#define		CV18XX_ADC_EN			BIT(0)
+#define		CV18XX_ADC_SEL(x)		BIT((x) + 4)
+#define CV18XX_ADC_STATUS_REG			0x08
+#define		CV18XX_ADC_BUSY			BIT(0)
+#define CV18XX_ADC_CYC_SET_REG			0x0C
+/* The default cycle configuration is set to maximize the accuracy */
+#define		CV18XX_ADC_DEF_STARTUP_CYCLE	0xF
+#define		CV18XX_ADC_DEF_SAMPLE_WINDOW	(0xF << 8)
+#define		CV18XX_ADC_DEF_CLOCK_DIVIDER	(0x1 << 12)
+#define		CV18XX_ADC_DEF_COMPARE_CYCLE	(0xF << 16)
+#define CV18XX_ADC_CH_RESULT_REG(x)		(0x10 + 4 * (x))
+#define		CV18XX_ADC_CH_RESULT		GENMASK(11, 0)
+#define		CV18XX_ADC_CH_VALID		BIT(15)
+#define CV18XX_ADC_INTR_EN_REG			0x20
+#define CV18XX_ADC_INTR_CLR_REG			0x24
+#define		CV18XX_ADC_INTR_CLR_BIT		BIT(0)
+#define CV18XX_ADC_INTR_STA_REG			0x28
+#define		CV18XX_ADC_INTR_STA_BIT		BIT(0)
+
+#define CV18XX_ADC_CHANNEL(index)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = index,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = index,					\
+	}
+
+struct cv18xx_adc {
+	struct completion completion;
+	void __iomem *regs;
+	struct mutex lock; /* ADC Control and Result register */
+	int irq;
+};
+
+static const struct iio_chan_spec sophgo_channels[] = {
+	CV18XX_ADC_CHANNEL(1),
+	CV18XX_ADC_CHANNEL(2),
+	CV18XX_ADC_CHANNEL(3),
+};
+
+static void cv18xx_adc_start_measurement(struct cv18xx_adc *saradc,
+					    int channel)
+{
+	writel(0, saradc->regs + CV18XX_ADC_CTRL_REG);
+	writel(CV18XX_ADC_SEL(channel) | CV18XX_ADC_EN,
+	       saradc->regs + CV18XX_ADC_CTRL_REG);
+}
+
+static int cv18xx_adc_wait(struct cv18xx_adc *saradc)
+{
+	if (saradc->irq < 0) {
+		u32 reg;
+
+		return readl_poll_timeout(saradc->regs + CV18XX_ADC_STATUS_REG,
+					  reg, !(reg & CV18XX_ADC_BUSY),
+					  500, 1000000);
+	}
+	return wait_for_completion_timeout(&saradc->completion,
+					  msecs_to_jiffies(1000)) > 0
+					  ? 0 : -ETIMEDOUT;
+}
+
+static int cv18xx_adc_read_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int *val, int *val2, long mask)
+{
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		{
+		struct cv18xx_adc *saradc = iio_priv(indio_dev);
+		u32 sample;
+		int ret;
+
+		scoped_guard(mutex, &saradc->lock) {
+			cv18xx_adc_start_measurement(saradc, chan->scan_index);
+			ret = cv18xx_adc_wait(saradc);
+			if (ret < 0)
+				return ret;
+
+			sample = readl(saradc->regs + CV18XX_ADC_CH_RESULT_REG(chan->scan_index));
+		}
+		if (!(sample & CV18XX_ADC_CH_VALID))
+			return -ENODATA;
+
+		*val = sample & CV18XX_ADC_CH_RESULT;
+		return IIO_VAL_INT;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 3300;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t cv18xx_adc_interrupt_handler(int irq, void *private)
+{
+	struct cv18xx_adc *saradc = private;
+
+	if (!(FIELD_GET(CV18XX_ADC_INTR_STA_BIT,
+			readl(saradc->regs + CV18XX_ADC_INTR_STA_REG))))
+		return IRQ_NONE;
+
+	writel(CV18XX_ADC_INTR_CLR_BIT, saradc->regs + CV18XX_ADC_INTR_CLR_REG);
+	complete(&saradc->completion);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info cv18xx_adc_info = {
+	.read_raw = &cv18xx_adc_read_raw,
+};
+
+static int cv18xx_adc_probe(struct platform_device *pdev)
+{
+	struct cv18xx_adc *saradc;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	saradc = iio_priv(indio_dev);
+	indio_dev->name = "sophgo-cv18xx-adc";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &cv18xx_adc_info;
+	indio_dev->num_channels = ARRAY_SIZE(sophgo_channels);
+	indio_dev->channels = sophgo_channels;
+
+	ret = IS_ERR(devm_clk_get_enabled(&pdev->dev, NULL));
+	if (ret)
+		return ret;
+
+	saradc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(saradc->regs))
+		return PTR_ERR(saradc->regs);
+
+	saradc->irq = platform_get_irq_optional(pdev, 0);
+	if (saradc->irq >= 0) {
+		init_completion(&saradc->completion);
+		ret = devm_request_irq(&pdev->dev, saradc->irq,
+				       cv18xx_adc_interrupt_handler, 0,
+				       dev_name(&pdev->dev), saradc);
+		if (ret)
+			return ret;
+
+		writel(1, saradc->regs + CV18XX_ADC_INTR_EN_REG);
+	}
+
+	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+	writel(CV18XX_ADC_DEF_STARTUP_CYCLE |
+	       CV18XX_ADC_DEF_SAMPLE_WINDOW |
+	       CV18XX_ADC_DEF_CLOCK_DIVIDER |
+	       CV18XX_ADC_DEF_COMPARE_CYCLE
+	       , saradc->regs + CV18XX_ADC_CYC_SET_REG);
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+
+}
+
+static const struct of_device_id cv18xx_adc_match[] = {
+	{ .compatible = "sophgo,cv1800b-saradc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cv18xx_adc_match);
+
+static struct platform_driver cv18xx_adc_driver = {
+	.driver	= {
+		.name		= "sophgo-saradc",
+		.of_match_table	= cv18xx_adc_match,
+	},
+	.probe = cv18xx_adc_probe,
+};
+module_platform_driver(cv18xx_adc_driver);
+
+MODULE_AUTHOR("Thomas Bonnefille <thomas.bonnefille@bootlin.com>");
+MODULE_DESCRIPTION("Sophgo SARADC driver");
+MODULE_LICENSE("GPL");

-- 
2.45.2


