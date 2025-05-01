Return-Path: <linux-iio+bounces-18925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5ECAA5B72
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 09:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19CF7AD3AD
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA3265CCF;
	Thu,  1 May 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEC4kl9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF72AEE9;
	Thu,  1 May 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746084969; cv=none; b=sJjgf3pBvyfBbZyNwPaXijn2P4XUhGF2LgbDdsimZthz60zuzALgDJmmosCEcmGwalxkVZ5C/vHekKJeQMEgr7v91P7ga7xn/Ov9zmNcdzMq2i8BWmsKAywCiWss8wfpPs57o+S34LyxepZbpiWGQJDRMWf0iaqEh6IY45MZOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746084969; c=relaxed/simple;
	bh=25/37cUMVVXu84cpKe5hjhMfPKL8k229o9wf+HT7AEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXqFBXpSyHBXcTjmC9HIpBvyc/a1bJVQ9FBEWxawdOMYDResOqgxisH2J91JTYOII3rFoMGMapYEjt+cGcfgHGNeVU3eunW83dlIZ0BbruTByu9xPdgpweRelhv1o4je0PNhO0B0XQi5/R6BS26IgLQLPMc0XHuFzQ0gLvS/5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEC4kl9T; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7086bc9eabfso226187b3.0;
        Thu, 01 May 2025 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746084966; x=1746689766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R33smmm7Plxhn+ZOVLOBVrXisntvRS5S1y6+uLYR5E=;
        b=jEC4kl9T6nRNgSfKLdfnqDsIO/FBUnLQzbbqY2mqbwqQ557p5T57SnaJHeng8t+LXg
         F0s9XKO25QC9Q2+U0fQUop4nvjZKQLITO8ospFrtS8UgO5Jj9fqaVy/fvr4zrwhh1M2O
         FT2WgaDATd0y0coDhxQzJCjZrnL/cOA04niJSj88KIaKNlNc3II50zPdMSwv/vNsFt5X
         jjayKQZx+pl/X/nvH9c7/bd04H+2gGkaqDp1Uu+WOaxbHNtZ8tHuDHeizHxifN1JwKHD
         Rz8oLqud+fk1I5Cg7IKP9JKms/RH6UDowLNfej4fMyluyAcs0U5tOBJdq1Cw1uXfDIRn
         ioPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746084966; x=1746689766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R33smmm7Plxhn+ZOVLOBVrXisntvRS5S1y6+uLYR5E=;
        b=raLl4HRD7yM8GBrgUvDo9hZuB8WCRxEiwlqTZgwfJR8zkO1nnO/vcZRDy8LO06yI39
         xnAVSFkVug3heFPvDLRYze0sOLGuWx8P2kl02pTqzRZD7JNSyGIxgKM0sj8t6eFnuutq
         rH3mh+aYJxMnqAlfdiJWn0Z23zmIsFovVKNDMNylMkYJEHb/+TlUpFVy34oSRvYu8YYU
         /J2F3NOv9YNCuzqGT5WLhs6qaxPFwDRS9t7NO3P/gdKatHdh8moOXsgjdQTXnfnbc0xI
         ogfdhQn0oEyo33OHYVXmeVoB7diu97mEbSmAysz1qEo2r39oPfdnmEjm0MeBoF0Nmnpt
         aSFw==
X-Forwarded-Encrypted: i=1; AJvYcCUMM4SjRRSANaURTmYGQyUebT8gUK2HAwaW6P4uc/rf1L09/BiNZfI8mbfiUQhANwXuSbMYdnLGPvM=@vger.kernel.org, AJvYcCVYlbS4vBzR87AsDJ6SKUSNnB/PVQ4TfuBJWRcXrA7QAVjnUcow4P7ceg9hsRmwfzu+LOM2I+lhFXyowVWf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+J10Ry3be8FYQnoLRLHmTvygLUChy8pIHjtyrjsikkz9ySGtd
	Au3FZ9mxTJw0UDfP99STFQ+vgGzc6ZU1BDryDqqJfVTO7UgR77utXvMXliZAGBVWaXVtr9aWLwZ
	r5he2WEbRy6cEuK+b4z+xNu2e/xT+10DL
X-Gm-Gg: ASbGnctRL4neDBURkS15VvCQYRhsTBv6UxKQn04/hBVhHudKJIELbk99C9WYR1zKW0z
	bHAJZc7CE7KiZ/L7+Dilk34fQwTlTIsvdbFqcawsOEPUsBcDnfAw7Wy/2wBHRJNThGStiy9jmnX
	ZGexPbBj8xuNRm0lEuWSYhig==
X-Google-Smtp-Source: AGHT+IG3Kk+Gf08jmpYy1fAwdKSYnl0NOMb9effMKmmhuUmJ2bY0meQ1Zb4nuLc1a+LC+uUfKFoUVkW15E138wVFVao=
X-Received: by 2002:a05:690c:4:b0:6fd:a226:fb48 with SMTP id
 00721157ae682-708aefdff00mr32416527b3.5.1746084966190; Thu, 01 May 2025
 00:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421220641.105567-1-l.rubusch@gmail.com> <20250421220641.105567-11-l.rubusch@gmail.com>
 <20250427140032.3112f51b@jic23-huawei>
In-Reply-To: <20250427140032.3112f51b@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 1 May 2025 09:35:29 +0200
X-Gm-Features: ATxdqUFtk85pPDPe84VudTc9sg7nZgezROhz7M7eXepHhipu7wDZGxo06xL9OrY
Message-ID: <CAFXKEHZ60bREfFmi33XSyrUNigyuQv+by4vh+uoUErni_UEcnw@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] iio: accel: adxl345: add coupling detection for activity/inactivity
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 3:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 21 Apr 2025 22:06:40 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add coupling activity/inactivity detection by the AC/DC bit. This is an
> > addititional enhancement for the detection of activity states and
> > completes the activity / inactivity feature of the ADXL345.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> I've dragged the table from the earlier patch into this one that actually=
 uses it.
> However I'm a little unsure on exactly how we present this feature.
>
> So until those questions are resolved I've dropped the patch (you'll need
> to rebase on my testing branch and fix up missing table for v8).
>
> The bit that made me not apply this series (with some tweaks) was that
> I'd expect enabling AC events to be visible as disabling of DC ones.
>

There are no AC events, nor DC ones.

Think of AC- or DC-coupled detection as modes of operating the
ACTIVITY/INACTIVITY
detection. The events are ACTIVITY or INACTIVITY. It has effect on how
the sensor detects
if it needs to trigger an (IN)/ACTIVITY event. DC is just going by the
configured thresholds,
where AC is supposed to apply some more elaborate way of declaring ACTIVITY=
 or
INACTIVITY.

The fact that you imply on this means to me, at least I explained it
wrong, or need to clarify
better.

> Also, I just noticed you aren't pushing the new event types.
>
> These controls need to look like a separate event detector hardware block
> with it's own controls + its own event codes.  The fact only this or
> the DC version can be enabled at any time should only be exposed in the
> reported state, not apparent via what files we expose etc.  On some
> other device they may be independent hardware blocks.
>
> Note I'd also expect to see value controls for these new events. You may
> need to cache the values and update on event change if the meaning is
> very different.   That's because the expectation would be an event
> setup sequence from userspace is:
>
> 1) Set value of threshold
> 2) Enable event
>
> On a change of event (due to shared hardware) The value set may scramble
> the event already enabled.
>
> So write the values into a cache and update to the right one when changin=
g
> event.
>

Might be that I got you wrong here, but I assume the above does
actually not apply.

Best,
L

> > ---
> >  drivers/iio/accel/adxl345_core.c | 162 ++++++++++++++++++++++++++++++-
> >  1 file changed, 159 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index b25efcad069b..c07ad5774c8a 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -37,7 +37,9 @@
> >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> >  #define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > +#define ADXL345_REG_ACT_ACDC_MSK     BIT(7)
> >  #define ADXL345_REG_INACT_AXIS_MSK   GENMASK(2, 0)
> > +#define ADXL345_REG_INACT_ACDC_MSK   BIT(3)
> >  #define ADXL345_POWER_CTL_INACT_MSK  (ADXL345_POWER_CTL_AUTO_SLEEP | A=
DXL345_POWER_CTL_LINK)
> >
> >  #define ADXL345_TAP_Z_EN             BIT(0)
> > @@ -91,6 +93,11 @@ static const unsigned int adxl345_act_thresh_reg[] =
=3D {
> >       [ADXL345_INACTIVITY] =3D ADXL345_REG_THRESH_INACT,
> >  };
> >
> > +static const unsigned int adxl345_act_acdc_msk[] =3D {
> > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_ACT_ACDC_MSK,
> > +     [ADXL345_INACTIVITY] =3D ADXL345_REG_INACT_ACDC_MSK,
> > +};
> > +
> >  enum adxl345_odr {
> >       ADXL345_ODR_0P10HZ =3D 0,
> >       ADXL345_ODR_0P20HZ,
> > @@ -204,6 +211,18 @@ static struct iio_event_spec adxl345_events[] =3D =
{
> >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> >       },
> > +     {
> > +             /* activity, activity - ac bit */
> Comment says activity and inactivity but channel type wise this
> is just activity (as rising)
>
> > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > +             .dir =3D IIO_EV_DIR_RISING,
> > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > +     },
> > +     {
> > +             /* activity, inactivity - ac bit */
>
> Likewise this seems to be inactivity.  Should this be in the x&y&z
> channel, not this one?
>
> > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > +             .dir =3D IIO_EV_DIR_FALLING,
> > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > +     },
> >  };
> >
> >  #define ADXL345_CHANNEL(index, reg, axis) {                           =
       \
> > @@ -320,6 +339,69 @@ static int adxl345_set_measure_en(struct adxl345_s=
tate *st, bool en)
> >
> >  /* act/inact */
> >
> > +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> > +                                enum adxl345_activity_type type, bool =
*ac)
> > +{
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regv=
al);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (type =3D=3D ADXL345_ACTIVITY)
> > +             *ac =3D FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval);
> > +     else
> > +             *ac =3D FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval);
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> > +                                 enum adxl345_activity_type type, bool=
 ac)
> > +{
> > +     unsigned int act_inact_ac =3D ac ? 0xff : 0x00;
> > +
> > +     /*
> > +      * A setting of false selects dc-coupled operation, and a setting=
 of
> > +      * true enables ac-coupled operation. In dc-coupled operation, th=
e
> > +      * current acceleration magnitude is compared directly with
> > +      * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to determi=
ne
> > +      * whether activity or inactivity is detected.
> > +      *
> > +      * In ac-coupled operation for activity detection, the accelerati=
on
> > +      * value at the start of activity detection is taken as a referen=
ce
> > +      * value. New samples of acceleration are then compared to this
> > +      * reference value, and if the magnitude of the difference exceed=
s the
> > +      * ADXL345_REG_THRESH_ACT value, the device triggers an activity
> > +      * interrupt.
> > +      *
> > +      * Similarly, in ac-coupled operation for inactivity detection, a
> > +      * reference value is used for comparison and is updated whenever=
 the
> > +      * device exceeds the inactivity threshold. After the reference v=
alue
> > +      * is selected, the device compares the magnitude of the differen=
ce
> > +      * between the reference value and the current acceleration with
> > +      * ADXL345_REG_THRESH_INACT. If the difference is less than the v=
alue in
> > +      * ADXL345_REG_THRESH_INACT for the time in ADXL345_REG_TIME_INAC=
T, the
> > +      * device is considered inactive and the inactivity interrupt is
> > +      * triggered. [quoted from p. 24, ADXL345 datasheet Rev. G]
> > +      *
> > +      * In a conclusion, the first acceleration snapshot sample which =
hit the
> > +      * threshold in a particular direction is always taken as acceler=
ation
> > +      * reference value to that direction. Since for the hardware acti=
vity
> > +      * and inactivity depend on the x/y/z axis, so do ac and dc coupl=
ing.
> > +      * Note, this sw driver always enables or disables all three x/y/=
z axis
> > +      * for detection via act_axis_ctrl and inact_axis_ctrl, respectiv=
ely.
> > +      * Where in dc-coupling samples are compared against the threshol=
ds, in
> > +      * ac-coupling measurement difference to the first acceleration
> > +      * reference value are compared against the threshold. So, ac-cou=
pling
> > +      * allows for a bit more dynamic compensation depending on the in=
itial
> > +      * sample.
> > +      */
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> > +                              adxl345_act_acdc_msk[type], act_inact_ac=
);
> > +}
>
> >  static int adxl345_find_range(struct adxl345_state *st, int val, int v=
al2,
> > @@ -797,9 +886,51 @@ static int adxl345_find_range(struct adxl345_state=
 *st, int val, int val2,
> >
> >  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_ra=
nge range)
> >  {
> > -     return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> > +     unsigned int act_threshold, inact_threshold;
> > +     unsigned int range_old;
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval)=
;
> > +     if (ret)
> > +             return ret;
> > +     range_old =3D FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> > +
> > +     ret =3D regmap_read(st->regmap,
> > +                       adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> > +                       &act_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(st->regmap,
> > +                       adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> > +                       &inact_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> >                                ADXL345_DATA_FORMAT_RANGE,
> >                                FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, ra=
nge));
> > +     if (ret)
> > +             return ret;
> > +
> > +     act_threshold =3D act_threshold
> > +             * adxl345_range_factor_tbl[range_old]
> > +             / adxl345_range_factor_tbl[range];
> > +     act_threshold =3D min(255, max(1, inact_threshold));
> > +
> This is first use of the range table. So introduce that in this patch.
>
> > +     inact_threshold =3D inact_threshold
> > +             * adxl345_range_factor_tbl[range_old]
> > +             / adxl345_range_factor_tbl[range];
> > +     inact_threshold =3D min(255, max(1, inact_threshold));
> > +
> > +     ret =3D regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_A=
CTIVITY],
> > +                        act_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_IN=
ACTIVITY],
> > +                        inact_threshold);
> >  }
> >
> >  static int adxl345_read_avail(struct iio_dev *indio_dev,
> > @@ -938,7 +1069,7 @@ static int adxl345_read_event_config(struct iio_de=
v *indio_dev,
> >                                    enum iio_event_direction dir)
> >  {
> >       struct adxl345_state *st =3D iio_priv(indio_dev);
> > -     bool int_en;
> > +     bool int_en, act_ac, inact_ac;
> >       int ret;
> >
> >       switch (type) {
> > @@ -983,6 +1114,21 @@ static int adxl345_read_event_config(struct iio_d=
ev *indio_dev,
> >               if (ret)
> >                       return ret;
> >               return int_en;
> > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > +             switch (dir) {
> > +             case IIO_EV_DIR_RISING:
> > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345_ACTIV=
ITY, &act_ac);
>
> Do we not need a check in the enabling of the DC events as well?  If we h=
ave enabled
> AC the DC one should report disabled (and if we enable that again then we=
 should
> update this.
>
> > +                     if (ret)
> > +                             return ret;
> > +                     return act_ac;
> > +             case IIO_EV_DIR_FALLING:
> > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345_INACT=
IVITY, &inact_ac);
> > +                     if (ret)
> > +                             return ret;
> > +                     return inact_ac;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -1019,6 +1165,16 @@ static int adxl345_write_event_config(struct iio=
_dev *indio_dev,
> >               }
> >       case IIO_EV_TYPE_MAG:
> >               return adxl345_set_ff_en(st, state);
> > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > +             switch (dir) {
> > +             case IIO_EV_DIR_RISING:
> > +                     return adxl345_set_act_inact_ac(st, ADXL345_ACTIV=
ITY, state);
>
> Similar to read path.  The DC events should be affected by this as well a=
s the AC ones.
>
> > +             case IIO_EV_DIR_FALLING:
> > +                     return adxl345_set_act_inact_ac(st, ADXL345_INACT=
IVITY, state);
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +
> >       default:
> >               return -EINVAL;
> >       }
>

