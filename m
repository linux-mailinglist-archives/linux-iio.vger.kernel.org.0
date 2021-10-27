Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EECE43CFE4
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbhJ0Rl0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 13:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243342AbhJ0Rl0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 13:41:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD9D60EFF;
        Wed, 27 Oct 2021 17:38:58 +0000 (UTC)
Date:   Wed, 27 Oct 2021 18:43:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211027184324.51811ef1@jic23-huawei>
In-Reply-To: <20211027092333.5270-1-antoniu.miclaus@analog.com>
References: <20211027092333.5270-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 Oct 2021 12:23:32 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1013 is a wideband, microwave upconverter optimized
> for point to point microwave radio designs operating in the
> 24 GHz to 44 GHz radio frequency (RF) range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1013.pdf
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu.

A few small things inline, but main issue in here is the use of the IIO_VAL_INT_MULTIPLE
There are very very few uses for that type (1 IIRC) and it isn't to combine multiple
values into a single sysfs attribute as shown here.  As such those offset interfaces
need a rethink.  We may well have to define some new ABI to support them but I don't
see a reason to not maintain the normal sysfs rule of one value per attribute.


..

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
> index 000000000000..91254605013c
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -0,0 +1,578 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1013 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
Recheck this list.  Should have
property.h and mod_devicetable.h

> +#include <linux/notifier.h>
> +#include <linux/regmap.h>

and not regmap as you aren't using it.

> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/unaligned.h>

...

> +/* ADMV1013_REG_OFFSET_ADJUST_Q Map */
> +#define ADMV1013_MIXER_OFF_ADJ_Q_P_MSK		GENMASK(15, 9)
> +#define ADMV1013_MIXER_OFF_ADJ_Q_N_MSK		GENMASK(8, 2)
Given these two registers have the same form, could you use generic naming
and just have them defined once?

> +
> +/* ADMV1013_REG_QUAD Map */
> +#define ADMV1013_QUAD_SE_MODE_MSK		GENMASK(9, 6)
> +#define ADMV1013_QUAD_FILTERS_MSK		GENMASK(3, 0)
> +
> +/* ADMV1013_REG_VVA_TEMP_COMP Map */
> +#define ADMV1013_VVA_TEMP_COMP_MSK		GENMASK(15, 0)
> +
> +struct admv1013_state {
> +	struct spi_device	*spi;
> +	struct clk		*clkin;
> +	/* Protect against concurrent accesses to the device */

Also against concurrent access to data.  Maybe other state in software as well?
This comment needs to cover everything the lock protects - if it were just
serialization of accesses to the device then the spi subsystem would handle
that fine for us.

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

...

> +static int admv1013_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->channel2 == IIO_MOD_I) {
> +			ret = admv1013_spi_read(st, ADMV1013_REG_OFFSET_ADJUST_I, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_I_P_MSK, data);
> +			*val2 = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_I_N_MSK, data);

I mention above about generic naming for these masks.  Advantage is then that this
code can be

		if (chan->channel2 == IIO_MOD_I)
			addr = ADMV1013_REG_OFFSET_ADJUST_I;
		else
			addr = ADMV1013_REG_OFFSET_ADJUST_Q;

		ret = admv1013_spi_read(st, addr, &data);
		if (ret)
			return ret;

		*val = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_P_MSK, data);
		*val2 = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_MSK, data);

		return IIO_VAL_INT_MULTIPLE;

However, returning multiple integers is normally reserved for things like
quaternions where the individual parts have no meaning except when they are all present.
It's not intended for pairs like this. It should also only be used with the special
read_raw_multi callback.

So we need to rethink this interface. I'm not entirely sure what it is
doing so I'm open to suggestions on what the interface should be!
The description on the datasheet suggest to me these are for calibration tweaking
in which case they should be related to calibbias not offset as they aren't something
we should apply to a raw value in userspace (which is what offset is for).


> +		} else {
> +			ret = admv1013_spi_read(st, ADMV1013_REG_OFFSET_ADJUST_Q, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_P_MSK, data);
> +			*val2 = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_N_MSK, data);
> +		}
> +
> +		return IIO_VAL_INT_MULTIPLE;
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 == IIO_MOD_I) {
> +			ret = admv1013_spi_read(st, ADMV1013_REG_LO_AMP_I, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val = FIELD_GET(ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK, data);

As above, the masks match for these two branches of if / else, so with a generic
name you should be able to share more code and only have to select the right register.

> +		} else {
> +			ret = admv1013_spi_read(st, ADMV1013_REG_LO_AMP_Q, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val = FIELD_GET(ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK, data);
> +		}
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1013_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		val2 /= 100000;
> +
> +		if (chan->channel2 == IIO_MOD_I)
> +			ret = admv1013_spi_update_bits(st, ADMV1013_REG_OFFSET_ADJUST_I,
> +						       ADMV1013_MIXER_OFF_ADJ_I_P_MSK |
> +						       ADMV1013_MIXER_OFF_ADJ_I_N_MSK,
> +						       FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_I_P_MSK, val) |
> +						       FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_I_N_MSK, val2));

As above, this isn't in inline with the normal ABI conventions so needs a rethink.  As far as I can
establish these two values are independent though the datasheet provides limited information.

> +		else
> +			ret = admv1013_spi_update_bits(st, ADMV1013_REG_OFFSET_ADJUST_Q,
> +						       ADMV1013_MIXER_OFF_ADJ_Q_P_MSK |
> +						       ADMV1013_MIXER_OFF_ADJ_Q_N_MSK,
> +						       FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_Q_P_MSK, val) |
> +						       FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_Q_N_MSK, val2));
> +
> +		return ret;
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 == IIO_MOD_I)
> +			return admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_I,
> +							ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK,
> +							FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK, val));
> +		else
> +			return admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_Q,
> +							ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK,
> +							FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK, val));
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
> +	if (rate >= 5400000000 && rate <= 7000000000)

To reduce chance of 0s issues you could use the HZ_PER_MHZ definition in include/linux/units.h
Nice to avoid counting so many zeros when reviewing.

> +		filt_raw = 15;
> +	else if (rate >= 5400000000 && rate <= 8000000000)
> +		filt_raw = 10;
> +	else if (rate >= 6600000000 && rate <= 9200000000)
> +		filt_raw = 5;
> +	else
> +		filt_raw = 0;
> +
> +	return __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
> +					ADMV1013_QUAD_FILTERS_MSK,
> +					FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
> +}
> +

> +static int admv1013_reg_access(struct iio_dev *indio_dev,
> +			       unsigned int reg,
> +			       unsigned int write_val,
> +			       unsigned int *read_val)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (read_val)
> +		ret = admv1013_spi_read(st, reg, read_val);

		return amdv1013_spi_read() etc is a bit more concise for now
loss of readability.

> +	else
> +		ret = admv1013_spi_write(st, reg, write_val);
> +
> +	return ret;
> +}
> +

...


> +
> +#define ADMV1013_CHAN(_channel, rf_comp) {			\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.modified = 1,						\
> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel2 = IIO_MOD_##rf_comp,				\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE) |	\
> +		BIT(IIO_CHAN_INFO_OFFSET)			\
> +	}
> +
> +static const struct iio_chan_spec admv1013_channels[] = {
> +	ADMV1013_CHAN(0, I),
> +	ADMV1013_CHAN(0, Q),
> +};

...

> +
> +static int admv1013_properties_parse(struct admv1013_state *st)
> +{
> +	int ret;
> +	struct spi_device *spi = st->spi;
> +
> +	st->vga_pd = device_property_read_bool(&spi->dev, "adi,vga-pd");
> +	st->mixer_pd = device_property_read_bool(&spi->dev, "adi,mixer-pd");
> +	st->quad_pd = device_property_read_bool(&spi->dev, "adi,quad-pd");
> +	st->bg_pd = device_property_read_bool(&spi->dev, "adi,bg-pd");
> +	st->mixer_if_en = device_property_read_bool(&spi->dev, "adi,mixer-if-en");
> +	st->det_en = device_property_read_bool(&spi->dev, "adi,det-en");

Comments on these in the binding document.

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
> +static int admv1013_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct admv1013_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	indio_dev->info = &admv1013_info;
> +	indio_dev->name = "admv1013";
> +	indio_dev->channels = admv1013_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(admv1013_channels);
> +
> +	st->spi = spi;
> +
> +	ret = admv1013_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified Common-Mode Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1013_reg_disable,
> +				       st->reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1013_clk_disable, st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call = admv1013_freq_change;
> +	ret = clk_notifier_register(st->clkin, &st->nb);

There seems to be a devm_clk_notifier_registers() which you should use.

> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1013_clk_notifier_unreg, st);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&st->lock);
> +
> +	ret = admv1013_init(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "admv1013 init failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1013_powerdown, st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +

...

