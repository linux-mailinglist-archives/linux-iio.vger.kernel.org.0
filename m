Return-Path: <linux-iio+bounces-13165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53C19E7630
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786F816FBEA
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C5206280;
	Fri,  6 Dec 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGGe2du/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98587819;
	Fri,  6 Dec 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502822; cv=none; b=YECPcu0IfLcRQcb+9cowtnxq1pr/v3OQeuIlN+/nT/qDIMr1OnBXWD6B+mOoqFzghwpJW0QL1kOlsjX1QTo8B8iRXnQsSVctQuGsfdQbx+1X5WSgtLm3MPZ5tn9YQGBp4o+niyUhkzPtkcJ1SFFUzI+pJ3ZAbdaBlBPC+UZ9uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502822; c=relaxed/simple;
	bh=9y1+vsY+ID1gTNCrI46KXa9fHSZpo0s8rUUbGfZ3V9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ygnk87fsRDrtLqVvOQLjOGl2/IN1+mlhvLvWVzkt/3GDLggOmBcBKxM+2o2W0WphSBTC5tLMP4xPMEa6Eax1ajY5Rg0+IzjSvRfe35IzmJFtC+a6DuMQIPCLZqd8B0Kk/4bPsxzSsWjpAsWdmFTk5FWuyv6UqOtGY+CGKIL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGGe2du/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B32EC4CED1;
	Fri,  6 Dec 2024 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733502822;
	bh=9y1+vsY+ID1gTNCrI46KXa9fHSZpo0s8rUUbGfZ3V9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGGe2du/lq3PObK5V04bP8LdRUTAc8aE6624SpbgdWjWtohOP2AQ6Kd92Yltu8NO6
	 YNUzmsDZQubE9UmQRnNfsT2l6GaWUpIapB9ktRF5gKmoUu0Jsvy9iEJp+9/XUkIwQY
	 vEcnw4xo0T0fTNS6hzw9BDJP5i90y9nG+0TepevKtkhYkicaHm5IPrLKz5oEPmMt0x
	 b/0NhnE6j2BSTJNt4YDNLw/WsSKTXkWtRYIwTDpFTMhtr520gUdTjeOCWtqzdyAKqe
	 OexBPSqPKDM6HHGJtVs8/A42GlKw1L+n0JfKNDVuzXoZUnb+4P9y7zerLf+ifFcEz2
	 ulhdTSTX4tjGQ==
Date: Fri, 6 Dec 2024 16:33:36 +0000
From: Conor Dooley <conor@kernel.org>
To: mgonellabolduc@dimonoff.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20241206-comment-tissue-7964de6bdcd3@spud>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
 <20241206-apds9160-driver-v2-1-be2cb72ef8f4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ouAae0tIUe+UFjOn"
Content-Disposition: inline
In-Reply-To: <20241206-apds9160-driver-v2-1-be2cb72ef8f4@dimonoff.com>


--ouAae0tIUe+UFjOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 11:09:56AM -0500, Mikael Gonella-Bolduc via B4 Rela=
y wrote:
> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
>=20
> Add device tree bindings for APDS9160 driver

Bindings are for hardware, not for drivers.

>=20
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> ---
>  .../bindings/iio/light/brcm,apds9160.yaml          | 51 ++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.ya=
ml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..525fba52f156df3b78e24d7d0=
d445fe9d882eaa7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Combined Proximity & Ambient light sensor
> +
> +maintainers:
> +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>

How come this differs from your author email?

> +
> +description: |
> +  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,apds9160
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
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
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        light-sensor@53 {
> +            compatible =3D "brcm,apds9160";
> +            reg =3D <0x53>;
> +            vdd-supply =3D <&vdd_reg>;
> +            interrupts =3D <29 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&pinctrl>;
> +        };
> +    };
> +...
>=20
> --=20
> 2.34.1
>=20
>=20

--ouAae0tIUe+UFjOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1MnSQAKCRB4tDGHoIJi
0t9gAQCHg84i1MxD/nka3fR1QIegxvYKRVcjpUYK86gy50AqVwEA6HranbygYVQ2
zidID8FwePAJ5NmyU06wlzilgcw/dg8=
=nDyF
-----END PGP SIGNATURE-----

--ouAae0tIUe+UFjOn--

