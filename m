Return-Path: <linux-iio+bounces-19997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE57AC726E
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 22:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545044E75C3
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E17217F56;
	Wed, 28 May 2025 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWkEZqsZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC41E8326;
	Wed, 28 May 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465614; cv=none; b=O44/DTqPOoyqcXn2OwlTWjV9aUco6I1kvUB4x2z9DlJWRFIznj2/od/xrByY2gL1CRBRWOa47/muSYX0jXMHlLmMJr+hJ0H9l/20mm3WBsUX/rGQHZ58Frpd/9GPS+glpWVofyuu6zy0hQqHculyzaIfdQ8N5ioItsirR7Djrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465614; c=relaxed/simple;
	bh=GK9rmZEaWvSkont9DXH4hkJ1E8KBEgj0tq+4dJf0yKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FO8bxhTI81Xpkm0pTwTHCWmS8gFvGUT9xHaxhbQA9ssNb052EIDj/lBjDdcDpM0cs1yikdvIQbAunFsGgIXK1y3W6A/zPbFzsgUp8/MTlXbMpHnzJdtqZ5E0YunFAZOV8imt6FRtzVi52/a7Eobti2IHp7VchVFkpFf13SmaijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWkEZqsZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7dcab6697cso36118276.2;
        Wed, 28 May 2025 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748465611; x=1749070411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gg0iim+NFxN+GfSzNkmRPTRI9ZD4M9Rf8eT64jyuF4=;
        b=LWkEZqsZxPodP3ieDY/JWhYFovOANXLCkVy09XUgq2Oj0jmrRffveQMNBFgua/aE7Y
         UKSEUZPUWIUoQpjdA4okARFgdZGGL+9KUzq6esedmh1G73AVh/9k14MoQepeuzcnaVYv
         f3vX1CBtyYRHlr9bVqgg/+W+PMY/+dCDw4Z6LiEgSNYoTHiE5R9KPZMKMyQQJFtVbMsH
         6Sxv5/BB2sRL56FmCvBvQRpIvpEqmnc0X5hZWBwnh5TWOomVA/9xdnV+GsoIRxOLhx5h
         67uCeanMPRl6tLXeimfMW5KeSRCChE5b7djL0inHS/oCJedRYM+iXyLPnmCRaWx/h/QO
         6lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748465611; x=1749070411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Gg0iim+NFxN+GfSzNkmRPTRI9ZD4M9Rf8eT64jyuF4=;
        b=HctPC6Fi8e0lBtan+WgYP1VbJO/CqIV+/7tiw+vWEqxZTxsD/SQjnWYwFJ4asB1OxL
         tszQV6rx8dwvkrDVXNz8HO3mfWG4f0YdBB42OC5pj27vhOAtzRCME1LygwbInrtBIlpX
         nWgJ38b+LpTDQX2GGKsvNY/bZMX2vT7rXtiI0jdSsO9xudfd0IW1zksZDivNjeMjpN+D
         C96JERg1xxK20Qichj4bddp5jcZ/n+Bu7h1cZtT5xvSP870w+NF7dX6bNMUYlX8bXOye
         /7dv5ZLv/nRZ+LOtA41a8zv1V5KYxQ3QW//5buEMCNZ86jFlablECFvqikThFPeXwnky
         wkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtMWRMbXERpzKs3dhbNJBvd1UrPZqlQSyzipalTekWkIcMB/l1j6UU+8erpYqMjnhEmBKRrkADIfw=@vger.kernel.org, AJvYcCVa7AsikdbcrlZB89yuyIvQlqyeRidM3/bqpnmL1wcJJEN+CUyqZKD/qtAgUjd9EepYVNucMmOQEYLy@vger.kernel.org, AJvYcCWST3jWvtN+M66EmCSwmOfzBnwtouASqhJuw1yeqSSb6S8gQIe6uiuEJfnYF8Qd6iRUCEVcNduJYLrFga7N@vger.kernel.org
X-Gm-Message-State: AOJu0YzQV5Sp650o/VGhq3/GszFKuyIXv8NDzrup08cN/c3rDQmqz3kl
	J1V92DPLExOUwE9bWNQ5wDy6Yv/lTXY0E8HWSz1f0T73ph1znBj8x8GDN3YOgBEhIfU9IvGbKPG
	XCAYzaU34o4p4YwJ+il+C6TWDKSNzmww=
X-Gm-Gg: ASbGnctH9V/0hXIo6An9jPqrXHDj5gjBLbZylpsGLXSmFAxNuaPTtK9GDglExwX1tg5
	InBDWtWSOsJa8LwVLlZB9rg8VQGlNIZaeZ1SpbF4MenD9oTLoAqmjorhVaVo8RrnoUmiyQj+nka
	EU4Cojh9hzOpgFctvRyHQlRt592+d0EKZE
X-Google-Smtp-Source: AGHT+IEKlfFChx8de4UJ8+CmplgrRoN3Rrg1W449blcHWSvnP/scO2OdDxiwRb4KJpadBqvbiNpi0QmMDaic6sRziTk=
X-Received: by 2002:a05:690c:6d82:b0:70e:572:dd78 with SMTP id
 00721157ae682-70e2d753d7amr102960977b3.0.1748465611000; Wed, 28 May 2025
 13:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523223523.35218-1-l.rubusch@gmail.com> <20250523223523.35218-8-l.rubusch@gmail.com>
 <20250525134831.68b3c905@jic23-huawei>
In-Reply-To: <20250525134831.68b3c905@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 28 May 2025 22:52:55 +0200
X-Gm-Features: AX0GCFu4uDW5WMc3QHfaxcty6jSPrSgIoCyUa4juoUHDtmMuYQrdUFBpLZsUyII
Message-ID: <CAFXKEHaM1xEk-v7rXdKoxdXKV-k=_Leu+hMBukDyKoWr3irVRQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] iio: accel: adxl313: add basic interrupt handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

I feel here either I have some missunderstanding or it needs more
(better?) explanation. Perhaps I'm using the wrong terminology.

One point, I forgot, do I actually need to add a Reviewed-by tag or
something like that for Andys review? Or if so, they will let me know,
I guess?

First of all, introducing the adxl313_fifo_reset(data) here is the
crucial part. So, the title I chose is not matching with the topic, or
is too general. I'll answer and try to better explain down below.

On Sun, May 25, 2025 at 2:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 23 May 2025 22:35:18 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Prepare the interrupt handler. Add register entries to evaluate the
> > incoming interrupt. Add functions to clear status registers and reset t=
he
> > FIFO.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>
> A few comments inline.
>
> > ---
> >  drivers/iio/accel/adxl313.h      |  16 ++++
> >  drivers/iio/accel/adxl313_core.c | 134 +++++++++++++++++++++++++++++++
> >  2 files changed, 150 insertions(+)
>
>
>
> >  struct adxl313_chip_info {
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl3=
13_core.c
> > index 9db318a03eea..1e085f0c61a0 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -10,15 +10,24 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > +#include <linux/overflow.h>
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> >
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/sysfs.h>
>
> This is an odd selection of headers to add now. Why do we need them but d=
idn't
> before?  Some of these aren't used yet so drop them (events.h, sysfs.h I =
think)
>

Agree.

> > +
>
> >  static const struct regmap_range adxl312_readable_reg_range[] =3D {
> >       regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
> >       regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)=
),
> > @@ -62,6 +71,7 @@ bool adxl313_is_volatile_reg(struct device *dev, unsi=
gned int reg)
> >       case ADXL313_REG_DATA_AXIS(4):
> >       case ADXL313_REG_DATA_AXIS(5):
> >       case ADXL313_REG_FIFO_STATUS:
> > +     case ADXL313_REG_INT_SOURCE:
> >               return true;
> >       default:
> >               return false;
> > @@ -363,6 +373,118 @@ static int adxl313_write_raw(struct iio_dev *indi=
o_dev,
> >       }
> >  }
> >
> > +static int adxl313_get_samples(struct adxl313_data *data)
>
> I doubt this gets called from multiple places. I'd just put
> the code inline and no have this helper at all.
>

It will be a called at least in two places. First, when reading the
measurements and second when clearing the fifo in the reset.

> > +{
> > +     unsigned int regval =3D 0;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(data->regmap, ADXL313_REG_FIFO_STATUS, &regva=
l);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> > +}
> > +
> > +static int adxl313_set_fifo(struct adxl313_data *data)
> > +{
> > +     unsigned int int_line;
> > +     int ret;
> > +
> > +     ret =3D adxl313_set_measure_en(data, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(data->regmap, ADXL313_REG_INT_MAP, &int_line)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
> > +                        FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, data=
->fifo_mode));
>
> Check ret.
>

Agree.

> > +
> > +     return adxl313_set_measure_en(data, true);
> > +}
> > +
> > +static int adxl313_fifo_transfer(struct adxl313_data *data, int sample=
s)
> > +{
> > +     size_t count;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     count =3D array_size(sizeof(data->fifo_buf[0]), ADXL313_NUM_AXIS)=
;
> > +     for (i =3D 0; i < samples; i++) {
> > +             ret =3D regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BA=
SE,
> > +                                    data->fifo_buf + (i * count / 2), =
count);
>
> that 2 is I'd guessed based on size of some data store element?
> I'd guess sizeof(data->fifo_buf[0]) is appropriate.
>

My calculation was the following:
* samples :=3D number of "lines" in the FIFO e.g. by watermark
* count :=3D number of bytes per "line"
* ADXL313_NUM_AXIS :=3D 3 for the three axis here
There's a bulk read per "line" of the FIFO. A "line" comprises
measurement for x, y and z axis. Each measurement consists of 2 bytes,
i.e. count has 6 bytes.

At a second look now, probably count/2 can be replaced directly by
ADXL313_NUM_AXIS. If so, I don't need the count variable. I see,
count/2 being already a constant expression here smells somehow. I
guess, this might be your point? I'll change that and need verify.

>
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/**
> > + * adxl313_fifo_reset() - Reset the FIFO and interrupt status register=
s.
> > + * @data: The device data.
> > + *
> > + * Reset the FIFO status registers. Reading out status registers clear=
s the
>
> I think you already read it before calling this. So how is it ever set?
>
> > + * FIFO and interrupt configuration. Thus do not evaluate regmap retur=
n values.
> > + * Ignore particular read register content. Register content is not pr=
ocessed
> > + * any further. Therefore the function returns void.
> > + */
> > +static void adxl313_fifo_reset(struct adxl313_data *data)
>
> As below.  This isn't a reset.  Fifo reset is normally the term used
> for when we have lost tracking of what is in the fifo and drop all data,
> not normal readback.
>
> > +{
> > +     unsigned int regval;
> > +     int samples;
> > +
> > +     adxl313_set_measure_en(data, false);
> Disabling measurement to read a fifo is unusual -  is this really necessa=
ry
> as it presumably puts a gap in the data, which is what we are trying
> to avoid by using a fifo.
>
> > +
> > +     samples =3D adxl313_get_samples(data);
> > +     if (samples > 0)
> > +             adxl313_fifo_transfer(data, samples);
> > +
> > +     regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &regval);
>
> Not processing the convents of INT_SOURCE every time you read it
> introduces race conditions.  This logic needs a rethink so that
> never happens.  I guess this is why you are disabling measurement
> to stop the status changing?  Just whatever each read of INT_SOURCE
> tells us we need to handle and all should be fine without disabling
> measurement.  That read should only clear bits that are set, so no
> race conditions.
>

When the ADXL345 triggers an interrupt for e.g. watermark, data ready,
or overrun,... it will stop from triggerring further interrupts until
the status registers, INT_SOURCE and FIFO_STATUS are cleared. This I
call "reset". In consequence the FIFO will simply run full.

Usually when the interrupt handler reads the interrupt status
(INT_SOURCE). In case of, say, watermark, it then reads the
FIFO_STATUS to obtain number of entries and reads this number of
samples by a linewise bulk read from the sensor DATA registers.
Reading all FIFO entries from the DATA register clears FIFO_STATUS,
and this clears INT_SOURCE.

Now, in case of error or overrun, I'd use this reset function as a
fallback error handling. I stop measurement i.e. I set the sensor to
standby. The sensor should not accept further measurements. Then I
read out the fifo entries to clear FIFO_STATUS and I (already) read
INT_SOURCE to clear interrupt status. Eventually I turn on measurement
to bring the sensor back to operational. I ignore the read
measurements, I'm reading here.

As alternative approaches I also saw for similar sensors (not Linux)
to e.g. switch FIFO_STREAM mode to FIFO_BYPASS and back. This works
here too, but only for the FIFO_STATUS not for INT_SOURCE. Another
idea I can imagine with the ADXL313, there is a soft reset register,
but never tried that.

In this initial patch, the reset function will resume the interrupt
handler function. With the follow up patches, this will form rather
the error handling. It is easy to get into this kind of overrun
situation, if the interrupt handler is still not working correctly.
I'm actually pretty confident, that it now works only as a fallback
error handling, but perhaps I'm doing something wrong here?

> > +
> > +     adxl313_set_measure_en(data, true);
> > +}
> > +
> > +static int adxl313_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > +
> > +     data->fifo_mode =3D ADXL313_FIFO_STREAM;
>
> If you always set fifo_mode before calling _set_fifo() probably better
> to pass the value in as a separate parameter and store it as necessary
> inside that function.
>

It might be that this is even in the cache. I'll verify this.

> > +     return adxl313_set_fifo(data);
> > +}
> > +
> > +static int adxl313_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     data->fifo_mode =3D ADXL313_FIFO_BYPASS;
> > +     ret =3D adxl313_set_fifo(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return regmap_write(data->regmap, ADXL313_REG_INT_ENABLE, 0);
> > +}
> > +
> > +static const struct iio_buffer_setup_ops adxl313_buffer_ops =3D {
> > +     .postenable =3D adxl313_buffer_postenable,
> > +     .predisable =3D adxl313_buffer_predisable,
> > +};
> > +
> > +static irqreturn_t adxl313_irq_handler(int irq, void *p)
> > +{
> > +     struct iio_dev *indio_dev =3D p;
> > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > +     int int_stat;
> > +
> > +     if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
>
> Failure to read is one thing we should handle, but also we should handle
> int_stat telling us there were no interrupts set for this device.
>
> > +             return IRQ_NONE;
> > +
> > +     adxl313_fifo_reset(data);
>
> Given we don't know it had anything to do with the fifo at this point
> resetting the fifo doesn't make much sense.  I'd expect a check
> on int_status, probably for overrun, before doing this.
>
> Ah. On closer inspection this isn't resetting the fifo, it's just
> reading it.  Rename that function and make it dependent on what
> was in int_stat.
>

As mentioned before, I used the term "reset" to clear the status
registers. This can occur for typically overrun, but also would cover
all events which are still not handled by the interrupt handler. I
could give it a try to see if the soft reset here would be a better
fit.

Best,
L

>
> > +
> > +     return IRQ_HANDLED;
> > +}
>

