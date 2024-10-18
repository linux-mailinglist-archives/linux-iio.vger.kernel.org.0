Return-Path: <linux-iio+bounces-10739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237819A4561
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14A5281356
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC220403F;
	Fri, 18 Oct 2024 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaKPpL5R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCF8472;
	Fri, 18 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274546; cv=none; b=MAdScaSG/DhCluVRMfX23M88xdnKcFBGV/Gxe7ASN0WId+zWL0J1N6HxdSC59ZcTcH+SeiNS6oh84g/Y7XHW281wVCxailf8+UsxN5KLnHdbb++nyG5tpNHI9S0UgsxzvUG+T9IixJx8g2RxTFlH0iWEadtFNdwtZCjIoN6t5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274546; c=relaxed/simple;
	bh=P4W5WsJ7T2B5pGPBAwjLvDhq586dUwXIusTYcg05BAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfQ6fgxps1j1C8T8NXVb697Yw5d97z1p3YSC9hzjMNm1Jmys0Yf/dUxSSSUMEQ0Xh71Og1mIVvGjLy0n8rsMBngceCM5Z5bFiFK8gno0LNn50FKQljYCPrB89nHoVCJKygBcDEulHMpzC1LZntBnnzt9sUeidHHGmO8QOmb4E/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaKPpL5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D501CC4CEC5;
	Fri, 18 Oct 2024 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729274545;
	bh=P4W5WsJ7T2B5pGPBAwjLvDhq586dUwXIusTYcg05BAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TaKPpL5RiJjzjLlTZ1KgNmeEw+H17Vgja2H25r1k8HDDFIJtWMBl4qmIB3oyu6uhC
	 2d+iaqNI+kJvt9yZhTYlfF0KbDa5o4zIiJBzes594EBWMpYH45zAICa0QmLBSjyyWl
	 6B2xNabrclbuWEEWb3ZdHXUZGJrLNsqsLrr5Tke14PJYhbo5lzF15IQ5BTRDa+u9EH
	 bHYNxs43rqP0mC1HTf3L5isI9dpxu6TQPS7CKHmCY2uthlRF9Jx61CxnrB3QwUsfqP
	 /47ykukVrgZDYOi6ClXDCyXiSBUqVAnAIt6pUvWjhZctAMHDaE3DsgOZpjA8sqPMPH
	 qDqDZCyvZB0iQ==
Date: Fri, 18 Oct 2024 19:02:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 3/3] iio: imu: Add scale and sampling frequency to
 BMI270 IMU
Message-ID: <20241018190218.2e2c04ff@jic23-huawei>
In-Reply-To: <877ca8alnr.fsf@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-4-justin@justinweiss.com>
	<20241012123535.1abe63bd@jic23-huawei>
	<87jzecpvpd.fsf@justinweiss.com>
	<20241013164000.19087833@jic23-huawei>
	<87ttdfn2nr.fsf@justinweiss.com>
	<20241014201124.5621c4aa@jic23-huawei>
	<877ca8alnr.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 18:20:24 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Sun, 13 Oct 2024 13:55:36 -0700
> > Justin Weiss <justin@justinweiss.com> wrote:
> >  
> >> Jonathan Cameron <jic23@kernel.org> writes:
> >>   
> >> > On Sat, 12 Oct 2024 19:45:18 -0700
> >> > Justin Weiss <justin@justinweiss.com> wrote:
> >> >    
> >> >> Jonathan Cameron <jic23@kernel.org> writes:
> >> >>     
> >> >> > On Fri, 11 Oct 2024 08:37:49 -0700
> >> >> > Justin Weiss <justin@justinweiss.com> wrote:
> >> >> >      
> >> >> >> Add read and write functions and create _available entries. Use
> >> >> >> IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
> >> >> >> the BMI160 / BMI323 drivers.      
> >> >> >
> >> >> > Ah.  Please break dropping _FREQUENCY change out as a separate fix
> >> >> > with fixes tag etc and drag it to start of the patch. It was never
> >> >> > wired to anything anyway
> >> >> >
> >> >> > That's a straight forward ABI bug so we want that to land ahead
> >> >> > of the rest of the series.      
> >> >> 
> >> >> Thanks, I'll pull that into its own change and make it the first patch.
> >> >>     
> >> >> > Does this device have a data ready interrupt and if so what affect
> >> >> > do the different ODRs for each type of sensor have on that?
> >> >> > If there are separate data ready signals, you probably want to 
> >> >> > go with a dual buffer setup from the start as it is hard to unwind
> >> >> > that later.      
> >> >> 
> >> >> It has data ready interrupts for both accelerometer and gyroscope and a
> >> >> FIFO interrupt. I had held off on interrupts to keep this change
> >> >> simpler, but if it's a better idea to get it in earlier, I can add it
> >> >> alongside the triggered buffer change.    
> >> >
> >> > Ok. So the challenge is that IIO buffers are only described by external
> >> > metadata.  We don't carry tags within them.  Hence if you are using
> >> > either effectively separate datastreams (the two data ready interrupts)
> >> > or a fifo that is tagged data (how this difference of speed is normally handled
> >> > if it's one buffer) then when we push them into IIO buffers, they have
> >> > to go into separate buffers.
> >> >
> >> > In older drivers this was done via the heavy weight option of registering
> >> > two separate IIO devices. Today we have the ability to support multiple buffers
> >> > in one driver. I'm not sure we've yet used it for this case, so I think
> >> > there may still be some gaps around triggering that will matter for the
> >> > separate dataready interrupt case (fifo is fine as no trigger involved).
> >> > Looking again at that code, it looks like there may need to be quite
> >> > a bit more work to cover this case proeprly.
> >> >
> >> > We may be able to have a migration path from the simple case you have
> >> > (where timing is an external trigger) to multiple buffers.
> >> > It would involve:
> >> > 1) Initial solution where the frequencies must match if the fifo is in use.
> >> >    Non fifo trigger from data ready might work but we'd need to figure out
> >> >    if they run in close enough timing.
> >> > 2) Solution where we add a second buffer and if the channels are enabled
> >> >    in that we can allow separate timing for the two sensor types.
> >> >
> >> > This is one of those hardware features that seems like a good idea
> >> > from the hardware design point of view but assumes a very specific
> >> > sort of software model :(
> >> >
> >> > Jonathan    
> >> 
> >> Hm, that does sound tricky. If there's an example I can follow, I can
> >> make an attempt at it.  
> >
> > I don't think it ever got used for a device like this - so probably no
> > examples, but I might have forgotten one. (this was a few years back).
> >  
> >> Otherwise, if there's a change I can make now
> >> that would help with migrating in the future, I can do that instead.
> >> 
> >> Of the devices I've looked at, only one has had the interrupts usable
> >> and that one only had a single pin available.  
> > Lovely!  
> >  
> >> So if this change doesn't
> >> make it harder to add later if it's necessary, I would still be OK going
> >> without full support for now.  
> > I stopped being lazy and opened the datasheet.
> >
> > Hmm. We have auxiliary channels as well.  oh goody.
> > Considering just the fifo as that's the high performance route.
> >
> > Basically we can do headerless mode trivially as that's just one buffer.
> > (same ODR for all sensors).
> > We could do headered version but without messing with multiple buffers
> > that would be only when all sensors have same ODR (after a messy
> > transition period perhaps - that bit of the datasheet is less than
> > intuitive!) The reason we might do headered mode is to support the
> > timestamps but we can probably get those via a quick read of other
> > registers after draining the fifo.  
> 
> OK, that sounds good. It looks like the BMI323 driver approximates
> timestamps by slicing up the time period between the last flush and the
> current flush. It seems like that could also work.
> 
> If I understand it right, the simple way forward would be to use only
> the fifo watermark interrupt, to set the fifo to headerless mode, and
> only allow that buffer to be enabled when the ODR is the same between
> the accel and gyro sensors.
> 
> Since that sounds like a fairly independent change, I can hold it for a
> future patch, unless you think it belongs in this set.
Indeed fine to leave it as it stands for this series.
We've established a compatible path forwards if those features get added
so all looks good to me.

Jonathan

> 
> Thank you for the rest of the feedback and advice, I really appreciate
> it. I think I have enough for another revision soon.
> 
> Justin
> 
> > So I'm fine with just not supporting the weird corner cases unless
> > we get someone turning up who
> > a) cares
> > b) if foolish (or motivated) enough to do the necessary work 
> > c) (if they are lucky) we have the infrastructure in place because someone
> >    else needed the missing bits.
> >
> > Jonathan
> >
> >  
> >> 
> >> Justin  


