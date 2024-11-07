Return-Path: <linux-iio+bounces-11968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F49BFF8C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 09:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50457B22441
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251171993BA;
	Thu,  7 Nov 2024 08:03:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638D18755C;
	Thu,  7 Nov 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966589; cv=none; b=uRGEBwLWFTYhLGQ0zsytV9WtlW9TcR44WStYh6XbrYUH2JcJOO8W0nRiCnS2QD08WqvDCUxuldjQdK3kfdpFpx6mMyocTRkEhckiPDYSYxAFX8xY15NYaOUClX29TDhQ0FkYh9gyeGeyIs5kZlTLwwKr4rWrspU3QHdABRXSCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966589; c=relaxed/simple;
	bh=GMCRBsPlCG3NHpyjnxN9HDh7uGYoD79/nXmVNHNC0U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKBwAHMXiRZHgi12IfHaO3LnQiKkm4itwLMNy1BJcZQ7crJkKk2kTrMF3N6EzhHsxX3J6LmQCjAWPOyS4P4NVLvUN/IXB/fXQkxZx8uAWmZf3fIPDd9j66CFSS6jGnh9q/M8S62h37CD+gucIIpaGXnHEKNhR5Mb2OuGWcqzg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: wjgcLk7MTkqm8ZAd5tx1zg==
X-CSE-MsgGUID: H/iLhGNlR72rDJmWMBRAcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48257270"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48257270"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 00:03:06 -0800
X-CSE-ConnectionGUID: 5h+UXdPiS5WFMzz3OA/8tQ==
X-CSE-MsgGUID: S5OkdE2NT9Kakrxuj8tt/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="84533901"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 00:02:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t8xTN-0000000CB5t-3cBC;
	Thu, 07 Nov 2024 10:02:33 +0200
Date: Thu, 7 Nov 2024 10:02:33 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com,
	alisadariana@gmail.com, joao.goncalves@toradex.com,
	marius.cristea@microchip.com, mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <Zyx0GUudmSui8Y2I@smile.fi.intel.com>
References: <20241106023916.440767-1-j2anfernee@gmail.com>
 <20241106023916.440767-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106023916.440767-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 06, 2024 at 10:39:16AM +0800, Eason Yang wrote:
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

> + * Copyright (c) 2022 Nuvoton Inc.

2024?

...

+ array_size.h
+ bits.h

> +#include <linux/delay.h>
> +#include <linux/device.h>

+ err.h

> +#include <linux/i2c.h>

> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Move these to be a separate group...

> +#include <linux/init.h>

+ mod_devicetable.h

> +#include <linux/module.h>
> +#include <linux/mutex.h>

+ types.h

...somewhere here after a blank line.

...

> +static const u8 REG_VIN[VIN_MAX] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
> +				     0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B};

Better to have it done like this

static const u8 REG_VIN[VIN_MAX] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,	/* 0 - 7 */
	0x08, 0x09, 0x0A, 0x0B,				/* 8 - 11 */
};

Note the following: the values are placed on separate lines with trailing
commas on each line and with grouping by powwer-of-2 per line.

> +static const u8 REG_VIN_HIGH_LIMIT[VIN_MAX] = { 0x20, 0x22, 0x24, 0x26, 0x28, 0x2A,
> +						0x2C, 0x2E, 0x30, 0x32, 0x34, 0x36};
> +static const u8 REG_VIN_LOW_LIMIT[VIN_MAX] = { 0x21, 0x23, 0x25, 0x27, 0x29, 0x2B,
> +					       0x2D, 0x2F, 0x31, 0x33, 0x35, 0x37};
> +static const u8 REG_VIN_HIGH_LIMIT_LSB[VIN_MAX] = { 0x40, 0x42, 0x44, 0x46, 0x48, 0x4A,
> +						    0x4C, 0x4E, 0x50, 0x52, 0x54, 0x56};
> +static const u8 REG_VIN_LOW_LIMIT_LSB[VIN_MAX] = { 0x41, 0x43, 0x45, 0x47, 0x49, 0x4B,
> +						   0x4D, 0x4F, 0x51, 0x53, 0x55, 0x57};
> +static u8 nct720x_chan_to_index[] = {
> +	0,	/* Not used */
> +	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
> +};

Ditto for the above initialisers.

> +
> +

One blank line is enough.

> +/* List of supported devices */
> +enum nct720x_chips {
> +	nct7201, nct7202

Leave trailing comma.

> +};

...

> +/* Read 1-byte register. Returns unsigned byte data or -ERRNO on error. */
> +static int nct720x_read_reg(struct nct720x_chip_info *chip, u8 reg)
> +{
> +	struct i2c_client *client = chip->client;
> +
> +	return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +/* Read 1-byte register. Returns unsigned word data or -ERRNO on error. */
> +static int nct720x_read_word_swapped_reg(struct nct720x_chip_info *chip, u8 reg)
> +{
> +	struct i2c_client *client = chip->client;
> +
> +	return i2c_smbus_read_word_swapped(client, reg);
> +}
> +
> +/*
> + * Read 2-byte register. Returns register in big-endian format or
> + * -ERRNO on error.
> + */
> +static int nct720x_read_reg16(struct nct720x_chip_info *chip, u8 reg)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret, low;

> +	mutex_lock(&chip->access_lock);

If you are going with this, use cleanup.h.

> +	ret = i2c_smbus_read_byte_data(client, reg);
> +	if (ret >= 0) {
> +		low = ret;
> +		ret = i2c_smbus_read_byte_data(client, reg + 1);
> +		if (ret >= 0)
> +			ret = low | (ret << 8);

Hmm... Does it require to have two separate transactions? In case of regmap,
can't bulk transfer be performed for that?

> +	}
> +
> +	mutex_unlock(&chip->access_lock);
> +	return ret;
> +}

I have no explanations why regmap I2C can't be used.

...

> +/* Write 1-byte register. Returns 0 or -ERRNO on error. */
> +static int nct720x_write_reg(struct nct720x_chip_info *chip, u8 reg, u8 val)
> +{
> +	struct i2c_client *client = chip->client;
> +	int err;
> +
> +	err = i2c_smbus_write_byte_data(client, reg, val);
> +	/* wait for write command to be finished */

Is there any justification for the chosen value (I mean datasheet
recommendations or so)?

> +	mdelay(10);
> +
> +	return err;
> +}

...

> +static int nct720x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	int index = nct720x_chan_to_index[chan->address];
> +	int v1, v2, volt, err;
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		mutex_lock(&chip->access_lock);
> +		if (chip->use_read_byte_vin) {
> +			/*
> +			 * MNTVIN Low Byte together with MNTVIN High Byte
> +			 * forms the 13-bit count value. If MNTVIN High
> +			 * Byte readout is read successively, the
> +			 * NCT7201/NCT7202 will latch the MNTVIN Low Byte
> +			 * for next read.
> +			 */
> +			v1 = nct720x_read_reg(chip, REG_VIN[index]);
> +			if (v1 < 0) {
> +				err = v1;
> +				goto abort;
> +			}
> +
> +			v2 = nct720x_read_reg(chip, REG_VOLT_LOW_BYTE);
> +			if (v2 < 0) {
> +				err = v2;
> +				goto abort;
> +			}
> +			volt = (v1 << 8) | v2;	/* Convert back to 16-bit value */

Hmm... I would expect volt to be __be16, but since you have two separate reads
it's probably fine.

> +		} else {
> +			/* NCT7201/NCT7202 also supports read word-size data */
> +			volt = nct720x_read_word_swapped_reg(chip, REG_VIN[index]);
> +		}
> +
> +		/* Voltage(V) = 13bitCountValue * 0.0004995 */
> +		volt = (volt >> 3) * NCT720X_IN_SCALING;
> +		*val = volt / 10000;
> +		mutex_unlock(&chip->access_lock);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +abort:
> +	mutex_unlock(&chip->access_lock);
> +	return err;

Yeah, this will gone with cleanup.h in use.
Ditto for all other places like this.

> +}

...

> +{
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +	int index, err = 0;
> +	long v1, v2, volt;

Why long? Wouldn't int / unsigned int suffice for v1 / v2?

> +
> +	index = nct720x_chan_to_index[chan->address];
> +	volt = (val * 10000) / NCT720X_IN_SCALING;

Please, use named constant for 10000 as you used it at least twice in the code.

> +	v1 = volt >> 5;
> +	v2 = (volt & 0x1f) << 3;

In the similar way it seems like some endianess and bit width manipulations.

Can v be an array of u8:s which you just fill with put_unaligned_be16() or so?

> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info == IIO_EV_INFO_VALUE) {
> +		if (dir == IIO_EV_DIR_FALLING) {
> +			mutex_lock(&chip->access_lock);
> +			err = nct720x_write_reg(chip, REG_VIN_LOW_LIMIT[index], v1);
> +			if (err < 0) {
> +				pr_err("Failed to write REG_VIN%d_LOW_LIMIT\n", index + 1);
> +				goto abort;
> +			}
> +
> +			err = nct720x_write_reg(chip, REG_VIN_LOW_LIMIT_LSB[index], v2);
> +			if (err < 0) {
> +				pr_err("Failed to write REG_VIN%d_LOW_LIMIT_LSB\n", index + 1);
> +				goto abort;
> +			}
> +		} else {
> +			mutex_lock(&chip->access_lock);
> +			err = nct720x_write_reg(chip, REG_VIN_HIGH_LIMIT[index], v1);
> +			if (err < 0) {
> +				pr_err("Failed to write REG_VIN%d_HIGH_LIMIT\n", index + 1);
> +				goto abort;
> +			}
> +
> +			err = nct720x_write_reg(chip, REG_VIN_HIGH_LIMIT_LSB[index], v2);
> +			if (err < 0) {
> +				pr_err("Failed to write REG_VIN%d_HIGH_LIMIT_LSB\n", index + 1);
> +				goto abort;
> +			}
> +		}
> +	}
> +abort:
> +	mutex_unlock(&chip->access_lock);
> +	return err;
> +}

...

> +	strscpy(info->type, "nct720x", I2C_NAME_SIZE);

Use 2-argument strscpy().

...

> +static const struct i2c_device_id nct720x_id[];

Remove this. It's not needed.

...

> +static int nct720x_init_chip(struct nct720x_chip_info *chip)
> +{

> +	int value = 0;

Why signed?

> +	int err = 0;


Redundant assignments.

> +	/* Initial reset */
> +	err = nct720x_write_reg(chip, REG_CONFIGURATION, CONFIGURATION_INIT);
> +	if (err) {
> +		pr_err("Failed to write REG_CONFIGURATION\n");
> +		return err;
> +	}
> +
> +	/* Enable Channel */
> +	err = nct720x_write_reg(chip, REG_CHANNEL_ENABLE_1, 0xff);

Magic 0xff.
Should be GENMASK() ? Anything else?

> +	if (err) {
> +		pr_err("Failed to write REG_CHANNEL_ENABLE_1\n");
> +		return err;
> +	}
> +
> +	if (chip->type == nct7202) {
> +		err = nct720x_write_reg(chip, REG_CHANNEL_ENABLE_2, 0xf);

Ditto.

> +		if (err) {
> +			pr_err("Failed to write REG_CHANNEL_ENABLE_2\n");
> +			return err;
> +		}
> +	}
> +
> +	value = nct720x_read_reg16(chip, REG_CHANNEL_ENABLE_1);
> +	if (value < 0)
> +		return value;
> +	chip->vin_mask = value;
> +
> +	/* Start monitoring if needed */
> +	value = nct720x_read_reg(chip, REG_CONFIGURATION);
> +	if (value < 0) {
> +		pr_err("Failed to read REG_CONFIGURATION\n");
> +		return value;
> +	}
> +
> +	value |= CONFIGURATION_START;
> +	err = nct720x_write_reg(chip, REG_CONFIGURATION, value);
> +	if (err < 0) {
> +		pr_err("Failed to write REG_CONFIGURATION\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}

...

> +	ret = of_property_read_u32(client->dev.of_node, "read-vin-data-size", &tmp);

No OF-centric APIs in a new code, please.
Use device_property_read_u32() and include property.h for that.

> +	if (ret < 0) {
> +		pr_err("read-vin-data-size property not found\n");
> +		return ret;
> +	}

...

> +	mutex_init(&chip->access_lock);

	ret = devm_mutex_init(...);

...

> +	/* this is only used for device removal purposes */
> +	i2c_set_clientdata(client, indio_dev);

Will be gone after removing ->remove().

...

> +	iio_device_register(indio_dev);

No error checks? In any case devm_ variant especially needs this.

> +	return 0;

	return devm_iio_device_register(...);

...

> +static const struct i2c_device_id nct720x_id[] = {
> +	{ "nct7201", nct7201 },
> +	{ "nct7202", nct7202 },

Please, use chip_info custom data structure instead of enum values.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, nct720x_id);
> +
> +static const struct of_device_id nct720x_of_match[] = {
> +	{
> +		.compatible = "nuvoton,nct7201",
> +		.data = (void *)nct7201
> +	},
> +	{
> +		.compatible = "nuvoton,nct7202",
> +		.data = (void *)nct7202

As per above and leave trailing commas.

> +	},
> +	{ },

Drop trailing comma in the terminator entries.

> +};

> +

Redundant blank line.

> +MODULE_DEVICE_TABLE(of, nct720x_of_match);
> +
> +static struct i2c_driver nct720x_driver = {
> +	.driver = {
> +		.name	= "nct720x",
> +		.of_match_table = nct720x_of_match,
> +	},
> +	.probe = nct720x_probe,
> +	.remove = nct720x_remove,
> +	.id_table = nct720x_id,
> +	.detect = nct720x_detect,
> +	.address_list = nct720x_address_list,
> +};

> +

Redundant blank line.

> +module_i2c_driver(nct720x_driver);

-- 
With Best Regards,
Andy Shevchenko



