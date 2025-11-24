Return-Path: <linux-iio+bounces-26398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D862C7F3B4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 08:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28428342F7E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA02E9759;
	Mon, 24 Nov 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C90MiOOU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9E381C4;
	Mon, 24 Nov 2025 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970197; cv=none; b=S448+BPe9caqhMTUdm1q4a366UIpBxyTSANMUjuVz8snW7vqYP3AjQxTQpmhNlSCn0X7xdgB2D2po5qtM2XkgduS2IhR8WpoTqHWjqxw3scoHH4ziU4p3mXKEugAQojXMyFuzc3qBtS5OmnbySjcy6O0OZ9XK2wP+gx6SMGmtuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970197; c=relaxed/simple;
	bh=LYf+9XcisUREKO79eSRnlzkTlvJ/bWw47p/chnCxJoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZKLIWeRMHITwBel/cUHz+z7SFrIlvIqoEAUZHBPLPrgof5Tr0MbxR9MhMdS3N5LA3PShwPvEE8tR386yZcMD/cHiPwGM9igSPvj5mU0KEI1kVUiv7VjOtZy3UeN4CTTdVqkvsw5e8BXWQfEw8wHymTZRpR3e+vUqeB8Igs6298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C90MiOOU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763970196; x=1795506196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LYf+9XcisUREKO79eSRnlzkTlvJ/bWw47p/chnCxJoQ=;
  b=C90MiOOUE+mg3I1/gfdQ5G6+W5TLMPdM+anPtc5Lbb8EVkicPEmQ57ao
   6kj9bRdq2AYiW89xFbiKdiF8b4brDIdXV1BztCiJt6h53OB7vm1qufIoz
   N4367Sp75MPJ36CeZA7tDRbQW8P2ojD2CoRVK+91rfFqr1BrJxL5Yft5V
   CUMMszkQXiqWzkZgFvWyKlbEaHnbXZu2w0RnD7siLoHvkf3TRHmE7dhbF
   tV2isEZSXN0QxPRIk9+fwGh6tgGjdWHD4QwlXrmGkUGGujk2X8UwoGezn
   do9K8X/zYP2TtJrNAAqP3sBC+oALHHyqLBSHBIlyMXF8rj5ejrhtyaTzf
   A==;
X-CSE-ConnectionGUID: xt80C35PTRCRI8kjdmwuuw==
X-CSE-MsgGUID: XYXtV2SqQsqkFgTCZi0D0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="77325078"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="77325078"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 23:43:15 -0800
X-CSE-ConnectionGUID: 0oyGKiqwTa2T6lCyPNWCJg==
X-CSE-MsgGUID: L53CV2/pRdS5j+ij0p6v5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="191544970"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 23:43:11 -0800
Date: Mon, 24 Nov 2025 09:43:09 +0200
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
Message-ID: <aSQMjZbc75cQtFqJ@smile.fi.intel.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-3-0f8ce7fef50c@analog.com>
 <20251018171032.144a126c@jic23-huawei>
 <ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 23, 2025 at 08:48:09PM +0100, Jorge Marques wrote:
> On Sat, Oct 18, 2025 at 05:10:32PM +0100, Jonathan Cameron wrote:
> > On Mon, 13 Oct 2025 09:28:01 +0200
> > Jorge Marques <jorge.marques@analog.com> wrote:

> Mostly acknowledgements and explanations, except a comment on ACQUIRE usage.

...

> > > +static int ad4062_read_chan_raw(struct iio_dev *indio_dev, int *val)
> > > +{
> > > +	struct ad4062_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> > There is a nice new
> > 	ACQUIRE()/ACQUIRE_ERR() related set of conditional guards defined that
> > let you do this using cleanup.h style.
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a0abc39450a3123fd52533a662fbd37e0d1508c
> > 
> > This looks like a perfect example of where those help.
> > 
> > When I catch up with review backlog I plan to look for other
> > places to use that infrastructure in IIO.
> > 
> I tried implementing, here becomes
> 
>         ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
>         ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> 
> At buffer and monitor, since we put the device as active during the
> lifetime of the buffer and monitor mode, either I leave as is, or I bump
> the counter with pm_runtime_get_noresume, so when the method leaves, the
> counter drops to 1 and not 0, then on disable I drop the counter back to
> 0 and queue the autosuspend with pm_runtime_put_autosuspend.
> > 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = ad4062_set_operation_mode(st, st->mode);
> > > +	if (ret)
> > > +		goto out_error;
> > > +
> > > +	ret = __ad4062_read_chan_raw(st, val);
> > > +
> > > +out_error:
> > > +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > > +	return ret;
> > > +}

I read the above code, I read it again, I don't understand the reasoning.
The ACQUIRE() doesn't change the behaviour of the above code.

If you need to bump the reference counter, it should be done somewhere else
where it affects the flow, or this code has a bug.

If I miss something, please elaborate.

-- 
With Best Regards,
Andy Shevchenko



