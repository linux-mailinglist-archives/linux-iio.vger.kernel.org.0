Return-Path: <linux-iio+bounces-24884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F7BCAD1A
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F15F1A608DD
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF7271450;
	Thu,  9 Oct 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giOLzron"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E31632DD;
	Thu,  9 Oct 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042405; cv=none; b=GPZRHzjVLBq3o+r6EdH9BzwySvcS1bt6KZ2BO/Pk8y9qCTamIMknMim0Zzy4ceVpGkv62UFNWPLAlOnTNtf1WKOLKsuqaqo9BbQxETx7axjC2+DOlD4bCi0fGL/JKYOacwHMJR2ZC3Ph3lGvDyvCfoEzz6Mq4uasJqo2+f1plMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042405; c=relaxed/simple;
	bh=Wra3e96sQ7aWAyWRJLgAXDUOVBj08fFQTKXs5dMkJz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4ePlwQSmrQExAyHdMC+GQ4DSZ6Kqmp7VN7dCPRPlgGFk+epPh8vNiXy10/zVE5wqIgH98dZSzU3tSiRmka3SpbR5FfUQHfO9Bjsck7f8cLn8qbL2m6pDVwYETKWRztZF4qwv2ek4k8kV32kMp7Bsmj0VEBil/OxL1NsRYoRSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giOLzron; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75C6C4CEE7;
	Thu,  9 Oct 2025 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760042405;
	bh=Wra3e96sQ7aWAyWRJLgAXDUOVBj08fFQTKXs5dMkJz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giOLzronK9BXQAEL0gaFblUEKMv6DFNRByb3FpCJOzCLnooraMrjFQOelnzsUJEWj
	 NinDePxLdcvgztVNhkd8XEvRNpjqlWyI8mL4b8cpc7WfH3+Dc+0vr7c5X4Nflv21vm
	 2MciHq2FneeqiVcnMqdlvq7v0SzXgBi0PKZijd4AD7fyo/QQljRhOgKzHbvkKe4LUI
	 UdIpfvhwv7mD8WYODWngNlTI1iz+WGZoVub3rqH2X8X1KGYbVVgfkELBldshF8mPJe
	 B1jBd9m0DYvpDo6Gle7LPrkXyz3W2YfEb+wyV1kNXnJOOez5Vl9Iit3x8N75B89wXo
	 XIvUkz+igk02w==
Date: Thu, 9 Oct 2025 22:40:02 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr
 struct member
Message-ID: <aOgdogFe9b1DTQry@lore-desk>
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-2-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TjOEAo5HJ71aNQ+2"
Content-Disposition: inline
In-Reply-To: <20251009173609.992452-2-flavra@baylibre.com>


--TjOEAo5HJ71aNQ+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The `odr` field in struct st_lsm6dsx_sensor contains a data rate
> value expressed in mHz, not in Hz.

ack, can you please the proper Fixes tag?

Regards,
Lorenzo

>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
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

--TjOEAo5HJ71aNQ+2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOgdogAKCRA6cBh0uS2t
rALeAP4iQaG92Gn+wxCWDhIzuRM7ioJ2kJpSI6aubPD3nISWOgD/Yr6egYnHVlzf
f/fc4RBfouJTmPvsT7IHneLJ1LB58AQ=
=nhEM
-----END PGP SIGNATURE-----

--TjOEAo5HJ71aNQ+2--

