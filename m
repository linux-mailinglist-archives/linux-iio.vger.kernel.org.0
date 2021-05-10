Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5D37965B
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhEJRsT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 13:48:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3056 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhEJRsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 13:48:17 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff7Zm3fHKz6wjpR;
        Tue, 11 May 2021 01:38:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 19:47:10 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 18:47:09 +0100
Date:   Mon, 10 May 2021 18:45:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <alexandru.tachici@analog.com>,
        <linux@deviqon.com>
Subject: Re: [PATCH 07/11] iio: adc: ad7192: convert to device-managed
 functions
Message-ID: <20210510184527.0000584e@Huawei.com>
In-Reply-To: <20210510125523.1271237-8-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
        <20210510125523.1271237-8-aardelean@deviqon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 May 2021 15:55:19 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
> now to convert the probe of the AD7192 driver to use device-managed
> functions.
> 
> The regulators and the mclk requires devm_add_action_or_reset() callbacks
> though.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

I'm fairly sure there's another bug in here... See below.

> ---
>  drivers/iio/adc/ad7192.c | 90 ++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 5b3c46213bd4..b3fa1b5764e9 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -908,6 +908,16 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static void ad7192_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
> +static void ad7192_clk_disable(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
> @@ -937,36 +947,40 @@ static int ad7192_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->avdd);
> +	if (ret)
> +		return ret;
> +
>  	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
> -	if (IS_ERR(st->dvdd)) {
> -		ret = PTR_ERR(st->dvdd);
> -		goto error_disable_avdd;
> -	}
> +	if (IS_ERR(st->dvdd))
> +		return PTR_ERR(st->dvdd);
>  
>  	ret = regulator_enable(st->dvdd);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
> -		goto error_disable_avdd;
> +		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->dvdd);
> +	if (ret)
> +		return ret;
> +
>  	voltage_uv = regulator_get_voltage(st->avdd);
>  
>  	if (voltage_uv > 0) {
>  		st->int_vref_mv = voltage_uv / 1000;
>  	} else {
> -		ret = voltage_uv;
>  		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
> -		goto error_disable_avdd;
> +		return voltage_uv;

There is a corner case here (in original code and new code).

What if voltage_uv == 0?  Driver reports successful probe. Not what we
want to happen.

>  	}
>  
> -	spi_set_drvdata(spi, indio_dev);
>  	st->chip_info = of_device_get_match_data(&spi->dev);
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = ad7192_channels_config(indio_dev);
>  	if (ret < 0)
> -		goto error_disable_dvdd;
> +		return ret;
>  
>  	if (st->chip_info->chip_id == CHIPID_AD7195)
>  		indio_dev->info = &ad7195_info;
> @@ -975,17 +989,15 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
>  
> -	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
> +	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		return ret;
>  
>  	st->fclk = AD7192_INT_FREQ_MHZ;
>  
>  	st->mclk = devm_clk_get_optional(&spi->dev, "mclk");
> -	if (IS_ERR(st->mclk)) {
> -		ret = PTR_ERR(st->mclk);
> -		goto error_remove_trigger;
> -	}
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
>  
>  	st->clock_sel = ad7192_of_clock_select(st);
>  
> @@ -993,55 +1005,26 @@ static int ad7192_probe(struct spi_device *spi)
>  	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
>  		ret = clk_prepare_enable(st->mclk);
>  		if (ret < 0)
> -			goto error_remove_trigger;
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7192_clk_disable,
> +					       st->mclk);
> +		if (ret)
> +			return ret;
>  
>  		st->fclk = clk_get_rate(st->mclk);
>  		if (!ad7192_valid_external_frequency(st->fclk)) {
> -			ret = -EINVAL;
>  			dev_err(&spi->dev,
>  				"External clock frequency out of bounds\n");
> -			goto error_disable_clk;
> +			return -EINVAL;
>  		}
>  	}
>  
>  	ret = ad7192_setup(st, spi->dev.of_node);
>  	if (ret)
> -		goto error_disable_clk;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto error_disable_clk;
> -	return 0;
> -
> -error_disable_clk:
> -	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> -	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
> -		clk_disable_unprepare(st->mclk);
> -error_remove_trigger:
> -	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> -error_disable_dvdd:
> -	regulator_disable(st->dvdd);
> -error_disable_avdd:
> -	regulator_disable(st->avdd);
> -
> -	return ret;
> -}
> -
> -static int ad7192_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad7192_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> -	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
> -		clk_disable_unprepare(st->mclk);
> -	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> -
> -	regulator_disable(st->dvdd);
> -	regulator_disable(st->avdd);
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id ad7192_of_match[] = {
> @@ -1059,7 +1042,6 @@ static struct spi_driver ad7192_driver = {
>  		.of_match_table = ad7192_of_match,
>  	},
>  	.probe		= ad7192_probe,
> -	.remove		= ad7192_remove,
>  };
>  module_spi_driver(ad7192_driver);
>  

