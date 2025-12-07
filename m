Return-Path: <linux-iio+bounces-26919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E976CABA8B
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 23:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6207C3005790
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3042DC35C;
	Sun,  7 Dec 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g85scAoJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FE23A9BE;
	Sun,  7 Dec 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765147849; cv=none; b=rj9UKuwlR7p5ea9vGiNDPp9aCTYBUu2HaEIKiK9qm4IrGPOmH7WYHsHDKeIZ0L4y81HqiKhLUB6XZtfvcXVBnlCc0yhejixNvK1CBA14c+vZiu2fmlDDWtpxWpcYLsX1blVKAiDekjBIZ7KTfK+P+3xXlrOEP8S6sqGu2VRw+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765147849; c=relaxed/simple;
	bh=YiZwseGkAamdCheyyAUEaM8RKE6E4uP2MnNEVskxMRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwGHgaDjvyCAONTbWkWja+ZL3hxyEfMXDyC1k+GlOBOC9/gtDirl17mU4SsrYcSTDDdkHltg7DhB6mU4kY6Z01jJbHHfxz2qRd1hnZ+4IM1hkcaSJkmHMdiYum1J/8bUz5cgq/paZB012hDe9zGwId+P2j+JS/3c4aZSSL6mlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g85scAoJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765147848; x=1796683848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YiZwseGkAamdCheyyAUEaM8RKE6E4uP2MnNEVskxMRw=;
  b=g85scAoJ7iC6JWaOivIlCLEFwSU2MtjZwXNHOaqrZAkzH0NSIfyRM5RV
   Ydf2PoLMwnEwM8vel5ZEqSQxOSvVZ6xdsZiUCskObjC94a8/I10/ZtreC
   GZXn8UHeA1U2oYwp7AscE/zzKKEST2JAblbKQrOjcAYD0uajedd71KyHl
   Yuz6rxjRLiGUW4WoAfru9rU2GSmd5if2lOYHZMymGQCXnMgHhzMQn/V7z
   Ua7qqR4XGi4VBHj0nD9TBFAXT1Ph4cAcBDLjTvedgLUMay+u/6xpT6yDV
   GEKykeGR/I5yfpt+DjoZ2qes2mN9aYGISRcaoKHqk7TW68Dc5b/7VzzRl
   A==;
X-CSE-ConnectionGUID: udqygBtJSiqhJ44Suc0e/Q==
X-CSE-MsgGUID: jTW+I0lTTsC0Y+5QkB0UQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="78452459"
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="78452459"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 14:50:46 -0800
X-CSE-ConnectionGUID: Gi0xBQ+9QIKq3vj3iJ3POw==
X-CSE-MsgGUID: HqIoZWX8TMm78gfk7Y3icw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,257,1758610800"; 
   d="scan'208";a="226452787"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 14:50:43 -0800
Date: Mon, 8 Dec 2025 00:50:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] iio: imu: st_lsm6dsx: remove event_threshold
 field from hw struct
Message-ID: <aTYEwUU0xkPGSZHF@smile.fi.intel.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
 <20251201100018.426749-6-flavra@baylibre.com>
 <20251207153113.20c97fa9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207153113.20c97fa9@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Dec 07, 2025 at 03:31:13PM +0000, Jonathan Cameron wrote:
> On Mon,  1 Dec 2025 11:00:14 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
> 
> > This field is used to store the wakeup event detection threshold value.
> > When adding support for more event types, some of which may have different
> > threshold values for different axes, storing all threshold values for all
> > event sources would be cumbersome. Thus, remove this field altogether, and
> > read the currently configured value from the sensor when requested by
> > userspace.

...

> >  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
> > +#define st_lsm6dsx_field_get(mask, reg)	((reg & mask) >> __ffs(mask))
> 
> I'm not going to fuss too much about this as expectation is that
> this will be replaced soon anyway with a generic version but convention
> would be to (reg) & (mask) to avoid precedence of operator problems if
> there are any in the parameters passed.  The generic version will I guess also deal
> with avoiding multiple evaluation of mask.
> 
> Anyhow, doesn't matter here given the simple user.
> 
> Applied.

Note, the new API is already in Linus' tree.

-- 
With Best Regards,
Andy Shevchenko



