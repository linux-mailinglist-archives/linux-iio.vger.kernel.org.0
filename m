Return-Path: <linux-iio+bounces-3920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C40892122
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 17:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3C5B267CE
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9925778;
	Fri, 29 Mar 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgD1QuPx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548712032A;
	Fri, 29 Mar 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727370; cv=none; b=bG2Y9lxgJkedZ1LGNuLoJuDRrPdbMiMZMV3n3srViD08980QMosxQ/XOh5AE6fP3ffAkPES1U5er2t5KFPVT/m2eXctjerXGX7hkGP/8/ICCYrnBMA90jnucjPHGMfaJnLgk5HHpE2NGV7C+2RcjTTIxSeqgoEcKaDuketTkdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727370; c=relaxed/simple;
	bh=E5hKDmbO76XZ2B5DMMf4tBVBJ2DYEMecSrGHLmZeE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/Iw1zBX69FkjLo86BAHqhVkLgN70ufjzMW2cUQlup98QzTcaxLIEl47oq6/jBTugxA4iGprlSBIpoqVCMYF8XUu/Crz1axaTaAe2tRBGXWwKS3EwkPKptVYA0B01P45tzXHviybyvsaPdkkGcQPdt0WuLJw9mIhmeRZ4dclFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgD1QuPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1F0C433C7;
	Fri, 29 Mar 2024 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711727370;
	bh=E5hKDmbO76XZ2B5DMMf4tBVBJ2DYEMecSrGHLmZeE4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgD1QuPxJrq4P8ox/NT3vmxJfC8HbosUJBLQOyhIeY/1Hzxf5qkIOGfyVYXtv95mO
	 WXB9tt7puLUHnkNMXCm6pS0PEF/s8g/gqO66WRRN4Ix8wQROvV36JAFLKpeeIfScDj
	 +B9VDss7T9Fje33BDeeDLU8YU8viLQ6hBHW+jDSSgPcK8vOh71KXX4a1vF6yH0WYuL
	 Fr7TTnhpcsvRxrrxuHIQ85f4BpUXbreFt90VJglNrsGzCWqIapEleIB0ZuIKpim18f
	 56IEf6yUjxDk8SMkfZFWP1EGLKW47M9qZTq+9DE65UeBw7kitAgv91O3D6grUQhtQ7
	 pzW7URYPEi+6A==
Date: Fri, 29 Mar 2024 15:49:26 +0000
From: Conor Dooley <conor@kernel.org>
To: inv.git-commit@tdk.com
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
Message-ID: <20240329-fifth-earpiece-78daf4d943ce@spud>
References: <20240329151535.712827-1-inv.git-commit@tdk.com>
 <20240329151535.712827-3-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pcloodLgjup+YNeh"
Content-Disposition: inline
In-Reply-To: <20240329151535.712827-3-inv.git-commit@tdk.com>


--pcloodLgjup+YNeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 03:15:35PM +0000, inv.git-commit@tdk.com wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Add bindings for ICM-42688-P chip.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

My initial thought was that you're missing a sign-off, but is
"inv.git-commit@tdk.com" some system you have to bypass corporate email
garbage?

> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 7cd05bcbee31..152aec8d82ff 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -31,6 +31,7 @@ properties:
>        - invensense,icm42602
>        - invensense,icm42605
>        - invensense,icm42622
> +      - invensense,icm42688

Can you add this in alphanumerical order please?

Also, this patch should be the first in the series.

Thanks,
Conor.

>        - invensense,icm42631
>=20
>    reg:
> --
> 2.34.1
>=20

--pcloodLgjup+YNeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgbjBgAKCRB4tDGHoIJi
0rWiAQCQwWc3duhLYw7cwEoK6szQhYboyyNB3jBoyTFuvevtbwD/UlykmlQEgVVc
Ths+lCIgYj5Mx/lbeLYNIQAzQZveEAs=
=smyn
-----END PGP SIGNATURE-----

--pcloodLgjup+YNeh--

