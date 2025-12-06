Return-Path: <linux-iio+bounces-26859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D1CAADB8
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FEB330B2112
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531762D8382;
	Sat,  6 Dec 2025 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irzKdLmY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B331B0F23;
	Sat,  6 Dec 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765054108; cv=none; b=SfY6lCYIp/eEYsq+8pOIuEeckE02G5KnBmr6B6H9L4HzUEmyUoa6NuQy4ujkNGDmF8c/hHTQfu3R5MrBLuL7bsiTaBosWYCW+oAfDjNjLEr2fTCmYK+oy7WsqLLsVIWVQRF8pbcyiP6GNldsBNjD96psRlnBFhAC/vgGHs0IhSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765054108; c=relaxed/simple;
	bh=0oI2cggSDbR+MiiLqwYKpRO0/g+qS2eYa/qwUN9EXBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4+dFpitasUfzfdmiDRoaGy3wyCTVV8Xm7LK3yyTBmf7RfoXzIo7Vill6Lt5Ch8h5l7IzSGzF1qSqfVuUWpXu5MLryxG+g+spwpR0SwI5st/E89pkzSSlJ1Fx8/jezZ2ikdicHJ+4wlEqvXgQ4epmTZD8Z8zIloBfYhMaID/wuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irzKdLmY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765054106; x=1796590106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0oI2cggSDbR+MiiLqwYKpRO0/g+qS2eYa/qwUN9EXBk=;
  b=irzKdLmY480SomeApmfeTQv0PNlAKhtze8FtHvPH+zj2t1BUNXcJuH1G
   c6np812yflqTdrUk0mVercfU3X16kZ/poJv9BcMqjXxMf+Uy4zTGARZqy
   sB+gXForYcmbfzfIYNuDwfGYxRHQHSnh9H7DwlBW1M68WzkJACp3JFCx7
   ObZ7UC9a0YgBCspQwyTHSr9Es+I1Otmdwt/2SYeHH52tgdHYP2t2Walvk
   Ain6Z5YRqTxcpRsUqFIY48w8zzz68r07OiNxuIWWfHdeeVaVcgqPh0+F+
   kve/CqtJgQVAqExouLi8NFecldn3T/ldaMx3XAm484RK41S6Lx3lgdBVG
   A==;
X-CSE-ConnectionGUID: /vQMXPs0Qyy8i35yga919Q==
X-CSE-MsgGUID: RB3WHcLOTfaFKnCCgUUGbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="69649713"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="69649713"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 12:48:25 -0800
X-CSE-ConnectionGUID: S5ltlwO5TBu8hnFTUgqrQw==
X-CSE-MsgGUID: UvSjCCGATo+nKLOPMRAIqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="195402322"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 12:48:22 -0800
Date: Sat, 6 Dec 2025 22:48:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Message-ID: <aTSWk_p62hJBKCtN@smile.fi.intel.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
 <20251205144058.1918-3-antoniu.miclaus@analog.com>
 <20251206190332.53874d41@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206190332.53874d41@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 06, 2025 at 07:03:32PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 16:40:41 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

...

> > +	/* Always include internal amplifier (14dB) */
> > +	st->gain_configs[i].path = ADL8113_INTERNAL_AMP;
> > +	st->gain_configs[i].gain_db = 14;
> 
> Could do this as something like:

I remember a discussion where it was against this approach due to compiler
warnings or so. However, IIRC, there was slightly different pattern, i.e.

	foo[i].bar = ...
	foo[i++].baz = ...

That said, I have no objection to your proposal, but we need to use it with
a good compile test coverage (clang with `make W=1` for a starter.

OTOH, the original code is robust enough...

> 	st->gain_configs[i++] = (struct adl8113_gain_config) {
> 		.path = ADL8113_INTERNAL_AMP,
> 		.gain_db = 14,
> 	};

...and doesn't require a good understanding of differences between designated
initialisers and compound literals.

> 	st->gain_configs[i++] = (struct adl8113_gain_config) {
> 		.path = ADL8113_INTERNAL_BYPASS,
> 		.gain_db = -2,
> 	};


-- 
With Best Regards,
Andy Shevchenko



