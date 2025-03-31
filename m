Return-Path: <linux-iio+bounces-17482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292C9A76B32
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E67416449A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733B12135DE;
	Mon, 31 Mar 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuwGriCr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A891E5205;
	Mon, 31 Mar 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436055; cv=none; b=kF/9M7TiI5hBrbFpufD2ziHxdB6/ciSY1EtXL96E4aSxfhRVRaQQfD3dvB+8q5pfcByuIIGowHfwGkPRP8T4/uAsVkV4/2WwVgtBO5mUcHb/qY+ZMO5a5cEsbz8mhQd2zywdPJHAvL8Ggz5oJwDRpxKZkSKJoVXG/8NBOGYZvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436055; c=relaxed/simple;
	bh=KzXRrsPeQsl8HhrdCfDzKEScyF0j+n+lAMfsL555uPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aerHJ7vPzxpVs+/Q1+EwJ0EOEJYgayZY87LvbmZ9pwwSS14nUxPJv1tVlmBcLO6+6Y3gjcYMcOaAzwu6Voea+4nvHHyyUgZ6z/TgtkVphS9OeIGZ4fcroQ5L89/tqj0vH9vJRF+ln2TQl2rxM2oIAkQ+EW+W2eC3lMNuBbaK/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuwGriCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14547C4CEE3;
	Mon, 31 Mar 2025 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743436054;
	bh=KzXRrsPeQsl8HhrdCfDzKEScyF0j+n+lAMfsL555uPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuwGriCrm9kWPVdofZzqdYT/cdzRRvBUohTQn1r6RUTaIba5/i883qxVq2JOYj1Nk
	 Et4G/w7BIordLZWDTBFfmlBrdUHdAr4GjKa17mj0iP3VWhsdcVO19cHcxAEXu7JmwK
	 BI0To6PsAicMphMub+LZ3CrXGqc5Pkia9JjK8oJL/iazH3veOISTFgRuW6pd3n2VBP
	 JKfznkCU6ON4NHExZC8aE+fKVhMIPWhlzGwdDz8ShyEmb9UzLsuwShRUDBGkwRo56w
	 sgGnOJjBlI9ZDJzZHCNSd4K5SHQO/8wapzP/VQH5vt8W0dfxf5nb5cRdundhgj3c1O
	 Svn3wvNvMoy/g==
Date: Mon, 31 Mar 2025 16:47:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: ROHM BD79104 ADC
Message-ID: <20250331-chooser-superbowl-2dfa754e8d05@spud>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
 <4ccc6d33ffb0fd29f02afcb9124a0f72f571a0cd.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oWSFxBmn7AniXwQi"
Content-Disposition: inline
In-Reply-To: <4ccc6d33ffb0fd29f02afcb9124a0f72f571a0cd.1742474322.git.mazziesaccount@gmail.com>


--oWSFxBmn7AniXwQi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:02:20AM +0300, Matti Vaittinen wrote:
> The ROHM BD79104 is a 12-bit, 8-channel ADC with two power supply pins,
> connected to SPI. It's worth noting the IC requires SPI MODE 3, (CPHA =3D
> 1, CPOL =3D 1).
>=20
> I used an evaluation board "BD79104FV-EVK-001" from ROHM. With this
> board I had problems to have things working correctly with higher SPI
> clock frequencies. I didn't do thorough testing for maximum frequency
> though. First attempt was 40M, then 20M and finally 4M. With 20M it
> seemed as if the read values were shifted by 1 bit. With 4M it worked
> fine.
>=20
> The component data-sheet is not exact what comes to the maximum SPI
> frequency. It says SPI frequency is 20M - "unless othervice specified".
> Additionally, it says that maximum sampling rate is 1Mhz, and since
> reading a sample requires writing the channel (16 bits) and reading
> data (16 bits) - we get some upper limit from this.
>=20
> From the "frequency is 20M, unless othervice specified" I picked the
> maximum frequency 20M - and did assumption that my problems with 20M
> weren't related to the BD79104 - but to the evaluation board
> "BD79104FV-EVK-001".
>=20
> Add bindings for the ROHM BD79104 ADC.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../bindings/iio/adc/rohm,bd79104.yaml        | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd7910=
4.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml =
b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> new file mode 100644
> index 000000000000..2a8ad4fdfc6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/rohm,bd79104.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM Semiconductor BD79104 ADC
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description: |
> +  12 bit SPI ADC with 8 channels.
> +
> +properties:
> +  compatible:
> +    const: rohm,bd79104
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  iovdd-supply: true
> +
> +# The component data-sheet says the frequency is 20M. I, however, found
> +# that the ROHM evaluation board BD79104FV-EVK-001 had problems with 20M.
> +# I have successfully used it with 4M. My _assumption_ is that this is n=
ot
> +# the limitation of the component itself, but a limitation of the EVK.
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - iovdd-supply
> +  - spi-cpha
> +  - spi-cpol
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "rohm,bd79104";
> +            reg =3D <0>;
> +            vdd-supply =3D <&vdd_supply>;
> +            iovdd-supply =3D <&iovdd_supply>;
> +            spi-max-frequency =3D <4000000>;
> +            spi-cpha;
> +            spi-cpol;
> +            #io-channel-cells =3D <1>;
> +        };
> +    };
> +...
> --=20
> 2.48.1
>=20



--oWSFxBmn7AniXwQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+q5EQAKCRB4tDGHoIJi
0iiRAP4vx0/h8dzdOHLKqJGmu0soxU8l51q5TjUpjlmqOt5+4QD/eJ/QyJtHS5iH
W2MyH8jVdJLKRv5VYvlvPb3pWogv3AQ=
=uoyk
-----END PGP SIGNATURE-----

--oWSFxBmn7AniXwQi--

