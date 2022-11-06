Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2461E4D9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKFRXO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 12:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiKFRWv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 12:22:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663D3FD16
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 09:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97CB60BFF
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 17:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C65BC433D6;
        Sun,  6 Nov 2022 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667755198;
        bh=0AMesVL8rW/BipJW7WXLw6Am2AieW+ZfxJ3QNhR2Kzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HneSi0ddKam24Vl0y7ITz/kfitgiCMBHaNc+ONH+gq2zYd2DIGSDs/kk+PyEi5O8z
         uZDkJ3F8x1198euWEsFOMkkjscJUQolEQSs4NhfQET2T6mTJpyKtFjV4/qilkjuhkI
         J4KbcG2/vvH+YlDzoP1HVkZs4aJsY3aoOxw1znH9JqnlSsVdYg7Xc0lBaW43LspfyE
         AS7Fi6c6oIVJY41sLSMkCzmL5C2GJmJ9giEvl+T4/MHWRSg2Qbwt2DgPgp8ODtkhuj
         vv1WZBjnL+FuXWkCD3tLGZyeVqKk7XStSLyBTdKOZTw1OPNj3b2shmVs6D11ieriY3
         /p1oC/oyGNLGg==
Date:   Sun, 6 Nov 2022 17:19:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     william.gray@linaro.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: add support for max5522
Message-ID: <20221106171949.571a6755@jic23-huawei>
In-Reply-To: <20221106165928.223318-1-angelo.dureghello@timesys.com>
References: <20221106165928.223318-1-angelo.dureghello@timesys.com>
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

On Sun,  6 Nov 2022 17:59:28 +0100
Angelo Dureghello <angelo.dureghello@timesys.com> wrote:

> Add initial support for DAC max5522.
> 
> Tested writing DAC A and B with some values,
> from 0 to 1023, measured output voltages, driver works properly.
> 
> Additions for max5523/24/25 will follow.
> 
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>

I've been dozy up to now.  This needs a (fairly simple)
device tree binding doc in Documentation/devicetree/bindings/iio/dac/

Make sure to include the device tree binding maintainers on that
and to follow the instructions to test the binding.
Feel free to send as a separate patch but refer back to this one.

I'll hold off applying this just in case it needs any changes
resulting form the binding review.


> 
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
> 
> Changes for v.3
> - move signed-off to be before the changelog
> - re-fix include alphabetical order
> - remove vrefin_mv references
> - align function params with opening bracket
> - try to get chip_info from firmware
> - name always read from max5522_chip_info_tbl
> - remove line break before MODULE_DEVICE_TABLE
> ---
>  drivers/iio/dac/Kconfig   |  13 +++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/max5522.c | 207 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 221 insertions(+)
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
> index 000000000000..00ba4e98fb9c
> --- /dev/null
> +++ b/drivers/iio/dac/max5522.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Maxim MAX5522
> + * Dual, Ultra-Low-Power 10-Bit, Voltage-Output DACs
> + *
> + * Copyright 2022 Timesys Corp.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
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
> +	struct regulator *vrefin_reg;
> +};
> +
> +#define MAX5522_CHANNEL(chan) {	\
> +	.type = IIO_VOLTAGE, \
> +	.indexed = 1, \
> +	.output = 1, \
> +	.channel = chan, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_SCALE), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 10, \
> +		.storagebits = 16, \
> +		.shift = 2, \
> +	} \
> +}
> +
> +const struct iio_chan_spec max5522_channels[] = {
> +	MAX5522_CHANNEL(0),
> +	MAX5522_CHANNEL(1),
> +};
> +
> +enum max5522_type {
> +	ID_MAX5522,
> +};
> +
> +static const struct max5522_chip_info max5522_chip_info_tbl[] = {
> +	[ID_MAX5522] = {
> +		.name = "max5522",
> +		.channels = max5522_channels,
> +		.num_channels = 2,
> +	},
> +};
> +
> +static inline int max5522_info_to_reg(struct iio_chan_spec const *chan)
> +{
> +	return MAX5522_REG_DATA(chan->channel);
> +}
> +
> +static int max5522_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
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
> +		*val = ret / 1000;
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
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct max5522_state *state = iio_priv(indio_dev);
> +	int rval;
> +
> +	if (val > 1023 || val < 0)
> +		return -EINVAL;
> +
> +	rval = regmap_write(state->regmap, max5522_info_to_reg(chan),
> +			    val << chan->scan_type.shift);
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
> +	state->chip_info = device_get_match_data(&spi->dev);
> +	if (!state->chip_info) {
> +		state->chip_info =
> +			(struct max5522_chip_info *)(id->driver_data);
> +		if (!state->chip_info)
> +			return -EINVAL;
> +	}
> +
> +	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
> +	if (IS_ERR(state->vrefin_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
> +				     "Vrefin regulator not specified\n");
> +
> +	ret = regulator_enable(state->vrefin_reg);
> +	if (ret) {
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to enable vref regulators\n");
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
> +	{ "max5522", (kernel_ulong_t)&max5522_chip_info_tbl[ID_MAX5522] },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, max5522_ids);
> +
> +static const struct of_device_id max5522_of_match[] = {
> +	{
> +		.compatible = "maxim,max5522",
> +		.data = &max5522_chip_info_tbl[ID_MAX5522],
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, max5522_of_match);
> +
> +static struct spi_driver max5522_spi_driver = {
> +	.driver = {
> +		.name = "max5522",
> +		.of_match_table = max5522_of_match,
> +	},
> +	.probe = max5522_spi_probe,
> +	.id_table = max5522_ids,
> +};
> +module_spi_driver(max5522_spi_driver);
> +
> +MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com");
> +MODULE_DESCRIPTION("MAX5522 DAC driver");
> +MODULE_LICENSE("GPL");

