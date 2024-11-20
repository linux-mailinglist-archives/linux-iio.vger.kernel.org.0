Return-Path: <linux-iio+bounces-12424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8559D40FA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 18:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6C41F22421
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D01AA1FB;
	Wed, 20 Nov 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWrt0pki"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3E5A4D5;
	Wed, 20 Nov 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123126; cv=none; b=rf5wafy6wF/5sJHPTkiRHGuHiiBDaVfKsm9QbihR6mobXioZieQH+TBczvk0WM3Ij1D/ps4hPClVKuxfWAMcZeFcuzQ0CsdzYOWQ5mtDxFyX9AEw+XNMKZsVeE3HzElHOIVQ1/JR5KUSj+D6N0fz9+0+TtlSB/VxgHy58M4ejYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123126; c=relaxed/simple;
	bh=Z0pr7ju78IJ6A2dquBo/UIbHx1DH8qaOUr9hRKU4fnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5HU4tlpSzD7GwSt5vzxxggjnLBZZTbPi6zD3JtfpuhaVdsdXDVFXrOOUFA2tDIvsQyqE0mmzrDNVQRkT98lIaxufXtWgkXMT5FMZGGR7QqD6g9BY641sy1uQc95dRndRonASovCw8pxCtahyDDFtVnz7eVea/XnnrqwxdKPxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWrt0pki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F27C4CECD;
	Wed, 20 Nov 2024 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732123125;
	bh=Z0pr7ju78IJ6A2dquBo/UIbHx1DH8qaOUr9hRKU4fnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWrt0pki5hrDDRzOcLtbuU1Pr7CdwzOaGmFO2lWyTrAma0ZVNMR5HguVFBMCfFX4Q
	 QWVZHZegHvpmnYPKpmG+Ev9bKXzO/hYPCHkdGH0I33VE/o7nzCpEJ8wst24ZIy5BQR
	 Rd5uHXw730z/d7ohASqs1E3pJuDmZnks0z+39hcH1Z8frKoxGRImVT1gQDVkbgOV5J
	 4KpwjmrESO6PQEa5ObShp1S2widCuuA3tlsCrf/gYQCoU0Z/X91Jdzdw9NEJGADUah
	 VU3q8qzH8XWd+xN3A3r6yquvNylE9bWaBbqZ+sIXi9Fq7YAZBdeC5h6vnRgQLfywtS
	 iO8xhP15E2BwA==
Date: Wed, 20 Nov 2024 17:18:40 +0000
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
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20241120-case-guy-7456f9f850fa@spud>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
 <20241119-apds9160-driver-v1-1-fa00675b4ea4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MfqXDEob/mz4hwMu"
Content-Disposition: inline
In-Reply-To: <20241119-apds9160-driver-v1-1-fa00675b4ea4@dimonoff.com>


--MfqXDEob/mz4hwMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 03:36:56PM -0500, Mikael Gonella-Bolduc via B4 Rela=
y wrote:
> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
>=20
> Add device tree bindings for APDS9160 driver
>=20
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> ---
>  .../bindings/iio/light/avago,apds9160.yaml         | 50 ++++++++++++++++=
++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9160.y=
aml b/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..12e196b297fe523e4d3241560=
41ef9c6900676eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/avago,apds9160.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Combined Proximity & Ambient light sensor
> +
> +maintainers:
> +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> +
> +description: |
> +  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
> +
> +properties:
> +  compatible:
> +    enum:
> +      - avago,apds9160
> +      - broadmobi,apds9160

What is the difference between these two devices? There's no match data,
makes it seem like there should be a fallback going on here.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        apds9160@53 {
> +          compatible =3D "broadmobi,apds9160";
> +          reg =3D <0x53>;
> +          interrupts =3D <29 IRQ_TYPE_EDGE_FALLING>;
> +          interrupt-parent =3D <&pinctrl>;
> +        };
> +    };
> +...
>=20
> --=20
> 2.34.1
>=20
>=20

--MfqXDEob/mz4hwMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz4Z8AAKCRB4tDGHoIJi
0irIAQCFplUzuvBHohSHEWOpiepgMv3yKQgtT7Nymecs6VPtWQD+KPrWLB6VEpX6
R7Q5I91n6XO8l2Xn5Yeoh/PBP+VhzAQ=
=3+si
-----END PGP SIGNATURE-----

--MfqXDEob/mz4hwMu--

