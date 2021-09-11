Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746164079C8
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhIKRO1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 13:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKRO1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 13:14:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FE160ED8;
        Sat, 11 Sep 2021 17:13:12 +0000 (UTC)
Date:   Sat, 11 Sep 2021 18:16:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH] iio: ep93xx: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210911181643.72d02489@jic23-huawei>
In-Reply-To: <20210908105646.1576-1-caihuoqing@baidu.com>
References: <20210908105646.1576-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Sep 2021 18:56:45 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

+CC Alexander who wrote this driver.

Given this one is less active than the others you've sent I'll pick it up now.
(the others will wait a few days to see if we get reviews from anyone else).

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ep93xx_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> index 8edd6407b7c3..fd5a9404c8dc 100644
> --- a/drivers/iio/adc/ep93xx_adc.c
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -156,15 +156,13 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
>  	struct iio_dev *iiodev;
>  	struct ep93xx_adc_priv *priv;
>  	struct clk *pclk;
> -	struct resource *res;
>  
>  	iiodev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>  	if (!iiodev)
>  		return -ENOMEM;
>  	priv = iio_priv(iiodev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>  

