Return-Path: <linux-iio+bounces-13733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48A9F9AA5
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B3D18955F2
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FB2210FF;
	Fri, 20 Dec 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2FKbvEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CC21A431
	for <linux-iio@vger.kernel.org>; Fri, 20 Dec 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723776; cv=none; b=sHkCcLI3SzBpKt+5ghvF1e41oYwL4VeU1iR5BWRAEdakpRAnWtfeQxJuPPEkEvDxgsFrxC3aKpUTpJcW4nJdgGHM/ED9YPk4HzMFHlU2N4Qsa7qQE6oHUYmknw+CFhToJuGyOut28qIWED52oLlr+bCTuLM6b4A90oyxn6glynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723776; c=relaxed/simple;
	bh=cnGteKvU2ak7yyApRsaY8hkerePT9xWTzh75rJ29fDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8skEJLa04QjpAwDhZHNonb1SuF01yOAv/0QT5cZsLGmalYSKkhCMiscGhtfT3Sr32rXcuKoTqnY5kKCjuXKTwLwdWmIVyjhzSbVQ+gUT+iIJM7tIh+mGk3oKFiYklIWreSxO9gBZZlSJ9qb4iOkNTsgBb36q3DG54W+1vw8zo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2FKbvEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5210DC4CECD;
	Fri, 20 Dec 2024 19:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734723775;
	bh=cnGteKvU2ak7yyApRsaY8hkerePT9xWTzh75rJ29fDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2FKbvEKcnjoNJYpzH9o0IldCyT+c1fP6UfAs2sVLU08NP9KymR4I+krvUc7k5MVS
	 4xzwzJTfkjaLTFhMDWZo2YGr2avcrCn5RqZn3nwo4MAmmG/8AnWwukzB8GJWa0o8Lo
	 SfWI04xv79F9tKG4qwIcbQIM9eIqa7kXuR5L/Wrv1Vg6Jns90CV48OpY9mDhC5oHq7
	 hDBvmaXpeBJC9Jo5xvcVM6X6YDx0UNXveKuDzwmtGf0sXXoXD+tAVTRWkaeIJnvg/h
	 IzTChIBFm1y5ROlOyVxQFSRlGaGVtHF9w4dV6Q674JO3hSt85Cfons9I/2rsmohzAv
	 wn9ApadL8NY/Q==
Date: Fri, 20 Dec 2024 19:42:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Message-ID: <20241220194249.434244e0@jic23-huawei>
In-Reply-To: <20241219230028.55987-1-hdegoede@redhat.com>
References: <20241219230028.55987-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 00:00:28 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
> Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
> The AXP288's GPADC is already supported by the X-Powers AXP288 ADC driver.
> 
> The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
> denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".
> 
> Add a driver for the Intel Dollar Cove TI PMIC's general purpose ADC,
> binding to the "chtdc_ti_adc" MFD cell of the MFD driver.
> 
> The "cht" in the cell name comes from Cherry Trail, but it turns out that
> just like the AXP288 the Intel Dollar Cove TI PMIC is also used with both
> Intel Bay Trail and Intel Cherry Trail SoCs, so this new ADC driver does
> not include the cht part in its name.
> 
> This is loosely based on kernel/drivers/iio/adc/iio_dc_ti_gpadc.c
> from the Acer A1-840 Android kernel source-code archive named:
> "App. Guide_Acer_20151221_A_A.zip"
> which is distributed by Acer from the Acer A1-840 support page:
> https://www.acer.com/us-en/support/product-support/A1-840/downloads
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Hi Hans,

A few comments inline, but mostly looks fine to me.

Jonathan

> ---
>  drivers/iio/adc/Kconfig           |  11 ++
>  drivers/iio/adc/Makefile          |   1 +
>  drivers/iio/adc/intel_dc_ti_adc.c | 258 ++++++++++++++++++++++++++++++
>  3 files changed, 270 insertions(+)
>  create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..8fd69edb057c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -678,6 +678,17 @@ config INTEL_MRFLD_ADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called intel_mrfld_adc.
>  
> +config INTEL_DC_TI_ADC
> +	tristate "Intel Bay / Cherry Trail Dollar Cove TI ADC driver"
> +	depends on INTEL_SOC_PMIC_CHTDC_TI
> +	help
> +	  Say yes here to have support for the Dollar Cove TI PMIC ADC device.
> +	  Depending on platform configuration, this general purpose ADC can be
> +	  used for sensors such as battery voltage and thermal resistors.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called intel_dc_ti_adc.
> +
Same thing on ordering.

>  config IMX7D_ADC
>  	tristate "Freescale IMX7D ADC driver"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ee19afba62b7..607d13c93c76 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>  obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
>  obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
> +obj-$(CONFIG_INTEL_DC_TI_ADC) += intel_dc_ti_adc.o
Alphabetical order. So swap these two above.

>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> diff --git a/drivers/iio/adc/intel_dc_ti_adc.c b/drivers/iio/adc/intel_dc_ti_adc.c
> new file mode 100644
> index 000000000000..c286f72cfb08
> --- /dev/null
> +++ b/drivers/iio/adc/intel_dc_ti_adc.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel Dollar Cove TI PMIC GPADC Driver
> + *
> + * Copyright (C) 2014 Intel Corporation (Ramakrishna Pallala <ramakrishna.pallala@intel.com>)
> + * Copyright (C) 2024 Hans de Goede <hansg@kernel.org>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/wait.h>
> +
> +#include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +
> +#define DC_TI_ADC_CNTL_REG			0x50
> +#define DC_TI_ADC_START				BIT(0)
> +#define DC_TI_ADC_CH_SEL			GENMASK(2, 1)
> +#define DC_TI_ADC_EN				BIT(5)
> +#define DC_TI_ADC_EN_EXT_BPTH_BIAS		BIT(6)
> +
> +#define DC_TI_ADC_CH0_DATAH_REG			0x54
> +#define DC_TI_ADC_CH0_DATAL_REG			0x55
> +#define DC_TI_ADC_CH1_DATAH_REG			0x56
> +#define DC_TI_ADC_CH1_DATAL_REG			0x57
> +#define DC_TI_ADC_CH2_DATAH_REG			0x58
> +#define DC_TI_ADC_CH2_DATAL_REG			0x59
> +#define DC_TI_ADC_CH3_DATAH_REG			0x5A
> +#define DC_TI_ADC_CH3_DATAL_REG			0x5B
> +
> +#define DEV_NAME				"chtdc_ti_adc"
As below. I'm not particularly keen on DEV_NAME defines as they
tend to give less readable code and blur boundaries of what must
be the same an what is coincidentally the same.
See comments on id_table later.

> +
> +enum dc_ti_adc_id {
> +	DC_TI_ADC_VBAT,
> +	DC_TI_ADC_PMICTEMP,
> +	DC_TI_ADC_BATTEMP,
> +	DC_TI_ADC_SYSTEMP0,
> +};
> +
> +struct dc_ti_adc_info {
> +	struct mutex lock;

Usual thing about a lock should have a comment on what data it
protects.

> +	wait_queue_head_t wait;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	bool conversion_done;
> +};
> +
> +static const struct iio_chan_spec dc_ti_adc_channels[] = {
> +	{
> +		.indexed = 1,
> +		.type = IIO_VOLTAGE,
> +		.channel = DC_TI_ADC_VBAT,
> +		.address = DC_TI_ADC_CH0_DATAH_REG,
> +		.datasheet_name = "CH0",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

No info at all on scaling?  

> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_PMICTEMP,
> +		.address = DC_TI_ADC_CH1_DATAH_REG,
> +		.datasheet_name = "CH1",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_BATTEMP,
> +		.address = DC_TI_ADC_CH2_DATAH_REG,
> +		.datasheet_name = "CH2",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_SYSTEMP0,
> +		.address = DC_TI_ADC_CH3_DATAH_REG,
> +		.datasheet_name = "CH3",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}
> +};
> +
> +static struct iio_map dc_ti_adc_default_maps[] = {
> +	IIO_MAP("CH0", "chtdc_ti_battery", "VBAT"),
> +	IIO_MAP("CH1", "chtdc_ti_battery", "PMICTEMP"),
> +	IIO_MAP("CH2", "chtdc_ti_battery", "BATTEMP"),
> +	IIO_MAP("CH3", "chtdc_ti_battery", "SYSTEMP0"),
> +	{}
Trivial preference for
	{ }

> +};
> +
> +static irqreturn_t dc_ti_adc_isr(int irq, void *data)
> +{
> +	struct dc_ti_adc_info *info = data;
> +
> +	info->conversion_done = true;
> +	wake_up(&info->wait);
> +	return IRQ_HANDLED;
> +}
> +
> +static int dc_ti_adc_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct dc_ti_adc_info *info = iio_priv(indio_dev);
> +	int ret, ch = chan->channel;
> +	unsigned int lsb, msb;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	guard(mutex)(&info->lock);
> +
> +	info->conversion_done = false;
> +
> +	/*
> +	 * If channel BPTHERM has been selected, first enable the BPTHERM BIAS
> +	 * which provides the VREFT Voltage reference to convert BPTHERM Input
> +	 * voltage to temperature.
> +	 * As per PMIC Vendor specifications, BPTHERM BIAS should be enabled
> +	 * 35 ms before ADC_EN command.
> +	 */
> +	if (ch == DC_TI_ADC_BATTEMP) {
> +		ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +					 DC_TI_ADC_EN_EXT_BPTH_BIAS,
> +					 DC_TI_ADC_EN_EXT_BPTH_BIAS);
> +		if (ret < 0)
> +			return ret;
> +		msleep(35);
> +	}
> +
> +	/*
> +	 * As per TI (PMIC Vendor), the ADC enable and ADC start commands should
> +	 * not be sent together. Hence send the commands separately
> +	 */
> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				 DC_TI_ADC_EN, DC_TI_ADC_EN);
> +	if (ret < 0)
> +		goto disable_adc;
Always a corner case of what to do about disabling when an enable fail.
We'd hope it never happens but in general I'd assume no side effects occured
and return here rather than the goto.

> +
> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				 DC_TI_ADC_CH_SEL, FIELD_PREP(DC_TI_ADC_CH_SEL, ch));
> +	if (ret < 0)
> +		goto disable_adc;
> +
> +	/*
> +	 * As per PMIC Vendor, a minimum of 50 micro seconds delay is required
> +	 * between ADC Enable and ADC START commands. This is also recommended
> +	 * by Intel Hardware team after the timing analysis of GPADC signals.
> +	 * Since the I2C Write transaction to set the channel number also
> +	 * imparts 25 micro seconds of delay, so we need to wait for another
> +	 * 25 micro seconds before issuing ADC START command.
> +	 */
> +	usleep_range(25, 40);

maybe fsleep() and let the range stuff in there handle setting those ranges
if appropriate at this scale.

> +
> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				 DC_TI_ADC_START, DC_TI_ADC_START);
> +	if (ret < 0)
> +		goto disable_adc;
> +
> +	/* TI (PMIC Vendor) recommends 5 sec timeout for conversion */

yikes. 5 seconds is rather long!  I assume in practice it's much less?

> +	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
> +	if (ret == 0) {
> +		dev_err(info->dev, "Error sample timeout\n");
> +		ret = -ETIMEDOUT;
> +		goto disable_adc;
> +	}
> +
> +	ret = regmap_read(info->regmap, chan->address, &msb);
> +	if (ret)
> +		goto disable_adc;
> +
> +	ret = regmap_read(info->regmap, chan->address + 1, &lsb);
bulk read and an endian conversion + mask?

> +	if (ret)
> +		goto disable_adc;
> +
> +	*val = ((msb << 8) | lsb) & 0x3ff;

That's an endian conversion. Use get_unaligned_xx16()
having stored the values next to each other (or bulk read if possible).


> +	ret = IIO_VAL_INT;
> +
> +disable_adc:
Maybe worth factoring out all the stuff that happens with the ADC enabled
so that the factored out function can simply return.

> +	regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +			   DC_TI_ADC_START | DC_TI_ADC_EN, 0);
> +
> +	if (ch == DC_TI_ADC_BATTEMP)
> +		regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +				   DC_TI_ADC_EN_EXT_BPTH_BIAS, 0);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info dc_ti_adc_iio_info = {
> +	.read_raw = dc_ti_adc_read_raw,
> +};
> +
> +static int dc_ti_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
> +	struct dc_ti_adc_info *info;
> +	struct iio_dev *indio_dev;
> +	int irq, ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &info->lock);
> +	if (ret)
> +		return ret;
> +
> +	init_waitqueue_head(&info->wait);
> +
> +	info->dev = dev;
> +	info->regmap = pmic->regmap;
> +
> +	indio_dev->name = pdev->name;

This is supposed to the part number. Is that the case for all firmware
types?  Probably better to just put an appropriate string in here.
That way I don't have to figure out what pdev->name is for various
forms of firmware.

> +	indio_dev->channels = dc_ti_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(dc_ti_adc_channels);
> +	indio_dev->info = &dc_ti_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_map_array_register(dev, indio_dev, dc_ti_adc_default_maps);

Given a problem we had recently, are we sure that we won't see platforms
with more than one of these PMICS?


> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, dc_ti_adc_isr,
> +					IRQF_ONESHOT, DEV_NAME, info);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static struct platform_driver dc_ti_adc_driver = {
> +	.probe = dc_ti_adc_probe,
> +	.driver = {
> +		.name = DEV_NAME,
> +	},
> +};
> +
> +module_platform_driver(dc_ti_adc_driver);
> +
> +MODULE_ALIAS("platform:" DEV_NAME);
Can we provide a id_table in the platform_driver and use
MODULE_DEVICE_TABLE(platform, ...) to provide the same as this without
needing to have DEV_NAME in multiple places.

Generally I'm not keen on DEV_NAME type defines because they tend to hide
away the actual strings, so getting to the point where it is only used in
one place and the string is fine is a good improvement.


> +MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
> +MODULE_DESCRIPTION("Intel Dollar Cove (TI) GPADC Driver");
> +MODULE_LICENSE("GPL");


