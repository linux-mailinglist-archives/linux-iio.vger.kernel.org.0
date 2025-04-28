Return-Path: <linux-iio+bounces-18784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73912A9F600
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 18:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C68189DAC0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8F27A92C;
	Mon, 28 Apr 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGrqc2lG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF184A3E;
	Mon, 28 Apr 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858444; cv=none; b=LXhYQvUzUJh20nwasEhua6VibBY0+0a25ln1cd5uQm6DN5yplMJPM8x2CmRSmKKbjRWnwfh4UQcPP7DpzNpBeuMGKkpK0txp7n+eLlXbk90kqBEjLGba3iwPxSn5+ZbTcq7fPH/joNsgjh0PUuldl2Uwnxqagq6CNZqXyEg6WTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858444; c=relaxed/simple;
	bh=IZiT22bu67/WDnQhbAi5nobg5mEMnbDK1ZfXPFMOlss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEmLgTF8Dti2dhBSwzzbGDMYBiUn67pDdSpm0y3oplwegOe9OSWM/rhur40cx+HkjR5/V+TPpEc5k8CTeHWiq8QTuotv05ZWdGbOFUEskEVeFL+8CZVBy5tI7SWc3fQ+nH0VRB616OD3xBuOdfWV55jQso8Zb2P5i2OobB7K0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGrqc2lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8593DC4CEE4;
	Mon, 28 Apr 2025 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745858443;
	bh=IZiT22bu67/WDnQhbAi5nobg5mEMnbDK1ZfXPFMOlss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGrqc2lGErJA3V6Zd1CIaUlBDCi39+Mge9FbnINp+UvoRn8zCUhbg0BMqXzL5u7A0
	 QSFiARL6jUFizdi2psQxokxFifS2EGKi2j6aWa04xUodixQx6C8Gi5jCbEZf4O/rOT
	 per0yQDruEMBPCyyoIwPMx8JQhQeEg/QkIAt3dPeDfB7o1WrW1lpdpXNq5JRGL6tYh
	 okBAp1pbDHtqWxQvpWwLJKtzc7ny8p8SRoEM6k6I/mYAwhxOQQoWmshE/iJI2iIcrn
	 8fPjTGDjTGZJvsBYgZMQTEeOGqv0pE9g+01hNJpYh8NCE6Z7n6eUeP8erMJtaY3PKf
	 kS4DCNNg64PSg==
Date: Mon, 28 Apr 2025 17:40:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org,
	Lukas Rauber <lukas.rauber@janitza.de>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: mcp3911: add reset-gpios
Message-ID: <20250428-alfalfa-caring-ee2eb658b8da@spud>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
 <20250428-mcp3911-fixes-v2-2-406e39330c3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ZB/lk+tppHCUr2R"
Content-Disposition: inline
In-Reply-To: <20250428-mcp3911-fixes-v2-2-406e39330c3d@gmail.com>


--9ZB/lk+tppHCUr2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 08:54:12AM +0200, Marcus Folkesson wrote:
> The MCP391X family provides an active low reset signal that is still not
> described in the bindings.
>=20
> Add reset-gpios to the bindings and the example.
>=20
> Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
> Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 5 +++=
++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index 06951ec5f5da381a9bb942d0ac7416128eebd3bc..3a69ec60edb915ae16312b94f=
ddd32f5c87f37a7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -32,6 +32,9 @@ properties:
>    spi-max-frequency:
>      maximum: 20000000
> =20
> +  reset-gpios:
> +    maxItems: 1
> +
>    clocks:
>      description: |
>        Phandle and clock identifier for external sampling clock.
> @@ -71,6 +74,7 @@ unevaluatedProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>      spi {
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
> @@ -80,6 +84,7 @@ examples:
>          reg =3D <0>;
>          interrupt-parent =3D <&gpio5>;
>          interrupts =3D <15 2>;
> +        reset-gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>;
>          spi-max-frequency =3D <20000000>;
>          microchip,device-addr =3D <0>;
>          vref-supply =3D <&vref_reg>;
>=20
> --=20
> 2.49.0
>=20

--9ZB/lk+tppHCUr2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaA+vhgAKCRB4tDGHoIJi
0kKjAP0SGoVbLKEoRIXDEoNsKzwTwRP6mi2cOiNg2ZTliu+/WQEAz3qlZTGXYpew
2L9C5uyNseNr9Dh05ZgsLkjQVSP9bw4=
=HZts
-----END PGP SIGNATURE-----

--9ZB/lk+tppHCUr2R--

