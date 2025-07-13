Return-Path: <linux-iio+bounces-21597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B5B03103
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA113BD31D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71B38DDB;
	Sun, 13 Jul 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="tQuPvUIO"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3314A8E;
	Sun, 13 Jul 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752410713; cv=none; b=b06/t+Llww6Gx9a21kKj4HX9AzHS2mxOP5SLCCyejFcnJ6k5B8R+X2kROEdORUabo2YwJVRSgF5ZthNk0Gip7jOiERKO9gtYoR4CkX45N7bk58dzyVRT44l+H+4/oqUu8e+mSc+czRHE/CTuJpCbBlrhucjoq08Er3cie++iQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752410713; c=relaxed/simple;
	bh=rZBU0y2jqmoOWM0aYmQwhYLn+mZVkvm4nsRsDyNDSDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx825JZiZLJNGUzZ6E67s7A3Hc+dMqC9x1QcYKS3qtiXr8GeQ88Gbe7ATjC+ziccW952OlZaWGQjV6OQYt/oc8r0D2M1YgX1Mf2eDsCMlbGfysdtv90ts0mAPeqCAbBIFOgiuPdT1pj9+VoEzvt9AUEbDZiRX4f87gyki25nFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=tQuPvUIO; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=F8eV3Cnz2Uq9dxl+U8/UhYbRCkKQscIpnZCFP+5lLkU=; b=tQuPvUIO6eXZZufHyy1NBfmPmw
	SgopnYzRxn9D1KiGZft2/znqKB2Lb1Brhfha4GGX+iMjtLeYgznDmMI+HRPP1hmQWARqEc1yvsxUx
	a6XgnkKU8UycGghh03ETQ9Q7pFl1pTZxIyRUlu8nWbR+11uhxH64l6YgBlp1tPQ2CaAKDBN6Ae5Ut
	YBKgbPKvC4ImGYaziI8eOER8r3B8OQV6jzfcTsNfwrPI6YXiNFdAKCoGIP3P4VKPxa/1RHBAOnTq6
	arsX39GHrOMkndEf4oR06FOrSWErDzorFLndyUXCNGW6fYRMtkLpt9Rqu+xaUJzPiOQXrpUlCzoYd
	l6N+Nx3A==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uavdp-0003bz-0J;
	Sun, 13 Jul 2025 14:17:13 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uavdp-000B4b-1Q;
	Sun, 13 Jul 2025 14:17:12 +0200
Date: Sun, 13 Jul 2025 14:17:11 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf08: use stack allocated scan buffer
Message-ID: <aHOjxzNqW8Yf2kR7@mail.your-server.de>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SiPHZew/0PDaT8Cd"
Content-Disposition: inline
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
X-Virus-Scanned: Clear (ClamAV 1.0.7/27698/Sun Jul 13 10:39:53 2025)


--SiPHZew/0PDaT8Cd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andreas Klinger <ak@it-klinger.de>

David Lechner <dlechner@baylibre.com> schrieb am Fr, 11. Jul 11:07:
> Use a stack allocated scan struct in srf08_trigger_handler(). Since the
> scan buffer isn't used outside of this function and doesn't need to be
> DMA-safe, it doesn't need to be in struct srf08_data. We can also
> eliminate an extra local variable for the return value of
> srf08_read_ranging() by using scan.chan directly.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/proximity/srf08.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index 6e32fdfd161b93a5624f757d5b7de579415b1055..a28efcf324a844a6dca43dff6=
9e71ca38a2ccc68 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -63,12 +63,6 @@ struct srf08_data {
>  	int			range_mm;
>  	struct mutex		lock;
> =20
> -	/* Ensure timestamp is naturally aligned */
> -	struct {
> -		s16 chan;
> -		aligned_s64 timestamp;
> -	} scan;
> -
>  	/* Sensor-Type */
>  	enum srf08_sensor_type	sensor_type;
> =20
> @@ -182,16 +176,18 @@ static irqreturn_t srf08_trigger_handler(int irq, v=
oid *p)
>  	struct iio_poll_func *pf =3D p;
>  	struct iio_dev *indio_dev =3D pf->indio_dev;
>  	struct srf08_data *data =3D iio_priv(indio_dev);
> -	s16 sensor_data;
> +	struct {
> +		s16 chan;
> +		aligned_s64 timestamp;
> +	} scan;
> =20
> -	sensor_data =3D srf08_read_ranging(data);
> -	if (sensor_data < 0)
> +	scan.chan =3D srf08_read_ranging(data);
> +	if (scan.chan < 0)
>  		goto err;
> =20
>  	mutex_lock(&data->lock);
> =20
> -	data->scan.chan =3D sensor_data;
> -	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>  				    pf->timestamp);
> =20
>  	mutex_unlock(&data->lock);
>=20
> ---
> base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-6-6ffc8e99552d
>=20
> Best regards,
> --=20
> David Lechner <dlechner@baylibre.com>
>=20

--=20
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 373
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de

--SiPHZew/0PDaT8Cd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmhzo8YACgkQyHDM+xwP
AVFE7Qv/Y5OiXVcCdkPhYkWDUbsK+5l+fiDppXaCoD0QEX5Tofr9vxDEAooHOhfP
2gwJlvEoXLM6tJ1qN/JtrQFMtdIoEXA9U3LLKWXRRgmWbI9UE07DcTqmC/ypcyp/
owALndBfntvkqiF5kBjhCQ/m0Jyh3xQk+W9w6R43LGNlEHGQO0MBd3A0euh9mcHK
1gwuFPLk34jd+h8ebiaqhViW0EQkqjOFb6MQvY8D05VMCgYoepRDe3Mknt/2qLnV
vmq2TwLXqOQyfzSpFuvB8f3HiYgePEPjPU2ENHPruMEFwJurf/fWrkB+v5w8TNsF
k3hlaqqDqjC2TT8Q/00y7Koik9lzcr0RZIdDPHt2a/HwfJ4Awwz4reDt5+OT2MeT
vQkCLpDOLFPETE2VjAysb39lMJn4eqJs8sZeDGyyDhXHGozAts1dNGj+nDYwSzs7
iYZGyNakfk6pN5z5m5I0xin/Iod20eC780oLTgNrkv2Z30cukUyUR2lnmDSmC8N0
xQyQXBwv
=4DJL
-----END PGP SIGNATURE-----

--SiPHZew/0PDaT8Cd--

