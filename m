Return-Path: <linux-iio+bounces-13370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FF9EDA32
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2E7188630A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062F020E308;
	Wed, 11 Dec 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCx0gGwl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5101F37DB;
	Wed, 11 Dec 2024 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956394; cv=none; b=nAHGQb8R9aY5xgWa+3OFBKpM3YBFQX0Yn+bT9z4sdYsrM740M7Hd39jcwk3tIRYCdzl4HoZ1gEtg3cOjdBvh3tp+kDkUZL16i2qnVHuqi9gzrD5ByVNtNK7zAWE/rkIUwSwjbH85jgpvdFo2WcJzG8AniMtPqA+e99e/LbMOVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956394; c=relaxed/simple;
	bh=YgTHLubS5k1wjTkb8qsRT7Zz1A+VHCdbJD5zJybDSqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlNxpttSyfQ+vNWnheeW1D8uhvaCEFqXJdbJBYu6NKvBYsLeCf017Tyl2jn0AbAx/+TQDJwZDy6HqXA8rvySt5l2cNh5L5kdbdKY1Sc8NRAvDvGQv63ydaGNUzKOsrshnKPER7ikRctt3viJfMZcQK3Y9HLG1SZpsmtV4IBSqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCx0gGwl; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3990f53d30so859741276.1;
        Wed, 11 Dec 2024 14:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733956392; x=1734561192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USS/fCbhCuGymUN2mXk4mqLJ6V5CqqTLPjkKHlyMS7E=;
        b=SCx0gGwl4lFqxCM0Z2N1BQV97zW0zXst8kHVrwwGXUarl3enGjJ+eZwMBJFpiBeT6+
         ugIBuVfQzcOxLtNCViYoL1nccVzQPHhZNTCBIGgLaSBzxdvBXoLEujx/qy1zSqgVklbu
         y6GhFt+RQsRQ+mo/zFwdpDNs1EUBrysRd0R/876aHKbcDjq/HO8oD5JWYGH02xLa4JIU
         MmxFGtKzG1lk7y5JcRMGJaQGmgKkHynOwdiGGLA/jVQPx5+jD7jjqHTVNvs2A/qJoam9
         kxy4QVEaoVGEe+J99GjYlFmaeWMC0DCqYgoWclfggJC/4KayIGDWEctmEZFJnagwJtjd
         VDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956392; x=1734561192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USS/fCbhCuGymUN2mXk4mqLJ6V5CqqTLPjkKHlyMS7E=;
        b=gCNriFbd5BijhtWCCVH/R09dlBz1NhvuFw7jcOlQuoDhsu05ocWk92bpqMtwjZL9Xw
         Mauhsh3il0Lg5VlpnHoRsaznS3PUGgu3q8ovUUU1i2Z1l85iQsOm8rj3nzV4HM8AtQto
         5VsSS+IyzXfVk5ksk8a+WjgeBqVMMmiqxT9k0ygyzjr8fA3i6uNJgE5ceCR1RFNb1M7J
         PU6/GQnsLvKUes1ZUWxq7wr3bupdlEP2qkJKzPleDy2AtdXPIqFpVSZQD6q8wJ+9n5sd
         g03eKqczXCOAXMgs8kuieRMNmI5WmRjULWMfoflT8OOv5v2fiRiF6Bw4WGQvySgL8MZi
         JAFA==
X-Forwarded-Encrypted: i=1; AJvYcCUoQmQNSZnUWMm1BLnvhxHVdqGvsX1KNSl/ryTNykEr02TAkfbsDXze71MXQdwUORhQ3+u4QvuXsXUE@vger.kernel.org, AJvYcCWhGwhWJ4wZX0mRnLcmNXUqgbe7GK9V4fnQKijjYTpQOeRZ1UDQN+Wya8JqfJv4xwn5S/lR7KWYDmE/@vger.kernel.org, AJvYcCXVdh/sBpkW6S1Mdl9pNC9PyqhXnU7FwPe4rqPV1jMwOzbjsuXqVczZWw63qIbem/Djf5H52OZna0NktyVP@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzagF7wRyJpZavL1Gphra1osG5poVKoG6UXgtWLpWsad7grqf
	aqyLHCVBOtv2qu2uZO7s+tm2fnTf43fk58JIrG6Q4VxR7U2mjVp2Bno+CIeBkRiEVQu2mJpaI4c
	iTWToeiPB9iuvMSNHgidiFxkstCw=
X-Gm-Gg: ASbGncuYSpQK7/C1o745I/WqIV1HZx3pf2skTTKOmB/xgehZreRNCV9/4bEkFpd2NLt
	cBZEX5jgT+l9QWISXbQ8ZxqkvRzQrBqeJp64=
X-Google-Smtp-Source: AGHT+IH55y2QYsbpfMCYEY6iO3ZeJ3oA/f/UKwJvTeb5B9Om5D2PAkuL6yBadJmV6x1NIfJ97pUxBS2c5g+T+BW0ihs=
X-Received: by 2002:a05:6902:2e09:b0:e3c:8b14:e7dc with SMTP id
 3f1490d57ef6-e3da26bab16mr419161276.9.1733956391760; Wed, 11 Dec 2024
 14:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-11-l.rubusch@gmail.com>
 <20241208163418.2d57f185@jic23-huawei> <CAFXKEHaLzrBXNV=dgTrX3CatvCT751x8Lh69mCXebLK=Fh4jFw@mail.gmail.com>
 <20241211191440.0e6f7afd@jic23-huawei>
In-Reply-To: <20241211191440.0e6f7afd@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Dec 2024 23:32:35 +0100
Message-ID: <CAFXKEHb+6xd_F7v7t3sRBoziokr1moNQFdv93ra7X+FKKattnQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark events
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,
Thank you again. This brought several pieces together for me.
See answeres down below.
Best,
L


On Wed, Dec 11, 2024 at 8:14=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
>
> > > > +}
> > > > +
> > > > +/**
> > > > + * adxl345_fifo_transfer() - Read samples number of elements.
> > > > + * @st: The instance of the state object of this sensor.
> > > > + * @samples: The number of lines in the FIFO referred to as fifo_e=
ntry,
> > > > + * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes=
 each.
> > > > + *
> > > > + * It is recommended that a multiple-byte read of all registers be=
 performed to
> > > > + * prevent a change in data between reads of sequential registers.=
 That is to
> > > > + * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.
> > >
> > > Doesn't match the code which is reading just one register lots of tim=
es.
> >
> > This is one of my painpoints, regmap_noinc_read() worked here, for a
> > linewise reading of FIFO elements. Say, I could read X0, X1, Y0,... Z1
> > in one command. Also, I tried here regmap_bulk_read(). At all, I find
> > this solution is working, but I'm not sure if there is not a total
> > differnt way to do the read out.
>
> A bulk read is defined as indexing through registers. Eg. ADDR, ADDR + 1,=
 ADDR + 2
> etc.  regmap_noinc_read() just keeps reading the same register, so is typ=
ically
> used for fifos.
>
> I opened the datasheet. It seems to say you need to read 3 registers repe=
atedly
> rather than one 3 times as often.  There isn't a good way to do that sort=
 of
> sequenced read in one go.  So you will need a loop like you have, but it
> should need a bulk read.  Curious it doesn't seem to...
>
> Ah. Device auto increments for both SPI and I2C.  So in that case
> the noinc_read and normal bulk read will actually issue the same thing an=
d
> as these are volatile registers it doesn't matter (it would if you were
> caching the result as the data would end up cached in different places).
>
> It will do the wrong thing though if you have an i2c controller that
> is less capable and can't do large reads.  So you should definitely use
> bulk_read not noinc.
>
> Have you set available_scan_masks?  If not you want to do so as
> per comment I made in the cover letter.
>

For v6 I'll setup available_scan_masks, as I understand its usage. I'm
not sure if I understood what it actually does. I can see it needs the
channel indexes available, but I'll need to read a bit more code.
Hopefully for now it'll be sufficient.

>
> > > > + * @irq: The irq being handled.
> > > > + * @p: The struct iio_device pointer for the device.
> > > > + *
> > > > + * Return: The interrupt was handled.
> > > > + */
> > > > +static irqreturn_t adxl345_event_handler(int irq, void *p)
> > > > +{
> > > > +     struct iio_dev *indio_dev =3D p;
> > > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > > +     u8 int_stat;
> > > > +     int samples;
> > > > +
> > > > +     int_stat =3D adxl345_get_status(st);
> > > > +     if (int_stat < 0)
> > > > +             return IRQ_NONE;
> > > > +
> > > > +     if (int_stat =3D=3D 0x0)
> > > Doesn't this correspond to 'not our interrupt'?
> > > If that's the case return IRQ_NONE is the right way to go and not res=
et the
> > > interrupt.  You have registered it as maybe shared, and if it is, the=
n this
> > > is a common thing to happen as interrupt from another device.
> > >
> >
> > Here I see actually
> > +     int_stat =3D adxl345_get_status(st);
> > +     if (int_stat < 0)
> > +             return IRQ_NONE; // a bus error, reading register not pos=
sible
> > ...and then...
> > +     if (int_stat =3D=3D 0x0)
> > +             // interrupt sources were 0, so IRQ not from our sensor
> >
> > I'm unsure if the first IRQ_NONE here is actually correct. I mean, if
> > the bus is not working,
> > actually any IRQ usage should be considered broken. Is there a way to
> > break out of measuring?
> >

Here actually, I merged them, when returning IRQ_NONE in both
statements. I mean, if the bus is broken, the sensor driver then is
anyway not operational anymore. It cannot process interrupts anymore
be it from someone else or own ones.

When the interrupt source register was 0, then the interrupt was not
ours for sure. As I understand, if such happens, there will be no more
IRQs anyway as long as interrupt source reg and fifo are not cleaned
up.

> It is a much debated thing on what you should return if you have no
> idea if it is our interrupt or not.   There isn't really a right
> answer.  If you get a lot of IRQ_NONE and no one else claims it eventuall=
y
> the interrupt will be disabled (to break the interrupt storm freezing the
> machine).
>
>
> > > > +             goto err;
> > > > +
> > > > +     if (int_stat & ADXL345_INT_OVERRUN)
> > > > +             goto err;
> > > > +
> > > > +     if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMAR=
K)) {
> > >
> > > I think you only ever enable the INT_WATERMARK?  If so does it
> > > make sense to check for DATA_READY as well?
> > >
> >
> > Watermark comes usually with data ready or overrun. I guess for the
> > FIFO watermark, just evaluating watermark is probably sufficient. For
> > other events, it then might be notification w/ a data ready set.
> > Probably better to introduce data ready when it's actually really
> > needed?
>
> Yes.  That dataready is normally used when you are doing capture without
> the fifo and want to read each sample - kind of same as a watermark depth
> of 1, but less hardware turned on.  As such, may be no need to ever suppo=
rt it.
>
>    return dev_err_probe(dev, ret, "Failed to add action or reset\n");
> > > >
> > > > +     if (st->irq > 0) {
> > > > +             dev_dbg(dev, "initialize for FIFO_STREAM mode\n");
> > > > +
> > > > +             ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &=
adxl345_buffer_ops);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +
> > > > +             ret =3D devm_request_threaded_irq(dev, st->irq, NULL,=
 &adxl345_event_handler,
> > > > +                             IRQF_SHARED | IRQF_ONESHOT,
> > > > +                             indio_dev->name, indio_dev);
> > > > +             if (ret)
> > > > +                     return dev_err_probe(dev, ret, "Failed to set=
up triggered buffer\n");
> > > > +
> > > > +     } else {
> > > > +             dev_dbg(dev, "initialize for FIFO_BYPASS mode (fallba=
ck)\n");
> > > > +
> > > Given you haven't removed this code from elsewhere, was the driver re=
lying
> > > on the defaults after reset before this patch?
> > >
> > > I don't mind having this branch as a form of documentation even if th=
at's
> > > true but maybe add a note to the patch description.
> > >
> >
> > I'm not sure if I get you correctly. The driver before only
> > implemented "BYPASS" mode. This was the case w/o a defined
> > interrupt-name. My intention now is to keep this behavior as fallback.
> > If no IRQ is around, i.e. interrupt + interrupt-name, the sensor
> > driver will operate the sensor in BYPASS mode.
> >
> > I was interpreting this also as the "default behavior", you mentioned
> > in the dt-binding patch? Is this correct?
> >
> > What do you mean when the driver is relying on the defaults after reset=
?
>
> The driver worked without irq before now.  Which is same as this path.
> So how was the register written here being configured correctly before
> this patch?  I'm guessing it wasn't and that the value written here
> is the default on power up.
>
> Either that or I'm miss understanding what this branch of the if / else i=
s
> about.

Well, I'm pretty convinced the sensor before was operated in
FIFO_BYPASS mode. TBH I'm not sure now if this is default setting, or
explicitely configured. But I remember that also from somewhere in the
datasheet. That's why I used this as fallback.

> Jonathan
>
> >
> > > > +             fifo_ctl =3D ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPAS=
S);
> > > > +
> > > > +             ret =3D regmap_write(st->regmap, ADXL345_REG_FIFO_CTL=
, fifo_ctl);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +     }
> > > >       return devm_iio_device_register(dev, indio_dev);
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
> > >
> >
>

