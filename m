Return-Path: <linux-iio+bounces-182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B36C7F129A
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 13:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232732825CE
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923A18C0A;
	Mon, 20 Nov 2023 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3K6M8XG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E07198;
	Mon, 20 Nov 2023 04:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700481747; x=1732017747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LHATOhiUEv+9zQmXWeZtqjxEFnK/mU/QuxdGD/KF4Ic=;
  b=X3K6M8XGhcw8nCTNu3x6eXdvXIdUYObu9GNzZM4ViIGy2NCjWfRirCAm
   2VfbB085wqw+hcHQZXr1fsxTrV+igQR6aXjAX0F6R0BnEIHYZw5/+Lq1E
   mbEd0B5VsN7OK3uGtqkaVCg4uHtxTejMWXWh7AfHVVcdFhL/LT8zLxEWM
   81gC5yvdYhioHbr6yV1xwAL1+fR5/ff2LOYBEfKgJjOvhrJVOwDguX/iQ
   lzLihsYfl6gywZowJoBi4HTf53qQ7LODGgJ3286MAs041xevphnVSJA4z
   45VWPWV0P1nVkrSIO4TzdnI2oskRSZaNZsbAM7D3W+PRffaaL2Yw+kIcd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455929940"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="455929940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:02:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="832250026"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="832250026"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:02:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r52yn-0000000FXc9-0fcp;
	Mon, 20 Nov 2023 14:02:17 +0200
Date: Mon, 20 Nov 2023 14:02:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <ZVtKyPvYHgg61JFG@smile.fi.intel.com>
References: <20231119212515.54001-1-marex@denx.de>
 <20231119212515.54001-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119212515.54001-2-marex@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 19, 2023 at 10:24:35PM +0100, Marek Vasut wrote:
> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.

...

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>

This is incomplete.

At least array_size.h, bits.h, cleanup.h, types.h are missing.

...

> +#define ISL76682_ADC_MAX			0xffff

Wouldn't the (BIT(16) - 1) be better in order to show that this is limited by
a bit field capacity. Also you can use FIELD_MAX().

...

> +static int isl76682_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);

> +	int ret = -EINVAL;

This is less maintainable, use it directly (see below).
Ah, the value is even not used!

> +	int i;
> +
> +	if (chan->type != IIO_LIGHT && chan->type != IIO_INTENSITY)
> +		return -EINVAL;
> +
> +	guard(mutex)(&chip->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = isl76682_get(chip, false, val);
> +			return (ret < 0) ? ret : IIO_VAL_INT;
> +		case IIO_INTENSITY:
> +			ret = isl76682_get(chip, true, val);
> +			return (ret < 0) ? ret : IIO_VAL_INT;
> +		default:

> +			break;

			return -EINVAL;

> +		}
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
> +			if (chip->range != isl76682_range_table[i].range)
> +				continue;
> +
> +			*val = 0;

...

> +			if (chan->type == IIO_LIGHT)
> +				*val2 = isl76682_range_table[i].als;
> +			else if (chan->type == IIO_INTENSITY)
> +				*val2 = isl76682_range_table[i].ir;
> +			else
> +				return -EINVAL;

Why not switch-case for consistency's sake?

> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = ISL76682_INT_TIME_US;
> +		return IIO_VAL_INT_PLUS_MICRO;

> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;

Move it to default.

> +}

...

> +static int illuminance_scale_available[] = {
> +	0, 15000,
> +	0, 60000,
> +	0, 240000,
> +	0, 960000

Leave trailing comma as it's not a terminator and will be an additional burden
if this list is going to be expanded in the future.

> +};
> +
> +static int intensity_scale_available[] = {
> +	0, 10500,
> +	0, 42000,
> +	0, 168000,
> +	0, 673000

Ditto.

> +};

...

> +static int isl76682_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type,
> +			       int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_LIGHT) {
> +			*vals = illuminance_scale_available;
> +			*length = ARRAY_SIZE(illuminance_scale_available);
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		} else if (chan->type == IIO_INTENSITY) {
> +			*vals = intensity_scale_available;
> +			*length = ARRAY_SIZE(intensity_scale_available);
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		}
> +		return -EINVAL;

Same Q: why not switch-case?

> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = integration_time_available;
> +		*length = ARRAY_SIZE(integration_time_available);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;

> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;

Move it to default.

> +}

...

> +static int isl76682_clear_configure_reg(struct isl76682_chip *chip)
> +{
> +	struct device *dev = regmap_get_device(chip->regmap);
> +	int ret;
> +
> +	ret = regmap_write(chip->regmap, ISL76682_REG_COMMAND, 0x0);
> +	if (ret < 0)
> +		dev_err(dev, "Error %d clearing the CONFIGURE register\n", ret);

> +	chip->command = 0;

Even in an error case? Is it a problem?

> +	return ret;
> +}

...

> +static void isl76682_reset_action(void *data)
> +{
> +	isl76682_clear_configure_reg((struct isl76682_chip *)data);

Redundant casting, just name the field as you line, seems "chip" is what being
used elsewhere.

> +}

...

> +	i2c_set_clientdata(client, indio_dev);

How is this being used?

...

> +	chip->regmap = devm_regmap_init_i2c(client, &isl76682_regmap_config);
> +	if (IS_ERR(chip->regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(chip->regmap),
> +				     "Error initializing regmap\n");
> +	}

Redundant {}

Also can be rewritten as

	chip->regmap = devm_regmap_init_i2c(client, &isl76682_regmap_config);
	ret = PTR_ERR_OR_ZERO(chip->regmap);
	if (ret)
		return dev_err_probe(dev, ret, "Error initializing regmap\n");

...

> +static const struct i2c_device_id isl76682_id[] = {
> +	{"isl76682", 0},

Unneeded 0.

> +	{}
> +};

...

> +static const struct of_device_id isl76682_of_match[] = {
> +	{ .compatible = "isil,isl76682", },
> +	{ },

Remove comma from the terminator.

> +};

...

> +

Redundant blank line.

> +module_i2c_driver(isl76682_driver);

-- 
With Best Regards,
Andy Shevchenko



