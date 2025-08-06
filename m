Return-Path: <linux-iio+bounces-22361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C6B1CD7F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 22:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38677A83E0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537C21C9E5;
	Wed,  6 Aug 2025 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8ZhisKz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BF1D7E31;
	Wed,  6 Aug 2025 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512574; cv=none; b=TVzhcsSPXeCpj84NAHRWK1stfsIeuos/DKmPqta5IZWXYFZo4lOn4ZRwb33PkRXfTU7jioyVZ1cBm5X4T3bN8JvOZdHnOEs4T3q0yZu0rOBR3ujCUUcTrBabHDx//PBMEhTPQ1+GsY7TSj0st2IC6EB7Aj3BHvoTAEmRT9CJwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512574; c=relaxed/simple;
	bh=omoGFr9ZQ8SroH5Srh+gk6QS+mi6a7nb1tSnLJs20D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTO0B1I3Or5oTAvIa+UFhzXgBAe2a5Wq/li6PIKB1zjOmP8dDlY1QxiNE6JOflKLJmefhmm4ShMSdzNEGxokca8XPQRfq4xdwVei9i0vmWzWXEact8g/br4/0sXvCFosf8Q2SRicXU91NDO8+kJVxgI1h4yNAayw5oOvqvqWnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8ZhisKz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512574; x=1786048574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omoGFr9ZQ8SroH5Srh+gk6QS+mi6a7nb1tSnLJs20D8=;
  b=U8ZhisKzQ2v//Om82BYKpMm+nfpwkYmsg1IF1nMzTrJL4fktdOlQjDZD
   DlERkHtZa3SKW9PVi5QDPqaprdG+mTsT3Z1EklDPZebvN631Fx3weTmO7
   haJHYb0hWtbx7rVqUbRVP1y1xG2Nh7oBk1yDAwLiP1C6paFVDY6ONHG2/
   1C2p9UPmoeh3EPzd+z2X3VZqbwD3QcyBpXRsVyWpLDkbfRwIeAj3+2WnO
   O8FkEkVGtybSqShkxmTeDF6af0RHjvl9tjnyvpFGi2PEeAYM0IBs4b1+i
   4uIZJQ42FukfGHw/gjWZQ3Iv43MF1fBw39pP7BrJFLcuBaFAVS9wBkDfu
   Q==;
X-CSE-ConnectionGUID: YS44eP2wSXqePd2oSKcKxA==
X-CSE-MsgGUID: AZtVbyGvSNubBbuXjyoC3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56917939"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56917939"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:36:13 -0700
X-CSE-ConnectionGUID: fliheRZYSE+quFMNHOZiVw==
X-CSE-MsgGUID: oywvH5iiSHy/ztXORqSLWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170138177"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:36:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujkrm-000000046qy-1dOc;
	Wed, 06 Aug 2025 23:36:06 +0300
Date: Wed, 6 Aug 2025 23:36:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: update ad7779 to use IIO backend
Message-ID: <aJO8thsrIgS3YGj2@smile.fi.intel.com>
References: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
 <20250806192502.10120-4-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806192502.10120-4-Ioana.Risteiu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 10:25:00PM +0300, Ioana Risteiu wrote:
> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.

...

> +enum ad7779_data_lines {
> +	AD7779_4LINES = 4,
> +	AD7779_2LINES = 2,
> +	AD7779_1LINE = 1,

Reversed ordering in enum is not a thing I see everyday in C, maybe a bit
confusing to the reader.

> +};

Seems like it's 1:1, why enum at all?

...

> -#define AD777x_CHAN_S(index, _ext_info)					\
> +#define AD777X_CHAN_S(index, _ext_info)					\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE)  |	\

Unneeded change.

...

> -#define AD777x_CHAN_NO_FILTER_S(index)					\
> -	AD777x_CHAN_S(index, NULL)
> +#define AD777X_CHAN_NO_FILTER_S(index)					\
> +	AD777X_CHAN_S(index, NULL)

Why?!

> +#define AD777X_CHAN_FILTER_S(index)					\
> +	AD777X_CHAN_S(index, ad7779_ext_filter)
>  
> -#define AD777x_CHAN_FILTER_S(index)					\
> -	AD777x_CHAN_S(index, ad7779_ext_filter)

Ditto.

>  static const struct iio_chan_spec ad7779_channels[] = {
> -	AD777x_CHAN_NO_FILTER_S(0),
> -	AD777x_CHAN_NO_FILTER_S(1),
> -	AD777x_CHAN_NO_FILTER_S(2),
> -	AD777x_CHAN_NO_FILTER_S(3),
> -	AD777x_CHAN_NO_FILTER_S(4),
> -	AD777x_CHAN_NO_FILTER_S(5),
> -	AD777x_CHAN_NO_FILTER_S(6),
> -	AD777x_CHAN_NO_FILTER_S(7),
> +	AD777X_CHAN_NO_FILTER_S(0),
> +	AD777X_CHAN_NO_FILTER_S(1),
> +	AD777X_CHAN_NO_FILTER_S(2),
> +	AD777X_CHAN_NO_FILTER_S(3),
> +	AD777X_CHAN_NO_FILTER_S(4),
> +	AD777X_CHAN_NO_FILTER_S(5),
> +	AD777X_CHAN_NO_FILTER_S(6),
> +	AD777X_CHAN_NO_FILTER_S(7),
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };

Ditto.

>  static const struct iio_chan_spec ad7779_channels_filter[] = {
> -	AD777x_CHAN_FILTER_S(0),
> -	AD777x_CHAN_FILTER_S(1),
> -	AD777x_CHAN_FILTER_S(2),
> -	AD777x_CHAN_FILTER_S(3),
> -	AD777x_CHAN_FILTER_S(4),
> -	AD777x_CHAN_FILTER_S(5),
> -	AD777x_CHAN_FILTER_S(6),
> -	AD777x_CHAN_FILTER_S(7),
> +	AD777X_CHAN_FILTER_S(0),
> +	AD777X_CHAN_FILTER_S(1),
> +	AD777X_CHAN_FILTER_S(2),
> +	AD777X_CHAN_FILTER_S(3),
> +	AD777X_CHAN_FILTER_S(4),
> +	AD777X_CHAN_FILTER_S(5),
> +	AD777X_CHAN_FILTER_S(6),
> +	AD777X_CHAN_FILTER_S(7),
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };

Ditto.

...

> +static int ad7779_conf_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
> +{
> +	struct iio_chan_spec *channels;
> +	struct device *dev = &st->spi->dev;
> +	int num_channels = ARRAY_SIZE(ad7779_channels);
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);

Doesn't sound like a right place for devm. Is this function called only at probe stage?

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	memcpy(channels, st->chip_info->channels, num_channels * sizeof(struct iio_chan_spec));

kmemdup_array()?

> +	for (int i = 0; i < 8; i++)

Why i is signed?
What is the magic 8? ARRAY_SIZE()?

> +		channels[i].scan_type.endianness = IIO_CPU;
> +
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +}

...

> +	if (ret)
> +		return ret;
> +
> +	return 0;

return ...


...

> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back)) {
> +		dev_err_probe(dev, ret, "failed to get iio backend");

Huh?!

> +		return PTR_ERR(st->back);

Pattern is

		return dev_err_probe(...);

> +	}

-- 
With Best Regards,
Andy Shevchenko



