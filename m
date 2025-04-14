Return-Path: <linux-iio+bounces-18102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC2A88B74
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF7176155
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033728E5F7;
	Mon, 14 Apr 2025 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNVomyoh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44A28BA9B;
	Mon, 14 Apr 2025 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655662; cv=none; b=IbQO8emfB+SLLB+o7YzNQqaNCVpU/C0nIVfdT+feUvtQHf5wRc+Z37IP9ZfyRQZ8dC3uZkroWsG3NETg18vz2PGghSbFZxrT8EgbiCtCvBe0LZaMbbtPwBRlBJORnP35TEvo+UVVxfx6I4L9kAKGmH88r+g0HRrRaUl0ndqKAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655662; c=relaxed/simple;
	bh=kbfxJkK2rgB4pt5FmbCLbUjzGPsUj25XGObFLO5oUJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAvQ2clJCScl7oqSGKayvL3CC+4EkF95Va4ve+p9abibMV/aZbpXHLwDdurklojP3AxARHMomA/ikjMw2DQbhabJCWQC5Sckb97rga61Tw5QbOhQXzs9m364gum67v49guHM3ZQW9i1A3Kg/t2ChnyU4e3mj1sHcmeBAuT99gyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNVomyoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E42C4CEE2;
	Mon, 14 Apr 2025 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744655661;
	bh=kbfxJkK2rgB4pt5FmbCLbUjzGPsUj25XGObFLO5oUJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gNVomyohQtRHaJaACQJaHblKiCfBzZvC9XrSc4e2HuAa+2qJVEfulA0wbfBikHrIr
	 5mgvkw+0BoJMg8821VCRmd49UCpzgPLSpSfiKckyxZmZp9DHntTXiJA0GSWQlHx8Hh
	 IJ3ZyUrph8FpEQvyQjKOAvPt7zMTHeBaZJhugqxbJ6ExzspARwiyKfPvdNlsa2m8g+
	 r3OFJts+mBIcxHhWVzo9bvGPPw30YOBBzf1SAkhVrkAqU4XxNmI6pC9TmceDQWIaxf
	 3XM5m/AQdD+A5My26LwWtQzFRb6e3Rfj0JbaH7qybTZ3HGeCU8P4oIigFmXhnHAsxI
	 4HPKGtZleBoBw==
Date: Mon, 14 Apr 2025 19:34:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 09/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250414193414.02d0ee0b@jic23-huawei>
In-Reply-To: <CAFXKEHYXnN9ddSM3wzgRTCZDu3JiaBJ6n8htQEBCiS52G+QzQQ@mail.gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-10-l.rubusch@gmail.com>
	<20250331114724.2c2c2e9b@jic23-huawei>
	<CAFXKEHYXnN9ddSM3wzgRTCZDu3JiaBJ6n8htQEBCiS52G+QzQQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 15:19:52 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Mon, Mar 31, 2025 at 12:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Tue, 18 Mar 2025 23:08:41 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the inactivity feature of the sensor. When activity and inactivity
> > > are enabled, a link bit will be set linking activity and inactivity
> > > handling. Additionally, the auto-sleep mode will be enabled. Due to t=
he
> > > link bit the sensor is going to auto-sleep when inactivity was
> > > detected.
> > >
> > > Inactivity detection needs a threshold to be configured, and a time
> > > after which it will go into inactivity state if measurements under
> > > threshold.
> > >
> > > When a ODR is configured this time for inactivity is adjusted with a
> > > corresponding reasonable default value, in order to have higher
> > > frequencies and lower inactivity times, and lower sample frequency but
> > > give more time until inactivity. Both with reasonable upper and lower
> > > boundaries, since many of the sensor's features (e.g. auto-sleep) will
> > > need to operate beween 12.5 Hz and 400 Hz. This is a default setting
> > > when actively changing sample frequency, explicitly setting the time
> > > until inactivity will overwrite the default.
> > >
> > > Similarly, setting the g-range will provide a default value for the
> > > activity and inactivity thresholds. Both are implicit defaults, but
> > > equally can be overwritten to be explicitly configured.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> >
> > A few comments inline.  The magic handling of the value 0 is
> > a bit of unexpected ABI.
> >
> > Jonathan
> > =20
> > > @@ -327,6 +358,7 @@ static int adxl345_set_act_inact_en(struct adxl34=
5_state *st,
> > >                                   bool cmd_en)
> > >  {
> > >       bool axis_en, en;
> > > +     unsigned int inact_time_s;
> > >       unsigned int threshold;
> > >       u32 axis_ctrl =3D 0;
> > >       int ret;
> > > @@ -345,6 +377,20 @@ static int adxl345_set_act_inact_en(struct adxl3=
45_state *st,
> > >               default:
> > >                       return -EINVAL;
> > >               }
> > > +     } else {
> > > +             switch (axis) {
> > > +             case IIO_MOD_X:
> > > +                     axis_ctrl =3D ADXL345_INACT_X_EN;
> > > +                     break;
> > > +             case IIO_MOD_Y:
> > > +                     axis_ctrl =3D ADXL345_INACT_Y_EN;
> > > +                     break;
> > > +             case IIO_MOD_Z:
> > > +                     axis_ctrl =3D ADXL345_INACT_Z_EN;
> > > +                     break;
> > > +             default:
> > > +                     return -EINVAL;
> > > +             }
> > >       }
> > >
> > >       if (cmd_en)
> > > @@ -365,11 +411,67 @@ static int adxl345_set_act_inact_en(struct adxl=
345_state *st,
> > >       if (type =3D=3D ADXL345_ACTIVITY) {
> > >               axis_en =3D FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ct=
rl) > 0;
> > >               en =3D axis_en && threshold > 0;
> > > +     } else { =20
> >
> > So previous suggestion on setting en doesn't work but you can still com=
bine
> > the bits other than the type match to simplify code and get rid of axis=
_en
> > in both paths.
> > =20
> > > +             ret =3D regmap_read(st->regmap, ADXL345_REG_TIME_INACT,=
 &inact_time_s);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             axis_en =3D FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_=
ctrl) > 0;
> > > +             en =3D axis_en && threshold > 0 && inact_time_s > 0;
> > >       } =20
> > =20
> > > +/**
> > > + * adxl345_set_inact_time_s - Configure inactivity time explicitly o=
r by ODR.
> > > + * @st: The sensor state instance.
> > > + * @val_s: A desired time value, between 0 and 255.
> > > + *
> > > + * If val_s is 0, a default inactivity time will be computed. It sho=
uld take
> > > + * power consumption into consideration. Thus it shall be shorter fo=
r higher
> > > + * frequencies and longer for lower frequencies. Hence, frequencies =
above 255 Hz
> > > + * shall default to 10 s and frequencies below 10 Hz shall result in=
 255 s to
> > > + * detect inactivity. =20
> >
> > I'd missed this previously.  I've no problem with a default time being =
set
> > on driver load, but a later write of 0 should not result in something v=
ery different
> > as that's not standard use of the ABI.  If a user wants to go back to a=
 sensible
> > default then they should have stored out what was set initially.
> >
> > I don't mind if you update the default until the point where they first=
 override
> > it, but from there on we should obey what they request or error out if =
the
> > value requested is not possible.
> > =20
>=20
> Hm, I'm unsure if I got this wrong. It is not supposed to be an
> automatic feature to kick in and change user configured values,
> actually. Let me try to explain it differently:
> Setting a threshold for an inactivity time in [s] is always applied as
> a user wishes. Setting 0s for inactivity time IMHO does not make much
> sense, where one could also simply disable the sensor event. So, what
> I did now is I implemented when 0s was set by a user for inactivity
> time, it will result in an automatic adjustment of inactivity time,
> depending on range and odr.

This is still a bit unexpected so ABI that is unlikely to be in general
useful.  If userspace can figure out this automatic value I'd rather we
just reject 0 as -EINVAL and let userspace code decide on a better value
given that 'hint'

>=20
> In v6 I will try to refrase the text, and double-check it's contained
> in documentation, too. Pls, let me know what you think.
>=20



