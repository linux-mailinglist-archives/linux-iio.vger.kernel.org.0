Return-Path: <linux-iio+bounces-13390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EFA9EE8FC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B05A165E19
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0421423F;
	Thu, 12 Dec 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9tKShSN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43F42AA6;
	Thu, 12 Dec 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014150; cv=none; b=U0Gdzq3+zJZIwL7VeM1MzYJaLgXTxPAwcZKGvDzkip3TZDAFMAnBrFFAOFDrArSP/J3N5HlAHwe/xDAz2nhE3d7YeZSR9PGUpStRteFo5NRYDKxULpxxJe80TcuOgVMTN6TOnThTWDlWblY40B3gIk+FLqUrWCDJvH2JF4Q5ZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014150; c=relaxed/simple;
	bh=pEIFIZJF8cngkjb+RiCN9/+fq9gFY1FVR3Tc3nK/LWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KliRGRNTjtlk+ZwW7lqReBzj29+rCL52pwwPFmF6dQhkX2QXZrZPXievyvjP6g0ybskvMR4PMcYoPuk95/kszbWSqY/QiMIr0TCxcIvJEK3n1ZIbZjneoDto+LLa5m/IIVioJvHx1egSnfXoZ9a3dzjrkH6RHHaAwshKx+jjZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9tKShSN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734014149; x=1765550149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pEIFIZJF8cngkjb+RiCN9/+fq9gFY1FVR3Tc3nK/LWc=;
  b=E9tKShSNxJ+buZFT+89eYyTDJmjMGmQjlc3jDF7rHuhe/M+KadOH6rAF
   kbld6RS+u7UaTMlc222tIsN0oAfkGdlgcWVRMNHK78oPzXOVVCFpR0i8j
   SvgbOVXsZaGD+C0qv7ytSafsNFUE1GEZxR2tiju1EkqEUmbVY54oguTgR
   8NonyrgNvu//RS2woygikcUiCFgdCBchDoVWBBQMhFrFa26+V8chfDo40
   tXE/UOFBjfnoP4uucrjAT848HqBT9aYu+aMBFFdJGvqBibv1/NkyQaKlB
   8+Z1Il2P7jWxYnjGJF/GfRo/wW7OEiUzY7C3o3QX/HbgIWCDfhH3YKwSj
   g==;
X-CSE-ConnectionGUID: l85wFHVSR+6ZEzxz5NXW3A==
X-CSE-MsgGUID: juC3scJvSjC20/rVjpqvbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="56902934"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="56902934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:35:49 -0800
X-CSE-ConnectionGUID: XzhTQfCsQ3ObPfL0Q+ZzKg==
X-CSE-MsgGUID: gOxbAqB1QLGOe4w1VFyx4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96655493"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:35:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tLkI5-00000006vKE-15tp;
	Thu, 12 Dec 2024 16:35:45 +0200
Date: Thu, 12 Dec 2024 16:35:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, gregkh@linuxfoundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Split devres APIs to device/devres.h
Message-ID: <Z1r0wUHu8VO4baaI@smile.fi.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
 <20241203195340.855879-2-andriy.shevchenko@linux.intel.com>
 <20241208171001.4994e749@jic23-huawei>
 <Z1Y9uqGyq-yuxoEe@smile.fi.intel.com>
 <20241211182958.5afc82c4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211182958.5afc82c4@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 11, 2024 at 06:29:58PM +0000, Jonathan Cameron wrote:
> On Mon, 9 Dec 2024 02:45:46 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Dec 08, 2024 at 05:10:01PM +0000, Jonathan Cameron wrote:
> > > On Tue,  3 Dec 2024 21:48:51 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >   
> > > > device.h is a huge header which is hard to follow and easy to miss
> > > > something. Improve that by splitting devres APIs to device/devres.h.
> > > > 
> > > > In particular this helps to speedup the build of the code that includes
> > > > device.h solely for a devres APIs.  

...

> > > > -#include <linux/overflow.h>
> > > > +  
> > > Unrelated change.  
> > 
> > Which one? Blank line?
> I think that's what I meant :)  Was a trivial comment though.

Got it!

...

> > > > -#include <linux/cleanup.h>  
> > > This header movement is unrelated.  
> > 
> > No problem to let it stay at the same place.
> > 
> > > I agree both are good but probably want to be a separate patch.
> > > 
> > > Otherwise this seems sensible to me, but your cc list seems a little short!
> > > 
> > > Greg and Rafael seems a good starting point so I've added them.  
> > 
> > Thanks! I need to check why they were not included into the original
> > submission. Perhpas I need to amend MAINTAINERS,

I added the file to MAINTAINERS locally.

-- 
With Best Regards,
Andy Shevchenko



