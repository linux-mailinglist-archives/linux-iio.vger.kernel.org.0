Return-Path: <linux-iio+bounces-23055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ED2B2DF20
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE9262301C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C526E6E3;
	Wed, 20 Aug 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1aDnEjR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3918C031;
	Wed, 20 Aug 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699493; cv=none; b=bAzqiOzCIi6qwsoSvwHXUMOOpR1fdeMnw6GXBns7hbo2WBZeDmDDcAewdc23nUOF98MLQICjN22dTg+oj7UXrU0VFpYJAANzR6THQCSlygInsVfAIOKzMz8igIGi1OaSHev83++oWztzYaqCpdW22WfTmc4cnaAPP6OuqSbe4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699493; c=relaxed/simple;
	bh=MequawHGbH8y9CuIP03AIdFN2olF7rn3Pf0V+3e0akU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRD2q2Z+cKkPu9DreCdocpfSF8ii9WoQ3ObUdu+fPWZhXcpunaio/o8PB+QeFUQziQACC7qb+AHlVW90jDwuljNGLzFACwvwtQ9jhstDIZd8Gorpi7CqIS0fVooyZZccHR5SKhy1+41y9A4pKJS6fPK32TbVt6XFzWuNDfarwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1aDnEjR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755699493; x=1787235493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MequawHGbH8y9CuIP03AIdFN2olF7rn3Pf0V+3e0akU=;
  b=X1aDnEjR2sye5FT0jy3ieNfuT0iDuswr0SrRGvNaq1w6biKW6FC3qFXJ
   SchDLpkWrYXWkgB0VaX2s/U+oiFI0f8LicIYRhoYt3rordJpmADti4dGL
   wA5ZdIPH5er14TGEWuIjN4VYAVNIiLds5sz2ycybYOwyvtcu95bknNa8H
   aJmE+xR132I7yKOwIh7i5MKx6eWzG6vEAQVVjccWs1COh4hnUfKaGWd0a
   EPiExQzbPbwv85Y6vm6gaeojHEHB4XrScKtvT1MHEnPqztzZg2esWovA5
   4VYTcCs5xWUBj8ogA0cMzgtccf0Cl+3Aiz2yb4G3wy2Z/8JImoSgkcuFc
   g==;
X-CSE-ConnectionGUID: Dgc9qBfzQzOgEkXhcUhbrw==
X-CSE-MsgGUID: 3ZmKyzwVSJmLT7qVgjLteA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69412045"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69412045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:18:12 -0700
X-CSE-ConnectionGUID: 3EIpFeO2QCKVP73XKK9jVg==
X-CSE-MsgGUID: FjAFMUfHSjqyKjJNlazMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172366765"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:18:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uojdd-00000006xGt-40Rt;
	Wed, 20 Aug 2025 17:18:05 +0300
Date: Wed, 20 Aug 2025 17:18:05 +0300
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
Subject: Re: [PATCH v4 4/4] iio: adc: update ad7779 to use IIO backend
Message-ID: <aKXZHVpcenaOkvrv@smile.fi.intel.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
 <20250820120247.3012-5-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820120247.3012-5-Ioana.Risteiu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 03:02:45PM +0300, Ioana Risteiu wrote:
> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.

...

> +static int ad7779_set_data_lines(struct iio_dev *indio_dev,
> +				 unsigned int num_lanes)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);

> +	int ret = -EINVAL;

In general the split assignment is easier to maintain and less prone to subtle
errors. In this case it's even worse as it's not needed...

> +	if (num_lanes != AD7779_1LINE &&
> +		num_lanes != AD7779_2LINES &&
> +		num_lanes != AD7779_4LINES)
> +		return ret;

...just return the error code directly here.

> +	ret = ad7779_set_sampling_frequency(st, num_lanes * AD7779_DEFAULT_SAMPLING_1LINE);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DOUT_FORMAT_MSK,
> +				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
> +}

...

> +static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
> +{
> +	struct iio_chan_spec *channels;
> +	struct device *dev = &st->spi->dev;
> +
> +	channels = devm_kmemdup_array(dev, st->chip_info->channels,
> +					ARRAY_SIZE(ad7779_channels),
> +					sizeof(*channels), GFP_KERNEL);

Indentation...

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < ARRAY_SIZE(ad7779_channels); i++)

Why signed iterator?

> +		channels[i].scan_type.endianness = IIO_CPU;
> +
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +}

...

> +static int ad7779_setup_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &st->spi->dev;

> +	int ret = -EINVAL;

Why?!

> +	int num_lanes;

Can it be negatie?

> +	indio_dev->info = &ad7779_info_data;
> +
> +	ret = ad7779_setup_channels(indio_dev, st);
> +	if (ret)
> +		return ret;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get iio backend");
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	num_lanes = 4;
> +	ret = device_property_read_u32(dev, "adi,num-lanes", &num_lanes);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	return ad7779_set_data_lines(indio_dev, num_lanes);
> +}

-- 
With Best Regards,
Andy Shevchenko



