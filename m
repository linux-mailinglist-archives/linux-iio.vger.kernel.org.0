Return-Path: <linux-iio+bounces-16781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F35BA5FBB8
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC9816A521
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E12698AE;
	Thu, 13 Mar 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5fzmoU7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFE26982E;
	Thu, 13 Mar 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883388; cv=none; b=j7oY9L+g5u/RZ3nurswdziL7Oix8B03g53nKMwrkej1/Z4FP3JgPFNXEzHgfWR4M3dQZoCsUVTrT0CjwfBfQsi6oBHTP0lCc/LDIY8Vyonuvw33hqQSKE85nmVAC8vCrA6lAD4w5ecmXtOB6WrqHNE+JIElvQfH+y/WWrp8N7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883388; c=relaxed/simple;
	bh=vu+WsiknG6iUDrXpUia0LQ5dXF+xVOwv3DCgcusjSrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh+edKC9zHuAFUeS6IZ60l/rtV7oetnZi+VMsSF3BYt4QNTr94GAXZO2n47ceehcgRGB5NRq4W/nP3lPbp18liYdIRjDZgg3jtu27p4lDxKFmXytn5kS6Bk07VBB9DrKr5/F0W09PNrVH2QHEy0fz53zlabVEZZb4mfR0Hvbbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5fzmoU7; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5dbca2b787so151922276.2;
        Thu, 13 Mar 2025 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883385; x=1742488185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNiRZ77hzFeyCNLXebrBhAMWf5VIczec18g8T4FcXCA=;
        b=P5fzmoU7oy+q2Zlqz5MQ37FiVSixBFM4xBqbxstrVgHKY9vXwNY8H2pmsxcJm7GjkI
         BmH+rCB26T2EPknRF3mBH2JHOEGZMFX7ZGr95p8Hxz9xW6lCDWf7i3OHk1wKSqOOs878
         Y0gv31Src5mvb6oBQsvL/UZOONwb/6B7KaSv3uRBOq0uPiLM3UfHxr3630d5XbtWlvyG
         eNHQlDUJw32PhDpM/XHkN5UC4Uz9B2XKMuR1ELyFn8gwPDrVC6UzACll57whgUfA2ke4
         tnb2nwIVbOsfZvNBehX4P6cfCA8AfGcprhMZ/gfFGL5iz+pzuXmt6GzjqkYrPCR6hXq6
         jBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883385; x=1742488185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNiRZ77hzFeyCNLXebrBhAMWf5VIczec18g8T4FcXCA=;
        b=sncIT111n+Tbmr6y31AQwdGOQsZxqsvADOh2lLKf88braiGzN/sOmZwW0lDRD4qD9A
         RGcVIboElXoeIR4bV+jWQ2Zx3zthwIdJWYGCOvKC4Zw4LLDkSpOLl09wukZ5ThtE8CWz
         P1ZjE8/PVrJVoSsODHi6NcTHajexBz3qlDbXPzNI/zOEQ7dS00qKgBF+GYRt9IeEWVzN
         LntIuyVFgkfbpUp1c+eBfqqCzaKDyLGd4sZcubZGMjze2EoaAakaeQ7RwK0ed/13jL28
         gQ41sWacDWaeGvNSzwe0v7EJpVC1c067ruw9lKLdXVUDa+I9C0z/mVvQ+MPj414YBfvW
         rCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCflZVxO+vdwmwRCKo7ezttL/pRl32CZUuHQwHsCFAgK4/v777gfUh2I7Z9DHcekxwoUa+f5tUzQQ=@vger.kernel.org, AJvYcCVwJT+GIHhXwQvUgK+A3HRHYf9p3DA9gphJbuajl3P8eydG2XO0H/kClR4/Rb3et3gZG1AiXmnRHst0eR+U@vger.kernel.org
X-Gm-Message-State: AOJu0YyJphbzPK51C1RqMKPvbJ9FYyUhidNClZPkChhQ+ROts4Rv52q9
	1O1iOZWEkfpSAHVCMJi8NBgJoQTkGxkCuhUtdHrq3FLthksrIqybdBYI8FYzP54dHjLGB8dDEva
	3N8k1e+dqV339nttzqvrhYNKUDYLCOws8
X-Gm-Gg: ASbGnct5/1VS82xr+cDIFI7nlbPHblAYiSUmi1LRbLytVBJ81SaDilWenuK+gkG9/x7
	lxlOdYyHNsxcdW11zoVxxxhld0yk9ZTAVJ3GakzQARlQmZWv8ju3BFgwrGyO7Lf7kMSUODnkZCU
	etlh1oqZTbOgSo6+vaHmG0u4XNgg==
X-Google-Smtp-Source: AGHT+IGC++v3lGqaqO3Yn//+6Oos8Cg+xRCzBXLsAHz9PRXhd7abU5iKlxNZQdCizapI75vgruiU7jHR6y8a6un1DZA=
X-Received: by 2002:a05:6902:120b:b0:e60:aa9c:8c94 with SMTP id
 3f1490d57ef6-e63b517860dmr6397207276.4.1741883385084; Thu, 13 Mar 2025
 09:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104234.40958-1-l.rubusch@gmail.com> <20250220104234.40958-7-l.rubusch@gmail.com>
 <20250302121436.32f96b35@jic23-huawei>
In-Reply-To: <20250302121436.32f96b35@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 13 Mar 2025 17:29:08 +0100
X-Gm-Features: AQ5f1JoVeEROo5B2P7WRe0LdLTbW_GDA6mJB2X3WlxgX8Z3829xuU2JHTH-cMqE
Message-ID: <CAFXKEHbV-PP8jLiW2+7Jc00Q_DWjoj==a7MOO=nE6_t-2wbCCQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] iio: accel: adxl345: add single tap feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

I prepared, reorganized and tested a v4 patch set. Given that I see
how busy you must be these days with current increased mail traffic
just in IIO ML when I compare it to some years ago,
I don't want to bother you too much.
Some particular doubts I will inline down below. If possible with your
work flow and to avoid giving you extra work, I'd like to ask you to
read the questions here, but to give your answers right to the
v4 patch set (so, i.e. after having seen the current state of source).
It also should make my points
a bit clearer. Anyway, this is just my idea, since I'm always happy
about any feedback!

On Sun, Mar 2, 2025 at 1:14=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 20 Feb 2025 10:42:25 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the single tap feature with a threshold in 62.5mg/LSB points and a
> > scaled duration in us. Keep singletap threshold in regmap cache but
> > the scaled value of duration in us as member variable.
> >
> > Both use IIO channels for individual enable of the x/y/z axis. Initiali=
zes
> > threshold and duration with reasonable content. When an interrupt is
> > caught it will be pushed to the according IIO channel.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 364 ++++++++++++++++++++++++++++++-
> >  1 file changed, 362 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 0cee81bc1877..d05593c0d513 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/property.h>
> > @@ -17,6 +18,7 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> >  #include <linux/iio/kfifo_buf.h>
> >
> >  #include "adxl345.h"
> > @@ -31,6 +33,33 @@
> >  #define ADXL345_INT1                 0
> >  #define ADXL345_INT2                 1
> >
> > +#define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> This is a bit confusing.  Here we have a mask for axis that
> has 3 bits.
> > +
> > +enum adxl345_axis {
> > +     ADXL345_Z_EN =3D BIT(0),
> > +     ADXL345_Y_EN =3D BIT(1),
> > +     ADXL345_X_EN =3D BIT(2),
> > +     /* Suppress double tap detection if value > tap threshold */
> > +     ADXL345_TAP_SUPPRESS =3D BIT(3),
> and here an enum that is closely related with 4.

I see your point. There are several registers used in the sensor for
directions. A status register for tap and activity directions, and a
activity/inactivity direction register. For Tap, direction enables are
stored using the suppress bit in the fourth position. All those
locations use actually four bit. Partly the upper four, partly the
lower four. That's why I use here four bit for reading and writing.
The locations 0, 1, 2 then can be used directly. Location 3 only
applies to tap detection.

I'll keep this in v4 patches, and hope to understand you correctly
that this is not a "real" issue?

>
> > +};
> ...
>
> >  enum adxl345_chans {
> > @@ -83,6 +128,7 @@ bool adxl345_is_volatile_reg(struct device *dev, uns=
igned int reg)
> >       case ADXL345_REG_DATA_AXIS(3):
> >       case ADXL345_REG_DATA_AXIS(4):
> >       case ADXL345_REG_DATA_AXIS(5):
> > +     case ADXL345_REG_ACT_TAP_STATUS:
>
> ah.   I thought this had a full list from earlier patches.
> Move this and any later additions back to patch 4.
>
> >       case ADXL345_REG_FIFO_STATUS:
> >       case ADXL345_REG_INT_SOURCE:
> >               return true;
> > @@ -112,6 +158,117 @@ static int adxl345_set_measure_en(struct adxl345_=
state *st, bool en)
> >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> >  }
> >
> > +/* tap */
> > +
> > +static int adxl345_write_tap_axis(struct adxl345_state *st,
> > +                               enum adxl345_axis axis, bool en)
> > +{
> > +     st->tap_axis_ctrl =3D FIELD_GET(ADXL345_REG_TAP_AXIS_MSK,
> > +                                   en ? st->tap_axis_ctrl | axis
> > +                                   : st->tap_axis_ctrl & ~axis);
> > +
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
> > +                               ADXL345_REG_TAP_AXIS_MSK,
> > +                               FIELD_PREP(ADXL345_REG_TAP_AXIS_MSK,
> > +                                          st->tap_axis_ctrl));
> Given that mask is bottom few bits anyway and you can just define the
> tap axis as separate fields.
>
> See below, but I would push the IIO_MOD values down into here. Put the sw=
itch
> per axis in at this level and then use a simple if statement to
> call regmap_clear_bits() / regmap_set_bits() based on enable.
>

Thank you for this hint. I  reimplemented that, though, I was guessing
quite a bit
how you might like to have the source. Please have a look into
upcoming v4 series and let me
know if I got it wrong.

> > +}
>
> ...
>
> > +static int adxl345_is_tap_en(struct adxl345_state *st,
> > +                          enum adxl345_tap_type type, bool *en)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *en =3D (adxl345_tap_int_reg[type] & regval) > 0;
>
> Could use 0/1 return rather than passing a paramter for the output.
> I don't mind much either way.
>

Hum. I took this rather as suggestion, and I will keep this as is for
now. I'm a bit unsure, on
the one side I'm using the return value for error handling (return
ret), on the other side there
is the enable. If using enable in the return, this would mix up, but
probably not a big issue.
It feels rather then to me, if the function is really needed, or if I
can put this in another place.
Anyway, I think it could/should be fine like that. Let me know in v4
context, what you think.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_singletap_en(struct adxl345_state *st,
> I'd push the IIO modifier in here instead of axis.
> > +                                 enum adxl345_axis axis, bool en)
> > +{
> > +     int ret;
> > +
> > +     ret =3D adxl345_write_tap_axis(st, axis, en);
> And push it into here as well.
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
> > +}
> > +
>
> ...
>
> > @@ -197,6 +354,160 @@ static int adxl345_write_raw(struct iio_dev *indi=
o_dev,
> >       return -EINVAL;
> >  }
> >
> > +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     bool int_en;
> > +     bool axis_en;
> > +     int ret =3D -EFAULT;
> > +
> > +     switch (type) {
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (chan->channel2) {
> > +             case IIO_MOD_X:
> > +                     axis_en =3D FIELD_GET(ADXL345_X_EN, st->tap_axis_=
ctrl);
> > +                     break;
> > +             case IIO_MOD_Y:
> > +                     axis_en =3D FIELD_GET(ADXL345_Y_EN, st->tap_axis_=
ctrl);
> > +                     break;
> > +             case IIO_MOD_Z:
> > +                     axis_en =3D FIELD_GET(ADXL345_Z_EN, st->tap_axis_=
ctrl);
> > +                     break;
> > +             default:
> > +                     axis_en =3D ADXL345_TAP_SUPPRESS;
> > +                     break;
> > +             }
> I'd check axis_en here.
>                 if (!axis_en)
>                         return false;
> > +
> > +             switch (dir) {
> > +             case IIO_EV_DIR_SINGLETAP:
> > +                     ret =3D adxl345_is_tap_en(st, ADXL345_SINGLE_TAP,=
 &int_en);
> > +                     if (ret)
> > +                             return ret;
> > +                     return int_en && axis_en;
>
> Then this just becomes return int_en;
>
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int adxl345_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir,
> > +                                   int state)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     enum adxl345_axis axis;
> > +
> > +     switch (type) {
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (chan->channel2) {
> > +             case IIO_MOD_X:
> > +                     axis =3D ADXL345_X_EN;
> > +                     break;
> > +             case IIO_MOD_Y:
> > +                     axis =3D ADXL345_Y_EN;
> > +                     break;
> > +             case IIO_MOD_Z:
> > +                     axis =3D ADXL345_Z_EN;
> > +                     break;
> > +             default:
> > +                     axis =3D ADXL345_TAP_SUPPRESS;
>
> How are we getting another axis here?

:)

> > +                     break;
> > +             }
> > +
> > +             switch (dir) {
> > +             case IIO_EV_DIR_SINGLETAP:
> > +                     return adxl345_set_singletap_en(st, axis, state);
>
> As above, pass chan->channel2 into here so we can simplify the eventual
> setting of the the register values.
>
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int adxl345_read_event_value(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info,
> > +                                 int *val, int *val2)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     unsigned int tap_threshold;
> > +     int ret;
> > +
> > +     switch (type) {
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     /*
> > +                      * The scale factor is 62.5mg/LSB (i.e. 0xFF =3D =
16g) but
> > +                      * not applied here.
>
> Maybe say why.
>

Usually I did scaling for the time values. Time values is something I
can understand someone
rather wants to configure in corresponding time units, such as [ms],
[us] or [s] rather than bit
values. For [mg] values, franckly speaking, I imagine this is a bit overkil=
l.

The threshold quite often is rather expect to be higher or lower,
depending a bit on variation of
the measurements. In the context of this rather "cheap" sensor, I
guess I'm not putting up a
seismic instrument, but rather generic tap detection, freefall or
general activity in a general
purpose context such as gaming, or the like. Let me know if this
assumption here is too lazy.

I added a bit more comment to the source, pls have a look into v4.

> > +                      */
> > +                     ret =3D regmap_read(st->regmap, ADXL345_REG_THRES=
H_TAP, &tap_threshold);
>
> Bit of a long line. Aim for sub 80 chars unless readability is greatly
> hurt.
>
> > +                     if (ret)
> > +                             return ret;
> > +                     *val =3D sign_extend32(tap_threshold, 7);
> > +                     return IIO_VAL_INT;
> > +             case IIO_EV_INFO_TIMEOUT:
> > +                     *val =3D st->tap_duration_us;
> > +                     *val2 =3D 1000000;
> > +                     return IIO_VAL_FRACTIONAL;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> ...
>

