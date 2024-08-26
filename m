Return-Path: <linux-iio+bounces-8788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643195EE53
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D3128165E
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDB146A69;
	Mon, 26 Aug 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f60MTcl1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC271474A9;
	Mon, 26 Aug 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667450; cv=none; b=FNqt90zVNdL0gHFp7+c+i+onrQwVHvIZzvLxJl1S/HJdIcrvqUtnPvYkUq813y/ifdQkANOWb9/oSg0DndXSg6dmJ5v5/UMAxTrS0mQwldOT7Pw/UGEoSqIPiazmyH1JO6vsJ6bgxkifknvr5UPLwX0axDzgSK8Y5KSNjpakYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667450; c=relaxed/simple;
	bh=Buc3IMpckq5tgjNZ8RKfWQywqJu7JnsCJu9Ai+khWjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ducN/yrK01aMNNFFXm/w2EwSuO2CYHOGqRFaXHNz9+yxpR7pgnIIkkDkxk/+dY27yopTV/8VMtc9mhEqK3VtKrVdDxuLkxIpFrDeQ5W0uWantnUTyOB80J2kcyq+ooR+ExGvlZhsoBUYC5ccC4zAM7dLb8iiyn8KH5FxtATlkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f60MTcl1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724667449; x=1756203449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Buc3IMpckq5tgjNZ8RKfWQywqJu7JnsCJu9Ai+khWjc=;
  b=f60MTcl1yXGsED0jXVTqbhnJULr0XTRdEDz+bZFLrm1IAqB9A0QSBi5Q
   gRHljMybIx/6iCHMFgpaVpSLvv13WlCZ39qj/3PRASQ/hZHuARlLxa2HD
   wx9O3Su+b0NOit0ls/c+zIDvLnuCPybET3/NC1UP17+l7yIXL4F+HlstL
   Vb6BoJtDk6GetQUBl23ymN7bau2AeOnloB60g/8CPhsTQM8GEucFshNw1
   5PVJcqgkYPYXjKapRjIoE5foi6Ve2gBGprH8fLy/rRGOVctkabgC8aTmE
   f5APhqsCAtjYZGkxNOJnRha2B65q5CXdiiaTshkSY6asqpJ2lssCQsVgz
   Q==;
X-CSE-ConnectionGUID: Pryq4gc6SxykBBxaZA/3Dg==
X-CSE-MsgGUID: yAKtid9sTj6Jh5g3zQ8gEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26845090"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="26845090"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:17:28 -0700
X-CSE-ConnectionGUID: 4pq+h476TJ6u1jGLBUQSsA==
X-CSE-MsgGUID: 96S86u3UTby1eCb+iOrZ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62983918"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:17:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siWmn-00000001pSA-3TZe;
	Mon, 26 Aug 2024 13:17:21 +0300
Date: Mon, 26 Aug 2024 13:17:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <ZsxWMSv5e5ZWOlai@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-5-vassilisamir@gmail.com>
 <ZsjiDaZjcA-oopWB@smile.fi.intel.com>
 <20240824112924.GD9644@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824112924.GD9644@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 24, 2024 at 01:29:24PM +0200, Vasileios Amoiridis wrote:
> On Fri, Aug 23, 2024 at 10:25:01PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 23, 2024 at 08:17:11PM +0200, Vasileios Amoiridis wrote:

...

> > > +	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
> > > +			   time_conv_press[data->oversampling_press];
> > 
> > 4 * USEC_PER_MSEC ?
> 
> Since the previous values in the arrays are all in thousands, why should
> I make this different?

When I read the code (and mind that we write code for humans), I don't
have a clue about the order of the values in use. Also it's hard to get from
the line the meaning of both sides of the formula. Using named definitions
helps a lot in understanding this line without reading and analysing code in
full.

...

> > > +	usleep_range(meas_time, meas_time * 12 / 10);
> > 
> > Comment? fsleep() ?
> 
> The usleep here is for waiting for the sensor to make the conversion,
> as the function name points out as well? Should I put it as a comment?
> 
> In general, is it considered good practice to add comments above all
> sleep functions?

Yes, it's even a requirement (not sure if it's documented anywhere) to comment
over long enough delays.

> I don't think it's a bad idea, I just didn't notice
> it somewhere.
> 
> > > +	return 0;
> > > +}

...

> > > +	usleep_range(2500, 3000);
> > 
> > fsleep() ?
> > 
> 
> ACK.

Also a comment, since it's milliseconds range which might be considered long
enough.

-- 
With Best Regards,
Andy Shevchenko



