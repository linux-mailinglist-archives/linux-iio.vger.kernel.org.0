Return-Path: <linux-iio+bounces-20572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA5AD7AED
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7457A95F3
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA82D0267;
	Thu, 12 Jun 2025 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkZqj9zZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8929898B;
	Thu, 12 Jun 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749755422; cv=none; b=OkRe7CWvlTnHhIV6o6yFLrElAjj1x6HeLE7RRGj9st27jTp8UujfAD+GZEYmNlRPw2pQc02qsZyuIrH8kv0LHIIWvNV1wh/APjQt18epCU8JYZXjyXcApVqr4dbRBqFUZFvsMS4CPTR6CsxhlVe/YyViDKs4q6xKfQYs9nnw44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749755422; c=relaxed/simple;
	bh=BQ0TV5Stz/vWyyu62ZhSbJbmlu58TvJYqNpEEOYBVC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e90xr5c+oLFWYE99NwvIP3ohDbuG29+KN4rVNb29U5msZTnlg83ow2E8+n7pxxEWAcPD3MbACxHx43zD7D6TA9igbw63eIxVT04W+D13+X2una8wVC7Ru4bDAcNHc6wIuBp+Cs0Jr8fSmfG02rJkbQ7dRX25g4S/pcpOW1frKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkZqj9zZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749755422; x=1781291422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BQ0TV5Stz/vWyyu62ZhSbJbmlu58TvJYqNpEEOYBVC0=;
  b=GkZqj9zZAh6+L9J73XsL+f0yQ35oiUsyVJz4Sx+w62ysjQ8JyaCoJ1mV
   ETts5XFckit8gA1w5G0bsoyEY2p6uB3G6LiqUOmQwuMOllbYR4m8dwXqr
   KClqbKO/FuU5hLG7Q6TCXcMQ612q+p/PBJ5KHeM4qhMiOgFWb7xejuvsJ
   AnWosiPvaq2YYUsx15liZEWOgj/H6m7WGNbbnlR55tt9u4qo6WA/6ot1g
   G/axo7vVzhQ0LWFFupKzZEIN+oXGAvPM0wnQO8+t74P7r5oYeIMyioBSM
   WbtWgpy5SrDPfHvzUdgDdr1S2XR7VuyvxbQ9U2D3mxFeg4Ah2JSlMo+aV
   g==;
X-CSE-ConnectionGUID: GFSTUfQdQBOH8IzSqSP2AA==
X-CSE-MsgGUID: LNJq3U4kRu6TIEeQd3hu9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52093210"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="52093210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 12:10:21 -0700
X-CSE-ConnectionGUID: e9iD3O3SS36bVUZFVNkguw==
X-CSE-MsgGUID: lSBa5jyTT9mJ70WAU7t4XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="184852801"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 12:10:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPnJQ-000000061me-0q0g;
	Thu, 12 Jun 2025 22:10:08 +0300
Date: Thu, 12 Jun 2025 22:10:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-rockchip@lists.infradead.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
	Roan van Dijk <roan@protonic.nl>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/28] iio: zero init stack with { } instead of memset()
Message-ID: <aEsmDyc44P8amm5p@smile.fi.intel.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
 <aEqbQPvz0FsLXt0Z@duo.ucw.cz>
 <2243943.irdbgypaU6@workhorse>
 <aEsiTy++yKGe1p9W@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEsiTy++yKGe1p9W@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 08:54:07PM +0200, Pavel Machek wrote:
> > On Thursday, 12 June 2025 11:17:52 Central European Summer Time Pavel Machek wrote:
> > > 
> > > > Jonathan mentioned recently that he would like to get away from using
> > > > memset() to zero-initialize stack memory in the IIO subsystem. And we
> > > > have it on good authority that initializing a struct or array with = { }
> > > > is the preferred way to do this in the kernel [1]. So here is a series
> > > > to take care of that.
> > > 
> > > 1) Is it worth the churn?
> > > 
> > > 2) Will this fail to initialize padding with some obscure compiler?
> > 
> > as of right now, the only two C compilers that are supported are
> > GCC >= 8.1, and Clang >= 13.0.1. If anyone even manages to get the
> > kernel
> 
> Well... I'm pretty sure parts of this would make it into -stable as a
> dependency, or because AUTOSEL decides it is a bugfix. So..
> 
> GNU C                  4.9              gcc --version
> Clang/LLVM (optional)  10.0.1           clang --version

Even though, what the kernel versions are you referring to? I am sure there
plenty of cases with {} there.

-- 
With Best Regards,
Andy Shevchenko



