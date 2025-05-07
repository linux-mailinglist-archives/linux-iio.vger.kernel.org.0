Return-Path: <linux-iio+bounces-19274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9233AAEDF6
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 23:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA4B3B4095
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796822F16F;
	Wed,  7 May 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ9IxsaQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFA1C84CD;
	Wed,  7 May 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654063; cv=none; b=GMZM9v14G27qy2FV8Ujdfy98+breM1Zy/Hb2Yzf2zVp8E11rQ7y39r6Nr9kFRJ7XbxaqFy3TkjYArzlpQgmcf0hWVvD94dZED03rasAae5wLrdo8AcV/3civQRfIfEAF1Qi+C4n3KKeeCdr7iK3ZM/S6k0zo8khxFVImNfckkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654063; c=relaxed/simple;
	bh=NblFdakzS+eLUug5FRqwYsRvz/5apIv1MPmvHBkPHdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1H9BCBg4BDVp1CCfWZ28x2es24hgQjDPxd57GdyTpza2SvAY1pTbqb9WXtA4JdfhF1rCD9wdLHgXxvpiBeWgjGI/sn04xYT3rIcnZldtdEBAf76AkELfh9XehFIoDO+WFHVLif6VqHc6CLmhTNAtxhys16uzGHzH3vLn2qmbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ9IxsaQ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7271b39a4fso41092276.3;
        Wed, 07 May 2025 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746654059; x=1747258859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI5zmL+gPpsZ7UVxJ1juYiyrMu5Tcir8vuH+OxFk3gg=;
        b=GZ9IxsaQFdD9NCcl+IM3+r1ka7LogVz0Nx8FGbNDHlsmwgQRlUM79WvRefD17wUD/X
         7eTpkfSrV9Bt3wKkdFchOzTESxV0GTcIVXOTRAWmP0/D1ctrjbnN+7KM0eVeAgFw0Sgz
         yXmYp2kh8KtQuAVkIFRctxqPWjxurqVFVTDiBHzKJEKZwTn0Re6wCW1X6NnLyaLKX8zn
         HtbcqsbRyNgubOavQQHTGb++QwWLvv5rbXRDbbiR3F0QRKMwyea1pd7IOMBTUFDePbWn
         jAbbxosLj4RtuxoFvjBn3McY/i90t6HUl35dqA0eMaYZL+UWsS53k/cauag1iE3rdw78
         aWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654059; x=1747258859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI5zmL+gPpsZ7UVxJ1juYiyrMu5Tcir8vuH+OxFk3gg=;
        b=UrCwU6OM76sD91iCik+zXS4nBFDJ02XmVai/o+xVef4ub8nB5gggpI2XpmV0Yko96b
         SPyvGGITsZQpjkm8RT9f+jWZqpOzGbvg+BU6RC3RdB32H8/EUujC6fvBkvpvmKjZRrY4
         MpFYM66Kc6BOSUSgKHsmvYOvJr3oU5FGBgRFLa6r85uAyAIVJgUPR+cUStu23XpYyEXz
         fFRLQjFSI0qm7KUi53HQZIXOhyJ6xCozfmkbv2Aj8qk93GmjuxchgjgzUogrfmia8HQZ
         F8a2Mc6qSi1mT6P5vLDaA7G7FhCMVaLw0uCBy8bKzJbNZWvqC4TpVlhbMiErRMcL6EWw
         +x7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEyhx0R0wDNszmfMgYJdp3hWTf5RmZGiPZZVUpvDaU0eklJsRAHdKJP9VQbWsfh4kGa+eZp7JYPSY=@vger.kernel.org, AJvYcCVWsWkvK4YJpy8JVVfR22P1SCheHw71YYYYseOV3PJhetujbef2Ye/MGrghdXP7pvopAaOO/iQiiB1f6VVE@vger.kernel.org
X-Gm-Message-State: AOJu0Yym34Qw0WqDT607QkhWszZ8GIhZrxUywp4XnpSUuXXGdH/ey3aU
	TfJnGK2AOC3MwdgUdj6nNbEsX850YpR8tHvd3paUZMFu7keur/dAOJUws0bEbHYWZiayDEgBhoW
	CmQpFa5WVwqMHshtWSZjItwtjAJE=
X-Gm-Gg: ASbGncunYCAY+fQaQrk6reYbzmc1mw+XQtF3/BMnfBmE0jENczLFYNrmA3yKaTHIylP
	Dkg2eOGBFRw11dXfHonzOC85Foprl8Q2TR+LAOdfDszu3xDGw29jqJgUs0jucK6Qxm3ZGDyO5il
	dzTL4DfnB6cYkZPZP5Xd2bgw==
X-Google-Smtp-Source: AGHT+IG/wNHyWP6jhZap2vKYIbs/JyvrCHLHiVsRbZq2QxH6FBOXIgOVCIChBVzWEfohxn+wXnu/GuAefA+83Ry63rY=
X-Received: by 2002:a05:6902:2085:b0:e73:281d:684b with SMTP id
 3f1490d57ef6-e78814218acmr2834777276.6.1746654059207; Wed, 07 May 2025
 14:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421220641.105567-1-l.rubusch@gmail.com> <20250421220641.105567-9-l.rubusch@gmail.com>
 <20250427134759.3cc3a2a4@jic23-huawei> <CAFXKEHZ3KQ_Z4QB==Bb_CTauV7Wowd0Lgxaick=6mfiLJU654Q@mail.gmail.com>
 <20250504112904.64c1b5ee@jic23-huawei> <CAFXKEHb8+76WiiTCQbRa9v6gAicT0wnua6vCn-NxCfgNiuud2g@mail.gmail.com>
 <20250505133743.686d957d@jic23-huawei> <CAFXKEHa2s53Rt9FkE+aUouvQDd7qs5gt9JNzpmDfEnvvK+5e7w@mail.gmail.com>
 <20250507204847.01807b28@jic23-huawei>
In-Reply-To: <20250507204847.01807b28@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 7 May 2025 23:40:22 +0200
X-Gm-Features: ATxdqUE7zyInUN-mMDOxz26pWDpwFyoWFtZdRCfb4VT6VJJJlojQEYp3roq8yLQ
Message-ID: <CAFXKEHZ+AzRdrnN2_cuNdTgby3JsCZA5V7oOv5OBG3mcW1KWeg@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] iio: accel: adxl345: add activity event feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 9:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Wed, 7 May 2025 00:37:43 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Hi Jonathan,
> > Still some questions and thoughts down below.
> >
> > On Mon, May 5, 2025 at 2:37=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > >
> > > On Sun, 4 May 2025 19:47:55 +0200
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > On Sun, May 4, 2025 at 12:29=E2=80=AFPM Jonathan Cameron <jic23@ker=
nel.org> wrote:
> > > > >
> > > > > On Thu, 1 May 2025 00:53:32 +0200
> > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > >
> > > > > > Hi Jonathan - Hi IIO list,
> > > > > >
> > > > > > Please, find some (many) questions inlined down below. Appologi=
es for
> > > > > > the separate
> > > > > > channels last time and not right away fixing them up as array. =
I did
> > > > > > not want to make extra work.
> > > > > >
> > > > > > On Sun, Apr 27, 2025 at 2:48=E2=80=AFPM Jonathan Cameron <jic23=
@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, 21 Apr 2025 22:06:38 +0000
> > > > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > > > >
> > > > > > > > Make the sensor detect and issue interrupts at activity. Ac=
tivity
> > > > > > > > events are configured by a threshold stored in regmap cache=
. Initialize
> > > > > > > > the activity threshold register to a reasonable default val=
ue in probe.
> > > > > > > > The value is taken from the older ADXL345 input driver, to =
provide a
> > > > > > > > similar behavior. Reset the activity/inactivity direction e=
nabling
> > > > > > > > register in probe. Reset and initialization shall bring the=
 sensor in a
> > > > > > > > defined initial state to prevent dangling settings when war=
m restarting
> > > > > > > > the sensor.
> > > > > > > >
> > > > > > > > Activity, ODR configuration together with the range setting=
 prepare the
> > > > > > > > activity/inactivity hystersesis setup, implemented in a fol=
low up patch.
> > > > > > > >
> > > > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > > > > ---
> > > > > > > >  drivers/iio/accel/adxl345_core.c | 217 +++++++++++++++++++=
+++++++++++-
> > > > > > > >  1 file changed, 214 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio=
/accel/adxl345_core.c
> > > > > > > > index 80b5b8402ced..680981609d83 100644
> > > > > > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > > > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > > > > > @@ -36,11 +36,16 @@
> > > > > > > >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > > > > > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > > > > > > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > > > > > > +#define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > > > > > >
> > > > > > > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > > > > > >  #define ADXL345_TAP_Y_EN             BIT(1)
> > > > > > > >  #define ADXL345_TAP_X_EN             BIT(2)
> > > > > > > >
> > > > > > > > +#define ADXL345_ACT_Z_EN             BIT(4)
> > > > > > > > +#define ADXL345_ACT_Y_EN             BIT(5)
> > > > > > > > +#define ADXL345_ACT_X_EN             BIT(6)
> > > > > > > > +
> > > > > > > >  /* single/double tap */
> > > > > > > >  enum adxl345_tap_type {
> > > > > > > >       ADXL345_SINGLE_TAP,
> > > > > > > > @@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_ti=
me_reg[] =3D {
> > > > > > > >       [ADXL345_TAP_TIME_DUR] =3D ADXL345_REG_DUR,
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +/* activity/inactivity */
> > > > > > > > +enum adxl345_activity_type {
> > > > > > > > +     ADXL345_ACTIVITY,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static const unsigned int adxl345_act_int_reg[] =3D {
> > > > > > > > +     [ADXL345_ACTIVITY] =3D ADXL345_INT_ACTIVITY,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static const unsigned int adxl345_act_thresh_reg[] =3D {
> > > > > > > > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_THRESH_ACT,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >  enum adxl345_odr {
> > > > > > > >       ADXL345_ODR_0P10HZ =3D 0,
> > > > > > > >       ADXL345_ODR_0P20HZ,
> > > > > > > > @@ -154,6 +172,13 @@ struct adxl345_state {
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  static struct iio_event_spec adxl345_events[] =3D {
> > > > > > > > +     {
> > > > > > > > +             /* activity */
> > > > > > > > +             .type =3D IIO_EV_TYPE_THRESH,
> > > > > > >
> > > > > > > Is this a threshold, or a magnitude? I'd expect an activity d=
etector
> > > > > > > to be magnitude as it doesn't care which way up the sensor is=
.
> > > > > > >
> > > > > >
> > > > > > This is touching the main points still unclear to me. I tried t=
o put
> > > > > > this into the
> > > > > > following questions. Could you please clarify?
> > > > >
> > > > > There are some corners where it gets messy. When I have time
> > > > > (not for a month or so) I'll try and write some proper docs for t=
his.
> > > > >
> > > > > >
> > > > > > 1. Given a measurement "val", and a configured threshold "thr".
> > > > > > A "rising" for IIO_EV_TYPE_THRESH means: val > thr
> > > > > > where a "rising" for IIO_EV_TYPE_MAG means something like: val =
> |thr|
> > > > > >
> > > > > > Q: Do I understand this correctly now?
> > > > >
> > > > > Yes that is the intended difference.
> > > > >
> > > > > >
> > > > > > Q: Is this documented somewhere (especially for reviewing furth=
er
> > > > > > EV_TYPE fields)?
> > > > >
> > > > > Only in the ABI documentation in
> > > > > Documentation/ABI/testing/sysfs-bus-iio
> > > > > This is definitely something we should look to improve with some
> > > > > docs beyond simply what the ABI is.  That ABI is focused on
> > > > > how the interrupt is triggered, not so much on what that means
> > > > > wrt to freefall etc.
> > > > >
> > > > >
> > > > > >
> > > > > > Q: I wonder if I missed this for the Tap events. Going by this
> > > > > > definition, then actually the
> > > > > > tap events should be rather MAG events, too. Right?
> > > > >
> > > > > The tap events have their own type (gesture) because they are way
> > > > > more complex than a simple threshold whether on magnitude or
> > > > > the signed value.  So those should be fine as type GESTURE.
> > > > >
> > > >
> > > > I was aware of that. Actually, the case of GESTURE is a bit
> > > > particular. On the one side, I
> > > > understand having a distinction between THRESH events and MAG event=
s.
> > > > Hence, a classification of the type of event in terms of a measurem=
ent
> > > > value triggering event condition.
> > > > This concept seems actually to be clear.
> > > >
> > > > GESTURE to me then seems a bit like a "wildcard type covering all k=
ind
> > > > of tap events". I mean,
> > > > saying tap detection, single tap, double tap, tripple tap, and so o=
n
> > > > tap go into category GESTURE - naively could also mean, then do a
> > > > freefall  type as well (?).
> > >
> > > Nope. Because freefall has a clear definition that aligns with
> > > the events that we have for other types of sensor.
> > >
> > > You are right that gesture is a wild card. I resisted it for a long
> > > time but there is just no sane way to handle tap events alongside
> > > the sort of things we get on any other sensor type.  Having looked
> > > at a bunch of them they can be anything from straight magnitude thres=
holds
> > > with time windows to things based on a mixture of jerk (rate of chang=
e
> > > of acceleration) and other stuff.  The only thing that kind of close
> > > to this is pedometer step events, but we handle those as a counting
> > > channel rather than an event as time of each is less interesting than
> > > how many have happened.  However as noted below we do have the CHANGE
> > > type of event specifically to account for those (which is ugly).
> > >
> > > >
> > > > [this is rather meant as a bit of a provocative rhetoric question t=
han
> > > > a proposal]
> > > >
> > > > > >
> > > > > >
> > > > > > 2. I oriented myself mostly by reading other drivers, for insta=
nce the
> > > > > > ADXL367, the ADXL372, or also the more recent ADXL380. I am awa=
re that
> > > > > > there might be differences among different
> > > > > > (Analog) sensors. But all those sensors specify Inactivity (and=
 Activity) as a
> > > > > > IIO_EV_TYPE_THRESH with directions IIO_MOD_X_OR_Y_OR_Z.
> > > > > > Given the above, I implemented Activity and Inactivity events a=
s
> > > > > > IIO_EV_TYPE_THRESH,
> > > > > > now I'm a bit confused.
> > > > >
> > > > > Hmm. This is one reason I think we need more documentation as tho=
se
> > > > > seem to be wrong.  Clearly the event is a threshold on a magnitud=
e of
> > > > > the acceleration, not the signed value as it applies in both dire=
ctions.
> > > > >
> > > > > >
> > > > > > Q: Why is this different for the ADXL345?
> > > > >
> > > > > Because we got it wrong for these others it seems unless they gen=
uinely
> > > > > have directional events - which typically means separate positive=
 and
> > > > > negative thresholds.  Right now those events are strictly speakin=
g
> > > > > only apply to positive accelerations.
> > > > >
> > > > > >
> > > > > > Q: If I implement Activity / Inactivity analogous to the e.g. a
> > > > > > ADXL380, then shouldn't it be IIO_EV_TYPE_THRESH with
> > > > > > IIO_MOD_X_OR_Y_OR_Z? Why not?
> > > > > >
> > > > >
> > > > > I think we got it wrong for that part.  Going forwards we should =
work
> > > > > on getting it (more) correct.
> > > > >
> > > >
> > > > I understand the point better now.
> > > >
> > > > > >
> > > > > > 3. For the ADXL345, a Freefall signal is on all axis lower than
> > > > > > threshold (magnitude). Thus I push a IIO_MOD_X_AND_Y_AND_Z to a
> > > > > > separate
> > > > > > fake channel. Inactivity will be like Freefall independent of t=
he axis.
> > > > > > The ADXL345 Activity can be configured by axis, as also the eve=
nt will
> > > > > > respect the axis information.
> > > > > >
> > > > > > Q: Setting up the "fake channel" to particuarly push to
> > > > > > IIO_MOD_X_AND_Y_AND_Z, I probably better should also evaluate
> > > > > > IIO_MOD_X_AND_Y_AND_Z in write_event_config(), write_event_valu=
e(),
> > > > > > etc. rather than evaluating IIO_MOD_-types as I'm currently
> > > > > > doing?
> > > > >
> > > > > Yes. That sounds correct for events on these 'fake' channels.
> > > > > The enable and the thresholds should all be on these fake channel=
s
> > > > > assuming they don't have different thresholds on a per axis basis
> > > > > (if they do things get tricky to represent).
> > > > >
> > > > > >
> > > > > > Q: Activity probably remains in the regular channels for the co=
rresponding axis?
> > > > >
> > > > > Yes.  That is easier to handle as OR of channels is very similar
> > > > > to separate interrupts etc.
> > > > >
> > > >
> > > > I think I should definitely evaluate the IIO_MOD_X_AND_Y_AND_Z here=
,
> > > > to take advantage
> > > > of the fake channel.
> > > >
> > > > > >
> > > > > >
> > > > > > 4. I implemented functions like adxl345_write_event_config(),
> > > > > > adxl345_write_event_value() or corresponding
> > > > > > readers, as follows
> > > > > > - THRESH/rising: Activity
> > > > > > - THRESH/falling: Inactivity
> > > > > > - MAG/falling: Freefall
> > > > > >
> > > > > > If I change Activity and Inactivity to be both of type MAG, I w=
ill end
> > > > > > up with MAG/falling to indicate Freefall or equally Inactivity.
> > > > > > Both on the IIO_MOD_X_AND_Y_AND_Z channel. I admit (ab)using th=
e
> > > > > > IIO_EV_TYPEs to solve my combinatorial issues for event configu=
ration
> > > > > > is probably not as supposed to be.
> > > > >
> > > > > Ah..  This I'd missed.  I'm fairly sure we didn't hit this for (s=
ome) previous
> > > > > inactivity sensors because they were always rate of change based,=
 (AC)
> > > > > rather than DC. DC is relatively unlikely to be used in practice =
because
> > > > > we can't set the threshold as less than 1G because of gravity.  I=
t is a
> > > > > bit odd that the device supports both DC and AC on this detector.
> > > > >
> > > > > I wonder why.... Might be to enable partial axis monitoring.  e.g=
.
> > > > > If a device is flat on a table we only look for inactivity on the=
 non
> > > > > vertical axis when doing DC coupling. (as we have 1g always in th=
e other
> > > > > axis).
> > > > >
> > > >
> > > > Thank you for clarifying your position in the other mail focussed o=
n
> > > > the AC- / DC-coupling
> > > > topic. It helped me in better understanding what you actually expec=
t
> > > > here. Although I'll
> > > > probably need to re-read it some times, before implementing somethi=
ng.
> > >
> > > I definitely need to find time to write some docs on this.  Mad few
> > > weeks coming up but maybe I'll get some time on a plane or at an airp=
ort
> > > to try a first draft.
> > >
> > > >
> > > > > > Given you still ask me to do Inactivity and Freefall as MAG/fal=
ling
> > > > > > with IIO_MOD_X_AND_Y_AND_Z. The difference between both IMHO,
> > > > > > is that Activity and Inactivity for the ADXL345 indicate sensor=
 state
> > > > > > changes, where Freefall indicates the particular event. The
> > > > > > sensor is either in "active" or "standby/inactive", where Freef=
all
> > > > > > just triggers and then retriggers and retriggers...
> > > > >
> > > > > Maybe. The datasheet is annoyingly vague on these but indeed ther=
e
> > > > > is no event for no longer falling.
> > > > >
> > > > > >
> > > > > > Q: What is the method to distinguish several similar IIO events=
, e.g.
> > > > > > to tag them somehow one as Freefall, the other one as Inactivit=
y?
> > > > >
> > > > > In general we should not be able to do that.  Long ago we made th=
e decision
> > > > > to have compact event codes so they don't allow for an index on a=
 particular
> > > > > combination of channel number and modifier.  This is mainly becau=
se
> > > > > there is limited purpose.   If one event is triggered, then we ha=
ve
> > > > > to process anyway so we can just look at the value for 'how far' =
it was
> > > > > triggered.  I.e. if we thought DC inactivity was triggered, we ca=
n just
> > > > > check free fall as well. (It gets a little more fiddly because of=
 _period
> > > > > etc which is why they may actually make sense here).
> > > > >
> > > > > The virtual (combination OR/AND) was added on top of that later a=
nd has
> > > > > made the connection looser.
> > > > >
> > > > > In theory we could use labels + index for the virtual channels to=
 achieve
> > > > > separate control attributes and be able to tell which was which b=
ut
> > > > > that would be new ABI.  I'm not sure how much use this stuff is a=
lready
> > > > > getting from userspace applications and hence whether this would =
be
> > > > > a big problem to get supported.
> > > > >
> > > > > That would give us something like
> > > > >
> > > > > iio\:device0/in_accel0_x&y&z_label   freefall
> > > > > iio\:device0/in_accel1_x&y&z_label   inactivity
> > > > > iio\:device0/events/in_accel0_x&y&z_en etc
> > > > > iio\:device0/events/in_accel1_x&y&z_en etc
> > > > >
> > > > > I don't like it much because it then doesn't generalize to the ca=
se
> > > > > of multiple sensors on each axis (there are multi range parts tha=
t do that).
> > > > > That case is pretty rare though (I think we only have such sensor=
 supported!)
> > > > > However, it's currently the only option we have to fully represen=
t this.
> > > > >
> >
> > Kind of the naive approach to allow for extending everything, but it pr=
obably
> > does not fit together with the existing sensor ABI.
>
> Agreed.
>
> >
> > > > > An alternative here might be to assess if anyone is really going =
to use
> > > > > DC coupled inactivity detection (because of the 1g problem) and h=
ence whether
> > > > > we want to support that at all?
> > > > >
> >
> > I'd rather drop free fall then. Activity and inactivity, linked to
> > gether work well for the power saving
> > thing. I guess that's probably also more of general use. Not sure how
> > usefull free fall is here.
> >
> > > > > Yet another alternative might be to configure it purely based on =
the period
> > > > > provided. If short use freefall, if long use inactivity. (I don't=
 like this
> > > > > one though as it doesn't really fit with usecase!)
> > > > >
> >
> > That's either free fall or the other? Ideally, I'd like to represent
> > what's possible with this sensor.
> That's the only option if using the period to control it.   You can't hav=
e
> one event with two periods.
>
> > Since I'm not really familiar with how those sensors are used, for me
> > all features are equally
> > important. I mean, the sensor offers enabling act/inact and enabling
> > free fall if one likes.
>
> Sure.
>
> >
> > > > > Sorry for lack of clarity on this. These events are tricky and
> > > > > it takes me a while to get the whole situation back into my head =
(and I missing
> > > > > things like inactivity and freefall being very similar here!)
> > > > >
> >
> > Ideally I'd like to implement support for all features of the sensor.
> > I can understand if some corner case features are too individual to
> > support them. So, at least the main features.
> >
> > From what I see in the code, configuring threshold and period, there
> > might be differences and it can be easy to distinguish in
> > read/write_event_value() like functions. Where
> > read/write_event_config() will be more difficult.
> > So, for the event, when I receive it I have knowledge of the exact
> > event type, free fall or inactivity. I'm losing this information since
> > it can currently not be conveyed over the channel. Might be that the
> > ADXL345 is a very particular case. Might also be, that this shows a
> > more general shortcoming which should be addressed.
>
> I'm sure there will be other sensors that have similar events.
> How common is hard to say though.
>
> >
> > Equally I could say, there is just a MAG event, so turning on
> > inactivity or free fall would result in the same event. The tricky
> > case then is if someone wants inactivity AND free fall. In such case
> > it would be a inact_or_free_fall event. Not sure about. Probably
> > rather not.
>
> It's just a threshold on falling magnitude of signal. What that means dep=
ends
> on the sensor type and other settings (here the period).  Event codes
> are the same, but without the settings those are pretty meaningless.
>
> >
> > Q: Still, what about the direction - I see, where activity is using
> > IIO_EV_DIR_RISING, inactivity uses _DIR_FALLING. Free fall now uses
> > _DIR_FALLING. I'm a bit unsure if this is just a choice. Could I use
> > _DIR_EITHER here? Or why not? I mean, actually it's not possible to
> > detect fall into one direction, it's simply "in a fall". We cannot
> > tell which axis we cannot tell which direction.
>
> Not about direction in sense of x/y/z, but direction of the signal.
>
> They are definitely triggered when the |X| > thresh transitions
> to |X| < thresh.  So direction is falling as value |X| is getting smaller=
.
>
> The choice reflects the physical thing being measured.
>
> >
> > > > > If you have time to take a look at what userspace is currently do=
ing with
> > > > > these events (iio_sensor_proxy etc) that might help us decide wha=
t works.
> > > > >
> >
> > This might be generally a good option. Honestly, I'd like to mess
> > still with some other sensors,
> > first.
>
> Make sense.

Could the following solve the situation: sharing the same event,
distinguishing by cached information in the driver.

Given, activity/inactivity and free-fall will have all MAG events,
with activity is RISING, inactivity FALLING, and free-fall also
FALLING.
If only activity/inactivity or only free-fall is enabled (or none),
there will be the particular MAG events. If now activity/inactivity
and free-fall are enabled, all will send the same MAG event. That
means some activity/inactivity event will then be shared with
free-fall.

The following ideas now apply only to the case both are enabled:
act/inact and free-fall.

Since the driver's ISR catches the sensor interrupt and evaluates, the
driver has knowledge about the exact type of event. One idea then is,
to keep this cached in the driver. Since activity / inactivity
indicate a state switch (happening rarely), I can distinguish a state
switch from free-fall by keeping activity/inactivity state switch as
cached value(s) in the driver. Here, I can think of keeping the
activity state, or indicate state switch, or the like.

Another idea is not even distinguish (so much). Since practically
free-fall is issued and re-issued quite often, most of the MAG FALLING
events might be free-fall. I can default generally to free-fall if
both is enabled. I'm not sure if activity/inactivity indication may
lead to anything outside, also the free-fall could imply being
interpreted of a sort of inactivity/activity type.

Let me know, what you think.

Best,
L

>
> J
>
> >
> > Best,
> > L
> >
> > > >
> > > > Just as a quick response here (or perhaps just to rule it out)..
> > > >
> > > > Actually, I can spot as MAG-similar event types:
> > > > - IIO_EV_TYPE_MAG
> > > > - IIO_EV_TYPE_MAG_ADAPTIVE
> > > > - IIO_EV_TYPE_CHANGE
> > > > - IIO_EV_TYPE_MAG_REFERENCED
> > > >
> > > > For instance the last one is only used in a single sensor. Is there=
 a
> > > > chance to put, say, freefall into one of the other "MAG-like" senso=
r
> > > > types. Alternatively, what about putting Activity/Inactivity under
> > > > say, "MAG_REFERENCED"? This might seem to be a stupid question, sin=
ce
> > > > I can imagine you have a clear definition of those in mind. But if
> > > > this was possible. It would solve this problem easily.
> > >
> > > The ABI docs do provide some definitions of these.
> > >
> > > Free fall is definitely straight forward TYPE MAG.  It precisely alig=
ns
> > > with that definition as a threshold on the per axis magnitudes.
> > >
> > > MAG_ADAPTIVE is meant for a case where the event is on the magnitude
> > > relative to a slow moving adaptive baseline (usually a low pass filte=
red
> > > version of the signal but can include corrective jumps - IIRC these t=
urn
> > > up for magnetic sensors).  This differs from a rate of change thresho=
ld
> > > because it's not simply a difference between current and earlier sign=
als
> > > but rather current and some heavily filtered earlier signal.
> > > These matter in cases where we have a slow changing baseline such as
> > > coming into proximity with metal in the environment when using a magn=
etometer
> > > for orientation detection.
> > >
> > > MAG_REFERENCED is a weird one.  This was done for a nice IMU that had
> > > the ability to estimate orientation and so remove the acceleration du=
e
> > > to gravity and then apply thresholds to the magnitude of the remainin=
g
> > > accelerations.  The AC filtering on your part is is a 'cheap' way
> > > to achieve roughly the equivalent of that for the activity detection =
at least
> > > where we are removing the 'nothing happening value'.
> > > (it is less clear for the inactivity case though that will still incl=
ude
> > >  g, so maybe it is still somewhat valid).
> > >
> > > CHANGE is IIRC only for counting channels (so far anyway).
> > >
> > > So none of the more esoteric forms of them fit for this DC coupled
> > > inactivity monitor or freefall. Both of them are the same type of eve=
nt
> > > just differing in filters applied.
> > >
> > > >
> > > > If not, then I'll need to think of it and come up with a more
> > > > elaborate approach. The label + index approach seems to be a bit
> > > > complex. Going somehow by the time constraints  in the event.. I ne=
ed
> > > > to play with that in the code to build up an oppinion, I guess.
> > >
> > > The time constraints thing falls down on the basis that it would
> > > be logical to have freefall enabled (for parking any moving parts - t=
hose
> > > used to exist mainly to stop hard disks but maybe there are other use=
 cases?)
> > > and inactivity for power saving with a much longer timescale.
> > >
> > > Freefall used to be fun because the aim was to get moving parts into
> > > a safe state before the device hit the ground.  So that meant if you =
dropped
> > > a device with a harddisk from higher up, it sometimes had a better ch=
ance
> > > of surviving.  I'm not sure if anyone cares any more! Will be interes=
ting
> > > to see if that feature goes away on new devices.
> > >
> > > Jonathan
> > >
> > > >
> > > > Best,
> > > > L
> > > >
> > > > > Jonathan
> > > > >
> > > > > >
> > > > > > Best,
> > > > > > L
> > > > > >
> > > > > > > > +             .dir =3D IIO_EV_DIR_RISING,
> > > > > > > > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > > > > > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALU=
E),
> > > > > > > > +     },
> > > > > > > >       {
> > > > > > > >               /* single tap */
> > > > > > > >               .type =3D IIO_EV_TYPE_GESTURE,
> > > > > > > > @@ -265,6 +290,99 @@ static int adxl345_set_measure_en(stru=
ct adxl345_state *st, bool en)
> > > > > > > >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL=
, val);
> > > > > > > >  }
> > > > > > > >
> > > > > > > Jonathan
> > > > > > >
> > > > > > >
> > > > >
> > >
> >
>

