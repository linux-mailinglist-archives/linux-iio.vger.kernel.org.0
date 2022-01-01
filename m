Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A234827F2
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 17:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiAAQcV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 11:32:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56926 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiAAQcU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 11:32:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB99608C3
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 16:32:20 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 6EE41C36AEC;
        Sat,  1 Jan 2022 16:32:18 +0000 (UTC)
Date:   Sat, 1 Jan 2022 16:38:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 15/49] iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP
 guards to pm_ptr() / __maybe_unused
Message-ID: <20220101163807.08f711ed@jic23-huawei>
In-Reply-To: <20211123211019.2271440-16-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-16-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 21:09:45 +0000
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
> ---
>  drivers/iio/adc/palmas_gpadc.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index f9c8385c72d3..98d7764e0662 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -653,8 +653,7 @@ static int palmas_gpadc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
> +static __maybe_unused int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
>  {
>  	int adc_period, conv;
>  	int i;
> @@ -759,7 +758,7 @@ static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
>  	return ret;
>  }
>  
> -static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
> +static __maybe_unused int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
>  {
>  	int ret;
>  
> @@ -777,7 +776,7 @@ static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
>  	return ret;
>  }
>  
> -static int palmas_gpadc_suspend(struct device *dev)
> +static __maybe_unused int palmas_gpadc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
> @@ -800,7 +799,7 @@ static int palmas_gpadc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int palmas_gpadc_resume(struct device *dev)
> +static __maybe_unused int palmas_gpadc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
> @@ -822,9 +821,8 @@ static int palmas_gpadc_resume(struct device *dev)
>  
>  	return 0;
>  };
> -#endif
>  
> -static const struct dev_pm_ops palmas_pm_ops = {
> +static __maybe_unused const struct dev_pm_ops palmas_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(palmas_gpadc_suspend,
>  				palmas_gpadc_resume)
>  };
I missed that this could have been SIMPLE_DEV_PM_OPS - in v2 that
will be the new DEFINE_SIMPLE_DEV_PM_OPS()

> @@ -840,7 +838,7 @@ static struct platform_driver palmas_gpadc_driver = {
>  	.remove = palmas_gpadc_remove,
>  	.driver = {
>  		.name = MOD_NAME,
> -		.pm = &palmas_pm_ops,
> +		.pm = pm_ptr(&palmas_pm_ops),
>  		.of_match_table = of_palmas_gpadc_match_tbl,
>  	},
>  };

