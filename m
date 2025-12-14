Return-Path: <linux-iio+bounces-27078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE5CBBC7B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 16:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88B743003167
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0EE2BD586;
	Sun, 14 Dec 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYv2wafo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB719AD8B
	for <linux-iio@vger.kernel.org>; Sun, 14 Dec 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765725938; cv=none; b=cMNLxA/Cluo4wWuTsNL7KHhoSu/CViIwql/L6R4IoFRGh1iqFzHCMQ4QSKdbAey3zsvCOi3p6CYlAG9UgTl4EGWqfbF1JfMeDIWZ09yH3+mnZR0YBauk9KZzl0jNx0hDZNncjAydIHG4Z1BckFF4OutdhqMv3FaHd5e+E+1mGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765725938; c=relaxed/simple;
	bh=pFvKN/2jQW9UdVXfJnQ+jONq6Ux0L+i2+gnQL6cHjJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3U0pTGDGrP75J+8l0GDKEsMQt24r8GYSl0fj1yUh/hz7JHjeo9YNOcsutZQ9ZSI0MOYTdnoXHD4wn6QDscSTEuK+BtXJl7i36aBVAlzUGAzgMhgn4E+ZUTbLSAzMuRiqQFKsTseqGgfvr0gBDeWIOFS+I2kst9aso9p87ycHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYv2wafo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7D7C4CEF1;
	Sun, 14 Dec 2025 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765725937;
	bh=pFvKN/2jQW9UdVXfJnQ+jONq6Ux0L+i2+gnQL6cHjJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYv2wafoaI4Gc+ulqDHPq9CcLvai1HbaojLydUGg/DTHT38WsD4YZMhoIV45bt96Z
	 ycFCLg1qZ7KHHVsE9GAqTJw0dc5qruwnzQYhNfL4Mbry38diHIdnmsFMIAtxW3Vs9X
	 6kDvrYTQsualM1iKR7C+kdLLvkVD2fj9D9lj+VS+qQcr02V3eZVMW0hGJD8FyEBGvU
	 HFgU4nl/tkj4VGDz2isZAxfo9HTmhLue+EMaBIJ5JYAfmhNdRo2LFRcB2KVYgjtPwB
	 BCHzJHKxj1uCY9W9SeUziS02V+yYIgomq7gDGpjdzqVWXe+VLugjjcVTHiwwK/7Hgw
	 Pdysvgi3jn2Ag==
Date: Sun, 14 Dec 2025 15:25:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] ad9832: driver cleanup
Message-ID: <20251214152531.52716b77@jic23-huawei>
In-Reply-To: <aTbwmynIVfIbGWJ7@Lewboski.localdomain>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
	<20251206160933.46d45e5f@jic23-huawei>
	<aTbwmynIVfIbGWJ7@Lewboski.localdomain>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Dec 2025 12:36:59 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> On Sat, Dec 06, 2025 at 04:09:33PM +0000, Jonathan Cameron wrote:
> > On Fri,  5 Dec 2025 17:27:40 -0300
> > Tomas Borquez <tomasborquez13@gmail.com> wrote:  
> 
> Hey Jonathan, thanks for all the feedback!
Hi Tomas,

You are welcome.
> 
> > Opening question for a cleanup of a driver like this is how you plan
> > to test it. Do you have the hardware, or are you emulating / stubbing
> > functions to test it? It is very brave to take on major refactoring
> > without a good way to test.
> > 
> > I was kind of planning to drop this driver this cycle on basis of no
> > interest in sorting it out, but clearly you are interested so great
> > as long as we can be sure it works well after your work on it
> > (or indeed that it works currently!)  
> 
> I don't have the hardware, so I've been testing with a stubbed SPI layer.
> I created a platform device wrapper that registers the IIO device without
> real SPI and replaced spi_sync() with a function that dumps the TX buffer
> via print_hex_dump() which allows me verify the register protocol against
> the datasheet, I validated:
> 
> - Frequency tuning word calculation (32-bit, formula from datasheet)
> - Phase register writes (12-bit values across two transfers)
> - Control register state machine (SLEEPRESCLR, FPSELECT commands)
> - Proper preservation of ctrl_fp bits when updating freq_symbol vs
> phase_symbol independently
> - Input validation (bounds checking on phase/frequency values)
> 
> All the SPI command bytes match what the datasheet specifies. Obviously
> this can't catch electrical issues or timing problems that would only show
> up with real hardware but it does verify the driver's logic and register
> protocol are correct.
> 
> I also ran it through sparse, smatch, and checkpatch with no warnings.
> I can share the test module + logs if that's useful for review.

Fair enough.  That's a laborious solution but if you are willing to
do it I'm not complaining!


> 
> ...
> 
> > > 2) Scale Attributes
> > > 
> > >    The frequency scale is 1 Hz and phase scale is 2*PI/4096 radians.
> > >    I cannot use info_mask_shared_by_type for IIO_CHAN_INFO_SCALE because
> > >    all channels share IIO_ALTVOLTAGE.
> > > 
> > >    So instead I'm using IIO_CONST_ATTR for the scales:
> > > 
> > >      out_altvoltage_frequency_scale = "1"
> > >      out_altvoltage_phase_scale = "0.0015339808"
> > > 
> > >    Is there a better approach here? Or should I just document the units and
> > >    skip scale attributes entirely?  
> > 
> > Good question.  I think right option is to just do the maths in the driver and
> > have out_altvoltage0_frequencyN take the scaled value rather than the register
> > value.  Then do some fixed point maths to get to the required register value.  
> 
> Which is already done in write_frequency(), should I do it with phase too?

yes

> And should I accept radians or microradians?

Radians.  It's in Documntation/ABI/testing/sysfs-bus-iio

The whole odd units of a few basic channel types was a long ago
misconceived attempt to align with hwmon.  If I could go back and change that
everything would be in the basic SI units,  not millivolts etc.
> 
> ...
> 
> I've been working on v2 based on your ABI feedback. If the testing approach
> sounds acceptable I'll send it out and if someone with hardware wants to
> test it, that would be great.

Sounds good to me.  Analog Devices folk: Is anyone able to get their hands
on one of these?

Thanks,

Jonathan

> 
> ...
> 
> Tomas


