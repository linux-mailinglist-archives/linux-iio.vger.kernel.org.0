Return-Path: <linux-iio+bounces-15874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD5A3DD70
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF82F16DD82
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318A1D5145;
	Thu, 20 Feb 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqP9ND1I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600F1D5144;
	Thu, 20 Feb 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063400; cv=none; b=QfK/BJqmS6102ajTuaWc5m2nWXTfo9QI6yi4HDAzqz6HSbba5Bg7ukYU2/Nns9FtedHXPyK52GRwUJCIofTrfxUA/LmiwIpSjYePgzDzgl6oNm7AxMPKnxNQdg7U2czgg0pd2URZBep/NzKQ3ZFnvaGA7MCwBIHQpr+k6mNsooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063400; c=relaxed/simple;
	bh=YbwDdBsjti3If6R1AwRXFGvljRGPfJvCwZ3grv5CLiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd9grvq2tI6Uu0Hwx7RLhaTzAosyUP4Schrnt8iv0+Av4LmYxHDVBa4910rTz+jMtdpqmebVcYTPP5zzyyPSk2mhJs34BGcLQu85lp8xB72wkOowGBifEqlJSYUV77ug4dk3FUZR9VLcou7ZHAtQecECb5BqxAwvFS+ShHCHvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqP9ND1I; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740063399; x=1771599399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YbwDdBsjti3If6R1AwRXFGvljRGPfJvCwZ3grv5CLiE=;
  b=iqP9ND1I4iqJ8x9Jlcwv+TT458mjzOuVUzX2GbjmmiaMSCwVz3qJqikZ
   BvURC4gVeBkNJtjd5sTQ65GvuWap/+cgCQWV9Wl2p2Bn0CGWXDYGL7CbR
   IBj/WiGQVE0Jm6sLuAnVxuZGkFC5k3rlVWiCxcafEK6j91JFbVEUAM60X
   E8w1JJKlv0Hp9fUzJuKs02l9WpkOgfg15cFnimyUwPgiz3R9gNJ5dqsVe
   a95DpanRdNEDTe3TUdi5eq8iGRFobZyHemvAYklkPdV7rXPnWOqRQunMe
   /+WL4YDGcxHtHxLsdbtEA5rTaWNzTOpFRZD/9n/hppCuPI1Qf3RTgmjj/
   g==;
X-CSE-ConnectionGUID: vIX8f8HqRmmyFIOWZsstkw==
X-CSE-MsgGUID: oysxh224QZm3Wc2YnbpcRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="63318719"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="63318719"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 06:56:38 -0800
X-CSE-ConnectionGUID: kEVuldFkQf6vlSbyMU3vxA==
X-CSE-MsgGUID: DEsCk3iDTmePuyZP91z/Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="145916713"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 06:56:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl7yY-0000000DMq3-05wg;
	Thu, 20 Feb 2025 16:56:30 +0200
Date: Thu, 20 Feb 2025 16:56:29 +0200
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
Message-ID: <Z7dCnRzuQTaJXzmb@smile.fi.intel.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
 <Z7ZB7RQhyI5Dohrq@smile.fi.intel.com>
 <b1c1ed68-2f4d-447c-9957-5a1bbc63ef6e@gmail.com>
 <Z7ci7tUlRQqZEZSN@smile.fi.intel.com>
 <ec76334b-bb13-4076-811d-9174170dd677@gmail.com>
 <Z7c2cBQpjoc9-Vyu@smile.fi.intel.com>
 <9018e23c-da28-41b0-b774-1598b946a2a1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9018e23c-da28-41b0-b774-1598b946a2a1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 04:21:37PM +0200, Matti Vaittinen wrote:
> On 20/02/2025 16:04, Andy Shevchenko wrote:
> > On Thu, Feb 20, 2025 at 03:40:30PM +0200, Matti Vaittinen wrote:
> > > On 20/02/2025 14:41, Andy Shevchenko wrote:
> > > > On Thu, Feb 20, 2025 at 09:13:00AM +0200, Matti Vaittinen wrote:
> > > > > On 19/02/2025 22:41, Andy Shevchenko wrote:
> > > > > > On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:

...

> > > > > > > +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
> > > > > > 
> > > > > > No namespace?
> > > > > 
> > > > > I was considering also this. The IIO core functions don't belong into a
> > > > > namespace - so I followed the convention to keep these similar to other IIO
> > > > > core stuff.
> > > > 
> > > > But it's historically. We have already started using namespaces
> > > > in the parts of IIO, haven't we?
> > > 
> > > Yes. But as I wrote, I don't think adding new namespaces for every helper
> > > file with a function or two exported will scale. We either need something
> > > common for IIO (or IIO "subsystems" like "adc", "accel", "light", ... ), or
> > > then we just keep these small helpers same as most of the IIO core.
> > 
> > It can be still pushed to IIO_CORE namespace. Do you see an issue with that?
> 
> No. I've missed the fact we have IIO_CORE O_o. Thanks for pointing it out!
> 
> > Or a new opaque namespace for the mentioned cases, something like IIO_HELPERS.
> 
> I am unsure if it really benefits to split this out of the IIO_CORE. I've a
> feeling it falls into the category of making things harder for user with no
> apparent reason. But yes, the IIO_CORE makes sense.

Probably I was not clear, I mean to put this under a given namespace. There is
no a such, we have currently:

IIO_BACKEND
IIO_DMA_BUFFER
IIO_DMAENGINE_BUFFER
IIO_GTS_HELPER
IIO_RESCALE

> > > > > (Sometimes I have a feeling that the trend today is to try make things
> > > > > intentionally difficult in the name of the safety. Like, "more difficult I
> > > > > make this, more experience points I gain in the name of the safety".)
> > > > > 
> > > > > Well, I suppose I could add a namespace for these functions - if this
> > > > > approach stays - but I'd really prefer having all IIO core stuff in some
> > > > > global IIO namespace and not to have dozens of fine-grained namespaces for
> > > > > an IIO driver to use...

...

> > > foo &= (~bar);
> > > 
> > > is _much_ faster than seeing:
> > 
> > Strongly disagree. One need to parse an additional pair of parentheses,
> > and especially when it's a big statement inside with nested ones along
> > with understanding what the heck is going on that you need them in the
> > first place.
> > 
> > On top of that, we have a common practices in the LK project and
> > with our history of communication it seems you are trying to do differently
> > from time to time. Sounds like a rebellion to me :-)
> 
> I only rebel when I (in my opinion) have a solid reason :)
> 
> > > foo &= ~bar;
> > > 
> > > and having to google the priorities.
> > 
> > Again, this is something a (regular) kernel developer keeps refreshed.
> > Or even wider, C-language developer.
> 
> Ha. As I mentioned, I've been writing C on a daily bases for almost 25
> years. I wonder if you intent to say I am not a kernel/C-language developer?
> Bold claim.

I'm just surprised by seeing that style from a 25y experienced C developer,
that's all.

-- 
With Best Regards,
Andy Shevchenko



