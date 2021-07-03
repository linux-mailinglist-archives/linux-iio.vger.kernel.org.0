Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3E3BA9F2
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhGCSMZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 3 Jul 2021 14:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhGCSMX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 14:12:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0788961922;
        Sat,  3 Jul 2021 18:09:45 +0000 (UTC)
Date:   Sat, 3 Jul 2021 19:12:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pierre CASTELLAN <pierre.castellan@non.se.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Milan Stevanovic <milan.o.stevanovic@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Tomasz Motyl <tomasz.motyl@se.com>,
        FREDERIC LOREAUD <frederic.loreaud@se.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio:adc: Add RZ/N1D ADC driver
Message-ID: <20210703191208.529921a0@jic23-huawei>
In-Reply-To: <DB6PR04MB29674E865CD47B1D0D60D936BA029@DB6PR04MB2967.eurprd04.prod.outlook.com>
References: <DB6PR04MB29674E865CD47B1D0D60D936BA029@DB6PR04MB2967.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Jun 2021 14:08:19 +0000
Pierre CASTELLAN <pierre.castellan@non.se.com> wrote:

>   This is ADC driver that can be found in the Renesas  RZ/N1D SoC
>   https://www.renesas.com/us/en/document/man/rzn1d-group-rzn1s-group-rzn1l-group-users-manual-peripherals-0?language=en&r=1054561
> 
>   ADC Core Features
>   - Up to 2 units
>   - Resolution 12-bit
>   - Sampling rate from 0.0625 MSPS to 1 MSPS
>   - Successive approximation
>   - Maximal conversion time 21 ADC_CLK
>   - Analog inputs 8 channels per core
>   (5 standard channels + 3 channels with sample/hold)
>   - Each channel has his own input trigger to start the conversion,
>   the triggers are managed by the ADC Controller

That's going to be fun if you add IIO style buffered support at some point.

>   - Power down mode
>   - ADC clock frequency from 4 MHz to 20 MHz
> 
> Signed-off-by: Tomasz Kazimierz Motyl <tomasz.motyl@se.com>
> Signed-off-by: Frederic Loreaud <frederic.loreaud@se.com>
> Signed-off-by: Pierre Castellan <pierre.castellan@non.se.com>

Comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig         |  10 +
>  drivers/iio/adc/Makefile        |   1 +
>  drivers/iio/adc/r9a06g032-adc.c | 352 ++++++++++++++++++++++++++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 drivers/iio/adc/r9a06g032-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f0af3a42f53c..c6ab22aa2000 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -746,6 +746,16 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config R9A06G032_ADC
> +	depends on  ARCH_R9A06G032 || COMPILE_TEST
> +	tristate "Renesas ADC driver"
> +	help
> +	  Say yes here to build support for the ADCs found in SoCs from
> +	  Renesas.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rzn1_adc.
> +
>  config SC27XX_ADC
>  	tristate "Spreadtrum SC27xx series PMICs ADC"
>  	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ef9cc485fb67..84c2ccae4317 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> +obj-$(CONFIG_R9A06G032_ADC) += r9a06g032-adc.o
>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>  obj-$(CONFIG_STX104) += stx104.o
> diff --git a/drivers/iio/adc/r9a06g032-adc.c b/drivers/iio/adc/r9a06g032-adc.c
> new file mode 100644
> index 000000000000..6c41ad74c868
> --- /dev/null
> +++ b/drivers/iio/adc/r9a06g032-adc.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Driver for Renesas R9A06G032 SoC built-in ADC
/*
 * Driver...

> + *
> + * Authors:
> + *  Tomasz Kazimierz Motyl
> + *  Frédéric Loreaud
> + *  Pierre Castellan
> + *
> + * Copyright (C) 2021 Schneider-Electric
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/completion.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/firmware/lces_monitor.h>
> +#include <linux/delay.h>
> +#include <linux/bits.h>
> +#include <asm/div64.h>
> +
> +/* force conversion register */
> +#define R9A06G032_ADC_SET_FORCE_REG_OFFSET  (13 * sizeof(u32))
> +/* configuration register */
> +#define R9A06G032_ADC_CONFIG_REG_OFFSET		(16 * sizeof(u32))
> +/* configuration register's power down bit */
> +#define R9A06G032_ADC_CONFIG_POWER_DOWN_BIT	BIT(3)
> +
> +/* virtual channels 0..8 control registers */

9 virtual channels for 8 real ones or typo?

> +#define R9A06G032_ADC_VIRTUAL_CHANNNELS_REGS_OFFSET  (48 * sizeof(u32))
> +/* control registers' virtual channels' bits */
> +#define R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK  GENMASK(2, 0)
Shorten these a little.

#define R9A06G032_ADC_VC_ADC1_SEL_MSK perhaps?

> +/* control registers' enable bit */
> +#define R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_ENABLE_BIT  BIT(15)
> +/* ADC 1 virtual channels conversion data register */
> +#define R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_REGS_OFFSET  (64 * sizeof(u32))
> +/* read data register's bits */
> +#define R9A06G032_ADC_READ_DATA_VALUE_MASK  GENMASK(11, 0)
> +/* read data register's update bit */
> +#define R9A06G032_ADC_READ_DATA_UPDATE_BIT  BIT(31)
> +
> +#define R9A06G032_ADC_CHANNEL(index) {  \
> +	.type = IIO_VOLTAGE,                                  \
> +	.indexed = 1,                                         \
> +	.channel = (index),                                     \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +	.scan_type = {          \
> +		.sign = 'u',          \
> +		.realbits = 12,   \
> +		.storagebits = 16,    \
> +		.shift = 0,    \

No need to specify shift as it's the obvious default.

> +		.endianness = IIO_BE, \
> +	},                      \
> +	.extend_name = NULL,    \

No need to set this either.

> +}
> +
> +/* R9A06G032 ADC has 8 channels */
> +#define R9A06G032_ADC_NUM_CHANNELS 8
> +
> +static struct iio_chan_spec r9a06g032_adc_channels[R9A06G032_ADC_NUM_CHANNELS] = {
> +	R9A06G032_ADC_CHANNEL(0),
> +	R9A06G032_ADC_CHANNEL(1),
> +	R9A06G032_ADC_CHANNEL(2),
> +	R9A06G032_ADC_CHANNEL(3),
> +	R9A06G032_ADC_CHANNEL(4),
> +	R9A06G032_ADC_CHANNEL(5),
> +	R9A06G032_ADC_CHANNEL(6),
> +	R9A06G032_ADC_CHANNEL(7),
> +};
> +
> +/* Device's private data */
> +struct r9a06g032_adc {
> +	struct device *dev;
> +
> +	struct mutex lock; /* channels readings must be done sequentially */
> +	struct completion complete;
> +	void __iomem *registers;
> +	resource_size_t phys_base;
> +	struct clk *clk;
> +	uint64_t conv_delay;
> +};
> +
> +static inline uint32_t r9a06g032_adc_read32(struct r9a06g032_adc *const adc,
> +					     const uint32_t reg_off)
> +{
> +	void __iomem *addr = adc->registers + reg_off;
> +
> +	return ioread32(addr);
> +}
> +
> +static inline void r9a06g032_adc_write32(struct r9a06g032_adc *const adc,
> +					  const uint32_t reg_off,
> +					  const uint32_t val)
> +{
> +	iowrite32(val, adc->registers + reg_off);
> +}
> +
> +static bool r9a06g032_adc_interrupt_status(struct r9a06g032_adc *const adc,
> +					    const int virtual_channel)
> +{
> +	bool ret;
> +	/* interrupt 0 status register has a 0 offset in register table */
> +	uint32_t status = r9a06g032_adc_read32(adc, 0);
> +
> +	ret = status & BIT(virtual_channel);
> +
> +	return ret;
> +}
> +
> +static int r9a06g032_adc_read_raw(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, long mask)
> +{
> +	struct r9a06g032_adc *adc = iio_priv(indio_dev);
> +	int virtual_channel = chan->channel;

Given virtual_channel is roughly the same length as chan->channel, why bother with the local
variable?

> +	uint32_t virtual_channel_control_offset = R9A06G032_ADC_VIRTUAL_CHANNNELS_REGS_OFFSET + 4 * virtual_channel;
> +	uint32_t virtual_channel_control = R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_ENABLE_BIT | (R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK & virtual_channel);

Add some line breaks as that is far too long.  Also shorter variable names should be possible
without loss of readability.

> +	uint32_t read_data = 0;
> +	int ret = 0;
> +
> +	if ((virtual_channel < 0)
> +	    || (virtual_channel > R9A06G032_ADC_NUM_CHANNELS)) {
> +		dev_err(adc->dev,
> +			"Invalid channel index (%i)\n", virtual_channel);
> +		return  -EINVAL;
> +	}
> +	mutex_lock(&adc->lock);
> +
> +	/*  disable power down mode, disable DMA and Sample & Hold mode */
> +	r9a06g032_adc_write32(adc, R9A06G032_ADC_CONFIG_REG_OFFSET,
> +			       0x00000000);
> +
> +	/* map virtual to physical channels 1:1 */
> +	r9a06g032_adc_write32(adc, virtual_channel_control_offset,
> +			       virtual_channel_control);
> +
> +	/* force conversion on vc[chan_idx] channel */
> +	r9a06g032_adc_write32(adc, R9A06G032_ADC_SET_FORCE_REG_OFFSET,
> +			       BIT(virtual_channel));
> +
> +	/*  Wait for maximum conversion duration of 21 ADC clock periods */
> +	ndelay(adc->conv_delay);
> +
> +	read_data = r9a06g032_adc_read32(adc,
> +					  (R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_REGS_OFFSET
> +					  + 4 * virtual_channel));
> +
> +	if ((read_data & R9A06G032_ADC_READ_DATA_UPDATE_BIT) == 0
> +		|| (r9a06g032_adc_interrupt_status(adc,
> +						virtual_channel) == false)) {
> +		ret = -EINVAL;	/* error reading input value */
> +		goto exit_point;
> +	}
> +
> +	*val = read_data & R9A06G032_ADC_READ_DATA_VALUE_MASK;
> +
> +	/* enable power down mode, keep DMA and Sample & Hold mode disabled */
> +	r9a06g032_adc_write32(adc, R9A06G032_ADC_CONFIG_REG_OFFSET,
> +			      R9A06G032_ADC_CONFIG_POWER_DOWN_BIT);
> +	ret = IIO_VAL_INT;
> +
> +exit_point:
> +	mutex_unlock(&adc->lock);
> +	return ret;
> +}
> +static int r9a06g032_adc_read_label(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     char *label)
> +{
> +	strcpy(label, indio_dev->channels->extend_name);
> +	return 0;
> +}
> +
> +static const struct iio_info r9a06g032_adc_info = {
> +	.read_raw = &r9a06g032_adc_read_raw,
> +	.read_label = &r9a06g032_adc_read_label,
> +};
> +
> +static int r9a06g032_adc_parse_channels_of(struct r9a06g032_adc *adc,
> +					    struct device_node *dn,
> +					    const int num_channels)
> +{
> +	int ret;
> +	struct device_node *channels;
> +	struct device_node *channel;
> +	struct iio_chan_spec *chanp;
> +
> +	channels = of_get_child_by_name(dn, "channels");
> +
> +	if (channels == NULL)
> +		return  -EINVAL;
> +
> +	for_each_available_child_of_node(channels, channel) {
> +
> +		uint32_t reg = 0;
> +
> +		ret = of_property_read_u32(channel, "reg", &reg);
> +
> +		if (ret != 0)

if (ret) more common idiom when doing error checking.

> +			return ret;
> +
> +		if (reg >= num_channels) {
> +			dev_err(adc->dev, "wrong reg child node value %i\n",
> +				reg);
> +			return -EINVAL;
> +		}
> +		chanp = &r9a06g032_adc_channels[reg];
> +		chanp->extend_name = of_get_property(channel, "label", NULL);

We very very rarely now use extend_names.  Store these somewhere else and
access that from your read_label callback.

> +	}
> +	return 0;
> +}
> +
> +static int r9a06g032_adc_setup_channel_names(struct r9a06g032_adc *adc,
> +					      struct iio_dev *const indio_dev)

This wrapper doesn't seem to add anything useful. I'd just put the content inline.

> +{
> +	struct device_node *dn = indio_dev->dev.of_node;

Ah, you use this before it would be set by the core.   If you have this
code inline you can easily refer to the parent of_node so that won't matter.

> +	int ret = r9a06g032_adc_parse_channels_of(adc, dn,
> +						   indio_dev->num_channels);
> +
> +	if (ret < 0)
> +		dev_warn(adc->dev, "unable to parse channels!\n");
You print errors twice for this one problem.

> +
> +	return ret;
> +}
> +
> +static int r9a06g032_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct r9a06g032_adc *adc;
> +	struct resource *res;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +
> +	if (indio_dev == NULL) {
> +		dev_err(&pdev->dev, "Failed to allocate memory for an IIO device!\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	adc = iio_priv(indio_dev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	/*
> +	 * Initialize private physical address for
> +	 * R9A06G032 secure monitor calls
> +	 */
> +	adc->phys_base = res->start;

I'm not seeing where you use that...  Something not yet implemented?

> +	adc->registers = devm_ioremap_resource(dev, res);
> +
> +	if (IS_ERR(adc->registers)) {
> +		dev_err(dev, "Unable to acquire memory mapping for the registers!\n");
> +		return  PTR_ERR(adc->registers);

Extra space.

> +	}
> +	platform_set_drvdata(pdev, indio_dev);
> +	adc->dev = dev;
> +
> +	/* Enabling clock for the ADC */
> +	adc->clk = devm_clk_get(&pdev->dev, "r9a06g032_adc_clk");
> +
> +	if (IS_ERR(adc->clk)) {
> +		dev_err(dev, "Failed to get the clock!\n");
> +		ret = PTR_ERR(adc->clk);

return it rather than carry on?

> +	}
> +	ret = clk_prepare_enable(adc->clk);
> +	if (ret) {
> +		dev_err(dev, "Could not prepare or enable the clock!\n");
> +		return ret;
> +	}
> +	dev_info(dev, "ADC clock rate: %lu Hz\n", clk_get_rate(adc->clk));
> +
> +	/*
> +	 * Estimate the max delay in ns,
> +	 * 20 clock tics + 1 clock tic for safety
> +	 */
> +	adc->conv_delay = div_u64(21000000000, clk_get_rate(adc->clk));
> +	dev_info(dev, "ADC conversion delay : %llu ns\n", adc->conv_delay);

Very noisy.  No one is going to find this stuff in the logs anyway, so
dev_dbg at most.

> +
> +	mutex_init(&adc->lock);
> +	init_completion(&adc->complete);
> +
> +	indio_dev->name = dev_name(dev);

Should be the part number so just put that in directly here. "r8a06g032"
I assume?

> +	indio_dev->dev.parent = dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;

Now set by the core on iio_device_register()

> +	indio_dev->info = &r9a06g032_adc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = r9a06g032_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(r9a06g032_adc_channels);
> +
> +	if (r9a06g032_adc_setup_channel_names(adc, indio_dev) < 0)
> +		dev_warn(dev,
> +			 "Invalid channels information - using defaults.\n");
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		clk_disable(adc->clk);

clk_disable_unprepare()?  I'm curious that you don't do this in remove though.
Even though it seems over the top, it's often worth using goto type
error handling in probe() because then you can make sure you did the same
in remove (+ whatever else is needed).

> +		dev_err(dev, "Failed to register IIO device %s': %d\n",
> +			indio_dev->name, ret);

Very noisy for something that is unlikely to happen and for which there are lots
of other ways of seeing it failed.

> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int r9a06g032_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_map_array_unregister(indio_dev);
if you use a devm_add_action_or_reset() to deal with the map removal
(and another for the missing clk_disable_unprepare()) then you could
easily get rid of the need for a explicit remove() function and simplify
some of your error paths.
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id r9a06g032_adc_ids[] = {
> +	{ .name = "r9a06g032-adc", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(platform, r9a06g032_adc_ids);
> +
> +static const struct of_device_id r9a06g032_adc_dt_ids[] = {
> +	{ .compatible = "r9a06g032-adc", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, r9a06g032_adc_dt_ids);
> +
> +static struct platform_driver r9a06g032_adc_driver = {
> +	.driver = {
> +		   .name = "r9a06g032-adc",
> +		   .of_match_table = of_match_ptr(r9a06g032_adc_dt_ids),
> +		    },
> +	.probe = r9a06g032_adc_probe,
> +	.remove = r9a06g032_adc_remove,
> +	.id_table = r9a06g032_adc_ids,
> +};
> +
> +module_platform_driver(r9a06g032_adc_driver);
> +
> +MODULE_DESCRIPTION("R9A06G032 ADC Driver for LCES2");
> +MODULE_AUTHOR("Tomasz Kazimierz Motyl <Tomasz.Motyl@schneider-electric.com>");
> +MODULE_LICENSE("GPL");

