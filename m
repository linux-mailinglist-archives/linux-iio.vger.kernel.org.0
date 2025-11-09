Return-Path: <linux-iio+bounces-26056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65131C43DD7
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915DC1883EA6
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7E2EC55B;
	Sun,  9 Nov 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hujg0fN2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730E2E975A;
	Sun,  9 Nov 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692092; cv=none; b=YtW4n9QQ8pSobrA5+z5QBcmdMX0I/c9TCgrPz8owoIsqUS18EBr1f8HobIiPtRetTzww4EBz6h6EuDLpm/zT3u69xzkVIGL+KBWANaK6g0xHA0kfA9/GuBY3lHjDqoV4pDc7CxzKjR7DFrZnPgnEYlgq0cGUCLR8YboqTKiHx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692092; c=relaxed/simple;
	bh=D2fO6b+7RL/6aN1x3OLkpblQOqizg946JOHiToqSI74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dniZS3fgcH28qZQv3G2vJaN0p80F3N+MoHaQNci6RMZI2UKzvqoY9C0LrrQw+mRR2bP1C6k7aU1rtZJe58p3xu6wnmItoOuySl954UBWW4HSIfLtxB19mQpy4rSSVA5so8WxTr5VNbQR3t1eGNNd75ELml5EareoOEHjpVodV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hujg0fN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC7DC19421;
	Sun,  9 Nov 2025 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762692091;
	bh=D2fO6b+7RL/6aN1x3OLkpblQOqizg946JOHiToqSI74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hujg0fN2+wBri0RREM3ucP+P8THVVeg3BCQcyEbRCRvCYSjbgNQutSnD7IXEV+ZxW
	 JCGcFBMQFWZTIbPkeSiO0eSXYaSaC9mHT3/kIDWxp9BANxF4hHfCrj9MX3qwVSD3tq
	 lR/RhZyD5IMnKKBeouwO0nzHhNC3oXhOA2x/rNk7ObogG2tuYh4Z/95pPTvvUIDGJW
	 /PWDlAwhUPdAZxFaBxzDvYR8Vm1VnAwqM0BrPiyfk1tN2hxE2jcN3d1VeUx8jpYg5U
	 cflBwc2xQCbiGsQL1gPAcmcM1SrKE5AyLzWdlu6j7s5cOEsawAuIIF8NNCqXtp7BgZ
	 KRDvhjHdgvyHg==
Date: Sun, 9 Nov 2025 12:41:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jagath Jog J
 <jagathjog1996@gmail.com>
Subject: Re: [PATCH 3/6] iio: accel: bma220: add tap detection
Message-ID: <20251109124125.2ab0d432@jic23-huawei>
In-Reply-To: <aQ09qTYr0gqlb0If@lipo.home.arpa>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-3-153424d7ea08@subdimension.ro>
	<20251018181632.76851d4e@jic23-huawei>
	<aQW9OnJSrOzn_Sws@lipo.home.arpa>
	<20251102122053.49ee2632@jic23-huawei>
	<aQ09qTYr0gqlb0If@lipo.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 02:30:33 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> On Sun, Nov 02, 2025 at 12:20:53PM +0000, Jonathan Cameron wrote:
> > On Sat, 1 Nov 2025 09:56:42 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Hello Jonathan,
> > > 
> > > thank you for the review.
> > > 
> > > On Sat, Oct 18, 2025 at 06:16:32PM +0100, Jonathan Cameron wrote:  
> > > > > +			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
> > > > > +			if (ret)
> > > > > +				return ret;
> > > > > +			*val = FIELD_GET(BMA220_TT_DUR_MSK, reg_val);    
> > > > 
> > > > This needs to be in second if you are using duration. Is the register really in seconds?    
> > > 
> > > this IC has a very small number of bits that configure
> > > duration/hysteresis/threshold levels. it's between 2 and 6 for each
> > > of them. in the case of high and low G events the duration is not
> > > even directly defined as a time interval, but as a count of samples
> > > that are over a threshold value.  
> > 
> > The ABI is in seconds, so you have to deal with scaling wrt to the sampling
> > frequency at the time.  I know it can be a pain to do, but consistent userspace
> > is the aim and so we need to match the ABI.  
> 
> on this bma220 chip, when someone modifies the cut off frequency of the
> filter then the ic automatically adjusts the sampling rate. and this 
> sample rate is not exposed on any of the registers.
> since duration parameters are defined as a count of samples 
> and the sample rate looks to be unknown I don't see how I could
> adapt to an API that is based on a unit of seconds.

Does the datasheet document that relationship? Table 4 on the datasheet I looked
at to seems to give settling time but I think is only relevant to low power
modes that might not apply here.

Would be very odd if there is no way to establish the sampling frequency from
the settings configured.

> 
> > > I was hoping that simply passing along a unitless value between 0 and
> > > parameter_max would be enough to customize all the event parameters.
> > > this does mean that the driver makes the assumption that the user is
> > > familiar with the device datasheet and knows the number of bits every
> > > parameter has been allocated. should the driver provide a conversion
> > > table for tt_duration just like for _scale_table and
> > > _lpf_3dB_freq_Hz_table?  
> > 
> > Exactly.  
> 
> I was thinking today of a more analog-feeling API, one in which a variable that can take values linearly between min and max can be set to a percentage of it's scale. think of stereo systems - most of us don't want to set a precise amount of decibels of attenuation when operating the volume knob, we just want to set it lower or higher until a condition matches. in this API the primary unit of measurement would not be dBs but notches or ticks - calculated based on min, max and the native resolution of the control (how many bits are allocated for it in the ic's memory map). this has also the benefit of translating nicely when the control is rendered as a widget in a GUI. think about a 0 to 11 volume knob.
> is there anything like this already implemented? is there any merit to this idea?

ABI is fixed the day it is defined and I'm not keen to have what sounds like
a duplicate ABI.  We also need to if even vaguely possible have consistency across sensors.
If you do it on basis of range set, and one sensor oddly provides twice the range
of another, then a 5 on one is a 10 on that other.

Hence the only things where we can do this sort of percentage thing are where
the thing being controlled is a unit less ratio and hence a percentage type
control is the only possible units.

Thanks,

Jonathan


> 
>  I will shelve the event part of this driver for another time, just got some Honeywell pressure sensors that need a new driver.
> 
> best regards,
> peter


