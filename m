Return-Path: <linux-iio+bounces-26858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B164CAAD5E
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 931403009F88
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC727FD59;
	Sat,  6 Dec 2025 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duqoSZYJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D5450FE;
	Sat,  6 Dec 2025 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053615; cv=none; b=nqTJG8SYX2dunGJdYx8z/fFeCo/VqD+BiDeVOKbDxp66JeOD5DTDbT8K1VnMs1GqwSa3y30cEQJ8XkvVOsEy93G8JNZxG+FJh7fGskE70UxEC43ulSGWvrYTrk4uhopus5Qh7ozPM5GdXielsVxu2eFn3s4AO7Qc0JH9Kf4cZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053615; c=relaxed/simple;
	bh=cHUivBrHGSQ0U/gowXuesc8vHqicL8rnj6fLEnoVj7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEFk0UBV0n+B685zZNa3un4wsGck4+PbjOeOIFMt9LpsolSX4eVkoEji1jVMokKR0xZq0oaEwJiPzzpCrEdgmC07z4sF9cuaUPT3+9IzQ0HxklCT6sEJWlTlufbjpV6xUGcGHV8Re5G47rkPCsWKOeQM1gEMGrRUn0mDG4QoAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duqoSZYJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765053613; x=1796589613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cHUivBrHGSQ0U/gowXuesc8vHqicL8rnj6fLEnoVj7I=;
  b=duqoSZYJsJmJkGSL2AsPb8yNmUyP4NmRDPNoljzZHnH2ys00aEiYR9ar
   cCqctqPrq5Wzj6Y6DpogdCnpOAMUi1Z9vDTwR+SOnmHhiVv5B8RvQQx35
   hSaWIS5I6xvkUMsLSvMkRK6oKJS7GP6E8l/8yng9gMmXKPRaqqMDhKErA
   TAYt8JibtFYwZY2h+XGno3tIZyTT+otoy0MNVtxf32GGnmkXkqjbXwhMO
   KNhfpkMpplJWQAB31tSASHLkNQji6hWQDnum1OeAcWJs5JmzRd/hYR81T
   H00s0SElfq8JYgoVb+XCKxBUXAKUtuPv2Yjq1JeGo3lId3rHEKpz6u8ny
   g==;
X-CSE-ConnectionGUID: peGjXipORxuB6ZzSz/oihA==
X-CSE-MsgGUID: mMCX75cHRoCaqCpVHehIiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="70900251"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="70900251"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 12:40:12 -0800
X-CSE-ConnectionGUID: izu28iuxS/65OWsi21HgZw==
X-CSE-MsgGUID: JmmjvYfxSYeiQI4Kr0Ab+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="200716430"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 12:40:08 -0800
Date: Sat, 6 Dec 2025 22:40:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Benson Leung <bleung@chromium.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Message-ID: <aTSUpUb5MLX9s0Xz@smile.fi.intel.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
 <3b80f8f3-c435-49f8-8c55-42568215bf0b@baylibre.com>
 <bf1c82f7-da25-47b6-846d-9f8427ee5790@baylibre.com>
 <DEPLQT84HBAO.2GAY5BHP05HNL@gmail.com>
 <CAHp75VfpG4PAG6rC5aFYAPLgnOZZzfJcGP6bMzKPMkMjpuymoQ@mail.gmail.com>
 <20251206184332.426cc30f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251206184332.426cc30f@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 06, 2025 at 06:43:32PM +0000, Jonathan Cameron wrote:
> On Thu, 4 Dec 2025 19:36:28 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Dec 4, 2025 at 7:18 PM Kurt Borja <kuurtb@gmail.com> wrote:
> > > On Wed Dec 3, 2025 at 5:34 PM -05, David Lechner wrote:  
> > > > On 12/3/25 3:50 PM, David Lechner wrote:  
> > > >> On 12/3/25 1:18 PM, Kurt Borja wrote:  

...

> > > If we rename iio_device_claim_direct() (which is huge), maybe we can
> > > pick shorter names and more descriptive names while at it? I was
> > > thinking something like:
> > >
> > >         iio_mode_lock()
> > >         iio_mode_lock_direct()
> > >         iio_mode_lock_buffer()
> > >         iio_mode_unlock()  
> > 
> > The device context is important, so at least iio_dev_mode_lock() (and so on).
> 
> If we are bringing lock into the name do we need to make it explicit which can fail?
> Given you can't use them in the wrong place, maybe not.
> 
> iio_mode_lock_try_direct() or maybe iio_mode_lock_direct_try()?

For locking the pattern is to have *_trylock()

> This was less relevant when they all could fail.  Maybe we don't need to
> bother given how rarely used the unconditional ones are.
> 
> I did like the claiming of mode terminology because it made it a little
> more clear that we were taking a lock that was there for a purpose rather than
> a normal lock.  Also the fact it's a lock is an implementation detail I'd
> rather not back into the ABI.
> 
> Maybe it's worth something inspired by Rafael's patch linked above?
> 
> #define IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) \
> 	ACQUIRE(iio_device_claim_direct, _var)(_dev);
> #define IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) \
> 	ACQUIRE(iio_device_claim_buffer, _var)(_dev);
> 
> For the two more complex ones and fine using guard() for the rare
> any mode variant.
> 
> Then we can have whatever naming we like for the helpers under
> the hood as no one will ever use them directly.
> 
> Hohum. Hardest problems in computer science etc, coherency and naming. :)
> 
> > > Shorter names will also keep lines short when using guards.  

-- 
With Best Regards,
Andy Shevchenko



