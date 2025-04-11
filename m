Return-Path: <linux-iio+bounces-17972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC46BA86326
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BA31BA0DB7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97321B9D3;
	Fri, 11 Apr 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is5B+Bgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D902C80;
	Fri, 11 Apr 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388669; cv=none; b=ZmfgHXL9+pirtoh7xxfsXtASnJem+biBjVqiTYlib74vl8GPHukKNOMX6kMRZqLNYGl2M0VUSkB07h+KrWEeD7lVwX1hEFiHGKU8FiMbGYbdMaMPZbJfFJmgBGOav98EW0bF6yvxP8JhGhjICWkkFRgnAzF8o89nQ8fzr0sXFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388669; c=relaxed/simple;
	bh=HLTkaTxD7CG28J8nNqScvqtP9UC6xZ1vDO2iU2D8fBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2WyJIEcj5SHaBcnZQmZSY1yjxGWyWa3+Ld5rDX/s276vsdBBWNeOAamSMu26b1U7BmBAR8iRepkq3HkMun1HxwLLHgLIgwsh5lyf1Y3JRmUTE46STc9NYvfrKfwv20X16GONfRmMx4c7+d1brwUcOnXTUkbEx8iFAFYAwrBttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is5B+Bgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AE1C4CEE2;
	Fri, 11 Apr 2025 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744388669;
	bh=HLTkaTxD7CG28J8nNqScvqtP9UC6xZ1vDO2iU2D8fBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Is5B+BguzA59qWVeT0IR70Xx7nsF3d95ae7vmk2mshW00sOhhwf/BQXti5ctO/rG8
	 /I/aP/hrUOd5rt4xaS1P6OuKcCe2Qs5mCGhA3P4CVlik6NGFVQHOEKF2vTnZgkZh2B
	 mDNluiWpU+PZcz6/alg561TOEl0vEp+GI/Yo5uiURnzV88ZeRulbO3DTtRI6jcfSNX
	 FkjKVknWtJhCRFn39oJfaAFfQtUXMdoeb+P/IMf95+3y/+4dLOriMpWobWSoTiS1eW
	 kvsglcWIEgsT9cQvOt8a/tRfnXeZsF9lEfcQqTrN8lJGnV+1ocA8gsrt+JB0mUvKrP
	 EgTh5Q4/I/VUA==
Date: Fri, 11 Apr 2025 17:24:24 +0100
From: Conor Dooley <conor@kernel.org>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Message-ID: <20250411-subwoofer-pushiness-107d847c8a07@spud>
References: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
 <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-1-19e4e2f8f7eb@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gCJy362GUAEnBLtu"
Content-Disposition: inline
In-Reply-To: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-1-19e4e2f8f7eb@tdk.com>


--gCJy362GUAEnBLtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 05:39:40PM +0200, Jean-Baptiste Maneyrol via B4 Rel=
ay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Add interrupt-names field for specifying interrupt pin configured.
>=20
> Chips are supporting up to 2 interrupt pins with configurable interrupt
> sources. Change interrupt to support 1 or 2 entries.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml    | 13 +++++++=
+++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 7e4492bbd0278a336587dc5ac04da7153453da29..d4d4e5c3d8562523872a73786=
4610c26c8fccd82 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -39,7 +39,16 @@ properties:
>      maxItems: 1
> =20
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> =20
>    drive-open-drain:
>      type: boolean
> @@ -76,6 +85,7 @@ examples:
>              reg =3D <0x68>;
>              interrupt-parent =3D <&gpio2>;
>              interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "INT1";
>              vdd-supply =3D <&vdd>;
>              vddio-supply =3D <&vddio>;
>          };
> @@ -95,6 +105,7 @@ examples:
>              spi-cpol;
>              interrupt-parent =3D <&gpio1>;
>              interrupts =3D <2 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "INT1";
>              vdd-supply =3D <&vdd>;
>              vddio-supply =3D <&vddio>;
>          };
>=20
> --=20
> 2.49.0
>=20
>=20

--gCJy362GUAEnBLtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/lCOAAKCRB4tDGHoIJi
0uS/AQDvorsdrJ0xeZtNY5PVoUWYc6H3zQbCI3wt0WfDkHq3sgD/Zu6+4WofITEE
QmuyUEJ+Stpi3A+sOeAlVOXnpHWIxgg=
=1j0R
-----END PGP SIGNATURE-----

--gCJy362GUAEnBLtu--

