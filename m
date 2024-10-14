Return-Path: <linux-iio+bounces-10580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ECA99D70A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45E31C22885
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1A1CB529;
	Mon, 14 Oct 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL/bS+0z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237B1CB317;
	Mon, 14 Oct 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933091; cv=none; b=JAfOKHzOeQdgPUzmV7jwxRYwY/e2txOrU0x9yDJM2WHYssbFoyAH3d88rEYo5OdNF7H0gXgg5ElvZwgifgkrLDtCKw57w1lwIRa29T+9hVmT7ZezTb/sKHNqRCnSRigFRnjeL3vwaIuof+FFF+6brmzGTUNcnoYgbsq4qHbC/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933091; c=relaxed/simple;
	bh=QH4aG1NnqGam4iwN7T37IahTXtsCUUsMTD/WBrPMO2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca8IWJau+3RM0SplqUNZW7lD+iHSxlYcOFtTqmlM79qOTK9il+dO+wFk8g3Z98QQ96vqxomxJnnCtdajBrA3KKku5QNFBdLMBmG79/KYr4NRN4d+LhOCisbWWqyqBtlDWanJrt0i4TaMxhJn+5SBQBzVIpyKli/r4r3nRlIDpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL/bS+0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1A0C4CEC3;
	Mon, 14 Oct 2024 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933090;
	bh=QH4aG1NnqGam4iwN7T37IahTXtsCUUsMTD/WBrPMO2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WL/bS+0zRqv27kx/DivpZ3MlxGTw2TuSHHSA1qE4dhpyH7b7JfO3PEHM/NS4hu2ve
	 Bu2/qkWFbVIR+W1AxwY3WvTia+oxsInf1ilp4d2WudHEjvw1Zv5EucyWxjyqMiRRr1
	 lSgzIuGtLAEAmt6f+t91qbm8GdUVklmFR5/7sNBCFsjUF6tqE0bBgB3g1SyXtFRH7u
	 e65E0Ndfy99qq+pH8CMasosZlFUX4+DlgPKv+n85BimT7EoczVtlLSJZgEA+HD9aIG
	 w0DsZ3igWGfb68+laMFBw9wCxFmXRXL4J93HYjq/w0nFye3GbZvsebdGFe+Oxq1A4b
	 50yWHyXGhCIXw==
Date: Mon, 14 Oct 2024 20:11:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 3/3] iio: imu: Add scale and sampling frequency to
 BMI270 IMU
Message-ID: <20241014201124.5621c4aa@jic23-huawei>
In-Reply-To: <87ttdfn2nr.fsf@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-4-justin@justinweiss.com>
	<20241012123535.1abe63bd@jic23-huawei>
	<87jzecpvpd.fsf@justinweiss.com>
	<20241013164000.19087833@jic23-huawei>
	<87ttdfn2nr.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 13:55:36 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Sat, 12 Oct 2024 19:45:18 -0700
> > Justin Weiss <justin@justinweiss.com> wrote:
> >  
> >> Jonathan Cameron <jic23@kernel.org> writes:
> >>   
> >> > On Fri, 11 Oct 2024 08:37:49 -0700
> >> > Justin Weiss <justin@justinweiss.com> wrote:
> >> >    
> >> >> Add read and write functions and create _available entries. Use
> >> >> IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
> >> >> the BMI160 / BMI323 drivers.    
> >> >
> >> > Ah.  Please break dropping _FREQUENCY change out as a separate fix
> >> > with fixes tag etc and drag it to start of the patch. It was never
> >> > wired to anything anyway
> >> >
> >> > That's a straight forward ABI bug so we want that to land ahead
> >> > of the rest of the series.    
> >> 
> >> Thanks, I'll pull that into its own change and make it the first patch.
> >>   
> >> > Does this device have a data ready interrupt and if so what affect
> >> > do the different ODRs for each type of sensor have on that?
> >> > If there are separate data ready signals, you probably want to 
> >> > go with a dual buffer setup from the start as it is hard to unwind
> >> > that later.    
> >> 
> >> It has data ready interrupts for both accelerometer and gyroscope and a
> >> FIFO interrupt. I had held off on interrupts to keep this change
> >> simpler, but if it's a better idea to get it in earlier, I can add it
> >> alongside the triggered buffer change.  
> >
> > Ok. So the challenge is that IIO buffers are only described by external
> > metadata.  We don't carry tags within them.  Hence if you are using
> > either effectively separate datastreams (the two data ready interrupts)
> > or a fifo that is tagged data (how this difference of speed is normally handled
> > if it's one buffer) then when we push them into IIO buffers, they have
> > to go into separate buffers.
> >
> > In older drivers this was done via the heavy weight option of registering
> > two separate IIO devices. Today we have the ability to support multiple buffers
> > in one driver. I'm not sure we've yet used it for this case, so I think
> > there may still be some gaps around triggering that will matter for the
> > separate dataready interrupt case (fifo is fine as no trigger involved).
> > Looking again at that code, it looks like there may need to be quite
> > a bit more work to cover this case proeprly.
> >
> > We may be able to have a migration path from the simple case you have
> > (where timing is an external trigger) to multiple buffers.
> > It would involve:
> > 1) Initial solution where the frequencies must match if the fifo is in use.
> >    Non fifo trigger from data ready might work but we'd need to figure out
> >    if they run in close enough timing.
> > 2) Solution where we add a second buffer and if the channels are enabled
> >    in that we can allow separate timing for the two sensor types.
> >
> > This is one of those hardware features that seems like a good idea
> > from the hardware design point of view but assumes a very specific
> > sort of software model :(
> >
> > Jonathan  
> 
> Hm, that does sound tricky. If there's an example I can follow, I can
> make an attempt at it.

I don't think it ever got used for a device like this - so probably no
examples, but I might have forgotten one. (this was a few years back).

> Otherwise, if there's a change I can make now
> that would help with migrating in the future, I can do that instead.
> 
> Of the devices I've looked at, only one has had the interrupts usable
> and that one only had a single pin available.
Lovely!  

> So if this change doesn't
> make it harder to add later if it's necessary, I would still be OK going
> without full support for now.
I stopped being lazy and opened the datasheet.

Hmm. We have auxiliary channels as well.  oh goody.
Considering just the fifo as that's the high performance route.

Basically we can do headerless mode trivially as that's just one buffer.
(same ODR for all sensors).
We could do headered version but without messing with multiple buffers
that would be only when all sensors have same ODR (after a messy
transition period perhaps - that bit of the datasheet is less than
intuitive!) The reason we might do headered mode is to support the
timestamps but we can probably get those via a quick read of other
registers after draining the fifo.

So I'm fine with just not supporting the weird corner cases unless
we get someone turning up who
a) cares
b) if foolish (or motivated) enough to do the necessary work 
c) (if they are lucky) we have the infrastructure in place because someone
   else needed the missing bits.

Jonathan


> 
> Justin


