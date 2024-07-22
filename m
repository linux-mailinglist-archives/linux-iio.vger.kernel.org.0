Return-Path: <linux-iio+bounces-7795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ECA939444
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 21:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EBA281CFB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ADE16FF4E;
	Mon, 22 Jul 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9/eurte"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF61BF54;
	Mon, 22 Jul 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676707; cv=none; b=kHc+IUmbsM5NLkV+ZLthFkwO3eFsnwh25RUFX+oxN+oDKHCC6hN8JPUbM5ekBFYwFumpIXu9BOAGqu4dJRERDr8nmRGmlEkSIiq2LJmZR2kUTFbAOhuYtjD3mn20iZHGFuuWNxQrkjA+/BKDRWFNiRXzRYENwmhyY+K7dKU5LNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676707; c=relaxed/simple;
	bh=nOkianMfG51fZ7daP0B6sbT+2LRI82yJDL+2nROUjfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFHqLxM4buQZJA8NvqYxbr5vz1etuRyIEVSbEJ1bm+qz7NqVNSSKouZE8XQ2dBUdRsDTq6L79I0fKb9b+gqkhtGob4SrCmFu1O6Cn+XEkWJbmcJR8kV7KIKHhnBNmjocu/wkhz999M+VACtqeqyY0wE5L4wFWYTLMr3viPXCcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9/eurte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822C6C116B1;
	Mon, 22 Jul 2024 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676706;
	bh=nOkianMfG51fZ7daP0B6sbT+2LRI82yJDL+2nROUjfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P9/eurteHWd0SwwNW4GmC9u4vw7sDve5Sq8nknbULRB+AtZM0o5mqlQWwBPIpCN9f
	 yrtnw8B8j0TSC6JmL2UeT42qVpnLuHAwV/Z4WdwTJ21fZEfhR1Ao+ils/OLQxkoSlQ
	 i0djSQlzZp+sWegfDkqz8EY700DD1B0KgpFJMFv+RNmGNJ+vCFdk0PywNyd5fbGlET
	 hjnZGvUNVsB9wKc40tqSZpgKgjIdj2RZ4nhpzTRRIq2Ypy953dqafxzsqAPpyPc9Ef
	 inZ/bG/zLo0NtzbtATSdZpleL3/XIDjPl7v4OVUD1EvB+slDWal8HIUqkv4AMC7hA3
	 ZA5311xZLysNw==
Date: Mon, 22 Jul 2024 20:31:38 +0100
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
Message-ID: <20240722203138.07b21300@jic23-huawei>
In-Reply-To: <20240721235113.GF325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-10-vassilisamir@gmail.com>
	<20240720123727.7598111b@jic23-huawei>
	<20240721235113.GF325365@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 01:51:13 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sat, Jul 20, 2024 at 12:37:27PM +0100, Jonathan Cameron wrote:
> > On Thu, 11 Jul 2024 23:15:57 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> > > a trigger for when there are data ready in the sensor for pick up.
> > > 
> > > This use case is used along with NORMAL_MODE in the sensor, which allows
> > > the sensor to do consecutive measurements depending on the ODR rate value.
> > > 
> > > The trigger pin can be configured to be open-drain or push-pull and either
> > > rising or falling edge.
> > > 
> > > No support is added yet for interrupts for FIFO, WATERMARK and out of range
> > > values.
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > 
> > A few minor things inline.
> > 
> > It might be worth thinking a bit about future fifo support as that can
> > get a little messy in a driver that already supports a dataready trigger.
> > We end up with no trigger being set meaning use the fifo.  Sometimes
> > it makes more sense to not support triggers at all.
> > 
> > What you have here is fine though as we have a bunch of drivers
> > that grew dataready trigger support before adding fifos later
> > particularly as often it's a 'new chip' that brings the fifo
> > support but maintains backwards compatibility if you don't use it.
> >   
> 
> Hi Jonathan,
> 
> Thank you very much for your thorough review again!
> 
> What I could do to make the code even better to be able to accept
> FIFO irq support are the following:
> 
> 1) in the bmp{380/580}_trigger_handler() currently, the data registers
> are being read. What I could do is to move the reading of registers
> to a separe function like bmpxxx_drdy_trigger_handler() and calling
> it inside the bmp{380/580}_trigger_handler() when I have DRDY or
> sysfs irq. In order to check the enabled irqs I propose also no.2

You shouldn't get to the trigger_handler by other paths.  But sure 
a bit of code reuse might make sense if fifo read out path is same
as for other data reads.  Superficially it looks totally different
on the bmp380 though as there is a separate fifo register.

> 
> 2) in the following bmp{380/580}_trigger_probe() functions instead of
> just doing:
> 
>        irq = fwnode_irq_get_byname(fwnode, "DRDY");
>        if (!irq) {
>                dev_err(data->dev, "No DRDY interrupt found\n");
>                return -ENODEV;
>        }
> 
> I could also use some type of variable like we do for the active
> channels in order to track "active/existing irqs".

I think there is only one IRQ on the 380 at least.  So
you should only request it once for this driver.  Then software
gets to configure what it is for.

However it shouldn't be called DRDY for these parts at least. It's
just INT on the datasheet.
The interrupt control register value will tell you what is enabled.
No need to track it separately.

If you mean track the one from the poll function registered for
handling triggers - that's an internal detail but you would indeed
need to track in your data structures whether that's the trigger
currently being used or not (easy to do by comparing iio_dev->trig
with a pointer for each trigger in iio_priv() data - so should be no
need for separate tracking.

Jonathan



> 
> Like this it would be easier to track the active irqs of the sensor.
> 
> Let me know what you think, or if I manage to have time I might send
> a v2 with those changes even earlier :)
> 
> Cheers,
> Vasilis
> 


