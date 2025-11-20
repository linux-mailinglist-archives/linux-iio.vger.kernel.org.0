Return-Path: <linux-iio+bounces-26342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92166C747AE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 15:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51BD4E9D9D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C13469FF;
	Thu, 20 Nov 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGRD3gbf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEE32FA16;
	Thu, 20 Nov 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647160; cv=none; b=oZ9rfmR1tYp/BvTytEDRozk4LrH2gayPl+pY62NDEs+LfPcCqbn0RvAtkRFRU31XOf8W5hRwTILZ0bj3jha85kWGEoKVr0zjhd+DnsWY8QUB737y98oywI/nedMv/sFgbFy1AnHNkVjUUwYTBmpahiIjLkaB9U2Z5F0Ts1bFiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647160; c=relaxed/simple;
	bh=mUjxP+3EY3gKhRrikUfyU27+Y+81EItJZhlxMqp5Zks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twZ6YrGvV5lkjS4DB8yKOnjUzkHWpKXZ03/ka40Vc32LGrMY2Cet8sHIQxbB9AxzioP2C+huPOmAnzwmpViI5OwTaSfCWkLoD+EAMYkoF2sVru+w+rmGxZfOrYR8hRmKdxWj9d8tCNmMLVsr08lqinf0FCBrPJo/9xbn9ielCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGRD3gbf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763647159; x=1795183159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mUjxP+3EY3gKhRrikUfyU27+Y+81EItJZhlxMqp5Zks=;
  b=aGRD3gbf2E9a6aKjc01dOl/JfhpwI8ByALdZPy6c90PQ+VvwYzVSB1SQ
   ccf0sT/XRZ88KDUBFXFucNyCH4TYeNYaHvL/FJShLanP7w1sIR39J8d/b
   C/Q9bqS+sH2XGW53AzyDEcq9IVeLTGNEEEap4efXPdRjOE5/fzjEBBlka
   rCHah2V+u/qCiwRLhjK76EOwIha0TzIfqGzn6DxWM1AbFNNMtaQXSDlYh
   ulhM+6vnT4UZJuW7gCvj9R6roLXXd5s9RhSA5KQqdewvV7+yZnGFLSpEt
   LVP/NApqLyOP5l0nbCQfWwYk2HI04AFo9RNODrxuGCqsnyTZuInd3Bdzi
   w==;
X-CSE-ConnectionGUID: tm9aTHwFROi6zat7TtgNFQ==
X-CSE-MsgGUID: VrxgMt9/Q/iTRDqdtp2P3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="83102227"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="83102227"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 05:59:18 -0800
X-CSE-ConnectionGUID: EUhXOTllT0mGd/U7eK7Iww==
X-CSE-MsgGUID: yqBDwbveSXqUmXOzcVj+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191184667"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 05:59:16 -0800
Date: Thu, 20 Nov 2025 15:59:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on a
 per axis basis
Message-ID: <aR8esn94zI140351@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-9-flavra@baylibre.com>
 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
 <aQNueWesrf_vXO06@smile.fi.intel.com>
 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
 <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
 <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
 <aR7Z19wgPksymwkw@black.igk.intel.com>
 <50107aecc446ba42e312b81e18a6ffe871fa3291.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50107aecc446ba42e312b81e18a6ffe871fa3291.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 12:43:09PM +0100, Francesco Lavra wrote:
> On Thu, 2025-11-20 at 10:05 +0100, Andy Shevchenko wrote:
> > On Tue, Nov 18, 2025 at 12:01:57PM +0100, Francesco Lavra wrote:
> > > On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote:
> > > > On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra wrote:
> > > > > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra wrote:
> > > > > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > > > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra
> > > > > > > > wrote:

...

> > > > > > > > > +       old_enable = hw->enable_event[event];
> > > > > > > > > +       new_enable = state ? (old_enable | BIT(axis)) :
> > > > > > > > > (old_enable
> > > > > > > > > &
> > > > > > > > > ~BIT(axis));
> > > > > > > > > +       if (!!old_enable == !!new_enable)
> > > > > > > > 
> > > > > > > > This is an interesting check. So, old_enable and new_enable
> > > > > > > > are
> > > > > > > > _not_
> > > > > > > > booleans, right?
> > > > > > > > So, this means the check test if _any_ of the bit was set and
> > > > > > > > kept
> > > > > > > > set or
> > > > > > > > none were set
> > > > > > > > and non is going to be set. Correct? I think a short comment
> > > > > > > > would be
> > > > > > > > good to have.
> > > > > > > 
> > > > > > > old_enable and new_enable are bit masks, but we are only
> > > > > > > interested
> > > > > > > in
> > > > > > > whether any bit is set, to catch the cases where the bit mask
> > > > > > > goes
> > > > > > > from
> > > > > > > zero to non-zero and vice versa. Will add a comment.
> > > > > > 
> > > > > > If it's a true bitmask (assuming unsigned long type) then all
> > > > > > this
> > > > > > can be
> > > > > > done
> > > > > > via bitmap API calls. Otherwise you can also compare a Hamming
> > > > > > weights of
> > > > > > them
> > > > > > (probably that gives even the same size of the object file, but
> > > > > > !!
> > > > > > instructions
> > > > > >  will be changed to hweight() calls (still a single assembly
> > > > > > instr on
> > > > > > modern
> > > > > >  architectures).
> > > > > 
> > > > > These are u8 variables, so we can't use the bitmap API.
> > > > 
> > > > OK. But hweight8() can still be used.
> > > > 
> > > > > And I don't
> > > > > understand the reason for using hweight(), given that the !!
> > > > > operators
> > > > > would still be needed.
> > > > 
> > > > No, you won't need !! with that.
> > > 
> > > I still don't understand. Are you proposing to replace `if
> > > (!!old_enable ==
> > > !!new_enable)` with `if (hweight8(old_enable) ==
> > > hweight8(new_enable))`?
> > > That won't work, because we only need to check whether the Hamming
> > > weight
> > > goes from zero to non-zero and vice versa.
> > 
> >        old_enable = hw->enable_event[event];
> >        new_enable = state ? (old_enable | BIT(axis)) :
> >                             (old_enable & ~BIT(axis));
> >        if (!!old_enable == !!new_enable)
> >                return 0;
> > 
> > If I am not mistaken this will do exactly the same in a simpler way.
> > 
> >         old_enable = hw->enable_event[event];
> >         if (state)
> >                 new_enable = old_enable | BIT(axis);
> >         else
> >                 new_enable = old_enable & ~BIT(axis);
> >         if ((new_enable ^ old_enable) != BIT(axis))
> >                 return 0;
> 
> This doesn't look right to me, if new_enable differs from old_enable by
> just one bit (which it does), then the XOR result will always have this bit
> (and no others) set, so (new_enable ^ old_enable) will always equal
> BIT(axis).
> We are not checking if the bit was already set or clear, when this code
> runs we already know that the bit is changing, what we are checking is
> whether all bits are zero before or after this change.

The check I proposed is to have a look for the cases when old_enable was 0 and
the BIT(axis) is set and when the BIT(axis) was _the last_ bit in the mask that
got reset. If it's not the case, the code will return 0. I think my check is
correct.

Should I write a test case?

-- 
With Best Regards,
Andy Shevchenko



