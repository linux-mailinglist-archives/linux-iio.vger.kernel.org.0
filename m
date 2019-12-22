Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAB128ED0
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2019 17:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVQGJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Dec 2019 11:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfLVQGJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Dec 2019 11:06:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF262070A;
        Sun, 22 Dec 2019 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577030767;
        bh=Sl2yx+lIrkKRhlpPMiDC1rjSdFHftcpX7mfEQyeZ20I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RhCO6G/MA3S/IylOiCv75UeAaV3VxlWxDc469AEtXzrcsJ9/JS+kRl0a81BMCOtFd
         ba/9oua7Rci6Jcnl93sfy4SzPdm3wsnuA0PJZun+WGiDA5hlMUi2akK00cvDUD5U2e
         FV0vndPp7uscHyRBUhSC6IuJpKuTCaWFLqXLZzBE=
Date:   Sun, 22 Dec 2019 16:06:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 3/3] iio: (bma400) basic regulator support
Message-ID: <20191222160602.0f889650@archlinux>
In-Reply-To: <20191220160051.26321-4-dan@dlrobertson.com>
References: <20191220160051.26321-1-dan@dlrobertson.com>
        <20191220160051.26321-4-dan@dlrobertson.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Dec 2019 16:00:51 +0000
Dan Robertson <dan@dlrobertson.com> wrote:

> Add support for the VDD and VDDIO regulators using the regulator
> framework.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
I tweaked a little bit below to drop the select for REGULATOR.
That should be unnecessary.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig       |  1 +
>  drivers/iio/accel/bma400.h      |  4 ++++
>  drivers/iio/accel/bma400_core.c | 39 ++++++++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 670e60568033..9cfe9c790190 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -116,6 +116,7 @@ config BMA400
>  	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
>  	select REGMAP
>  	select BMA400_I2C if I2C
> +	select REGULATOR
You shouldn't need to select REGULATOR. There are stub functions such
that I believe this code should still work fine without it.

This assumes the regulators are always on, but that is valid for
some platforms.


>  	help
>  	  Say Y here if you want to build a driver for the Bosch BMA400
>  	  triaxial acceleration sensor.
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 15c0e307d2c4..5ad10db9819f 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -86,6 +86,10 @@
>  #define BMA400_SCALE_MIN            38357
>  #define BMA400_SCALE_MAX            306864
>  
> +#define BMA400_NUM_REGULATORS       2
> +#define BMA400_VDD_REGULATOR        0
> +#define BMA400_VDDIO_REGULATOR      1
> +
>  extern const struct regmap_config bma400_regmap_config;
>  
>  int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index e7ba01e79d2c..61eb676e46be 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "bma400.h"
>  
> @@ -53,6 +54,7 @@ struct bma400_sample_freq {
>  struct bma400_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct regulator_bulk_data regulators[BMA400_NUM_REGULATORS];
>  	struct mutex mutex; /* data register lock */
>  	struct iio_mount_matrix orientation;
>  	enum bma400_power_mode power_mode;
> @@ -573,17 +575,38 @@ static int bma400_init(struct bma400_data *data)
>  		goto out;
>  	}
>  
> +	data->regulators[BMA400_VDD_REGULATOR].supply = "vdd";
> +	data->regulators[BMA400_VDDIO_REGULATOR].supply = "vddio";
> +	ret = devm_regulator_bulk_get(data->dev,
> +				      ARRAY_SIZE(data->regulators),
> +				      data->regulators);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(data->dev,
> +				"Failed to get regulators: %d\n",
> +				ret);
> +
> +		goto out;
> +	}
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> +				    data->regulators);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to enable regulators: %d\n",
> +			ret);
> +		goto out;
> +	}
> +
>  	ret = bma400_get_power_mode(data);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to get the initial power-mode\n");
> -		goto out;
> +		goto err_reg_disable;
>  	}
>  
>  	if (data->power_mode != POWER_MODE_NORMAL) {
>  		ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
>  		if (ret) {
>  			dev_err(data->dev, "Failed to wake up the device\n");
> -			goto out;
> +			goto err_reg_disable;
>  		}
>  		/*
>  		 * TODO: The datasheet waits 1500us here in the example, but
> @@ -596,15 +619,15 @@ static int bma400_init(struct bma400_data *data)
>  
>  	ret = bma400_get_accel_output_data_rate(data);
>  	if (ret)
> -		goto out;
> +		goto err_reg_disable;
>  
>  	ret = bma400_get_accel_oversampling_ratio(data);
>  	if (ret)
> -		goto out;
> +		goto err_reg_disable;
>  
>  	ret = bma400_get_accel_scale(data);
>  	if (ret)
> -		goto out;
> +		goto err_reg_disable;
>  
>  	/*
>  	 * Once the interrupt engine is supported we might use the
> @@ -614,6 +637,9 @@ static int bma400_init(struct bma400_data *data)
>  	 */
>  	return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);
>  
> +err_reg_disable:
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
>  out:
>  	return ret;
>  }
> @@ -809,6 +835,9 @@ int bma400_remove(struct device *dev)
>  	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
>  	mutex_unlock(&data->mutex);
>  
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
> +
>  	iio_device_unregister(indio_dev);
>  
>  	return ret;
> 
> 

