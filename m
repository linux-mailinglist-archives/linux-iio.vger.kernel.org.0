Return-Path: <linux-iio+bounces-23310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41DB371CE
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2889F2A38C7
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CAE2F3625;
	Tue, 26 Aug 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN+I9L/F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0102F1FF3;
	Tue, 26 Aug 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230937; cv=none; b=TJWIsT6eBYZRMyI3PctdtpQRHWtKdR7/FvagKn/98K/OqGopddt7Tbsg8OyUsGdB2whNYm4zx+Q16pi9KzmX67s3G9D8duD8k2G8T6KnH8hzqQYxneGPodcQA5bXcD1ooIIcTh3m39Q0pgrjbYasL6kWpto8PksrNbCH/3ksFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230937; c=relaxed/simple;
	bh=vK1ZgxN00M0SncLhVW+63U28AI64oXU2/lB66eqm49A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCTcNVNMauD7g7u1boAyEG31rIEUalnLBKen6bIDRVfGatrMjXbeEVXAOpWY0gPUX2kHWlclyXT1PL+2PGDWdH98YXJaZ/47JBMLYGrq/0i5pyab8j7xl5HFNMvuZldBsLs7VksDNIklDKjUnhvicPQEFCvjrAa/VdOlLsHGUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN+I9L/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A0CC116D0;
	Tue, 26 Aug 2025 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756230936;
	bh=vK1ZgxN00M0SncLhVW+63U28AI64oXU2/lB66eqm49A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HN+I9L/Fgfq1j7NfCR/LCuStr2ueTUrb9pxJ/Su4T2eDGF3Nc3X+URPmusyueGvbt
	 icsYmqnHoHUUG0Tu1lU+vBPw4z5A89TkRlTIW1YUGnyF68IlQIybAEF4NEnTnmJrRD
	 jeaLOkjNTYmBtHX1coHb+2goqgajakySDad7XkHdMDNRaZQ+kvX7NHRyw/mStpb2nv
	 qkgJHGOJKmqh9D1QfptPwhEReTUWrwXvHREeMrOsQQg7OrPX0oI/bmdASvee6aez1n
	 qunnL0Xji9LVd2taiUGGx4iZgt/7LojTNdS3vgGhA/XHBqN1Jyblb+P0ICcbWzrEbi
	 qkv8su0/yK/yw==
Date: Tue, 26 Aug 2025 18:55:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
	jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	Marcelo.Schmitt@analog.com, dumitru.ceclan@analog.com,
	Jonathan.Santos@analog.com, dragos.bogdan@analog.com
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add device tree binding
 for MAX22531 ADC
Message-ID: <20250826-senator-profusely-219c4afdbe0d@spud>
References: <cover.1756115378.git.jain.abhinav177@gmail.com>
 <ba7c09277c71cd8bc84736429a7fdc66914fd322.1756115378.git.jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqLaiIP2d7P44eBQ"
Content-Disposition: inline
In-Reply-To: <ba7c09277c71cd8bc84736429a7fdc66914fd322.1756115378.git.jain.abhinav177@gmail.com>


--xqLaiIP2d7P44eBQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 02:55:24AM +0530, Abhinav Jain wrote:
> Add device tree documentation for MAX22530-MAX22532 family of ADCs.
> The MAX22530=E2=80=93MAX22532 are galvanically isolated, 4-channel, multi=
plexed,
> 12-bit, analog-to-digital converters (ADC) in the MAXSafe=E2=84=A2 family=
 product
> line. An integrated, isolated, DC-DC converter powers all fieldside
> circuitry, and this allows field-side diagnostics even when no input
> signal is present.
>=20
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  .../bindings/iio/adc/adi,max22531.yaml        | 75 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max2253=
1.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml
> new file mode 100644
> index 000000000000..16bf4a1d0926
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Abhinav Jain
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,max22531.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX22530-MAX22532 12-bit Field Isolated ADCs
> +
> +maintainers:
> +  - Abhinav Jain <jain.abhinav177@gmail.com>
> +
> +description:
> +  Bindings for the Analog Devices Max22530-MAX22532 Field-Side Self-Powe=
red,
> +  4-Channel, 12-bit, Isolated ADCs.
> +
> +  Datasheet can be found here
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
max22530-max22532.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max22530
> +      - adi,max22531
> +      - adi,max22532

Generally this looks okay to me, but I would like you to mention what it
is that makes a fallback between these impossible in your commit
message.=20

--xqLaiIP2d7P44eBQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK31EwAKCRB4tDGHoIJi
0iC0AQDr8p9s43qr2Tx29kG0NjaBhYAYEiQIl90KDYaf2dYsygEApoPNAHiXRiS1
WgWv75A+IV0u2O7t7hYT1qhMTC0JrwM=
=NISr
-----END PGP SIGNATURE-----

--xqLaiIP2d7P44eBQ--

