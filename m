Return-Path: <linux-iio+bounces-13167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40A9E76B1
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB471882D22
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020141F63F0;
	Fri,  6 Dec 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxPsnTm8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE27193071;
	Fri,  6 Dec 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504881; cv=none; b=FWeP0qrBFYAWJbXxFob0M0Xnj+ZOT0CgWNcRV3D1Fn5DptqV4KdWVNhyY086452SkyO+EOunZgxtsJ48SLayUpd06WC0PB0DsN///XtXkycBaPhPLN5+s40RigQUIYNi2Wjl2/EOX8UJNKPSUElFnW0CmNN8Y5tUzqt1wQSwxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504881; c=relaxed/simple;
	bh=BJ4R5MF63GQrSkrHJErvy/V9yLpV9nFR0eYVIIdbU2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzbYuXrsdqOtynJ4sOE3OdOIxEPmBQMpIBvYHfk4xGagHLhZNrj60HpOU/aOWI8mYRc7PP/yFyHcv4Le7b6sPzqLbaRqT/pBOzabi6hPGxByh2n5hlyZHKd3hBdUNoSuRi/cI9FH1NgZGawgwxp/kW9yJ048jRCGI9qugrGygBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxPsnTm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215E5C4CED1;
	Fri,  6 Dec 2024 17:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504881;
	bh=BJ4R5MF63GQrSkrHJErvy/V9yLpV9nFR0eYVIIdbU2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxPsnTm8LF1i3d6nY/uykSyio0Xc4OvCtjwkJqUjjX/45VU4uihIQUNGbeKAZoyz2
	 qMU16He31qcwC1dG4SPBnTlwWv0Gpi2VIHRK1UDCwjQCGGgQQA3b9RM1J58FcJ+1jb
	 LCRXPRRBgDTstaxiwYUQwg0O45wTdpR8dMPteZNmVczDwU4pNd1n2uKtYjRWL0JboQ
	 jxvXwvSL0lFwUi6JMfuhEr2axDC45mVOVi3K2jp41ul9NNZaANGtmvH4WCi1WYL6iw
	 qoawNxO3WptpxHredxTjB/TdRcX9cHrH9o8vR2RDOkyRDLjvlc8LMK3mI8aoL0liFp
	 HrEHzQngQrHXQ==
Date: Fri, 6 Dec 2024 17:07:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
Message-ID: <20241206-settle-impulsive-280ce8dc312f@spud>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
 <20241205171343.308963-7-l.rubusch@gmail.com>
 <20241205-fraying-overfull-4fe3eb6c5376@spud>
 <CAFXKEHbGcTGBNH8Hrg3i90_-xR1KYyw_97X1pPMFB6E4ztL5Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="baagkmPE417JmE1E"
Content-Disposition: inline
In-Reply-To: <CAFXKEHbGcTGBNH8Hrg3i90_-xR1KYyw_97X1pPMFB6E4ztL5Aw@mail.gmail.com>


--baagkmPE417JmE1E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 08:41:52PM +0100, Lothar Rubusch wrote:
> On Thu, Dec 5, 2024 at 6:54=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Thu, Dec 05, 2024 at 05:13:39PM +0000, Lothar Rubusch wrote:
> > > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > > sensor. Only one line will be connected for incoming events. The driv=
er
> > > needs to be configured accordingly. If no interrupt line is set up, t=
he
> > > sensor will still measure, but no events are possible.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 +++++=
++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.=
yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > index 280ed479ef5..67e2c029a6c 100644
> > > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > @@ -37,6 +37,11 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > >
> > > +  interrupt-names:
> > > +    description: Use either INT1 or INT2 for events, or ignore event=
s.
> > > +    items:
> > > +      - enum: [INT1, INT2]
> >
> > The description for this ", or ignore events" does not make sense. Just
> > drop it, it's clear what happens if you don't provide interrupts.
> >
> > However, interrupts is a required property but interrupt-names is not.
> > Seems rather pointless not making interrupt-names a required property
> > (in the binding!) since if you only add interrupts and not
> > interrupt-names you can't even use the interrupt as you do not know
> > whether or not it is INT1 or INT2?
>=20
> What I meant is, yes, the sensor needs an interrupt line.
> Interrupt-names is optional. The sensor always can measure. When
> interrupt-names is specified, though, the sensor will setup a FIFO and
> can use events, such as data ready, watermark, single tap, freefall,
> etc. Without the interrupt-names, the sensor goes into a "FIFO bypass
> mode" without its specific events.

What I'm talking about here is how it is ultimately pointless for
interrupts to be a required property if it can never be used without
interrupt-names as you cannot know which interrupt is in use. I think
both should be made mandatory or neither.

> Hence, I better drop the description entirely, since it rather seems
> to be confusing.

--baagkmPE417JmE1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1MvbAAKCRB4tDGHoIJi
0nvPAQCKCfcxZqSyFB8ENeB0ZiIIgGCWkezVWtHBlxuy/3M/mAEAreGK6AakFoFg
NlA1CskzBNYhN7qAz4Y1uwZnMsS9Ygo=
=OMcb
-----END PGP SIGNATURE-----

--baagkmPE417JmE1E--

