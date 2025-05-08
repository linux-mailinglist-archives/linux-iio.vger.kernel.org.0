Return-Path: <linux-iio+bounces-19307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAAAAAFD7F
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CABC7BDBDE
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A982741A9;
	Thu,  8 May 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/vm7AkM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780E2741CA;
	Thu,  8 May 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715318; cv=none; b=Q1thE8tgc94HeOp/HBXt3FX+LlKJ7xsmwDgALu6Z8wzWNgtggk+btTJV9w+Ay1VKQNdYb/DQrLMqC+7eETBuq0ZZj76NSOGs7jP5w6ilvCN6pXwbZ3y4WWkIfmci+8c5vASN9XYRZI7gyPz0aa2AcvMXWYpcWY+IZyIuJTfqEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715318; c=relaxed/simple;
	bh=2dvvwI2yZ3MJj1b3qX1/yXO1jKizCLwmkiJdxg3MfsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0tcpjtCckIm1/A79VGZecDrDHlyEWFTNycyklb3N6yn4WeE92OpftTuA/DzB7MB5T2ceJ8dyDU59LyFVk6JeIoLviMO9dLhR/zZ+40r5BQ6rSt3zSS3so1hiu6GI9OUPprt7dDESGYaOcyMNJTfLnFdq8WX0JvegqMVqpGa+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/vm7AkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F31EC4CEE7;
	Thu,  8 May 2025 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746715318;
	bh=2dvvwI2yZ3MJj1b3qX1/yXO1jKizCLwmkiJdxg3MfsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/vm7AkMR83r0RsRunfaAaHjxcndSoehbcy7wn0KidBhB/XP7bLIoCZ9AbQWBiqi3
	 8wOHDzN2kn6v5Hbs9nTDKMeiUWg+BvK4BHt8A/ag1dWXwQUNWZ8U0AkCaTotPf3aJN
	 PglpvnfKIcQkJWunB4T8HljQM1ymCJu539hkHpEkv+KktZXrjbWaRwnMCRpUlWSRwq
	 FrJ0SSEHbd0pSbh3FB2ZY015e0kzmyNlsyIqj5VYKt4ZoNMywmgzkKfISJf7gvjin/
	 OOQ+Ja/xnsiC9g4R63zcNa+p0XxgHuQe6L4QZq5Vv/90rbXCEUwlL0mlL7uDxi6Yln
	 hUbhzCEGiqRig==
Date: Thu, 8 May 2025 15:41:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: add ad7405
Message-ID: <20250508-brethren-rants-a3c80c091b45@spud>
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
 <20250508123107.3797042-4-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y7jWalb74cMUIFPa"
Content-Disposition: inline
In-Reply-To: <20250508123107.3797042-4-pop.ioan-daniel@analog.com>


--y7jWalb74cMUIFPa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 03:30:56PM +0300, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v2:
>  - remove  #address-cells and #size-cells
>  - add additionalProperties: false instead of unevaluatedProperties: false
>  - remove #include <dt-bindings/interrupt-controller/irq.h>
>    because it's not used
>  - add new line at the end of the file
>  - add mantainer
>  .../bindings/iio/adc/adi,ad7405.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> new file mode 100644
> index 000000000000..8c30a712968d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7405.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7405 family
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> +
> +description: |
> +  Analog Devices AD7405 is a high performance isolated ADC, 1-channel,
> +  16-bit with a second-order =CE=A3-=CE=94 modulator that converts an an=
alog input signal
> +  into a high speed, single-bit data stream.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7405.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7701.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7702.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
uM7703.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7405
> +      - adi,adum7701
> +      - adi,adum7702
> +      - adi,adum7703

These last three devices have the same match data, why is a fallback
compatible not appropriate? (Please list the reason in your commit
message).

> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  clocks:
> +    maxitems: 1
> +
> +  io-backends:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vdd1-supply
> +  - vdd2-supply
> +  - clocks
> +  - io-backends
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc {
> +        compatible =3D "adi,ad7405";
> +        clocks =3D <&axi_clk_gen 0>;
> +        vdd1-supply =3D <&vdd1>;
> +        vdd2-supply =3D <&vdd2>;
> +        io-backends =3D <&iio_backend>;
> +    };
> +...
> --=20
> 2.34.1
>=20

--y7jWalb74cMUIFPa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzCrwAKCRB4tDGHoIJi
0qJBAP4yuhKFZeze8aMu5rnLQiDh6tdA/1X464sK2nyshTk/ngEAutMZx9NJsfTD
dgMR9RpolZoTsAemJqV7QTUjKhpYTw0=
=sCd2
-----END PGP SIGNATURE-----

--y7jWalb74cMUIFPa--

