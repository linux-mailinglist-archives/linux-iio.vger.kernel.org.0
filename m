Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14EB18DFAE
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 12:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCULFt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 07:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCULFt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 07:05:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66EB20732;
        Sat, 21 Mar 2020 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584788747;
        bh=KjAbaQI+at1Cu2hUdsJNKQcgayQ71HeqjGgU9dukvGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GAaVOnZEt6h7eFjrgASsg/kcSqxUFbzu/5MNgCoxZlzSjfKqbJJ0PYfWvc0lmj8b4
         kqlUKUx7EdSzulEm7v/67irWpfH30QHmCFqSIxdekssWvXvIUKXdi9OOXsCiF7BY6y
         ClTnlTY+VqsPVdpH2GRhRL1RTmIVO/DyBcxDy3E8=
Date:   Sat, 21 Mar 2020 11:05:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: Drop unnecessary explicit casting
Message-ID: <20200321110541.65b3a768@archlinux>
In-Reply-To: <20200318100754.25667-1-nish.malpani25@gmail.com>
References: <20200318100754.25667-1-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Mar 2020 15:37:54 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Provide correct specifiers while printing error logs to discard the use
> of unnecessary explicit casting.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

Looks good in general, but I'd prefer one patch per driver
(all in a series for easy applying).

The reason is that these may need to be applied by someone as a
precursor to an actual fix.  If we have them as one big set
they have to do considerably more work to use them than if
we keep the patches independent for each of the drivers.

Except in very rare cases we try to avoid patches that cover
multiple otherwise independent bits of code.

Thanks,

Jonathan

> ---
> 
> Based on previous conversations which can be found here [1].
> 
> [1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
> ---
>  drivers/iio/accel/kxsd9-i2c.c              | 4 ++--
>  drivers/iio/gyro/bmg160_i2c.c              | 4 ++--
>  drivers/iio/gyro/bmg160_spi.c              | 4 ++--
>  drivers/iio/gyro/mpu3050-i2c.c             | 4 ++--
>  drivers/iio/imu/bmi160/bmi160_i2c.c        | 4 ++--
>  drivers/iio/imu/bmi160/bmi160_spi.c        | 4 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 4 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 4 ++--
>  drivers/iio/magnetometer/bmc150_magn_spi.c | 4 ++--
>  9 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 38411e1c155b..6a2fb2e84170 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>  
>  	regmap = devm_regmap_init_i2c(i2c, &config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&i2c->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 4fc9c6a3321f..abb11855e1b2 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -21,8 +21,8 @@ static int bmg160_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
> index 182a59c42507..104f1bac7805 100644
> --- a/drivers/iio/gyro/bmg160_spi.c
> +++ b/drivers/iio/gyro/bmg160_spi.c
> @@ -19,8 +19,8 @@ static int bmg160_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
> index afa8018b9238..9de9ca295742 100644
> --- a/drivers/iio/gyro/mpu3050-i2c.c
> +++ b/drivers/iio/gyro/mpu3050-i2c.c
> @@ -51,8 +51,8 @@ static int mpu3050_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &mpu3050_i2c_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index e36f5e82d400..6179d60d3968 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -24,8 +24,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
> index c19e3df35559..38fc4d124cc0 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -20,8 +20,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &bmi160_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 6993d3b87bb0..90f1f4c79605 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -122,8 +122,8 @@ static int inv_mpu_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 673b198e6368..7ee275547531 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -53,8 +53,8 @@ static int inv_mpu_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
> index ed9be0490d77..f4afad0c44cc 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_spi.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
> @@ -22,8 +22,8 @@ static int bmc150_magn_spi_probe(struct spi_device *spi)
>  
>  	regmap = devm_regmap_init_spi(spi, &bmc150_magn_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
> +			PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  	return bmc150_magn_probe(&spi->dev, regmap, spi->irq, id->name);

