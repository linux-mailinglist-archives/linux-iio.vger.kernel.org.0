Return-Path: <linux-iio+bounces-13341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304B9ED64D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76355162ABB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309A1FF1B8;
	Wed, 11 Dec 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL5E0Nek"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374102594B3;
	Wed, 11 Dec 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944490; cv=none; b=XMCWnkElmY5xdu2Y6q1AsWoXy/8y+eeJ6YR/1wuoj+14QEGyiPxYY6ynXel3onABUkQQhJ6wcHrrWyxMrHoJyIgLYsizPQhVmqTlHbCXrmrl+eno/uymdPcHxsAB28x3uJtYgZHvxbdvITx3N8uiI2IT3rDa84gEm7HWjno0Szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944490; c=relaxed/simple;
	bh=eAniawxBhtib03GfxX9/u4Ndstdo7x6Aj1ZRkV2OAvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOUXvYJ0dNvuJPsuS1QWjISpdVwHVD0QIix9ZDKJY1Al3DvKf10BJ52VVetUjNM/Tu9d7gsQRJsfh1QfZmhlpSkrA0/pGhqGmHG2aYn+NLS0pbNAi7cLAnqEqRl0NC8wac6fXsLvk1hGdKA/9gjWJfR9RmdLrX3Vv0J/c2I2ykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL5E0Nek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD0FC4CED2;
	Wed, 11 Dec 2024 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944489;
	bh=eAniawxBhtib03GfxX9/u4Ndstdo7x6Aj1ZRkV2OAvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VL5E0NekGGP/+NklIqGa1wt05rnw2b98UGKvBzpJtz6HSKfCf/NFvndulLtRqtsnv
	 rUfPrAVHWoMVEMEm90gmky87VlyBRj4r7TzLX0G0/f44np9aTYqSbZBghpnkDVuhRz
	 2osplHggKVpYVd3zFdd4wr49zwDniH4TUb8hT4ZcHTboi977Y2jTL8A7kStLFC7Pr5
	 HXSnZ52u1rUvlmXd3kQMlAiXad/231ku+/16X1rzvNK7PDd7e+GAzBOpqxTW54jpoe
	 IdRiWTRlEgdhWZC3zBElbkeTZjNRvgLhiYooX+3/baOKMqAYkfJUm4hLV/QkciFORC
	 DoWS7tP5XOdug==
Date: Wed, 11 Dec 2024 19:14:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <20241211191440.0e6f7afd@jic23-huawei>
In-Reply-To: <CAFXKEHaLzrBXNV=dgTrX3CatvCT751x8Lh69mCXebLK=Fh4jFw@mail.gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-11-l.rubusch@gmail.com>
	<20241208163418.2d57f185@jic23-huawei>
	<CAFXKEHaLzrBXNV=dgTrX3CatvCT751x8Lh69mCXebLK=Fh4jFw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +}
> > > +
> > > +/**
> > > + * adxl345_fifo_transfer() - Read samples number of elements.
> > > + * @st: The instance of the state object of this sensor.
> > > + * @samples: The number of lines in the FIFO referred to as fifo_entry,
> > > + * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes each.
> > > + *
> > > + * It is recommended that a multiple-byte read of all registers be performed to
> > > + * prevent a change in data between reads of sequential registers. That is to
> > > + * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.  
> >
> > Doesn't match the code which is reading just one register lots of times.  
> 
> This is one of my painpoints, regmap_noinc_read() worked here, for a
> linewise reading of FIFO elements. Say, I could read X0, X1, Y0,... Z1
> in one command. Also, I tried here regmap_bulk_read(). At all, I find
> this solution is working, but I'm not sure if there is not a total
> differnt way to do the read out.

A bulk read is defined as indexing through registers. Eg. ADDR, ADDR + 1, ADDR + 2
etc.  regmap_noinc_read() just keeps reading the same register, so is typically
used for fifos.

I opened the datasheet. It seems to say you need to read 3 registers repeatedly
rather than one 3 times as often.  There isn't a good way to do that sort of
sequenced read in one go.  So you will need a loop like you have, but it
should need a bulk read.  Curious it doesn't seem to...

Ah. Device auto increments for both SPI and I2C.  So in that case
the noinc_read and normal bulk read will actually issue the same thing and
as these are volatile registers it doesn't matter (it would if you were
caching the result as the data would end up cached in different places).

It will do the wrong thing though if you have an i2c controller that
is less capable and can't do large reads.  So you should definitely use
bulk_read not noinc.

Have you set available_scan_masks?  If not you want to do so as
per comment I made in the cover letter.



> > > + * @irq: The irq being handled.
> > > + * @p: The struct iio_device pointer for the device.
> > > + *
> > > + * Return: The interrupt was handled.
> > > + */
> > > +static irqreturn_t adxl345_event_handler(int irq, void *p)
> > > +{
> > > +     struct iio_dev *indio_dev = p;
> > > +     struct adxl345_state *st = iio_priv(indio_dev);
> > > +     u8 int_stat;
> > > +     int samples;
> > > +
> > > +     int_stat = adxl345_get_status(st);
> > > +     if (int_stat < 0)
> > > +             return IRQ_NONE;
> > > +
> > > +     if (int_stat == 0x0)  
> > Doesn't this correspond to 'not our interrupt'?
> > If that's the case return IRQ_NONE is the right way to go and not reset the
> > interrupt.  You have registered it as maybe shared, and if it is, then this
> > is a common thing to happen as interrupt from another device.
> >  
> 
> Here I see actually
> +     int_stat = adxl345_get_status(st);
> +     if (int_stat < 0)
> +             return IRQ_NONE; // a bus error, reading register not possible
> ...and then...
> +     if (int_stat == 0x0)
> +             // interrupt sources were 0, so IRQ not from our sensor
> 
> I'm unsure if the first IRQ_NONE here is actually correct. I mean, if
> the bus is not working,
> actually any IRQ usage should be considered broken. Is there a way to
> break out of measuring?
> 

It is a much debated thing on what you should return if you have no
idea if it is our interrupt or not.   There isn't really a right
answer.  If you get a lot of IRQ_NONE and no one else claims it eventually
the interrupt will be disabled (to break the interrupt storm freezing the
machine).


> > > +             goto err;
> > > +
> > > +     if (int_stat & ADXL345_INT_OVERRUN)
> > > +             goto err;
> > > +
> > > +     if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {  
> >
> > I think you only ever enable the INT_WATERMARK?  If so does it
> > make sense to check for DATA_READY as well?
> >  
> 
> Watermark comes usually with data ready or overrun. I guess for the
> FIFO watermark, just evaluating watermark is probably sufficient. For
> other events, it then might be notification w/ a data ready set.
> Probably better to introduce data ready when it's actually really
> needed?

Yes.  That dataready is normally used when you are doing capture without
the fifo and want to read each sample - kind of same as a watermark depth
of 1, but less hardware turned on.  As such, may be no need to ever support it.

   return dev_err_probe(dev, ret, "Failed to add action or reset\n");
> > >
> > > +     if (st->irq > 0) {
> > > +             dev_dbg(dev, "initialize for FIFO_STREAM mode\n");
> > > +
> > > +             ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret = devm_request_threaded_irq(dev, st->irq, NULL, &adxl345_event_handler,
> > > +                             IRQF_SHARED | IRQF_ONESHOT,
> > > +                             indio_dev->name, indio_dev);
> > > +             if (ret)
> > > +                     return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
> > > +
> > > +     } else {
> > > +             dev_dbg(dev, "initialize for FIFO_BYPASS mode (fallback)\n");
> > > +  
> > Given you haven't removed this code from elsewhere, was the driver relying
> > on the defaults after reset before this patch?
> >
> > I don't mind having this branch as a form of documentation even if that's
> > true but maybe add a note to the patch description.
> >  
> 
> I'm not sure if I get you correctly. The driver before only
> implemented "BYPASS" mode. This was the case w/o a defined
> interrupt-name. My intention now is to keep this behavior as fallback.
> If no IRQ is around, i.e. interrupt + interrupt-name, the sensor
> driver will operate the sensor in BYPASS mode.
> 
> I was interpreting this also as the "default behavior", you mentioned
> in the dt-binding patch? Is this correct?
> 
> What do you mean when the driver is relying on the defaults after reset?

The driver worked without irq before now.  Which is same as this path.
So how was the register written here being configured correctly before
this patch?  I'm guessing it wasn't and that the value written here
is the default on power up.

Either that or I'm miss understanding what this branch of the if / else is
about.

Jonathan

> 
> > > +             fifo_ctl = ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
> > > +
> > > +             ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +     }
> > >       return devm_iio_device_register(dev, indio_dev);
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);  
> >  
> 


