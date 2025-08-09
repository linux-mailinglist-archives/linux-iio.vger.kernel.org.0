Return-Path: <linux-iio+bounces-22487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088DAB1F3E1
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 11:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6A218C820F
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF33248878;
	Sat,  9 Aug 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2384Fbc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40D239E65;
	Sat,  9 Aug 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733228; cv=none; b=lcS8pMxufusmXmqlnOaCQJFxiy9J4btlQMiLM06hDVGyCDs9huDYVxre+9v7Xa9+4QB+oxiEw7vZSSxRiVuB8PjQc7rhhwbhbalJYxdlA4Fz7+mvLvxWkt3DJ3V3cBGkNnyi0wu9aTj+uwI8nRRXAwlsSql4w9W48NQG+cV8RIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733228; c=relaxed/simple;
	bh=4VnnuHX7b+C/9fKWJdTyKX8G1lRacxEpbRNlncHuRnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXeBMoIGJNWgWK+FmBy8SaNndhJqtTyUv9meAUwNiVgnUHvVSjyQZwOWFcVnxOy4am7wr9nvjxiL2cLY7O9J6hMXvlostalkcbrJMHOBqC3Gf9n7djVvVPWgh/d0XuQjGz6slGdFk1rWdW0xcApZr8qN0yD5ncdDsnPAxLleQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2384Fbc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754733227; x=1786269227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4VnnuHX7b+C/9fKWJdTyKX8G1lRacxEpbRNlncHuRnI=;
  b=i2384FbcfvBfgZ8srSedxC3xys50Z//KD59C49wcER8PkMgBCqeoG2NU
   dV+zw326g0qVC92sxWzb9DFWaAH653PJ7KIxddx00p3WUU93BSAUsVxJ+
   Wz6UTd9MEOIaPxKzdFg9qSPyys8uzrPfMct61saUYbXwOHTjSYeaJ5meP
   wkB35s702d1Kdjj+asNASDZ3X4jtWuF6XxdYLDTQeZ4L7yLJxGSVxUso6
   9uZ4FLQsv+Flbig+toLB+3wN+a9i0ifr4LY+SAMpUWIKqXMhX6PGgajGf
   cuCKvhQUuTzbTI5QWSliuZ28G731tv67wRWVJbsoEB0b9rwjnaR5OU+NY
   g==;
X-CSE-ConnectionGUID: /u4n2lbtRP2gKtV9WEqOYA==
X-CSE-MsgGUID: PN4qe/b3RTab1BIVZE5Zow==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68146091"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68146091"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:53:46 -0700
X-CSE-ConnectionGUID: MW1Fh5prS1Cw0sat/EQcDA==
X-CSE-MsgGUID: cGHXJERpRM2xqUScN+PvDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166307165"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:53:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ukgGi-00000004caN-3cTm;
	Sat, 09 Aug 2025 12:53:40 +0300
Date: Sat, 9 Aug 2025 12:53:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
Message-ID: <aJcapPt8f5YMUBH3@smile.fi.intel.com>
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
 <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
 <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
 <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
 <20250806161801.000061c0@huawei.com>
 <aJO05BNi2TsYtdwe@smile.fi.intel.com>
 <20250807140401.00006c85@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807140401.00006c85@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 07, 2025 at 02:04:01PM +0100, Jonathan Cameron wrote:
> On Wed, 6 Aug 2025 23:02:44 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Aug 06, 2025 at 04:18:01PM +0100, Jonathan Cameron wrote:
> > > On Tue, 5 Aug 2025 14:47:32 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > On Tue, Aug 5, 2025 at 6:05 AM Akshay Jindal <akshayaj.lkd@gmail.com> wrote:  
> > > > > On Tue, Aug 5, 2025 at 2:36 AM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:    

...

> > > > > > Doesn't sound right to me. HAve you investigated PM runtime paths?    
> > > > > Yes I did investigate and found that PM runtime->suspend() callback
> > > > > co-exists with remove callback.
> > > > >    
> > > > > > Looking at what the code you added there it sounds to me like a part
> > > > > > of PM runtime ->suspend() callback.    
> > > > > Yes, part of functionality will always be common, because both the
> > > > > callback implementations put
> > > > > the device into powered down or low power state which is what has been done here
> > > > > Both _suspend() and remove are called at different times in the lifecycle of the
> > > > > driver, but with respect to register setting, they put the device into
> > > > > power down state.    
> > > > 
> > > > Are you sure about the remove stage and how it interacts with runtime
> > > > PM? Please, check how the device driver core manages PM on the remove
> > > > stage.
> > > >   
> > > > > Additionally .remove() can have code for:
> > > > > 1. disable runtime power management (if enabled while device registration).    
> > > > 
> > > > If the device core enables it for you, it will disable it
> > > > symmetrically. I don't see the issue here, it should be done
> > > > automatically. If you do that explicitly, use the respective
> > > > devm_pm_runtime_*() call.
> > > >   
> > > > > 2. device cleanup (disabling interrupt and cleaning up other configs done).    
> > > > 
> > > > Wrap them into devm if required.
> > > >   
> > > > > 2. unregister the device.    
> > > > 
> > > > Already done in the original code which your patch reverts, why?
> > > >   
> > > > > For eg: another light sensor bh1750
> > > > > static void bh1750_remove(struct i2c_client *client)
> > > > > {
> > > > >     iio_device_unregister(indio_dev);
> > > > >     mutex_lock(&data->lock);
> > > > >     i2c_smbus_write_byte(client, BH1750_POWER_DOWN);
> > > > >     mutex_unlock(&data->lock);
> > > > > }
> > > > >
> > > > > static int bh1750_suspend(struct device *dev)
> > > > > {
> > > > >     mutex_lock(&data->lock);
> > > > >     ret = i2c_smbus_write_byte(data->client, BH1750_POWER_DOWN);
> > > > >     mutex_unlock(&data->lock);
> > > > >     return ret;
> > > > > }    
> > > > 
> > > > Correct and where do you see the problem here? Perhaps the problem is
> > > > in the cleanup aordering and some other bugs vs. devm calls?
> > > >   
> > > > > In drivers/iio/light, you can find similar examples in pa12203001,
> > > > > rpr0521, apds9960,
> > > > > vcnl4000, isl29028, vcnl4035. You can find many more examples in
> > > > > sensors other than light sensors.    
> > > > 
> > > > Good, should all they need to be fixed?  
> > > 
> > > The complex corners that occur with devm + runtime pm are around
> > > things that we must not run if we are already in runtime suspend.
> > > Typically disabling power supplies (as we can underflow counters
> > > and getting warning prints).  Seeing as this driver is not
> > > doing that it should be simple to use a devm_add_action_or_reset()
> > > 
> > > Key thing to consider is that runtime pm may not be built.  
> > 
> > This will mean that user does not want to handle PM at all at runtime, so why
> > should it be our problem? If device is off, it's not the problem of the driver
> > to do the power cycle at run time (yes, this might not apply to the system
> > suspend and resume cases, which has to be implemented as well).
> > 
> > > So the flow should work with those calls doing nothing.  That means that
> > > if you turn the device on in probe we should make sure to explicitly turn
> > > it off in the remove flow. That's where devm_add_action_or_reset()
> > > comes in handy.  
> > 
> > I don't think we should do that explicitly in remove. As I pointed out above,
> > this the case that driver should not override.  Otherwise there is no point in
> > having the common runtime PM. User deliberately makes it not compiled, so they
> > should prepare to leave with it.
> 
> Hmm. I don't agree. We turned it on so on error or remove I think we
> should turn it off again.  We do that in many drivers that never made use of
> any of the standard PM stuff because they only touch enable and disable in
> probe and remove.  If nothing else I don't like the lack of balance between
> probe and remove if we don't do it.

We can do it, but this sounds to me like a step back. Implementing proper PM
runtime callbacks is a step forward.

Doing the former in the existing drivers is not an argument to me because all
of them avoiding use of the PM APIs. Note, with PM APIs it may also involve
devlink and other benefits that device driver core gives us.

> > > ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
> > > Is the paired operation with the second disable you add in remove.
> > > Wrap that in a devm callback.
> > > 
> > > More complex is the interrupt enable as that doesn't pair with
> > > anything in particular in probe. I'm curious though, do we need
> > > to disable it given the next operation turns off the sensor and on
> > > probe we reset the sensor.
> > > 
> > > Is just clearing the enable bit enough?   

-- 
With Best Regards,
Andy Shevchenko



