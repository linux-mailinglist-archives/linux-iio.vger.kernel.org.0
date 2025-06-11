Return-Path: <linux-iio+bounces-20469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85FAD5CB2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B9166CA8
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC19205519;
	Wed, 11 Jun 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRHNY/eb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F462E610F;
	Wed, 11 Jun 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660745; cv=none; b=HB4XozVvcUOBauSRgWu7x2ZNVOrYoRXjTfXfArKbWWFGzrZzqNv3+Z2EDHGBpDj8oPjDlIwD8AP77nwnGTpR8/PlaXuiE9dRj2Fc6vBiNwGbWWlD76mYdoxvbWW0zeX/ShgMjIoa8hsPUXMXMmTybImZd3sF32nWdpnNSTRxnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660745; c=relaxed/simple;
	bh=bZ7Zp+RHAzcuC/JNEGT+goE+g1TCIlv+thSOowgvvLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek3zhZz31+w+GmxfUY9tr5arh/eIS5SH7WsZknxIYSepQtSv6BqcrrJH+ttpMB/JrDO3oJK7CeC1oFc/HtTpC54227pPrS6UZyoEGPzRbKbf85n4ntUePBYYM3eiA+pmUGr0n2SoeqCIgfO6qhrJ/ddyIMANPNcTkp168GvMsyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRHNY/eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C014C4CEE3;
	Wed, 11 Jun 2025 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660744;
	bh=bZ7Zp+RHAzcuC/JNEGT+goE+g1TCIlv+thSOowgvvLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oRHNY/ebdAaxsrEfuV+Q9nygv8R9p7UtmfltidvSspsL850DtKTM0Tk4wIghE+j5h
	 o0XCZxyWNwQIksft8H+Va2qArgzYf+DeptwhWaz3h8GOgzAoUF7YK0KAY7U+9aD4CI
	 cYpMoZ4kAXQBtaAIvhnszo8W10zCutmY3AYiPTSfwp8oDYyIpwvd7dRgc7a5MDd2hC
	 TDKbsdGmSXWVrCpWFKENYAi8icAYwOQGYzqbwMm0neEjb5KFUMKXy8bDXzg6kfsrQO
	 wLUV5HSm1nGqB0vd79sGnQH0Jw18M6nJvxYECP26PSeu6/QXZrC9IuGX8/S3zJ2OHA
	 06wYqc1og7RPw==
Date: Wed, 11 Jun 2025 17:52:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] iio: accel: adxl313: add inactivity sensing
Message-ID: <20250611175216.602d6a3f@jic23-huawei>
In-Reply-To: <CAFXKEHYP6o5vzsSP24SLUSs+Tu2Oqm=oVf71xy8EKKD5hoCQqg@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-9-l.rubusch@gmail.com>
	<CAHp75Vd=mzfVN_UBUHAkTyj2Ap_tz76AB0LtKEz28pR=WmNzog@mail.gmail.com>
	<CAFXKEHYP6o5vzsSP24SLUSs+Tu2Oqm=oVf71xy8EKKD5hoCQqg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 17:36:49 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Jun 1, 2025 at 9:46=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.=
com> wrote: =20
> > >
> > > Extend the interrupt handler to process interrupts as inactivity even=
ts.
> > > Add functions to set threshold and period registers for inactivity. A=
dd
> > > functions to enable / disable inactivity. Extend the fake iio channel=
 to =20
> >
> > IIO
> > =20
> > > deal with inactivity events on x, y and z combined with AND. =20
> >
> > ...
> > =20
> > > +static int adxl313_set_inact_time_s(struct adxl313_data *data,
> > > +                                   unsigned int val_s)
> > > +{
> > > +       unsigned int max_boundary =3D 255; =20
> >
> > This is unclear how it's defined. What is the limit behind? Size of a
> > bit field? Decimal value from the datasheet?
> >
> > The forms of (BIT(8) - 1) or GENMASK(7, 0) may be better depending on
> > the answers to the above questions.
> > =20
> > > +       unsigned int val =3D min(val_s, max_boundary);
> > > +
> > > +       return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val=
);
> > > +} =20
> >
> > ...
> > =20
> > > -       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > > +       if (type =3D=3D ADXL313_ACTIVITY)
> > > +               axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > > +       else
> > > +               axis_en =3D FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl=
); =20
> >
> > Even with this change my previous comment stays.
> >
> > ...
> > =20
> > > +       en =3D cmd_en && threshold;
> > > +       if (type =3D=3D ADXL313_INACTIVITY) {
> > > +               ret =3D regmap_read(data->regmap, ADXL313_REG_TIME_IN=
ACT, &inact_time_s);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               en =3D en && inact_time_s;
> > > +       } =20
> >
> > ...
> > =20
> > > -       if (info !=3D IIO_EV_INFO_VALUE)
> > > -               return -EINVAL;
> > > -
> > > -       /* Scale factor 15.625 mg/LSB */
> > > -       regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> > > -       switch (dir) {
> > > -       case IIO_EV_DIR_RISING:
> > > -               ret =3D regmap_write(data->regmap,
> > > -                                  adxl313_act_thresh_reg[ADXL313_ACT=
IVITY],
> > > -                                  regval); =20
> >
> > Hmm... This was added by the previous patches, right? Why can't it be
> > done as a switch case to begin with? I remember one of the previous
> > versions had some nested switch-cases, perhaps you need to rethink on
> > how to split the code between functions to avoid too much nesting (add
> > some helper functions?). =20
>=20
> The point here is, as I mentioned in the other mail:
> Initially, I wanted to build up the final switch/case struct i.e.
> going by MAG/MAG_ADAPTIVE, then INFO_VALUE -> RISING / FALLING and
> PERIOD.
>=20
> This will distinguish properties for four different types of events,
> of course it then also will use separate functions. As I uderstood
> your review, why starting with switch/case, do
> if (!MAG event) then, return right away. I implemented that as I
> understood. For further switch/case-ing, I did the same.
> Now, patch by patch, it grows. Thus the if-not-back-out lines will be
> moved out and replaced by switch/case. Worse, with every level switch
> case, all existing code needs indention, thus reading through the
> patches show (too) many changes.
>=20
> How can I improve to help you reviewing this or make the feedback more
> useful for me? Or is my approach wrong? I'd like to start with the
> switch case right away, then just add up what comes in with every
> other patch. If so, you'd only see the changes, since the final
> structure of this is already clear, because very similar to all
> iio/accel drivers at least (as you probably know better than me).
As mentioned earlier, reviewers tend to look at patches in a linear
fashion (and forget them more or less entirely between versions posted!)

So feel free to push back on earlier review comments that say 'you could
simplify this as X' with 'I did this because it becomes more complex in pat=
ch 4
and this reduces churn'.

Maybe here factoring out some elements into helpers will reduce the churn
anyway (to a couple of lines) and that discussion become unnecessary.

J
>=20
> > =20
> > > +       switch (info) {
> > > +       case IIO_EV_INFO_VALUE:
> > > +               /* Scale factor 15.625 mg/LSB */
> > > +               regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 1562=
5);
> > > +               switch (dir) {
> > > +               case IIO_EV_DIR_RISING:
> > > +                       ret =3D regmap_write(data->regmap,
> > > +                                          adxl313_act_thresh_reg[ADX=
L313_ACTIVITY],
> > > +                                          regval);
> > > +                       if (ret)
> > > +                               return ret;
> > > +                       return adxl313_set_measure_en(data, true);
> > > +               case IIO_EV_DIR_FALLING:
> > > +                       ret =3D regmap_write(data->regmap,
> > > +                                          adxl313_act_thresh_reg[ADX=
L313_INACTIVITY],
> > > +                                          regval);
> > > +                       if (ret)
> > > +                               return ret;
> > > +                       return adxl313_set_measure_en(data, true);
> > > +               default:
> > > +                       return -EINVAL;
> > > +               }
> > > +       case IIO_EV_INFO_PERIOD:
> > > +               ret =3D adxl313_set_inact_time_s(data, val);
> > >                 if (ret)
> > >                         return ret;
> > >                 return adxl313_set_measure_en(data, true); =20
> >
> > --
> > With Best Regards,
> > Andy Shevchenko =20
>=20


