Return-Path: <linux-iio+bounces-8365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1330894D209
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E552845C3
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA0195FEC;
	Fri,  9 Aug 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANKKWbci"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D541E49B;
	Fri,  9 Aug 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213180; cv=none; b=ea4NOnSiWcyp09ZvFXaut6O8aetwQbdxvHzXgACJbh1PeGvQlddJ+fhYbz2Pu/Q+nIfbaKyxJhvwqVg1DqaJErgzUZo45Fa59NAJxxWSU4ysDa9Jukkk2U7EX2c23pHYTsBaooDvHOKOFlmwz/SW6xf6xfDRwBj3SEutkVri/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213180; c=relaxed/simple;
	bh=Q1GREfp3xB2sDVSRO/f0mhNu4LfbXqzzd//VQfZmxck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os/m4L+pGCMNl2wDHbnzjafV9OwYQODb4bJylFL8UQekdMkeyMXdKAPGjuGiv/Two4WhrmIxbDkwuRbE+dPd9UnJChhtrKQmY9+GtqZn5a0rS6MUXVW6tKszi7ULc0jBvhwpR9KER+0n5mMMlLppZ3k1DazwbNNCAuKrIU+ZBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANKKWbci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECC0C32782;
	Fri,  9 Aug 2024 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213179;
	bh=Q1GREfp3xB2sDVSRO/f0mhNu4LfbXqzzd//VQfZmxck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANKKWbciiJnJH37Y811R4u5kjsRVnZ49Y6NTAODTalZO1r40oQ0ZWy+VhFp9ZP/i+
	 jKAyJqIXJCIAxLlWQMOQ2cQ3Uhx/UIezzgPzSTw5pl2x7s06zlxTCEcyiBuy2RVhEd
	 nsRWCH9WoOXhdOJMNk9ztx6jR55A9DzT0mcXduvVKIXgCXV7JVBRI5LIbZcrTOu+M1
	 /p2KD+i2lLBJGP/9DHsZmMrOez6qr0vhy9J+idaMiRC2emjQzUmQ5hs1OqDEO8V9QG
	 NJeflUJHjQbxYbxHEeURVGHHpZ67NG4x+PY3IRy36q5Attr/Bz9+sRBH2ugDgZYkkV
	 dK/7W0oQHa9GA==
Date: Fri, 9 Aug 2024 15:19:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: smi240: devicetree binding
Message-ID: <20240809-enlarging-harpist-49d323f0ddac@spud>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s+bgNCWnHGshQukl"
Content-Disposition: inline
In-Reply-To: <20240809111635.106588-2-Jianping.Shen@de.bosch.com>


--s+bgNCWnHGshQukl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 01:16:34PM +0200, Jianping.Shen@de.bosch.com wrote:
> From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
>=20
> dt-bindings: iio: imu: smi240: dt-binding improvements

The commit message here doesn't make much sese, you're adding a new
file. Something like the description in the binding below would be a
better fit than what you have.

> Signed-off-by: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>
                               ^^^^^^^^^^^^
If this is not part of your name, or a client of Bosch that you want to
attribute authorship to, remove it.

> ---
>=20
> Notes:
>     v1 -> v2
>     - Add more detail in description
>     - Add maintainer
>     - Add vdd and vddio power supply
>     - Use generic node name
>     - Order the properties according to DTS coding style
>=20
>  .../bindings/iio/imu/bosch,smi240.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi24=
0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml =
b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> new file mode 100644
> index 00000000000..0529e67de26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch smi240 imu
> +
> +maintainers:
> +  - Jianping Shen <Jianping.Shen@de.bosch.com>
> +
> +description:
> +  The smi240 is a combined three axis angular rate and three=20
> +  axis acceleration sensor module with a measurement range of=20
> +  +/-300=B0/s and up to 16g.

> smi240 does not support interrupt.

You can, drop this, don't think it's worth mentioning in the
description.

> +  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-dri=
ving/smi240/
> +
> +properties:
> +  compatible:
> +    const: bosch,smi240
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: provide VDD power to the sensor.
> +
> +  vddio-supply:
> +    description: provide VDD IO power to the sensor.

I think the descriptions for these are not really worth having and can
be replaced with "vddio-supply: true" etc.

> +
> +required:
> +  - compatible
> +  - reg

However, the supplies likely are required to function and should be
added to the required section.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        imu@0 {
> +            compatible =3D "bosch,smi240";           =20

You have trailing whitespace after this line.

Cheers,
Conor.

> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--s+bgNCWnHGshQukl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYldgAKCRB4tDGHoIJi
0uNcAP9l6rZF9WJwxEuVPR/cb1t9nJDyLveMmQ5G/NFOvi6EbQD9FLvD0TAN2Z32
FsXXZHoARqvg1rNg5wVDBhbzt0cjNAM=
=Gcf2
-----END PGP SIGNATURE-----

--s+bgNCWnHGshQukl--

