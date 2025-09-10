Return-Path: <linux-iio+bounces-23952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA7B51F59
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA377A71D5
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D713334711;
	Wed, 10 Sep 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnoGWGmD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBEF261B9A;
	Wed, 10 Sep 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526385; cv=none; b=X3VAOByE9HIhx/67C0EzWFhAG3Aso3WDyLTUPWV8wskmv3sdzAbxIE2L7khZ39wAjuTZ9xQhlWyTjw+A36jniTgA2E9hi7dj14nQUCVwIH3MPxz+JEwqrZ0iusv8KuODthZJTMTfAL225EUKiTqIJPvS/F4HQzgXyATyG38FknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526385; c=relaxed/simple;
	bh=0dXcKztqcBTIOPXYflckkwx4jmeZlOxeJTyT5RrxD4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6vStQQ4/Fqd18JEePhO6PPYkpZDZ9e4/ZFMV0MvN3TWCRHojxgu858aP39HxnU2Jz5AmqTsgeViqNn+LIpAlpP6OPxJ+wJ+gx9MNumYlNvIrerklnfacoWH/75rXS+6CveqlQSDghVaQpZswlOj1zYztKSuZ9TF+EuuSQatTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnoGWGmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94622C4CEEB;
	Wed, 10 Sep 2025 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757526385;
	bh=0dXcKztqcBTIOPXYflckkwx4jmeZlOxeJTyT5RrxD4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnoGWGmDsGGsuBI8+xP9ocNVkgIr1W7X79Iy8FHpqHRwlfqsr0bcNw97A2akFb9ab
	 H4vfxU/L377lNc6Y3f9tdzKpp9XAIIJtCboHfGPpPoYVVy9W4lnqzaB9yxdw1Ri3Xs
	 BBZPJO8lzXJjTYZXiCd8L0rSxHl7WbDBiS5Td53z2yzj8liwKQqfq9sAFhvukRjRvk
	 HpSqobSH5GbYN4S69SgLIB+MEoPA4YepCjpb0bkodHkQ/oK6gTVSq9AYMq01lccK11
	 AprDuLOpqW8/99B4l7wMDJW86FpeSpxmxmaxpzdspoa9/OXvG0sF8CHPw8u4x7bZgp
	 F3/jPcySK/r5A==
Date: Wed, 10 Sep 2025 18:46:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250910184619.0303163d@jic23-huawei>
In-Reply-To: <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
	<20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 14:24:35 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> 
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> 
> The IC does also support CRC but it is not implemented in the driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

A few trivial things that I'll tidy up if nothing else comes up (I might not
bother given how trivial they are!)

Also one question. I couldn't immediately follow why any random register
read is sanity checking if an ADC pin is configured as GPIO.

Jonathan

> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a2a3affe2c6dc86a237a164139c27ec66dc9d131
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79112.c
> @@ -0,0 +1,553 @@


> +/*
> + * The BD79112 requires "R/W bit" to be set for SPI register (not ADC data)
> + * reads and an "IOSET bit" to be set for read/write operations (which aren't
> + * reading the ADC data).
> + */

> +/*
> + * Read transaction consists of two 16-bit sequences separated by CSB.
> + * For register read, 'IOSET' bit must be set. For ADC read, IOSET is cleared
> + * and ADDR equals the channel number (0 ... 31).
> + *
> + * First 16-bit sequence, MOSI as below, MISO data ignored:
> + * - SCK: | 1 | 2 |   3   |    4   | 5 .. 8 | 9 .. 16 |
> + * - MOSI:| 0 | 0 | IOSET | RW (1) |  ADDR  |  8'b0   |
> + *
> + * CSB released and re-acquired between these sequences
> + *
> + * Second 16-bit sequence, MISO as below, MOSI data ignored:
> + *   For Register read data is 8 bits:
> + *   - SCK: | 1 .. 8 |   9 .. 16   |
> + *   - MISO:|  8'b0  | 8-bit data  |
> + *
> + *   For ADC read data is 12 bits:
> + *   - SCK: | 1 .. 4 |   4 .. 16   |
> + *   - MISO:|  4'b0  | 12-bit data |
> + */
> +static int bd79112_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct bd79112_data *data = context;
> +	int ret;
> +
> +	if (reg & BD79112_BIT_IO)
> +		reg |= BD79112_BIT_RW;
> +
> +	data->read_tx[0] = reg;
> +
> +	ret = spi_sync(data->spi, &data->read_msg);
> +	if (!ret)
> +		*val = be16_to_cpu(data->read_rx);
> +
> +	if (reg & BD79112_BIT_IO && *val & BD79112_ADC_STATUS_FLAG)
> +		dev_err(data->dev, "ADC pin configured as GPIO\n");

Why are we checking this in a regmap callback?
Maybe it needs rewording and the point is some missmatch in what we
can read vs the state?

> +
> +	return ret;
> +}

> +
> +static int bd79112_probe(struct spi_device *spi)
> +{
> +	struct bd79112_data *data;
> +	struct iio_dev *iio_dev;
> +	struct iio_chan_spec *cs;
> +	struct device *dev = &spi->dev;
> +	unsigned long gpio_pins, pin;
> +	unsigned int i;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio_dev);
> +	data->spi = spi;
> +	data->dev = dev;
> +	data->map = devm_regmap_init(&spi->dev, NULL, data, &bd79112_regmap);

	data->mpa = devm_regmap_init(dev, ...


> +	if (IS_ERR(data->map))
> +		return dev_err_probe(dev, PTR_ERR(data->map),
> +				     "Failed to initialize Regmap\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
> +
> +	data->vref_mv = ret / 1000;
> +
> +	ret = devm_regulator_get_enable(dev, "iovdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
> +
> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
> +	data->read_xfer[0].len = sizeof(data->read_tx);
> +	data->read_xfer[0].cs_change = 1;
> +	data->read_xfer[1].rx_buf = &data->read_rx;
> +	data->read_xfer[1].len = sizeof(data->read_rx);
> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
> +
> +	data->write_xfer.tx_buf = &data->reg_write_tx[0];
> +	data->write_xfer.len = sizeof(data->reg_write_tx);
> +	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
> +
> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
> +						    BD79112_MAX_NUM_CHANNELS - 1,
> +						    &cs);
> +
> +	/* Register all pins as GPIOs if there are no ADC channels */
> +	if (ret == -ENOENT)
> +		goto register_gpios;
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	iio_dev->num_channels = ret;
> +	iio_dev->channels = cs;
> +
> +	for (i = 0; i < iio_dev->num_channels; i++) {
> +		unsigned int ch = cs[i].channel;
> +
> +		cs[i].datasheet_name = bd79112_chan_names[ch];

Could have done

		cs[i].datasheet_name = bd79112_chan_names[cs[i].channel];

and I don't think it makes it harder to read, but doesn't matter enough to respin.

> +	}



