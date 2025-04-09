Return-Path: <linux-iio+bounces-17884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9962A82C4E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC9C3A37B0
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353DD26869D;
	Wed,  9 Apr 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3iIuENC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39A267F77;
	Wed,  9 Apr 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215583; cv=none; b=kVD0f7QUe9SK9XZvWvAJNmjYowsgzDreKZe+/2YBTgB8tnI077dYKV6FXTt2IwBooGzEKB18LNULhLrtUrjtulZ8psWm/RdXt4dtdOCt9e6Vf1aIVht2pdQcGmo+dt0nam/uDT7pCjG/7wBwIQpLTujKgBwDIwMNNuK4l+zckYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215583; c=relaxed/simple;
	bh=GMRPI97U1Hug2kQvBLIECMIBNRKCRkXiOj7Sxd7X3sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjWxJHpzcAAHfoFKl1Oy1SMNaIT7gYRVxyzLyS0LrFZWMFAEjkQnJ+usYa/jqOvc3i/WDX8O6ZA58XLW7ThyY6hJCBn9GklUoJMhHY93bKPTf+1fBKz/EzUHsgbFicqh3LNsKLp8cr3mVZ4ecE77q5si2Te2nL+KIcSqTSGlMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3iIuENC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744215581; x=1775751581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMRPI97U1Hug2kQvBLIECMIBNRKCRkXiOj7Sxd7X3sE=;
  b=a3iIuENCBV1o1n2CXJWLnO4KeJU1RBltdme7EXw4mUojGqtLJgf/irMU
   DCMwhetekeXcYIBHUa/DGEJ1EogN/CrORomaXZ0zrYkd+y6JVxVOqhNeV
   xh14yhmrRRKoPAabhIeWGW6nmjOXBCTm+flyuNNjpBOvv+pn0boQ5wJif
   b7w40fBxl02KTkpYm35TtgDkcL3zNpvH3TU3vK0PJvjulIR7zODKsGPKo
   E5ftyIseIqu8BL/zUSnqlAmvpAVUl1BI3a79mLeOwXtaKyEwNrGq2tgFy
   egj+B2JMN/0Py9Sr68AV2C4uV8bz4ERYeRg0eIWNSYixdBls6IHp7Gl1v
   A==;
X-CSE-ConnectionGUID: KlisvDznT06Xue1LnxzkSg==
X-CSE-MsgGUID: pDyRfE04RuSpe/Srmfq/0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56685533"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="56685533"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:19:39 -0700
X-CSE-ConnectionGUID: kKlx20ezQeaAJHLpSUMu+g==
X-CSE-MsgGUID: mzE2yxYSR968/PbENHSlnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129468522"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:19:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2Y9C-0000000AnBH-3u8U;
	Wed, 09 Apr 2025 19:19:30 +0300
Date: Wed, 9 Apr 2025 19:19:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com,
	tgamblin@baylibre.com, alisadariana@gmail.com,
	antoniu.miclaus@analog.com, eblanc@baylibre.com,
	jstephan@baylibre.com, matteomartelli3@gmail.com,
	angelogioacchino.delregno@collabora.com, herve.codina@bootlin.com,
	marcelo.schmitt@analog.com, chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com, yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <Z_aeEuIk9brES6dM@smile.fi.intel.com>
References: <20250409012351.2543450-1-j2anfernee@gmail.com>
 <20250409012351.2543450-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409012351.2543450-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 09:23:51AM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and all the threshold values could be set for
> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

...

> +#define NCT7201_VIN_MAX				12

Is this in volts? Can you add a unit suffix?

...

> +#define NCT7201_IN_SCALING				4995

Interesting number, just want to confirm it's indeed 4995 and not 4095.

...

> +static int nct7201_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	unsigned int value;
> +	int err;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;

> +	if (dir == IIO_EV_DIR_FALLING) {
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +				  &value);
> +		if (err < 0)
> +			return err;
> +	} else {
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +				  &value);
> +		if (err < 0)
> +			return err;
> +	}

	if (dir == IIO_EV_DIR_FALLING) {
		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
				  &value);
	} else {
		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
				  &value);
	}
	if (err)
		return err;

Here and elsewhere why ' < 0' is used? Do you expect positive return values
from those?

> +	*val = FIELD_GET(NCT7201_REG_VIN_MASK, value);
> +
> +	return IIO_VAL_INT;
> +}

...

> +static int nct7201_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);

> +	int  err = 0;

Useless assignment.

> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EOPNOTSUPP;
> +
> +	if (dir == IIO_EV_DIR_FALLING) {
> +		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
> +		if (err < 0)
> +			return err;
> +	} else {
> +		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;

	if (dir == IIO_EV_DIR_FALLING) {
		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
	} else {
		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
	}
	return err;


> +}

...

> +static int nct7201_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	unsigned int mask;
> +	int err;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	mask = BIT(chan->address);
> +
> +	if (state)
> +		chip->vin_mask |= mask;
> +	else
> +		chip->vin_mask &= ~mask;

> +	if (chip->num_vin_channels <= 8) {
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +				   chip->vin_mask);
> +		if (err < 0)
> +			return err;
> +	} else {
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +					&chip->vin_mask, sizeof(chip->vin_mask));
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;

Same as above.

> +}

...

> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	u8 data[2] = {0};

'0' is not needed. Shouldn't this be __le16 or __be16 instead?

> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			   NCT7201_BIT_CONFIGURATION_RESET);
> +	if (err < 0)
> +		return dev_err_probe(&chip->client->dev, -EIO,

	struct device *dev = &chip->client->dev;

at the top of the function will help a lot in tiding up the below code.

Shadowed error code, why?

> +				     "Failed to write NCT7201_REG_CONFIGURATION\n");
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then the Power
> +	 * Up bit will be set to 1. If not, wait for it.
> +	 */
> +	mdelay(25);

No sleep? Why? Can't you use fsleep()?

> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err < 0)
> +		return err;
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(&chip->client->dev, -EIO,

Shadowed error code, why?

> +				     "Failed to power up after reset\n");
> +
> +	/* Enable Channel */
> +	if (chip->num_vin_channels <= 8) {
> +		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, data[0]);
> +		if (err < 0)
> +			return dev_err_probe(&chip->client->dev, -EIO,

Why error code is shadowed?

> +					     "Failed to write NCT7201_REG_CHANNEL_ENABLE_1\n");
> +	} else {
> +		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> +		data[1] = NCT7201_REG_CHANNEL_ENABLE_2_MASK;
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +					data, ARRAY_SIZE(data));
> +		if (err < 0)
> +			return dev_err_probe(&chip->client->dev, -EIO,

Ditto.

> +					     "Failed to write NCT7201_REG_CHANNEL_ENABLE_1 and NCT7201_REG_CHANNEL_ENABLE_2\n");
> +	}

Just make it 16-bit type, define one value and use just simple English
in the error message: "Failed to write channel enable mask\n");

Same to all your error messages.

> +	chip->vin_mask = get_unaligned_le16(data);
> +
> +	/* Start monitoring if needed */
> +	err = regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &value);
> +	if (err < 0)
> +		return dev_err_probe(&chip->client->dev, -EIO,
> +				     "Failed to read NCT7201_REG_CONFIGURATION\n");

> +	regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION, NCT7201_BIT_CONFIGURATION_START);

> +	return 0;

No error check? Why?

> +}

...

> +static int nct7201_probe(struct i2c_client *client)
> +{
> +	const struct nct7201_adc_model_data *model_data;

	struct device *dev = &client->dev;

> +	struct nct7201_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	model_data = i2c_get_match_data(client);
> +	if (!model_data)
> +		return -EINVAL;

ENODEV is more suitable here.

> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	chip = iio_priv(indio_dev);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &nct7201_regmap8_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> +				     "Failed to init regmap\n");
> +
> +	chip->regmap16 = devm_regmap_init_i2c(client, &nct7201_regmap16_config);
> +	if (IS_ERR(chip->regmap16))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap16),
> +				     "Failed to init regmap16\n");
> +
> +	chip->num_vin_channels = model_data->num_vin_channels;

> +	chip->client = client;

How exactly is _client_ used elsewhere? Shouldn't it be just a struct device
pointer?

> +	ret = nct7201_init_chip(chip);
> +	if (ret < 0)

Do you expect positive returned values? What is their meaning?
Why do you skip them?

> +		return ret;
> +
> +	indio_dev->name = model_data->model_name;
> +	indio_dev->channels = model_data->channels;
> +	indio_dev->num_channels = model_data->num_channels;
> +	if (client->irq)
> +		indio_dev->info = &nct7201_info;
> +	else
> +		indio_dev->info = &nct7201_info_no_irq;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



