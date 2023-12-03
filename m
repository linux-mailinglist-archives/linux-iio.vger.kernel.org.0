Return-Path: <linux-iio+bounces-554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9018022B5
	for <lists+linux-iio@lfdr.de>; Sun,  3 Dec 2023 12:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1E81C20918
	for <lists+linux-iio@lfdr.de>; Sun,  3 Dec 2023 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A14947F;
	Sun,  3 Dec 2023 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os2huNSn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021E9461;
	Sun,  3 Dec 2023 11:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CD3C433C7;
	Sun,  3 Dec 2023 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701602675;
	bh=+hli562zk5dYtpGn2rXW8IygBpXXsf4LYyXt8bwX9bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Os2huNSnaTDA7CdOUExN3Wa+xKx51n8bWFYxm8eA4gj0wytV/c0WPB6H57qGpiunV
	 IGIL+3iWZwS+iFfByNCZ2BYUvdkh1/ULbjDpL2+Y+IjfZbM9EGEAyxvTHxH7A2fwxB
	 Dtxue4iTcEw0BB1IUhPoVFJTq79bOKdAqANc5sul1Qlqt9hvpoqlrYOEElotWE60n/
	 SBdJMGQRnkJF2fqJFpLq/1PGaSeDpBoEO86kaIOPMTZk/MJB0lwrcPntivqrAGrbMh
	 4Xm/wLJVsmnxT6Cf3sxoZoi2XNZKfaR6tivXRGiidDicxnibhZIH/tmi0W3h39GIH6
	 YHJ2SlnFznMLQ==
Date: Sun, 3 Dec 2023 11:24:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	lars@metafoo.de, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <20231203-wrecking-sneer-d34f19c39f04@spud>
References: <20231202041651.719963-1-alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VO1eO5mEsXF2CF0y"
Content-Disposition: inline
In-Reply-To: <20231202041651.719963-1-alkuor@gmail.com>


--VO1eO5mEsXF2CF0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 11:16:50PM -0500, Abdel Alkuor wrote:
> as6200 is high accuracy temperature sensor of -/+ 0.4C degree

Is +/- 0.4 degrees really "high accuracy"?

> with a range between -40C to 125C degrees
>=20
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
> Changes in v2:
>   - Add vdd-supply
>=20
>  .../bindings/iio/temperature/ams,as6200.yaml  | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams=
,as6200.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200=
=2Eyaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> new file mode 100644
> index 000000000000..a1817795cdca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/ams,as6200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS6200 Temperature Sensor
> +
> +maintainers:
> +  - Abdel Alkuor <alkuor@gmail.com>
> +
> +description: |

Please add the text from your commit message (although perhaps dropping
the "high accuracy" section) here.

Otherwise, this looks okay to me.

Thanks,
Conor.

> +  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> +
> +properties:
> +  compatible:
> +    const: ams,as6200
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temperature-sensor@48 {
> +            compatible =3D "ams,as6200";
> +            reg =3D <0x48>;
> +            vdd-supply =3D <&vdd>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...
> --=20
> 2.34.1
>=20

--VO1eO5mEsXF2CF0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxlbwAKCRB4tDGHoIJi
0vpyAQCfmd+i6NPXT2jdvO2gdFD/qBee+EWn0M4wbPRYUWeBFwEAiu4RIcctDI90
G7b23mXguq1l0mFtK5hAdkZjABenWAU=
=0u24
-----END PGP SIGNATURE-----

--VO1eO5mEsXF2CF0y--

