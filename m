Return-Path: <linux-iio+bounces-22195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8486CB18E52
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D15562C44
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E31224256;
	Sat,  2 Aug 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTo32lN4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620632E36FD;
	Sat,  2 Aug 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135909; cv=none; b=q/mBtrI+fNNARtPrSMigGLF4in2e0ur67J6mu92UzOcWqNdbKSZcr/5ddegIZiTzAXd6FfE/OSYN+OdPckZiV/QV/5afYUQFq0e6UB9fpJm3385XphmfFFJGXAGBCZxQrOstWUwoShiYtvXNkxtQAP7fAr+TGyV/dy9VoK+k5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135909; c=relaxed/simple;
	bh=Xc8SYXB/1ZyPNo7QZEwo91xM8O0MlYCL/z/O4oWx/dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZKhmIcaTELEmTco0kNzJCXoER1HnPB+Rm694+8mWWDCDOqI/TSmzjrvYOobD7OsLMtEB+QkIJbMA6eXNOvq3d5spU+gvW2GKisUNQ94Bp2k/IXCXoL98ZC3G6E/hiehP83KhsT3pV4Y81bogLHd1wxC/4KJKgfYVxJ12AAHfFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTo32lN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40750C4CEEF;
	Sat,  2 Aug 2025 11:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754135908;
	bh=Xc8SYXB/1ZyPNo7QZEwo91xM8O0MlYCL/z/O4oWx/dI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pTo32lN495MtDyGc/Y5MPNZE/zh772B4v+dL7L/qFfJ3Tzrte01jWefQjFuHK0SVb
	 Bh69gdO0PRH3cqxjCgH8QUDiTYtCtsn0iVGSGf7gjFAGAuxMNc1tKGaTaQkCUhh7wz
	 QyUNM0JW135jAwXg+sOgHL13VSOddFKbmpJf+B/EnmsyJfMnftvw9fmrmvk12ufVUt
	 9hTKyIA3KniMX1kQljpsnWNUQ1iqMtzllZy7z79ZMaH0YnZ9DvoWKgXZF9jHuo19p/
	 gkimJFDPy3NBsiWYo8nY9MI9X3OgVwS9r0OipVWyzt9tvdumwIcw0J6gANTtoV4FlK
	 0m/zbxKmgMXdw==
Date: Sat, 2 Aug 2025 12:58:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lothar Rubusch
 <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <20250802125821.2ae1b17b@jic23-huawei>
In-Reply-To: <20250727164909.1833c4bc@jic23-huawei>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
	<20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
	<aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
	<aHYIBReTFqJMtiXW@smile.fi.intel.com>
	<vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
	<aHd2s987EMCdgdrJ@smile.fi.intel.com>
	<20250724162227.065d20a0@jic23-huawei>
	<aIKlC-HlP3nX-ERA@smile.fi.intel.com>
	<20250727164909.1833c4bc@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 16:49:09 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 25 Jul 2025 00:26:35 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Thu, Jul 24, 2025 at 04:22:27PM +0100, Jonathan Cameron wrote:  
> > > On Wed, 16 Jul 2025 12:53:55 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:    
> > > > On Tue, Jul 15, 2025 at 08:55:35PM -0300, Gustavo Silva wrote:    
> > > > > On Tue, Jul 15, 2025 at 10:49:25AM +0300, Andy Shevchenko wrote:      
> > > > > > On Tue, Jul 15, 2025 at 10:37:22AM +0300, Andy Shevchenko wrote:      
> > > > > > > On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:      
> > 
> > ...
> >   
> > > > > > > > +/* 9.81 * 1000000 m/s^2 */
> > > > > > > > +#define BMI270_G_MEGA_M_S_2				9810000      
> > > > > > > 
> > > > > > > I thought this is MICRO...      
> > > > > > 
> > > > > > Btw, what if we use the device on poles and on equator (or even on orbital
> > > > > > station)? I'm wondering if this constant should be defined in units.h or
> > > > > > even in uAPI that user space may add a correction if needed.
> > > > > >       
> > > > > I certainly hadn't thought about these scenarios.
> > > > > FWIW, the accelerometer scale values also assume g = 9.81 m/s^2.
> > > > > For example, 0.000598 = 2 * 9.81 / 32768      
> > > > 
> > > > Right, but this should be supplied to user space somehow. OTOH the measure error
> > > > may be high enough (what is the precision of the measurements by the way?) that
> > > > it will neglect the differences in the 'g' constant.
> > > > 
> > > > All the details are given in [1].
> > > > 
> > > > [1]: https://en.wikipedia.org/wiki/Gravity_of_Earth#:~:text=The%20precise%20strength%20of%20Earth's,/s2)%20by%20definition.    
> > > 
> > > These sensors don't measure relative to g.    
> > 
> > What do they measure? Any links for me to study?  
> m/s^2 (well actually not, but they derive that from change in properties of a capacitor like structure as it bends under
> the force generated by the acceleration.  Which in the vertical direction is g if the device isn't moving.
> 
> https://www.analog.com/en/resources/technical-articles/accelerometer-and-gyroscopes-sensors-operation-sensing-and-applications.html
> looks good as an intro from a very quick glance.
> 
> >   
> > > That's annoying marketing which is why I held firm for m/s^2 for IIO :)
> > > So what they measure for a given acceleration does not change depending
> > > on where we are on earth. You should use a 'fixed' standard value for
> > > conversion from marketing values in g to m/s^2..    
> > 
> > Hmm... But shouldn't that marketing value be exposed to user space?  
> 
> yes, but its 9.81 where ever you are. Or whatever the datasheet says they use.
> These things are rarely that well calibrated, so the exact value gets lost in the
> errors!
> 
> Jonathan
> 
I got lost in this thread, so perhaps am assuming there is a v5 to come.

Maybe just send one anyway even if no changes as it'll jump up my list to look at.

Jonathan

> 
> 
> > 
> >   
> 
> 


