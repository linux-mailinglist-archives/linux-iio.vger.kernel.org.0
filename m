Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D714827ED
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 17:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiAAQWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 11:22:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53136 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiAAQWE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 11:22:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC3D60B4A
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 16:22:03 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A1AAAC36AE9;
        Sat,  1 Jan 2022 16:22:00 +0000 (UTC)
Date:   Sat, 1 Jan 2022 16:27:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/49] iio:adc:ad7606: Switch from CONFIG_PM_SLEEP
 guards to pm_ptr() / __maybe_unused
Message-ID: <20220101162748.1f99ad6b@jic23-huawei>
In-Reply-To: <20211123211019.2271440-13-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-13-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 21:09:42 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> The pm_ptr() macro only removes the reference if CONFIG_PM is not
> set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
> will not always remove the pm_ops structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'll comment here as this patch won't exist in v2.

Given the structure is exported from one module to others, the
compiler can't remove it automatically.  Hence this one really does
need the CONFIG_PM_SLEEP guards.

Not sure what I was thinking when I wrote this!

Jonathan

> ---
>  drivers/iio/adc/ad7606.c     | 8 ++------
>  drivers/iio/adc/ad7606.h     | 5 -----
>  drivers/iio/adc/ad7606_par.c | 2 +-
>  drivers/iio/adc/ad7606_spi.c | 2 +-
>  4 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 0a60ecc69d38..16a013aad20f 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -695,9 +695,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  }
>  EXPORT_SYMBOL_GPL(ad7606_probe);
>  
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int ad7606_suspend(struct device *dev)
> +static __maybe_unused int ad7606_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -710,7 +708,7 @@ static int ad7606_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int ad7606_resume(struct device *dev)
> +static __maybe_unused int ad7606_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -727,8 +725,6 @@ static int ad7606_resume(struct device *dev)
>  SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
>  EXPORT_SYMBOL_GPL(ad7606_pm_ops);
>  
> -#endif
> -
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 9350ef1f63b5..fd545836790e 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -162,11 +162,6 @@ enum ad7606_supported_device_ids {
>  	ID_AD7616,
>  };
>  
> -#ifdef CONFIG_PM_SLEEP
>  extern const struct dev_pm_ops ad7606_pm_ops;
> -#define AD7606_PM_OPS (&ad7606_pm_ops)
> -#else
> -#define AD7606_PM_OPS NULL
> -#endif
>  
>  #endif /* IIO_ADC_AD7606_H_ */
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index f732b3ac7878..60be3fb4ae39 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -92,7 +92,7 @@ static struct platform_driver ad7606_driver = {
>  	.id_table = ad7606_driver_ids,
>  	.driver = {
>  		.name = "ad7606",
> -		.pm = AD7606_PM_OPS,
> +		.pm = pm_ptr(&ad7606_pm_ops),
>  		.of_match_table = ad7606_of_match,
>  	},
>  };
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 29945ad07dca..8cc525b4b960 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -352,7 +352,7 @@ static struct spi_driver ad7606_driver = {
>  	.driver = {
>  		.name = "ad7606",
>  		.of_match_table = ad7606_of_match,
> -		.pm = AD7606_PM_OPS,
> +		.pm = pm_ptr(&ad7606_pm_ops),
>  	},
>  	.probe = ad7606_spi_probe,
>  	.id_table = ad7606_id_table,

