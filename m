Return-Path: <linux-iio+bounces-7705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA958934FB9
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B79DB239B1
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D5143C75;
	Thu, 18 Jul 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwPiv6AD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241013C9CF;
	Thu, 18 Jul 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315662; cv=none; b=I7W9DULyqV+FtqfnNjVJoMLE4f2ACLxufYbISC2RlsEH0g5zw1xjyw+URLEpaMiujb1wDHt6tp3t71o4fZoCd47lSUAnGQPGfXbgnTfrhJt+cYcAmJHSZrHhhfmxQE5MrULn4284Y1IPyP8cscVCr6eub96RKXikk8aS75CFovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315662; c=relaxed/simple;
	bh=prEt0GHsrPFyABKzCiiaQDxgpEcvGXX1gVDzyBwq6+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEOYvDvGzQxly/4bNuUf//ArGsS690bNrRFEEl06yWFtV9k+aLghNTjDoJT5zifIERSSxrYTdYMiCfL/AeDsSojDRlgdI6WjB89CpnRxXwsvz7vTad4UfJPJ5sZBG5Yfqdc8RTVyPwoiJit5myqYxaGGStJuNuRq/KBlNOaVSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwPiv6AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A613C116B1;
	Thu, 18 Jul 2024 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315661;
	bh=prEt0GHsrPFyABKzCiiaQDxgpEcvGXX1gVDzyBwq6+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwPiv6ADjyLRZ9ziB5ePFGFT8lINTB3j35TLzYph/vOl/XAS4/cj43rVY+4/J7VmY
	 iP8YXeLTgx2KLQrcNdb3MWJX8x1uif99buJUVHoik77w4Wqd/OWEhnjbldc8A4D1Ap
	 XqrIetvGX5ejDpIA2E/2hY6a6+WVYWIsf4xBDARxkyWfCiPyg5YVEdDZO4jSOEhYBv
	 5tdolp+Lg3jKQdRzYocpnY/siQGV4lAlHvMoEsCAvFmgfYJMIs9Dv4yv0G9v1frDcJ
	 PkDydxOW6wgmTqMwM05QxTDE7E05bKncvdjtOMqeNfybAziGG9wAqxfcGrLorVqTxD
	 oBN7dC0f5Vv2g==
Date: Thu, 18 Jul 2024 16:14:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: iio: adc: ad7192: Add clock provider
Message-ID: <20240718-revisable-penpal-bc06ff6366ab@spud>
References: <20240717212535.8348-1-alisa.roman@analog.com>
 <20240717212535.8348-4-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="70lbqN+K8e7m12o8"
Content-Disposition: inline
In-Reply-To: <20240717212535.8348-4-alisa.roman@analog.com>


--70lbqN+K8e7m12o8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:25:34AM +0300, Alisa-Dariana Roman wrote:
> Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> clock provider to support this functionality when clock cells property
> is present.
>=20
> The clock source can be either provided externally or the internal clock
> is used. Pair of clocks and clock-names property is mutally exclusive
> with #clock-cells property.
>=20
> Modify second example to showcase the mode where internal clock is used.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7192.yaml     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index c3adc32684cf..edfa4378e838 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -42,13 +42,19 @@ properties:
>      description:
>        Optionally, either a crystal can be attached externally between MC=
LK1 and
>        MCLK2 pins, or an external CMOS-compatible clock can drive the MCL=
K2
> -      pin. If absent, internal 4.92MHz clock is used.
> +      pin. If absent, internal 4.92MHz clock is used, which can be made
> +      available on MCLK2 pin.
> =20
>    clock-names:
>      enum:
>        - xtal
>        - mclk
> =20
> +  "#clock-cells":
> +    const: 0
> +    description:
> +      If present when internal clock is used, configured as clock provid=
er.
> +
>    interrupts:
>      maxItems: 1
> =20
> @@ -169,6 +175,8 @@ allOf:
>        required:
>          - clocks
>          - clock-names
> +      properties:
> +        "#clock-cells": false

Properties before required, otherwise
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> =20
>  unevaluatedProperties: false
> =20
> @@ -214,8 +222,7 @@ examples:
>              spi-max-frequency =3D <1000000>;
>              spi-cpol;
>              spi-cpha;
> -            clocks =3D <&ad7192_mclk>;
> -            clock-names =3D "mclk";
> +            #clock-cells =3D <0>;
>              interrupts =3D <25 0x2>;
>              interrupt-parent =3D <&gpio>;
>              aincom-supply =3D <&aincom>;
> --=20
> 2.34.1
>=20

--70lbqN+K8e7m12o8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpkxSQAKCRB4tDGHoIJi
0spOAP93oyPy6/thhTIa734tsfEViWyFsYYVB1dXh9b0uInYaQD5AQaFTEKBNCLy
7bQiW/EHRbdfiXDQ2s0y6cCLaiW5JAk=
=ZLJt
-----END PGP SIGNATURE-----

--70lbqN+K8e7m12o8--

