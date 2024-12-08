Return-Path: <linux-iio+bounces-13217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1E9E856D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 14:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F99928166A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA3149C7B;
	Sun,  8 Dec 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8tF+63M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4C1E495;
	Sun,  8 Dec 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733664113; cv=none; b=QDmlG7hWdfdGvLjlSrzeLTBBcD7JEXROSHXfF6zQ4saKn9xIW2mZXyEEqeJu/tz7OK+w2W00V2q3GeYwDNMJVOFuTE379pODR2DmtkPWDMaBkXXrfouw/AvOgwuKNrMxrzHutJTbtMOq5ULvrbhWZRtHvGLGfiE1G2Aonl0tcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733664113; c=relaxed/simple;
	bh=PsE4WIqRkNJRyiLiyQXSNO9sz4PMLfBgYnDgwiGph7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMYusvtrkpdDKpjeBtafXw9Kg7JD5ZfJMkSZbg7OhSZU+reNB6OvbMjt6JoNJOKhGJ+ib0uotf+2zKTHtAbnHY7gubc+ViAlN/75R3UMrQOfa+Yl9pmhE19GEkVeDVcosOXznzmBggqQoZ88rRsOAEMcOc3VOcW3qMmNjEmfhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8tF+63M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9963EC4CED2;
	Sun,  8 Dec 2024 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733664112;
	bh=PsE4WIqRkNJRyiLiyQXSNO9sz4PMLfBgYnDgwiGph7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C8tF+63MmMG4sSMXW62ppWHF/56pKOGKxQa2xYg217GR3WZlegqaaFJst7ElgMISU
	 WB4aTZiFJnBIwHdai+C6HO4Wfh4PzCoBpLRM0f6V5S0EXFZwtCz0N47Ejn0mLCjEx3
	 +5uFr2b5MwbrZ7cq5bkm4E5CoLmAv691Ly1ml4iYqA0ELiO1+4TMyUEefup2Tybi/l
	 xxEDOf2qchSdCYkU/X/aL85A1HKoGTx1dAiyDPaEKNRrogvDGeZZ7dNqnMQRFdrF3F
	 HA+L9whe6qQUqlSKu0EulOWu0/OrInb5ssAtZkdCOTCrKcyjv0addl+xdmtUpjQpsX
	 NS8Ih3KhN3osQ==
Date: Sun, 8 Dec 2024 13:21:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
Message-ID: <20241208132147.67efbfa1@jic23-huawei>
In-Reply-To: <CAFXKEHYULs+GO4S4nUzkPC0Sx0KrDur7K3zdFvZn4A3_OEstXw@mail.gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-7-l.rubusch@gmail.com>
	<20241205-fraying-overfull-4fe3eb6c5376@spud>
	<CAFXKEHbGcTGBNH8Hrg3i90_-xR1KYyw_97X1pPMFB6E4ztL5Aw@mail.gmail.com>
	<20241206-settle-impulsive-280ce8dc312f@spud>
	<CAFXKEHb1NbV-Us3kaNyG+P90SMXsV7233dXd64_gbtCKst6gmQ@mail.gmail.com>
	<CAFXKEHYULs+GO4S4nUzkPC0Sx0KrDur7K3zdFvZn4A3_OEstXw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Dec 2024 13:10:22 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Fri, Dec 6, 2024 at 6:29=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > On Fri, Dec 6, 2024 at 6:08=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote: =20
> > >
> > > On Thu, Dec 05, 2024 at 08:41:52PM +0100, Lothar Rubusch wrote: =20
> > > > On Thu, Dec 5, 2024 at 6:54=E2=80=AFPM Conor Dooley <conor@kernel.o=
rg> wrote: =20
> > > > >
> > > > > On Thu, Dec 05, 2024 at 05:13:39PM +0000, Lothar Rubusch wrote: =
=20
> > > > > > Add interrupt-names INT1 and INT2 for the two interrupt lines o=
f the
> > > > > > sensor. Only one line will be connected for incoming events. Th=
e driver
> > > > > > needs to be configured accordingly. If no interrupt line is set=
 up, the
> > > > > > sensor will still measure, but no events are possible.
> > > > > >
> > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7=
 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,ad=
xl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > > > > index 280ed479ef5..67e2c029a6c 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.y=
aml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.y=
aml
> > > > > > @@ -37,6 +37,11 @@ properties:
> > > > > >    interrupts:
> > > > > >      maxItems: 1
> > > > > >
> > > > > > +  interrupt-names:
> > > > > > +    description: Use either INT1 or INT2 for events, or ignore=
 events.
> > > > > > +    items:
> > > > > > +      - enum: [INT1, INT2] =20
> > > > >
> > > > > The description for this ", or ignore events" does not make sense=
. Just
> > > > > drop it, it's clear what happens if you don't provide interrupts.
> > > > >
> > > > > However, interrupts is a required property but interrupt-names is=
 not.
> > > > > Seems rather pointless not making interrupt-names a required prop=
erty
> > > > > (in the binding!) since if you only add interrupts and not
> > > > > interrupt-names you can't even use the interrupt as you do not kn=
ow
> > > > > whether or not it is INT1 or INT2? =20
> > > >
> > > > What I meant is, yes, the sensor needs an interrupt line.
> > > > Interrupt-names is optional. The sensor always can measure. When
> > > > interrupt-names is specified, though, the sensor will setup a FIFO =
and
> > > > can use events, such as data ready, watermark, single tap, freefall,
> > > > etc. Without the interrupt-names, the sensor goes into a "FIFO bypa=
ss
> > > > mode" without its specific events. =20
> > >
> > > What I'm talking about here is how it is ultimately pointless for
> > > interrupts to be a required property if it can never be used without
> > > interrupt-names as you cannot know which interrupt is in use. I think
> > > both should be made mandatory or neither.
> > > =20
> >
> > Ah, now I can see your point. I agree that it should be equally
> > mandatory as the interrupt. Legacy implementations used simply always
> > just INT1. I'd like to make it configurable in the IIO driver but
> > tried to avoid the DT topic for now (which was not a smart decision
> > either). Hence, I added the interrupt-names.
> > I'm unsure should I make "interrupt-names" a required property now?
> > What about the existing DTS files using this sensor? There are no
> > interrupt-names specified, so if made required, the missing
> > interrupt-names there would break binding check, or not?
> > =20
>=20
> Sorry, I have to clarify myself, yesterday I was not focussed..
>=20
> 1. I agree this is kind of half way. Either, both are required or none of=
 them.
> If both were required, also the older DTS files using the ADXL345 would
> need to be "fixed".

Easy. If they aren't both provided, no interrupts are used.
Driver carries on working bug less functionality.  That's fine.

> If I add interrupt-names, it works with my patches for the
> "newer" IIO driver, because since I implement it it's using interrupt-nam=
es.
> The older input driver for that using interrupt, does not use interrupt-n=
ames.
> Hence, it requires the interrupt in the DT. But it does not require
> interrupt-names
> (historical stuff).

We don't care.  The required list should be about requirements for the
hardware to function in a useful fashion, not if the driver currently suppo=
rts
that mode.  So it should never have been required even if the driver at the
time required it because no one had done the work to make it work without.

In theory you could provide a default for interrupt-names I guess if
do want to be nice to the legacy driver.

>=20
> 2. AFAIK the sensor can operate w/o interrupts.
> A) w/o INT line: measuring is possible; FIFO bypassed; no events
> B) w/ INT line: measuring is possible; can use FIFO; events are possible
> When setting the interrupt in DT, the interrupt line name can/could be
> configured also via SW (setting up the registers of the sensor). So, it's=
 not
> impossible. This is AFAIR the approach in the legacy input driver. Now, t=
here
> is devicetree, and both should probably be better configured somewhere in
> the DT

Agreed no interrupts are required for device to do something useful.
(not sure I follow the rest of this entry).
>=20
> 3. IMHO neither one, not the interrupt, nor the interrupt-names need to be
> a required DT-binding.
> If interrupt is required and interrupt-names not, it's a half-way approac=
h,
> which leaves specifying the IRQ line open to be solved partly in DT
> (declaration of the interrupt) and partly in SW (configuration of the
> interrupt line to use), e.g. hardcoded or configurable somewhere in the
> driver via sysfs or the like. Not nice.

Only way I can see to be nice about this is to specify a default.
However, if someone is using the input driver and we have interrupt names
that don't match the default, all bets are off.  That setup doesn't work
today anyway, so do we care? I don't think so.

So in conclusion. Drop the required entry for interrupts, but consider
if a default can work for interrupt-names, or whether we should add
the logic to require interrupt-names if interrupts are provided.

Jonathan

>=20
> Pls, let me know what you think, and in case, if I need to take some
> action, here.
> Best,
> L
>=20
>=20
> > > > Hence, I better drop the description entirely, since it rather seems
> > > > to be confusing. =20


