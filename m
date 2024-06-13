Return-Path: <linux-iio+bounces-6248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1038907883
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529101F228C4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654B149C61;
	Thu, 13 Jun 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeCNc+eZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11C149C4E;
	Thu, 13 Jun 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296989; cv=none; b=Aa4F5daOqbO7VrbOrwT7ifkEb4sU+ovS5QMdF7CoZXJzYCAM+8B361l4MEa5qrh5DnHJ8cuw+OHk3pfl3SgR+GRpdU6Q+knMFgOht/Ig38v90S23W702kZgLjzLvwHHHXsf0CP91aDNGyzuWwqQSAXh98GQWaoowwRiVukMOvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296989; c=relaxed/simple;
	bh=5N86/34S9SsY993i4OkYsoiBIKBqPyqnwe4IRziKYTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxfRBSMaclnoUV6hKAbaVBRl4l0p5i6ZXd+P3X8z+DKFDRJmnDGFP+8b1XGDfIH+attj1hirgIkAWDYagJRmiWCpv0KfpV58pXbVz37Chw/pqiBwax6IF11xJuAu1rbWlz9IyM3dXzvx3OsCrCgb9uok6kQsb3GtfQqh7GMjYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeCNc+eZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67BFC32786;
	Thu, 13 Jun 2024 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718296988;
	bh=5N86/34S9SsY993i4OkYsoiBIKBqPyqnwe4IRziKYTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeCNc+eZYG9ORTjLRsHrCVE8nxJrUu5YEgZ+GmPJIdJL17zuVlPmMEw5NRZ+Hee2u
	 iyEdpY+bLyH0yoWJj2S0bdZgMpCshE/5SQC78dHWgtcNGWqNVqzCSDVxzufAmc95Up
	 J92LVZmVkSXO5sy1DSlArRFK2tRL2FDVBwXeJr2tpe/f5lwCLGm2Z16WL3Vy/UQCMp
	 M/EJYLLqfSi9Qgr4gB6qQtHEckyPmNMcvn4wMBNCyKHWZX4Mtjd0o3rhpx35Y/PC+K
	 hekuJ2Ab5ob1sqFUtPxx+i2bm14JZPbOzQRXav2bdG/XtZGV37bgqnUy/nPCWJx3AD
	 6KBcbZ0PteVKA==
Date: Thu, 13 Jun 2024 17:43:03 +0100
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
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: adc: ad7192: Add clock provider
Message-ID: <20240613-porthole-hedging-6655d32072a8@spud>
References: <20240613114001.270233-1-alisa.roman@analog.com>
 <20240613114001.270233-5-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZG98mhyg/OXpjdLh"
Content-Disposition: inline
In-Reply-To: <20240613114001.270233-5-alisa.roman@analog.com>


--ZG98mhyg/OXpjdLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 02:40:00PM +0300, Alisa-Dariana Roman wrote:
> Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> clock provider to support this functionality.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7192.yaml       | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 3ae2f860d24c..1434d89c2880 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -42,13 +42,20 @@ properties:
>      description: |
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
> +  clock-output-names:
> +    maxItems: 1

Why do you need an output name when you have exactly one clock?

--ZG98mhyg/OXpjdLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmshlwAKCRB4tDGHoIJi
0rN5AQDwx3OuFGaIq92gAW9SP4SawMqQkqEvdf2NqApMoU8puQD9E/24Paa8Ot5p
Yw14vSKM8xuL+pvJgvu9QbMx9HMcywE=
=1M/8
-----END PGP SIGNATURE-----

--ZG98mhyg/OXpjdLh--

