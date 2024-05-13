Return-Path: <linux-iio+bounces-5011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378AD8C44D8
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 18:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF962B2115B
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13715533D;
	Mon, 13 May 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzGqeL8M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF115532B;
	Mon, 13 May 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616591; cv=none; b=VuUXeyoVBqPwYRwW+6A5coMzyd7LdNkmzj4/40FXfOpBLjNC746a1E9Y/cxFDmSsIxuukg3vYC7Vq/K1VeyKM+7Q8jcLzpoEc3pZ80bbE98INVl0eQIUDA8c3jgoU9ufn0NC6R5DFuOS6TSrU1OpeyMGA2V/xIHFgzHEDsj6kHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616591; c=relaxed/simple;
	bh=VgZrcH2L0VNhynVh/vwPqZ8Wq2nfjg7j3GeXk9G68/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT5Vjzvtw3A3+CeT54/8h+r/6uPt6aScQutcZsssjWINKEPiFNYBUXRmsdU1XHhCbp6TJTQGntW5V1YFXCoIbWQ5b/T7uJRBeYIL99h0R5QZSgxpZYt1AVzpnjRzLA1/qH0EVo4f23lZMhESqS1x/rl/alvO8+figyfCOov+l4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzGqeL8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5A4C113CC;
	Mon, 13 May 2024 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616590;
	bh=VgZrcH2L0VNhynVh/vwPqZ8Wq2nfjg7j3GeXk9G68/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzGqeL8Mea6GqV6H07IZzyG42u7QxB9xAZUCqSfxWiZFrzj8LQcDNWyC0IsfzFJT5
	 OnJiy/GWTdIxyNWZvkyUZ+gZyTiV99ra+1SDHmvg4js4YMpyyCEE5GptOsLYfWqkaR
	 oExXUDOc6w2OdEJaBUhwvJXF7rHTx2wwcC+SoW6br/pkWYdCF1/Q2kx5bB0Q+p9GHP
	 MiX5notiRHe00SD4KqaimIP7WgYE7guLhguLcsPiMqXOqM4GelCPT1RkNaRwEZ/FIi
	 nRVoYTqpXLYHASnhpgoaugk51x4MwKVbeRZSZah9FRIzK2pc1XGCVtEHAj/TxQUDxc
	 AJEPGASh/1jCQ==
Date: Mon, 13 May 2024 17:09:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de, christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: Add ENS160 as trivial device
Message-ID: <20240513-entree-ferris-cbaf7c57b0b5@spud>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
 <20240512210444.30824-3-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dbL0gNk2qdW68dmr"
Content-Disposition: inline
In-Reply-To: <20240512210444.30824-3-gustavograzs@gmail.com>


--dbL0gNk2qdW68dmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 06:04:38PM -0300, Gustavo Silva wrote:
> ScioSense ENS160 is a multi-gas sensor.
>=20
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Looks like this device has two supplies, Vdd and Vddio.
Jonathan generally likes supplies to be documented, so that would
disqualify this as a trivial device.

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index e07be7bf8..cdd7f0b46 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -318,6 +318,8 @@ properties:
>            - samsung,24ad0xd1
>              # Samsung Exynos SoC SATA PHY I2C device
>            - samsung,exynos-sataphy-i2c
> +            # ScioSense ENS160 multi-gas sensor
> +          - sciosense,ens160
>              # Semtech sx1301 baseband processor
>            - semtech,sx1301
>              # Sensirion multi-pixel gas sensor with I2C interface
> --=20
> 2.45.0
>=20

--dbL0gNk2qdW68dmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI7SgAKCRB4tDGHoIJi
0k/eAQCSd/M4zUc1ofya4kDKydd6wRBwRRHnsAAiT7Qyfi65DwEAsrQnbgqZgQdN
3rkQXY8pa9rpx8pPLcKaio1D8l1WQQ8=
=hSoY
-----END PGP SIGNATURE-----

--dbL0gNk2qdW68dmr--

