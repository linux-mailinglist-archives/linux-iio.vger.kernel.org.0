Return-Path: <linux-iio+bounces-5012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BF28C4508
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904241C21CC7
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C615534C;
	Mon, 13 May 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7E7qh2C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9B23CB;
	Mon, 13 May 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617575; cv=none; b=RqZUVESD1VI2O+2qLjkNORbekeA2RSQf8uDZmo/UQ210Qel+ILjpKtkhTbMeHjf43PhXJS4KTyvaWmR1OSYIzhN2IOpNriTvfrxoBakOMlAyXCCAFbzFfjBjrHNx91UW9cn++P0AhFYAOXHoahyB6w1BDLEpUYmRmeupLKR7bVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617575; c=relaxed/simple;
	bh=+4zO9ASfKSS6PnSBipIzzhi8J3n45oak72iAryaZmb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC477rig8qAovbpF3SKsb8gzWm1i7TOQBce8VHG7HdCJRVW+jEq1RFWji5T9Lwuhm39SyGPaFoRSvfk5TsN2QzRAOoyBw49H/FQ+M4t51KGAzIUz9z8G7nPy+K5WBhbEie587axusLd7Bf7oXsiW01z3OiQqZ3i8BMQmgV66e60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7E7qh2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBC9C113CC;
	Mon, 13 May 2024 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715617575;
	bh=+4zO9ASfKSS6PnSBipIzzhi8J3n45oak72iAryaZmb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7E7qh2CG77iROarlTd2amPHvTcfr+NbfMXLC09jvHzk6QcYf31tpbLcGavDvdh9T
	 fNHe+3NT/0vr2HtqsZcCpFFcJ1Zx36fZ/WltHnoFYSXo9+9a9x55VSpoTwgfFeFUQQ
	 taBJFV7x+RmKWbRrqjNw98GIyo2TU6R+s4grE3qqAo1qtQw0jyW+TIuEK99KmIcWUW
	 9K61ZiKCfXFDMqT+Nk/F+Ca/Lm/dJAt8DNshBm6lQLt3v+VJPvOT+huBszKwHP8V8l
	 KAi2whdXlykabID3bnuxEmQUsOynd6YO34LUhRt5DM4OqsfEOgw87Z8UH2uVouDL58
	 cL5lEQJfjDEiQ==
Date: Mon, 13 May 2024 17:26:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Arthur Becker <arthur.becker@sentec.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: add veml6040 RGBW-LS bindings
Message-ID: <20240513-repulsive-fiftieth-884b3805472f@spud>
References: <ZR1P278MB1117B205886E023F9F72A2E881E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZitAmeaQDcOi6BbO"
Content-Disposition: inline
In-Reply-To: <ZR1P278MB1117B205886E023F9F72A2E881E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>


--ZitAmeaQDcOi6BbO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 02:35:44PM +0000, Arthur Becker wrote:
> This commit adds device tree bindings for the veml6040 RGBW Light Sensor
>=20
> signed-off-by: Arthur Becker <arthur.becker@sentec.com>

If you're writing a standalone binding for this and not putting it into
trivial-devices.yaml you should document the supply for this device.

> ---
>=20
>  .../bindings/iio/light/veml6040.yaml          | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6040.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/veml6040.yaml b/=
Documentation/devicetree/bindings/iio/light/veml6040.yaml
> new file mode 100644
> index 000000000000..796c22f75575
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/veml6040.yaml

Filename matching the compatible please.

> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/veml6040.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VEML6040 RGBW Light Sensor
> +
> +maintainers:
> +  - Arthur Becker <arthur.becker@sentec.com>
> +
> +description: |

This | isn;t needed, you've got no formatting to preserve.


Cheers,
Conor.

--ZitAmeaQDcOi6BbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI/JAAKCRB4tDGHoIJi
0u3NAQDsfKGAM28B8wsjgPoIYMhedJufJfYp+IZUBzI0SVYGkwEAnYppx7Mh7S+D
LhvpMTYTJzUgkwQnEWW/LY+X2NZkhwE=
=OphQ
-----END PGP SIGNATURE-----

--ZitAmeaQDcOi6BbO--

