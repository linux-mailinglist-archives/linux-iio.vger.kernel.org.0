Return-Path: <linux-iio+bounces-17974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF48A8637F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200F13A475A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52F521D3E8;
	Fri, 11 Apr 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLD1WqX4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091126AD9;
	Fri, 11 Apr 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389716; cv=none; b=FrJ+MVvb0x1Lc4i1vnJuHMROHCKAuadHeq9TsG6bhSRR/SRREq9OcjDf2upTOL6vSaTnVMcZADp7Vi+ss4nJhr3tOs6xZXNk02pzhuAbsgApjJ9AwnN0HzbTvOT4vB3RTdPe9aFoN1WlV7pSYwuuBryxXZk17Wo7P3dRD0am7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389716; c=relaxed/simple;
	bh=xaMRMlTtmiorF03h9x3YHc65UTX8uhiWTBu1Taoe374=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7J67tYJon1swAovYaHUl0Qi03/YPKf3IxdUXjXWwDmZKgKJ6dBg3cuGVGrKSy034DrC66X+nxLe49i5GRKp1dSaMPvtrlAFl0yN03HqxWIF/iNBQx2mt3YJBz69ENOFelz804SIbfr9s+vU0rgpIsKtCoyqQn2h893LCPkQs4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLD1WqX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7C8C4CEE2;
	Fri, 11 Apr 2025 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389715;
	bh=xaMRMlTtmiorF03h9x3YHc65UTX8uhiWTBu1Taoe374=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLD1WqX4ab75yFVpKv2FcEREcmt3iBpBkjUewnQOhwK42G0X+kiji/eBqs9qiRi7j
	 o03/KZkAUfRuE304X3JnxetAeh0OQZUyjRNk4mSUUiOfP/Z3Q3KQUj9Ri3ajE0uDNn
	 hJ5JenE5lQRYfEBW46qj62xFigF/1zHNL2hlkZ4T8/yueY4xjpYxWhSCeBmH7Nb6LR
	 4dC5kNYN5XxikiDvg6TAq4LbdI0e33Qbyo69gVgB5bae/mhXTNiodpL09wLb7q69ij
	 ZbbpuUt9ul4VDTNWHsRubVO6exM/HpJ4Bvafe+JXbIijkbBcEJ0/cg9/WD+qSEgyQ7
	 5N0AYmKgUwfwQ==
Date: Fri, 11 Apr 2025 17:41:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v5 01/14] dt-bindings: trigger-source: add generic GPIO
 trigger source
Message-ID: <20250411-lavender-font-8166f4e8d2f4@spud>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <414f5b60b81f87f99b4e18b9a55eb51f29d2225a.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RrRdRgf73VRrx37C"
Content-Disposition: inline
In-Reply-To: <414f5b60b81f87f99b4e18b9a55eb51f29d2225a.1744325346.git.Jonathan.Santos@analog.com>


--RrRdRgf73VRrx37C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 12:56:04PM -0300, Jonathan Santos wrote:
> Inspired by pwn-trigger, create a new binding for using a GPIO
> pin as a trigger source.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v5 Changes:
> * New patch in v5.
> ---
>  .../bindings/trigger-source/gpio-trigger.yaml | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio=
-trigger.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/trigger-source/gpio-trigge=
r.yaml b/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> new file mode 100644
> index 000000000000..d77d62050179
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/trigger-source/gpio-trigger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic trigger source using GPIO
> +

> +description: Remaps a GPIO pin as a trigger source.

Just a minor comment about the description, "remaps" is a very software
term, I think you can just say "A GPIO used as a trigger source" and be
fine.

> +
> +maintainers:
> +  - Jonathan Santos <Jonathan.Santos@analog.com>
> +
> +properties:
> +  compatible:
> +    const: gpio-trigger
> +
> +  '#trigger-source-cells':
> +    const: 0
> +
> +  gpios:
> +    maxItems: 1
> +    description: GPIO to be used as a trigger source.
> +
> +required:
> +  - compatible
> +  - '#trigger-source-cells'
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    trigger {
> +        compatible =3D "gpio-trigger";
> +        #trigger-source-cells =3D <0>;
> +        gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +    };
> --=20
> 2.34.1
>=20

--RrRdRgf73VRrx37C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/lGTQAKCRB4tDGHoIJi
0rd1AP0YWT3Dz4Wu/ePsOSEYDNa2yoK+llqWzkmYZ27BHEltrAD8CRGqWdZOLeIb
6kL9ErCkDa6D0rfL4a6sbVKO/l1Ikwo=
=aQYv
-----END PGP SIGNATURE-----

--RrRdRgf73VRrx37C--

