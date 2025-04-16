Return-Path: <linux-iio+bounces-18162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FFCA8B57B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 11:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8600E189F683
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE6233D9E;
	Wed, 16 Apr 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpLW4TIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D6140E5F;
	Wed, 16 Apr 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796074; cv=none; b=B+BB1KDqKL2n+qx/W5DftHq7BXT9Zgm3z9shanuIHc6LgMNGDiHkIpuHwy4h2ErB2DG7TNUDuYw3qirlRmzxoqNY1dYQQvLt4k4HAr2+N2lhLpCtWz6SIroKchphoeQYErP65ooiDpH/ln5sqP/JnaW48xFJLyksQiRwOBV8wfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796074; c=relaxed/simple;
	bh=uZSQmjV+BQKmWHHE2sxmoUIlyRSpGOZ7FX772VnTlTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9he1AeOCN5oeTGPEzKwLrFGubzUHZvHe2ToXzU5/hEza6RUyZP+kijcLWjSRn73CwjLIRCKPgsU3swteiRX4pRIcAfszdiVNeqxB565NYUicuS7/s7DzrEs+QrpDtaXItu7vnxaLmp0aHsG5HfMPJwfD0w0Egb6AFeyISwVKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpLW4TIq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744796073; x=1776332073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZSQmjV+BQKmWHHE2sxmoUIlyRSpGOZ7FX772VnTlTg=;
  b=lpLW4TIqX6sTjETw1tvPzihLiRAywQP7Sws+EVovFP0GGSkq8QZcPxBr
   YsgXTGrT8npX/iVmkupo1pvj8+nrFk2s6j6Ug8VR1VN3y6BXIo7IF2PJG
   K74EAxSoQUW5yeFJkds0Xekmu8F3jyw50FY7Dem5Itpl9hTD8a7kZd7zo
   b92uqWYIQLmNqdOkz7WlUPhjwT0TlLOJ4tkszlCnv9TsIwMw2e/QFmOua
   MUzl1eHntE+wG33T/fypTx4pGrHLNYVLsqrI2EIdMY5KygH4av6tcBZem
   jxAofs62g/2nHdNkvH0vMH8MhRsFwqb2JGTmJomVxtbzE8vfsqK0zepa6
   A==;
X-CSE-ConnectionGUID: vzv+ZBzmQoGgu/KQ8OQSHA==
X-CSE-MsgGUID: 3+mq7CdcSh2PcJjUA45H9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63741016"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="63741016"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 02:34:32 -0700
X-CSE-ConnectionGUID: /MOSed0eSKSAYtpaHJDjCQ==
X-CSE-MsgGUID: TsTqlq7mSBK2Ad8BCZQkuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130925250"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 02:34:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4z9y-0000000CoFA-0ZGb;
	Wed, 16 Apr 2025 12:34:22 +0300
Date: Wed, 16 Apr 2025 12:34:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com,
	alisadariana@gmail.com, tgamblin@baylibre.com,
	olivier.moysan@foss.st.com, antoniu.miclaus@analog.com,
	eblanc@baylibre.com, joao.goncalves@toradex.com,
	tobias.sperling@softing.com, marcelo.schmitt@analog.com,
	angelogioacchino.delregno@collabora.com,
	thomas.bonnefille@bootlin.com, herve.codina@bootlin.com,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <Z_95naiV7zpLokPr@smile.fi.intel.com>
References: <20250416081734.563111-1-j2anfernee@gmail.com>
 <20250416081734.563111-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416081734.563111-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 04:17:34PM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> for independent alarm signals, and all the threshold values could be set
> for system protection without any timing delay. It also supports reset
> input RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.

...

> +#define NCT7201_REG_VIN(i)				(i)

This doesn't do anything useful. Why do you need this rather useless macro?

...

> +struct nct7201_chip_info {
> +	struct device *dev;

This can be derived from the respective regmap. No need to have it here.

> +	struct regmap *regmap;
> +	struct regmap *regmap16;
> +	int num_vin_channels;
> +	u16 vin_mask;
> +};

...

> +struct nct7201_adc_model_data {
> +	const char *model_name;
> +	const struct iio_chan_spec *channels;

> +	const int num_channels;

What is the meaning of const here?

> +	int num_vin_channels;
> +};

...

> +#define NCT7201_VOLTAGE_CHANNEL(num)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (num + 1),					\

Parentheses are in a wrong place

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.address = num,						\
> +		.event_spec = nct7201_events,				\
> +		.num_event_specs = ARRAY_SIZE(nct7201_events),		\
> +	}

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

> +	mask = BIT(chan->address);

Just join this with the definition above.


> +	if (state)
> +		chip->vin_mask |= mask;
> +	else
> +		chip->vin_mask &= ~mask;
> +
> +	if (chip->num_vin_channels <= 8)
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,

Remove _1.

> +				   chip->vin_mask);
> +	else
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +					&chip->vin_mask, sizeof(chip->vin_mask));

> +	if (err)
> +		return err;
> +
> +	return 0;

As simple as

	return err;

> +}

...

> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	struct device *dev = chip->dev;

Derive this from chip->regmap.

> +	__le16 data = cpu_to_le16(NCT7201_REG_CHANNEL_ENABLE_MASK);
> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			   NCT7201_BIT_CONFIGURATION_RESET);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to reset chip\n");
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then the Power
> +	 * Up bit will be set to 1. If not, wait for it.

"Up bit" is odd, please be more specific.

> +	 */
> +	fsleep(25000);

+ Blank line.

> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to read busy status\n");
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(dev, -EIO, "Failed to power up after reset\n");
> +
> +	/* Enable Channel */
> +	if (chip->num_vin_channels <= 8)
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +				   NCT7201_REG_CHANNEL_ENABLE_MASK);
> +	else
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +					&data, sizeof(data));
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable channel\n");
> +
> +	err = regmap_bulk_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +			       &chip->vin_mask, sizeof(chip->vin_mask));
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Failed to read channel enable register\n");
> +
> +	/* Start monitoring if needed */
> +	err = regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			      NCT7201_BIT_CONFIGURATION_START);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to start monitoring\n");
> +
> +	return 0;
> +}

...

> +	ret = nct7201_init_chip(chip);
> +	if (ret < 0)

Why ' < 0' ?

> +		return ret;

-- 
With Best Regards,
Andy Shevchenko



