Return-Path: <linux-iio+bounces-13317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6019EBC27
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 22:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55271887E7D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD52232367;
	Tue, 10 Dec 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrkpV3dS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8F23ED78;
	Tue, 10 Dec 2024 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867720; cv=none; b=k3F65hnMCODXF5ijDD1buQ9DId5XuQ63RQRAsuDXfdgWIJ/IwXCrsRdhJSN6A1N6z7xNr03GLUIO0JfiSwNuE7uy7BAqBdsuZ225W8Nux1YU/WNdx5/vLT1HGHEQDLx0Wf2wPYY0zkxg9TOiYetNORhS5z1tA3B7YWd4uRqUDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867720; c=relaxed/simple;
	bh=fQNFb894IqWEp1FEb6M0sqPrvyKYhDT3CdBh0JQJYmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ft4qkSCOzVHTz+6LWYODT7FVCZP8ashkYqOuRbca5f9k6t5LAkA/Q5XeROEi0QGtyTxItcbqAEr4kw/1BcC//WumwEwtBsGYbUjb45J3hQ4+fVp1sURgJpu77g7Rvc4GCBatDs4LluX0vRdZ2AWgQXq+oyLXVKjZhB/pDRyyCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrkpV3dS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eff98e133cso903097b3.3;
        Tue, 10 Dec 2024 13:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733867717; x=1734472517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E7gXvjrAntpMmUX59kjHa63TxpILYHTXkni1m2LmZY=;
        b=CrkpV3dSZv5QZldxkjDM6ynUfQtI4ksy2Zg3bshoo7rdR7UKe2CSMQbsVLLv4A5Lho
         Mb0A+3Gdhp1pJpzNYo1nZfIeUWP3Txf5oW1nK6tz8viKIX886vZHWs+fOb92burL7jk7
         Y5YZeiPwYOGGB3iy4J+nfTOruDgNmAN+B+C/WqJZ4n6/PGjDkWJTQAEfqqKNJDC0p1ot
         AtLOi1Z7ETymLWZzdd/dARY6Z7x28QTy0iHbc61PldA+QD+dQ0VnHMLtz4kVdoor8IIe
         KXJMzjxqykqBl+EfzVVbAYzvqvBmH1hVPEM8Hzjqx1/NCUwJVnrBIisawmb5jSuUgHLz
         VyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733867717; x=1734472517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E7gXvjrAntpMmUX59kjHa63TxpILYHTXkni1m2LmZY=;
        b=t6dpYflwmPvYzkdP33534YLcG1JhISwrEVQicl52nqLu/N3fy8WEtDdYEZU8y0AyNE
         DTPG5BrzY11pRAxoW6rgIESWF6aUDeKC0W/C4/9v3qlLtWzLvSqKwMNc0YQt3zGapMTN
         4sI8QZrzJ991eNWUm18YeAIpyiWRJFUKh+czCEEDq3tz+RYTK9vQH79vkZo1e1vOS2d1
         JUOcmXo2bTFv91MGwp60YKryGWf6+gHK71CRjvUmcqiWKgcrWcSpSKMxAghRp4e5P1BT
         Hw6rlVewugetMdP0A4XBAdZAidg2UQIQM76rV2WaAzvq72czYDLwNw4xT+q+TsEi8kgb
         VAWg==
X-Forwarded-Encrypted: i=1; AJvYcCV66HKGFgZHg74FH4gHLk/Trq9lOK2I2SCPSbS1qKNApdAczIlA0gRm0xgYn3oKfg0SM+L+Tolx2B+O@vger.kernel.org, AJvYcCWWF8JfB25aGxTknhDvNhF3lVbhT4QfccHpuKO1YxTtdbxZE4Wsb0mjNzioTwtctt/RaepUPVr5Cp5HPhf+@vger.kernel.org, AJvYcCXK7GFd/ERsjq/xmY6RRqGdl5KmjJEsMc6E6gWqF286rPxC+b7vFOEu7RdKjbIHH8ZlzS4FHp4w8tYD@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKXz4b2aig0cNh3GQT0SKHJYDu6uwnN2bDsnLdZGPJdBQta+x
	Y+By7kYH2yur6RzqotYd3n9BlZ3heUyt9rT2qrkrT+dAevhkjhkbKPDXebBLp44fYG5RpP0RjZc
	4ZgujSER2OBWzF9YHkTs1kMDbqqM=
X-Gm-Gg: ASbGncufntSvFufJqBTTSIH2lrRJNKvKCXhXzG2YZcWUpoVAWbZ08hcrUa0qHBLr3mB
	AR829Tc2ZxuaPbAXnOOtS9GWOsuYQ0A9C8hw=
X-Google-Smtp-Source: AGHT+IE2m73Wn4uOCTfjhwfdf4Bucty+Aaf7n+6sjD0S/DDOIAxYXCR5rwZ5oUgzFyCjf4V6q35Vp/iIyVc3WP9nbGU=
X-Received: by 2002:a05:690c:6ac1:b0:6e2:ada7:ab3a with SMTP id
 00721157ae682-6f148036afamr4427847b3.5.1733867716779; Tue, 10 Dec 2024
 13:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-11-l.rubusch@gmail.com>
 <20241208163418.2d57f185@jic23-huawei>
In-Reply-To: <20241208163418.2d57f185@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 10 Dec 2024 22:54:40 +0100
Message-ID: <CAFXKEHaLzrBXNV=dgTrX3CatvCT751x8Lh69mCXebLK=Fh4jFw@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark events
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,
Find my answers down below.
Best,
L

On Sun, Dec 8, 2024 at 5:34=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu,  5 Dec 2024 17:13:43 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add a basic setup for FIFO with configurable watermark. Add a handler
> > for watermark interrupt events and extend the channel for the
> > scan_index needed for the iio channel. The sensor is configurable to us=
e
> > a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode no=
w
> > a watermark can be configured, or disabled by setting 0. Further featur=
es
> > require a working FIFO setup.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Various comments inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 300 +++++++++++++++++++++++++++++++
> >  1 file changed, 300 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 3067a70c54e..58ed82d66dc 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -15,15 +15,28 @@
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
>
> I'm not seeing any use of this header yet.  Bring it in when you need it.
>
> > +#include <linux/iio/kfifo_buf.h>
> >
> >  #include "adxl345.h"
> >
> > +#define ADXL345_FIFO_BYPASS  0
> > +#define ADXL345_FIFO_FIFO    1
> > +#define ADXL345_FIFO_STREAM  2
> > +
> > +#define ADXL345_DIRS 3
> > +
> >  struct adxl345_state {
> >       int irq;
> >       const struct adxl345_chip_info *info;
> >       struct regmap *regmap;
> > +     __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE];
> >       bool fifo_delay; /* delay: delay is needed for SPI */
> >       u8 intio;
> > +     u8 int_map;
> > +     u8 watermark;
> > +     u8 fifo_mode;
> >  };
> >
> >  #define ADXL345_CHANNEL(index, reg, axis) {                           =
       \
> > @@ -36,6 +49,13 @@ struct adxl345_state {
> >       .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |         =
 \
> >               BIT(IIO_CHAN_INFO_SAMP_FREQ),                           \
> >       .scan_index =3D (index),                          \
> > +     .scan_type =3D {                                  \
> > +             .sign =3D 's',                            \
> > +             .realbits =3D 13,                         \
> > +             .storagebits =3D 16,                      \
> > +             .shift =3D 0,                             \
>
> No need to specify shift of 0. It's the 'obvious' default and C will set =
it to 0
> for you anyway.
>
> > +             .endianness =3D IIO_LE,                   \
> > +     },                                              \
> >  }
> >
> >  enum adxl345_chans {
> > @@ -48,6 +68,25 @@ static const struct iio_chan_spec adxl345_channels[]=
 =3D {
> >       ADXL345_CHANNEL(2, chan_z, Z),
> >  };
> >
> > +static int adxl345_set_interrupts(struct adxl345_state *st)
> > +{
> > +     int ret;
> > +     unsigned int int_enable =3D st->int_map;
> > +     unsigned int int_map;
> > +
> > +     /* Any bits set to 0 in the INT map register send their respectiv=
e
>
>         /*
>          * Any bits....
>
>
> > +      * interrupts to the INT1 pin, whereas bits set to 1 send their r=
espective
> > +      * interrupts to the INT2 pin. The intio shall convert this accor=
dingly.
> > +      */
> > +     int_map =3D 0xFF & (st->intio ? st->int_map : ~st->int_map);
> > +
> > +     ret =3D regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enabl=
e);
> > +}
>
>
> > +/**
> > + * adxl345_get_samples() - Read number of FIFO entries.
> > + * @st: The initialized state instance of this driver.
> > + *
> > + * The sensor does not support treating any axis individually, or excl=
ude them
> > + * from measuring.
> > + *
> > + * Return: negative error, or value.
> > + */
> > +static int adxl345_get_samples(struct adxl345_state *st)
> > +{
> > +     unsigned int regval =3D 0;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_FIFO_STATUS, &regval)=
;
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0x3f & regval;
> FIELD_GET() for all stuff like this with appropriate #define for the mask=
.
>
> > +}
> > +
> > +/**
> > + * adxl345_fifo_transfer() - Read samples number of elements.
> > + * @st: The instance of the state object of this sensor.
> > + * @samples: The number of lines in the FIFO referred to as fifo_entry=
,
> > + * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes eac=
h.
> > + *
> > + * It is recommended that a multiple-byte read of all registers be per=
formed to
> > + * prevent a change in data between reads of sequential registers. Tha=
t is to
> > + * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.
>
> Doesn't match the code which is reading just one register lots of times.

This is one of my painpoints, regmap_noinc_read() worked here, for a
linewise reading of FIFO elements. Say, I could read X0, X1, Y0,... Z1
in one command. Also, I tried here regmap_bulk_read(). At all, I find
this solution is working, but I'm not sure if there is not a total
differnt way to do the read out.

> > + *
> > + * Return: 0 or error value.
> > + */
> > +static int adxl345_fifo_transfer(struct adxl345_state *st, int samples=
)
> > +{
> > +     size_t count;
> > +     int i, ret;
> > +
> > +     count =3D sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
> > +     for (i =3D 0; i < samples; i++) {
> > +             ret =3D regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BAS=
E,
> > +                             st->fifo_buf + (i * count / 2), count);
> > +             if (ret < 0)
> > +                     return ret;
>
> This is where I'd expect to see the delay mentioned below.

I agree with the delay, I'll move it.

> > +     }
> > +     return ret;
> > +}
> > +
>
> > +static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     st->int_map =3D 0x00;
> > +
> > +     ret =3D adxl345_set_interrupts(st);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     st->fifo_mode =3D ADXL345_FIFO_BYPASS;
> > +     return adxl345_set_fifo(st);
> I'd normally expect order in predisable to be reverse of that in postenab=
le.
> Why isn't it?  That is why is the set_fifo here after set_interrupts and
> not before it.  Add a comment.
>
> > +}
> > +
> > +static const struct iio_buffer_setup_ops adxl345_buffer_ops =3D {
> > +     .postenable =3D adxl345_buffer_postenable,
> > +     .predisable =3D adxl345_buffer_predisable,
> > +};
> > +
> > +static int adxl345_get_status(struct adxl345_state *st)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return (0xff & regval);
>
> No brackets needed.
>
> > +}
> > +
> > +static int adxl345_fifo_push(struct iio_dev *indio_dev,
> > +                               int samples)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int i, ret;
> > +
> > +     if (samples <=3D 0)
> > +             return -EINVAL;
> > +
> > +     ret =3D adxl345_fifo_transfer(st, samples);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i =3D 0; i < ADXL345_DIRS * samples; i +=3D ADXL345_DIRS) {
> > +             /*
> > +              * To ensure that the FIFO has completely popped, there m=
ust be at least 5
> > +              * us between the end of reading the data registers, sign=
ified by the
> > +              * transition to register 0x38 from 0x37 or the CS pin go=
ing high, and the
> > +              * start of new reads of the FIFO or reading the FIFO_STA=
TUS register. For
> > +              * SPI operation at 1.5 MHz or lower, the register addres=
sing portion of the
> > +              * transmission is sufficient delay to ensure the FIFO ha=
s completely
> > +              * popped. It is necessary for SPI operation greater than=
 1.5 MHz to
> > +              * de-assert the CS pin to ensure a total of 5 us, which =
is at most 3.4 us
> > +              * at 5 MHz operation.
> > +              */
> > +             if (st->fifo_delay && (samples > 1))
> > +                     udelay(3);
>
> I'm not following why a delay here helps.  At this point you're read mass=
es of
> data from the fifo without the delays you mention.
>
> > +
> > +             iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * adxl345_event_handler() - Handle events of the ADXL345.
>
> Up to you but...
> Given it's an IIO driver and that we have a very specific meaning
> for events, maybe just call this adxl345_irq_handler()?
>
> > + * @irq: The irq being handled.
> > + * @p: The struct iio_device pointer for the device.
> > + *
> > + * Return: The interrupt was handled.
> > + */
> > +static irqreturn_t adxl345_event_handler(int irq, void *p)
> > +{
> > +     struct iio_dev *indio_dev =3D p;
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     u8 int_stat;
> > +     int samples;
> > +
> > +     int_stat =3D adxl345_get_status(st);
> > +     if (int_stat < 0)
> > +             return IRQ_NONE;
> > +
> > +     if (int_stat =3D=3D 0x0)
> Doesn't this correspond to 'not our interrupt'?
> If that's the case return IRQ_NONE is the right way to go and not reset t=
he
> interrupt.  You have registered it as maybe shared, and if it is, then th=
is
> is a common thing to happen as interrupt from another device.
>

Here I see actually
+     int_stat =3D adxl345_get_status(st);
+     if (int_stat < 0)
+             return IRQ_NONE; // a bus error, reading register not possibl=
e
...and then...
+     if (int_stat =3D=3D 0x0)
+             // interrupt sources were 0, so IRQ not from our sensor

I'm unsure if the first IRQ_NONE here is actually correct. I mean, if
the bus is not working,
actually any IRQ usage should be considered broken. Is there a way to
break out of measuring?

> > +             goto err;
> > +
> > +     if (int_stat & ADXL345_INT_OVERRUN)
> > +             goto err;
> > +
> > +     if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) =
{
>
> I think you only ever enable the INT_WATERMARK?  If so does it
> make sense to check for DATA_READY as well?
>

Watermark comes usually with data ready or overrun. I guess for the
FIFO watermark, just evaluating watermark is probably sufficient. For
other events, it then might be notification w/ a data ready set.
Probably better to introduce data ready when it's actually really
needed?

> > +             samples =3D adxl345_get_samples(st);
> > +             if (samples < 0)
> > +                     goto err;
> > +
> > +             if (adxl345_fifo_push(indio_dev, samples) < 0)
> > +                     goto err;
> > +
> > +     }
> > +     return IRQ_HANDLED;
> > +
> > +err:
> > +     adxl345_fifo_reset(st);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  static const struct iio_info adxl345_info =3D {
> >       .attrs          =3D &adxl345_attrs_group,
> >       .read_raw       =3D adxl345_read_raw,
> >       .write_raw      =3D adxl345_write_raw,
> >       .write_raw_get_fmt      =3D adxl345_write_raw_get_fmt,
> > +     .hwfifo_set_watermark =3D adxl345_set_watermark,
> >  };
> >
> >  /**
> > @@ -222,6 +499,7 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap,
> >       unsigned int data_format_mask =3D (ADXL345_DATA_FORMAT_RANGE |
> >                                        ADXL345_DATA_FORMAT_FULL_RES |
> >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> > +     u8 fifo_ctl;
> >       int ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > @@ -293,6 +571,28 @@ int adxl345_core_probe(struct device *dev, struct =
regmap *regmap,
> >       if (ret < 0)
> >               return dev_err_probe(dev, ret, "Failed to add action or r=
eset\n");
> >
> > +     if (st->irq > 0) {
> > +             dev_dbg(dev, "initialize for FIFO_STREAM mode\n");
> > +
> > +             ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl=
345_buffer_ops);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D devm_request_threaded_irq(dev, st->irq, NULL, &ad=
xl345_event_handler,
> > +                             IRQF_SHARED | IRQF_ONESHOT,
> > +                             indio_dev->name, indio_dev);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret, "Failed to setup t=
riggered buffer\n");
> > +
> > +     } else {
> > +             dev_dbg(dev, "initialize for FIFO_BYPASS mode (fallback)\=
n");
> > +
> Given you haven't removed this code from elsewhere, was the driver relyin=
g
> on the defaults after reset before this patch?
>
> I don't mind having this branch as a form of documentation even if that's
> true but maybe add a note to the patch description.
>

I'm not sure if I get you correctly. The driver before only
implemented "BYPASS" mode. This was the case w/o a defined
interrupt-name. My intention now is to keep this behavior as fallback.
If no IRQ is around, i.e. interrupt + interrupt-name, the sensor
driver will operate the sensor in BYPASS mode.

I was interpreting this also as the "default behavior", you mentioned
in the dt-binding patch? Is this correct?

What do you mean when the driver is relying on the defaults after reset?

> > +             fifo_ctl =3D ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
> > +
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fi=
fo_ctl);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> >       return devm_iio_device_register(dev, indio_dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
>

