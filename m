Return-Path: <linux-iio+bounces-20543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C932AD6FF3
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E511BC4FA7
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996F1865EB;
	Thu, 12 Jun 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dqbsgbss"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431C2F4338;
	Thu, 12 Jun 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730524; cv=none; b=d4e25pEN4s5D7WK7bRLknO4DX/wAsiYzw6C7IMm+wPILnxpEVsR1uoo/3tjUM3eULc2Q2bUqxvscRd6NHp9kBxgvDxppo/1VhCBCOth4y/b5bpUiWRU+4Nnvs8pkithOWbM1//t7HvSbjGbCYaZA1VRudySny3T66qFiUJV58V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730524; c=relaxed/simple;
	bh=SEs2j+fKgl/2ov7h4rZaMSfSjXIEe+/fSs1zEnX0EuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR5Q0JINEcqSqPi8DNS+nbVNIrsVhF/1r7lJ1kfs27bfOeBxZivLDKceUvdqFdRal5gvCG/ZTrZUVC7QaaKzY5WqnEsFwz5qShAsCv7SAfOIxoXgZgRoUAx5mXB6OWPsefGgjNIaBA7kZ+sAd042VlrxEJgA/SccqfRCKTVIxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dqbsgbss; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749730523; x=1781266523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEs2j+fKgl/2ov7h4rZaMSfSjXIEe+/fSs1zEnX0EuY=;
  b=DqbsgbssxtFJlbegxMJXfTrk09uUaAuEl5W/cEl3ck4kDno+9aOgbz/o
   eCRUW0Ri0bHopQWa8NTY8mWlW5S0wsKBOzZxjDixFfJtIuMaRKCoUxvoK
   Tw0espqJIh1XWkpZjBhl2VkIrB1XCHK2laPcSfv+9ZXqxlSZo7++qomYr
   bkiXxj8PnpWr2UcOC5JUsqK5X/g+MmZFMm1+RFj92yXkxJHEZFs8zUX9h
   /o6E8JJgTKJHlgcp9/m3upD/dSL5MDXuzp3IiJXqmqdrkikLZRt7tupZ9
   C644JmevJZRuXgX1HN0cUTnUGlYemlUNxc01Vfe+JwwxmNU2Jvo8DR2Se
   Q==;
X-CSE-ConnectionGUID: o25NS/IqTvSmGrqIwR33BA==
X-CSE-MsgGUID: b19mZ9IaRAC0E91BpaBqNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="55579483"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="55579483"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:15:22 -0700
X-CSE-ConnectionGUID: mlZxuIRSQL6AppBv1TJt+w==
X-CSE-MsgGUID: K9pnUkGYRBOhmJ7qtqpzIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147410548"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:15:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPgpv-00000005wdj-3Lmw;
	Thu, 12 Jun 2025 15:15:15 +0300
Date: Thu, 12 Jun 2025 15:15:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
Message-ID: <aErE0xmlm4qBHg03@smile.fi.intel.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
 <20250610215933.84795-9-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610215933.84795-9-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 10, 2025 at 09:59:30PM +0000, Lothar Rubusch wrote:
> Add the inactivity feature of the sensor to the driver. When activity
> and inactivity are enabled, a link bit will be set linking activity and
> inactivity handling. Additionally, the auto-sleep mode will be enabled.
> Due to the link bit the sensor is going to auto-sleep when inactivity
> was detected.
> 
> Inactivity detection needs a threshold to be configured and a period of
> time in seconds. After, it will transition to inactivity state, if
> measurements stay below inactivity threshold.
> 
> When a ODR is configured the period for inactivity is adjusted with a
> corresponding reasonable default value, in order to have higher
> frequencies, lower inactivity times, and lower sample frequency but
> give more time until inactivity. Both with reasonable upper and lower
> boundaries, since many of the sensor's features (e.g. auto-sleep) will
> need to operate between 12.5 Hz and 400 Hz. This is a default setting
> when actively changing sample frequency, explicitly setting the time
> until inactivity will overwrite the default.
> 
> Similarly, setting the g-range will provide a default value for the
> activity and inactivity thresholds. Both are implicit defaults, but
> equally can be overwritten to be explicitly configured.

...

> +static const struct iio_event_spec adxl345_fake_chan_events[] = {
> +	{
> +		/* inactivity */
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_PERIOD),

Slightly better

		.mask_shared_by_type =
			BIT(IIO_EV_INFO_VALUE) |
			BIT(IIO_EV_INFO_PERIOD),

> +	},
> +};

And the same for other similar cases.

...

> +/**
> + * adxl345_set_inact_time - Configure inactivity time explicitly or by ODR.
> + * @st: The sensor state instance.
> + * @val_s: A desired time value, between 0 and 255.
> + *
> + * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0
> + * is configured by a user, then a default inactivity time will be computed.
> + *
> + * In such case, it should take power consumption into consideration. Thus it
> + * shall be shorter for higher frequencies and longer for lower frequencies.
> + * Hence, frequencies above 255 Hz shall default to 10 s and frequencies below
> + * 10 Hz shall result in 255 s to detect inactivity.
> + *
> + * The approach simply subtracts the pre-decimal figure of the configured
> + * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz are thus
> + * ignored in this estimation. The recommended ODRs for various features
> + * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.5 Hz and
> + * 400 Hz, thus higher or lower frequencies will result in the boundary
> + * defaults or need to be explicitly specified via val_s.
> + *
> + * Return: 0 or error value.
> + */
> +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> +{
> +	unsigned int max_boundary = 255;
> +	unsigned int min_boundary = 10;
> +	unsigned int val = min(val_s, max_boundary);
> +	enum adxl345_odr odr;
> +	unsigned int regval;
> +	int ret;
> +
> +	if (val == 0) {
> +		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
> +		if (ret)
> +			return ret;
> +
> +		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);

> +		val = (adxl345_odr_tbl[odr][0] > max_boundary)
> +			? min_boundary : max_boundary -	adxl345_odr_tbl[odr][0];

clamp() ?

> +	}
> +
> +	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +}

...

>  	if (type == ADXL345_ACTIVITY) {
>  		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
>  				ADXL345_ACT_Z_EN;
>  	} else {
> -		axis_ctrl = 0x00;
> +		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> +				ADXL345_INACT_Z_EN;
>  	}

Now this can be as simple as

	axis_ctrl = ADXL345_ACT_X_EN;
	if (type == ADXL345_ACTIVITY)
		axis_ctrl |= ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
	else
		axis_ctrl |= ADXL345_INACT_Y_EN | ADXL345_INACT_Z_EN;

Yeah, I don't know how to make the diff better (it gets worse), but the end
result is better.

One way, which I don't like much is to previously have this conditional written as:

	axis_ctrl = ADXL345_ACT_X_EN;
	if (type == ADXL345_ACTIVITY)
		axis_ctrl |= ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
	else
		axis_ctrl = 0;

...

> +	ret = regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
> +				 (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK),

Unneeded parentheses.

> +				 en);
>  	if (ret)
>  		return ret;

...

>  static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
>  {
> -	return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
>  				 ADXL345_BW_RATE_MSK,
>  				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
> +	if (ret)
> +		return ret;
> +
> +	/* update inactivity time by ODR */
> +	return adxl345_set_inact_time(st, 0);

Okay, in this case the initial form of

	int ret;

	ret = ...
	if (ret)
		return ret;

	return 0;


will be better with the respectful comment (as Jonathan suggested) in that
change that this is not optimal as standalone change, but it will help reduce
churn in the next change(s).

>  }

...

>  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
>  {
> -	return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,

Same here.

> +	unsigned int act_threshold, inact_threshold;
> +	unsigned int range_old;
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval);
> +	if (ret)
> +		return ret;
> +	range_old = FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> +
> +	ret = regmap_read(st->regmap,
> +			  adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +			  &act_threshold);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap,
> +			  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> +			  &inact_threshold);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
>  				 ADXL345_DATA_FORMAT_RANGE,
>  				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
> +	if (ret)
> +		return ret;
> +
> +	act_threshold = act_threshold * adxl345_range_factor_tbl[range_old]
> +		/ adxl345_range_factor_tbl[range];
> +	act_threshold = min(U8_MAX, max(1, act_threshold));
> +
> +	inact_threshold = inact_threshold * adxl345_range_factor_tbl[range_old]
> +		/ adxl345_range_factor_tbl[range];
> +	inact_threshold = min(U8_MAX, max(1, inact_threshold));
> +
> +	ret = regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +			   act_threshold);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> +			   inact_threshold);
>  }

-- 
With Best Regards,
Andy Shevchenko



