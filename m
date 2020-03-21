Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1129E18E4B1
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCUVJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:09:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:49832 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgCUVJX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 17:09:23 -0400
IronPort-SDR: tCkzTud/pHJpYddUI2djKpp8Ij/+Zk62D2U+Bgdt6GWGuzbIHXCW7A1d+Gzi95bV1Y3cwooZ9V
 SOCDLlLhPIrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 14:09:21 -0700
IronPort-SDR: BZY+EKG1RKhkNlv2ucSh4eesHE/QzS58rnDfzqmR1s5ojnZWIkNiBYkAA2P5jk/uRfyahkDY+H
 5MvC2nBELqYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,289,1580803200"; 
   d="scan'208";a="392500096"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2020 14:09:19 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jFlMv-00BoyE-NU; Sat, 21 Mar 2020 23:09:21 +0200
Date:   Sat, 21 Mar 2020 23:09:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH v4 1/2] iio: dac: ad5770r: Add AD5770R support
Message-ID: <20200321210921.GA2814584@smile.fi.intel.com>
References: <20200218121031.27233-1-alexandru.tachici@analog.com>
 <20200218121031.27233-2-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218121031.27233-2-alexandru.tachici@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 18, 2020 at 02:10:30PM +0200, Alexandru Tachici wrote:
> The AD5770R is a 6-channel, 14-bit resolution, low noise, programmable
> current output digital-to-analog converter (DAC) for photonics control
> applications.
> 
> It contains five 14-bit resolution current sourcing DAC channels and one
> 14-bit resolution current sourcing/sinking DAC channel.

...

> +#define AD5770R_CFG_CH0_SINK_EN(x)		(((x) & 0x1) << 7)
> +#define AD5770R_CFG_SHUTDOWN_B(x, ch)		(((x) & 0x1) << (ch))

BIT(0) ?

> +#define AD5770R_REF_RESISTOR_SEL(x)		(((x) & 0x1) << 2)

Ditto.

> +#define AD5770R_CH_SET(x, ch)		(((x) & 0x1) << (ch))

Ditto.

...

> +enum ad5770r_ch0_modes {
> +	AD5770R_CH0_0_300 = 0,
> +	AD5770R_CH0_NEG_60_0,
> +	AD5770R_CH0_NEG_60_300
> +};
> +
> +enum ad5770r_ch1_modes {
> +	AD5770R_CH1_0_140_LOW_HEAD = 1,
> +	AD5770R_CH1_0_140_LOW_NOISE,
> +	AD5770R_CH1_0_250
> +};
> +
> +enum ad5770r_ch2_5_modes {
> +	AD5770R_CH_LOW_RANGE = 0,
> +	AD5770R_CH_HIGH_RANGE
> +};
> +
> +enum ad5770r_ref_v {
> +	AD5770R_EXT_2_5_V = 0,
> +	AD5770R_INT_1_25_V_OUT_ON,
> +	AD5770R_EXT_1_25_V,
> +	AD5770R_INT_1_25_V_OUT_OFF
> +};
> +
> +enum ad5770r_output_filter_resistor {
> +	AD5770R_FILTER_60_OHM = 0x0,
> +	AD5770R_FILTER_5_6_KOHM = 0x5,
> +	AD5770R_FILTER_11_2_KOHM,
> +	AD5770R_FILTER_22_2_KOHM,
> +	AD5770R_FILTER_44_4_KOHM,

> +	AD5770R_FILTER_104_KOHM,

It would be nice to go consistent about last entry in enums. Are they
terminators? For me it doesn't look like it (new revision of hardware
always can use extended lists of modes, etc).

So, I think leaving comma for all above is a right thing to do.

> +};

...

> +static const unsigned int ad5770r_filter_reg_vals[] = {
> +	AD5770R_FILTER_104_KOHM,
> +	AD5770R_FILTER_44_4_KOHM,
> +	AD5770R_FILTER_22_2_KOHM,
> +	AD5770R_FILTER_11_2_KOHM,
> +	AD5770R_FILTER_5_6_KOHM,
> +	AD5770R_FILTER_60_OHM
> +};

Ditto.

...

> +	return regmap_write(st->regmap,
> +			    AD5770R_OUTPUT_RANGE(channel), regval);

It fits one line (even has room for one character more)
Perhaps you may consider to amend settings of your text editor?
Please fix all similar places in all of your patches.

...

> +static int ad5770r_reset(struct ad5770r_state *st)
> +{
> +	/* Perform software reset if no GPIO provided */
> +	if (!st->gpio_reset)
> +		return ad5770r_soft_reset(st);


Perhaps split this to _reset_gpio() and do

	if (gpio)
		return _reset_gpio();
	else // It's redundant, but some people use for a style
		return _soft_reset();

> +
> +	gpiod_set_value_cansleep(st->gpio_reset, 0);
> +	usleep_range(10, 20);
> +	gpiod_set_value_cansleep(st->gpio_reset, 1);
> +
> +	/* data must not be written during reset timeframe */
> +	usleep_range(100, 200);
> +
> +	return 0;
> +}

...

> +		ret = regmap_bulk_read(st->regmap,
> +				       chan->address,

> +				       st->transf_buf, 2);

sizeof() ?

> +		if (ret)
> +			return 0;

...

> +		st->transf_buf[0] = ((u16)val >> 6);

Why explicit casting?

> +		st->transf_buf[1] = (val & GENMASK(5, 0)) << 2;
> +		return regmap_bulk_write(st->regmap, chan->address,
> +					 st->transf_buf, 2);

sizeof() ?

...

> +static int ad5770r_read_freq_avail(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   const int **vals, int *type, int *length,
> +				   long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*type = IIO_VAL_INT;
> +		*vals = ad5770r_filter_freqs;
> +		*length = ARRAY_SIZE(ad5770r_filter_freqs);
> +		return IIO_AVAIL_LIST;
> +	}
> +

> +	return -EINVAL;

default case?

> +}

...

> +	ret = kstrtobool(buf, &readin);
> +	if (ret)
> +		return ret;
> +

> +	readin = !readin;

I think using ! directly in places where it's needed will be helpful ti
understand the code.

> +
> +	regval = AD5770R_CFG_SHUTDOWN_B(readin, chan->channel);
> +	if (chan->channel == 0 &&
> +	    st->output_mode[0].out_range_mode > AD5770R_CH0_0_300) {
> +		regval |= AD5770R_CFG_CH0_SINK_EN(readin);
> +		mask = BIT(chan->channel) + BIT(7);
> +	} else {
> +		mask = BIT(chan->channel);
> +	}
> +	ret = regmap_update_bits(st->regmap, AD5770R_CHANNEL_CONFIG, mask,
> +				 regval);
> +	if (ret)
> +		return ret;
> +
> +	regval = AD5770R_CH_SET(readin, chan->channel);
> +	ret = regmap_update_bits(st->regmap, AD5770R_CH_ENABLE,
> +				 BIT(chan->channel), regval);
> +	if (ret)
> +		return ret;
> +
> +	st->ch_pwr_down[chan->channel] = !readin;

...

> +	int ret, tmp[2], min, max;
> +	unsigned int num;
> +	struct fwnode_handle *child;
> +
> +	num = device_get_child_node_count(&st->spi->dev);
> +	if (num != AD5770R_MAX_CHANNELS)
> +		return -EINVAL;
> +
> +	device_for_each_child_node(&st->spi->dev, child) {
> +		ret = fwnode_property_read_u32(child, "num", &num);
> +		if (ret)
> +			return ret;
> +		if (num > AD5770R_MAX_CHANNELS)
> +			return -EINVAL;
> +
> +		ret = fwnode_property_read_u32_array(child,
> +						     "adi,range-microamp",

> +						     tmp, 2);

sizeof()?

And perhaps
	u32 tmp[2];

> +		if (ret)
> +			return ret;
> +
> +		min = tmp[0] / 1000;
> +		max = tmp[1] / 1000;
> +		ret = ad5770r_store_output_range(st, min, max, num);
> +		if (ret)
> +			return ret;
> +	}

> +	return ret;

ret might be uninitialized?

In any case, shouldn't be
	return 0;
?

> +}

...

> +	st->external_res = fwnode_property_read_bool(st->spi->dev.fwnode,
> +						     "adi,external-resistor");

Use of fwnode (and esp. w/o dev_fwnode() helper) looks inconsistent here.
Why not device_property_...()?

> +	return ret;

return 0;

...

> +static const struct of_device_id ad5770r_of_id[] = {
> +	{ .compatible = "adi,ad5770r", },

> +	{},

No need comma in terminator line.

> +};
> +MODULE_DEVICE_TABLE(of, ad5770r_of_id);
> +
> +static const struct spi_device_id ad5770r_id[] = {
> +	{ "ad5770r", 0 },

> +	{},

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko


