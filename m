Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E64107F8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhIRSBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 14:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhIRSBs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:01:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FBC6101B;
        Sat, 18 Sep 2021 18:00:22 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:04:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad9832: convert probe to device-managed
Message-ID: <20210918190402.379e2972@jic23-huawei>
In-Reply-To: <20210913115209.300665-1-aardelean@deviqon.com>
References: <20210913115209.300665-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 14:52:09 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change does a conversion of the driver to use device-managed init
> functions. The 2 regulators and the clock inits are converted to use
> devm_add_action_or_reset() callbacks for de-initializing them when the
> driver unloads.
> 
> And finally the devm_iio_device_register() function can be use to register
> the device.
> 
> The remove hook can finally be removed and the spi_set_drvdata() call can
> also be removed as the private data is no longer used.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/frequency/ad9832.c | 82 +++++++++++---------------
>  1 file changed, 36 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 3f1981e287f5..f43464db618a 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -294,6 +294,16 @@ static const struct iio_info ad9832_info = {
>  	.attrs = &ad9832_attribute_group,
>  };
>  
> +static void ad9832_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
> +static void ad9832_clk_disable(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
>  static int ad9832_probe(struct spi_device *spi)
>  {
>  	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -310,7 +320,6 @@ static int ad9832_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	spi_set_drvdata(spi, indio_dev);
>  	st = iio_priv(indio_dev);
>  
>  	st->avdd = devm_regulator_get(&spi->dev, "avdd");
> @@ -323,27 +332,35 @@ static int ad9832_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->avdd);
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
>  		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
> -		goto error_disable_avdd;
> +		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->dvdd);
> +	if (ret)
> +		return ret;
> +
>  	st->mclk = devm_clk_get(&spi->dev, "mclk");
> -	if (IS_ERR(st->mclk)) {
> -		ret = PTR_ERR(st->mclk);
> -		goto error_disable_dvdd;
> -	}
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
>  
>  	ret = clk_prepare_enable(st->mclk);
>  	if (ret < 0)
> -		goto error_disable_dvdd;
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad9832_clk_disable, st->mclk);
> +	if (ret)
> +		return ret;
>  
>  	st->spi = spi;
>  	mutex_init(&st->lock);
> @@ -394,60 +411,34 @@ static int ad9832_probe(struct spi_device *spi)
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret) {
>  		dev_err(&spi->dev, "device init failed\n");
> -		goto error_unprepare_mclk;
> +		return ret;
>  	}
>  
>  	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
>  	if (ret)
> -		goto error_unprepare_mclk;
> +		return ret;
>  
>  	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
>  	if (ret)
> -		goto error_unprepare_mclk;
> +		return ret;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
>  	if (ret)
> -		goto error_unprepare_mclk;
> +		return ret;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
>  	if (ret)
> -		goto error_unprepare_mclk;
> +		return ret;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
>  	if (ret)
> -		goto error_unprepare_mclk;
> +		return ret;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
>  	if (ret)
> -		goto error_unprepare_mclk;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_unprepare_mclk;
> -
> -	return 0;
> -
> -error_unprepare_mclk:
> -	clk_disable_unprepare(st->mclk);
> -error_disable_dvdd:
> -	regulator_disable(st->dvdd);
> -error_disable_avdd:
> -	regulator_disable(st->avdd);
> -
> -	return ret;
> -}
> -
> -static int ad9832_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad9832_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	clk_disable_unprepare(st->mclk);
> -	regulator_disable(st->dvdd);
> -	regulator_disable(st->avdd);
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad9832_id[] = {
> @@ -462,7 +453,6 @@ static struct spi_driver ad9832_driver = {
>  		.name	= "ad9832",
>  	},
>  	.probe		= ad9832_probe,
> -	.remove		= ad9832_remove,
>  	.id_table	= ad9832_id,
>  };
>  module_spi_driver(ad9832_driver);

