Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4310E130525
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2020 01:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAEAKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jan 2020 19:10:43 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42367 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgAEAKn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jan 2020 19:10:43 -0500
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A885E1C0005;
        Sun,  5 Jan 2020 00:10:39 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
Date:   Sun,  5 Jan 2020 01:16:37 +0100
Message-Id: <20200105001639.142061-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200105001639.142061-1-contact@artur-rojek.eu>
References: <20200105001639.142061-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Implement support for the touchscreen mode found in JZ47xx SoCs ADC.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/Kconfig       |   3 +
 drivers/iio/adc/ingenic-adc.c | 120 +++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5d8540b7b427..dabbf15032af 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -446,6 +446,9 @@ config INA2XX_ADC
 config INGENIC_ADC
 	tristate "Ingenic JZ47xx SoCs ADC driver"
 	depends on MIPS || COMPILE_TEST
+	select IIO_BUFFER
+	select IIO_BUFFER_CB
+	select IIO_KFIFO_BUF
 	help
 	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.
 
diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 7a24bc1dabe1..4dbf15fdd95d 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -8,7 +8,10 @@
 
 #include <dt-bindings/iio/adc/ingenic,adc.h>
 #include <linux/clk.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -20,6 +23,8 @@
 #define JZ_ADC_REG_CFG			0x04
 #define JZ_ADC_REG_CTRL			0x08
 #define JZ_ADC_REG_STATUS		0x0c
+#define JZ_ADC_REG_ADSAME		0x10
+#define JZ_ADC_REG_ADWAIT		0x14
 #define JZ_ADC_REG_ADTCH		0x18
 #define JZ_ADC_REG_ADBDAT		0x1c
 #define JZ_ADC_REG_ADSDAT		0x20
@@ -28,6 +33,9 @@
 #define JZ_ADC_REG_ENABLE_PD		BIT(7)
 #define JZ_ADC_REG_CFG_AUX_MD		(BIT(0) | BIT(1))
 #define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
+#define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
+#define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
+#define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
 #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
 #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
 #define JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB	8
@@ -44,6 +52,14 @@
 #define JZ4770_ADC_BATTERY_VREF			6600
 #define JZ4770_ADC_BATTERY_VREF_BITS		12
 
+#define JZ_ADC_IRQ_AUX			BIT(0)
+#define JZ_ADC_IRQ_BATTERY		BIT(1)
+#define JZ_ADC_IRQ_TOUCH		BIT(2)
+#define JZ_ADC_IRQ_PEN_DOWN		BIT(3)
+#define JZ_ADC_IRQ_PEN_UP		BIT(4)
+#define JZ_ADC_IRQ_PEN_DOWN_SLEEP	BIT(5)
+#define JZ_ADC_IRQ_SLEEP		BIT(7)
+
 struct ingenic_adc;
 
 struct ingenic_adc_soc_data {
@@ -411,6 +427,30 @@ static const struct iio_info ingenic_adc_info = {
 };
 
 static const struct iio_chan_spec ingenic_channels[] = {
+	{
+		.extend_name = "touchscreen_xp",
+		.type = IIO_POSITIONRELATIVE,
+		.indexed = 1,
+		.channel = INGENIC_ADC_TOUCH_XP,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16
+		},
+	},
+	{
+		.extend_name = "touchscreen_yp",
+		.type = IIO_POSITIONRELATIVE,
+		.indexed = 1,
+		.channel = INGENIC_ADC_TOUCH_YP,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16
+		},
+	},
 	{
 		.extend_name = "aux",
 		.type = IIO_VOLTAGE,
@@ -418,6 +458,7 @@ static const struct iio_chan_spec ingenic_channels[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
 		.channel = INGENIC_ADC_AUX,
+		.scan_index = -1
 	},
 	{
 		.extend_name = "battery",
@@ -428,6 +469,7 @@ static const struct iio_chan_spec ingenic_channels[] = {
 						BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
 		.channel = INGENIC_ADC_BATTERY,
+		.scan_index = -1
 	},
 	{ /* Must always be last in the array. */
 		.extend_name = "aux2",
@@ -436,16 +478,70 @@ static const struct iio_chan_spec ingenic_channels[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
 		.channel = INGENIC_ADC_AUX2,
+		.scan_index = -1
 	},
 };
 
+static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
+{
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+
+	clk_enable(adc->clk);
+	/* It takes significant time for the touchscreen hw to stabilize. */
+	msleep(50);
+	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK,
+			       JZ_ADC_REG_CFG_SAMPLE_NUM(4) |
+			       JZ_ADC_REG_CFG_PULL_UP(4));
+	writew(80, adc->base + JZ_ADC_REG_ADWAIT);
+	writew(2, adc->base + JZ_ADC_REG_ADSAME);
+	writeb((u8)~JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_CTRL);
+	writel(0, adc->base + JZ_ADC_REG_ADTCH);
+	ingenic_adc_enable(adc, 2, true);
+
+	return 0;
+}
+
+static int ingenic_adc_buffer_disable(struct iio_dev *iio_dev)
+{
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+
+	ingenic_adc_enable(adc, 2, false);
+	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
+	writeb(0xff, adc->base + JZ_ADC_REG_STATUS);
+	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK, 0);
+	writew(0, adc->base + JZ_ADC_REG_ADSAME);
+	writew(0, adc->base + JZ_ADC_REG_ADWAIT);
+	clk_disable(adc->clk);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ingenic_buffer_setup_ops = {
+	.postenable = &ingenic_adc_buffer_enable,
+	.predisable = &ingenic_adc_buffer_disable
+};
+
+static irqreturn_t ingenic_adc_irq(int irq, void *data)
+{
+	struct iio_dev *iio_dev = data;
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+	u32 tdat;
+
+	tdat = readl(adc->base + JZ_ADC_REG_ADTCH);
+	iio_push_to_buffers(iio_dev, &tdat);
+	writeb(JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_STATUS);
+
+	return IRQ_HANDLED;
+}
+
 static int ingenic_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iio_dev *iio_dev;
 	struct ingenic_adc *adc;
 	const struct ingenic_adc_soc_data *soc_data;
-	int ret;
+	struct iio_buffer *buffer;
+	int irq, ret;
 
 	soc_data = device_get_match_data(dev);
 	if (!soc_data)
@@ -460,6 +556,18 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	mutex_init(&adc->aux_lock);
 	adc->soc_data = soc_data;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Failed to get irq: %d\n", irq);
+		return irq;
+	}
+	ret = devm_request_irq(dev, irq, ingenic_adc_irq, 0,
+			       dev_name(dev), iio_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to request irq: %d\n", ret);
+		return ret;
+	}
+
 	adc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
@@ -499,7 +607,8 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 
 	iio_dev->dev.parent = dev;
 	iio_dev->name = "jz-adc";
-	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	iio_dev->setup_ops = &ingenic_buffer_setup_ops;
 	iio_dev->channels = ingenic_channels;
 	iio_dev->num_channels = ARRAY_SIZE(ingenic_channels);
 	/* Remove AUX2 from the list of supported channels. */
@@ -507,6 +616,13 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 		iio_dev->num_channels -= 1;
 	iio_dev->info = &ingenic_adc_info;
 
+	buffer = devm_iio_kfifo_allocate(dev);
+	if (!buffer) {
+		dev_err(dev, "Unable to add IIO buffer\n");
+		return -ENOMEM;
+	}
+	iio_device_attach_buffer(iio_dev, buffer);
+
 	ret = devm_iio_device_register(dev, iio_dev);
 	if (ret)
 		dev_err(dev, "Unable to register IIO device\n");
-- 
2.24.1

