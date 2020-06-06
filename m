Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415851F07AC
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFFPqQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgFFPqP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jun 2020 11:46:15 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFB5C03E96A;
        Sat,  6 Jun 2020 08:46:15 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 86F299E7476;
        Sat,  6 Jun 2020 16:46:12 +0100 (BST)
Date:   Sat, 6 Jun 2020 16:46:10 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 4/6] iio: remove left-over comments about parent
 assignment
Message-ID: <20200606164610.3120fcce@archlinux>
In-Reply-To: <20200603114023.175102-5-alexandru.ardelean@analog.com>
References: <20200603114023.175102-1-alexandru.ardelean@analog.com>
        <20200603114023.175102-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jun 2020 14:40:21 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> These were obtained by doing a 'git diff | grep \/\*', in the previous diff
> to find comments. These needed a bit more manual review, as the semantic
> patch isn't great for catching these.
> 
> The result is:
>  	/* Initialize Counter device and driver data */
>  	/* Initialize IIO device */
>  	/* Establish that the iio_dev is a child of the spi device */
>  	/* Estabilish that the iio_dev is a child of the spi device */
>  	/* Initiate the Industrial I/O device */
>  	/* Establish that the iio_dev is a child of the device */
> -	/* establish that the iio_dev is a child of the i2c device */
> -	/* establish that the iio_dev is a child of the i2c device */
>  	/* This is only used for removal purposes */
>  	/* setup the industrialio driver allocated elements */
>  	/* variant specific configuration */
>  	/* Setup for userspace synchronous on demand sampling. */
>  	st->readback_delay_us += 5; /* Add tWAIT */
> -	/* Establish that the iio_dev is a child of the i2c device */
>  	/* Establish that the iio_dev is a child of the i2c device */
> 
> Out of which, 4 are really left-over comments about parent assignment.
> 3 of them are removed by the semantic patch, as the comment removed (by
> spatch) would be for an empty line.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7476.c         | 1 -
>  drivers/iio/adc/ad7887.c         | 1 -
>  drivers/iio/dac/ad5446.c         | 1 -
>  drivers/staging/iio/cdc/ad7746.c | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index e2a69dd6a47e..6286e230f55b 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -300,7 +300,6 @@ static int ad7476_probe(struct spi_device *spi)
>  
>  	st->spi = spi;
>  
> -	/* Establish that the iio_dev is a child of the spi device */
>  	indio_dev->dev.of_node = spi->dev.of_node;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index ca4c98401ebc..0f93f5c8965d 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -264,7 +264,6 @@ static int ad7887_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
>  
> -	/* Estabilish that the iio_dev is a child of the spi device */
>  	indio_dev->dev.of_node = spi->dev.of_node;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad7887_info;
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index e01ba90dc106..5931bd630c4e 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -250,7 +250,6 @@ static int ad5446_probe(struct device *dev, const char *name,
>  	st->reg = reg;
>  	st->dev = dev;
>  
> -	/* Establish that the iio_dev is a child of the device */
>  	indio_dev->name = name;
>  	indio_dev->info = &ad5446_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index bd9803c7c5b6..dfd71e99e872 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -693,7 +693,6 @@ static int ad7746_probe(struct i2c_client *client,
>  	chip->client = client;
>  	chip->capdac_set = -1;
>  
> -	/* Establish that the iio_dev is a child of the i2c device */
>  	indio_dev->name = id->name;
>  	indio_dev->info = &ad7746_info;
>  	indio_dev->channels = ad7746_channels;

