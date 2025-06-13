Return-Path: <linux-iio+bounces-20603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55CDAD909C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 17:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3083AED46
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B09149DE8;
	Fri, 13 Jun 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwBVg6jZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1E2E11DC;
	Fri, 13 Jun 2025 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826923; cv=none; b=QuWr/l5Y9zlv+VLFmtZ0gh8kKYoHNuUpGbqdlGeIFWZl5gE6oa6oQRiAj5NervrJU9wvfG9D0sVG9OYJ8vxEBLKRp1wOq22ltqqQ/W5SKtJ6Qo1fPOdrP5xZeogynGiEw+PsEi7XPLR6zo9NqvsGtYFCJUh/NiejfkZSJVATSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826923; c=relaxed/simple;
	bh=c7bXGkiWRxvoldC7dxoyAbyqGDXjDsAGEKdNdgmIhVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmJGMG5Kqxenixqi8KX8UHdUKn2Q2Tu4hgACjmr1p5IFiGa1RxmjRBe/aneyU6NfSAw0uGfk5NclvfuWsca0/15J/UcN6Oq/lZJ3gfLdHHgn7p/i0EUTENNUhs7sVfJJoioBR5pO1MOyei00XDihAQBQ2VizhaMlqx0qHHqjjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwBVg6jZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749826922; x=1781362922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c7bXGkiWRxvoldC7dxoyAbyqGDXjDsAGEKdNdgmIhVk=;
  b=lwBVg6jZV2JvtPY+laBJyVqCfLw+VyuaQ/zMgoeWfXkBg9yK3szjrpN9
   PB2g7GJxLsXyErtgS/xB1oix0jjWufqEI98DoOZuRe2nnIyfSqCV+LUlQ
   aekrBNIdRNdMzhhQwr35xXfrnPjKc6eaRn78w9fyqNK1jxXotdanXzoTw
   M7ZzIikT2rg7HNfKjG3U8GdRNYTZAplm/EzPSHwsg8A6zmfAKB/8r32Wy
   9WBXzXnk4jpzsFP+Z9lV26SIMuxows9CEYpr7PXuknN+6lRilz+6RQEsu
   bvv2sWBuafbZwROnTsCspFmsFQZf8RKAw/Zmt1+106kwuNCvS1XAIopNw
   Q==;
X-CSE-ConnectionGUID: WGGJZzIyST62LATNpfFMfg==
X-CSE-MsgGUID: 5R938C4PS52R6Cd2t/plAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51158570"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51158570"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:02:01 -0700
X-CSE-ConnectionGUID: BczvfYkzTeuADX0PJyqo0w==
X-CSE-MsgGUID: MdyQOD+ZQFKQXMmJNsygHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="171032378"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:01:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ5um-00000006HHz-13Pn;
	Fri, 13 Jun 2025 18:01:56 +0300
Date: Fri, 13 Jun 2025 18:01:55 +0300
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
Message-ID: <aEw9Yxhodwhh8BT6@smile.fi.intel.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com>
 <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEwfUMgLTnQxOh_k@smile.fi.intel.com>
 <aEwfgP3tiio52Rj-@smile.fi.intel.com>
 <FR3P281MB1757AEF932A3CE2AB9637046CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEw4q3p12q1iI7vC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEw4q3p12q1iI7vC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 05:41:47PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 13, 2025 at 01:43:58PM +0000, Jean-Baptiste Maneyrol wrote:
> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >Sent: Friday, June 13, 2025 14:54
> > >On Fri, Jun 13, 2025 at 03:53:36PM +0300, Andy Shevchenko wrote:
> > >> On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyrol wrote:
> > >> > >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >> > >Sent: Friday, June 13, 2025 10:29
> > >> > >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

...

> > >> > >Overall, looking to this patch again, I think it would be better to prepend it
> > >> > >by replacing *int*_t types by the respective uXX ones. Because in this patch
> > >> > >we add dozens of new ones which increases an unneeded churn in the future.
> > >> > >
> > >> > In my opinion, to respect the rule don't mix *int*_t and uXX types, it is better
> > >> > to keep *int*_t types. If it need to be changed, we can change afterward the
> > >> > whole driver types with a replace tool and send it in a separate patch.
> > >> 
> > >> It will be never ending story, sorry. We need someone to solve this tech debt.
> > >> And since this patch adds more than 3 new users of it, I think it's a candidate
> > >> to embrace the burden.
> > >
> > >For your convenience I can mock-up a change...
> > 
> > It looks like there's something I don't understand in the kernel Documentation about
> > types then.
> > Quoting Documentation/process/coding-style.rst, section 5.d:
> > ---
> > New types which are identical to standard C99 types, in certain exceptional circumstances.
> > 
> > Although it would only take a short amount of time for the eyes and brain to become accustomed
> > to the standard types like uint32_t, some people object to their use anyway.
> > 
> > Therefore, the Linux-specific u8/u16/u32/u64 types and their signed equivalents which are
> > identical to standard types are permitted -- although they are not mandatory in new code
> > of your own.
> > 
> > When editing existing code which already uses one or the other set of types, you should
> > conform to the existing choices in that code.
> > ---
> > 
> > My understanding is that uXX are not mandatory for new code. You can use types like *int*_t.
> > But you need to conform afterward to the existing choice. That's why this driver was
> > done initially with *int*_t types, and that patches are conforming to this choice.
> 
> This part of the documentation has a lot of room for different interpretations.
> One [1] may consider this as uXX superior, another, like you, that it's okay
> to use.  In any case Greg KH prefers uXX over uintXX_t. And he is also in
> the chain of maintainers here. Feel free to amend the Documentation. But
> be sure all stakeholders will see your proposal (like Greg KH and other
> key maintainers).
> 
> > By looking at all Linux drivers, there are plenty of them using *int*_t, even
> > inside iio:
> 
> $ git grep -l 'u\?int[0-9][0-9]\?_t' -- drivers/iio/ | wc -l
> 59
> 
> $ git ls-files drivers/iio*.c | wc -l
> 640
> 
> Less than 10%.
> 
> > Then, why it is mandatory to change this driver to use uXX instead?
> 
> TO be consistent. With the above wording in the documentation I may argue that
> entire subsystem should be consistent and at least in IIO we have tons of patch
> series that are against the whole subsystem to do one style change or another
> (look at the recent memset() vs. {} for initialisation).
> 
> [1] https://lore.kernel.org/all/20250409180953.398686-1-matchstick@neverthere.org/

Oh, this [2] is golden!
YUou may found support for your arguments and for mine in that thread, but the
bottom line is: what do maintainers of IIO prefer? (Taking into account that it
goes via Greg KH)


[2]: https://lore.kernel.org/all/20210423230609.13519-1-alx.manpages@gmail.com/

-- 
With Best Regards,
Andy Shevchenko



