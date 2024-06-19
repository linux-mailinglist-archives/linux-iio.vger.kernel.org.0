Return-Path: <linux-iio+bounces-6598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D390F560
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 19:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EACB22AAD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B833C155C8B;
	Wed, 19 Jun 2024 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH4U57RK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2477107;
	Wed, 19 Jun 2024 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818958; cv=none; b=rKDeFmzx7f4XpykUYlFyiwmJV0KG3Z3Ivdd+XMW3iFqkPWkCAwHUYT8oxHe/ITwIUztm3W6245MdmPobz5zb44J+wyvXObFFEQtAUwEYGMPn0cXcAOIuf7iUg0N3zOs5eQgn7v0Rxw1nGoRNL7R71XUcpvAlsHT8fuyNOvDMyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818958; c=relaxed/simple;
	bh=IMD+o+HtoEpgZPwdGoQZpT4+nJLbdqGSdMmmb9m9c+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPHJJdx4TfSL/ev0t7oiDtLF6mRdV1KlUVMv5ofepWH8jCZF5xh9pbZZ0rWqTSFxMThAxdnJj/Vmbw7deSkNEMiqZIgejVqQ+ZsVub3SUIhzLfmCRerCBfDD1xk1vmXbrAGq+cWRvgsxb48B5wMbSkvkg5KMae589aZkwjVytmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH4U57RK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0D8C2BBFC;
	Wed, 19 Jun 2024 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818958;
	bh=IMD+o+HtoEpgZPwdGoQZpT4+nJLbdqGSdMmmb9m9c+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pH4U57RKTHye7kcgscE74d6x6iWpjFvzye6Yl1G6LisVHUGm18xcXhWHTH+gSLowX
	 MDn+x2broIqM4BGXnRAugyMCGTX4rBkfvLDQuZu3llasVnthWFeyviLdJjHDRpLoHv
	 i3KpXnCnmlgOcS/I/K7/4RZnhlcnONjv0RGlJlTetK+OSZQcxz84D2gDywgfHcNChv
	 pD85mheLgSa6gK9a5T3FFu5UbGBgJ5tPrz+AZnvVybnjUVdMDeaM5XqIgzzmXv9vBM
	 hslTx3hWKpuMfILAdb1ZV4Tq1syONoMHfzKGQxuF413ezJ68sX/BQM6E88v7kPGWtB
	 fC8z8k6RGKUJw==
Date: Wed, 19 Jun 2024 18:42:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Okan Sahin <okan.sahin@analog.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240619-pouring-evaluator-470155652a40@spud>
References: <20240619122105.22642-1-ramona.nechita@analog.com>
 <20240619122105.22642-2-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zWzIdbr3LJguoypS"
Content-Disposition: inline
In-Reply-To: <20240619122105.22642-2-ramona.nechita@analog.com>


--zWzIdbr3LJguoypS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 03:20:44PM +0300, Ramona Alexandra Nechita wrote:
> Add dt bindings for adc ad7779.
>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> new file mode 100644
> index 000000000000..f1eec656acec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD777X family 8-Channel, 24-Bit, Simultaneous Samp=
ling ADCs
> +
> +maintainers:
> +  - Ramona Nechita <ramona.nechita@analog.com>
> +
> +description: |
> +  The AD777X family consist of 8-channel, simultaneous sampling analog-t=
o-
> +  digital converter (ADC). Eight full =CE=A3-=CE=94 ADCs are on-chip. The
> +  AD7771 provides an ultralow input current to allow direct sensor
> +  connection. Each input channel has a programmable gain stage
> +  allowing gains of 1, 2, 4, and 8 to map lower amplitude sensor
> +  outputs into the full-scale ADC input range, maximizing the
> +  dynamic range of the signal chain.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7770.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7771.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7779.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7770
> +      - adi,ad7771
> +      - adi,ad7779
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

Why does this device have address/size cells, but not have any child
nodes? Are you missing some channel child nodes? If you don't have
children, you don't need these properties.

Also, your patch is still not threaded with the other 2 patches in the
series (I see 1/3 in the subject). Where are those patches?

Thanks,
Conor.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply
> +
> +  start-gpios:
> +    description:
> +      Pin that controls start synchronization pulse.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +- |
> +  #include <dt-bindings/gpio/gpio.h>
> +  spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +        compatible =3D "adi,ad7779";
> +        reg =3D <0>;
> +        vref-supply =3D <&vref>;
> +        start-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> +        reset-gpios =3D <&gpio0 93 GPIO_ACTIVE_LOW>;
> +        clocks =3D <&adc_clk>;
> +      };
> +  };
> +...
> --=20
> 2.43.0
>=20

--zWzIdbr3LJguoypS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMYhwAKCRB4tDGHoIJi
0ljnAQCua8lOT/HSJP8NZDAHBxmVeFj8Oa6o1ZcxDly4qE9TvwEA8+FFAZoo7WOx
+je7T8yijGxZsIl3Hap9aqSs4HeHlQI=
=2IPT
-----END PGP SIGNATURE-----

--zWzIdbr3LJguoypS--

