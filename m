Return-Path: <linux-iio+bounces-7256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C276492646D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796691F20F5F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8D217E904;
	Wed,  3 Jul 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq1w0hud"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BD17C205;
	Wed,  3 Jul 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019412; cv=none; b=ut85tyjv4JQa+EMSlJ3tMu0qZu7caMxwe+CR9nbwM5wSK2ZUt+Quh7QBmWLZpXSqaXNjb/YT1E3Y8JBCeGyOBxATKfb8GBYEIcBL0GR3PE0ScIpIuDRHm4e9DBRlRqHbqNApaP9EfJ1qgGV8rIbvvhUhjUiRtL05A+hJk3OC4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019412; c=relaxed/simple;
	bh=zQh4GCVNLnNssHoNRrZyjyLjjoT1Lg/AVexHRFwV0K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvwpH6mmQPhn0iwvp9MkWpdInL3RXeGlPsOLkyqn8s1IfJlYXOUidjwa+MK3SIeId/JuiWLPG6I3PDjMXBSp8HdEGvBsI6VwYnD0SeF0iReC1bYeIFxb602NGhsLKjQLp9m1ujc+VHoWR4NIM82Yqm7YBnniHq5etFjfjqNjhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq1w0hud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C781AC3277B;
	Wed,  3 Jul 2024 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019411;
	bh=zQh4GCVNLnNssHoNRrZyjyLjjoT1Lg/AVexHRFwV0K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dq1w0hudNJuP5JlGv/g48GasoR3puhzDepPgzAyCZLkx2vTZQj9XBsVEqwuYb/hJW
	 tZxR3Ho10z4Kq7p5wkjq3ZM1k8KnNVqfv5F0VZjqqZzYeAbP2iyJeZ5e61WD1UxND2
	 oMjIqZSYDaiRYvfym0Z0c/P1ZrxYTU8KuFlTShYXLx/Hhr1yK80nlxVPqOOQZxCi3s
	 1t24HaCcMzuh5akdAwYe5prPjpAY6efgRx+js+9NEwtUc5nMx8hzQGK7wTL3b9jH6y
	 iyyX+N5rjRjPrbTIE1x6JaqBWiE0TOCSR1ouMDThUgG6YLr/sak5URbn0fneyr6ejR
	 xUsq/Xbje6GLw==
Date: Wed, 3 Jul 2024 16:10:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add binding for pac1921
Message-ID: <20240703-bovine-thumping-c3747fd7caa1@spud>
References: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
 <20240703-iio-pac1921-v1-1-54c47d9180b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VlbABFsqndUOu9zD"
Content-Disposition: inline
In-Reply-To: <20240703-iio-pac1921-v1-1-54c47d9180b6@gmail.com>


--VlbABFsqndUOu9zD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 03, 2024 at 03:34:35PM +0200, Matteo Martelli wrote:
> Add binging for Microchip PAC1921 Power/Current monitor
>=20
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  .../bindings/iio/adc/microchip,pac1921.yaml        | 79 ++++++++++++++++=
++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
> new file mode 100644
> index 000000000000..ec08228dcc16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1921.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1921 High-Side Power/Current Monitor with Anaog Outp=
ut
> +
> +maintainers:
> +  - Matteo Martelli <matteomartelli3@gmail.com>
> +
> +description: |
> +  The PAC1921 is a power/current monitoring device with an analog output
> +  and I2C/SMBus interface.
> +
> +  Datasheet can be found here:
> +  https://ww1.microchip.com/downloads/en/DeviceDoc/PAC1921-Data-Sheet-DS=
20005293E.pdf
> +
> +properties:
> +  compatible:
> +    const: microchip,pac1921
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value in micro Ohms of the shunt resistor connected between
> +      the SENSE+ and SENSE- inputs, across which the current is measured.
> +      Value is needed to compute the scaling of the measured current.
> +
> +  label:
> +    description: Unique name to identify which device this is.
> +
> +  microchip,dv-gain:
> +    description:
> +      Digital multiplier to control the effective bus voltage gain. The =
gain
> +      value of 1 is the setting for the full-scale range and it can be i=
ncreased
> +      when the system is designed for a lower VBUS range.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32]
> +    default: 1
> +
> +  microchip,di-gain:

Why is this gain a fixed property in the devicetree, rather than
something the user can control? Feels like it should be user
controllable.

> +    description:
> +      Digital multiplier to control the effective current gain. The gain
> +      value of 1 is the setting for the full-scale range and it can be
> +      increased when the system is designed for a lower VSENSE range.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +    default: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - shunt-resistor-micro-ohms

You're missing a vdd-supply btw and the !read/int pin isn't described
here either. I think the latter needs a property to control it (probably
a GPIO since it is intended for host control) and a default value for if
the GPIO isn't provided?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@4c {
> +            compatible =3D "microchip,pac1921";
> +            #io-channel-cells =3D <1>;
> +            label =3D "vbat";
> +            reg =3D <0x4c>;

Order here should be compatible, reg, generic properties and then finally
vendor ones.

Thanks for your patch,
Conor.

> +            shunt-resistor-micro-ohms =3D <10000>;
> +            microchip,dv-gain =3D <4>;
> +            microchip,di-gain =3D <32>;
> +        };
> +    };
> +...
>=20
> --=20
> 2.45.1
>=20

--VlbABFsqndUOu9zD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVpzwAKCRB4tDGHoIJi
0iYPAPwOEcwOJ93bjA1zJvtsgZdmj04xjexLwZkXqb24oCC44QD/RRz+0OhjiMP9
qyLjfj/5kifjtDd3gFcVqqT4g5G4BQs=
=n7MM
-----END PGP SIGNATURE-----

--VlbABFsqndUOu9zD--

