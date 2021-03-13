Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3BB339ECF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 16:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCMPJ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 10:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233446AbhCMPJq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 10:09:46 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8C564ECE;
        Sat, 13 Mar 2021 15:09:45 +0000 (UTC)
Date:   Sat, 13 Mar 2021 15:09:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/1] iio: imu: st_lsm6dsx: Drop unneeded explicit
 castings
Message-ID: <20210313150942.08d5a324@archlinux>
In-Reply-To: <20210312134743.4055-1-andriy.shevchenko@linux.intel.com>
References: <20210312134743.4055-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 15:47:43 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In a few places the unnecessary explicit castings are being used.
> Drop them for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied, ta

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 3 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 3 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index ec8d4351390a..8b4fc2c15622 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -29,8 +29,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &st_lsm6dsx_i2c_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> index 57e633121bdc..8d4201b86e87 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -34,8 +34,7 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
>  
>  	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&i3cdev->dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index 349ec9c1890d..e80110b6b280 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -29,8 +29,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &st_lsm6dsx_spi_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  

