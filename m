Return-Path: <linux-iio+bounces-25979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0EC3C47B
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 17:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C42B4F4B21
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0D33CEA1;
	Thu,  6 Nov 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULtLdBXd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5C316918;
	Thu,  6 Nov 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445247; cv=none; b=ZKBQYzdYTCPqSnK0LYhp5vqA9n4LLdZFwrO5Qy7McnrHAcsVFBryQLXILNKReQ14A4BOnS6wcrJwiZ2dZxIR5tb4vie1RIFb9BD+n21aLqVE4cFgfElDz0iuyAHVRBd8k/HEPhGVu3npPYVU546B0rZAqTvZFyPaHSJkDZS2jDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445247; c=relaxed/simple;
	bh=SbAz1dDS4lGDeM9FWy6nLhyTEHqSyFKNrQiQdkYRtqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUP2yG81d/zLQy9jqLodXMm90uWGV5pfPf8CiPxhKu+0Ku6IZN+zoWc1UDnLsrujxjx0IFcbLikxbzY5ORLYDck+MgnJrCoGJ9fxGEZgVEYxNnxdv3vQpeZ8nmfF8jaG+1jEfPaXGz2CAs2+p61kRCcmyZMV4Xqj9oSuOByHyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULtLdBXd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445245; x=1793981245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SbAz1dDS4lGDeM9FWy6nLhyTEHqSyFKNrQiQdkYRtqE=;
  b=ULtLdBXdJUgpKbjcSsLkbbmzSaiuP89PFBRX/pb7WCP69TbVvaMuzX1V
   kA/Xq0M6KpAg0OzKEvXRQn1nSxYmQSI+CkySBs+CKOizHhDMtkDrV6MWt
   k0JfUDkGnbSQogQrzn68mc+jBpeceFdJMSyAdo9uXxTWQ0reUZbwRFsRw
   kpy87CjRowBJTKYpcJAbJbdShXpcMrEAK+DIPvOOCkHkPDnl+rqLZttmf
   sntr4ERF2agrIW1dy0GPbIkQDFmGHwF2JoxGkI6PhqvNxi37Z/Mrztr3R
   y8n27HxS5vKCjZgQT39WtQUmuPnTNGk3hqxAUN3j3ilOfXsW5RX/ITEAI
   g==;
X-CSE-ConnectionGUID: ivy8FE9RRXqDfGvzV9cAug==
X-CSE-MsgGUID: sbtaZjGxTV20ZDb+FVBPpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64469941"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64469941"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:07:24 -0800
X-CSE-ConnectionGUID: xyGQLGVLSAGvFCLnQ0FfRg==
X-CSE-MsgGUID: QGNNY7BrSregxim4Q2AYIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218545205"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:07:21 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH2W6-00000006BoP-1d52;
	Thu, 06 Nov 2025 18:07:18 +0200
Date: Thu, 6 Nov 2025 18:07:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: add processed write API
Message-ID: <aQzHtqFEIA5E0ikO@smile.fi.intel.com>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-2-fd1feae0f65a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-ltm8054-driver-v3-2-fd1feae0f65a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 03:11:47PM +0100, Romain Gantois wrote:
> Add a function to allow IIO consumers to write a processed value to a
> channel.

...

> +int iio_divide_by_value(int *result, s64 numerator,
> +			unsigned int type, int val, int val2)
> +{
> +	s64 tmp_num, tmp_den;
> +
> +	switch (type) {
> +	case IIO_VAL_INT:
> +		tmp_num = numerator;
> +		tmp_den = val;
> +		break;
> +	case IIO_VAL_INT_PLUS_MICRO:
> +	case IIO_VAL_INT_PLUS_NANO:
> +		switch (type) {
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp_num = MICRO;
> +			tmp_den = MICRO;
> +			break;
> +
> +		case IIO_VAL_INT_PLUS_NANO:
> +			tmp_num = NANO;
> +			tmp_den = NANO;
> +			break;
> +		}

> +		tmp_num *= numerator;
> +		tmp_den = (s64)abs(val) * tmp_den + (s64)abs(val2);

Here is a subtle bug. The problematic piece is abs(). See
https://lore.kernel.org/r/20251106152051.2361551-1-andriy.shevchenko@linux.intel.com
for the answer.

> +		if (val < 0 || val2 < 0)
> +			tmp_num *= -1;

Drop that duplication of the switches above and split the calculations. Note,
with the split done, the confusing assignments of tmp_den will gone as well.

> +		break;
> +	case IIO_VAL_FRACTIONAL:
> +		tmp_num = (s64)numerator * (s64)val2;
> +		tmp_den = val;
> +		break;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp_num = (s64)numerator << val2;
> +		tmp_den = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!tmp_den)
> +		return -ERANGE;
> +
> +	*result = div64_s64(tmp_num, tmp_den);
> +
> +	return IIO_VAL_INT;
> +}

...

> +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,

> +	if (offset_type >= 0) {

Why?

> +		switch (offset_type) {
> +		case IIO_VAL_INT:
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			half_step = MICRO / 2;
> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			half_step = NANO / 2;
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			offset_val = DIV_ROUND_CLOSEST(offset_val, offset_val2);
> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			offset_val >>= offset_val2;
> +			break;

> +		default:

You probably wanted to check it here.

> +			return -EINVAL;



> +		}
> +
> +		/* Round fractional part to closest to reduce rounding bias. */
> +		if (half_step) {
> +			if (offset_val2 >= half_step)
> +				*raw -= 1;
> +			else if (offset_val2 <= -half_step)
> +				*raw += 1;
> +		}
> +
> +		*raw -= offset_val;
> +	}

...

> +EXPORT_SYMBOL_GPL(iio_write_channel_processed_scale);

Can we start using namespaced exports?

...

> +/**
> + * iio_divide_by_value() - Divide by an IIO value
> + * @result:	Destination pointer for the division result
> + * @numerator:	Numerator.
> + * @type:	One of the IIO_VAL_* constants. This decides how the @val
> + *		and @val2 parameters are interpreted.
> + * @val:	Denominator.
> + * @val2:	Denominator. @val2 use depends on type.
> + *
> + * Divide an s64 number by an IIO value, storing the result as

s64 number --> @numerator

> + * IIO_VAL_INT. This is typically used for scaling.
> + *
> + * Returns:
> + * IIO_VAL_INT on success or a negative error-number on failure.

Use % for the constants. It will be rendered differently (font) when
applicable. Same for other constants in all of the kernel-doc you add.

> + */

...

> +/**
> + * iio_write_channel_processed_scale() - scale and write processed value to a given channel
> + * @chan:		The channel being queried.
> + * @val:		Value to write.
> + * @scale:		Processed value is divided by this scale factor during the conversion.
> + *
> + * This function writes a processed value to a channel. A processed value means
> + * that this value will have the correct unit and not some device internal
> + * representation. If the device does not support writing a processed value, the
> + * function will query the channel's scale and offset and write an appropriately
> + * transformed raw value.

> + * Context: May sleep.

The above kernel-doc doesn't have this!

> + * Return: an error code or 0.

Be consistent with the existing code, and even in your own change.

("Return" section name, "Context" section presence, etc.)

Use Perl (original) kernel-doc for now, the Python has a significant regression
(the fix is pending to go to Linus' branch).

-- 
With Best Regards,
Andy Shevchenko



