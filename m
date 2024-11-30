Return-Path: <linux-iio+bounces-12886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72AE9DF2B1
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758621627DE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9721A7259;
	Sat, 30 Nov 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6Y4JVcn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DA17BD3
	for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993018; cv=none; b=oHX+VDf94bJkDR6Hr3U6wKOZADV8vNhs0TgfEk2c+0UXaScxW6wL4RI6wZkfWvO1lnrknR5/Qfc9zgTA3JR4y7/cinxb/9YV+s9UX7LJwBBAbqQxHf6RYcO693eQdhAa8o0f8fyyhYydHqStlKFcErM1DrAOHYX7RFEtUz2tgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993018; c=relaxed/simple;
	bh=11NM9/N8IuCnrCC8SUwJK+nK4Isu2RmXLLzYjr0M9EA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULeg09MQDVxTPCHjrXm8/YVIuYwVaIUHh52f8JJEpXVv1/h5pjd4vTTKiHy6j6bQ87JOA3ijk6PkGYpPGdmt9eXouZp3HFPPLvRhPgSP2E6FBCZaaM4haOTyZQsnCbU0JY1OE5RKtcFThasEHyoL1/CGoCl6jr4Mq9DaN6nAEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6Y4JVcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEE9C4CECC;
	Sat, 30 Nov 2024 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732993018;
	bh=11NM9/N8IuCnrCC8SUwJK+nK4Isu2RmXLLzYjr0M9EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O6Y4JVcnWLAA0hRIMLmhrD84P90oGKiy3iS84AYLGy7YsKkuGxtt9xfWz4HeQRk4M
	 nYzgXZl0W2BvC13X9QrhruCEeS0GGZigMrfR5c0NqLarFRnvCawUzcmfSBEMBE8MKB
	 uuNhnnfpHe8bxWlYzFVQGRBKnirrn1nxsw+EVdjPAv5GJbqhGe15uRyRqUxrzD2FmH
	 C+itn8fozXAGATT1gwZYfkrmgRm/8E53OeKBt/2hKI1YX0cdBhW/M82vapih2qgW/U
	 lf0OcCwdhMG16JTPYrsq14zasIlwjq8x+1XjiLLMK/+bH0TG1KM0e3Yywo1W/Dx5Ik
	 to7Ok2fYif61Q==
Date: Sat, 30 Nov 2024 18:56:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v4 09/10] iio: adc: ad7124: Add error reporting during
 probe
Message-ID: <20241130185649.2e2d68db@jic23-huawei>
In-Reply-To: <20241127145929.679408-21-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
	<20241127145929.679408-21-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2024 15:59:38 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> A driver that silently fails to probe is annoying and hard to debug. So
> add messages in the error paths of the probe function.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Probably worth calling out in this patch description that you also
replace some dev_err() calls with dev_err_probe()

One comment inline.

Thanks,

Jonathan

> @@ -1007,36 +1008,42 @@ static int ad7124_probe(struct spi_device *spi)
> =20
>  		ret =3D regulator_enable(st->vref[i]);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret, "Failed to enable regulator #%d\n", i);
> =20
>  		ret =3D devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
>  					       st->vref[i]);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret, "Failed to register disable handler fo=
r regulator #%d\n", i);
>  	}
> =20
>  	st->mclk =3D devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))
> -		return PTR_ERR(st->mclk);
> +		return dev_err_probe(dev, PTR_ERR(st->mclk), "Failed to get mclk\n");
> =20
>  	ret =3D ad7124_soft_reset(st);
>  	if (ret < 0)
> +		/* ad7124_soft_reset() already emitted an error message */
I'd not bother adding these already emitted comments.
The only time we'd care is if someone else comes along and adds them. Hopef=
ully we'd
catch that anyway in review, but even if don't it wouldn't matter a lot.
>  		return ret;
> =20
>  	ret =3D ad7124_check_chip_id(st);
>  	if (ret)
> +		/* ad7124_check_chip_id() already emitted an error message */
>  		return ret;
> =20
>  	ret =3D ad7124_setup(st);
>  	if (ret < 0)
> +		/* ad7124_setup() already emitted an error message */
>  		return ret;
> =20
>  	ret =3D devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
>  	if (ret < 0)
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to setup triggers\n");
> =20
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> =20
> +	return 0;
>  }
> =20
>  static const struct of_device_id ad7124_of_match[] =3D {


