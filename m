Return-Path: <linux-iio+bounces-19265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE72AAECA6
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75CF7AEDE5
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA281F4CAF;
	Wed,  7 May 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TujV5ghJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323C1DD877;
	Wed,  7 May 2025 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648309; cv=none; b=VwsehOoHsjX4AD3H8ZpvcqZB5zdgzXjHwCf4XR/yHX2WyOOBVm+N1ijfiOb0V+bK4luIEFkU4xNsh+VrhR7L66avSPMj5VEVFruHZLHzlSjVf9FcVuzE1ELI7x/+0nXzqoZsNhp8tr3eff45Mfc3Rqb0G6b3KXYKc2S/5XMQ8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648309; c=relaxed/simple;
	bh=ELX/QrmRqtzvJbpT2zEnJU/4muWN49rAsluF5b3Bqfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVNhWi1gmWjHQP0e5eSxxh35K7hwcIpz/5QP4X/bcEV+YuIxpLHfwvt5BqOF07GSzqYs5IeUhDV64eixJ7mHrFKygF2AdfwUqqbAVFyJGiLY2lN/5FO5H2fFz/93MGGjS8de7hdA5mBeIbJ9qNwyh+eYN/odEDDW+HSS/3ECxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TujV5ghJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7316c56e6eso26649276.3;
        Wed, 07 May 2025 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746648307; x=1747253107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX2xFiglN/HlKVCaacNYo8er3Ud+iyqL0gELfOvfiJQ=;
        b=TujV5ghJwZd4paK6DSdxW7jBgMtC2bifk+n2DkhrwNYKp9qbn82yGJ8wKLtTLC1KUu
         KjciNsOfYK01O6LIyxlEBEtkVqfQfQjpBSCKaf2c25T+rGzeM9aOlgkQz9lYvqlLKdtV
         sWR3YMTsjXXN21b+OCdl7qmZ6mFyCj+L1HbVrqmoviyIsmyfw5sl5CKDjn9RoOOl91uJ
         06iknXPMAsqJ2FaYBH0imuY4op0JNd3cbqQcSy/XPW9HlFPloos7ik+H3wBb+lh13/1F
         cs6R0tSaqlawsLaM/Pt65KB5VVaCLMORVevwwiajrobFt1skW+NX6/PlTRF5Sarmg33I
         jxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746648307; x=1747253107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX2xFiglN/HlKVCaacNYo8er3Ud+iyqL0gELfOvfiJQ=;
        b=BgxKCWjDoXLEuZaYRZppg+4oe8zgmjRHHN3te+7Ndbz0I7MUsZP2nSKfCuJ2yp1l/t
         a8+8ucsEq5Dxuw+Dzz2IH0WBkqRCas1bLa4QK1Nc+6lByGW9V2/tdCJjEYKPfDIoblAc
         BBHrmyp7kXzbFhThP/P/jfA+/cu7KTJQh+J7DoWtGGgF+vdJfQ4/to5+58N8jO5zLDLY
         xagfBhUCxQwIMGm7j7yCYRQ7uELHu9U/p+/CgFrgQ5QocQb44vJnxxdsWxP6E6U2xYSz
         WuzHmhcFQEpeI2OAsB6TA0ms8hanV4Acazh4RIOZe+iI90IHCKn6hSe4J8H/AkDsrrof
         zVKg==
X-Forwarded-Encrypted: i=1; AJvYcCUnd1nF128XyYAAUyY9CFuoLMYT/coNjUrQib1nShwe86xyDHGrIdYc00uFAjeGpWwxBWhkOAC/2clxl9aI@vger.kernel.org, AJvYcCX2tX01o37XJz+/v4UwBr5QERHiXaab1XLEh00glBV1rD+B2JLcm0C8QNuzJqECx3AWKn0lrdJfeO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkLhDgpTikz0d8J+swfcsqzvjzdm6Zk1vb7z0aw7t9LGBGfa6
	hoDR61idLZ8llBOB3GAnoBY8hB30vc3kDQKhAyuXD6EuWK/Snd1DOU/yak+XYwgWki7TtCmfROl
	q6yXC1lnbxRzJQ9XLd0DlMTsWov4=
X-Gm-Gg: ASbGncv70SUMUqQgkhSJNtEjLbnDhEcvs+301p+/S6KroAVuZbkmirji0h5uZshRegr
	tD68SepV7Ef70SQeZkIz6pejxFwEM/0ZI3/xLtRTUCoAP+nxOvY/BXLddLYHXlSFlfSbGNEZPFf
	GJ19rm8jXXJwsw/sSjGhlBs/fhAcR3yaWp
X-Google-Smtp-Source: AGHT+IEwUCyR7ntKSaCs09Bcpk9E9rIBQ8jni8pevru8KPvXXiVNBayzJjNUOv+AfsBKTVvSOw/EfqvuX4spSnay/hc=
X-Received: by 2002:a05:6902:240f:b0:e75:3db7:41cd with SMTP id
 3f1490d57ef6-e78810be22amr2615197276.4.1746648306487; Wed, 07 May 2025
 13:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421220641.105567-1-l.rubusch@gmail.com> <20250421220641.105567-11-l.rubusch@gmail.com>
 <20250427140032.3112f51b@jic23-huawei> <CAFXKEHZ60bREfFmi33XSyrUNigyuQv+by4vh+uoUErni_UEcnw@mail.gmail.com>
 <20250504113907.5030b02d@jic23-huawei>
In-Reply-To: <20250504113907.5030b02d@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 7 May 2025 22:04:29 +0200
X-Gm-Features: ATxdqUHuwakHgkBzXFQv7139tjMjA7PhdfesuCM-dZEo2DyjJFtLroUbi5rf6Do
Message-ID: <CAFXKEHaupT2RZqNaQnLjiKpCodHSHsswhRXCKAmGh_Tnr3iXJQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] iio: accel: adxl345: add coupling detection for activity/inactivity
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, May 4, 2025 at 12:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 1 May 2025 09:35:29 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > On Sun, Apr 27, 2025 at 3:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Mon, 21 Apr 2025 22:06:40 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > Add coupling activity/inactivity detection by the AC/DC bit. This i=
s an
> > > > addititional enhancement for the detection of activity states and
> > > > completes the activity / inactivity feature of the ADXL345.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > >
> > > I've dragged the table from the earlier patch into this one that actu=
ally uses it.
> > > However I'm a little unsure on exactly how we present this feature.
> > >
> > > So until those questions are resolved I've dropped the patch (you'll =
need
> > > to rebase on my testing branch and fix up missing table for v8).
> > >
> > > The bit that made me not apply this series (with some tweaks) was tha=
t
> > > I'd expect enabling AC events to be visible as disabling of DC ones.
> > >
> >
> > There are no AC events, nor DC ones.
> >
> > Think of AC- or DC-coupled detection as modes of operating the
> > ACTIVITY/INACTIVITY
> > detection. The events are ACTIVITY or INACTIVITY.
>
> That's where we differ. For generalizing an ABI we absolutely should
> not think of them as modes - that's an implementation detail only
>
> > It has effect on how
> > the sensor detects
> > if it needs to trigger an (IN)/ACTIVITY event. DC is just going by the
> > configured thresholds,
> > where AC is supposed to apply some more elaborate way of declaring ACTI=
VITY or
> > INACTIVITY.
> >
> > The fact that you imply on this means to me, at least I explained it
> > wrong, or need to clarify
> > better.
>
> Not at all (I think).  This is a question of datasheet representation vs
> what we are doing in the ABI.  Lets have a thought experiment.
>
> If the device had separate enables, thresholds and periods for
> DC activity, DC inactivity, AC activity and AC inactivity would you be
> thinking of them as modes of one event?  They would be separate event typ=
es
> that could be all enabled at the same time.
>
> Now step 2.  We have many sensors that have limited numbers of highly pro=
grammable
> event detection engines (the adis IMUs for instance have only a few such =
engines
> but many types of events). For those we treat them as a fifo.  If you req=
uest
> 3 events and the device has 2 detectors you get the last two that were as=
ked
> for.  We do this because we don't want a detector with 10s of modes with
> the parameter meaning changing for each one.  The ABI should look the sam=
e
> as independent detectors.  Some models are more complex and have more suc=
h
> engines, but the interface remains the same.
>
> So here we have a pair of less flexible engines that can support either
> AC or DC for inactivity/activity.  We should represent that the same
> way we represent the separate engines case.  Hence when you enable
> activity AC, our short (1 element) fifo means we disable activity DC.
>
> Which is why treating them as separate engines (with rules on which can
> be enabled at any time) is the right way to go.  IIRC correctly long
> ago we had various experiments with interfaces around this (including
> mode based ones) and ended up with this approach that looks like a
> whole bunch of event detectors with a mux that means we can only use
> a subset at a time.
>
> Jonathan
>

Thank  you so much for this explanation. It makes it much clearer to
me now to understand what
you were writing about before.

Anyway, I just wanted to confirm what is missing here. I'll need to
distinguish the following events:
- activity_ac
- inactivity_ac
- activity_dc
- inactivity_dc

For the implementation, each shall be a separate event, i.e. each will
have separate handles in sysfs:
- event config: enable
- event value: threshold
- event value: time

Internally I will use the regmap cached flag for AC/DC to distinguish
if the ACTIVITY or INACTIVITY event belongs to activity_ac or
inactivity_dc. Threshold and time values will be specific to ACTIVITY
and INACTIVITY, respectively. Since, the events will be still activity
/ inactivity, as their registers will be so, too. The distinction thus
will be rather a question of the presented handles in sysfs.
All events will be type MAG, and dir RISING (activity) or FALLING
(inactivity). As said above, dc /  ac coupling I will read from the
cache.

Is this approach sufficient to solve the required adjustments, or do
the events themselves need further information about coupling (I guess
so, how can I represent this in the events?)?

Best,
L

>
> >
> > > Also, I just noticed you aren't pushing the new event types.
> > >
> > > These controls need to look like a separate event detector hardware b=
lock
> > > with it's own controls + its own event codes.  The fact only this or
> > > the DC version can be enabled at any time should only be exposed in t=
he
> > > reported state, not apparent via what files we expose etc.  On some
> > > other device they may be independent hardware blocks.
> > >
> > > Note I'd also expect to see value controls for these new events. You =
may
> > > need to cache the values and update on event change if the meaning is
> > > very different.   That's because the expectation would be an event
> > > setup sequence from userspace is:
> > >
> > > 1) Set value of threshold
> > > 2) Enable event
> > >
> > > On a change of event (due to shared hardware) The value set may scram=
ble
> > > the event already enabled.
> > >
> > > So write the values into a cache and update to the right one when cha=
nging
> > > event.
> > >
> >
> > Might be that I got you wrong here, but I assume the above does
> > actually not apply.
> >
> > Best,
> > L
> >
> > > > ---
> > > >  drivers/iio/accel/adxl345_core.c | 162 +++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 159 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/a=
dxl345_core.c
> > > > index b25efcad069b..c07ad5774c8a 100644
> > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > @@ -37,7 +37,9 @@
> > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > >  #define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > > +#define ADXL345_REG_ACT_ACDC_MSK     BIT(7)
> > > >  #define ADXL345_REG_INACT_AXIS_MSK   GENMASK(2, 0)
> > > > +#define ADXL345_REG_INACT_ACDC_MSK   BIT(3)
> > > >  #define ADXL345_POWER_CTL_INACT_MSK  (ADXL345_POWER_CTL_AUTO_SLEEP=
 | ADXL345_POWER_CTL_LINK)
> > > >
> > > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > > @@ -91,6 +93,11 @@ static const unsigned int adxl345_act_thresh_reg=
[] =3D {
> > > >       [ADXL345_INACTIVITY] =3D ADXL345_REG_THRESH_INACT,
> > > >  };
> > > >
> > > > +static const unsigned int adxl345_act_acdc_msk[] =3D {
> > > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_ACT_ACDC_MSK,
> > > > +     [ADXL345_INACTIVITY] =3D ADXL345_REG_INACT_ACDC_MSK,
> > > > +};
> > > > +
> > > >  enum adxl345_odr {
> > > >       ADXL345_ODR_0P10HZ =3D 0,
> > > >       ADXL345_ODR_0P20HZ,
> > > > @@ -204,6 +211,18 @@ static struct iio_event_spec adxl345_events[] =
=3D {
> > > >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> > > >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> > > >       },
> > > > +     {
> > > > +             /* activity, activity - ac bit */
> > > Comment says activity and inactivity but channel type wise this
> > > is just activity (as rising)
> > >
> > > > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > > > +             .dir =3D IIO_EV_DIR_RISING,
> > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > > > +     },
> > > > +     {
> > > > +             /* activity, inactivity - ac bit */
> > >
> > > Likewise this seems to be inactivity.  Should this be in the x&y&z
> > > channel, not this one?
> > >
> > > > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > > > +             .dir =3D IIO_EV_DIR_FALLING,
> > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > > > +     },
> > > >  };
> > > >
> > > >  #define ADXL345_CHANNEL(index, reg, axis) {                       =
           \
> > > > @@ -320,6 +339,69 @@ static int adxl345_set_measure_en(struct adxl3=
45_state *st, bool en)
> > > >
> > > >  /* act/inact */
> > > >
> > > > +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> > > > +                                enum adxl345_activity_type type, b=
ool *ac)
> > > > +{
> > > > +     unsigned int regval;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &=
regval);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     if (type =3D=3D ADXL345_ACTIVITY)
> > > > +             *ac =3D FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval);
> > > > +     else
> > > > +             *ac =3D FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval)=
;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> > > > +                                 enum adxl345_activity_type type, =
bool ac)
> > > > +{
> > > > +     unsigned int act_inact_ac =3D ac ? 0xff : 0x00;
> > > > +
> > > > +     /*
> > > > +      * A setting of false selects dc-coupled operation, and a set=
ting of
> > > > +      * true enables ac-coupled operation. In dc-coupled operation=
, the
> > > > +      * current acceleration magnitude is compared directly with
> > > > +      * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to det=
ermine
> > > > +      * whether activity or inactivity is detected.
> > > > +      *
> > > > +      * In ac-coupled operation for activity detection, the accele=
ration
> > > > +      * value at the start of activity detection is taken as a ref=
erence
> > > > +      * value. New samples of acceleration are then compared to th=
is
> > > > +      * reference value, and if the magnitude of the difference ex=
ceeds the
> > > > +      * ADXL345_REG_THRESH_ACT value, the device triggers an activ=
ity
> > > > +      * interrupt.
> > > > +      *
> > > > +      * Similarly, in ac-coupled operation for inactivity detectio=
n, a
> > > > +      * reference value is used for comparison and is updated when=
ever the
> > > > +      * device exceeds the inactivity threshold. After the referen=
ce value
> > > > +      * is selected, the device compares the magnitude of the diff=
erence
> > > > +      * between the reference value and the current acceleration w=
ith
> > > > +      * ADXL345_REG_THRESH_INACT. If the difference is less than t=
he value in
> > > > +      * ADXL345_REG_THRESH_INACT for the time in ADXL345_REG_TIME_=
INACT, the
> > > > +      * device is considered inactive and the inactivity interrupt=
 is
> > > > +      * triggered. [quoted from p. 24, ADXL345 datasheet Rev. G]
> > > > +      *
> > > > +      * In a conclusion, the first acceleration snapshot sample wh=
ich hit the
> > > > +      * threshold in a particular direction is always taken as acc=
eleration
> > > > +      * reference value to that direction. Since for the hardware =
activity
> > > > +      * and inactivity depend on the x/y/z axis, so do ac and dc c=
oupling.
> > > > +      * Note, this sw driver always enables or disables all three =
x/y/z axis
> > > > +      * for detection via act_axis_ctrl and inact_axis_ctrl, respe=
ctively.
> > > > +      * Where in dc-coupling samples are compared against the thre=
sholds, in
> > > > +      * ac-coupling measurement difference to the first accelerati=
on
> > > > +      * reference value are compared against the threshold. So, ac=
-coupling
> > > > +      * allows for a bit more dynamic compensation depending on th=
e initial
> > > > +      * sample.
> > > > +      */
> > > > +     return regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_C=
TRL,
> > > > +                              adxl345_act_acdc_msk[type], act_inac=
t_ac);
> > > > +}
> > >
> > > >  static int adxl345_find_range(struct adxl345_state *st, int val, i=
nt val2,
> > > > @@ -797,9 +886,51 @@ static int adxl345_find_range(struct adxl345_s=
tate *st, int val, int val2,
> > > >
> > > >  static int adxl345_set_range(struct adxl345_state *st, enum adxl34=
5_range range)
> > > >  {
> > > > -     return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT=
,
> > > > +     unsigned int act_threshold, inact_threshold;
> > > > +     unsigned int range_old;
> > > > +     unsigned int regval;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &reg=
val);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +     range_old =3D FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> > > > +
> > > > +     ret =3D regmap_read(st->regmap,
> > > > +                       adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> > > > +                       &act_threshold);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D regmap_read(st->regmap,
> > > > +                       adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> > > > +                       &inact_threshold);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMA=
T,
> > > >                                ADXL345_DATA_FORMAT_RANGE,
> > > >                                FIELD_PREP(ADXL345_DATA_FORMAT_RANGE=
, range));
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     act_threshold =3D act_threshold
> > > > +             * adxl345_range_factor_tbl[range_old]
> > > > +             / adxl345_range_factor_tbl[range];
> > > > +     act_threshold =3D min(255, max(1, inact_threshold));
> > > > +
> > > This is first use of the range table. So introduce that in this patch=
.
> > >
> > > > +     inact_threshold =3D inact_threshold
> > > > +             * adxl345_range_factor_tbl[range_old]
> > > > +             / adxl345_range_factor_tbl[range];
> > > > +     inact_threshold =3D min(255, max(1, inact_threshold));
> > > > +
> > > > +     ret =3D regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL3=
45_ACTIVITY],
> > > > +                        act_threshold);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL34=
5_INACTIVITY],
> > > > +                        inact_threshold);
> > > >  }
> > > >
> > > >  static int adxl345_read_avail(struct iio_dev *indio_dev,
> > > > @@ -938,7 +1069,7 @@ static int adxl345_read_event_config(struct ii=
o_dev *indio_dev,
> > > >                                    enum iio_event_direction dir)
> > > >  {
> > > >       struct adxl345_state *st =3D iio_priv(indio_dev);
> > > > -     bool int_en;
> > > > +     bool int_en, act_ac, inact_ac;
> > > >       int ret;
> > > >
> > > >       switch (type) {
> > > > @@ -983,6 +1114,21 @@ static int adxl345_read_event_config(struct i=
io_dev *indio_dev,
> > > >               if (ret)
> > > >                       return ret;
> > > >               return int_en;
> > > > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > > > +             switch (dir) {
> > > > +             case IIO_EV_DIR_RISING:
> > > > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345_A=
CTIVITY, &act_ac);
> > >
> > > Do we not need a check in the enabling of the DC events as well?  If =
we have enabled
> > > AC the DC one should report disabled (and if we enable that again the=
n we should
> > > update this.
> > >
> > > > +                     if (ret)
> > > > +                             return ret;
> > > > +                     return act_ac;
> > > > +             case IIO_EV_DIR_FALLING:
> > > > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345_I=
NACTIVITY, &inact_ac);
> > > > +                     if (ret)
> > > > +                             return ret;
> > > > +                     return inact_ac;
> > > > +             default:
> > > > +                     return -EINVAL;
> > > > +             }
> > > >       default:
> > > >               return -EINVAL;
> > > >       }
> > > > @@ -1019,6 +1165,16 @@ static int adxl345_write_event_config(struct=
 iio_dev *indio_dev,
> > > >               }
> > > >       case IIO_EV_TYPE_MAG:
> > > >               return adxl345_set_ff_en(st, state);
> > > > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > > > +             switch (dir) {
> > > > +             case IIO_EV_DIR_RISING:
> > > > +                     return adxl345_set_act_inact_ac(st, ADXL345_A=
CTIVITY, state);
> > >
> > > Similar to read path.  The DC events should be affected by this as we=
ll as the AC ones.
> > >
> > > > +             case IIO_EV_DIR_FALLING:
> > > > +                     return adxl345_set_act_inact_ac(st, ADXL345_I=
NACTIVITY, state);
> > > > +             default:
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +
> > > >       default:
> > > >               return -EINVAL;
> > > >       }
> > >
>

