Return-Path: <linux-iio+bounces-20078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2EAC9BC7
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F82817DDE2
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277D18A959;
	Sat, 31 May 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfZFuyHp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD281448E0;
	Sat, 31 May 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748709281; cv=none; b=Gtd1fA10LZOsaFwkPZEWqeqnjDbPjglML2c+TZ9Q34tfao+r5vAjpfJ3lTpeTftvBdma1/GVMGVCbxQj+cb2tY8UvcVW4PHLzDbGIQmo67165uGi2Q5YJCetS5QFapzZE2VmMkBdOYOTov+hdlyacM80w+IWVhNs/menqNUyUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748709281; c=relaxed/simple;
	bh=LBeZakZJii6oUPSZqeG48dOeeJUonlf7KQZttFKzggE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrs7busEYOolW/0Pc/itoRiE3B0yPlAFfe+9comBYKNaExocByDGAbvCvL5R55waCOC3z9sbfScw/EPxDu40ejUoLpmLZjKnfP8fuOF1zU/Zu7AQzgLC5mGVQ0RCFTQHXo9tngS/tMxgZY2VZkT/ldfRzgdyvpyrfYVv0VpbknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfZFuyHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B7AC4CEE3;
	Sat, 31 May 2025 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748709280;
	bh=LBeZakZJii6oUPSZqeG48dOeeJUonlf7KQZttFKzggE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bfZFuyHpddDVrAtTdyjGqEt9xMdd215skpdu8NjNLoehzJp0Pz4P08QCvD6BrBk3j
	 fO1J8CHUmOdEKXQXXmhmO3xca29NFHOTJABdO2Mo0v/HrwOHGWiSQ+CF3s2UCYRBU6
	 a9qbeZsCJGzPNgh6kcMqH3ZpWzI4vzyCZpoO7l8FrpCd4dboY2Bh/aTZs2WTqbM3nF
	 bhMOYscrqaTSwTHqRok4rW47zYW64HaDDi2/4Vkio9GWtP6mC5J9pf0q4PAwZs/rbl
	 L8BZoPlZjmupCb9PduJu2XTWFJTO0l1BR27eeHakFc/dXVf/WjqYy3Ak7qW2ep/OuK
	 1T15TPzvhP3Ow==
Date: Sat, 31 May 2025 17:34:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/12] iio: accel: adxl313: add activity sensing
Message-ID: <20250531173431.3a5a535d@jic23-huawei>
In-Reply-To: <CAFXKEHb96Kyr_L_Mw3UQxxD=nR8X2bU3TCcgH6OWsqYfaQtE+Q@mail.gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-10-l.rubusch@gmail.com>
	<20250525140351.559be514@jic23-huawei>
	<CAFXKEHb96Kyr_L_Mw3UQxxD=nR8X2bU3TCcgH6OWsqYfaQtE+Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 May 2025 18:22:50 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sun, May 25, 2025 at 3:04=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 23 May 2025 22:35:20 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add possibilities to set a threshold for activity sensing. Extend the
> > > interrupt handler to process activity interrupts. Provide functions t=
o set
> > > the activity threshold and to enable/disable activity sensing. Furthe=
r add
> > > a fake channel for having x, y and z axis anded on the iio channel.
> > >
> > > This is a preparatory patch. Some of the definitions and functions are
> > > supposed to be extended for inactivity later on.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > One comment I found confusing.
> >
> > I see this hardware is similar to our friend the axl345 so some of the =
outcomes
> > of final reviews on that series may apply here as well. =20
>=20
> Yes. To be honest with you, I already saw several places, where I
> probably need to send you some refac for the ADXL345 as well.
> Implementing the same type of source a second time, sometimes leads
> [me] to different[/better?] solutions and brings different insights.
>=20
> > =20
> > > ---
> > >  drivers/iio/accel/adxl313_core.c | 229 +++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 227 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adx=
l313_core.c
> > > index 80991cd9bd79..74bb7cfe8a55 100644
> > > --- a/drivers/iio/accel/adxl313_core.c
> > > +++ b/drivers/iio/accel/adxl313_core.c =20
> > =20
> > >  static const unsigned long adxl313_scan_masks[] =3D {
> > > @@ -300,6 +334,60 @@ static int adxl313_read_freq_avail(struct iio_de=
v *indio_dev,
> > >       }
> > >  }
> > >
> > > +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> > > +                                enum adxl313_activity_type type)
> > > +{
> > > +     unsigned int axis_ctrl;
> > > +     unsigned int regval;
> > > +     int axis_en, int_en, ret;
> > > +
> > > +     ret =3D regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &a=
xis_ctrl);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* Check if axis for activity are enabled */ =20
> >
> > If all 3 axis perhaps?  Or If any axis?  I'm not sure what intent is he=
re. =20
>=20
> For the ADXL313 I do generally all axis, i.e. x-, y-, z-axis - enabled
> and disabled, respectively. I'll modify the comment.
>=20
> Sry about spamming the ML with my emails about the reset function. I
> oversaw your other mail. Patches will be merged.

Lol. I did the same thing just now. Don't worry about it!

J
>=20
> Best,
> L
>=20
> > =20
> > > +     if (type !=3D ADXL313_ACTIVITY)
> > > +             return 0;
> > > +
> > > +     axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > > +
> > > +     /* The axis are enabled, now check if specific interrupt is ena=
bled */
> > > +     ret =3D regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regv=
al);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     int_en =3D adxl313_act_int_reg[type] & regval;
> > > +
> > > +     return axis_en && int_en;
> > > +} =20
> > =20


