Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72473154185
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgBFKD7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgBFKD7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 05:03:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71A31214AF;
        Thu,  6 Feb 2020 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580983438;
        bh=Hg4nfjOj1qAK61ueiJUQAoDHErrNERmZ2ORckrbMPRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f+d6Z+rjgGmXa7P9Pk5HAzIdLSNlZ1lFl00wtvtnuShZL8x0RLl7WEzyRaytVmuD6
         ol4N6nAbLsKVyOGMkjvT2xI/P0rLERv3jHPxZnMRZBThUUUkGzEPWZN5EWITFSrOil
         jUc4tgt4TnFE9QE9j09qvon5HSI2iG9jAerpWsMk=
Date:   Thu, 6 Feb 2020 10:03:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5 V2] staging: iio: adc: ad7192: removed spi_device_id
Message-ID: <20200206100354.1dfae679@archlinux>
In-Reply-To: <20200205171511.25912-4-alexandru.tachici@analog.com>
References: <20200202162215.50915c83@archlinux>
        <20200205171511.25912-1-alexandru.tachici@analog.com>
        <20200205171511.25912-4-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Feb 2020 19:15:09 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch removes spi_device_id table and moves the
> init data (id of the chip) in the .data field
> of of_device_id table.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Good.  A few comments inline that'll make this more compact.

> ---
>  drivers/staging/iio/adc/ad7192.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 8f2fa154876a..e75d808a2f41 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/delay.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -876,8 +877,11 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static const struct of_device_id ad7192_of_match[];

Move the table rather than a forward reference?

> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
> +	const struct of_device_id *match;
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret, voltage_uv = 0;
> @@ -927,8 +931,12 @@ static int ad7192_probe(struct spi_device *spi)
>  		goto error_disable_avdd;
>  	}
>  
> +	match = of_match_device(ad7192_of_match, &spi->dev);

Can step the intermediate point by using of_device_get_match_data

> +	if (!match)
> +		return -EINVAL;
> +
>  	spi_set_drvdata(spi, indio_dev);
> -	st->devid = spi_get_device_id(spi)->driver_data;
> +	st->devid = (unsigned long)match->data;
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1010,21 +1018,11 @@ static int ad7192_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static const struct spi_device_id ad7192_id[] = {
> -	{"ad7190", ID_AD7190},
> -	{"ad7192", ID_AD7192},
> -	{"ad7193", ID_AD7193},
> -	{"ad7195", ID_AD7195},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(spi, ad7192_id);
> -
>  static const struct of_device_id ad7192_of_match[] = {
> -	{ .compatible = "adi,ad7190" },
> -	{ .compatible = "adi,ad7192" },
> -	{ .compatible = "adi,ad7193" },
> -	{ .compatible = "adi,ad7195" },
> +	{ .compatible = "adi,ad7190", .data = (void *)ID_AD7190},
> +	{ .compatible = "adi,ad7192", .data = (void *)ID_AD7192 },
> +	{ .compatible = "adi,ad7193", .data = (void *)ID_AD7193 },
> +	{ .compatible = "adi,ad7195", .data = (void *)ID_AD7195 },
>  	{}
>  };
>  
> @@ -1037,7 +1035,6 @@ static struct spi_driver ad7192_driver = {
>  	},
>  	.probe		= ad7192_probe,
>  	.remove		= ad7192_remove,
> -	.id_table	= ad7192_id,
>  };
>  module_spi_driver(ad7192_driver);
>  

