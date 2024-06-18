Return-Path: <linux-iio+bounces-6532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DBE90DB58
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7AA1C2180A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073BE156F25;
	Tue, 18 Jun 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsB1ggxD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E13156C6C;
	Tue, 18 Jun 2024 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734239; cv=none; b=d7qtzPmQm+ikAuNQAI5aRCnQsfztOIyW4hrlp46wqhYdM5C3WklyUs2enxyVLinK/NV6lY0YhY+pUxdj1QXHSuJXLfgQLxrEW4nz9LmdLbRJ6sBl+qu2mNFTwCqt+6yJLtK3pT0Xi5yR/carebAEWPsqv63pCEQMDfehaO6oqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734239; c=relaxed/simple;
	bh=EAvgZ3jMRCuTBhjZ/B+YPumQ+F27xwXs2WGNI9/iw6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CathX58dYt05ftmnRGcLyj0TLlqFvOgLKm2gpPE5VKqqnJVFMAHGU9GvdiEZWQeRZ85QwKGuYtvcRay89IqNJ73lH0H0i8TpifJyrTOhAMwFwsrJ/ZyC92/+vnEJFh89q8Y7JF+piYWlHwHxp5v22wRqcLgtvHU2AWR1O1Ljv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsB1ggxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D31EC3277B;
	Tue, 18 Jun 2024 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734239;
	bh=EAvgZ3jMRCuTBhjZ/B+YPumQ+F27xwXs2WGNI9/iw6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsB1ggxDjMVJ2bkpOY1nKfMR+8EDszY1zyaQ5sHAm5770BSZXaG2f6OB+YNYYXa6q
	 JPKFtXmGx6H4GmFZ+pdBKNvJ1eWUsXVnCmEnOpTL0Dh1PFH93SXT08T46h5g1vm5cG
	 ayKhoikeHx/EcWdFzABFU3tAdtaYi9GxJw4TGJBQe0cWXJYif06tuTUvoF6x2dSYcH
	 BAOL8V7giCyQP1QeNs7qtVGHoFLN/cYqyCkFxCPzdO2AxFQqaBhoaw/ExuhmPOxK7d
	 TduN9cJ8gbcDNEwCcAXQQw1cjeqQ7K9zWRxZD/u3kSjjO/+Q5Lw2Wzz2QrxTgcddEo
	 swS7EoMEUABbA==
Date: Tue, 18 Jun 2024 19:10:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: iio: dfsdm: move to backend framework
Message-ID: <20240618-footwear-impotence-5284985a609d@spud>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-5-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SiWeHDoe2HNgIcV"
Content-Disposition: inline
In-Reply-To: <20240618160836.945242-5-olivier.moysan@foss.st.com>


--4SiWeHDoe2HNgIcV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 06:08:30PM +0200, Olivier Moysan wrote:
> Change the DFSDM binding to use the new IIO backend framework,
> along with the adoption of IIO generic channels.
> This binding change allows to add scaling support to the DFSDM.
>=20
> Keep the legacy binding as deprecated for backward compatibility.
>=20
> The io-backends property is supported only in generic IIO channel
> binding.
>=20
> - Channel description with the generic binding (Audio and Analog):
>=20
>   Properties supersed by generic properties:
>     st,adc-channels: becomes "reg" property in channel node
>     st,adc-channel-names: becomes "label" property in channel node
>   Properties moved to channel child node:
>     st,adc-channel-types, st,adc-channel-clk-src, st,adc-alt-channel
>=20
> - Analog binding:
>=20
>   DFSDM filter channel is configured as an IIO backend consumer.
>   Add io-backends property in channel child nodes.
>=20
>   DFSDM is no more configured as a channel consumer from SD modulator.
>   Use of io-channels in DFSDM node is deprecated.
>=20
> - Audio binding:
>=20
>   DFSDM audio DAI is configured as a channel consumer from DFSDM filter.
>   No change compare to legacy.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 158 +++++++++++++++++-
>  1 file changed, 152 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc=
=2Eyaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> index c1b1324fa132..dd414bab74c1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> @@ -102,9 +102,11 @@ patternProperties:
>          items:
>            minimum: 0
>            maximum: 7
> +        deprecated: true
> =20
>        st,adc-channel-names:
>          description: List of single-ended channel names.
> +        deprecated: true
> =20
>        st,filter-order:
>          description: |
> @@ -118,6 +120,12 @@ patternProperties:
>        "#io-channel-cells":
>          const: 1
> =20
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>        st,adc-channel-types:
>          description: |
>            Single-ended channel input type.
> @@ -128,6 +136,7 @@ patternProperties:
>          items:
>            enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
>          $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +        deprecated: true
> =20
>        st,adc-channel-clk-src:
>          description: |
> @@ -139,6 +148,7 @@ patternProperties:
>          items:
>            enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
>          $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +        deprecated: true
> =20
>        st,adc-alt-channel:
>          description:
> @@ -147,6 +157,7 @@ patternProperties:
>            If not set, channel n is connected to SPI input n.
>            If set, channel n is connected to SPI input n + 1.
>          type: boolean
> +        deprecated: true
> =20
>        st,filter0-sync:
>          description:
> @@ -165,11 +176,65 @@ patternProperties:
>        - compatible
>        - reg
>        - interrupts
> -      - st,adc-channels
> -      - st,adc-channel-names
>        - st,filter-order
>        - "#io-channel-cells"
> =20
> +    patternProperties:
> +      "^channel@([0-9]|1[0-9])$":
> +        type: object
> +        $ref: adc.yaml
> +        description: Represents the external channels which are connecte=
d to the DFSDM.
> +
> +        properties:
> +          reg:
> +            items:
> +              minimum: 0
> +              maximum: 8
> +
> +          label:
> +            description:
> +              Unique name to identify which channel this is.
> +
> +          st,adc-channel-types:
> +            description: |
> +              Single-ended channel input type.
> +              - "SPI_R": SPI with data on rising edge (default)
> +              - "SPI_F": SPI with data on falling edge
> +              - "MANCH_R": manchester codec, rising edge =3D logic 0, fa=
lling edge =3D logic 1
> +              - "MANCH_F": manchester codec, rising edge =3D logic 1, fa=
lling edge =3D logic 0
> +            items:
> +              enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
> +            $ref: /schemas/types.yaml#/definitions/non-unique-string-arr=
ay

Why is this an array? And why is the property plural? Can a channel have
more than one type?

> +
> +          st,adc-channel-clk-src:
> +            description: |
> +              Conversion clock source.
> +              - "CLKIN": external SPI clock (CLKIN x)
> +              - "CLKOUT": internal SPI clock (CLKOUT) (default)
> +              - "CLKOUT_F": internal SPI clock divided by 2 (falling edg=
e).
> +              - "CLKOUT_R": internal SPI clock divided by 2 (rising edge=
).
> +            items:
> +              enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
> +            $ref: /schemas/types.yaml#/definitions/non-unique-string-arr=
ay

Ditto here, but s/type/clock source/

Thanks,
Conor.

> +
> +          st,adc-alt-channel:
> +            description:
> +              Must be defined if two sigma delta modulators are
> +              connected on same SPI input.
> +              If not set, channel n is connected to SPI input n.
> +              If set, channel n is connected to SPI input n + 1.
> +            type: boolean
> +
> +          io-backends:
> +            description:
> +              From common IIO binding.

Drop this from the description.

> Used to pipe external sigma delta
> +              modulator or internal ADC backend to DFSDM channel.
> +
> +        required:
> +          - reg
> +
> +        additionalProperties: false
> +
>      allOf:
>        - if:
>            properties:
> @@ -199,9 +264,19 @@ patternProperties:
>                description:
>                  From common IIO binding. Used to pipe external sigma del=
ta
>                  modulator or internal ADC output to DFSDM channel.
> +              deprecated: true
> =20
> -          required:
> -            - io-channels
> +          if:
> +            required:
> +              - st,adc-channels
> +          then:
> +            required:
> +              - io-channels
> +
> +          patternProperties:
> +            "^channel@([0-9]|1[0-9])$":
> +              required:
> +                - io-backends

Why is this here, rather than with reg above? Only some channels require
a backend?

--4SiWeHDoe2HNgIcV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHNmQAKCRB4tDGHoIJi
0qHWAP4sIhBxMJaoCYlRr235U6E4PaT7TkOaskE90Tjd/qpLJQEAyeBOaQxiIt+1
NK/yqLrQ0NQySGaW07Y716L/6hIBTgs=
=tTur
-----END PGP SIGNATURE-----

--4SiWeHDoe2HNgIcV--

