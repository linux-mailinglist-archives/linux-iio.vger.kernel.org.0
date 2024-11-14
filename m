Return-Path: <linux-iio+bounces-12264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4D9C92E8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 21:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1224B2407D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367911AA1EB;
	Thu, 14 Nov 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAtYBi4y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA0EEDE;
	Thu, 14 Nov 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614856; cv=none; b=nqO+IjZoZgCKnaOmohFERzA4qFVUn4j3u75zFlw5nGAwSDfGxzhYoSnh1I9cBDuOqKjx1kJ8ho1lOgbbGtd1D8XHvmP8qyF5qpOMcapZkpk9GYwA3MtY9Ybvq7GwFMHriDFbUBzUmCpGW2RCiv0YKMcLHAcAXPnJcp6jANRgUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614856; c=relaxed/simple;
	bh=nqJiNu8v2ujQkfJAmU9C5VR3//m4linYKmRisSXR+OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cok/VhV5oEXKMjbHv15KrbdLekuVzv6wgTiwk7rO9UKySph7+cqIzVkDNv0SuPXiJF+6er2bDK4c5QWmGDN7xV3Elb/T6x4RzkR1ctE5qmaMNnss+BuuQX28oYJDN/ybLgJnUErLOrLNc+RNHQcjc8QkUWln7tDCfd9OXdPMDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAtYBi4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D583C4CED5;
	Thu, 14 Nov 2024 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614855;
	bh=nqJiNu8v2ujQkfJAmU9C5VR3//m4linYKmRisSXR+OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAtYBi4yJAjPz/PEMA36PsQw9r/rpNGJ7Lqm4OZfk6SoeAUyEso7XPg8UDgPzXRjk
	 bkVYnm5caKILvncDhVBDdUoZ1FOzSwd3IqA4FoEJy1l/REaSKjGoVUV92f+IbFnHVs
	 OIAoOvk5V1yvYRXFXV8AHX7d9dMZruDx6ts6xwgIJG5/FvOgy7qHBeS12Fvy6caNNP
	 gs+67FJgpjm99NHhgYl9C4YrvKK1qhhtxo4VdifQ8V4+7nRDQ5jxFU3i+wxwpkYM+m
	 7gQK9U5sKLsOaXmmYhVLY24M7O2dJ4FQgGAeDhnkmNQZ0VgGXf22Nr7sSrU9BsyX2l
	 LwOV4jlpkwD8A==
Date: Thu, 14 Nov 2024 20:07:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8967af'
Message-ID: <20241114-showing-aspirin-8ca12f0b2e50@spud>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
 <20241113-fxls-v1-1-5e48ff1b1fb8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BLm+PiydXSQuPslL"
Content-Disposition: inline
In-Reply-To: <20241113-fxls-v1-1-5e48ff1b1fb8@nxp.com>


--BLm+PiydXSQuPslL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:54:39PM -0500, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Add compatible string 'nxp,fxls8967af' for the NXP FXLS8967AF acceleromet=
er
> sensor.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.y=
aml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index 783c7ddfcd90a..c375ef1bd083f 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -14,12 +14,16 @@ description: |
>    SPI and I2C interface.
>      https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
>      https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
> =20
>  properties:
>    compatible:
> +    description:
> +      These chips are compatible with each other, just have different ID=
s.

Then there should be a fallback. Please remove this description and add
the new device with a fallback to an existing one.

>      enum:
>        - nxp,fxls8962af
>        - nxp,fxls8964af
> +      - nxp,fxls8967af
> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.34.1
>=20

--BLm+PiydXSQuPslL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZYggAKCRB4tDGHoIJi
0qctAQDHl3DPf7LwU7fxaBdmPPX2qhiGz8tA8KDft9OZS+25AAD/YHIdFD71J05r
0YRD5CgsZp+OvlL6M1mUzfcHKfiqmwc=
=UnPl
-----END PGP SIGNATURE-----

--BLm+PiydXSQuPslL--

