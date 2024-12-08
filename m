Return-Path: <linux-iio+bounces-13216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0149E8557
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 14:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08394188439C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E014A4EB;
	Sun,  8 Dec 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2sF9HBS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F780BFF;
	Sun,  8 Dec 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733663692; cv=none; b=BrxTeDsiTC5iYQ3ZoVDJ4s6TauZtXowUZflJRLMkpbQ1Ns9D8D4Eu24OXdgGlgQFXOuwJ3In9m8FFfPXBk8Nt++uYKFOpNWffSp+3uPyhw+gwGScDZ/LcVMxjey7LdXqk+tJ+Sg5whxTzxmBIj6IMr8nabSyhG9Thb2NbRM9lJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733663692; c=relaxed/simple;
	bh=QyUFy65Vch1JoMxvnX2ceiKNS1/udfKefKOYbQGKJbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exJn/7SeScSyEKQhA39/WYp+FlqJbs2XSfoZKkTXZG5pxFnvzJXUACksVYF2xHbjUcpuxJaXp9A/5ZCr06CGYqq3wuIwAZsQqkE8z9WbBJeafWTdDEVIP2sYubNXzxl0wooEfWrTz5s6HYtuf7a37LtuDc0Ywq9f1poLFLkfs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2sF9HBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7443C4CED2;
	Sun,  8 Dec 2024 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733663691;
	bh=QyUFy65Vch1JoMxvnX2ceiKNS1/udfKefKOYbQGKJbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j2sF9HBShsxumBLG1HZmoodRz4+qjhT6WUe2D0qa4nLXatG/qn7GBKCJs2Ay4exOu
	 8Rlb3H0ZPkYK1lioH54pcu/kYyI3VMLK5qjVztO0G396jqQ7eCuUYbAfa64I6IsrQ5
	 krY/rpwWxmnhBqbZC7GkPbOSvOR+wJsLcjWmyQpz5kCLqU40xCvquMzE3I+d7Xuehr
	 xCj/RB9P2FeiQeyf69FVMc8/FL23JrlHFeW2d56u2eHYNlDToZQ7uhIpl7Wk0dR7w4
	 YpKs9a16iJaR1OGEWdReGTLtkarrp7MhgXQiyux4bJim005vNo9scCfg08deBAi15X
	 M41JrmW79ndZg==
Date: Sun, 8 Dec 2024 13:14:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
Message-ID: <20241208131442.29d7d2c0@jic23-huawei>
In-Reply-To: <CAFXKEHb1NbV-Us3kaNyG+P90SMXsV7233dXd64_gbtCKst6gmQ@mail.gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-7-l.rubusch@gmail.com>
	<20241205-fraying-overfull-4fe3eb6c5376@spud>
	<CAFXKEHbGcTGBNH8Hrg3i90_-xR1KYyw_97X1pPMFB6E4ztL5Aw@mail.gmail.com>
	<20241206-settle-impulsive-280ce8dc312f@spud>
	<CAFXKEHb1NbV-Us3kaNyG+P90SMXsV7233dXd64_gbtCKst6gmQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 18:29:48 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Fri, Dec 6, 2024 at 6:08=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Thu, Dec 05, 2024 at 08:41:52PM +0100, Lothar Rubusch wrote: =20
> > > On Thu, Dec 5, 2024 at 6:54=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote: =20
> > > >
> > > > On Thu, Dec 05, 2024 at 05:13:39PM +0000, Lothar Rubusch wrote: =20
> > > > > Add interrupt-names INT1 and INT2 for the two interrupt lines of =
the
> > > > > sensor. Only one line will be connected for incoming events. The =
driver
> > > > > needs to be configured accordingly. If no interrupt line is set u=
p, the
> > > > > sensor will still measure, but no events are possible.
> > > > >
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 +=
++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl=
345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
Side note, but patch name must include what device it is!

dt-bindings: iio: accel: adxl345: ...

> > > > > index 280ed479ef5..67e2c029a6c 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > > > @@ -37,6 +37,11 @@ properties:
> > > > >    interrupts:
> > > > >      maxItems: 1
> > > > >
> > > > > +  interrupt-names:
> > > > > +    description: Use either INT1 or INT2 for events, or ignore e=
vents.
> > > > > +    items:
> > > > > +      - enum: [INT1, INT2] =20
> > > >
> > > > The description for this ", or ignore events" does not make sense. =
Just
> > > > drop it, it's clear what happens if you don't provide interrupts.
> > > >
> > > > However, interrupts is a required property but interrupt-names is n=
ot.
> > > > Seems rather pointless not making interrupt-names a required proper=
ty
> > > > (in the binding!) since if you only add interrupts and not
> > > > interrupt-names you can't even use the interrupt as you do not know
> > > > whether or not it is INT1 or INT2? =20
> > >
> > > What I meant is, yes, the sensor needs an interrupt line.
> > > Interrupt-names is optional. The sensor always can measure. When
> > > interrupt-names is specified, though, the sensor will setup a FIFO and
> > > can use events, such as data ready, watermark, single tap, freefall,
> > > etc. Without the interrupt-names, the sensor goes into a "FIFO bypass
> > > mode" without its specific events. =20
> >
> > What I'm talking about here is how it is ultimately pointless for
> > interrupts to be a required property if it can never be used without
> > interrupt-names as you cannot know which interrupt is in use. I think
> > both should be made mandatory or neither.
> > =20
>=20
> Ah, now I can see your point. I agree that it should be equally
> mandatory as the interrupt. Legacy implementations used simply always
> just INT1. I'd like to make it configurable in the IIO driver but
> tried to avoid the DT topic for now (which was not a smart decision
> either). Hence, I added the interrupt-names.
> I'm unsure should I make "interrupt-names" a required property now?
> What about the existing DTS files using this sensor? There are no
> interrupt-names specified, so if made required, the missing
> interrupt-names there would break binding check, or not?

Neither should be required.  The driver isn't currently using interrupts
and I presume it is functional?  So I'd just drop the required on interrupt=
s.
Now a condition that says interrupt-names is needed if interrupts is suppli=
ed
would be a useful addition (IIRC there are examples of that in tree).

So interrupts being required is a bug that we should fix by just
dropping that. =20

Jonathan



>=20
> > > Hence, I better drop the description entirely, since it rather seems
> > > to be confusing. =20


