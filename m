Return-Path: <linux-iio+bounces-23097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FDB2F44F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEED47AEE32
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFF2EF657;
	Thu, 21 Aug 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAk05YtB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82051DF74F;
	Thu, 21 Aug 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769400; cv=none; b=uFKtxQy7/JQIG1n3Fyr4sQL0RkRImk9fYCZT+w40Ud/dQP2OMtYLfB1p09WOhZoA7srPdi81O5g5rpBzNx/3z2o2VeJLzlSAAD7+MgMJTkDtIVUUwZNr8wJRGILBIXN6JbHpPAvBJdATjitDBLPPiCUAsDp4gJ7yN63FsAbuc+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769400; c=relaxed/simple;
	bh=IzAeBKvBI5xikFKRMfx1rMJjSZ8IRUExIksmFutkdG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjVaUjUr4Ak26IfXFmnzIcLgsdTmGStRKIb9QjYeLFsm0eaL3KdtBU17cgO5ikLnK5c0m6JyMgbRfZyrYp+yYYbJBj5KO3pZPxB9amUHyjxUmEjd6zFYD5D0Awn9DnRc3Iu3JWPJHKyNl7UsS+k7QVZ4v+DooOaIairyDHubOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAk05YtB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755769399; x=1787305399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IzAeBKvBI5xikFKRMfx1rMJjSZ8IRUExIksmFutkdG4=;
  b=cAk05YtBRXdjZI/YleNWF3IUjSh9oU4ffFOAs3BR4qlcqBV7AOpoofRr
   EEcmnrOJ1akFMq9Nu+jIQPV+G+Lf/qwKlLv8loHhb6qywPlk5jCNgg+Xc
   r2BLrUMm28vIRK0pYfneot34jXEUE3KT0WMtjEpC2RHDdt0jU1TOvAYdh
   FFJHAL+QG5mtN25JS+Jo6lGtUtUvyDbJvrlkCElPtEFT+4zkjjUdbg1yy
   6S8iIaF6MisazghJEDMzh1lihXPV+so8IBoNGTawXEekVE4XcOUnzTAxD
   0S+yl+Wemzfr2hwkBM7liFSdDJjnPlmWHbjtMsoG2qLPkYnsiqEgKflfE
   g==;
X-CSE-ConnectionGUID: YMMYxu17Qs++154AsKnTYg==
X-CSE-MsgGUID: jItEiEL0RGW7Q8CkvN5cAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75502530"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="75502530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:43:18 -0700
X-CSE-ConnectionGUID: zko0mtC0T9OplGy9wW7qmw==
X-CSE-MsgGUID: 27nKqLPuS5OpcVtm0xa9Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199245987"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:43:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1up1p9-00000007Bk4-08MG;
	Thu, 21 Aug 2025 12:43:11 +0300
Date: Thu, 21 Aug 2025 12:43:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aKbqLpJMCxJd3QXW@smile.fi.intel.com>
References: <20250715085810.7679-1-ak@it-klinger.de>
 <20250715085810.7679-3-ak@it-klinger.de>
 <aHdWAUMMH43tIqV4@smile.fi.intel.com>
 <aIMy_BHJYNA20k-x@mail.your-server.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIMy_BHJYNA20k-x@mail.your-server.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 25, 2025 at 09:32:12AM +0200, Andreas Klinger wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Mi, 16. Jul 10:34:

...

> > > +#define	VEML6046X00_GAIN_1          0x0
> > > +#define	VEML6046X00_GAIN_2          0x1
> > > +#define	VEML6046X00_GAIN_0_66       0x2
> > > +#define	VEML6046X00_GAIN_0_5        0x3
> > 
> > Is it defined as hexadecimal in the datasheet? Otherwise use plain decimal
> > numbers.
> 
> It's in the datasheet defined exactly the way i did.

OK!

...

> > > +	part_id = le16_to_cpu(reg);
> > > +	if (part_id != 0x0001)
> > > +		dev_info(dev, "Unknown ID %#04x\n", part_id);
> > 
> > For 0 it will print 0 and not 0x0000. Is it okay?
> 
> I just tried and it prints 0x00 if the part_id is 0.

This is interesting... So it's not 0, nor 0x0000?

-- 
With Best Regards,
Andy Shevchenko



