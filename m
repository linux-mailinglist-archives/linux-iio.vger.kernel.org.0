Return-Path: <linux-iio+bounces-19029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262BAA85FE
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 12:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B5F1899A7D
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD019E819;
	Sun,  4 May 2025 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxpMVN7K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCC1BC3C;
	Sun,  4 May 2025 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354549; cv=none; b=ZjNruFEYG6hVkslSWFM9ewR5TLxzwj1Qg84c6JtfJI4uDz1CxKwD/Ll26qHaLQz/Oiz5Nk+lZLwVYu7moARcxHf12AED1k8SfI3E2rI3atWfaSN1suLmvY9AGbAznrfLr5c6dedKKHUARffnZY4/fsoPQW41orDt6MgNcwoW7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354549; c=relaxed/simple;
	bh=krRNJg6Hz7KWX1vHDa6l0gePIA0kEl+sndGGSv3Tqhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHbe7OLnfoE+m9Cp02Wy945HJxZTKFdI8XPXDf3RH0XeSva7Bnx43Lm6G2Uaanq/IHMUmAsYy4w9FQQeEvBKMl6qagT0gMbk2a1tBSB788+zN6/qiLI4u1PrQ1mSZ4KIIBFaRVPqIhA/XXvxBVDPacFNpy3Jux3vke96AMJEZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxpMVN7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DB0C4CEE7;
	Sun,  4 May 2025 10:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746354548;
	bh=krRNJg6Hz7KWX1vHDa6l0gePIA0kEl+sndGGSv3Tqhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OxpMVN7KwML9KceM4dk2wL/wRM+Wi/h2S2BTWjRAuuq3YLJ/QisVcbnMNJdSMmquz
	 D9WVM4e6SGzo1s3vKNr5xrNpBiEA0JaS0MpJiYw8r1lE9gmGWre2Ryyw/f3ozW/mDs
	 bmP1MN8bfl8Rh2/onH7ub/3zqEL6H+9W1GNnve9doQfdfZkT+Wh57NcWe0pjTGh603
	 2DK36mKGVqqLGKS/qf7SKrPrxECCY6ueDRkCDOBnKQJyr5XLz37yn2kSbYjKpoSGt+
	 NjjgdMXh69p9vLWDDtiE9YEHQI1GNsPk0tNugQCZg90MS43fMCzoCrYP6CdSOhaliu
	 +9A1diTP1UuNg==
Date: Sun, 4 May 2025 11:29:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 08/11] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250504112904.64c1b5ee@jic23-huawei>
In-Reply-To: <CAFXKEHZ3KQ_Z4QB==Bb_CTauV7Wowd0Lgxaick=6mfiLJU654Q@mail.gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-9-l.rubusch@gmail.com>
	<20250427134759.3cc3a2a4@jic23-huawei>
	<CAFXKEHZ3KQ_Z4QB==Bb_CTauV7Wowd0Lgxaick=6mfiLJU654Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 1 May 2025 00:53:32 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan - Hi IIO list,
>=20
> Please, find some (many) questions inlined down below. Appologies for
> the separate
> channels last time and not right away fixing them up as array. I did
> not want to make extra work.
>=20
> On Sun, Apr 27, 2025 at 2:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 21 Apr 2025 22:06:38 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Make the sensor detect and issue interrupts at activity. Activity
> > > events are configured by a threshold stored in regmap cache. Initiali=
ze
> > > the activity threshold register to a reasonable default value in prob=
e.
> > > The value is taken from the older ADXL345 input driver, to provide a
> > > similar behavior. Reset the activity/inactivity direction enabling
> > > register in probe. Reset and initialization shall bring the sensor in=
 a
> > > defined initial state to prevent dangling settings when warm restarti=
ng
> > > the sensor.
> > >
> > > Activity, ODR configuration together with the range setting prepare t=
he
> > > activity/inactivity hystersesis setup, implemented in a follow up pat=
ch.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 217 +++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 214 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 80b5b8402ced..680981609d83 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -36,11 +36,16 @@
> > >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > +#define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > >
> > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > >  #define ADXL345_TAP_Y_EN             BIT(1)
> > >  #define ADXL345_TAP_X_EN             BIT(2)
> > >
> > > +#define ADXL345_ACT_Z_EN             BIT(4)
> > > +#define ADXL345_ACT_Y_EN             BIT(5)
> > > +#define ADXL345_ACT_X_EN             BIT(6)
> > > +
> > >  /* single/double tap */
> > >  enum adxl345_tap_type {
> > >       ADXL345_SINGLE_TAP,
> > > @@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_time_reg[] =
=3D {
> > >       [ADXL345_TAP_TIME_DUR] =3D ADXL345_REG_DUR,
> > >  };
> > >
> > > +/* activity/inactivity */
> > > +enum adxl345_activity_type {
> > > +     ADXL345_ACTIVITY,
> > > +};
> > > +
> > > +static const unsigned int adxl345_act_int_reg[] =3D {
> > > +     [ADXL345_ACTIVITY] =3D ADXL345_INT_ACTIVITY,
> > > +};
> > > +
> > > +static const unsigned int adxl345_act_thresh_reg[] =3D {
> > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_THRESH_ACT,
> > > +};
> > > +
> > >  enum adxl345_odr {
> > >       ADXL345_ODR_0P10HZ =3D 0,
> > >       ADXL345_ODR_0P20HZ,
> > > @@ -154,6 +172,13 @@ struct adxl345_state {
> > >  };
> > >
> > >  static struct iio_event_spec adxl345_events[] =3D {
> > > +     {
> > > +             /* activity */
> > > +             .type =3D IIO_EV_TYPE_THRESH, =20
> >
> > Is this a threshold, or a magnitude? I'd expect an activity detector
> > to be magnitude as it doesn't care which way up the sensor is.
> > =20
>=20
> This is touching the main points still unclear to me. I tried to put
> this into the
> following questions. Could you please clarify?

There are some corners where it gets messy. When I have time
(not for a month or so) I'll try and write some proper docs for this.

>=20
> 1. Given a measurement "val", and a configured threshold "thr".
> A "rising" for IIO_EV_TYPE_THRESH means: val > thr
> where a "rising" for IIO_EV_TYPE_MAG means something like: val > |thr|
>=20
> Q: Do I understand this correctly now?

Yes that is the intended difference.

>=20
> Q: Is this documented somewhere (especially for reviewing further
> EV_TYPE fields)?

Only in the ABI documentation in
Documentation/ABI/testing/sysfs-bus-iio
This is definitely something we should look to improve with some
docs beyond simply what the ABI is.  That ABI is focused on
how the interrupt is triggered, not so much on what that means
wrt to freefall etc.


>=20
> Q: I wonder if I missed this for the Tap events. Going by this
> definition, then actually the
> tap events should be rather MAG events, too. Right?

The tap events have their own type (gesture) because they are way
more complex than a simple threshold whether on magnitude or
the signed value.  So those should be fine as type GESTURE.

>=20
>=20
> 2. I oriented myself mostly by reading other drivers, for instance the
> ADXL367, the ADXL372, or also the more recent ADXL380. I am aware that
> there might be differences among different
> (Analog) sensors. But all those sensors specify Inactivity (and Activity)=
 as a
> IIO_EV_TYPE_THRESH with directions IIO_MOD_X_OR_Y_OR_Z.
> Given the above, I implemented Activity and Inactivity events as
> IIO_EV_TYPE_THRESH,
> now I'm a bit confused.

Hmm. This is one reason I think we need more documentation as those
seem to be wrong.  Clearly the event is a threshold on a magnitude of
the acceleration, not the signed value as it applies in both directions.

>=20
> Q: Why is this different for the ADXL345?

Because we got it wrong for these others it seems unless they genuinely
have directional events - which typically means separate positive and
negative thresholds.  Right now those events are strictly speaking
only apply to positive accelerations.

>=20
> Q: If I implement Activity / Inactivity analogous to the e.g. a
> ADXL380, then shouldn't it be IIO_EV_TYPE_THRESH with
> IIO_MOD_X_OR_Y_OR_Z? Why not?
>=20

I think we got it wrong for that part.  Going forwards we should work
on getting it (more) correct.

>=20
> 3. For the ADXL345, a Freefall signal is on all axis lower than
> threshold (magnitude). Thus I push a IIO_MOD_X_AND_Y_AND_Z to a
> separate
> fake channel. Inactivity will be like Freefall independent of the axis.
> The ADXL345 Activity can be configured by axis, as also the event will
> respect the axis information.
>=20
> Q: Setting up the "fake channel" to particuarly push to
> IIO_MOD_X_AND_Y_AND_Z, I probably better should also evaluate
> IIO_MOD_X_AND_Y_AND_Z in write_event_config(), write_event_value(),
> etc. rather than evaluating IIO_MOD_-types as I'm currently
> doing?

Yes. That sounds correct for events on these 'fake' channels.
The enable and the thresholds should all be on these fake channels
assuming they don't have different thresholds on a per axis basis
(if they do things get tricky to represent).

>=20
> Q: Activity probably remains in the regular channels for the correspondin=
g axis?

Yes.  That is easier to handle as OR of channels is very similar
to separate interrupts etc.

>=20
>=20
> 4. I implemented functions like adxl345_write_event_config(),
> adxl345_write_event_value() or corresponding
> readers, as follows
> - THRESH/rising: Activity
> - THRESH/falling: Inactivity
> - MAG/falling: Freefall
>=20
> If I change Activity and Inactivity to be both of type MAG, I will end
> up with MAG/falling to indicate Freefall or equally Inactivity.
> Both on the IIO_MOD_X_AND_Y_AND_Z channel. I admit (ab)using the
> IIO_EV_TYPEs to solve my combinatorial issues for event configuration
> is probably not as supposed to be.

Ah..  This I'd missed.  I'm fairly sure we didn't hit this for (some) previ=
ous
inactivity sensors because they were always rate of change based, (AC)
rather than DC. DC is relatively unlikely to be used in practice because
we can't set the threshold as less than 1G because of gravity.  It is a
bit odd that the device supports both DC and AC on this detector.

I wonder why.... Might be to enable partial axis monitoring.  e.g.
If a device is flat on a table we only look for inactivity on the non
vertical axis when doing DC coupling. (as we have 1g always in the other
axis).

> Given you still ask me to do Inactivity and Freefall as MAG/falling
> with IIO_MOD_X_AND_Y_AND_Z. The difference between both IMHO,
> is that Activity and Inactivity for the ADXL345 indicate sensor state
> changes, where Freefall indicates the particular event. The
> sensor is either in "active" or "standby/inactive", where Freefall
> just triggers and then retriggers and retriggers...

Maybe. The datasheet is annoyingly vague on these but indeed there
is no event for no longer falling.=20

>=20
> Q: What is the method to distinguish several similar IIO events, e.g.
> to tag them somehow one as Freefall, the other one as Inactivity?

In general we should not be able to do that.  Long ago we made the decision
to have compact event codes so they don't allow for an index on a particular
combination of channel number and modifier.  This is mainly because
there is limited purpose.   If one event is triggered, then we have
to process anyway so we can just look at the value for 'how far' it was
triggered.  I.e. if we thought DC inactivity was triggered, we can just
check free fall as well. (It gets a little more fiddly because of _period
etc which is why they may actually make sense here).

The virtual (combination OR/AND) was added on top of that later and has
made the connection looser.

In theory we could use labels + index for the virtual channels to achieve
separate control attributes and be able to tell which was which but
that would be new ABI.  I'm not sure how much use this stuff is already
getting from userspace applications and hence whether this would be
a big problem to get supported.

That would give us something like

iio\:device0/in_accel0_x&y&z_label   freefall=20
iio\:device0/in_accel1_x&y&z_label   inactivity
iio\:device0/events/in_accel0_x&y&z_en etc
iio\:device0/events/in_accel1_x&y&z_en etc

I don't like it much because it then doesn't generalize to the case
of multiple sensors on each axis (there are multi range parts that do that).
That case is pretty rare though (I think we only have such sensor supported=
!)
However, it's currently the only option we have to fully represent this.

An alternative here might be to assess if anyone is really going to use
DC coupled inactivity detection (because of the 1g problem) and hence wheth=
er
we want to support that at all?

Yet another alternative might be to configure it purely based on the period
provided. If short use freefall, if long use inactivity. (I don't like this
one though as it doesn't really fit with usecase!)

Sorry for lack of clarity on this. These events are tricky and
it takes me a while to get the whole situation back into my head (and I mis=
sing
things like inactivity and freefall being very similar here!)

If you have time to take a look at what userspace is currently doing with
these events (iio_sensor_proxy etc) that might help us decide what works.

Jonathan

>=20
> Best,
> L
>=20
> > > +             .dir =3D IIO_EV_DIR_RISING,
> > > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE),
> > > +     },
> > >       {
> > >               /* single tap */
> > >               .type =3D IIO_EV_TYPE_GESTURE,
> > > @@ -265,6 +290,99 @@ static int adxl345_set_measure_en(struct adxl345=
_state *st, bool en)
> > >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> > >  }
> > > =20
> > Jonathan
> >
> > =20


