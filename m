Return-Path: <linux-iio+bounces-1701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA19882EA47
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jan 2024 08:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A451F24063
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jan 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094D111BE;
	Tue, 16 Jan 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+oEV8Gn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C211700;
	Tue, 16 Jan 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e85595298so1726035e9.2;
        Mon, 15 Jan 2024 23:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705391087; x=1705995887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e7EVR9WCX6YMJ4bk4YK+FN5baHUCpUNaXnpvooUmD0k=;
        b=E+oEV8GnmC4jMKV42gstqu/WO9fzybgd4YnvQiSF1kmNMxO/0TqS0JRWvZ7zrdFEOz
         wHGeA3aqwgeMXCfXmMlDmZNbDG8soagkF2/K0vBuKXzhR4/BMH3c+iUIi19t0Gc1rSeR
         oW5rXfeQoOgpqFt6aeNYRa4g50mpM/+Madh1qBqJdHOwpZ9os0YmOx7JkOHVse1xgz6V
         gR197uFo62OwNogwayAwy6FBMvUkwFvo1T5zSojdsUPAnk1mM9jnPH8X27FmYJuIvGiU
         RRmHeQYWtpFEcck5YsOra91FEA8mu+qfn9CxCVKqb//DY158ojHJxcbOlfbXvIVj0jjC
         C8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705391087; x=1705995887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7EVR9WCX6YMJ4bk4YK+FN5baHUCpUNaXnpvooUmD0k=;
        b=AZ6E8EfPbMIej0r3xIO8In7T3U/rB6tOHf8boIgPbKl4x6QhpLAa30ZPdgiMUQeb/8
         qj0Kwl411SkaYOzJCMpFpt7O2tDMWmIzue183ELFTgEO0jJ6W+9byawSHO+Bey3HsbgL
         apZY7tMlqbGNqQX/Hsy55omuwxISnFoTZkxPViwu9hiHbBBaB+67edGb73NfMmX27vQw
         RRi4ow/XCejSEOtmysZZZ+iDftYl7/JUQh9yxdGjzJrd0hpWVE6gWMrEq7J4uftR5l0N
         UpTDvRA8qnah3KROCwRDwsjlm5wFjYy8j9o+VRqH9tASfUmEtCKebbOuK6B3z3yTrx5s
         IWdw==
X-Gm-Message-State: AOJu0YzRCKpY+J5xh2oaS+zdELz1ezcuwgi+o3FgR4UedCLBcIEzLNro
	ZLhPTDNq7CVZkKP/tB7abBc=
X-Google-Smtp-Source: AGHT+IFS197B74gsaqPEVvYi6NGnYQirfJ2kcEglH6qGa9bQIAluqaEx6q3i8BVu+J/9jhvygfYoCw==
X-Received: by 2002:a05:600c:2255:b0:40e:4786:9379 with SMTP id a21-20020a05600c225500b0040e47869379mr1880381wmm.103.1705391086245;
        Mon, 15 Jan 2024 23:44:46 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id g12-20020adff40c000000b00337bdfa91d7sm241855wro.78.2024.01.15.23.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:44:45 -0800 (PST)
Message-ID: <eabd64dbf89bc288f7e02cdec3c2a6ba0af752cb.camel@gmail.com>
Subject: Re: [PATCH 03/33] iio: adc: ad_sigma_delta: Follow renaming of SPI
 "master" to "controller"
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, kernel@pengutronix.de, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron
	 <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Tue, 16 Jan 2024 08:44:45 +0100
In-Reply-To: <34f4c9459aae0915539c69bf02adabce58d51a45.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
	 <34f4c9459aae0915539c69bf02adabce58d51a45.1705348269.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-15 at 21:12 +0100, Uwe Kleine-K=C3=B6nig wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>=20
> To be able to remove these compatibility macros push the renaming into
> this driver.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index 7e2192870743..55442eddf57c 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -212,7 +212,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delt=
a,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	spi_bus_lock(sigma_delta->spi->master);
> +	spi_bus_lock(sigma_delta->spi->controller);
> =C2=A0	sigma_delta->bus_locked =3D true;
> =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> =C2=A0	reinit_completion(&sigma_delta->completion);
> @@ -235,7 +235,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delt=
a,
> =C2=A0	sigma_delta->keep_cs_asserted =3D false;
> =C2=A0	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> =C2=A0	sigma_delta->bus_locked =3D false;
> -	spi_bus_unlock(sigma_delta->spi->master);
> +	spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -287,7 +287,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *=
indio_dev,
> =C2=A0
> =C2=A0	ad_sigma_delta_set_channel(sigma_delta, chan->address);
> =C2=A0
> -	spi_bus_lock(sigma_delta->spi->master);
> +	spi_bus_lock(sigma_delta->spi->controller);
> =C2=A0	sigma_delta->bus_locked =3D true;
> =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> =C2=A0	reinit_completion(&sigma_delta->completion);
> @@ -322,7 +322,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *=
indio_dev,
> =C2=A0	sigma_delta->keep_cs_asserted =3D false;
> =C2=A0	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> =C2=A0	sigma_delta->bus_locked =3D false;
> -	spi_bus_unlock(sigma_delta->spi->master);
> +	spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0	iio_device_release_direct_mode(indio_dev);
> =C2=A0
> =C2=A0	if (ret)
> @@ -387,7 +387,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *in=
dio_dev)
> =C2=A0
> =C2=A0	sigma_delta->samples_buf =3D samples_buf;
> =C2=A0
> -	spi_bus_lock(sigma_delta->spi->master);
> +	spi_bus_lock(sigma_delta->spi->controller);
> =C2=A0	sigma_delta->bus_locked =3D true;
> =C2=A0	sigma_delta->keep_cs_asserted =3D true;
> =C2=A0
> @@ -401,7 +401,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *in=
dio_dev)
> =C2=A0	return 0;
> =C2=A0
> =C2=A0err_unlock:
> -	spi_bus_unlock(sigma_delta->spi->master);
> +	spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -426,7 +426,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *i=
ndio_dev)
> =C2=A0
> =C2=A0	ad_sigma_delta_disable_all(sigma_delta);
> =C2=A0	sigma_delta->bus_locked =3D false;
> -	return spi_bus_unlock(sigma_delta->spi->master);
> +	return spi_bus_unlock(sigma_delta->spi->controller);
> =C2=A0}
> =C2=A0
> =C2=A0static irqreturn_t ad_sd_trigger_handler(int irq, void *p)


