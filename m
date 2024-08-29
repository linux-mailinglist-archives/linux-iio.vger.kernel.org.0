Return-Path: <linux-iio+bounces-8889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63F9650BC
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 22:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83871F24708
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5E1BAED1;
	Thu, 29 Aug 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKZfZYdO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F31B5813;
	Thu, 29 Aug 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963169; cv=none; b=ZOse57gL9D4uiwhy+WAs8Odfk7DQKLtAby1gp13refucNRjD5f+vwwr3eNg7OLxvMe1FUgDXYjC4JbsfCiUsJpqCWqp9Q4XVrGecfbXloGCzErHUWpMJxmWvTIHWA8ivw5lThO+4XuUOHnmuLL+mZ33JPYkLh1S7rKSSqJqM8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963169; c=relaxed/simple;
	bh=86RPtIL+msArvWiZ8omd1lm+QQ09MUZ0+jCaU7IO3Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6DC0sH7u/sdXNnANX5IcD5cQFQB5MrYffOe3ymMGZeElxeNOJVThl0lwhJJpjMcTItmwmT/MirOdgNz3oE1kYVdYXGAuE/xvTWcHPcTaZTsX2ItsZ2xbCDYHrkG1QyQwkUCWhMfO64GKquj9smrRHhOtTMlHqSTHCOG+pv89jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKZfZYdO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724963168; x=1756499168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=86RPtIL+msArvWiZ8omd1lm+QQ09MUZ0+jCaU7IO3Dk=;
  b=oKZfZYdOyrUuq7HwvrEkakHg6nsCx4dA8eL1H78/duK9dFkxlegQFaAv
   whA5+GZ4JjJDNRB/o0OoK0OKrDHEZgoc1AJp+NNg2lG9yzJwwB5xXO80C
   +a9dslVn5cE2XzvUqMWFSa8j0dDaGDP+RDPbbpaZ1IoEmVCkw7Lo3WNE2
   mPFsL4QqcaW28ELbu8xTKbI7cWZLzkBVy1tDUPnnnXn/nj2nxISlU9W6q
   EN15pMqyoX8wHVQ2tZIpcrbwldR58S0Wk+328SymTutXKgA7HC/eMZ10O
   PosansJdvn05kFxYbi/kQm64Ve1QZvs1z9L0uQzJTYuKqb6sOzXQs6MRd
   A==;
X-CSE-ConnectionGUID: nOxfFtozSv2P32YyqqYNTA==
X-CSE-MsgGUID: KHCKNrKcR8efyZ9Kk1P8GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27462709"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27462709"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:26:07 -0700
X-CSE-ConnectionGUID: LyJTEhqnR0KpyPumG70D+g==
X-CSE-MsgGUID: c+lPvE3ORMWZcsJnV3/Y3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="94514568"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:26:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjliS-000000039Rk-4Beb;
	Thu, 29 Aug 2024 23:26:01 +0300
Date: Thu, 29 Aug 2024 23:26:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <ZtDZWCgE-zRriyQ4@smile.fi.intel.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-5-vassilisamir@gmail.com>
 <ZtBqNAYlZSEhd_20@smile.fi.intel.com>
 <20240829191344.GC3493@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829191344.GC3493@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 09:13:44PM +0200, Vasileios Amoiridis wrote:
> On Thu, Aug 29, 2024 at 03:31:48PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 28, 2024 at 10:51:24PM +0200, Vasileios Amoiridis wrote:

...

> > int bmp280_chip_config(struct bmp280_data *data)
> > 
> > >  				BMP280_OSRS_TEMP_MASK |
> > >  				BMP280_OSRS_PRESS_MASK |
> > >  				BMP280_MODE_MASK,
> > > -				osrs | BMP280_MODE_NORMAL);
> > > +				osrs | BMP280_MODE_SLEEP);
> > >  	if (ret) {
> > >  		dev_err(data->dev, "failed to write ctrl_meas register\n");
> > >  		return ret;
> > 
> > This _feels_ like a separate change. I haven't found anything explicitly
> > describing it in the commit message. Did I miss it?
> 
> Well this change is because before, the sensor was by default in
> NORMAL_MODE so whenever we were writing a different setting (Output
> data rate, oversampling ratio) to the sensor, the NORMAL_MODE was
> chosen. There was no idea of SLEEP or FORCED MODE.
> 
> While now, since this commits adds the idea of SLEEP_MODE
> by default (FORCED_MODE for oneshot captures, and NORMAL_MODE for
> buffer/trigger) we need to keep the sensor in SLEEP_MODE as well
> when we change its configuration.
> 
> I believe it belongs to this commit. Maybe though, I should mention
> this change explicitly in the commit message?

Yes, please.

...

> > And in programming hardware we quite often operate with power-of-2 things, so I
> > recommend to have 8 per line,
> > 
> > 	static const int time_conv_press[] = {
> > 		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420,		/* 0-7 */
> > 		84420,							/* 8 */
> > 	};
> 
> I was not aware of this convention, I can do it.

It's rather a common sense to easy maintain this and see exactly how many
(decimal) values are supplied. With hex values we usually make them fixed-width
and hence easier to count (however also makes sense to keep power-of-2 in mind).

-- 
With Best Regards,
Andy Shevchenko



