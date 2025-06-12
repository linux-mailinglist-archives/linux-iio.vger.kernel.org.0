Return-Path: <linux-iio+bounces-20532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EA3AD6C18
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 11:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B60189DBFC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F261226CF8;
	Thu, 12 Jun 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="PkZDjm+V"
X-Original-To: linux-iio@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8B1DDC1B;
	Thu, 12 Jun 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720463; cv=none; b=C29lCIzcOFbk0hxi2W10SwiCQLtkZQPcohS0+f5vrLtvReBlHCoJ4GUjuzsgz0wbC4dxCYetIRgKDRu4tjQ/48VrQndx3d6P25Gm8s8YTYH4Io0RsjhJw9pExrhBt4tEDlvRMBFZoNnnlt08FkCHj7c2gfUOZ0MiswLnN2mrXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720463; c=relaxed/simple;
	bh=zU2wAuUr/7XYBXddnsRh3IBaolX1LhhUnQ+M9OIR0q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9cMsU9mRcHFIS4qyNJ+2LtbXUmqzHcqBh2zvTF8keh2klDRv5LyjYFNieH2ys+aCUkvHPcdVT+sc/GLUZdhDvoPT4jmvX9tI9oCRoDdp5WUJufic7Wn+rmL9zK7Hi/Mt2osriCp0vQtATZUtHDaLhXVWke2eQ7aLDe/CMRNGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=PkZDjm+V; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C9E871C00B7; Thu, 12 Jun 2025 11:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1749719872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jK207JmCPoreSPAxEuJucLTQP5EiXczQgWbs/TTbYI0=;
	b=PkZDjm+VNaBiHoM19j/d5n9YER5Bd3SVefh8dKqwEN8k5jc2k65ob+oA7hwkxHW6kxGWBX
	9O4xDZh7LriFaoxfmyvFJQg3qyg3IlrtwF8xT0JGHqOaRBnYof2s+Lj763My4eXvfO6kxu
	0RF39dsnyWVpKCOD3wdHEG1hkzigaK4=
Date: Thu, 12 Jun 2025 11:17:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
	Roan van Dijk <roan@protonic.nl>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/28] iio: zero init stack with { } instead of memset()
Message-ID: <aEqbQPvz0FsLXt0Z@duo.ucw.cz>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rtWrUApkft0MEwbP"
Content-Disposition: inline
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>


--rtWrUApkft0MEwbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Jonathan mentioned recently that he would like to get away from using
> memset() to zero-initialize stack memory in the IIO subsystem. And we
> have it on good authority that initializing a struct or array with =3D { }
> is the preferred way to do this in the kernel [1]. So here is a series
> to take care of that.

1) Is it worth the churn?

2) Will this fail to initialize padding with some obscure compiler?

3) Why do you believe that {} is the preffered way? All we have is
Kees' email that explains that =3D {} maybe works in configs he tested.

BR,
								Pavel

> [1]:
> https://lore.kernel.org/linux-iio/202505090942.48EBF01B@keescook/



> ---
> David Lechner (28):
>       iio: accel: adxl372: use =3D { } instead of memset()
>       iio: accel: msa311: use =3D { } instead of memset()
>       iio: adc: dln2-adc: use =3D { } instead of memset()
>       iio: adc: mt6360-adc: use =3D { } instead of memset()
>       iio: adc: rockchip_saradc: use =3D { } instead of memset()
>       iio: adc: rtq6056: use =3D { } instead of memset()
>       iio: adc: stm32-adc: use =3D { } instead of memset()
>       iio: adc: ti-ads1015: use =3D { } instead of memset()
>       iio: adc: ti-ads1119: use =3D { } instead of memset()
>       iio: adc: ti-lmp92064: use =3D { } instead of memset()
>       iio: adc: ti-tsc2046: use =3D { } instead of memset()
>       iio: chemical: scd4x: use =3D { } instead of memset()
>       iio: chemical: scd30: use =3D { } instead of memset()
>       iio: chemical: sunrise_co2: use =3D { } instead of memset()
>       iio: dac: ad3552r: use =3D { } instead of memset()
>       iio: imu: inv_icm42600: use =3D { } instead of memset()
>       iio: imu: inv_mpu6050: use =3D { } instead of memset()
>       iio: light: bh1745: use =3D { } instead of memset()
>       iio: light: ltr501: use =3D { } instead of memset()
>       iio: light: opt4060: use =3D { } instead of memset()
>       iio: light: veml6030: use =3D { } instead of memset()
>       iio: magnetometer: af8133j: use =3D { } instead of memset()
>       iio: pressure: bmp280: use =3D { } instead of memset()
>       iio: pressure: mpl3115: use =3D { } instead of memset()
>       iio: pressure: mprls0025pa: use =3D { } instead of memset()
>       iio: pressure: zpa2326: use =3D { } instead of memset()
>       iio: proximity: irsd200: use =3D { } instead of memset()
>       iio: temperature: tmp006: use =3D { } instead of memset()
>=20
>  drivers/iio/accel/adxl372.c                       | 3 +--
>  drivers/iio/accel/msa311.c                        | 4 +---
>  drivers/iio/adc/dln2-adc.c                        | 4 +---
>  drivers/iio/adc/mt6360-adc.c                      | 3 +--
>  drivers/iio/adc/rockchip_saradc.c                 | 4 +---
>  drivers/iio/adc/rtq6056.c                         | 4 +---
>  drivers/iio/adc/stm32-adc.c                       | 3 +--
>  drivers/iio/adc/ti-ads1015.c                      | 4 +---
>  drivers/iio/adc/ti-ads1119.c                      | 4 +---
>  drivers/iio/adc/ti-lmp92064.c                     | 4 +---
>  drivers/iio/adc/ti-tsc2046.c                      | 3 +--
>  drivers/iio/chemical/scd30_core.c                 | 3 +--
>  drivers/iio/chemical/scd4x.c                      | 3 +--
>  drivers/iio/chemical/sunrise_co2.c                | 6 ++----
>  drivers/iio/dac/ad3552r.c                         | 3 +--
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 5 ++---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 5 ++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c        | 4 +---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c        | 6 ++----
>  drivers/iio/light/bh1745.c                        | 4 +---
>  drivers/iio/light/ltr501.c                        | 4 +---
>  drivers/iio/light/opt4060.c                       | 4 +---
>  drivers/iio/light/veml6030.c                      | 4 +---
>  drivers/iio/magnetometer/af8133j.c                | 4 +---
>  drivers/iio/pressure/bmp280-core.c                | 5 +----
>  drivers/iio/pressure/mpl3115.c                    | 3 +--
>  drivers/iio/pressure/mprls0025pa_i2c.c            | 5 +----
>  drivers/iio/pressure/zpa2326.c                    | 4 +---
>  drivers/iio/proximity/irsd200.c                   | 3 +--
>  drivers/iio/temperature/tmp006.c                  | 4 +---
>  30 files changed, 34 insertions(+), 85 deletions(-)
> ---
> base-commit: 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
> change-id: 20250611-iio-zero-init-stack-with-instead-of-memset-0d12d41a7e=
cb
>=20
> Best regards,

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--rtWrUApkft0MEwbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEqbQAAKCRAw5/Bqldv6
8quUAJ9TqDazu4enIZD/WIHKSEebP5o8lQCgo2StzDEJ7G4crF9oQEjDZPrt78A=
=/MEA
-----END PGP SIGNATURE-----

--rtWrUApkft0MEwbP--

