Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B347F4773EE
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhLPOGD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 09:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhLPOGC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 09:06:02 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68441C061574;
        Thu, 16 Dec 2021 06:06:02 -0800 (PST)
Received: from [81.101.6.87] (port=52574 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxrOS-0000lO-NF; Thu, 16 Dec 2021 14:06:01 +0000
Date:   Thu, 16 Dec 2021 14:11:25 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/3] iio: dac: add support for ltc2688
Message-ID: <20211216141110.0a4dc0c3@jic23-huawei>
In-Reply-To: <20211214165608.7903-2-nuno.sa@analog.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
        <20211214165608.7903-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Dec 2021 17:56:06 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

> The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> precision reference. It is guaranteed monotonic and has built in
> rail-to-rail output buffers that can source or sink up to 20 mA.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

I'm not that keen on toggle having to be clock driven, but I guess we can
always change that later when usecases come along.

Some comments inline.

Jonathan

> ---

> +
> +static int ltc2688_spi_read(void *context, const void *reg, size_t reg_size,
> +			    void *val, size_t val_size)
> +{
> +	struct ltc2688_state *st = context;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = reg,
> +			.bits_per_word = 8,
> +			/*
> +			 * This means that @val will also be part of the
> +			 * transfer as there's no pad bits. That's fine as these
> +			 * bits are don't care for the device and we fill
> +			 * @val with the proper value afterwards. Using regmap
> +			 * pad bits to get reg_size right would just make the
> +			 * write part more cumbersome than this...
> +			 */
> +			.len = reg_size + 2,

what Lars said :)

> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = st->tx_data,
> +			.rx_buf = st->rx_data,
> +			.bits_per_word = 8,
> +			.len = 3,
> +		},
> +	};
> +	int ret;
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, &st->rx_data[1], val_size);
> +
> +	return 0;
> +}
> +
> +static int ltc2688_spi_write(void *context, const void *data, size_t count)
> +{
> +	struct ltc2688_state *st = context;
> +
> +	return spi_write(st->spi, data, count);
> +}
> +



> +};
> +
> +static int ltc2688_dac_code_write(struct ltc2688_state *st, u32 chan, u32 input,
> +				  u16 code)
> +{
> +	struct ltc2688_chan *c = &st->channels[chan];
> +	int ret, reg;
> +
> +	/* 2 LSBs set to 0 if writing dither amplitude */
> +	if (!c->toggle_chan && input == LT2688_INPUT_B) {
> +		if (code > GENMASK(13, 0))
> +			return -EINVAL;
> +
> +		code <<= 2;

FIELD_PREP preferred.

> +	}
> +
> +	mutex_lock(&st->lock);
> +	/* select the correct input register to read from */
> +	ret = regmap_update_bits(st->regmap, LTC2688_CMD_A_B_SELECT, BIT(chan),
> +				 input << chan);
> +	if (ret)
> +		goto unlock;
> +
> +	/*
> +	 * If in dither/toggle mode the dac should be updated by an
> +	 * external signal (or sw toggle) and not here.
> +	 */
> +	if (c->mode == LTC2688_MODE_DEFAULT)
> +		reg = LTC2688_CMD_CH_CODE_UPDATE(chan);
> +	else
> +		reg = LTC2688_CMD_CH_CODE(chan);
> +
> +	ret = regmap_write(st->regmap, reg, code);
> +unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}

> +
> +static int ltc2688_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long m)
> +{
> +	struct ltc2688_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ltc2688_dac_code_read(st, chan->channel, LT2688_INPUT_A,
> +					    val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		return ltc2688_offset_get(st, chan->channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val2 = 16;
> +		return ltc2688_scale_get(st, chan->channel, val);

I'm not against functions returning the IIO_VAL_* like this, but if they
are I expect the function to set val2 as well.

I'd suggest return 0 on success and then do similar to what you have done for code_read above.

> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = regmap_read(st->regmap,
> +				  LTC2688_CMD_CH_OFFSET(chan->channel), val);
> +		if (ret)
> +			return ret;
> +
> +		/* Just 13 bits used. 2LSB ignored */
> +		*val >>= 2;
FIELD_GET() would get rid of need for the comment.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = regmap_read(st->regmap,
> +				  LTC2688_CMD_CH_GAIN(chan->channel), val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static ssize_t ltc2688_read_ext(struct iio_dev *indio_dev,
> +				uintptr_t private,
> +				const struct iio_chan_spec *chan,
> +				char *buf)
> +{
> +	struct ltc2688_state *st = iio_priv(indio_dev);
> +	u32 val;
> +	int ret;
> +
> +	switch (private) {
> +	case LTC2688_DITHER_TOGGLE_ENABLE:

As below. I'd have separate functions rather than multiplexing this
to little benefit.

> +		return ltc2688_reg_bool_get(st, chan->channel,
> +					    LTC2688_CMD_TOGGLE_DITHER_EN, buf);
> +	case LTC2688_POWERDOWN:
> +		return ltc2688_reg_bool_get(st, chan->channel,
> +					    LTC2688_CMD_POWERDOWN, buf);
> +	case LTC2688_INPUT_B:
> +		ret = ltc2688_dac_code_read(st, chan->channel, LT2688_INPUT_B,
> +					    &val);
> +		if (ret)
> +			return ret;
> +
> +		return sysfs_emit(buf, "%u\n", val);
> +	case LTC2688_INPUT_B_AVAIL:
> +		/* dither amplitude has 1/4 of the span */
> +		return sysfs_emit(buf, "[%u %u %u]\n", ltc2688_raw_range[0],
> +				  ltc2688_raw_range[1],
> +				  ltc2688_raw_range[2] / 4);
> +	case LTC2688_SW_TOGGLE:
> +		return ltc2688_reg_bool_get(st, chan->channel,
> +					    LTC2688_CMD_SW_TOGGLE, buf);
> +	case LTC2688_DITHER_FREQ:
> +		return ltc2688_dither_freq_get(st, chan->channel, buf);
> +	case LTC2688_DITHER_FREQ_AVAIL:
> +		return ltc2688_dither_freq_avail(st, chan->channel, buf);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ltc2688_write_ext(struct iio_dev *indio_dev,
> +				 uintptr_t private,
> +				 const struct iio_chan_spec *chan,
> +				 const char *buf, size_t len)
> +{
> +	struct ltc2688_state *st = iio_priv(indio_dev);
> +	u16 val;
> +	int ret;
> +	bool en;
> +
> +	switch (private) {
> +	case LTC2688_DITHER_TOGGLE_ENABLE:

As commented on below, I'd just have a function for each case block you have
here.

> +		ret = kstrtobool(buf, &en);
> +		if (ret)
> +			return ret;
> +
> +		ret = ltc2688_dither_toggle_set(st, chan->channel, en);
> +		if (ret)
> +			return ret;
> +
> +		return len;
> +	case LTC2688_POWERDOWN:
> +		ret = ltc2688_reg_bool_set(st, chan->channel,
> +					   LTC2688_CMD_POWERDOWN, buf);
> +		if (ret)
> +			return ret;
> +
> +		return len;
> +	case LTC2688_INPUT_B:
> +		ret = kstrtou16(buf, 10, &val);
> +		if (ret)
> +			return ret;
> +
> +		ret = ltc2688_dac_code_write(st, chan->channel, LT2688_INPUT_B,
> +					     val);
> +		if (ret)
> +			return ret;
> +
> +		return len;
> +	case LTC2688_SW_TOGGLE:
> +		ret = ltc2688_reg_bool_set(st, chan->channel,
> +					   LTC2688_CMD_SW_TOGGLE, buf);
> +		if (ret)
> +			return ret;
> +
> +		return len;
> +	case LTC2688_DITHER_FREQ:
> +		ret = ltc2688_dither_freq_set(st, chan->channel, buf);
> +		if (ret)
> +			return ret;
> +
> +		return len;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc2688_get_dither_phase(struct iio_dev *dev,
> +				    const struct iio_chan_spec *chan)
> +{
> +	struct ltc2688_state *st = iio_priv(dev);
> +	int ret, regval;
> +
> +	ret = regmap_read(st->regmap, LTC2688_CMD_CH_SETTING(chan->channel),
> +			  &regval);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_GET(LTC2688_CH_DIT_PH_MSK, regval);
> +}
> +
> +static int ltc2688_set_dither_phase(struct iio_dev *dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int phase)
> +{
> +	struct ltc2688_state *st = iio_priv(dev);
> +
> +	return regmap_update_bits(st->regmap,
> +				  LTC2688_CMD_CH_SETTING(chan->channel),
> +				  LTC2688_CH_DIT_PH_MSK,
> +				  FIELD_PREP(LTC2688_CH_DIT_PH_MSK, phase));
> +}
> +
> +static int ltc2688_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct ltc2688_state *st = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +	else
> +		return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static const char * const ltc2688_dither_phase[] = {
> +	"0", "90", "180", "270",
> +};
> +
> +static const struct iio_enum ltc2688_dither_phase_enum = {
> +	.items = ltc2688_dither_phase,
> +	.num_items = ARRAY_SIZE(ltc2688_dither_phase),
> +	.set = ltc2688_set_dither_phase,
> +	.get = ltc2688_get_dither_phase,
> +};
> +
> +#define LTC2688_CHAN_EXT_INFO(_name, _what, _shared) {	\
> +	.name = _name,					\
> +	.read = ltc2688_read_ext,			\
> +	.write = ltc2688_write_ext,			\

I'm not really convinced big multiplexer functions are a good idea here.
They seem to save little code and hurt readability a bit.

> +	.private = (_what),				\
> +	.shared = (_shared),				\
> +}
> +
> +/*
> + * For toggle mode we only expose the symbol attr (sw_toggle) in case a TGPx is
> + * not provided in dts.
> + */
> +#define LTC2688_CHAN_TOGGLE(t, name) ({							\
> +	static const struct iio_chan_spec_ext_info t ## _ext_info[] = {			\
> +		LTC2688_CHAN_EXT_INFO("raw1", LTC2688_INPUT_B, IIO_SEPARATE),		\
> +		LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_DITHER_TOGGLE_ENABLE,	\
> +				      IIO_SEPARATE),					\
> +		LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_POWERDOWN, IIO_SEPARATE),	\
> +		LTC2688_CHAN_EXT_INFO(name, LTC2688_SW_TOGGLE, IIO_SEPARATE),		\
> +		{}									\
> +	};										\
> +	t ## _ext_info;									\
> +})
> +
> +static struct iio_chan_spec_ext_info ltc2688_dither_ext_info[] = {
> +	LTC2688_CHAN_EXT_INFO("dither_raw", LTC2688_INPUT_B, IIO_SEPARATE),
> +	LTC2688_CHAN_EXT_INFO("dither_raw_available", LTC2688_INPUT_B_AVAIL,
> +			      IIO_SEPARATE),
> +	/*
> +	 * Not IIO_ENUM because the available freq needs to be computed at
> +	 * probe. We could still use it, but it didn't felt much right.
> +	 *

no extra blank line.

> +	 */
> +	LTC2688_CHAN_EXT_INFO("dither_frequency", LTC2688_DITHER_FREQ,
> +			      IIO_SEPARATE),
> +	LTC2688_CHAN_EXT_INFO("dither_frequency_available",
> +			      LTC2688_DITHER_FREQ_AVAIL, IIO_SEPARATE),
> +	IIO_ENUM("dither_phase", IIO_SEPARATE, &ltc2688_dither_phase_enum),
> +	IIO_ENUM_AVAILABLE("dither_phase", IIO_SEPARATE,
> +			   &ltc2688_dither_phase_enum),
> +	LTC2688_CHAN_EXT_INFO("dither_en", LTC2688_DITHER_TOGGLE_ENABLE,
> +			      IIO_SEPARATE),
> +	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_POWERDOWN, IIO_SEPARATE),
> +	{}
> +};
> +
> +static const struct iio_chan_spec_ext_info ltc2688_ext_info[] = {
> +	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_POWERDOWN, IIO_SEPARATE),
> +	{}
> +};
> +

> +
> +enum {
> +	LTC2688_CHAN_TD_TGP1,
> +	LTC2688_CHAN_TD_TGP2,
> +	LTC2688_CHAN_TD_TGP3,
> +	LTC2688_CHAN_TD_MAX
> +};

> +/* Helper struct to deal with dither channels binded to TGPx pins */
> +struct ltc2688_dither_helper {
> +	u8 chan[LTC2688_DAC_CHANNELS];
> +	u8 n_chans;
> +};
> +
bitmap perhaps given ordering doesn't matter (I think)



...

> +
> +static int ltc2688_channel_config(struct ltc2688_state *st)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(&st->spi->dev), *child;
> +	struct ltc2688_dither_helper tgp[LTC2688_CHAN_TD_MAX] = {0};
> +	u32 reg, clk_input, val, mask, tmp[2];
> +	unsigned long clk_msk = 0;
> +	int ret, span;
> +

I think you need to sanity check you have a fwnode

> +	fwnode_for_each_available_child_node(fwnode, child) {

I guess this is because of the whole device_for_each_available_child_node() not
existing discussion that isn't resolved. 

> +		struct ltc2688_chan *chan;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(&st->spi->dev, ret,
> +					     "Failed to get reg property\n");
> +		}
> +
> +		if (reg >= LTC2688_DAC_CHANNELS) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(&st->spi->dev, -EINVAL,
> +					     "reg bigger than: %d\n",
> +					     LTC2688_DAC_CHANNELS);
> +		}
> +
> +		chan = &st->channels[reg];
> +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan = true;
> +			/* assume sw toggle ABI */
> +			ltc2688_channels[reg].ext_info = LTC2688_CHAN_TOGGLE(__s, "symbol");

That's a little nasty.  Pick it up from a static const array defined outside
this function.

> +		}
> +
> +		ret = fwnode_property_read_u32_array(child, "adi,output-range-millivolt",
> +						     tmp, ARRAY_SIZE(tmp));
> +		if (!ret) {
> +			span = ltc2688_span_lookup(st, tmp[0], tmp[1]);
> +			if (span < 0)
> +				return dev_err_probe(&st->spi->dev, -EINVAL,
> +						     "output range not valid:[%d %d]\n",
> +						     tmp[0], tmp[1]);
> +
> +			mask |= LTC2688_CH_SPAN_MSK;
> +			val |= FIELD_PREP(LTC2688_CH_SPAN_MSK, span);
> +		}
> +
> +		ret = fwnode_property_read_u32(child, "adi,toggle-dither-input",
> +					       &clk_input);
> +		if (!ret) {
> +			int cur_chan = tgp[clk_input].n_chans;
> +
> +			if (clk_input > LTC2688_CHAN_TD_TGP3) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(&st->spi->dev, -EINVAL,
> +						     "toggle-dither-input inv value(%d)\n",
> +						     clk_input);
> +			}
> +
> +			mask |= LTC2688_CH_TD_SEL_MSK;
> +			/*
> +			 * 0 means software toggle which is the default mode.
> +			 * Hence the +1.
> +			 */
> +			val |= FIELD_PREP(LTC2688_CH_TD_SEL_MSK, clk_input + 1);
> +			clk_msk |= BIT(clk_input);
> +			/*
> +			 * If a TGPx is given, we automatically assume a dither
> +			 * capable channel (unless toggle is already enabled).
> +			 * Hence, we prepar our TGPx <-> channel map to make it

prepare

> +			 * easier to handle the clocks and available frequency
> +			 * calculations... On top of this we just set here the
> +			 * dither bit in the channel settings. It won't have any
> +			 * effect until the global toggle/dither bit is enabled.
> +			 */
> +			if (!chan->toggle_chan) {
> +				tgp[clk_input].chan[cur_chan] = reg;
> +				tgp[clk_input].n_chans++;
> +				mask |= LTC2688_CH_MODE_MSK;
> +				val |= FIELD_PREP(LTC2688_CH_MODE_MSK, 1);
> +				ltc2688_channels[reg].ext_info = ltc2688_dither_ext_info;
> +			} else {
> +				/* wait, no sw toggle after all */
> +				ltc2688_channels[reg].ext_info = LTC2688_CHAN_TOGGLE(__no_s, NULL);
> +			}
> +		}
> +
> +		if (fwnode_property_read_bool(child, "adi,overrange")) {
> +			chan->overrange = true;
> +			val |= LTC2688_CH_OVERRANGE_MSK;
> +			mask |= BIT(3);
> +		}
> +
> +		if (!mask)
> +			continue;
> +
> +		ret = regmap_update_bits(st->regmap,
> +					 LTC2688_CMD_CH_SETTING(reg), mask,
> +					 val);

Maybe I'm missing something, but why not just write the whole register?
Certainly most if not all of the value is controlled by this function or known
at this point to be in the reset state.


> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(&st->spi->dev, -EINVAL,
> +					     "failed to set chan settings\n");
> +		}
> +
> +		mask = 0;
> +		val = 0;

Why not at the start of the loop?  Particularly as I can't see them being
initialised for the first loop.


> +	}
> +
> +	return ltc2688_tgp_setup(st, clk_msk, tgp);
> +}


...

> +static bool ltc2688_reg_writable(struct device *dev, unsigned int reg)
> +{
> +	if (reg <= LTC2688_CMD_UPDATE_ALL && reg != LTC2688_CMD_THERMAL_STAT)

Isn't UPDATE_ALL the last register?  So how do you get higher than that?
Definitely needs a comment if there is a reason that check is necessary.

> +		return true;
> +
> +	return false;
> +}
> +
> +struct regmap_bus ltc2688_regmap_bus = {
> +	.read = ltc2688_spi_read,
> +	.write = ltc2688_spi_write,
> +	.read_flag_mask = LTC2688_READ_OPERATION,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG
> +};
> +
> +static const struct regmap_config ltc2688_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.readable_reg = ltc2688_reg_readable,
> +	.writeable_reg = ltc2688_reg_writable,
> +	/* ignoring the no op command */
> +	.max_register = LTC2688_CMD_UPDATE_ALL
> +};
> +
> +static const struct iio_info ltc2688_info = {
> +	.write_raw = ltc2688_write_raw,
> +	.read_raw = ltc2688_read_raw,
> +	.read_avail = ltc2688_read_avail,
> +	.debugfs_reg_access = ltc2688_reg_access,
> +};
> +
> +static int ltc2688_probe(struct spi_device *spi)
> +{
> +	struct ltc2688_state *st;
> +	struct iio_dev *indio_dev;
> +	struct regulator *vref_reg;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;

blank line so it's clear the comment refers to the next block.

> +	/* Just this once. No need to di it in every regmap read */

do

> +	st->tx_data[0] = LTC2688_CMD_NOOP;
> +	mutex_init(&st->lock);
> +
> +	st->regmap = devm_regmap_init(&spi->dev, &ltc2688_regmap_bus, st,

A lot of references to &spi->dev so probably worth a local
struct device *dev = &spi->dev; Might let a few things fit
on fewer lines, but either way it'll be a little tidier.


> +				      &ltc2688_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +				     "Failed to init regmap");
> +
> +	st->regulators[0].supply = "vcc";
> +	st->regulators[1].supply = "iovcc";
> +	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ltc2688_bulk_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (!IS_ERR(vref_reg)) {
> +		ret = regulator_enable(vref_reg);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to enable vref regulators\n");
> +
> +		ret = devm_add_action_or_reset(&spi->dev,
> +					       ltc2688_disable_regulator,
> +					       vref_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(vref_reg);
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to get vref\n");
> +
> +		st->vref = ret / 1000;
> +	} else {
> +		if (PTR_ERR(vref_reg) != -ENODEV)
> +			return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
> +					     "Failed to get vref regulator");
> +
> +		vref_reg = NULL;
> +		/* internal reference */
> +		st->vref = 4096;
> +	}
> +
> +	indio_dev->name = "ltc2688";
> +	indio_dev->info = &ltc2688_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ltc2688_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltc2688_channels);
> +
> +	ret = ltc2688_setup(st, vref_reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +}
> +

