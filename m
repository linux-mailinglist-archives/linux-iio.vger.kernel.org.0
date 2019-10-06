Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D17CD021
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfJFJut (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJut (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:50:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8BD20867;
        Sun,  6 Oct 2019 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570355448;
        bh=VhtuzqfBvrR81T1HFD3R8lHzSWNl+vOseLxfnzhZ5oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2LJfYaN8klIOEW0ptkuZl2VyDKvqSSHAWWQVvWzOJT6fzJ4JTLes5idFbB1UYrCp5
         O/CVzB/YIjmkfEKI4r4+Zs3woh5S9vWdEP81uz+QZoUuaAdeffpYF6DNKtnIkYb2F5
         7j4D8w6tVvbDakgbtEVgKUPoCbcFFgUidL7XLHPU=
Date:   Sun, 6 Oct 2019 10:50:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/4] iio: pressure: bmp280: use bulk regulator ops
Message-ID: <20191006105043.4ad65ec3@archlinux>
In-Reply-To: <20191002085759.13337-2-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
        <20191002085759.13337-2-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Oct 2019 10:57:56 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The vddd and vdda supplies are always operated on together. We can
> shrink the code a bit by using the bulk regulator helpers.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Looks good. Will pick up once I have the precursors in my branch.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 69 +++++++++++++-----------------
>  1 file changed, 30 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 8d0f15f27dc5..c21f8ce7b09c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -74,6 +74,12 @@ struct bmp280_calib {
>  	s8  H6;
>  };
>  
> +static const char *const bmp280_supply_names[] = {
> +	"vddd", "vdda"
> +};
> +
> +#define BMP280_NUM_SUPPLIES ARRAY_SIZE(bmp280_supply_names)
> +
>  struct bmp280_data {
>  	struct device *dev;
>  	struct mutex lock;
> @@ -85,8 +91,7 @@ struct bmp280_data {
>  		struct bmp180_calib bmp180;
>  		struct bmp280_calib bmp280;
>  	} calib;
> -	struct regulator *vddd;
> -	struct regulator *vdda;
> +	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
>  	unsigned int start_up_time; /* in microseconds */
>  
>  	/* log of base 2 of oversampling rate */
> @@ -1033,27 +1038,23 @@ int bmp280_common_probe(struct device *dev,
>  	}
>  
>  	/* Bring up regulators */
> -	data->vddd = devm_regulator_get(dev, "vddd");
> -	if (IS_ERR(data->vddd)) {
> -		dev_err(dev, "failed to get VDDD regulator\n");
> -		return PTR_ERR(data->vddd);
> -	}
> -	ret = regulator_enable(data->vddd);
> +	regulator_bulk_set_supply_names(data->supplies,
> +					bmp280_supply_names,
> +					BMP280_NUM_SUPPLIES);
> +
> +	ret = devm_regulator_bulk_get(dev,
> +				      BMP280_NUM_SUPPLIES, data->supplies);
>  	if (ret) {
> -		dev_err(dev, "failed to enable VDDD regulator\n");
> +		dev_err(dev, "failed to get regulators\n");
>  		return ret;
>  	}
> -	data->vdda = devm_regulator_get(dev, "vdda");
> -	if (IS_ERR(data->vdda)) {
> -		dev_err(dev, "failed to get VDDA regulator\n");
> -		ret = PTR_ERR(data->vdda);
> -		goto out_disable_vddd;
> -	}
> -	ret = regulator_enable(data->vdda);
> +
> +	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
>  	if (ret) {
> -		dev_err(dev, "failed to enable VDDA regulator\n");
> -		goto out_disable_vddd;
> +		dev_err(dev, "failed to enable regulators\n");
> +		return ret;
>  	}
> +
>  	/* Wait to make sure we started up properly */
>  	usleep_range(data->start_up_time, data->start_up_time + 100);
>  
> @@ -1068,17 +1069,17 @@ int bmp280_common_probe(struct device *dev,
>  	data->regmap = regmap;
>  	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
>  	if (ret < 0)
> -		goto out_disable_vdda;
> +		goto out_disable_regulators;
>  	if (chip_id != chip) {
>  		dev_err(dev, "bad chip id: expected %x got %x\n",
>  			chip, chip_id);
>  		ret = -EINVAL;
> -		goto out_disable_vdda;
> +		goto out_disable_regulators;
>  	}
>  
>  	ret = data->chip_info->chip_config(data);
>  	if (ret < 0)
> -		goto out_disable_vdda;
> +		goto out_disable_regulators;
>  
>  	dev_set_drvdata(dev, indio_dev);
>  
> @@ -1092,14 +1093,14 @@ int bmp280_common_probe(struct device *dev,
>  		if (ret < 0) {
>  			dev_err(data->dev,
>  				"failed to read calibration coefficients\n");
> -			goto out_disable_vdda;
> +			goto out_disable_regulators;
>  		}
>  	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
>  		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
>  		if (ret < 0) {
>  			dev_err(data->dev,
>  				"failed to read calibration coefficients\n");
> -			goto out_disable_vdda;
> +			goto out_disable_regulators;
>  		}
>  	}
>  
> @@ -1111,7 +1112,7 @@ int bmp280_common_probe(struct device *dev,
>  	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
>  		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
>  		if (ret)
> -			goto out_disable_vdda;
> +			goto out_disable_regulators;
>  	}
>  
>  	/* Enable runtime PM */
> @@ -1137,10 +1138,8 @@ int bmp280_common_probe(struct device *dev,
>  	pm_runtime_get_sync(data->dev);
>  	pm_runtime_put_noidle(data->dev);
>  	pm_runtime_disable(data->dev);
> -out_disable_vdda:
> -	regulator_disable(data->vdda);
> -out_disable_vddd:
> -	regulator_disable(data->vddd);
> +out_disable_regulators:
> +	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  	return ret;
>  }
>  EXPORT_SYMBOL(bmp280_common_probe);
> @@ -1154,8 +1153,7 @@ int bmp280_common_remove(struct device *dev)
>  	pm_runtime_get_sync(data->dev);
>  	pm_runtime_put_noidle(data->dev);
>  	pm_runtime_disable(data->dev);
> -	regulator_disable(data->vdda);
> -	regulator_disable(data->vddd);
> +	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  	return 0;
>  }
>  EXPORT_SYMBOL(bmp280_common_remove);
> @@ -1165,12 +1163,8 @@ static int bmp280_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	int ret;
>  
> -	ret = regulator_disable(data->vdda);
> -	if (ret)
> -		return ret;
> -	return regulator_disable(data->vddd);
> +	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  }
>  
>  static int bmp280_runtime_resume(struct device *dev)
> @@ -1179,10 +1173,7 @@ static int bmp280_runtime_resume(struct device *dev)
>  	struct bmp280_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = regulator_enable(data->vddd);
> -	if (ret)
> -		return ret;
> -	ret = regulator_enable(data->vdda);
> +	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
>  	if (ret)
>  		return ret;
>  	usleep_range(data->start_up_time, data->start_up_time + 100);

