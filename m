Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C303FAD6D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 19:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhH2RNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 13:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhH2RNw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 13:13:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9798760F38;
        Sun, 29 Aug 2021 17:12:57 +0000 (UTC)
Date:   Sun, 29 Aug 2021 18:16:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lars@metafoo.de, ardeleanalex@gmail.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc128s052: Simplify 'adc128_probe()'
Message-ID: <20210829181612.0b366561@jic23-huawei>
In-Reply-To: <4fa7fcc59c40e27af0569138d656c698a53dbd44.1630002770.git.christophe.jaillet@wanadoo.fr>
References: <4fa7fcc59c40e27af0569138d656c698a53dbd44.1630002770.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Aug 2021 20:36:22 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Turn 'adc128_probe()' into a full resource managed function to simplify the
> code.
> 
> This way, the .remove function can be removed.
> Doing so, the only 'spi_get_drvdata()' call is removed and the
> corresponding 'spi_set_drvdata()' can be removed as well.
> 
> Suggested-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Looks good to me, but as mentioned this will need to wait for the
fix to go upstream.

Give me a poke if I seem to have lost it once that's true.

Thanks,

Jonathan

> ---
> Compile tested only.
> 
> When reviewing, pay special attention to the 'spi_set_drvdata()' call
> removal. I recently introduced a regression with a too aggressive cleanup
> like that.
> 
> This patch should be applied after
> https://lore.kernel.org/linux-iio/f33069f0-601b-4bbb-3766-026f7a161912-39ZsbGIQGT5GWvitb5QawA@public.gmane.org/T/#meb792dcd6540f87d9ae041660ca4738a776e924a
> 
> v1 --> v2: just garbage --> ignore
> v1 --> v3: Simplify 'adc128_disable_regulator()'
> ---
>  drivers/iio/adc/ti-adc128s052.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 3143f35a6509..ce0cfe40b219 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -132,6 +132,11 @@ static const struct iio_info adc128_info = {
>  	.read_raw = adc128_read_raw,
>  };
>  
> +static void adc128_disable_regulator(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int adc128_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -151,8 +156,6 @@ static int adc128_probe(struct spi_device *spi)
>  	adc = iio_priv(indio_dev);
>  	adc->spi = spi;
>  
> -	spi_set_drvdata(spi, indio_dev);
> -
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &adc128_info;
> @@ -167,23 +170,13 @@ static int adc128_probe(struct spi_device *spi)
>  	ret = regulator_enable(adc->reg);
>  	if (ret < 0)
>  		return ret;
> +	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator, adc->reg);
> +	if (ret)
> +		return ret;
>  
>  	mutex_init(&adc->lock);
>  
> -	ret = iio_device_register(indio_dev);
> -
> -	return ret;
> -}
> -
> -static int adc128_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adc128 *adc = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	regulator_disable(adc->reg);
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id adc128_of_match[] = {
> @@ -225,7 +218,6 @@ static struct spi_driver adc128_driver = {
>  		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
>  	},
>  	.probe = adc128_probe,
> -	.remove = adc128_remove,
>  	.id_table = adc128_id,
>  };
>  module_spi_driver(adc128_driver);

