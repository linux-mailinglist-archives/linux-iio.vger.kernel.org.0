Return-Path: <linux-iio+bounces-15849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC501A3DA43
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6939B7AA6DD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37DE1F4614;
	Thu, 20 Feb 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eogWL2iq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327A1F3FD7;
	Thu, 20 Feb 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055289; cv=none; b=tgCKlYCZ0PGslxTjWQjPsa+2Aih5nvwNT03JMewMhwEfLDhCj+bJ2m4IZ4Qdpg7uoGNu2vhTyZmiY3O5CdVYMaCUDcd5N9/Zn22tb7fAkJhAXr8DnuFdmGBmsJpZSjllirW5tOnNmMdj9Vt+QwTWeoYQyx8U8kMWwyffbUx5wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055289; c=relaxed/simple;
	bh=LeIpn0tC1VxcvvTy4WIzSMid7/q9gL2QZySYy1PWKyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBFIcNys8kJYI9mwoauVUrRmDcjFKZXEk8xuYZmKdBbgwrYJSJJfF5EUwwB8vvn7NyIv/REk2CcEcvK2M1DxEnfPvS1qVAQzHMX1g4JwhmEDAnzxJ8t8w/dBzDTiaLMaxuKR3TXW05/N7lmWDRNbozFozjSLZtaTTu1TZSxIYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eogWL2iq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740055288; x=1771591288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LeIpn0tC1VxcvvTy4WIzSMid7/q9gL2QZySYy1PWKyA=;
  b=eogWL2iqusvqHVd/eiTts50CMt+fT8ZLySfFu+Z55nRkWYUeYS2a47jJ
   3bx43mxj+ot5trkEJI2Qytx0j9eaGPke/LtoJyuanfoltEQRxBzgylL8x
   i2Yen8pnAo/h/2DxlQb9gRsXc0ZG8MWxMeXpBsHr56w0RL3InYPt0DP/5
   4nPj+GKoFMBBDVqQPHcnydEkOwMoldCiYC4bnrwk1rEQZCruRgOCM4X6f
   t72F3Si92hAQZXYbTr1TAxYmoUCnnnx2xcp7KIxSfYhAR0vnMUs/lWEMO
   I2m58awqFKF6KCw2bxFnXdrX/2qeMr2OedM59ok/UrSkTNCov9+Zm5gzC
   A==;
X-CSE-ConnectionGUID: OQZ3mpSKSG6jYEOHu5jlsw==
X-CSE-MsgGUID: zrSU11XKQJ+KkibiJ/MY1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40951635"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40951635"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:41:27 -0800
X-CSE-ConnectionGUID: 9dH+52A+TUCTpmU05P8WYg==
X-CSE-MsgGUID: kRr+uJgAQdC/atds2MA++g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120136529"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:41:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl5ri-0000000DKcf-3Ad8;
	Thu, 20 Feb 2025 14:41:18 +0200
Date: Thu, 20 Feb 2025 14:41:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
Message-ID: <Z7ci7tUlRQqZEZSN@smile.fi.intel.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
 <Z7ZB7RQhyI5Dohrq@smile.fi.intel.com>
 <b1c1ed68-2f4d-447c-9957-5a1bbc63ef6e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c1ed68-2f4d-447c-9957-5a1bbc63ef6e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 09:13:00AM +0200, Matti Vaittinen wrote:
> On 19/02/2025 22:41, Andy Shevchenko wrote:
> > On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:

...

> > > obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
> > >   obj-$(CONFIG_GEHC_PMC_ADC) += gehc-pmc-adc.o
> > >   obj-$(CONFIG_HI8435) += hi8435.o
> > >   obj-$(CONFIG_HX711) += hx711.o
> > 
> > > +obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
> > 
> > Shouldn't this be grouped with other IIO core related objects?
> 
> I was unsure where to put this. The 'adc' subfolder contained no other IIO
> core files, so there really was no group. I did consider putting it on top
> of the file but then just decided to go with the alphabetical order. Not
> sure what is the right way though.

I think it would be nice to have it grouped even if this one becomes
the first one.

> > >   obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
> > >   obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
> > >   obj-$(CONFIG_IMX93_ADC) += imx93_adc.o

...

> > > +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
> > 
> > No namespace?
> 
> I was considering also this. The IIO core functions don't belong into a
> namespace - so I followed the convention to keep these similar to other IIO
> core stuff.

But it's historically. We have already started using namespaces
in the parts of IIO, haven't we?

> (Sometimes I have a feeling that the trend today is to try make things
> intentionally difficult in the name of the safety. Like, "more difficult I
> make this, more experience points I gain in the name of the safety".)
> 
> Well, I suppose I could add a namespace for these functions - if this
> approach stays - but I'd really prefer having all IIO core stuff in some
> global IIO namespace and not to have dozens of fine-grained namespaces for
> an IIO driver to use...

...

> > > +	if (!allowed_types || allowed_types & (~IIO_ADC_CHAN_PROP_TYPE_ALL)) {
> > 
> > Unneeded parentheses around negated value.
> > 
> > > +	if (found_types & (~allowed_types)) {
> > 
> > Ditto.
> > 
> > > +		long unknown_types = found_types & (~allowed_types);
> > 
> > Ditto and so on...
> > 
> > Where did you get this style from? I think I see it first time in your
> > contributions. Is it a new preferences? Why?
> 
> Last autumn I found out my house was damaged by water. I had to empty half
> of the rooms and finally move out for 2.5 months.

Sad to hear that... Hope that your house had been recovered (to some extent?).

> Now I'm finally back, but
> during the moves I lost my printed list of operator precedences which I used
> to have on my desk. I've been writing C for 25 years or so, and I still
> don't remember the precedence rules for all bitwise operations - and I am
> fairly convinced I am not the only one.

~ (a.k.a. negation) is higher priority in bitops and it's idiomatic
(at least in LK project).

> What I understood is that I don't really have to have a printed list at
> home, or go googling when away from home. I can just make it very, very
> obvious :) Helps me a lot.

Makes code harder to read, especially in the undoubtful cases like

	foo &= (~...);

> > > +		int type;
> > > +
> > > +		for_each_set_bit(type, &unknown_types,
> > > +				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
> > > +			dev_err(dev, "Unsupported channel property %s\n",
> > > +				iio_adc_type2prop(type));
> > > +		}
> > > +
> > > +		return -EINVAL;
> > > +	}

...

> > > +		tmp.required &= (~BIT(IIO_ADC_CHAN_PROP_COMMON));
> > 
> > Redundant outer parentheses. What's the point, please?
> 
> Zero need to think of precedence.

Huh? See above.
Everything with equal sign is less precedence than normal ops.

...

> > > +		ret = fwnode_property_read_u32(child, "common-mode-channel",
> > > +					       &common);
> > 
> > I believe this is okay to have on a single line,
> 
> I try to keep things under 80 chars. It really truly helps me as I'd like to
> have 3 parallel terminals open when writing code. Furthermore, I hate to
> admit it but during the last two years my near vision has deteriorated... :/
> 40 is getting more distant and 50 is approaching ;)

It's only 86 altogether with better readability.
We are in the second quarter of 21st century,
the 80 should be left in 80s...

(and yes, I deliberately put the above too short).

...

> > > +#include <linux/iio/iio.h>
> > 
> > I'm failing to see how this is being used in this header.
> 
> I suppose it was the struct iio_chan_spec. Yep, forward declaration could
> do, but I guess there would be no benefit because anyone using this header
> is more than likely to use the iio.h as well.

Still, it will be a beast to motivate people not thinking about what they are
doing. I strongly prefer avoiding the use of the "proxy" or dangling headers.

...

> > > +/*
> > > + * Channel property types to be used with iio_adc_device_get_channels,
> > > + * devm_iio_adc_device_alloc_chaninfo, ...
> > 
> > Looks like unfinished sentence...
> 
> Intention was to just give user an example of functions where this gets
> used, and leave room for more functions to be added. Reason is that lists
> like this tend to end up being incomplete anyways. Hence the ...

At least you may add ').' (without quotes) to that to make it clear.

> > > + */

-- 
With Best Regards,
Andy Shevchenko



