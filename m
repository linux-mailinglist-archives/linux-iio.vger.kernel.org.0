Return-Path: <linux-iio+bounces-21716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62DB071A0
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C27B1AA42C9
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FFB2F0E2D;
	Wed, 16 Jul 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGNlB110"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203C27144B;
	Wed, 16 Jul 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658132; cv=none; b=HTCaCSbvw5pzBG3CzKDJ8yr7gjdH4L7YMBRQFx+GOppUnJQyMvAcp3vP9b4UbyCyeJk8HZS3EKKH6Fpxf9EIhZub3MF3bVPm+DulphP3LOUN9d0KPBezCDBGdavf8WsWSxs4mpdChxSws9vMlTUd3DpnUaM+HEwGHjLknPzoPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658132; c=relaxed/simple;
	bh=cxDevEX8yGyjG9n9wQuv6d50HxIqhk0SioR/6U0Gbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuC6QPPh7DB0Gdjq+6O5/r65hfh1h1ZG4jzN4fwAEOAIhvVhbaPbF5prtu7wvX5GQzk7oeLToOLG611cW/VWeKqOndNVmzsJC0RUj1z0fQIrqpfOJ8pf3ZBeGVVBPGRuyzRyKDDjCgvrdx8txphLswsgRU8+MEDmeZV5gfPyqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGNlB110; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752658131; x=1784194131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cxDevEX8yGyjG9n9wQuv6d50HxIqhk0SioR/6U0Gbxk=;
  b=RGNlB110zfw4K4UkPJLIIbbvwLOdnn39xdiS4FuPzd0BNda0s9H7gWpe
   OxCTpD7t2qKMBFeT1NVE8hGakZsrQozovLCRFeWeEhX7hSqXGatVKrzuA
   WxkhN1CHECjah8Um26TVXlXpBiYmRpCiMej/0Eiid7EQ435V34Py3laIb
   vE7G3clBPorOefhJXrOyVKUUBP83iLU3BbGFLbRCTKFAwaUQm+kmxmz96
   +qQxjPv3yrARc86sK+lKJMoZnbF90/ufrrvA1oR/AnG0yvb+Gb0GNka2M
   OghNhFGs7KPPP68wAk36rWzDdME5xXUFOeOj0JBWYFNN+DIhZx7J4gFDF
   g==;
X-CSE-ConnectionGUID: EX/tXt8QRdSeW6HsOiSAJA==
X-CSE-MsgGUID: z2nQNY/bTXaATkXxcWRxeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66343773"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="66343773"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:28:50 -0700
X-CSE-ConnectionGUID: VYHuNRWBQxuLDL/zSmYEJw==
X-CSE-MsgGUID: XTgQe7JOQZyEGL/mhn8+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161477874"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:28:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubyRQ-0000000Ftjd-3b9v;
	Wed, 16 Jul 2025 12:28:44 +0300
Date: Wed, 16 Jul 2025 12:28:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
Message-ID: <aHdwzFk-688ASRx2@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-3-sean.anderson@linux.dev>
 <aHYOuzdQ_jSKA898@smile.fi.intel.com>
 <8bb7d291-f94a-4e96-b3ec-93fbe06c8407@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb7d291-f94a-4e96-b3ec-93fbe06c8407@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 11:42:05AM -0400, Sean Anderson wrote:
> On 7/15/25 04:18, Andy Shevchenko wrote:
> > On Mon, Jul 14, 2025 at 09:20:18PM -0400, Sean Anderson wrote:

...

> >> +EXPORT_SYMBOL_GPL(iio_event_mode);
> > 
> > Can we move this to namespace? Otherwise it will be never ending story...
> > Ditto for other new APIs.
> 
> Never ending story of what?

Of converting IIO core to use exported namespaces.

...

> >> +			if (scale64 <= INT_MAX && scale64 >= INT_MIN)
> >> +				raw64 = processed / (int)scale64;
> > 
> > Do you need the casting? (I mean if the compiler is dumb enough to not see this)
> 
> AIUI 64-bit division is not available on 32-bit platforms. The cast
> ensures we get 32-bit division.

I put specifically a remark in the parentheses. So, the Q is if the compiler
doesn't recognize that. Can you confirm that 32-bit compilation without cast
is broken?

...

> >> +	*raw = clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);
> > 
> > You already have similar approach here...
> 
> Well, I can spell it 0x7fffffffLL if you'd like...

Nope, I like to have named constants instead of magics, but actually are those
castings needed for the clamp()?

-- 
With Best Regards,
Andy Shevchenko



