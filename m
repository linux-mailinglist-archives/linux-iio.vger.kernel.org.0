Return-Path: <linux-iio+bounces-26400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE80C7F7C4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3DF9348470
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079092F5302;
	Mon, 24 Nov 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrEXWkJq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2912E7F1D;
	Mon, 24 Nov 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975440; cv=none; b=A8JKlpvHIj7ZN8owGL2TF5J/sGqDQYoZs2Cn6ZeGG0wt8XHj0OQJX6DK6lJlOejS942MBC0AV3nfzIBLGnk4Wj3VJN1MyxPZGOa7ef5e79F1H2wsVK0JrVGO4Mau8viAVWxse0w0ka/i99li+2m60c6xl9AgMa7z4kORzJYxm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975440; c=relaxed/simple;
	bh=4Iw4haa9AZ75DSrYve0C850xo3Bln3Ujtshodh10r8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZgeHp3wZ6EcIB+bfO13lHBFWz79449F2GseZSJa8+T7Ni2HzguwOvpUAjeOeXzldCHtZoU1NVB6toQhjpNGZ2ZoN8HGEKHRB9xEAM0g5fjFvU3q/xGwaJpUy4RjKTJJeZjoT/PpoB3ak2nibMckaXl8B4RXshhjS6K00Sxxlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrEXWkJq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763975439; x=1795511439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Iw4haa9AZ75DSrYve0C850xo3Bln3Ujtshodh10r8Q=;
  b=RrEXWkJqEHms8XUXktguL5F75YEyzbF59RUTccKrFSEMzuIJSA+Na2j+
   31FM7o9YnzDUfxKYTPKkDL2Alr31Ak62Byowge9Eb/YbTAEHSMYLNOyW/
   gb6wEdaz3uHtDk4KDolrm3f3b3MweW79fNZVnZiMpZXq4hasm8nV2nN71
   VtHA2f2PACRaRwwC5S6gxRnqiEj6KmGkfb7he5cfvydH2zR9OhIZxZ2Pz
   l61q4muIAZgUA44ArB1Kjtb6wvaAChGBIZ2JOgMbN4qsk62iBPeW/Bobe
   ENsz+W3RjLR6ZAudAmGHSlKVcFkyAeb1tYURr8+gL8ywpVs+KAYA+jeAF
   w==;
X-CSE-ConnectionGUID: hrHvm2S4SBO0bJNBhO6/4A==
X-CSE-MsgGUID: hT5BmZ1BRo6HRe1W46VY0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69833878"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69833878"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 01:10:38 -0800
X-CSE-ConnectionGUID: Dso6PzEeTtioHJeThlGrxQ==
X-CSE-MsgGUID: AgKA3APWTyqXV4mNT7EQrg==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 01:10:34 -0800
Date: Mon, 24 Nov 2025 11:10:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jorge Marques <jorge.marques@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: Add support for ad4062
Message-ID: <aSQhCKBC36T9t-H1@smile.fi.intel.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-3-0f8ce7fef50c@analog.com>
 <20251018171032.144a126c@jic23-huawei>
 <ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
 <aSQMjZbc75cQtFqJ@smile.fi.intel.com>
 <o4kt2of4xql4azufjgiecm4jzuexgm6nkvr7aghbwfk6qd7yqd@r4plggehzces>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o4kt2of4xql4azufjgiecm4jzuexgm6nkvr7aghbwfk6qd7yqd@r4plggehzces>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 09:57:26AM +0100, Jorge Marques wrote:
> On Mon, Nov 24, 2025 at 09:43:09AM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 23, 2025 at 08:48:09PM +0100, Jorge Marques wrote:
> > > On Sat, Oct 18, 2025 at 05:10:32PM +0100, Jonathan Cameron wrote:
> > > > On Mon, 13 Oct 2025 09:28:01 +0200
> > > > Jorge Marques <jorge.marques@analog.com> wrote:

> > > Mostly acknowledgements and explanations, except a comment on ACQUIRE usage.

...

> > > > > +static int ad4062_read_chan_raw(struct iio_dev *indio_dev, int *val)
> > > > > +{
> > > > > +	struct ad4062_state *st = iio_priv(indio_dev);
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> > > > There is a nice new
> > > > 	ACQUIRE()/ACQUIRE_ERR() related set of conditional guards defined that
> > > > let you do this using cleanup.h style.
> > > > 
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a0abc39450a3123fd52533a662fbd37e0d1508c
> > > > 
> > > > This looks like a perfect example of where those help.
> > > > 
> > > > When I catch up with review backlog I plan to look for other
> > > > places to use that infrastructure in IIO.
> > > > 
> > > I tried implementing, here becomes
> > > 
> > >         ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> > >         ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> > > 
> > > At buffer and monitor, since we put the device as active during the
> > > lifetime of the buffer and monitor mode, either I leave as is, or I bump
> > > the counter with pm_runtime_get_noresume, so when the method leaves, the
> > > counter drops to 1 and not 0, then on disable I drop the counter back to
> > > 0 and queue the autosuspend with pm_runtime_put_autosuspend.
> > > > 
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = ad4062_set_operation_mode(st, st->mode);
> > > > > +	if (ret)
> > > > > +		goto out_error;
> > > > > +
> > > > > +	ret = __ad4062_read_chan_raw(st, val);
> > > > > +
> > > > > +out_error:
> > > > > +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > > > > +	return ret;
> > > > > +}
> > 
> > I read the above code, I read it again, I don't understand the reasoning.
> > The ACQUIRE() doesn't change the behaviour of the above code.
> > 
> > If you need to bump the reference counter, it should be done somewhere else
> > where it affects the flow, or this code has a bug.
> > 
> > If I miss something, please elaborate.
> 
> The part highlighted does not require bumping the reference counter, but
> at the buffer acquisition and monitor mode, to not put the device back
> in low power mode during the lifetime of those operations.
> 
> Buffer more:
> 
>   static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
>   {
>           struct ad4062_state *st = iio_priv(indio_dev);
>           int ret;
> 
> 	  // [ Some code ]
> 
>           ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
>           ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
>           if (ret)
>                   return ret;
> 
> 	  // [ More code ]

>           pm_runtime_get_noresume(&st->i3cdev->dev);


Yes, this looks good if it makes the error paths cleaner.
Also consider adding

	struct device *dev = &st->i3cdev->dev;

at the top of the functions that use it, it might make code better to read.

>           return 0;
>   }
> 
>   static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
>   {
>           struct ad4062_state *st = iio_priv(indio_dev);
> 
>           pm_runtime_put_autosuspend(&st->i3cdev->dev);
>           return 0;
>   }
> 
> Monitor mode:
> 
>   static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
>   {
>           int ret = 0;
> 
>           if (!enable) {
>                   pm_runtime_put_autosuspend(&st->i3cdev->dev);
>                   return 0;
>           }
> 
>           ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
>           ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
>           if (ret)
>                   return ret;
> 
> 	  // [ Some code ]
> 
>           pm_runtime_get_noresume(&st->i3cdev->dev);
>           return 0;
>   }

-- 
With Best Regards,
Andy Shevchenko



