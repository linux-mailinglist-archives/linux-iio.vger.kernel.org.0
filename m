Return-Path: <linux-iio+bounces-16869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5503FA63130
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0081747CE
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDE204085;
	Sat, 15 Mar 2025 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAzKfViX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48E18EFD4;
	Sat, 15 Mar 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061632; cv=none; b=HZu0FbWi4+H9WBWJiA9Qo7/4vYVn0PPjtFr9iwGrId/z/I++4WTc+tu8u6VE5ItE4pYFxHoPIeZRo12azfDNXArw2LLWQkwOF0dJfKPw8+XJca9XwiT3BtF/u7cnP5iqHFMVj7EP/8Bv70EHPkEPqAfnYtCnSnm0XxhDvER5/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061632; c=relaxed/simple;
	bh=H4Yv5J6hJp30ADoy8oRhvkcQAAWsSyg+yNsIit/vcJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjnSO71r81xNmnoA7eC+kV+OAOwM0AKb5CfacDR5tpCoD1b0/Mku3WPKGoUghe9jCskm9SOFjLXVd+UPg/4/FZtk/3cf/YXVMte4bkEPKu5lQBOc0C/NoxFK/CTjrUTVjB5pswp4WJkgf7R9b8rrYcPEST9uK1CM9QOA5xFEYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAzKfViX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2990C4CEE9;
	Sat, 15 Mar 2025 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742061631;
	bh=H4Yv5J6hJp30ADoy8oRhvkcQAAWsSyg+yNsIit/vcJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TAzKfViXjCrB3JRvRLOwHEI88fkqynuHWKVcQTkL3rAe3robTYzHQW3ptp8rEUkgS
	 wnjm8GtRudFwvFBamOmZcLCzruuLHjRRUmQE8qzP0VL5yknPDLXq8yyt1qDDOetBRX
	 8oORgOVKEc/8w/Qfmfcrdm7j6Lx2bWtUJc2jOrpSJvJJAiLTTre6uokov5X85rLD+P
	 JafNRPv8oEWbJqP+g6dkkBfH19S5GFnzywIaFVtpWFjZ974xsZL+VbzK1hHLzBOoiP
	 31yXh3RYnL5r29ivGxZaFt91OvkAGvFQ0NzlpI119C2UlE1IHbhCbfKd+umdyZ7bKZ
	 zZqwIryaYoktQ==
Date: Sat, 15 Mar 2025 18:00:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 12/15] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250315180023.3a0f0113@jic23-huawei>
In-Reply-To: <CAFXKEHZF4bW=rvbJDkrs04XtGo5rV3Y4HR0fBgOR_03ZTpc-Cg@mail.gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-13-l.rubusch@gmail.com>
	<20250304134918.797e6386@jic23-huawei>
	<CAFXKEHZF4bW=rvbJDkrs04XtGo5rV3Y4HR0fBgOR_03ZTpc-Cg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 11:55:05 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
>=20
> I'm currently about to update the series and like to answer some of
> your review comments directly when submitting. Nevertheless, here I'll
> anticipate this one. Pls, find my questions inlined down below.
>=20
> On Tue, Mar 4, 2025 at 2:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Thu, 20 Feb 2025 10:42:31 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Make the sensor detect and issue interrupts at activity. Activity
> > > events are configured by a threshold stored in regmap cache.
> > >
> > > Activity, together with ODR and range setting are preparing a setup
> > > together with inactivity coming in a follow up patch.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Some questions / comments inline.
> >
> > This review is has been at random moments whilst travelling (hence
> > over several days!) so it may be less than thorough or consistent!
> > I should be back to normal sometime next week.
> > =20
>=20
> No problem, no hurry!
>=20
> > > @@ -258,6 +284,73 @@ static int adxl345_set_measure_en(struct adxl345=
_state *st, bool en)
> > >       return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> > >  }
> > >
> > > +/* act/inact */
> > > +
> > > +static int adxl345_write_act_axis(struct adxl345_state *st,
> > > +                               enum adxl345_activity_type type, bool=
 en)
> > > +{
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * The ADXL345 allows for individually enabling/disabling axis =
for
> > > +      * activity and inactivity detection, respectively. Here both a=
xis are
> > > +      * kept in sync, i.e. an axis will be generally enabled or disa=
bled for
> > > +      * both equally, activity and inactivity detection. =20
> >
> > Why?  Can definitely see people only being interested in one case
> > and not the other.  What advantage is there in always having both
> > or neither over separate controls? =20
>=20
> Ugh! This happens when I mix writing code and writing English texts,
> w/o re-reading it.
>=20
> Situation: The sensor allows to individually enable / disable x,y and
> z axis for r activity and for inactivity. I don't offer this in the
> driver. When activity is selected, I always enable all three axis or
> disable them. Similar, for inactivity.

Ah. All axis together, not always both inactivty and activity.

> The question is then actually,
> if this is legitimate, or should I really implement enabling/disabling
> of each axis individually for activity and similar then for
> inactivity? I mean, when not interested in one or the other axis,
> someone can fiilter the result.

For some sensors there is no way to distinguish which threshold was hit
(they just provide 1 bit for activity in the status register)
Here it seems we get a single bit that indicates first act or inact
triggering axis (in ACT_TAP_STATUS).  Assuming I read that
text correcty only one bit is set. That's not exactly useful as
it doesn't tell use other axis would have triggered it.

So I think here your approach of all axis enable is perhaps the
right approach. Also report it as an X_OR_Y_OR_Z event and ignore
the indication of which axis perhaps?

> On the other side I can imagine a
> small impact in power consumption, when only one axis is used instead
> of three axis (?). Since the ADXL345 is [was] one of Analog's fancy
> acme-ultra-low-power-sensors, power is definitvely a topic here IMHO.
> I can't really estimate the importance.

I doubt it would make a measurable difference to power usage.

>=20
> I guess I'll try to implement it and see how ugly it gets. At least
> it's a good exercise. As also, I'll try to bring regmap cache and
> clear_bits / set_bits more in here for activity and inactivity in the
> next version.
>=20

> > > @@ -842,6 +972,23 @@ static int adxl345_write_event_value(struct iio_=
dev *indio_dev,
> > >               return ret;
> > >
> > >       switch (type) {
> > > +     case IIO_EV_TYPE_THRESH:
> > > +             switch (info) {
> > > +             case IIO_EV_INFO_VALUE:
> > > +                     switch (dir) {
> > > +                     case IIO_EV_DIR_RISING:
> > > +                             ret =3D regmap_write(st->regmap,
> > > +                                                adxl345_act_thresh_r=
eg[ADXL345_ACTIVITY],
> > > +                                                val);
> > > +                             break; =20
> > This collection of breaks and nested functions suggests maybe we can ei=
ther
> > return directly (I've lost track of what happens after this) or that
> > we should factor out some of this code to allow direct returns in the
> > function we put that code in.  Chasing the breaks is not great if it
> > doesn't lead to anything interesting. =20
>=20
> I understand, but since I'm using quite a bit configuration for the
> sensor, I'm taking advantage
> of type, info and dir here. It won't get more complex than that. I'm
> [actually] pretty sure, since this
> then is almost feature complete.
>=20
> I don't see a different way how to do it. I mean, I could still
> separate handling the "dir" entirely in
> a called function. Or, say, implement IIO_EV_TYPE_THRESH handling in a
> separate function?
> Pls, let me know what you think.

Maybe factor everything out between the set_measure_en and it's counterpart.
Then you can just return in all paths in the factored out function.
That's nice because anyone reading it doesn't have to chase down to
see what else happens.

It might make sense to break it up further but probably not.
>=20
> > > +                     default:
> > > +                             ret =3D -EINVAL;
> > > +                     }
> > > +                     break;
> > > +             default:
> > > +                     ret =3D -EINVAL;
> > > +             }
> > > +             break;
> > >       case IIO_EV_TYPE_GESTURE:
> > >               switch (info) {
> > >               case IIO_EV_INFO_VALUE:
> > > @@ -1124,6 +1271,17 @@ static int adxl345_push_event(struct iio_dev *=
indio_dev, int int_stat,
> > >                       return ret;
> > >       }
> > >
> > > +     if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
> > > +             ret =3D iio_push_event(indio_dev,
> > > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > +                                                     act_tap_dir,
> > > +                                                     IIO_EV_TYPE_THR=
ESH,
> > > +                                                     IIO_EV_DIR_RISI=
NG),
> > > +                                  ts);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > >       if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> > >               ret =3D iio_push_event(indio_dev,
> > >                                    IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > @@ -1157,6 +1315,7 @@ static irqreturn_t adxl345_irq_handler(int irq,=
 void *p)
> > >               ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STA=
TUS, &regval);
> > >               if (ret)
> > >                       return ret;
> > > +             /* tap direction */ =20
> >
> > Belongs in earlier patch?
> > =20
> > >               if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
> > >                       act_tap_dir =3D IIO_MOD_Z;
> > >               else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
> > > @@ -1165,6 +1324,19 @@ static irqreturn_t adxl345_irq_handler(int irq=
, void *p)
> > >                       act_tap_dir =3D IIO_MOD_X;
> > >       }
> > >
> > > +     if (FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0)=
 {
> > > +             ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STA=
TUS, &regval);
> > > +             if (ret)
> > > +                     return ret;
> > > +             /* activity direction */
> > > +             if (FIELD_GET(ADXL345_Z_EN, regval >> 4) > 0) =20
> >
> > I'm not following the shifts here.   That looks like we don't have
> > defines that we should but instead use the ones for the lower fields. =
=20
>=20
> The 8-bit register is split as follows:
>=20
> | 7                |  6         |  5          |  4         |  3
>           |  2              |  1             |  0             |
> -------------------------------------------------------------------------=
---------------------------------------------
> | ACT ac/dc | ACT_X | ACT_Y | ACT_Z | INACT ac/dc | INACT_X | INACT_Y
> | INACT_Z |
>=20
> I thought here, either I shift the ACT_* directions by 4 then use the
> general mask for axis (lower 4 bits). Or I introduce an axis enum for
> ACT_* and a separate one for INACT_*. Thus, I kept the shift and use
> the same ADXL345_*_EN mask. How can I improve this, or can this stay?
I'd not use enums here at all unless you actually use the enum
type directly somewhere to enforce allowed values.

Separate defines for inact and act make sense though.  Saves the reader
of this bit of the code having to care about the layout of the fields,

Jonathan


>=20
> > =20
> > > +                     act_tap_dir =3D IIO_MOD_Z;
> > > +             else if (FIELD_GET(ADXL345_Y_EN, regval >> 4) > 0)
> > > +                     act_tap_dir =3D IIO_MOD_Y;
> > > +             else if (FIELD_GET(ADXL345_X_EN, regval >> 4) > 0)
> > > +                     act_tap_dir =3D IIO_MOD_X;
> > > +     } =20
> >
> > =20
>=20
> Best,
> L


