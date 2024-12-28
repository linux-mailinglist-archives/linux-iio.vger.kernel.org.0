Return-Path: <linux-iio+bounces-13847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE739FDBA5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545703A1240
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269051917D9;
	Sat, 28 Dec 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byEfoN6B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50F382;
	Sat, 28 Dec 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735402357; cv=none; b=IWSS5uj7fDSJp6GnWVEhXxmARFK4WKE89ZDcyUqi6ULTxCA/Uo9y3E4/zmkzxi77JrIRe08BBnZNgwwFIyDz/VeUomD5WJGVYPze/U+kAzIY5tchiF3BFfzNq+Uy+i8RdsOUYiz/UE0rSUK/wzvDDS/Prw/C0gonSWX2YiXGEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735402357; c=relaxed/simple;
	bh=f/XiG2jZ8PzIQlX0GgztbsbJkxp42VlhUgoH8LM204Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz42Eiz92q1xjZM3t4XVtL5yCxGcU5342LD0qcb2T1dupc5BBwIj/y9yQaXDXqfzKh0EBuuwAUyFH4k7FYjODu5Z1l9BeWsqw0Xp9mR1lA221VB3YJqWEUXc/UTjgInxl+V76kq1xHQXUEWLxLbn4oQpPA2XoR4Kd3lRu10y8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byEfoN6B; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5411de729bso205330276.2;
        Sat, 28 Dec 2024 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735402355; x=1736007155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piHbCMr+fAYjzNFmCD2eg5aU0bQw5yPG+B3xbHoPE3s=;
        b=byEfoN6BvsbxkaUqA+UlpCeobuA3XFczuPo0Wv6TEGe10zRllJSTu4LUOZZOEW5HgP
         6M6hR2BjVSGUaUnQ7kfQ3eKZjuI3tw5aw/6BluRwvIj7Ho5hvfxno2bkp5FhX8i1aKK+
         tRxgqciR/wo2622r/mZLR0OQ4AHfnVW104ur68Ot8FjhqzwKUbnM6a6rc4G3/2c8GEC3
         N2FBcpQ3QQSflozv7s+okQnBjhKxJvS1OSAVFwUdmZOrTG1ktvf735OQqOsa8Xrvo6lU
         +GkP7IMtF53lLglBtCSxSK+IAUF4I8JaxhTiSDqLb0RELFzvU3UQ8LRaNtwxogdqEnnD
         V2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735402355; x=1736007155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piHbCMr+fAYjzNFmCD2eg5aU0bQw5yPG+B3xbHoPE3s=;
        b=WEGZW9rVvWCit9qIz7MZ7k9aMNhHKcXgEQwD/KRc+X8BXOP9jm0q6BQr7awNqsON7d
         HqTHH/Stpc1KUIwAXlVFXWl4DC9qaNL4WyF/qMKffR2gSZUd75QzOB0B5yzbgHB5RzOo
         XJyCQMWUwGKRa7zGJs4pjUxNyMeufGDo5GucPXo4dzH0HaRV8Q79wXpOtVb6Ns2cjh3H
         FJTUUD0oCOtvNwONcrI9f083HGc7FNK69HUh+S4D0bobyjnGpQW5G9ZVxjwxdQBlKqiC
         Je6MmmuvpXJ6RpFgho/6mL1v54lPEAWO70yn8fUfzhZKTOWhK7sejJef71XUOq4+FTwg
         crkA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ukwbEgPU2OfFR4dDQN8uiKIh3AnBQl50zkxWnZAr4DABlo1eo0hODBesyfIU+K8TJvQKLqFLqcsX@vger.kernel.org, AJvYcCXAtH52c4KoLa6D9ZhRn0JY3oVHoJuSW98Nwv8NqumG0h/qJvl7qhwTACD5Z/oiFT/SN3994ACghuFGXe7o@vger.kernel.org, AJvYcCXFWPY9KMODS53SZ1hEO9QMCMafeyLPLTPRv4N1AYb6JWKvaZlFAmOSd3XZhvjEAnh6EKlyy0dLHsDk@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWZSEovvtxIl6sBbUsEg3ak0ZtexeA/j43s3y/lfERa3LFXzT
	rfestyxLzR1LC+YR6rb5DIYHB4/VoiFLclZRH57R37KQNIIwSNU7AOIkLazjoB+kSFlcjo/3wrC
	uqPTJ4kUoGdTqwaEI4TUyXL3Gj+A=
X-Gm-Gg: ASbGncsK+uR5XVbcXJnCX7HjCvzNkqrE9+LiD9Kz8Vijy6GJr2JouSvj4aM0W+TsO4l
	+tzd/NEr5ySfSdDjQCkZyZGSWQbJJFAHOfxfqWg==
X-Google-Smtp-Source: AGHT+IHiCr1iP1ziJz96WDE5XGfnM7G/fF6E/E26D//kZtAeea95Uuv1fr6/CfH0CQU0yBZ4/oTEmlTubzwC2IQoNac=
X-Received: by 2002:a05:6902:1ac3:b0:e48:c695:ef12 with SMTP id
 3f1490d57ef6-e538c2654cdmr8961370276.5.1735402354602; Sat, 28 Dec 2024
 08:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241225181338.69672-1-l.rubusch@gmail.com> <20241225181338.69672-7-l.rubusch@gmail.com>
 <20241228144536.12e2e8a5@jic23-huawei>
In-Reply-To: <20241228144536.12e2e8a5@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 28 Dec 2024 17:11:58 +0100
Message-ID: <CAFXKEHbVFsv2pQvPc-0aHCPmCJ0=RX2ezYrXf1PeMq1QUwf7ZA@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] iio: accel: adxl345: add FIFO with watermark events
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 3:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 25 Dec 2024 18:13:37 +0000
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
> > ---
> >  drivers/iio/accel/adxl345.h      |  27 ++-
> >  drivers/iio/accel/adxl345_core.c | 305 ++++++++++++++++++++++++++++++-
> >  2 files changed, 321 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index 6f39f16d3..bf9e86cff 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -15,18 +15,32 @@
> >  #define ADXL345_REG_OFS_AXIS(index)  (ADXL345_REG_OFSX + (index))
> >  #define ADXL345_REG_BW_RATE          0x2C
> >  #define ADXL345_REG_POWER_CTL                0x2D
> > +#define ADXL345_REG_INT_ENABLE               0x2E
> > +#define ADXL345_REG_INT_MAP          0x2F
> > +#define ADXL345_REG_INT_SOURCE               0x30
> > +#define ADXL345_REG_INT_SOURCE_MSK   0xFF
> >  #define ADXL345_REG_DATA_FORMAT              0x31
> > -#define ADXL345_REG_DATAX0           0x32
> > -#define ADXL345_REG_DATAY0           0x34
> > -#define ADXL345_REG_DATAZ0           0x36
> > -#define ADXL345_REG_DATA_AXIS(index) \
> > -     (ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> > +#define ADXL345_REG_XYZ_BASE         0x32
> > +#define ADXL345_REG_DATA_AXIS(index)                         \
> > +     (ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
> >
> > +#define ADXL345_REG_FIFO_CTL         0x38
> > +#define ADXL345_REG_FIFO_STATUS      0x39
> > +#define ADXL345_REG_FIFO_STATUS_MSK  0x3F
> > +
> > +#define ADXL345_FIFO_CTL_SAMPLES(x)  FIELD_PREP(GENMASK(4, 0), x)
> These need linux/bitfield.h to be included.
>

Sure, I can do this.

> However, that got me looking closer at this and it should be done
> differently.
>
> Just define the masks in here and put the FIELD_PREP() inline in the
> c file.  Same for the various other FIELD_PREP macros in here.
>
> It may seem convenient to wrap all this up here, but in general
> I'd rather see that these are simple FIELD_PREP() calls where they
> are used inline.
>

Ok, I understand, the masks stay in the adxl345.h and the FIELD_RPEP()
macros better go to where they are used, i.e. the adxl345_core.c.

Thank you for reviewing this. I was a bit unsure about using the
FIELD_PREP() / GENMASK() combinations correctly. The code seems to
work for me, though. For future usage of those macros: Generally my
usage of those macros is correct?

Do I understand correctly, on the long run it would generally be
cleaner, also to migrate the defines to the adxl345_core.c? IMHO,
probably most of the constants in the adxl345.h can be private to
adxl345_core.c, and probably better should.

Best regards,
L

> Thanks,
>
> Jonathan
>
> > +/* 0: INT1, 1: INT2 */
> > +#define ADXL345_FIFO_CTL_TRIGGER(x)  FIELD_PREP(BIT(5), x)
> > +#define ADXL345_FIFO_CTL_MODE(x)     FIELD_PREP(GENMASK(7, 6), x)
> > +
> > +#define ADXL345_INT_DATA_READY               BIT(7)
> > +#define ADXL345_INT_WATERMARK                BIT(1)
> > +#define ADXL345_INT_OVERRUN          BIT(0)
> >  #define ADXL345_BW_RATE                      GENMASK(3, 0)
> >  #define ADXL345_BASE_RATE_NANO_HZ    97656250LL
> >
> > -#define ADXL345_POWER_CTL_MEASURE    BIT(3)
> >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > +#define ADXL345_POWER_CTL_MEASURE    BIT(3)
> >
> >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0)   /* Set the g rang=
e */
> >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2)  /* Left-justified (MSB) m=
ode */
> > @@ -40,6 +54,7 @@
> >  #define ADXL345_DATA_FORMAT_16G              3
> >
> >  #define ADXL345_DEVID                        0xE5
> > +#define ADXL345_FIFO_SIZE            32
> >
> >  /*
> >   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 987a0fe03..738960298 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -15,9 +15,17 @@
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer.h>
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
> >  #define ADXL345_INT_NONE             0xff
> >  #define ADXL345_INT1                 0
> >  #define ADXL345_INT2                 1
> > @@ -28,25 +36,66 @@ struct adxl345_state {
> >       bool fifo_delay; /* delay: delay is needed for SPI */
> >       int irq;
> >       u8 intio;
> > +     u8 int_map;
> > +     u8 watermark;
> > +     u8 fifo_mode;
> > +     __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(I=
IO_DMA_MINALIGN);
> >  };
> >
> > -#define ADXL345_CHANNEL(index, axis) {                                =
       \
> > +#define ADXL345_CHANNEL(index, reg, axis) {                           =
       \
> >       .type =3D IIO_ACCEL,                                             =
 \
> >       .modified =3D 1,                                                 =
 \
> >       .channel2 =3D IIO_MOD_##axis,                                    =
 \
> > -     .address =3D index,                                              =
 \
> > +     .address =3D (reg),                                              =
 \
> >       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |                 =
 \
> >               BIT(IIO_CHAN_INFO_CALIBBIAS),                           \
> >       .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |         =
 \
> >               BIT(IIO_CHAN_INFO_SAMP_FREQ),                           \
> > +     .scan_index =3D (index),                          \
> > +     .scan_type =3D {                                  \
> > +             .sign =3D 's',                            \
> > +             .realbits =3D 13,                         \
> > +             .storagebits =3D 16,                      \
> > +             .endianness =3D IIO_LE,                   \
> > +     },                                              \
> >  }
> >
> > +enum adxl345_chans {
> > +     chan_x, chan_y, chan_z,
> > +};
> > +
> >  static const struct iio_chan_spec adxl345_channels[] =3D {
> > -     ADXL345_CHANNEL(0, X),
> > -     ADXL345_CHANNEL(1, Y),
> > -     ADXL345_CHANNEL(2, Z),
> > +     ADXL345_CHANNEL(0, chan_x, X),
> > +     ADXL345_CHANNEL(1, chan_y, Y),
> > +     ADXL345_CHANNEL(2, chan_z, Z),
> >  };
> >
> > +static const unsigned long adxl345_scan_masks[] =3D {
> > +     BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
> > +     0
> > +};
> > +
> > +static int adxl345_set_interrupts(struct adxl345_state *st)
> > +{
> > +     int ret;
> > +     unsigned int int_enable =3D st->int_map;
> > +     unsigned int int_map;
> > +
> > +     /*
> > +      * Any bits set to 0 in the INT map register send their respectiv=
e
> > +      * interrupts to the INT1 pin, whereas bits set to 1 send their r=
espective
> > +      * interrupts to the INT2 pin. The intio shall convert this accor=
dingly.
> > +      */
> > +     int_map =3D FIELD_GET(ADXL345_REG_INT_SOURCE_MSK,
> > +                         st->intio ? st->int_map : ~st->int_map);
> > +
> > +     ret =3D regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enabl=
e);
> > +}
> > +
> >  static int adxl345_read_raw(struct iio_dev *indio_dev,
> >                           struct iio_chan_spec const *chan,
> >                           int *val, int *val2, long mask)
> > @@ -132,6 +181,24 @@ static int adxl345_write_raw(struct iio_dev *indio=
_dev,
> >       return -EINVAL;
> >  }
> >
> > +static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned i=
nt value)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     unsigned int fifo_mask =3D 0x1F;
> > +     int ret;
> > +
> > +     value =3D min(value, ADXL345_FIFO_SIZE - 1);
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_FIFO_CTL, fifo=
_mask, value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     st->watermark =3D value;
> > +     st->int_map |=3D ADXL345_INT_WATERMARK;
> > +
> > +     return 0;
> > +}
> > +
> >  static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
> >                                    struct iio_chan_spec const *chan,
> >                                    long mask)
> > @@ -186,11 +253,217 @@ static const struct attribute_group adxl345_attr=
s_group =3D {
> >       .attrs =3D adxl345_attrs,
> >  };
> >
> > +static int adxl345_set_fifo(struct adxl345_state *st)
> > +{
> > +     int ret;
> > +
> > +     /* FIFO should only be configured while in standby mode */
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(st->regmap, ADXL345_REG_FIFO_CTL,
> > +                        ADXL345_FIFO_CTL_SAMPLES(st->watermark) |
> > +                        ADXL345_FIFO_CTL_TRIGGER(st->intio) |
> > +                        ADXL345_FIFO_CTL_MODE(st->fifo_mode));
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return adxl345_set_measure_en(st, true);
> > +}
> > +
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
> > +     return FIELD_GET(ADXL345_REG_FIFO_STATUS_MSK, regval);
> > +}
> > +
> > +/**
> > + * adxl345_fifo_transfer() - Read samples number of elements.
> > + * @st: The instance of the state object of this sensor.
> > + * @samples: The number of lines in the FIFO referred to as fifo_entry=
.
> > + *
> > + * It is recommended that a multiple-byte read of all registers be per=
formed to
> > + * prevent a change in data between reads of sequential registers. Tha=
t is to
> > + * read out the data registers X0, X1, Y0, Y1, Z0, Z1, i.e. 6 bytes at=
 once.
> > + *
> > + * Return: 0 or error value.
> > + */
> > +static int adxl345_fifo_transfer(struct adxl345_state *st, int samples=
)
> > +{
> > +     size_t count;
> > +     int i, ret =3D 0;
> > +
> > +     /* count is the 3x the fifo_buf element size, hence 6B */
> > +     count =3D sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
> > +     for (i =3D 0; i < samples; i++) {
> > +             /* read 3x 2 byte elements from base address into next fi=
fo_buf position */
> > +             ret =3D regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE=
,
> > +                                    st->fifo_buf + (i * count / 2), co=
unt);
> > +             if (ret < 0)
> > +                     return ret;
> > +
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
> > +             if (st->fifo_delay && samples > 1)
> > +                     udelay(3);
> > +     }
> > +     return ret;
> > +}
> > +
> > +/**
> > + * adxl345_fifo_reset() - Empty the FIFO in error condition.
> > + * @st: The instance to the state object of the sensor.
> > + *
> > + * Read all elements of the FIFO. Reading the interrupt source registe=
r
> > + * resets the sensor.
> > + */
> > +static void adxl345_fifo_reset(struct adxl345_state *st)
> > +{
> > +     int regval;
> > +     int samples;
> > +
> > +     adxl345_set_measure_en(st, false);
> > +
> > +     samples =3D adxl345_get_samples(st);
> > +     if (samples > 0)
> > +             adxl345_fifo_transfer(st, samples);
> > +
> > +     regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
> > +
> > +     adxl345_set_measure_en(st, true);
> > +}
> > +
> > +static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     ret =3D adxl345_set_interrupts(st);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     st->fifo_mode =3D ADXL345_FIFO_STREAM;
> > +     return adxl345_set_fifo(st);
> > +}
> > +
> > +static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     st->fifo_mode =3D ADXL345_FIFO_BYPASS;
> > +     ret =3D adxl345_set_fifo(st);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     st->int_map =3D 0x00;
> > +     return adxl345_set_interrupts(st);
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
> > +     return FIELD_GET(ADXL345_REG_INT_SOURCE_MSK, regval);
> > +}
> > +
> > +static int adxl345_fifo_push(struct iio_dev *indio_dev,
> > +                          int samples)
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
> > +     for (i =3D 0; i < ADXL345_DIRS * samples; i +=3D ADXL345_DIRS)
> > +             iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * adxl345_irq_handler() - Handle irqs of the ADXL345.
> > + * @irq: The irq being handled.
> > + * @p: The struct iio_device pointer for the device.
> > + *
> > + * Return: The interrupt was handled.
> > + */
> > +static irqreturn_t adxl345_irq_handler(int irq, void *p)
> > +{
> > +     struct iio_dev *indio_dev =3D p;
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int int_stat;
> > +     int samples;
> > +
> > +     int_stat =3D adxl345_get_status(st);
> > +     if (int_stat <=3D 0)
> > +             return IRQ_NONE;
> > +
> > +     if (int_stat & ADXL345_INT_OVERRUN)
> > +             goto err;
> > +
> > +     if (int_stat & ADXL345_INT_WATERMARK) {
> > +             samples =3D adxl345_get_samples(st);
> > +             if (samples < 0)
> > +                     goto err;
> > +
> > +             if (adxl345_fifo_push(indio_dev, samples) < 0)
> > +                     goto err;
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
> > @@ -221,6 +494,7 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap,
> >                                        ADXL345_DATA_FORMAT_JUSTIFY |
> >                                        ADXL345_DATA_FORMAT_FULL_RES |
> >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> > +     u8 fifo_ctl;
> >       int ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > @@ -239,6 +513,7 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap,
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> >       indio_dev->channels =3D adxl345_channels;
> >       indio_dev->num_channels =3D ARRAY_SIZE(adxl345_channels);
> > +     indio_dev->available_scan_masks =3D adxl345_scan_masks;
> >
> >       if (setup) {
> >               /* Perform optional initial bus specific configuration */
> > @@ -289,6 +564,26 @@ int adxl345_core_probe(struct device *dev, struct =
regmap *regmap,
> >                       st->intio =3D ADXL345_INT_NONE;
> >       }
> >
> > +     if (st->intio !=3D ADXL345_INT_NONE) {
> > +             /* FIFO_STREAM mode is going to be activated later */
> > +             ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl=
345_buffer_ops);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D devm_request_threaded_irq(dev, st->irq, NULL,
> > +                                             &adxl345_irq_handler,
> > +                                             IRQF_SHARED | IRQF_ONESHO=
T,
> > +                                             indio_dev->name, indio_de=
v);
> > +             if (ret)
> > +                     return ret;
> > +     } else {
> > +             /* FIFO_BYPASS mode */
> > +             fifo_ctl =3D ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fi=
fo_ctl);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> >       return devm_iio_device_register(dev, indio_dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
>

