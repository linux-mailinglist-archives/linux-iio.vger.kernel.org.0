Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A045B735
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 10:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhKXJTr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 04:19:47 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43297 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbhKXJT0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 04:19:26 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4F35060011;
        Wed, 24 Nov 2021 09:16:12 +0000 (UTC)
Date:   Wed, 24 Nov 2021 10:16:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 13/49] iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP
 guards to pm_ptr() / __maybe_unused
Message-ID: <YZ4C3L1c1X4HIIcX@piout.net>
References: <20211123211019.2271440-1-jic23@kernel.org>
 <20211123211019.2271440-14-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123211019.2271440-14-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/11/2021 21:09:43+0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> The pm_ptr() macro only removes the reference if CONFIG_PM is not
> set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
> will not always remove the pm_ops structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/iio/adc/at91_adc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 5a7d3a3a5fa8..14a4735d72b5 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1234,8 +1234,7 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int at91_adc_suspend(struct device *dev)
> +static __maybe_unused int at91_adc_suspend(struct device *dev)
>  {
>  	struct iio_dev *idev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(idev);
> @@ -1246,7 +1245,7 @@ static int at91_adc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int at91_adc_resume(struct device *dev)
> +static __maybe_unused int at91_adc_resume(struct device *dev)
>  {
>  	struct iio_dev *idev = dev_get_drvdata(dev);
>  	struct at91_adc_state *st = iio_priv(idev);
> @@ -1256,7 +1255,6 @@ static int at91_adc_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
>  
> @@ -1386,7 +1384,7 @@ static struct platform_driver at91_adc_driver = {
>  	.driver = {
>  		   .name = DRIVER_NAME,
>  		   .of_match_table = at91_adc_dt_ids,
> -		   .pm = &at91_adc_pm_ops,
> +		   .pm = pm_ptr(&at91_adc_pm_ops),
>  	},
>  };
>  
> -- 
> 2.34.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
