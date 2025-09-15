Return-Path: <linux-iio+bounces-24112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827CB57E79
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48416204462
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1A31B821;
	Mon, 15 Sep 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ib744pOF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47D2D12E7;
	Mon, 15 Sep 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945563; cv=none; b=Rf7pD8gjznhYWwzVaZncvPd401MqrjLAePI91iLtqw1yVIg5A2314JJLLmFSTmy6wmPcQWOkuedruKJObzDGYMPnm8qbNY2hw/Qx0AxLkTr41qOwilVjULJnrAyc0Vsi8miM/MXo9AVOPmNhHnuaQbcFkxdf9XZ+uLsx89hpp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945563; c=relaxed/simple;
	bh=KgVjLVJIEGxaahBivf2jposmH0k5F1mKeUGKFxC40rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7sg68+gcMdxdignmajnqTTW6bpkQYCb0zNpa9VFy5FxNYvevjmcPJROes8DPJwOnhQxzkIiXZmtSo4sSl0ibiWqz+ej1ayYDzVXjdl/iVlrY4wC0WPNiyl1Hq1ToMLIbLBEgje/se7rxyKkFGpYseJrgLqH6f4pTRRWwmN7ISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ib744pOF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757945562; x=1789481562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KgVjLVJIEGxaahBivf2jposmH0k5F1mKeUGKFxC40rU=;
  b=Ib744pOFSXOA4yk2Umv77oMD4dy7jZXXkSC6uAkMq3gvxo1Ejz1ljxNn
   uniqacumbyKv3aw6rKOjjYn9eFXhHBR0yyGVwSnEqQ83lSe+UIDE0yJtT
   zvaFFW2Wrx7ejy3+8foPrITFVpCuQnze5Kwky6pY9AR2AXMYSfVnP3Dji
   videZ4QMQJEHwuXmmnTF7C2ZTvCL1dRqfL/4TUi22hDXfaWA7vMUGSuaY
   44P7IclGqeqWKSUSX5Xd4nA2tVboBbQH0BD/e6tDS37YjsWeyxIkd8JdV
   rB6BHgSzVFFt/mZgqfzAC7PU09H3bp5lBV7Y6JC5lttgOwxwOUFTRyL4w
   g==;
X-CSE-ConnectionGUID: 47WfFI+oT5y+jX+fb8MHyg==
X-CSE-MsgGUID: GZVkfGJxQrafETJ604+l0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71567912"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="71567912"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:12:41 -0700
X-CSE-ConnectionGUID: 3inNKzA3TLKjz1f7vlblkg==
X-CSE-MsgGUID: TtYywyn8Sx6i+0cfps0tpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="179807537"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:12:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uy9wY-00000003GfO-1jDn;
	Mon, 15 Sep 2025 17:12:34 +0300
Date: Mon, 15 Sep 2025 17:12:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <aMge0jYwYCiY72Yb@smile.fi.intel.com>
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:
> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> 
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> 
> The IC does also support CRC but it is not implemented in the driver.

...

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
> +	data->map = devm_regmap_init(dev, NULL, data, &bd79112_regmap);
> +	if (IS_ERR(data->map))
> +		return dev_err_probe(dev, PTR_ERR(data->map),
> +				     "Failed to initialize Regmap\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");

> +	data->vref_mv = ret / 1000;

I still think moving to _mV is the right thing to do.
There is no 'mv' in the physics for Volts.

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

> +	devm_spi_optimize_message(dev, spi, &data->read_msg);

And if it fails?..

> +	data->write_xfer.tx_buf = &data->reg_write_tx[0];
> +	data->write_xfer.len = sizeof(data->reg_write_tx);
> +	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
> +	devm_spi_optimize_message(dev, spi, &data->write_msg);
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
> +	for (i = 0; i < iio_dev->num_channels; i++)
> +		cs[i].datasheet_name = bd79112_chan_names[cs[i].channel];
> +
> +	iio_dev->info = &bd79112_info;
> +	iio_dev->name = "bd79112";
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/*
> +	 * Ensure all channels are ADCs. This allows us to register the IIO
> +	 * device early (before checking which pins are to be used for GPIO)
> +	 * without having to worry about some pins being initially used for
> +	 * GPIO.
> +	 */
> +	for (i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
> +		ret = regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to initialize channels\n");
> +	}
> +
> +	ret = devm_iio_device_register(data->dev, iio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to register ADC\n");
> +
> +register_gpios:
> +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> +					  iio_dev->num_channels);
> +
> +	/* If all channels are reserved for ADC, then we're done. */
> +	if (!gpio_pins)
> +		return 0;
> +
> +	/* Default all the GPIO pins to GPI */
> +	for_each_set_bit(pin, &gpio_pins, BD79112_MAX_NUM_CHANNELS) {
> +		ret = bd79112_gpio_dir_set(data, pin, GPIO_LINE_DIRECTION_IN);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to mark pin as GPI\n");
> +	}
> +
> +	data->gpio_valid_mask = gpio_pins;
> +	data->gc = bd79112_gpio_chip;
> +	data->gc.parent = dev;
> +
> +	return devm_gpiochip_add_data(dev, &data->gc, data);
> +}

-- 
With Best Regards,
Andy Shevchenko



