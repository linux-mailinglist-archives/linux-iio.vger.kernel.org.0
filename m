Return-Path: <linux-iio+bounces-8522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4495572D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382BCB21533
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDDF148826;
	Sat, 17 Aug 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO/mKHIY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E276B657
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723890196; cv=none; b=N90KQLAhShRkd4GmhGetJHWAnat/4CV+zPVbH21cfIiHxTKZ9lR9B3Zuw+D4A54YHlqAMnI2qJfEFzQ6zVW0Jatbb1H4GARyYXBOoGefuJ/3YNtDLb+NMjujqTBvzXaIsQn6kzs5jBFVsoV5GybMW72bk2WgzAPDawGv/3lXang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723890196; c=relaxed/simple;
	bh=8Rmh4fPZ8kQoxIczrpf4gCXY8LGHRKFyTNX2Sy6YFrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJioxoHmcyKxWR8MM2F4SlhPY+Os5zbRgatzNDWtiX9cN7gY2oi0hNPlXi3ZRsVnrtx/mm/1uCywsEWEV0x6jWTNfVDFobvbPIC6RZbgMHWLMMQvrPwcmwb48b+/+IUJB+nqX87REI/2lJPowZ8bJ5BCmRkODxPLGa3GpguO+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO/mKHIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05407C116B1;
	Sat, 17 Aug 2024 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723890195;
	bh=8Rmh4fPZ8kQoxIczrpf4gCXY8LGHRKFyTNX2Sy6YFrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gO/mKHIYUgpaRqydUoq6Ed1ev5LF73mtw6+7OZNgNS0oZj9woXtAlLzKP4UGktDsb
	 cl0/dRnvcSC1O/sOKEwk/AA2X4ji+K2Y1pkdGUZVNv+bVgYgVhpxiZSj7CZb1juqYA
	 8ssMuLqogH2aRpJCQQRqzhbEnNdZoCmWR5oOMCZh1IeknDV7QQ/UqUjMg1fH5nNdgE
	 Kb+6iWqzzIvEzkT3rUE1fS3jIhZRYxA3nTiX6OJyj0E87NNL0Twjh+Uddkjd3RVl29
	 CzotWnhVh3jy/6sDvM8s8pnOZBFi/Yx1Fmj5ztk470/JcNn7/2j2VoXMSzMuPxcOH5
	 G8L5VERkAj+IA==
Date: Sat, 17 Aug 2024 11:23:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: light: noa1305: Fix up integration time look up
Message-ID: <20240817112308.336811f1@jic23-huawei>
In-Reply-To: <20240814191946.81386-1-marex@denx.de>
References: <20240814191946.81386-1-marex@denx.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Aug 2024 21:19:09 +0200
Marek Vasut <marex@denx.de> wrote:

> The current code is always iterating over two fields in the
> noa1305_int_time_available array. Fix iteration limit, which
> has to be halved to avoid out of bounds access in case the
> value that is being looked up is not in the array.
>=20
> Fixes: 025f23cfebad ("iio: light: noa1305: Make integration time configur=
able")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
Applied. Thanks,

> ---
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/light/noa1305.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> index da83425fd9100..25f63da70297e 100644
> --- a/drivers/iio/light/noa1305.c
> +++ b/drivers/iio/light/noa1305.c
> @@ -197,7 +197,7 @@ static int noa1305_write_raw(struct iio_dev *indio_de=
v,
>  		return -EINVAL;
> =20
>  	/* Look up integration time register settings and write it if found. */
> -	for (i =3D 0; i < ARRAY_SIZE(noa1305_int_time_available); i++)
> +	for (i =3D 0; i < ARRAY_SIZE(noa1305_int_time_available) / 2; i++)
>  		if (noa1305_int_time_available[2 * i + 1] =3D=3D val2)
>  			return regmap_write(priv->regmap, NOA1305_REG_INTEGRATION_TIME, i);
> =20


