Return-Path: <linux-iio+bounces-25161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E21BE5578
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 22:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3807A4F5D5D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 20:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAD62DCF45;
	Thu, 16 Oct 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoZisRuh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0F298CBE;
	Thu, 16 Oct 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645617; cv=none; b=Xmuq5c/hbDp7lAv/O4bmulQR/CEgFeVS5eMy5Yhug2M9KGIfjJU0g/iU1bNMCF/rFDejHBKmYA0rGOc1/SoJJdYiUcIc4675Z8RZXkhFgq0mraIkABcFrvmMA+1y/wY0ChxF8+NRaYRyztCRqpwcX7BYKBGtrfBrR/CzF5xNIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645617; c=relaxed/simple;
	bh=C6hEZSRNOhTaYZZm6HwiLiUAsURbOeJrgP9+CDQbRdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwcukZlWwbp9XVM8NIxwyvGK5rH7udeiNyM4kYl+mCeCa3YyncVgXpRdGA6c/wewPGQyogxL4sZnA3tTEWuX8Ta9JUbjE71/vjzScM2A20HjtfNePEM/yLnZjm0yJ06BcXMbBYel1xwsahFotos9jP+PhJFRGxPO91QClgLzqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoZisRuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C923C4CEFE;
	Thu, 16 Oct 2025 20:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760645616;
	bh=C6hEZSRNOhTaYZZm6HwiLiUAsURbOeJrgP9+CDQbRdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoZisRuhk0bD1uZr60YjMBtVCK47m9WexDTl+CG9Rj2C0/Qg3oX6E3pEXtNr8viFu
	 cXiNL3x6ci9ykuFB+CEMaazMa/VRi0064Ck44lmVPLeyRumfy8wT4tfakGCROARAWd
	 fhxThjTbDmE3ig35LgsEUEr2ITJ/E2ik+2Ar6hCFgXoop6MG2Xi2eZinxxOTyduTF9
	 x5NCRxGA/1x/RWYlHBZbRM5clI4oJOp8OzT48MKgPWhx11Z+yuRmMPV2P6WkDzBdMw
	 3F4Wvn4aTLAzG6Kx4GmL3DoHvATbCpzzpR1YBTeItOSrTQLlJSQKRg5lqzu8cHIxtJ
	 XiLA/WOvjCd0A==
Date: Thu, 16 Oct 2025 22:13:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr
 struct member
Message-ID: <aPFR7r-aHtURsWtD@lore-desk>
References: <20251016172122.1220332-1-flavra@baylibre.com>
 <20251016172122.1220332-2-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zHw0xrITPIhzFWvc"
Content-Disposition: inline
In-Reply-To: <20251016172122.1220332-2-flavra@baylibre.com>


--zHw0xrITPIhzFWvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The `odr` field in struct st_lsm6dsx_sensor contains a data rate
> value expressed in mHz, not in Hz.
>=20
> Fixes: 290a6ce11d938 ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index c225b246c8a5..bd366c6e282a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -365,7 +365,7 @@ enum st_lsm6dsx_fifo_mode {
>   * @id: Sensor identifier.
>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>   * @gain: Configured sensor sensitivity.
> - * @odr: Output data rate of the sensor [Hz].
> + * @odr: Output data rate of the sensor [mHz].
>   * @samples_to_discard: Number of samples to discard for filters settlin=
g time.
>   * @watermark: Sensor watermark level.
>   * @decimator: Sensor decimation factor.
> --=20
> 2.39.5
>=20

--zHw0xrITPIhzFWvc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPFR7gAKCRA6cBh0uS2t
rN21AQDLFEaHQItSaDlFETFDMPlEwS7tt+1HVBKifbtZvjz2CwD/S3s8tsVpI54j
mP+Btt8kCfQaxPTQwoBdinTFqtZ7sgI=
=g0Jo
-----END PGP SIGNATURE-----

--zHw0xrITPIhzFWvc--

