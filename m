Return-Path: <linux-iio+bounces-26081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DDC441B9
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 674894E4FAD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09A2FBDE0;
	Sun,  9 Nov 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7EvVQM0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F351CEAC2;
	Sun,  9 Nov 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704151; cv=none; b=Xbqfkm0oIK6z+pF4VvJnR+d80LHu32bGnqVVBIhoVNQVOBncFaWKuK3l2ynLPl/ycoJfF+T1t2oM4rflEVzI4eKmdArIXN7DK/u1YmKEur9SCFZLlFEyYfdFxZyu9KrL8Dnx6EiGvtI9Z9Gn1PKPCXFAlmtcSizqvn2XF1OLnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704151; c=relaxed/simple;
	bh=akRYaQ8oQc0GEO6lBbgLh4RrTlk2tsQwvjYanGUrRCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noIkZ4yEWq3625Ns3wEtJ+NTM6mugTlSSQMIpJqT2DmD5uaboN5FUpLkpQ2icC9Cvm/XY7KmH272r5FtU3y7t0J7WAmCpkq1KjQnUNMGZI2rCdzFGkXbw08MihucpQ6N7rmJBLZYn/x4/y6oEwpa8/1MrI7OhUQjsbaucqLS7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7EvVQM0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762704150; x=1794240150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=akRYaQ8oQc0GEO6lBbgLh4RrTlk2tsQwvjYanGUrRCs=;
  b=g7EvVQM0Li8ySqCj2p8sJgGVTXQdscZnTCaOT52lx7rTmOYZjZ8w1YaC
   eB0bW4SO8RIjF+BuLjH1rUb0zwp5ej5ebSmjhMcfqeA7cKJwCuxri0VCP
   F8gH/ZBvbfqxQRYtZ3qL6ouI3KucqeYrZ+BOVeCopO8Xwz2Ku06622m16
   vUaM1cMGvdUA0BxsJ0ofYBtls0GgLc+Cm8tMSxOHSlCc2EezTOn+boCnl
   dS2k13wkRt16KVlSgzZPY18gHbUFmh1d9znEm7a/ugxXMk0o+7Le6x5xH
   AWQdfQwFk+P1WQzSDO5LGa4+Iqj83wfq+YTWw0H7ydUX/nX+OrDx7WfuO
   w==;
X-CSE-ConnectionGUID: T646Ahs7TpKU10Ubl7eY6g==
X-CSE-MsgGUID: j2Rl+PPcRzuG1iinCEEZvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75882990"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="75882990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 08:02:29 -0800
X-CSE-ConnectionGUID: 1qK6HE27TmeR+1ZnoGsazQ==
X-CSE-MsgGUID: OTZj4hbkSaKJBg3C2D/s/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="225734364"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 08:02:27 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vI7s0-000000073nB-31kB;
	Sun, 09 Nov 2025 18:02:24 +0200
Date: Sun, 9 Nov 2025 18:02:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Antoni Pokusinski <apokusinski01@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <aRC7EPHXEtcwkGak@smile.fi.intel.com>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
 <aQ1Rdcbi3e8lzOvM@debian-BULLSEYE-live-builder-AMD64>
 <20251107220106.ihk6e46paxmyfqgg@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
 <aQ-UfmTkRX75BOfg@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ-UfmTkRX75BOfg@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 08, 2025 at 04:05:34PM -0300, Marcelo Schmitt wrote:

...

> > > > +		if (val < 0 || val > U16_MAX)
> > > Alternatively, could use in_range() for the check.
> > > 
> > > > +			return -EINVAL;

,,,

> > > > +		if (val < S8_MIN || val > S8_MAX)
> > > this could also use in_range().
> > > 
> > > If you opt for the macro,
> > > #include <linux/minmax.h>
> > >
> > I see that the in_range() macro operates only on unsigned values, so
> > placing it here would be wrong I guess. In order to keep the style
> > consistenc in this function, I'd keep both checks as "val < x || val > y"
> > 
> Ah, good point. Okay, no objection. 


Actually we need something like in_the_range() or so which takes the min/max pair instead of start-end. And make it work for any signdness.

> > > > +			return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko



