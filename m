Return-Path: <linux-iio+bounces-21717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82EB07224
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 11:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109111AA0267
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1DA2F0E2D;
	Wed, 16 Jul 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNPHbP8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938D157493;
	Wed, 16 Jul 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659244; cv=none; b=kFclekAveif6utLFdEMFimVlIkqBAr04E+DSeAh2Fcb6hIYDft0r5HlHziUlZ80wEWpeJLyBIN6vTRXJuSafP2xt1LlZJrs2T7bK26j96r+46c2R160FTG4de4xzN1M05G2EZnm/rDtJiSoKHVrd5ugOxZaKbor2IZvLqx9yJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659244; c=relaxed/simple;
	bh=zCyLPNfnMzZrZVOjJyA5bovh+fRwSs7MY4x27YXj+js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2qFcFZBPDppIZZduARbOmTUwbOKcag7MD1Kii56/g5ysxZyBIKe+srPTDA7LFybhBIbcYX+kaUADS7rNbH6ezxyvtUux152OPYB6DyETnuWHRGr0urjbCXZURsl687y6tMT3s/qPm/6XooBODT/h/oioKRmPyNrMkNlwjoQdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNPHbP8V; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752659243; x=1784195243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCyLPNfnMzZrZVOjJyA5bovh+fRwSs7MY4x27YXj+js=;
  b=DNPHbP8VqSEviLTT1Dx6SYwj6A7WTjQQKjuQrvLCzigXlnYJnezjrSb7
   Tk9vhzgykKs5h3iOOoS00ETqPCF4cNEkUoSvsvX+rtvzEFgmLKLlC3UnR
   g0uVxY2Yp6ESmU50SuYJLryWON8ViqRZ/CXKTJ3pdDLe3OFayZdcx9tgH
   Vxv73l68KclR8yWGVD1X+yqfIPTU1a40FHo/au0LzZgs5fULOYYpnetPK
   sD8YHDM8C49ZpRqxLus9H0K6tnMjt0QkvQ+EApUqZghf7rCa2IyFx4JmL
   SSTYPEaE7YJR3GMIHU8QDcQggyCDA4NUI0lkNQYdIsSg1QXhPhfu0NNS6
   A==;
X-CSE-ConnectionGUID: KuV03549Sfq9aDyuC1XHBw==
X-CSE-MsgGUID: 5gNnjs4ZQkiN5171wV/Rtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72470364"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="72470364"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:47:22 -0700
X-CSE-ConnectionGUID: 6eh2VefOQPyhdP7u3EU8sw==
X-CSE-MsgGUID: oGPR/H2rSB2TMTayxbBm5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="181150913"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:47:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubyjM-0000000FtzU-1OxH;
	Wed, 16 Jul 2025 12:47:16 +0300
Date: Wed, 16 Jul 2025 12:47:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
Message-ID: <aHd1IzB1_O9pOFvl@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-4-sean.anderson@linux.dev>
 <aHYPYZgq17ogdEgC@smile.fi.intel.com>
 <80ed9b12-ba0a-4d1a-bd54-122218edc8a1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ed9b12-ba0a-4d1a-bd54-122218edc8a1@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 11:47:07AM -0400, Sean Anderson wrote:
> On 7/15/25 04:20, Andy Shevchenko wrote:
> > On Mon, Jul 14, 2025 at 09:20:19PM -0400, Sean Anderson wrote:

...

> >> +	WARN_ON(atomic_notifier_chain_unregister(&ev_int->notifier, block));
> > 
> > Is bug.h already included?
> 
> I assume so. No build errors.

Explicitly? Otherwise it's against IWYU principle.

-- 
With Best Regards,
Andy Shevchenko



