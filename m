Return-Path: <linux-iio+bounces-8905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB578967103
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB261F22959
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 11:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B8D17B421;
	Sat, 31 Aug 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMggorzQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402001BC39;
	Sat, 31 Aug 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102273; cv=none; b=VqK4bWHhDzqPdwWOjNxkFCtIVJqzqGqLi6P84IkSQGdO/umnIMvE4zaDKhavGlDttW5LX60fr/hiVNqvCI7MmyC0UjyikPjiPvcR1KZSjFZ4cXp11GnIFWBORkjZf+QZpmEwB1HpCvI+Uq5w2iwUcnrr47fdx4zAQkJEAZGqgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102273; c=relaxed/simple;
	bh=DyPI+ghGw3V76yOFNfDBNteyNZJ32yycnLbezM1s5Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCoJKh/M3CxWQW1r4H6K1Ag3Uy/r+wsC2JxD12sIXIfXKw8XTwlleC+nTSHuQj36ZNDL/NsaHGkv7QcDGVP2hO6199xMEluoCQSXJ9mUvDfCdyCRHIIsrCOzl7GwluxreroTi5q3OA22YizSFV14w6aio1aF0M0tP9qa1DAEIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMggorzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B1AC4CEC0;
	Sat, 31 Aug 2024 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725102272;
	bh=DyPI+ghGw3V76yOFNfDBNteyNZJ32yycnLbezM1s5Vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMggorzQtVFKo4PvUDf10V1KBDGRo6ZaZnm45dYM/ZmCPWmnzjLIQ461+F9Xp6aLG
	 8qvOQTaoUuviGUI5F3BV0ipsb1dy9mxglzWK+WAXT2UiRSuot0lEoPZMgGra7CiCq/
	 atMcvNX+ySpEFynQUt/Xf0QTQOh7DC489q3jclNiJ8uONuxLnA3pNGEaU8merb/VOy
	 AAzsSyD4p9joIff+g5lyqrQgI2dkua2dMcz6YOftOFXOAYUjami0i0MmBt78zGKUe7
	 Nk0WvxsHaTzFDrV+vYA1DD+WOnX0rAdDK8PGQWhXpzGohiW4tGOb1JyOcgGOEFOC5V
	 ZYwMznPDqGhmg==
Date: Sat, 31 Aug 2024 12:04:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240831120420.46e73425@jic23-huawei>
In-Reply-To: <20240829191957.GE3493@vamoiridPC>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
	<20240828205128.92145-7-vassilisamir@gmail.com>
	<ZtBsQg_JIcY4F-0h@smile.fi.intel.com>
	<20240829191957.GE3493@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 21:19:57 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Thu, Aug 29, 2024 at 03:40:34PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 28, 2024 at 10:51:26PM +0200, Vasileios Amoiridis wrote:  
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
> >   
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > ---
> > >  drivers/iio/pressure/bmp280-core.c | 231 ++++++++++++++++++++++++++++-
> > >  drivers/iio/pressure/bmp280.h      |  21 +++
> > >  2 files changed, 250 insertions(+), 2 deletions(-)  
> > 
> > ...
> >   
> > > +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> > > +				  const struct iio_trigger_ops *trigger_ops,
> > > +				  int (*int_config)(struct bmp280_data *data),
> > > +				  irq_handler_t irq_thread_handler)
> > > +{
> > > +	struct bmp280_data *data = iio_priv(indio_dev);  
> > 
> > With
> > 
> > 	struct device *dev = data->dev;
> > 
> > you may shorten some lines below and collapse a few.
> >   
> 
> ACK.
> 
> > > +	struct fwnode_handle *fwnode;
> > > +	int ret, irq, irq_type;  
> > 
> > Why irq_type is signed?
> >   
> 
> True, this can be made u32.
> 
> > Also try to make that returned variable is closer to the end of the definition
> > block. And it might be worth to follow reversed xmas tree order (longer lines
> > first).
> >   
> > > +	struct irq_data *desc;
> > > +
> > > +	irq = fwnode_irq_get(dev_fwnode(data->dev), 0);
> > > +	if (irq < 0)
> > > +		return dev_err_probe(data->dev, irq, "No interrupt found.\n");
> > > +
> > > +	desc = irq_get_irq_data(irq);
> > > +	irq_type = irqd_get_trigger_type(desc);  
> > 
> > So, altogether it may be written as
> > 
> > 	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
> > 
> > And looking further, we have a helper for that:
> > irq_get_trigger_type(). Why not use it?
> >   
> 
> I was not aware of that, I can definitely change it.

Nice.  A quick grep suggests a bunch of other places
where this cleanup applies.

Maybe I'll do it this weekend, but if not patches welcome ;)

Jonathan



