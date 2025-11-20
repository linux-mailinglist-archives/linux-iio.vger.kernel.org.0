Return-Path: <linux-iio+bounces-26338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0FC7302A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 75EB02FAA0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4530C61B;
	Thu, 20 Nov 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E76tF9x+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C930C35D;
	Thu, 20 Nov 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629532; cv=none; b=XGKaU11ebAcIgj1kd9W4TY297QmNpnRhwrq9opPtad3sAFk+4wEb2IsOsN+WyhyDyTUFzHbKkwNs9jFsT+v1nE8nUOTXNFLRJE+eKPdGUDI3e0DmXo1zVtpk+nyiNS+KZZN5SA8u4uUgse5bUjDtWHEsG2ZYl5OOIl8oq3pH7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629532; c=relaxed/simple;
	bh=E25ZtGkJprSRR7U/LkQIJLqplYxisrCQAtRXyuKlm0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8vy2QbcvQ722dFAGzunTCJ4x9p3EN28lkFwvKTdoPRnA7mWcoXeQqEoGKotcIWrEw7WH1rs/BB2HsiBGhtc1N4KK4SKiWztv88MpUE50YMR5qbVrRuU4SwEBAPXhmy2+xd9EUTINvKifs8y/Lq1p3kr3cW4GDZWhjZ8dGewpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E76tF9x+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763629531; x=1795165531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E25ZtGkJprSRR7U/LkQIJLqplYxisrCQAtRXyuKlm0Y=;
  b=E76tF9x+YtoyQOMbSi54Y9OCB6IgUUZw70hCKhUmKrZV3cYruWJbLpU6
   suup3GOJy/1ZOSfKl2n4lfJ0F9kbaJir2KhrHbCZpJbeRgdLJe7AE76/N
   bp6QeqALileshQ0qvviEqh4TRrfUpzIvrvYJXSydxUn5LxM8fJB3VPvdD
   tybob8Etk2W0YHcEasuV+aRLmn61HRMItzO+rUFPrGmjvicOJh+xxIeyo
   TkbeRpPofFLAmoDbBMX1sk8dum+M7obe2NMfANpB0D6TV1V7vm3SjMn7a
   H+sUlYuJTkyQfSMGfkxrRnb0Sg/9K9K21e9JhsNFdpsOdJBsWyC2oZKFZ
   Q==;
X-CSE-ConnectionGUID: aXVdzVmoT3yyCEW/iQo0Zg==
X-CSE-MsgGUID: cWtDxda+SBKoYMmb+9tF7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69560422"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69560422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:05:30 -0800
X-CSE-ConnectionGUID: GPz6FuYRQVGKmzMS17w8VQ==
X-CSE-MsgGUID: 5NfqCymEQmOrSw7zaL6t8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="222242823"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2025 01:05:28 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 409B196; Thu, 20 Nov 2025 10:05:27 +0100 (CET)
Date: Thu, 20 Nov 2025 10:05:27 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on a
 per axis basis
Message-ID: <aR7Z19wgPksymwkw@black.igk.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-9-flavra@baylibre.com>
 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
 <aQNueWesrf_vXO06@smile.fi.intel.com>
 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
 <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
 <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 18, 2025 at 12:01:57PM +0100, Francesco Lavra wrote:
> On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote:
> > On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra wrote:
> > > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra wrote:
> > > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra wrote:

...

> > > > > > > +       old_enable = hw->enable_event[event];
> > > > > > > +       new_enable = state ? (old_enable | BIT(axis)) :
> > > > > > > (old_enable
> > > > > > > &
> > > > > > > ~BIT(axis));
> > > > > > > +       if (!!old_enable == !!new_enable)
> > > > > > 
> > > > > > This is an interesting check. So, old_enable and new_enable are
> > > > > > _not_
> > > > > > booleans, right?
> > > > > > So, this means the check test if _any_ of the bit was set and
> > > > > > kept
> > > > > > set or
> > > > > > none were set
> > > > > > and non is going to be set. Correct? I think a short comment
> > > > > > would be
> > > > > > good to have.
> > > > > 
> > > > > old_enable and new_enable are bit masks, but we are only interested
> > > > > in
> > > > > whether any bit is set, to catch the cases where the bit mask goes
> > > > > from
> > > > > zero to non-zero and vice versa. Will add a comment.
> > > > 
> > > > If it's a true bitmask (assuming unsigned long type) then all this
> > > > can be
> > > > done
> > > > via bitmap API calls. Otherwise you can also compare a Hamming
> > > > weights of
> > > > them
> > > > (probably that gives even the same size of the object file, but !!
> > > > instructions
> > > >  will be changed to hweight() calls (still a single assembly instr on
> > > > modern
> > > >  architectures).
> > > 
> > > These are u8 variables, so we can't use the bitmap API.
> > 
> > OK. But hweight8() can still be used.
> > 
> > > And I don't
> > > understand the reason for using hweight(), given that the !! operators
> > > would still be needed.
> > 
> > No, you won't need !! with that.
> 
> I still don't understand. Are you proposing to replace `if (!!old_enable ==
> !!new_enable)` with `if (hweight8(old_enable) == hweight8(new_enable))`?
> That won't work, because we only need to check whether the Hamming weight
> goes from zero to non-zero and vice versa.

       old_enable = hw->enable_event[event];
       new_enable = state ? (old_enable | BIT(axis)) :
                            (old_enable & ~BIT(axis));
       if (!!old_enable == !!new_enable)
               return 0;

If I am not mistaken this will do exactly the same in a simpler way.

	old_enable = hw->enable_event[event];
	if (state)
		new_enable = old_enable | BIT(axis);
	else
		new_enable = old_enable & ~BIT(axis);
	if ((new_enable ^ old_enable) != BIT(axis))
		return 0;


-- 
With Best Regards,
Andy Shevchenko



