Return-Path: <linux-iio+bounces-25916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CFEC362AA
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDE81881E84
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208BC329E62;
	Wed,  5 Nov 2025 14:51:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F9246BB2
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354310; cv=none; b=higDekvveHhfiDuiuPBedvLsM8igD+5s+VQ+iP6idzuJ2y6/G58stn/2LaHtRAlLajDJNhrQSVcmyzHENrGWrxkAHm2wLBRYHHBNCshZoAwrwbhY7p4pc4nV8rheEQWdGwJnfN46xwnUNKj0YCkPU7tm4cadtkPxvUFYPx8gWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354310; c=relaxed/simple;
	bh=kArMz44jDsq9lMxSADlKl6F6xCdH6Wh/a/aPNuLy9K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDJ5bM4iiNtoYkLA1sdEaEYA2fYvdzED+928T0K8+3NwleBmDsGOfukpP1qh8pQ3OJMpkdVhDIwB4PsnLFNCa8FW6tuQPA88flgRmEIocj1LI/qHGuK14YR+FBnNl2pUYoyi5X1eB7L3SNonQYcy/821NNw5cbcvJ6B6IvTv/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vGerK-0005pR-VW; Wed, 05 Nov 2025 15:51:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vGerK-007DJ0-0B;
	Wed, 05 Nov 2025 15:51:38 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B84844985DB;
	Wed, 05 Nov 2025 14:51:37 +0000 (UTC)
Date: Wed, 5 Nov 2025 15:51:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	kernel@pengutronix.de, David Jander <david@protonic.nl>, 
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <20251105-refreshing-classy-koel-ecf968-mkl@pengutronix.de>
References: <20251105143814.1807444-1-o.rempel@pengutronix.de>
 <20251105143814.1807444-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kiei2i6q7lmfevfz"
Content-Disposition: inline
In-Reply-To: <20251105143814.1807444-3-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--kiei2i6q7lmfevfz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
MIME-Version: 1.0

On 05.11.2025 15:38:14, Oleksij Rempel wrote:
> +static int ads131m_probe(struct spi_device *spi)
> +{
> +	const struct ads131m_configuration *config;
> +	struct iio_dev *indio_dev;
> +	struct ads131m_priv *priv;
> +	int ret;
> +
> +	spi->mode =3D SPI_MODE_1;
> +	spi->bits_per_word =3D 8;
> +
> +	if (!spi->max_speed_hz || spi->max_speed_hz > ADS131M_MAX_SCLK_HZ)
> +		spi->max_speed_hz =3D ADS131M_MAX_SCLK_HZ;
> +
> +	ret =3D spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Error in spi setup\n");
> +		return ret;
> +	}
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv =3D iio_priv(indio_dev);
> +	priv->spi =3D spi;
> +
> +	indio_dev->name =3D spi_get_device_id(spi)->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ads131m_info;
> +
> +	config =3D device_get_match_data(&spi->dev);
> +	if (!config) {
> +		const struct spi_device_id *id;
> +
> +		id =3D spi_get_device_id(spi);
> +		if (!id)
> +			return -ENODEV;
> +
> +		config =3D (const void *)id->driver_data;
> +	}
> +	priv->config =3D config;
> +
> +	indio_dev->channels =3D config->channels;
> +	indio_dev->num_channels =3D config->num_channels;
> +	priv->num_channels =3D config->num_channels;
> +
> +	/* Get the external clock source connected to the CLKIN pin */
> +	priv->clk =3D devm_clk_get(&spi->dev, NULL);

Can you use devm_clk_get_prepared() here? This simplifies the
ads131m_hw_init() function.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kiei2i6q7lmfevfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkLZHYACgkQDHRl3/mQ
kZxTyQf+KZP429n572RPaSeQ0vUbhSrtZM+mXkxHxuGaGruxmBphZMPoV4kjyMdP
iw5j1SivNu7kLA46N/zHSzo6XKbUj3yB57+gnaFt1t4OpBessYF30e6mUsxKWkmf
g2juuE/XYgvrQ95LP4DWdon2hNiMHi0gDbIAhyOZqY66rUr5E4V8eKUC0xdkQ5J8
QScH88XdFmium7gWPfJZP3eFCA5AvQoazBNfarBwTCHP/UQCeUQvbcnj3lEI/G23
YHMgluBBGrKthOR1ZVQ4ixQ+UYWlhfK3YR47GszflRCY58hszD9kkYuvubq0ULtZ
yJA8PtLMqgs+xm9UHo+LCEF89HREtw==
=pX3M
-----END PGP SIGNATURE-----

--kiei2i6q7lmfevfz--

