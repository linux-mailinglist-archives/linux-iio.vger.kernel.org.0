Return-Path: <linux-iio+bounces-10503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C999B4C0
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FE41F22021
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B116DEA7;
	Sat, 12 Oct 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPY/X5KS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D312145A19;
	Sat, 12 Oct 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734971; cv=none; b=cGsU1zI5AgoaT4Re6aLhjuF7God8vIw9eqyt2iC1yfNhSC/HhsKiCMydT4+R9lUceY/YdEVvxsZ3mviRrculOJ71VRLslMEkxNxrQ5t9Z53gJGSk7L9KdnI16uKV+ZRp5Upkf9ceUlwbUPZHUEUxzm2VRNaIOn/BP5zC/8s4yrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734971; c=relaxed/simple;
	bh=Zs+3S7uhMXlk++Si7vaGGaF2OHG/6Z9jr4O2PNgIvx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Arh9qGetR9IyJIzEkjJP8eG8dOhbnadrme454mCN/xMeFyZjonNZb10aXkVbBVNz143oT72gS7AklM+PJTDBQTKK4E9lI2UX3omHjvGFANAQxpcYQdGbALKAFHhX5T4lzUMlTRokpEn4UM6VpsYqw+M6wBrQzeed5pMFjfj7i4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPY/X5KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD70AC4CEC6;
	Sat, 12 Oct 2024 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728734970;
	bh=Zs+3S7uhMXlk++Si7vaGGaF2OHG/6Z9jr4O2PNgIvx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VPY/X5KSHDVdDnuXbLy3WvSNphh2y3w29GPfXcXWRKN9G2psBlc5y1dh33vCe7hE6
	 77IjhS1DYqR1hfb/xdV/1dZMXf1Gsf20aOHC8ENYumz/0uuSpQZQciC55LuXSvtKXp
	 JIZOkuSH52LUK17Kv+ViMTb7Stcnrz58QnPm9BO9/phFqgFl+30qdT5oofYcOBVd91
	 baY4irtFPzscretLdShoO3OCYdBJJUePCM26o0OhNZlzFokYFZxWJXxy7bf6zS6szy
	 k7npbAln/wfnOdNuMSN3aelPVan5xQR0LB02XfO1Sx7LM/7SMJt/Gn2Wm0uRj/Vfyq
	 WBVWIo2G0sYcw==
Date: Sat, 12 Oct 2024 13:09:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/13] iio: chemical: bme680: Add triggered buffer
 support
Message-ID: <20241012130922.167cbd7b@jic23-huawei>
In-Reply-To: <20241012130402.450b7181@jic23-huawei>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-13-vassilisamir@gmail.com>
	<ZwkABN9RycsVPRwo@smile.fi.intel.com>
	<Zwl3aBDFiLN9b0TK@vamoirid-laptop>
	<20241012130402.450b7181@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 13:04:02 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 11 Oct 2024 21:07:20 +0200
> Vasileios Aoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Fri, Oct 11, 2024 at 01:37:56PM +0300, Andy Shevchenko wrote:  
> > > On Thu, Oct 10, 2024 at 11:00:29PM +0200, vamoirid wrote:    
> > > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > 
> > > > Add triggered buffer and soft timestamp support. The available scan mask
> > > > enables all the channels of the sensor in order to follow the operation of
> > > > the sensor. The sensor basically starts to capture from all channels
> > > > as long as it enters into FORCED mode.    
> > > 
> > > ...
> > >     
> > > >  	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
> > > >  	int ambient_temp;
> > > >  
> > > > +	u8 buffer[ALIGN(sizeof(s32) * BME680_NUM_CHANNELS, sizeof(s64))
> > > > +		  + sizeof(s64)] __aligned(sizeof(s64));    
> > > 
> > > Can it be represented as a structure?
> > > We also have aligned_s64 for the timestamp.
> > >    
> > 
> > Hi Andy,
> > 
> > The same approach was used also for the bmp280 driver and since I was
> > working on the bmp280 as well, I did it here. You think the
> > representation as a struct would look better? Personally I like the
> > nature of this one because of the ALIGN() but I have no problem of using
> > a struct here.  
> 
> Depends if you can enable sufficiently few channels that the timestamp
> moves.  If that is the case, a structure is missleading as a representation
> of this buffer so I prefer the above fun as it doesn't give the wrong
> impression (by giving no impression at all of the data layout!)
Looks like you always write them all to the buffer. So structure indeed
appropriate here. (I should have read the code before commenting!)

J
> 
> Jonathan


