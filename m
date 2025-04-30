Return-Path: <linux-iio+bounces-18920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92436AA5869
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 00:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BD05055AE
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 22:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD02288C6;
	Wed, 30 Apr 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShFxNywz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2D227EB6;
	Wed, 30 Apr 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053653; cv=none; b=gGn9IZVV7HPPVF86AmG+8LQJsnnOlfkSHpeChU37GgwV2HhFjF8mM5vlWekaw5CYZbET9QdFpM7eQ8TjZ8qPDJZeQR5bqWeMyZclXVhygz7lJ5qd3Zksd/uUohSyfnnzMRWrSZAECI7qa0oEWcsE1nVMa2bmTUoDmBWqBakwCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053653; c=relaxed/simple;
	bh=btJoBqs2JxZXwt6XXUJQK4EDLWHYw59GYHg2ZgejWtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXKI1x6csugR2pQWKxmYNe7U8pnzn3SRguQzZbOdIdxGWBnuqmlS6GJRIf2vEpE7Lg9+YYJsLOsCbz/3vEVtKcDiU1bH+2nJIMIbjwY+zHa+SZdRpnsY4GenwBYldgBl2Ms5h8FdAiHf1wcrCnjMs0iyGuWuoEfdw72Ao0osdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShFxNywz; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7316c56e6eso40712276.3;
        Wed, 30 Apr 2025 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746053650; x=1746658450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGlvSY4xy7vtr+5vm5soRE85P3d2Vcbw2tqiq00apYg=;
        b=ShFxNywzgtI/XwI+aKSzl3Nfxs1JD+XrJaz0sNLddI1UmQFXQ0hhguCOuprADLrAkI
         wtylkJ34gaSwIKX+4ptmQUWol7R/kJnKohG1rdG4gFuC/Wc0TvpzMx1hdAEhgjCtbr3C
         7vC13jL31BY26n1AJn0f3E9JsK0oadPrDuRYkCBwQxTg7LbzzGQ6srlWnIQqTfl25wB+
         QBsFuAjcrM0VaULtDIqOzp9RriAWQLzb2SiXIRUXAZ9JWhH7fIbBfiIJGp7uGRYCAJ4x
         iAHP/p6Hc0TCL6f0faIVFEw26SlBA8S6auijx08ol+vU+AcDNFxWf0wG+l6JMKiEjm1J
         MEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746053650; x=1746658450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGlvSY4xy7vtr+5vm5soRE85P3d2Vcbw2tqiq00apYg=;
        b=OF1rUXnl+Vm+C29hnAj74F2lVdLm/YmW1c/1oLwJXsvkp+0gx972kqKpLv+eo3rzyc
         ueFuA0bw8iCrDyXXmybkxuwR/SoLSDhZjENxP+GaulQf7aMTP3wrpLX1U+dOFL/MGsEX
         yTNbNymLhnmH3BgOShXrfS0DOwo+Ub6QugLjxOnwB352Q7+y+1vawYYMEV/qyalh+RQo
         frL7Yj38dGLO5of8+nO0zjRrtf73KJ06uBTiJ/iYwvU8QTwdic8UNVhMaadbb0k51O3Y
         Kjr99jr55m5N/JM0fDhDtbvhlNvD7DyXtC6Y2ws0j4KGNMdz+c38p4gTMMWTg2m0nL6F
         9j6g==
X-Forwarded-Encrypted: i=1; AJvYcCUk7Sp5+eKEFd/NZMe6R+WtzBnTu7HRq5o8PqJo36cn4XfGVY/ITCGKYIjMSROvN36W6SFCVOOxJSZEpfN8@vger.kernel.org, AJvYcCXHmRM4/9PGED8rqBdGfQeKGHiSXoHqhLUCf+BxidmlE4TtgW4MTtxt/x1vkkJltcvjzm2TXsffmws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDynmC1i53t1o0fG3SkemW8FRJu6Ce+/pYaMcu2NvMGRpJsEt
	Aiow86hiOagy4gEmLqbV/aLYVLjyzSuXloUCsE6WFKhMSX0XzTuB11ZP2lArkpZJt+oXyZFtZDm
	cn9A0b+MGwjO9FGb26fZncI4cJvg=
X-Gm-Gg: ASbGncvc4tT8lDHtINsG2kS87mtfSlzOodXDfGzcoK6LV85CKzNgE0ENMPJ+NO3y6Jn
	Su6dm8U3dehTlOpopFEwz4ilj4OCARikAYoQdWbHiEqlzMbJptjXNI1jJfZCKwMaYPeJTXGZs/I
	LwD2oEBWmk0bWjWM7W1dt3vQ==
X-Google-Smtp-Source: AGHT+IHCQ8IGykZJqIoWOiBIU7is9iADQhGwmCUDKAwS1PflcAhilxD9+MR4ntbT9de8cQFXfxjU6rUILNZinxkANsw=
X-Received: by 2002:a05:690c:fd5:b0:708:2e5c:3012 with SMTP id
 00721157ae682-708af020514mr27455797b3.6.1746053650458; Wed, 30 Apr 2025
 15:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421220641.105567-1-l.rubusch@gmail.com> <20250421220641.105567-9-l.rubusch@gmail.com>
 <20250427134759.3cc3a2a4@jic23-huawei>
In-Reply-To: <20250427134759.3cc3a2a4@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 1 May 2025 00:53:32 +0200
X-Gm-Features: ATxdqUGPnTNGtsek4p7bFeMDWJY6zGGPahGsNOLU9VNtCLKT1muOgUxZIZ12wDY
Message-ID: <CAFXKEHZ3KQ_Z4QB==Bb_CTauV7Wowd0Lgxaick=6mfiLJU654Q@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] iio: accel: adxl345: add activity event feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan - Hi IIO list,

Please, find some (many) questions inlined down below. Appologies for
the separate
channels last time and not right away fixing them up as array. I did
not want to make extra work.

On Sun, Apr 27, 2025 at 2:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 21 Apr 2025 22:06:38 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Make the sensor detect and issue interrupts at activity. Activity
> > events are configured by a threshold stored in regmap cache. Initialize
> > the activity threshold register to a reasonable default value in probe.
> > The value is taken from the older ADXL345 input driver, to provide a
> > similar behavior. Reset the activity/inactivity direction enabling
> > register in probe. Reset and initialization shall bring the sensor in a
> > defined initial state to prevent dangling settings when warm restarting
> > the sensor.
> >
> > Activity, ODR configuration together with the range setting prepare the
> > activity/inactivity hystersesis setup, implemented in a follow up patch=
.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 217 ++++++++++++++++++++++++++++++-
> >  1 file changed, 214 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 80b5b8402ced..680981609d83 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -36,11 +36,16 @@
> >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > +#define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> >
> >  #define ADXL345_TAP_Z_EN             BIT(0)
> >  #define ADXL345_TAP_Y_EN             BIT(1)
> >  #define ADXL345_TAP_X_EN             BIT(2)
> >
> > +#define ADXL345_ACT_Z_EN             BIT(4)
> > +#define ADXL345_ACT_Y_EN             BIT(5)
> > +#define ADXL345_ACT_X_EN             BIT(6)
> > +
> >  /* single/double tap */
> >  enum adxl345_tap_type {
> >       ADXL345_SINGLE_TAP,
> > @@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_time_reg[] =3D=
 {
> >       [ADXL345_TAP_TIME_DUR] =3D ADXL345_REG_DUR,
> >  };
> >
> > +/* activity/inactivity */
> > +enum adxl345_activity_type {
> > +     ADXL345_ACTIVITY,
> > +};
> > +
> > +static const unsigned int adxl345_act_int_reg[] =3D {
> > +     [ADXL345_ACTIVITY] =3D ADXL345_INT_ACTIVITY,
> > +};
> > +
> > +static const unsigned int adxl345_act_thresh_reg[] =3D {
> > +     [ADXL345_ACTIVITY] =3D ADXL345_REG_THRESH_ACT,
> > +};
> > +
> >  enum adxl345_odr {
> >       ADXL345_ODR_0P10HZ =3D 0,
> >       ADXL345_ODR_0P20HZ,
> > @@ -154,6 +172,13 @@ struct adxl345_state {
> >  };
> >
> >  static struct iio_event_spec adxl345_events[] =3D {
> > +     {
> > +             /* activity */
> > +             .type =3D IIO_EV_TYPE_THRESH,
>
> Is this a threshold, or a magnitude? I'd expect an activity detector
> to be magnitude as it doesn't care which way up the sensor is.
>

This is touching the main points still unclear to me. I tried to put
this into the
following questions. Could you please clarify?

1. Given a measurement "val", and a configured threshold "thr".
A "rising" for IIO_EV_TYPE_THRESH means: val > thr
where a "rising" for IIO_EV_TYPE_MAG means something like: val > |thr|

Q: Do I understand this correctly now?

Q: Is this documented somewhere (especially for reviewing further
EV_TYPE fields)?

Q: I wonder if I missed this for the Tap events. Going by this
definition, then actually the
tap events should be rather MAG events, too. Right?


2. I oriented myself mostly by reading other drivers, for instance the
ADXL367, the ADXL372, or also the more recent ADXL380. I am aware that
there might be differences among different
(Analog) sensors. But all those sensors specify Inactivity (and Activity) a=
s a
IIO_EV_TYPE_THRESH with directions IIO_MOD_X_OR_Y_OR_Z.
Given the above, I implemented Activity and Inactivity events as
IIO_EV_TYPE_THRESH,
now I'm a bit confused.

Q: Why is this different for the ADXL345?

Q: If I implement Activity / Inactivity analogous to the e.g. a
ADXL380, then shouldn't it be IIO_EV_TYPE_THRESH with
IIO_MOD_X_OR_Y_OR_Z? Why not?


3. For the ADXL345, a Freefall signal is on all axis lower than
threshold (magnitude). Thus I push a IIO_MOD_X_AND_Y_AND_Z to a
separate
fake channel. Inactivity will be like Freefall independent of the axis.
The ADXL345 Activity can be configured by axis, as also the event will
respect the axis information.

Q: Setting up the "fake channel" to particuarly push to
IIO_MOD_X_AND_Y_AND_Z, I probably better should also evaluate
IIO_MOD_X_AND_Y_AND_Z in write_event_config(), write_event_value(),
etc. rather than evaluating IIO_MOD_-types as I'm currently
doing?

Q: Activity probably remains in the regular channels for the corresponding =
axis?


4. I implemented functions like adxl345_write_event_config(),
adxl345_write_event_value() or corresponding
readers, as follows
- THRESH/rising: Activity
- THRESH/falling: Inactivity
- MAG/falling: Freefall

If I change Activity and Inactivity to be both of type MAG, I will end
up with MAG/falling to indicate Freefall or equally Inactivity.
Both on the IIO_MOD_X_AND_Y_AND_Z channel. I admit (ab)using the
IIO_EV_TYPEs to solve my combinatorial issues for event configuration
is probably not as supposed to be.
Given you still ask me to do Inactivity and Freefall as MAG/falling
with IIO_MOD_X_AND_Y_AND_Z. The difference between both IMHO,
is that Activity and Inactivity for the ADXL345 indicate sensor state
changes, where Freefall indicates the particular event. The
sensor is either in "active" or "standby/inactive", where Freefall
just triggers and then retriggers and retriggers...

Q: What is the method to distinguish several similar IIO events, e.g.
to tag them somehow one as Freefall, the other one as Inactivity?

Best,
L

> > +             .dir =3D IIO_EV_DIR_RISING,
> > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE),
> > +     },
> >       {
> >               /* single tap */
> >               .type =3D IIO_EV_TYPE_GESTURE,
> > @@ -265,6 +290,99 @@ static int adxl345_set_measure_en(struct adxl345_s=
tate *st, bool en)
> >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> >  }
> >
> Jonathan
>
>

