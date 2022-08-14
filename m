Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CC3592240
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiHNPrI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiHNPoj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 11:44:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8E2408D
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 08:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8041BB80B48
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 15:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10984C433C1;
        Sun, 14 Aug 2022 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491238;
        bh=dsGScxKqzywLdaDzDAIdqtaSYVdS4JlJ5ATXY/+uUXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ml/JEx22EcRjCmEAj/7B977ol4L6y12Srni9mGGXDqTZjskhsqBfqNlhPX6fADs/1
         F2Q/XlTnL/WNoE1lLYKGSVRk204ZY1lfEfw0l7p5pk/BgxJ1lmc4Ajkpl5qFYdQ8as
         oGGBm7/Zo8cD0MSOxUh/lbf89Ysdn8O4J7Errma+ZCQLXdzaKzn/HDK3iayuYXNHUV
         R42aLpYK9Yta3megG698R5zglbnTAByYYaPlHB1xhVx+9APr438/58s9E799zSZw4X
         vyOmktNYopib8UyhU6d/inmSC661a9OXzfjysmyV/LvQb/Vi6Tqls0N2ZtaD7ptfUE
         Ac97kl5GnxcVg==
Date:   Sun, 14 Aug 2022 16:44:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v3 1/2] iio: adc: add max11410 adc driver
Message-ID: <20220814164427.5d278beb@jic23-huawei>
In-Reply-To: <20220811134243.111-2-Ibrahim.Tilki@analog.com>
References: <20220811134243.111-1-Ibrahim.Tilki@analog.com>
        <20220811134243.111-2-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Aug 2022 13:42:42 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> has 3 differential reference and 10 differential channel inputs.
> Inputs and references can be buffered internally. Inputs can also
> be amplified with internal PGA.
> 
> Device has four digital filter modes: FIR50/60, FIR50, FIR60 and SINC4.
> FIR 50Hz and 60Hz rejections can be enabled/disabled separately.
> Digital filter selection affects sampling frequency range so driver
> has to consider the configured filter when configuring sampling frequency.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>

Hi

Line length is a bit random currently.  Rough set of rules I'd go by:
1) If it doesn't hurt readability stay under 80 chars, but don't overwrap.
2) If there is a string someone might grep for, long lines are fine.
3) Try to keep under 100 chars in any case. (you are fine on this)

unfortunately I got confused and gave you some misleading feedback on v2.
Short version is: ADC drivers do not present HARDWAREGAIN as it has no
relevant meaning for them.  They present only SCALE (and maybe CALIBSCALE
if there are tuning values to be tweaked).  The driver is then expected
to work out the right settings of PGAs etc to achieve the requested scale
value.


> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> new file mode 100644
> index 000000000..383cef3a0
> --- /dev/null
> +++ b/drivers/iio/adc/max11410.c
> @@ -0,0 +1,954 @@
> +// SPDX-License-Identifier: GPL-2.0-only

No copyright notice?  Unusual for such a big piece of work.

> +
> +static const u8 max11410_sampling_len[] = {
> +	[MAX11410_FILTER_FIR5060] = 5,
> +	[MAX11410_FILTER_FIR50] = 6,
> +	[MAX11410_FILTER_FIR60] = 6,
> +	[MAX11410_FILTER_SINC4] = 10,
> +};
> +
> +static const int max11410_sampling_rates[4][10][2] = {
> +	[MAX11410_FILTER_FIR5060] = {
> +		{1, 100000},
		{ 1, 100000 }, throughout to match most common kernel style.
We don't always bother fixing this in old code, because it creates
a lot of noise, but good to get it right in new code.

> +		{2, 100000},
> +		{4, 200000},
> +		{8, 400000},
> +		{16, 800000}
> +	},
> +	[MAX11410_FILTER_FIR50] = {
> +		{1, 300000},
> +		{2, 700000},
> +		{5, 300000},
> +		{10, 700000},
> +		{21, 300000},
> +		{40}
> +	},
> +	[MAX11410_FILTER_FIR60] = {
> +		{1, 300000},
> +		{2, 700000},
> +		{5, 300000},
> +		{10, 700000},
> +		{21, 300000},
> +		{40}
> +	},
> +	[MAX11410_FILTER_SINC4] = {
> +		{4},
> +		{10},
> +		{20},
> +		{40},
> +		{60},
> +		{120},
> +		{240},
> +		{480},
> +		{960},
> +		{1920}
> +	}
> +};




> +static ssize_t max11410_notch_en_store(struct device *dev,
> +				       struct device_attribute *devattr,
> +				       const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct max11410_state *state = iio_priv(indio_dev);
> +	struct iio_dev_attr *iio_attr = to_iio_dev_attr(devattr);
> +	unsigned int filter_bit;
> +	int ret;
> +
> +	filter_bit = iio_attr->address == 0 ? MAX11410_FILTER_50HZ : MAX11410_FILTER_60HZ;
> +	if (sysfs_streq(buf, "0"))

Tend to use kstrtobool() for cases like this. It's a little more generous in what it
accepts. Documentation can carry on saying 0 or 1 though and we print 0 or 1 as most
appropriate values for this attribute.

> +		ret = regmap_set_bits(state->regmap, MAX11410_REG_FILTER, filter_bit);
> +	else if (sysfs_streq(buf, "1"))
> +		ret = regmap_clear_bits(state->regmap, MAX11410_REG_FILTER, filter_bit);
> +	else
> +		return -EINVAL;
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static IIO_CONST_ATTR(in_voltage_filter0_notch_center, "50");
> +static IIO_CONST_ATTR(in_voltage_filter1_notch_center, "60");
> +
> +static IIO_DEVICE_ATTR(in_voltage_filter0_notch_en, 0644,
> +		       max11410_notch_en_show, max11410_notch_en_store, 0);
> +static IIO_DEVICE_ATTR(in_voltage_filter1_notch_en, 0644,
> +		       max11410_notch_en_show, max11410_notch_en_store, 1);
> +
> +static struct attribute *max11410_attributes[] = {
> +	&iio_const_attr_in_voltage_filter0_notch_center.dev_attr.attr,
> +	&iio_const_attr_in_voltage_filter1_notch_center.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_filter0_notch_en.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_filter1_notch_en.dev_attr.attr,

As mentioned in reply to cover letter this is all new, so please
provide ABI documentatio to cover it.
I'm not fully comfortable with the approach of getting sinc4 if nothing
else is configured but perhaps that makes sense. I'm a bit surprised that
the hardware doesn't allow both the sinc4 and the FIR filters as would
seem logical to get rid of Mains and sampling frequency associated noise.

We could take advantage of the fact that IIO ABI allows any file write
to effect any other (needed as we can't always describe complex dependencies
and hence have additional attrs
	in_voltage_filter2_notch_en (if you turn both the fir filters off you get this.
		if you turn this on, then turn off).
	in_voltage_filter2_notch_centre which matches the sampling frequency (I think!)

That might be clearer than implicit control of that filter?


> +	NULL
> +};
> +

> +static int max11410_configure_channel(struct max11410_state *st,
> +				      struct iio_chan_spec const *chan)
> +{
> +	int ret;
> +	unsigned int regval;
> +	struct max11410_channel_config cfg = st->channels[chan->address];
> +
> +	if (chan->differential)
> +		ret = max11410_set_input_mux(st, chan->channel, chan->channel2);
> +	else
> +		ret = max11410_set_input_mux(st, chan->channel, MAX11410_AINN_GND);
> +
> +	if (ret)
> +		return ret;
> +
> +	regval = FIELD_PREP(MAX11410_CTRL_VREFP_BUF_BIT, cfg.buffered_vrefp) |
> +		 FIELD_PREP(MAX11410_CTRL_VREFN_BUF_BIT, cfg.buffered_vrefn) |
> +		 FIELD_PREP(MAX11410_CTRL_REFSEL_MASK, cfg.refsel) |
> +		 FIELD_PREP(MAX11410_CTRL_UNIPOLAR_BIT, !cfg.bipolar);
> +	ret = regmap_update_bits(st->regmap, MAX11410_REG_CTRL,
> +				 MAX11410_CTRL_REFSEL_MASK | MAX11410_CTRL_VREFN_BUF_BIT |
> +				 MAX11410_CTRL_VREFN_BUF_BIT | MAX11410_CTRL_UNIPOLAR_BIT,
> +				 regval);
> +	if (ret)
> +		return ret;
> +
> +	regval = FIELD_PREP(MAX11410_PGA_SIG_PATH_MASK, cfg.sig_path) |
> +		 FIELD_PREP(MAX11410_PGA_GAIN_MASK, cfg.gain);
> +	ret = regmap_write(st->regmap, MAX11410_REG_PGA, regval);
> +	if (ret)
> +		return ret;
> +
> +	if (cfg.settling_time_us)
> +		fsleep(cfg.settling_time_us);
> +
> +	return ret;

return 0;  Can't get here with any other value, so good to make that explicit.

> +}
> +
> +static int max11410_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	int ret, reg_val, filter, rate;
> +	struct regulator *vrefp, *vrefn;
> +	struct max11410_state *state = iio_priv(indio_dev);
> +	struct max11410_channel_config cfg = state->channels[chan->address];
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		vrefp = max11410_get_vrefp(state, cfg.refsel);
> +		if (!vrefp) {
> +			/* We should never get here */
> +			return -ENODEV;
> +		}
> +
> +		*val = regulator_get_voltage(vrefp) / 1000;
> +		vrefn = max11410_get_vrefn(state, cfg.refsel);
> +		if (vrefn)
> +			*val -= regulator_get_voltage(vrefn) / 1000;
> +
> +		if (cfg.bipolar)
> +			*val *= 2;
> +
> +		*val = *val >> cfg.gain;
> +
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (cfg.bipolar)
> +			*val = -BIT(chan->scan_type.realbits - 1);
> +		else
> +			*val = 0;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&state->lock);
> +
> +		ret = max11410_configure_channel(state, chan);
> +
> +		if (!ret)
> +			ret = max11410_sample(state, &reg_val);

Perhaps pull out these few lines of code as a helper so as to avoid
the nasty if (!ret) handling.
max11410_read_channel() or something like that.


> +
> +		mutex_unlock(&state->lock);
> +
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*val = BIT(cfg.gain);

See below. This shouldn't exist for an ADC driver.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(state->regmap, MAX11410_REG_FILTER, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		filter = FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
> +		rate = reg_val & MAX11410_FILTER_RATE_MASK;
> +		if (rate >= max11410_sampling_len[filter])
> +			rate = max11410_sampling_len[filter] - 1;
> +
> +		*val = max11410_sampling_rates[filter][rate][0];
> +		*val2 = max11410_sampling_rates[filter][rate][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const int max11410_hwgain_list[] = {1, 2, 4, 8, 16, 32, 64, 128};
> +
> +static int max11410_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int i, ret, reg_val, filter;
> +	struct max11410_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:

Ah. I gave a misleading response to discussion on previous patch as I misunderstood
your question. Sorry about that!  Just checked back on the v2 thread because I
was surprised to see this here.

We shouldn't be using hardwaregain at all in this driver.  Instead
we should be computing the available _scale values for the various settings
of hardware gain and making _scale controllable.

Hardware gain is intended for usecases where the gain is not directly
on the channel value being measured (e.g. on the ADC used to measure a pulse
on a time of flight sensor - the scale is on the voltage, not distance which
is derived from the timing of those pulses). Userspace software as a result
doesn't understand the use of hardware gain you have here.  It does tend to
understand using writable _SCALE.

It is more complex to write the code for scale, but it is an easier interface
for userspace to use as it needs to change one value, not change something
seemingly unrelated then notice the change in _scale which is what it cares
about.  You will need to provide an available_scale and that will require
runtime computation based on the reference voltage.  Sometimes it's better
to just precompute that in probe() rather than doing it dynamically later.

> +		for (i = 0; i < ARRAY_SIZE(max11410_hwgain_list); ++i) {
> +			if (val == max11410_hwgain_list[i])
> +				break;
> +		}
> +		if (i == ARRAY_SIZE(max11410_hwgain_list))
> +			return -EINVAL;
> +
> +		st->channels[chan->address].gain = i;
> +
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
> +
> +		ret = regmap_read(st->regmap, MAX11410_REG_FILTER, &reg_val);
> +		if (ret)
> +			goto out;
> +
> +		filter = FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
> +
> +		for (i = 0; i < max11410_sampling_len[filter]; ++i) {
> +			if (val == max11410_sampling_rates[filter][i][0] &&
> +			    val2 == max11410_sampling_rates[filter][i][1])
> +				break;
> +		}
> +		if (i == max11410_sampling_len[filter]) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			goto out;
> +
> +		ret = regmap_write_bits(st->regmap, MAX11410_REG_FILTER,
> +					MAX11410_FILTER_RATE_MASK, i);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +out:
> +		mutex_unlock(&st->lock);
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>


> +
> +static int max11410_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	int scan_ch, ret;
> +	struct max11410_state *st = iio_priv(indio_dev);
> +
> +	/* Configure GPIO1 of MAX11410 as interrupt output. */
I'd missed this before, but it's come up for some other drivers in the meantime..

This will follow through to the binding, but it's very hard to retrofit support for
different interrupt lines being wired.  Much easier to add that now.
Alternative is having the binding be flexible but check and reject interrupt
wirings the driver doesn't know about yet.

> +	ret = max11410_write_reg(st, MAX11410_REG_GP1_CTRL, MAX11410_GP1_CTRL_INTRB);
> +	if (ret)
> +		return ret;
> +
> +	scan_ch = ffs(*indio_dev->active_scan_mask) - 1;
> +
> +	ret = max11410_configure_channel(st, &indio_dev->channels[scan_ch]);
> +	if (ret)
> +		return ret;
> +
> +	/* Start continuous conversion. */
> +	return max11410_write_reg(st, MAX11410_REG_CONV_START, MAX11410_CONV_TYPE_CONTINUOUS);
> +}
> +

> +static int max11410_parse_channels(struct max11410_state *st,
> +				   struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *channels;
> +	struct fwnode_handle *child;
> +	struct max11410_channel_config *cfg;
> +	struct device *dev = &st->spi_dev->dev;
> +	const char *node_name;
> +	unsigned int num_ch;
> +	u32 inputs[2];
> +	u32 reference, sig_path;
> +	int chan_idx = 0;
> +	int ret;
> +	struct iio_chan_spec chanspec = chanspec_template;

Where it doesn't hurt grouping for readability, slight preference for reverse
xmas tree.

> +
> +	num_ch = device_get_child_node_count(dev);
> +	if (num_ch == 0)
> +		return dev_err_probe(&indio_dev->dev,
> +				     -ENODEV,
> +				     "FW has no channels defined\n");
> +
> +	/* Reserve space for soft timestamp channel */
> +	num_ch++;
> +	channels = devm_kcalloc(dev, num_ch,
> +				sizeof(struct iio_chan_spec),
> +				GFP_KERNEL);

overwrapped.  That fits nicely on one fewer lines.

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	st->channels = devm_kcalloc(dev, num_ch,
> +				    sizeof(struct max11410_channel_config),

sizeof(*st->channels) preferred for cases like this.

> +				    GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
...

> +}

> +
> +static int max11410_init_vref(struct device *dev,
> +			      struct regulator **vref,
> +			      const char *id)
> +{
> +	int ret;
> +	struct regulator *reg;
> +
> +	reg = devm_regulator_get_optional(dev, id);

You need to separate handling of -ENODEV which indicates that a regulator is not specified
from other errors which you do not want to hid. e.g. -EPROBE_DEFER
which just indicates we need to wait for some other driver to load
and then retry this one.
 
> +	if (IS_ERR(reg)) {
> +		*vref = NULL;
> +		return 0;
> +	}
> +	ret = regulator_enable(reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable regulator %s\n", id);
> +
> +	*vref = reg;
> +	return devm_add_action_or_reset(dev, max11410_disable_reg, reg);
> +}
> +
>
> +
> +static int max11410_probe(struct spi_device *spi)
> +{
> +	struct max11410_state *st;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	const char *vrefp_regs[] = { "vref0p", "vref1p", "vref2p" };
> +	const char *vrefn_regs[] = { "vref0n", "vref1n", "vref2n" };
> +	int ret;
> +	int i;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi_dev = spi;
> +	init_completion(&st->completion);
> +	mutex_init(&st->lock);
> +
> +	indio_dev->name = "max11410";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &max11410_info;
> +
> +	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "regmap initialization failed\n");
> +
> +	st->avdd = devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(st->avdd))
> +		return dev_err_probe(dev, PTR_ERR(st->avdd),
> +				     "avdd-supply is required.\n");
> +
> +	ret = regulator_enable(st->avdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, max11410_disable_reg, st->avdd);
FYI. It probably won't land before this but there is a series adding
devm_regulator_enable() under review that would replace this (and 100s more
instances in IIO).

> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(vrefp_regs); i++) {
> +		ret = max11410_init_vref(dev, &st->vrefp[i], vrefp_regs[i]);
> +		if (ret)
> +			return ret;
> +
> +		ret = max11410_init_vref(dev, &st->vrefn[i], vrefn_regs[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Regulators must be configured before parsing channels for
> +	 * validating "adi,reference" property of each channel.
> +	 */
> +	ret = max11410_parse_channels(st, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, MAX11410_REG_CTRL, MAX11410_CTRL_FORMAT_BIT);
> +	if (ret)
> +		return ret;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &max11410_trigger_ops;
> +	ret = devm_iio_trigger_register(dev, st->trig);

You register a trigger that might not have an irq to drive it?
That's unusual and I think pointless - move the trigger allocation down to under
the if (spi->irq > 0 ) block.


> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      NULL,

NULL, fits on previous line so move it up.
I'm reading backwards and got bored at this point, but check for other
similar cases.

> +					      &max11410_trigger_handler,
> +					      &max11410_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	if (spi->irq > 0) {
> +		ret = devm_request_threaded_irq(dev, spi->irq,
> +						NULL,
> +						&max11410_interrupt,
> +						IRQF_ONESHOT,
> +						"max11410", indio_dev);
overwrapped. Perhaps keep the two callbacks on one line given that NULL
can go on either the line above or the one below where you have it.

		ret = devm_request_threaded_irq(dev, spi->irq,
						NULL, &max11410_interrupt,
						IRQF_ONESHOT,
						"max11410", indio_dev);

> +		if (ret)
> +			return ret;
> +
> +		ret = max11410_write_reg(st, MAX11410_REG_GP1_CTRL, MAX11410_GP1_CTRL_INTRB);
No loss of readability by adding line breaks as
> +		ret = max11410_write_reg(st, MAX11410_REG_GP1_CTRL,
					 MAX11410_GP1_CTRL_INTRB);


> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = max11410_self_calibrate(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot perform device self calibration\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
