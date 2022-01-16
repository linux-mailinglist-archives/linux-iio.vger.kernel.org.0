Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3848FCC4
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiAPMiZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 07:38:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38620 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiAPMiY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 07:38:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB9660EC7;
        Sun, 16 Jan 2022 12:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CF0C36AE7;
        Sun, 16 Jan 2022 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642336703;
        bh=paUMNP+QYR6xzny3kjg9qTv3BmKnwNPV0mzHO3KGVi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ejQIbia3lkNmOrqDKOEpCHG5CCZ1wM0rq1EmHWobMJwJ3clWoE29ja+nCZGHfDu55
         S/SQZjqQX8umwa4QDDJm6QUvjehILzKTEUXkBHCn64EKklVmVi9R2Fn06v+OJUp9m9
         DyiLm+sBvJqZE2B1cnqytXWpEOKoEssQRmbjs7HZ/CZskZGuUAUz34wNHDqVRANTFj
         8ygFxqdj+/Yn7PDmknIhsN43B6qZM78m+U8Un/4nRGENPmZ389LwVG4vdxGYAxXVx2
         YZemViDDkrAQehpstsQ94AUHrrjvZdj00uP2IrUSHorw2VpqF3RBdtgi6RZ9kQ07hd
         BwWiWC4hFbf3A==
Date:   Sun, 16 Jan 2022 12:44:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 1/3] iio: dac: add support for ltc2688
Message-ID: <20220116124424.5360296f@jic23-huawei>
In-Reply-To: <20220115092705.491-2-nuno.sa@analog.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
        <20220115092705.491-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Jan 2022 10:27:03 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> precision reference. It is guaranteed monotonic and has built in
> rail-to-rail output buffers that can source or sink up to 20 mA.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

A few minor additions inline.

In particular I think we can work around that lack of
device_for_each_available_child_node() issue and use generic fw propreties.
rather than of ones.  That way we can separate things from the question of
how to 'fix' that issue.

One thing I'm not sure on is the phase units. Right now I think you are
exposing just the raw register value whereas I think that needs converting
to radians.

Jonathan



...

> +static int ltc2688_channel_config(struct ltc2688_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	struct device_node *child;
> +	u32 reg, clk_input, val, tmp[2];
> +	int ret, span;
> +
> +	for_each_available_child_of_node(dev->of_node, child) {

Gah. This still going on with there not being a generic _available_
specific form.  We need to kick that again because I'm not keen to
merge another driver we'll need to tidy up later to use generic
properties.

Best bet is probably to just define
device_for_each_available_child_node() and see if anyone shoots
it down (even if it does the same as device_for_each_child_node()
in at least some cases).

Or thinking about it.. Here you could use device_for_each_child_node()
and then call fwnode_device_is_available() on the result and continue
if not true.

Will always return true (I think) but will make the intent clear.

We can tidy up to a new for_* if / when it becomes available.



> +		struct ltc2688_chan *chan;
> +
> +		ret =3D of_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			of_node_put(child);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get reg property\n");
> +		}
> +
> +		if (reg >=3D LTC2688_DAC_CHANNELS) {
> +			of_node_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg bigger than: %d\n",
> +					     LTC2688_DAC_CHANNELS);
> +		}
> +
> +		val =3D 0;
> +		chan =3D &st->channels[reg];
> +		if (of_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan =3D true;
> +			/* assume sw toggle ABI */
> +			st->iio_chan[reg].ext_info =3D ltc2688_toggle_sym_ext_info;
> +			/*
> +			 * Clear IIO_CHAN_INFO_RAW bit as toggle channels expose
> +			 * out_voltage_raw{0|1} files.
> +			 */
> +			clear_bit(IIO_CHAN_INFO_RAW,
> +				  &st->iio_chan[reg].info_mask_separate);
> +		}
> +
> +		ret =3D of_property_read_u32_array(child, "adi,output-range-microvolt",
> +						 tmp, ARRAY_SIZE(tmp));
> +		if (!ret) {
> +			span =3D ltc2688_span_lookup(st, (int)tmp[0] / 1000,
> +						   tmp[1] / 1000);
> +			if (span < 0) {
> +				of_node_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "output range not valid:[%d %d]\n",
> +						     tmp[0], tmp[1]);
> +			}
> +
> +			val |=3D FIELD_PREP(LTC2688_CH_SPAN_MSK, span);
> +		}
> +
> +		ret =3D of_property_read_u32(child, "adi,toggle-dither-input",
> +					   &clk_input);
> +		if (!ret) {
> +			if (clk_input >=3D LTC2688_CH_TGP_MAX) {
> +				of_node_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "toggle-dither-input inv value(%d)\n",
> +						     clk_input);
> +			}
> +
> +			ret =3D ltc2688_tgp_clk_setup(st, chan, child, clk_input);
> +			if (ret) {
> +				of_node_put(child);
> +				return ret;
> +			}
> +
> +			/*
> +			 * 0 means software toggle which is the default mode.
> +			 * Hence the +1.
> +			 */
> +			val |=3D FIELD_PREP(LTC2688_CH_TD_SEL_MSK, clk_input + 1);
> +
> +			/*
> +			 * If a TGPx is given, we automatically assume a dither
> +			 * capable channel (unless toggle is already enabled).
> +			 * On top of this we just set here the dither bit in the
> +			 * channel settings. It won't have any effect until the
> +			 * global toggle/dither bit is enabled.
> +			 */
> +			if (!chan->toggle_chan) {
> +				val |=3D FIELD_PREP(LTC2688_CH_MODE_MSK, 1);
> +				st->iio_chan[reg].ext_info =3D ltc2688_dither_ext_info;
> +			} else {
> +				/* wait, no sw toggle after all */
> +				st->iio_chan[reg].ext_info =3D ltc2688_toggle_ext_info;
> +			}
> +		}
> +
> +		if (of_property_read_bool(child, "adi,overrange")) {
> +			chan->overrange =3D true;
> +			val |=3D LTC2688_CH_OVERRANGE_MSK;
> +		}
> +
> +		if (!val)
> +			continue;
> +
> +		ret =3D regmap_write(st->regmap, LTC2688_CMD_CH_SETTING(reg),
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
> +
> +static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vre=
f)
> +{
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	/*
> +	 * If we have a reset pin, use that to reset the board, If not, use
> +	 * the reset bit.
> +	 */
> +	gpio =3D devm_gpiod_get_optional(&st->spi->dev, "clr", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio))
> +		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
> +				     "Failed to get reset gpio");
> +	if (gpio) {
> +		usleep_range(1000, 1200);
> +		/* bring device out of reset */
> +		gpiod_set_value_cansleep(gpio, 0);
> +	} else {
> +		ret =3D regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG,
> +					 LTC2688_CONFIG_RST,
> +					 LTC2688_CONFIG_RST);
> +		if (ret < 0)
A bit of a mixture in here on whether you prefer if (ret) or if (ret < 0)
for error returns you know can't be postive.

I'd go with if (ret) for all of them.  It makes things consistent with the
cases where you directly return the value without checking it for less
than 0 like below.


> +			return ret;
> +	}
> +
> +	usleep_range(10000, 12000);
> +
> +	/*
> +	 * Duplicate the default channel configuration as it can change during
> +	 * @ltc2688_channel_config()
> +	 */
> +	st->iio_chan =3D devm_kmemdup(&st->spi->dev, ltc2688_channels,
> +				    sizeof(ltc2688_channels), GFP_KERNEL);
> +	if (!st->iio_chan)
> +		return -ENOMEM;
> +
> +	ret =3D ltc2688_channel_config(st);
> +	if (ret)
> +		return ret;
> +
> +	if (!vref)
> +		return 0;
> +
> +	return regmap_set_bits(st->regmap, LTC2688_CMD_CONFIG,
> +			       LTC2688_CONFIG_EXT_REF);
> +}
> +
> +static void ltc2688_bulk_disable(void *data)

rename to mention regulators.  Could be bulk disabling something else...

> +{
> +	struct ltc2688_state *st =3D data;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
> +}
> +

...

Thanks,

Jonathan


