Return-Path: <linux-iio+bounces-6247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E7907879
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB5A1F2371B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317C149C4B;
	Thu, 13 Jun 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kamjskX+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DE1494C2;
	Thu, 13 Jun 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296919; cv=none; b=luflvezkm7IyY4yohq/SlTXOHQHpjeybyGyPIOWmQlwav1GSoT+g+nGbVUvP/YvDjiEWsbWbAQ7HR8deg11Wgf9oLtZurIHWJgYvoJWAjTCCwAqsThGbIorGIK1fZUhTbZ0ge5U/GsNOLyCi/luI7ZxzWpj6dshkgHaKIWxOguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296919; c=relaxed/simple;
	bh=vsXFKBT+cSrkgehHrImlatR7bWrZFbEWVqJGyHEVB8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI6ahHgD5e3QmkE6/6BxGzRWooGxUiJ7oPp1FRJyeeecMNYkySoh6oKYwGcMtURjZljV6xl/0ModwxiH0esp0y40+NaJmNqNQBiHKxtSs87idlorio6JCNx28anMiw+RbxDlGEA7XUj6w/vHXA2UT7zc5MfFXRDWl72CdqZjbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kamjskX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41B8C32786;
	Thu, 13 Jun 2024 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718296918;
	bh=vsXFKBT+cSrkgehHrImlatR7bWrZFbEWVqJGyHEVB8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kamjskX+1DHnEM5Qq8CuMsKFatQSlkozsBYZC9ATYruNzKLVszlk+scp82PsvBcCb
	 P+UdGu/2EtHqz0I/nJ4wtUwJT5ywO/vPfpDzP5X+gZEbjQfsFmQF3B8C+1q7z9GhmE
	 gKodOoGMIEHLjmk+fyBqucpN/I3oYLbV8LiCvfgtgqhjDIhyS6hpcK0z3eAQ+qypqr
	 ZwdvYxFSheCWa/ZYq5WxtwLYtNRvqQe7MMO0vVNIQikg8ZpC1X5vikLlqWCbkiYAAn
	 B7798lI3ncnzys9kxPNaK4VP43FBIVbbR46FrG0d69snNIRC3JvU+OhSH3zh2bHFEb
	 xP+fFuyuSz6Fw==
Date: Thu, 13 Jun 2024 17:41:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: iio: adc: ad7192: Update clock config
Message-ID: <20240613-vineyard-doing-87ada1b7a8ed@spud>
References: <20240613114001.270233-1-alisa.roman@analog.com>
 <20240613114001.270233-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m9XQa0OBbOvIhW8/"
Content-Disposition: inline
In-Reply-To: <20240613114001.270233-3-alisa.roman@analog.com>


--m9XQa0OBbOvIhW8/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 02:39:58PM +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>=20
> Add clock name xtal alongside mclk. When an external crystal is
> attached, xtal should be chosen. When an external clock is used, mclk
> should be chosen.

This is still missing an explanation of why a new name is needed.
Hint: do you need to change register settings to use one versus the
other?

>=20
> The presence of an external clock source is optional, not required. When
> absent, internal clock is used. Modify required property accordingly and
> modify second example to showcase this.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7192.yaml    | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index a03da9489ed9..3ae2f860d24c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -39,11 +39,15 @@ properties:
> =20
>    clocks:
>      maxItems: 1
> -    description: phandle to the master clock (mclk)
> +    description: |
> +      Optionally, either a crystal can be attached externally between MC=
LK1 and
> +      MCLK2 pins, or an external CMOS-compatible clock can drive the MCL=
K2
> +      pin. If absent, internal 4.92MHz clock is used.
> =20
>    clock-names:
> -    items:
> -      - const: mclk
> +    enum:
> +      - xtal
> +      - mclk
> =20
>    interrupts:
>      maxItems: 1
> @@ -135,8 +139,6 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> -  - clocks
> -  - clock-names
>    - interrupts
>    - dvdd-supply
>    - avdd-supply
> @@ -202,8 +204,6 @@ examples:
>              spi-max-frequency =3D <1000000>;
>              spi-cpol;
>              spi-cpha;
> -            clocks =3D <&ad7192_mclk>;
> -            clock-names =3D "mclk";
>              interrupts =3D <25 0x2>;
>              interrupt-parent =3D <&gpio>;
>              aincom-supply =3D <&aincom>;
> --=20
> 2.34.1
>=20

--m9XQa0OBbOvIhW8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmshUAAKCRB4tDGHoIJi
0j40AQC/5ubIJbIF44JX0Xp18MLiKZANhOQVvlyxU5cJNPT6FwD/clq35TXv6JWP
NmWCp4wPP5eoWvB4SVNvRsbXOAGxAgs=
=/uC6
-----END PGP SIGNATURE-----

--m9XQa0OBbOvIhW8/--

