Return-Path: <linux-iio+bounces-14578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC7A1C3C8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F59A188977D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0B282ED;
	Sat, 25 Jan 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHuye4vj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A75208D0;
	Sat, 25 Jan 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737815995; cv=none; b=f/KSh6UVM0HQUBjoxNRikem7Qi/0WFbnANj0TyFuqNb2IGDCk6MyQNGbljGEwBDU0JUpVA+pGz0Gh3eVdzEexstR3re24rBSc7C5VnjmkYfAshnTw+qenJV4CWv57WpO5snOk1FxPWkbb+jX+/SBgaGi1t2IMeR8S/n80Q6OV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737815995; c=relaxed/simple;
	bh=ZI7ZvS4RmdNXc+hCYub/u4cdPrY8DXwvp9nPZ2/ix1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6Og3fkEeDWlz0+mfd5krLRLenHLybZu78SpRZDsyhIzyrTSADnGdd1kE4djWbCmaQDsGTHyUMhMz8+P/FJgHu9YRV2tk0G7bmbfgl3Ui9hhgMqg7n83sbE6tgmR7SOfC4I7oaef2B4OwzQVpQ+Z8BUPnhJj0sgtvYg/a0jbMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHuye4vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B2CC4CED6;
	Sat, 25 Jan 2025 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737815993;
	bh=ZI7ZvS4RmdNXc+hCYub/u4cdPrY8DXwvp9nPZ2/ix1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KHuye4vjiOI4btYX7yZZBPIccgHUjekK5hxiZ4HJaCIkaNJU9bjRw94xvGzjsmxKn
	 CmapCl70JHS0wgUpD4a7342rmIvfJCJ8KoyyJwr6DDeEDkB64r1rLVMRVVVMQk48EJ
	 VnZCjNNZPoDlZ/sfyIP8txKWMhzOiRmF5Ci9MbjxQzs0NFWNbEKYiLkaX8fuqs1gAc
	 4MA9j1Yu05g7xwTp/inm2tiUHSQYsWUvouSjHKCg9Cf1TXVYI7vOzaNEQoiRqBkWZ4
	 NwjeaooAFZcx4smskmxe5qoPU4cWRGTUu1F8gdQGuLrrFJhGVnvi5yWRMuqVh24Rp7
	 LG42NMcPS4vXQ==
Date: Sat, 25 Jan 2025 14:39:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7191: add AD7191
Message-ID: <20250125143942.3df83c3d@jic23-huawei>
In-Reply-To: <20250122132821.126600-3-alisa.roman@analog.com>
References: <20250122132821.126600-1-alisa.roman@analog.com>
	<20250122132821.126600-3-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 15:20:40 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Hi Alisa-Dariana,

A few additional comments inline. Hopefully not too much overlap
with other reviews

Jonathan

> diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
> new file mode 100644
> index 000000000000..dd8151ad3f3f
> --- /dev/null
> +++ b/drivers/iio/adc/ad7191.c
> @@ -0,0 +1,570 @@


> +static int set_cs(struct ad_sigma_delta *sigma_delta, int pull_down)
> +{
> +	struct spi_transfer t = {
> +		.len = 0,
> +		.cs_change = pull_down,
> +	};
> +	struct spi_message m;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);

spi_message_init_with_transfers() given there is no spi_sync_transfers_locked()
and probably not enough users to make it worth adding.


> +
> +	return spi_sync_locked(sigma_delta->spi, &m);
> +}
>

> +static int ad7191_gpio_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->sd.spi->dev;
> +
> +	if (device_property_read_u32(dev, "adi,odr-state", &st->odr_state) == 0) {
> +		if (st->odr_state > AD7191_MAX_ODR_STATE)
> +			return dev_err_probe(dev, -EINVAL, "Invalid ODR state.\n");
> +
> +		dev_info(dev, "ODR is pin-strapped to %d\n", st->odr_state);

dev_dbg for all these. 

> +		st->odr_gpios = NULL;
> +	} else {
> +		st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->odr_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
> +					     "Failed to get odr gpios.\n");
> +	}
> +
> +	if (device_property_read_u32(dev, "adi,pga-state", &st->pga_state) == 0) {
> +		if (st->odr_state > AD7191_MAX_PGA_STATE)
> +			return dev_err_probe(dev, -EINVAL, "Invalid PGA state.\n");
> +
> +		dev_info(dev, "PGA is pin-strapped to %d\n", st->pga_state);
> +		st->pga_gpios = NULL;
> +	} else {
> +		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->pga_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +					     "Failed to get pga gpios.\n");
> +	}
> +
> +	if (device_property_read_u32(dev, "adi,clksel-state", &st->clksel_state) == 0) {
> +		dev_info(dev, "CLKSEL is pin-strapped to %d\n", st->clksel_state);
> +		st->clksel_gpio = NULL;
> +	} else {
> +		st->clksel_gpio = devm_gpiod_get(dev, "clksel", GPIOD_OUT_HIGH);
> +		if (IS_ERR(st->clksel_gpio))
> +			return dev_err_probe(dev, PTR_ERR(st->clksel_gpio),
> +					     "Failed to get clksel gpio.\n");
> +	}
> +
> +	st->temp_gpio = devm_gpiod_get(dev, "temp", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->temp_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->temp_gpio),
> +				     "Failed to get temp gpio.\n");
> +
> +	st->chan_gpio = devm_gpiod_get(dev, "chan", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->chan_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->chan_gpio),
> +				     "Failed to get chan gpio.\n");
> +
> +	return 0;
> +}
> +
> +static int ad7191_clock_setup(struct ad7191_state *st)
> +{
> +	struct device *dev = &st->sd.spi->dev;
> +	u8 clksel_value;
> +
> +	st->mclk = devm_clk_get_enabled(dev, "mclk");
> +	if (IS_ERR(st->mclk)) {
> +		if (PTR_ERR(st->mclk) != -ENOENT)
> +			return dev_err_probe(dev, PTR_ERR(st->mclk),
> +					     "Failed to get mclk.\n");
> +
> +		/*
> +		 * No external clock found, default to internal clock.
Single line comment if anything.  Kind of obvious from code anyway
so could drop the comment..

> +		 */
> +		clksel_value = AD7191_INT_CLK_ENABLE;
> +		if (!st->clksel_gpio && st->clksel_state != AD7191_INT_CLK_ENABLE)
> +			return dev_err_probe(dev, -EINVAL,
> +				"Invalid CLKSEL state. To use the internal clock, CLKSEL must be high.\n");
> +
> +		dev_info(dev, "Using internal clock.\n");

dev_dbg() for this stuff.  Driver shouldn't be that noisy about details like this

> +	} else {
> +		clksel_value = AD7191_EXT_CLK_ENABLE;
> +		if (!st->clksel_gpio && st->clksel_state != AD7191_EXT_CLK_ENABLE)
> +			return dev_err_probe(dev, -EINVAL,
> +				"Invalid CLKSEL state. To use the external clock, CLKSEL must be low.\n");
> +
> +		dev_info(dev, "Using external clock.\n");
> +	}
> +
> +	if (st->clksel_gpio)
> +		gpiod_set_value(st->clksel_gpio, clksel_value);
> +
> +	return 0;
> +}
> +
> +static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	u64 scale_uv;
> +	const int gain[4] = {1, 8, 64, 128};
> +	int i, ret;
> +
> +	ret = ad7191_init_regulators(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_gpio_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_clock_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Sampling frequencies in Hz, available in the documentation, Table 5.

I'd just go with
	 /* Sampling frequencies in Hz, see Table 5 */

Unlikely it would be anywhere else and 'in the documentation' isn't
very specific.

> +	 */
> +	st->samp_freq_avail[0] = 120;
> +	st->samp_freq_avail[1] = 60;
> +	st->samp_freq_avail[2] = 50;
> +	st->samp_freq_avail[3] = 10;
> +
> +	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> +		scale_uv = ((u64)st->int_vref_mv * NANO) >>
> +			   (indio_dev->channels[0].scan_type.realbits - 1);
> +		do_div(scale_uv, gain[i]);
> +		st->scale_avail[i][1] = do_div(scale_uv, NANO);
> +		st->scale_avail[i][0] = scale_uv;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7191_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long m)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:

As below.  Make the scope explicit with {}

> +			guard(mutex)(&st->lock);
> +			*val = st->scale_avail[st->pga_state][0];
> +			*val2 = st->scale_avail[st->pga_state][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_TEMP:
> +			*val = 0;
> +			*val2 = NANO / AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1 << (chan->scan_type.realbits - 1));
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val -= 273 * AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->samp_freq_avail[st->odr_state];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}

> +
> +static int __ad7191_write_raw(struct ad7191_state *st,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
scope should be defined and obvious if you want to use guard.

	case IIO_CHAN_INFO_SCALE: {
		guard(mutex)(&st->lock);
...

		return -EINVAL;
	}
> +		guard(mutex)(&st->lock);
> +		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> +			if (val2 != st->scale_avail[i][1])
> +				continue;
> +			return ad7191_set_gain(st, i);
> +		}
> +		return -EINVAL;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!val)
> +			return -EINVAL;
> +
> +		guard(mutex)(&st->lock);

Same here.

> +		for (i = 0; i < ARRAY_SIZE(st->samp_freq_avail); i++) {
> +			if (val != st->samp_freq_avail[i])
> +				continue;
> +			return ad7191_set_samp_freq(st, i);
> +		}
> +		return -EINVAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ad7191_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ad7191_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!spi->irq) {
> +		dev_err(dev, "no IRQ?\n");

Can't the ad_sigma_delta library figure this out for all devices?
Feels odd to check it here when this code never directly uses it.


> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "ad7191";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad7191_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7191_channels);
> +	indio_dev->info = &ad7191_info;
> +
> +	ad_sd_init(&st->sd, indio_dev, spi, &ad7191_sigma_delta_info);
> +
> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_setup(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

