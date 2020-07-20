Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D18225C14
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 11:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGTJwD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 05:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgGTJwD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 05:52:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FFE2080D;
        Mon, 20 Jul 2020 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595238722;
        bh=coXwZdwOXFKPGgvX4obwgqWriOmurjihA9v8koqgfps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tFqswkdVHToGKOQktWtN97tpc75JwQemEIHb4ZMioMiGDb84k1ibpNRMS6U76+//V
         0kvt3/en2XJwzVWAG96QlE0PNMX3q0AT4I0/3hmt5kaZgX/f9VfeB52OeYLcaZKtXS
         /Ou8OSSTLWpqbtIT37nyT7USBrHNhDNsxsNOirb4=
Date:   Mon, 20 Jul 2020 10:51:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
Message-ID: <20200720105157.775a2add@archlinux>
In-Reply-To: <20200719205307.87385-5-contact@artur-rojek.eu>
References: <20200719205307.87385-1-contact@artur-rojek.eu>
        <20200719205307.87385-5-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Jul 2020 22:53:07 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> The SADC component in JZ47xx SoCs provides support for touchscreen
> operations (pen position and pen down pressure) in single-ended and
> differential modes.
> 
> The touchscreen component of SADC takes a significant time to stabilize
> after first receiving the clock and a delay of 50ms has been empirically
> proven to be a safe value before data sampling can begin.
> 
> Of the known hardware to use this controller, GCW Zero and Anbernic RG-350
> utilize the touchscreen mode by having their joystick(s) attached to the
> X/Y positive/negative input pins.
> 
> JZ4770 and later SoCs introduce a low-level command feature. With it, up
> to 32 commands can be programmed, each one corresponding to a sampling
> job. It allows to change the low-voltage reference, the high-voltage
> reference, have them connected to VCC, GND, or one of the X-/X+ or Y-/Y+
> pins.
> 
> This patch introduces support for 6 stream-capable channels:
> - channel #0 samples X+/GND
> - channel #1 samples Y+/GND
> - channel #2 samples X-/GND
> - channel #3 samples Y-/GND
> - channel #4 samples X+/X-
> - channel #5 samples Y+/Y-
> 
> Being able to sample X-/GND and Y-/GND is useful on some devices, where
> one joystick is connected to the X+/Y+ pins, and a second joystick is
> connected to the X-/Y- pins.
> 
> All the boards which probe this driver have the interrupt provided from
> Device Tree, with no need to handle a case where the IRQ was not provided.
> 
> Co-developed-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

For this set I've created an immutable branch to allow the option of
Dmitry pulling it into input given the binding for the joystick
set is dependent on a patch in here.  Doesn't matter if not though,
this just gives the option.

Immutable branch:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git ib-5.8-jz47xx-ts

Merged that into the togreg branch of iio.git and pushed out as testing or
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  Changes:
> 
>  v2: - improve description of the touchscreen mode,
>      - get rid of the unneeded kfifo,
>      - drop IIO_BUFFER_CB from Kconfig,
>      - remove extended names from the touchscreen channels
> 
>  v3: remove unneeded `linux/iio/kfifo_buf.h` include
> 
>  v4: clarify irq provider source in the patch description
> 
>  v5: no change
> 
>  v6: - correct the spelling of Device Tree and IRQ in commit message
>      - don't omit trailing commas from initializer lists
>      - error check `clk_enable`
>      - remove redundant `dev_err` from `platform_get_irq` error check
> 
>  v7: no change
> 
>  v8: add support for ADCMD low-level command feature
> 
>  v9: replace IIO_POSITIONRELATIVE with IIO_VOLTAGE for touchscreen
>      channels
> 
>  drivers/iio/adc/Kconfig       |   1 +
>  drivers/iio/adc/ingenic-adc.c | 250 +++++++++++++++++++++++++++++++++-
>  2 files changed, 249 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ff3569635ce0..5b57437cef75 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -500,6 +500,7 @@ config INA2XX_ADC
>  config INGENIC_ADC
>  	tristate "Ingenic JZ47xx SoCs ADC driver"
>  	depends on MIPS || COMPILE_TEST
> +	select IIO_BUFFER
>  	help
>  	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.
>  
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 16fc0974c65c..c5b01766513d 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -8,7 +8,9 @@
>  
>  #include <dt-bindings/iio/adc/ingenic,adc.h>
>  #include <linux/clk.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> @@ -20,19 +22,46 @@
>  #define JZ_ADC_REG_CFG			0x04
>  #define JZ_ADC_REG_CTRL			0x08
>  #define JZ_ADC_REG_STATUS		0x0c
> +#define JZ_ADC_REG_ADSAME		0x10
> +#define JZ_ADC_REG_ADWAIT		0x14
>  #define JZ_ADC_REG_ADTCH		0x18
>  #define JZ_ADC_REG_ADBDAT		0x1c
>  #define JZ_ADC_REG_ADSDAT		0x20
> +#define JZ_ADC_REG_ADCMD		0x24
>  #define JZ_ADC_REG_ADCLK		0x28
>  
>  #define JZ_ADC_REG_ENABLE_PD		BIT(7)
>  #define JZ_ADC_REG_CFG_AUX_MD		(BIT(0) | BIT(1))
>  #define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
> +#define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
> +#define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
> +#define JZ_ADC_REG_CFG_CMD_SEL		BIT(22)
> +#define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
>  #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
>  #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
>  #define JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB	8
>  #define JZ4770_ADC_REG_ADCLK_CLKDIVMS_LSB	16
>  
> +#define JZ_ADC_REG_ADCMD_YNADC		BIT(7)
> +#define JZ_ADC_REG_ADCMD_YPADC		BIT(8)
> +#define JZ_ADC_REG_ADCMD_XNADC		BIT(9)
> +#define JZ_ADC_REG_ADCMD_XPADC		BIT(10)
> +#define JZ_ADC_REG_ADCMD_VREFPYP	BIT(11)
> +#define JZ_ADC_REG_ADCMD_VREFPXP	BIT(12)
> +#define JZ_ADC_REG_ADCMD_VREFPXN	BIT(13)
> +#define JZ_ADC_REG_ADCMD_VREFPAUX	BIT(14)
> +#define JZ_ADC_REG_ADCMD_VREFPVDD33	BIT(15)
> +#define JZ_ADC_REG_ADCMD_VREFNYN	BIT(16)
> +#define JZ_ADC_REG_ADCMD_VREFNXP	BIT(17)
> +#define JZ_ADC_REG_ADCMD_VREFNXN	BIT(18)
> +#define JZ_ADC_REG_ADCMD_VREFAUX	BIT(19)
> +#define JZ_ADC_REG_ADCMD_YNGRU		BIT(20)
> +#define JZ_ADC_REG_ADCMD_XNGRU		BIT(21)
> +#define JZ_ADC_REG_ADCMD_XPGRU		BIT(22)
> +#define JZ_ADC_REG_ADCMD_YPSUP		BIT(23)
> +#define JZ_ADC_REG_ADCMD_XNSUP		BIT(24)
> +#define JZ_ADC_REG_ADCMD_XPSUP		BIT(25)
> +
>  #define JZ_ADC_AUX_VREF				3300
>  #define JZ_ADC_AUX_VREF_BITS			12
>  #define JZ_ADC_BATTERY_LOW_VREF			2500
> @@ -44,6 +73,14 @@
>  #define JZ4770_ADC_BATTERY_VREF			6600
>  #define JZ4770_ADC_BATTERY_VREF_BITS		12
>  
> +#define JZ_ADC_IRQ_AUX			BIT(0)
> +#define JZ_ADC_IRQ_BATTERY		BIT(1)
> +#define JZ_ADC_IRQ_TOUCH		BIT(2)
> +#define JZ_ADC_IRQ_PEN_DOWN		BIT(3)
> +#define JZ_ADC_IRQ_PEN_UP		BIT(4)
> +#define JZ_ADC_IRQ_PEN_DOWN_SLEEP	BIT(5)
> +#define JZ_ADC_IRQ_SLEEP		BIT(7)
> +
>  struct ingenic_adc;
>  
>  struct ingenic_adc_soc_data {
> @@ -69,6 +106,61 @@ struct ingenic_adc {
>  	bool low_vref_mode;
>  };
>  
> +static void ingenic_adc_set_adcmd(struct iio_dev *iio_dev, unsigned long mask)
> +{
> +	struct ingenic_adc *adc = iio_priv(iio_dev);
> +
> +	mutex_lock(&adc->lock);
> +
> +	/* Init ADCMD */
> +	readl(adc->base + JZ_ADC_REG_ADCMD);
> +
> +	if (mask & 0x3) {
> +		/* Second channel (INGENIC_ADC_TOUCH_YP): sample YP vs. GND */
> +		writel(JZ_ADC_REG_ADCMD_XNGRU
> +		       | JZ_ADC_REG_ADCMD_VREFNXN | JZ_ADC_REG_ADCMD_VREFPVDD33
> +		       | JZ_ADC_REG_ADCMD_YPADC,
> +		       adc->base + JZ_ADC_REG_ADCMD);
> +
> +		/* First channel (INGENIC_ADC_TOUCH_XP): sample XP vs. GND */
> +		writel(JZ_ADC_REG_ADCMD_YNGRU
> +		       | JZ_ADC_REG_ADCMD_VREFNYN | JZ_ADC_REG_ADCMD_VREFPVDD33
> +		       | JZ_ADC_REG_ADCMD_XPADC,
> +		       adc->base + JZ_ADC_REG_ADCMD);
> +	}
> +
> +	if (mask & 0xc) {
> +		/* Fourth channel (INGENIC_ADC_TOUCH_YN): sample YN vs. GND */
> +		writel(JZ_ADC_REG_ADCMD_XNGRU
> +		       | JZ_ADC_REG_ADCMD_VREFNXN | JZ_ADC_REG_ADCMD_VREFPVDD33
> +		       | JZ_ADC_REG_ADCMD_YNADC,
> +		       adc->base + JZ_ADC_REG_ADCMD);
> +
> +		/* Third channel (INGENIC_ADC_TOUCH_XN): sample XN vs. GND */
> +		writel(JZ_ADC_REG_ADCMD_YNGRU
> +		       | JZ_ADC_REG_ADCMD_VREFNYN | JZ_ADC_REG_ADCMD_VREFPVDD33
> +		       | JZ_ADC_REG_ADCMD_XNADC,
> +		       adc->base + JZ_ADC_REG_ADCMD);
> +	}
> +
> +	if (mask & 0x30) {
> +		/* Sixth channel (INGENIC_ADC_TOUCH_YD): sample YP vs. YN */
> +		writel(JZ_ADC_REG_ADCMD_VREFNYN | JZ_ADC_REG_ADCMD_VREFPVDD33
> +		       | JZ_ADC_REG_ADCMD_YPADC,
> +		       adc->base + JZ_ADC_REG_ADCMD);
> +
> +		/* Fifth channel (INGENIC_ADC_TOUCH_XD): sample XP vs. XN */
> +		writel(JZ_ADC_REG_ADCMD_VREFNXN | JZ_ADC_REG_ADCMD_VREFPVDD33
> +		       | JZ_ADC_REG_ADCMD_XPADC,
> +		       adc->base + JZ_ADC_REG_ADCMD);
> +	}
> +
> +	/* We're done */
> +	writel(0, adc->base + JZ_ADC_REG_ADCMD);
> +
> +	mutex_unlock(&adc->lock);
> +}
> +
>  static void ingenic_adc_set_config(struct ingenic_adc *adc,
>  				   uint32_t mask,
>  				   uint32_t val)
> @@ -288,6 +380,72 @@ static const struct iio_chan_spec jz4740_channels[] = {
>  };
>  
>  static const struct iio_chan_spec jz4770_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_TOUCH_XP,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_TOUCH_YP,
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_TOUCH_XN,
> +		.scan_index = 2,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_TOUCH_YN,
> +		.scan_index = 3,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_TOUCH_XD,
> +		.scan_index = 4,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_TOUCH_YD,
> +		.scan_index = 5,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
> +	},
>  	{
>  		.extend_name = "aux",
>  		.type = IIO_VOLTAGE,
> @@ -491,13 +649,89 @@ static const struct iio_info ingenic_adc_info = {
>  	.of_xlate = ingenic_adc_of_xlate,
>  };
>  
> +static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
> +{
> +	struct ingenic_adc *adc = iio_priv(iio_dev);
> +	int ret;
> +
> +	ret = clk_enable(adc->clk);
> +	if (ret) {
> +		dev_err(iio_dev->dev.parent, "Failed to enable clock: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* It takes significant time for the touchscreen hw to stabilize. */
> +	msleep(50);
> +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK,
> +			       JZ_ADC_REG_CFG_SAMPLE_NUM(4) |
> +			       JZ_ADC_REG_CFG_PULL_UP(4));
> +
> +	writew(80, adc->base + JZ_ADC_REG_ADWAIT);
> +	writew(2, adc->base + JZ_ADC_REG_ADSAME);
> +	writeb((u8)~JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_CTRL);
> +	writel(0, adc->base + JZ_ADC_REG_ADTCH);
> +
> +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_CMD_SEL,
> +			       JZ_ADC_REG_CFG_CMD_SEL);
> +	ingenic_adc_set_adcmd(iio_dev, iio_dev->active_scan_mask[0]);
> +
> +	ingenic_adc_enable(adc, 2, true);
> +
> +	return 0;
> +}
> +
> +static int ingenic_adc_buffer_disable(struct iio_dev *iio_dev)
> +{
> +	struct ingenic_adc *adc = iio_priv(iio_dev);
> +
> +	ingenic_adc_enable(adc, 2, false);
> +
> +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_CMD_SEL, 0);
> +
> +	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
> +	writeb(0xff, adc->base + JZ_ADC_REG_STATUS);
> +	ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK, 0);
> +	writew(0, adc->base + JZ_ADC_REG_ADSAME);
> +	writew(0, adc->base + JZ_ADC_REG_ADWAIT);
> +	clk_disable(adc->clk);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ingenic_buffer_setup_ops = {
> +	.postenable = &ingenic_adc_buffer_enable,
> +	.predisable = &ingenic_adc_buffer_disable
> +};
> +
> +static irqreturn_t ingenic_adc_irq(int irq, void *data)
> +{
> +	struct iio_dev *iio_dev = data;
> +	struct ingenic_adc *adc = iio_priv(iio_dev);
> +	unsigned long mask = iio_dev->active_scan_mask[0];
> +	unsigned int i;
> +	u32 tdat[3];
> +
> +	for (i = 0; i < ARRAY_SIZE(tdat); mask >>= 2, i++) {
> +		if (mask & 0x3)
> +			tdat[i] = readl(adc->base + JZ_ADC_REG_ADTCH);
> +		else
> +			tdat[i] = 0;
> +	}
> +
> +	iio_push_to_buffers(iio_dev, tdat);
> +	writeb(JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_STATUS);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int ingenic_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct iio_dev *iio_dev;
>  	struct ingenic_adc *adc;
>  	const struct ingenic_adc_soc_data *soc_data;
> -	int ret;
> +	int irq, ret;
>  
>  	soc_data = device_get_match_data(dev);
>  	if (!soc_data)
> @@ -512,6 +746,17 @@ static int ingenic_adc_probe(struct platform_device *pdev)
>  	mutex_init(&adc->aux_lock);
>  	adc->soc_data = soc_data;
>  
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, ingenic_adc_irq, 0,
> +			       dev_name(dev), iio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to request irq: %d\n", ret);
> +		return ret;
> +	}
> +
>  	adc->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(adc->base))
>  		return PTR_ERR(adc->base);
> @@ -551,7 +796,8 @@ static int ingenic_adc_probe(struct platform_device *pdev)
>  
>  	iio_dev->dev.parent = dev;
>  	iio_dev->name = "jz-adc";
> -	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	iio_dev->setup_ops = &ingenic_buffer_setup_ops;
>  	iio_dev->channels = soc_data->channels;
>  	iio_dev->num_channels = soc_data->num_channels;
>  	iio_dev->info = &ingenic_adc_info;

