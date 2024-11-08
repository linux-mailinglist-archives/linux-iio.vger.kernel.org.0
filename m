Return-Path: <linux-iio+bounces-12043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08939C2463
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 18:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1631C20CA0
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF221CFBC;
	Fri,  8 Nov 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQlw8ioA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEA21CFA7;
	Fri,  8 Nov 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088085; cv=none; b=mXDgKHDMjyUqbtb+zw4CAOG9IHw8NkIy2s7F/nCxdHQNadye+kTDVAw9OE2m2UZjdB9m/doY+ENWB2c+nUVBb5bDzOHeVsr7y4smw9FQRrggohZCYUNdUNbb/dTu9IcZ0EhS6YO4rFvE08iFXF0o7JzfRrnqoJG5nxvUgLooZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088085; c=relaxed/simple;
	bh=1aUgru2o3+ohxnEw3ic1aU0QZvsJMvqqwbA9o6Tjhco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzUlMov7IsfhKnGJiBXxG17QDKRpTNe2FYM5FRuHLm/71k8EXGCm/IItxzZxWOWpraMM+FIwh2Vjoj54aeqVgZ81Z5caSsu47ICjPksfBzyxGTe/wMq8yd+09krCaxYYQUznDERrvF2vwnjpVOZjPPWRKvv0mvHXpVcyolXQqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQlw8ioA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B6BC4CECF;
	Fri,  8 Nov 2024 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731088085;
	bh=1aUgru2o3+ohxnEw3ic1aU0QZvsJMvqqwbA9o6Tjhco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQlw8ioAsLCZR6EGz/lj/mKtMcg0xuyBdUiP8Gt2ouPpGWJmc+4eZB3115pN/YO6d
	 JwZErhkqXOhlI2yZfsMLSWPqXNjdOqA3bBruP7vihKmqQs+Mbt+o3thgLahp/nX4Ay
	 sxLjzvtwI2jQDrB2TpRwIuy8tkiOrYJTMuerD+DxJQssWlr87HbaqI1FrsrJi+iP8D
	 CYq2MEpR6qjH+E92NwbJhYcZDcTot/o0Z1Ye1EuZmCBVXmSZPBhOC89D/321DrB/9Q
	 bbBZ3VkC6+KxlUaeUKL6sXdxRUIvuZwrEKap5gUsAUDzM21g0s/q/NwRKIfIcHnvOn
	 vpC98j+VSXRmw==
Date: Fri, 8 Nov 2024 17:47:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: trivial-devices: Add NXP P3T1085UK
 I3C/I2C temperature sensor
Message-ID: <20241108-deuce-skimpily-a1d2149edd64@spud>
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
 <20241107-p3t1085-v1-1-9a76cb85673f@nxp.com>
 <20241108084547.dzmxgdwllwvbiw5n@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7nHnTVEESqYlNb9S"
Content-Disposition: inline
In-Reply-To: <20241108084547.dzmxgdwllwvbiw5n@pengutronix.de>


--7nHnTVEESqYlNb9S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 09:45:47AM +0100, Marco Felsch wrote:
> On 24-11-07, Frank Li wrote:
> > P3T1085UK is a temperature-to-digital converter with a -40 =B0C to +125=
 =B0C
> > range. The device can be communicated by a controller via the 2-wire se=
rial
> > I3C (up to 12.5 MHz) and I2C (up to 3.4 MHz) interface.
> >=20
> > Add it to trivial-devices.yaml because only one 'reg' and 'interrupts'
> > needs.
> >=20
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/D=
ocumentation/devicetree/bindings/trivial-devices.yaml
> > index 6ecd6432b021b..361943b3d73bc 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -301,6 +301,8 @@ properties:
> >            - national,lm92
> >              # Nuvoton Temperature Sensor
> >            - nuvoton,w83773g
> > +            # NXP I2C/I3C Temperature Sensor (-40 =B0C to +125 =B0C)
> > +          - nxp,p3t1085
>=20
> The description of this binding says:
>=20
> "This is a list of trivial I2C and SPI devices ..."
>=20
> but you add a I2C and I3C device.
>=20
> Also I really like to see that you add a "power-supply" property which
> is most the time missing for such simple devices but always required.

Aye, the done thing in iio land is to make the supplies required too.

--7nHnTVEESqYlNb9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZy5OzwAKCRB4tDGHoIJi
0jokAP9Dkn068XT6Vudin7/GU6TzC36mN4490js3el82D0oMagD+PARCNk+APpU1
AkdWfs0ES1SrzM+YIhQFAXt20uDgCwQ=
=3YSF
-----END PGP SIGNATURE-----

--7nHnTVEESqYlNb9S--

