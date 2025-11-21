Return-Path: <linux-iio+bounces-26353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0553C7839C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 469E0325DE
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3532E2299;
	Fri, 21 Nov 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEUgBYam"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E021BD035;
	Fri, 21 Nov 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717523; cv=none; b=tPF8bQtT7KkPfXU/fhNFKtNYYNxZCKDBQ7pzWMkNl3o+OqsEYRMq8UM/fr5cEt1cIJUbZ1tw+Fr0mQ6OQegFpcYyULXUF3yknF7BJfoejYmIBpPUCwFRRfIJ1IexUOm8UyhAzHVXl1yhKEuTzchwdGOHVyGh9bwvYP5sa464Too=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717523; c=relaxed/simple;
	bh=yGso0Id5H7R/S/ebhl4C/lccZmc6tphMPYu5sJ+ZeRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsXJ1aoHq1PmtHPLrsuE55VsXYdFilxkfHKBwuzvl0Kh7zqSVCezuQeLsXeaOioQWlikiyc8xg2hJCK/u0uzvz9yGqBQ9p4sNrf6O7125+9gL7jnSJaptdTa8r3dBP5vMoqzZ+6XoYL91Vuoee1orgH9ih62aEl62ygZ2Nk6aFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEUgBYam; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763717522; x=1795253522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yGso0Id5H7R/S/ebhl4C/lccZmc6tphMPYu5sJ+ZeRg=;
  b=IEUgBYam+q5qmirde8x0X+rZm04LdFBFLBgKrmZKmzvkajPzarmWqHDN
   dFEfLay8MZSR9sYypAGrhIZbqSkrfzfY+Au5HbUg1nlTEYexlnd0EwS5M
   KnLi6PaapOMR39fMuOojGaFoCYu5sN1N6+8fCDgCAAOJH9lVfSECPs8ql
   cOsolc9YY9mZ/UfQdWTEKMrNW0CBOjWzXb+dXuemz71EhH/W79yV/1kOG
   kkmMIQKyWoNBIAS+wi26gG8m6U14mVAuUXOh2fjUS+0wmpE/pOZ1zPFcw
   3zdLuNKFygUhaOgayJS5bPW2uIDh0ixUgkPbDCda3u0xsSE2hrAjfR2U0
   g==;
X-CSE-ConnectionGUID: yCsbTAqhQmOMLWtpKnZSrg==
X-CSE-MsgGUID: JME+MzhJRcWT8s5l2tsz0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="83197058"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="83197058"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 01:32:01 -0800
X-CSE-ConnectionGUID: /sFTWevTTlain5yByy+Kcg==
X-CSE-MsgGUID: SuGqt5sDRdmyLuFq/SZlxg==
X-ExtLoop1: 1
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 01:31:59 -0800
Date: Fri, 21 Nov 2025 11:31:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on a
 per axis basis
Message-ID: <aSAxjBCfiw-iCWhI@smile.fi.intel.com>
References: <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
 <aQNueWesrf_vXO06@smile.fi.intel.com>
 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
 <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
 <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
 <aR7Z19wgPksymwkw@black.igk.intel.com>
 <50107aecc446ba42e312b81e18a6ffe871fa3291.camel@baylibre.com>
 <aR8esn94zI140351@smile.fi.intel.com>
 <aR9ej_7o0te-HO8P@smile.fi.intel.com>
 <e448a6fdb420b0c0561ab2255820d2ba62f838a1.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e448a6fdb420b0c0561ab2255820d2ba62f838a1.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 21, 2025 at 10:14:06AM +0100, Francesco Lavra wrote:
> On Thu, 2025-11-20 at 20:31 +0200, Andy Shevchenko wrote:
> > On Thu, Nov 20, 2025 at 03:59:18PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 20, 2025 at 12:43:09PM +0100, Francesco Lavra wrote:
> > > > On Thu, 2025-11-20 at 10:05 +0100, Andy Shevchenko wrote:
> > > > > On Tue, Nov 18, 2025 at 12:01:57PM +0100, Francesco Lavra wrote:
> > > > > > On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote:
> > > > > > > On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra
> > > > > > > wrote:
> > > > > > > > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > > > > > > > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra
> > > > > > > > > wrote:
> > > > > > > > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > > > > > > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco
> > > > > > > > > > > Lavra
> > > > > > > > > > > wrote:

...

> > > > > > > > > > > > +       old_enable = hw->enable_event[event];
> > > > > > > > > > > > +       new_enable = state ? (old_enable | BIT(axis))
> > > > > > > > > > > > :
> > > > > > > > > > > > (old_enable
> > > > > > > > > > > > &
> > > > > > > > > > > > ~BIT(axis));
> > > > > > > > > > > > +       if (!!old_enable == !!new_enable)
> > > > > > > > > > > 
> > > > > > > > > > > This is an interesting check. So, old_enable and
> > > > > > > > > > > new_enable
> > > > > > > > > > > are
> > > > > > > > > > > _not_
> > > > > > > > > > > booleans, right?
> > > > > > > > > > > So, this means the check test if _any_ of the bit was
> > > > > > > > > > > set and
> > > > > > > > > > > kept
> > > > > > > > > > > set or
> > > > > > > > > > > none were set
> > > > > > > > > > > and non is going to be set. Correct? I think a short
> > > > > > > > > > > comment
> > > > > > > > > > > would be
> > > > > > > > > > > good to have.
> > > > > > > > > > 
> > > > > > > > > > old_enable and new_enable are bit masks, but we are only
> > > > > > > > > > interested
> > > > > > > > > > in
> > > > > > > > > > whether any bit is set, to catch the cases where the bit
> > > > > > > > > > mask
> > > > > > > > > > goes
> > > > > > > > > > from
> > > > > > > > > > zero to non-zero and vice versa. Will add a comment.
> > > > > > > > > 
> > > > > > > > > If it's a true bitmask (assuming unsigned long type) then
> > > > > > > > > all
> > > > > > > > > this
> > > > > > > > > can be
> > > > > > > > > done
> > > > > > > > > via bitmap API calls. Otherwise you can also compare a
> > > > > > > > > Hamming
> > > > > > > > > weights of
> > > > > > > > > them
> > > > > > > > > (probably that gives even the same size of the object file,
> > > > > > > > > but
> > > > > > > > > !!
> > > > > > > > > instructions
> > > > > > > > >  will be changed to hweight() calls (still a single
> > > > > > > > > assembly
> > > > > > > > > instr on
> > > > > > > > > modern
> > > > > > > > >  architectures).
> > > > > > > > 
> > > > > > > > These are u8 variables, so we can't use the bitmap API.
> > > > > > > 
> > > > > > > OK. But hweight8() can still be used.
> > > > > > > 
> > > > > > > > And I don't
> > > > > > > > understand the reason for using hweight(), given that the !!
> > > > > > > > operators
> > > > > > > > would still be needed.
> > > > > > > 
> > > > > > > No, you won't need !! with that.
> > > > > > 
> > > > > > I still don't understand. Are you proposing to replace `if
> > > > > > (!!old_enable ==
> > > > > > !!new_enable)` with `if (hweight8(old_enable) ==
> > > > > > hweight8(new_enable))`?
> > > > > > That won't work, because we only need to check whether the
> > > > > > Hamming
> > > > > > weight
> > > > > > goes from zero to non-zero and vice versa.
> > > > > 
> > > > >        old_enable = hw->enable_event[event];
> > > > >        new_enable = state ? (old_enable | BIT(axis)) :
> > > > >                             (old_enable & ~BIT(axis));
> > > > >        if (!!old_enable == !!new_enable)
> > > > >                return 0;
> > > > > 
> > > > > If I am not mistaken this will do exactly the same in a simpler
> > > > > way.
> > > > > 
> > > > >         old_enable = hw->enable_event[event];
> > > > >         if (state)
> > > > >                 new_enable = old_enable | BIT(axis);
> > > > >         else
> > > > >                 new_enable = old_enable & ~BIT(axis);
> > > > >         if ((new_enable ^ old_enable) != BIT(axis))
> > > > >                 return 0;
> > > > 
> > > > This doesn't look right to me, if new_enable differs from old_enable
> > > > by
> > > > just one bit (which it does), then the XOR result will always have
> > > > this bit
> > > > (and no others) set, so (new_enable ^ old_enable) will always equal
> > > > BIT(axis).
> > > > We are not checking if the bit was already set or clear, when this
> > > > code
> > > > runs we already know that the bit is changing, what we are checking
> > > > is
> > > > whether all bits are zero before or after this change.
> > > 
> > > The check I proposed is to have a look for the cases when old_enable
> > > was 0 and
> > > the BIT(axis) is set and when the BIT(axis) was _the last_ bit in the
> > > mask that
> > > got reset. If it's not the case, the code will return 0. I think my
> > > check is
> > > correct.
> > > 
> > > Should I write a test case?
> > 
> > FWIW, https://gist.github.com/andy-shev/afe4c0e009cb3008ac613d8384aaa6eb
> 
> The code in your gist produces:
> 
> Initial event: 0x92, new state: True for bit 0x20

Initial event is 10010010b, we assume that we got in the code when required
state is to 'set' (True) with axis = 5 (means 00100000b when powered).

The [-] are special cases just to show the algo.

> [-] 0x00 | 0x20 --> 1: handle

If initial event is 0 we handle

If _after_ that the bit 5 set (which is NOT the case in _this_ iteration),
we will stop handling.

> [0] 0x92 | 0x20 --> 1: handle

So, it's again step 1. I _assumed_ that your code works and sets the bit. Check
the 0 and bit events (two other groups), they have exactly one handle
(excluding special [-] cases).


> [1] 0x93 | 0x20 --> 1: handle
> [2] 0x93 | 0x20 --> 1: handle
> [3] 0x97 | 0x20 --> 1: handle
> [4] 0x9f | 0x20 --> 1: handle
> [5] 0x9f | 0x20 --> 1: handle
> [6] 0xbf | 0x20 --> 0: return
> [7] 0xff | 0x20 --> 0: return
> [-] 0xff | 0x20 --> 0: return
> 
> But this is not what I need. I need "handle" to be there only when the
> bitmask goes from 0x00 to non-zero (in the above example, only at the first
> [-] iteration); all the other cases should be a "return". Likewise, if
> there is '&' instead of '|', I need "handle" to be there only when the
> bitmask goes from non-zero to 0x00.

Probably we are reading results differently. I put jut several iterations to
show different _inputs_, not outputs. Please, check again.

P.S. I know, bits are very hard...


-- 
With Best Regards,
Andy Shevchenko



