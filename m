Return-Path: <linux-iio+bounces-23227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19907B34258
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D379D3A9272
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFD2F2903;
	Mon, 25 Aug 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtUejWJS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8952F28EC;
	Mon, 25 Aug 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129742; cv=none; b=seyREd536ESFM86ibTz63T6vY2/xg9GUwN088yHqzfPXg844pbtT/rKxbBl7UE/TTWkYwTW2v7DyTYA29T6INasVys+EQY1XKjj8tG++p6q6eKrZPeR4l0M//HHN1Ba3bLL7zkD4x0UAkN1M+3IZip2isDsmt+mW1B9MkE/wLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129742; c=relaxed/simple;
	bh=2JIQtST7ZN+nR+CyfTh1cBuXQlpBVKdvovu1zUOkCh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6GvZzmbhwAEA22Se7GMDN2dnqqjf7K3UmameAfwrZuUFeKzIrCs4ZwKMsKOat2siBjXyFu/Or+lWOjPw2Jo6Jn0thGIN2Oi+RFG1dxAr5DtQaA9i0R6grl3/HivP2fQWL63KwqIICNFHlKF0v1AGUKRScJHUkan4ydyLo3ynGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtUejWJS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756129740; x=1787665740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2JIQtST7ZN+nR+CyfTh1cBuXQlpBVKdvovu1zUOkCh8=;
  b=FtUejWJSfUCTYhxWRdJ03GcB4pgYSDqeNYMq5pVy55wR0cfHcO9R2gR9
   oTKAuHuZH3GSh5qmX5QLQ/y5G6qw3hcuOA0XpJRmNICygqiygK8jBlMW+
   xmglGijkK1iyfWp9AqVQf+ymG+suEDtRYqRHFw4IO5twQOBoqb40AdCDl
   +MipC9milk9ZC4V28VvV7k0BdSg1p1Woln3SjBezNT+iJmfxZZ64CJ3si
   cRpVV3WKH/XeV++dYjwDwsvkAqa4weHnSyu+U27VHt6siIqCS96rLFwW9
   3DZI5w7jbVDmJR0w+puTdqHhS+50lyjMK95FAusUqvoIkpjhzURSoWU8y
   A==;
X-CSE-ConnectionGUID: +pWoOg0nSlSisAuEpd2zbg==
X-CSE-MsgGUID: 3yVml97VRXm8hriVCVFXuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58283940"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58283940"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:48:59 -0700
X-CSE-ConnectionGUID: U1aWIXVHRQuBnYslC8Qzlw==
X-CSE-MsgGUID: SG7wkakdRtyMEvapR2kKOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169693784"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:48:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uqXZ7-00000008WUS-1yJs;
	Mon, 25 Aug 2025 16:48:53 +0300
Date: Mon, 25 Aug 2025 16:48:53 +0300
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
Subject: Re: [PATCH v5 4/4] iio: adc: update ad7779 to use IIO backend
Message-ID: <aKxpxVJTRO90Tz-W@smile.fi.intel.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
 <20250825105121.19848-5-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825105121.19848-5-Ioana.Risteiu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 25, 2025 at 01:51:19PM +0300, Ioana Risteiu wrote:
> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.

...

> +static int ad7779_set_data_lines(struct iio_dev *indio_dev, u32 num_lanes)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (num_lanes != AD7779_1LINE &&
> +		num_lanes != AD7779_2LINES &&
> +		num_lanes != AD7779_4LINES)

Wrong indentation.

> +		return -EINVAL;
> +
> +	ret = ad7779_set_sampling_frequency(st, num_lanes * AD7779_DEFAULT_SAMPLING_1LINE);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				     AD7779_DOUT_FORMAT_MSK,
> +				     FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
> +}

...

> +static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
> +{
> +	struct iio_chan_spec *channels;
> +	struct device *dev = &st->spi->dev;
> +
> +	channels = devm_kmemdup_array(dev, st->chip_info->channels,
> +				      ARRAY_SIZE(ad7779_channels),
> +				      sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(ad7779_channels); i++)
> +		channels[i].scan_type.endianness = IIO_CPU;
> +
> +	indio_dev->channels = channels;

So, here I expect to see num_channels assignment as well as near to any other
channels assignment.

> +
> +	return 0;
> +}

Otherwise LGTM.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



