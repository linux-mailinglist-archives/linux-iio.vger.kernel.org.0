Return-Path: <linux-iio+bounces-9144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5DA96C03E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A63628EC4B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B81DC19F;
	Wed,  4 Sep 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwNyUZZS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702041386C9;
	Wed,  4 Sep 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459713; cv=none; b=fxkBL1dZwqugyx9LUp6gg0wEPflpxMW/cZddf/uBwW0zefoc106QZU54NbEdJIYRyAoPMACcLryr/o8gDz3srwLbXUXeyICAKM67YBb+PooVBK/ZVe6cRWnm18UHBtDCWK3E7VTmxNa/GwiReEhq48kD2xcFgQWdeZKfrEeDbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459713; c=relaxed/simple;
	bh=ngL98UXfE8sIVOA4xLAR7v1aB/yBJVOUhi4uMokF1Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue3VeMItLjP7Oa2N9/Mvazb66O1zU5NgNyxmo1/1i75oAn6fjQxLWYZKXiyPl9trS3ouyTKBHXYzQ3I4LRsR3feFch6S/+PIwu0tRLz8aKBIGns+Sgvo4mQpeBUL2Ycoqgj4P8jss825/cfx6PANPakmJjGoxYmDt/P79+25INc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwNyUZZS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725459713; x=1756995713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ngL98UXfE8sIVOA4xLAR7v1aB/yBJVOUhi4uMokF1Ak=;
  b=AwNyUZZSXCzkw5IL6eRjTLCJkGSRERS8dAFbRHhGICrx8Wp58bhO6sSx
   I9rn0o3y0tCiU8scS/BPvZ+dwshOHgEGYRg/pIGuOGyz610FxhAdf+938
   dMktLd48T1nuV08JnwBlPh6ncIgqCKF6ASFXiWfODq5QtWCaAjyljgYQP
   mDi5/cno+55xoQhLufvOz1oLdlV7zbWMQiCrKJdYn3epMp/JCXw3TOcka
   f39ubSrl5V2lEWyUWmIa2olAqicoFBNtK+I+/gQTCXGY6+EZ2/NV7uoZt
   XFi1s9zA/dFlfGE9xleRU9xCzOu6+RGdqaEbQyHcIdbNTrffhDo0C17jL
   g==;
X-CSE-ConnectionGUID: bgmsJ/EkQk+aF677YkCwaQ==
X-CSE-MsgGUID: g61wYNRsRCa2rJ7wqWDTvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24267615"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="24267615"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:21:52 -0700
X-CSE-ConnectionGUID: 1H+GBePaSS+PnL4/6LFPUA==
X-CSE-MsgGUID: 5Vq1EPPQRPO975GXu4M2TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="65124778"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:21:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slqtF-000000055V2-0Mvs;
	Wed, 04 Sep 2024 17:21:45 +0300
Date: Wed, 4 Sep 2024 17:21:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <Zths-IcwYyUV_kYk@smile.fi.intel.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-5-vassilisamir@gmail.com>
 <ZtccnvhmcxyRQVuf@smile.fi.intel.com>
 <20240904102427.GA44250@vamoiridPC>
 <Zthr-bKR-jr7B2kc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zthr-bKR-jr7B2kc@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 05:17:29PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 04, 2024 at 12:24:27PM +0200, Vasileios Amoiridis wrote:
> > On Tue, Sep 03, 2024 at 05:26:38PM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 02, 2024 at 08:42:19PM +0200, Vasileios Amoiridis wrote:

...

> > > > +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> > > > +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> > > > +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > > > +		return -EBUSY;
> > > > +	}
> > > 
> > > Alternatively
> > > 
> > > 	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
> > > 	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> > > 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > > 		return -EBUSY;
> > > 	}
> > 
> > Why would I use && instead of || ? I just need one of the 2 to be true
> > (one of the 2 measurements is not complete) and I can trigger the error
> > action.
> 
> Oh, I messed up the logic inversion, but wouldn't it be simpler to read
> "we return busy if neither press nor temp drdy bit set"?
> 
> 	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) && (reg & BMP380_STATUS_DRDY_TEMP_MASK))) {
> 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> 		return -EBUSY;
> 	}
> 
> (I left long line for the better understanding of my point, you may break it to
>  two if needed)

Scratch below, it needs more thinking...

> With that, you even may have
> 
> #define BMP380_STATUS_DRDY_PRESS_AND_TEMP_MASK ...
> 
> 	if (!(reg & BMP380_STATUS_DRDY_PRESS_AND_TEMP_MASK)) {

Maybe ^, but I have no time to dive into this, you got the idea I believe.

> 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> 		return -EBUSY;
> 	}
> 
> which makes it all obvious.

-- 
With Best Regards,
Andy Shevchenko



