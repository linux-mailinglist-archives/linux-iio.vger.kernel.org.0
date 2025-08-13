Return-Path: <linux-iio+bounces-22663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F44B24985
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 14:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48841898394
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23361ADC93;
	Wed, 13 Aug 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQy8FSxk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37191C8FE;
	Wed, 13 Aug 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088249; cv=none; b=aiXLkgYWgurgn+8EHoSCdamWBI/9D+F0Xhhrvt2OeBuWWK2unA5zZzJF2N5HmqIZkYmWPHw04BRCLxfc1DSi8xyuUgfhSBr5apfHueAOGuwNULF/O2gKG2jXbwFbxT7eyOdK7bnv5KFn6nEO3drOyh2rIev2hj1fFf+/fe/bTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088249; c=relaxed/simple;
	bh=PFsHEezheqBXV0CEB4gSCHIuBI44jNyRudJNTTgils8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhSBfyie21urObQBXainXCr8Ao/NjqPk4pN95oseyVWeUxDWzfXmkVGxo/OItM0tVA84RvZR+XfvpMFQAuTI2FnOxRhkKchQs61koOh5ZQStViMMaSX7U82nKRSvgMG/I6ArzhYB80sIpq5EFTuVLwvM/mleDh8bgJj7m1D+Uq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQy8FSxk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755088248; x=1786624248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PFsHEezheqBXV0CEB4gSCHIuBI44jNyRudJNTTgils8=;
  b=lQy8FSxkIIDHME3R5YeLjj2iAfP57wbdy2+Cog3J3WQiyUsUyDrx9XlF
   9nrdzwuWfIoUHOqVU+IFvz1sZx9N5ZP9sn4bp0Smx38oK1dcfv6FSF5jf
   D92mnQ6Yh+HO+g88YtW2a5aERvLw7tJ+7UsgvijuyECkw8PEoHxl0g4xg
   JnD3KCAWaIYb1wTkLKceue9V3/a3LJsEfkp+O5NvZdubW3jej9aTmWxjh
   HCBn52KnIPp0/K+fEmCro38kYi9Nc2ugr3nYkNMfG7Lu2Z+6ym5p82ikJ
   9ardNHJmPG8KkqkVonCEp6/anVjqupEOugMGXXm0jNqM2MMfufYCm4mg4
   w==;
X-CSE-ConnectionGUID: pfbwCUsJRUWxpxuNzNj5dA==
X-CSE-MsgGUID: RYc+9gttQpOTemUlnGspRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44956846"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44956846"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 05:28:05 -0700
X-CSE-ConnectionGUID: dRG6x7AhToCZ6Bd0MqrZQg==
X-CSE-MsgGUID: c1Q3Q1JSQUmUM+/Gc7jVTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170666905"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 05:28:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umAaE-00000005R0Z-1F3W;
	Wed, 13 Aug 2025 15:27:58 +0300
Date: Wed, 13 Aug 2025 15:27:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] iio: adc: bd79124: Add GPIOLIB dependency
Message-ID: <aJyEzsbYrwwzCdcL@smile.fi.intel.com>
References: <6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com>
 <CAMRc=Mf75cangdeg7T4E0nAhJs_BTdLyCu6GcrCL8vJzzAkFWg@mail.gmail.com>
 <CAHp75VcY9JWGH3+HmmJQQtLLTLPvaZ1RJzmPZ1wFBM+gqRiTHw@mail.gmail.com>
 <CAMRc=McL04Sk9YRmimKAALyuDJc75vSJJuZQGWOP87Jv=o7cyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McL04Sk9YRmimKAALyuDJc75vSJJuZQGWOP87Jv=o7cyw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 02:17:44PM +0200, Bartosz Golaszewski wrote:
> On Wed, Aug 13, 2025 at 12:07 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Aug 13, 2025 at 11:40 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Wed, 13 Aug 2025 11:16:06 +0200, Matti Vaittinen
> > > <mazziesaccount@gmail.com> said:

...

> > > As for the former: it seems it's
> > > a common pattern for the headers containing the "provider" part of the
> > > subystem API, you'd get the same issue with regulators or pinctrl.
> > >
> > > I don't have a good answer, I'd just apply this as it's not a common issue
> > > from what I can tell.
> >
> > If the GPIO functionality is optional (not the main one), the user
> > should be able to compile it conditionally, in such a case it's either
> > an ifdeffery in the code, or separate module with its own stubs.
> 
> Honestly, it makes much more sense to factor out that optional
> functionality into its own compilation unit that can be left out
> completely for !CONFIG_GPIOLIB with a single internal registration
> function being stubbed within the driver.

That's what I suggested under "separate module with its own stubs" above.

-- 
With Best Regards,
Andy Shevchenko



