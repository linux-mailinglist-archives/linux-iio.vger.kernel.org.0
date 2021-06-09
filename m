Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4D3A1DF5
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFIUKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 16:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhFIUKn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 16:10:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D116139A;
        Wed,  9 Jun 2021 20:08:46 +0000 (UTC)
Date:   Wed, 9 Jun 2021 21:10:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        nuno.sa@analog.com
Subject: Re: [PATCH] iio: imu: remove unused private data assigned with
 spi_set_drvdata()
Message-ID: <20210609211040.56df2934@jic23-huawei>
In-Reply-To: <20210513122512.93187-1-aardelean@deviqon.com>
References: <20210513122512.93187-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 May 2021 15:25:12 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> These were usually used before the conversion to devm_ functions, so that
> the remove hook would be able to retrieve the pointer and do cleanups on
> remove.
> When the conversion happened, they should have been removed, but were
> omitted.
> 
> Some drivers were copied from drivers that fit the criteria described
> above. In any case, in order to prevent more drivers from being used as
> example (and have spi_set_drvdata() needlessly set), this change removes it
> from the IIO IMU group.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Hohum. I missed this one due to an error in my colour coding scheme
that had it having dependencies. Oops.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16400.c | 2 --
>  drivers/iio/imu/adis16460.c | 2 --
>  drivers/iio/imu/adis16475.c | 1 -
>  drivers/iio/imu/adis16480.c | 2 --
>  4 files changed, 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index cb8d3ffab6fc..109b2360a54e 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -1164,8 +1164,6 @@ static int adis16400_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	/* setup the industrialio driver allocated elements */
>  	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 73bf45e859b8..068d98780383 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -388,8 +388,6 @@ static int adis16460_probe(struct spi_device *spi)
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> -	spi_set_drvdata(spi, indio_dev);
> -
>  	st = iio_priv(indio_dev);
>  
>  	st->chip_info = &adis16460_chip_info;
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 5654c0c15426..90aec3c9dbcb 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1329,7 +1329,6 @@ static int adis16475_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	st->info = device_get_match_data(&spi->dev);
>  	if (!st->info)
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index f81b86690b76..c7dd1150780d 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -1279,8 +1279,6 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> -	spi_set_drvdata(spi, indio_dev);
> -
>  	st = iio_priv(indio_dev);
>  
>  	st->chip_info = &adis16480_chip_info[id->driver_data];

