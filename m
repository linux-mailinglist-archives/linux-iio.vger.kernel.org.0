Return-Path: <linux-iio+bounces-23835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8688BB47A45
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343E72010D5
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5222370D;
	Sun,  7 Sep 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/x39Us4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A51E7C27;
	Sun,  7 Sep 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238966; cv=none; b=M2Dyiya+fU+NkpaBwYFdjnGp5P49nA+kvZPPGRpmizTgpk2+k1Z+E7t4dvAJYqEcV61eBeulaFjhqXYN8d4kcYFaCHjSGZeolce7z7zVX6eyOsYD49zqk0Dq8NXKR8R9NbnpZrER1eWs10Rv16xeOLzumvrEjQZIWX9zwOSq1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238966; c=relaxed/simple;
	bh=s+ufZDkdvUdzGstR2WBPr+nF6WFZ7xcXUI4NS2zqRvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLWG+dB+nZXSWj1uZI8zKulOSHAom6fvmahOAGdNcBUCmxp2/ZRvTOdZ8jMtUsxonO1sG1s2dNW+S2+mBYM91k+hRzBH/i/eAMdX6pfQpaHCeiiO/pG+NW1FuC2n5DZ2LnutlPqLFw19LbfyRAJMK3yPhtPc76d9qZOD1fPz2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/x39Us4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E549FC4CEF0;
	Sun,  7 Sep 2025 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757238966;
	bh=s+ufZDkdvUdzGstR2WBPr+nF6WFZ7xcXUI4NS2zqRvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z/x39Us4ZRSMKTh0l3i27sqWiDvG859mvZWLm1sD4GOTGUldqna8ikRbgs4oitpRi
	 +5S+VPK50MSTbtRSgWJoB2zHR5fYW115aAz0Uvmg0Y4WRANMwMAhJBP+BCmvaUp0IB
	 3kegAo8W1tmh/3bBcBTQFYYaeQmcGd0aT10QHGj+yVteLjNgIyxbbJzAd6lbB8Eg7c
	 RJJUIiGLYHQF/1xSCkAYjNrfZ23jAkVPj2mH41SJfZb2p8HzlahXVeNpuIBQNVNFrj
	 jAA47AxnW64w7GphnbKyBY2aQQN9qkryeJ+MwLHrC3HiBpyMH66p5Btb6HeZSfOLom
	 5Eu4PeJ4peqow==
Date: Sun, 7 Sep 2025 10:55:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250907105557.7bab8bfe@jic23-huawei>
In-Reply-To: <20250906034225.12401-1-akshayaj.lkd@gmail.com>
References: <20250906034225.12401-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat,  6 Sep 2025 09:12:19 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Implement runtime power management for the LTR390 sensor. The device
> autosuspends after 1s of idle time, reducing current consumption from
> 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the datash=
eet.
>=20
> Ensure that interrupts continue to be delivered with runtime PM.
> Since the LTR390 cannot be used as a wakeup source during runtime
> suspend, therefore increment the runtime PM refcount when enabling
> events and decrement it when disabling events or powering down.
> This prevents event loss while still allowing power savings when IRQs
> are unused.
>=20
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>

One missing bit of error handling. Otherwise looks fine to me.
Wait a while though for other reviews before posting v7.

Thanks

Jonathan



> +static int ltr390_pm_init(struct ltr390_data *data)
> +{
> +	int ret;
> +	struct device *dev =3D &data->client->dev;
> +
> +	ret =3D devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable runtime PM\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +	return 0;
>  }
> =20
>  static int ltr390_probe(struct i2c_client *client)
> @@ -708,6 +783,8 @@ static int ltr390_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
> +	i2c_set_clientdata(client, indio_dev);
> +
>  	data =3D iio_priv(indio_dev);
>  	data->regmap =3D devm_regmap_init_i2c(client, &ltr390_regmap_config);
>  	if (IS_ERR(data->regmap))
> @@ -721,6 +798,8 @@ static int ltr390_probe(struct i2c_client *client)
>  	data->gain =3D 3;
>  	/* default mode for ltr390 is ALS mode */
>  	data->mode =3D LTR390_SET_ALS_MODE;
> +	/* default value of irq_enabled is false */
> +	data->irq_enabled =3D false;
> =20
>  	mutex_init(&data->lock);
> =20
> @@ -763,6 +842,7 @@ static int ltr390_probe(struct i2c_client *client)
>  					     "request irq (%d) failed\n", client->irq);
>  	}
> =20
> +	ltr390_pm_init(data);

This can return an error so you need to check that and fail probe if it doe=
s.


>  	return devm_iio_device_register(dev, indio_dev);
>  }
> =20
> @@ -784,7 +864,26 @@ static int ltr390_resume(struct device *dev)
>  				LTR390_SENSOR_ENABLE);
>  }
> =20


