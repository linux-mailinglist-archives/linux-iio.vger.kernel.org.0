Return-Path: <linux-iio+bounces-25867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAAAC30820
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680C74231C6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A75315D5A;
	Tue,  4 Nov 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5zN7B1r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23F52F88;
	Tue,  4 Nov 2025 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251931; cv=none; b=XMJPQw9R762d5PZHlLQBGGArQlGvLdEZAYymRKfJigsok22IOTBfoG30ho8RQZxkOEHISi86LSPpTCfdNJmGoocQPV25emBDdJzLesOo0sQqou35YIkLP6eiOdZaWiW29UEdzwOketavcIGC4mICoMkryBfeymACGX3Zfq+BZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251931; c=relaxed/simple;
	bh=kakEUcQSOtzSBqF6N8EkgPMI1HGiwG5u5+sMJW43HSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyprsmuKPSJTuedgd6Yna81hlOJqvTmPZ3T0NNYDNR2IwEZNAc7Shk/7K1rkTKR6uGRHy/LUJGrGPCejAOBDFnyI7z8kX6WWGFr5ytC60GpqV384s+43mxRWWnK3lJdoOraei3sfprXHhw10biEciSOPqT8VSQenpBpvG4OroAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5zN7B1r; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762251929; x=1793787929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kakEUcQSOtzSBqF6N8EkgPMI1HGiwG5u5+sMJW43HSU=;
  b=N5zN7B1rjvguu4Jfqh183T6Yuw8aZjA+xKU8q0EuTpQIgVGOU4OSrVay
   JaNtYzb3Lml7jRBhHN1WapPLv5onuT/DIjIrCZrFdXO0DgtEZYOYxsxyq
   kh3VYA1rfoJWG3O9k7ASdciD5+dcIkr0YP22qWQGA9zkU86a9nGdF083C
   BpBiFqBmhXX+7NJUEN0yLYp2eklUxtrbBfynG/tv2iFLTiDvnQ0aACySd
   KKzrF69u77/4TfLIk3co9HIcgXQmY2C+dZ1IkffEpYEE1vhij+3qIJ7BW
   vfyoP0kFvbqAQMJnI8ISSSr32YYhSmaQutGRD/vytlCGGdUD5XRs7/7l+
   w==;
X-CSE-ConnectionGUID: 896XM151S/az/ZzjcrQnyw==
X-CSE-MsgGUID: HoXCuAlZTHOcqbU4E/Ip8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64270962"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64270962"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 02:25:28 -0800
X-CSE-ConnectionGUID: w0ll2e/FTpWP11qlctlusg==
X-CSE-MsgGUID: izSN3QAdTeiOK2z0KyRO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="186979462"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 02:25:26 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGEE7-00000005QnX-2aZO;
	Tue, 04 Nov 2025 12:25:23 +0200
Date: Tue, 4 Nov 2025 12:25:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aQnUk4Inip8QQz6u@smile.fi.intel.com>
References: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
 <20251103-mcp47feb02-v2-2-8c37741bd97a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-mcp47feb02-v2-2-8c37741bd97a@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 05:50:30PM +0200, Ariana Lazar wrote:
> This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
> MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
> of buffered voltage output Digital-to-Analog Converters with nonvolatile or
> volatile memory and an I2C Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.

...

> +config MCP47FEB02
> +	tristate "MCP47F(E/V)B|(0/1/2)(1/2/4/8)DAC driver"

This is unreadable cryptic title. Make it more human-readable, like:

"Microchip MCP47F family of DAC driver"

> +	depends on I2C
> +	help
> +          Say yes here if you want to build a driver for the Microchip

Too many spaces, see how it's done elsewhere.

> +          MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
> +          MCP47FEB22, MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02,
> +          MCP47FVB12, MCP47FVB02, MCP47FVB12, MCP47FVB22, MCP47FVB04,
> +          MCP47FVB14, MCP47FVB24, MCP47FVB04, MCP47FVB08, MCP47FVB18,
> +          MCP47FVB28, MCP47FEB04, MCP47FEB14 and MCP47FEB24 having up to 8

This is also unreadable, please split to groups (by family species and/or bits)
and sort each group accordingly, like

	  - E-group (8-bit): MCP47FEB01, MCP47FEB11, MCP47FEB21
	  - E-group (10-bit): MCP47FEB02, MCP47FEB12, MCP47FEB22
	  ...

Note, I put a hypothetical text there, I haven't check this for the correctness!

> +          channels, 8-bit, 10-bit or 12-bit digital-to-analog converter (DAC)
> +          with I2C interface.
> +
> +          To compile this driver as a module, choose M here: the module
> +          will be called mcp47feb02.

...

> + * Datasheet for MCP47FEBXX can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
> + *
> + * Datasheet for MCP47FVBXX can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
> + *
> + * Datasheet for MCP47FXBX4/8 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf

Avoid duplicating information, so far it can be just listed as

 * Datasheet links:
 * 
 * [MCP47FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
 * [MCP47FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
 * [MCP47FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf

(also note xx instead of XX).

Or propose a better style.

...

> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

Missing includes. E.g., for 'bool', for 'ARRAY_SIZE()', for 'guard()()'.
Follow IWYU (Include What You Use) principle.

...

> +#define MCP47FEB02_DAC0_REG_ADDR			(0x00 << 3)

I assume it's the similar case as for below 0x10-0x17 range. Perhaps do both as
a macro with a parameter?

> +#define MCP47FEB02_VREF_REG_ADDR			(0x08 << 3)
> +#define MCP47FEB02_POWER_DOWN_REG_ADDR			(0x09 << 3)
> +#define MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR		(0x0A << 3)
> +#define MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR		(0x0B << 3)
> +
> +#define MCP47FEB02_NV_DAC0_REG_ADDR			(0x10 << 3)
> +#define MCP47FEB02_NV_DAC1_REG_ADDR			(0x11 << 3)
> +#define MCP47FEB02_NV_DAC2_REG_ADDR			(0x12 << 3)
> +#define MCP47FEB02_NV_DAC3_REG_ADDR			(0x13 << 3)
> +#define MCP47FEB02_NV_DAC4_REG_ADDR			(0x14 << 3)
> +#define MCP47FEB02_NV_DAC5_REG_ADDR			(0x15 << 3)
> +#define MCP47FEB02_NV_DAC6_REG_ADDR			(0x16 << 3)
> +#define MCP47FEB02_NV_DAC7_REG_ADDR			(0x17 << 3)
> +#define MCP47FEB02_NV_VREF_REG_ADDR			(0x18 << 3)
> +#define MCP47FEB02_NV_POWER_DOWN_REG_ADDR		(0x19 << 3)
> +#define MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR	(0x1A << 3)

Drop this << 3 part, just do it at run-time. Or embed them, by providing
shifted values. Also, there is special formats for regmap, perhaps that's what
you wanted to begin with? *Yes, it might need some code to be added into
drivers/base/regmap.c.

...

> +#define MCP47FEB02_INTERNAL_BAND_GAP_MV			2440

_MV --> _mV

...

> +#define MCP47FEB02_DELAY_1_MS				1000

Drop '_1' and use (1 * USEC_PER_MSEC) as value.

But looking at the code this makes the definition useless, just use values
directly there.

...

> +struct mcp47feb02_features {
> +	const char	*name;
> +	unsigned int	phys_channels;
> +	unsigned int	resolution;
> +	bool have_ext_vref1;
> +	bool have_eeprom;

Inconsistent style. Be consistent.

> +};

...

> +struct mcp47feb02_channel_data {
> +	enum vref_mode ref_mode;
> +	u8 powerdown_mode;
> +	bool use_2x_gain;
> +	bool powerdown;
> +	u16 dac_data;

Have you ran `pahole`? Please do, and amend the data types accordingly.

> +};

...

> +struct mcp47feb02_data {
> +	struct mcp47feb02_channel_data chdata[MCP47FEBXX_MAX_CH];
> +	int scale_1[MCP47FEB02_MAX_VALS_SCALES_CH];
> +	int scale[MCP47FEB02_MAX_VALS_SCALES_CH];
> +	const struct mcp47feb02_features *info;
> +	const char *labels[MCP47FEBXX_MAX_CH];
> +	unsigned long active_channels_mask;

> +	struct i2c_client *client;
> +	struct regmap *regmap;

Why both are needed?

> +	bool vref1_buffered;
> +	bool vref_buffered;
> +	u16 phys_channels;
> +	struct mutex lock; /* synchronize access to driver's state members */
> +	bool use_vref1;
> +	bool use_vref;
> +};

...

> +static ssize_t mcp47feb02_store_eeprom(struct device *dev, struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct mcp47feb02_data *data = iio_priv(dev_to_iio_dev(dev));
> +	int ret, i, val, val1, eewa_val;

Do you expect i to hold the signed value?

> +	bool state;
> +
> +	ret = kstrtobool(buf, &state);

> +	if (ret < 0)

Why ' < 0'?

> +		return ret;
> +
> +	if (!state)
> +		return 0;
> +
> +	/*
> +	 * Verify DAC Wiper and DAC Configuratioin are unlocked. If both are disabled,
> +	 * writing to EEPROM is available.
> +	 */
> +	ret = regmap_read(data->regmap, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val)  {
> +		dev_err(dev, "DAC Wiper and DAC Configuration not are unlocked.\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		ret = mcp47feb02_write_to_eeprom(data, i << 3, data->chdata[i].dac_data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(data->regmap, MCP47FEB02_VREF_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_VREF_REG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_POWER_DOWN_REG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR, eewa_val,
> +				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
> +				       MCP47FEB02_DELAY_1_MS, MCP47FEB02_DELAY_1_MS * 5);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR, &val1);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR,
> +					 (val1 & MCP47FEB02_VOLATILE_GAIN_BIT_MASK) |
> +					 (val & MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK));
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +

Blank line should go after IIO_DEVICE_ATTR()...

> +static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_eeprom, 0);

...here, also Why not IIO_DEVICE_ATTR_WO()?

> +static struct attribute *mcp47feb02_attributes[] = {
> +	&iio_dev_attr_store_eeprom.dev_attr.attr,
> +	NULL
> +};

...

> +static int mcp47feb02_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mcp47feb02_data *data = iio_priv(indio_dev);
> +	int ret, ch;

Why ch is signed?

> +	u8 pd_mode;
> +
> +	guard(mutex)(&data->lock);
> +
> +	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
> +		data->chdata[ch].powerdown = true;
> +		pd_mode = data->chdata[ch].powerdown_mode + 1;

> +		regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
> +				   DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));

Missed error check.

> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(data->regmap, ch << 3, data->chdata[ch].dac_data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

I stopped here, I think it's already warrants a new version.

...

> +	tmp = (s64)vref_mv * 1000000LL >> data->info->resolution;

vref_mV
MICRO, MEGA, ... from units.h

> +	value_int = div_s64_rem(tmp, 1000000LL, &value_micro);

...

> +		set_bit(reg, &data->active_channels_mask);

Is the atomic op required here?

...

> +		if (fwnode_property_present(child, "label"))

Useless check as you don't handle an error code from below anyway (means
optional property).

> +			fwnode_property_read_string(child, "label", &data->labels[reg]);

...

May you split this to add the main functionality with the subset of the
supported chips and add, for example, FxBx later in a separate patch?
This will help a lot with reviewing and pushing your patches forward.
Note, considering my comments above I don't think this will make v6.19-rc1,
so you have plenty of time to polish this and maybe even split more.

-- 
With Best Regards,
Andy Shevchenko



