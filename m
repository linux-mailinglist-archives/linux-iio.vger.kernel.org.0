Return-Path: <linux-iio+bounces-15871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B943EA3DC14
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD2419C2EF4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58E1C5D50;
	Thu, 20 Feb 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl90/mwn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464751C3C07;
	Thu, 20 Feb 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060285; cv=none; b=m7qEryuj5r1isLhRIGAB85hCPXYMNwxzkmKP91A91j2FCiwtV4sJ/lvyCd4UL3vJTjB0fsHYdvIHTr4TV0In6cY89U/SCxMmmYpk2IYR0tPzdRZIE741UB1V6sbRM4ebIztu/rKfYd/fMPhvY+j1KT+hxrhv4UAjUqvh4sPC3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060285; c=relaxed/simple;
	bh=DWSYAHUTargpU400f9NK3gvtZ8FTGTCpxJjIS2y1L/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO0EvQnRTkEGNfcv07kheC4QdypHJNeEtHhsnSPCSMeDB2caW8/nYaCeNOL7Hiw9wM4zR36I4h1VNacNuHmUIuM8GMt9WNZ+oshB5cuG/xRpAFOgVc7B1Eb8QN+RXnv4zZD6IR0UNNWERc9lttkZ04Ve2TQX/tljNuzmDBR/w1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl90/mwn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740060283; x=1771596283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWSYAHUTargpU400f9NK3gvtZ8FTGTCpxJjIS2y1L/s=;
  b=kl90/mwnoi01V90U5bziIzlKuiRbOOu/hjkkQ49YBSIG07yrtwHRNram
   OGbUpPKL+avKUYmoMUiS7p7iGUhMrWKoLg/W3KgT07Fc0XRPPaXUuZAOa
   JAuICpky2txJue2tq85HIGJhxxv59zTBp+O2DOVUieTPpqaDYkRMG7rj9
   0PBOfV6qnpK/RzN5QYFK4sid5ZUNyZJSayBQUm1fVUdlglUb/u03lYiTO
   3z2/A6qVyEHw/DHpwMb02TD3iQS2sMdc2zmjkQvlWtL2KKWfQM5vp8+v/
   gUHiOfca3vTkAsEU2YnX60c3xOBboAwkBdPDnmaUoLl9ISIf0iVUsGfUY
   w==;
X-CSE-ConnectionGUID: QoQqtPzmSba509bjNqHOQA==
X-CSE-MsgGUID: +ZD6xKFxRv6etvGDH81pyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40707053"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40707053"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 06:04:42 -0800
X-CSE-ConnectionGUID: apojjs4AR7mOwWcYYd5TxA==
X-CSE-MsgGUID: fYV6tpzvSFOT2RzZ5HweAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152242291"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 06:04:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl7AG-0000000DLyt-3fDh;
	Thu, 20 Feb 2025 16:04:32 +0200
Date: Thu, 20 Feb 2025 16:04:32 +0200
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
Message-ID: <Z7c2cBQpjoc9-Vyu@smile.fi.intel.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
 <Z7ZB7RQhyI5Dohrq@smile.fi.intel.com>
 <b1c1ed68-2f4d-447c-9957-5a1bbc63ef6e@gmail.com>
 <Z7ci7tUlRQqZEZSN@smile.fi.intel.com>
 <ec76334b-bb13-4076-811d-9174170dd677@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec76334b-bb13-4076-811d-9174170dd677@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 03:40:30PM +0200, Matti Vaittinen wrote:
> On 20/02/2025 14:41, Andy Shevchenko wrote:
> > On Thu, Feb 20, 2025 at 09:13:00AM +0200, Matti Vaittinen wrote:
> > > On 19/02/2025 22:41, Andy Shevchenko wrote:
> > > > On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:

...

> > > > > +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
> > > > 
> > > > No namespace?
> > > 
> > > I was considering also this. The IIO core functions don't belong into a
> > > namespace - so I followed the convention to keep these similar to other IIO
> > > core stuff.
> > 
> > But it's historically. We have already started using namespaces
> > in the parts of IIO, haven't we?
> 
> Yes. But as I wrote, I don't think adding new namespaces for every helper
> file with a function or two exported will scale. We either need something
> common for IIO (or IIO "subsystems" like "adc", "accel", "light", ... ), or
> then we just keep these small helpers same as most of the IIO core.

It can be still pushed to IIO_CORE namespace. Do you see an issue with that?

Or a new opaque namespace for the mentioned cases, something like IIO_HELPERS.

> > > (Sometimes I have a feeling that the trend today is to try make things
> > > intentionally difficult in the name of the safety. Like, "more difficult I
> > > make this, more experience points I gain in the name of the safety".)
> > > 
> > > Well, I suppose I could add a namespace for these functions - if this
> > > approach stays - but I'd really prefer having all IIO core stuff in some
> > > global IIO namespace and not to have dozens of fine-grained namespaces for
> > > an IIO driver to use...

...

> > > > > +	if (!allowed_types || allowed_types & (~IIO_ADC_CHAN_PROP_TYPE_ALL)) {
> > > > 
> > > > Unneeded parentheses around negated value.
> > > > 
> > > > > +	if (found_types & (~allowed_types)) {
> > > > 
> > > > Ditto.
> > > > 
> > > > > +		long unknown_types = found_types & (~allowed_types);
> > > > 
> > > > Ditto and so on...
> > > > 
> > > > Where did you get this style from? I think I see it first time in your
> > > > contributions. Is it a new preferences? Why?
> > > 
> > > Last autumn I found out my house was damaged by water. I had to empty half
> > > of the rooms and finally move out for 2.5 months.
> > 
> > Sad to hear that... Hope that your house had been recovered (to some extent?).
> 
> Thanks. I finalized rebuilding last weekend. Just moved back and now I'm
> trying to carry things back to right places... :rolleyes:
> 
> > > Now I'm finally back, but
> > > during the moves I lost my printed list of operator precedences which I used
> > > to have on my desk. I've been writing C for 25 years or so, and I still
> > > don't remember the precedence rules for all bitwise operations - and I am
> > > fairly convinced I am not the only one.
> > 
> > ~ (a.k.a. negation) is higher priority in bitops and it's idiomatic
> > (at least in LK project).
> 
> I know there are well established, accurate rules. Problem is that I never
> remember these without looking.

There are very obvious cases like below.

> > > What I understood is that I don't really have to have a printed list at
> > > home, or go googling when away from home. I can just make it very, very
> > > obvious :) Helps me a lot.
> > 
> > Makes code harder to read, especially in the undoubtful cases like
> > 
> > 	foo &= (~...);
> 
> This is not undoubtful case for me :) And believe me, reading and
> deciphering the
> 
> foo &= (~bar);
> 
> is _much_ faster than seeing:

Strongly disagree. One need to parse an additional pair of parentheses,
and especially when it's a big statement inside with nested ones along
with understanding what the heck is going on that you need them in the
first place.

On top of that, we have a common practices in the LK project and
with our history of communication it seems you are trying to do differently
from time to time. Sounds like a rebellion to me :-)

> foo &= ~bar;
> 
> and having to google the priorities.

Again, this is something a (regular) kernel developer keeps refreshed.
Or even wider, C-language developer.

> > > > > +		int type;
> > > > > +
> > > > > +		for_each_set_bit(type, &unknown_types,
> > > > > +				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
> > > > > +			dev_err(dev, "Unsupported channel property %s\n",
> > > > > +				iio_adc_type2prop(type));
> > > > > +		}
> > > > > +
> > > > > +		return -EINVAL;
> > > > > +	}

...

> > > > > +		tmp.required &= (~BIT(IIO_ADC_CHAN_PROP_COMMON));
> > > > 
> > > > Redundant outer parentheses. What's the point, please?
> > > 
> > > Zero need to think of precedence.
> > 
> > Huh? See above.
> > Everything with equal sign is less precedence than normal ops.
> 
> Sure. It's obvious if you remember that "Everything with equal sign is less
> precedence than normal ops". But as I said, I truly have hard time
> remembering these rules. When I try "going by memory" I end up having odd
> errors and suggestions to add parenthesis from the compiler...

The hardest to remember probably the

	foo && bar | baz

case and alike. These are the only ones that I totally agree on with you.
But negation.

> By the way, do you know why anyone has bothered to add these
> warnings/suggestions about adding the parenthesis to the compiler? My guess
> is that I am not only one who needs the precedence charts ;)

Maybe someone programmed too much in LISP?.. (it's a rhetorical one)

...

> > > > > +		ret = fwnode_property_read_u32(child, "common-mode-channel",
> > > > > +					       &common);
> > > > 
> > > > I believe this is okay to have on a single line,
> > > 
> > > I try to keep things under 80 chars. It really truly helps me as I'd like to
> > > have 3 parallel terminals open when writing code. Furthermore, I hate to
> > > admit it but during the last two years my near vision has deteriorated... :/
> > > 40 is getting more distant and 50 is approaching ;)
> > 
> > It's only 86 altogether with better readability.
> > We are in the second quarter of 21st century,
> > the 80 should be left in 80s...
> > 
> > (and yes, I deliberately put the above too short).
> 
> I didn't even notice you had squeezed the lines :)
> 
> But yeah, I truly have problems fitting even 3 80 column terminals on screen
> with my current monitor. And when working on laptop screen it becomes
> impossible. Hence I strongly prefer keeping the 80 chars limit.

Maybe you need a bigger monitor after all? (lurking now :-)

...

> > > > > +#include <linux/iio/iio.h>
> > > > 
> > > > I'm failing to see how this is being used in this header.
> > > 
> > > I suppose it was the struct iio_chan_spec. Yep, forward declaration could
> > > do, but I guess there would be no benefit because anyone using this header
> > > is more than likely to use the iio.h as well.
> > 
> > Still, it will be a beast to motivate people not thinking about what they are
> > doing. I strongly prefer avoiding the use of the "proxy" or dangling headers.
> 
> Ehh. There will be no IIO user who does not include the iio.h.

It's not your concern. That's the idea of making C units as much independent
and modular as possible (with common sense in mind). And in this case I see
no point of including this header. Again, the main problem is this will call
people to use the new header as a "proxy" and that's what I fully against to.

> And, I need the iio_chan_spec here.

Do you really need it or is it just a pointer?

...

> And as I said, I suggest saving some of the energy for reviewing the next
> version. I doubt the "property type" -flags and bitwise operations stay, and
> it may be all of this will be just meld in the bd79124 code - depending on
> what Jonathan & others think of it.

Whenever this code will be trying to land, the review comments still apply.

-- 
With Best Regards,
Andy Shevchenko



