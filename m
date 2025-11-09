Return-Path: <linux-iio+bounces-26106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B553FC4436D
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207FE3A6683
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACF2FF147;
	Sun,  9 Nov 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHEAtoyd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4F30499A;
	Sun,  9 Nov 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708169; cv=none; b=uA5TfXQOxcrIxOC672QwOfPxW3NTGkJf8mHvHEry8XJ2tId4VCcpc+zgA0tnaerGSEBP+U3YSpOUS3m3bXez43Gv0o5yfDLqhRlqolN4mdnYQOr2o3hTwgCyz4uvUYBaIbWWK+wOkI/A337kxXxX1/pDQTFvImOIKYvhSg2BQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708169; c=relaxed/simple;
	bh=ifyQCECAtBcQxgR5E0pL//6P+IXt1bCDRYzHSxJKPtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7xNFgmRPzZ7maCsyVQRkQd9QJ89B2yTz80k1aXuN0SsJFSJKk+UNBDWkDvE01SmLUHHxthQfbIvCJP3ZLpHnRQJZjYaDFoxJ0p7OVCaRcP77tQz+vxVYG8k6GAyKj7Vf8yIAUzbFP9/wqUTGv9WhW39QYVj/0+ivLgJHYAH6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHEAtoyd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762708168; x=1794244168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ifyQCECAtBcQxgR5E0pL//6P+IXt1bCDRYzHSxJKPtk=;
  b=FHEAtoyduAx6F1X+/yWxwweWKEMEi4TEVtbbiQI5pk/9VHvjH4yL8gv7
   rwOAleNQFE0lw9wcq0QU5nKRaAVRzCbC4sLjuazSqKMXrqDB976hjc5CW
   /dy8jYCCo+6LBJ+JvN6tpvvhxRsbNqJt00ezo9xshqD7wqIFBrnqwj94i
   mkJNaWsx3iHC4Nx7ijeTvjz7gmHSHXXNkEJ7wwoSXtTTCOC/shBrsjlXJ
   5Pj9g5GguEEu4CAixS2pKLlDneJAF7wV7e8742l+CexRCLoi78yIwyLUw
   tEg+Z31wajslv2IglddUDKXbAtKmHInasqH0HFXAw1PfEgzusXrMpBVqx
   A==;
X-CSE-ConnectionGUID: xXY5ekOjSdWDac1B/Akvig==
X-CSE-MsgGUID: R9sYzihvQEiufqqTIhVNRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="76228425"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="76228425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 09:09:27 -0800
X-CSE-ConnectionGUID: Fd17s4YwRPaADzaVcPLRjg==
X-CSE-MsgGUID: sw7bb81sQ7+538g9Rlqp5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="188327592"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 09:09:23 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vI8um-000000074ls-1h2F;
	Sun, 09 Nov 2025 19:09:20 +0200
Date: Sun, 9 Nov 2025 19:09:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: Re: [PATCH v2 2/6] units: Add =?utf-8?Q?32?=
 =?utf-8?Q?-_and_64-bit_signed_values_of_=CF=80?=
Message-ID: <aRDKwFkjOSfypJVW@smile.fi.intel.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
 <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
 <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
 <CAHp75VexvdYyjt1GkbfqOotkFpLeb=io6outJ5dpRqBv2qPNng@mail.gmail.com>
 <20251109170032.2763ae5b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109170032.2763ae5b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 09, 2025 at 05:00:32PM +0000, Jonathan Cameron wrote:
> On Sat, 8 Nov 2025 21:02:54 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > пʼятниця, 7 листопада 2025 р. David Lechner <dlechner@baylibre.com> пише:
> > > On 11/7/25 2:03 PM, Andy Shevchenko wrote:  
> > > > There are a few drivers that want to have these values, and
> > > > one more known to come soon. Let's define the values for them.

...

> > > > +/* Value of π * 10⁸ (fits s32 or signed int) */
> > > > +#define PI   314159265  
> > >
> > > It isn't clear to me at all in the other patches that e.g.
> > > DIV_ROUND_UP(PI, 1000) would be π ✕ 10⁴ (rounded to nearest
> > > integer, of course).
> > >
> > > Calling these PI_E8 and PI_E18 or PI_x10_8 and PI_x10_18
> > > would help to clear that up.  
> > 
> > This will be an awful and ugly name(s). I fully disagree on such a
> > proposal. The power is chosen to fit the type with maximum precision, no
> > need to explain this in the name.
> With no indicate of the multiplier we have to check it every time wwe
> use it which isn't ideal either.
> 
> So I agree with David that we have to indicate this somewhere. Maybe hold the
> multiplier in a separate define
> #define PI_MUL
> #define PI_MUL_LL
> 
> Then compute the divisions by (PI_MUL) / KILO or something along those lines?

I see, we have a disagreement here, because I don't like to uglify the pure PI
definition. So, please abandon this series then.

> > > > +/* Value of π * 10¹⁸ (fits s64 or signed long long) */
> > > > +#define PI_LL        3141592653589793238LL

Note, this constant is used a lot in the tests (3+ modules), so if you go with
your version, take this into account.

> > > >  /* Hz based multipliers */
> > > >  #define NANOHZ_PER_HZ                1000000000UL
> > > >  #define MICROHZ_PER_HZ               1000000UL  

-- 
With Best Regards,
Andy Shevchenko



