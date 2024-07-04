Return-Path: <linux-iio+bounces-7325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1728F927B2E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 18:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E701C217DD
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE11B29CA;
	Thu,  4 Jul 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGrdXnvk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225241AE859;
	Thu,  4 Jul 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110972; cv=none; b=pfliIpBggv5mOkM53YEdXzkZX7asnjnLVsFXcS8Pw9VKTstb/t6L9XSj29TaAgjzqR/dbhD0X24su7YYyh817qc9xTLgzLBcqfRESTeJEkQ89d9z7WYS7L0I/o35uHx6O+loR4gpziVFaLNHLg9kkoekmk3ivUQJ7oa6n8X9c2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110972; c=relaxed/simple;
	bh=Wun1nBHv7W3ouKEejnS0gC9QT0sciqtJvbP8LUysBdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlXrOaSFAwnRpyBJ4oLrZjRYpHKFTKvKAq+5I+EU/I7sFiPl4HqY3f9nNldWFFp/Ii116TB5EGHNN/MJ4WRUViiXR1vGzjtAee1LbILuoKKrRgPe/3z1Qw1zNGIwuTTuLym/bU2iULQ/bypyURQdVp1SnQ9NND2VY05gDVJxQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGrdXnvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EF6C32781;
	Thu,  4 Jul 2024 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720110971;
	bh=Wun1nBHv7W3ouKEejnS0gC9QT0sciqtJvbP8LUysBdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGrdXnvkfhSgD0VHOi8gd3OztnaICzxGQuZ2AKDOTDK3R+smMJR3MQ+bkoXgVsTS1
	 m2UvCdj4E1d0kZz9VvPcrNae9c9tQxbDE8h7xBBlCipA9Yr+7kNi7/7UNmLkuxdCmv
	 Tdag4FY+Z9SM04SDprCGFcLKGL6ckJecx6Am1p1calTME93nbmx26jVw4HbJlsNkjd
	 SVztdcrmzy/TCs4D6UCJCSpGU73KXxiUKWE4663NYKiL8htb3E2rKn0dkPiKEPAcbM
	 tFvGAV3Atqh85Z2YtA/M6skbppllAd9Sqow9yLzKqd1hhg8mJEk/2MSkykZVLW15kE
	 Mtd2OMu85/VRw==
Date: Thu, 4 Jul 2024 17:36:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: fabrice.gasnier@foss.st.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] dt-bindings: iio: add backend support to sd
 modulator
Message-ID: <20240704-semifinal-lining-8ed34ec648ce@spud>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
 <20240704155338.2387858-6-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6WPbI4M8ywloIk6n"
Content-Disposition: inline
In-Reply-To: <20240704155338.2387858-6-olivier.moysan@foss.st.com>


--6WPbI4M8ywloIk6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 05:53:33PM +0200, Olivier Moysan wrote:
> The legacy sd modulator driver registers the sigma delta modulator as
> an IIO channel provider. This implementation is not convenient when the
> SD modulator has to be cascaded with another IIO device. The scaling
> information is distributed across devices, which makes it difficult to
> report consistent scaling data on IIO devices.
>=20
> The solution is to expose these cascaded IIO devices as an aggregate
> device, which report global scaling information.
> Add IIO backend support to SD modulator to allow scaling information
> management.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com

The backend portion of this looks fine to me, thanks.

>
> ---
>  .../iio/adc/sigma-delta-modulator.yaml        | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modula=
tor.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.=
yaml
> index cab0d425eaa4..3f682d95d807 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> @@ -18,18 +18,37 @@ properties:
>        - sd-modulator
>        - ads1201
> =20
> +  '#io-backend-cells':
> +    const: 0
> +
>    '#io-channel-cells':
>      const: 0
> =20
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: Phandle to the vref input analog reference voltage.

These two look like unrelated changes that should be done in their own
patch. They certainly deserve a justification.

Cheers,
Conor.

> +
>  required:
>    - compatible
> -  - '#io-channel-cells'
> +
> +anyOf:
> +  - required: ['#io-backend-cells']
> +  - required: ['#io-channel-cells']
> =20
>  additionalProperties: false
> =20
>  examples:
>    - |
> -    ads1202: adc {
> +    // Backend binding example. SD modulator configured as an IIO backen=
d device
> +    ads1201_0 {
> +      compatible =3D "sd-modulator";
> +      #io-backend-cells =3D <0>;
> +    };
> +
> +    // Legacy binding example. SD modulator configured as an IIO channel=
 provider
> +    ads1201_1 {
>        compatible =3D "sd-modulator";
>        #io-channel-cells =3D <0>;
>      };
> --=20
> 2.25.1
>=20

--6WPbI4M8ywloIk6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZobPdwAKCRB4tDGHoIJi
0l8rAP9UeirWRnoGjCwxJmkEfVR3eaE1a8wyYHRHNNmlp8NtDAD8CuK6YNYbBf4o
iPcLYuvTF6Bg5L9jW+ekyZUPpzhFoQY=
=OI2p
-----END PGP SIGNATURE-----

--6WPbI4M8ywloIk6n--

