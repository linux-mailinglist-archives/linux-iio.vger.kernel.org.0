Return-Path: <linux-iio+bounces-24100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA5B5709C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 08:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB88616B62E
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC42BD5A2;
	Mon, 15 Sep 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3xDtv0h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75972BD59C;
	Mon, 15 Sep 2025 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918783; cv=none; b=pQkt4mwMN89t1WbawMF2Uvte8QtmNEA5oRHl5Dq10skwuUZaXNWOA4yjqkLGkzUx22VCIGIB5tHY19lpGN93eSIPmj7xpFDZsjQsK/xQCnwZJn5i0ZeHAjvDHaTX6rAHAH8UstF5HC8XvGXgaNtWpKe0rTVVlOYIPU1jocO327k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918783; c=relaxed/simple;
	bh=cmgS2z03ZvYjY3BA1InRHzrqI41lDySPZ1Y6UvJpps8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOhY62ROfMdxV96t7OxXoCH9R94cYMHQwnnOhiVjKQQkBTQlQk0/zHRpH8stJuIVnA5knFN3oQmSVwNuBETfi096+JVQ49onFBTngjTzv0CS7z6fFGaV/KEqxudn2b2bYhijVZm7WOOwY03n/ZPoKnzbMzIx3ik8BamMROVztlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3xDtv0h; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757918782; x=1789454782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cmgS2z03ZvYjY3BA1InRHzrqI41lDySPZ1Y6UvJpps8=;
  b=Y3xDtv0hKRLLOl6Gz7nsXW1OvvpcrNHsbLknkvIjC2vBhQ6sBAeNIy9F
   Zwtk8lSZ/hscVqWd3HjEh0d/pAN73BTGhngUTQ/2fw97S1VCcro6mnUlT
   wI2wDvFwYfnIiklxnXBez/6HWS6W7XOwmSQTxwAsM+S14/3FZZ8kp98Jz
   jpo16BtPLVA6WyUMLS81oh82+OTlb1Gcy2UvKpSlo1bSDJdO8lLzS3Nh6
   G3mjfrLOafzHEG4/6D08hyEA3ptHvdDaDJsHGD7WhuZoBqTDwlOUePP8e
   oKX1jpnozqDB5sPYRMw2fw9dOzYvoWXoANtx6GLRDCjxNZe1V/iaLMaKo
   w==;
X-CSE-ConnectionGUID: w/ErTmdBQ1upi6KZ1huxzw==
X-CSE-MsgGUID: xeed5aOySa2KBBdGopTR0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="47731674"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="47731674"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:46:21 -0700
X-CSE-ConnectionGUID: alMmINDRSgy70osL0q2/dA==
X-CSE-MsgGUID: oWfXSeK3R+OLKpxqLs0S6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174079788"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:46:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uy2ye-00000003B3E-0HRj;
	Mon, 15 Sep 2025 09:46:16 +0300
Date: Mon, 15 Sep 2025 09:46:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: ad7124: add filter support
Message-ID: <aMe2N7B8XwUPXsEG@smile.fi.intel.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-5-b09f492416c7@baylibre.com>
 <CAHp75Vf69X4PmGx2c_9KvQwu1opLDyfL0+TyjwX2wTG9bgtMZw@mail.gmail.com>
 <87245221-c3d0-4026-980d-36562f0b4669@baylibre.com>
 <20250913144200.17337dd8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250913144200.17337dd8@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 13, 2025 at 02:42:00PM +0100, Jonathan Cameron wrote:
> On Fri, 12 Sep 2025 09:27:47 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> > On 9/11/25 11:49 PM, Andy Shevchenko wrote:
> > > On Fri, Sep 12, 2025 at 12:43 AM David Lechner <dlechner@baylibre.com> wrote:  

...

> > >> -       factor = 32 * 4; /* N = 4 for default sinc4 filter. */
> > >> -       odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor +
> > >> -                                              odr_micro * factor / MICRO);
> > >> -       odr_sel_bits = clamp(odr_sel_bits, 1, 2047);
> > >> +       divisor = cfg->requested_odr * factor +
> > >> +                 cfg->requested_odr_micro * factor / MICRO;
> > >> +       odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 2047);  
> > > 
> > > I have a déjà vu feeling here. Is this similar code to elsewhere?  Can
> > > it be factored out to a helper?
> > 
> > It is changing the same code from a previous commit, not duplicating
> > it. I guess I could have introduced the divisor variable in the
> > earlier commit and saved some churn.
> For this and the previous patch, to me it feels like we are letting
> aiming for perfect patch break up be the enemy of a good result.
> So I've applied them both but as I don't know if Andy will agree
> not his RB.

Even if I not agree, this is not a big deal. We can amend it in the future if
even needed. So, thanks!

-- 
With Best Regards,
Andy Shevchenko



