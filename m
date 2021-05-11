Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8637A8B3
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhEKOPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhEKOPX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 10:15:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED3F613F7;
        Tue, 11 May 2021 14:14:15 +0000 (UTC)
Date:   Tue, 11 May 2021 15:15:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio: ep93xx: Remove redundant error printing in
 ep93xx_adc_probe()
Message-ID: <20210511151522.4cdafbe9@jic23-huawei>
In-Reply-To: <20210511113912.5548-1-thunder.leizhen@huawei.com>
References: <20210511113912.5548-1-thunder.leizhen@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 19:39:12 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> When devm_ioremap_resource() fails, a clear enough error message will be
> printed by its subfunction __devm_ioremap_resource(). The error
> information contains the device name, failure cause, and possibly resource
> information.
> 
> Therefore, remove the error printing here to simplify code and reduce the
> binary size.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ep93xx_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> index c08ab3c6dfafd48..a10a4e8d94fdda8 100644
> --- a/drivers/iio/adc/ep93xx_adc.c
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -165,10 +165,8 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(priv->base)) {
> -		dev_err(&pdev->dev, "Cannot map memory resource\n");
> +	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> -	}
>  
>  	iiodev->name = dev_name(&pdev->dev);
>  	iiodev->modes = INDIO_DIRECT_MODE;

