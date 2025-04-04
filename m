Return-Path: <linux-iio+bounces-17620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03DA7C1D4
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145437A5A70
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA9B21147A;
	Fri,  4 Apr 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL2CX66K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCA20AF9C;
	Fri,  4 Apr 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785638; cv=none; b=dDTS0wwmXN3QJN+k6kVVLeuRleLHGVWEiZzMuA+5hgDYQni8cWMrdXM/AFTzvgU9So4FszOXtHx+3XDqrdOCDzmVhoe45fHxLwVjgntqd2ILqUzVr/4xscWtwYE1AsEJGmajg1UwHclACLTdm1wgu/Kyce9OHAHgmyMhkt2+92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785638; c=relaxed/simple;
	bh=tTTvTfvZYeCa8vtMMVHza4IkDNDnyr8Ok6EJRSK4jhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep8jRhgy9YHy8QuOm6xe9WOgMkU817RmidyIsFkGfVA6hvku0zmsgQL0fS9xO5QB0NmmNqoRvgHnJkkBA3B5KpqI92+Z72y5pRCNebjxIkSvR5oF+1rQtqEZOAfs8TrJZTeD6W746WAcKBQFFwPboGy8VWVHiQbEFfHRvjTxc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL2CX66K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A5FC4CEDD;
	Fri,  4 Apr 2025 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743785637;
	bh=tTTvTfvZYeCa8vtMMVHza4IkDNDnyr8Ok6EJRSK4jhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL2CX66K8LMZgCsacM7xnXGrkVEUEC7zuQ1aRwO6qOnmLE0U9BLrt/WeWDeDdTJ2u
	 EUqeNVGXGVv2O3+r2TtfpGsJ733L1sto6XhSwQPddCRLrg9FUnMkGvdFMilOB6o9WG
	 34RobeGFuuTxOS1dVN1FbKN/LlXZgW1stE2WvY9zyFf3ekaCB7obk3Je3ze0g3XofL
	 0kzaCHKYLt2ZAj/VPAf2gtWG0LwlPBs0xSBp5LQNbCyfuWde6bTq+AxA8rFJj7a8kk
	 6ymNs3DPqsWQz/FmasbjGuUK2BFr3Z4y5thDFhi0EW+Qk9dJ50f15pB/WsXiIbnpLb
	 OtGoLaaDfijYA==
Date: Fri, 4 Apr 2025 17:53:53 +0100
From: Conor Dooley <conor@kernel.org>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Message-ID: <20250404-entering-rebel-fee1d02020b3@spud>
References: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
 <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-1-72ed5100da14@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5s5RhPSZ/hmY01Nl"
Content-Disposition: inline
In-Reply-To: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-1-72ed5100da14@tdk.com>


--5s5RhPSZ/hmY01Nl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 05:52:02PM +0200, Jean-Baptiste Maneyrol via B4 Rel=
ay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Add interrupt-names field for specifying interrupt used.
> Only INT1 is supported by the driver currently.
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml          | 8 ++=
++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 7e4492bbd0278a336587dc5ac04da7153453da29..f19cdfd7450e04e7c984dc987=
f3c23f5ad89a248 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -41,6 +41,12 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  interrupt-names:
> +    enum:
> +      - INT1

An enum with one entry is just a const.

> +    description: |
> +      set to "INT1" the only supported interrupts pin

The commit message suggests there are others, you should list them all
here (if there are) even if the driver doesn't use them.

> +
>    drive-open-drain:
>      type: boolean
> =20
> @@ -76,6 +82,7 @@ examples:
>              reg =3D <0x68>;
>              interrupt-parent =3D <&gpio2>;
>              interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "INT1";
>              vdd-supply =3D <&vdd>;
>              vddio-supply =3D <&vddio>;
>          };
> @@ -95,6 +102,7 @@ examples:
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

--5s5RhPSZ/hmY01Nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/AOoQAKCRB4tDGHoIJi
0gQ7APsFIFIPMkwe13hKI27blN9dVqyfZP4YLgWYUI48hScZ/wD/X6MUhBSk4+R/
xmMXNurhCnFEx36O6F1unJ+Xsd+YVAE=
=y9nB
-----END PGP SIGNATURE-----

--5s5RhPSZ/hmY01Nl--

