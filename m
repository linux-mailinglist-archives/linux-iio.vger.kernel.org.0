Return-Path: <linux-iio+bounces-1796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5498356A6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07FB2820AD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9F37714;
	Sun, 21 Jan 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3Kj+79d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45922069;
	Sun, 21 Jan 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854473; cv=none; b=sH1sHmtoXMoCZmmG/aYFRhRWKAHWOV0D//fQ/J5wmS4Y9KKNaGkx27eyF+Ow7A6pku36rqNy8RHEZTwXyxeuNtWCLrYX7CVuBDfQpn3MlaPy/OtA22P5grx7tzPUd3etJAqHAhQFo5eGx/goQjgOsm0rOAOxn5B1gXK0rPkV5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854473; c=relaxed/simple;
	bh=gemiH66/fc5MVqLVekLA+NM1waZprso3707Qt2cZJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anBHXpA13fjG9Ko0jjgLMVCiX46WnaSZeCm6GEkd8LNA0t6dz5dIA3OU+Nbccgyr28Qi5r1bQmO9hYdlQ5XK2mAsjVjVqmSamO9E9DotiNzAT0t1fWdw3ok+r2QrQYDk6n/rtdHEGu9h4rb7iO3WFM7S9nNzoBkTX40ptAsToeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3Kj+79d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEF8C433F1;
	Sun, 21 Jan 2024 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705854472;
	bh=gemiH66/fc5MVqLVekLA+NM1waZprso3707Qt2cZJ1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3Kj+79ddmRiq9wftKCcYG5f1Fs945q7r1Azg94lbXHqj/D0YW4xfy7aHfmRF1XcG
	 NYlFB/2swjQHsMdnKdYZrJOPg4fU9oM+VLBSxHRtpw97eoH1x9CqXxalnhiLyj52tU
	 2oTp4K2L6i5ihaxRZyfvOYuH1NTHLmBJEeDn/XcR0Jmj9m2M6U6dSPiw9syCx4SjP/
	 bPbiXGBkpMZf21qvypbQ7+8bCBM92lFNQWAgT2HFN9UawTcwtiGM9FOk4GIiJk1xQA
	 XRkMsHYoKAPJDzDIPN9ZWICO8K0d0wDWSb1tlNx5ginMTAGWpXXAEV5q1uctbpzZKt
	 SM4HruK8kvk8A==
Date: Sun, 21 Jan 2024 16:27:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-spi@vger.kernel.org,
 kernel@pengutronix.de, Lars-Peter Clausen  <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/33] iio: adc: ad_sigma_delta: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240121162739.166402e8@jic23-huawei>
In-Reply-To: <eabd64dbf89bc288f7e02cdec3c2a6ba0af752cb.camel@gmail.com>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
	<34f4c9459aae0915539c69bf02adabce58d51a45.1705348269.git.u.kleine-koenig@pengutronix.de>
	<eabd64dbf89bc288f7e02cdec3c2a6ba0af752cb.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 08:44:45 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-01-15 at 21:12 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> > some functions and struct members were renamed. To not break all drivers
> > compatibility macros were provided.
> >=20
> > To be able to remove these compatibility macros push the renaming into
> > this driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git but I won't be pushing that out as =
togreg
until I can rebase on rc1. Until then, just pushed out as testing to 0-day =
a head
start.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad_sigma_delta.c | 14 +++++++-------
> > =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigm=
a_delta.c
> > index 7e2192870743..55442eddf57c 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -212,7 +212,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_de=
lta,
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	spi_bus_lock(sigma_delta->spi->master);
> > +	spi_bus_lock(sigma_delta->spi->controller);
> > =C2=A0	sigma_delta->bus_locked =3D true;
> > =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> > =C2=A0	reinit_completion(&sigma_delta->completion);
> > @@ -235,7 +235,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_de=
lta,
> > =C2=A0	sigma_delta->keep_cs_asserted =3D false;
> > =C2=A0	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> > =C2=A0	sigma_delta->bus_locked =3D false;
> > -	spi_bus_unlock(sigma_delta->spi->master);
> > +	spi_bus_unlock(sigma_delta->spi->controller);
> > =C2=A0
> > =C2=A0	return ret;
> > =C2=A0}
> > @@ -287,7 +287,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev=
 *indio_dev,
> > =C2=A0
> > =C2=A0	ad_sigma_delta_set_channel(sigma_delta, chan->address);
> > =C2=A0
> > -	spi_bus_lock(sigma_delta->spi->master);
> > +	spi_bus_lock(sigma_delta->spi->controller);
> > =C2=A0	sigma_delta->bus_locked =3D true;
> > =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> > =C2=A0	reinit_completion(&sigma_delta->completion);
> > @@ -322,7 +322,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev=
 *indio_dev,
> > =C2=A0	sigma_delta->keep_cs_asserted =3D false;
> > =C2=A0	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> > =C2=A0	sigma_delta->bus_locked =3D false;
> > -	spi_bus_unlock(sigma_delta->spi->master);
> > +	spi_bus_unlock(sigma_delta->spi->controller);
> > =C2=A0	iio_device_release_direct_mode(indio_dev);
> > =C2=A0
> > =C2=A0	if (ret)
> > @@ -387,7 +387,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *=
indio_dev)
> > =C2=A0
> > =C2=A0	sigma_delta->samples_buf =3D samples_buf;
> > =C2=A0
> > -	spi_bus_lock(sigma_delta->spi->master);
> > +	spi_bus_lock(sigma_delta->spi->controller);
> > =C2=A0	sigma_delta->bus_locked =3D true;
> > =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> > =C2=A0
> > @@ -401,7 +401,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *=
indio_dev)
> > =C2=A0	return 0;
> > =C2=A0
> > =C2=A0err_unlock:
> > -	spi_bus_unlock(sigma_delta->spi->master);
> > +	spi_bus_unlock(sigma_delta->spi->controller);
> > =C2=A0
> > =C2=A0	return ret;
> > =C2=A0}
> > @@ -426,7 +426,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev =
*indio_dev)
> > =C2=A0
> > =C2=A0	ad_sigma_delta_disable_all(sigma_delta);
> > =C2=A0	sigma_delta->bus_locked =3D false;
> > -	return spi_bus_unlock(sigma_delta->spi->master);
> > +	return spi_bus_unlock(sigma_delta->spi->controller);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static irqreturn_t ad_sd_trigger_handler(int irq, void *p) =20
>=20


