Return-Path: <linux-iio+bounces-26555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 221FFC93038
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 855D834CE9A
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990B332919;
	Fri, 28 Nov 2025 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNEe8VWr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813B2080C8;
	Fri, 28 Nov 2025 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764357959; cv=none; b=UgkEbjMDgDLm0nfxhe7QRv+5xWs9TWiGqaoegIbapEJRC4qQaEkXsm50bYq6/GVNU/82dsE2h/BZB9bC0uUrfVqeZDN8uviE2VllG2k0RKOrMtK5qmv1HaqpDMql18sEPj1I//W6rIiPVlOIPafMqXI+CRdWpaIvJvPLsK/SJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764357959; c=relaxed/simple;
	bh=ZgJg19JgVapqtEPwhxxKRypueCcS657c0JxAgQtWkMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud8W+QLTnEEPhNEUcjylXtKL/nOZZBC5sdcsOxrXzNaV/38Di9dl3V4qRtUwcNgiB0LaHdBPFwm6NxveBjjJJgyh6ZcUH+ir9lYmeePVwb6wiMAj+ImrnmmGo1Rp+Kbri2YDigm0evysANlQ2vSSR7xxB5AYoQcVUO1uUBrgimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNEe8VWr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764357958; x=1795893958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZgJg19JgVapqtEPwhxxKRypueCcS657c0JxAgQtWkMk=;
  b=NNEe8VWrVO7M40Ry48W+bzgwdwoJneBDaOXmp18kTfWNk/Z1GreQDtCO
   7qFATVcNHlwxBNuwkQawtefOoJW9h9Axr6Ds5f6vhohaBLnnIm8HAu8DB
   r05QD0Vxec/dgViut2ABgdcnElV/xDt9CfX7bd4hWYZXVOhTzELF1CO08
   1PKUnyxS6bgFoY+bJhp9MqvkglCwhK/POnQlSEqzsHD/0AG4ZCJQ8atY/
   4kPI3A98k2snFJySOdlZ/wCh6cS8+7RR/Q8TH3MtFlyMms855n5AUp6lF
   Sc43+ho51yHQ2V63aSI7QQ2zd8Bda3RbDPgTMIK0Apqlmf5DCZtylPt/e
   g==;
X-CSE-ConnectionGUID: D7jH7Jp1QIylLMOiDbt1fg==
X-CSE-MsgGUID: D7eRvhlHRQqnP1jkEOlTIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="66339621"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66339621"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 11:25:57 -0800
X-CSE-ConnectionGUID: Vn3gvOaiSiazneVBYPV21w==
X-CSE-MsgGUID: xgpQSso1RDSsHXKA92I+Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="193419743"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.17])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 11:25:53 -0800
Date: Fri, 28 Nov 2025 21:25:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/9] iio: adc: Add support for ad4062
Message-ID: <aSn3PthKIvFAhDS6@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-3-a375609afbb7@analog.com>
 <aSQxiSoZcI_ol3S5@smile.fi.intel.com>
 <aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
 <aSgSsGSUuBtMOuro@smile.fi.intel.com>
 <zryqws2h2i4duejczo2rptwhlzhile7fa7brriqh2hmtarwjxn@cr2cyzymwpav>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zryqws2h2i4duejczo2rptwhlzhile7fa7brriqh2hmtarwjxn@cr2cyzymwpav>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 07:50:02PM +0100, Jorge Marques wrote:
> On Thu, Nov 27, 2025 at 10:58:24AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 26, 2025 at 12:40:00PM +0100, Jorge Marques wrote:
> > > On Mon, Nov 24, 2025 at 12:20:57PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 24, 2025 at 10:18:02AM +0100, Jorge Marques wrote:

Please, remove the context you are agree with or which has no need
to be answered, it helps to parse and reply.

...

> > > > > +static int ad4062_calc_sampling_frequency(int fosc, unsigned int n_avg)
> > > > > +{
> > > > > +	/* See datasheet page 31 */
> > > > > +	u64 duration = div_u64((u64)(n_avg - 1) * NSEC_PER_SEC, fosc) + AD4062_TCONV_NS;
> > > > > +
> > > > > +	return DIV_ROUND_UP_ULL(NSEC_PER_SEC, duration);
> > > > 
> > > > Why u64?
> > > > 
> > > > The DIV_ROUND_UP_ULL() seems an overkill here. Or do you expect duration be
> > > > more than 4 billions?
> > > > 
> > > This is necessary since at fosc 111 Hz and avg 4096 it does take longer
> > > than 4 seconds, even though I do timeout after 1 seconds in the raw
> > > acquisition.
> > 
> > Values above NSEC_PER_SEC+1 do not make sense (it will return 0),
> > and that fits u32. Can you refactor to avoid 64-bit arithmetics?
> 
> Ok, any frequency lower than 1 Hz does not make sense.

Depends on the cases, we have sub-Hz sensors or some other stuff.
So, "...does not make sense in _this_ case." That's what I implied.

>   static int ad4062_calc_sampling_frequency(int fosc, unsigned int oversamp_ratio)

Shouldn't fosc be unsigned?

>   {
>   	/* See datasheet page 31 */

It's fine, but better to add a formula here or more information about
the calculations done in the function.

>   	u32 period = NSEC_PER_SEC / fosc;

period_ns ?

(We usually add units to this kind of variables for better understanding
 of the calculations)

>   	u32 n_avg = BIT(oversamp_ratio) - 1;
>   
>   	/* Result is less than 1 Hz */
>   	if (n_avg >= fosc)
>   		return 1;

+ blank line.

>   	return NSEC_PER_SEC / (n_avg * period + AD4062_TCONV_NS);
>   }

LGTM, thanks!

> > > > > +}

...

> > >   static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
> > >   				      int gain_frac)
> > >   {
> > >   	u32 gain;
> > >   	int ret;
> > >   
> > >   	if (gain_int < 0 || gain_frac < 0)
> > >   		return -EINVAL;
> > >   
> > >   	gain = gain_int * MICRO + gain_frac;
> > >   	if (gain > 1999970)
> > 
> > But this magic should be changed to what you explained to me
> > (as in 0xffff/0x8000 with the proper precision, and this
> >  can be done in 32-bit space).
> > 
> > Or even better
> > 
> > 	if (gain_int < 0 || gain_int > 1)
> > 		return -EINVAL;
> > 
> > 	if (gain_int == 1 && gain_frac > 0x7fff) // did I get this right?
> > 		return -EINVAL;

> gain_frac would be 999999 max, or 999970 for the limit that fits in the
> register after the math. I think > 1.999.970 is self explanatory.

On the place of unprepared reader this is a complete magic number without
scale, without understanding where it came from, etc.

So, can you define it as a derivative from the other constants and with
a comment perhaps?

> > >   		return -EINVAL;
> > >   
> > >   	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL((u64)gain * AD4062_MON_VAL_MIDDLE_POINT,
> > >   						 MICRO),
> > 
> > ...with temporary variable at minimum.
> > 
> > But again, I still don't see the need for 64-bit space.
> 
> Well, by dividing mon_val and micro values by a common divisor the
> operation fit in 32-bits:
> 
>   static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
>                                         int gain_frac)
>   {

	/* Divide numerator and denumerator by known great common divider */

>           const u32 mon_val = AD4062_MON_VAL_MIDDLE_POINT / 64;
>           const u32 micro = MICRO / 64;

Yep, I suggested the same in another patch under review (not yours) for
the similar cases where we definitely may easily avoid overflow.

Alternatively you can use gcd().

>           const u32 gain = gain_int * MICRO + gain_frac;
>           int ret;
> 
>           if (gain_int < 0 || gain_frac < 0)
>                   return -EINVAL;
> 
>           if (gain > 1999970)
>                   return -EINVAL;
> 
>           put_unaligned_be16(DIV_ROUND_CLOSEST(gain * mon_val, micro), st->buf.bytes);
> 
>           ret = regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
>                                   &st->buf.be16, sizeof(st->buf.be16));
>           if (ret)
>                   return ret;
> 
>           /* Enable scale if gain is not equal to one */
>           return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
>                                     AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
>                                     FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
>                                                !(gain_int == 1 && gain_frac == 0)));

Btw, I think you can move this check up and save in a temporary variable which
might affect the binary size of the compiled object as accesses to the gain_int
and gain_frac will be grouped in the same place with potential of the reusing
the CPU register(s)..

>   }

> > >   			   st->buf.bytes);
> > >   
> > >   	ret = regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
> > >   				&st->buf.be16, sizeof(st->buf.be16));
> > >   	if (ret)
> > >   		return ret;
> > >   
> > >   	/* Enable scale if gain is not equal to one */
> > >   	return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
> > >   				  AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> > >   				  FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> > >   					     !(gain_int == 1 && gain_frac == 0)));
> > >   }
> > > 
> > > To provide the enough resolution to compute every step (e.g., 0xFFFF and
> > > 0xFFFE) with the arbitrary user input.

-- 
With Best Regards,
Andy Shevchenko



