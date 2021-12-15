Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6089747562C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhLOKX5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 05:23:57 -0500
Received: from www381.your-server.de ([78.46.137.84]:44272 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhLOKX5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 05:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=EHkoHCM4/akmiX+GQlxsqrqfd96puN1iG/rN61e+Rz0=; b=Y+tGjTuyZsdqnD8H0Gh66ZCDOW
        0XjqD8MF8QGMDsspr/JnrOsDT6mLypgS0FUn4Ci8x6y3DvLJQ/8PXZlh3EtEDIMWkewk8wUdo7xH9
        bO+MvFWbcS0uLUBI+NTb/yyOikBnOKoWmmdXH8LKe9hJyE3TsrU3GMi5UztFH3E0yGeaKe9G416TU
        3atWgLPUL5vq0QVrGukTey9caX3LtL2yfztEZVUjkR3xzf4q/bJAacNFEWHeS20ojrZKW/6A5ESrB
        Lmw4RcZ5Zi7SrjKD8MmcyG49zsYIcTPgnlypwWZiW895h6BpKJCkiHPvkVrKH598hqn009WZHhyfb
        uSWQoFJQ==;
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxRRz-00056B-31; Wed, 15 Dec 2021 11:23:55 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxRRy-000OCI-Ti; Wed, 15 Dec 2021 11:23:54 +0100
Subject: Re: [PATCH 1/3] iio: dac: add support for ltc2688
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
 <20211214165608.7903-2-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <001b1c03-3d46-291f-e732-21514a9fd721@metafoo.de>
Date:   Wed, 15 Dec 2021 11:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211214165608.7903-2-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26388/Wed Dec 15 08:24:21 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/14/21 5:56 PM, Nuno Sá wrote:
> The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> precision reference. It is guaranteed monotonic and has built in
> rail-to-rail output buffers that can source or sink up to 20 mA.

Looks very good!

Although I'm not sure what to make of the `raw1` API. Maybe it makes 
sense to submit an initial version of this driver without the toggle 
API. And then have a follow up discussion how to define the API for 
this. This will not be the only DAC that has this feature so it would be 
a good idea to come up with a common API.


>
> [...]
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
This is making assumptions about the memory layout in the regmap core. 
This could change in the future and then this driver breaks. It is 
better to not assume that reg is part of a larger buffer.
> +			.len = reg_size + 2,
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
> [...]
> +
> +static int ltc2688_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
Using mask for the variable name is a relic from the days when it used 
to be a mask. For new drivers it is better to use `info`. Same for the 
other functions.
> [...]
> +
> +static const char * const ltc2688_dither_phase[] = {
> +	"0", "90", "180", "270",
> +};
Usually we use radians for phase values. Although that would make for a 
bit of an awkward API in this case.
> +
> [...]
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

This macro is a bit strange since it declares a static, but is called in 
a function. It might be better to declare the two types of ext_infos 
statically and then reference them by name from within the function.

> [...]
> +
> +static int ltc2688_tgp_setup(struct ltc2688_state *st, long clk_mask,
> +			     const struct ltc2688_dither_helper *tgp)
> +{
> +	int ret, bit;
> +
> +	for_each_set_bit(bit, &clk_mask, LTC2688_CHAN_TD_MAX) {
clk_mask should be unsigned long
> [...]
> +
> +static int ltc2688_span_lookup(const struct ltc2688_state *st, int min, int max)
> +{
> +	u32 span;
Nit: Why u32 and not unsigned int? The size doesn't seem to be important 
for the loop variable.
> +
> +	for (span = 0; span < ARRAY_SIZE(ltc2688_span_helper); span++) {
> +		if (min == ltc2688_span_helper[span][0] &&
> +		    max == ltc2688_span_helper[span][1])
> +			return span;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ltc2688_channel_config(struct ltc2688_state *st)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(&st->spi->dev), *child;
> +	struct ltc2688_dither_helper tgp[LTC2688_CHAN_TD_MAX] = {0};
> +	u32 reg, clk_input, val, mask, tmp[2];
> +	unsigned long clk_msk = 0;
> +	int ret, span;
> +
> +	fwnode_for_each_available_child_node(fwnode, child) {
> [...]
> +		chan = &st->channels[reg];
> +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan = true;
> +			/* assume sw toggle ABI */
> +			ltc2688_channels[reg].ext_info = LTC2688_CHAN_TOGGLE(__s, "symbol");
Updating ltc2688_channels at runtime will break if you have multiple 
instances of the device with a different configuration. You need to 
kmemdup() the channel array.
> +		}
> +[...]
> +	return ltc2688_tgp_setup(st, clk_msk, tgp);
> +}
> +
> +static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
> +{
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	/*
> +	 * If we have a reset pin, use that to reset the board, If not, use
> +	 * the reset bit.
> +	 */
Looking at the datasheet I do not see a reset pin on the chip.
> +	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
Usually when we have a reset which is active low we define it in the DT 
as active low rather than doing the inversion in the driver.
> +	if (IS_ERR(gpio))
> +		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
> +				     "Failed to get reset gpio");
> +	if (gpio) {
> +		usleep_range(1000, 1200);
> +		/* bring device out of reset */
> +		gpiod_set_value_cansleep(gpio, 0);
> +	} else {
> +		ret = regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG,
> +					 LTC2688_CONFIG_RST,
> +					 LTC2688_CONFIG_RST);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	usleep_range(10000, 12000);
> +
> +	ret = ltc2688_channel_config(st);
> +	if (ret)
> +		return ret;
> +
> +	if (!vref)
> +		return 0;
> +
> +	return regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG,
> +				  LTC2688_CONFIG_EXT_REF, BIT(1));

This is a bit confusing since you are using LTC2688_CONFIG_EXT_REF for 
the mask and BIT(1) for the value, even though both are the same.

There is a new API regmap_set_bits()/regmap_clear_bits() that allows you 
to write this in a more compact way. There are a few other places in the 
driver where they can be used as well.

> +}
> [...]
> +

