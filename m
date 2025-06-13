Return-Path: <linux-iio+bounces-20602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8EAD8FD4
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 16:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAEE17DD24
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004119CD01;
	Fri, 13 Jun 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yew09Y+L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F203192B84;
	Fri, 13 Jun 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825753; cv=none; b=r3IjctX5mn5IEwW7kjeu1fvSsVsULrUHUKfY14LMEhSDr5Tf4/ZZFf34Mg95uqt0mRukrZrl/fKFSU2mxRZvNJmxezJA7EH7dJXpD5rxG1IUPP1Tk0v/DIzCqwhdmddvRDI3jpcSOgQXgoW6kc6odBemcXKmUgZ/vbqJ7oAAkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825753; c=relaxed/simple;
	bh=/EhcpIn8oZkspRCHdGD8A6ppdJP/935NyccMYNOS7y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOHd/w+7jABXNBTcyxKB3u3nLthaUYgn6nXAKnMwvydqfsCOcK6mW+huYzoSH0fItDlqW/xRyEgTDzVvpC0bUfd1xcr9VuMPdTE0cKBUK/ZkaHe31IzEH0tkIi4sm3sH02JrnokMmeQLYGg/0tWxSobfGWBH0plHonyE/GpXQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yew09Y+L; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749825752; x=1781361752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/EhcpIn8oZkspRCHdGD8A6ppdJP/935NyccMYNOS7y0=;
  b=Yew09Y+LL3upH25QsD7nTbxl1pfi3bzPZ1qOBuEMeZRaNpudISTkY2de
   XYTRpD/2fBWp4BqieZN1u8eyCGgUYnitBnoLLUeaR0uyG6nDmlkh/kdTm
   79n6yOWGcxVqgJurkr3/CXi1zaL4hCB4Kn/uoJgJ152SxEn+3mdXs+dhC
   aZqq9JRxecVZGQT6JDPhdhTX7DUiqBDVSBERRV+FxYtCjojaN7SfcgoB8
   WiLOpyoGpxd12/2LclXw+HNUXOrE1au9aQd4F6JTVKyD5LmC0YYIeYIto
   ItM0ipl/AURYkBN29Cg83tkXd87LvgB1dVkQuVTRghLztNxgT10eA9K1r
   g==;
X-CSE-ConnectionGUID: k/2k6r/eTHWf/2oIofmgig==
X-CSE-MsgGUID: b8H505LrTAKTWSmrX3smDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="62695415"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="62695415"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:41:53 -0700
X-CSE-ConnectionGUID: SbKS1l3EShyEXFd005Xpng==
X-CSE-MsgGUID: 48PhrhZGTlqAX5HpXiOnmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148736678"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:41:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ5bI-00000006GwF-0764;
	Fri, 13 Jun 2025 17:41:48 +0300
Date: Fri, 13 Jun 2025 17:41:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <aEw4q3p12q1iI7vC@smile.fi.intel.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com>
 <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEwfUMgLTnQxOh_k@smile.fi.intel.com>
 <aEwfgP3tiio52Rj-@smile.fi.intel.com>
 <FR3P281MB1757AEF932A3CE2AB9637046CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FR3P281MB1757AEF932A3CE2AB9637046CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 01:43:58PM +0000, Jean-Baptiste Maneyrol wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Friday, June 13, 2025 14:54
> >On Fri, Jun 13, 2025 at 03:53:36PM +0300, Andy Shevchenko wrote:
> >> On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyrol wrote:
> >> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> > >Sent: Friday, June 13, 2025 10:29
> >> > >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

...

> >> > >Overall, looking to this patch again, I think it would be better to prepend it
> >> > >by replacing *int*_t types by the respective uXX ones. Because in this patch
> >> > >we add dozens of new ones which increases an unneeded churn in the future.
> >> > >
> >> > In my opinion, to respect the rule don't mix *int*_t and uXX types, it is better
> >> > to keep *int*_t types. If it need to be changed, we can change afterward the
> >> > whole driver types with a replace tool and send it in a separate patch.
> >> 
> >> It will be never ending story, sorry. We need someone to solve this tech debt.
> >> And since this patch adds more than 3 new users of it, I think it's a candidate
> >> to embrace the burden.
> >
> >For your convenience I can mock-up a change...
> 
> It looks like there's something I don't understand in the kernel Documentation about
> types then.
> Quoting Documentation/process/coding-style.rst, section 5.d:
> ---
> New types which are identical to standard C99 types, in certain exceptional circumstances.
> 
> Although it would only take a short amount of time for the eyes and brain to become accustomed
> to the standard types like uint32_t, some people object to their use anyway.
> 
> Therefore, the Linux-specific u8/u16/u32/u64 types and their signed equivalents which are
> identical to standard types are permitted -- although they are not mandatory in new code
> of your own.
> 
> When editing existing code which already uses one or the other set of types, you should
> conform to the existing choices in that code.
> ---
> 
> My understanding is that uXX are not mandatory for new code. You can use types like *int*_t.
> But you need to conform afterward to the existing choice. That's why this driver was
> done initially with *int*_t types, and that patches are conforming to this choice.

This part of the documentation has a lot of room for different interpretations.
One [1] may consider this as uXX superior, another, like you, that it's okay
to use.  In any case Greg KH prefers uXX over uintXX_t. And he is also in
the chain of maintainers here. Feel free to amend the Documentation. But
be sure all stakeholders will see your proposal (like Greg KH and other
key maintainers).

> By looking at all Linux drivers, there are plenty of them using *int*_t, even
> inside iio:

$ git grep -l 'u\?int[0-9][0-9]\?_t' -- drivers/iio/ | wc -l
59

$ git ls-files drivers/iio*.c | wc -l
640

Less than 10%.

> Then, why it is mandatory to change this driver to use uXX instead?

TO be consistent. With the above wording in the documentation I may argue that
entire subsystem should be consistent and at least in IIO we have tons of patch
series that are against the whole subsystem to do one style change or another
(look at the recent memset() vs. {} for initialisation).

[1] https://lore.kernel.org/all/20250409180953.398686-1-matchstick@neverthere.org/

-- 
With Best Regards,
Andy Shevchenko



