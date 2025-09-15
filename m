Return-Path: <linux-iio+bounces-24119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FFB585C0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 22:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB5B7A225A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB21289802;
	Mon, 15 Sep 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUtK8wJx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763F2747B;
	Mon, 15 Sep 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967211; cv=none; b=hH8fui/SUslM7k4yrIAnGGUB8Ju4IhqDRFG74u0VDeNxUXA54NPqW174ab9FasLf2Zb8j23J23lHYYSn4doWvw/zYoENgqBGxNAybeGmPRnJXd7yfexcz8/zS3gP67jPaCapm/t+JyjsCwzCbGTkgAV4vpf2+MuHCF2Dw2DkquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967211; c=relaxed/simple;
	bh=sCG6ETdfTXdU2pnnMtozox8YjbeWgsBQMnCaCblSvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDPZlT6PL4Xsj64vicIFoGSEWEe/v9slMDZFrvsG213Z9Trfus9zNbnBwZKb4nXN2/YyUsxuWrOuaWZFHy8hZBQAuhWH673Ykqhkr7QQ830izU3Nwct/ZEe1exQCnDVGq838zn2KZNS5xWD1/Ob+Sy+AITwo92mKZZ2218DcrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUtK8wJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2474C4CEF1;
	Mon, 15 Sep 2025 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757967211;
	bh=sCG6ETdfTXdU2pnnMtozox8YjbeWgsBQMnCaCblSvgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hUtK8wJxUjCzDYLa5vedEHLvsx5Af0pWXUKHmFdth0E7Ds3tPKgFwXhFA2Dhw4YXP
	 ga1bGxoH9FNInZ1/DbtTcIKMc2hLqL1Xa2jXs0fk52BlAA1IpcCqS1nbeYU5qzcyJ7
	 G8z68f7IeRhPL2OTGyJC7cxWTxwyJ/gkV1ULq3YBv0tXx7J5Tv2C5ncBTXbVEAxACa
	 YHMJ/IuoJKoE9ZWzsZhK6FEukKJZzMv8uQMlKfzvTsfp8G0KzSemAado53Uaa/LSHQ
	 JnVJv9E7IiBlBffIwVI/b/owd/BaaKg2w5MvpgjmpIVoBnApXEJD7Pv0VbMTGCv14J
	 rh23Z04Iet+wQ==
Date: Mon, 15 Sep 2025 21:13:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250915211321.47865d3d@jic23-huawei>
In-Reply-To: <aMge0jYwYCiY72Yb@smile.fi.intel.com>
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
	<20250915-bd79112-v5-2-a74e011a0560@gmail.com>
	<aMge0jYwYCiY72Yb@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 17:12:34 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:
> > The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> > be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> > 
> > The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> > voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> > daisy-chain configuration) and maximum sampling rate is 1MSPS.
> > 
> > The IC does also support CRC but it is not implemented in the driver.  
> 
> ...
> 
> > +static int bd79112_probe(struct spi_device *spi)
> > +{
> > +	struct bd79112_data *data;
> > +	struct iio_dev *iio_dev;
> > +	struct iio_chan_spec *cs;
> > +	struct device *dev = &spi->dev;
> > +	unsigned long gpio_pins, pin;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!iio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(iio_dev);
> > +	data->spi = spi;
> > +	data->dev = dev;
> > +	data->map = devm_regmap_init(dev, NULL, data, &bd79112_regmap);
> > +	if (IS_ERR(data->map))
> > +		return dev_err_probe(dev, PTR_ERR(data->map),
> > +				     "Failed to initialize Regmap\n");
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");  
> 
> > +	data->vref_mv = ret / 1000;  
> 
> I still think moving to _mV is the right thing to do.
> There is no 'mv' in the physics for Volts.

I'm not disagreeing with this review but I'm also not going to hold a
driver back for that given timing is pretty much such that I merge it
today or it sits a cycle and this one is very near...
I'll get fussier on this once we have written up some guidance and may
well send a patch to modify existing recent cases like this one!

> 
> > +	ret = devm_regulator_get_enable(dev, "iovdd");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
> > +
> > +	data->read_xfer[0].tx_buf = &data->read_tx[0];
> > +	data->read_xfer[0].len = sizeof(data->read_tx);
> > +	data->read_xfer[0].cs_change = 1;
> > +	data->read_xfer[1].rx_buf = &data->read_rx;
> > +	data->read_xfer[1].len = sizeof(data->read_rx);
> > +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);  
> 
> > +	devm_spi_optimize_message(dev, spi, &data->read_msg);  
> 
> And if it fails?..
I've added the following and applied the series.

Note I'm cutting this fine so if we get any build issues or similar
it might well get pushed back to next cycle yet!

diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
index b406d4ee5411..d15e06c8b94d 100644
--- a/drivers/iio/adc/rohm-bd79112.c
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -454,12 +454,18 @@ static int bd79112_probe(struct spi_device *spi)
        data->read_xfer[1].rx_buf = &data->read_rx;
        data->read_xfer[1].len = sizeof(data->read_rx);
        spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
-       devm_spi_optimize_message(dev, spi, &data->read_msg);
+       ret = devm_spi_optimize_message(dev, spi, &data->read_msg);
+       if (ret < 0)
+               return dev_err_probe(dev, ret,
+                                    "Failed to optimize SPI read message\n");
 
        data->write_xfer.tx_buf = &data->reg_write_tx[0];
        data->write_xfer.len = sizeof(data->reg_write_tx);
        spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
-       devm_spi_optimize_message(dev, spi, &data->write_msg);
+       ret = devm_spi_optimize_message(dev, spi, &data->write_msg);
+       if (ret < 0)
+               return dev_err_probe(dev, ret,
+                                    "Failed to optimize SPI write message\n");
 
        ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
                                                    BD79112_MAX_NUM_CHANNELS - 1,
> 
> > +	data->write_xfer.tx_buf = &data->reg_write_tx[0];
> > +	data->write_xfer.len = sizeof(data->reg_write_tx);
> > +	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
> > +	devm_spi_optimize_message(dev, spi, &data->write_msg);
> > +
> > +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
> > +						    BD79112_MAX_NUM_CHANNELS - 1,
> > +						    &cs);
> > +
> > +	/* Register all pins as GPIOs if there are no ADC channels */
> > +	if (ret == -ENOENT)
> > +		goto register_gpios;
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	iio_dev->num_channels = ret;
> > +	iio_dev->channels = cs;
> > +
> > +	for (i = 0; i < iio_dev->num_channels; i++)
> > +		cs[i].datasheet_name = bd79112_chan_names[cs[i].channel];
> > +
> > +	iio_dev->info = &bd79112_info;
> > +	iio_dev->name = "bd79112";
> > +	iio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	/*
> > +	 * Ensure all channels are ADCs. This allows us to register the IIO
> > +	 * device early (before checking which pins are to be used for GPIO)
> > +	 * without having to worry about some pins being initially used for
> > +	 * GPIO.
> > +	 */
> > +	for (i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
> > +		ret = regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to initialize channels\n");
> > +	}
> > +
> > +	ret = devm_iio_device_register(data->dev, iio_dev);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret, "Failed to register ADC\n");
> > +
> > +register_gpios:
> > +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> > +					  iio_dev->num_channels);
> > +
> > +	/* If all channels are reserved for ADC, then we're done. */
> > +	if (!gpio_pins)
> > +		return 0;
> > +
> > +	/* Default all the GPIO pins to GPI */
> > +	for_each_set_bit(pin, &gpio_pins, BD79112_MAX_NUM_CHANNELS) {
> > +		ret = bd79112_gpio_dir_set(data, pin, GPIO_LINE_DIRECTION_IN);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to mark pin as GPI\n");
> > +	}
> > +
> > +	data->gpio_valid_mask = gpio_pins;
> > +	data->gc = bd79112_gpio_chip;
> > +	data->gc.parent = dev;
> > +
> > +	return devm_gpiochip_add_data(dev, &data->gc, data);
> > +}  
> 


