Return-Path: <linux-iio+bounces-26676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09DC9F07B
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20253A5B47
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730220125F;
	Wed,  3 Dec 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IM8HucDJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AA7260D;
	Wed,  3 Dec 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764766772; cv=none; b=Wesf+tu5o2wOP4ZJzEq/aKhRXLGYpqXj384k/2ep6kY9teVVzhA5a/KWir/2GOQFa1MPXy7rrgnoNXRx138YIWcUpXr1F6yCDlffpRXedknXqAohrYaLbrQVk9phH+hpN/0WBI8A5ECjaAhN0lFKBQWg3L452oWo9wZkvq31IHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764766772; c=relaxed/simple;
	bh=B4tPlaT6uVEgQh3MIX7Jz4wxDxdB2JWr1rbtC3gv7xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so8dveMtG2hDWSyHwuuon3Dsb8z0P1sAd1sHzxZeMckWXAmpEZ6fedDM+C/YMpW067kXsuZOMm95G1xvSaVi7F6wpQHU6mqrJ24/yr5FrUSkDwxdooXTI8ECv2+J6WphEUigcG2cymHA/YU7B10K3S5orl0jQWFh8q2JHZ5inMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IM8HucDJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764766771; x=1796302771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B4tPlaT6uVEgQh3MIX7Jz4wxDxdB2JWr1rbtC3gv7xQ=;
  b=IM8HucDJGf9YhAPoECoA5aMswXCkS212vF/0X4QSNVTDVdROORGXjaOP
   /kZFp48U3bHPASAdHE5UDa/6npNh/zHmL/3+Qltb3aPMSE5mmhMznOIwH
   GdJzeLrzmT/94UEc75L3j+ilYjWwu9Wi8VnjFCxQAsleaEPvhzum7W973
   58ZLFIpBjf8t3D3agmCi80e5cyKps71//QzjQEUy5rbzRcS6elYCnOvKD
   M182c6MrCJobeR9llFgYfOTY3xYxqPeV9//1o+i2peHh/woKttfBGR1+m
   KU+nuFzB4YLj9EvXhyvzGWkOQ7JTd4bD1NpOfXO5mrCZRo+gwWm3ioGbZ
   w==;
X-CSE-ConnectionGUID: yH4BmYsgQs+pqXo7Ie6kHA==
X-CSE-MsgGUID: VhCuehQoR3iA0wChnvVrhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70614851"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="70614851"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 04:59:30 -0800
X-CSE-ConnectionGUID: TVHmLwTCRG6xyYaHxX+8aQ==
X-CSE-MsgGUID: uysXoXj/T0SjATTbgwg0yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="194570116"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 04:59:26 -0800
Date: Wed, 3 Dec 2025 14:59:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 2/3] iio: adc: Initial support for AD4134
Message-ID: <aTA0LDYDzP8s__1V@smile.fi.intel.com>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <c189c25b1c46f406c3f7942e5ac4cdb0b964ee52.1764708608.git.marcelo.schmitt@analog.com>
 <CAHp75Vf7p=aPy2ofC_zVz1PURA3R9i0WZCG63-dCEXO=xKJ0FA@mail.gmail.com>
 <daf53d16106f29a09134b2c2a5a2f4870a0bfbe1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daf53d16106f29a09134b2c2a5a2f4870a0bfbe1.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 11:02:45AM +0000, Nuno Sá wrote:
> On Tue, 2025-12-02 at 23:26 +0200, Andy Shevchenko wrote:
> > On Tue, Dec 2, 2025 at 10:55 PM Marcelo Schmitt
> > <marcelo.schmitt@analog.com> wrote:

Nuno, may you please remove unrelated context when replying?

...

> > > I tried using the reset-gpio driver to handle AD4134 reset GPIO. I had changed
> > > the device tree to set a reset-controller node and had referenced that from the
> > > ADC node. I also updated the ad4134 driver to use a reset controller to handle
> > > its reset GPIO. Though, after those changes, the AD4134 driver would defer
> > > device initialization forever because it missed a reset-controller. To make the
> > > reset-gpio driver probe and instantiate a reset controller, it would take a
> > > platform device to be set within a machine-specific, hardcoded platform data.
> > > AD4134 is not bound to any specific platform, so it doesn't make much sense to
> > > have a reset-gpio platform device for that. Thanks for mentioning reset-gpio. It
> > > was interesting looking into the reset-gpio driver and the reset framework. It
> > > looks cool. But I don't think the reset-gpio driver suits the AD4134 reset use
> > > case.
> > 
> > Bart converted it to be an aux driver and it should work. Please, give
> > a try after v6.19-rc1 is out.

...

> > > +       reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > +       if (IS_ERR(reset_gpio))
> > > +               return dev_err_probe(dev, PTR_ERR(reset_gpio),
> > > +                                    "failed to find reset GPIO\n");
> > > +
> > > +       if (reset_gpio) {
> > > +               fsleep(AD4134_RESET_TIME_US);
> > > +               gpiod_set_value_cansleep(reset_gpio, 0);
> > > +       }
> > 
> > I still think that reset-gpio driver is the right way to go (after
> > Bart's changes, which should be part of v6.19-rc1).
> 
> Hmm, can you share why we should have a reset controller for the above? 

My point here is to have a standard way of handling "reset" pin independently
of what's beneath in the HW — GPIO or other means to assert/deassert it.

> Unless I'm missing something, even with the aux device, you'll need the code to
> optionally add it which (I think) will already force you to check the existence for
> the pin (which would be a bit odd IMO).

If this is the case, it needs to be fixed, but reset framework provides
_optional() API, that's what should be used for the cases where reset is
optional. Let reset framework to handle that.

> But more importantly, for things like the above I'm failing to see the
> benefit in registering a reset controller. In fact, I think it would be
> dangerous to "allow" other potential consumers to randomly reset the device.

Again, same here, reset framework provides _shared() API which we do not want to
use here, we want to use _exclusive() one.

> If you look at Krzysztof's log when adding the driver, you see:

It's unrelated, because from the user's perspective it communicates via reset
framework.

> "Add a simple driver to control GPIO-based resets using the reset
> controller API for the cases when the GPIOs are shared and reset should
> be coordinated.  The driver is expected to be used by reset core
> framework for ad-hoc reset controllers."
> 
> Key point is *GPIOs are shared and reset should be coordinated*. That is not
> the case here.

And it has no direct relation to this driver in such a case. Of course the
generic reset controller driver should try to cover as many users as possible.
Then on the framework level they can decide how they want to use it.

It's more flexible that way, so I expect most of the reset controller drivers
to allow shared accesses. And it's orthogonal to the discussion here.

> Or maybe I'm missing the point...

I think so, see above.

> Having said the above, I would be up for some kind of helper in gpiolib.
> I still see way too often people misinterpreting the meaning of
> GPIOD_OUT_HIGH and that the value in gpiod_set_value_cansleep() means
> assert/deassert.

Consider this as a helper :-)

-- 
With Best Regards,
Andy Shevchenko



