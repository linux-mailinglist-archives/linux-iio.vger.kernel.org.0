Return-Path: <linux-iio+bounces-24380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A9B97387
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 20:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20DF17901E
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A3E3019C6;
	Tue, 23 Sep 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6JrtzTQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF01D5146;
	Tue, 23 Sep 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652909; cv=none; b=ZPQ5XAl7cyvE2Tf2KMiuTAD3mA8OA+u+98n8KGWzF1W9HrAxVhoUlpDeVA5Mquk+wytitJkS0eShS/g+NyXjmJdPqmhG4D0AcSPXqA7ehlNfexpHlWgaffb/wZE51D01Vuir7KiB5tAwtj9/eL+xnA70V2HK9JeBjnxEFWxmU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652909; c=relaxed/simple;
	bh=Hqf061t5q3203ZdM7uYVB+F7fFOGaBDfx66exBR4K0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1WZjL8pP+2yQh+Mas6xbhFUIfQTdqDZF0uEg6uWiizJJbw6RAsZ31G3iONPiTG+BJ9sROYRVzb361LgRDXIfmeFY99EUQljtFZnncaNVYo7YCXvg+vOhdn0xF/xBP7vw7BWdAWlsLvUq/irDdIoSfTgwhKIt92TH+Yy2UgfjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6JrtzTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6411CC4CEF5;
	Tue, 23 Sep 2025 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758652908;
	bh=Hqf061t5q3203ZdM7uYVB+F7fFOGaBDfx66exBR4K0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6JrtzTQVih7eArFHAGyZs4M5mx2MrXR5R16/+9YAZN0lanJLRiIBgfF9amqMKcyX
	 mErGsMH58oaGKDSXYgvK6EYW0qbDHvh8aIDCQUXjEKzUCs/2mUKpPdQDfvzuxei4Hf
	 TPMpX5k9GWeZU/4oITxSA1T4dNmYlHka8hTH0t36sgIA7KgYYg+YfuP15DaL0vl/lT
	 oz35QRnFMyMWjRObhQnCyaLvFUcnTXIQF8LM78o+Jbm02But8OWReBSn7Gt27PbXcn
	 9uYUanpp++gU4FUL0oPskzdAZhoVs7ShWvp8igxDcFSp++Cuaud1SI22mln7qtOYQZ
	 KlXIxgjen5/zg==
Date: Tue, 23 Sep 2025 19:41:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
Message-ID: <20250923-walmart-shale-359fb66133f8@spud>
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aJDuWnn7O/3Zbilf"
Content-Disposition: inline
In-Reply-To: <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>


--aJDuWnn7O/3Zbilf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 07:05:16PM +0300, Cosmin Tanislav wrote:
> Document the A/D 12-Bit successive approximation converters found in the
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>=20
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  .../iio/adc/renesas,r9a09g077-adc.yaml        | 170 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a=
09g077-adc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-=
adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.=
yaml
> new file mode 100644
> index 000000000000..840108cd317e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/T2H / RZ/N2H ADC12
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> +
> +description: |
> +  A/D Converter block is a successive approximation analog-to-digital co=
nverter
> +  with a 12-bit accuracy. Up to 15 analog input channels can be selected.
> +  Conversions can be performed in single or continuous mode. Result of t=
he ADC
> +  is stored in a 16-bit data register corresponding to each channel.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,r9a09g077-adc # RZ/T2H
> +      - renesas,r9a09g087-adc # RZ/N2H
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: A/D scan end interrupt
> +      - description: A/D scan end interrupt for Group B
> +      - description: A/D scan end interrupt for Group C
> +      - description: Window A compare match
> +      - description: Window B compare match
> +      - description: Compare match
> +      - description: Compare mismatch
> +
> +  interrupt-names:
> +    items:
> +      - const: adi
> +      - const: gbadi
> +      - const: gcadi
> +      - const: cmpai
> +      - const: cmpbi
> +      - const: wcmpm
> +      - const: wcmpum
> +
> +  clocks:
> +    items:
> +      - description: converter clock
> +      - description: peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: adclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  renesas,max-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Maximum number of channels supported by the ADC.
> +      RZ/T2H has two ADCs with 4 channels and one with 6 channels.
> +      RZ/N2H has two ADCs with 4 channels and one with 15 channels.

What is the point of this? Why do you need to know how many channels
there can be in the driver, isn't it enough to just figure out how many
child nodes you have?

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - renesas,max-channels

This should be after patternProperties.

> +
> +patternProperties:
> +  "^channel@[0-9a-e]$":
> +    $ref: adc.yaml
> +    type: object
> +    description: The external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        maximum: 14
> +
> +    required:
> +      - reg
> +

> +    additionalProperties: false

You don't include any properties other than reg from adc.yaml, and using
additionalProperties: false blocks their use. Is that intentional or
should this be unevaluatedProperties: false?

Cheers,
Conor.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-adc
> +    then:
> +      properties:
> +        renesas,max-channels:
> +          enum: [4, 6]
> +
> +      patternProperties:
> +        "^channel@[6-9a-e]$": false
> +        "^channel@[0-5]$":
> +          properties:
> +            reg:
> +              maximum: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g087-adc
> +    then:
> +      properties:
> +        renesas,max-channels:
> +          enum: [4, 15]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    adc@80008000 {
> +      compatible =3D "renesas,r9a09g077-adc";
> +      reg =3D <0x80008000 0x400>;
> +      interrupts =3D <GIC_SPI 708 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 709 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 710 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 855 IRQ_TYPE_EDGE_RISING>,
> +                   <GIC_SPI 856 IRQ_TYPE_EDGE_RISING>;
> +      interrupt-names =3D "adi", "gbadi", "gcadi",
> +                        "cmpai", "cmpbi", "wcmpm", "wcmpum";
> +      clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
> +               <&cpg CPG_MOD 225>;
> +      clock-names =3D "adclk", "pclk";
> +      power-domains =3D <&cpg>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      #io-channel-cells =3D <1>;
> +      renesas,max-channels =3D <6>;
> +
> +      channel@0 {
> +        reg =3D <0x0>;
> +      };
> +      channel@1 {
> +        reg =3D <0x1>;
> +      };
> +      channel@2 {
> +        reg =3D <0x2>;
> +      };
> +      channel@3 {
> +        reg =3D <0x3>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f4b48801879..07e0d37cf468 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21822,6 +21822,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
>  F:	drivers/counter/rz-mtu3-cnt.c
> =20
> +RENESAS RZ/T2H / RZ/N2H A/D DRIVER
> +M:	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> +L:	linux-iio@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> +
>  RENESAS RTCA-3 RTC DRIVER
>  M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>  L:	linux-rtc@vger.kernel.org
> --=20
> 2.51.0
>=20

--aJDuWnn7O/3Zbilf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLp5gAKCRB4tDGHoIJi
0gF8AP0e9IPpkmVVbAYL2Uh5rbwusvJrXFkZkKEhbkNv1YjSJAEA97RhG7uRUc9W
WWGY5cG6DcxCQkUGOfidMcOgEgHLhgc=
=iUBj
-----END PGP SIGNATURE-----

--aJDuWnn7O/3Zbilf--

