Return-Path: <linux-iio+bounces-26983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C9CB139C
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 22:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C7653015970
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C62DC77E;
	Tue,  9 Dec 2025 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpVY8996"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0283B8D64;
	Tue,  9 Dec 2025 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316758; cv=none; b=Cp9rCJzUI0L+X882XVASeMfkqT3PdkBrD4srJq5/1qHB/Z6cDfrMLoxvIj+zL6G8/9sk+heVwwidj8ys9sp6zGPUrnfMciWJpTQy/kBBkmW0nKYgGdYILHlgx/GRexVJHLTIVPnOCFVDB+4xc1iTeQ2/Wk9KOjzaMhH/zRqhf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316758; c=relaxed/simple;
	bh=7cOGOPo9B83cnNVv8VlN+MM28FfPF8tkuK6gWxDTV64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaslfbfTX4Sg8N5toMJ3ssJPbHWxc7WP8Rf1zPTxzL0ovU1glVU2lukxRqEb7xzLP1n6sVUQQzPg0M/+cvnEzpDoECzw318aRIrhVvaaXdISr7t2KdEcK1qJTt1bazcqoQgtBSLRAevGztJMsMSUtdkrg+Ho2HjfzaaMr34m6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpVY8996; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765316756; x=1796852756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cOGOPo9B83cnNVv8VlN+MM28FfPF8tkuK6gWxDTV64=;
  b=GpVY8996CGbzwk6Yv00Z0n7TCOs3KzdKBWFso8tfhukMJ+MJQJTlSVIF
   o1k/V8fPeCH40xKuLMujZOEdNxSlA9z8RFhwmFcK8MQN3eqOcMeBTUUHM
   vPo6CCHKLB91yq26rvKffpxCy58HU/oD4kRh66wlqdql/Z7JF8KqxVWty
   afsEbl2w0B7MdzMF+uIKKWi561jWHyoQRTqRWDJOshhn8Z61ajeMwEmwK
   Dxj/Wei3sRDOykhGrxH8+QvoGmU1ib2ZV8A7pOxAqmyqNT0Y7ACu7+BX/
   cpQM52Bi01uw5aEuisa3zgwn3a0M9bqkEhTODCzwgo9ZL7wnlllKK9x00
   Q==;
X-CSE-ConnectionGUID: mvfyb6o1RdScNhsAs+dYdg==
X-CSE-MsgGUID: P1aYqwBMSqu283JWHDKwFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="71148412"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="71148412"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 13:45:56 -0800
X-CSE-ConnectionGUID: o8vhg7mET4+eL0B8pRB4oA==
X-CSE-MsgGUID: 8PPUNGmTQr2qBhqYzbNJpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196336860"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 13:45:52 -0800
Date: Tue, 9 Dec 2025 23:45:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aTiYjT1kjOP3xN8x@smile.fi.intel.com>
References: <20251209-mcp47feb02-v3-0-bb0ba9052f4f@microchip.com>
 <20251209-mcp47feb02-v3-2-bb0ba9052f4f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-mcp47feb02-v3-2-bb0ba9052f4f@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 06:06:24PM +0200, Ariana Lazar wrote:
> This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
> MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
> of buffered voltage output Digital-to-Analog Converters with nonvolatile or
> volatile memory and an I2C Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.

Thank you for the update, almost good. See my comments below.

...

> +config MCP47FEB02
> +	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
> +	depends on I2C
> +	help
> +	  Say yes here if you want to build the driver for the Microchip:
> +	  8-bit DAC: MCP47FEB01, MCP47FEB02, MCP47FEB04, MCP47FEB08,
> +	  MCP47FVB01, MCP47FVB02, MCP47FVB04, MCP47FVB08
> +	  10-bit DAC: MCP47FEB11, MCP47FEB12, MCP47FEB14, MCP47FEB18,
> +	  MCP47FVB11, MCP47FVB12, MCP47FVB14, MCP47FVB18
> +	  12-bit DAC: MCP47FEB21, MCP47FEB22, MCP47FEB24, MCP47FEB28,
> +	  MCP47FVB21, MCP47FVB22, MCP47FVB24, MCP47FVB28

This is good, but you can do even better, like in cover letter:

	  - 8-bit DAC:
	    MCP47FEB01, MCP47FEB02, MCP47FEB04, MCP47FEB08,
	    MCP47FVB01, MCP47FVB02, MCP47FVB04, MCP47FVB08
	  - ...

> +	  having 1 to 8 channels, 8/10/12-bit digital-to-analog converter
> +	  (DAC) with I2C interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp47feb02.

...

> +struct mcp47feb02_features {
> +	const char	*name;
> +	unsigned int	phys_channels;
> +	unsigned int	resolution;

> +	bool		have_ext_vref1;
> +	bool		have_eeprom;

Now it's not difference, but maybe in the future we would want more than 4
flags, which will occupy more memory with such an approach. In any case,
currently it is fine.

> +};

...

> +	ret = kstrtobool(buf, &state);

+ kstrtox.h

> +	if (ret)
> +		return ret;

...

> +static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
> +					  const struct iio_chan_spec *ch, const char *buf,
> +					  size_t len)
> +{
> +	struct mcp47feb02_data *data = iio_priv(indio_dev);
> +	u8 tmp_pd_mode;
> +	bool state;
> +	u32 reg;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = kstrtobool(buf, &state);
> +	if (ret < 0)

	if (ret)

Be consistent with a style.

> +		return ret;
> +
> +	reg = ch->address;
> +
> +	/*
> +	 * Set channel to the power-down mode selected. Normal operation mode (0000h)
> +	 * must be written to register in order to exit  power-down mode.
> +	 */
> +	tmp_pd_mode = state ? (data->chdata[reg].powerdown_mode + 1) : MCP47FEB02_NORMAL_OPERATION;
> +	ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
> +				 DAC_CTRL_MASK(reg), DAC_CTRL_VAL(reg, tmp_pd_mode));
> +	if (ret)
> +		return ret;
> +
> +	data->chdata[reg].powerdown = state;
> +
> +	return len;
> +}

...

> +static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mV,
> +					int vref_mV, int vref1_mV)
> +{
> +	struct device *dev = &data->client->dev;

Derive it from regmap (here and everywhere else, where no explicit 'client').

> +	int tmp_vref;
> +
> +	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
> +
> +	if (data->use_vref)
> +		tmp_vref = vref_mV;
> +	else
> +		tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
> +
> +	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
> +	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
> +
> +	if (data->phys_channels >= 4) {
> +		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);

> +		if (data->use_vref1 && vref1_mV <= 0)
> +			return dev_err_probe(dev, -EINVAL, "Invalid voltage for Vref1\n");

Hmm... Does negative vref1_mV contain an actual error code? If so, use it.

> +		if (data->use_vref1)
> +			tmp_vref = vref1_mV;
> +		else
> +			tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
> +
> +		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1,
> +				      tmp_vref, data->scale_1);
> +		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2,
> +				      tmp_vref * 2, data->scale_1);
> +	}
> +
> +	return 0;
> +}

...

> +		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: invalid label\n",
> +					     fwnode_get_name(child));

%pfw

...

> +static int mcp47feb02_probe(struct i2c_client *client)
> +{
> +	const struct mcp47feb02_features *info;
> +	struct device *dev = &client->dev;
> +	struct mcp47feb02_data *data;
> +	struct iio_dev *indio_dev;
> +	int vref1_mV = 0;
> +	int vref_mV = 0;
> +	int vdd_mV = 0;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);

> +	data->client = client;

This is used solely for the getting struct device out of it. Since the struct
mcp47feb02_data contains regmap, this member is duplication and redundancy.
Use regmap_get_device() in the users.

> +	info = i2c_get_match_data(client);
> +	if (!info)
> +		return -EINVAL;
> +
> +	data->info = info;
> +
> +	if (info->have_eeprom) {
> +		data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
> +		indio_dev->info = &mcp47feb02_info;
> +	} else {
> +		data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
> +		indio_dev->info = &mcp47fvb02_info;
> +	}

> +

Unneeded blank line.

> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
> +
> +	indio_dev->name = info->name;
> +
> +	ret = mcp47feb02_parse_fw(indio_dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return ret;

> +	vdd_mV = ret / 1000;

It might be (MICRO / MILLI)


> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret > 0) {
> +		vref_mV = ret / 1000;

Ditto.

> +		data->use_vref = true;
> +	} else {
> +		dev_dbg(dev, "using internal band gap as voltage reference.\n");
> +		dev_dbg(dev, "Vref is unavailable.\n");
> +	}
> +
> +	if (info->have_ext_vref1) {
> +		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> +		if (ret > 0) {
> +			vref1_mV = ret / 1000;

Ditto.

> +			data->use_vref1 = true;
> +		} else {
> +			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> +			dev_dbg(dev, "Vref1 is unavailable.\n");
> +		}
> +	}
> +
> +	ret = mcp47feb02_init_ctrl_regs(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error initialising vref register\n");
> +
> +	ret = mcp47feb02_init_ch_scales(data, vdd_mV, vref_mV, vref1_mV);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



