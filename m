Return-Path: <linux-iio+bounces-16561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDAA57B37
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9545B16890D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85781CAA67;
	Sat,  8 Mar 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnAUFYXF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE1140E30;
	Sat,  8 Mar 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445286; cv=none; b=LHNlNvQAAJXS8Gq1BFTF0X+q2vPD40RdCI8CyKQHecmPgZpk7c8elDOLcBnguBxD8mpKoA0qUsdJd/zlIZGb07BfsYTt7hxs6YQo5uCY5Mvkvjeq7+iNNkXP4Bw6DMGaNDdL6eJ9orR+viQwAVq7f3D5Fp8gjzy5Ea9dOIX8+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445286; c=relaxed/simple;
	bh=uj9vADcFAdbrm5DZnTmfGLl4ggwwkk6vsfd0pjT2xCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9jMxxPTrr32ED1SNGs+N1rZKQ78Xg+k1/kMaVoRxNmPLZX2K1mRtgzI1BUPm9X3CMlbynvVcs3ncJ40EV42t/NtPv6yJxQreOIo9Ic4qgE6xJJjxtLRpfHlqtZuv6+P1ztSqTp5T1npPHMwusp8+ThZFFzhlHYRqsDrBC9MZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnAUFYXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C29C4CEE0;
	Sat,  8 Mar 2025 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741445286;
	bh=uj9vADcFAdbrm5DZnTmfGLl4ggwwkk6vsfd0pjT2xCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TnAUFYXFtYsMdhzirUyxhJOplgNTjzEOO2eIRNcw5S0tIEUr4gr24ipjr9SOOWECC
	 CsW4bgMeEYsLNPm+SH3KAGiyP3wNhD0D4bDbYipzCtxVIij4VFLJDlODl9M1xGmQJ+
	 VI5ffQxVOO2YjZVb9PKtzioUkrR3GKIkDuJGUdy8Z7L4BfFgSTig9yyD7njheSSKqo
	 jkfyrlkNRulpki+hUV5IfX13Qjr8313i9t1KLxMMjCJJ5M6pzMNaDIOLg+YRZUBbEN
	 knwkJ9XqdB5Uds3YSgQIopZI9n+txjAEH2TZq4Y6lyrpIgtptw2IR4AIC2+Op6d6Rj
	 kQKeqZicKF5jQ==
Date: Sat, 8 Mar 2025 14:48:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: iio: adis16203: Remove unneeded
 spi_set_drvdata()
Message-ID: <20250308144801.08083814@jic23-huawei>
In-Reply-To: <20250305234949.1548646-1-danascape@gmail.com>
References: <20250305234949.1548646-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 05:19:49 +0530
Saalim Quadri <danascape@gmail.com> wrote:

> By making use of devm_iio_device_register(), we no longer have a driver
> remove callback.
> Since this was the last user of spi_get_drvdata(),
> we can drop the call to spi_set_drvdata().
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
As per other discussion. Dropping this one as 
better to merge support into the adis16201 driver.

> ---
>  drivers/staging/iio/accel/adis16203.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index c1c73308800c..3faf3c61046a 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -267,8 +267,6 @@ static int adis16203_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
>  	indio_dev->channels = adis16203_channels;


