Return-Path: <linux-iio+bounces-6508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7B490D777
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDF2B2AD26
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFB21C6A7;
	Tue, 18 Jun 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXN89Etq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82900208A0;
	Tue, 18 Jun 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723076; cv=none; b=BiQo7eqN3IE6iX6bS8eQtZWL0rryYVTywFt4iUGHflHskVYPR3YcUk4LBHm2BQKVD/IR+gd1Hf0O9cLCq37j3ReEQ3iAQYlEMY1mENq6J1nAkXX4zD4N1c6tsH8O8oSEKjK3Zw+G0FeFGRUKnv4bbXecFrv/ypZ9YhzqnDhBjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723076; c=relaxed/simple;
	bh=zUH6sxUpWz+jUDtEsbx0212WG7R9YpNKSFSngMqY4IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tdcwfo15/oLP7br01apkb1LpSdxtkukPlbY/DQJpzGt7axxPOIq09PjbWUMlnrvSSC2k3isSuFLLSB16IEX3Z9O2gzVuIMNbLHpqJo8V6I9y0SN5hXIrsSPE9oWktephM7u3wF/XkxwBnz1Zp1iiY2cMpogRiFehPyDd9KbnRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXN89Etq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC46C3277B;
	Tue, 18 Jun 2024 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723076;
	bh=zUH6sxUpWz+jUDtEsbx0212WG7R9YpNKSFSngMqY4IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXN89EtqTLoNICcVZ0/4xiQlTNuLEhAeHz0dBE6vCg2yf4kuKsyGQK5C54XtQ5U8r
	 ostnGhuLf5X3RJ/Wyf1iqxgI5LUMnFROMnc3ABT+fkquuaOerJNmSbzsGV0LnM7UaH
	 X++10nl2efvrFGit4ur546kGJmw8kw2jKoM2a2i4Amar7q7/wAPNDkF+tSUckekaIO
	 R5sbmhcJy+XBo54NJbGw3Zpt+MH8hUKopyhTgURXmw780LE9FHAewWtePfLM4R0/J0
	 FLj1D5wUdAzaOvfGxHrXaoL65r92aYqxPyQRTNV9ltmifjYi8+z88Lf5cvP+SPwVFI
	 nHlvUpVUtQBXg==
Date: Tue, 18 Jun 2024 16:04:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 4/6] dt-bindings: iio: adc: ad7192: Add clock provider
Message-ID: <20240618-gulp-unmoved-1c0c7f59ac9a@spud>
References: <20240618142138.520192-1-alisa.roman@analog.com>
 <20240618142138.520192-5-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yeyMPujx+I0caroe"
Content-Disposition: inline
In-Reply-To: <20240618142138.520192-5-alisa.roman@analog.com>


--yeyMPujx+I0caroe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 05:21:36PM +0300, Alisa-Dariana Roman wrote:
> Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> clock provider to support this functionality.
>=20
> Modify second example to showcase this mode.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7192.yaml          | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 67384bed4cd3..e31436484372 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -42,13 +42,17 @@ properties:
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
> +
>    interrupts:
>      maxItems: 1
> =20
> @@ -204,8 +208,7 @@ examples:
>              spi-max-frequency =3D <1000000>;
>              spi-cpol;
>              spi-cpha;
> -            clocks =3D <&ad7192_mclk>;
> -            clock-names =3D "mclk";
> +            #clock-cells =3D <0>;

I don't see why the example needs to change here.
If these are mutually exclusive, I think the binding should enforce that
if clock-cells is present that clock-names cannot contain "mclk".

>              interrupts =3D <25 0x2>;
>              interrupt-parent =3D <&gpio>;
>              aincom-supply =3D <&aincom>;
> --=20
> 2.34.1
>=20

--yeyMPujx+I0caroe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGh/wAKCRB4tDGHoIJi
0kaYAQDWgRQavVZD5t1BOM6o5Ccqm+RMK3ZhXagISBjmkckc2wEA7GiNO62dGe7s
ohpS19NbpMhbJxksnsBjjXRu/eVC9QI=
=ZTyk
-----END PGP SIGNATURE-----

--yeyMPujx+I0caroe--

