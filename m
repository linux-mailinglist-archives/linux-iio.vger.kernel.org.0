Return-Path: <linux-iio+bounces-28004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E134D3B6F5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42946304DB59
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F938F956;
	Mon, 19 Jan 2026 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fu2dO9un"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C33126A1;
	Mon, 19 Jan 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849891; cv=none; b=GLHbVstHHPHnzxmj9WMTXft+Voqw0feYX+cCcim2PnlYvZXAm+r+P1fRjVwVzcWDYWLhI60su6bHwe13ISVpRpph44/QJoVCxejAdae6IxE2fUk3JTSUxe1kZEDvPsq/xwTItVnFg79kwCY08IFAeq6mf7Q+vYSHN6+mjghnWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849891; c=relaxed/simple;
	bh=fLO6T0/fGTVtnzO1cEfB2bZ7ORGh+gx0pi92VSS7Cyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8r5LA1SaqRyy5OMFq3ixzQAxE5pH38oXIkqb4WwbYGhAgr3pvEd9pDDDe2xbS2ZC+RSvuNuVi99pOoEEMfICdhr53NVEjuAhR26hJvCFYDEffftWlB2kI2w5BYVRbTZxAJ5Amtzr8d5e6cNZ+IhIhC9QVtfSgTb3lezcUb5vjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fu2dO9un; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768849889; x=1800385889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLO6T0/fGTVtnzO1cEfB2bZ7ORGh+gx0pi92VSS7Cyo=;
  b=Fu2dO9unPaq9bNxM7uM1AY4rslBQr7ipBX7esFgu7oGxk9pfhdCxWprE
   iFouzx60nPIIp7JUTnN4tysoDGR9dtL7Ky6p27xr9QPt8zBnpU16ia0kj
   Hw574/RakeZeBixNVbxa2yZOMmpfk9D0MXCNukunnR59V61els2Q1Jgcc
   M+xppCkVNf6l1/Y5nU2LZj3TGbJbM3XXHqhgIAQW8LoiR5w+W3Qgwv0c7
   Hfe1jdYO1G3vQ54OaCxbNqXzvX1Hv7pVYu/tC3QLriqVFo60xL8F3aXVA
   pVHK1MdU9BpbcMjPEOPqFeLszCqyhNjdN26wyoK95DWQlixrbbvDeiadQ
   w==;
X-CSE-ConnectionGUID: yFbyBPpPRlugmvsUhvUUWA==
X-CSE-MsgGUID: 12gOQXVjTPWR2oX9Px3eUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69972499"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="69972499"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:11:29 -0800
X-CSE-ConnectionGUID: oBsPDJPZTpa8B/53QdhWFg==
X-CSE-MsgGUID: wsuLApVFQAWilWGmVipHjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="210435749"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:11:26 -0800
Date: Mon, 19 Jan 2026 21:11:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 5/8] iio: dac: ds4424: add Rfs-based scale and
 per-variant limits
Message-ID: <aW6B22-nMF1EfGmE@smile.fi.intel.com>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119182424.1660601-6-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 07:24:21PM +0100, Oleksij Rempel wrote:
> Parse optional maxim,rfs-ohms values to derive the per-channel output
> current scale (mA per step) for the IIO current ABI.
> 
> Select per-variant parameters to match the shared register map while
> handling different data widths and full-scale current calculations.
> 
> Behavior changes:
> - If maxim,rfs-ohms is present, IIO_CHAN_INFO_SCALE becomes available
>   and reports mA/step derived from Rfs.
> - If maxim,rfs-ohms is missing, SCALE is not exposed to keep older DTs
>   working without requiring updates.
> - RAW writes are now limited to the representable sign-magnitude range
>   of the detected variant to avoid silent truncation (e.g. +/-31 on
>   DS440x).

...

> +struct ds4424_chip_info {
> +	u8 result_mask;
> +	int vref_mv;
> +	int scale_denom;

Wondering if `pahole` is fine with the proposed layout.
Otherwise I would move u8 to the end.

> +};

...

> +static const struct ds4424_chip_info ds4424_info = {
> +	.result_mask = 0x7F,

GENMASK() ?
(Note, we also have GENMASK_U8() IIRC)

> +	.vref_mv = 976,
> +	.scale_denom = 16,
> +};

...

> +/* DS4402 is handled like DS4404 (same resolution and scale formula). */
> +static const struct ds4424_chip_info ds4404_info = {
> +	.result_mask = 0x1F,

Ditto.

> +	.vref_mv = 1230,
> +	.scale_denom = 4,
> +};

...

> -		if (val <= S8_MIN || val > S8_MAX)
> +		/*
> +		 * The hardware uses sign-magnitude representation (not
> +		 * two's complement). Therefore, the range is symmetric:
> +		 * [-max_val, +max_val].
> +		 */
> +		if (val < -max_val || val > max_val)
>  			return -EINVAL;

Right, cool, but I still think even in the fix it would be good to fix that and
here it will be quite logical and clear change. Maybe even introduce a comment
in the fix-patch and just update limits here.

...

> +static int ds4424_setup_channels(struct i2c_client *client,
> +				 struct ds4424_data *data,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec channels[DS4424_MAX_DAC_CHANNELS];
> +	size_t channels_size;
> +	int i;
> +
> +	channels_size = indio_dev->num_channels * sizeof(*channels);

Sounds like devm_kmemdup_array() to me...

> +	memcpy(channels, ds4424_channels, channels_size);

> +	/* Enable scale only when rfs is available. */
> +	if (data->has_rfs) {
> +		for (i = 0; i < indio_dev->num_channels; i++)
> +			channels[i].info_mask_separate |=
> +				BIT(IIO_CHAN_INFO_SCALE);
> +	}

Can be done after kmemdup(), right?

> +	indio_dev->channels = devm_kmemdup(&client->dev, channels,
> +					   channels_size, GFP_KERNEL);
> +	if (!indio_dev->channels)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

...

> +static int ds4424_parse_rfs(struct i2c_client *client,
> +			    struct ds4424_data *data,
> +			    struct iio_dev *indio_dev)
> +{

	struct device *dev = &client->dev;

> +	int count, i, ret;
> +
> +	if (!device_property_present(&client->dev, "maxim,rfs-ohms")) {
> +		dev_info_once(&client->dev, "maxim,rfs-ohms missing, scale not supported\n");
> +		return 0;
> +	}
> +
> +	count = device_property_count_u32(&client->dev, "maxim,rfs-ohms");
> +	if (count != indio_dev->num_channels) {
> +		dev_err(&client->dev,
> +			"maxim,rfs-ohms must have %u entries\n",
> +			indio_dev->num_channels);
> +		return -EINVAL;
> +	}
> +
> +	ret = device_property_read_u32_array(&client->dev,
> +					     "maxim,rfs-ohms",
> +					     data->rfs_ohms,
> +					     indio_dev->num_channels);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Failed to read maxim,rfs-ohms property\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		if (!data->rfs_ohms[i]) {

> +			dev_err(&client->dev,
> +				"maxim,rfs-ohms entry %d is zero\n",
> +				i);

> +			return -EINVAL;

This is only for probe stage, right?

Then

			return dev_err_probe();

?

> +		}
> +	}
> +
> +	data->has_rfs = true;
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



