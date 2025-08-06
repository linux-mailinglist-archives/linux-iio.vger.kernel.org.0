Return-Path: <linux-iio+bounces-22360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F178CB1CD6F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937233ABCCA
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171C218AAD;
	Wed,  6 Aug 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ds6/czIO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCF10E4;
	Wed,  6 Aug 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512023; cv=none; b=A4yFWtSb7HItyam4Hlpu/UYPzH+mfX2sOYeNQ6AvbVWNLvzNZpzm4mZs6ncaLMECT63YLlUnZ45qCelUChNVKHhuwMecrpwKl1h9tZPOGGQv/IeqxyL9yoFz0Y8Lw+Rl77F1Zgk+gn6fIxDnDObiaKSnPGjw/VLxaUyM03XvhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512023; c=relaxed/simple;
	bh=I5YWQeBrQwcESC8lhNQmpERBji1Y5dvijPiuccEW5cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJpug2pwP4vxbdWH3gKHkHXUXQfSTKrHqLpXm0ZBzmeZ2teSZQn47TJ1V50WqkihsGMov2pvDhoO17m0nshvsdYeWYkZ2nwxFGWJL4vf0l0PX/3fK0NBUoDuiTxn0hA1MIdvoAW0ETafLfMdxBqtvDbn+6qVkkLNoIV3EgvdvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ds6/czIO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512022; x=1786048022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5YWQeBrQwcESC8lhNQmpERBji1Y5dvijPiuccEW5cY=;
  b=ds6/czIOQFfAw8fSCSoCHVo5OTgo0b5BUpicryZMtYfXNhj3Y9Jdeqhm
   BXjb2UH1V6J/2zm+uYHKsQWVJD9CDGH48DxVACfeML+hJHJqMcB42s0ye
   WPRjr3G2GbTPVntxJ8p9/u8LwwqqJKFUdfR4WDInXokZDnkJr4HufEE7c
   XVpJ+b+pVpzv3HMNZLkCIOqgjXF/nt9blrZBRUxpH63QhBuAwf0IJmCCb
   ShV3iLO2smBHzXr0P9g+Pz34mK50NIv35CDVcuMLkhQxnH7YdmPK2CiFW
   7L2AG3MStKvTgApzCZ8zpzjazuSIJSo7P0UtCQqcAK97zlCh6aw9FbD3X
   w==;
X-CSE-ConnectionGUID: dRqlXpISRxS/PWnM0cTK5w==
X-CSE-MsgGUID: WTRK6dw9TZWlMlAe8Ip+Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56805863"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56805863"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:27:01 -0700
X-CSE-ConnectionGUID: TWmLGizuQ4GzfGyyrDVajw==
X-CSE-MsgGUID: 1zfEMnxsQFaGDv+JYYwEtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169039605"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:26:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujkis-000000046mN-03Qa;
	Wed, 06 Aug 2025 23:26:54 +0300
Date: Wed, 6 Aug 2025 23:26:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <aJO6jVcITlOXp0YB@smile.fi.intel.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 10:04:43AM +0300, Matti Vaittinen wrote:
> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
> 
> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
> conversion. Unlike with the ad7091 and ad7091r which also have a
> CONVSTART pin, the BD79105 requires that the pin must remain high also
> for the duration of the SPI access.
> 
> (*) Couple of words about the SPI. The BD79105 has pins named as
> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
> ISO.
> 
> DIN is a signal which can be used as a chip-select. When DIN is pulled
> low, the ADC will output the completed measurement via DOUT as SCLK is
> clocked. According to the data-sheet, the DIN can also be used for
> daisy-chaining multiple ADCs. Also, DOUT can be used also for a
> 'data-ready' -IRQ. These modes aren't supported by this driver.
> 
> Support reading ADC scale and data from the BD79105 using SPI, when DIN
> is used as a chip-select.

...

> +static void bd79105_convst_disable(struct ad7476_state *st)
> +{
> +	if (!st->convst_gpio)
> +		return;

Dup code, please remove.

> +	gpiod_set_value(st->convst_gpio, 0);
> +}
> +
> +static void bd79105_convst_enable(struct ad7476_state *st)
> +{

> +	if (!st->convst_gpio)
> +		return;

With 10ns sleep in mind this is also unneeded check.

> +	gpiod_set_value(st->convst_gpio, 1);

> +	udelay(1); /* 10ns required for conversion */

We have ndelay(). But I believe toggling GPIO is much longer operation.

> +}

...

> @@ -347,7 +381,6 @@ static int ad7476_probe(struct spi_device *spi)
>  	if (st->convst_gpio)
>  		indio_dev->channels = st->chip_info->convst_channel;
>  	/* Setup default message */
> -
>  	st->xfer.rx_buf = &st->data;
>  	st->xfer.len = indio_dev->channels[0].scan_type.storagebits / 8;

Stray change.


-- 
With Best Regards,
Andy Shevchenko



