Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0317D031
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 22:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgCGVGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 16:06:34 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48755 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCGVGd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 16:06:33 -0500
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id ED67340005;
        Sat,  7 Mar 2020 21:06:28 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v4 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
Date:   Sat,  7 Mar 2020 22:14:10 +0100
Message-Id: <20200307211412.44148-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200307211412.44148-1-contact@artur-rojek.eu>
References: <20200307211412.44148-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The SADC component in JZ47xx SoCs provides support for touchscreen
operations (pen position and pen down pressure) in single-ended and
differential modes.

Of the known hardware to use this controller, GCW Zero and Anbernic RG-350
utilize the touchscreen mode by having their joystick(s) attached to the
X/Y positive/negative input pins.
GCW Zero comes with a single joystick and is sufficiently handled with the
currently implemented single-ended mode. Support for boards with two
joysticks, where one is hooked up to Xn/Yn and the other to Xp/Yp channels
will need to be provided in the future.

The touchscreen component of SADC takes a significant time to stabilize
after first receiving the clock and a delay of 50ms has been empirically
proven to be a safe value before data sampling can begin.

All the boards which probe this driver have the interrupt provided from
devicetree, with no need to handle a case where the irq was not provided.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

 Changes:

 v2: - improve description of the touchscreen mode,
     - get rid of the unneeded kfifo,
     - drop IIO_BUFFER_CB from Kconfig,
     - remove extended names from the touchscreen channels

 v3: remove unneeded `linux/iio/kfifo_buf.h` include

 v4: clarify irq provider source in the patch description

 drivers/iio/adc/Kconfig       |   1 +
 drivers/iio/adc/ingenic-adc.c | 109 +++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 82e33082958c..d3fd4b6e2d47 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -453,6 +453,7 @@ config INA2XX_ADC
 config INGENIC_ADC
 	tristate "Ingenic JZ47xx SoCs ADC driver"
 	depends on MIPS || COMPILE_TEST
+	select IIO_BUFFER
 	help
 	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.
 
diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 7a24bc1dabe1..0dafc8d5d0d8 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -8,7 +8,9 @@
 
 #include <dt-bindings/iio/adc/ingenic,adc.h>
 #include <linux/clk.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -20,6 +22,8 @@
 #define JZ_ADC_REG_CFG			0x04
 #define JZ_ADC_REG_CTRL			0x08
 #define JZ_ADC_REG_STATUS		0x0c
+#define JZ_ADC_REG_ADSAME		0x10
+#define JZ_ADC_REG_ADWAIT		0x14
 #define JZ_ADC_REG_ADTCH		0x18
 #define JZ_ADC_REG_ADBDAT		0x1c
 #define JZ_ADC_REG_ADSDAT		0x20
@@ -28,6 +32,9 @@
 #define JZ_ADC_REG_ENABLE_PD		BIT(7)
 #define JZ_ADC_REG_CFG_AUX_MD		(BIT(0) | BIT(1))
 #define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
+#define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
+#define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
+#define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
 #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
 #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
 #define JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB	8
@@ -44,6 +51,14 @@
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
@@ -411,6 +426,28 @@ static const struct iio_info ingenic_adc_info = {
 };
 
 static const struct iio_chan_spec ingenic_channels[] = {
+	{
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
@@ -418,6 +455,7 @@ static const struct iio_chan_spec ingenic_channels[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
 		.channel = INGENIC_ADC_AUX,
+		.scan_index = -1
 	},
 	{
 		.extend_name = "battery",
@@ -428,6 +466,7 @@ static const struct iio_chan_spec ingenic_channels[] = {
 						BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
 		.channel = INGENIC_ADC_BATTERY,
+		.scan_index = -1
 	},
 	{ /* Must always be last in the array. */
 		.extend_name = "aux2",
@@ -436,16 +475,69 @@ static const struct iio_chan_spec ingenic_channels[] = {
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
+	int irq, ret;
 
 	soc_data = device_get_match_data(dev);
 	if (!soc_data)
@@ -460,6 +552,18 @@ static int ingenic_adc_probe(struct platform_device *pdev)
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
@@ -499,7 +603,8 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 
 	iio_dev->dev.parent = dev;
 	iio_dev->name = "jz-adc";
-	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	iio_dev->setup_ops = &ingenic_buffer_setup_ops;
 	iio_dev->channels = ingenic_channels;
 	iio_dev->num_channels = ARRAY_SIZE(ingenic_channels);
 	/* Remove AUX2 from the list of supported channels. */
-- 
2.25.1

