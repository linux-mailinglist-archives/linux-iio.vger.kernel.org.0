Return-Path: <linux-iio+bounces-18392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAFA949DA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9981891D01
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1F01A23AF;
	Sun, 20 Apr 2025 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK/QHwI2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C1647;
	Sun, 20 Apr 2025 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745187176; cv=none; b=s+GrVcnxF9NAL/4SJd4j3lw9q6RbMdJhirM7SiLQKrXTBmgQ/fFEOULLhl7Ud8O1c0n15TWOw4lYw4ZjK+8fWwJtWz5HQPfSl5ExZeZKqJia5dl68zUV9HQomwcbtNuCi4oIVqdHTw2z0OrdXQvnjqiPK7zWo7UbrLNA8l4+Bgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745187176; c=relaxed/simple;
	bh=+14h2xzrlQWgkny0BXgRec8DQQnoPD5Chht7U0tXErU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7bsASiJemEAEqRnlVGJ7WwTZFnZWfTgAQe+R5Fpy/Io/F5LYHZZY0N1PzhByAxMj8mnmZU3Adw0iz1F9yftheV8JYnLdcDnHNncZcbJvTIUWbe5W8DTmXTrY0+2xS+GWPQoMpJdtGKpWgEQD2wQHu+lxdnkMahv4ONpO63Cd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK/QHwI2; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6e04a05c76so463654276.0;
        Sun, 20 Apr 2025 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745187173; x=1745791973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl/A6toidpkv0GhXDihqOxjynCVRsGJu4fcfqMtkbzI=;
        b=QK/QHwI25qWM/AuKuWtQzVkU6bZvgykR4dMh5XsdyTzZy67xQKxrcfqU/2D7TfYSoI
         8kvnQeFpQn+moklSQHWQ8fgKOLODe3NejQ0Hfd91y2yGVxkKlSb8aJIY8/ifh7VC2Euf
         fzR3Zoj9/fWBfyXGDOTuGKtf0rU9QOOoDh+nBfhW+9xVGRL83U5grkC4ls1uVumqtxqy
         t9506gRcpmUlLTs3vz1UuB4fiDrF76tvtMGDf2cGI3/02F1nBSWJGc0Am+glKjLF3BWB
         YaLz7UFXBty/tBdtDunB1523scqCWr/wCququrNwnvzR4lboP+8PipjjpV+4mgEEdZK4
         mm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745187173; x=1745791973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl/A6toidpkv0GhXDihqOxjynCVRsGJu4fcfqMtkbzI=;
        b=NXcE6CxXe2XkySJh+AjWzpsxd8KBWCDfhgwaBo1/E2Ex5VBtLvvYY+gBMPnqfQXAp8
         Pc+Kirdsid2DKYZtWroIje/KsbX/RL4Q6KOvmbu57rB7IXS3N0u4COHs0o7GcrCBJywN
         BooQNg9nsr/3tX89HooOGXset3RZDGeagZRJ6konzKwWV1AMLPSjZ1e+PhChCVS8hGgu
         6tPASrXkK6Xt/oG7PORIDStk+Mm2c3UMYHDqHEKDYtMBCsIkLs+wEULZfVIRLWaLxnsc
         ME7IX1CsjDqcZP4HAoq3IhbCIXYEGX4eCGaTQQ+CgBlPavALeCapheDhX0ShujzgeZ1b
         1pvw==
X-Forwarded-Encrypted: i=1; AJvYcCU2jFTr17Rz1ERMYnCaQ+kMODPIL4BhhPaBv00A3LireAQsGEtV8V38njEur/retnNBlB99TJe0VHc=@vger.kernel.org, AJvYcCXM6AxWYDYS7fCjSwy4zFYHrOvLtXX/9FoetxesYawNdOImee9htzGNF4VC2mNujvqgISNiCeQt/srzi+NK@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfsqNcntPMJqgDxp+N6s/19cmO9urDRuedVXQwHi1o8PXAYwN
	g1sdoi/3k5lKJgoUL2U9+grSGHA0AWEIprWe5tboCyIdCGWWpC+R1VUvt7iV1kgL2xgxilB9oep
	2uRJgPFGC+gV9m0UQb9rFpoSz4tQTtg==
X-Gm-Gg: ASbGnct28a5FgkrBmG/WIajaCnayRTr3Bta4uJ5nmEmMs1rLTp4W7jF2fY0HZM0Util
	HHDjBKY3ZINDrzFYPMlU/4ONyP1/ef3IIRMkczplnDd7yUIHhBymxSjI3Otgo/kmYnZIJd9YR10
	MfdS70oX70a/RdBydwo6qFwQ==
X-Google-Smtp-Source: AGHT+IG6IliQ0mHgxwyz6Klzad9OkdSOEaIZsQeI3VtteYlye6Raax9xKreWFXinMscsaDvqeTpOYTKUvUZ/0zpOHhw=
X-Received: by 2002:a05:6902:1b10:b0:e72:7714:1219 with SMTP id
 3f1490d57ef6-e7297eb93c2mr5429071276.8.1745187173327; Sun, 20 Apr 2025
 15:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414184245.100280-1-l.rubusch@gmail.com> <20250414184245.100280-10-l.rubusch@gmail.com>
 <20250418193411.406bd974@jic23-huawei>
In-Reply-To: <20250418193411.406bd974@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 21 Apr 2025 00:12:17 +0200
X-Gm-Features: ATxdqUG86Jec0zlXeV4eDxwLPP5sbwzUf76szgGlOaIyHqQLavgHWEMi_se_vqQ
Message-ID: <CAFXKEHary=PcCh3GEEXznJQgcxj54ZmGR0jmzBdpx8ZVtk2_0g@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] iio: accel: adxl345: add inactivity feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Happy Easter (again)!

On Fri, Apr 18, 2025 at 8:34=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 14 Apr 2025 18:42:43 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the inactivity feature of the sensor. When activity and inactivity
> > are enabled, a link bit will be set linking activity and inactivity
> > handling. Additionally, the auto-sleep mode will be enabled. Due to the
> > link bit the sensor is going to auto-sleep when inactivity was
> > detected.
> >
> > Inactivity detection needs a threshold to be configured, and a time
> > after which it will go into inactivity state if measurements under
> > threshold.
> >
> > When a ODR is configured this time for inactivity is adjusted with a
> > corresponding reasonable default value, in order to have higher
> > frequencies and lower inactivity times, and lower sample frequency but
> > give more time until inactivity. Both with reasonable upper and lower
> > boundaries, since many of the sensor's features (e.g. auto-sleep) will
> > need to operate beween 12.5 Hz and 400 Hz. This is a default setting
> > when actively changing sample frequency, explicitly setting the time
> > until inactivity will overwrite the default.
> >
> > Similarly, setting the g-range will provide a default value for the
> > activity and inactivity thresholds. Both are implicit defaults, but
> > equally can be overwritten to be explicitly configured.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>
> Patches 6-8 look good to me.
>
> This runs into a similar issue to the freefall one. I haven't dug into
> the datasheet but does it report on one channel going inactive, or
> all being inactive at the same time?  I checked and it is the all
> case so we should be both on a pseudo channel to describe it right
> and reporting IIO_MOD_X_AND_Y_AND_Z not the OR form.
>
> Sorry again that I'm only realising this on v6 :(

No problem at all! Sure, I'm still in this phase where counting every
single commit upstream makes my ego greater. On the long run, though,
I guess it's better to build up knowledge and end up with a decent
implementation quality, than just increasing a commit counter. For me
it's fine. I also hope it's not too annoying for you.

>
> Difference is for Activity the definition is:
> "The activity bit is set when acceleration greater than the value
> stored in the THRESH_ACT register (Address 0x24) is experienced
> on _any_ participating axis, set by the ACT_INACT_CTL register
> (Address 0x27)."
> vs Inactivity:
> "The inactivity bit is set when acceleration of less than the value
> stored in the THRESH_INACT register (Address 0x25) is experienced
> for more time than is specified in the TIME_INACT
> register (Address 0x26) on _all_ participating axes, as set by the
> ACT_INACT_CTL register (Address 0x27). "
>
> So all vs any.
>

I think I  see your point. At least I change here for inactivity, too,
to AND'ed axis.

IMHO, if I set OR here, the first axis raising the inactivity will put
the sensor to sleep mode,
where AND needs all three axis in inactivity state. I'm not sure if
this works out, I need to verify
it still with the hardware, for now I'll change this to AND.

> > +
> > +/**
> > + * adxl345_set_inact_time_s - Configure inactivity time explicitly or =
by ODR.
> > + * @st: The sensor state instance.
> > + * @val_s: A desired time value, between 0 and 255.
> > + *
> > + * Inactivity time can be configured between 1 and 255 sec. If a val_s=
 of 0
> > + * is configured by a user, then a default inactivity time will be com=
puted.
> > + *
> > + * In such case, it should take power consumption into consideration. =
Thus it
> > + * shall be shorter for higher frequencies and longer for lower freque=
ncies.
> > + * Hence, frequencies above 255 Hz shall default to 10 s and frequenci=
es below
> > + * 10 Hz shall result in 255 s to detect inactivity.
> > + *
> > + * The approach simply subtracts the pre-decimal figure of the configu=
red
> > + * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz =
are thus
> > + * ignored in this estimation. The recommended ODRs for various featur=
es
> > + * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.=
5 Hz and
> > + * 400 Hz, thus higher or lower frequencies will result in the boundar=
y
> > + * defaults or need to be explicitly specified via val_s.
> > + *
> > + * Return: 0 or error value.
> > + */
> > +static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 val_=
s)
> > +{
> > +     unsigned int max_boundary =3D 255;
> > +     unsigned int min_boundary =3D 10;
> > +     unsigned int val =3D min(val_s, max_boundary);
> > +     enum adxl345_odr odr;
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     if (val =3D=3D 0) {
> > +             ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE, &reg=
val);
> > +             if (ret)
> > +                     return ret;
> > +             odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > +
> > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > +                     ? min_boundary : max_boundary - adxl345_odr_tbl[o=
dr][0];
> > +     }
> > +
> > +     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> >  }
> >
> >  /* tap */
> > @@ -837,6 +943,13 @@ static int adxl345_read_event_config(struct iio_de=
v *indio_dev,
> >                       if (ret)
> >                               return ret;
> >                       return int_en;
> > +             case IIO_EV_DIR_FALLING:
> > +                     ret =3D adxl345_is_act_inact_en(st, chan->channel=
2,
>
> Does it makes sense to allow inactivity detection on a subset of channels=
 but then
> report it as XYZ?  I guess it didn't matter when it was and OR, but if we
> change to AND as suggested that is going to be misleading.
>
> we might have to allow separate enables but report an event as the combin=
ation
> of channels that are enabled X_AND_Y, X_AND_Z etc  I guess we can improve=
 activity
> channel case as well by doing that with the X_OR_Y etc
>

Well, initially I guess I only had one enable for inactivity.

This was kind of confusing to me. There is a register to enable
activity and inactivity on a per axis base [ACT_INACT_CTL, 0x27].

The interrupt event will set a single bit for inactivity or activity
[INT_SOURCE, 0x30]. In the interrupt handler further one can read out
the [ACT_TAP_STATUS, 0x2B], which contains tap and activity
directions, but no information about inactivity axis.

In summary, for the ADXL345 inactivity can be configured on a per axis
base, but the event won't tell about the axis that fell into
inactivity, i.e. the first inactivity is supposed to put the sensor
into power save (with link bit and power modes set - I think
inactivity should mainly be seen in the context of their/Analog's
power save concept). As said before, initially I only provided a
single "inactivity enable". Then I saw actually I could set and offer
this per axis. I don't know if there are use cases only to observe
particularly the x-axis for a general power save. Probably rather not.

So, I agree. But if you don't tell me explicitely to replace per axis
enables by a single one, I'll probably leave it as is. It implements
most transparently what the sensor can offer for configuration.

>
>
> > +                                                   ADXL345_INACTIVITY,
> > +                                                   &int_en);
> > +                     if (ret)
> > +                             return ret;
> > +                     return int_en;
> >               default:
> >                       return -EINVAL;
> >               }
> > @@ -881,6 +994,9 @@ static int adxl345_write_event_config(struct iio_de=
v *indio_dev,
> >               case IIO_EV_DIR_RISING:
> >                       return adxl345_set_act_inact_en(st, chan->channel=
2,
> >                                                       ADXL345_ACTIVITY,=
 state);
> > +             case IIO_EV_DIR_FALLING:
> > +                     return adxl345_set_act_inact_en(st, chan->channel=
2,
> > +                                                     ADXL345_INACTIVIT=
Y, state);
> >               default:
> >                       return -EINVAL;
> >               }
>
> > @@ -1314,6 +1458,17 @@ static int adxl345_push_event(struct iio_dev *in=
dio_dev, int int_stat,
> >                       return ret;
> >       }
> >
> > +     if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
> > +             ret =3D iio_push_event(indio_dev,
> > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                                     IIO_MOD_X_OR_Y_OR=
_Z,
>
> So this is our open question. Similar to the free fall case. Do we have t=
he boolean
> logic right way around?
>
> > +                                                     IIO_EV_TYPE_THRES=
H,
> > +                                                     IIO_EV_DIR_FALLIN=
G),
> > +                                  ts);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +

