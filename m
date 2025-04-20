Return-Path: <linux-iio+bounces-18391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528ACA949B1
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 23:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCC9188E0C0
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6931DC9A3;
	Sun, 20 Apr 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXrfxXZe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663F158218;
	Sun, 20 Apr 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745184446; cv=none; b=r2Q487Dn2OtRq1qdUSwjC2MfDvenjTJU1ZirsFIA6Ewul1W7tVWC+ZI4FCbmgVLxNK8cTqKaQO2i4BnlPsKAs3CtCJmGxqjD3bZkh4S/iUlx/e2KquG57/jF9KWauFVa48TWhxvkjhQbWeE0cqbbg0YkoBiUytafFGCiLQLWro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745184446; c=relaxed/simple;
	bh=Yx5D8wvs8NCBfKStwpYWI0dWWf4KV3deODss4JtN4G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7V7/s2WoP6dOCcx2M5rhhMCddYSaNHwvvsnIO/CmsUTtbpr2qGDpA8GfijEIaZX/Pu0odkXA6K9HoflhYmlJ3nXejOwTiEcSH25Uz168l5qTuX1uqAw/p7i2ksZ6N+zR0HVCCO8VwI8D+XJYy+yEH8jyg8q2pOf0IwkKc4OLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXrfxXZe; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e72834cfa83so434127276.1;
        Sun, 20 Apr 2025 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745184443; x=1745789243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrmWFgSQTy4HrkhYw35euyGMxctugOPIBDeYkDWyDxM=;
        b=NXrfxXZe/7FhDFJbacD63s5QpCcEaikbJMJauhPxhajKQKgnHFen4LxlGZ26xZLynr
         ojyms/45ZP/HAKCwQ7JPfUec14OhK8x3bxHHnRhCJxhsk93eyYWGhuIGly2qhtxwH/KN
         AqF5hTu/Fz/E95WOOGaEjZbxSD8SHDr8Uwc4MKMANafmgfhkWbf/Y2W4Hk306NZNjbWY
         4Ehbj7oNWeuaSYBCPz816T21DfIQldrNzmV75LX7Ju6wvfHO4pX3cv18DxrUtZYWUMT1
         5yhc8GjDsoPU6SOF8sQhktvKf0z7kynN733dbXtk+vJwK0UMLJ4Y7ad+67enT0jYsgEy
         Buxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745184443; x=1745789243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrmWFgSQTy4HrkhYw35euyGMxctugOPIBDeYkDWyDxM=;
        b=AYYgs5mzF8jeuh/UZ3iEMTtnJjZHmkc8fwZEdz1gYOeKCWqexHYZIPAp802vbzJJ8q
         /LPbMGiEI8gvFNgwoyO0eR1t+a79YdNupoX0vSco5/zPBeHgKQviHy6fkzgGJx0S8KpF
         x+3E9IbdbJG4k3LRx6Zn3ciBOSunFIyVML5K8FNQj2146oP+Uu7tfRRqiEBQ4Dkw1m+6
         xyjg+Dcd66LocU5pJEdOYdZ8OD0NCfiFo3uBktmE189H9q6ap4DRRoytK+t7oxwa4dgz
         NGOkV23yDR8ccHJbHyHZ15wR/MKkV+dXm7TtNuFoOXUyolIfm+jg+MyYR9+RVG+9nSSX
         B7aA==
X-Forwarded-Encrypted: i=1; AJvYcCUdRi7MvxI4FOFbVs7u/SpKsoZzHJN++FJvbXkD4zMW1kEoRuMMxf4PRpmo7RfjpO6XQGF0XKtrhKw=@vger.kernel.org, AJvYcCWtTAF0v62QM02CnLn7hJdXE7PWxXxaQLbx2jB5mOfDTIbOM32CxslugZa7irCCl/nk6qILDYf+xxWBQkn8@vger.kernel.org
X-Gm-Message-State: AOJu0YyYI5pA6mK06lgW7Dlryv3cOGU9ai8SRu6F/I5jZ7KWrOe/Sswy
	svrHIuUMHOg7A84nGutqzzJy9yzBx3cPjKo3AbqcXWVYYCInl7GsHC/Yj9nmVNbKMJoAhN84PJs
	jwDf+xeMkJpkfeqS9f0JjFbeudB0=
X-Gm-Gg: ASbGncsbc8dTP/jlHN/t9Vt2KgdmADpwj1Hxt2PlaHxlqmNT8ObLjpzORd74eG8WyC8
	AKRxKNmzvi98TwPDnjoUPZvMdiN+Y0roZp6KSWyGtCf6e9xUEIUTcBpoEqp+4gb7eDLYbv3gC8y
	unGHHRSTk1NB9rZnbQoyxPbw==
X-Google-Smtp-Source: AGHT+IEU1zse+uDGMuYbPAgZGuzOgrA3NjBgqfPOx1yBdjFaoTnUMzM+i4fvqa8bVlyqOmbBIwoK1ZHwKBJjmylVQOs=
X-Received: by 2002:a05:690c:6601:b0:6ff:271b:73ed with SMTP id
 00721157ae682-706cce0c4abmr56861347b3.4.1745184443096; Sun, 20 Apr 2025
 14:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414184245.100280-1-l.rubusch@gmail.com> <20250414184245.100280-6-l.rubusch@gmail.com>
 <20250418192254.0becd27d@jic23-huawei>
In-Reply-To: <20250418192254.0becd27d@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 20 Apr 2025 23:26:47 +0200
X-Gm-Features: ATxdqUGdphpMDFwLWvOONZA-K8NCPe0hFs6zTbJQVh9FJAeY0XUKN64JOV9XSeQ
Message-ID: <CAFXKEHZNmUsUmheyDdh1bDDf97-7ZTpsm2xqqbwT+hq3K58F5A@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] iio: accel: adxl345: add freefall feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Happy Easter!

On Fri, Apr 18, 2025 at 8:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 14 Apr 2025 18:42:39 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the freefall detection of the sensor together with a threshold and
> > time parameter. A freefall event is detected if the measuring signal
> > falls below the threshold.
> >
> > Introduce a freefall threshold stored in regmap cache, and a freefall
> > time, having the scaled time value stored as a member variable in the
> > state instance.
> >
> Reading this I wondered whether we had the event code consistent for
> freefall detectors... Or indeed inactivity ones (which are kind of simila=
rish)
>
> :( We don't it seems.  The issue is that
> freefall is actually that all channels are simultaneously under the the m=
agnitude
> threshold, not one of them.  So it should I think be
> X_AND_Y_AND_Z not X_OR_Y_OR_Z
>

I change to X_AND_Y_AND_Z.

> This is as opposed to activity detectors which tend to be any axis shows
> activity and X_OR_Y_OR_Z applies.
>
> Anyhow upshot is I think I lead you astray on this and we should make thi=
s
> one IIO_MOD_X_AND_Y_AND_Z
>
> A few other things inline.
>
> Unfortunately we don't deal with these events that often so I forget
> what we did before :(
>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 125 +++++++++++++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index c464c87033fb..ae02826e552b 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -75,6 +75,7 @@ struct adxl345_state {
> >       u32 tap_duration_us;
> >       u32 tap_latent_us;
> >       u32 tap_window_us;
> > +     u32 ff_time_ms;
> >
> >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(I=
IO_DMA_MINALIGN);
> >  };
> > @@ -96,6 +97,14 @@ static struct iio_event_spec adxl345_events[] =3D {
> >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> >       },
> > +     {
> > +             /* free fall */
> > +             .type =3D IIO_EV_TYPE_MAG,
> > +             .dir =3D IIO_EV_DIR_FALLING,
> > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |
> > +                     BIT(IIO_EV_INFO_VALUE) |
> > +                     BIT(IIO_EV_INFO_PERIOD),
> > +     },
> This is creating separate per axis enables, values and period. Does that =
make
> sense?  If not you need to spin a kind of virtual channel (with mod X_AND=
_Y_AND_Z)
> and add the events to it.
>
> See how the sca3000 does it for example.

Hum, I'm not sure if I understand you correctly. In my driver, I'm
using .mask_shared_by_type, and I verified there appears only one
enable, one value and one period handle.
# ls -l /sys/bus/iio/devices/iio:device0/events/
total 0
...
-rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_en
-rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_period
-rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_value
...

In the sources of sca3000.c I saw this setup with .mask_separate. So,
there I'd expect to see separate enables per axis, or am I wrong? In
the case of the ADXL345, there should only be one freefall enable (in
my driver) and not per axis. So, isn't this what is currently there?

So far I only adjust the or'ing to and'ing the axis for freefall.

> >  };
> >
> >  #define ADXL345_CHANNEL(index, reg, axis) {                           =
       \
> > @@ -383,6 +392,63 @@ static int adxl345_set_tap_latent(struct adxl345_s=
tate *st, u32 val_int,
> >       return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fra=
ct_us);
> >  }
> >
> > +/* freefall */
> > +
> > +static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
> > +{
> > +     int ret;
> > +     unsigned int regval;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *en =3D FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> > +{
> > +     unsigned int regval, ff_threshold;
> > +     bool en;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_thresh=
old);
> > +     if (ret)
> > +             return ret;
> > +
> > +     en =3D cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> > +
> > +     regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
> > +
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > +                               ADXL345_INT_FREE_FALL, regval);
> > +}
> > +
> > +static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
> > +                            u32 val_fract_us)
> > +{
> > +     unsigned int regval;
> > +     int val_ms;
> > +
> > +     /*
> > +      * max value is 255 * 5000 us =3D 1.275000 seconds
> > +      *
> > +      * Note: the scaling is similar to the scaling in the ADXL380
> > +      */
> > +     if (1000000 * val_int + val_fract_us > 1275000)
> > +             return -EINVAL;
> > +
> > +     val_ms =3D val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
> > +     st->ff_time_ms =3D val_ms;
> > +
> > +     regval =3D DIV_ROUND_CLOSEST(val_ms, 5);
> > +
> > +     /* Values between 100ms and 350ms (0x14 to 0x46) are recommended.=
 */
> > +     return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, =
0xff));
> > +}
> > +
> >  static int adxl345_read_raw(struct iio_dev *indio_dev,
> >                           struct iio_chan_spec const *chan,
> >                           int *val, int *val2, long mask)
> > @@ -495,6 +561,11 @@ static int adxl345_read_event_config(struct iio_de=
v *indio_dev,
> >               default:
> >                       return -EINVAL;
> >               }
> > +     case IIO_EV_TYPE_MAG:
> > +             ret =3D adxl345_is_ff_en(st, &int_en);
> > +             if (ret)
> > +                     return ret;
> > +             return int_en;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -518,6 +589,8 @@ static int adxl345_write_event_config(struct iio_de=
v *indio_dev,
> >               default:
> >                       return -EINVAL;
> >               }
> > +     case IIO_EV_TYPE_MAG:
> > +             return adxl345_set_ff_en(st, state);
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -532,6 +605,7 @@ static int adxl345_read_event_value(struct iio_dev =
*indio_dev,
> >  {
> >       struct adxl345_state *st =3D iio_priv(indio_dev);
> >       unsigned int tap_threshold;
> > +     unsigned int ff_threshold;
> >       int ret;
> >
> >       switch (type) {
> > @@ -565,6 +639,22 @@ static int adxl345_read_event_value(struct iio_dev=
 *indio_dev,
> >               default:
> >                       return -EINVAL;
> >               }
> > +     case IIO_EV_TYPE_MAG:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     ret =3D regmap_read(st->regmap, ADXL345_REG_THRES=
H_FF,
> > +                                       &ff_threshold);
> > +                     if (ret)
> > +                             return ret;
> > +                     *val =3D ff_threshold;
> > +                     return IIO_VAL_INT;
> > +             case IIO_EV_INFO_PERIOD:
> > +                     *val =3D st->ff_time_ms;
> > +                     *val2 =3D 1000;
> > +                     return IIO_VAL_FRACTIONAL;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -612,6 +702,22 @@ static int adxl345_write_event_value(struct iio_de=
v *indio_dev,
> >                       return -EINVAL;
> >               }
> >               break;
> > +     case IIO_EV_TYPE_MAG:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     ret =3D regmap_write(st->regmap, ADXL345_REG_THRE=
SH_FF, val);
> > +                     if (ret)
> > +                             return ret;
> > +                     break;
> > +             case IIO_EV_INFO_PERIOD:
> > +                     ret =3D adxl345_set_ff_time(st, val, val2);
> > +                     if (ret)
> > +                             return ret;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -865,6 +971,17 @@ static int adxl345_push_event(struct iio_dev *indi=
o_dev, int int_stat,
> >                       return ret;
> >       }
> >
> > +     if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> > +             ret =3D iio_push_event(indio_dev,
> > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                                     IIO_MOD_X_OR_Y_OR=
_Z,
>
> This is the event that got me thinking about whether we were doing this r=
ight..
>
> > +                                                     IIO_EV_TYPE_MAG,
> > +                                                     IIO_EV_DIR_FALLIN=
G),
> > +                                  ts);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
>

