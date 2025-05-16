Return-Path: <linux-iio+bounces-19595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C7AB9E80
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CEB166A93
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E71898FB;
	Fri, 16 May 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWXG33jt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844A1632DD;
	Fri, 16 May 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405113; cv=none; b=ruvBkkgK3UJ29487jWHqVUMkItZYJLBb+wV1rxa2e1Mzv7Hrt+Ji6gKPbi3mTNIgVX6m8ldJMIUODL83ZNVvCtMKbfICB4NsFcJs3xumexN1iYsXA76Dan06GJx4euElafRFrFexmSk7ZcHrlHQK/A0ovZiiRNx2qiQwSy7HfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405113; c=relaxed/simple;
	bh=wJC6zw4ize8YvwX8KINR0uybINw/Jty0tJPjNkm1idc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSaxyY/RULiVrdXI8Ler8aPust1Wqef6qQ03+aVZ6tMJrlgNBwwCoWSE9vrxa9ZlX3FhGwxg+XG1gOD8ef6M1XBOEan+Dloy7XSLH7bS/4zxzAhWOkHn03/75fwLljhaINsQAjVqi8kyS6L1uXFIP3KCcjpIUc43t4N3EL/WTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWXG33jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD18FC4CEE4;
	Fri, 16 May 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747405113;
	bh=wJC6zw4ize8YvwX8KINR0uybINw/Jty0tJPjNkm1idc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWXG33jt+z9gQJKbLLztRaIhXu3GxC1mAa0ZSlSKQm4IUJrXys/tLQgoGbEyVpyzM
	 Qkm/KgG7O9POchBxw24pZSWhDuSVXN8Uq3SJ6t/fpj/U+LZY4DBL6KVdey57i1t107
	 Wz8m0xxe5beLiFlhw50FKELh6evnhdQeRWIez/HvjJe4JM7SMKb41KReJ1EKkgDVa5
	 ON3tGUogQzuKCn/x+F8hSYJdrXps3pXqwKiyMCyd74KSJf1heyoHdnUXD1v58AxsAq
	 DRPJ10U3WnmwNAeUyRM2bJwlqTeCfAfRS9jybP5N90hW04pb0QPs2twM8qtkGgiElS
	 vgs7yd6MmjdKw==
Date: Fri, 16 May 2025 15:18:26 +0100
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
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: adc: add ad7405
Message-ID: <20250516-moonshine-engine-006e72665702@spud>
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
 <20250516105810.3028541-4-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zCsU3JcOku4xXmfF"
Content-Disposition: inline
In-Reply-To: <20250516105810.3028541-4-pop.ioan-daniel@analog.com>


--zCsU3JcOku4xXmfF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 01:58:03PM +0300, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v2:
>  - fix properties: clocks issue
>  .../bindings/iio/adc/adi,ad7405.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> new file mode 100644
> index 000000000000..939de3bd6f26
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
> +
> +  clocks:
> +    maxItems: 1
> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  io-backends:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - vdd1-supply
> +  - vdd2-supply
> +  - io-backends
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc {
> +        compatible =3D "adi,ad7405";
> +        clocks =3D <&axi_clk_gen 0>;

No reg here, how do you actually access this device?
Is it entirely via the backend?

> +        vdd1-supply =3D <&vdd1>;
> +        vdd2-supply =3D <&vdd2>;
> +        io-backends =3D <&iio_backend>;
> +    };
> +...
> --=20
> 2.34.1
>=20

--zCsU3JcOku4xXmfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCdJMgAKCRB4tDGHoIJi
0ttWAQCZHPR/d5g4pOwzwPU+IPLwJ/U2F1ULaSQn8yETrxSQWAD+ONIA7VlcVA3U
hsAHlnrxHmukjdGZA9cYEdL/iJeBug8=
=hq22
-----END PGP SIGNATURE-----

--zCsU3JcOku4xXmfF--

