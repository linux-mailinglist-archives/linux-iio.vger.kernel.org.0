Return-Path: <linux-iio+bounces-15447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56127A32868
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 15:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0146A1615F5
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F221018D;
	Wed, 12 Feb 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YItEj+7U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9820FAB6;
	Wed, 12 Feb 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370533; cv=none; b=C3Q2Tzl/SSlL13s4/OMLReJItfhBs4H/juyPbdOTGCgv7Ga/JB1rBRrYLPsef3XhXBUevw/g6KuEJOKjwEFsJ7H8l9vQR+0Qo4K7fMRk4Q9BDGXH5UfjXwVas93wMprYJEZsp3g6+bGZa2fYmDV0cAabPAxHaybcLY8XMl9jePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370533; c=relaxed/simple;
	bh=DH+nudXgdQmFf7v7VHtcCDPot/KT90y0NSlnuZU7Hws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5Pmr3yxHhC5zBqzv9/jP+rD45LBbzHD34sEny8OKmb1E/TC4LQ+OZqERXkkh9HcS93AJITowNgEhjKY/4Xq2HqNHlZiSmP60IaBYi/2E0D+R9K6nN6eUYNy0dgkWUzpTZ6BLNqZahuZRtP7LmAy7DRXBZUpXcA3IDeBUKOTio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YItEj+7U; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739370531; x=1770906531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DH+nudXgdQmFf7v7VHtcCDPot/KT90y0NSlnuZU7Hws=;
  b=YItEj+7UN3rydGsJqdGkKGk5WYUYAipR73KfxukecfRkSGTYfwXcevqe
   Yw6/Ye4hiOZFVR6b4keSxTBjNl7508n5Dd6s2pm+/W5sqvKRMX62Tnfyf
   kSi+J9DtdioE/0gCc+aaL+iQ1Smwjgly5zO+0r4i2p56CuwheKGCXmFDN
   6NFKgmFruh0VGtaaiDIXIf9AxGW4RXdpx5VhouiD1HVJ10CHlMrC8U8PC
   /8Lh/no0Xqszi//BMq+HvRlMUh2DIcBQyySDyYiOX0sa4/XEDiXFqqEtT
   B0ZD+cq++LlshnAQQdqYz8MpD/ROJ5tzMYefISXW4r0l8lQxDL3QT5cwq
   w==;
X-CSE-ConnectionGUID: sw0PxgMXT4WJ4wnpkEcqTg==
X-CSE-MsgGUID: 8bWslBGUTyi7yXTLXsq/Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43792658"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="43792658"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:28:50 -0800
X-CSE-ConnectionGUID: 3j3aYGkWR7eU42Rw7YhPvQ==
X-CSE-MsgGUID: dqGyEoynR16Y5YmAM3bSAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112819648"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:28:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiDjG-0000000ArLK-22Fe;
	Wed, 12 Feb 2025 16:28:42 +0200
Date: Wed, 12 Feb 2025 16:28:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <Z6ywGgofzU1bvm0H@smile.fi.intel.com>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212064657.5683-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 08:46:56AM +0200, Svyatoslav Ryhel wrote:
> AL3000a is a simple I2C-based ambient light sensor, which is
> closely related to AL3010 and AL3320a, but has significantly
> different hardware configuration.

(Note, the part of the below comments are applicable to your other series)

...

> +/*
> + * AL3000a - Dyna Image Ambient Light Sensor
> + */

Can be on a single line.

...

> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

No of*.h in the new code, please.

> +#include <linux/regulator/consumer.h>

Too small headers to be included. You use much more.


> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

...

> +/*
> + * This are pre-calculated lux values based on possible output
> + * of sensor (range 0x00 - 0x3F)
> + */

types.h

> +static const u32 lux_table[64] = {

I think you don't need 64 to be there, but okay, I understand the intention.

> +	1, 1, 1, 2, 2, 2, 3, 4, 4, 5, 6, 7, 9, 11, 13, 16,

For the better readability and maintenance put pow-of-2 amount of values per
line, like 8, and add the respective comment:

	1, 1, 1, 2, 2, 2, 3, 4,					/*  0 -  7 */
	4, 5, 6, 7, 9, 11, 13, 16,				/*  8 - 15 */

> +	19, 22, 27, 32, 39, 46, 56, 67, 80, 96, 116, 139,
> +	167, 200, 240, 289, 347, 416, 499, 600, 720, 864,
> +	1037, 1245, 1495, 1795, 2155, 2587, 3105, 3728,	4475,
> +	5373, 6450, 7743, 9296, 11160, 13397, 16084, 19309,
> +	23180, 27828, 33408, 40107, 48148, 57803, 69393,
> +	83306, 100000

Leave trailing comma, it's not a terminated list generally speaking
(in the future it might grow).

> +};

...

> +struct al3000a_data {
> +	struct i2c_client *client;

	struct regmap *map;

will suffice, I believe, see below.


> +	struct regulator *vdd_supply;
> +};

...

> +static const struct iio_chan_spec al3000a_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),

> +	}

Leave trailing comma

> +};

...

> +static int al3000a_set_pwr(struct al3000a_data *data, bool pwr)
> +{
> +	struct device *dev = &data->client->dev;
> +	u8 val = pwr ? AL3000A_CONFIG_ENABLE : AL3000A_CONFIG_DISABLE;
> +	int ret;
> +
> +	if (pwr) {
> +		ret = regulator_enable(data->vdd_supply);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable vdd power supply\n");
> +			return ret;

With struct regmap *map in mind, the struct device *dev can be derived using
the respective API.

> +		}
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, AL3000A_REG_SYSTEM, val);

Why not using regmap I²C APIs?

> +	if (ret < 0) {
> +		dev_err(dev, "failed to write system register\n");
> +		return ret;
> +	}
> +
> +	if (!pwr) {
> +		ret = regulator_disable(data->vdd_supply);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to disable vdd power supply\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

...

> +static int al3000a_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct al3000a_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

> +		ret = i2c_smbus_read_byte_data(data->client,
> +					       AL3000A_REG_DATA);

It may be a single line. There is a lot of room.

> +		if (ret < 0)
> +			return ret;
> +
> +		*val = lux_table[ret & 0x3F];

I believe you want to define the size of that table and use it here.
Also this needs a comment to explain the meaning of the ret >= 64 and
when it may happen.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +
> +		return IIO_VAL_INT;

> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;

Return directly from the default case.

> +}

...

> +static int al3000a_probe(struct i2c_client *client)
> +{
> +	struct al3000a_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;

	struct device *dev = &client->dev;

will make the below lines shorter and easier to read.


> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "failed to get vdd regulator\n");

err.h

> +	indio_dev->info = &al3000a_info;
> +	indio_dev->name = AL3000A_DRV_NAME;
> +	indio_dev->channels = al3000a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(al3000a_channels);

array_size.h

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = al3000a_init(data);
> +	if (ret < 0)

> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to init ALS\n");

Single line.

> +	ret = devm_add_action_or_reset(&client->dev, al3000a_set_pwr_off,
> +				       data);

Ditto.

device.h

> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to add action\n");
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

...

> +static const struct of_device_id al3000a_of_match[] = {

mod_devicetable.h

> +	{ .compatible = "dynaimage,al3000a" },
> +	{ /* sentinel */ }
> +};

...

> +static struct i2c_driver al3000a_driver = {
> +	.driver = {
> +		.name = AL3000A_DRV_NAME,
> +		.of_match_table = al3000a_of_match,

> +		.pm = pm_sleep_ptr(&al3000a_pm_ops),

pm.h

> +	},
> +	.probe = al3000a_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko



