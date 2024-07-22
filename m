Return-Path: <linux-iio+bounces-7801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E6B9394CF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CFDB214B3
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 20:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075BD34CE5;
	Mon, 22 Jul 2024 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id7/ujMy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168C1C6A8;
	Mon, 22 Jul 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680721; cv=none; b=J7jtppBJv++/TcOTYrSUBj2VJe0bZzj6RGoXNCwdoy71ZwSPuCgIq1QFsSS9dcmcW4e7Qup0mzmtt/1Wd5XsHLhaHvHIFk1+99GywdnMJhlA1wPYidhRCI9/Y/p5yl/i5XG/KfhCLzJEl2FmCiaKs428FriZ4myc+DLvVJ6ZPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680721; c=relaxed/simple;
	bh=oj7iizPmx9Uac534TDn+iK6P7w94M6HPkwDq4rx9hbg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFMoY8ulZ5oEFBblQR3Sw7GwLctgkdcxJqz9vQVr0GUg8WSUlY4TCYfrTFm/zCFDxKE3bZFynPETlI+evvC2cWRv99gmqvBOeCdLfXVobnCCZUqH8s6oDaRzKqqH/e7BMBwPZyZucTfra8aFPEIiEhIUaG/s3Iig6FnJj0Yedas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id7/ujMy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so3834288a12.3;
        Mon, 22 Jul 2024 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721680718; x=1722285518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4soFdbWI6WlrT388kgL0g2NFrLFysdOT5ujOm7GMw3s=;
        b=Id7/ujMyhKAKwmpJOdwOw5rbUkbf8Q1EDVBgfaIkdvcOclPs8ovFZ7OfhKOCGvgnA+
         Yv1rJFv+WurV/74a6gVdzFSxjuufuY6OfLh/en20WhnwG7lPE2WCiFIeWOUlMkTGuUJT
         ox7IIncZ/m7hb7idUdEngpNy/rHcLe83litNUAjeXcqZFrCFhCFtXqu1BL22xR4HmOZZ
         hDYKXG+SpHWBPJVQApBdLRK5y4cPNeGb88eyhpqDdW1z65EGmVGMyPx83cmxmwPQDpt1
         JzkFMOjtCaFiJ3qHVGfOsXjW6D5RbtJaI3RryU8LCQ6xU6yYv/4nLiZQJVsWRo372Pfu
         VTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721680718; x=1722285518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4soFdbWI6WlrT388kgL0g2NFrLFysdOT5ujOm7GMw3s=;
        b=oh2ubs8Tbo9WG3nnfO50zG26ePY/BINfP0prXadWbZ1X2Xi0iM4WVu6ZhG1I5hZdJq
         6UMCA+yB9IlYmzpTmipAlwvLqTX6taD3GZr2r3PGyjk/wMi6/KaNpIvlrAtEVxEP3URF
         YyoNRUgBzEAZs0TE5DUTadQUvjK9MqhT48CAHMvEYsaMgIE6y7UE5CzzK6tLDtxut1+v
         pN2i7eQVF9yzCiGCN5LmlgI3O16I3Bo8b6T71Vwa/kD4PyjHpKVel8riEz7CY+opqAVh
         ncivWEoRHvT89Tuf0O3/MWKuYRVvt2NziNAjCzvBg0v5IQhhnNWJFwR9FWGvN1RViF7e
         Qu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv/efd73qOwBWY0+51yHMF3Ful0VWIlevfdc/DJgHwBrp6/MX7sIDqFuRpl0YdQ+idyY/mIfarwttDnoGDvBUrTPcSFRC0dkTGOaLmrUwpuiSSL38BHzlbGbiBXqUJRaT0hjT4T6BUiNDnzErwrBVIQeE+a43l/7KmA65iNnNtxcsoBA==
X-Gm-Message-State: AOJu0YzI3oWeWqy3YThyj0ps6AWd0qKBS4zJjKduJspWh6jgvORMAeRu
	pY7ZF4yGAxKpTWJ5KXjSvqMaZnl4H6lsL0THOtnfR5FBpDkm0s5H
X-Google-Smtp-Source: AGHT+IEhhx04/8t1mBceev5cCkjM+y02k9b7hRo6GVXAdNpYCApOTGeRgRIM6BPwR9J/nTo9Fh/47A==
X-Received: by 2002:a50:c30f:0:b0:5a3:ca25:56e2 with SMTP id 4fb4d7f45d1cf-5a47afefb48mr4681612a12.23.1721680718093;
        Mon, 22 Jul 2024 13:38:38 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:a09a:d3e:5e36:412c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30af83e8dsm6610671a12.49.2024.07.22.13.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:38:37 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 22 Jul 2024 22:38:34 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/10] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240722203834.GA468105@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-10-vassilisamir@gmail.com>
 <20240720123727.7598111b@jic23-huawei>
 <20240721235113.GF325365@vamoiridPC>
 <20240722203138.07b21300@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722203138.07b21300@jic23-huawei>

On Mon, Jul 22, 2024 at 08:31:38PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Jul 2024 01:51:13 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Sat, Jul 20, 2024 at 12:37:27PM +0100, Jonathan Cameron wrote:
> > > On Thu, 11 Jul 2024 23:15:57 +0200
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > >   
> > > > The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> > > > a trigger for when there are data ready in the sensor for pick up.
> > > > 
> > > > This use case is used along with NORMAL_MODE in the sensor, which allows
> > > > the sensor to do consecutive measurements depending on the ODR rate value.
> > > > 
> > > > The trigger pin can be configured to be open-drain or push-pull and either
> > > > rising or falling edge.
> > > > 
> > > > No support is added yet for interrupts for FIFO, WATERMARK and out of range
> > > > values.
> > > > 
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > > 
> > > A few minor things inline.
> > > 
> > > It might be worth thinking a bit about future fifo support as that can
> > > get a little messy in a driver that already supports a dataready trigger.
> > > We end up with no trigger being set meaning use the fifo.  Sometimes
> > > it makes more sense to not support triggers at all.
> > > 
> > > What you have here is fine though as we have a bunch of drivers
> > > that grew dataready trigger support before adding fifos later
> > > particularly as often it's a 'new chip' that brings the fifo
> > > support but maintains backwards compatibility if you don't use it.
> > >   
> > 
> > Hi Jonathan,
> > 
> > Thank you very much for your thorough review again!
> > 
> > What I could do to make the code even better to be able to accept
> > FIFO irq support are the following:
> > 
> > 1) in the bmp{380/580}_trigger_handler() currently, the data registers
> > are being read. What I could do is to move the reading of registers
> > to a separe function like bmpxxx_drdy_trigger_handler() and calling
> > it inside the bmp{380/580}_trigger_handler() when I have DRDY or
> > sysfs irq. In order to check the enabled irqs I propose also no.2
> 
> You shouldn't get to the trigger_handler by other paths.  But sure 
> a bit of code reuse might make sense if fifo read out path is same
> as for other data reads.  Superficially it looks totally different
> on the bmp380 though as there is a separate fifo register.
> 

So, I don't mean getting into the trigger_handler by other paths. I will
always end up in the trigger_handler and then, depending on the interrupt
that was triggered (DRDY, FIFO, etc...) I choose different actions.

> > 
> > 2) in the following bmp{380/580}_trigger_probe() functions instead of
> > just doing:
> > 
> >        irq = fwnode_irq_get_byname(fwnode, "DRDY");
> >        if (!irq) {
> >                dev_err(data->dev, "No DRDY interrupt found\n");
> >                return -ENODEV;
> >        }
> > 
> > I could also use some type of variable like we do for the active
> > channels in order to track "active/existing irqs".
> 
> I think there is only one IRQ on the 380 at least.  So
> you should only request it once for this driver.  Then software
> gets to configure what it is for.
> 
> However it shouldn't be called DRDY for these parts at least. It's
> just INT on the datasheet.
> The interrupt control register value will tell you what is enabled.
> No need to track it separately.
> 

So I am a bit confused. Indeed, BMP380 has only irq line. So I understand
why I should call it INT. The actual IRQ inside the chip that will be 
triggered needs to be configured by software. I do it through the
bmp{3/5}80_int_config() function. How am I supposed to know
which IRQ to enable? Options are:

	a) DRDY only
	b) FIFO only
	c) both

How can I inform the driver about which to enable? Shouldn't this go
through the device-tree?

> If you mean track the one from the poll function registered for
> handling triggers - that's an internal detail but you would indeed
> need to track in your data structures whether that's the trigger
> currently being used or not (easy to do by comparing iio_dev->trig
> with a pointer for each trigger in iio_priv() data - so should be no
> need for separate tracking.
> 

My idea is that there is one trigger_handler which inside you check
which interrupt triggered and you choose which path to choose. If that's
wrong, do you know any specific driver that implements it in the correct
way? Because in my mind, the iio_dev->trig is one and just inside the
handler, different functions are called.

> Jonathan
> 
> 

Thanks for the feedback :)

Cheers,
Vasilis

> 
> > 
> > Like this it would be easier to track the active irqs of the sensor.
> > 
> > Let me know what you think, or if I manage to have time I might send
> > a v2 with those changes even earlier :)
> > 
> > Cheers,
> > Vasilis
> > 
> 

