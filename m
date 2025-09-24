Return-Path: <linux-iio+bounces-24400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBAB99862
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E272A19C7711
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1F2E62BF;
	Wed, 24 Sep 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I/UYiK1N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196D2E5B32
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711835; cv=none; b=rxObVCdhvz35HFnzVuI/NfdlFDf98yBOiDsnYTZBE1Cc5HmWTA2TY0SNXqlmPMz3u1wplq3ipAWY2nqZK5BffOT+56qRfSoy1L+T8G4gH3gygM910FRC2StAR3cfv0tUaZvGli+w8HAAPXzVHvEcNXkd8TQzzsVV3pdBNoZ6PDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711835; c=relaxed/simple;
	bh=vRaOT9Q3YvJQNWFbw0Fz0aeIvu9zB6I2v+SoiGqfWwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz/Mr7cgnn/Iry4yBcVrzqVB/vLaVnZysH0uPszp/r+m1103WezjhTn4Z49panbx+6DCmCGHZpmcoMAPMNhTm8egiryGKT5zVhvtIsfyz9ad3MzGycZlSPa/VuSWPbTxkKCl7+1iIaJXL7rRL6WMNqdOZ3fdn8hVJrUFLNAoyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I/UYiK1N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b30f8d14b9cso244052466b.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 04:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758711827; x=1759316627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f++NaNuyR4eX62VVTKpDJcYw+NpFttUC6PgqiII/fcw=;
        b=I/UYiK1NiAwsOZ45z3vC7BsSBZrwAnZhqs7wYLM+jzBarnE1vEiy25oGhPWLq71Ukq
         E4czQjBttMqeJuUWQ2hxTCvhHegoKepzq1z2Ip1wPFjb9zdw5tFk4vo5xXQvtZqZpH+s
         CikWzYOqCpUq+nII9l/JElw8u8p8fSCXMLNKEjFDdKsb7POGYtYYi0sEHlxewBy4+MuJ
         8xYl3dXgg5m+O03N98T/SkkWJoUItdDrn5oh0kRPbTNtwc+ic1GJQTeU/ShWWd3EwPtb
         MTYKLFtwBd2aat7OLDHDrCzkg+1gU1gmNbgVNLcQvFxpXcQ39ansq8uGTysf+kN/P1/z
         vEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758711827; x=1759316627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f++NaNuyR4eX62VVTKpDJcYw+NpFttUC6PgqiII/fcw=;
        b=dGb6uztHGmLqqWHUWKPGChzR/oiPQrlu2jpPSAPjA6RgM1sIPl4XzIIdYwTIeikmtY
         THoUKiGNkHubjQoeugRUeo37zDZPIYO6ZqNJ0og4ouCPs1Id8Gs+sJ+Iw6rk4ny9ARvM
         Get/YRg1umDsYHVuU+HfrAi6U0I0HkLZCdCNLJM/qGxhjbC6n5PtiqhQRAtpTtI3k2IE
         WFSGPTEoPzuJ8CBh5fhpLAn5yjxloBBbmzxO1C6dupRu0lIBMN7sgW+YURVNqIuHpwbx
         zLdqJETSFixG2Z2+6E9HC2QTL5hGxpJqdb1N40fFb2eM85cuXsQdWi4Bp+hHtNwRk/+s
         W2pA==
X-Forwarded-Encrypted: i=1; AJvYcCUEKprec6f2CkzSzXUQA8NJshYoNrXOwWu6yCpnkXGx+H3YMXxUBCvONsg9j0jpzPHS/wcMV11UXx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZUeDWlTmEslH+PLrSr1aYRxhW12tlnePuKUccrcNSz9O2itjb
	cHW/YVoPCIGma4iRgHb2aT8QAmjXd62YdxASxWylXrulnNX3RFwDs5kupb/UqJSlJirvw3WvKaJ
	8MNTg
X-Gm-Gg: ASbGncuplOZ/Thb6bBBoy5RrPVByawDSNxh1lqQZhFZLT8fnZJOAy10p/yBc62qxdGJ
	sXYIZYEgblCfyq0OFjn/a40OzASmLQvuxXhjT32c/0vju1nH1shxIBEoXzyOt52hoYb/MNVbmvz
	lre879Kp11FwjsbyhBNbrmafpC4yp/+Ia+v9Ty7bxjjJ/Qu3KzPLS1fHrzPMYG3FxvEW2ePawyv
	V6PlwIOzkHYn0YdBn81oGPAzeaohkCiPTYyG3Srd8DfZhZVy6o/bJtEwCZJ3cMhXDpj021Ndau5
	qA7gTqukCWMSJpU16zOSdV7/Ji73Vex4O915q2N5j6HBMW1I3Wwwd/JaxEVgXwlyJQlCQ9VRlk6
	zOEanMGep3gHmbNRkGye8V10OV5WeRhvZ61MLVA==
X-Google-Smtp-Source: AGHT+IFBwMGZ4wBRteHoxqPVvsjT3lf+VIufpVIMyZrC/No4MyrhUd4ysW+E9ZygAk5RcfGCQiGU2A==
X-Received: by 2002:a17:907:3d02:b0:af9:6bfb:58b7 with SMTP id a640c23a62f3a-b302679e8d7mr570930666b.5.1758711826582;
        Wed, 24 Sep 2025 04:03:46 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b2d4309ab9asm611622266b.74.2025.09.24.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:03:45 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:03:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
Message-ID: <h2rof27omrhv4l6pjisdsnvkpb35ovy7e6m4soeltfun5rafk5@oriv7e3egh3p>
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="diar7b3iid3lrt6r"
Content-Disposition: inline
In-Reply-To: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>


--diar7b3iid3lrt6r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
MIME-Version: 1.0

Hello David,

On Tue, Sep 23, 2025 at 03:18:02PM -0500, David Lechner wrote:
> Fix temperature channel not working due to gain and offset not being
> initialized. This was causing the raw temperature readings to be always
> 8388608 (0x800000).
>=20
> To fix it, we just make sure the gain and offset values are set to the
> default values and still return early without doing an internal
> calibration.
>=20
> While here, add a comment explaining why we don't bother calibrating
> the temperature channel.
>=20
> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at=
 probe time")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7124.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 374e39736584f55c1290db3e257dff2c60f884d2..94d90a63987c0f9886586db0c=
4bc1690855be2c1 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -1518,10 +1518,6 @@ static int __ad7124_calibrate_all(struct ad7124_st=
ate *st, struct iio_dev *indio
>  	int ret, i;
> =20
>  	for (i =3D 0; i < st->num_channels; i++) {
> -
> -		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> -			continue;
> -
>  		/*
>  		 * For calibration the OFFSET register should hold its reset default
>  		 * value. For the GAIN register there is no such requirement but
> @@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124_st=
ate *st, struct iio_dev *indio
>  		st->channels[i].cfg.calibration_offset =3D 0x800000;
>  		st->channels[i].cfg.calibration_gain =3D st->gain_default;
> =20
> +		/*
> +		 * Only the main voltage input channels are important enough
> +		 * to be automatically calibrated here.
> +		 */
> +		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> +			continue;
> +

I don't understand a detail of the problem. The commit log suggests that
there is a general problem, but looking at the patch I suspect there is
only a problem if at probe time the OFFSET and GAIN register for the
temperature channel are different from their reset default setting.

I think the patch is fine, but if my understanding is right the commit
log is more dramatic than the issue really is, as it needs some fiddling
with the ADC's registers between poweron and driver loading to trigger.

Best regards
Uwe

--diar7b3iid3lrt6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjT0A0ACgkQj4D7WH0S
/k629gf9EEyMob63w45sy8E1Tl2I0vbiHhfCGjC0RuxdvWZZ94q7yARaASpMhL0L
+6NNeLxgzvoVEQ/I680dnAoDBysDPbIY2jT4V4AiwU+8faJMbapw3FMq89ojV1x0
vaTqrmUHtU/aNqalhl953zpWgSo4YH5ZIkiqgj5yJUTMz23XRmJblV99y97NTjOE
GbW8kI/Qn1Y57Rhe90rwKM5GYJUs+Il/R61u2o8oSp135MDCGJeD8Q8n17JzH87B
WXORKMd787hcPOlIJ3KVTYXBBg3YB9fwBT/MC5u8mFr3ZDQJnlf4kdPpm56Er/d/
zId8hbNmZtRPi0pMVy9PXnn1ehuTYw==
=1vmw
-----END PGP SIGNATURE-----

--diar7b3iid3lrt6r--

