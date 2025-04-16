Return-Path: <linux-iio+bounces-18156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539EA8B10E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 08:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C6A3AF686
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309E22539D;
	Wed, 16 Apr 2025 06:47:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CA1F416A;
	Wed, 16 Apr 2025 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786032; cv=none; b=CkSM6N62ucUdERz/KNX5WrdZxP0owmsY99mZpA4icxs3oN6KDecoR2UW5X5QgpDMGcTUAKd3V28O3v0IXMmILfd4RzqtwYAsz0S/7Q2HRyYBZM/Uip3zEYX0CS+caRmnBWhxztmkPaIK0njGYH94zFTkXkkWqxTIinoE7MKYBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786032; c=relaxed/simple;
	bh=v4MkhYmM6oeYz7WbeIOXOxzwvDrwNocyD+Et+z0xPts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQOKlLLxdna3nJP6eYhqTHhS0UvN5dtBxV7UK8YRO/KIBHEK5WhgJCO2u89bz1U2Kc5HpsfXV/wVadkxII7Dqg9HlZ+epiuRSfTpc+3YPoP70iBIQoUNYh/Xof3epgY+pwHs138k84ZCqgcPNu25kWs6MygMqmR9rMNXk1bf0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: RFrqay15QsiB0ZzdVZWatw==
X-CSE-MsgGUID: 2UrVFvPfQ9+5pe6qcUlG8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57313733"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="57313733"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:47:10 -0700
X-CSE-ConnectionGUID: +pxPWeTjRceJd88M+15GHg==
X-CSE-MsgGUID: PMPeNWJ9SAyG5oLvOSf+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130368410"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:47:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u4wY4-0000000Cllc-0Bzx;
	Wed, 16 Apr 2025 09:47:04 +0300
Date: Wed, 16 Apr 2025 09:47:03 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH] iio: adc: ad4000: Avoid potential double data word read
Message-ID: <Z_9SZ_XgKfv4DliG@smile.fi.intel.com>
References: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
 <CAHp75VendQGLdpggySS3mX6M2YSeS70bvE8yg7sp_LNGDS-Scg@mail.gmail.com>
 <22858e4f-db8e-4c97-8551-a1934a9f2fe7@baylibre.com>
 <CAHp75VdKpSnwfKO4GaJmVOs8kHASsZ4V9yNcZ7EF_GVoDNmrfw@mail.gmail.com>
 <CAHp75VfuCkohVLUJKgcMrgad-fRk4aKx_Ki0gRxxhJP3qgvS1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfuCkohVLUJKgcMrgad-fRk4aKx_Ki0gRxxhJP3qgvS1g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 09:01:02AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 16, 2025 at 8:59 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Apr 16, 2025 at 12:22 AM David Lechner <dlechner@baylibre.com> wrote:
> > > On 4/15/25 1:02 PM, Andy Shevchenko wrote:

...

> > > It would have to be:
> > >
> > >         xfers[1].len = roundup_pow_of_two(BITS_TO_BYTES(chan->scan_type.realbits));
> > >
> > > But that gets too long for 1 line
> >
> > Actually there are a handful of drivers including SPI core that need
> > that helper already, I would prefer to have a helper defined in spi.h.
> >
> > , so I prefer what Marcelo wrote.
> > >
> > > Maybe an idea for another day:
> > >
> > > #define SPI_LEN_FOR_BITS(bits) roundup_pow_of_two(BITS_TO_BYTES(bits))
> >
> > Right, but as static inline to have stricter types.
> >
> > > There are a couple of places in spi/ that could use this and several
> > > iio drivers.
> 
> Or even wider, in bitops.h / bit*.h somewhere. Let me craft a patch.

Just sent a mini-series, you are in Cc there.

-- 
With Best Regards,
Andy Shevchenko



