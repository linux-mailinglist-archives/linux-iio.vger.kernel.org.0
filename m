Return-Path: <linux-iio+bounces-22939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3333B2B026
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B060D565665
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3E2D24AB;
	Mon, 18 Aug 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRCrtr9J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F52848B1;
	Mon, 18 Aug 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541425; cv=none; b=N9s2l+AYPF6MVSc81pBfICZcO42bZmAc06RGqxUSXTwDHNG3fhvYFTWSrbXwAX3OwT8v6PvDTCWfIw0hSUc9mEiiHAd8OkfkDl86ga3EdwlTFgpYmucmPxBlDKHh4bN5LPptQlrvPjj+fGEsKgDNVL+kGAWPhbX9OdcRpaKbFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541425; c=relaxed/simple;
	bh=ZOIj05MFLCwF+DumLOC4eUsR6lIYbHJI9B1zVCxvqLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwZ3o+cxNe6LTGRANxa3kG/Os/SehfFpmZD99QDqHhIZztq+RRF3rSag180saXZQmTWdZJcxDOSVlFLzWQIoqB75+NdJkd2dg6pA6KA6mHgur1D0VWAixeMwe+qXAcsGx68+7N648udwx69uz00DDktL5jULOblK1qamzfenQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRCrtr9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E360C4CEEB;
	Mon, 18 Aug 2025 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541425;
	bh=ZOIj05MFLCwF+DumLOC4eUsR6lIYbHJI9B1zVCxvqLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cRCrtr9JpLKqj7OGAlfE3sQT9dG3wQFDgOoXncMKpWFYSEN5HMZAU72kx9vXmroWk
	 C4U15p6Yy+VepETJO8Uws2xDG4yS7Jojl8bZpTNZv71VCJQlJBZass5EC+wY3BYI1V
	 EaXMk8EaQAtHxHSIkrT4w8V12MO8GcggsFO46GY+H1cUr3g2fsYPU1VkPRuxx+IOSE
	 JrVpyJSo+adVHRajs509oUcXxJBZEFTYf2BE9JGohj0d49ACGQobieahAWzcmRs+eP
	 OetLx4s3SyRBnML+MJf7SOo7VJweK60dLTZTQHdrlkZjQ6vtmCNh22K+msWvaLKASa
	 ZPDqw0yVdj36g==
Date: Mon, 18 Aug 2025 19:23:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 Markus.Elfring@web.de
Subject: Re: [PATCH v4 1/3] iio: pressure: bmp280: Use IS_ERR() in
 bmp280_common_probe()
Message-ID: <20250818192337.2256ff4a@jic23-huawei>
In-Reply-To: <20250818092740.545379-2-salah.triki@gmail.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
	<20250818092740.545379-2-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Aug 2025 10:27:30 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> `devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
> Check its return value using `IS_ERR()` and propagate the error if
> necessary.
>=20
> Fixes: df6e71256c84 ("iio: pressure: bmp280: Explicitly mark GPIO optiona=
l")
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

The rest of the series will have to wait for that to work it's way back
via upstream.=20

Thanks

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-core.c
> index 74505c9ec1a0..6cdc8ed53520 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3213,11 +3213,12 @@ int bmp280_common_probe(struct device *dev,
> =20
>  	/* Bring chip out of reset if there is an assigned GPIO line */
>  	gpiod =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod))
> +		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n"=
);
> +
>  	/* Deassert the signal */
> -	if (gpiod) {
> -		dev_info(dev, "release reset\n");
> -		gpiod_set_value(gpiod, 0);
> -	}
> +	dev_info(dev, "release reset\n");
> +	gpiod_set_value(gpiod, 0);
> =20
>  	data->regmap =3D regmap;
> =20


