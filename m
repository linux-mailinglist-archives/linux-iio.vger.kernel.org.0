Return-Path: <linux-iio+bounces-10835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E339A5AD3
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 08:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247131C2132D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF521DACA1;
	Mon, 21 Oct 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfHO78f6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422461D0F6E;
	Mon, 21 Oct 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493244; cv=none; b=nKlm2JGPd/G2PL+uQ9RK6KLHPSrf4htvQXmL42w2bhzHe/2bwuAM88A0Rp86rcgRsejAynmxtnIwawFfQoXQGb9edtHEIy8YqV33leoyYfL4/OHxmJypeN4ekV8ULdIfPzyccrmHrA6RXbarpNy3QYprndl3o3ryvOSvG0HQGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493244; c=relaxed/simple;
	bh=s03mjayWlvoA5msMDQHuZc331Tu+wgaZdUbrkGQxm7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e12wxDA73AWTvE4yFL/9ihMcuOcnm1SpYI0/7QAtPAkx7mm1CDX8Z/fAv5S1dmwwemm+onIgi2zPKWlirjvqYTttMTEG62dKTT4yEwSXD34ZeFw+Zj1zgdE/vKLm7OiewD5l5Z15tmd469Xr752DlOxQXNi8NjINBhDZiRpvcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfHO78f6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729493242; x=1761029242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s03mjayWlvoA5msMDQHuZc331Tu+wgaZdUbrkGQxm7A=;
  b=PfHO78f6pJiQk3vrcw7967zVm3DfhCgQ15Bnjjeq9RAbOPYCEyJf1po/
   UXmOO4591TOUgLImBYKkHNpztBC/Oj+WHJyGFDJHuaLu93JWQzzHzyZQH
   sKMWEhsIDGtBZshQpZVjUGRxK0JqeroeLpyPdpvGkmSiUpt4XAQIuJoBN
   dDWWZxvgmlOEFngaKZAVSOVqTXhCGguofVHKeYvUxDZpNLmS1QxF/HTEg
   7kEMFqeickONnO3dA3kv96p0PXTDRDwtpj20+T27MXkOU3iuFnlokn8NZ
   Kg6arxShzcbpR0EO6+vw+n1ucxB/pbZlvK1HaqhTEmKTZH/VjL+pBq6Vp
   A==;
X-CSE-ConnectionGUID: Ijq0aCuaSLGxBhmWG7cwgw==
X-CSE-MsgGUID: mhRekab0QMixu0quRErdKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29080306"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="29080306"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:47:21 -0700
X-CSE-ConnectionGUID: M8UndYcLSR2/dFwsy0cR0Q==
X-CSE-MsgGUID: 4qE6f91DQOafeG4EZ/OY+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79393680"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:47:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2mCD-00000005Onp-0UlO;
	Mon, 21 Oct 2024 09:47:17 +0300
Date: Mon, 21 Oct 2024 09:47:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justin Weiss <justin@justinweiss.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI IDs
Message-ID: <ZxX49BzZJtoYOBI7@smile.fi.intel.com>
References: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
 <20241018185105.41a2db06@jic23-huawei>
 <87sestcg1e.fsf@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sestcg1e.fsf@justinweiss.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 01:27:57PM -0700, Justin Weiss wrote:
> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Fri, 18 Oct 2024 17:57:32 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> >> The commits in question do not proove that ACPI IDs exist.
> >> Quite likely it was a cargo cult addition while doing that
> >> for DT-based enumeration. Drop most likely fake ACPI IDs.
> >> 
> >> The to be removed IDs has been checked against the following resources:
> >> 1) DuckDuckGo
> >> 2) Google
> >> 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> >> This gives no useful results in regard to DSDT, moreover, the official
> >> vendor IDs in the registry for Bosh are BSG and BOSC.
> >> 
> >
> > I'm nervous about Bosch drivers in the wild given recent report
> > from Justin
> > https://lore.kernel.org/linux-iio/87jzeboi3g.fsf@justinweiss.com/

I know about Realtek case, but for BMI0/BMI it's interesting that MS
catalog shows hits on BMI160 (note no leading zero!), but not on BMI0160.

> > Justin, I couldn't find the driver you were referring to for the bmi160,
> > is it online somewhere?
> 
> Yes, the BMI160/260 Windows driver is on this page:
> https://ayaneo.com/support/download
> 
> It's at the very bottom, under "AYANEO Universal Gyro Driver." GPD also
> has a copy inside their driver pack under the "Drivers & BIOS" tab here:
> https://www.gpd.hk/gpdwinminifirmwaredriver, but the download is often
>>  at capacity unless you're signed into Google.

I was not Cc'ed on ACPI ID parts, please make sure that the patch
that adds it has a pointer to the actual device which uses it _and_
DSDT excerpt of the respective Device object. Without that info provided,
NAK from me.

> > Also if you have other bosch drivers could you check for these + bmc150
> > IDs Andy is proposing dropping in:
> >
> > https://lore.kernel.org/linux-iio/20241018145805.2181682-1-andriy.shevchenko@linux.intel.com/
> 
> Unfortunately, the 160/260 driver is the only one I have. I wanted gyro
> support in Linux for a handheld PC I bought, and it was the IMU that
> happened to be inside.

-- 
With Best Regards,
Andy Shevchenko



