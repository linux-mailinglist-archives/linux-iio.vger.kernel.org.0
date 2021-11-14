Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7544F8DF
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbhKNP43 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 10:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231888AbhKNP42 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 10:56:28 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424C260EE7;
        Sun, 14 Nov 2021 15:53:32 +0000 (UTC)
Date:   Sun, 14 Nov 2021 15:58:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211114155818.5f945bc9@jic23-huawei>
In-Reply-To: <20211105112930.122017-2-antoniu.miclaus@analog.com>
References: <20211105112930.122017-1-antoniu.miclaus@analog.com>
        <20211105112930.122017-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Nov 2021 13:29:28 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1013 is a wideband, microwave upconverter optimized
> for point to point microwave radio designs operating in the
> 24 GHz to 44 GHz radio frequency (RF) range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1013.pdf
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hmm. Representing the LO signal as a clock seems a little interesting
but I guess that does let us use the clock framework to at least understand
it's frequency etc.

A few fairly trivial comments inline, but most of the discussion around this
is going to focus on ABI + DT bindings in the other patches.

Jonathan

> ---
> changes in v4:
>  - add extended info for the LO feedthrough offset calibration
>  drivers/iio/frequency/Kconfig    |  11 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1013.c | 631 +++++++++++++++++++++++++++++++
>  3 files changed, 643 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1013.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 240b81502512..411b3b961e46 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -49,5 +49,16 @@ config ADF4371
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
> +
> +config ADMV1013
> +	tristate "Analog Devices ADMV1013 Microwave Upconverter"
> +	depends on SPI && COMMON_CLK
> +	help
> +	  Say yes here to build support for Analog Devices ADMV1013
> +	  24 GHz to 44 GHz, Wideband, Microwave Upconverter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv1013.
> +
>  endmenu
>  endmenu
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index 518b1e50caef..559922a8196e 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,3 +7,4 @@
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
> +obj-$(CONFIG_ADMV1013) += admv1013.o
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> new file mode 100644
> index 000000000000..e3d99afe5ecc
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -0,0 +1,631 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1013 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/notifier.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +

> +
> +struct admv1013_state {
> +	struct spi_device	*spi;
> +	struct clk		*clkin;
> +	/* Protect against concurrent accesses to the device and to data */
> +	struct mutex		lock;
> +	struct regulator	*reg;
> +	struct notifier_block	nb;
> +	unsigned int		quad_se_mode;
> +	bool			vga_pd;
> +	bool			mixer_pd;
> +	bool			quad_pd;
> +	bool			bg_pd;
> +	bool			mixer_if_en;
> +	bool			det_en;
> +	u8			data[3] ____cacheline_aligned;
> +};
> +
> +static int __admv1013_spi_read(struct admv1013_state *st, unsigned int reg,
> +			       unsigned int *val)
> +{
> +	int ret;
> +	struct spi_transfer t = {0};
> +
> +	st->data[0] = 0x80 | (reg << 1);

FIELD_PREP()

> +	st->data[1] = 0x0;
> +	st->data[2] = 0x0;
> +
> +	t.rx_buf = &st->data[0];
> +	t.tx_buf = &st->data[0];
> +	t.len = 3;
> +
> +	ret = spi_sync_transfer(st->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = (get_unaligned_be24(&st->data[0]) >> 1) & GENMASK(15, 0);

FIELD_GET and GENMASK(16, 1) is slightly more readable.

> +
> +	return ret;
> +}
> +
> +
> +static int __admv1013_spi_write(struct admv1013_state *st,
> +				unsigned int reg,
> +				unsigned int val)
> +{
> +	put_unaligned_be24((val << 1) | (reg << 17), &st->data[0]);

Looks like a place where FIELD_PREP and appropriate masks would be useful.

> +
> +	return spi_write(st->spi, &st->data[0], 3);
> +}

blank line.

...

> +
> +static int admv1013_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 == IIO_MOD_I)
> +			return admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_I,
> +							ADMV1013_LOAMP_PH_ADJ_FINE_MSK,

line too long.  Uses some local variables for the various parameters to reduce the length.

> +							FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, val));
> +		else
> +			return admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_Q,
> +							ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
> +							FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, val));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1013_update_quad_filters(struct admv1013_state *st)
> +{
> +	unsigned int filt_raw;
> +	u64 rate = clk_get_rate(st->clkin);
> +
> +	if (rate >= (5400 * HZ_PER_MHZ) && rate <= (7000 * HZ_PER_MHZ))
> +		filt_raw = 15;
> +	else if (rate >= (5400 * HZ_PER_MHZ) && rate <= (8000 * HZ_PER_MHZ))
> +		filt_raw = 10;
> +	else if (rate >= (6600 * HZ_PER_MHZ) && rate <= (9200 * HZ_PER_MHZ))
> +		filt_raw = 5;
> +	else
> +		filt_raw = 0;
> +
> +	return __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
> +					ADMV1013_QUAD_FILTERS_MSK,
> +					FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
> +}
> +
> +static int admv1013_update_mixer_vgate(struct admv1013_state *st)
> +{
> +	unsigned int vcm, mixer_vgate;
> +
> +	vcm = regulator_get_voltage(st->reg);
> +
> +	if (vcm >= 0 && vcm < 1800000)
> +		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
> +	else if (vcm > 1800000 && vcm < 2600000)
> +		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;
> +	else
> +		return -EINVAL;
> +
> +	return __admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_I,
> +				 ADMV1013_MIXER_VGATE_MSK,
> +				 FIELD_PREP(ADMV1013_MIXER_VGATE_MSK, mixer_vgate));
> +}
> +
> +static int admv1013_reg_access(struct iio_dev *indio_dev,
> +			       unsigned int reg,
> +			       unsigned int write_val,
> +			       unsigned int *read_val)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +
> +	if (read_val)
> +		return admv1013_spi_read(st, reg, read_val);
> +	else
> +		return admv1013_spi_write(st, reg, write_val);
> +}
> +
> +static const struct iio_info admv1013_info = {
> +	.read_raw = admv1013_read_raw,
> +	.write_raw = admv1013_write_raw,
> +	.debugfs_reg_access = &admv1013_reg_access,
> +};
> +
> +static int admv1013_freq_change(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct admv1013_state *st = container_of(nb, struct admv1013_state, nb);
> +	int ret;
> +
> +	if (action == POST_RATE_CHANGE) {
> +		mutex_lock(&st->lock);
> +		ret = notifier_from_errno(admv1013_update_quad_filters(st));
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +#define _ADMV1013_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = admv1013_read, \
> +		.write = admv1013_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +}
> +
> +static const struct iio_chan_spec_ext_info admv1013_ext_info[] = {
> +	_ADMV1013_EXT_INFO("lo_feedthrough_offset_calib_positive", IIO_SEPARATE,
> +			   ADMV1013_LO_FEED_OFFSET_CALIB_P),
> +	_ADMV1013_EXT_INFO("lo_feedthrough_offset_calib_negative", IIO_SEPARATE,
> +			   ADMV1013_LO_FEED_OFFSET_CALIB_N),
> +	{ },
> +};
> +
> +#define ADMV1013_CHAN_PHASE(_channel, rf_comp) {		\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.modified = 1,						\
> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel2 = IIO_MOD_##rf_comp,				\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE)		\
> +	}
> +
> +#define ADMV1013_FEED_LO_CALIB(_channel, rf_comp,  _admv1013_ext_info) {\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.modified = 1,						\
> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel2 = IIO_MOD_##rf_comp,				\
> +	.channel = _channel,					\
> +	.ext_info = _admv1013_ext_info,				\
> +	}
> +
> +static const struct iio_chan_spec admv1013_channels[] = {
> +	ADMV1013_CHAN_PHASE(0, I),
> +	ADMV1013_CHAN_PHASE(0, Q),
> +	ADMV1013_FEED_LO_CALIB(0, I, admv1013_ext_info),
> +	ADMV1013_FEED_LO_CALIB(0, Q, admv1013_ext_info),
> +};
> +
> +static int admv1013_init(struct admv1013_state *st)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = st->spi;
> +
> +	/* Perform a software reset */
> +	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_SPI_CONTROL,
> +					 ADMV1013_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_SPI_CONTROL,
> +					 ADMV1013_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 0));
> +	if (ret)
> +		return ret;
> +
> +	ret = __admv1013_spi_read(st, ADMV1013_REG_SPI_CONTROL, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id = FIELD_GET(ADMV1013_CHIP_ID_MSK, chip_id);
> +	if (chip_id != ADMV1013_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = __admv1013_spi_write(st, ADMV1013_REG_VVA_TEMP_COMP, 0xE700);
> +	if (ret)
> +		return ret;
> +
> +	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
> +					 ADMV1013_QUAD_SE_MODE_MSK,
> +					 FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st->quad_se_mode));

Try to avoid very long lines where it doesn't affect readability.

> +	if (ret)
> +		return ret;
> +
> +	ret = admv1013_update_mixer_vgate(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = admv1013_update_quad_filters(st);
> +	if (ret)
> +		return ret;
> +
> +	enable_reg_msk = ADMV1013_VGA_PD_MSK |
> +			ADMV1013_MIXER_PD_MSK |
> +			ADMV1013_QUAD_PD_MSK |
> +			ADMV1013_BG_PD_MSK |
> +			ADMV1013_MIXER_IF_EN_MSK |
> +			ADMV1013_DET_EN_MSK;
> +
> +	enable_reg = FIELD_PREP(ADMV1013_VGA_PD_MSK, st->vga_pd) |
> +			FIELD_PREP(ADMV1013_MIXER_PD_MSK, st->mixer_pd) |
> +			FIELD_PREP(ADMV1013_QUAD_PD_MSK, st->quad_pd ? 7 : 0) |
> +			FIELD_PREP(ADMV1013_BG_PD_MSK, st->bg_pd) |
> +			FIELD_PREP(ADMV1013_MIXER_IF_EN_MSK, st->mixer_if_en) |
> +			FIELD_PREP(ADMV1013_DET_EN_MSK, st->det_en);
> +
> +	return __admv1013_spi_update_bits(st, ADMV1013_REG_ENABLE, enable_reg_msk, enable_reg);
> +}
...

> +
> +static int admv1013_properties_parse(struct admv1013_state *st)
> +{
> +	int ret;
> +	struct spi_device *spi = st->spi;
> +
> +	st->vga_pd = device_property_read_bool(&spi->dev, "adi,vga-powerdown");
> +	st->mixer_pd = device_property_read_bool(&spi->dev, "adi,mixer-powerdown");
> +	st->quad_pd = device_property_read_bool(&spi->dev, "adi,quad-powerdown");
> +	st->bg_pd = device_property_read_bool(&spi->dev, "adi,bg-powerdown");
> +	st->mixer_if_en = device_property_read_bool(&spi->dev, "adi,mixer-if-enable");
> +	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");

Comments on these in the binding doc review.



> +
> +	ret = device_property_read_u32(&spi->dev, "adi,quad-se-mode", &st->quad_se_mode);
> +	if (ret)
> +		st->quad_se_mode = 12;
> +
> +	st->reg = devm_regulator_get(&spi->dev, "vcm");
> +	if (IS_ERR(st->reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> +				     "failed to get the common-mode voltage\n");
> +
> +	st->clkin = devm_clk_get(&spi->dev, "lo_in");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the LO input clock\n");
> +
> +	return 0;
> +}
> +


