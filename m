Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC74AAA98
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbiBERam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 12:30:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:37399 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbiBERam (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Feb 2022 12:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644082242; x=1675618242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1xQ83hgxHOXYdo6riPdONZ//nBFyhdfrP0f8Jbzp9is=;
  b=ctKso8fwXzaOoQf/8shdlCDdZnpxHmOz8D5PgWribeh3OwFtdxNLzGmX
   MgopIpKtXieOeN3nAbvTOcNrUG8e09EwhThJTXeskS6IWOFnhg/2Ow50q
   IwyyM3nPO2+SYPq53JcxxaPmHKxth/w1pAr9yh9B8lQhCevZIqohc75lQ
   QwcqHa29wOHoW+V/oEFv4wF5URIk1kjmOJhb+L6uOcoYuHFanUpk4MB7x
   YfFis2dfq8Zz6QEa31oDfc8sWgURrjtgChgUhMakrnWHLIr2dBn3hbWR0
   KUGifFtcDj+JOKHQtssya6iZj1fIi6NR8GIp3dwAIlgEcgxZOTOPOLtoe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="228496359"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="228496359"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 09:30:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="524651830"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 09:30:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nGOsW-001KWh-4q;
        Sat, 05 Feb 2022 19:29:40 +0200
Date:   Sat, 5 Feb 2022 19:29:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121142501.151-2-nuno.sa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:
> The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> precision reference. It is guaranteed monotonic and has built in
> rail-to-rail output buffers that can source or sink up to 20 mA.

...

> +#include <linux/of.h>

property.h please/

...

> +static int ltc2688_spi_read(void *context, const void *reg, size_t reg_size,
> +			    void *val, size_t val_size)
> +{
> +	struct ltc2688_state *st = context;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = st->tx_data,
> +			.bits_per_word = 8,
> +			.len = 3,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = st->tx_data + 3,
> +			.rx_buf = st->rx_data,
> +			.bits_per_word = 8,
> +			.len = 3,
> +		},
> +	};
> +	int ret;

> +	memcpy(st->tx_data, reg, reg_size);
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, &st->rx_data[1], val_size);
> +
> +	return 0;
> +}

First of all, yuo have fixed len in transfer sizes, so what the purpose of the reg_size / val_size?
Second, why do you need this specific function instead of regmap bulk ops against be24/le24?

...

> +unlock:

out_unlock: ?
(And in similar cases)

...

> +	if (ret)
> +		return ret;
> +
> +	return len;

In some cases the return ret ?: len; is used, in some like above. Maybe a bit
of consistency?

...

> +	if (private == LTC2688_INPUT_B_AVAIL)
> +		return sysfs_emit(buf, "[%u %u %u]\n", ltc2688_raw_range[0],
> +				  ltc2688_raw_range[1],
> +				  ltc2688_raw_range[2] / 4);

Is it standard form "[A B C]" for ranges in IIO? I haven't looked into the code
deeply (and datasheet at all) to understand meaning. To me range is usually out
of two numbers.

> +	if (private == LTC2688_DITHER_OFF)
> +		return sysfs_emit(buf, "0\n");

> +	ret = ltc2688_dac_code_read(st, chan->channel, private, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);

These three types of output for one sysfs node? Seems it's not align with the
idea behind sysfs. It maybe that I missed something.

...

> +	ret = kstrtou16(buf, 10, &val);

In other function you have long, here u16. I would expect that the types are of
the same class, e.g. if here you have u16, then there something like s32 / s64.
Or here something like unsigned short.

A bit of elaboration why u16 is chosen here?

...

> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),		\
> +	.ext_info = ltc2688_ext_info					\

+ Comma

...

> +static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
> +				 struct ltc2688_chan *chan,
> +				 struct device_node *np, int tgp)
> +{
> +	unsigned long rate;
> +	struct clk *clk;
> +	int ret, f;
> +
> +	clk = devm_get_clk_from_child(&st->spi->dev, np, NULL);
> +	if (IS_ERR(clk))

Make it optional for non-OF, can be done as easy as

	if (IS_ERR(clk)) {
		if (PTR_ERR(clk) == -ENOENT)
			clk = NULL;
		else
			return dev_err_probe(...);
	}

> +		return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
> +				     "failed to get tgp clk.\n");
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return dev_err_probe(&st->spi->dev, ret,
> +				     "failed to enable tgp clk.\n");
> +
> +	ret = devm_add_action_or_reset(&st->spi->dev, ltc2688_clk_disable, clk);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->toggle_chan)
> +		return 0;
> +
> +	/* calculate available dither frequencies */
> +	rate = clk_get_rate(clk);
> +	for (f = 0; f < ARRAY_SIZE(chan->dither_frequency); f++)
> +		chan->dither_frequency[f] = DIV_ROUND_CLOSEST(rate, ltc2688_period[f]);
> +
> +	return 0;
> +}

...

> +static int ltc2688_channel_config(struct ltc2688_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct device_node *child;
> +	u32 reg, clk_input, val, tmp[2];
> +	int ret, span;
> +
> +	for_each_available_child_of_node(dev->of_node, child) {

device_for_each_child_node()

> +		struct ltc2688_chan *chan;
> +
> +		ret = of_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			of_node_put(child);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get reg property\n");
> +		}
> +
> +		if (reg >= LTC2688_DAC_CHANNELS) {
> +			of_node_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg bigger than: %d\n",
> +					     LTC2688_DAC_CHANNELS);
> +		}
> +
> +		val = 0;
> +		chan = &st->channels[reg];
> +		if (of_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan = true;
> +			/* assume sw toggle ABI */
> +			st->iio_chan[reg].ext_info = ltc2688_toggle_sym_ext_info;
> +			/*
> +			 * Clear IIO_CHAN_INFO_RAW bit as toggle channels expose
> +			 * out_voltage_raw{0|1} files.
> +			 */

> +			clear_bit(IIO_CHAN_INFO_RAW,
> +				  &st->iio_chan[reg].info_mask_separate);

Do you need atomic operation here?

> +		}
> +
> +		ret = of_property_read_u32_array(child, "adi,output-range-microvolt",
> +						 tmp, ARRAY_SIZE(tmp));
> +		if (!ret) {
> +			span = ltc2688_span_lookup(st, (int)tmp[0] / 1000,
> +						   tmp[1] / 1000);
> +			if (span < 0) {
> +				of_node_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "output range not valid:[%d %d]\n",
> +						     tmp[0], tmp[1]);
> +			}
> +
> +			val |= FIELD_PREP(LTC2688_CH_SPAN_MSK, span);
> +		}
> +
> +		ret = of_property_read_u32(child, "adi,toggle-dither-input",
> +					   &clk_input);
> +		if (!ret) {
> +			if (clk_input >= LTC2688_CH_TGP_MAX) {
> +				of_node_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "toggle-dither-input inv value(%d)\n",
> +						     clk_input);
> +			}
> +
> +			ret = ltc2688_tgp_clk_setup(st, chan, child, clk_input);
> +			if (ret) {
> +				of_node_put(child);
> +				return ret;
> +			}
> +
> +			/*
> +			 * 0 means software toggle which is the default mode.
> +			 * Hence the +1.
> +			 */
> +			val |= FIELD_PREP(LTC2688_CH_TD_SEL_MSK, clk_input + 1);
> +
> +			/*
> +			 * If a TGPx is given, we automatically assume a dither
> +			 * capable channel (unless toggle is already enabled).
> +			 * On top of this we just set here the dither bit in the
> +			 * channel settings. It won't have any effect until the
> +			 * global toggle/dither bit is enabled.
> +			 */
> +			if (!chan->toggle_chan) {
> +				val |= FIELD_PREP(LTC2688_CH_MODE_MSK, 1);
> +				st->iio_chan[reg].ext_info = ltc2688_dither_ext_info;
> +			} else {
> +				/* wait, no sw toggle after all */
> +				st->iio_chan[reg].ext_info = ltc2688_toggle_ext_info;
> +			}
> +		}
> +
> +		if (of_property_read_bool(child, "adi,overrange")) {
> +			chan->overrange = true;
> +			val |= LTC2688_CH_OVERRANGE_MSK;
> +		}
> +
> +		if (!val)
> +			continue;
> +
> +		ret = regmap_write(st->regmap, LTC2688_CMD_CH_SETTING(reg),
> +				   val);
> +		if (ret) {
> +			of_node_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "failed to set chan settings\n");
> +		}
> +	}
> +
> +	return 0;
> +}

...

> +struct regmap_bus ltc2688_regmap_bus = {
> +	.read = ltc2688_spi_read,
> +	.write = ltc2688_spi_write,
> +	.read_flag_mask = LTC2688_READ_OPERATION,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG

+ Comma.

> +};
> +
> +static const struct regmap_config ltc2688_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.readable_reg = ltc2688_reg_readable,
> +	.writeable_reg = ltc2688_reg_writable,
> +	/* ignoring the no op command */
> +	.max_register = LTC2688_CMD_UPDATE_ALL

Ditto.

> +};

...

> +	vref_reg = devm_regulator_get_optional(dev, "vref");

> +	if (!IS_ERR(vref_reg)) {

Why not positive conditional check (and hence standard pattern -- error
handling first)?

> +		ret = regulator_enable(vref_reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable vref regulators\n");
> +
> +		ret = devm_add_action_or_reset(dev, ltc2688_disable_regulator,
> +					       vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(vref_reg);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to get vref\n");
> +
> +		st->vref = ret / 1000;
> +	} else {
> +		if (PTR_ERR(vref_reg) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(vref_reg),
> +					     "Failed to get vref regulator");
> +
> +		vref_reg = NULL;
> +		/* internal reference */
> +		st->vref = 4096;
> +	}

-- 
With Best Regards,
Andy Shevchenko


