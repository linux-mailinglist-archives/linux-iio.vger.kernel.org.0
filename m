Return-Path: <linux-iio+bounces-19065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B03AAA88C1
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F26E3AC95F
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0AE2459F3;
	Sun,  4 May 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy2GAxvI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9C724469C;
	Sun,  4 May 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380915; cv=none; b=mWUsdnzOmTESXBqZ7hKgQzhnjpX6beN01o+mNFz1iOoPu9IU7n9UvHYfP6D0L3njECFcAogss7DK9prpF4onIRAMOZJqudBtLOIfOVYmqbqChTfxYHmHVbyYANuivm70PzOH4JsBU42ceDCIB5CpFHbyUznuZP8Z/JSTaOJDqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380915; c=relaxed/simple;
	bh=Wl9BdK27cTB5P6HaDU3GJkHhPedBXltGpvXa2kR5ons=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XabwD8OGYSq3EHTmFtn5K54N++jlD+q8196ixnMRb6E3rHIJ/5GFkOiCKvQri1iAtvSI47kwYvOVe6V3S33elJBJbU65KmtbtJ/ie344k55q18XIi6YxctbQQafCncBvK3hOgF3MlYCuakiGyk3EY/GoO7XgGehMi5xNsXpUQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy2GAxvI; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e745a0b7a65so502666276.3;
        Sun, 04 May 2025 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746380912; x=1746985712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWEnNZchLhWuXHuljHiRmaEPQm7TqKAORxsAk7AQ2hM=;
        b=Xy2GAxvIxuwpsKTyEeDtMT3YINFXOGJ1jYhBrjPuxHJPrLepelPoEuZ3z+YzKCsBZr
         Hh2EW8La1AvGkXXjPES8ZukJJSYmHgj7MgfbcMp+xoneCQld3oIQBmuFhGwdM3Max8LJ
         JNajeR06iIxpulZqdiHxxEp6xZBOuxAbzKeHD3h8hx5A5DBcUxfsQ5fRuU4vmDJzrvPL
         9z8QcNfT7j9RAQk2xRbOSsYPgrggnvfPhAb+fXGu0ZDC54W8XTGw6v3PZ4BogsMt6e2N
         rcaqqagxTpa08QV8+ZInNMx66zvm5VJWXzUkOD9xZN0cdDIpE1UyIt8QCN970t+eMbGU
         tJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746380912; x=1746985712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWEnNZchLhWuXHuljHiRmaEPQm7TqKAORxsAk7AQ2hM=;
        b=kgd+BsnEypWKeN0I7r0UCv0eIn0jbbfCPEoB18PvCt5OyALsDg2AwiNEt5c0zfPJtp
         oJlGF+EFIaf2p8wi/6nq2tVqNjqECNILhNjSRe9eTdaEfj4PHM92l5VbJBMrBQNzc6II
         AyITyoz57+0RLVQUamtUfnGjp455lT8128Pm+XLkuoDhvp5Q0aomsvy2GJ9D8mhS7Xnz
         nUtyXzXCGmtn3YSutGkM24GW2B1YvR7dONmmPbLhx7ZhyS/XfRhZYVMu5gaPnVF70AeZ
         XEenPdCfWD1cK2ofsYRczRhX5tkN68tieBgfnvnMc/IGIRsj/0J54CJqGfNBzU1JDeKs
         HcMw==
X-Forwarded-Encrypted: i=1; AJvYcCVWICpW+2pGo4xJohNrXsPtOps+Nx3QpPPRPTHjkscp2JgZn+/SqtmDWFmNf3FLn595iPMKcjOVSft0JSUK@vger.kernel.org, AJvYcCXTLqxCK0z5BUJp0G9CMw3fGbUJd5NJlh0cAy+EoEVLQLS8GKTv7C8DCK4x6onJSDa1nkD2oATJdI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGukOtSWXedMfCAsZHXh99bZZycmsxyPoMhugDJ/uNGIswp2u2
	HLJhI65ZXMvIfRCHBa9zdRjKfQVVehZAxOAua23OeRP368z4lQNOl0wzzFJAOfanQ5tIOzXDtpS
	n08QAeZbYoIp33THCEGomyotaP6Y=
X-Gm-Gg: ASbGnctOJs9GpdYZ5J9Lg6g2UbscT2yJlljUuprub0gxlxFmoM+q4NyXeW2TV9H/VJW
	WXWxI6dndjBXfl98su64XNJq586SGEycVralvgRmA+KJmokU8w+Ivs3iT+7icVXI61w0So/eC1q
	ai35M66/OJn6kQ/IqLZdM1Gw==
X-Google-Smtp-Source: AGHT+IGQNme7NFxSL6wbQsXd76cPFeAzoQg0wBeOcUvS4OKT2NEZriUaWtEvzLwn38tRWAnGtkB0BzNSfBA4iIeMCd8=
X-Received: by 2002:a05:6902:1588:b0:e73:2b56:c40 with SMTP id
 3f1490d57ef6-e7565558086mr5636202276.3.1746380912289; Sun, 04 May 2025
 10:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421220641.105567-1-l.rubusch@gmail.com> <20250421220641.105567-9-l.rubusch@gmail.com>
 <20250427134759.3cc3a2a4@jic23-huawei> <CAFXKEHZ3KQ_Z4QB==Bb_CTauV7Wowd0Lgxaick=6mfiLJU654Q@mail.gmail.com>
 <20250504112904.64c1b5ee@jic23-huawei>
In-Reply-To: <20250504112904.64c1b5ee@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 4 May 2025 19:47:55 +0200
X-Gm-Features: ATxdqUGtrT5Wju3q0Pbqas87nBjrriRG-x7ntu6Yi2qTnqbolczsxUh9X9c6MKY
Message-ID: <CAFXKEHb8+76WiiTCQbRa9v6gAicT0wnua6vCn-NxCfgNiuud2g@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] iio: accel: adxl345: add activity event feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 12:29=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 1 May 2025 00:53:32 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Hi Jonathan - Hi IIO list,
> >
> > Please, find some (many) questions inlined down below. Appologies for
> > the separate
> > channels last time and not right away fixing them up as array. I did
> > not want to make extra work.
> >
> > On Sun, Apr 27, 2025 at 2:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Mon, 21 Apr 2025 22:06:38 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > Make the sensor detect and issue interrupts at activity. Activity
> > > > events are configured by a threshold stored in regmap cache. Initia=
lize
> > > > the activity threshold register to a reasonable default value in pr=
obe.
> > > > The value is taken from the older ADXL345 input driver, to provide =
a
> > > > similar behavior. Reset the activity/inactivity direction enabling
> > > > register in probe. Reset and initialization shall bring the sensor =
in a
> > > > defined initial state to prevent dangling settings when warm restar=
ting
> > > > the sensor.
> > > >
> > > > Activity, ODR configuration together with the range setting prepare=
 the
> > > > activity/inactivity hystersesis setup, implemented in a follow up p=
atch.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/adxl345_core.c | 217 +++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 214 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/a=
dxl345_core.c
> > > > index 80b5b8402ced..680981609d83 100644
> > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > @@ -36,11 +36,16 @@
> > > >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > > +#define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > >
> > > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > >  #define ADXL345_TAP_Y_EN             BIT(1)
> > > >  #define ADXL345_TAP_X_EN             BIT(2)
> > > >
> > > > +#define ADXL345_ACT_Z_EN             BIT(4)
> > > > +#define ADXL345_ACT_Y_EN             BIT(5)
> > > > +#define ADXL345_ACT_X_EN             BIT(6)
> > > > +
> > > >  /* single/double tap */
> > > >  enum adxl345_tap_type {
> > > >       ADXL345_SINGLE_TAP,
> > > > @@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_time_reg[]=
 =3D {
> > > >       [ADXL345_TAP_TIME_DUR] =3D ADXL345_REG_DUR,
> > > >  };
> > > >
> > > > +/* activity/inactivity */
> > > > +enum adxl345_activity_type {
> > > > +     ADXL345_ACTIVITY,
> > > > +};
> > > > +
> > > > +static const unsigned int adxl345_act_int_reg[] =3D {
> > > > +     [ADXL345_ACTIVITY] =3D ADXL345_INT_ACTIVITY,
> > > > +};
> > > > +
> > > > +static const unsigned int adxl345_act_thresh_reg[] =3D {
> > > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_THRESH_ACT,
> > > > +};
> > > > +
> > > >  enum adxl345_odr {
> > > >       ADXL345_ODR_0P10HZ =3D 0,
> > > >       ADXL345_ODR_0P20HZ,
> > > > @@ -154,6 +172,13 @@ struct adxl345_state {
> > > >  };
> > > >
> > > >  static struct iio_event_spec adxl345_events[] =3D {
> > > > +     {
> > > > +             /* activity */
> > > > +             .type =3D IIO_EV_TYPE_THRESH,
> > >
> > > Is this a threshold, or a magnitude? I'd expect an activity detector
> > > to be magnitude as it doesn't care which way up the sensor is.
> > >
> >
> > This is touching the main points still unclear to me. I tried to put
> > this into the
> > following questions. Could you please clarify?
>
> There are some corners where it gets messy. When I have time
> (not for a month or so) I'll try and write some proper docs for this.
>
> >
> > 1. Given a measurement "val", and a configured threshold "thr".
> > A "rising" for IIO_EV_TYPE_THRESH means: val > thr
> > where a "rising" for IIO_EV_TYPE_MAG means something like: val > |thr|
> >
> > Q: Do I understand this correctly now?
>
> Yes that is the intended difference.
>
> >
> > Q: Is this documented somewhere (especially for reviewing further
> > EV_TYPE fields)?
>
> Only in the ABI documentation in
> Documentation/ABI/testing/sysfs-bus-iio
> This is definitely something we should look to improve with some
> docs beyond simply what the ABI is.  That ABI is focused on
> how the interrupt is triggered, not so much on what that means
> wrt to freefall etc.
>
>
> >
> > Q: I wonder if I missed this for the Tap events. Going by this
> > definition, then actually the
> > tap events should be rather MAG events, too. Right?
>
> The tap events have their own type (gesture) because they are way
> more complex than a simple threshold whether on magnitude or
> the signed value.  So those should be fine as type GESTURE.
>

I was aware of that. Actually, the case of GESTURE is a bit
particular. On the one side, I
understand having a distinction between THRESH events and MAG events.
Hence, a classification of the type of event in terms of a measurement
value triggering event condition.
This concept seems actually to be clear.

GESTURE to me then seems a bit like a "wildcard type covering all kind
of tap events". I mean,
saying tap detection, single tap, double tap, tripple tap, and so on
tap go into category GESTURE - naively could also mean, then do a
freefall  type as well (?).

[this is rather meant as a bit of a provocative rhetoric question than
a proposal]

> >
> >
> > 2. I oriented myself mostly by reading other drivers, for instance the
> > ADXL367, the ADXL372, or also the more recent ADXL380. I am aware that
> > there might be differences among different
> > (Analog) sensors. But all those sensors specify Inactivity (and Activit=
y) as a
> > IIO_EV_TYPE_THRESH with directions IIO_MOD_X_OR_Y_OR_Z.
> > Given the above, I implemented Activity and Inactivity events as
> > IIO_EV_TYPE_THRESH,
> > now I'm a bit confused.
>
> Hmm. This is one reason I think we need more documentation as those
> seem to be wrong.  Clearly the event is a threshold on a magnitude of
> the acceleration, not the signed value as it applies in both directions.
>
> >
> > Q: Why is this different for the ADXL345?
>
> Because we got it wrong for these others it seems unless they genuinely
> have directional events - which typically means separate positive and
> negative thresholds.  Right now those events are strictly speaking
> only apply to positive accelerations.
>
> >
> > Q: If I implement Activity / Inactivity analogous to the e.g. a
> > ADXL380, then shouldn't it be IIO_EV_TYPE_THRESH with
> > IIO_MOD_X_OR_Y_OR_Z? Why not?
> >
>
> I think we got it wrong for that part.  Going forwards we should work
> on getting it (more) correct.
>

I understand the point better now.

> >
> > 3. For the ADXL345, a Freefall signal is on all axis lower than
> > threshold (magnitude). Thus I push a IIO_MOD_X_AND_Y_AND_Z to a
> > separate
> > fake channel. Inactivity will be like Freefall independent of the axis.
> > The ADXL345 Activity can be configured by axis, as also the event will
> > respect the axis information.
> >
> > Q: Setting up the "fake channel" to particuarly push to
> > IIO_MOD_X_AND_Y_AND_Z, I probably better should also evaluate
> > IIO_MOD_X_AND_Y_AND_Z in write_event_config(), write_event_value(),
> > etc. rather than evaluating IIO_MOD_-types as I'm currently
> > doing?
>
> Yes. That sounds correct for events on these 'fake' channels.
> The enable and the thresholds should all be on these fake channels
> assuming they don't have different thresholds on a per axis basis
> (if they do things get tricky to represent).
>
> >
> > Q: Activity probably remains in the regular channels for the correspond=
ing axis?
>
> Yes.  That is easier to handle as OR of channels is very similar
> to separate interrupts etc.
>

I think I should definitely evaluate the IIO_MOD_X_AND_Y_AND_Z here,
to take advantage
of the fake channel.

> >
> >
> > 4. I implemented functions like adxl345_write_event_config(),
> > adxl345_write_event_value() or corresponding
> > readers, as follows
> > - THRESH/rising: Activity
> > - THRESH/falling: Inactivity
> > - MAG/falling: Freefall
> >
> > If I change Activity and Inactivity to be both of type MAG, I will end
> > up with MAG/falling to indicate Freefall or equally Inactivity.
> > Both on the IIO_MOD_X_AND_Y_AND_Z channel. I admit (ab)using the
> > IIO_EV_TYPEs to solve my combinatorial issues for event configuration
> > is probably not as supposed to be.
>
> Ah..  This I'd missed.  I'm fairly sure we didn't hit this for (some) pre=
vious
> inactivity sensors because they were always rate of change based, (AC)
> rather than DC. DC is relatively unlikely to be used in practice because
> we can't set the threshold as less than 1G because of gravity.  It is a
> bit odd that the device supports both DC and AC on this detector.
>
> I wonder why.... Might be to enable partial axis monitoring.  e.g.
> If a device is flat on a table we only look for inactivity on the non
> vertical axis when doing DC coupling. (as we have 1g always in the other
> axis).
>

Thank you for clarifying your position in the other mail focussed on
the AC- / DC-coupling
topic. It helped me in better understanding what you actually expect
here. Although I'll
probably need to re-read it some times, before implementing something.

> > Given you still ask me to do Inactivity and Freefall as MAG/falling
> > with IIO_MOD_X_AND_Y_AND_Z. The difference between both IMHO,
> > is that Activity and Inactivity for the ADXL345 indicate sensor state
> > changes, where Freefall indicates the particular event. The
> > sensor is either in "active" or "standby/inactive", where Freefall
> > just triggers and then retriggers and retriggers...
>
> Maybe. The datasheet is annoyingly vague on these but indeed there
> is no event for no longer falling.
>
> >
> > Q: What is the method to distinguish several similar IIO events, e.g.
> > to tag them somehow one as Freefall, the other one as Inactivity?
>
> In general we should not be able to do that.  Long ago we made the decisi=
on
> to have compact event codes so they don't allow for an index on a particu=
lar
> combination of channel number and modifier.  This is mainly because
> there is limited purpose.   If one event is triggered, then we have
> to process anyway so we can just look at the value for 'how far' it was
> triggered.  I.e. if we thought DC inactivity was triggered, we can just
> check free fall as well. (It gets a little more fiddly because of _period
> etc which is why they may actually make sense here).
>
> The virtual (combination OR/AND) was added on top of that later and has
> made the connection looser.
>
> In theory we could use labels + index for the virtual channels to achieve
> separate control attributes and be able to tell which was which but
> that would be new ABI.  I'm not sure how much use this stuff is already
> getting from userspace applications and hence whether this would be
> a big problem to get supported.
>
> That would give us something like
>
> iio\:device0/in_accel0_x&y&z_label   freefall
> iio\:device0/in_accel1_x&y&z_label   inactivity
> iio\:device0/events/in_accel0_x&y&z_en etc
> iio\:device0/events/in_accel1_x&y&z_en etc
>
> I don't like it much because it then doesn't generalize to the case
> of multiple sensors on each axis (there are multi range parts that do tha=
t).
> That case is pretty rare though (I think we only have such sensor support=
ed!)
> However, it's currently the only option we have to fully represent this.
>
> An alternative here might be to assess if anyone is really going to use
> DC coupled inactivity detection (because of the 1g problem) and hence whe=
ther
> we want to support that at all?
>
> Yet another alternative might be to configure it purely based on the peri=
od
> provided. If short use freefall, if long use inactivity. (I don't like th=
is
> one though as it doesn't really fit with usecase!)
>
> Sorry for lack of clarity on this. These events are tricky and
> it takes me a while to get the whole situation back into my head (and I m=
issing
> things like inactivity and freefall being very similar here!)
>
> If you have time to take a look at what userspace is currently doing with
> these events (iio_sensor_proxy etc) that might help us decide what works.
>

Just as a quick response here (or perhaps just to rule it out)..

Actually, I can spot as MAG-similar event types:
- IIO_EV_TYPE_MAG
- IIO_EV_TYPE_MAG_ADAPTIVE
- IIO_EV_TYPE_CHANGE
- IIO_EV_TYPE_MAG_REFERENCED

For instance the last one is only used in a single sensor. Is there a
chance to put, say, freefall into one of the other "MAG-like" sensor
types. Alternatively, what about putting Activity/Inactivity under
say, "MAG_REFERENCED"? This might seem to be a stupid question, since
I can imagine you have a clear definition of those in mind. But if
this was possible. It would solve this problem easily.

If not, then I'll need to think of it and come up with a more
elaborate approach. The label + index approach seems to be a bit
complex. Going somehow by the time constraints  in the event.. I need
to play with that in the code to build up an oppinion, I guess.

Best,
L

> Jonathan
>
> >
> > Best,
> > L
> >
> > > > +             .dir =3D IIO_EV_DIR_RISING,
> > > > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE),
> > > > +     },
> > > >       {
> > > >               /* single tap */
> > > >               .type =3D IIO_EV_TYPE_GESTURE,
> > > > @@ -265,6 +290,99 @@ static int adxl345_set_measure_en(struct adxl3=
45_state *st, bool en)
> > > >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> > > >  }
> > > >
> > > Jonathan
> > >
> > >
>

