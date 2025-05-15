Return-Path: <linux-iio+bounces-19524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13486AB7EF2
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609064C1BA2
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACF202C2A;
	Thu, 15 May 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrU8vWk7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6241FFC46;
	Thu, 15 May 2025 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294606; cv=none; b=QyW71Y6REBNdKEfh6YRp+01B1I2pViGSHhIvYksFQgCrNUiB86ryNnDzh5UW6S54QBQHcEKn3+/aQjcY9GO1Hm6QVnE2og4gkDCmOvJ6xFhqJV5QOWI2FVMKVrwNln9CNU21u8oDdpjdqnbYGHJJ3MO3wiuVtr+tVxv+ZKQa0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294606; c=relaxed/simple;
	bh=gXBjwiQfN2NmlauHQfc5qJjXDFmBxA25P9oFmctnxxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOaYcBLpjuzSCKIkck8TJtg1A11UKAAdUSF1A/leYhl2KuiJb+fCaccW/fwPUzGvDRVJ2uAj7I6nC7ROu2B+kN6+5Q9+J8V6nSMOJUv0Bh22LPP1RnXDIP12Yk44OeoyHdL3sa+qyfhl9oCQRhbuvxhoLjdHqIrF3dCxXs87grI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrU8vWk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6247FC4CEE9;
	Thu, 15 May 2025 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747294605;
	bh=gXBjwiQfN2NmlauHQfc5qJjXDFmBxA25P9oFmctnxxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UrU8vWk7yQhzeEtyZwjkWdA1DUkXBnDHSA1AC54AhgTeZpRAJbBCXQJMQg1zGO1q4
	 qhTmAbu1pA3EnG49I6An2dOpOjfExWeGKQQHw7FgpWYntjpgM1KcPPhXZhEdA+fusV
	 mInWemdBJi7fs5YjMwjJIaXv875z6saZgM1JLcsYxBEG3+GkvXyDRECSoSKfu5O/jF
	 9pMankp/+o56X4ESNNjTreXeDQqcqhJWt/dSlJYrN5A67HuayX/xSo28KmbABLLe71
	 kLZ3FavUFHi830MWYXp80ihcMF00TwOeUM7HfJoAOd1/JYCrlflmcQzQdRQkguBQK2
	 uiVs+dVI93++w==
Date: Thu, 15 May 2025 08:36:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 10/11] iio: accel: adxl345: add coupling detection
 for activity/inactivity
Message-ID: <20250515083638.14ee1292@jic23-huawei>
In-Reply-To: <CAFXKEHaupT2RZqNaQnLjiKpCodHSHsswhRXCKAmGh_Tnr3iXJQ@mail.gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-11-l.rubusch@gmail.com>
	<20250427140032.3112f51b@jic23-huawei>
	<CAFXKEHZ60bREfFmi33XSyrUNigyuQv+by4vh+uoUErni_UEcnw@mail.gmail.com>
	<20250504113907.5030b02d@jic23-huawei>
	<CAFXKEHaupT2RZqNaQnLjiKpCodHSHsswhRXCKAmGh_Tnr3iXJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 22:04:29 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sun, May 4, 2025 at 12:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Thu, 1 May 2025 09:35:29 +0200
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > On Sun, Apr 27, 2025 at 3:00=E2=80=AFPM Jonathan Cameron <jic23@kerne=
l.org> wrote: =20
> > > >
> > > > On Mon, 21 Apr 2025 22:06:40 +0000
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > =20
> > > > > Add coupling activity/inactivity detection by the AC/DC bit. This=
 is an
> > > > > addititional enhancement for the detection of activity states and
> > > > > completes the activity / inactivity feature of the ADXL345.
> > > > >
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > > >
> > > > I've dragged the table from the earlier patch into this one that ac=
tually uses it.
> > > > However I'm a little unsure on exactly how we present this feature.
> > > >
> > > > So until those questions are resolved I've dropped the patch (you'l=
l need
> > > > to rebase on my testing branch and fix up missing table for v8).
> > > >
> > > > The bit that made me not apply this series (with some tweaks) was t=
hat
> > > > I'd expect enabling AC events to be visible as disabling of DC ones.
> > > > =20
> > >
> > > There are no AC events, nor DC ones.
> > >
> > > Think of AC- or DC-coupled detection as modes of operating the
> > > ACTIVITY/INACTIVITY
> > > detection. The events are ACTIVITY or INACTIVITY. =20
> >
> > That's where we differ. For generalizing an ABI we absolutely should
> > not think of them as modes - that's an implementation detail only
> > =20
> > > It has effect on how
> > > the sensor detects
> > > if it needs to trigger an (IN)/ACTIVITY event. DC is just going by the
> > > configured thresholds,
> > > where AC is supposed to apply some more elaborate way of declaring AC=
TIVITY or
> > > INACTIVITY.
> > >
> > > The fact that you imply on this means to me, at least I explained it
> > > wrong, or need to clarify
> > > better. =20
> >
> > Not at all (I think).  This is a question of datasheet representation vs
> > what we are doing in the ABI.  Lets have a thought experiment.
> >
> > If the device had separate enables, thresholds and periods for
> > DC activity, DC inactivity, AC activity and AC inactivity would you be
> > thinking of them as modes of one event?  They would be separate event t=
ypes
> > that could be all enabled at the same time.
> >
> > Now step 2.  We have many sensors that have limited numbers of highly p=
rogrammable
> > event detection engines (the adis IMUs for instance have only a few suc=
h engines
> > but many types of events). For those we treat them as a fifo.  If you r=
equest
> > 3 events and the device has 2 detectors you get the last two that were =
asked
> > for.  We do this because we don't want a detector with 10s of modes with
> > the parameter meaning changing for each one.  The ABI should look the s=
ame
> > as independent detectors.  Some models are more complex and have more s=
uch
> > engines, but the interface remains the same.
> >
> > So here we have a pair of less flexible engines that can support either
> > AC or DC for inactivity/activity.  We should represent that the same
> > way we represent the separate engines case.  Hence when you enable
> > activity AC, our short (1 element) fifo means we disable activity DC.
> >
> > Which is why treating them as separate engines (with rules on which can
> > be enabled at any time) is the right way to go.  IIRC correctly long
> > ago we had various experiments with interfaces around this (including
> > mode based ones) and ended up with this approach that looks like a
> > whole bunch of event detectors with a mux that means we can only use
> > a subset at a time.
> >
> > Jonathan
> > =20
>=20
> Thank  you so much for this explanation. It makes it much clearer to
> me now to understand what
> you were writing about before.
>=20
> Anyway, I just wanted to confirm what is missing here. I'll need to
> distinguish the following events:
> - activity_ac
> - inactivity_ac
> - activity_dc
> - inactivity_dc
>=20
> For the implementation, each shall be a separate event, i.e. each will
> have separate handles in sysfs:
> - event config: enable
> - event value: threshold
> - event value: time
>=20
yes, so 4 different events for inactivty/activity - only one type
of inactivity enabled at a time and only one type of activity event enabled

> Internally I will use the regmap cached flag for AC/DC to distinguish
> if the ACTIVITY or INACTIVITY event belongs to activity_ac or
> inactivity_dc. Threshold and time values will be specific to ACTIVITY
> and INACTIVITY, respectively. Since, the events will be still activity
> / inactivity, as their registers will be so, too.=20

> The distinction thus
> will be rather a question of the presented handles in sysfs.
> All events will be type MAG, and dir RISING (activity) or FALLING
> (inactivity). As said above, dc /  ac coupling I will read from the
> cache.

Not quite.  The caching bit is all fine but the sysfs events
have to represent AC/DC and they do that with different event types.
>=20
> Is this approach sufficient to solve the required adjustments, or do
> the events themselves need further information about coupling (I guess
> so, how can I represent this in the events?)?


activity_dc is a simple magnitude threshold type event.
activity_ac is one of two options depending on how we think about it.
MAG_REFERENCED if we ignore the reset of the reference when activity_ac and
inactivity_ac are coupled.
MAG_ADAPTIVE if we take it that the base point for the threshold is changing
over time (which is slightly more accurate if inactivity and activity are
coupled). =20

I think I slightly prefer MAG_ADAPTIVE but it's a corner case because
until the other state occurs we don't adapt and it looks more like
a referenced event.

So we'd have 4 event types for these.  2 for activity and 2 for inactivity.

Jonathan

>=20
> Best,
> L
>=20
> > =20
> > > =20
> > > > Also, I just noticed you aren't pushing the new event types.
> > > >
> > > > These controls need to look like a separate event detector hardware=
 block
> > > > with it's own controls + its own event codes.  The fact only this or
> > > > the DC version can be enabled at any time should only be exposed in=
 the
> > > > reported state, not apparent via what files we expose etc.  On some
> > > > other device they may be independent hardware blocks.
> > > >
> > > > Note I'd also expect to see value controls for these new events. Yo=
u may
> > > > need to cache the values and update on event change if the meaning =
is
> > > > very different.   That's because the expectation would be an event
> > > > setup sequence from userspace is:
> > > >
> > > > 1) Set value of threshold
> > > > 2) Enable event
> > > >
> > > > On a change of event (due to shared hardware) The value set may scr=
amble
> > > > the event already enabled.
> > > >
> > > > So write the values into a cache and update to the right one when c=
hanging
> > > > event.
> > > > =20
> > >
> > > Might be that I got you wrong here, but I assume the above does
> > > actually not apply.
> > >
> > > Best,
> > > L
> > > =20
> > > > > ---
> > > > >  drivers/iio/accel/adxl345_core.c | 162 +++++++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 159 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel=
/adxl345_core.c
> > > > > index b25efcad069b..c07ad5774c8a 100644
> > > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > > @@ -37,7 +37,9 @@
> > > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > > > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > > >  #define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > > > +#define ADXL345_REG_ACT_ACDC_MSK     BIT(7)
> > > > >  #define ADXL345_REG_INACT_AXIS_MSK   GENMASK(2, 0)
> > > > > +#define ADXL345_REG_INACT_ACDC_MSK   BIT(3)
> > > > >  #define ADXL345_POWER_CTL_INACT_MSK  (ADXL345_POWER_CTL_AUTO_SLE=
EP | ADXL345_POWER_CTL_LINK)
> > > > >
> > > > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > > > @@ -91,6 +93,11 @@ static const unsigned int adxl345_act_thresh_r=
eg[] =3D {
> > > > >       [ADXL345_INACTIVITY] =3D ADXL345_REG_THRESH_INACT,
> > > > >  };
> > > > >
> > > > > +static const unsigned int adxl345_act_acdc_msk[] =3D {
> > > > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_ACT_ACDC_MSK,
> > > > > +     [ADXL345_INACTIVITY] =3D ADXL345_REG_INACT_ACDC_MSK,
> > > > > +};
> > > > > +
> > > > >  enum adxl345_odr {
> > > > >       ADXL345_ODR_0P10HZ =3D 0,
> > > > >       ADXL345_ODR_0P20HZ,
> > > > > @@ -204,6 +211,18 @@ static struct iio_event_spec adxl345_events[=
] =3D {
> > > > >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> > > > >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> > > > >       },
> > > > > +     {
> > > > > +             /* activity, activity - ac bit */ =20
> > > > Comment says activity and inactivity but channel type wise this
> > > > is just activity (as rising)
> > > > =20
> > > > > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > > > > +             .dir =3D IIO_EV_DIR_RISING,
> > > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > > > > +     },
> > > > > +     {
> > > > > +             /* activity, inactivity - ac bit */ =20
> > > >
> > > > Likewise this seems to be inactivity.  Should this be in the x&y&z
> > > > channel, not this one?
> > > > =20
> > > > > +             .type =3D IIO_EV_TYPE_MAG_REFERENCED,
> > > > > +             .dir =3D IIO_EV_DIR_FALLING,
> > > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
> > > > > +     },
> > > > >  };
> > > > >
> > > > >  #define ADXL345_CHANNEL(index, reg, axis) {                     =
             \
> > > > > @@ -320,6 +339,69 @@ static int adxl345_set_measure_en(struct adx=
l345_state *st, bool en)
> > > > >
> > > > >  /* act/inact */
> > > > >
> > > > > +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> > > > > +                                enum adxl345_activity_type type,=
 bool *ac)
> > > > > +{
> > > > > +     unsigned int regval;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL,=
 &regval);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     if (type =3D=3D ADXL345_ACTIVITY)
> > > > > +             *ac =3D FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval);
> > > > > +     else
> > > > > +             *ac =3D FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regva=
l);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> > > > > +                                 enum adxl345_activity_type type=
, bool ac)
> > > > > +{
> > > > > +     unsigned int act_inact_ac =3D ac ? 0xff : 0x00;
> > > > > +
> > > > > +     /*
> > > > > +      * A setting of false selects dc-coupled operation, and a s=
etting of
> > > > > +      * true enables ac-coupled operation. In dc-coupled operati=
on, the
> > > > > +      * current acceleration magnitude is compared directly with
> > > > > +      * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to d=
etermine
> > > > > +      * whether activity or inactivity is detected.
> > > > > +      *
> > > > > +      * In ac-coupled operation for activity detection, the acce=
leration
> > > > > +      * value at the start of activity detection is taken as a r=
eference
> > > > > +      * value. New samples of acceleration are then compared to =
this
> > > > > +      * reference value, and if the magnitude of the difference =
exceeds the
> > > > > +      * ADXL345_REG_THRESH_ACT value, the device triggers an act=
ivity
> > > > > +      * interrupt.
> > > > > +      *
> > > > > +      * Similarly, in ac-coupled operation for inactivity detect=
ion, a
> > > > > +      * reference value is used for comparison and is updated wh=
enever the
> > > > > +      * device exceeds the inactivity threshold. After the refer=
ence value
> > > > > +      * is selected, the device compares the magnitude of the di=
fference
> > > > > +      * between the reference value and the current acceleration=
 with
> > > > > +      * ADXL345_REG_THRESH_INACT. If the difference is less than=
 the value in
> > > > > +      * ADXL345_REG_THRESH_INACT for the time in ADXL345_REG_TIM=
E_INACT, the
> > > > > +      * device is considered inactive and the inactivity interru=
pt is
> > > > > +      * triggered. [quoted from p. 24, ADXL345 datasheet Rev. G]
> > > > > +      *
> > > > > +      * In a conclusion, the first acceleration snapshot sample =
which hit the
> > > > > +      * threshold in a particular direction is always taken as a=
cceleration
> > > > > +      * reference value to that direction. Since for the hardwar=
e activity
> > > > > +      * and inactivity depend on the x/y/z axis, so do ac and dc=
 coupling.
> > > > > +      * Note, this sw driver always enables or disables all thre=
e x/y/z axis
> > > > > +      * for detection via act_axis_ctrl and inact_axis_ctrl, res=
pectively.
> > > > > +      * Where in dc-coupling samples are compared against the th=
resholds, in
> > > > > +      * ac-coupling measurement difference to the first accelera=
tion
> > > > > +      * reference value are compared against the threshold. So, =
ac-coupling
> > > > > +      * allows for a bit more dynamic compensation depending on =
the initial
> > > > > +      * sample.
> > > > > +      */
> > > > > +     return regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT=
_CTRL,
> > > > > +                              adxl345_act_acdc_msk[type], act_in=
act_ac);
> > > > > +} =20
> > > > =20
> > > > >  static int adxl345_find_range(struct adxl345_state *st, int val,=
 int val2,
> > > > > @@ -797,9 +886,51 @@ static int adxl345_find_range(struct adxl345=
_state *st, int val, int val2,
> > > > >
> > > > >  static int adxl345_set_range(struct adxl345_state *st, enum adxl=
345_range range)
> > > > >  {
> > > > > -     return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORM=
AT,
> > > > > +     unsigned int act_threshold, inact_threshold;
> > > > > +     unsigned int range_old;
> > > > > +     unsigned int regval;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &r=
egval);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +     range_old =3D FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> > > > > +
> > > > > +     ret =3D regmap_read(st->regmap,
> > > > > +                       adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> > > > > +                       &act_threshold);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     ret =3D regmap_read(st->regmap,
> > > > > +                       adxl345_act_thresh_reg[ADXL345_INACTIVITY=
],
> > > > > +                       &inact_threshold);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FOR=
MAT,
> > > > >                                ADXL345_DATA_FORMAT_RANGE,
> > > > >                                FIELD_PREP(ADXL345_DATA_FORMAT_RAN=
GE, range));
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     act_threshold =3D act_threshold
> > > > > +             * adxl345_range_factor_tbl[range_old]
> > > > > +             / adxl345_range_factor_tbl[range];
> > > > > +     act_threshold =3D min(255, max(1, inact_threshold));
> > > > > + =20
> > > > This is first use of the range table. So introduce that in this pat=
ch.
> > > > =20
> > > > > +     inact_threshold =3D inact_threshold
> > > > > +             * adxl345_range_factor_tbl[range_old]
> > > > > +             / adxl345_range_factor_tbl[range];
> > > > > +     inact_threshold =3D min(255, max(1, inact_threshold));
> > > > > +
> > > > > +     ret =3D regmap_write(st->regmap, adxl345_act_thresh_reg[ADX=
L345_ACTIVITY],
> > > > > +                        act_threshold);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL=
345_INACTIVITY],
> > > > > +                        inact_threshold);
> > > > >  }
> > > > >
> > > > >  static int adxl345_read_avail(struct iio_dev *indio_dev,
> > > > > @@ -938,7 +1069,7 @@ static int adxl345_read_event_config(struct =
iio_dev *indio_dev,
> > > > >                                    enum iio_event_direction dir)
> > > > >  {
> > > > >       struct adxl345_state *st =3D iio_priv(indio_dev);
> > > > > -     bool int_en;
> > > > > +     bool int_en, act_ac, inact_ac;
> > > > >       int ret;
> > > > >
> > > > >       switch (type) {
> > > > > @@ -983,6 +1114,21 @@ static int adxl345_read_event_config(struct=
 iio_dev *indio_dev,
> > > > >               if (ret)
> > > > >                       return ret;
> > > > >               return int_en;
> > > > > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > > > > +             switch (dir) {
> > > > > +             case IIO_EV_DIR_RISING:
> > > > > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345=
_ACTIVITY, &act_ac); =20
> > > >
> > > > Do we not need a check in the enabling of the DC events as well?  I=
f we have enabled
> > > > AC the DC one should report disabled (and if we enable that again t=
hen we should
> > > > update this.
> > > > =20
> > > > > +                     if (ret)
> > > > > +                             return ret;
> > > > > +                     return act_ac;
> > > > > +             case IIO_EV_DIR_FALLING:
> > > > > +                     ret =3D adxl345_is_act_inact_ac(st, ADXL345=
_INACTIVITY, &inact_ac);
> > > > > +                     if (ret)
> > > > > +                             return ret;
> > > > > +                     return inact_ac;
> > > > > +             default:
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > >       default:
> > > > >               return -EINVAL;
> > > > >       }
> > > > > @@ -1019,6 +1165,16 @@ static int adxl345_write_event_config(stru=
ct iio_dev *indio_dev,
> > > > >               }
> > > > >       case IIO_EV_TYPE_MAG:
> > > > >               return adxl345_set_ff_en(st, state);
> > > > > +     case IIO_EV_TYPE_MAG_REFERENCED:
> > > > > +             switch (dir) {
> > > > > +             case IIO_EV_DIR_RISING:
> > > > > +                     return adxl345_set_act_inact_ac(st, ADXL345=
_ACTIVITY, state); =20
> > > >
> > > > Similar to read path.  The DC events should be affected by this as =
well as the AC ones.
> > > > =20
> > > > > +             case IIO_EV_DIR_FALLING:
> > > > > +                     return adxl345_set_act_inact_ac(st, ADXL345=
_INACTIVITY, state);
> > > > > +             default:
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > > +
> > > > >       default:
> > > > >               return -EINVAL;
> > > > >       } =20
> > > > =20
> > =20


