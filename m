Return-Path: <linux-iio+bounces-20235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164FAACEA16
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 08:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E94188A067
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D117D1F03D8;
	Thu,  5 Jun 2025 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1OUTOVj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D02566;
	Thu,  5 Jun 2025 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104524; cv=none; b=QpGoXif8E2a1LyjxR0Loka8EN/ScOnM2nemJkOJ5iKG1UDZLQgz0gvt92iQ2pPoYxB30NE4NuCc/kpHlooMHoXIPUSNgBI0f99jjKXxO+c2zZ0lSniCewHMH9VvFGEOL9r+9uw2F5ZBDup7DwbOcbBdxh+JQEenXDrBAqjgR+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104524; c=relaxed/simple;
	bh=MHhal0LgKPtaPMkQ1hzcXyBudC1oK/SC0MLQV/wiVH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4KyAx/8IabnAyZ6zJecdRqtritjcZrMLzzaCYLugAC2BFR4gC1H1yFu/XnCPP45eY/DvsCZnP5vPHkWKlpn2m8U8TVlue0XxyFr7vQpZFTk3aoD1RDyoYVGYoqg4wtKJ6QiS7WAEd7QYaFEQQ0eeBnzlQ2Drh4Dad0gbjb0uI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1OUTOVj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749104523; x=1780640523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHhal0LgKPtaPMkQ1hzcXyBudC1oK/SC0MLQV/wiVH4=;
  b=a1OUTOVjjTmfktVG00MUvSge4qItQIQJO+N8daVTg+l7f9TW6S2CIC00
   iJtSboxN8CUUIyQNMEC7qaoYIIa/JWYvI2ugY8BcE21KPg73qQ44LrdPC
   Jh4blVs3TbDkLXpvZ8zF6DQa2fK+KTdB6BVkcq9etlkydtgIUQMpUk5xu
   fWZU4bw9/fO4QUwBbeOmdkjBT5puhAg+Fp+qJJrS1EI4yFW5ujLH0+d8z
   kCLmSCGTyeBunb5baaCufu0MXWiU7DSYIxjvq4Ro4PfgRaOMCZJqFcp36
   bK5tMtv4ba/WlIugAjWlee8U1e1ttEj+Bz79xM7zbmpFYy+ovL1Xw0kip
   w==;
X-CSE-ConnectionGUID: sjnyY6DIRmSbkbK8eyDkrA==
X-CSE-MsgGUID: DKqW1JuiTW+SbHdvc0IjcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="55009131"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="55009131"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:22:02 -0700
X-CSE-ConnectionGUID: 112haDkxTtGUgp88JcSy5w==
X-CSE-MsgGUID: 34UgflkGQtuotlqHlkBbNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="176358227"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:21:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uN3z8-00000003mQH-22Ck;
	Thu, 05 Jun 2025 09:21:54 +0300
Date: Thu, 5 Jun 2025 09:21:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v10 11/12] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <aEE3gsbbOuBdI1ky@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
 <c36d6494453050041a585c0e79d7bb674da11c99.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c36d6494453050041a585c0e79d7bb674da11c99.1749063024.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 04, 2025 at 04:37:36PM -0300, Jonathan Santos wrote:
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables sinc3, sinc3+rej60
> and wideband filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features. Sampling frequency
> table is updated after every digital filter parameter change.
> 
> Changes in the sampling frequency are not allowed anymore while in
> buffered mode.

...

> +static const int ad7768_dec_rate_values[8] = {
> +	8, 16, 32, 64, 128, 256, 512, 1024,
> +};
> +
> +/* Decimation rate range for sinc3 filter */
> +static const int ad7768_sinc3_dec_rate_range[3] = {
> +	32, 32, 163840

Also leave trailing comma here.

> +};

...

> +static const char * const ad7768_filter_enum[] = {
> +	[AD7768_FILTER_SINC5] = "sinc5",
> +	[AD7768_FILTER_SINC3] = "sinc3",
> +	[AD7768_FILTER_WIDEBAND] = "wideband",
> +	[AD7768_FILTER_SINC3_REJ60] = "sinc3+rej60"

Ditto.

>  };

...

> +static int ad7768_set_mclk_div(struct ad7768_state *st, unsigned int mclk_div)
> +{
> +	unsigned int mclk_div_value;
> +
> +	mclk_div_value = AD7768_PWR_MCLK_DIV(mclk_div);
> +	/*
> +	 * Set power mode based on mclk_div value.
> +	 * ECO_MODE is only recommended for MCLK_DIV 16

'= 16.' ?

> +	 */
> +	mclk_div_value |= mclk_div > AD7768_MCLK_DIV_16 ?
> +			  AD7768_PWR_PWRMODE(AD7768_FAST_MODE) :
> +			  AD7768_PWR_PWRMODE(AD7768_ECO_MODE);
> +
> +	return regmap_update_bits(st->regmap, AD7768_REG_POWER_CLOCK,
> +				  AD7768_PWR_MCLK_DIV_MSK | AD7768_PWR_PWRMODE_MSK,
> +				  mclk_div_value);
>  }

-- 
With Best Regards,
Andy Shevchenko



