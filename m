Return-Path: <linux-iio+bounces-26628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65041C9BCCA
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA23A7C68
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D91C212B31;
	Tue,  2 Dec 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQgFH+rJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35018BC3D;
	Tue,  2 Dec 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686175; cv=none; b=KO65RYH80iCYQrw4qvWuZ83fy93jSxfqk4cqYNqyK0PJGZEV+1m7RvTbwstq2CafqJVquReo37O2RjDVdL9YwakMbzKh1epsVhXPbG6Dil0AffVlv4zwSEfGzTDA2sM15fDKfM8oY/C64AAevMkwJWiicfO8t47GqFMxe7yK7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686175; c=relaxed/simple;
	bh=4BnrM77bNuOaQO0bcvRVsldjztdB4bUPkh8e3DJqMfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU/7gRJlVdwIlqXthlymPy6vFApAq08r67WshZ+Qqoviqb3rNTbnH/dCpqmoXX6xFqsZl0acOU82JcSaxeOMRHsvT1LFzqTG/FkRdQ8WGBnAf3xuS52ErJc3zip2x6kspFkoE7cuy/T5V/JywnUNqDGQ0zxIu0UdJbZAwcdNYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQgFH+rJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764686173; x=1796222173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4BnrM77bNuOaQO0bcvRVsldjztdB4bUPkh8e3DJqMfQ=;
  b=bQgFH+rJC2xjLgXc8HRtEujNQzk9mKx4Y1i8q+BgJ05rLasHkHL0iMml
   Ug0qDqA0LNQkjPdJpN88IaCZSwime/ycP5OfEk/igoW2KiY8YTYu8M1Ls
   k9qEN+M+NpEHu5wdIG7NK9vHxEKvI1v8tr3ywL27yAFqjM3ervI1DASXY
   GPyoaJ5IsbqbrhGuoDw61tJoyeKyz2zuF/IBEahcjTaPYvH/JM6Vf0Ll4
   nr/+inefL4NKWWv/fjO/X01JdjSvNkCs5GJNHaVNyMWq1U48SfvUFawkA
   dZUiuk3s3Z+zfVmSk9JIEW+SVrYR0UypXUz5JQ346++28N1JamSDSZU2k
   w==;
X-CSE-ConnectionGUID: 5ME30k/TSPa0X37APwl9rQ==
X-CSE-MsgGUID: 5Zehd3kqTUiMPeRycdmg3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66367791"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66367791"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:36:13 -0800
X-CSE-ConnectionGUID: TlwwMuOIQ2u/TM3QUjMisg==
X-CSE-MsgGUID: mmqnkM9eQ/+n8ejbDFjDXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194274734"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:36:10 -0800
Date: Tue, 2 Dec 2025 16:36:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad9467: support write/read offset
Message-ID: <aS75V9Zb3xu5RTU6@smile.fi.intel.com>
References: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com>
 <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
 <CAHp75VdaYR5S7MmVEMBH1e6g-0bQim_d7m48=X2ybpf3hBAfTA@mail.gmail.com>
 <44a38485-ce29-45c8-8892-5000abb8d44e@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44a38485-ce29-45c8-8892-5000abb8d44e@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 02, 2025 at 12:03:21PM +0200, Tomas Melin wrote:
> On 01/12/2025 15:59, Andy Shevchenko wrote:
> > On Mon, Dec 1, 2025 at 2:00 PM Tomas Melin <tomas.melin@vaisala.com> wrote:

...

> >> +#define AD9434_CHAN(_chan, avai_mask, _si, _bits, _sign)               \
> >> +{                                                                      \
> >> +       .type = IIO_VOLTAGE,                                            \
> >> +       .indexed = 1,                                                   \
> >> +       .channel = _chan,                                               \
> >> +       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
> >> +               BIT(IIO_CHAN_INFO_SAMP_FREQ) |                          \
> >> +               BIT(IIO_CHAN_INFO_OFFSET),                              \
> >> +       .info_mask_shared_by_type_available = avai_mask,                \
> > 
> > Okay, this macro uses parameterized avai_mask (which should be spelled
> > correctly and probably in parentheses, but it's not the point) and
> > it's being called only once. Why can't we just embed it for now?
> 
> Sure, I'm ok with embedding if that is preferred.

I meant to embed the one of the _chan/_si parameter, not the entire macro.
And with comment about index vs. channel, it seems one of them is not needed
at all.

> >> +       .scan_index = _si,                                              \
> >> +       .scan_type = {                                                  \
> >> +               .sign = _sign,                                          \
> >> +               .realbits = _bits,                                      \
> >> +               .storagebits = 16,                                      \
> >> +       },                                                              \
> >> +}
> > 
> > Also, looking at the existing macro below, I think you should have a
> > common, parameterised macro and then 3 different on top of it for this
> > case, and for the existing two.
> > 
> > Does it make sense?
> Keeping this and embedding the ad9434 declaration.

Answered to v2. I think the macro approach is better due to consistency.

> >>  #define AD9467_CHAN(_chan, avai_mask, _si, _bits, _sign)               \

...

> >>  static const struct iio_chan_spec ad9434_channels[] = {
> >> -       AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> >> +       AD9434_CHAN(0, BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> >> +                   0, 12, 's'),
> >>  };
> > 
> > Also the first and third parameters are identical in all cases, can we
> > for now just make them using a single parameter?

...

> >> +       if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
> >> +               return -EINVAL;
> > 
> > Wondering if at some point we can switch to in_range(). And we perhaps
> > need a new generic macro to supply start/end instead of start/size.

> Atleast drop-in usage of in_range() does not seems feasible?

I know, that's why it starts with "wondering" and continues with "perhaps".

-- 
With Best Regards,
Andy Shevchenko



