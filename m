Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00569339ED1
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 16:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhCMPKa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 10:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233446AbhCMPKT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 10:10:19 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E33964ED9;
        Sat, 13 Mar 2021 15:10:18 +0000 (UTC)
Date:   Sat, 13 Mar 2021 15:10:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/1] iio: imu: fxos8700: Drop unneeded explicit
 castings
Message-ID: <20210313151014.071bccd0@archlinux>
In-Reply-To: <20210312134538.3759-1-andriy.shevchenko@linux.intel.com>
References: <20210312134538.3759-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 15:45:38 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In a few places the unnecessary explicit castings are being used.
> Drop them for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied, Thanks
> ---
>  drivers/iio/imu/fxos8700_i2c.c | 3 +--
>  drivers/iio/imu/fxos8700_spi.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
> index 3ceb76366313..40a570325b0a 100644
> --- a/drivers/iio/imu/fxos8700_i2c.c
> +++ b/drivers/iio/imu/fxos8700_i2c.c
> @@ -26,8 +26,7 @@ static int fxos8700_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &fxos8700_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/imu/fxos8700_spi.c b/drivers/iio/imu/fxos8700_spi.c
> index 57e7bb6444e7..27e694cce173 100644
> --- a/drivers/iio/imu/fxos8700_spi.c
> +++ b/drivers/iio/imu/fxos8700_spi.c
> @@ -17,8 +17,7 @@ static int fxos8700_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &fxos8700_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  

