Return-Path: <linux-iio+bounces-21663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B333B05490
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682483ACB2B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5BE25CC64;
	Tue, 15 Jul 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bmf47ibC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AA1DED5F;
	Tue, 15 Jul 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567491; cv=none; b=e4N2CN0rFqC39OMO2wJdt0aLZk2pSQa/4Sq6IsmJXzpQUHgVBRryOyAUYf4mu/gY3qGF8+GY9Yozc+i4S1gPUDtReJUuwYqJIwa7vS9fF7DD3zlmKnC7vSiJuK5nSUKjlqOVVyj5um4jJE25huYe0RXa9J0H1p65spmFi6wTrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567491; c=relaxed/simple;
	bh=GR5AzgsuP15s2T63aa+aJNSu2oT+RJqnrJLmc3TqPcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QclrAnk1kjstHBKJp2NWcEQx8J7e+sAJzzqHXfJCrPmeogsFQbDmDt7YUYtiu4eMxK+Agvag4/uG8B0WOI4qcSP7H3nNev4OFG3CqvncQ3edsSUNXfu2kiduG84sGh+jHr0eeFmpMZKHaKZzs338PR9TothEkoVO6GSP9C+ugWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bmf47ibC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752567490; x=1784103490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GR5AzgsuP15s2T63aa+aJNSu2oT+RJqnrJLmc3TqPcw=;
  b=Bmf47ibCXac96SulOpnsxkNXuJXgBZCgfyuUrXNye8SG6AyFp0svdSgU
   ylYf/Uz8saBBU3/HVo3plFLtMFVoo7kB8nV4M+tf/aWFaqc710nfqY9fn
   vEPT9Yqe3BWGXI4+RFrKEpeOMSbjRSoBQXil0d1NUtmzDBQndFbJKkF5f
   vJ0ZAcj//dZncyfn5ZWa1768sIMXd4aGqd6IPljM2X5HeskknKbnafeVN
   1RWLb6oe7FyZW048b1YL36kxN1C0c9yp5lRDDA7Pi7lfdXdyFtaTcDQmY
   IJXpJDZAmACGD579tow4cRDY80Qz5h35ROOctWMD2NPZ0oxjhkN0Ul9Vn
   g==;
X-CSE-ConnectionGUID: CYDHJug/Tk6/uOE4blYSJA==
X-CSE-MsgGUID: xWACsmMfTC+L0aBE9OixiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54630779"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54630779"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:18:09 -0700
X-CSE-ConnectionGUID: 4IShovDJTZS3uozcLCnM1A==
X-CSE-MsgGUID: eWsigi4fRj+TBl74t6GUuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156571470"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:18:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubarT-0000000Fasp-20cj;
	Tue, 15 Jul 2025 11:18:03 +0300
Date: Tue, 15 Jul 2025 11:18:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
Message-ID: <aHYOuzdQ_jSKA898@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-3-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:20:18PM -0400, Sean Anderson wrote:
> Add an in-kernel API for reading/writing event properties. Like the
> raw-to-processed conversion, with processed-to-raw we only convert the
> integer part, introducing some round-off error.
> 
> A common case is for other drivers to re-expose IIO events as sysfs
> properties with a different API. To help out with this, iio_event_mode
> returns the appropriate mode. It can also be used to test for existence
> if the consumer doesn't care about read/write capability.

...

> +EXPORT_SYMBOL_GPL(iio_event_mode);

Can we move this to namespace? Otherwise it will be never ending story...
Ditto for other new APIs.

...

> +			if (scale64 <= INT_MAX && scale64 >= INT_MIN)
> +				raw64 = processed / (int)scale64;

Do you need the casting? (I mean if the compiler is dumb enough to not see this)

...

> +		case IIO_VAL_INT_PLUS_MICRO:
> +			scale64 = scale_val * scale * 1000000LL + scale_val2;
> +			raw64 = div64_s64_rem(processed, scale64, &r);
> +			raw64 = raw64 * 1000000 +
> +				div64_s64(r * 1000000, scale64);

Logically this should be 1000000L, but can we somehow use the constants?
Like

			scale64 = (s64)MICRO * scale_val * scale + scale_val2;
			raw64 = div64_s64_rem(processed, scale64, &r);
			raw64 = raw64 * (s32)MICRO +
				div64_s64(r * (s64)MICRO, scale64);


> +			break;

Ditto for other cases?

...

> +	*raw = clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);

You already have similar approach here...

...

> +	ret = iio_convert_processed_to_raw_unlocked(chan, processed, &raw,
> +						    scale);
> +	if (ret < 0)

Why ' < 0' ?

> +		return ret;

-- 
With Best Regards,
Andy Shevchenko



