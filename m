Return-Path: <linux-iio+bounces-24385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E5AB97C78
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 01:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDDE1AE190F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3EB3112BF;
	Tue, 23 Sep 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hghqotyn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46730FF3A;
	Tue, 23 Sep 2025 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668833; cv=none; b=cnXV+tCFbk1eVYrnlaXr6puiv6KtxJI7lVawE0WW2H4HmcJpAqaqnOze2fHqj6YIdtygLxOqZLJgXzSMZnJ7UCOsN5oaKqr3TOY78p4CL13e+dYSvlocR66Daza5I7EE0wE4DSSJTvhb3iV1d8vFOWr/jcxkcaT4CCYC/wZBfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668833; c=relaxed/simple;
	bh=myebbJEIelj6OaJbcBR6uxOg/2sE9Y7fBusonNz4fbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlaiyhNG0xMrZMtnr26qk5vGz9myy91JwLZH5aNFornpWtoXanMDPfNkxwTrm1pff0uxYnWVm/+1605RCrusyqfGeFeB6BbzC3j7XXjO1MFaW87+XG4JrRLIUbwLEHS4umY8iYwX9Qz/rATvDJJb39IzQ/ZzAxA6u6tv5KKg2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hghqotyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE36C113CF;
	Tue, 23 Sep 2025 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758668833;
	bh=myebbJEIelj6OaJbcBR6uxOg/2sE9Y7fBusonNz4fbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HghqotynkHbRWS3JVhE5mbF5L7n8U8MzlD8w7dZ/rwbNd3mL/QE/hnHV9Eh8fhsbq
	 5Me2eIVHvj3BTjyC1j/NEPlUVrl/rh5c7BDMcCXqOk3kkTKlIBshjZcoYjfohK3sDl
	 ir+jDd+VSc7cXxaovhYy+haSO0h6lI9SBydPy4Zy+Qyl5Vf8OqpANSqn+jN9KGTIqV
	 3yr92JwMt+hZcpI5G90qjHZ+DPEBnNyvkfSYTALVr1W4VdgXE8EbMfSSq17etDCsxn
	 2HFKBNfPEfK5JBQTjBeVLD/veWVuiKPDdxaDIaMOM+gaOwzDmsPBTxvzoaAxB0XS54
	 LMVGPceu04opg==
Date: Wed, 24 Sep 2025 00:07:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
Message-ID: <20250924-playable-catfight-3757178ada02@spud>
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
 <20250923-walmart-shale-359fb66133f8@spud>
 <TYWPR01MB88052B9ACC279F3C00AEAC21851DA@TYWPR01MB8805.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OsOWBbkfV+LccHUK"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB88052B9ACC279F3C00AEAC21851DA@TYWPR01MB8805.jpnprd01.prod.outlook.com>


--OsOWBbkfV+LccHUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 08:14:09PM +0000, Cosmin-Gabriel Tanislav wrote:
> > From: Conor Dooley <conor@kernel.org>
> > On Tue, Sep 23, 2025 at 07:05:16PM +0300, Cosmin Tanislav wrote:
> > > Document the A/D 12-Bit successive approximation converters found in =
the
> > > Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> > >
> > > RZ/T2H has two ADCs with 4 channels and one with 6.
> > > RZ/N2H has two ADCs with 4 channels and one with 15.
> > >
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.co=
m>
> > > ---
> > >  .../iio/adc/renesas,r9a09g077-adc.yaml        | 170 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   7 +
> > >  2 files changed, 177 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g=
077-
> > adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-
> > adc.yaml
> > > new file mode 100644
> > > index 000000000000..840108cd317e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-
> > adc.yaml
> > > @@ -0,0 +1,170 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yam=
l#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Renesas RZ/T2H / RZ/N2H ADC12
> > > +
> > > +maintainers:
> > > +  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > +
> > > +description: |
> > > +  A/D Converter block is a successive approximation analog-to-digital
> > converter
> > > +  with a 12-bit accuracy. Up to 15 analog input channels can be
> > selected.
> > > +  Conversions can be performed in single or continuous mode. Result =
of
> > the ADC

Your mail client is screwing up quoting somehow. Please fix it.

> > > +  renesas,max-channels:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Maximum number of channels supported by the ADC.
> > > +      RZ/T2H has two ADCs with 4 channels and one with 6 channels.
> > > +      RZ/N2H has two ADCs with 4 channels and one with 15 channels.
> >
> > What is the point of this? Why do you need to know how many channels
> > there can be in the driver, isn't it enough to just figure out how many
> > child nodes you have?
> >
>=20
> The idea here was that the SoC dtsi file would define the number of
> channels supported by each instance of the ADC peripheral, while the
> board dtsi (which includes the SoC dtsi) would define the number of
> channels actually wired up on the.
>=20
> Alternatively, we could have multiple compatibles for each SoC, like
> renesas,r9a09g077-adc-4, which would only have 4 channels, while
> the main renesas,r9a09g077-adc compatible would be the one with the
> most channels, 6.
>=20
> There might exist instances where knowing how many channels the chip
> has might be useful inside the driver, but the bindings themselves
> shouldn't really be addressing driver requirements, they should be
> describing the hardware properties.

"There might", so in other words: have written the driver and have not
had any need for this information. ;)

> The maximum number of supported channels of each ADC instance is a
> property of the hardware, which is fine to have in the bindings.

That is true, but also there's no interest in having properties that
you can obtain by other means - or don't need at all.

> Also, it is useful to know the maximum number of channels,
> otherwise, we would have to iterate over the iio_chan_spec
> populated by devm_iio_adc_device_alloc_chaninfo_se() to figure out
> what is the maximum used channel. We will surely need this

Right, you can get the information from another source. You only need to
do that exactly once, during probe, so whatever overhead that produces
isn't meaningful. I think this property should be removed.

> information when implementing buffered mode, to know up to which
> register to read data from, and we already need it when iterating
> over the enabled channels for the same reason.
>=20
> All things considered, I think it is useful to have this property
> here, considering the separation between SoC capabilities and board
> implementation.
>=20

--OsOWBbkfV+LccHUK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNMoGwAKCRB4tDGHoIJi
0h49AQDirzGaJuMpClcLnZM1qOqUHlpJ6LU+uguhyM7s+7diGQEAh+Jk/swRqsSC
5K2R+SP2kftGX+lyjQVSixUCvRGiXAk=
=riQv
-----END PGP SIGNATURE-----

--OsOWBbkfV+LccHUK--

