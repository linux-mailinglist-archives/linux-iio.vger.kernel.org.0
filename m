Return-Path: <linux-iio+bounces-13238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889DD9E870A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A26F18840C8
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509DD176240;
	Sun,  8 Dec 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZmOaH36"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4F145324;
	Sun,  8 Dec 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678855; cv=none; b=p/TFqyvG48oAXgnZgXO28+4DYtJbJlgzWLfdt1LX9PoxgTj6YG9Iy0qIC0HKq7nBWlB9JGwntdmEOTsRoHkCVbWURqR6DqRcm13CMqfnoX09te3ufYPW6KNPg+NVWmHqJiP1uTZGVZx1XZ+ugWn3z2lI5+nj2tU7XEo4NKHS9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678855; c=relaxed/simple;
	bh=tzZBc7qZHdPxfeaWV/qXC1oRkW9L0BW5DCE6dDkKqWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MB3Fx+ShUaB7346k6lPZ4GBky2zu1OIYaDtOMQUjjgbnDPH0GkzPO89hthxbYlA0muo0xx+oBp9jqXqhnebG7ofCOBQ2MyEAj/ICuEMZVJ9n7m9sQc2NUhUHIi/rLUPaG5y8bQ3vY0oPH9USgHz82Pb/fvY2E+oMWBEp5uU42cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZmOaH36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13408C4CED2;
	Sun,  8 Dec 2024 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733678854;
	bh=tzZBc7qZHdPxfeaWV/qXC1oRkW9L0BW5DCE6dDkKqWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZmOaH36B9wRcGvhFtzSYQEUPrZEZkSyGBrGfw1bS4PYqDlXvvmHKslzSzMlfKnBR
	 yiRpKVeJ/yOWrW50hOVk2BhBPgy47UaqDEQZKH5DAB1DG3vQmaQWQhEcV78imFov6D
	 qZKNkuMyVCPrs8cZHR2nu2cLMHgZSZlIbOfemcQxota6WvubSCWmxCtb2D2o4SBC/c
	 NBHTTEHFPaiXdYDFPq64ijLgdx8vx55h3LUI/XCqRTbG4znMPbBdpWL317LNqwPKq3
	 QozZAQkEmCZgrvwkBZ8NaTmeI7s00VD1C91ras/oikD3RwrAkQormxuTHPE31FjxbB
	 wIaPcF+nTLuhw==
Date: Sun, 8 Dec 2024 17:27:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: don't always auto-enable I2C, I3C
 and SPI interface drivers
Message-ID: <20241208172726.7ed07735@jic23-huawei>
In-Reply-To: <20241203-lsm6dsx-v1-1-6d7893443bc8@geanix.com>
References: <20241203-lsm6dsx-v1-1-6d7893443bc8@geanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Dec 2024 08:20:17 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> This patch makes I2C, I3C and SPI interface drivers for ST lsm6dsx
> individually selectable via Kconfig.
> 
> The default is kept unchanged - I2C, I3C and SPI interface drivers are
> still selected by default if the corresponding bus support is available.
> 
> However, the patch makes it possible to explicitly disable drivers
> that are not needed for a particular target.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Fair enough. Well explained and I guess you have a config which restricted enough
that this makes sense.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day to
see what we missed this time

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 89d687ec3099cc3ecb848e44f610c5cd64c80ad1..3cabec3b152d21403b40668a20ca7d175109a79e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -6,9 +6,6 @@ config IIO_ST_LSM6DSX
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select IIO_KFIFO_BUF
> -	select IIO_ST_LSM6DSX_I2C if (I2C)
> -	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
> -	select IIO_ST_LSM6DSX_I3C if (I3C)
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor.
> @@ -42,16 +39,19 @@ config IIO_ST_LSM6DSX
>  	  will be called st_lsm6dsx.
>  
>  config IIO_ST_LSM6DSX_I2C
> -	tristate
> -	depends on IIO_ST_LSM6DSX
> +	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors I2C Interface"
> +	depends on I2C && IIO_ST_LSM6DSX
> +	default I2C && IIO_ST_LSM6DSX
>  	select REGMAP_I2C
>  
>  config IIO_ST_LSM6DSX_SPI
> -	tristate
> -	depends on IIO_ST_LSM6DSX
> +	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors SPI Interface"
> +	depends on SPI_MASTER && IIO_ST_LSM6DSX
> +	default SPI_MASTER && IIO_ST_LSM6DSX
>  	select REGMAP_SPI
>  
>  config IIO_ST_LSM6DSX_I3C
> -	tristate
> -	depends on IIO_ST_LSM6DSX
> +	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors I3C Interface"
> +	depends on I3C && IIO_ST_LSM6DSX
> +	default I3C && IIO_ST_LSM6DSX
>  	select REGMAP_I3C
> 
> ---
> base-commit: 4ecd1edf4994bc5385609c6ea9e599b4ee958706
> change-id: 20241202-lsm6dsx-585182084202
> 
> Best regards,


