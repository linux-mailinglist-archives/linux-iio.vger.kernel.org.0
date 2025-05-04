Return-Path: <linux-iio+bounces-19030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E7AA8606
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C613BB57C
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290A1A0BE1;
	Sun,  4 May 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sztuBlgp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6414F70;
	Sun,  4 May 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746355154; cv=none; b=NrstLsjS5aLBu2i7t5JPHFwTvmZG9mDF/iycIoPaQFFzsIBRJ9R4sqZI23jTvplGu2mGKeON72iIOAaPU4x7sz0aYzynvO1KJ4zy3OTSEbtqerRMCSITIM1QSV7kg3akF0J93CFeLZhP7n7uGdjlBWHtbMktqi4U3jznBRB8wyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746355154; c=relaxed/simple;
	bh=GTEi23sovXjfk7ZSs/2mXXPsbuBZgDBj358bejUAMBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmkhGvnICaVG3/jYLxQbg7pBXWS8CKJVOcN7F5XgaxdDfRnTtsF0COOPBJU2vEA5G6AHAnzB1tQ7jukLS8Ih4QzEIvLSfhlm8CCmb4P4Qf426fUZvUe69EY332I8xABQh3MKH7fwGLRndgHWWmRCdnY3IoEDmZ/g/1V3GoeNDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sztuBlgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90E5C4CEE7;
	Sun,  4 May 2025 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746355153;
	bh=GTEi23sovXjfk7ZSs/2mXXPsbuBZgDBj358bejUAMBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sztuBlgpN9fGR9CkcA08YmE0hdKn6Qh3IyW3pT4SWPouph64YNubeQWVr/KNjOZ7F
	 xhqqtuTF43SdtmDrEHPrhMILvzOI3a2S3U3C8QYD0uns/rY8xcy6XWY6FKrMfuIWxm
	 lQfQKlj4Qw+xjETUzRATiwP9qfm2BwAhMMVC5QMiIb3ypvmpwJXkQ57410f28fcKpx
	 2XSd6G8KYqB6TMV7+xVlpPRT747eEncoG6b9pefhb9KLwwDH14gEYzl6lbyU2aRDAy
	 m27Zmi9EIsSJgw5Quu0oGSOZmF/puKTa7HFdDu1hauzOrq/o/L+F+80CRfZfXoF72i
	 sgS9H1ntGlKNA==
Date: Sun, 4 May 2025 11:39:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 10/11] iio: accel: adxl345: add coupling detection
 for activity/inactivity
Message-ID: <20250504113907.5030b02d@jic23-huawei>
In-Reply-To: <CAFXKEHZ60bREfFmi33XSyrUNigyuQv+by4vh+uoUErni_UEcnw@mail.gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-11-l.rubusch@gmail.com>
	<20250427140032.3112f51b@jic23-huawei>
	<CAFXKEHZ60bREfFmi33XSyrUNigyuQv+by4vh+uoUErni_UEcnw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 1 May 2025 09:35:29 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Apr 27, 2025 at 3:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 21 Apr 2025 22:06:40 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add coupling activity/inactivity detection by the AC/DC bit. This is =
an
> > > addititional enhancement for the detection of activity states and
> > > completes the activity / inactivity feature of the ADXL345.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> >
> > I've dragged the table from the earlier patch into this one that actual=
ly uses it.
> > However I'm a little unsure on exactly how we present this feature.
> >
> > So until those questions are resolved I've dropped the patch (you'll ne=
ed
> > to rebase on my testing branch and fix up missing table for v8).
> >
> > The bit that made me not apply this series (with some tweaks) was that
> > I'd expect enabling AC events to be visible as disabling of DC ones.
> > =20
>=20
> There are no AC events, nor DC ones.
>=20
> Think of AC- or DC-coupled detection as modes of operating the
> ACTIVITY/INACTIVITY
> detection. The events are ACTIVITY or INACTIVITY.=20

That's where we differ. For generalizing an ABI we absolutely should
not think of them as modes - that's an implementation detail only

> It has effect on how
> the sensor detects
> if it needs to trigger an (IN)/ACTIVITY event. DC is just going by the
> configured thresholds,
> where AC is supposed to apply some more elaborate way of declaring ACTIVI=
TY or
> INACTIVITY.
>=20
> The fact that you imply on this means to me, at least I explained it
> wrong, or need to clarify
> better.

Not at all (I think).  This is a question of datasheet representation vs
what we are doing in the ABI.  Lets have a thought experiment.

If the device had separate enables, thresholds and periods for
DC activity, DC inactivity, AC activity and AC inactivity would you be
thinking of them as modes of one event?  They would be separate event types
that could be all enabled at the same time.

Now step 2.  We have many sensors that have limited numbers of highly progr=
ammable
event detection engines (the adis IMUs for instance have only a few such en=
gines
but many types of events). For those we treat them as a fifo.  If you reque=
st
3 events and the device has 2 detectors you get the last two that were asked
for.  We do this because we don't want a detector with 10s of modes with
the parameter meaning changing for each one.  The ABI should look the same
as independent detectors.  Some models are more complex and have more such
engines, but the interface remains the same.

So here we have a pair of less flexible engines that can support either
AC or DC for inactivity/activity.  We should represent that the same
way we represent the separate engines case.  Hence when you enable
activity AC, our short (1 element) fifo means we disable activity DC.

Which is why treating them as separate engines (with rules on which can
be enabled at any time) is the right way to go.  IIRC correctly long
ago we had various experiments with interfaces around this (including
mode based ones) and ended up with this approach that looks like a
whole bunch of event detectors with a mux that means we can only use
a subset at a time.

Jonathan


>=20
> > Also, I just noticed you aren't pushing the new event types.
> >
> > These controls need to look like a separate event detector hardware blo=
ck
> > with it's own controls + its own event codes.  The fact only this or
> > the DC version can be enabled at any time should only be exposed in the
> > reported state, not apparent via what files we expose etc.  On some
> > other device they may be independent hardware blocks.
> >
> > Note I'd also expect to see value controls for these new events. You may
> > need to cache the values and update on event change if the meaning is
> > very different.   That's because the expectation would be an event
> > setup sequence from userspace is:
> >
> > 1) Set value of threshold
> > 2) Enable event
> >
> > On a change of event (due to shared hardware) The value set may scramble
> > the event already enabled.
> >
> > So write the values into a cache and update to the right one when chang=
ing
> > event.
> > =20
>=20
> Might be that I got you wrong here, but I assume the above does
> actually not apply.
>=20
> Best,
> L
>=20
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 162 +++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 159 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index b25efcad069b..c07ad5774c8a 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -37,7 +37,9 @@
> > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > >  #define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > +#define ADXL345_REG_ACT_ACDC_MSK     BIT(7)
> > >  #define ADXL345_REG_INACT_AXIS_MSK   GENMASK(2, 0)
> > > +#define ADXL345_REG_INACT_ACDC_MSK   BIT(3)
> > >  #define ADXL345_POWER_CTL_INACT_MSK  (ADXL345_POWER_CTL_AUTO_SLEEP |=
 ADXL345_POWER_CTL_LINK)
> > >
> > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > @@ -91,6 +93,11 @@ static const unsigned int adxl345_act_thresh_reg[]=
 =3D {
> > >       [ADXL345_INACTIVITY] =3D ADXL345_REG_THRESH_INACT,
> > >  };
> > >
> > > +static const unsigned int adxl345_act_acdc_msk[] =3D {
> > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_ACT_ACDC_MSK,
> > > +     [ADXL345_INACTIVITY] =3D ADXL345_REG_INACT_ACDC_MSK,
> > > +};
> > > +
> > >  enum adxl345_odr {
> > >       ADXL345_ODR_0P10HZ =3D 0,
> > >       ADXL345_ODR_0P20HZ,
> > > @@ -204,6 +211,18 @@ static struct iio_event_spec adxl345_events[] =
=3D {
> > >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> > >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> > >       },
> > > +     {
> > > +             /* activity, activity - ac bit */ =20
> > Comment says activity and inactivity but channel type wise this
> > is just activity (as rising)
> > =20
> > > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > > +             .dir =3D IIO_EV_DIR_RISING,
> > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > > +     },
> > > +     {
> > > +             /* activity, inactivity - ac bit */ =20
> >
> > Likewise this seems to be inactivity.  Should this be in the x&y&z
> > channel, not this one?
> > =20
> > > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > > +             .dir =3D IIO_EV_DIR_FALLING,
> > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > > +     },
> > >  };
> > >
> > >  #define ADXL345_CHANNEL(index, reg, axis) {                         =
         \
> > > @@ -320,6 +339,69 @@ static int adxl345_set_measure_en(struct adxl345=
_state *st, bool en)
> > >
> > >  /* act/inact */
> > >
> > > +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> > > +                                enum adxl345_activity_type type, boo=
l *ac)
> > > +{
> > > +     unsigned int regval;
> > > +     int ret;
> > > +
> > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &re=
gval);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (type =3D=3D ADXL345_ACTIVITY)
> > > +             *ac =3D FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval);
> > > +     else
> > > +             *ac =3D FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> > > +                                 enum adxl345_activity_type type, bo=
ol ac)
> > > +{
> > > +     unsigned int act_inact_ac =3D ac ? 0xff : 0x00;
> > > +
> > > +     /*
> > > +      * A setting of false selects dc-coupled operation, and a setti=
ng of
> > > +      * true enables ac-coupled operation. In dc-coupled operation, =
the
> > > +      * current acceleration magnitude is compared directly with
> > > +      * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to deter=
mine
> > > +      * whether activity or inactivity is detected.
> > > +      *
> > > +      * In ac-coupled operation for activity detection, the accelera=
tion
> > > +      * value at the start of activity detection is taken as a refer=
ence
> > > +      * value. New samples of acceleration are then compared to this
> > > +      * reference value, and if the magnitude of the difference exce=
eds the
> > > +      * ADXL345_REG_THRESH_ACT value, the device triggers an activity
> > > +      * interrupt.
> > > +      *
> > > +      * Similarly, in ac-coupled operation for inactivity detection,=
 a
> > > +      * reference value is used for comparison and is updated whenev=
er the
> > > +      * device exceeds the inactivity threshold. After the reference=
 value
> > > +      * is selected, the device compares the magnitude of the differ=
ence
> > > +      * between the reference value and the current acceleration with
> > > +      * ADXL345_REG_THRESH_INACT. If the difference is less than the=
 value in
> > > +      * ADXL345_REG_THRESH_INACT for the time in ADXL345_REG_TIME_IN=
ACT, the
> > > +      * device is considered inactive and the inactivity interrupt is
> > > +      * triggered. [quoted from p. 24, ADXL345 datasheet Rev. G]
> > > +      *
> > > +      * In a conclusion, the first acceleration snapshot sample whic=
h hit the
> > > +      * threshold in a particular direction is always taken as accel=
eration
> > > +      * reference value to that direction. Since for the hardware ac=
tivity
> > > +      * and inactivity depend on the x/y/z axis, so do ac and dc cou=
pling.
> > > +      * Note, this sw driver always enables or disables all three x/=
y/z axis
> > > +      * for detection via act_axis_ctrl and inact_axis_ctrl, respect=
ively.
> > > +      * Where in dc-coupling samples are compared against the thresh=
olds, in
> > > +      * ac-coupling measurement difference to the first acceleration
> > > +      * reference value are compared against the threshold. So, ac-c=
oupling
> > > +      * allows for a bit more dynamic compensation depending on the =
initial
> > > +      * sample.
> > > +      */
> > > +     return regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTR=
L,
> > > +                              adxl345_act_acdc_msk[type], act_inact_=
ac);
> > > +} =20
> > =20
> > >  static int adxl345_find_range(struct adxl345_state *st, int val, int=
 val2,
> > > @@ -797,9 +886,51 @@ static int adxl345_find_range(struct adxl345_sta=
te *st, int val, int val2,
> > >
> > >  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_=
range range)
> > >  {
> > > -     return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> > > +     unsigned int act_threshold, inact_threshold;
> > > +     unsigned int range_old;
> > > +     unsigned int regval;
> > > +     int ret;
> > > +
> > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regva=
l);
> > > +     if (ret)
> > > +             return ret;
> > > +     range_old =3D FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> > > +
> > > +     ret =3D regmap_read(st->regmap,
> > > +                       adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> > > +                       &act_threshold);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D regmap_read(st->regmap,
> > > +                       adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> > > +                       &inact_threshold);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> > >                                ADXL345_DATA_FORMAT_RANGE,
> > >                                FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, =
range));
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     act_threshold =3D act_threshold
> > > +             * adxl345_range_factor_tbl[range_old]
> > > +             / adxl345_range_factor_tbl[range];
> > > +     act_threshold =3D min(255, max(1, inact_threshold));
> > > + =20
> > This is first use of the range table. So introduce that in this patch.
> > =20
> > > +     inact_threshold =3D inact_threshold
> > > +             * adxl345_range_factor_tbl[range_old]
> > > +             / adxl345_range_factor_tbl[range];
> > > +     inact_threshold =3D min(255, max(1, inact_threshold));
> > > +
> > > +     ret =3D regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345=
_ACTIVITY],
> > > +                        act_threshold);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_=
INACTIVITY],
> > > +                        inact_threshold);
> > >  }
> > >
> > >  static int adxl345_read_avail(struct iio_dev *indio_dev,
> > > @@ -938,7 +1069,7 @@ static int adxl345_read_event_config(struct iio_=
dev *indio_dev,
> > >                                    enum iio_event_direction dir)
> > >  {
> > >       struct adxl345_state *st =3D iio_priv(indio_dev);
> > > -     bool int_en;
> > > +     bool int_en, act_ac, inact_ac;
> > >       int ret;
> > >
> > >       switch (type) {
> > > @@ -983,6 +1114,21 @@ static int adxl345_read_event_config(struct iio=
_dev *indio_dev,
> > >               if (ret)
> > >                       return ret;
> > >               return int_en;
> > > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > > +             switch (dir) {
> > > +             case IIO_EV_DIR_RISING:
> > > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345_ACT=
IVITY, &act_ac); =20
> >
> > Do we not need a check in the enabling of the DC events as well?  If we=
 have enabled
> > AC the DC one should report disabled (and if we enable that again then =
we should
> > update this.
> > =20
> > > +                     if (ret)
> > > +                             return ret;
> > > +                     return act_ac;
> > > +             case IIO_EV_DIR_FALLING:
> > > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345_INA=
CTIVITY, &inact_ac);
> > > +                     if (ret)
> > > +                             return ret;
> > > +                     return inact_ac;
> > > +             default:
> > > +                     return -EINVAL;
> > > +             }
> > >       default:
> > >               return -EINVAL;
> > >       }
> > > @@ -1019,6 +1165,16 @@ static int adxl345_write_event_config(struct i=
io_dev *indio_dev,
> > >               }
> > >       case IIO_EV_TYPE_MAG:
> > >               return adxl345_set_ff_en(st, state);
> > > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > > +             switch (dir) {
> > > +             case IIO_EV_DIR_RISING:
> > > +                     return adxl345_set_act_inact_ac(st, ADXL345_ACT=
IVITY, state); =20
> >
> > Similar to read path.  The DC events should be affected by this as well=
 as the AC ones.
> > =20
> > > +             case IIO_EV_DIR_FALLING:
> > > +                     return adxl345_set_act_inact_ac(st, ADXL345_INA=
CTIVITY, state);
> > > +             default:
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > >       default:
> > >               return -EINVAL;
> > >       } =20
> > =20


