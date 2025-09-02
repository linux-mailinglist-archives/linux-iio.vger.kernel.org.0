Return-Path: <linux-iio+bounces-23661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29A8B40E06
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 21:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69222174413
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217F30E831;
	Tue,  2 Sep 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3fn49Ju"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A95198A11;
	Tue,  2 Sep 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842152; cv=none; b=HkbGmehQxDvCo/Vs2hdBS7kbFKTHyMe/jvi/jpOyfeFrIrSkUj3J4Tq16XEKg287NKZnPOzbtFfjQXRJ6hY7l/cXVJxkP6mKv9zLPB+UakRMabHW+ek5gzQKJSG4LSP6gwLvIMkj97KQQwA1+02fnrL0IMs8Sgsp2SqwxldZTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842152; c=relaxed/simple;
	bh=CB9bHQ5ZSrUAaDlo+S0fnv/mmSyoQ+Sgb/i0Y6DNcTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDzNgstDNChNr47Sg/EPfHgkN09lpvv/Gq44SlKKSzDgyNTchbnEVbQ94ESORmCpCqEoy6O+xyb4xhFPg4CsFF2FcRkj4rO7TAOYoB/Fmh9OLlAi23jZ9ZGlaxSOZjm0AZRCFgqo4cNCtP8EFk6VSRQ11pAC50W/3k6ZiHD60TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3fn49Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0ACC4CEF7;
	Tue,  2 Sep 2025 19:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756842151;
	bh=CB9bHQ5ZSrUAaDlo+S0fnv/mmSyoQ+Sgb/i0Y6DNcTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3fn49Junfzx/cNxK68I+mqtvwnhKICYFe8ZN9F/CuQRC0Romsrw+XXsElu7/43J7
	 oXEFuVMRpLBDqxX3bxi/eWmA2kdnwm8isennHxdb98hTuKaVi+Ga6YwEUpYETJ2lPk
	 h7vuIcG0XC9vGUkb6qes7mk6V2qDkvRWkAsQ/Y0BSw5HWl9w1HhmpILZrk4WJ7eRFP
	 xCa4MoN/3X1Nd3Xt2dHbgN7Lm3m2MqTtGdK51J7jigcT9U7ygdZ90rQhw6QHzrKKtq
	 Wy5BHsvCFoBMPwV2wWXN/aVf9yykzmAzH4ngM06RWxPQ06DmXpkHhxYovi591NNmUB
	 pHUKGBj0W6cZA==
Date: Tue, 2 Sep 2025 20:42:26 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: iio: adc: add max14001
Message-ID: <20250902-henna-flammable-df3a9160619b@spud>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <34b7cc7226e789acdc884d35927269aa5a0d5e14.1756816682.git.marilene.agarcia@gmail.com>
 <89265de7-eeff-4eea-838b-6a810c069a20@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p12u5IEj66XosoaZ"
Content-Disposition: inline
In-Reply-To: <89265de7-eeff-4eea-838b-6a810c069a20@baylibre.com>


--p12u5IEj66XosoaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 09:29:04AM -0500, David Lechner wrote:
> On 9/2/25 8:15 AM, Marilene Andrade Garcia wrote:
> > Add device-tree documentation for MAX14001/MAX14002 ADCs.
> > The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
> > converters with programmable voltage comparators and inrush current
> > control optimized for configurable binary input applications.
>=20
> When there are multiple devices, DT maintainers like to know
> what is the difference between the devices.

Looking at the driver, I don't really buy that there even is a
meaningful one, at least at first glance. What even is different between
them other than the name?

>=20
> >=20
> > Co-developed-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> > Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
>=20
> Sine the patch is From: M.A.G., according to [1], this should be:
>=20
> Co-developed-by: K.S.P.
> Signed-off-by: K.S.P.
> Signed-off-by: M.A.G.
>=20
> (hopefully obvious, but don't use the abbreviations - I just did
> that for brevity)

Prob also worth putting a note under the --- line as to why the r-b from
Krzysztof got dropped that was on v9.

>=20
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml#when-to-use-acked-by-cc-and-co-developed-by
>=20
> > ---
> >  .../bindings/iio/adc/adi,max14001.yaml        | 79 +++++++++++++++++++
> >  MAINTAINERS                                   |  8 ++
> >  2 files changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14=
001.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> > new file mode 100644
> > index 000000000000..ff9a41f04300
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023-2025 Analog Devices Inc.
> > +# Copyright 2023 Kim Seer Paller
> > +# Copyright 2025 Marilene Andrade Garcia
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX14001-MAX14002 ADC
> > +
> > +maintainers:
> > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > +  - Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> > +
> > +description: |
> > +    Single channel 10 bit ADC with SPI interface.
> > +    Datasheet can be found here
> > +      https://www.analog.com/media/en/technical-documentation/data-she=
ets/MAX14001-MAX14002.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max14001
> > +      - adi,max14002
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 5000000
> > +
> > +  vdd-supply:
> > +    description:
> > +      Isolated DC-DC power supply input voltage.
> > +
> > +  vddl-supply:
> > +    description:
> > +      Logic power supply.
> > +
> > +  vrefin-supply:
>=20
> The actual pin name is REFIN, so refin-supply would make more sense.
>=20
> > +    description:
> > +      ADC voltage reference supply.
> > +
> > +  interrupts:
>=20
> Likely needs `minItems: 1` in case only one interrupt is wired.
>=20
> > +    items:
> > +      - description: |
> > +          Interrupt for signaling when conversion results exceed the c=
onfigured
> > +          upper threshold for ADC readings or fall below the lower thr=
eshold for
> > +          them. Interrupt source must be attached to COUT pin.
>=20
> We could shorten these descriptions. The important part is which pin
> it is connected to.
>=20
> > +      - description: |
> > +          Alert output that asserts low during a number of different e=
rror
> > +          conditions. The interrupt source must be attached to FAULT p=
in.
> > +
>=20
> And also `interrupt-names:` makes sense so we know which one is
> is wired if only one is given.

Additionally, v9 had no interrupts at all but only serviced once device.
Do both devices have the interrupts or should these only be permitted on
the 140002?

>=20
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - vddl-supply
> > +

--p12u5IEj66XosoaZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLdIogAKCRB4tDGHoIJi
0vHVAQC5vOqUyUnEJVpTrDBp+yj1apl7lLDvgOjLnmB5QWbJxAD2Ld9s9XN5AnKc
yQ1DLgskykjBmNOAbLppcBF5lSANBw==
=k35l
-----END PGP SIGNATURE-----

--p12u5IEj66XosoaZ--

