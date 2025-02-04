Return-Path: <linux-iio+bounces-14990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219FA27B27
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9193A2C33
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD2216E29;
	Tue,  4 Feb 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkegLUID"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C4204F8B;
	Tue,  4 Feb 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697136; cv=none; b=MU6/qB5GBA2hLIbslC1SEJ1dxPmTSBARc8Sn0X4ZdfdVwut+poCpM2fgki9Q0sopWC3jol9VRM6IgNmQWINSWbnxtf8lpJ11Eo8/fPuQroypjaRJ6xDHiBlL6V7L88kyMT8Q8d99T//mfwKz1CU9laEFKgYV4TDtXLrS0hckdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697136; c=relaxed/simple;
	bh=C6Iapfq1eN3KSPLnP8LaEMpuydv5QeVLO70ImxSYOeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBYgQiiaXOAfxl6VcPuxEQ3DxWjHfB2YzAnopVcjfggzIphSl1CwhoHd4Dzy1CHkUVCjFJvo0ajLHWH52FOXlHSMWKzb+RUC5NgoqJYPYjkJkQqRQg7dtfAhgEWbpOOxTtYzGLyJSQOeXUodV2Iki8ldB6wOlBeZ6dKQtYt4ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkegLUID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8918EC4CEDF;
	Tue,  4 Feb 2025 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697136;
	bh=C6Iapfq1eN3KSPLnP8LaEMpuydv5QeVLO70ImxSYOeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkegLUIDoeeFsitVAc7ehJ4HIo4qixvTQGtxNEjREDzypAC/nbQUqmXamK3uOxlBQ
	 ISalFDepIxyck7aBS61AnsBeiVBfDhPB8SG6G07VxUQQZ57RVgdRyOph2cgsfxSazZ
	 1hUcF6PGxNuNoPVunSxZXv0NXkIBjo3Z68qCew1E+Nbg5jTaaAhDM3S74whlmjCQ2T
	 gamzu4Bp0mUaM4DSliYvYKPRxyvyPeplVjX/8HjFmFE1F7Ew8LY2zj86KzhtdBiTKA
	 vZRVEuR3T8QeF4UlppsxWZbmW4qXrcV1S8pUO1zPx0M/bWQOkGsV3sAyHPUqJMNqx4
	 jwhyJvQ8/LlQg==
Date: Tue, 4 Feb 2025 19:25:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Paul Cercueil <paul@crapouillou.net>,
	David Lechner <dlechner@baylibre.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20250204-helium-marbled-a0863a0a18a8@spud>
References: <20250204143612.85939-1-robert.budai@analog.com>
 <20250204143612.85939-5-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lomlFNdTSMH+4T1Z"
Content-Disposition: inline
In-Reply-To: <20250204143612.85939-5-robert.budai@analog.com>


--lomlFNdTSMH+4T1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 04:36:08PM +0200, Robert Budai wrote:
> Document the ADIS16550 device devicetree bindings.
>=20
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>=20
> v6:
> - applied blank line suggestions
> - added clock-frequency dependency change suggestions
> - yamllint corrections
>=20
>  .../bindings/iio/imu/adi,adis16550.yaml       | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis165=
50.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> new file mode 100644
> index 000000000000..8750bb937979
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16550 and similar IMUs
> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Ramona Gradinariu <ramona.gradinariu@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16550
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 15000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  clocks:
> +    description: If not provided, then the internal clock is used.
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: Clock frequency in Hz when an external clock is used.
> +    oneOf:
> +      - minimum: 1
> +        maximum: 128
> +      - minimum: 3000
> +        maximum: 4500

I don't get why this is a property, to be honest. When you've got an
external clock, why isn't the frequency obtained from the clock provider
node?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - spi-max-frequency
> +  - vdd-supply
> +
> +dependentRequired:
> +  clock: [clock-frequency]
         ^
typo, missing s.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +additionalProperties: false
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        imu@0 {
> +            compatible =3D "adi,adis16550";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <15000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            vdd-supply =3D <&vdd>;
> +            interrupts =3D <4 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&gpio>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6247500cf427..8913e13dcaef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1452,6 +1452,15 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>  F:	drivers/iio/imu/adis16475.c
> =20
> +ANALOG DEVICES INC ADIS16550 DRIVER
> +M:	Nuno Sa <nuno.sa@analog.com>
> +M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> +
>  ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-hwmon@vger.kernel.org
> --=20
> 2.39.5
>=20

--lomlFNdTSMH+4T1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6JpqgAKCRB4tDGHoIJi
0lTiAP9e6BRlww3AQv+1TYSurfPow3DxH41y1tAXXv4SEgN/zgEA5cDzyf95Jnme
0lIESiiWqveA1p+YjP24DyX6NbeWpQ4=
=Kcg6
-----END PGP SIGNATURE-----

--lomlFNdTSMH+4T1Z--

