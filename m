Return-Path: <linux-iio+bounces-25154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12467BE48E2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 18:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB41756563F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A230B32AAB8;
	Thu, 16 Oct 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmNfP4s0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB232D0FE;
	Thu, 16 Oct 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631564; cv=none; b=ImeQOLG8szHbKLS7l02sffH+PO8EBCAyaI4vHbtQWBGV20l+UZbhqgUm58Xt2FWrBbc55Tp5z/GZnN0yRRdUZBN7IB33PgjsZ0Hfmq6kN/szWJwDU/afpI0XO9udKzjO9bP4uQiYVUgjYyqE/Z5FakKXgYmXMYlGVfxfVDRkyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631564; c=relaxed/simple;
	bh=rhBuyltnRldTiBa1avsLIjFQMD9CKcgHEk++kIOoC/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh1Jhuwu6IeKmf8lKwmCiHt9DFxaUo5FcinmcJWq+rsR+n10aSMx9wyN2HvABxTgg/lXuLkmEv1DSIJ+UAylIby5fBjEx5/VPJvnftP1XE+EgvrRyJ1p8TI6+x5jA3OMnAwLFIdsZ0xPA1rC7vXMTysUjpzuSlUvDJ5SLhbieW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmNfP4s0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0396C4CEF1;
	Thu, 16 Oct 2025 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760631564;
	bh=rhBuyltnRldTiBa1avsLIjFQMD9CKcgHEk++kIOoC/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmNfP4s0Z3BHf7yml9NcVJIlUyEPS1BB8up+irtDwhKI0HlXmKFZRVTmE9gmL4uTk
	 yFDdbOhZoHhmIDfl6SdBOLoMb+5HYy4cLaVgdD5ScN5gTbbqBPcsV1+LDt/2smJIeH
	 cNHy7jR4uU0qhP6tyJKOeml+jmH2ZOU3LTCJm9c7RaGrg2dOXZhkj26yLgZZa9inv6
	 cPZKtPUTe4g69IeucRUJhF6xTNIzvbwi9d6R0OT4NPzFGCORPWZqtnOa3PB4WIdTjl
	 u20rs8pK6Aoh7bAsloM9iPqP5kAMYeWU+rkwJ4ePVjFVY0o5hxBoZu8cT93yoOO+qJ
	 jz1Z+5SVBe38w==
Date: Thu, 16 Oct 2025 17:19:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding support for PAC1711
Message-ID: <20251016-idealist-railway-c9e94e22ef3c@spud>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
 <20251015-pac1711-v1-1-976949e36367@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7HVN5qN8TvfPexH6"
Content-Disposition: inline
In-Reply-To: <20251015-pac1711-v1-1-976949e36367@microchip.com>


--7HVN5qN8TvfPexH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Oct 15, 2025 at 01:12:15PM +0300, Ariana Lazar wrote:
> This is the device tree schema for Microchip PAC1711 single-channel power
> monitor with accumulator. The device uses 12-bit resolution for voltage a=
nd
> current measurements and 24 bits power calculations. The device supports
> one 56-bit accumulator register.
>=20
> PAC1711 measures up to 42V Full-Scale Range.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1711.yaml        | 195 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 201 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..67edd778981c2f0ed21dda02f=
14e383a153169b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1711.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1711 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Ariana Lazar <ariana.lazar@microchip.com>
> +
> +description: |
> +  This device is part of the Microchip family of Power Monitors with Acc=
umulator.
> +  The datasheet for PAC1711 can be found here:
> +  https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Produc=
tDocuments/PAC1711-Data-Sheet-DS20007058.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1711
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

There are no child nodes here, so I don't think size or address cells are
needed.

> +
> +  gpio-controller:
> +    description: Marks the device node as a GPIO controller.
> +
> +  "#gpio-cells":
> +    const: 2
> +    description:
> +      The first cell is the GPIO number and the second cell specifies
> +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> +
> +  powerdown-gpios:
> +    description:
> +      Active low puts the device in power-down state. When the PWRDN pin=
 is
> +      pulled high, measurement and accumulation will resume using the de=
fault
> +      register settings.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description:
> +      Could be triggered by overvoltage, undervoltage, overcurrent, over=
power,
> +      undercurrent, step limit, accumulator overflow and accumulator cou=
nt
> +      overflow.
> +    items:
> +      - const: alert0
> +      - const: alert1

This won't allow using alert0 but not alert1, or vice versa. Is that
intended? I would imagine that only using one of the interrupt pins is a
valid behaviour.

> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value in micro Ohms of the shunt resistor connected between
> +      the VSENSEP and VSENSEN inputs, across which the current is measur=
ed.
> +      Value is needed to compute the scaling of the measured current.
> +
> +  label:
> +    description: Unique name to identify which device this is.
> +
> +  microchip,gpio:
> +    type: boolean
> +    description:
> +      In default mode, A0 pin is a GPIO 0 input pin, respectively A1 pin=
 is
> +      GPIO 1. The pins can be used for the SLOW function, the device wil=
l sample
> +      at 8 samples/second if pulled high. A0 also function as the Alert0=
 and A1
> +      as Alert1, but can no longer be used to control conversion rate or=
 SLOW.

This description provides zero detail about what the property actually
does. The driver doesn't appear to use it either, so no hints for me
there. If it is something to do with deciding if pins are interrupts or
are free for gpio use, can't that just be determined based on what
interrupts are in use?

> +
> +  microchip,vbus-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the voltage f=
ull
> +      scale range (FSR). The range should be set as <minimum, maximum> by
> +      hardware design and should not be changed during runtime.
> +
> +      The VBUS could be configured into the following full scale range:
> +        -  VBUS has unipolar 0V to 42V FSR (default)
> +        -  VBUS has bipolar -42V to 42V FSR
> +        -  VBUS has bipolar -21V to 21V FSR
> +    items:
> +      - enum: [-42000000, -21000000, 0]
> +      - enum: [21000000, 42000000]
> +
> +  microchip,vsense-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the current f=
ull
> +      scale range (FSR). The current is calculated by dividing the vsense
> +      voltage by the value of the shunt resistor. The range should be se=
t as
> +      <minimum, maximum> by hardware design and it should not be changed=
 during
> +      runtime.
> +
> +      The VSENSE could be configured into the following full scale range:
> +        -  VSENSE has unipolar 0 mV to 100V FSR (default)
> +        -  VSENSE has bipolar -100 mV to 100 mV FSR
> +        -  VSENSE has bipolar -50 mV to 50 mV FSR
> +    items:
> +      - enum: [-100000, -50000, 0]
> +      - enum: [50000, 100000]
> +
> +  microchip,accumulation-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The Hardware Accumulator may be used to accumulate VPOWER, VSENSE =
or
> +      VBUS values for any channel. By setting the accumulator for a chan=
nel
> +      to accumulate the VPOWER values gives a measure of accumulated pow=
er
> +      into a time period, which is equivalent to energy. Setting the
> +      accumulator for a channel to accumulate VSENSE values gives a meas=
ure
> +      of accumulated current, which is equivalent to charge.
> +
> +      The Hardware Accumulator could be configured as:
> +       <0>  -  Accumulator accumulates VPOWER (default)
> +       <1>  -  Accumulator accumulates VSENSE
> +       <2>  -  Accumulator accumulates VBUS

Please make this a string, probably with values "vpower", "vsense" and
"vbus".

> +    maximum: 2
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - shunt-resistor-micro-ohms
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,pac1711

This is the only compatible, using an if/then/else section here is not
required. This should be describable in the property itself.

> +    then:
> +      properties:
> +        microchip,vbus-input-range-microvolt:
> +          oneOf:
> +            - items:
> +                - const: 0
> +                - const: 42000000
> +            - items:
> +                - const: -42000000
> +                - const: 42000000
> +            - items:
> +                - const: -21000000
> +                - const: 21000000
> +          default:
> +            items:
> +              - const: 0
> +              - const: 42000000
> +
> +        microchip,vsense-input-range-microvolt:
> +          oneOf:
> +            - items:
> +                - const: 0
> +                - const: 100000
> +            - items:
> +                - const: -100000
> +                - const: 100000
> +            - items:
> +                - const: -50000
> +                - const: 50000
> +          default:
> +            items:
> +              - const: 0
> +              - const: 100000
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        pac1711@10 {

"pac1711" is not a class of device, so probably dac@10?

pw-bot: changes-requested

> +            compatible =3D "microchip,pac1711";
> +            reg =3D <0x10>;
> +
> +            shunt-resistor-micro-ohms =3D <10000>;
> +            label =3D "VDD3V3";
> +            vdd-supply =3D <&vdd>;
> +            microchip,vbus-input-range-microvolt =3D <(-21000000) 210000=
00>;
> +            microchip,vsense-input-range-microvolt =3D <(-50000) 50000>;
> +            microchip,accumulation-mode =3D <0>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa163f9fe8fe3f04bf66426f9a894409..7686e2516c90442aa3e23d19c=
fb08e280a44ba76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16337,6 +16337,12 @@ F:	Documentation/devicetree/bindings/nvmem/micro=
chip,sama7g5-otpc.yaml
>  F:	drivers/nvmem/microchip-otpc.c
>  F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> =20
> +MICROCHIP PAC1711 DAC DRIVER
> +M:	Ariana Lazar <ariana.lazar@microchip.com>

I also work for Microchip (in the FPGA BU), so whenever I see people
=66rom Microchip whose name I don't recognise I look them up. I noticed
that Teams lists you as being an intern, so I have to ask what your plan
is for maintaining this after your internship has completed. Do you
intend passing it over to someone else from your team or continuing
yourself? If it's the former, it'd be good to CC them and/or add them
here as a co-maintainer.

Cheers,
Conor.

> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> +
>  MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
>  M:	Matteo Martelli <matteomartelli3@gmail.com>
>  L:	linux-iio@vger.kernel.org
>=20
> --=20
> 2.43.0
>=20

--7HVN5qN8TvfPexH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEbBwAKCRB4tDGHoIJi
0gSvAQCBF/6HaKvqqyEh/ff9b2A+B67fmJ7VliDhUrfsBvrfPwD/ZMme/QIleR9c
+UNEtePhn3IdlFWqxebquWgYXMSzZgg=
=LMII
-----END PGP SIGNATURE-----

--7HVN5qN8TvfPexH6--

