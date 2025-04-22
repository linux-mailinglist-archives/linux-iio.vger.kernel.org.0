Return-Path: <linux-iio+bounces-18524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC7A9739E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA503189F3F0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCD19F40B;
	Tue, 22 Apr 2025 17:31:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB738382;
	Tue, 22 Apr 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343068; cv=none; b=SELcEcnoN1ULDfbRsULMl5/Ja+GQe3jp2qET++7P8u+AZdksSSZ/n+LJciLBgQ87PtSrGvBGFKms1IEyfARO8sMoeIx09VXw9YBczws8Ae8pS4HtJDHDxBhSMmhdqatbrksN8jK1jliADf14K5liGUmYmkXB4wzn4ScY8Rnz9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343068; c=relaxed/simple;
	bh=+u5lJ3//Nx10YkQWNldvdtuPfI6RVP2CDF+nDTeEWow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmfoLMLiS/p+mnwyAng6fBqWstTHYeOnCfGU9xXTkYYoKd+ctNpfOtyZATHAHdqbeadsKG+eUke8sx9Ijk4AYA7AEOUV1jkrG1gjY1d4VY/em+zqMGhWVWv0WqFglaud6g494s49QBoQOk5VvzdlQ7u/uzm34kH1GfkDj0gzdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: DjE+0xOmStSIflA3Cg9bJg==
X-CSE-MsgGUID: frgl/NqgRWmExoPpoZ8iyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57573891"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="57573891"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:31:03 -0700
X-CSE-ConnectionGUID: 7yeI17VmT+KNRJsRZ2y64g==
X-CSE-MsgGUID: lt0D1RopSmeI71SqT7R0GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="136164120"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:31:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1u7HSU-0000000EnW7-2UCl;
	Tue, 22 Apr 2025 20:30:58 +0300
Date: Tue, 22 Apr 2025 20:30:58 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <aAfSUjFh_eB8Dtl2@smile.fi.intel.com>
References: <20250420181015.492671-1-gye976@gmail.com>
 <20250420181015.492671-4-gye976@gmail.com>
 <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
 <CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com>
 <CAKbEzns_cve+=8wQu2poVx5ZFr8zfUyMajmEz_YpSCDxffQXyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbEzns_cve+=8wQu2poVx5ZFr8zfUyMajmEz_YpSCDxffQXyg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 05:38:56PM +0900, Gyeyoung Baek wrote:
> On Mon, Apr 21, 2025 at 4:24 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Apr 20, 2025 at 10:21 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Apr 20, 2025 at 9:10 PM Gyeyoung Baek <gye976@gmail.com> wrote:

...

> > > > --- a/drivers/iio/chemical/Makefile
> > > > +++ b/drivers/iio/chemical/Makefile
> >
> > > >  obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
> > > >  obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
> > > >  obj-$(CONFIG_VZ89X)            += vz89x.o
> > > > +obj-$(CONFIG_WINSEN_MHZ19B) += mhz19b.o
> > >
> > > Preserve order.
> >
> > Ah, I see it's ordered but by Kconfig, Why do you have WINSEN in the
> > option and no such thing in the filename? I would drop that from the
> > config option.
> 
> I followed the 'vendor_device' naming pattern seen in examples like
> 'CONFIG_SENSEAIR_SUNRISE_CO2'

Interesting... Now I understand why the above was pulled without any comment,
because the vendor and device names start with the same letter 'S'!

> But I'll drop the vendor prefix in the next patch, thanks.

-- 
With Best Regards,
Andy Shevchenko



