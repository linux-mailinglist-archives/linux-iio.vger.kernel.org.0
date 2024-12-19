Return-Path: <linux-iio+bounces-13642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21949F7D93
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22502188AE8F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F2224B1E;
	Thu, 19 Dec 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwdxYjKt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28602582;
	Thu, 19 Dec 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620661; cv=none; b=aE709oJWvO4KZQQREbIjqlXQpnBRjRoQWwqTjF2xxnvvh/GP8qRFEseP0+cNRTES2k0UPU6YimQ8kKZKoUgCpQjoBbjMyCcKQH/wH70CEC184gzR4NtNaci7JZNhSm1OQt6C8Ce3JuvLysr8NebvqBRjXLTZFmFYLGP7QWi9FU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620661; c=relaxed/simple;
	bh=XvNtTnoh4VZUJSrxpjmth36rx99R5D8Ahqp+cTuD23M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo+ZON5+N3+cFvrHBOTBgROWRHm6uJXCyDgTlFIpLnXUCGX55MW8eHWSzD/ZxLHx//YhB7VfkjJyko/dj8m1GWzYANEvIt2qX5iwst3kl50jgf+fh12T1OQimsVCfpJ8mpm3YlbFjBoqmU4r1Me4CC1lDxRzd0EKbmtvYdejkVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwdxYjKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2151FC4CECE;
	Thu, 19 Dec 2024 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734620660;
	bh=XvNtTnoh4VZUJSrxpjmth36rx99R5D8Ahqp+cTuD23M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lwdxYjKtOE/wD9Bm78hW/UW/FQlMwi+gg3DoRs/Q2nEJ4oJL5YMLq353grBwE1m4o
	 YYXzxxWhUdTZLv6LzsU0Dg7iPtkHujgCdHwccFwYSiDlpY+KOJ42xFPlkdObxdXYHW
	 KGxcHf5EmmKkBmDKhMBfsz6DkzNG7wdPWHvMgLd5OElc9O+bxFcBtvVRuxs+DwdyyC
	 onBCrd2CVQuwyhR/Yv5BUI89FvCjxXdSRIHinANI6e2VCrRtlL8S++19bhobcwsch7
	 XJmCLTdjiDvs3FQfCLo+VGJXmPhBy2lPxcCyzXtM7AIRWwwxbesaxD5/NW209zwubO
	 11zwRfj2P2nug==
Date: Thu, 19 Dec 2024 15:04:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ana-Maria Cusco
 <ana-maria.cusco@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [RFC PATCH 3/4] iio: adc: Add support for AD4170
Message-ID: <20241219150412.2af51921@jic23-huawei>
In-Reply-To: <827daa6ba0882cc7974a9a61831e53dbf1ed5a78.1734530280.git.marcelo.schmitt@analog.com>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
	<827daa6ba0882cc7974a9a61831e53dbf1ed5a78.1734530280.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Dec 2024 11:37:59 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
Two froms!
>=20
> Add support for the AD4170 ADC with the following features:
> - Single-shot read (read_raw), scale, sampling freq
> - Multi channel buffer support
> - Buffered capture in triggered mode
> - Gain and offset calibration
> - chop_iexc and chop_adc device configuration
> - Powerdown switch configuration
>=20
> Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |   16 +
>  drivers/iio/adc/Makefile |    1 +
>  drivers/iio/adc/ad4170.c | 2049 ++++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad4170.h |  316 ++++++

Don't have a separate header if only 1 c file. It just adds unnecessary boi=
lerplate
and can lead to separations that make little sense.

It's a big driver and I think the changes requested to bindings will make
it bigger and  more complex still.  Hence not the most detailed of reviews
follows.

Jonathan

> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> new file mode 100644
> index 000000000000..20b74575f2cb
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.c
> @@ -0,0 +1,2049 @@

...

> +
> +static const char *const ad4170_clk_sel[] =3D {
> +	"ext-clk", "xtal"
> +};
> +
> +static const char *const ad4170_i_out_pin_dt_props[] =3D {
> +	"adi,excitation-pin-0",
> +	"adi,excitation-pin-1",
> +	"adi,excitation-pin-2",
> +	"adi,excitation-pin-3",
> +};
> +
> +static const char *const ad4170_i_out_val_dt_props[] =3D {

Push this down into the place it is used. Same for similar
examples of once use static const data.

> +	"adi,excitation-current-0-microamp",
> +	"adi,excitation-current-1-microamp",
> +	"adi,excitation-current-2-microamp",
> +	"adi,excitation-current-3-microamp",
> +};
> +
> +#define AD4170_SINC5_FS_PADDING		8
> +#define AD4170_SINC3_FS_OFFSET		2
> +
> +#define AD4170_SINC3_MIN_FS		4
> +#define AD4170_SINC3_MAX_FS		65532
> +#define AD4170_SINC5_MIN_FS		1
> +#define AD4170_SINC5_MAX_FS		256
> +
> +/* Make separate fs tables? One for SINC5 other for SINC5+AVG and SINC3?=
 */

That sounds simpler than this.

> +static const unsigned int ad4170_filt_fs_tbl[] =3D {
> +	1, /* SINC5 minimum filter_fs */
> +	2,
> +	4, /* SINC5+AVG and SINC3 minimum filter_fs */
> +	8,
> +	12,
> +	16,
> +	20,
> +	40,
> +	48,
> +	80,
> +	100,
> +	256, /* SINC5 maximum filter_fs */
> +	500,
> +	1000,
> +	5000,
> +	8332,
> +	10000,
> +	25000,
> +	50000,
> +	65532 /* SINC5+AVG and SINC3 maximum filter_fs */
> +};

> +struct ad4170_state {
> +	struct regmap *regmap;
> +	struct spi_device *spi;
> +	struct regulator_bulk_data supplies[7];
> +	struct mutex lock; /* Protect filter, PGA, GPIO, chan read, chan config=
 */
> +	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
> +	struct ad4170_chan_info chans_info[AD4170_MAX_CHANNELS];
> +	struct ad4170_setup setups[AD4170_MAX_SETUPS];
> +	u32 mclk_hz;
> +	enum ad4170_pin_function pins_fn[AD4170_NUM_ANALOG_PINS];
> +	enum ad4170_gpio_function gpio_fn[AD4170_NUM_GPIO_PINS];
> +	unsigned int clock_ctrl;
> +	struct clk *ext_clk;
> +	struct clk_hw int_clk_hw;
> +	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][ARRAY_SIZE(ad4170_filt_fs_tb=
l)][2];
> +	struct completion completion;
> +	struct iio_trigger *trig;
> +	u32 data[AD4170_MAX_CHANNELS];
> +
> +	struct spi_transfer xfer;
> +	struct spi_message msg;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> +	 * to live in their own cache lines.
Comment doesn't match code.  write_tx_buf is not in the
cacheline you intend.

> +	 */
> +	u8 reg_write_tx_buf[6];
> +	__be32 reg_read_rx_buf __aligned(IIO_DMA_MINALIGN);
> +	__be16 reg_read_tx_buf;
> +};
> +

> +static const struct regmap_config ad4170_regmap_config =3D {
> +	.reg_bits =3D 14,
> +	.val_bits =3D 32,
> +	.reg_format_endian =3D REGMAP_ENDIAN_BIG,
> +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> +	.reg_read =3D ad4170_reg_read,
> +	.reg_write =3D ad4170_reg_write,
> +};
> +
> +static int ad4170_set_mode(struct ad4170_state *st, unsigned int mode)
> +{
> +	return regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +				  AD4170_REG_CTRL_MODE_MSK,
> +				  FIELD_PREP(AD4170_REG_CTRL_MODE_MSK, mode));
> +}
> +
> +/* 8 possible setups (0-7)*/
> +static int ad4170_write_setup(struct ad4170_state *st, unsigned int setu=
p_num,
> +			      struct ad4170_setup *setup)
> +{
> +	int ret;
> +
> +	/*
> +	 * It is recommended to place the ADC in standby mode or idle mode to
> +	 * write to OFFSET and GAIN registers.
> +	 */
> +	ret =3D ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4170_MISC_REG(setup_num), setup->mis=
c);
> +	if (ret < 0)
regmap always returns 0 on success so you can just do if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4170_AFE_REG(setup_num), setup->afe);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4170_FILTER_REG(setup_num),
> +			   setup->filter);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4170_FILTER_FS_REG(setup_num),
> +			   setup->filter_fs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4170_OFFSET_REG(setup_num),
> +			   setup->offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4170_GAIN_REG(setup_num), setup->gai=
n);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
Advantage of above is then return regmap_write() etc is obviously the same
as the earlier calls.

> +}

> +static int ad4170_set_filter_type(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int val)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info =3D &st->chans_info[chan->address];
> +	struct ad4170_setup *setup =3D &st->setups[chan_info->setup_num];
> +	unsigned int old_filter_fs, old_filter, filter_type_conf;
> +	int ret =3D 0;
> +
> +	switch (val) {
> +	case AD4170_SINC5_AVG:
> +		filter_type_conf =3D AD4170_SINC5_AVG_CONF;
> +		break;
> +	case AD4170_SINC5:
> +		filter_type_conf =3D AD4170_SINC5_CONF;
> +		break;
> +	case AD4170_SINC3:
> +		filter_type_conf =3D AD4170_SINC3_CONF;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The filters provide the same ODR for a given filter_fs value but
> +	 * there are different minimum and maximum filter_fs limits for each
> +	 * filter. The filter_fs value will be adjusted if the current filter_fs
> +	 * is out of the limits of the just requested filter. Since the
> +	 * filter_fs value affects the ODR (sampling_frequency), changing the
> +	 * filter may lead to a change in the sampling frequency.
> +	 */
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {

As below on this magic going away. Though in this case not worth a helper f=
unction as no early returns.

> +		old_filter =3D setup->filter;
> +		old_filter_fs =3D setup->filter_fs;
> +		if (val =3D=3D AD4170_SINC5_AVG || val =3D=3D AD4170_SINC3) {
> +			if (setup->filter_fs < AD4170_SINC3_MIN_FS)
> +				setup->filter_fs =3D AD4170_SINC3_MIN_FS;
> +			if (setup->filter_fs > AD4170_SINC3_MAX_FS)
> +				setup->filter_fs =3D AD4170_SINC3_MAX_FS;
> +
> +		} else if (val =3D=3D AD4170_SINC5) {
> +			if (setup->filter_fs < AD4170_SINC5_MIN_FS)
> +				setup->filter_fs =3D AD4170_SINC5_MIN_FS;
> +			if (setup->filter_fs > AD4170_SINC5_MAX_FS)
> +				setup->filter_fs =3D AD4170_SINC5_MAX_FS;
> +		}
> +
> +		setup->filter &=3D ~AD4170_SETUPS_FILTER_TYPE_MSK;
> +		setup->filter |=3D FIELD_PREP(AD4170_SETUPS_FILTER_TYPE_MSK,
> +					    filter_type_conf);
> +
> +		guard(mutex)(&st->lock);
> +		ret =3D ad4170_write_setup(st, chan_info->setup_num, setup);
> +		if (ret) {
> +			setup->filter =3D old_filter;
> +			setup->filter_fs =3D old_filter_fs;
> +		}
> +		return ret;
> +	}
> +	unreachable();
> +}
>
> +
> +static int ad4170_read_sample(struct iio_dev *indio_dev, unsigned int ch=
annel,
> +			      int *val)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info =3D &st->chans_info[channel];
> +	struct ad4170_setup *setup =3D &st->setups[chan_info->setup_num];
> +	int precision_bits =3D ad4170_channel_template.scan_type.realbits;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	ret =3D ad4170_set_channel_enable(st, channel, true);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->completion);
> +
> +	ret =3D ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_SINGLE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D wait_for_completion_timeout(&st->completion, HZ);
> +	if (!ret)
> +		goto out;

Odd to let this go, but for other cases not re enable the channel.
Add a comment on why you are doing this.

> +
> +	ret =3D regmap_read(st->regmap, AD4170_DATA_24b_REG, val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(AD4170_AFE_BIPOLAR_MSK, setup->afe))
> +		*val =3D sign_extend32(*val, precision_bits - 1);
> +out:
> +	ret =3D ad4170_set_channel_enable(st, channel, false);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}

...

> +/*
> + * Receives the device state, the channel spec, a reference selection, a=
nd
> + * returns the magnitude of the allowed input range in =C2=B5V.
> + * Verifies whether the channel configuration is valid by checking the p=
rovided
> + * input type, polarity, and voltage references result in a sane input r=
ange.
> + * Returns negative error code on failure.
> + */
> +static int ad4170_get_input_range(struct ad4170_state *st,
> +				  struct iio_chan_spec const *chan,
> +				  unsigned int ref_sel)
> +{
> +	struct ad4170_chan_info *chan_info =3D &st->chans_info[chan->address];
> +	struct ad4170_setup *setup =3D &st->setups[chan_info->setup_num];
> +	bool bipolar =3D FIELD_GET(AD4170_AFE_BIPOLAR_MSK, setup->afe);
> +	int refp, refn, ain_voltage, ret;
> +
> +	switch (ref_sel) {
> +	case AD4170_AFE_REFIN_REFIN1:
> +		refp =3D regulator_get_voltage(st->supplies[AD4170_REFIN1P_SUP].consum=
er);
> +		refn =3D regulator_get_voltage(st->supplies[AD4170_REFIN1N_SUP].consum=
er);
> +		break;
> +	case AD4170_AFE_REFIN_REFIN2:
> +		refp =3D regulator_get_voltage(st->supplies[AD4170_REFIN2P_SUP].consum=
er);
> +		refn =3D regulator_get_voltage(st->supplies[AD4170_REFIN2N_SUP].consum=
er);
> +		break;
> +	case AD4170_AFE_REFIN_AVDD:
> +		refp =3D regulator_get_voltage(st->supplies[AD4170_AVDD_SUP].consumer);
> +		ret =3D regulator_get_voltage(st->supplies[AD4170_AVSS_SUP].consumer);
> +		/*
> +		 * TODO AVSS is actually optional.
> +		 * Should we handle -EPROBE_DEFER here?

Not here.  That should have been handled when originally getting the regula=
tor.

> +		 */
> +		if (ret < 0)
> +			ret =3D 0; /* Assume AVSS at GND if not provided */
> +
> +		refn =3D ret;
> +		break;
> +	case AD4170_AFE_REFIN_REFOUT:
> +		refn =3D regulator_get_voltage(st->supplies[AD4170_AVSS_SUP].consumer);
> +		if (refn < 0)
> +			refn =3D 0;
> +
> +		/* REFOUT is 2.5 V relative to AVSS */
> +		/* avss-supply is never above 0V. */
> +		refp =3D AD4170_INT_REF_2_5V - refn;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (refp < 0)
> +		return refp;
> +
> +	if (refn < 0)
> +		return refn;
> +
> +	/*
> +	 * Find out the analog input range from the channel type, polarity, and
> +	 * voltage reference selection.
> +	 * AD4170 channels are either differential or pseudo-differential.
> +	 */
> +	/* Differential Input Voltage Range: =E2=88=92VREF/gain to +VREF/gain (=
datasheet page 6) */
> +	/* Single-Ended Input Voltage Range: 0 to VREF/gain (datasheet page 6) =
*/

Checkpatch is going to moan.  Just make a larger multiline comment without =
appropriate
formatting to have same affect as here.

> +	if (chan->differential) {
> +		if (!bipolar)
> +			return dev_err_probe(&st->spi->dev, -EINVAL,
> +					     "Invalid channel %lu setup.\n",
> +					     chan->address);
> +
> +		/* Differential bipolar channel */
> +		/* avss-supply is never above 0V. */
> +		/* Assuming refin1n-supply not above 0V. */
> +		/* Assuming refin2n-supply not above 0V. */

More to combine into a block comment with some extra formatting.

> +		return refp + refn;
> +	}
> +	/*
> +	 * Some configurations can lead to invalid setups.
> +	 * For example, if AVSS =3D -2.5V, REF_SELECT set to REFOUT (REFOUT/AVS=
S),
> +	 * and single-ended channel configuration set, then the input range
> +	 * should go from 0V to +VREF (single-ended - datasheet pg 10), but
> +	 * REFOUT/AVSS range would be -2.5V to 0V.
> +	 * Check the positive reference is higher than 0V for pseudo-diff
> +	 * channels.
> +	 */
> +	if (bipolar) {
> +		/* Pseudo-differential bipolar channel */
> +		/* Input allowed to swing from GND to +VREF */
> +		if (refp <=3D 0)
> +			return dev_err_probe(&st->spi->dev, -EINVAL,
> +					     "Invalid setup for channel %lu.\n",
> +					     chan->address);
> +
> +		return refp;
> +	}
> +
> +	/* Pseudo-differential unipolar channel */
> +	/* Input allowed to swing from IN- to +VREF */
> +	if (refp <=3D 0)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				     "Invalid setup for channel %lu.\n",
> +				     chan->address);
> +
> +	ret =3D ad4170_get_AINM_voltage(st, chan->channel2, &ain_voltage);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (refp - ain_voltage <=3D 0)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				     "Invalid setup for channel %lu.\n",
> +				     chan->address);
> +
> +	return refp - ain_voltage;
> +}
> +
> +static int ad4170_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info =3D &st->chans_info[chan->address];
> +	struct ad4170_setup *setup =3D &st->setups[chan_info->setup_num];
> +	enum ad4170_filter_type f_type;
> +	unsigned int pga, fs_idx;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)

Sorry to say that I think this is going away.  Please open code the claim
and release.  If I finish reviewing the backlog I'll start work on ripping
this out. The unreachable() here is one of the reasons it is a pain
and not worth it



> +			return ad4170_read_sample(indio_dev, chan->address, val);
> +		unreachable();
> +	case IIO_CHAN_INFO_SCALE:
> +		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> +		*val =3D chan_info->scale_tbl[pga][0];
> +		*val2 =3D chan_info->scale_tbl[pga][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> +		*val =3D chan_info->offset_tbl[pga];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		f_type =3D ad4170_filter_to_filter_type(setup->filter);
> +		fs_idx =3D find_closest(setup->filter_fs, ad4170_filt_fs_tbl,
> +				      ARRAY_SIZE(ad4170_filt_fs_tbl));
> +		*val =3D st->sps_tbl[f_type][fs_idx][0];
> +		*val2 =3D st->sps_tbl[f_type][fs_idx][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val =3D setup->offset;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val =3D setup->gain;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +
> +static int ad4170_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {

It's a pain but this is almost certainly going away. Easiest solution
is use the opencoded claim and release but then factor out the bit in this =
scope
as a __ad4170_write_raw() so that you can still do direct returns etc.

> +		switch (info) {
> +		case IIO_CHAN_INFO_SCALE:
> +			return ad4170_set_pga(indio_dev, st, chan->address, val,
> +					      val2);
> +		case IIO_CHAN_INFO_SAMP_FREQ:
> +			return ad4170_set_channel_freq(st, chan->address, val,
> +						       val2);
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			return ad4170_set_calib_offset(indio_dev, chan->address,
> +						       val);
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			return ad4170_set_calib_gain(indio_dev, chan->address,
> +						     val);
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	unreachable();
> +}
> +
> +static int ad4170_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *active_scan_mask)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	unsigned int channel;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	for_each_set_bit(channel, active_scan_mask, indio_dev->num_channels) {

Can't do this any more... Try building on latest kernel.  You will need
to use an accessor function to get num_channels.

> +		ret =3D ad4170_set_channel_enable(st, channel, true);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}


c int ad4170_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	int chan_num, i, ret;
> +
> +	chan_num =3D 0;
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret =3D ad4170_parse_channel_node(indio_dev, child, chan_num);
> +		if (ret)
> +			return ret;
> +
> +		chan_num++;
> +	}
> +	for (i =3D 0; i < AD4170_MAX_CHANNELS; i++)
> +		if (st->chans[i].scan_index =3D=3D 0)
> +			break;
> +
> +	/*
> +	 * When more than one channel is enabled, channel 0 must always be used.
Maybe say why?

> +	 */
> +	if (chan_num > 1 && i =3D=3D AD4170_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Channel 0 must be configured\n");
> +
> +	indio_dev->channels =3D st->chans;
> +	indio_dev->num_channels =3D chan_num;
> +	return 0;
> +}

> +
> +static int ad4170_clk_output_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad4170_state *st =3D clk_hw_to_ad4170(hw);
> +	u32 clk_sel;
> +
> +	clk_sel =3D FIELD_GET(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, st->clock_ctrl);
> +	return clk_sel =3D=3D AD4170_INTERNAL_OSC_OUTPUT;

That is a bool not an int.

> +}

> +static int ad4170_parse_pw_switch(struct ad4170_state *st, struct device=
 *dev)
> +{
> +	bool pdsw0, pdsw1;
> +
> +	pdsw0 =3D device_property_read_bool(dev, "adi,gpio0-power-down-switch");
> +	pdsw1 =3D device_property_read_bool(dev, "adi,gpio1-power-down-switch");
> +
> +	/*
> +	 * Error if a GPIO is assigned to be both excitation current output and
> +	 * power switch.
> +	 */
> +	if (pdsw0) {
> +		if (st->gpio_fn[0] !=3D AD4170_GPIO_UNASIGNED)
> +			return dev_err_probe(&st->spi->dev, -EINVAL,

Can't you use the dev that was passed in?

> +					     "GPIO 0 already used with fn %u\n",
> +					     st->gpio_fn[0]);
> +
> +		st->gpio_fn[0] =3D AD4170_GPIO_PW_DOW_SWITCH;
> +	}
> +	if (pdsw1) {
> +		if (st->gpio_fn[1] !=3D AD4170_GPIO_UNASIGNED)
> +			return dev_err_probe(&st->spi->dev, -EINVAL,
> +					     "GPIO 1 already used with fn %u\n",
> +					     st->gpio_fn[1]);
> +
> +		st->gpio_fn[1] =3D AD4170_GPIO_PW_DOW_SWITCH;
> +	}
> +	return regmap_update_bits(st->regmap, AD4170_POWER_DOWN_SW_REG,
> +				 AD4170_POWER_DOWN_SW_PDSW0_MSK |
> +				 AD4170_POWER_DOWN_SW_PDSW1_MSK,
> +				 pdsw0 | pdsw1);
> +}
> +
> +static int ad4170_parse_vbias(struct ad4170_state *st, struct device *de=
v)
> +{
> +	u32 vbias_pins[AD4170_MAX_ANALOG_PINS];
> +	unsigned int i, val;
> +	u32 num_vbias_pins;
> +	int ret;
> +
> +	ret =3D device_property_count_u32(dev, "adi,vbias-pins");
> +	if (ret > 0) {
> +		if (ret > AD4170_MAX_ANALOG_PINS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Too many vbias pins %u\n", ret);

Look at what dev_err_probe() does... You never want to print ret explicitly
as it does the job better than this.

> +
> +		num_vbias_pins =3D ret;
> +		ret =3D device_property_read_u32_array(dev, "adi,vbias-pins",
> +						     vbias_pins,
> +						     num_vbias_pins);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read vbias pins\n");
> +	}
> +	for (i =3D 0; i < num_vbias_pins; i++) {
> +		if (st->pins_fn[vbias_pins[i]] !=3D AD4170_PIN_UNASIGNED)
> +			return dev_err_probe(&st->spi->dev, -EINVAL,

dev?

> +					     "AIN%d already used with fn %u\n",
> +					     vbias_pins[i], st->pins_fn[i]);
> +
> +		val |=3D BIT(vbias_pins[i]);
> +		st->pins_fn[vbias_pins[i]] =3D AD4170_PIN_VBIAS;
> +	}
> +	return regmap_write(st->regmap, AD4170_V_BIAS_REG, val);
> +}
> +
> +static int ad4170_parse_firmware(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	int ret, i;
> +	u8 aux;
> +
> +	ret =3D ad4170_clock_select(indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to setup device clock\n");
> +
> +	ret =3D regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ad4170_parse_pin_muxing(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < AD4170_NUM_ANALOG_PINS; i++)
> +		st->pins_fn[i] =3D AD4170_PIN_UNASIGNED;
> +
> +	for (i =3D 0; i < AD4170_NUM_GPIO_PINS; i++)
> +		st->gpio_fn[i] =3D AD4170_GPIO_UNASIGNED;
> +
> +	ret =3D ad4170_parse_exc_current(indio_dev);
> +	if (ret)
> +		return ret;
> +// write to misc reg must be delaied because misc register contains sett=
ings
> +// that are channel specific.

looks like left over debug comment. Make sure to address these before posti=
ng.

> +
> +	ret =3D ad4170_parse_pw_switch(st, dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to config power down switches\n");
> +
> +	ret =3D ad4170_parse_vbias(st, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ad4170_parse_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	aux =3D AD4170_MISC_CHOP_IEXC_OFF;
> +	ret =3D device_property_read_u8(dev, "adi,chop-iexc", &aux);
> +	if (!ret) {
> +		ret =3D ad4170_find_table_index(ad4170_iexc_chop_tbl, aux);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid adi,chop-iexc config: %u\n",
> +					      aux);
> +	}
> +
> +	/* Set excitation current chop config to first channel setup config */
> +	st->setups[indio_dev->channels[0].address].misc |=3D
> +		FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK, aux);
> +	return 0;
> +}
> +
> +static int ad4170_initial_config(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info;
> +	struct iio_chan_spec const *chan;
> +	struct ad4170_setup *setup;
> +	unsigned int val;
> +	unsigned int i;
> +	int ret;
> +
> +	ad4170_fill_sps_tbl(st);
> +
> +	/* Put ADC in IDLE mode */
Code is pretty self explanatory.  So drop the comment as something that mig=
ht bitrot.

> +	ret =3D ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup channels. */

Similar with this one.

> +	for (i =3D 0; i < indio_dev->num_channels; i++) {

Can reduce the scope of some of the local variables by pulling them in here.

> +		chan =3D &indio_dev->channels[i];
> +		chan_info =3D &st->chans_info[chan->address];
> +		setup =3D &st->setups[chan_info->setup_num];

To match with the other drivers that support hardware where channels have
to share some config, you will need to do the setup stuff alongside a config
entry allocator that checks for matches. It's fiddly but there are examples
in tree.  Some of the other ADI folk should be able to point you at a good
example to follow

> +
> +		ret =3D regmap_update_bits(st->regmap,
> +					 AD4170_CHAN_SETUP_REG(chan->address),
> +					 AD4170_CHANNEL_SETUP_SETUP_MSK,
> +					 FIELD_PREP(AD4170_CHANNEL_SETUP_SETUP_MSK,
> +						    chan_info->setup_num));
> +		if (ret)
> +			return ret;
> +
> +		setup->gain =3D AD4170_GAIN_REG_DEFAULT;
> +		ret =3D ad4170_write_setup(st, chan_info->setup_num, setup);
> +		if (ret)
> +			return ret;
> +
> +		val =3D FIELD_PREP(AD4170_CHANNEL_MAPN_AINP_MSK, chan->channel) |
> +		      FIELD_PREP(AD4170_CHANNEL_MAPN_AINM_MSK, chan->channel2);
> +
> +		ret =3D regmap_write(st->regmap, AD4170_CHAN_MAP_REG(i), val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D ad4170_set_channel_freq(st, chan->address,
> +					      AD4170_MAX_SAMP_RATE, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad4170_fill_scale_tbl(indio_dev, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, AD4170_CHANNEL_EN_REG, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Configure channels to share the same data output register, i.e. data
> +	 * can be read from the same register address regardless of channel
> +	 * number.
> +	 */
> +	ret =3D regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +				 AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK,
> +				 AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return regmap_update_bits...

> +}

> +static void ad4170_prepare_message(struct ad4170_state *st)
> +{
> +	/*
> +	 * Continuous data register read is enabled on buffer postenable so
> +	 * no instruction phase is needed meaning we don't need to send the
> +	 * register address to read data. Transfer only needs the read buffer.
> +	 */
> +	st->xfer.rx_buf =3D &st->reg_read_rx_buf;
> +	st->xfer.bits_per_word =3D ad4170_channel_template.scan_type.storagebit=
s;
> +	st->xfer.len =3D BITS_TO_BYTES(ad4170_channel_template.scan_type.storag=
ebits);
> +
> +	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
> +}
> +
> +static int ad4170_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_CONT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +				 AD4170_REG_CTRL_CONT_READ_MSK,
> +				 FIELD_PREP(AD4170_REG_CTRL_CONT_READ_MSK,
> +					    AD4170_ADC_CTRL_CONT_READ_ENABLE));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return spi_optimize_message(st->spi, &st->msg);

This is a little odd. You have an optimized message, but also use regmap
and never seem to use st->msg.

Half done conversion?

> +}
> +
> +static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret, i;
> +
> +	spi_unoptimize_message(&st->msg);
> +
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		ret =3D ad4170_set_channel_enable(st, i, false);

I guess harmless to disable channels that were never enabled. Maybe
add a comment on that.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +				 AD4170_REG_CTRL_CONT_READ_MSK,
> +				 FIELD_PREP(AD4170_REG_CTRL_CONT_READ_MSK,
> +					    AD4170_ADC_CTRL_CONT_READ_DISABLE));
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
> +}
> +
> +static const struct iio_buffer_setup_ops ad4170_buffer_ops =3D {
> +	.postenable =3D ad4170_buffer_postenable,
> +	.predisable =3D ad4170_buffer_predisable,
> +};
> +
> +static irqreturn_t ad4170_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret, i =3D 0;
> +	int scan_index;
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {

Try building on current kernel...  then fix it up ;)  There is a new
iterator for this.


> +		/* Read register data */
> +		ret =3D regmap_read(st->regmap, AD4170_DATA_24b_REG, &st->data[i]);
> +		if (ret)
> +			goto out;
> +		i++;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
> +					   iio_get_time_ns(indio_dev));

Used the pollfunc that gets a timestamp but grabbed a new one here which ma=
kes no sense.
Figure out when it makes more sense to get that timestamp and only use that.

> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad4170_triggered_buffer_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	indio_dev->modes |=3D INDIO_BUFFER_TRIGGERED;

That's set appropriately by devm_iio_trigger_buffer_setup() so no need
I think to set it here.

> +
> +	st->trig =3D devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-trig%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops =3D &ad4170_trigger_ops;
> +	st->trig->dev.parent =3D indio_dev->dev.parent;
> +
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret =3D devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig =3D iio_trigger_get(st->trig);
> +
> +	ret =3D request_irq(st->spi->irq,
> +			  &ad4170_interrupt,
> +			  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

Interrupt direction is a thing for firmware to control, not the driver so d=
on't set it here.

> +			  indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &ad4170_trigger_handler,
> +					       &ad4170_buffer_ops);
> +}
> +
> +static int ad4170_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4170_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	devm_mutex_init(dev, &st->lock);
> +
> +	indio_dev->name =3D AD4170_NAME;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad4170_info;
> +
> +	st->spi =3D spi;
> +	st->regmap =3D devm_regmap_init(dev, NULL, st, &ad4170_regmap_config);
> +
> +	st->supplies[AD4170_AVDD_SUP].supply =3D "avdd";
> +	st->supplies[AD4170_AVSS_SUP].supply =3D "avss";
> +	st->supplies[AD4170_IOVDD_SUP].supply =3D "iovdd";
> +	st->supplies[AD4170_REFIN1P_SUP].supply =3D "refin1p";
> +	st->supplies[AD4170_REFIN1N_SUP].supply =3D "refin1n";
> +	st->supplies[AD4170_REFIN2P_SUP].supply =3D "refin2p";
> +	st->supplies[AD4170_REFIN2N_SUP].supply =3D "refin2n";
> +
> +	/*
> +	 * If a regulator is not available, it will be set to a dummy regulator.
> +	 * Each channel reference is checked with regulator_get_voltage() before
> +	 * setting attributes so if any channel uses a dummy supply the driver
> +	 * probe will fail.

If you are using an optional regulator to provide an attribute and it's not=
 there
then we should not be registering the attribute (to indicate to userspace
it is not supported).  You are doing complex handling of channel setup in h=
ere
anyway so shouldn't be too hard to filter for this

> +	 */
> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(st->supplies),
> +				      st->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get supplies\n");
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(st->supplies), st->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, ad4170_disable_supplies, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add supplies disable action\n");
> +
> +	ret =3D ad4170_soft_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4170_parse_firmware(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to parse firmware\n");

Check wrapping throughout.  This easily fits on line line under 80 chars.

> +
> +	ret =3D ad4170_initial_config(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to setup device\n");
> +
> +	init_completion(&st->completion);
> +
> +	ret =3D ad4170_triggered_buffer_setup(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup read buffer\n");
> +
> +	ad4170_prepare_message(st);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad4170_of_match[] =3D {
> +	{
> +		.compatible =3D "adi,ad4170",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4170_of_match);
> +
> +static struct spi_driver ad4170_driver =3D {
> +	.driver =3D {
> +		.name =3D AD4170_NAME,

As below. String here preferred over the define.

> +		.of_match_table =3D ad4170_of_match,
> +	},

Need the id_table of spi_match_ids as well so autoprobing works. (odd piece
of history that we can't unwind easily).

> +	.probe =3D ad4170_probe,
> +};
> +module_spi_driver(ad4170_driver);
> +
> +MODULE_AUTHOR("Ana-Maria Cusco <ana-maria.cusco@analog.com>");
> +MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4170 SPI driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/adc/ad4170.h b/drivers/iio/adc/ad4170.h
> new file mode 100644
> index 000000000000..5b24788314b1
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.h
As mentioned at the top, just put this stuff at top of the c file.

> @@ -0,0 +1,316 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AD4170 ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <dt-bindings/iio/adc/adi,ad4170.h>
> +
> +#define AD4170_NAME				"ad4170"

Use the string inline rather than via a define like this.
Easier to review and often there is no specific reason why the string
should be the same in all the places it is used.

> +
> +#define AD4170_READ_MASK BIT(14)
> +/* AD4170 registers */
> +#define AD4170_INTERFACE_CONFIG_A_REG		0x00

Clunky name. I'd shorten it.

> +#define AD4170_STATUS_REG			0x14
> +#define AD4170_DATA_24b_REG			0x1c
> +#define AD4170_PIN_MUXING_REG			0x68
> +#define AD4170_CLOCK_CTRL_REG			0x6A
> +#define AD4170_POWER_DOWN_SW_REG		0x6e
> +#define AD4170_ADC_CTRL_REG			0x70
> +#define AD4170_CHANNEL_EN_REG			0x78
> +#define AD4170_CHAN_SETUP_REG(x)		(0x80 + 4 * (x))
> +#define AD4170_CHAN_MAP_REG(x)			(0x82 + 4 * (x))
> +#define AD4170_MISC_REG(x)			(0xc0 + 14 * (x))
> +#define AD4170_AFE_REG(x)			(0xc2 + 14 * (x))
> +#define AD4170_FILTER_REG(x)			(0xc4 + 14 * (x))
> +#define AD4170_FILTER_FS_REG(x)			(0xc6 + 14 * (x))
> +#define AD4170_OFFSET_REG(x)			(0xc8 + 14 * (x))
> +#define AD4170_GAIN_REG(x)			(0xcb + 14 * (x))
> +#define AD4170_V_BIAS_REG			0x134
> +#define AD4170_CURRENT_SRC_REG(x)		(0x138 + 2 * (x))
> +
> +/* AD4170_REG_INTERFACE_CONFIG_A */

Name the fields to make it obvious what they are in.  Just the config_A bit=
 should do
or INTCONFA or some other shortening.



> +#define AD4170_SW_RESET_MSK		(BIT(7) | BIT(0))
> +#define AD4170_IFACE_CONFIG_ADDR_ASCENSION_MSK	BIT(5)
That made me go look at the datasheet.  Weird naming.  I'd call it ADDR_INC=
_NDEC
or something like that.

> +#define AD4170_RESET_SLEEP_US	        1000
> +#define AD4170_INT_REF_2_5V		2500000
> +
> +/* AD4170_REG_PIN_MUXING */
> +#define AD4170_PIN_MUXING_DIG_AUX2_CTRL_MSK		GENMASK(7, 6)
> +#define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
> +#define AD4170_PIN_MUXING_SYNC_CTRL_MSK			GENMASK(3, 2)
> +
> +/* AD4170_REG_CLOCK_CTRL */
> +#define AD4170_INT_FREQ_16MHZ				16000000
> +#define AD4170_EXT_FREQ_MHZ_MIN				1000000
> +#define AD4170_EXT_FREQ_MHZ_MAX				17000000
Generally don't mix field definitions with values they map to.  Put these
magic values later, or put them inline where they are used.  They are real
numbers afterall.  MEGA define in units.h is your friend as well for making
them more readable.

> +#define AD4170_CLOCK_CTRL_CLOCKSEL_MSK			GENMASK(1, 0)
> +
> +#define AD4170_INTERNAL_OSC				0x0
> +#define AD4170_INTERNAL_OSC_OUTPUT			0x1
> +#define AD4170_EXTERNAL_OSC				0x2
> +#define AD4170_EXTERNAL_XTAL				0x3

Name these so it's obvious where they go.  So after the field name.

I'll not look closely at the rest of the defines but suggestion is to rethi=
nk them
to make it easier to:
1) Figure out which register a field is in.
2) Figure out what values can be set in that field.

> +
> +/* AD4170_REG_POWER_DOWN_SW */
> +#define AD4170_POWER_DOWN_SW_PDSW1_MSK				BIT(1)
> +#define AD4170_POWER_DOWN_SW_PDSW0_MSK				BIT(0)
> +
> +/* AD4170_REG_ADC_CTRL */
> +#define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK			BIT(7)
> +#define AD4170_REG_CTRL_CONT_READ_MSK				GENMASK(5, 4)
> +#define AD4170_REG_CTRL_MODE_MSK				GENMASK(3, 0)
> +
> +/* AD4170_REG_CHANNEL_EN */
> +#define AD4170_CHANNEL_EN(ch)					BIT(ch)
> +
> +/* AD4170_REG_ADC_CHANNEL_SETUP */
> +#define AD4170_CHANNEL_SETUP_SETUP_MSK				GENMASK(2, 0)
> +
> +/* AD4170_REG_ADC_CHANNEL_MAP */
> +#define AD4170_CHANNEL_MAPN_AINP_MSK				GENMASK(12, 8)
> +#define AD4170_CHANNEL_MAPN_AINM_MSK				GENMASK(4, 0)
> +
> +/* AD4170_REG_ADC_SETUPS_MISC */
> +#define AD4170_MISC_CHOP_IEXC_MSK				GENMASK(15, 14)
> +#define AD4170_MISC_CHOP_ADC_MSK				GENMASK(9, 8)
> +#define AD4170_MISC_BURNOUT_MSK					GENMASK(1, 0)
> +
> +/* AD4170_REG_ADC_SETUPS_AFE */
> +#define AD4170_AFE_REF_BUF_M_MSK				GENMASK(11, 10)
> +#define AD4170_AFE_REF_BUF_P_MSK				GENMASK(9, 8)
> +#define AD4170_AFE_REF_SELECT_MSK				GENMASK(6, 5)
> +#define AD4170_AFE_BIPOLAR_MSK					BIT(4)
> +#define AD4170_AFE_PGA_GAIN_MSK					GENMASK(3, 0)
> +
> +/* AD4170_REG_ADC_SETUPS_FILTER */
> +#define AD4170_SETUPS_POST_FILTER_SEL_MSK			GENMASK(7, 4)
> +#define AD4170_SETUPS_FILTER_TYPE_MSK				GENMASK(3, 0)
> +
> +/* AD4170 REG_OFFSET*/
> +#define AD4170_OFFSET_MSK					GENMASK(23, 0)
> +
> +/* AD4170 REG_GAIN*/
> +#define AD4170_GAIN_MSK						GENMASK(23, 0)
> +#define AD4170_GAIN_REG_DEFAULT					0x555555
> +
> +/* AD4170_REG_CURRENT_SOURCE */
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_MSK			GENMASK(12, 8)
> +#define AD4170_CURRENT_SRC_I_OUT_VAL_MSK			GENMASK(2, 0)
> +
> +/* AD4170_REG_FIR_CONTROL */
> +#define AD4170_FIR_CONTROL_IIR_MODE_MSK				BIT(15)
> +
> +#define AD4170_MAX_CHANNELS				16
> +#define AD4170_MAX_ANALOG_PINS				8
> +#define AD4170_MAX_SETUPS				8
> +#define AD4170_INVALID_SETUP_SLOT			9
> +#define AD4170_NUM_CURRENT_SRC				4
> +#define AD4170_MAX_SAMP_RATE				125000
> +
> +#define AD4170_NUM_ANALOG_PINS				9
> +#define AD4170_NUM_GPIO_PINS				4
> +
> +#define AD4170_DIG_AUX1_DISABLED	0
> +#define AD4170_DIG_AUX1_RDY		1
> +#define AD4170_DIG_AUX1_SYNC		2
> +
> +#define AD4170_DIG_AUX2_DISABLED	0
> +#define AD4170_DIG_AUX2_LDAC		1
> +#define AD4170_DIG_AUX2_SYNC		2
> +
> +#define AD4170_SYNC_DISABLED		0
> +#define AD4170_SYNC_STANDARD		1
> +#define AD4170_SYNC_ALTERNATE		2
> +
> +#define AD4170_I_OUT_0UA		0
> +#define AD4170_I_OUT_10UA		10
> +#define AD4170_I_OUT_50UA		50
> +#define AD4170_I_OUT_100UA		100
> +#define AD4170_I_OUT_250UA		250
> +#define AD4170_I_OUT_500UA		500
> +#define AD4170_I_OUT_1000UA		1000
> +#define AD4170_I_OUT_1500UA		1500

Defines for not so magic numbers where the value is the name aren't
normally all that useful.

> +
> +#define AD4170_BURNOUT_OFF		0
> +#define AD4170_BURNOUT_100NA		100
> +#define AD4170_BURNOUT_2000NA		2000
> +#define AD4170_BURNOUT_10000NA		10000
> +
> +#define AD4170_PGA_OPTIONS		10
> +
> +enum ad4170_pin_function {
> +	AD4170_PIN_UNASIGNED,
> +	AD4170_PIN_ANALOG_IN,
> +	AD4170_PIN_CURRENT_OUT,
> +	AD4170_PIN_VBIAS
> +};
> +
> +enum ad4170_gpio_function {
> +	AD4170_GPIO_UNASIGNED,
> +	AD4170_GPIO_PW_DOW_SWITCH,
> +	AD4170_GPIO_AC_EXCITATION,
> +	AD4170_GPIO_OUTPUT,
> +	AD4170_GPIO_CHANNEL,
> +};
> +
> +#define AD4170_ADC_CTRL_CONT_READ_DISABLE		0
> +#define AD4170_ADC_CTRL_CONT_READ_ENABLE		1
> +//#define AD4170_ADC_CTRL_CONT_READ_TRANSMIT		2

?

> +
> +#define AD4170_ADC_CTRL_MODE_CONT			0
> +#define AD4170_ADC_CTRL_MODE_SINGLE			4
> +#define AD4170_ADC_CTRL_MODE_IDLE			7
> +
> +/**
> + * @enum ad4170_ref_buf
> + * @brief REFIN Buffer Enable.
> + */
> +enum ad4170_ref_buf {
> +	/** Pre-charge Buffer. */

Use longer defines and drop the comments as they should then
be unnecessary.

> +	AD4170_REF_BUF_PRE,
> +	/** Full Buffer.*/
> +	AD4170_REF_BUF_FULL,
> +	/** Bypass */
> +	AD4170_REF_BUF_BYPASS
> +};
> +
> +/**
> + * @enum ad4170_filter_type
> + * @brief Filter Mode for Sinc-Based Filters.
> + */
> +enum ad4170_filter_type {
> +	AD4170_SINC5_AVG,
> +	AD4170_SINC5,
> +	AD4170_SINC3,
> +};
> +
> +/* ADC Register Lengths */
> +static const unsigned int ad4170_reg_size[] =3D {
> +	[AD4170_INTERFACE_CONFIG_A_REG] =3D 1,
> +	[AD4170_STATUS_REG]	=3D 2,
> +	[AD4170_DATA_24b_REG]	=3D 3,
> +	[AD4170_PIN_MUXING_REG]	=3D 2,
> +	[AD4170_CLOCK_CTRL_REG]	=3D 2,
> +	[AD4170_POWER_DOWN_SW_REG]	=3D 2,
> +	[AD4170_ADC_CTRL_REG]	=3D 2,
> +	[AD4170_CHANNEL_EN_REG]	=3D 2,
> +	/*
> +	 * CHANNEL_SETUP and CHANNEL_MAP register are all 2 byte size each and
> +	 * their addresses are interleaved such that we have CHANNEL_SETUP0
> +	 * address followed by CHANNEL_MAP0 address, followed by CHANNEL_SETUP1,
> +	 * and so on until CHANNEL_MAP15.
> +	 * Thus, initialize the register size for them only once.
> +	 */
> +	[AD4170_CHAN_SETUP_REG(0) ... AD4170_CHAN_MAP_REG(AD4170_MAX_CHANNELS -=
 1)] =3D 2,
> +	/*
> +	 * MISC, AFE, FILTER, FILTER_FS, OFFSET, and GAIN register addresses are
> +	 * also interleaved but MISC, AFE, FILTER, FILTER_FS, OFFSET are 16-bit
> +	 * while OFFSET, GAIN are 24-bit registers so we can't init them all to
> +	 * the same size.
> +	 */
> +	/* Init MISC register size */

Maybe use a macro for each config set?
Would avoid confusion of having them out of register order here.

> +	[AD4170_MISC_REG(0)] =3D 2,
> +	[AD4170_MISC_REG(1)] =3D 2,
> +	[AD4170_MISC_REG(2)] =3D 2,
> +	[AD4170_MISC_REG(3)] =3D 2,
> +	[AD4170_MISC_REG(4)] =3D 2,
> +	[AD4170_MISC_REG(5)] =3D 2,
> +	[AD4170_MISC_REG(6)] =3D 2,
> +	[AD4170_MISC_REG(7)] =3D 2,
> +	/* Init AFE register size */
> +	[AD4170_AFE_REG(0)] =3D 2,
> +	[AD4170_AFE_REG(1)] =3D 2,
> +	[AD4170_AFE_REG(2)] =3D 2,
> +	[AD4170_AFE_REG(3)] =3D 2,
> +	[AD4170_AFE_REG(4)] =3D 2,
> +	[AD4170_AFE_REG(5)] =3D 2,
> +	[AD4170_AFE_REG(6)] =3D 2,
> +	[AD4170_AFE_REG(7)] =3D 2,
> +	/* Init FILTER register size */
> +	[AD4170_FILTER_REG(0)]	=3D 2,
> +	[AD4170_FILTER_REG(1)]	=3D 2,
> +	[AD4170_FILTER_REG(2)]	=3D 2,
> +	[AD4170_FILTER_REG(3)]	=3D 2,
> +	[AD4170_FILTER_REG(4)]	=3D 2,
> +	[AD4170_FILTER_REG(5)]	=3D 2,
> +	[AD4170_FILTER_REG(6)]	=3D 2,
> +	[AD4170_FILTER_REG(7)]	=3D 2,
> +	/* Init FILTER_FS register size */
> +	[AD4170_FILTER_FS_REG(0)]	=3D 2,
> +	[AD4170_FILTER_FS_REG(1)]	=3D 2,
> +	[AD4170_FILTER_FS_REG(2)]	=3D 2,
> +	[AD4170_FILTER_FS_REG(3)]	=3D 2,
> +	[AD4170_FILTER_FS_REG(4)]	=3D 2,
> +	[AD4170_FILTER_FS_REG(5)]	=3D 2,
> +	[AD4170_FILTER_FS_REG(6)]	=3D 2,
> +	[AD4170_FILTER_FS_REG(7)]	=3D 2,
> +	/* Init OFFSET register size */
> +	[AD4170_OFFSET_REG(0)]	=3D 3,
> +	[AD4170_OFFSET_REG(1)]	=3D 3,
> +	[AD4170_OFFSET_REG(2)]	=3D 3,
> +	[AD4170_OFFSET_REG(3)]	=3D 3,
> +	[AD4170_OFFSET_REG(4)]	=3D 3,
> +	[AD4170_OFFSET_REG(5)]	=3D 3,
> +	[AD4170_OFFSET_REG(6)]	=3D 3,
> +	[AD4170_OFFSET_REG(7)]	=3D 3,
> +	/* Init GAIN register size */
> +	[AD4170_GAIN_REG(0)]	=3D 3,
> +	[AD4170_GAIN_REG(1)]	=3D 3,
> +	[AD4170_GAIN_REG(2)]	=3D 3,
> +	[AD4170_GAIN_REG(3)]	=3D 3,
> +	[AD4170_GAIN_REG(4)]	=3D 3,
> +	[AD4170_GAIN_REG(5)]	=3D 3,
> +	[AD4170_GAIN_REG(6)]	=3D 3,
> +	[AD4170_GAIN_REG(7)]	=3D 3,
> +	[AD4170_V_BIAS_REG]	=3D 2,
> +	[AD4170_CURRENT_SRC_REG(0) ... AD4170_CURRENT_SRC_REG(AD4170_NUM_CURREN=
T_SRC - 1)] =3D 2,
> +};

> +
> +static const unsigned int ad4170_burnout_current_na_tbl[] =3D {
> +	AD4170_BURNOUT_OFF,

Maybe just call it 0NA which is off :)

> +	AD4170_BURNOUT_100NA,
> +	AD4170_BURNOUT_2000NA,
> +	AD4170_BURNOUT_10000NA,
> +};


