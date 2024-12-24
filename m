Return-Path: <linux-iio+bounces-13788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958C9FC23E
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 21:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039E07A1638
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E701212D9E;
	Tue, 24 Dec 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWYRm+yx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B20212B1F;
	Tue, 24 Dec 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735072037; cv=none; b=Ts+gFD5qppwmyC3MuG/v41h0ibq6ZeIeTJhr/xkZH66oAGinCILMSNZ6sIJC/bhNv8pKsIokdLjUbiXwNo8p/Q1cUzF2qlbhdJQyCggaEp39Y/lRELNtiwHH1W+vAfcRi3y6A+dVE4pryzdsq4gH7ux2CZ7LvYgLiPRpK16GjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735072037; c=relaxed/simple;
	bh=ed4xiVuk/FKUuXATF+R9WqnmG2ecUGVK8QJ0W+gvZOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTHHfMlNQ2y1Ce2n5YUX2+uXjFdU5kRtPiXGjfwCR3tEY8dhb4Uy99SUqkaKoEbMAqrB4H+NLhXkBYmQVppOh+4CuNe4scoPxaolenRQkybJEezRGNyjsnLas65+cDYrKlt6aQKPEMM9E6/a3WRbBltn2b6lLXUxPRze+LDYh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWYRm+yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A96C4CED0;
	Tue, 24 Dec 2024 20:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735072036;
	bh=ed4xiVuk/FKUuXATF+R9WqnmG2ecUGVK8QJ0W+gvZOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWYRm+yxEkhyuSG47vC+R+upcigH8B5DBQjmHar9HrqTJAfZVYsWgXhuNySf0q/or
	 hoZgIYskmF+6I8P0Xw4eSWEWaCrKgju0rfB/l9R7r6pPMbrdvFBIywOzKQ90XJdCRz
	 p50xMhuv2H5Z0p361MAYyuF+xDR2vsQHIdjQWM11SFCeEOLy/gLHsbwbY5ki9G63L4
	 n+oCEdZQvuXpFmF/3r2qVw8QCGZHJ/i8cpn3SDAVcwhYIa4nB2ihIdG6I2qANnDhYG
	 e7CoNr3U1oq059yUU03XOs/OhWnRsnEr7ktTFMulJXN1yPeiQ122uKnDogXXayAbKg
	 4wJjIeGNQZDdw==
Date: Tue, 24 Dec 2024 20:27:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: add AD7191
Message-ID: <20241224-unlivable-calibrate-ba5eed1ce741@spud>
References: <20241221155926.81954-1-alisa.roman@analog.com>
 <20241221155926.81954-3-alisa.roman@analog.com>
 <20241222-sequester-mounted-42c0db97611f@spud>
 <20241222181857.00b38e57@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XfkBLUR+FvMJ4gm0"
Content-Disposition: inline
In-Reply-To: <20241222181857.00b38e57@jic23-huawei>


--XfkBLUR+FvMJ4gm0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 06:18:57PM +0000, Jonathan Cameron wrote:
> On Sun, 22 Dec 2024 14:48:08 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Sat, Dec 21, 2024 at 05:56:01PM +0200, Alisa-Dariana Roman wrote:
> > > AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
> > > designed for precision bridge sensor measurements. It features two
> > > differential analog input channels, selectable output rates,
> > > programmable gain, internal temperature sensor and simultaneous
> > > 50Hz/60Hz rejection.
> > >=20
> > > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>=20
> Maybe I'm over thinking things, but comments inline about possibility of
> pinstrapping holding this device in a particular configuration, without
> the GPIOS connected.
>=20
> > > ---
> > >  .../bindings/iio/adc/adi,ad7191.yaml          | 128 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   7 +
> > >  2 files changed, 135 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7=
191.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> > > new file mode 100644
> > > index 000000000000..f3e596918c22
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> > > @@ -0,0 +1,128 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2025 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AD7191 ADC device driver
> > > +
> > > +maintainers:
> > > +  - Alisa-Dariana Roman <alisa.roman@analog.com>
> > > +
> > > +description: |
> > > +  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
> > > +  found here:
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7191.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad7191
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-cpol: true
> > > +
> > > +  spi-cpha: true
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description:
> > > +      Optionally, either a crystal can be attached externally betwee=
n MCLK1 and
> > > +      MCLK2 pins, or an external CMOS-compatible clock can drive the=
 MCLK2
> > > +      pin. If absent, internal 4.92MHz clock is used. =20
> >=20
> > Without clock-names, how do you tell the difference between driven ctal=
 and
> > the cmos-compatible clock? That CLKSEL's job?
>=20
> Seems it's an unusual part and there is no config associated with whether=
 we
> have a clock or an xtal, so we probably don't need the name.
>=20
> Related to that, in many cases I'd expect clksel to be tied to always
> use the external clock or not (depending on whether one is connected)
> not to be a gpio.  So you probably need to take that configuration into
> account as well.
>=20
> Similar may apply for the odr, and pga pins.  Sometimes people
> hardwire those things.  There are examples in tree (I can't point at one
> right now though) that deal with this. Fairly sure at least 1 ADI part
> has a binding to handle that.  (the ad7606 does a bit of this as it needs
> a particular pinstrap for sw-mode).
>=20
> You should be fine with chan and temp always being GPIOs as it would be w=
eird
> to buy a part with the extra channels + temperature sensor and not wire it
> to be useable.
>=20
> >=20
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  avdd-supply:
> > > +    description: AVdd voltage supply
> > > +
> > > +  dvdd-supply:
> > > +    description: DVdd voltage supply
> > > +
> > > +  vref-supply:
> > > +    description: Vref voltage supply
> > > +
> > > +  odr1-gpios:
> > > +    description: GPIO connected to ODR1 pin for output data rate sel=
ection
> > > +    maxItems: 1
> > > +
> > > +  odr2-gpios:
> > > +    description: GPIO connected to ODR2 pin for output data rate sel=
ection
> > > +    maxItems: 1
> > > +
> > > +  pga1-gpios:
> > > +    description: GPIO connected to PGA1 pin for gain selection
> > > +    maxItems: 1
> > > +
> > > +  pga2-gpios:
> > > +    description: GPIO connected to PGA2 pin for gain selection
> > > +    maxItems: 1
> > > +
> > > +  temp-gpios:
> > > +    description: GPIO connected to TEMP pin for temperature sensor e=
nable
> > > +    maxItems: 1
> > > +
> > > +  chan-gpios:
> > > +    description: GPIO connected to CHAN pin for input channel select=
ion
> > > +    maxItems: 1
> > > +
> > > +  clksel-gpios:
> > > +    description: GPIO connected to CLKSEL pin for clock source selec=
tion
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - avdd-supply
> > > +  - dvdd-supply
> > > +  - vref-supply
> > > +  - spi-cpol
> > > +  - spi-cpha =20
> >=20
> > > +  - odr1-gpios
> > > +  - odr2-gpios
> > > +  - pga1-gpios
> > > +  - pga2-gpios =20
> >=20
> > For these 4, since all are required, seems like grouping as odr-pgios
> > and pga-gpios would be a good idea?
> Agreed except for the annoying option of pin strapping.  Maybe we ignore =
that
> for now.  If it becomes a problem, we can add it safely as a driver preda=
ting
> that will try to grab the gpios and fail if it sees a DT not providing th=
em.
> So will fail safe before we add pinstrapping.  Maybe we will never need t=
o.

To me, it's a cosmetic nicety to merge them, so I'm happy with any valid
reason to not do so.

--XfkBLUR+FvMJ4gm0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2sZHwAKCRB4tDGHoIJi
0gwPAP9DQEboTW0osTYGqDLIN1IEW6qxWOJyIyal6rFoLplarAEAqi2WibGajOa3
PwYU/IrXMv2yK1gUjuvQ/RZ3HolpYQg=
=iYEZ
-----END PGP SIGNATURE-----

--XfkBLUR+FvMJ4gm0--

