Return-Path: <linux-iio+bounces-20941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C48AE5F99
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8163AFB25
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B017E2253EE;
	Tue, 24 Jun 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVYWb0mN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A5239072;
	Tue, 24 Jun 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754204; cv=none; b=tBpLgI6cnUMJj8RkGVayYGnwmBQWC9YURwPF2XFBo2bcQVhzER50h9UfSlP9dAwSGDre1n+2q2NMURpXQ0tYJnEiz/jAed2+59RUjRqOpmPRbdGwoYh6EKriKmJSSlzirsdWYYUuplghEXIY/yhluqMlOtGZBknkCO6tIC98XQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754204; c=relaxed/simple;
	bh=FyvEGnr7ym7WA2bZe3VgmH9NtiRgOu7qIJOamXHgDWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0b30r+oUPiDW3V6Y/bn/QbzvnNXTCsIlD01kLpvuxjB6M2N9fh3Xf84IkI5dsTbLPlscsPF2hIANllUA6RZTSP6AXoweiWIQSq9PHNoCLDVr39Vo0L+EdgssqL9kMtQ0hL8t+u+eMMqentDW9C3lZsPs43e/CgVdpeISwFvl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVYWb0mN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750754203; x=1782290203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FyvEGnr7ym7WA2bZe3VgmH9NtiRgOu7qIJOamXHgDWE=;
  b=DVYWb0mNmf2I2jSGmUa6Qb0ZVFYee7AeIrChZSbJwBdBJFQqSLtTpbrL
   e1Bsz2bbGfqr089YQcEK+WPvEVJJL87OMvelfsNWz9LRU8iYKx0SaHJjV
   8QbK3exJ3thsULm7OZUDH//xmsCPZkUy5RTRFkwm/MdNDFdol5/eSgD4g
   2ek3mjnGKJatanrU3p56f873U/L4OTEEHdHzi5J41bngMQOAaofLXWBYA
   AwjFeHjcTNjMHuvG0FAAys8qOTXS+hkJODq1k0PypWZWXydjbX63jqvTV
   ol6CKMQ01bxrNKcedgy6GX3mYBB3/MqI7/KAjawNRlbgWCAF5u/sf1fyP
   w==;
X-CSE-ConnectionGUID: AZspukSuQRK81Lz5TS+sgA==
X-CSE-MsgGUID: 0hcOarj9StqTRFg7MvOBrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52212735"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52212735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:36:42 -0700
X-CSE-ConnectionGUID: abL0p+w9RE6OhIAUjgUEiA==
X-CSE-MsgGUID: uvlsNPgoRli9u2sASf7VXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151331392"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:36:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTz8u-00000009Q3q-07R9;
	Tue, 24 Jun 2025 11:36:36 +0300
Date: Tue, 24 Jun 2025 11:36:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 6/7] iio: accel: adxl345: extend inactivity time for
 less than 1s
Message-ID: <aFpjkwfxHq8EGFE5@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-7-l.rubusch@gmail.com>
 <aFkpv0CUkateel8q@smile.fi.intel.com>
 <CAFXKEHb9Fbd_UOF90EumEtns82VPhYBrLZ=JtmhVJ4pJsT=q-g@mail.gmail.com>
 <aFpV1f1qapCQunVO@smile.fi.intel.com>
 <CAFXKEHYhXekE29Ljfv=c7oRuzo0irWtJNM7fjW516xQ-ydsm=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHYhXekE29Ljfv=c7oRuzo0irWtJNM7fjW516xQ-ydsm=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 24, 2025 at 10:18:35AM +0200, Lothar Rubusch wrote:
> On Tue, Jun 24, 2025 at 9:38 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, Jun 23, 2025 at 11:21:01PM +0200, Lothar Rubusch wrote:
> > > On Mon, Jun 23, 2025 at 12:17 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Sun, Jun 22, 2025 at 03:50:09PM +0000, Lothar Rubusch wrote:

...

> > > > > -     if (val == 0) {
> > > > > +     if (val_int == 0 && val_fract == 0) {
> > >
> > > The case for 0sec, 0.0 or setting "0" and fract will consequently be
> > > "0". 0 is an invalid input for this period and sensor, so it will
> > > default to an optimized period based on given ODR.
> > >
> > > > > +             /* Generated inactivity time based on ODR */
> > > > >               ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
> > > > >               if (ret)
> > > > >                       return ret;
> > > >
> > > > >               odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > > > >               val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
> > > > >                           min_boundary, max_boundary);
> > > > > +             st->inact_time_ms = MILLI * val;
> > > > > +
> > > > > +             /* Inactivity time in s */
> > > > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > > > > +     } else if (val_int == 0 && val_fract > 0) {
> > > >
> > > > val_fract check is not needed here.
> > >
> > > Case for e.g. 0.123, numbers under 1s. This goes into the free-fall register.
> >
> > 0.0 is already checked above, and since the val_fract is unsigned this is check
> > is redundant.
> >
> > > > > +             /* time < 1s, free-fall */
> > > > > +
> > > > > +             /*
> > > > > +              * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
> > > > > +              *
> > > > > +              * Recommended values between 100ms and 350ms (0x14 to 0x46)
> > > > > +              */
> > > > > +             st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
> > > > > +
> > > > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> > > > > +                                 DIV_ROUND_CLOSEST(val_fract, 5));
> > > > > +     } else if (val_int > 0) {
> > > >
> > > > if now is redundant here, right?
> > >
> > > So, this will be 1s through 255s. Periods above 1sec. This goes into
> > > the inactivity register.
> >
> > See above,
> >
> 
> I agree, that checking for val_fract is actually done as a sub case of
> val_int, and only if val_int was 0. So, would the following make it
> clearer?
> 
> if (val_int  == 0) {
>     if (val_fract == 0) {
>         // 0 provided, default values
>     } else {
>         // >0s, e.g. 0.123s, use free-fall register
> } else {
>     // 1s - 255s, use inactivity register
> }
> 
> Actually - I did not touch that - I saw some places where I'm already
> using nested if/else in the third level. I guess, by the style advice
> according to switch/case, this also applies to if/else, right?
> 
> If yes, when the according parts go into another round, I might give
> it a try to separate as well using helper functions.

You can think through the patches. It might make sense to consider as well this

helper_1()
{
	// for default
}

helper_2()
{
	// for free-fall
}

helper_3()
{
	// for inactive
}

	...
	if ()
		helper_1();
	else if ()
		helper_2();
	else
		helper_3();


> > > > > +             /* Time >= 1s, inactivity */
> > > > > +             st->inact_time_ms = MILLI * val_int;
> > > > > +
> > > > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> > > > >       }

-- 
With Best Regards,
Andy Shevchenko



