Return-Path: <linux-iio+bounces-20234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A46ACE9E0
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 08:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924737A7525
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48DC1F2BAE;
	Thu,  5 Jun 2025 06:14:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75B1EDA0F;
	Thu,  5 Jun 2025 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104060; cv=none; b=P5m7koeE2fg/RM4Uc3IROkFPLKtOVLo0yJdoFg+y+g0EGPfGVNELBj2cAX5VtGjPw55wTZztQKEgDyc9uOUoSe+8WGpC1M0Cm1QpzQqG2r/8pk/In2nhYsH/WkNrylcYvYh8bX2wXcnJUu5xv32sug8TN7wU3DZjZ9UAfAQTc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104060; c=relaxed/simple;
	bh=WK1uYtCdUzd5l0mC8bzQZUF7PXGq08d44yHsN/8HCLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhJgwiNCNitKElNWMI9+jmQ9qhJuN5NZliRaMZ3DIaE3t2ideZJ4spMCYjpUWEgSFXXq6FTTm9o+G4ofEGC9A5vA25eJV0gskt7S3uG7BaT+DNhXVsIeuAMaCFNBbJ3htBKpPHF5XxmXTYI90tBQ+NfiaIEduu/ZhnJCEBXdrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 1n5lKT+DSraNJZE2/wANsw==
X-CSE-MsgGUID: AyqsUD6uTxKYFKaiv0VMLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="76607023"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="76607023"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:14:18 -0700
X-CSE-ConnectionGUID: vvAIuT6kSUGphIbpdKBDJg==
X-CSE-MsgGUID: IVqj2cBGRHOjIp+Qn4xs1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="150424887"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:14:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uN3rf-00000003mKD-097C;
	Thu, 05 Jun 2025 09:14:11 +0300
Date: Thu, 5 Jun 2025 09:14:10 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 12/12] iio: adc: ad7768-1: add low pass -3dB cutoff
 attribute
Message-ID: <aEE1sjgMHa2sW5-X@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
 <e53b113a7edfa8fbe68fd6a45503f2250e264808.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e53b113a7edfa8fbe68fd6a45503f2250e264808.1749063024.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 04, 2025 at 04:37:49PM -0300, Jonathan Santos wrote:
> Ad7768-1 has a different -3db frequency multiplier depending on
> the filter type configured. The cutoff frequency also varies according
> to the current ODR.
> 
> Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> the user which bandwidth is being allowed depending on the filter
> configurations.

...

> +/*
> + * -3dB cutoff frequency multipliers (relative to ODR) for
> + * each filter type. Values are multiplied by 1000.

Instead of the second sentence in the comments...

> + */
> +static const int ad7768_filter_3db_odr_multiplier[] = {
> +	[AD7768_FILTER_SINC5] = 204,

...just add a comment on each line

	[AD7768_FILTER_SINC5] = 204,		/* 0.204 */

> +	[AD7768_FILTER_SINC3] = 262,
> +	[AD7768_FILTER_SINC3_REJ60] = 262,
> +	[AD7768_FILTER_WIDEBAND] = 433,
> +};

At least to me it will look much better as it immediately gives the actual
(float) value in accordance to the datasheet, right?

...

>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = st->oversampling_ratio;
>  
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		temp = st->samp_freq * ad7768_filter_3db_odr_multiplier[st->filter_type];
> +		*val = DIV_ROUND_CLOSEST(temp, 1000);
> +
>  		return IIO_VAL_INT;

Just wondering if you are using --histogram diff algo when preparing the
patches to send. If not, please do. (The above suggests that you don't use
or in unlike event that algo can't really catch the same return line in
different blocks.)

-- 
With Best Regards,
Andy Shevchenko



