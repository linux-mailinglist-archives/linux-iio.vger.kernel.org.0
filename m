Return-Path: <linux-iio+bounces-20938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38FAE5E23
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D815E7B0F59
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E26253B73;
	Tue, 24 Jun 2025 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMzm0yjT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDFBA49;
	Tue, 24 Jun 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750686; cv=none; b=Spj4QMrtq++RUmGkFNKg2TFIKOmcjRdZfxhWANWGMK0UQA2Lsr9B6EOvPL7iKebf3GIbmMDn1EDx84U5skxG+7tLEiCH0EtA4nidWQ9z0N5rdRBuVXhQorSw1vDBRE0BPTtDQb5TRTIElSeDOVz5aeXBVF/UFwv1jbXFt9tWpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750686; c=relaxed/simple;
	bh=uof2a1fOq6wtjDzq0MgfyjYAft9RO4Q0fa0qJ5Rtd0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rev9r1KxcphGQlqxZEnaACptxl3oCZ/KZUAB4lP0liFuTJDbwGMbwW9BGmDWFEC2nYxSMFCV+1vG2kP2vGWG0oGeIgRqnrQ0HfTaBF8iRniSLmHU4IqOC6ILAlQocn9sdV2O2lP/iQIDhj2ddALow2Vd50qtvC0Snngd6BkFeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMzm0yjT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750750686; x=1782286686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uof2a1fOq6wtjDzq0MgfyjYAft9RO4Q0fa0qJ5Rtd0w=;
  b=hMzm0yjTVdGapuaoniRpsYttHdiB/5x22BDrFYb8WPWH1Hu/Ge2IhmTV
   BSTRKIZ6xG7wgZaOgjax8urpFFCDir1Eq2FD/rZ1tr2qdBnd0u9KYw7UU
   n0j7OCOEWcfb7iN4vv4NSiKhiJS6dd4fTQxe3KvbM8g6tID0C3MMZyioa
   pUJREpjCC7xFk85em1ppSv4TDblLpFghZjnOb888RvxXoaxomhEirySVd
   GVNIydcPuUw0wAWa6twuQY7VuCpgyqUQW86tEDliU4IRrT2TUgy27ss4Q
   fwqrS6UrTKTsDEDLHGDYPsxDB9ME1sM7IzNxHJT7UqZS8Cl17sKwTnxIL
   Q==;
X-CSE-ConnectionGUID: n+E+XNj5SouaNgkv0TfUvw==
X-CSE-MsgGUID: MEp1R7eUQqGx16IsFKAHiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53113829"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53113829"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:38:04 -0700
X-CSE-ConnectionGUID: I4AEmWPZTQOezcDp0Bivtw==
X-CSE-MsgGUID: sCeZHKSiSDKdqPSQ2Kmk/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151259282"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:38:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTyE9-00000009PJ1-1PuQ;
	Tue, 24 Jun 2025 10:37:57 +0300
Date: Tue, 24 Jun 2025 10:37:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 6/7] iio: accel: adxl345: extend inactivity time for
 less than 1s
Message-ID: <aFpV1f1qapCQunVO@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-7-l.rubusch@gmail.com>
 <aFkpv0CUkateel8q@smile.fi.intel.com>
 <CAFXKEHb9Fbd_UOF90EumEtns82VPhYBrLZ=JtmhVJ4pJsT=q-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHb9Fbd_UOF90EumEtns82VPhYBrLZ=JtmhVJ4pJsT=q-g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 23, 2025 at 11:21:01PM +0200, Lothar Rubusch wrote:
> On Mon, Jun 23, 2025 at 12:17 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sun, Jun 22, 2025 at 03:50:09PM +0000, Lothar Rubusch wrote:

...

> > > -static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> > > +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_int,
> > > +                               u32 val_fract)
> > >  {
> > >       int max_boundary = U8_MAX;
> > >       int min_boundary = 10;
> > > -     unsigned int val = min(val_s, U8_MAX);
> > > +     unsigned int val;
> >
> > You see, I even suggested splitting this assignment to begin with.
> > The change will be clearer with that done.
> >
> > >       enum adxl345_odr odr;
> > >       unsigned int regval;
> > >       int ret;
> > >
> > > -     if (val == 0) {
> > > +     if (val_int == 0 && val_fract == 0) {
> 
> The case for 0sec, 0.0 or setting "0" and fract will consequently be
> "0". 0 is an invalid input for this period and sensor, so it will
> default to an optimized period based on given ODR.
> 
> > > +             /* Generated inactivity time based on ODR */
> > >               ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
> > >               if (ret)
> > >                       return ret;
> >
> > >               odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > >               val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
> > >                           min_boundary, max_boundary);
> > > +             st->inact_time_ms = MILLI * val;
> > > +
> > > +             /* Inactivity time in s */
> > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > > +     } else if (val_int == 0 && val_fract > 0) {
> >
> > val_fract check is not needed here.
> 
> Case for e.g. 0.123, numbers under 1s. This goes into the free-fall register.

0.0 is already checked above, and since the val_fract is unsigned this is check
is redundant.

> > > +             /* time < 1s, free-fall */
> > > +
> > > +             /*
> > > +              * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
> > > +              *
> > > +              * Recommended values between 100ms and 350ms (0x14 to 0x46)
> > > +              */
> > > +             st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
> > > +
> > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> > > +                                 DIV_ROUND_CLOSEST(val_fract, 5));
> > > +     } else if (val_int > 0) {
> >
> > if now is redundant here, right?
> 
> So, this will be 1s through 255s. Periods above 1sec. This goes into
> the inactivity register.

See above,

> > > +             /* Time >= 1s, inactivity */
> > > +             st->inact_time_ms = MILLI * val_int;
> > > +
> > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> > >       }
> > >
> > > -     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > > +     /* Do not support negative or wrong input. */
> > > +     return -EINVAL;
> > >  }

-- 
With Best Regards,
Andy Shevchenko



