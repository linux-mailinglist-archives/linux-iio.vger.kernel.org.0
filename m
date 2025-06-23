Return-Path: <linux-iio+bounces-20899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92381AE3C09
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC2166C66
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1FE2185BD;
	Mon, 23 Jun 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSpZevIc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF483594B;
	Mon, 23 Jun 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673864; cv=none; b=K9k8n73o6QYHgPKrih2EFSEOCRbpBU7EMh7rf7sErUDCKDSOH3R0eOgqCNmWVJnz0B+9IpCCIrRyLgZHyT0YPNnlbhRhzQxj8hrGuMeiwb0zEtn/4FdH2UN6vWjbNQ+7yRFfBzNqYPpf6EoVvOWQI35OebV7IKjwGfaqKgDNT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673864; c=relaxed/simple;
	bh=yV7882rsHr2RnMe45/OkrAOQZHM9Ha8lI3Ma6OgCRL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx2c5wK11jcbxVcVBjdH8B6ivViZ9ZOAYDuDvqWTqhmtv3UzDiwjMLLtwC8qRcUr+bwSEHdku/HryNMfiucny8F8CUfPv/XYLb7mUcG/nrSIaNOtWU85QTwWaERaQ7D++LqyMcH98CrkVFRZIlZQV5PeIqBZp0lX2dw4s+Wt5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSpZevIc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750673862; x=1782209862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yV7882rsHr2RnMe45/OkrAOQZHM9Ha8lI3Ma6OgCRL8=;
  b=FSpZevIcdfBoDW7UcLLULImBl2djK6dNQZ+hvOJTmMlf9BWVqP6mTAkT
   VkfoTQXbgnfNj92+xxYcUKNqNYrmUQ1yN5UiLjosOb7uwWoqaldX7hvlT
   HtuU2MxclvqmK39cTj3NqgEhmtXJ7hCRATPIpyUCDIf1K2wZ9XUJlnNyA
   GTK+A+k9euEY8I87SASrpODIiTjjt8VKmUN1icAPQpw6myn6i77SgeAXO
   ulJSpSnR2HASKLHlFRfHh0B15XtvYKUwvHU09jo6XYLInS2sBlXp6Maxg
   Xsm12rnDtCzciWmGqxVzYEF17boigecNzqWfiTPzxO7XlqlveWEbk59qK
   w==;
X-CSE-ConnectionGUID: tMwtBhFRTFeLhknJyDOGng==
X-CSE-MsgGUID: 1NYrkfINSu2NaI2CwGOIzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="64229757"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="64229757"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:17:41 -0700
X-CSE-ConnectionGUID: NjPYF6FNTG2kWw/01TFTUA==
X-CSE-MsgGUID: OCIGEnYkSE+NfXAsTwnM1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="150980983"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:17:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTeF5-000000098RB-1mej;
	Mon, 23 Jun 2025 13:17:35 +0300
Date: Mon, 23 Jun 2025 13:17:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 6/7] iio: accel: adxl345: extend inactivity time for
 less than 1s
Message-ID: <aFkpv0CUkateel8q@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-7-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622155010.164451-7-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 22, 2025 at 03:50:09PM +0000, Lothar Rubusch wrote:
> Inactivity and free-fall events are essentially the same type of sensor
> events. Therefore, inactivity detection (normally set for periods between 1
> and 255 seconds) can be extended for shorter durations to support free-fall
> detection.
> 
> For periods shorter than 1 second, the driver automatically configures the
> threshold and duration using the free-fall register. For periods longer
> than 1 second, it uses the inactivity threshold and duration using the
> inactivity registers.
> 
> When using the free-fall register, the link bit is not set, which means
> auto-sleep cannot be enabled if activity detection is also active.

...

> -static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_int,
> +				  u32 val_fract)
>  {
>  	int max_boundary = U8_MAX;
>  	int min_boundary = 10;
> -	unsigned int val = min(val_s, U8_MAX);
> +	unsigned int val;

You see, I even suggested splitting this assignment to begin with.
The change will be clearer with that done.

>  	enum adxl345_odr odr;
>  	unsigned int regval;
>  	int ret;
>  
> -	if (val == 0) {
> +	if (val_int == 0 && val_fract == 0) {
> +		/* Generated inactivity time based on ODR */
>  		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
>  		if (ret)
>  			return ret;

>  		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
>  		val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
>  			    min_boundary, max_boundary);
> +		st->inact_time_ms = MILLI * val;
> +
> +		/* Inactivity time in s */
> +		return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	} else if (val_int == 0 && val_fract > 0) {

val_fract check is not needed here.

> +		/* time < 1s, free-fall */
> +
> +		/*
> +		 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
> +		 *
> +		 * Recommended values between 100ms and 350ms (0x14 to 0x46)
> +		 */
> +		st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
> +
> +		return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> +				    DIV_ROUND_CLOSEST(val_fract, 5));
> +	} else if (val_int > 0) {

if now is redundant here, right?

> +		/* Time >= 1s, inactivity */
> +		st->inact_time_ms = MILLI * val_int;
> +
> +		return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
>  	}
>  
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	/* Do not support negative or wrong input. */
> +	return -EINVAL;
>  }

-- 
With Best Regards,
Andy Shevchenko



