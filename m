Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53E713A82
	for <lists+linux-iio@lfdr.de>; Sun, 28 May 2023 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjE1QWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 May 2023 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjE1QWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 May 2023 12:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A75B9;
        Sun, 28 May 2023 09:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 168AF60B6E;
        Sun, 28 May 2023 16:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A633C433EF;
        Sun, 28 May 2023 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685290918;
        bh=O2vg3Ov5iVP10TTdBGk0zHoI09jnIvTNhX+NR+A0E20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FRcV98sjFE3eFUeFKhzRslOmQD3V7OH+iC9VQSec6fA1otwfPCSvJhYLTY/me/glM
         toBQaJ66OHIPlBTRRZy/Tted7o7JhwG8QO0XwVazxCWOJ6SH53Zk+TkjajS2QVWKB7
         A3K/6L4S6vdm4jXTzDpVZUhE7EokHt6t5VedUbcNh/vxYWdwTbE2U84Blh/rA8lcrF
         V42BoVGSWHTb4FYUgkRLowhzH8QRWET4Rd0YEsisjIAw7CdiknD9ShbF3YdvikH4WG
         bNXByJQlA+3g82gPexPPPyBAaAGSIfVQPUtUx66NrMz5ozhfoREPtlO8HFgKtrsxiB
         dpU4T1+VTQTHw==
Date:   Sun, 28 May 2023 17:38:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v1 1/4] iio: adc: Add Allwinner D1/T113s/R329 SoCs
 GPADC
Message-ID: <20230528173814.6d8dc146@jic23-huawei>
In-Reply-To: <20230524082744.3215427-2-bigunclemax@gmail.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
        <20230524082744.3215427-2-bigunclemax@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 May 2023 11:27:30 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

> The General Purpose ADC (GPADC) can convert the external signal into
> a certain proportion of digital value, to realize the measurement of
> analog signal, which can be applied to power detection and key detection.
> 
> D1, T113s and R329 contain this GPADC IP. The only difference between
> this SoCs is the number of available channels:
> 
>  T113 - 1 channel
>  D1   - 2 channels
>  R329 - 4 channels
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

Hi Maxim,

Various comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig            |  10 ++
>  drivers/iio/adc/Makefile           |   1 +
>  drivers/iio/adc/sun20i-gpadc-iio.c | 275 +++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index eb2b09ef5d5b..988804f46bf6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1123,6 +1123,16 @@ config SUN4I_GPADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called sun4i-gpadc-iio.
>  
> +config SUN20I_GPADC
> +	tristate "Support for the Allwinner SoCs GPADC"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	help
> +	  Say yes here to build support for Allwinner (D1, T113 and R329) SoCs
> +	  GPADC. This ADC provides up to 4 channels.

Given you wrote code that clamps at 16 channels I'd avoid saying only 4 here as
it will then need updating if another device turns up with more than 4.

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sun20i-gpadc-iio.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C

> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
> new file mode 100644
> index 000000000000..90f3bb2e41cd
> --- /dev/null
> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPADC driver for sunxi platforms (D1, T113-S3 and R329)
> + * Copyright (c) 2023 Maksim Kiselev <bigunclemax@gmail.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
Use generic versions from property.h
> +#include <linux/clk.h>

Alphabetical order preferred. Fine to separate out the iio one as
a more specific group at the end though.

> +#include <linux/reset.h>
> +#include <linux/platform_device.h>

I'd expect to see mod_devicetable.h included.

> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +
> +#define SUN20I_GPADC_SR					0x00
> +
> +#define SUN20I_GPADC_CTRL				0x04
> +#define SUN20I_GPADC_CTRL_ADC_FIRST_DLY			((GENMASK(7, 0) & (x)) << 24)

define the mask, and use FIELD_PREP to place the data in it.
Same for other cases that look like this.

> +#define SUN20I_GPADC_CTRL_ADC_AUTOCALI_EN		BIT(23)
> +#define SUN20I_GPADC_CTRL_ADC_OP_BIAS			((GENMASK(1, 0) & (x)) << 20)
> +#define SUN20I_GPADC_CTRL_WORK_MODE_SELECT(x)		((GENMASK(1, 0) & (x)) << 18)
> +#define SUN20I_GPADC_CTRL_ADC_CALI_EN			BIT(17)
> +#define SUN20I_GPADC_CTRL_ADC_EN			BIT(16)
> +
> +#define SUN20I_GPADC_CS_EN				0x08
> +#define SUN20I_GPADC_CS_EN_ADC_CHAN_CMP_EN(x)		((GENMASK(16, 0) & BIT(x)) << 16)

> +#define SUN20I_GPADC_CS_EN_ADC_CHAN_SELECT(x)		(GENMASK(16, 0) & BIT(x))
> +
> +#define SUN20I_GPADC_DATA_INTC				0x28
> +#define SUN20I_GPADC_DATA_INTC_CHAN_DATA_IRQ_EN(x)	(GENMASK(16, 0) & BIT(x))
> +
> +#define SUN20I_GPADC_DATA_INTS				0x38
> +#define SUN20I_GPADC_DATA_INTS_DATA_PENDING(x)		(GENMASK(16, 0) & BIT(x))
> +#define SUN20I_GPADC_DATA_INTS_DATA_PENDING_MASK	GENMASK(16, 0)
> +
> +#define SUN20I_GPADC_CHAN_DATA(x)			(0x80 + (x) * 4)
> +
> +#define SUN20I_GPADC_TIMEOUT				msecs_to_jiffies(100)

I'd either document why that time here, or push this down to were it's called.
It's a real world value rather than a magic number so doesn't need a name unless
more information is provided with that.

> +#define SUN20I_GPADC_MAX_CHANNELS			16
> +


...

> +
> +static int sun20i_gpadc_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan, int *val,
> +				 int *val2, long mask)
> +{
> +	struct sun20i_gpadc_iio *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&info->lock);
> +		ret = sun20i_gpadc_adc_read(info, chan, val);
> +		mutex_unlock(&info->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* 1800mV / 4096 * raw */

Not * raw, because that bit is in userspace - or express this as
value in mv = 1800mV / 4096  raw

Also we have IIO_VAL_FRACTIONAL_LOG_2 - the advantage of that being that
a consumer of this channel can do more efficient maths in some cases 
if it gets the values in that form.

> +		*val = 0;
> +		*val2 = 439453125;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t sun20i_gpadc_irq_handler(int irq, void *data)
> +{
> +	struct sun20i_gpadc_iio *info = data;
> +	u32 reg;
> +
> +	/* clear data interrupt status register */
> +	regmap_read(info->regmap, SUN20I_GPADC_DATA_INTS, &reg);
> +	regmap_write(info->regmap, SUN20I_GPADC_DATA_INTS, reg);
> +
> +	complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info sun20i_gpadc_iio_info = {
> +	.read_raw = sun20i_gpadc_read_raw,
> +};
> +
> +static int sun20i_gpadc_probe(struct platform_device *pdev)
> +{
> +	const struct sun20i_gpadc_configuration *config;
> +	struct iio_dev *indio_dev;
> +	struct sun20i_gpadc_iio *info;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	struct clk *clk;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	platform_set_drvdata(pdev, indio_dev);

Why set this?  I'm not immediately spotting it being used.

> +
> +	mutex_init(&info->lock);
> +	init_completion(&info->completion);
> +
> +	info->indio_dev = indio_dev;

This is very rarely a good idea. It normally implies that
the level of abstraction has gone wrong somewhere in the driver.
Here I don't think you even use it - hence drop that pointer from
the structure.

> +	indio_dev->info = &sun20i_gpadc_iio_info;
> +	indio_dev->name = dev_name(&pdev->dev);

dev_name() has a habit of not reflecting the part number of the device,
which is what should be used for indio_dev->name.
Usual fix is put it in your device type specific structure - which is another
reason you may want to keep the explicit compatibles.

> +
> +	config = of_device_get_match_data(&pdev->dev);

I think this already got pointed out.  In IIO we are trying to use
the generic firmware interfaces for everything.  Whilst there are devices
where it is unlikely that anyone will ever use them with other firmware
types, using the generic interfaces is more consistent for reviewers
of the wide class of devices that are used with ACPI etc.

> +	if (!config)
> +		return -ENODEV;
> +
> +	/* Sanity check for possible later IP variants with more channels */
> +	if (config->num_channels > SUN20I_GPADC_MAX_CHANNELS)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "max channels exceeded\n");

This should be either by design or a compile time check if you really
want to check it.

> +
> +	indio_dev->channels = config->channels;
> +	indio_dev->num_channels = config->num_channels;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +					     &sun20i_gpadc_regmap_config);
> +	if (IS_ERR(info->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->regmap),
> +				     "failed to init regmap\n");
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +				     "failed to enable bus clock\n");
> +
> +	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
> +				     "failed to get reset control\n");
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				    "failed to deassert reset\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq, "failed to get irq\n");
> +
> +	ret = devm_request_irq(&pdev->dev, irq, sun20i_gpadc_irq_handler,
> +			       0, dev_name(&pdev->dev), info);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed requesting irq %d\n", irq);
> +
> +	/* set the single conversion mode and enable auto calibration*/
> +	regmap_write(info->regmap, SUN20I_GPADC_CTRL,
> +		     SUN20I_GPADC_CTRL_ADC_AUTOCALI_EN |
> +		     SUN20I_GPADC_CTRL_WORK_MODE_SELECT(0));
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not register the device\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun20i_gpadc_of_id[] = {
> +	{
> +		.compatible = "allwinner,sun8i-t113-gpadc",
> +		.data = &sun20i_gpadc_config[0],
> +	},
> +	{
> +		.compatible = "allwinner,sun20i-d1-gpadc",
> +		.data = &sun20i_d1_gpadc_channels[1]
> +	},
> +	{
> +		.compatible = "allwinner,sun50i-r329-gpadc",
> +		.data = &sun50i_r329_gpadc_channels[2]
I agree with the other reviewer who suggested the array was unnecessary
- if you did want to keep it for some reason the introduce an enum so
you can reference it by named index.

Add commas to these lines, both for consistency and because maybe we will
one day set more in that structure and it will reduce the noise level
of such a patch.
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);
