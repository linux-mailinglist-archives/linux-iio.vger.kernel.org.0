Return-Path: <linux-iio+bounces-18016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9135A86E37
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0D719E25D2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C61F03C1;
	Sat, 12 Apr 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaKiiKIT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E321DFE8;
	Sat, 12 Apr 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744476441; cv=none; b=lQhz+IEM1jOpJO/H5KBEoEhh5P5byn0lGEqoDfyU1rQecSpKqtcIi/z5KrX9jYrkb/6Chxo+eCKVIiwbZSTARoCjpKCV7cLM8ZddkbRSC7Rz+oNY2PE5hoyberU1zi3J0GiCWajZgKd3l7f7V5CGTD2NoF2Q1a+jZgJ9qkvQwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744476441; c=relaxed/simple;
	bh=6j6m/hd/naEKq1B81DZ1wsfYKBuf2rmA5SeCvlTY7qA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3T64PpPWGWh34TyFMrfi8yEZdWy8KRhJVxroLl98geKR7LCMrjmohB6Yh88o0Pu6eCxRsBeUzYJ7LfMMqjE5QUVvL8F+e2Dh7U6xqwyhKJl/vkU4KvnRsooRyIeT/YNKRztFUDT3a1jhsTyAkbV/W2KywzANVuziwJq8/PApLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaKiiKIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6578C4CEE3;
	Sat, 12 Apr 2025 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744476440;
	bh=6j6m/hd/naEKq1B81DZ1wsfYKBuf2rmA5SeCvlTY7qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FaKiiKITYfUuTYhyjiJ3zeU4MtF/MNEFG0m1LvfYYQ/nlYUUiSOWZY2QE91dkIFit
	 JfiUrPfUHAAgEbysA5zCMFrvGJbT7YLb7eUMcXZjHPueV+uMdbjqHhRFhB6FjFzg0A
	 4FzBKAxT0LpfSkjatg8wCakp95uAVpMAaLFuPnvIO8Y2bqJrjBWuXbgZrmm9ISWynS
	 nMgxcrFilm4LE8wA/6A937KVcSCasDlllbYQy/AL4JXbmzzzZYvEeQIG0cQZ/bAcUX
	 n1OHQ4hd34UFQqj0iYPfBDuAypkNkhs3ZkG7MYgzMhU8nDytTxI1Jy6AKawXc45SDE
	 sQ4LHhvajYFNg==
Date: Sat, 12 Apr 2025 17:47:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ana-Maria Cusco
 <ana-maria.cusco@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
Message-ID: <20250412174710.33afb04d@jic23-huawei>
In-Reply-To: <5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	<5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 09:24:35 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> 
> Add support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Digital filter and sampling frequency configuration.
> - Calibration gain and offset configuration.
> - Differential and pseudo-differential input configuration.
> 
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi.

Clearly this is a massive driver, even with it broken up like this.
So it might take a few cycles to review enough that we don't find
new things :(

I can't think of a good way to split it up further though

Jonathan

> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> new file mode 100644
> index 000000000000..0d24286ac2ab
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.c


> +#define AD4170_NUM_ANALOG_PINS				9
> +#define AD4170_MAX_CHANNELS				16
> +#define AD4170_MAX_ANALOG_PINS				8
> +#define AD4170_MAX_SETUPS				8
> +#define AD4170_INVALID_SETUP				9
> +#define AD4170_NUM_CURRENT_SRC				4
> +#define AD4170_DEFAULT_SAMP_RATE			(125 * KILO)
> +
> +#define AD4170_INT_REF_2_5V				(2500 * MILLI)

As with the clocks. Sometimes just having the value inline is clearer.

Also units of this are not clear from name (uvolts it seems)

> +
> +/* Internal and external clock properties */
> +#define AD4170_INT_CLOCK_16MHZ				(16 * MEGA)
> +#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * MEGA)
> +#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * MEGA)

Do these benefit from being defines given the are real numbers, not magic ones?

> +#define AD4170_MAX_FS_TBL_SIZE		ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl)
> +
> +static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
> +	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256

Add the trailing comma. Only time to not have those is for terminating / null entries.
It is a slightly odd convention given we won't see more elements in an array like
this one but it has been like that a long time.

Similar for other cases.

> +};


>
> +
> +static int ad4170_read_sample(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	int settling_time_ms, ret;
> +
> +	guard(mutex)(&st->lock);
> +	/*
> +	 * The ADC sequences through all enabled channels. That can lead to
> +	 * incorrect channel being sampled if a previous read would have left a
> +	 * different channel enabled. Thus, always enable and disable the
> +	 * channel on single-shot read.
> +	 */
> +	ret = ad4170_set_channel_enable(st, chan->address, true);
> +	if (ret)
> +		return ret;
Consider factoring out from here... 
> +
> +	reinit_completion(&st->completion);
> +
> +	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_SINGLE);
> +	if (ret)
> +		goto err_disable;
> +
> +	/*
> +	 * When a channel is manually selected by the user, the ADC needs an
> +	 * extra time to provide the first stable conversion. The ADC settling
> +	 * time depends on the filter type, filter frequency, and ADC clock
> +	 * frequency (see datasheet page 53). The maximum settling time among
> +	 * all filter configurations is 6291164 / fCLK. Use that formula to wait
> +	 * for sufficient time whatever the filter configuration may be.
> +	 */
> +	settling_time_ms = DIV_ROUND_UP(6291164 * MILLI, st->mclk_hz);
> +	ret = wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(settling_time_ms));
> +	if (!ret)
> +		dev_dbg(&st->spi->dev,
> +			"No Data Ready signal. Reading after delay.\n");
> +
> +	ret = regmap_read(st->regmap24, AD4170_DATA_24B_REG, val);
> +	if (ret)
> +		goto err_disable;
> +
> +	if (chan->scan_type.sign == 's')
> +		*val = sign_extend32(*val, chan->scan_type.realbits - 1);
> +
to here as a helper.  That way you can do direct returns from the helper.

> +err_disable:
> +	ret = ad4170_set_channel_enable(st, chan->address, false);
Avoid overwriting the first error code.

> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}

> +static int ad4170_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +	enum ad4170_filter_type f_type;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)chan_info->scale_tbl;
> +		*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		f_type = ad4170_get_filter_type(indio_dev, chan);
> +		switch (f_type) {
> +		case AD4170_SINC5_AVG:
> +			fallthrough;
No need for fallthrough here.
		case A:
		case B:

is fine without .

> +		case AD4170_SINC3:
> +			*vals = (int *)st->sps_tbl[f_type];
> +			*length = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl) * 2;
> +			break;
> +		case AD4170_SINC5:
> +			*vals = (int *)st->sps_tbl[f_type];
> +			*length = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl) * 2;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4170_set_pga(struct ad4170_state *st,
> +			  struct iio_chan_spec const *chan, int val, int val2)
> +{
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup = &chan_info->setup;
> +	unsigned int old_pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> +	unsigned int pga;
> +	int ret = 0;
Looks like ret is always set.

> +
> +	for (pga = 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
> +		if (val == chan_info->scale_tbl[pga][0] &&
> +		    val2 == chan_info->scale_tbl[pga][1])
> +			break;
> +	}
> +
> +	if (pga == AD4170_NUM_PGA_OPTIONS)
> +		return -EINVAL;
> +
> +	if (pga == old_pga)
> +		return 0;
> +
> +	setup->afe &= ~AD4170_AFE_PGA_GAIN_MSK;
> +	setup->afe |= FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, pga);
> +
> +	guard(mutex)(&st->lock);
> +	ret = ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret) {
> +		setup->afe &= ~AD4170_AFE_PGA_GAIN_MSK;
> +		setup->afe |= FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, old_pga);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad4170_set_channel_freq(struct ad4170_state *st,
> +				   struct iio_chan_spec const *chan, int val,
> +				   int val2)
> +{
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup = &chan_info->setup;
> +	enum ad4170_filter_type f_type = __ad4170_get_filter_type(setup->filter);
> +	int filt_fs_tbl_size, i, ret = 0;
Don't mix declarations with assignments on a line with others that don't assign
Also, I think ret is always set anwyay.

> +	unsigned int old_filter_fs;
> +
> +	switch (f_type) {
> +	case AD4170_SINC5_AVG:
> +		fallthrough;
> +	case AD4170_SINC3:
> +		filt_fs_tbl_size = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl);
> +		break;
> +	case AD4170_SINC5:
> +		filt_fs_tbl_size = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl);
> +		break;
> +	}
> +
> +	for (i = 0; i < filt_fs_tbl_size; i++) {
> +		if (st->sps_tbl[f_type][i][0] == val &&
> +		    st->sps_tbl[f_type][i][1] == val2)
> +			break;
> +	}
> +	if (i >= filt_fs_tbl_size)
> +		return -EINVAL;
> +
> +	old_filter_fs = setup->filter_fs;
> +	if (f_type == AD4170_SINC5)
> +		setup->filter_fs = ad4170_sinc5_filt_fs_tbl[i];
> +	else
> +		setup->filter_fs = ad4170_sinc3_filt_fs_tbl[i];
> +
> +	guard(mutex)(&st->lock);
> +	ret = ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret)
> +		setup->filter_fs = old_filter_fs;
> +
> +	return ret;
> +}



> +
> +static irqreturn_t ad4170_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +
> +	complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +};
> +
> +static int ad4170_trigger_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-trig%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad4170_trigger_ops;
> +	st->trig->dev.parent = indio_dev->dev.parent;
> +
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	return request_irq(st->spi->irq, &ad4170_irq_handler, IRQF_ONESHOT,
> +			   indio_dev->name, indio_dev);

This seems unusual. If it's a trigger, why not calling iio_trigger_poll() etc?
This doesn't seem to be a trigger at all.  Maybe introduce it only with buffered
capture, so in the next patch.  Here all you need is the interrupt registration.

> +}
> +
> +static int ad4170_regulator_setup(struct ad4170_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	/* Required regulators */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get AVDD voltage.\n");
> +
> +	st->vrefs_uv[AD4170_AVDD_SUP] = ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "iovdd");

If no channel uses this reference is it not optional?  Maybe not worth the
complexity of handling that.  We have sometime bothered to do so in the past
by first figuring out which references are in use, then trying to get the
appropriate regulators with small changes for cases like this where
it needs to be enabled but we might not need the voltage.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get IOVDD voltage.\n");
> +
> +	st->vrefs_uv[AD4170_IOVDD_SUP] = ret;
> +
> +	/* Optional regulators */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "avss");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get AVSS voltage.\n");
> +
> +	/* Assume AVSS at GND (0V) if not provided */
> +	st->vrefs_uv[AD4170_AVSS_SUP] = ret == -ENODEV ? 0 : -ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin1p");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN+ voltage.\n");
> +
> +	st->vrefs_uv[AD4170_REFIN1P_SUP] = ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin1n");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN- voltage.\n");
> +
> +	/* Negative supplies are assumed to provide negative voltage */
> +	st->vrefs_uv[AD4170_REFIN1N_SUP] = ret == -ENODEV ? -ENODEV : -ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin2p");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN2+ voltage.\n");
> +
> +	st->vrefs_uv[AD4170_REFIN2P_SUP] = ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin2n");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN2- voltage.\n");
> +
> +	/* Negative supplies are assumed to provide negative voltage */
> +	st->vrefs_uv[AD4170_REFIN2N_SUP] = ret == -ENODEV ? -ENODEV : -ret;
> +
> +	return 0;
> +}
> +
> +static int ad4170_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4170_state *st;
> +	const char *dev_name;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	devm_mutex_init(dev, &st->lock);
> +
> +	dev_name = spi_get_device_match_data(spi);
> +	if (!dev_name)
> +		return -EINVAL;
> +
> +	indio_dev->name = dev_name;
> +	indio_dev->info = &ad4170_info;
> +
> +	st->spi = spi;
> +	st->regmap8 = devm_regmap_init_spi(spi, &ad4170_regmap8_config);
> +	if (IS_ERR(st->regmap8))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap8),
> +				     "Failed to initialize regmap8\n");
> +
> +	st->regmap16 = devm_regmap_init_spi(spi, &ad4170_regmap16_config);

I see Nuno suggested bulk reads for these. I'd be surprised if you can't
make that work better than this complex multiple regmap case. We normallly
only do this if they are genuinely variable sized registers. Here they
are defined as sets of 8 bit registers.


> +	if (IS_ERR(st->regmap16))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap16),
> +				     "Failed to initialize regmap16\n");
> +

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad4170_id_table[] = {
> +	{ "ad4170", (kernel_ulong_t)ad4170_chip_names[0] },

I'd be surprised if we never see anything different between these other than
the names.  I would just define a structure that for now just contains
the const char *name

> +	{ "ad4190", (kernel_ulong_t)ad4170_chip_names[1] },
> +	{ "ad4195", (kernel_ulong_t)ad4170_chip_names[2] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4170_id_table);


