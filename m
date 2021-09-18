Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065A14107FE
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhIRSFG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 14:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238237AbhIRSFG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:05:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DC5610E9;
        Sat, 18 Sep 2021 18:03:41 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:07:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: adis16080: use devm_iio_device_register() in
 probe
Message-ID: <20210918190721.58d3aa44@jic23-huawei>
In-Reply-To: <20210913115308.301877-1-aardelean@deviqon.com>
References: <20210913115308.301877-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 14:53:08 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> There is nothing else that needs to be done for this driver. The remove
> hook calls only the iio_device_unregister() hook.
> 
> So this driver can use devm_iio_device_register() directly.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
huh?  How did we end up with this one being so nearly done.
I guess maybe it predates devm_iio_device_register()!

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to waste time testing it for us ;)

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adis16080.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
> index e2f4d943e220..acef59d822b1 100644
> --- a/drivers/iio/gyro/adis16080.c
> +++ b/drivers/iio/gyro/adis16080.c
> @@ -195,8 +195,6 @@ static int adis16080_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	mutex_init(&st->lock);
>  
> @@ -210,13 +208,7 @@ static int adis16080_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16080_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int adis16080_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id adis16080_ids[] = {
> @@ -231,7 +223,6 @@ static struct spi_driver adis16080_driver = {
>  		.name = "adis16080",
>  	},
>  	.probe = adis16080_probe,
> -	.remove = adis16080_remove,
>  	.id_table = adis16080_ids,
>  };
>  module_spi_driver(adis16080_driver);

