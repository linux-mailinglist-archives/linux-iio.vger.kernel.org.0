Return-Path: <linux-iio+bounces-13822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD19FD41A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35D81883E9F
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E51F130F;
	Fri, 27 Dec 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNhGR+uW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC779CD;
	Fri, 27 Dec 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301694; cv=none; b=BaUVeOtQh4lNJPJJrpklK7Vc6/GK+Q5ISlhjOKi/iFU1j0o7+W5Y3g1evDJ8scD9srrZ9ACnincmB0ydf65NTuII11TO29Ww9CoHdidB7r5G8khDZDp4P68CS1r9r865eZqsar20z3XTMXoeWnr58CPufw1Fvyktsi5q1PE1I0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301694; c=relaxed/simple;
	bh=MS4p1AYx5z/BuPVHhOc4WQ7xPgnZi276DtZgh2XwMj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9uycM3fYCFLT1JnZbyKuH0+ZUG25tjQ8KIyYGxBV1XE4hbRj1V5UUdAHANgK1EvcD2HKm136XV8VECn3c3TFRIGI9iyk/jQ0N/v2yBvl/d6WQVIkYO62eKY4kB8BAjInfL0i/6s3ExHHYfzzI6UKgjHiFQAsxgihmzp8v1Ul7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNhGR+uW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735301693; x=1766837693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MS4p1AYx5z/BuPVHhOc4WQ7xPgnZi276DtZgh2XwMj8=;
  b=gNhGR+uWN4ggBlZwxwrwRb4gCl5XeA3FEYPsvP5QO6RlNPqgvoW5XfhG
   3ZsWp6tebHGvJ5GNpyHMxulzzBzrRaeV+9BxMlZfumhuRxLQvwU9Ngi60
   OZYGkKO5RsQSUo5JNHMgk05iSLheHu52rkw02yOvb35vRI/9rE0tpYHh6
   JyNUVLgz3k6wuO1zAkmvB78KTJjC0jZSNEIM66985yqBpC1nxvbdfQoVe
   6F8lbVIuo4R8mRSUeh0nyYGSkNeRdyODpozZ0rz4hAQ/IJKKtNnkMW/sg
   ZpqrM+TJ1b+sRcD1CK/Ndpk4uoYkN9lmx/Dwb63AdT/HiQ/LXFQFMPHE8
   A==;
X-CSE-ConnectionGUID: 2fIWBZA+TdqzLol8SspMHQ==
X-CSE-MsgGUID: 4/V8OCkhRjWc3acoPQSCPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11298"; a="46198499"
X-IronPort-AV: E=Sophos;i="6.12,269,1728975600"; 
   d="scan'208";a="46198499"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 04:14:52 -0800
X-CSE-ConnectionGUID: hHBMYqQmSwGviEjJjzQ20w==
X-CSE-MsgGUID: xZ02nZBhSkmUJ2133X6WrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123427753"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 04:14:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tR9Eo-0000000CwuN-0Uxy;
	Fri, 27 Dec 2024 14:14:42 +0200
Date: Fri, 27 Dec 2024 14:14:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com, tgamblin@baylibre.com,
	matteomartelli3@gmail.com, alisadariana@gmail.com,
	gstols@baylibre.com, thomas.bonnefille@bootlin.com,
	herve.codina@bootlin.com, chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com, yhyang2@nuvoton.com, openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add Nuvoton NCT7201 ADC driver
Message-ID: <Z26aMVayh-EdYA8n@smile.fi.intel.com>
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
 <20241226055313.2841977-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226055313.2841977-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 26, 2024 at 01:53:13PM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and the all threshold values could be set for
> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events support.

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN(chan->address), &value);
> +		if (err < 0)
> +			return err;
> +		volt = value;

> +		*val = volt >> 3;

I am not sure I understand this. If it's a shifted field, you rather
should fix it by using FIELD_*() macros from bitfield.h, otherwise
it's even more confusing.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* From the datasheet, we have to multiply by 0.0004995 */
> +		*val = 0;
> +		*val2 = 499500;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}

...

> +	*val = volt >> 3;

Ditto.


...

> +	v1 = val >> 5;
> +	v2 = FIELD_PREP(NCT7201_REG_VIN_LIMIT_LSB_MASK, val) << 3;

Ditto.

> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info == IIO_EV_INFO_VALUE) {
> +		guard(mutex)(&chip->access_lock);
> +		if (dir == IIO_EV_DIR_FALLING) {
> +			regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LIMIT(chan->address), v1);
> +			regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LIMIT_LSB(chan->address), v2);
> +		} else {
> +			regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_LIMIT(chan->address), v1);
> +			regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_LIMIT_LSB(chan->address), v2);
> +		}

This needs a comment why regmap_bulk_write() can't be used.

> +	}

...

> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	u8 data[2];
> +	unsigned int value;
> +	int err;
> +
> +	regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +		     NCT7201_BIT_CONFIGURATION_RESET);

No error check?

> +	/*
> +	 * After about 25 msecs, the device should be ready and then
> +	 * the Power Up bit will be set to 1. If not, wait for it.
> +	 */
> +	mdelay(25);
> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err < 0)
> +		return err;
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(&chip->client->dev, -EIO, "failed to power up after reset\n");
> +
> +	/* Enable Channel */
> +	guard(mutex)(&chip->access_lock);
> +	regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +		     NCT7201_REG_CHANNEL_ENABLE_1_MASK);
> +	if (chip->num_vin_channels == 12)
> +		regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
> +			     NCT7201_REG_CHANNEL_ENABLE_2_MASK);
> +
> +	err = regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, &value);
> +	if (err < 0)
> +		return err;
> +	data[0] = value;
> +
> +	err = regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2, &value);
> +	if (err < 0)
> +		return err;
> +	data[1] = value;
> +
> +	value = get_unaligned_le16(data);
> +	chip->vin_mask = value;
> +
> +	/* Start monitoring if needed */
> +	err = regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &value);
> +	if (err < 0) {

> +		dev_err_probe(&chip->client->dev, -EIO, "Failed to read REG_CONFIGURATION\n");
> +		return value;

You already used

	return dev_err_probe(...);

above, why here it's different? You want return something in addition to the
error code? Why?

> +	}
> +
> +	value |= NCT7201_BIT_CONFIGURATION_START;
> +	regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION, value);
> +
> +	return 0;
> +}

...

> +static const struct regmap_config nct7201_regmap8_config = {
> +	.name = "vin-data-read-byte",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0xff,
> +};
> +
> +static const struct regmap_config nct7201_regmap16_config = {
> +	.name = "vin-data-read-word",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = 0xff,
> +};

I don't see how these configurations will prevent, e.g., debugfs to access
16-bit registers via 8-bit IO and vice versa.

-- 
With Best Regards,
Andy Shevchenko



