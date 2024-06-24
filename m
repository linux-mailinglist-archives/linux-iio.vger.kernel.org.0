Return-Path: <linux-iio+bounces-6819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142091533A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C672B21030
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871819D8A5;
	Mon, 24 Jun 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJLWckyJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10F12FF84;
	Mon, 24 Jun 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245630; cv=none; b=ceiMYsxSqgkAUtcEbWKLjX76BrVJblCgFleJASEQB6A7ZYVMr/WK4h/o7shD37oJp4EVC5luGKWMk57f+ye3H1W/ccM+U/cwXaBFm1c9LZlmCYKdxUhkBQ2ELN4wFGN2PSnNnF4Ha5zZawovIPuxhTNS+gtXH0qgY275ie7FjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245630; c=relaxed/simple;
	bh=DgVVOPk1ZkKbKxb3mtBrBTehxOzldRGgUCcC7y0SrK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb8k9ZH1qQXz+wQM/TsTe/NbcywqSeNdC214W7+OUwrtYa+7sYHVbeDi3T1GiqiyT68vc6pS7Qtc3KtlKLygek8Xo07zE1FyPYdQAYro2ArfNsDjkQyoYCyLXMJklnMw3hmcLbm3UjZxqnAz0WqcO1CAd4qv5v/QRmOH+2Uo/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJLWckyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E518EC2BBFC;
	Mon, 24 Jun 2024 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719245629;
	bh=DgVVOPk1ZkKbKxb3mtBrBTehxOzldRGgUCcC7y0SrK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJLWckyJQvmvD9adz4fDH22WUxDxxW5rX2aLB9mnyJ00mtIOIocl5Z4dVPqPkKqcB
	 yTD+WBJ9Bl5oU/eVHvQP/qiN5lM0zRT/cqY1W43/TrgydV3lcm6xowsD14pk0vcxwN
	 uA9WXIICT4mYNiLJpaSKgtXFlW0DniqPU1acehpnupzkJ6UB7msyBunSneIQqu+oq/
	 jJaRQn1tg9TsdJlVjtruiWiLR/JRmz3PvxBzeaB0vqctRF8BHUaNFVXYuZf+T0bYvY
	 Am+yH4ATOc0Q5PowenOWyfBBvNUX0xR3Sj+jqVvkjrlj0/Kjh2m0y5FfkQOTiPXSFK
	 cnR0F7LZaMACw==
Date: Mon, 24 Jun 2024 17:13:44 +0100
From: Conor Dooley <conor@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240624-handled-swimwear-94ed97b123cc@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-4-kimseer.paller@analog.com>
 <20240619-left-usable-316cbe62468a@spud>
 <PH0PR03MB7141FB5DFBCA46C727FA9605F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w16K0kP6Co5gYb/H"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141FB5DFBCA46C727FA9605F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>


--w16K0kP6Co5gYb/H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 03:13:56PM +0000, Paller, Kim Seer wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Thursday, June 20, 2024 1:57 AM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> > Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> > Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> > Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > Subject: Re: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
> >=20
> > [External]
> >=20
> > On Wed, Jun 19, 2024 at 02:49:02PM +0800, Kim Seer Paller wrote:
> > > Add documentation for ltc2664.
> > >
> > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > ---
> > >  .../bindings/iio/dac/adi,ltc2664.yaml         | 167 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   8 +
> > >  2 files changed, 175 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > > b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > > new file mode 100644
> > > index 000000000000..be37700e3b1f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > > @@ -0,0 +1,167 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices LTC2664 DAC
> > > +
> > > +maintainers:
> > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > > +
> > > +description: |
> > > +  Analog Devices LTC2664 4 channel, 12-/16-Bit, +-10V DAC
> > > +
> > > +https://www.analog.com/media/en/technical-documentation/data-sheets/2
> > > +664fa.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ltc2664
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 50000000
> > > +
> > > +  vcc-supply:
> > > +    description: Analog Supply Voltage Input.
> > > +
> > > +  v-pos-supply:
> > > +    description: Positive Supply Voltage Input.
> > > +
> > > +  v-neg-supply:
> > > +    description: Negative Supply Voltage Input.
> > > +
> > > +  iovcc-supply:
> > > +    description: Digital Input/Output Supply Voltage.
> > > +
> > > +  ref-supply:
> > > +    description:
> > > +      Reference Input/Output. The voltage at the REF pin sets the fu=
ll-scale
> > > +      range of all channels. If not provided the internal reference =
is used and
> > > +      also provided on the VREF pin.
> > > +
> > > +  reset-gpios:
> > > +    description:
> > > +      Active-low Asynchronous Clear Input. A logic low at this level=
-triggered
> > > +      input clears the part to the reset code and range determined b=
y the
> > > +      hardwired option chosen using the MSPAN pins. The control regi=
sters are
> > > +      cleared to zero.
> > > +    maxItems: 1
> > > +
> > > +  adi,manual-span-operation-config:
> > > +    description:
> > > +      This property must mimic the MSPAN pin configurations. By tyin=
g the
> > MSPAN
> > > +      pins (MSP2, MSP1 and MSP0) to GND and/or VCC, any output range=
 can
> > be
> > > +      hardware-configured with different mid-scale or zero-scale res=
et options.
> > > +      The hardware configuration is latched during power on reset fo=
r proper
> > > +      operation.
> > > +        0 - MPS2=3DGND, MPS1=3DGND, MSP0=3DGND (+-10V, reset to 0V)
> > > +        1 - MPS2=3DGND, MPS1=3DGND, MSP0=3DVCC (+-5V, reset to 0V)
> > > +        2 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DGND (+-2.5V, reset to 0V)
> > > +        3 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DVCC (0V to 10, reset to 0=
V)
> > > +        4 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DGND (0V to 10V, reset to =
5V)
> > > +        5 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DVCC (0V to 5V, reset to 0=
V)
> > > +        6 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DGND (0V to 5V, reset to 2=
=2E5V)
> > > +        7 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DVCC (0V to 5V, reset to 0=
V, enables
> > SoftSpan)
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> >=20
> > Can you explain why this property is required, when below there's one t=
hat sets
> > the ranges in microvolts? Isn't the only new information that this prov=
ides the
> > reset values (in a few cases that it is not 0).
> > What am I missing?
>=20
> For specifying output range and reset options without relying on software=
 initialization
> routines, and also for enabling the softspan feature, I think this proper=
ty seems essential.

The portion of this information that is duplicated below I do not think
should reappear in this property.
Really the only additional information is the reset values being at 50%
of the range and the SoftSpan

--w16K0kP6Co5gYb/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmbOAAKCRB4tDGHoIJi
0mouAQDzsVsipg/3w2VG+hknkSbjckhNz5CqLEQ8NOBuG1kDCAEAv6ufhDKmdcyu
7Vpu2g6CSOzzkHDSkLJwqM59OjpWRw8=
=5rtG
-----END PGP SIGNATURE-----

--w16K0kP6Co5gYb/H--

