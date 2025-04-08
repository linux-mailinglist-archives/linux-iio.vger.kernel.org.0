Return-Path: <linux-iio+bounces-17800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0416A7F5A3
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 09:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239953BA72F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 07:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289AA25FA2E;
	Tue,  8 Apr 2025 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhBKXmf2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B725F798;
	Tue,  8 Apr 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095926; cv=none; b=lWDclQqvTc/AVn3PIOiPS4CAHF/Ogu+rzmSabv5iIgwBVvIDvxU81dMWxMRc2jcqYCM58dLjb5059HsVz4D9uv3BKkRGnq8kxwNxxYIZQoDx8qG1aesam8ikEWsNchLAecXVVpuCzyQ7U/1K/MLSpREpblNaDk3ZTtQv7hEL7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095926; c=relaxed/simple;
	bh=GciUSmDoiyOOH8RESRqc/QgBNQpo9ZXAnJgR53gp4So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4kPITsppd0ljVEi6iK6O3YSVSIAnTX+wvF5wlp0zbIFdnoxi5FU62aIxfxh0mUbdGafpV/Zf53mC7etxdyTP0JgZT+XQyQb1+b1V9HQGz9pMIMqmphjt0aKCIoWfeYf1UtJUMY3YTH17W9QcmIRvCp+yhR0DnP0rADsN4SDEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhBKXmf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF76C4CEE5;
	Tue,  8 Apr 2025 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744095926;
	bh=GciUSmDoiyOOH8RESRqc/QgBNQpo9ZXAnJgR53gp4So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhBKXmf2loebWjpDATXkQowrCtc9eRDG2jooHYgtnX/ND1fwM/DXn9ndz99JTWBG0
	 dSDhLzo1RIDGNLhIkzX8H6TPpt/RftkdzcmtW52paJwsb4gAUum2S9tl3cmKoTbaGC
	 n3TwbNINdKoCB2v85KYPwPAdZbpIb1HiK6Fzy+GEQhlIWlp175/ce8lZbWYvO6XH6k
	 jQW5eAp/68D5fzVZJzh3D6sMt+XLmkAf305YhMpxsH6UDmE5SN8DPqjUix8SZj9EQb
	 c5iUx+hYhSvGYb4t2xOy59B+Vt3loE44+lx+gF7f73jK9JiC0W6f62hei2NvehaEt6
	 E4UOOmnt45OHQ==
Date: Tue, 8 Apr 2025 09:05:24 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: Fix wakeup source leaks on
 device unbind
Message-ID: <Z_TKtP_5S99Nakrs@lore-desk>
References: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
 <20250406-b4-device-wakeup-leak-iio-v1-3-2d7d322a4a93@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s3vjrGR+QtVN7rVS"
Content-Disposition: inline
In-Reply-To: <20250406-b4-device-wakeup-leak-iio-v1-3-2d7d322a4a93@linaro.org>


--s3vjrGR+QtVN7rVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Device can be unbound, so driver must also release memory for the wakeup
> source.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 4fdcc2acc94ed0f594116b9141ce85f7c4449a58..96c6106b95eef60b43eb41fef=
67889d44d5836db 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2719,8 +2719,11 @@ int st_lsm6dsx_probe(struct device *dev, int irq, =
int hw_id,
>  	}
> =20
>  	if (device_property_read_bool(dev, "wakeup-source") ||
> -	    (pdata && pdata->wakeup_source))
> -		device_init_wakeup(dev, true);
> +	    (pdata && pdata->wakeup_source)) {
> +		err =3D devm_device_init_wakeup(dev);
> +		if (err)
> +			return dev_err_probe(dev, err, "Failed to init wakeup\n");
> +	}
> =20
>  	return 0;
>  }
>=20
> --=20
> 2.45.2
>=20

--s3vjrGR+QtVN7rVS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/TKswAKCRA6cBh0uS2t
rOgiAP0XRypFHUm+gAEZRrabccqH17B5Tp2XEjsujDO9TsmlMwD+LQBZVclZuoGz
s7oaY38hSzzhd5wAUkrhmyRXALvwDAc=
=FnZy
-----END PGP SIGNATURE-----

--s3vjrGR+QtVN7rVS--

