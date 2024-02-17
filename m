Return-Path: <linux-iio+bounces-2716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57A1859147
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 18:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84611C215D3
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723C7D404;
	Sat, 17 Feb 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODrQv4Ai"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7B79929
	for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708189717; cv=none; b=u7HeR6sidZRGuRXSkEljzJ51J+fqpgV6qP01zmHVzINav/0tiWT54Nzivek6OUIxxrmIxxETUP8EroKcRlLFUvjh3jRKc2bb512LO3kCeZa393Od3oWb6/RePeK/T7n7kpHG/XK8ByzNfwLiWYQFJ/zzZGE/N5zvJ8R8aala/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708189717; c=relaxed/simple;
	bh=Vvah6my32Y3V9hnSfvECT356dYfd2piQf14ayGMQW0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uruCbDy3BzKCTHxd+6dEr6Fil+71UBld3wF5zOM64h0J48aG018E4finxHteMulMGgkTDSTNgheeCThFLA6R/fUMab3zS41ARlJijrAErWa70cilg9eM6PRyM28sppkbD84/gwFuaYfGu194Rmveqz3uRQ+E9rzjle+b7JI+d5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODrQv4Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082A7C433F1;
	Sat, 17 Feb 2024 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708189716;
	bh=Vvah6my32Y3V9hnSfvECT356dYfd2piQf14ayGMQW0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ODrQv4Aiq2nxu5FAZDj0v++JZzEdH7K1fZCGSPF/AxD1OLbTJ6VAdm6mCJa5Gswzj
	 XHF2UCPBRnmvt54pc/eFNahIylQVbizw0K0skSSKUk8CQFPQTdbnAF6iAQtt9GgH+o
	 JjUsD9Uo+zHsPC5h5qTzXfjziAQUilRWJyEMYnm4GIHzMVePf7VORPlN55f15L3+pV
	 UffoW9buw9Mq+wiZUQJJ/1W18ekoVRKvR+TmxHUwdiRJJ8iwMLank0KyHPiSHspl8b
	 xEqHxiY3ZhR1aH3ie+geCv+f/xxNeBHvrrMPvptNuAhdy5+vtXQmej7uZ28BYjrm1L
	 AFj+/BSqOC0rA==
Date: Sat, 17 Feb 2024 17:08:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jeremy Mattfeld <jmmattfeld@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: multiple iio_devices, one shared GPIO iio_trigger
Message-ID: <20240217170825.65c2b704@jic23-huawei>
In-Reply-To: <CABbzQ=f2mUCeUE5fBz=4A3yivLwZZOMwqt8SVHSUeNtZDEqw-Q@mail.gmail.com>
References: <CABbzQ=f2mUCeUE5fBz=4A3yivLwZZOMwqt8SVHSUeNtZDEqw-Q@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 18:12:37 -0800
Jeremy Mattfeld <jmmattfeld@gmail.com> wrote:

Hi Jeremy,

The answer will get a bit complex because there are various things you
could do - but the simple one is that you use the dataready trigger from
one device (don't describe interrupt line for the others in DT) and
then set the current_trigger value for all of them to point to that
single trigger.  The rest of my reply should give more detail + talk
about other options.

> I have a hardware design using a TI-AM335x cpu connected over a SPI
> bus to 4 AD7779 adc's. 

Is this a new driver?  Also I note the device supports SPI daisy chaining
which typically makes a set of devices behave more or less like one
bigger device - so that might be worth considering.

>I want to use the DRDY_N signal (I have it
> connected to the GPIO on the AM335x) from one of the adc's to generate
> an interrupt to trigger reads on all four.  I have seen several places
> in the documentation that states that this is possible (common even)
> but I have not seen examples of it in the kernel tree.

With a few caveats most IIO drivers that support buffers do this and it
should work with most triggers. Note though that there is a config
variable controlling how many devices can use a single trigger:
CONFIG_IIO_CONSUMERS_PER_TRIGGER so for you case case that would need
to be at least 4.  Drivers that don't support this will have *validate*
callbacks (in either or both directions - triggers can be limited to
only triggering one device, often when the signal is internal, devices
can be limited to only their own triggers, often when there is some
complex interaction that makes a more independent model complex).


If you only had one interrupt actually wired then what you do is simply set
iio\:device0/current_trigger to the trigger and
iio\:device1/current_trigger etc to the same trigger.

For each the pollfunc would then be called to collect the data and push it
to the independent buffers for each driver instance.  Then you would need
to align the resulting data in userspace.

>  Most of the
> drivers from ADI request an IRQ along with allocating and registering
> their own iio_trigger.  When binding multiple instances of the same
> iio device driver, the first IRQ request succeeds, while subsequent
> requests will return EBUSY.

So on to the other options:

A driver can support a shared interrupt (grep IRQF_SHARED). There are
some drivers in IIO that do this - usually because someone had a board
where mutiple different devices were wired up to a shared interrupt pin.

Modifying a driver to do this isn't that hard as long as the device
has a register that indicates new data (in addition to the dataready
interrupt).  Otherwise we have no idea if it was our interrupt or not.
I took a quick look at the datasheet and can't see that here.
Given there is also no way to disable the drdy line that I can see
you definitely want to only register the interrupt for one of them
(or not share lines but then this question would be odd :)



> 
> Is the correct way to accomplish this to define all my SPI slave nodes
> in my devicetree with just one having an interrupts and use
> conditional logic in the driver to only have that one request the IRQ?

Yes, just describe the interrupt once (and hopefully that is valid as you
only wired one up - otherwise you are likely to get spurious interrupts
given we can't turn off the drdy interrupt - or at least a quick search
didn't show me how).

>  Another method would be to use the standalone trigger driver (I have
> enabled in Kconfig) but I have not been able to find documentation
> that shows the devicetree binding for standalone triggers for GPIO
> interrupts.

There isn't a DT binding for the standalone GPIO trigger. We'd welcome
one though if you want to add support but I don't think you need to
here and generally we don't want to do that if a it's not coming from
independent hardware.  So might work, but it's not a clean solution.

Hopefully that gives you an idea where to start.

Jonathan



> 
> Any guidance would be appreciated.
> 
> Thanks,
> 
> Jeremy
> 


