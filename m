Return-Path: <linux-iio+bounces-27488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A431CF49C8
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353CE31C4914
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67D311C2D;
	Mon,  5 Jan 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYRC4obx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC617736;
	Mon,  5 Jan 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628366; cv=none; b=iV8hNKyVvQ0IeiZhWY9hubsYzm6NsKFoZSUbAlFmEQMPAbdzJwV37hGYkcNKvAXqAgllkJkiebwfX5FypvmqtUJwX2cRip20b2hi59W2QcBIvMrQ4vW+TjrR0qJhvnESU29Gw0UaQqTPgGZZrCTRiSKEnCyRkfiOGb3MwuoSyCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628366; c=relaxed/simple;
	bh=m9e9DIlJ/pYKWW7t8Lu0hofeC3X55rgFKER632Qvmnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY+R+KRRAdxIJuce8bS+Xd8I96T+Vx9ZgkPCFgO256XctpTHh1wsiUanfOtzRNLHfyz/T7p3i771pWAbr2KfyyxQxIqlFaRWwKMCL2IghTkIbKHrXS/rLmTwKBdGW9tV+jU08agDuGbK8jzTiwkpHnXtPnReyLXUc7xeE+L68Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYRC4obx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767628365; x=1799164365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m9e9DIlJ/pYKWW7t8Lu0hofeC3X55rgFKER632Qvmnc=;
  b=iYRC4obxfgumMl3vCctSVzFrWnnfXu2L0udU4EzyThQGQfA3i5i4xJ1k
   WpLiGBC2gGN61qcpAQfCmxsWSwPxWtHlojdNVv6uWj8+64gGP4LEgheLH
   Kk8goRABbdHoCv3gKv6NFrFP7Tuw7U6GMygvIytCGFqPYMCYn7nTH9j5B
   SgxGWUo0AFTlupBARQxlx5qfBp1AYbtH0+oQgXqf2htyDsTBJdYLULFIU
   qfx4wd/cYH3uc5E/XXwxZLCBroYa57ZUv0JWjzTJ8iH/BgH7KrshC9PAg
   r9RiThNwRZlAi0SHmPiw0J0FLzl3cQ0+NZvT2OqPcVTrOsSFtdHYXjmbX
   w==;
X-CSE-ConnectionGUID: 5tM2E/WWS/Seetxte8dGDQ==
X-CSE-MsgGUID: 44tC80SjRP+on3/cq++A9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="68005937"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="68005937"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:52:44 -0800
X-CSE-ConnectionGUID: TrkGWDyMQ+mMXGGUmgQFPQ==
X-CSE-MsgGUID: vbjSLmRoTKK2VrXnxrdy6A==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:52:41 -0800
Date: Mon, 5 Jan 2026 17:52:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
Message-ID: <aVveR7GEPEaO8juK@smile.fi.intel.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
 <20251230203459.28935-5-tomasborquez13@gmail.com>
 <CAHp75VefAPs8C9gJdz-zTkS3cpExg5pwOTMreiUs-ikSgpygOw@mail.gmail.com>
 <hjspdsgz6ey7iaczw3qxn5qwlmpv7pnhxxmrzmfigygc33at2r@3gq2xps7idza>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hjspdsgz6ey7iaczw3qxn5qwlmpv7pnhxxmrzmfigygc33at2r@3gq2xps7idza>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 04, 2026 at 02:25:23AM -0300, Tomas Borquez wrote:
> On Wed, Dec 31, 2025 at 12:46:28AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 30, 2025 at 10:35 PM Tomas Borquez <tomasborquez13@gmail.com> wrote:

...

> > > +static IIO_DEVICE_ATTR(out_altvoltage0_frequency0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> > > +static IIO_DEVICE_ATTR(out_altvoltage0_frequency1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> > 
> > Any particular point in not using _WO() / _RO() variants of the
> > IIO_DEVICE_ATTR_*() macros?
> I was looking into this and saw that the definition for both _WO() and _RO() only takes _name and _addr:
> 
> #define IIO_DEVICE_ATTR_WO(_name, _addr) \
> 	struct iio_dev_attr iio_dev_attr_##_name = IIO_ATTR_WO(_name, _addr)
> 
> So if we use it for frequency0 for example, it assumes the store function
> since we don't pass it:
> 
> static IIO_DEVICE_ATTR_WO(out_altvoltage0_frequency0, AD9832_FREQ0HM);
> 
> // Expands to
> struct iio_dev_attr iio_dev_attr_out_altvoltage0_frequency0 = {
>     .dev_attr = {
>         . attr = {
>           ...
>           .store = out_altvoltage0_frequency0_store,
>         }
>     }
> }
> 
> Meaning we would have to create a store for each one instead of using
> just one write function

Yes, and it will be fine, no? Explicit is better than implicit
(at least in this case).

-- 
With Best Regards,
Andy Shevchenko



