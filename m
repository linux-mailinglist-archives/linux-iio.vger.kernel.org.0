Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D661E21A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKFMes (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 07:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKFMer (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 07:34:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C52BE5
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 04:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2ED960C56
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 12:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D835C433C1;
        Sun,  6 Nov 2022 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667738085;
        bh=SGIcOmHDeueLXO2YQz2Fb0Aw62tXeZMUDGaMZdF2Yl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ogvvpu5riGKttVRupsJPgfD7hI7raU7t7Cv3yS/UatRuBnNOb/RDbszwpQDU49XSW
         mgsJVt2fMniRV4rPHMgBl2T4yEI/FjfRgTwu1bFN+KjQ15mJzVgTYyC/JEprYfQbim
         kA79U5+Pwtsb4US0oIu9hvodTFBJ8+gViTdZ5CI8kiox23SbW8Otpqn63iKy9a2D5z
         TwvPUS/msc6h67rPFvoSfELy80fCuSHc1YVH7C7OyP6zZdaod8nFEPC7gGf1zz42fL
         28m90YkcL6duxPJGqovpY5OQ/HSbOaxsUy/fVdrj5Oj0oS3C9/82bxeC7KTK+j2aGA
         m94Yp9NFMMKVg==
Date:   Sun, 6 Nov 2022 12:34:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     william.gray@linaro.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: add support for max5522
Message-ID: <20221106123435.29770882@jic23-huawei>
In-Reply-To: <20221030230813.460021-1-angelo.dureghello@timesys.com>
References: <20221030230813.460021-1-angelo.dureghello@timesys.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Oct 2022 00:08:13 +0100
Angelo Dureghello <angelo.dureghello@timesys.com> wrote:

> Add initial support for DAC max5522.
> 
> Tested writing DAC A and B with some values,
> from 0 to 1023, measured output voltages, driver works properly.

Hi.

A few minor follow up comments plus details I missed on first review.
The dance with data from different firmware sources is something we are
still tidying up across the subsystem - so there are lots of less than
perfect examples!

Coming together nicely.

Jonathan

> 
> Additions for max5523/24/25 will follow.
> 
.. Sign off here .. Git won't pick up anything after the --- for the git
log when applying this.

> ---
> Changes for v.2
> - fix commit message
> - Kconfig, fix depends and select
> - Kconfig, fix typo
> - fix include alphabetical order
> - remove sysfs includes
> - fix MAX5522_REG_DATA macro
> - use devm_ as much as possible
> - add regulator_enable
> - remove useless code
> - remove commas after structure initializers and null terminators
> - change to use simplier module_spi_driver
> - get id->name from device info structure
> - regulator voltage read always from read_raw (no cache)
The change log belongs below the --- as you have it but the sign off must
be above... 
> 
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---
>  drivers/iio/dac/Kconfig   |  13 +++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/max5522.c | 198 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/iio/dac/max5522.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 80521bd28d0f..6c49523fe357 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -357,6 +357,19 @@ config MAX517
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called max517.
>  
> +config MAX5522
> +	tristate "Maxim MAX5522 DAC driver"
> +	depends on SPI_MASTER
> +	select REGMAP_SPI
> +	help
> +	  Say Y here if you want to build a driver for the Maxim MAX5522.
> +
> +	  MAX5522 is a dual, ultra-low-power, 10-Bit, voltage-output
> +	  digital to analog converter (DAC) offering rail-to-rail buffered
> +	  voltage outputs.
> +
> +	  If compiled as a module, it will be called max5522.
> +
>  config MAX5821
>  	tristate "Maxim MAX5821 DAC driver"
>  	depends on I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index ec3e42713f00..6c74fea21736 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_LTC2632) += ltc2632.o
>  obj-$(CONFIG_LTC2688) += ltc2688.o
>  obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
> +obj-$(CONFIG_MAX5522) += max5522.o
>  obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
> diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
> new file mode 100644
> index 000000000000..dda822843542
> --- /dev/null
> +++ b/drivers/iio/dac/max5522.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Maxim MAX5522
> + * Dual, Ultra-Low-Power 10-Bit, Voltage-Output DACs
> + *
> + * Copyright 2022 Timesys Corp.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

mod_devicetable.h should probably be directly included.

After changes suggested below should add property.h

> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

Alphabetical order preferred (so nearly is!).
It's nice to also pull subsystem headers out to the end.

... Main block in alphabetical order ...

... iio headers ...

... driver specific headers if there are any ...

> +
> +#define MAX5522_MAX_ADDR	15
> +#define MAX5522_CTRL_NONE	0
> +#define MAX5522_CTRL_LOAD_IN_A	9
> +#define MAX5522_CTRL_LOAD_IN_B	10
> +
> +#define MAX5522_REG_DATA(x)	((x) + MAX5522_CTRL_LOAD_IN_A)
> +
> +struct max5522_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +struct max5522_state {
> +	struct regmap *regmap;
> +	const struct max5522_chip_info *chip_info;
> +	unsigned short dac_cache[2];
> +	unsigned int vrefin_mv;

As mentioned below, I don't think you have any reason to cache
the voltage in here any more.

> +	struct regulator *vrefin_reg;
> +};

> +static int max5522_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long info)
> +{
> +	struct max5522_state *state = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = state->dac_cache[chan->channel];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(state->vrefin_reg);
> +		if (ret < 0)
> +			return -EINVAL;
> +		state->vrefin_mv = ret / 1000;

Why not use a local variable given you only access the value in here.


> +		*val = state->vrefin_mv;
> +		*val2 = 10;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int max5522_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long info)
Slightly preferable to align parameters with opening brackets.
There are scripts that find this, so we tend to get follow up patches
if we don't do it from the start.

static int max5522_write_raw(struct iio_dev *indio_dev,
			     struct iio_chan_spec const *chan,
			     int val, int val2, long info)


> +{
> +	struct max5522_state *state = iio_priv(indio_dev);
> +	int rval;
> +
> +	if (val > 1023 || val < 0)
> +		return -EINVAL;
> +
> +	rval = regmap_write(state->regmap, max5522_info_to_reg(chan),
> +				val << chan->scan_type.shift);
> +	if (rval < 0)
> +		return rval;
> +
> +	state->dac_cache[chan->channel] = val;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info max5522_info = {
> +	.read_raw = max5522_read_raw,
> +	.write_raw = max5522_write_raw,
> +};
> +
> +static const struct regmap_config max5522_regmap_config = {
> +	.reg_bits = 4,
> +	.val_bits = 12,
> +	.max_register = MAX5522_MAX_ADDR,
> +};
> +
> +static int max5522_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct iio_dev *indio_dev;
> +	struct max5522_state *state;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (indio_dev == NULL) {
> +		dev_err(&spi->dev, "failed to allocate iio device\n");
> +		return  -ENOMEM;
> +	}
> +
> +	state = iio_priv(indio_dev);
> +	state->chip_info = &max5522_chip_info_tbl[id->driver_data];

Normally ends up cleaner to store the pointer directly in the ID table
(via an appropriate cast)

I'd prefer to see a small dance here where we use the firmware
provided data first, and then fallback to the old id table only if necessary.
Usually something like (and you'll need to add the value below)

	state->chip_info = device_get_match_data(&spi->dev);
	if (!state->chip_info) {
		state->chip_info = (struct max5582_chip_info *)(id->driver_data);
		if (!state->chip_info)
			return -ENINVAL;
	}
The reason is that there are a bunch of different ways we can probe an
irq device and a lack of consistency in which routes work.

The firmware one is the most generic as it's not I2C specific, but we
do still need to fallback to not using that because some code hadn't
been converted yet.

Andy proposed a wrapper for this sort of sequence - not sure that will
be acceptable though as it hides a bunch of magic.

> +
> +	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
> +	if (IS_ERR(state->vrefin_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
> +				     "Vrefin regulator not specified\n");
> +
> +	ret = regulator_enable(state->vrefin_reg);
> +	if (ret) {
> +		return dev_err_probe(&spi->dev, ret,
> +				      "Failed to enable vref regulators\n");
> +	}
> +
> +	state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
> +
> +	if (IS_ERR(state->regmap))
> +		return PTR_ERR(state->regmap);
> +
> +	indio_dev->info = &max5522_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max5522_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max5522_channels);
> +	indio_dev->name = max5522_chip_info_tbl[ID_MAX5522].name;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max5522_ids[] = {
> +	{ "max5522", ID_MAX5522 },
See above, for why but
	{ "max5522", (kernel_ulong_t)&max622_chip_info_tbl[ID_MAX5522] },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, max5522_ids);
> +
> +
> +static const struct of_device_id max5522_of_match[] = {
> +	{ .compatible = "maxim,max5522" },
Again, above for why
	{
		.compatible = "maxim,max5522",
		.data = &max622_chip_info_tbl[ID_MAX5522],
	 },
> +	{}
> +};
> +

Totally trivial, but for consistency with above (and common practice)
no line break here.

> +MODULE_DEVICE_TABLE(of, max5522_of_match);
> +
> +static struct spi_driver max5522_spi_driver = {
> +	.driver = {
> +		   .name = "max5522",
> +		   .of_match_table = max5522_of_match,
> +	},
> +	.probe = max5522_spi_probe,
> +	.id_table = max5522_ids,
> +};
> +module_spi_driver(max5522_spi_driver);
> +
> +MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com");
> +MODULE_DESCRIPTION("MAX5522 DAC driver");
> +MODULE_LICENSE("GPL");

