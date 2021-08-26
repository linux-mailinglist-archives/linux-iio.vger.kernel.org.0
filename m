Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549D33F8DD6
	for <lists+linux-iio@lfdr.de>; Thu, 26 Aug 2021 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbhHZSam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 14:30:42 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:26694 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHZSam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 14:30:42 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d32 with ME
        id mJVt250043riaq203JVtbB; Thu, 26 Aug 2021 20:29:53 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Aug 2021 20:29:53 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH v2] iio: adc128s052: Simplify 'adc128_probe()'
To:     jic23@kernel.org, lars@metafoo.de, ardeleanalex@gmail.com,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <d769321da74eea17a1260b48d4ab16f416b37c74.1630002390.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <c573f244-df4f-5082-97b8-cdee617ed8de@wanadoo.fr>
Date:   Thu, 26 Aug 2021 20:29:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d769321da74eea17a1260b48d4ab16f416b37c74.1630002390.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 26/08/2021 à 20:28, Christophe JAILLET a écrit :
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
> v1 --> v2: Simplify 'adc128_disable_regulator()'
> ---
>   drivers/iio/adc/ti-adc128s052.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index e1afdb775100..3143f35a6509 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -132,13 +132,6 @@ static const struct iio_info adc128_info = {
>   	.read_raw = adc128_read_raw,
>   };
>   
> -static void adc128_disable_regulator(void *data)
> -{
> -	struct regulator *reg = data;
> -
> -	regulator_disable(reg);
> -}
> -
>   static int adc128_probe(struct spi_device *spi)
>   {
>   	struct iio_dev *indio_dev;
> @@ -158,6 +151,8 @@ static int adc128_probe(struct spi_device *spi)
>   	adc = iio_priv(indio_dev);
>   	adc->spi = spi;
>   
> +	spi_set_drvdata(spi, indio_dev);
> +
>   	indio_dev->name = spi_get_device_id(spi)->name;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->info = &adc128_info;
> @@ -172,13 +167,23 @@ static int adc128_probe(struct spi_device *spi)
>   	ret = regulator_enable(adc->reg);
>   	if (ret < 0)
>   		return ret;
> -	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator, adc->reg);
> -	if (ret)
> -		return ret;
>   
>   	mutex_init(&adc->lock);
>   
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	ret = iio_device_register(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int adc128_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adc128 *adc = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(adc->reg);
> +
> +	return 0;
>   }
>   
>   static const struct of_device_id adc128_of_match[] = {
> @@ -220,6 +225,7 @@ static struct spi_driver adc128_driver = {
>   		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
>   	},
>   	.probe = adc128_probe,
> +	.remove = adc128_remove,
>   	.id_table = adc128_id,
>   };
>   module_spi_driver(adc128_driver);
> 
NACK

I messed-up everything and this v2 is just garbage
Sorry for the noise.

CJ
