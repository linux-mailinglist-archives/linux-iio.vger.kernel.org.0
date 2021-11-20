Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462BE457F7E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhKTQaE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 11:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhKTQaE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 11:30:04 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125F76056B;
        Sat, 20 Nov 2021 16:26:58 +0000 (UTC)
Date:   Sat, 20 Nov 2021 16:31:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 2/2] iio:frequency:admv4420.c: Add support for
 ADMV4420
Message-ID: <20211120163150.4e208061@jic23-huawei>
In-Reply-To: <20211119114011.75406-2-cristian.pop@analog.com>
References: <20211119114011.75406-1-cristian.pop@analog.com>
        <20211119114011.75406-2-cristian.pop@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Nov 2021 13:40:11 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> Add support for K Band Downconverter with Integrated
> Fractional-N PLL and VCO.
> More info:
> https://www.analog.com/en/products/admv4420.html

Datasheet: https://www.analog.com/en/products/admv4420.html

> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

Having looked at the datasheet I'm not sure how we can realistically fit this
into a remotely standard ABI.  A user would care about controlling the tuning
frequency and that's not going to be trivial to describe.

So having read this I'm not sure I understand why the IIO part of the driver
is useful.  If the only interest is in fixed frequency operation why expose
any standard(ish) userspace?

Thanks,

Jonathan


> ---
>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv4420.c | 413 +++++++++++++++++++++++++++++++
>  3 files changed, 424 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv4420.c
...

> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Why this include?

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +
> +#define ADMV4420_REFERENCE_IN_MODE(x)		(x << 1)

Prefer to see these specified as masks and then defines for the values
followed by use of FIELD_PREP to set the actual bits.

> +#define ADMV4420_REFERENCE_DOUBLER(x)		(x << 2)
> +#define ADMV4420_REFERENCE_DIVIDE_BY_2_MASK	BIT(0)
> +#define ADMV4420_REFERENCE_MODE_MASK		BIT(1)
> +#define ADMV4420_REFERENCE_DOUBLER_MASK		BIT(2)


> +
> +struct admv4420_reference_block {
> +	bool doubler_en;
> +	bool divide_by_2_en;
> +	bool ref_single_ended;
> +	u32 freq_hz;
> +	u32 divider;
> +};
> +
> +struct admv4420_n_counter {
> +	u32 int_val;
> +	u32 frac_val;
> +	u32 mod_val;
> +	u32 n_counter;
> +};
> +

> +
> +static void admv4420_calc_vco_freq(struct admv4420_state *st)
> +{
> +	u64 tmp;
> +
> +	tmp = div_u64((st->pfd_freq_hz * st->n_counter.frac_val), st->n_counter.mod_val);
> +	tmp += st->pfd_freq_hz * st->n_counter.int_val;
> +	st->vco_freq_hz = tmp;
> +}
> +
> +static void admv4420_calc_pfd_freq(struct admv4420_state *st)
> +{
> +	u32 tmp;
> +
> +	tmp = st->ref_block.freq_hz * (st->ref_block.doubler_en ? 2 : 1);
> +	tmp = DIV_ROUND_CLOSEST(tmp, st->ref_block.divider *
> +				(st->ref_block.divide_by_2_en ? 2 : 1));
> +	st->pfd_freq_hz = tmp;
> +
> +	admv4420_calc_vco_freq(st);
> +	st->lo_freq_hz = st->vco_freq_hz * 2;
> +}
> +
> +static int admv4420_set_n_counter(struct admv4420_state *st, u32 int_val, u32 frac_val, u32 mod_val)
> +{
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_FRAC_H, FIELD_GET(ADMV4420_FRAC_H_MASK, frac_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_FRAC_M, FIELD_GET(ADMV4420_FRAC_M_MASK, frac_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_FRAC_L, FIELD_GET(ADMV4420_FRAC_L_MASK, frac_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_MOD_H, FIELD_GET(ADMV4420_MOD_H_MASK, mod_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_MOD_M, FIELD_GET(ADMV4420_MOD_M_MASK, mod_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_MOD_L, FIELD_GET(ADMV4420_MOD_L_MASK, mod_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_INT_H, FIELD_GET(ADMV4420_H_MASK, int_val));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADMV4420_INT_L, FIELD_GET(ADMV4420_L_MASK, int_val));
> +}
> +
> +static int admv4420_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct admv4420_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		*val = div_u64(st->lo_freq_hz, 1000000);
> +		div_u64_rem(st->lo_freq_hz, 1000000, val2);

Why is it useful to describe a fixed frequency via an IIO device?



> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info admv4420_info = {
> +	.read_raw = admv4420_read_raw,
> +	.debugfs_reg_access = &admv4420_reg_access,
> +};
> +
> +#define ADMV4420_CHAN_LO(_channel) {				\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +}
> +
> +static const struct iio_chan_spec admv4420_channels[] = {
> +	ADMV4420_CHAN_LO(0),
> +};
> +
> +static void admv4420_dt_parse(struct admv4420_state *st)
> +{
> +	struct spi_device *spi = st->spi;
> +
> +	st->ref_block.ref_single_ended = of_property_read_bool(spi->dev.of_node,
> +							       "adi,ref_single_ended");
> +	st->ref_block.doubler_en = of_property_read_bool(spi->dev.of_node, "adi,ref_doubler_en");
> +	st->ref_block.divide_by_2_en = of_property_read_bool(spi->dev.of_node,
> +							     "adi,ref_divide_by_2_en");
> +	device_property_read_u32(&spi->dev, "adi,ref_freq_hz", &st->ref_block.freq_hz);
> +	device_property_read_u32(&spi->dev, "adi,ref_divider", &st->ref_block.divider);
> +	device_property_read_u32(&spi->dev, "adi,N_counter_int_val", &st->n_counter.int_val);
> +	device_property_read_u32(&spi->dev, "adi,N_counter_frac_val", &st->n_counter.frac_val);
> +	device_property_read_u32(&spi->dev, "adi,N_counter_mod_val", &st->n_counter.mod_val);
> +	device_property_read_u32(&spi->dev, "adi,mux_sel", &st->mux_sel);
> +}
> +
> +static int admv4420_setup(struct iio_dev *indio_dev)
> +{
> +	struct admv4420_state *st = iio_priv(indio_dev);
> +	u32 val = 0;
> +	int ret;
> +
> +	/* Software reset and activate SDO */
> +	ret = regmap_write(st->regmap, ADMV4420_SPI_CONFIG_1,
> +			   ADMV4420_SPI_CONFIG_1_SOFTRESET_ | ADMV4420_SPI_CONFIG_1_SOFTRESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADAR1000_SCRATCH_PAD_VAL_1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != ADAR1000_SCRATCH_PAD_VAL_1) {
> +		dev_err(indio_dev->dev.parent, "Failed ADMV4420 to read/write scratchpad %x ", val);

Try to keep lines under 80 chars unless it hurts readability.  Breaking this one before
the string doesn't hurt readability so please do so.

> +		return -EIO;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADAR1000_SCRATCH_PAD_VAL_2);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != ADAR1000_SCRATCH_PAD_VAL_2) {
> +		dev_err(indio_dev->dev.parent, "Failed ADMV4420 to read/write scratchpad %x ", val);
> +		return -EIO;
> +	}
> +
> +	st->ref_block.freq_hz = ADMV4420_DEF_REF_HZ;
> +	st->ref_block.ref_single_ended = false;
> +	st->ref_block.doubler_en = false;
> +	st->ref_block.divide_by_2_en = false;
> +	st->ref_block.divider = ADMV4420_DEF_REF_DIVIDER;
> +
> +	st->n_counter.int_val = ADMV4420_DEF_NC_INT;
> +	st->n_counter.frac_val = ADMV4420_DEF_NC_FRAC;
> +	st->n_counter.mod_val = ADMV4420_DEF_NC_MOD;
> +
> +	st->mux_sel = ADMV4420_LOCK_DTCT;
> +
> +	admv4420_dt_parse(st);
> +
> +	ret = regmap_write(st->regmap, ADMV4420_R_DIV_L,
> +			   FIELD_GET(ADMV4420_L_MASK, st->ref_block.divider));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_R_DIV_H,
> +			   FIELD_GET(ADMV4420_H_MASK, st->ref_block.divider));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_REFERENCE,
> +			   st->ref_block.divide_by_2_en |
> +			   ADMV4420_REFERENCE_IN_MODE(st->ref_block.ref_single_ended) |
> +			   ADMV4420_REFERENCE_DOUBLER(st->ref_block.doubler_en));
> +	if (ret)
> +		return ret;
> +
> +	ret = admv4420_set_n_counter(st, st->n_counter.int_val, st->n_counter.frac_val,
> +				     st->n_counter.mod_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_PLL_MUX_SEL, st->mux_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_ENABLES, ENABLE_PLL | ENABLE_LO | ENABLE_VCO |
> +			   ENABLE_IFAMP | ENABLE_MIXER | ENABLE_LNA);
> +	if (ret)
> +		return ret;
> +
> +	admv4420_calc_pfd_freq(st);
> +
> +	return 0;
> +}
> +
> +static int admv4420_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct admv4420_state *st;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_spi(spi, &admv4420_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Error  ADMV4420 initializing spi regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	st->regmap = regmap;
> +	mutex_init(&st->lock);
> +
> +	indio_dev->dev.parent = &spi->dev;

The IIO core should set that for you.

> +	indio_dev->name = "admv4420";
> +	indio_dev->info = &admv4420_info;
> +	indio_dev->channels = admv4420_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(admv4420_channels);
> +
> +	ret = admv4420_setup(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Setup ADMV4420 failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +

> +
> +MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADMV44200 K Band Downconverter");
> +MODULE_LICENSE("Dual BSD/GPL");



