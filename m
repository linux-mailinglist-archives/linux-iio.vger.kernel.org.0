Return-Path: <linux-iio+bounces-19523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E8AB7EB9
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FB81B668D2
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 07:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B71DC998;
	Thu, 15 May 2025 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqDvG3NH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288294B1E44;
	Thu, 15 May 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293729; cv=none; b=V+UNyLlUZz5zERa4ZBOVcRW6eDH4ChWJyhQ86/m5fpvgoI5XKlxGsmio/2IgBMmGaw6DXqXUREYLNODa1qviP2M/P3LBia0n6RthkNWXUZ9pZMOyOmkbGAm2Sq7y0xEdd1w+YpTY8TpyuQAsLwzpKeJePmTE1N+q6G9NQxi/Fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293729; c=relaxed/simple;
	bh=HK6YROBPMh3xX66lUY8Hx6AIs/NdC8Ai++Co32lkwmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qicdt7Wn4/4Cx3hHD9nQhjgs2FngQAOfKgxE1Yfq48cVEs+eY1BASzFGr2z2Z/66KZypsf3AFi7zEijWZp3FcXfEviZdxRqPmjk2nw4Frt5t67MeY4ktbeapICocL+1b0BikSeQPMJeD0D2YAyhc70kbDbnUZhK5DKmpS+6DcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqDvG3NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C8FC4CEE7;
	Thu, 15 May 2025 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747293728;
	bh=HK6YROBPMh3xX66lUY8Hx6AIs/NdC8Ai++Co32lkwmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WqDvG3NHlpg1zdXE9lF2OTIRAJjA+zgQ94I7ejvpbrBhKQBdQ6ujEwUUM8bsOv/P0
	 fbNP1vZeUkj+dSWBB/BCVWc+g/h0itOpnyVYJ5JvX5rEghJzDsMsatKSt6PbB9+hmQ
	 D3NJ9B28QCo3owjlVqFslsKNkt52/J8J24tp9VThPtNPd4Ik83/CHNMv1HTYcLEAUC
	 BbpeDtcDT3DlqsYMNtPZbdpQh8nXMEOWTuPR3IJCVIN86//lmLuDMH9Vfkp6lQ/uZ+
	 VbAZZ1vzeatzNjCx19HXhg+/vRjK3htFsz33bRyDHBv4PHhSCh2cM2xaNGpMy/rM3e
	 Gt/CXc/nhic0w==
Date: Thu, 15 May 2025 08:22:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 08/11] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250515082204.3a996a36@jic23-huawei>
In-Reply-To: <CAFXKEHZ+AzRdrnN2_cuNdTgby3JsCZA5V7oOv5OBG3mcW1KWeg@mail.gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-9-l.rubusch@gmail.com>
	<20250427134759.3cc3a2a4@jic23-huawei>
	<CAFXKEHZ3KQ_Z4QB==Bb_CTauV7Wowd0Lgxaick=6mfiLJU654Q@mail.gmail.com>
	<20250504112904.64c1b5ee@jic23-huawei>
	<CAFXKEHb8+76WiiTCQbRa9v6gAicT0wnua6vCn-NxCfgNiuud2g@mail.gmail.com>
	<20250505133743.686d957d@jic23-huawei>
	<CAFXKEHa2s53Rt9FkE+aUouvQDd7qs5gt9JNzpmDfEnvvK+5e7w@mail.gmail.com>
	<20250507204847.01807b28@jic23-huawei>
	<CAFXKEHZ+AzRdrnN2_cuNdTgby3JsCZA5V7oOv5OBG3mcW1KWeg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 23:40:22 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Wed, May 7, 2025 at 9:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Wed, 7 May 2025 00:37:43 +0200
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Hi Jonathan,
> > > Still some questions and thoughts down below.
> > >
> > > On Mon, May 5, 2025 at 2:37=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote: =20
> > > >
> > > > On Sun, 4 May 2025 19:47:55 +0200
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > =20
> > > > > On Sun, May 4, 2025 at 12:29=E2=80=AFPM Jonathan Cameron <jic23@k=
ernel.org> wrote: =20
> > > > > >
> > > > > > On Thu, 1 May 2025 00:53:32 +0200
> > > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > > > =20
> > > > > > > Hi Jonathan - Hi IIO list,
> > > > > > >
> > > > > > > Please, find some (many) questions inlined down below. Appolo=
gies for
> > > > > > > the separate
> > > > > > > channels last time and not right away fixing them up as array=
. I did
> > > > > > > not want to make extra work.
> > > > > > >
> > > > > > > On Sun, Apr 27, 2025 at 2:48=E2=80=AFPM Jonathan Cameron <jic=
23@kernel.org> wrote: =20
> > > > > > > >
> > > > > > > > On Mon, 21 Apr 2025 22:06:38 +0000
> > > > > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > > > > > =20
> > > > > > > > > Make the sensor detect and issue interrupts at activity. =
Activity
> > > > > > > > > events are configured by a threshold stored in regmap cac=
he. Initialize
> > > > > > > > > the activity threshold register to a reasonable default v=
alue in probe.
> > > > > > > > > The value is taken from the older ADXL345 input driver, t=
o provide a
> > > > > > > > > similar behavior. Reset the activity/inactivity direction=
 enabling
> > > > > > > > > register in probe. Reset and initialization shall bring t=
he sensor in a
> > > > > > > > > defined initial state to prevent dangling settings when w=
arm restarting
> > > > > > > > > the sensor.
> > > > > > > > >
> > > > > > > > > Activity, ODR configuration together with the range setti=
ng prepare the
> > > > > > > > > activity/inactivity hystersesis setup, implemented in a f=
ollow up patch.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/iio/accel/adxl345_core.c | 217 +++++++++++++++++=
+++++++++++++-
> > > > > > > > >  1 file changed, 214 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/i=
io/accel/adxl345_core.c
> > > > > > > > > index 80b5b8402ced..680981609d83 100644
> > > > > > > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > > > > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > > > > > > @@ -36,11 +36,16 @@
> > > > > > > > >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > > > > > > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > > > > > > > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > > > > > > > +#define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > > > > > > >
> > > > > > > > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > > > > > > >  #define ADXL345_TAP_Y_EN             BIT(1)
> > > > > > > > >  #define ADXL345_TAP_X_EN             BIT(2)
> > > > > > > > >
> > > > > > > > > +#define ADXL345_ACT_Z_EN             BIT(4)
> > > > > > > > > +#define ADXL345_ACT_Y_EN             BIT(5)
> > > > > > > > > +#define ADXL345_ACT_X_EN             BIT(6)
> > > > > > > > > +
> > > > > > > > >  /* single/double tap */
> > > > > > > > >  enum adxl345_tap_type {
> > > > > > > > >       ADXL345_SINGLE_TAP,
> > > > > > > > > @@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_=
time_reg[] =3D {
> > > > > > > > >       [ADXL345_TAP_TIME_DUR] =3D ADXL345_REG_DUR,
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > +/* activity/inactivity */
> > > > > > > > > +enum adxl345_activity_type {
> > > > > > > > > +     ADXL345_ACTIVITY,
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +static const unsigned int adxl345_act_int_reg[] =3D {
> > > > > > > > > +     [ADXL345_ACTIVITY] =3D ADXL345_INT_ACTIVITY,
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +static const unsigned int adxl345_act_thresh_reg[] =3D {
> > > > > > > > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_THRESH_ACT,
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > >  enum adxl345_odr {
> > > > > > > > >       ADXL345_ODR_0P10HZ =3D 0,
> > > > > > > > >       ADXL345_ODR_0P20HZ,
> > > > > > > > > @@ -154,6 +172,13 @@ struct adxl345_state {
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  static struct iio_event_spec adxl345_events[] =3D {
> > > > > > > > > +     {
> > > > > > > > > +             /* activity */
> > > > > > > > > +             .type =3D IIO_EV_TYPE_THRESH, =20
> > > > > > > >
> > > > > > > > Is this a threshold, or a magnitude? I'd expect an activity=
 detector
> > > > > > > > to be magnitude as it doesn't care which way up the sensor =
is.
> > > > > > > > =20
> > > > > > >
> > > > > > > This is touching the main points still unclear to me. I tried=
 to put
> > > > > > > this into the
> > > > > > > following questions. Could you please clarify? =20
> > > > > >
> > > > > > There are some corners where it gets messy. When I have time
> > > > > > (not for a month or so) I'll try and write some proper docs for=
 this.
> > > > > > =20
> > > > > > >
> > > > > > > 1. Given a measurement "val", and a configured threshold "thr=
".
> > > > > > > A "rising" for IIO_EV_TYPE_THRESH means: val > thr
> > > > > > > where a "rising" for IIO_EV_TYPE_MAG means something like: va=
l > |thr|
> > > > > > >
> > > > > > > Q: Do I understand this correctly now? =20
> > > > > >
> > > > > > Yes that is the intended difference.
> > > > > > =20
> > > > > > >
> > > > > > > Q: Is this documented somewhere (especially for reviewing fur=
ther
> > > > > > > EV_TYPE fields)? =20
> > > > > >
> > > > > > Only in the ABI documentation in
> > > > > > Documentation/ABI/testing/sysfs-bus-iio
> > > > > > This is definitely something we should look to improve with some
> > > > > > docs beyond simply what the ABI is.  That ABI is focused on
> > > > > > how the interrupt is triggered, not so much on what that means
> > > > > > wrt to freefall etc.
> > > > > >
> > > > > > =20
> > > > > > >
> > > > > > > Q: I wonder if I missed this for the Tap events. Going by this
> > > > > > > definition, then actually the
> > > > > > > tap events should be rather MAG events, too. Right? =20
> > > > > >
> > > > > > The tap events have their own type (gesture) because they are w=
ay
> > > > > > more complex than a simple threshold whether on magnitude or
> > > > > > the signed value.  So those should be fine as type GESTURE.
> > > > > > =20
> > > > >
> > > > > I was aware of that. Actually, the case of GESTURE is a bit
> > > > > particular. On the one side, I
> > > > > understand having a distinction between THRESH events and MAG eve=
nts.
> > > > > Hence, a classification of the type of event in terms of a measur=
ement
> > > > > value triggering event condition.
> > > > > This concept seems actually to be clear.
> > > > >
> > > > > GESTURE to me then seems a bit like a "wildcard type covering all=
 kind
> > > > > of tap events". I mean,
> > > > > saying tap detection, single tap, double tap, tripple tap, and so=
 on
> > > > > tap go into category GESTURE - naively could also mean, then do a
> > > > > freefall  type as well (?). =20
> > > >
> > > > Nope. Because freefall has a clear definition that aligns with
> > > > the events that we have for other types of sensor.
> > > >
> > > > You are right that gesture is a wild card. I resisted it for a long
> > > > time but there is just no sane way to handle tap events alongside
> > > > the sort of things we get on any other sensor type.  Having looked
> > > > at a bunch of them they can be anything from straight magnitude thr=
esholds
> > > > with time windows to things based on a mixture of jerk (rate of cha=
nge
> > > > of acceleration) and other stuff.  The only thing that kind of close
> > > > to this is pedometer step events, but we handle those as a counting
> > > > channel rather than an event as time of each is less interesting th=
an
> > > > how many have happened.  However as noted below we do have the CHAN=
GE
> > > > type of event specifically to account for those (which is ugly).
> > > > =20
> > > > >
> > > > > [this is rather meant as a bit of a provocative rhetoric question=
 than
> > > > > a proposal]
> > > > > =20
> > > > > > >
> > > > > > >
> > > > > > > 2. I oriented myself mostly by reading other drivers, for ins=
tance the
> > > > > > > ADXL367, the ADXL372, or also the more recent ADXL380. I am a=
ware that
> > > > > > > there might be differences among different
> > > > > > > (Analog) sensors. But all those sensors specify Inactivity (a=
nd Activity) as a
> > > > > > > IIO_EV_TYPE_THRESH with directions IIO_MOD_X_OR_Y_OR_Z.
> > > > > > > Given the above, I implemented Activity and Inactivity events=
 as
> > > > > > > IIO_EV_TYPE_THRESH,
> > > > > > > now I'm a bit confused. =20
> > > > > >
> > > > > > Hmm. This is one reason I think we need more documentation as t=
hose
> > > > > > seem to be wrong.  Clearly the event is a threshold on a magnit=
ude of
> > > > > > the acceleration, not the signed value as it applies in both di=
rections.
> > > > > > =20
> > > > > > >
> > > > > > > Q: Why is this different for the ADXL345? =20
> > > > > >
> > > > > > Because we got it wrong for these others it seems unless they g=
enuinely
> > > > > > have directional events - which typically means separate positi=
ve and
> > > > > > negative thresholds.  Right now those events are strictly speak=
ing
> > > > > > only apply to positive accelerations.
> > > > > > =20
> > > > > > >
> > > > > > > Q: If I implement Activity / Inactivity analogous to the e.g.=
 a
> > > > > > > ADXL380, then shouldn't it be IIO_EV_TYPE_THRESH with
> > > > > > > IIO_MOD_X_OR_Y_OR_Z? Why not?
> > > > > > > =20
> > > > > >
> > > > > > I think we got it wrong for that part.  Going forwards we shoul=
d work
> > > > > > on getting it (more) correct.
> > > > > > =20
> > > > >
> > > > > I understand the point better now.
> > > > > =20
> > > > > > >
> > > > > > > 3. For the ADXL345, a Freefall signal is on all axis lower th=
an
> > > > > > > threshold (magnitude). Thus I push a IIO_MOD_X_AND_Y_AND_Z to=
 a
> > > > > > > separate
> > > > > > > fake channel. Inactivity will be like Freefall independent of=
 the axis.
> > > > > > > The ADXL345 Activity can be configured by axis, as also the e=
vent will
> > > > > > > respect the axis information.
> > > > > > >
> > > > > > > Q: Setting up the "fake channel" to particuarly push to
> > > > > > > IIO_MOD_X_AND_Y_AND_Z, I probably better should also evaluate
> > > > > > > IIO_MOD_X_AND_Y_AND_Z in write_event_config(), write_event_va=
lue(),
> > > > > > > etc. rather than evaluating IIO_MOD_-types as I'm currently
> > > > > > > doing? =20
> > > > > >
> > > > > > Yes. That sounds correct for events on these 'fake' channels.
> > > > > > The enable and the thresholds should all be on these fake chann=
els
> > > > > > assuming they don't have different thresholds on a per axis bas=
is
> > > > > > (if they do things get tricky to represent).
> > > > > > =20
> > > > > > >
> > > > > > > Q: Activity probably remains in the regular channels for the =
corresponding axis? =20
> > > > > >
> > > > > > Yes.  That is easier to handle as OR of channels is very similar
> > > > > > to separate interrupts etc.
> > > > > > =20
> > > > >
> > > > > I think I should definitely evaluate the IIO_MOD_X_AND_Y_AND_Z he=
re,
> > > > > to take advantage
> > > > > of the fake channel.
> > > > > =20
> > > > > > >
> > > > > > >
> > > > > > > 4. I implemented functions like adxl345_write_event_config(),
> > > > > > > adxl345_write_event_value() or corresponding
> > > > > > > readers, as follows
> > > > > > > - THRESH/rising: Activity
> > > > > > > - THRESH/falling: Inactivity
> > > > > > > - MAG/falling: Freefall
> > > > > > >
> > > > > > > If I change Activity and Inactivity to be both of type MAG, I=
 will end
> > > > > > > up with MAG/falling to indicate Freefall or equally Inactivit=
y.
> > > > > > > Both on the IIO_MOD_X_AND_Y_AND_Z channel. I admit (ab)using =
the
> > > > > > > IIO_EV_TYPEs to solve my combinatorial issues for event confi=
guration
> > > > > > > is probably not as supposed to be. =20
> > > > > >
> > > > > > Ah..  This I'd missed.  I'm fairly sure we didn't hit this for =
(some) previous
> > > > > > inactivity sensors because they were always rate of change base=
d, (AC)
> > > > > > rather than DC. DC is relatively unlikely to be used in practic=
e because
> > > > > > we can't set the threshold as less than 1G because of gravity. =
 It is a
> > > > > > bit odd that the device supports both DC and AC on this detecto=
r.
> > > > > >
> > > > > > I wonder why.... Might be to enable partial axis monitoring.  e=
.g.
> > > > > > If a device is flat on a table we only look for inactivity on t=
he non
> > > > > > vertical axis when doing DC coupling. (as we have 1g always in =
the other
> > > > > > axis).
> > > > > > =20
> > > > >
> > > > > Thank you for clarifying your position in the other mail focussed=
 on
> > > > > the AC- / DC-coupling
> > > > > topic. It helped me in better understanding what you actually exp=
ect
> > > > > here. Although I'll
> > > > > probably need to re-read it some times, before implementing somet=
hing. =20
> > > >
> > > > I definitely need to find time to write some docs on this.  Mad few
> > > > weeks coming up but maybe I'll get some time on a plane or at an ai=
rport
> > > > to try a first draft.
> > > > =20
> > > > > =20
> > > > > > > Given you still ask me to do Inactivity and Freefall as MAG/f=
alling
> > > > > > > with IIO_MOD_X_AND_Y_AND_Z. The difference between both IMHO,
> > > > > > > is that Activity and Inactivity for the ADXL345 indicate sens=
or state
> > > > > > > changes, where Freefall indicates the particular event. The
> > > > > > > sensor is either in "active" or "standby/inactive", where Fre=
efall
> > > > > > > just triggers and then retriggers and retriggers... =20
> > > > > >
> > > > > > Maybe. The datasheet is annoyingly vague on these but indeed th=
ere
> > > > > > is no event for no longer falling.
> > > > > > =20
> > > > > > >
> > > > > > > Q: What is the method to distinguish several similar IIO even=
ts, e.g.
> > > > > > > to tag them somehow one as Freefall, the other one as Inactiv=
ity? =20
> > > > > >
> > > > > > In general we should not be able to do that.  Long ago we made =
the decision
> > > > > > to have compact event codes so they don't allow for an index on=
 a particular
> > > > > > combination of channel number and modifier.  This is mainly bec=
ause
> > > > > > there is limited purpose.   If one event is triggered, then we =
have
> > > > > > to process anyway so we can just look at the value for 'how far=
' it was
> > > > > > triggered.  I.e. if we thought DC inactivity was triggered, we =
can just
> > > > > > check free fall as well. (It gets a little more fiddly because =
of _period
> > > > > > etc which is why they may actually make sense here).
> > > > > >
> > > > > > The virtual (combination OR/AND) was added on top of that later=
 and has
> > > > > > made the connection looser.
> > > > > >
> > > > > > In theory we could use labels + index for the virtual channels =
to achieve
> > > > > > separate control attributes and be able to tell which was which=
 but
> > > > > > that would be new ABI.  I'm not sure how much use this stuff is=
 already
> > > > > > getting from userspace applications and hence whether this woul=
d be
> > > > > > a big problem to get supported.
> > > > > >
> > > > > > That would give us something like
> > > > > >
> > > > > > iio\:device0/in_accel0_x&y&z_label   freefall
> > > > > > iio\:device0/in_accel1_x&y&z_label   inactivity
> > > > > > iio\:device0/events/in_accel0_x&y&z_en etc
> > > > > > iio\:device0/events/in_accel1_x&y&z_en etc
> > > > > >
> > > > > > I don't like it much because it then doesn't generalize to the =
case
> > > > > > of multiple sensors on each axis (there are multi range parts t=
hat do that).
> > > > > > That case is pretty rare though (I think we only have such sens=
or supported!)
> > > > > > However, it's currently the only option we have to fully repres=
ent this.
> > > > > > =20
> > >
> > > Kind of the naive approach to allow for extending everything, but it =
probably
> > > does not fit together with the existing sensor ABI. =20
> >
> > Agreed.
> > =20
> > > =20
> > > > > > An alternative here might be to assess if anyone is really goin=
g to use
> > > > > > DC coupled inactivity detection (because of the 1g problem) and=
 hence whether
> > > > > > we want to support that at all?
> > > > > > =20
> > >
> > > I'd rather drop free fall then. Activity and inactivity, linked to
> > > gether work well for the power saving
> > > thing. I guess that's probably also more of general use. Not sure how
> > > usefull free fall is here.
> > > =20
> > > > > > Yet another alternative might be to configure it purely based o=
n the period
> > > > > > provided. If short use freefall, if long use inactivity. (I don=
't like this
> > > > > > one though as it doesn't really fit with usecase!)
> > > > > > =20
> > >
> > > That's either free fall or the other? Ideally, I'd like to represent
> > > what's possible with this sensor. =20
> > That's the only option if using the period to control it.   You can't h=
ave
> > one event with two periods.
> > =20
> > > Since I'm not really familiar with how those sensors are used, for me
> > > all features are equally
> > > important. I mean, the sensor offers enabling act/inact and enabling
> > > free fall if one likes. =20
> >
> > Sure.
> > =20
> > > =20
> > > > > > Sorry for lack of clarity on this. These events are tricky and
> > > > > > it takes me a while to get the whole situation back into my hea=
d (and I missing
> > > > > > things like inactivity and freefall being very similar here!)
> > > > > > =20
> > >
> > > Ideally I'd like to implement support for all features of the sensor.
> > > I can understand if some corner case features are too individual to
> > > support them. So, at least the main features.
> > >
> > > From what I see in the code, configuring threshold and period, there
> > > might be differences and it can be easy to distinguish in
> > > read/write_event_value() like functions. Where
> > > read/write_event_config() will be more difficult.
> > > So, for the event, when I receive it I have knowledge of the exact
> > > event type, free fall or inactivity. I'm losing this information since
> > > it can currently not be conveyed over the channel. Might be that the
> > > ADXL345 is a very particular case. Might also be, that this shows a
> > > more general shortcoming which should be addressed. =20
> >
> > I'm sure there will be other sensors that have similar events.
> > How common is hard to say though.
> > =20
> > >
> > > Equally I could say, there is just a MAG event, so turning on
> > > inactivity or free fall would result in the same event. The tricky
> > > case then is if someone wants inactivity AND free fall. In such case
> > > it would be a inact_or_free_fall event. Not sure about. Probably
> > > rather not. =20
> >
> > It's just a threshold on falling magnitude of signal. What that means d=
epends
> > on the sensor type and other settings (here the period).  Event codes
> > are the same, but without the settings those are pretty meaningless.
> > =20
> > >
> > > Q: Still, what about the direction - I see, where activity is using
> > > IIO_EV_DIR_RISING, inactivity uses _DIR_FALLING. Free fall now uses
> > > _DIR_FALLING. I'm a bit unsure if this is just a choice. Could I use
> > > _DIR_EITHER here? Or why not? I mean, actually it's not possible to
> > > detect fall into one direction, it's simply "in a fall". We cannot
> > > tell which axis we cannot tell which direction. =20
> >
> > Not about direction in sense of x/y/z, but direction of the signal.
> >
> > They are definitely triggered when the |X| > thresh transitions
> > to |X| < thresh.  So direction is falling as value |X| is getting small=
er.
> >
> > The choice reflects the physical thing being measured.
> > =20
> > > =20
> > > > > > If you have time to take a look at what userspace is currently =
doing with
> > > > > > these events (iio_sensor_proxy etc) that might help us decide w=
hat works.
> > > > > > =20
> > >
> > > This might be generally a good option. Honestly, I'd like to mess
> > > still with some other sensors,
> > > first. =20
> >
> > Make sense. =20
>=20
> Could the following solve the situation: sharing the same event,
> distinguishing by cached information in the driver.
>=20
> Given, activity/inactivity and free-fall will have all MAG events,
> with activity is RISING, inactivity FALLING, and free-fall also
> FALLING.
> If only activity/inactivity or only free-fall is enabled (or none),
> there will be the particular MAG events. If now activity/inactivity
> and free-fall are enabled, all will send the same MAG event. That
> means some activity/inactivity event will then be shared with
> free-fall.
>=20
> The following ideas now apply only to the case both are enabled:
> act/inact and free-fall.
>=20
> Since the driver's ISR catches the sensor interrupt and evaluates, the
> driver has knowledge about the exact type of event. One idea then is,
> to keep this cached in the driver. Since activity / inactivity
> indicate a state switch (happening rarely), I can distinguish a state
> switch from free-fall by keeping activity/inactivity state switch as
> cached value(s) in the driver. Here, I can think of keeping the
> activity state, or indicate state switch, or the like.
>=20
> Another idea is not even distinguish (so much). Since practically
> free-fall is issued and re-issued quite often, most of the MAG FALLING
> events might be free-fall. I can default generally to free-fall if
> both is enabled. I'm not sure if activity/inactivity indication may
> lead to anything outside, also the free-fall could imply being
> interpreted of a sort of inactivity/activity type.
>=20
> Let me know, what you think.

I'm not grasping what these suggestions mean for userspace ABI.

My gut feeling is that almost no one will use free fall in practice
because the dominant usecase for that which I know of
(moving parts in laptops etc) isn't really at thing any more.
I think someone did long ago mention that it is also used for parking
mechanical lenses in phones though so maybe that still matters.

I see you sent a new version.  Perhaps that will make all clear.
Unfortunately I'm travelling this week and it's all a bit of rush
for the end of the kernel cycle, so it might take me a little
while to catch up with reviews.

Jonathan



>=20
> Best,
> L
>=20
> >
> > J
> > =20
> > >
> > > Best,
> > > L
> > > =20
> > > > >
> > > > > Just as a quick response here (or perhaps just to rule it out)..
> > > > >
> > > > > Actually, I can spot as MAG-similar event types:
> > > > > - IIO_EV_TYPE_MAG
> > > > > - IIO_EV_TYPE_MAG_ADAPTIVE
> > > > > - IIO_EV_TYPE_CHANGE
> > > > > - IIO_EV_TYPE_MAG_REFERENCED
> > > > >
> > > > > For instance the last one is only used in a single sensor. Is the=
re a
> > > > > chance to put, say, freefall into one of the other "MAG-like" sen=
sor
> > > > > types. Alternatively, what about putting Activity/Inactivity under
> > > > > say, "MAG_REFERENCED"? This might seem to be a stupid question, s=
ince
> > > > > I can imagine you have a clear definition of those in mind. But if
> > > > > this was possible. It would solve this problem easily. =20
> > > >
> > > > The ABI docs do provide some definitions of these.
> > > >
> > > > Free fall is definitely straight forward TYPE MAG.  It precisely al=
igns
> > > > with that definition as a threshold on the per axis magnitudes.
> > > >
> > > > MAG_ADAPTIVE is meant for a case where the event is on the magnitude
> > > > relative to a slow moving adaptive baseline (usually a low pass fil=
tered
> > > > version of the signal but can include corrective jumps - IIRC these=
 turn
> > > > up for magnetic sensors).  This differs from a rate of change thres=
hold
> > > > because it's not simply a difference between current and earlier si=
gnals
> > > > but rather current and some heavily filtered earlier signal.
> > > > These matter in cases where we have a slow changing baseline such as
> > > > coming into proximity with metal in the environment when using a ma=
gnetometer
> > > > for orientation detection.
> > > >
> > > > MAG_REFERENCED is a weird one.  This was done for a nice IMU that h=
ad
> > > > the ability to estimate orientation and so remove the acceleration =
due
> > > > to gravity and then apply thresholds to the magnitude of the remain=
ing
> > > > accelerations.  The AC filtering on your part is is a 'cheap' way
> > > > to achieve roughly the equivalent of that for the activity detectio=
n at least
> > > > where we are removing the 'nothing happening value'.
> > > > (it is less clear for the inactivity case though that will still in=
clude
> > > >  g, so maybe it is still somewhat valid).
> > > >
> > > > CHANGE is IIRC only for counting channels (so far anyway).
> > > >
> > > > So none of the more esoteric forms of them fit for this DC coupled
> > > > inactivity monitor or freefall. Both of them are the same type of e=
vent
> > > > just differing in filters applied.
> > > > =20
> > > > >
> > > > > If not, then I'll need to think of it and come up with a more
> > > > > elaborate approach. The label + index approach seems to be a bit
> > > > > complex. Going somehow by the time constraints  in the event.. I =
need
> > > > > to play with that in the code to build up an oppinion, I guess. =
=20
> > > >
> > > > The time constraints thing falls down on the basis that it would
> > > > be logical to have freefall enabled (for parking any moving parts -=
 those
> > > > used to exist mainly to stop hard disks but maybe there are other u=
se cases?)
> > > > and inactivity for power saving with a much longer timescale.
> > > >
> > > > Freefall used to be fun because the aim was to get moving parts into
> > > > a safe state before the device hit the ground.  So that meant if yo=
u dropped
> > > > a device with a harddisk from higher up, it sometimes had a better =
chance
> > > > of surviving.  I'm not sure if anyone cares any more! Will be inter=
esting
> > > > to see if that feature goes away on new devices.
> > > >
> > > > Jonathan
> > > > =20
> > > > >
> > > > > Best,
> > > > > L
> > > > > =20
> > > > > > Jonathan
> > > > > > =20
> > > > > > >
> > > > > > > Best,
> > > > > > > L
> > > > > > > =20
> > > > > > > > > +             .dir =3D IIO_EV_DIR_RISING,
> > > > > > > > > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > > > > > > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VA=
LUE),
> > > > > > > > > +     },
> > > > > > > > >       {
> > > > > > > > >               /* single tap */
> > > > > > > > >               .type =3D IIO_EV_TYPE_GESTURE,
> > > > > > > > > @@ -265,6 +290,99 @@ static int adxl345_set_measure_en(st=
ruct adxl345_state *st, bool en)
> > > > > > > > >       return regmap_write(st->regmap, ADXL345_REG_POWER_C=
TL, val);
> > > > > > > > >  }
> > > > > > > > > =20
> > > > > > > > Jonathan
> > > > > > > >
> > > > > > > > =20
> > > > > > =20
> > > > =20
> > > =20
> > =20


