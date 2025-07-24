Return-Path: <linux-iio+bounces-22000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986EB11315
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 23:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377B71C27820
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034252EE973;
	Thu, 24 Jul 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYCq2Bn9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1C2EE962;
	Thu, 24 Jul 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392403; cv=none; b=kkFFHZ9XbuSkH3x20np4WgM3IXJ4hdCQO5BRZ/KVD1dWroCPKymLz9IHVlm+56nvjGIvmi0N/izqGdnJEgY8GLZwUZN+msXfGzHpFdx/xveRrKKh3tsk+cRJ9TgfjsTdU08j9ppVQO2tOWMXlwZt1CgPgPqlI6lfsjPZeniULFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392403; c=relaxed/simple;
	bh=EfX6aQqkaAynLlfF++u2MHxnMAbP6JMoA+Q8z6ldujQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P14KbbIUEo0OIhCFGKN1FabNjchOT8oDD9KFBL1C8ktNB06FKKYH5FL6ST2djKxBKX4ceIwUbjsZLM8/oIiovsh+1rrq90BXff/k8bQ65mLtM4WrMhUQDyY5OlhWBHVsrb9W7LDf7TI5qdd9LCdP2WbiGTCIl1FJMS/CVMuipsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYCq2Bn9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753392403; x=1784928403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EfX6aQqkaAynLlfF++u2MHxnMAbP6JMoA+Q8z6ldujQ=;
  b=iYCq2Bn9NAe8GZUBLLMoU1CTW8Q1UJ+yKE/i1Zvxr1t3uCsTg2LyT7r5
   wgqftSUNyuARDyoNKgEtOQki5jMV+RgJTAO4JYBFxBycfLf0I2nntjEsv
   IHoXdH5/waG5AE/UQ1ul7N1O7UFv0yC18m+r5UQBRQVmNwSzuDRTVbX4r
   Q22SVbiEYQlOhGqVY686zE/0vXCjN5167X91Lj6qzelCzNhmlEwITueds
   ETJT6eiF5CJr2sT3cwo6QMsF6ZJwKODJAtWs9EDXh0A4dXGXWOHswthrn
   noQNmmSYkjpQHvbqVdPRCAXBcIyj9kg+sfZ0+U6oIHb2jHeng/5rcLPot
   w==;
X-CSE-ConnectionGUID: 8a6LtsSnT2iTPnsK4uroCg==
X-CSE-MsgGUID: x848tIYkTKCCx2N3I5TQrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55873279"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55873279"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 14:26:41 -0700
X-CSE-ConnectionGUID: iUGxf4nrSSuoV6KIJxKKfA==
X-CSE-MsgGUID: UNW5t2e0QFSJsUyt8+v7CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="184134516"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 14:26:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uf3SV-00000000fr7-3O11;
	Fri, 25 Jul 2025 00:26:35 +0300
Date: Fri, 25 Jul 2025 00:26:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gustavo Silva <gustavograzs@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <aIKlC-HlP3nX-ERA@smile.fi.intel.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
 <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
 <aHYIBReTFqJMtiXW@smile.fi.intel.com>
 <vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
 <aHd2s987EMCdgdrJ@smile.fi.intel.com>
 <20250724162227.065d20a0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724162227.065d20a0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 24, 2025 at 04:22:27PM +0100, Jonathan Cameron wrote:
> On Wed, 16 Jul 2025 12:53:55 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jul 15, 2025 at 08:55:35PM -0300, Gustavo Silva wrote:
> > > On Tue, Jul 15, 2025 at 10:49:25AM +0300, Andy Shevchenko wrote:  
> > > > On Tue, Jul 15, 2025 at 10:37:22AM +0300, Andy Shevchenko wrote:  
> > > > > On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:  

...

> > > > > > +/* 9.81 * 1000000 m/s^2 */
> > > > > > +#define BMI270_G_MEGA_M_S_2				9810000  
> > > > > 
> > > > > I thought this is MICRO...  
> > > > 
> > > > Btw, what if we use the device on poles and on equator (or even on orbital
> > > > station)? I'm wondering if this constant should be defined in units.h or
> > > > even in uAPI that user space may add a correction if needed.
> > > >   
> > > I certainly hadn't thought about these scenarios.
> > > FWIW, the accelerometer scale values also assume g = 9.81 m/s^2.
> > > For example, 0.000598 = 2 * 9.81 / 32768  
> > 
> > Right, but this should be supplied to user space somehow. OTOH the measure error
> > may be high enough (what is the precision of the measurements by the way?) that
> > it will neglect the differences in the 'g' constant.
> > 
> > All the details are given in [1].
> > 
> > [1]: https://en.wikipedia.org/wiki/Gravity_of_Earth#:~:text=The%20precise%20strength%20of%20Earth's,/s2)%20by%20definition.
> 
> These sensors don't measure relative to g.

What do they measure? Any links for me to study?

> That's annoying marketing which is why I held firm for m/s^2 for IIO :)
> So what they measure for a given acceleration does not change depending
> on where we are on earth. You should use a 'fixed' standard value for
> conversion from marketing values in g to m/s^2..

Hmm... But shouldn't that marketing value be exposed to user space?


-- 
With Best Regards,
Andy Shevchenko



