Return-Path: <linux-iio+bounces-25657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C0C1F3B3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 10:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A24E7B26
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370EF31960E;
	Thu, 30 Oct 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STcxgVNt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906612D0C9D;
	Thu, 30 Oct 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815904; cv=none; b=eLIlESYyFWXiw8WXErhC7BOrQxSzioIsSUKR/UFCqt7cot+99+sOV19lN10CiPDBUyNxH3EvefJSzq3fGG20hzhB1rYn8s3diJYHgzxGldS4b7K0oUXioCRrCAZE8TLyqJxclncZ96I73X9BcOie/yAMB0lkia7qsOLfTQwiW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815904; c=relaxed/simple;
	bh=zHCqDJZUfYLD2C0sOWZh7SsMj50sJuSbJFBamQ1EwHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DagrDwwNqDpHqESWqOSjuNbXuthJ9l+5hBo7cHGohtxYPupRvwIDzSTKjlycaZrNC9Df/WBK2nc+ed3XLUsFSvGpCNS0pNZPvk/1T+H8EQyYjbeCwXK7e9SUsfE56TROtSOgnpngkjDRW/Z3HEHrKO2An2seOwwWJbVPX9ab5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STcxgVNt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761815902; x=1793351902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHCqDJZUfYLD2C0sOWZh7SsMj50sJuSbJFBamQ1EwHw=;
  b=STcxgVNtjkYIvuTKUEyPqXDJeTh4ALnetru4D+inoODnDOHeX6dbIfw2
   WVJHTSFqjfSBhD1a3EEq//dj3XXwkI2nXNplQkkRBSzpTcd17lJxuoRcy
   sgdGptgI1hDGG8p/tF3WtvMTmvlzd/G+yTKmiKaHYRXlTltjy30k9dU2G
   AAT9znUU9ODI3I0hvGGzqOi6XbQxkYBUktvl11/dkZoUYUQ0N8M+qqPSo
   hwVZCoDONzLypgCM1gcDt0NLI7jGbA+7WYX+kvvW1GTtfMT8YiVYXRSSN
   GHljNlhpPs6Pug8PgfnE57gx1Ia+UCxaElQbr2DvufL00Kfwem+QWGkik
   Q==;
X-CSE-ConnectionGUID: WeilZlqdS2yH84gO2TtYRw==
X-CSE-MsgGUID: cCb5jPvQRGKIgt6C0fA4IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67812050"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="67812050"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:18:14 -0700
X-CSE-ConnectionGUID: 18ap4ge9So6E8UWbDzdDcQ==
X-CSE-MsgGUID: DdF1Q12oRgOwaTsGiEd3tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186646242"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:18:12 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEOnK-00000003r8q-0kjR;
	Thu, 30 Oct 2025 11:18:10 +0200
Date: Thu, 30 Oct 2025 11:18:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: mpl3115: add threshold events support
Message-ID: <aQMtUUp_QoR4l3nd@smile.fi.intel.com>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-3-apokusinski01@gmail.com>
 <aQHPUQ5bU7sFojul@smile.fi.intel.com>
 <20251029224605.3ixkvmmkm36iwh22@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029224605.3ixkvmmkm36iwh22@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 11:46:05PM +0100, Antoni Pokusinski wrote:
> On Wed, Oct 29, 2025 at 10:24:49AM +0200, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 10:33:52PM +0100, Antoni Pokusinski wrote:

Please, remove context you are agree with!
Otherwise raise your point(s).

...


> > > -	u8 ctrl_reg1 = data->ctrl_reg1;
> > > -	u8 ctrl_reg4 = data->ctrl_reg4;
> > > +	u8 ctrl_reg1, ctrl_reg4;
> > 
> > > +	guard(mutex)(&data->lock);
> > 
> > Why this is moved? Before the access to the data->ctrl* was done without
> > locking. Is it an existing bug?
> > 
> Since this patchset adds `write_event_config()` in which CTRL_REG1.ACTIVE
> and CTRL_REG4 are modified, the lock now needs to guard the read of
> data->ctrl_regX as well. Otherwise, we could have e.g. 2 concurrent
> threads executing `set_trigger_state()` and `write_event_config()` that
> would read data->ctrl_regX at the same time and then one would overwrite
> the other's values in `config_interrupt()`.
> 
> In the current driver I don't think there is any bug in here. The only
> place (except probe) where the data->ctrl_regX is modified is
> `config_interrupt()`, called from `set_trigger_state()`. If we had
> concurrent calls to this function, then the final values of CTRL_REG1
> and CTRL_REG4 would simply depend on which thread is scheduled as the last one.
> With the `guard(mutex)` before accessing data->ctrl_reg1, the situation
> would be exactly the same.

I see, can you summarize this in the commit message as well?
And/or in the code near to the lock description.

> > > +	ctrl_reg1 = data->ctrl_reg1;
> > > +	ctrl_reg4 = data->ctrl_reg4;
> > >  
> > >  	if (state) {
> > >  		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> > >  		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
> > >  	} else {
> > > -		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > >  		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> > > -	}
> > >  
> > > -	guard(mutex)(&data->lock);
> > > +		if (!ctrl_reg4)
> > > +			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko



