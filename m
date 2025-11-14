Return-Path: <linux-iio+bounces-26200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACCC5AF18
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 02:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406093AE09F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 01:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D425FA13;
	Fri, 14 Nov 2025 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCnC48ba"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD322580FB;
	Fri, 14 Nov 2025 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084625; cv=none; b=RhERLxx2jVNMsiADEJlLh7/Ta9t/WhmDWxxCrqvVr7roI3EsgkhlXpnsDtKeS7UqLFwkPrd5AXP+W80232tOhZ0MVeCIkKLa84riqDVtVdoEnqK+17hZ2iT+TNntZfX99+qJN+kyc6ugpbf4TepyjooV92ilFf8RlMYHW6t3NU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084625; c=relaxed/simple;
	bh=kTfllGDlqhvc1A9BtHfcfoTLx7PQTo5DNtFBvhItSq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNeqgX0GlbYrgzBtRBTgUyAzH61SqO+U/MjGqVkO5NynES80j6fO3GwC7cn/os+1F+JBhu59+l8s/ctidLIbl+70GCabDUnOnjVbzSAkIKZotszy+GUZruCaXbqsEkO3/+DGoP79nWygrbY8kYex4UG+8eiLhjYEAqZ5sQgEk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCnC48ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D9C4CEF8;
	Fri, 14 Nov 2025 01:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084625;
	bh=kTfllGDlqhvc1A9BtHfcfoTLx7PQTo5DNtFBvhItSq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCnC48bagvhoEeAKRZtrLNml/fJaKq32T/byHu+o48fyeszmCibTBZkCNRdZ7burb
	 Q9JVt8HeZZxYWEmbGHrmoaK6JzfELIjh99hYP4ppXCJq++TcwUu5PXltO5p7EYXugc
	 /XNFNDqDiVBHOjd/OMwiFz5yeQXXN2jEHXVzvtXGdJ3PMEeK5Oz48HVQbDZr6Ddci0
	 aET62+bRgj7z7NuCSXqUdrt9vuH0AxoH4PNj4F1Jsea+gv2dS6MOj2mjEssj3DKFq/
	 b0vnu3x4ruvkgcqEC1mwfVBRSend+s3QIr8y3IZKwAr6fZU2o7hGEyO07C42i1rs1g
	 9ym8IyEfa9wpA==
Date: Fri, 14 Nov 2025 01:43:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, cosmin.tanislav@analog.com
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: Add AD4134
Message-ID: <20251114-unmasking-nerd-d5c147c43bad@spud>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
 <608ab00821af9f766c75d88f59940fed87cb6df7.1762777931.git.marcelo.schmitt@analog.com>
 <20251110-unsightly-blah-410539e95a18@spud>
 <aRZUCtYzZCY9IQ5U@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NCijVMID48bHqWAR"
Content-Disposition: inline
In-Reply-To: <aRZUCtYzZCY9IQ5U@debian-BULLSEYE-live-builder-AMD64>


--NCijVMID48bHqWAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 06:56:26PM -0300, Marcelo Schmitt wrote:
> On 11/10, Conor Dooley wrote:
> > On Mon, Nov 10, 2025 at 09:45:18AM -0300, Marcelo Schmitt wrote:
> >=20
> > > +  adi,control-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    description:
> > > +      Describes whether the device is wired to an SPI interface or n=
ot. The
> >=20
> > Can you explain how you don't automagically know this from what bus
> > you're on?
>=20
> No. I mean, I should have realized we can imply SPI control mode from the=
 bus node.
> That's one fewer dt property :)
>=20
> >=20
> > > +      PIN/SPI pin on the device must be set accordingly, i.e., PIN/S=
PI must be
> > > +      set to logic high for SPI Control Mode, low for Pin Control Mo=
de. When
> > > +      absent, implies the SPI interface configuration.
> > > +    enum: [ spi-control-mode, pin-control-mode ]
> > > +    default: spi-control-mode
> > > +
> > > +  adi,asrc-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    description:
> > > +      Asynchronous Sample Rate Converter (ASRC) operation mode contr=
ol input.
> > > +      Describes whether the MODE pin is set to a high level (for mas=
ter mode
> > > +      operation) or to a low level (for slave mode operation).
> >=20
> > I don't really get this one. If this is an input to the device that
> > controls behaviour (master v slave) why is an option needed too? Clearly
> > this is not a gpio but it seems like it could be one, in which case you=
'd
> > need some sort of asrc-gpios property. Is it not possible to read the
> > value of this setting out of the device's registers (maybe it's not when
> > there's no spi interface connected?)?
> > It's not used in your driver, so I can't look there easily to see what's
> > going on.
>=20
> The MODE pin defines whether the ODR pin will behave as input or output.
> Currently, there are no plans for supporting ODR as output but, software =
would
> need to do different things to control the output data rate in that case.
> Though, the MODE pin state can indeed be read from a register. Same for D=
CLK pin
> I/O direction and DCLK mode. They are also readable from device's registe=
rs.
> So, that would be 4 fewer dt props total. Well, yeah, if the device is not
> connected to an SPI host (pin control mode) then we can't read those. The=
re are
> no plans for supporting this device outside an SPI bus, but we would then
> need these properties (or a separate binding). Not sure what to do here.=
=20
> Do I drop or keep adi,asrc-mode?

If you need it when not in spi mode, then keep it. For all of those
kinds of things, you probably can use the property to set things in spi
mode and to know they're set that way in !spi mode? In spi mode you
probably still need to be able to change the asrc mode, right? Or does
the device not permit being tristate (n/c I guess), and it has to be tied
low or high, and therefore software must just follow the pin setting?

> The MODE pin is sampled only when the AD4134 is powered on so I don't thi=
nk we
> would benefit from having a GPIO connected to that (if we keep a property=
 to
> describe the MODE pin state).

As in, it gets sampled once at power on, not continuously while powered
on? Technically, you can still do that with gpios, if you have
controllable supplies. Depends on use case I suppose and could be added
as an alternative later on if needed, so I wouldn't worry too much about
it when you're seemingly not even using what you have here in the driver.

Actually it might be worth actually checking for it in your driver, to
make sure that it is not being set to high, since you don't currently
support that?

I hope all that made sense, prob shouldn't be sending mails at 0145,
Conor.

--NCijVMID48bHqWAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRaJSwAKCRB4tDGHoIJi
0pAmAPwImdSG3G8VxyScL/ZMU2cwSIIIdTLJtiQtTF6UlJy8/wD+L81ULtbWBcCx
4JC9BXn0Tv9U4qGieNNc/Q2oaQJfogQ=
=YIcG
-----END PGP SIGNATURE-----

--NCijVMID48bHqWAR--

