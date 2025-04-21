Return-Path: <linux-iio+bounces-18445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2FA951CF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDE189451A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14426656C;
	Mon, 21 Apr 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRlBHvHL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FCB266570;
	Mon, 21 Apr 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242812; cv=none; b=CYd8BDi1Per+KM5uUnhe47vFT/LAe3PT4J9z/ZrIQmOCRt9v5AzFM8uAdNm6c0Z7wcxbdD+KPnA/py6U21hLQG2m2sJNh0XB/DvzCGkNuQRM8CixeO7bnMrvASvjyhpv/dI0Kk+33gEcU6ceHmsRVJtCnTgSHWpg3yp0krkNAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242812; c=relaxed/simple;
	bh=0v6cgyOk0nsKeprhUqYsx2Vd4TgvxqOD24CRhYIun+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhLz9qYw40Znu6myvVNywgROEm31kMWHOIa9J38OtKUggHTl7C0TO2xn+iG5sDFH4GNtRskL6q+zKF2NyAdze7aTJUDtlxesmommBhMZGNQNW1IJxXrc4K/s8cVwoQnTl7rzPJH2RyWGkU4UFcDMOyYJdehbn88scgZ8EewjSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRlBHvHL; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e72b8b7bf32so160081276.3;
        Mon, 21 Apr 2025 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745242809; x=1745847609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpGvaPnt9/CqxJFVMjZ2YiGNcRmTBvg8h75W2bPN2Q8=;
        b=kRlBHvHLXW0/+qmJer7Wi1wYjYKpGkdf4WsqmMCpt69MBFjJaVJH6kngwwsGYNhxfS
         PnZbFGnp8D4U1feGMv1WIQHNiP9+y5SyJ2AUd8wDXe6xDPJvGUNFJLUlE0qjDfrPcHgy
         JceV1fRnuARDL6E/618Lr5AvM8Df2li7RW3nnKrzCM9QXpWiRwZoT+B7LOeKAu5mVbHw
         oUpLjYfpgvkfWWr+Jp/aJ3Yhl5JCqLOnWBlVFSh4oBg6HZ9s2Svl0t8Q4zixGL+y9cPL
         rWXRPQoh2imqSyE5vrFJ/z9i7J4AAOh0T/Iyzt0o9W8KNKLGk21l+7Koe2FU2ta/0RRZ
         PAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745242809; x=1745847609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpGvaPnt9/CqxJFVMjZ2YiGNcRmTBvg8h75W2bPN2Q8=;
        b=FQoXO5tWBNl36EiDRaFWmkGhiOxZnMbjghrjOKvfqLpzZeR8E719zvR1iVgKfGb+yv
         MBZTfX0Cg6yH5Qokj62IG7E8CUuHKuiYfL+hZLsH3rl2Sg9knPe8TNmUMuOMurn0wYRA
         fKRZqEFaITnb9R/DcpG8bbHru62i9liptrA0gMFuFmVm3wGZlTZYn5ZPd0ndv4xA+/TB
         vjFfJTxXuoEOLDFUQAEPTdd+eW3jwWkYCbphOjgSZEL6wih78adYHGkkTIuEf5MZ3cxT
         XBTg4/0byBYQ+o4m74ymLBYyCS5PfUoxCwpdjMAq2HyXT7Tzp1DtB6UNn6ebx4X0s3rY
         rpUw==
X-Forwarded-Encrypted: i=1; AJvYcCUL61gZgcg0oCdi1Mb3LVSDXj5QtohoRRQZi8qj1/UMz9uQMXW3egGSFVEIbtqv5PIkRmPnIT0DauDQrlLa@vger.kernel.org, AJvYcCWss3KUhyIIXB3UV/pvLs1Xop9Q4cZr3PeIoLObvQxnlp8b/iNf8G9v0s4+C09/Mi+WFZetuE6N+8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8qzQulFdfTsCU/syG4ZylnaPYBpH+TQyLkIlujX3uhVQpnBV
	N575+QAk5v02FlaOO/frKTQZUNm9/S1cUDHndbpMGHeSJ2EqqVCC9KIfWgBlSePbYciVQGkNWN7
	LO7DWZJBJjv3cqDcfRoKgwQoRI5Y=
X-Gm-Gg: ASbGnctgiTD2Jh/8Iiu5LV8kx5SsSr7rhz5//Heu0+RligjlA+cFNkP/iauHWJAf90F
	N6NgqMhF3v7PuOuyTErYRQN4mFQMJ7HwErxxPfHNgNg8YE0dclHwP+JSXJ7tjG9lLDlvFy8jRpt
	Qh/k2d8Go6gFCGo6vipNz6Ew==
X-Google-Smtp-Source: AGHT+IEwr7hewb5X60u3ctkpPPV5t8VWYhpFPyNmaIAqMFHQsh/fM9viain4nmmAvhCOE/HN7SlFEUMjQ6D4vE1mP8A=
X-Received: by 2002:a05:6902:218b:b0:e60:a4f4:7f3 with SMTP id
 3f1490d57ef6-e7297eae373mr6911994276.6.1745242809332; Mon, 21 Apr 2025
 06:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414184245.100280-1-l.rubusch@gmail.com> <20250414184245.100280-10-l.rubusch@gmail.com>
 <20250418193411.406bd974@jic23-huawei> <CAFXKEHary=PcCh3GEEXznJQgcxj54ZmGR0jmzBdpx8ZVtk2_0g@mail.gmail.com>
 <20250421112228.453dfa89@jic23-huawei>
In-Reply-To: <20250421112228.453dfa89@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 21 Apr 2025 15:39:33 +0200
X-Gm-Features: ATxdqUHfgQAnkyNDiR_3ivS4MD9k2ORARyZfvZsLF4q_wXZZaM77xT-0RpgMBzA
Message-ID: <CAFXKEHYsMKHMYoBq7U5n02=0wnVmp0_CUrbvxxFFRLJDayS7Kg@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] iio: accel: adxl345: add inactivity feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 12:22=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Mon, 21 Apr 2025 00:12:17 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Happy Easter (again)!
> >
> > On Fri, Apr 18, 2025 at 8:34=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Mon, 14 Apr 2025 18:42:43 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > Add the inactivity feature of the sensor. When activity and inactiv=
ity
> > > > are enabled, a link bit will be set linking activity and inactivity
> > > > handling. Additionally, the auto-sleep mode will be enabled. Due to=
 the
> > > > link bit the sensor is going to auto-sleep when inactivity was
> > > > detected.
> > > >
> > > > Inactivity detection needs a threshold to be configured, and a time
> > > > after which it will go into inactivity state if measurements under
> > > > threshold.
> > > >
> > > > When a ODR is configured this time for inactivity is adjusted with =
a
> > > > corresponding reasonable default value, in order to have higher
> > > > frequencies and lower inactivity times, and lower sample frequency =
but
> > > > give more time until inactivity. Both with reasonable upper and low=
er
> > > > boundaries, since many of the sensor's features (e.g. auto-sleep) w=
ill
> > > > need to operate beween 12.5 Hz and 400 Hz. This is a default settin=
g
> > > > when actively changing sample frequency, explicitly setting the tim=
e
> > > > until inactivity will overwrite the default.
> > > >
> > > > Similarly, setting the g-range will provide a default value for the
> > > > activity and inactivity thresholds. Both are implicit defaults, but
> > > > equally can be overwritten to be explicitly configured.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > Hi Lothar,
> > >
> > > Patches 6-8 look good to me.
> > >
> > > This runs into a similar issue to the freefall one. I haven't dug int=
o
> > > the datasheet but does it report on one channel going inactive, or
> > > all being inactive at the same time?  I checked and it is the all
> > > case so we should be both on a pseudo channel to describe it right
> > > and reporting IIO_MOD_X_AND_Y_AND_Z not the OR form.
> > >
> > > Sorry again that I'm only realising this on v6 :(
> >
> > No problem at all! Sure, I'm still in this phase where counting every
> > single commit upstream makes my ego greater. On the long run, though,
> > I guess it's better to build up knowledge and end up with a decent
> > implementation quality, than just increasing a commit counter. For me
> > it's fine. I also hope it's not too annoying for you.
> >
> > >
> > > Difference is for Activity the definition is:
> > > "The activity bit is set when acceleration greater than the value
> > > stored in the THRESH_ACT register (Address 0x24) is experienced
> > > on _any_ participating axis, set by the ACT_INACT_CTL register
> > > (Address 0x27)."
> > > vs Inactivity:
> > > "The inactivity bit is set when acceleration of less than the value
> > > stored in the THRESH_INACT register (Address 0x25) is experienced
> > > for more time than is specified in the TIME_INACT
> > > register (Address 0x26) on _all_ participating axes, as set by the
> > > ACT_INACT_CTL register (Address 0x27). "
> > >
> > > So all vs any.
> > >
> >
> > I think I  see your point. At least I change here for inactivity, too,
> > to AND'ed axis.
> >
> > IMHO, if I set OR here, the first axis raising the inactivity will put
> > the sensor to sleep mode,
> > where AND needs all three axis in inactivity state. I'm not sure if
> > this works out, I need to verify
> > it still with the hardware, for now I'll change this to AND.
>
> I'd be surprised if it worked differently but indeed good to check!
>
> >
> > > > +
> > > > +/**
> > > > + * adxl345_set_inact_time_s - Configure inactivity time explicitly=
 or by ODR.
> > > > + * @st: The sensor state instance.
> > > > + * @val_s: A desired time value, between 0 and 255.
> > > > + *
> > > > + * Inactivity time can be configured between 1 and 255 sec. If a v=
al_s of 0
> > > > + * is configured by a user, then a default inactivity time will be=
 computed.
> > > > + *
> > > > + * In such case, it should take power consumption into considerati=
on. Thus it
> > > > + * shall be shorter for higher frequencies and longer for lower fr=
equencies.
> > > > + * Hence, frequencies above 255 Hz shall default to 10 s and frequ=
encies below
> > > > + * 10 Hz shall result in 255 s to detect inactivity.
> > > > + *
> > > > + * The approach simply subtracts the pre-decimal figure of the con=
figured
> > > > + * sample frequency from 255 s to compute inactivity time [s]. Sub=
-Hz are thus
> > > > + * ignored in this estimation. The recommended ODRs for various fe=
atures
> > > > + * (activity/inactivity, sleep modes, free fall, etc.) lie between=
 12.5 Hz and
> > > > + * 400 Hz, thus higher or lower frequencies will result in the bou=
ndary
> > > > + * defaults or need to be explicitly specified via val_s.
> > > > + *
> > > > + * Return: 0 or error value.
> > > > + */
> > > > +static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 =
val_s)
> > > > +{
> > > > +     unsigned int max_boundary =3D 255;
> > > > +     unsigned int min_boundary =3D 10;
> > > > +     unsigned int val =3D min(val_s, max_boundary);
> > > > +     enum adxl345_odr odr;
> > > > +     unsigned int regval;
> > > > +     int ret;
> > > > +
> > > > +     if (val =3D=3D 0) {
> > > > +             ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE, =
&regval);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +             odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > > > +
> > > > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > > > +                     ? min_boundary : max_boundary - adxl345_odr_t=
bl[odr][0];
> > > > +     }
> > > > +
> > > > +     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > > >  }
> > > >
> > > >  /* tap */
> > > > @@ -837,6 +943,13 @@ static int adxl345_read_event_config(struct ii=
o_dev *indio_dev,
> > > >                       if (ret)
> > > >                               return ret;
> > > >                       return int_en;
> > > > +             case IIO_EV_DIR_FALLING:
> > > > +                     ret =3D adxl345_is_act_inact_en(st, chan->cha=
nnel2,
> > >
> > > Does it makes sense to allow inactivity detection on a subset of chan=
nels but then
> > > report it as XYZ?  I guess it didn't matter when it was and OR, but i=
f we
> > > change to AND as suggested that is going to be misleading.
> > >
> > > we might have to allow separate enables but report an event as the co=
mbination
> > > of channels that are enabled X_AND_Y, X_AND_Z etc  I guess we can imp=
rove activity
> > > channel case as well by doing that with the X_OR_Y etc
> > >
> >
> > Well, initially I guess I only had one enable for inactivity.
> >
> > This was kind of confusing to me. There is a register to enable
> > activity and inactivity on a per axis base [ACT_INACT_CTL, 0x27].
>
> Agreed this is a slightly odd concept.
>
> >
> > The interrupt event will set a single bit for inactivity or activity
> > [INT_SOURCE, 0x30]. In the interrupt handler further one can read out
> > the [ACT_TAP_STATUS, 0x2B], which contains tap and activity
> > directions, but no information about inactivity axis.
> >
> > In summary, for the ADXL345 inactivity can be configured on a per axis
> > base, but the event won't tell about the axis that fell into
> > inactivity, i.e. the first inactivity is supposed to put the sensor
> > into power save (with link bit and power modes set - I think
> > inactivity should mainly be seen in the context of their/Analog's
> > power save concept). As said before, initially I only provided a
> > single "inactivity enable". Then I saw actually I could set and offer
> > this per axis. I don't know if there are use cases only to observe
> > particularly the x-axis for a general power save. Probably rather not.
> >
> > So, I agree. But if you don't tell me explicitely to replace per axis
> > enables by a single one, I'll probably leave it as is. It implements
> > most transparently what the sensor can offer for configuration.
>
> The snag is what I mentioned for freefall. It becomes very hard to indica=
te
> to userspace what it might expect for the x&y&z cases.  If inactivity req=
uires
> them all to be inactive, I think separate enables is going to be really
> tricky to build a consistent ABI around :(
>
> Some devices we've had in the past have allowed specific configuration of
> and / or for axis combinations. For those we've normally kept clear becau=
se
> the number of combinations gets sill quickly.
>
> If we don't have a separate channel enable usecase today I think we shoul=
d
> go ahead with general inactivity / activity (and/or as appropriate) and
> perhaps solve the per axis case if anyone ever cares about it.
>

Well, I think here we need to distinguish:
Activity: would allow per axis enables and events indicate per axis activit=
y
Inactivity: allows per axis enables, but only a generic inactivity indicati=
on

So, also here, what's still missing? When doing it similarly  to my
understanding of freefall now, for a v7 of the patches...

Activity:
- I would leave activity as is (is this ok?)

Inactivity:
- I replace single three axis enables by a generic enable, setting and
unsetting all three axis for inactivity
- I need probably also to provide a similar virtual channel
- The axis for this channel are AND'ed
- Now, with the virtual channel, usage will be "separate" instead of
"shared", which will result in a single enable handle in sysfs

Is this a correct understanding of what is +/- missing? Can you agree
to the points I listed up, or is something's missing (documentation of
course later)?

> >
> > >
> > >
> > > > +                                                   ADXL345_INACTIV=
ITY,
> > > > +                                                   &int_en);
> > > > +                     if (ret)
> > > > +                             return ret;
> > > > +                     return int_en;
> > > >               default:
> > > >                       return -EINVAL;
> > > >               }
> > > > @@ -881,6 +994,9 @@ static int adxl345_write_event_config(struct ii=
o_dev *indio_dev,
> > > >               case IIO_EV_DIR_RISING:
> > > >                       return adxl345_set_act_inact_en(st, chan->cha=
nnel2,
> > > >                                                       ADXL345_ACTIV=
ITY, state);
> > > > +             case IIO_EV_DIR_FALLING:
> > > > +                     return adxl345_set_act_inact_en(st, chan->cha=
nnel2,
> > > > +                                                     ADXL345_INACT=
IVITY, state);
> > > >               default:
> > > >                       return -EINVAL;
> > > >               }
> > >
> > > > @@ -1314,6 +1458,17 @@ static int adxl345_push_event(struct iio_dev=
 *indio_dev, int int_stat,
> > > >                       return ret;
> > > >       }
> > > >
> > > > +     if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
> > > > +             ret =3D iio_push_event(indio_dev,
> > > > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > > +                                                     IIO_MOD_X_OR_=
Y_OR_Z,
> > >
> > > So this is our open question. Similar to the free fall case. Do we ha=
ve the boolean
> > > logic right way around?
> > >
> > > > +                                                     IIO_EV_TYPE_T=
HRESH,
> > > > +                                                     IIO_EV_DIR_FA=
LLING),
> > > > +                                  ts);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +
>

