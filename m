Return-Path: <linux-iio+bounces-26354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58346C78372
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C6ECA364C9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5B2F6591;
	Fri, 21 Nov 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiHEC7FI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262E280327;
	Fri, 21 Nov 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717657; cv=none; b=DZNabKXu+9nX1yAinoFrq+vi/l4rsesU7ZwvMHSniyZYoigWdfCBNKIby4B78ex+1giSq3K6T09FS/gP0pxZfcioisb2RA8yv1tJFKFNsv+HR8JuG48TeGnW2oas7ZsD5FQ9x0QtCAXnUW6b0esOWmSRcEYuLIeh11W2qTzExhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717657; c=relaxed/simple;
	bh=gP6Vm1KPsLLQ1M09e+wYJzvNIcYVOVPfZ+2kURcQevM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNqRqTUeerbXqxJw9PD9SmDlbks3nhtwNrJ0ek/lXHUrV3m6eiN4cOHsw05kII+wBPSWnqAZd+3qlD9h4BWfCVjo5YGjUzxwHkjszx23TPNyGY5vvEdxCoYHgXsT+xGC2bpYDMOsSIIOXt9WJF5BOW7NAjqmnzcEDO8Ya7pu+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiHEC7FI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763717657; x=1795253657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gP6Vm1KPsLLQ1M09e+wYJzvNIcYVOVPfZ+2kURcQevM=;
  b=FiHEC7FIApS5rYZcrXYb0z7Zi6i4G5iXxuuPheOXL8xvQhznbWNWW3Ue
   BccgMztu+0XBV4kjI3aGMmrWAJN2eZQaWtjg421crXG/QuHQUDSWtpox1
   VRJmhLhFe4n9NcqnyQst+EY3ET6y5xaQxD9eDy5izdeB2mo9FHGACutwE
   hFwCb1tr9E6HrtLYq0+levqiA97A9lOgKrCELorQBnunBW6Xat+XSscTS
   Bc6HUzATf6QO6rXv++KuZe4CcUVQJ7pnumdtii8efhNJToEM05JePvpjO
   6oX/70a8RTLOpH1Dj7DXMebYh5NikvROiysIc9HqWYHKoiIh5UzEIgAEh
   Q==;
X-CSE-ConnectionGUID: +IDzRmOZSo2BQSIDLbDcGg==
X-CSE-MsgGUID: 3UcGw4EYR2CAEwYJn/z/dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76131111"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="76131111"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 01:34:16 -0800
X-CSE-ConnectionGUID: rqC01Sh6RIKn9p4BRfARKA==
X-CSE-MsgGUID: wvuKwWl7SmutkXPxbUURlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="191519533"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 01:34:14 -0800
Date: Fri, 21 Nov 2025 11:34:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iio: imu: st_lsm6dsx: remove event_threshold
 field from hw struct
Message-ID: <aSAyE0xQ15k4Qqwk@smile.fi.intel.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-6-flavra@baylibre.com>
 <aSAfT3OZRnaTtjXn@lore-desk>
 <c665ae5fed9fb42e0312f000a2d3e784360a8d01.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c665ae5fed9fb42e0312f000a2d3e784360a8d01.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 21, 2025 at 09:43:28AM +0100, Francesco Lavra wrote:
> On Fri, 2025-11-21 at 09:14 +0100, Lorenzo Bianconi wrote:
> > > This field is used to store the wakeup event detection threshold value.
> > > When adding support for more event types, some of which may have
> > > different
> > > threshold values for different axes, storing all threshold values for
> > > all
> > > event sources would be cumbersome. Thus, remove this field altogether,
> > > and
> > > read the currently configured value from the sensor when requested by
> > > userspace.
> > > 
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>

> > Just a nit inline, fixing it:

...

> > > +#define st_lsm6dsx_field_get(mask, reg)        ((reg & mask) >>
> > > __ffs(mask))
> > 
> > To be aligned with the rest of the code, I guess we could use capital
> > letters
> > here:
> > 
> >         #define ST_LSM6DSX_FIELD_GET(mask, reg)▸     ((reg & mask) >>
> > __ffs(mask))
> 
> That's what I proposed initially, but Andy suggested [1] using small
> letters instead.
> 
> https://lore.kernel.org/linux-iio/aQh4m25uVBV8A09F@smile.fi.intel.com/

Yes, this should be temporary as there is a pending series to make field_get()
to appear in the common header, so this one will be removed, we may even do
that after v6.19-rc1 as a (semi-)fix if Jonathan agrees on that.

-- 
With Best Regards,
Andy Shevchenko



