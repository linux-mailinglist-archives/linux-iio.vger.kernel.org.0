Return-Path: <linux-iio+bounces-13821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E199FD40F
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 13:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38598161776
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B101B2180;
	Fri, 27 Dec 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOOPEQTA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805D79CD;
	Fri, 27 Dec 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301105; cv=none; b=dtB2IDNe71EW4sySV3mv92BtpO3sFWtUVdYPj+bmI08EURoQ5qZ/Eaw4ldnI6ir1n6lXaWsLQ40P6q0oSKJ1KAI/404qDGw0Dts0J4quFUv55aXrlLCs2Cd7TOmDYuuOLTD89Jbk/7ji8lCJfiJmMNll5hiLMlefT74kbYW4eEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301105; c=relaxed/simple;
	bh=WcIekhAguvpAJQc15sG+xo+PFwcUVS69lTUeOcBIsJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNFG/IBSfdqTcLy2aOCvdxI+ofd+cA50XXoA/9qYE+3d7+UNJuiUHzNCG+lVY9oR3LsVQOog8j1puQ+MVJb+1CE8jkFtDbMk7QBqX2W7y+pidt3Lpkx/mQZnUtFTx89R5rGa4TLeX7qAs+dJsBcJpOhF/EQsVFhgtwJzMsZ0Gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOOPEQTA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735301104; x=1766837104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WcIekhAguvpAJQc15sG+xo+PFwcUVS69lTUeOcBIsJY=;
  b=TOOPEQTAWeNWsT8MjKMyC8QGe1wiIkEbzfhsAn5e/FE8sdGD45sQ74hN
   zQMtcuF74fQt2SJqDdkfiRt3pCWCOjp5EdOLztx9b3uWjRDpIzs5gCJfP
   xFwXgXan43hR0G9D5mzwcciNIyO+8ZuSu1bCHWy61covB0EPJty2O8eZH
   i0/nKIuNNzx8XlZon+xcXQ1Fx5Tu3NFy30ptAQZ7voXwA8NvdWfMelwFP
   q7nohztNoSJM6Y4WCaEGqNVhVn3z8lQND23eaA9DPs9nBZ0rEObaz+YYK
   KnVdwBNWGIaGYd4BlpDr+Vz7JZCFyv+BdS4Y3a4IP7LF1djRheB3lmtdv
   Q==;
X-CSE-ConnectionGUID: 7yQryVXpRw6tDfWJultrSg==
X-CSE-MsgGUID: i+QG07gtQqi7qNp1n9mGFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11298"; a="58165572"
X-IronPort-AV: E=Sophos;i="6.12,269,1728975600"; 
   d="scan'208";a="58165572"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 04:05:03 -0800
X-CSE-ConnectionGUID: v7jgdhQAQHiFzqTOTwNuRQ==
X-CSE-MsgGUID: oq9cl1xDQP2G8hZVjKFKlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,269,1728975600"; 
   d="scan'208";a="99997009"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 04:04:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tR95L-0000000CwjQ-413o;
	Fri, 27 Dec 2024 14:04:55 +0200
Date: Fri, 27 Dec 2024 14:04:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Andreas Dannenberg <dannenberg@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Message-ID: <Z26X52u_5i5rsDao@smile.fi.intel.com>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
 <20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
 <Z2rRnBGd4qqJXAb5@smile.fi.intel.com>
 <PN0P287MB2843562E6C965196D05E2BCFFF0C2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
 <Z2wJ9BLsrLeDD-zb@smile.fi.intel.com>
 <PN3P287MB2845E6B3A390BE3741CFBF13FF0D2@PN3P287MB2845.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3P287MB2845E6B3A390BE3741CFBF13FF0D2@PN3P287MB2845.INDP287.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 26, 2024 at 06:14:59AM +0000, Hardevsinh Palaniya wrote:
> > On Wed, Dec 25, 2024 at 09:56:36AM +0000, Hardevsinh Palaniya wrote:
> > > > On Tue, Dec 24, 2024 at 11:43:16AM +0530, Hardevsinh Palaniya wrote:

...

> > > > > The OPT3004 sensor shares the same functionality and scale range as
> > > > > the OPT3001. This Adds the compatible string for OPT3004, enabling
> > > > > the driver to support it without any functional changes.
> > > > >
> > > > > Datasheet: https://www.ti.com/lit/gpn/opt3004
> > > >
> > > > >
> > > >
> > > > This blank line is not needed.

> Regarding the second comment:
> The blank line was added to differentiate between the commit message and the
> SoB tag. Are you sure it should be removed?

If I understood the intention properly the Datasheet is supposed to be a tag,
so there shouldn't be blank lines among the tags in the tag block. With that
I truly think you should remove that blank line.

...

> > > > >  static const struct of_device_id opt3001_of_match[] = {
> > > > >       { .compatible = "ti,opt3001", .data = &opt3001_chip_information },
> > > > >       { .compatible = "ti,opt3002", .data = &opt3002_chip_information },
> > > > > +     { .compatible = "ti,opt3004", .data = &opt3001_chip_information },
> > > > >       { }
> > > > >  };
> > > >
> > > > I'm always puzzled why do we need a new compatible for the existing driver
> > > > data? Is this hardware has an additional feature that driver does not (yet)
> > > > implement?
> > >
> > > OPT3001 and OPT3004 sensors are functionally identical, and there are no
> > > additional features in the OPT3004 that require separate handling in the driver.
> > >
> > > The new compatible string for the OPT3004 is being added, which will allow the
> > > driver to recognize and support this sensor in the same way it handles the OPT3001.
> > But why? I understand if you put two compatible strings into the DT to make it
> > explicit in case of the future developments of the driver, but new compatible
> > in the driver makes only sense when you have either quirk(s) or feature(s) that
> > are different to the existing code. Since you haven't added either, what's the
> > point?
> 
> Understood.
> 
> I also found a similar case with the ADXL346, which is identical to the ADXL345.
> In the mainline kernel, a compatible string was added as a fallback in the bindings
> but was not added to the driver itself.
> 
> Thanks for the insight.
> 
> In the next version, I will drop this patch and only submit the bindings for the OPT3004.
> using the fallback mechanism.

But the kernel help test is good to have been updated, as well as having the
Datasheet link to be in the Git history (kinda documented).

-- 
With Best Regards,
Andy Shevchenko



