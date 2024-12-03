Return-Path: <linux-iio+bounces-13021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D19E1CDC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA797B41F1E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B341EB9E7;
	Tue,  3 Dec 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4OpATY3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246872500BB;
	Tue,  3 Dec 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229763; cv=none; b=CY8IDGt0peyEvyc/1c5P/+FsL+W0cBmlb1SiSGYTroX8DJLrNAeKoR8T+p0XlXYk8mZuQnj2eHka+Ebd9GA+saDceepetCuzYxJsHk65/yev3lWBwnM8OjZdmxdEfW0JCwtdfFXYzF0CAnIQujrNaH25kiCpytPAZMwqyZvGlwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229763; c=relaxed/simple;
	bh=GEVDWoXU8EkXt2/Ud0xmX9mi2TRTdqO++Z+8LyxF8Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C85owkEbnzdz4Xa+ZwWGj5lXRwm+Q0pOyPjib/+dU2jqkeaHb3GCDLq0kWlBCcju/bj7MBBLJ1vH6ZXz04IH8CsVDDwsG01cAIEj0zwq4KYx9YepFqvYcMJ+zXwuXzhRj4HkoyL7GtbaQS22fa2rDiU6AJKxJf5CVwkvyG1oFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4OpATY3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733229762; x=1764765762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GEVDWoXU8EkXt2/Ud0xmX9mi2TRTdqO++Z+8LyxF8Gc=;
  b=L4OpATY39k2zAx0zqAEuEJV/RxYeKf1+Bb0zcBPPt4+35+ntAOcyIwlU
   cbOGldUV3Na7dgn3oGlZc4O0qxp4XjcNHilbfo9jic4qbPjD7ggSQE61h
   CMJTP4m2RqTxMhiMwBBA1VR6BzY1ntDiP/wA1f7pFxLSefSH0DNhtOhIU
   w5ZjlnkLpA4sK45FxamohMC2QSGRG8SupfJ2gaKKug6BuLsixJ6N46b+R
   MClXAxRk1Ga3YJGeWq08RmgQVv0ZFEk0cwZC1aYsnxFFPwA+6XutKnVf9
   /eW8O2hytnD6ajXUvL9xms02gNzGo7fQmkfN9gvPwIFqTpkl+vN+mOcJo
   A==;
X-CSE-ConnectionGUID: caj+rfiXSI+cemIc9nzeMg==
X-CSE-MsgGUID: K2MP4OWPRF2YarTwMLAfnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32785675"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="32785675"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 04:42:41 -0800
X-CSE-ConnectionGUID: Cjp9XN5TQnWBwd25pyBIQg==
X-CSE-MsgGUID: skx+fdfuTdKqJ4NbE8lekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93510610"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 04:42:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tISEe-00000003RGH-1eT5;
	Tue, 03 Dec 2024 14:42:36 +0200
Date: Tue, 3 Dec 2024 14:42:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: chemical: bme680: add power management
Message-ID: <Z078vIxRoQf_zLsy@smile.fi.intel.com>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
 <20241202192341.33187-4-vassilisamir@gmail.com>
 <Z04N6GUSL2H0zt6_@smile.fi.intel.com>
 <Z04aJg7eoBR9CYKe@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z04aJg7eoBR9CYKe@vamoirid-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 09:35:50PM +0100, Vasileios Amoiridis wrote:
> On Mon, Dec 02, 2024 at 09:43:36PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 02, 2024 at 08:23:41PM +0100, Vasileios Amoiridis wrote:
> > > Add runtime power management to the device.

...

> > > +	ret = pm_runtime_resume_and_get(dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
> > > +	pm_runtime_mark_last_busy(dev);
> > > +	pm_runtime_put_autosuspend(dev);
> > 
> > Side note: as long as idle method is not defined (NULL) the above dance is
> > already taken into account in the regular put.

> Thanks again for the review! Indeed by looking at the code a bit, it
> looks like the suspend callback is being called if the idle one is not
> found. But I have seen this dance that you mention much more often in
> the IIO that's why I used it. We can see what Jonathan has to say as
> well, I think what you propose, simplifies things.

Yeah, this is cargo cult by many people (including me :-) who missed that
detail. If any, this can be addressed in a different series.

...

> > > +static int bme680_buffer_preenable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct bme680_data *data = iio_priv(indio_dev);
> > > +	struct device *dev = regmap_get_device(data->regmap);
> > > +	int ret;
> > 
> > > +	ret = pm_runtime_resume_and_get(dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > 
> > Either this is broken (if the above can return positive codes), or can be
> > replaced with direct return:
> > 
> > 	return pm_...
> > 
> > (but I believe it's the former and you wanted something like if (ret < 0)
> >  there).
> > 
> > > +}
> 
> Well, pm_runtime_resume_and_get() looks like it returns 0 on success and
> negative value on error so I think the if (ret) is correct, no? But I
> agree with you that it can be simplified as you proposed.

Please, go ahead with the simplification!

-- 
With Best Regards,
Andy Shevchenko



