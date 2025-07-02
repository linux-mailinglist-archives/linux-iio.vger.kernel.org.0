Return-Path: <linux-iio+bounces-21249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30CAF5C8D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BA91889288
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1727A12F;
	Wed,  2 Jul 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVakEbLi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2EE1C3F02;
	Wed,  2 Jul 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469452; cv=none; b=LAc3810Zlu+avW5A4Dpp8KRSUTT+jhWO/j5JS9mLz2epFRhniWeG27JDcfUdXt1Tbd2z6VUIvC7m42XxaMBr7Gd9Qvlc6tuKzNEgYDHdgmt99mTYE43O3wvg3h0rUY5HhXSbg/in9cATwAvFshTbbHnFA5cf6f2i8zzL4I07C58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469452; c=relaxed/simple;
	bh=0J/bQNTWUK3CBlRXBmlUER6bfndlkg4+YTtCvX1E1t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZPzk/cvSYt0YpzgJXLoRfDDp6ijUFXBbSpJBKpVSeMP0NiVTyfDvkiiN6J+RO5PbMSWrKeXb/6xYimPG/BPBfdTjnZeHtJNxr2KDQ5DDmRvu+nCiShDCdQiEtZNvU1t5kAr0El7R47Y0mB1nPAY8gQ3HwtPUKlYT+iECwnzvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVakEbLi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751469451; x=1783005451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0J/bQNTWUK3CBlRXBmlUER6bfndlkg4+YTtCvX1E1t4=;
  b=AVakEbLieg6ccSqcjXQKTgaTm2fmg3OEn0oYBj0DVybrdTQj7iQkmRfV
   omoZvllQPKp072AinHzi07bnbVlZkS5qSxcL7mRK4n2HODz58W3vZi96s
   L/Rh5po/eAPUt7YVGCrFs7asMYbQ6wQ7Nw3yiQcVcjKQk005gyhmX8TZH
   UCenPzZ7IuncZWsF5HU0hmvHb2ofiGqsZd4rD1v2LGamo/I7yIPdbdG5a
   nHjTefmjJ2cJXHFisX9yxRhgg1S1yuLSX0gG4y+yJ+Y3GFjK01yfiwlme
   0bxRRwDPkWIbd+8kvFhs7sQo/GHb3pwhRhhizIC2b8B/6ROZBcyLuoVem
   A==;
X-CSE-ConnectionGUID: cME5MhDNRdiWrFrMk1xthw==
X-CSE-MsgGUID: cKHl+qIbQd6YwLKgVGKD0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="71341605"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="71341605"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 08:17:30 -0700
X-CSE-ConnectionGUID: wEnsnc39Tai9vIOaOuvRTw==
X-CSE-MsgGUID: 2P04b6y7SBG7QtOLh6hrhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153511918"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 08:17:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWzDA-0000000Bx6z-1YDq;
	Wed, 02 Jul 2025 18:17:24 +0300
Date: Wed, 2 Jul 2025 18:17:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Robert Budai <robert.budai@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16550: rework clock range test
Message-ID: <aGVNhIwn7CXO_lpP@smile.fi.intel.com>
References: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
 <aGVIBVsFPcVw3lN6@smile.fi.intel.com>
 <aGVJPRmn1-HUBb40@smile.fi.intel.com>
 <3778ad13-3b62-4f68-946d-b861b0df4272@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3778ad13-3b62-4f68-946d-b861b0df4272@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:07:17AM -0500, David Lechner wrote:
> On 7/2/25 9:59 AM, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 05:53:57PM +0300, Andy Shevchenko wrote:
> >> On Wed, Jul 02, 2025 at 09:27:45AM -0500, David Lechner wrote:
> >>> Rework the clock rate range test to test if sync_mode_data != NULL
> >>> instead of testing if the for loop index variable. This makes it easier
> >>> for static analyzers to see that we aren't using an uninitialized
> >>> sync_mode_data [1].
> >>
> >> But at the same time it makes it not to be the usual pattern.,,
> > 
> > Reading the static analyser output I think the first hunk is only what we need,
> > but this is still false positive and it's problem of that static
> > analyser. Have you filed a bug there? (My point is that modifying the code for
> > the advantage of false positives of some static analyser is wrong road to go
> > in my opinion.)
> 
> I agree that we shouldn't fix this _only_ to make the static analyzer
> happy. But I had to think quite a bit harder to see that the existing
> code was correct compared to what I have proposed here.
> 
> But if this is a common pattern that I just haven't learned to identify
> at a glance yet and everybody else can easily see that the existing code
> is correct, then perhaps it isn't worth the change.

To me checking against index variable (when it's integer, obviously) is correct
thing to do and regular pattern. OTOH, if the "index" is a pointer and rather
we call it "iterator", the angle of view is different because in some cases
it may lead to stale or invalid value which might be mistakenly dereferenced or
speculated (see more in the discussion about list entry APIs [entry is a
keyword here] and if list_entry_is_head() is a good approach.)

-- 
With Best Regards,
Andy Shevchenko



