Return-Path: <linux-iio+bounces-4908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312578C02EF
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 19:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F741F245B7
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AE12A175;
	Wed,  8 May 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE4Beywt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5A2E3E8;
	Wed,  8 May 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188688; cv=none; b=pbifQ+mY+s+NGOMJ+b8V27mJwCNcPkUIHA6XWiWyh//Wy4anwo6XMurXXlmnpk1XzTBkTxp2kGgtNJm05s7Roh/7ZYLI2nUu0yP2plD0hWswCaZC+QNyBcWnextXY+PFq+v7dUq6Fa9EXT1LgVylT6lAkXgww21CCnbZYoxJF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188688; c=relaxed/simple;
	bh=uLLaune42TupOBgkRUofecfgAsBuOBglfsyyRmLDEHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXqxnIlypDKk90C7A5dDTWY2zlpY9brKhbb6GILULLzrh/LAk5Ej3WpUUxWyWSD6tRzXqQ+6zOASpvWell3GUTJJLRAlhevMIqA7bvbIxVD5ehndXlozqnRL4LC/B4qrCov8GhRTlikIcYEJUg9SCuYz05n+T5So3qoLt3Fb2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE4Beywt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D4CC113CC;
	Wed,  8 May 2024 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715188687;
	bh=uLLaune42TupOBgkRUofecfgAsBuOBglfsyyRmLDEHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eE4BeywtHEsHwRws/u3ElnzkL/r8QoUb9Hsa7YIM4AHjc+1an2O0of6bQ79OpBMDX
	 rgCa/StEDE/baqvccO2zFfBQsI8gTwzgM/L0fsvQLsj9LsMaI52CIAMVEsmal0CReU
	 HruYfuXnWUMRVjTLmjNv6X+BusDfcXyYjSMMmrmAD9dSSTE3pe1pkk/P1D2ofPDrUq
	 rojV/jJBHWTY2cOwlVAROgVVSLAAZj4f4xt/xD3GavNHykDp97T3zEt/L0B+btL3HC
	 btV6ei7tFgkzEJuAVH3lvuouUwYvMzHfAA26nA06csBUBwY02mRKk45hknXYID79CO
	 E7yWSWqsGarXg==
Date: Wed, 8 May 2024 18:18:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: imu: Add ADIS1657X family
 devices compatibles
Message-ID: <20240508-monsoon-theology-d141f4e32bad@spud>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
 <20240508131310.880479-8-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WpJ+I2U/bkBC8Ytu"
Content-Disposition: inline
In-Reply-To: <20240508131310.880479-8-ramona.bolboaca13@gmail.com>


--WpJ+I2U/bkBC8Ytu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 04:13:09PM +0300, Ramona Gradinariu wrote:
> Add ADIS1657X family devices compatibles and specify the according
> maximum SPI baudrate.
> Similarly to other ADIS1650X devices, ADIS1657X supports sync-mode
> values [0,2].
> Each newly added device has a different angular velocity/linear
> acceleration/ delta velocity scale combination, as follows:
> Accel dynamic range sensitivity:
> - 262144000 LSB/g: ADIS16575
> - 52428800 LSB/g: ADIS16576, ADIS16577
> Gyro dynamic range sensitivity:
> - 2621440 LSB/deg/sec: ADIS1575-2, ADIS1576-2, ADIS1577-2
> - 655360 LSB/deg/sec: ADIS1575-3, ADIS1576-3, ADIS1577-3
> Delta velocity sensitivity:
> - 2^15/100 LSB/m/sec: ADIS16575
> - 2^15/125 LSB/m/sec: ADIS16576
> - 2^15/400 LSB/m/sec: ADIS16577
> Each ADIS1657X device supports FIFO usage and a sample-rate of 4.1KHz,
> meanwhile the already existing devices do not support FIFO usage and
> have a maximum sample-rate of 2.1KHz.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---
> changes in v2:
>  - updated commit message stating the differences between the new added d=
evices
>  and existing ones supported by this driver

Thanks for that. Was much easier to understand this way than cross
checking a bunch of structs and the justification for how the bindings
look should be in the binding commit message anyway :)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--WpJ+I2U/bkBC8Ytu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjuzywAKCRB4tDGHoIJi
0mehAQC8UPguZodr1irMCzp/fysIvK+krWOQqFCuTAdnBGW4xgD/ZrNfugE7vATt
GBNvkJhgirM/PqrQECwkgCA8q+RkMAs=
=vlxh
-----END PGP SIGNATURE-----

--WpJ+I2U/bkBC8Ytu--

