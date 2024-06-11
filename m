Return-Path: <linux-iio+bounces-6184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5F904360
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 20:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0211F2659F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AC46BFD4;
	Tue, 11 Jun 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYr3z6ib"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578D376E9;
	Tue, 11 Jun 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129842; cv=none; b=e2kbGfLdMWig3p63DlEQT3pkSWNYAJp+ktNVapEMO87yo13rqUqf5pqSD+yCdKg2r8nG/3egFBrai6Nq3B09g6BE03I0wDSqPNxKVWJJ7jQLs7n3tHRAGMe41A8FE66YHNwX7Jq+nZMg9eLNABj0GvBxdCdrkEIqEpQzDaun8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129842; c=relaxed/simple;
	bh=vAq9v37lvJRm6xxE15oLaANy4ox3DXYXkORfdowFKus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWAIMslFzgI/c+qMnM1ut0bMJL7p4P0sxcDulYXFBSwth3aBpiQ2mvUHmXHtnCDxLQJhzfAvFtXMtKDUZ7ugYWy+ybTDIam2/rG9FcgSfm5pI6ba6oLcrHnbK+Yg5Ab/VQRPpkFmVouHGCY71+7YDByDI4Tla6s5qS+lJwCLdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYr3z6ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5B4C2BD10;
	Tue, 11 Jun 2024 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718129841;
	bh=vAq9v37lvJRm6xxE15oLaANy4ox3DXYXkORfdowFKus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYr3z6ibJlMpqOY/t9lhUTqyWLnfuPWDJ1FnE0nNAKGEh69zKJbuzrOYKCLqE8hYG
	 6tSj61HesZYDtJBXVOL0UQrVpNsuEHliPeNTAbTdm4hA59v5sztfR/SuGlWIGSCy4p
	 x8EBD2QIGbLQ8Iyefnsl1ZvwaAkmMX84XN5+yenphJIcv7jpAsNLKhXiujA+orPGUj
	 zMan6XGOkvuPUUrohLIdK9V5YklJhuf//RwJdfFe21mU54dmcaYWtfS6bB1xXpCVm1
	 RFHiTu0ucXGhr+p4658NFAUQCX+ut3nibak/XxT/uPeCVzEXa5LVEe8rwahOBAgi32
	 xU5KWLuRU6Rcw==
Date: Tue, 11 Jun 2024 19:17:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, denis.ciocca@st.com,
	devicetree@vger.kernel.org, linus.walleij@linaro.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240611-reassign-eliminate-b05e4a302cfb@spud>
References: <20240611160821.13941-1-kauschluss@disroot.org>
 <20240611160821.13941-2-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nu6bNi20vSq7UFgt"
Content-Disposition: inline
In-Reply-To: <20240611160821.13941-2-kauschluss@disroot.org>


--nu6bNi20vSq7UFgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote:
> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.

I can see that! Your commit message should mention why this device
is not compatible with existing variants.

Thanks,
Conor.

>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/D=
ocumentation/devicetree/bindings/iio/st,st-sensors.yaml
> index fff7e3d83a02..71c1ee33a393 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -26,6 +26,7 @@ properties:
>            - st,lis2dw12
>            - st,lis2hh12
>            - st,lis2dh12-accel
> +          - st,lis2ds12
>            - st,lis302dl
>            - st,lis331dl-accel
>            - st,lis331dlh-accel
> --=20
> 2.45.1
>=20
>=20

--nu6bNi20vSq7UFgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmiUrQAKCRB4tDGHoIJi
0qEqAQCVRcgvhVlMOSSsQ39vFTlnK/tiqhnsa3c2vFU6YIyU2gEAnojZRQ4tQsAU
xWH5Vs5gt3fzWn0kWP8/aHMLBKLJVQE=
=/Qza
-----END PGP SIGNATURE-----

--nu6bNi20vSq7UFgt--

