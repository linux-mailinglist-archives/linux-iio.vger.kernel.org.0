Return-Path: <linux-iio+bounces-19260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680EAAEC6D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8763BB34E
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892928E589;
	Wed,  7 May 2025 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIobswQq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638B288C15;
	Wed,  7 May 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647336; cv=none; b=VB5E4S3Qu6KB2nLU8nk+Tte56Ei3GbWmQOpK2sjPBpA5y8FdjLTlbeSNjXVuhA/oWJvrdFsSlv/+Z/zk3Go3uiDNDpUZRVHRjL1+6VMcdgQQqnPO/56YRJP7zTK6BfruNk7tl8/osSBEsG3JUZqc5SGt0OiLQdIHviFgyGugCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647336; c=relaxed/simple;
	bh=qwJNW8ft/5YdhUvEaohKqtjQ8nXoWMdrD6VX5+mSfII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Se5KbQZGG3qKIeRp7MfU7aCksZumKMhKX1iBe6lYF0x634M1C4Vs3meesi04L386QhhiWhcO+cx3B+aQQzr0WT5pTCzjk9XoPwyHYKAx8i6D8wZlXkAGF8chmKeIfVL//wjXUdh36iJe+yJe9IG7XKqpwamK3pTl/TG8BRolNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIobswQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CDCC4CEE2;
	Wed,  7 May 2025 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647334;
	bh=qwJNW8ft/5YdhUvEaohKqtjQ8nXoWMdrD6VX5+mSfII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZIobswQqmqY1M7kwu9S0+KerwVcj0U3ZcnwiSKFpdQecC3xjsqSR9GR3XP8tVgyLd
	 d/LHnN3PZaGebf454V5GsNkU2Ng8ZPS50FrL7NQ+IM1ue7G/1CWjaDNslDAAQpzLRU
	 bhvFRxQ75fFYc69FCi1ZsspLXA02jjYN24c/8dQSf0rnP0jML6UdG3yJM75pK3CLeu
	 KIG4euztOg749OFc46fex3cvgxRNMfr1dKxYp9HrLBKMD7l1eiVJW2IiIL5JtND4ya
	 DB6OynXT97FBCLXw14V33gWg1Pa7kgD4Fw7ho9hETBhajt+Xqaxd6Wks7cLhB2ZB61
	 ruEFjbhNkg83g==
Date: Wed, 7 May 2025 20:48:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 08/11] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250507204847.01807b28@jic23-huawei>
In-Reply-To: <CAFXKEHa2s53Rt9FkE+aUouvQDd7qs5gt9JNzpmDfEnvvK+5e7w@mail.gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-9-l.rubusch@gmail.com>
	<20250427134759.3cc3a2a4@jic23-huawei>
	<CAFXKEHZ3KQ_Z4QB==Bb_CTauV7Wowd0Lgxaick=6mfiLJU654Q@mail.gmail.com>
	<20250504112904.64c1b5ee@jic23-huawei>
	<CAFXKEHb8+76WiiTCQbRa9v6gAicT0wnua6vCn-NxCfgNiuud2g@mail.gmail.com>
	<20250505133743.686d957d@jic23-huawei>
	<CAFXKEHa2s53Rt9FkE+aUouvQDd7qs5gt9JNzpmDfEnvvK+5e7w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 00:37:43 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
> Still some questions and thoughts down below.
>=20
> On Mon, May 5, 2025 at 2:37=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sun, 4 May 2025 19:47:55 +0200
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > On Sun, May 4, 2025 at 12:29=E2=80=AFPM Jonathan Cameron <jic23@kerne=
l.org> wrote: =20
> > > >
> > > > On Thu, 1 May 2025 00:53:32 +0200
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > =20
> > > > > Hi Jonathan - Hi IIO list,
> > > > >
> > > > > Please, find some (many) questions inlined down below. Appologies=
 for
> > > > > the separate
> > > > > channels last time and not right away fixing them up as array. I =
did
> > > > > not want to make extra work.
> > > > >
> > > > > On Sun, Apr 27, 2025 at 2:48=E2=80=AFPM Jonathan Cameron <jic23@k=
ernel.org> wrote: =20
> > > > > >
> > > > > > On Mon, 21 Apr 2025 22:06:38 +0000
> > > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > > > =20
> > > > > > > Make the sensor detect and issue interrupts at activity. Acti=
vity
> > > > > > > events are configured by a threshold stored in regmap cache. =
Initialize
> > > > > > > the activity threshold register to a reasonable default value=
 in probe.
> > > > > > > The value is taken from the older ADXL345 input driver, to pr=
ovide a
> > > > > > > similar behavior. Reset the activity/inactivity direction ena=
bling
> > > > > > > register in probe. Reset and initialization shall bring the s=
ensor in a
> > > > > > > defined initial state to prevent dangling settings when warm =
restarting
> > > > > > > the sensor.
> > > > > > >
> > > > > > > Activity, ODR configuration together with the range setting p=
repare the
> > > > > > > activity/inactivity hystersesis setup, implemented in a follo=
w up patch.
> > > > > > >
> > > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/iio/accel/adxl345_core.c | 217 +++++++++++++++++++++=
+++++++++-
> > > > > > >  1 file changed, 214 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/a=
ccel/adxl345_core.c
> > > > > > > index 80b5b8402ced..680981609d83 100644
> > > > > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > > > > @@ -36,11 +36,16 @@
> > > > > > >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > > > > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > > > > > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > > > > > +#define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > > > > >
> > > > > > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > > > > >  #define ADXL345_TAP_Y_EN             BIT(1)
> > > > > > >  #define ADXL345_TAP_X_EN             BIT(2)
> > > > > > >
> > > > > > > +#define ADXL345_ACT_Z_EN             BIT(4)
> > > > > > > +#define ADXL345_ACT_Y_EN             BIT(5)
> > > > > > > +#define ADXL345_ACT_X_EN             BIT(6)
> > > > > > > +
> > > > > > >  /* single/double tap */
> > > > > > >  enum adxl345_tap_type {
> > > > > > >       ADXL345_SINGLE_TAP,
> > > > > > > @@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_time=
_reg[] =3D {
> > > > > > >       [ADXL345_TAP_TIME_DUR] =3D ADXL345_REG_DUR,
> > > > > > >  };
> > > > > > >
> > > > > > > +/* activity/inactivity */
> > > > > > > +enum adxl345_activity_type {
> > > > > > > +     ADXL345_ACTIVITY,
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const unsigned int adxl345_act_int_reg[] =3D {
> > > > > > > +     [ADXL345_ACTIVITY] =3D ADXL345_INT_ACTIVITY,
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const unsigned int adxl345_act_thresh_reg[] =3D {
> > > > > > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_THRESH_ACT,
> > > > > > > +};
> > > > > > > +
> > > > > > >  enum adxl345_odr {
> > > > > > >       ADXL345_ODR_0P10HZ =3D 0,
> > > > > > >       ADXL345_ODR_0P20HZ,
> > > > > > > @@ -154,6 +172,13 @@ struct adxl345_state {
> > > > > > >  };
> > > > > > >
> > > > > > >  static struct iio_event_spec adxl345_events[] =3D {
> > > > > > > +     {
> > > > > > > +             /* activity */
> > > > > > > +             .type =3D IIO_EV_TYPE_THRESH, =20
> > > > > >
> > > > > > Is this a threshold, or a magnitude? I'd expect an activity det=
ector
> > > > > > to be magnitude as it doesn't care which way up the sensor is.
> > > > > > =20
> > > > >
> > > > > This is touching the main points still unclear to me. I tried to =
put
> > > > > this into the
> > > > > following questions. Could you please clarify? =20
> > > >
> > > > There are some corners where it gets messy. When I have time
> > > > (not for a month or so) I'll try and write some proper docs for thi=
s.
> > > > =20
> > > > >
> > > > > 1. Given a measurement "val", and a configured threshold "thr".
> > > > > A "rising" for IIO_EV_TYPE_THRESH means: val > thr
> > > > > where a "rising" for IIO_EV_TYPE_MAG means something like: val > =
|thr|
> > > > >
> > > > > Q: Do I understand this correctly now? =20
> > > >
> > > > Yes that is the intended difference.
> > > > =20
> > > > >
> > > > > Q: Is this documented somewhere (especially for reviewing further
> > > > > EV_TYPE fields)? =20
> > > >
> > > > Only in the ABI documentation in
> > > > Documentation/ABI/testing/sysfs-bus-iio
> > > > This is definitely something we should look to improve with some
> > > > docs beyond simply what the ABI is.  That ABI is focused on
> > > > how the interrupt is triggered, not so much on what that means
> > > > wrt to freefall etc.
> > > >
> > > > =20
> > > > >
> > > > > Q: I wonder if I missed this for the Tap events. Going by this
> > > > > definition, then actually the
> > > > > tap events should be rather MAG events, too. Right? =20
> > > >
> > > > The tap events have their own type (gesture) because they are way
> > > > more complex than a simple threshold whether on magnitude or
> > > > the signed value.  So those should be fine as type GESTURE.
> > > > =20
> > >
> > > I was aware of that. Actually, the case of GESTURE is a bit
> > > particular. On the one side, I
> > > understand having a distinction between THRESH events and MAG events.
> > > Hence, a classification of the type of event in terms of a measurement
> > > value triggering event condition.
> > > This concept seems actually to be clear.
> > >
> > > GESTURE to me then seems a bit like a "wildcard type covering all kind
> > > of tap events". I mean,
> > > saying tap detection, single tap, double tap, tripple tap, and so on
> > > tap go into category GESTURE - naively could also mean, then do a
> > > freefall  type as well (?). =20
> >
> > Nope. Because freefall has a clear definition that aligns with
> > the events that we have for other types of sensor.
> >
> > You are right that gesture is a wild card. I resisted it for a long
> > time but there is just no sane way to handle tap events alongside
> > the sort of things we get on any other sensor type.  Having looked
> > at a bunch of them they can be anything from straight magnitude thresho=
lds
> > with time windows to things based on a mixture of jerk (rate of change
> > of acceleration) and other stuff.  The only thing that kind of close
> > to this is pedometer step events, but we handle those as a counting
> > channel rather than an event as time of each is less interesting than
> > how many have happened.  However as noted below we do have the CHANGE
> > type of event specifically to account for those (which is ugly).
> > =20
> > >
> > > [this is rather meant as a bit of a provocative rhetoric question than
> > > a proposal]
> > > =20
> > > > >
> > > > >
> > > > > 2. I oriented myself mostly by reading other drivers, for instanc=
e the
> > > > > ADXL367, the ADXL372, or also the more recent ADXL380. I am aware=
 that
> > > > > there might be differences among different
> > > > > (Analog) sensors. But all those sensors specify Inactivity (and A=
ctivity) as a
> > > > > IIO_EV_TYPE_THRESH with directions IIO_MOD_X_OR_Y_OR_Z.
> > > > > Given the above, I implemented Activity and Inactivity events as
> > > > > IIO_EV_TYPE_THRESH,
> > > > > now I'm a bit confused. =20
> > > >
> > > > Hmm. This is one reason I think we need more documentation as those
> > > > seem to be wrong.  Clearly the event is a threshold on a magnitude =
of
> > > > the acceleration, not the signed value as it applies in both direct=
ions.
> > > > =20
> > > > >
> > > > > Q: Why is this different for the ADXL345? =20
> > > >
> > > > Because we got it wrong for these others it seems unless they genui=
nely
> > > > have directional events - which typically means separate positive a=
nd
> > > > negative thresholds.  Right now those events are strictly speaking
> > > > only apply to positive accelerations.
> > > > =20
> > > > >
> > > > > Q: If I implement Activity / Inactivity analogous to the e.g. a
> > > > > ADXL380, then shouldn't it be IIO_EV_TYPE_THRESH with
> > > > > IIO_MOD_X_OR_Y_OR_Z? Why not?
> > > > > =20
> > > >
> > > > I think we got it wrong for that part.  Going forwards we should wo=
rk
> > > > on getting it (more) correct.
> > > > =20
> > >
> > > I understand the point better now.
> > > =20
> > > > >
> > > > > 3. For the ADXL345, a Freefall signal is on all axis lower than
> > > > > threshold (magnitude). Thus I push a IIO_MOD_X_AND_Y_AND_Z to a
> > > > > separate
> > > > > fake channel. Inactivity will be like Freefall independent of the=
 axis.
> > > > > The ADXL345 Activity can be configured by axis, as also the event=
 will
> > > > > respect the axis information.
> > > > >
> > > > > Q: Setting up the "fake channel" to particuarly push to
> > > > > IIO_MOD_X_AND_Y_AND_Z, I probably better should also evaluate
> > > > > IIO_MOD_X_AND_Y_AND_Z in write_event_config(), write_event_value(=
),
> > > > > etc. rather than evaluating IIO_MOD_-types as I'm currently
> > > > > doing? =20
> > > >
> > > > Yes. That sounds correct for events on these 'fake' channels.
> > > > The enable and the thresholds should all be on these fake channels
> > > > assuming they don't have different thresholds on a per axis basis
> > > > (if they do things get tricky to represent).
> > > > =20
> > > > >
> > > > > Q: Activity probably remains in the regular channels for the corr=
esponding axis? =20
> > > >
> > > > Yes.  That is easier to handle as OR of channels is very similar
> > > > to separate interrupts etc.
> > > > =20
> > >
> > > I think I should definitely evaluate the IIO_MOD_X_AND_Y_AND_Z here,
> > > to take advantage
> > > of the fake channel.
> > > =20
> > > > >
> > > > >
> > > > > 4. I implemented functions like adxl345_write_event_config(),
> > > > > adxl345_write_event_value() or corresponding
> > > > > readers, as follows
> > > > > - THRESH/rising: Activity
> > > > > - THRESH/falling: Inactivity
> > > > > - MAG/falling: Freefall
> > > > >
> > > > > If I change Activity and Inactivity to be both of type MAG, I wil=
l end
> > > > > up with MAG/falling to indicate Freefall or equally Inactivity.
> > > > > Both on the IIO_MOD_X_AND_Y_AND_Z channel. I admit (ab)using the
> > > > > IIO_EV_TYPEs to solve my combinatorial issues for event configura=
tion
> > > > > is probably not as supposed to be. =20
> > > >
> > > > Ah..  This I'd missed.  I'm fairly sure we didn't hit this for (som=
e) previous
> > > > inactivity sensors because they were always rate of change based, (=
AC)
> > > > rather than DC. DC is relatively unlikely to be used in practice be=
cause
> > > > we can't set the threshold as less than 1G because of gravity.  It =
is a
> > > > bit odd that the device supports both DC and AC on this detector.
> > > >
> > > > I wonder why.... Might be to enable partial axis monitoring.  e.g.
> > > > If a device is flat on a table we only look for inactivity on the n=
on
> > > > vertical axis when doing DC coupling. (as we have 1g always in the =
other
> > > > axis).
> > > > =20
> > >
> > > Thank you for clarifying your position in the other mail focussed on
> > > the AC- / DC-coupling
> > > topic. It helped me in better understanding what you actually expect
> > > here. Although I'll
> > > probably need to re-read it some times, before implementing something=
. =20
> >
> > I definitely need to find time to write some docs on this.  Mad few
> > weeks coming up but maybe I'll get some time on a plane or at an airport
> > to try a first draft.
> > =20
> > > =20
> > > > > Given you still ask me to do Inactivity and Freefall as MAG/falli=
ng
> > > > > with IIO_MOD_X_AND_Y_AND_Z. The difference between both IMHO,
> > > > > is that Activity and Inactivity for the ADXL345 indicate sensor s=
tate
> > > > > changes, where Freefall indicates the particular event. The
> > > > > sensor is either in "active" or "standby/inactive", where Freefall
> > > > > just triggers and then retriggers and retriggers... =20
> > > >
> > > > Maybe. The datasheet is annoyingly vague on these but indeed there
> > > > is no event for no longer falling.
> > > > =20
> > > > >
> > > > > Q: What is the method to distinguish several similar IIO events, =
e.g.
> > > > > to tag them somehow one as Freefall, the other one as Inactivity?=
 =20
> > > >
> > > > In general we should not be able to do that.  Long ago we made the =
decision
> > > > to have compact event codes so they don't allow for an index on a p=
articular
> > > > combination of channel number and modifier.  This is mainly because
> > > > there is limited purpose.   If one event is triggered, then we have
> > > > to process anyway so we can just look at the value for 'how far' it=
 was
> > > > triggered.  I.e. if we thought DC inactivity was triggered, we can =
just
> > > > check free fall as well. (It gets a little more fiddly because of _=
period
> > > > etc which is why they may actually make sense here).
> > > >
> > > > The virtual (combination OR/AND) was added on top of that later and=
 has
> > > > made the connection looser.
> > > >
> > > > In theory we could use labels + index for the virtual channels to a=
chieve
> > > > separate control attributes and be able to tell which was which but
> > > > that would be new ABI.  I'm not sure how much use this stuff is alr=
eady
> > > > getting from userspace applications and hence whether this would be
> > > > a big problem to get supported.
> > > >
> > > > That would give us something like
> > > >
> > > > iio\:device0/in_accel0_x&y&z_label   freefall
> > > > iio\:device0/in_accel1_x&y&z_label   inactivity
> > > > iio\:device0/events/in_accel0_x&y&z_en etc
> > > > iio\:device0/events/in_accel1_x&y&z_en etc
> > > >
> > > > I don't like it much because it then doesn't generalize to the case
> > > > of multiple sensors on each axis (there are multi range parts that =
do that).
> > > > That case is pretty rare though (I think we only have such sensor s=
upported!)
> > > > However, it's currently the only option we have to fully represent =
this.
> > > > =20
>=20
> Kind of the naive approach to allow for extending everything, but it prob=
ably
> does not fit together with the existing sensor ABI.

Agreed.

>=20
> > > > An alternative here might be to assess if anyone is really going to=
 use
> > > > DC coupled inactivity detection (because of the 1g problem) and hen=
ce whether
> > > > we want to support that at all?
> > > > =20
>=20
> I'd rather drop free fall then. Activity and inactivity, linked to
> gether work well for the power saving
> thing. I guess that's probably also more of general use. Not sure how
> usefull free fall is here.
>=20
> > > > Yet another alternative might be to configure it purely based on th=
e period
> > > > provided. If short use freefall, if long use inactivity. (I don't l=
ike this
> > > > one though as it doesn't really fit with usecase!)
> > > > =20
>=20
> That's either free fall or the other? Ideally, I'd like to represent
> what's possible with this sensor.
That's the only option if using the period to control it.   You can't have
one event with two periods.

> Since I'm not really familiar with how those sensors are used, for me
> all features are equally
> important. I mean, the sensor offers enabling act/inact and enabling
> free fall if one likes.

Sure.

>=20
> > > > Sorry for lack of clarity on this. These events are tricky and
> > > > it takes me a while to get the whole situation back into my head (a=
nd I missing
> > > > things like inactivity and freefall being very similar here!)
> > > > =20
>=20
> Ideally I'd like to implement support for all features of the sensor.
> I can understand if some corner case features are too individual to
> support them. So, at least the main features.
>=20
> From what I see in the code, configuring threshold and period, there
> might be differences and it can be easy to distinguish in
> read/write_event_value() like functions. Where
> read/write_event_config() will be more difficult.
> So, for the event, when I receive it I have knowledge of the exact
> event type, free fall or inactivity. I'm losing this information since
> it can currently not be conveyed over the channel. Might be that the
> ADXL345 is a very particular case. Might also be, that this shows a
> more general shortcoming which should be addressed.

I'm sure there will be other sensors that have similar events.
How common is hard to say though.

>=20
> Equally I could say, there is just a MAG event, so turning on
> inactivity or free fall would result in the same event. The tricky
> case then is if someone wants inactivity AND free fall. In such case
> it would be a inact_or_free_fall event. Not sure about. Probably
> rather not.

It's just a threshold on falling magnitude of signal. What that means depen=
ds
on the sensor type and other settings (here the period).  Event codes
are the same, but without the settings those are pretty meaningless.

>=20
> Q: Still, what about the direction - I see, where activity is using
> IIO_EV_DIR_RISING, inactivity uses _DIR_FALLING. Free fall now uses
> _DIR_FALLING. I'm a bit unsure if this is just a choice. Could I use
> _DIR_EITHER here? Or why not? I mean, actually it's not possible to
> detect fall into one direction, it's simply "in a fall". We cannot
> tell which axis we cannot tell which direction.

Not about direction in sense of x/y/z, but direction of the signal.

They are definitely triggered when the |X| > thresh transitions
to |X| < thresh.  So direction is falling as value |X| is getting smaller.

The choice reflects the physical thing being measured.

>=20
> > > > If you have time to take a look at what userspace is currently doin=
g with
> > > > these events (iio_sensor_proxy etc) that might help us decide what =
works.
> > > > =20
>=20
> This might be generally a good option. Honestly, I'd like to mess
> still with some other sensors,
> first.

Make sense.

J

>=20
> Best,
> L
>=20
> > >
> > > Just as a quick response here (or perhaps just to rule it out)..
> > >
> > > Actually, I can spot as MAG-similar event types:
> > > - IIO_EV_TYPE_MAG
> > > - IIO_EV_TYPE_MAG_ADAPTIVE
> > > - IIO_EV_TYPE_CHANGE
> > > - IIO_EV_TYPE_MAG_REFERENCED
> > >
> > > For instance the last one is only used in a single sensor. Is there a
> > > chance to put, say, freefall into one of the other "MAG-like" sensor
> > > types. Alternatively, what about putting Activity/Inactivity under
> > > say, "MAG_REFERENCED"? This might seem to be a stupid question, since
> > > I can imagine you have a clear definition of those in mind. But if
> > > this was possible. It would solve this problem easily. =20
> >
> > The ABI docs do provide some definitions of these.
> >
> > Free fall is definitely straight forward TYPE MAG.  It precisely aligns
> > with that definition as a threshold on the per axis magnitudes.
> >
> > MAG_ADAPTIVE is meant for a case where the event is on the magnitude
> > relative to a slow moving adaptive baseline (usually a low pass filtered
> > version of the signal but can include corrective jumps - IIRC these turn
> > up for magnetic sensors).  This differs from a rate of change threshold
> > because it's not simply a difference between current and earlier signals
> > but rather current and some heavily filtered earlier signal.
> > These matter in cases where we have a slow changing baseline such as
> > coming into proximity with metal in the environment when using a magnet=
ometer
> > for orientation detection.
> >
> > MAG_REFERENCED is a weird one.  This was done for a nice IMU that had
> > the ability to estimate orientation and so remove the acceleration due
> > to gravity and then apply thresholds to the magnitude of the remaining
> > accelerations.  The AC filtering on your part is is a 'cheap' way
> > to achieve roughly the equivalent of that for the activity detection at=
 least
> > where we are removing the 'nothing happening value'.
> > (it is less clear for the inactivity case though that will still include
> >  g, so maybe it is still somewhat valid).
> >
> > CHANGE is IIRC only for counting channels (so far anyway).
> >
> > So none of the more esoteric forms of them fit for this DC coupled
> > inactivity monitor or freefall. Both of them are the same type of event
> > just differing in filters applied.
> > =20
> > >
> > > If not, then I'll need to think of it and come up with a more
> > > elaborate approach. The label + index approach seems to be a bit
> > > complex. Going somehow by the time constraints  in the event.. I need
> > > to play with that in the code to build up an oppinion, I guess. =20
> >
> > The time constraints thing falls down on the basis that it would
> > be logical to have freefall enabled (for parking any moving parts - tho=
se
> > used to exist mainly to stop hard disks but maybe there are other use c=
ases?)
> > and inactivity for power saving with a much longer timescale.
> >
> > Freefall used to be fun because the aim was to get moving parts into
> > a safe state before the device hit the ground.  So that meant if you dr=
opped
> > a device with a harddisk from higher up, it sometimes had a better chan=
ce
> > of surviving.  I'm not sure if anyone cares any more! Will be interesti=
ng
> > to see if that feature goes away on new devices.
> >
> > Jonathan
> > =20
> > >
> > > Best,
> > > L
> > > =20
> > > > Jonathan
> > > > =20
> > > > >
> > > > > Best,
> > > > > L
> > > > > =20
> > > > > > > +             .dir =3D IIO_EV_DIR_RISING,
> > > > > > > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > > > > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE),
> > > > > > > +     },
> > > > > > >       {
> > > > > > >               /* single tap */
> > > > > > >               .type =3D IIO_EV_TYPE_GESTURE,
> > > > > > > @@ -265,6 +290,99 @@ static int adxl345_set_measure_en(struct=
 adxl345_state *st, bool en)
> > > > > > >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, =
val);
> > > > > > >  }
> > > > > > > =20
> > > > > > Jonathan
> > > > > >
> > > > > > =20
> > > > =20
> > =20
>=20


