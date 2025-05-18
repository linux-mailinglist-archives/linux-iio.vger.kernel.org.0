Return-Path: <linux-iio+bounces-19640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E997ABB11D
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB916A135
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CA21E08A;
	Sun, 18 May 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7kGfYtk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955821D5B5;
	Sun, 18 May 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747589939; cv=none; b=aR4WSsBm6k3b7sZx4H6zoM3V89eOgbRCNfHEkO3B14pFrNodXRfAZLR4Ygz1tjuUWSdksbw95Efih2sedeUW+75/f7PTEyvo5WPvwKuMM2iR5K5viwOm/JfmqjD7MpvRg1ldnemNdgdwYGBd6BjXpnb54UY5b8RC0hcCvSuvXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747589939; c=relaxed/simple;
	bh=Sr1/9jGKxhwCls0Utn+t/gxiBhVYbEI9OCJ2SmH2ZmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VP9URqHja+iv9G/h/aOYBMGRTL/XGDFg4s1fcJreGnk9vXlxyqc7FJdGd/O9CZew22T55rFH0fyaIP0soVtRrz+42suGWaexWInV7qmyzEAdrUkbVciux489m57D85jnTRrxsOaA6UyoV34qgtPkvR6llfTxawl1qwC6GkiLmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7kGfYtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A8BC4CEED;
	Sun, 18 May 2025 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747589938;
	bh=Sr1/9jGKxhwCls0Utn+t/gxiBhVYbEI9OCJ2SmH2ZmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e7kGfYtkjqFiaY0POUZDHxZfO9owln21gOPvwhSJMrkciSogSxSINoXly51yFiEkR
	 klw2oGiO397IW4HlWNM5NYZE7veRknk3QVHsiwx/kUwXBNTUzepJuN9uK02OWlbuJ+
	 oDNcd9xhRTpwSPygCmi3UIzRRCgx6ZLXa/JoinCOKU/mViqYX4JD6ObKeeIhouM7s4
	 Zs+CRAvCc+bjDDq82vBEBW3FlRQ0ALQT+ebbJkPMn/dX7nR9AuGCRwMjCw5qwydVCX
	 AKeG+hMnkwSYdVZcKUG/h5oTi9AGKNg/EuO6/cdkltjYN+6vG1EWXQurjCzfu7Xvtr
	 y2uJG8ZD6qqqw==
Date: Sun, 18 May 2025 18:38:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250518183852.7e9afdac@jic23-huawei>
In-Reply-To: <pndldqwiihi.fsf@axis.com>
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei>
	<pndldqwiihi.fsf@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +#define D3323AA_DRV_NAME "d3323aa"  
> >
> > Put that inline where used.  A define like this both implies that various values
> > must be the same when they need not be and means that we have to go find the
> > define to fine out what they are set to.  Just setting the strings directly
> > tends to end up more readable.  
> 
> Sure, we can do that. (There are a bunch of IIO-drivers doing this, so I
> just thought that was the "convention".)

I'm sometimes in less fussy mood.  One day I might just clean those up
so there is nothing to copy into new drivers!

>
> >> +	/* Input clock or output detection signal (Vout). */  
> >
> > I'd rename. Vout kind of suggests a variable voltage. This seems to just
> > be a level signal.  
> 
> >> +	struct gpio_desc *gpiod_clk_vout;  
> 
> Yeah, it's a weird pin with multiple use-cases... I just named it
> according to what the datasheet calls it. What about
> `gpiod_clk_detection`?

That sounds like it's detecting a clock.  Hmm.  
gpiod_clkin_detectout maybe?

> >> +static int d3323aa_write_settings(struct iio_dev *indio_dev,
> >> +				  const unsigned long *regmap)  
> >
> > Rename regmap. regmap means some specific stuff in the kernel register_bm or something
> > like that avoids that potential confusion.
> >
> > However, it would be much easier to read this driver if only this
> > function and the read one knew about the bitmap stuff.  Inside the reset
> > of the driver just store and pass around a structure with the various fields.
> > Then in here use that to build up the bitmap locally and write to the device.
> > The opposite in read which decodes the bitmap into those fields.
> >
> > That will make for a more standard and easier to review driver.  
> 
> Hm, maybe it would be easier to understand it if we remove the bitmap
> from `struct d3323aa_data` and instead only store the relevant state
> variables. We still would need to have the `regmap_lock` but to instead
> protect all of the variables.
> 
> Let's go for that then! I actually don't have any strong arguments (or
> opinions) against it.

Just don't use the term regmap and that all sounds fine as it won't
cause confusion against the stuff in drivers/base/regmap/


> >> +static irqreturn_t d3323aa_irq_detection(int irq, void *dev_id)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_id;
> >> +	struct d3323aa_data *data = iio_priv(indio_dev);
> >> +	enum iio_event_direction dir;
> >> +	int val;
> >> +
> >> +	val = gpiod_get_value(data->gpiod_clk_vout);  
> >
> > Ideally I'd like a setup where we can wire the interrupt side of this
> > to one pin and the gpio needed for writing to another.  In practice
> > they may well be the same pin but that does introduced a bunch of races
> > and dependency on what the interrupt controller does when an irq
> > is disabled.
> >
> > Using one pin as an irq and as a data line is prone to some nasty
> > corner cases though it works on some SoCs.  
> 
> Hm, that's an interesting idea. However, as you say there might then be
> other issues to take care of.
> 
> On the other hand, the scope of the clock bit bang is quite small (only in
> `*read/write_settings()`). So I guess we just leave it then?

I'd give a very high chance that if the driver sees much use you will get
bug reports as we've seen for ADCs that do similar multiple uses of the
same line (one of which is as an interrupt).

Here we will probably just see spurious interrupts which will be mostly
harmless.  So fine as it stands.




