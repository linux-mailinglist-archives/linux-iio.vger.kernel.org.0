Return-Path: <linux-iio+bounces-20896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BFAE3AD9
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 11:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7638916D3D9
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E522DF86;
	Mon, 23 Jun 2025 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntrFiZG/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026522940F;
	Mon, 23 Jun 2025 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671873; cv=none; b=ZwqS+nasEOl0kuA+JtjsWVnX4uooR9xGfVc95N3u/8uam0rpdHxaSoCpW2m3PwULi1th8vaLciq5ABFZ7stA2PWbHVnKDxn44ZqwMWXeFMJ2S1fWHXoAoOVHv9HfB/XKFBisU2tzx1arOQ0sgrPJC7MVliKnogAJNupv5vFbz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671873; c=relaxed/simple;
	bh=0E/AaZN6qOMuMlMCYG2o1/Ze/MndbrvBCcrhbvfO9Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpEd5U/IFxFvCFTIWp7pUJmvc1PByt5E+8AdsSEwx50p32cQKZuJh3mhi0V6uz5cdKAABvgzy9VmlSGLEGWMnDF0SDbF5hh/0daS9yR+2fuagwQ4qTXmc6po3w4QVfYRqAKQd3+8ZR6vx/Bb4f+bTdVtGbTEmf0wHJ0jfzSgsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntrFiZG/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750671872; x=1782207872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0E/AaZN6qOMuMlMCYG2o1/Ze/MndbrvBCcrhbvfO9Ms=;
  b=ntrFiZG/bI1uaGcJw0qh7QtJNu1wb35vdaaSRDx4XmS4JW4EhYiRH2HI
   DUpcm64FRFSvv+f0YkZOWSqLqCOD3Gfzcys/ddrquEzuPBZVVQaqChHs9
   NVLrCXQcE4gSxqwxBkgWVpE2MB8N+zr+W58xjix54Ol33emLMccBzgkTp
   +oLHCG+PuWu/uifmGQp91V6Fq1+tCSDE6KraA9puVXAzutsZq4OQjQnUN
   eUgsWNvwSWhzhPItqSB4S01sfcD/zai5UkkU7Ip4Kt1xpWnterqfrnFEP
   /Zs/wwN6DMbbGV84L/gew6lKElQuO+l70uFkP6mwDXrV9L1UbJi5vd0v5
   g==;
X-CSE-ConnectionGUID: k7XhyCbEQrCZndlpCZ709A==
X-CSE-MsgGUID: 78klbsd7Tcuyd+Q38v/skg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="70438468"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="70438468"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:44:31 -0700
X-CSE-ConnectionGUID: vrNO2kbtRN6+XVxw1vmkOw==
X-CSE-MsgGUID: fsNGcGK7QA+tT23BwSybFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="157336260"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:44:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTdiy-000000097qN-2V8z;
	Mon, 23 Jun 2025 12:44:24 +0300
Date: Mon, 23 Jun 2025 12:44:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
Message-ID: <aFkh-E1dG__p_G4m@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-5-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250622155010.164451-5-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 22, 2025 at 03:50:07PM +0000, Lothar Rubusch wrote:
> Add support for the sensor’s inactivity feature in the driver. When both
> activity and inactivity detection are enabled, the sensor sets a link bit
> that ties the two functions together. This also enables auto-sleep mode,
> allowing the sensor to automatically enter sleep state upon detecting
> inactivity.
> 
> Inactivity detection relies on a configurable threshold and a specified
> time period. If sensor measurements remain below the threshold for the
> defined duration, the sensor transitions to the inactivity state.
> 
> When an Output Data Rate (ODR) is set, the inactivity time period is
> automatically adjusted to a sensible default. Higher ODRs result in shorter
> inactivity timeouts, while lower ODRs allow longer durations-within
> reasonable upper and lower bounds. This is important because features like
> auto-sleep operate effectively only between 12.5 Hz and 400 Hz. These
> defaults are applied when the sample rate is modified, but users can
> override them by explicitly setting a custom inactivity timeout.
> 
> Similarly, configuring the g-range provides default threshold values for
> both activity and inactivity detection. These are implicit defaults meant
> to simplify configuration, but they can also be manually overridden as
> needed.

...

> +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> +{
> +	int max_boundary = U8_MAX;
> +	int min_boundary = 10;
> +	unsigned int val = min(val_s, U8_MAX);

Wondering if it's possible to refer here to max_boundary?
In any case, split this assignment since it will be easier
to maintain.

> +	enum adxl345_odr odr;
> +	unsigned int regval;
> +	int ret;

	val = min(val_s, max_boundary);

> +	if (val == 0) {
> +		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
> +		if (ret)
> +			return ret;
> +
> +		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> +		val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
> +			    min_boundary, max_boundary);
> +	}
> +
> +	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +}

...

> +	case ADXL345_INACTIVITY:
> +		en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
> +			FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
> +			FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);

As I pointed out earlier. the indentation is supposed to be on the same colomn
for 'F' letters.

> +		if (!en)
> +			return false;
> +		break;

...

> +			ret = regmap_read(st->regmap,
> +					  ADXL345_REG_TIME_INACT,
> +					  &period);

There is plenty of room on the previous lines. Depending on the next
changes (which I believe unlikely touch this) it may be packed to two
lines with a logical split, like

			ret = regmap_read(st->regmap,
					  ADXL345_REG_TIME_INACT, &period);

It again seems the byproduct of the too strict settings of the wrap limit in
your editor.

...

> +	case ADXL345_INACTIVITY:
> +		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> +				ADXL345_INACT_Z_EN;

Consider
		axis_ctrl =
			ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | ADXL345_INACT_Z_EN;

(yes, I see that it's longer than 80, but it might worth doing it for the sake of
 consistency with the previous suggestion).


...

>  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
>  {
> -	return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,

> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
>  				 ADXL345_DATA_FORMAT_RANGE,
>  				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
> +	if (ret)
> +		return ret;

If it's a code from the previous patch, it might make sense to introduce ret
there.

>  }

...

> +	case IIO_EV_INFO_PERIOD:
> +		ret = regmap_read(st->regmap,
> +				  ADXL345_REG_TIME_INACT,
> +				  &period);

Too short lines.

-- 
With Best Regards,
Andy Shevchenko



