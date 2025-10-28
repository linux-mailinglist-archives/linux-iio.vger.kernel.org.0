Return-Path: <linux-iio+bounces-25574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA2C14647
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 12:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 818714E6DBC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7CD1D63EF;
	Tue, 28 Oct 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6ZwtEkT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CC1DFD9A;
	Tue, 28 Oct 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651266; cv=none; b=S5TThDCdtK6QRDcu1BlPwW7MDvmG8A9vMePR6k/VPrIMgVwOIRv6Fg6tHUEj8vgX30akzkPXQE/D4mNNL/jrJAid4oKgvDOHWFh89M7wuGkNry7yJlN4hT4KYzFuMT+Ua6R2FJVYxOw0RJex+TYDyih9AHKimZViv+5AxkPBZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651266; c=relaxed/simple;
	bh=pu5MKC98iytXYXwdRFwcTAWCXS3UHEEjW1hJRxmpumE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUHSgWdHMpORsSB8GuV23FFtDDZ+9vKV8azNCiruxM8G61IEw7KtH3m1HqAoJQVzycTtQRCyDb/b73vz0+4vT/RHCbt/dj9NZLToJ4ukO+Xa/ovfeRTPqMeGlekYLGI74dhHOoUP7/iuFmm3HycMs0heaKY6RnggJ/LF8/zS+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6ZwtEkT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761651263; x=1793187263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pu5MKC98iytXYXwdRFwcTAWCXS3UHEEjW1hJRxmpumE=;
  b=A6ZwtEkT3sRODin29DZ5eSEeM9TaiV8DBtCxmO6GGjK2/wxO44nbIjmK
   82HBKTzRAFhUHvyqbV/MKHWa3dKjzKU/q+kBvy5uIsnmexwVx1vCZsFoT
   yOXoLxM04fK0xNor5mFM/7C59Sx8SIv7mpd2nTVdirTC6ylcJaBt+lJW3
   6/V/YyCQhoDN21T5r2vgGWILDGx1jzivhN8Q4cKInwPZvQkSIfp0dR4PS
   0VVvhzmzHwC8wyFKTClG/yqor9CzQtddl7lTKF6dCLTE/lS8dPxc58hZB
   FguG9UTpAXrAHJY5V88O7H30havEZTJivXS8jXlg7EkR3fmzJeRtq3zOf
   w==;
X-CSE-ConnectionGUID: 411/NEBIQ/araNv49UeJIw==
X-CSE-MsgGUID: bir/HZhrTniOO6Q3Epwy4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81378351"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81378351"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:34:23 -0700
X-CSE-ConnectionGUID: OijtI/erQ+e2KE2bWejLsA==
X-CSE-MsgGUID: v/9TRkG1QcmHJEjfj0oGxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="215980085"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:34:20 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDhxx-00000003IWC-0GNW;
	Tue, 28 Oct 2025 13:34:17 +0200
Date: Tue, 28 Oct 2025 13:34:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Fix irq assumption regression
Message-ID: <aQCqOJWQpvgI1o1q@smile.fi.intel.com>
References: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org>
 <aP9dqnGb_tdWdr7y@smile.fi.intel.com>
 <CACRpkdb9GYL3dQzn28Q5E_-keJdLLA+TiXxTuNf1aaevKqHJYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb9GYL3dQzn28Q5E_-keJdLLA+TiXxTuNf1aaevKqHJYA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 06:24:25PM +0100, Linus Walleij wrote:
> On Mon, Oct 27, 2025 at 12:55 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, Oct 27, 2025 at 11:18:17AM +0100, Linus Walleij wrote:
> 
> > Hmm... Isn't this already being discussed somewhere? I have some déjà-vu.
> 
> I brought it up on the PostmarkeOS IRC, otherwise I don't
> know.

It might be that it was a cross-mail that describes the same issue in another
IIO driver.

> > > +     /* We do not always have an IRQ */
> > > +     if (!data->has_irq)
> >
> > Wouldn't check for 0 be enough?
> >
> >         if (!data->irq)
> 
> But this driver does not store the IRQ number in the
> instance struct because it isn't used outside of the probe()
> function.
> 
> The information that needs to be stored is bool so that's
> why I stored a bool.

I understand this, but I think storing the IRQ number is tiny better
as we might have a chance to need it in the future.


-- 
With Best Regards,
Andy Shevchenko



