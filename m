Return-Path: <linux-iio+bounces-17503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC5A77495
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8653F167F79
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D881E22FC;
	Tue,  1 Apr 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hudPsAVp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D51DF73B
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489243; cv=none; b=ivk+5mSj6MyPxYP8Tu8r7rAr9rYB1MGYSTAnwJdWnGO7p+5aEAJ7ceZjW+z4G85FZPs/KjXAWKJKMi5NIyNhxyFHkxqBTbIFO0VsAXQiyX2fakZtnkxOGG8d9e8M04NmkxCYzzQ4k40CQrNnziB12WFVAOh5aalHpZmcRTJNuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489243; c=relaxed/simple;
	bh=ajZL4KRjeQNiffs/FInVIRZHj36JRouhXhIixxKowT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REdL2Ag6N7P1VF8vI1NI3sk97epkcYTDhn+Ur6AQsQJRdptQrIHL7JhTaVxlp9WjII57p0oDeX8hOjWv/ehOFo8uM5ST0UhJ0zZlyOU3YdsdTBcicyKLVzibBtx1d7SMi3eIaHUxufBxVnazzl6z/cdsA/fG5YQbmEk5mOfp7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hudPsAVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D921DC4CEE8;
	Tue,  1 Apr 2025 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743489243;
	bh=ajZL4KRjeQNiffs/FInVIRZHj36JRouhXhIixxKowT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hudPsAVpEV4/7a6De6a3iblS2SsITSPzhT8w/aUQymcicCqFRZdLNJmusN69ABalK
	 wyyls4P6fn9IJsd59bQPZKx+w5BR1ci3wLTIXE0mdcOQsoZYgGwP9orlSHrSDAoD5o
	 3UY0LmcGc75ylgN9wt5mC4m6LgmcA+NoUAa0+KYLNTEcLV+OG8IBpNa0BMJXKuN/W4
	 4OXOtPKlTCv8pNlpe8BVTNNzmgqzr7XWoJfxxKC0HRl9XyiatESK037PxEAevGZVHW
	 i6FaktwuonuS3DH2dyST8mJ40rk0Nj5cqUZpZ5C/SJqDcDJARYAgzUZ4HybK812gSX
	 QpV+ZPHUnPM+Q==
Date: Tue, 1 Apr 2025 08:34:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 14/37] iio: humidity: hts211: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <Z-uI2DRFeDtULh27@lore-desk>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-15-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3CA+psVYauJewGS3"
Content-Disposition: inline
In-Reply-To: <20250331121317.1694135-15-jic23@kernel.org>


--3CA+psVYauJewGS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 31, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/humidity/hts221_core.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/ht=
s221_core.c
> index ca4746f2ecba..bfeb0a60d3af 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -464,13 +464,12 @@ static int hts221_read_raw(struct iio_dev *iio_dev,
>  {
>  	int ret;
> =20
> -	ret =3D iio_device_claim_direct_mode(iio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(iio_dev))
> +		return -EBUSY;
> =20
>  	ret =3D __hts221_read_raw(iio_dev, ch, val, val2, mask);
> =20
> -	iio_device_release_direct_mode(iio_dev);
> +	iio_device_release_direct(iio_dev);
> =20
>  	return ret;
>  }
> @@ -504,13 +503,12 @@ static int hts221_write_raw(struct iio_dev *iio_dev,
>  {
>  	int ret;
> =20
> -	ret =3D iio_device_claim_direct_mode(iio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(iio_dev))
> +		return -EBUSY;
> =20
>  	ret =3D __hts221_write_raw(iio_dev, chan, val, mask);
> =20
> -	iio_device_release_direct_mode(iio_dev);
> +	iio_device_release_direct(iio_dev);
> =20
>  	return ret;
>  }
> --=20
> 2.48.1
>=20

--3CA+psVYauJewGS3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+uI2AAKCRA6cBh0uS2t
rC7tAQDeZrKFbcQF8qZdPnjt6QuJo+sOXbglaJGykBFHabI/kgEAsozIJ0tf3yJY
9jcVlmZWb7+SeXmyXEsMBZIuI2OhpQQ=
=vP7y
-----END PGP SIGNATURE-----

--3CA+psVYauJewGS3--

