Return-Path: <linux-iio+bounces-20471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DAAD5CBF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BF3175DA5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FED2040B0;
	Wed, 11 Jun 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpR8haIz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EB2E610F;
	Wed, 11 Jun 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660965; cv=none; b=LZvSRiywSx+A0ium3OI43qGvJkUw/hVhBb1G79B0eOZjrImugP1XDE6cjuO9y/e+37N5M8ko9JiX15dAARnymg+9jfNYDpz4qvHuH9zNH+/ECPfnX7oCPoe7SoFOavp49uGhxnyf9KLA08pvx9RKJd9aM3MCmGB3Ev8Gcpk8DvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660965; c=relaxed/simple;
	bh=kXPgbYGW4Ce0FByjH2rCx+mFWb6SBX8g4QPPZmEJe6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljSOl7gqxSNaw2xDtRpQAtXY8aReJH0npUZliEF3eNz+8gGxTdHTKp3F2UTJYopTIxHZVoJfhqGrt4HmnTEF616Ti4oC2SX58hVvWqd1oKElxXu8ErVrB/HV2lRtQuw2EEKE5kwyeb2VH0LBPphsuf3eOI7EcyZ9Mdvo4MpJ1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpR8haIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AC0C4CEE3;
	Wed, 11 Jun 2025 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660965;
	bh=kXPgbYGW4Ce0FByjH2rCx+mFWb6SBX8g4QPPZmEJe6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cpR8haIziieNiPGelu8VW61zlDC7plqQlq3OcEu3yBl+jGZ+9vTJOV2gzSARKb4Se
	 bcBa2haeMrrnsNtHINo3jBi30ibuxNvx+l/WogJ0uyvceAW/ZeTQ1u43bJMVhas7YC
	 l9EUf/YICtB2btR49eIS07s8rZvtMsDzDTYQfv4tlHE6v2ZQVjDqChOAusl+bByymu
	 rpITNzbcQ1RSfJhdUBozODWJXLehusU99RxT9A2nlU1hqZnLphjr76Yi0/TnyEEv3p
	 dX30gO4tQ+LD+GuhGDZJkIVXvJdzwBrVUZiJsjWMJAAs0NipLp24nV8BfkHEjKkECP
	 cg+8cW2pTdOhQ==
Date: Wed, 11 Jun 2025 17:55:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: check return value of spi_setup()
Message-ID: <20250611175559.76fb1365@jic23-huawei>
In-Reply-To: <20250611-iio-adc-ad7173-check-spi_setup-return-v1-1-4d6f9ef0a2e4@baylibre.com>
References: <20250611-iio-adc-ad7173-check-spi_setup-return-v1-1-4d6f9ef0a2e4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 09:40:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Check the return value of spi_setup() and propagate the error in the
> ad7173_probe() function. This is unlikely to happen since virtually
> every SPI controller supports SPI_MODE_3, but still always a good idea
> to check the return value.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

> ---
>  drivers/iio/adc/ad7173.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 69de5886474ce2f700bf277ce707b15637113564..911001be368302fb9d7d6e8da3783751fe0f61c5 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1775,7 +1775,9 @@ static int ad7173_probe(struct spi_device *spi)
>  	indio_dev->info = &ad7173_info;
>  
>  	spi->mode = SPI_MODE_3;
> -	spi_setup(spi);
> +	ret = spi_setup(spi);
> +	if (ret)
> +		return ret;
>  
>  	ret = ad_sd_init(&st->sd, indio_dev, spi, st->info->sd_info);
>  	if (ret)
> 
> ---
> base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
> change-id: 20250611-iio-adc-ad7173-check-spi_setup-return-072017235f3c
> 
> Best regards,


