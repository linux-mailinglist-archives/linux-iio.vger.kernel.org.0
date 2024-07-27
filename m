Return-Path: <linux-iio+bounces-7960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1EE93DF3D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247AE1F224EA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EB26F06D;
	Sat, 27 Jul 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+dI+HLp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80811C83;
	Sat, 27 Jul 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722082537; cv=none; b=kM091eBBMUXyQ+gZHYQEoHiOjTsfShzu0z7YQJ0K293E+lk3604TP2k1DWyPljOznvgJ7m15ap6FafQfzp1tob8sPu6lznsgZX9AbTpbhazJEqQTsvJY5sAjdw4fHFlVAzM56PEJESGsN6XlRSbspO4KbKWN4eVBAZjff9pLMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722082537; c=relaxed/simple;
	bh=RkNV4TIuJeEznWhIML71pNK+ucVIMiyt6oztrCTx5qw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZev0AwNnHBqucplQK00LiYWlGEfquF3GpMxUmtndH8Yo++iaqSAFHvyi5gV4KpLHCNe2RejX1H4esXbwVWhutCk3AxZdt2KAvekb13s3PDc63QFQh85Q6oLtvTur2oL/ZHR4rt4f2otUCLwfnKjri02Ws9s8jkbfbuJfYXr960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+dI+HLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1C7C32781;
	Sat, 27 Jul 2024 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722082536;
	bh=RkNV4TIuJeEznWhIML71pNK+ucVIMiyt6oztrCTx5qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+dI+HLpX+5K2JrJPRyQ7pepv7HPUxIfODKxqSIFKpcmEXDVRbR9NAMWgsA8v7t1Z
	 dYDyZsg3DQQoAzB80YsiAwmO/lY2PFykJM4MwBU2Ex2mydEp1Ha1PQaCGelvbPQB36
	 QfbsmEG0y74htG6i7cA/7nDNgHRvpG/UgxinIv8eohZqJCb/EWROwBG3LQgvRi4qE8
	 GgUCnh5Y2d4WAwYSxJkFO+KtZBtDEdglY6oCAbtldrFuI5Y/8JysiAzbuxV7xz7bUW
	 cDAyVVRCPaRU1nkdDD0J5TZaCQJlwkU7qDP9InRgwiznFKMyQBc5leV8FeQ6BCpMvM
	 ZKA+719ZXk/sA==
Date: Sat, 27 Jul 2024 13:15:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/10] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240727131525.60950546@jic23-huawei>
In-Reply-To: <20240722203834.GA468105@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-10-vassilisamir@gmail.com>
	<20240720123727.7598111b@jic23-huawei>
	<20240721235113.GF325365@vamoiridPC>
	<20240722203138.07b21300@jic23-huawei>
	<20240722203834.GA468105@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 22:38:34 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Mon, Jul 22, 2024 at 08:31:38PM +0100, Jonathan Cameron wrote:
> > On Mon, 22 Jul 2024 01:51:13 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > On Sat, Jul 20, 2024 at 12:37:27PM +0100, Jonathan Cameron wrote:  
> > > > On Thu, 11 Jul 2024 23:15:57 +0200
> > > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > >     
> > > > > The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> > > > > a trigger for when there are data ready in the sensor for pick up.
> > > > > 
> > > > > This use case is used along with NORMAL_MODE in the sensor, which allows
> > > > > the sensor to do consecutive measurements depending on the ODR rate value.
> > > > > 
> > > > > The trigger pin can be configured to be open-drain or push-pull and either
> > > > > rising or falling edge.
> > > > > 
> > > > > No support is added yet for interrupts for FIFO, WATERMARK and out of range
> > > > > values.
> > > > > 
> > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>    
> > > > 
> > > > A few minor things inline.
> > > > 
> > > > It might be worth thinking a bit about future fifo support as that can
> > > > get a little messy in a driver that already supports a dataready trigger.
> > > > We end up with no trigger being set meaning use the fifo.  Sometimes
> > > > it makes more sense to not support triggers at all.
> > > > 
> > > > What you have here is fine though as we have a bunch of drivers
> > > > that grew dataready trigger support before adding fifos later
> > > > particularly as often it's a 'new chip' that brings the fifo
> > > > support but maintains backwards compatibility if you don't use it.
> > > >     
> > > 
> > > Hi Jonathan,
> > > 
> > > Thank you very much for your thorough review again!
> > > 
> > > What I could do to make the code even better to be able to accept
> > > FIFO irq support are the following:
> > > 
> > > 1) in the bmp{380/580}_trigger_handler() currently, the data registers
> > > are being read. What I could do is to move the reading of registers
> > > to a separe function like bmpxxx_drdy_trigger_handler() and calling
> > > it inside the bmp{380/580}_trigger_handler() when I have DRDY or
> > > sysfs irq. In order to check the enabled irqs I propose also no.2  
> > 
> > You shouldn't get to the trigger_handler by other paths.  But sure 
> > a bit of code reuse might make sense if fifo read out path is same
> > as for other data reads.  Superficially it looks totally different
> > on the bmp380 though as there is a separate fifo register.
> >   
> 
> So, I don't mean getting into the trigger_handler by other paths. I will
> always end up in the trigger_handler and then, depending on the interrupt
> that was triggered (DRDY, FIFO, etc...) I choose different actions.

Often the right thing to do for a fifo is to not use a trigger at all.
So instead it becomes the main interrupt handler that runs that path.
The reason being that triggers are typically one per 'scan' i.e. set of
channels and fifo interrupts are much less common.  That makes a mess
of things like timestamps etc that means different handling is necessary.
So for fifo paths we often just don't use a trigger.


> 
> > > 
> > > 2) in the following bmp{380/580}_trigger_probe() functions instead of
> > > just doing:
> > > 
> > >        irq = fwnode_irq_get_byname(fwnode, "DRDY");
> > >        if (!irq) {
> > >                dev_err(data->dev, "No DRDY interrupt found\n");
> > >                return -ENODEV;
> > >        }
> > > 
> > > I could also use some type of variable like we do for the active
> > > channels in order to track "active/existing irqs".  
> > 
> > I think there is only one IRQ on the 380 at least.  So
> > you should only request it once for this driver.  Then software
> > gets to configure what it is for.
> > 
> > However it shouldn't be called DRDY for these parts at least. It's
> > just INT on the datasheet.
> > The interrupt control register value will tell you what is enabled.
> > No need to track it separately.
> >   
> 
> So I am a bit confused. Indeed, BMP380 has only irq line. So I understand
> why I should call it INT. The actual IRQ inside the chip that will be 
> triggered needs to be configured by software. I do it through the
> bmp{3/5}80_int_config() function. How am I supposed to know
> which IRQ to enable? Options are:
> 
> 	a) DRDY only
> 	b) FIFO only
> 	c) both
> 
> How can I inform the driver about which to enable? Shouldn't this go
> through the device-tree?

No. This is a policy question for the driver, not something to do
with wiring (which is what belongs in device tree).
You choose how it is used based on what userspace configures the
device to do.

DRDY if it uses that trigger.  FIFO typically if the buffer is enabled
without a trigger (though we have a few cases where a dummy trigger
is used for this).  


> 
> > If you mean track the one from the poll function registered for
> > handling triggers - that's an internal detail but you would indeed
> > need to track in your data structures whether that's the trigger
> > currently being used or not (easy to do by comparing iio_dev->trig
> > with a pointer for each trigger in iio_priv() data - so should be no
> > need for separate tracking.
> >   
> 
> My idea is that there is one trigger_handler which inside you check
> which interrupt triggered and you choose which path to choose. If that's
> wrong, do you know any specific driver that implements it in the correct
> way? Because in my mind, the iio_dev->trig is one and just inside the
> handler, different functions are called.

You don't have to use a trigger.  Just look for drivers that handle
a fifo. This is pretty common situation and there are a couple of
different solutions but often the cleanest is to not use the
trigger infrastructure at all if the fifo is in use.

Jonathan

> 
> > Jonathan
> > 
> >   
> 
> Thanks for the feedback :)
> 
> Cheers,
> Vasilis
> 
> >   
> > > 
> > > Like this it would be easier to track the active irqs of the sensor.
> > > 
> > > Let me know what you think, or if I manage to have time I might send
> > > a v2 with those changes even earlier :)
> > > 
> > > Cheers,
> > > Vasilis
> > >   
> >   


