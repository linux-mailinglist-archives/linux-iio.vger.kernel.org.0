Return-Path: <linux-iio+bounces-15354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA9A314B6
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D453A8C77
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123DC262D17;
	Tue, 11 Feb 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/TmVYCf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EF250C11;
	Tue, 11 Feb 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301159; cv=none; b=ifuIVENKqJgUnyhjUUVOzn7AWXqMDHk57wNjwC4h1h07pY7G+CX6VnWBMeXFvQkpM51hNNREZ9hozN1Vcfy4ULb+RDbKxzsQDg79CVBZxD7QRPo4wwdUIRcnXqDATEe2CEY9hI0gSPcuBsTI2wHI85Jr12IWLxbugXUwuvge5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301159; c=relaxed/simple;
	bh=H7MHu+xpTMJ4BpY1PzaT8/+oJaIeMZ9r3n9y6AHeetI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iolq0h63CwzBTRurMJvjXURLtOYHNivV0QzJu5wQO5N/nfJk5tgYlEAvz07swf1ThtUj7Wl8WNhQN+0N9+nLiWcPisNdqPUUnXlWoKt7QgUYL8D+jEgkcPhs4yOvISsSnivFyvF46jA2lJ/jeHyZXREetSMlO/D2LvmZnF9imPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/TmVYCf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739301158; x=1770837158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H7MHu+xpTMJ4BpY1PzaT8/+oJaIeMZ9r3n9y6AHeetI=;
  b=N/TmVYCfpEfCgFT97VoXFbVu6YAqrb/6lMSgyQHJdYecq5ZdcoMcKDw4
   nEogoWTh2X7uRKwQEFU8ufdy0i77A3fMDLQ6Jyti4oVgHuqUaR4WIzngc
   X9zC11bDR332VsVrJhTnLA+wKpHw8z45jcwYCBs0y+CnfPbDrEQLJnDAD
   Gqol9CVT/UaSbNZ9WObM/zzTVItk5vHNV5b5XtwvMhE5jvd+g0iadxko1
   dWx0VRhilOoMsSEhLZrN/2PtjjjP5P7/LfqRdHI6J3+U1nH8r/PNflzs+
   oXu/Iu2Vn7eQB2r49wlybLJ6JhSkHSCH6WCFDrlK9zOUZOw4qJBtYcQ8i
   Q==;
X-CSE-ConnectionGUID: sYDCZzaCQmCK+ZG9v+EoEQ==
X-CSE-MsgGUID: Stzgb5IfR4esSlYats/B8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50921772"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50921772"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:12:37 -0800
X-CSE-ConnectionGUID: F8IVCoQIRZOU/7mXo9KiWg==
X-CSE-MsgGUID: wKuThONQSF6cQTKozwl6nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112814519"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:12:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1thvgM-0000000AbW1-161Q;
	Tue, 11 Feb 2025 21:12:30 +0200
Date: Tue, 11 Feb 2025 21:12:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <Z6uhHssgIvI2DJ4c@smile.fi.intel.com>
References: <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
 <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
 <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 07:45:30PM +0100, Uwe Kleine-König wrote:
> Hello Andy,
> 
> On Tue, Feb 11, 2025 at 04:35:34PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 04:31:45PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 11, 2025 at 04:29:33PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Feb 11, 2025 at 04:20:50PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Feb 11, 2025 at 01:00:08PM +0000, Mark Brown wrote:
> > > > > > On Mon, Feb 10, 2025 at 10:33:31PM +0200, Andy Shevchenko wrote:
> > > > > > > On Mon, Feb 10, 2025 at 05:48:00PM +0000, Mark Brown wrote:
> > > > > > > > On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:
> > > > > > 
> > > > > > > > > In this case, we specifically split up the headers so that the only time you
> > > > > > > > > would ever include this header is if you need to call functions in this
> > > > > > > > > namespace (i.e. struct definitions are in linux/spi/offload/types.h which
> > > > > > > > > doesn't import the namespace). So this doesn't actually seem like a problem
> > > > > > > > > to me.
> > > > > > 
> > > > > > > > Indeed - I can't see any case where a user would need the header without
> > > > > > > > needing the namespace.
> > > > > > 
> > > > > > > You are looking from the other end. What I'm telling is that anyone who adds
> > > > > > > a header, automatically gets a namespace. What's the point to have namespace
> > > > > > > if it won't easily prevent from (ab)using it in the code. I consider putting
> > > > > > > MODULE_IMPORT_NS() in the headers a bit weird.
> 
> There was a similar discussion some time ago about the lpss pwm driver
> (https://lore.kernel.org/linux-pwm/Z09YJGifvpENYNPy@smile.fi.intel.com/).
> The arguments that you didn't accept back then already are similar to
> the ones that were brought forward here.
> The TL;DR; is: Adding MODULE_IMPORT_NS() to a header makes it easier for
> code to use the exported symbols. Yes, that includes abusers of the
> code.
> 
> But if you mostly care about the regular users of an API/ABI, making
> things easy for those is the thing that matters. Agreed, if you think
> that module namespaces are primarily a line of defence against abusers,
> adding the import to the header weakens that defence (a bit). However a
> typical header includes function prototypes and macros. Those also make
> it easier for abusers. With your argumentation we better don't create
> headers at all?
> 
> There are other benefits of module namespaces like reducing the set of
> globally available symbols which speeds up module loading or the
> ability to see in the module meta data that a namespace is used.

Thank you for summarizing the previous discussion.

> > > > > > Sure, but there's no case where anyone should ever be adding the header
> > > > > > without adding the namespace which does rather sound like the sort of
> > > > > > thing where you should just move the namespace addition to the header.
> > > > > 
> > > > > $ git grep -lw MODULE_IMPORT_NS | wc -l
> > > > > 651
> > > > > 
> > > > > $ git grep -lw MODULE_IMPORT_NS | grep '\.h$'
> > > > > 
> > > > > drivers/base/firmware_loader/sysfs.h
> > > > > drivers/iio/adc/ltc2497.h
> > > > > drivers/pwm/pwm-dwc.h
> > > > > ^^^ These ones are probably fine as they are not in include/
> > > > > 
> > > > > include/kunit/visibility.h
> > > > > include/linux/module.h
> > > > > include/linux/pwm.h
> > > > > 
> > > > > I believe these three are misuses of MODULE_IMPORT_NS(). Because one may add
> > > > 
> > > > _Two_, of course, module.h provides the macro :-)
> > > 
> > > And after looking into include/kunit/visibility.h it becomes only a single one.
> > > So, PWM is abuser of MODULE_IMPORT_NS() and this series added one more.
> > 
> > > > > a header just as a "proxy" one (copy'n'paste, for example) and we know that is
> > > > > real as we saw a lot of code that has semi-random header inclusion blocks.
> > 
> > And thinking of more realistic example when we want header and do *not* want a
> > namespace is the simple use of the macro / or data type from it without
> > actually relying on the APIs.
> 
> The problem of your more realistic example is that it doesn't apply
> here. A user of include/linux/pwm.h (or the header under discussion
> here) won't only use a macro or two and so not benefit from the imported
> module namespace.

It may not apply _today_, but it may be applicable tomorrow as headers are tend
to grow and use another headers and so on.

> Nobody intends to import all possible namespaces in <linux/kernel.h>.
> 
> > So, in case of the header structure like
> > 
> > foo_constants.h
> > foo_types.h
> > foo_api.h
> > foo_uplevel_something.h
> > 
> > The MODULE_IMPORT_NS() would make sense only to foo_api.h. And I still would
> > question that. As I explained that header may simply become a stale one or
> > being used by a mistake.
> 
> I have no problem here. If the header becomes stale we will most
> probably notice that eventually and remove it.

Lol. Look at the header hell we have now. 98% code in the drivers/ just show
that the developers either don't care or do not understand C (in terms of
what headers are for and why it's important to follow IWYU principle).

> Maybe the unused namespace even makes it easier to spot that issue.

Do we have an existing tools for that?

> See
> https://lore.kernel.org/r/20250123103939.357160-2-u.kleine-koenig@baylibre.com
> for an example which I found exactly like that.


-- 
With Best Regards,
Andy Shevchenko



