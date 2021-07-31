Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988213DC6FC
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGaQnV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 12:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaQnV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 12:43:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF14360D07;
        Sat, 31 Jul 2021 16:43:11 +0000 (UTC)
Date:   Sat, 31 Jul 2021 17:45:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: fix the right check and
 simplify code
Message-ID: <20210731174551.188aee79@jic23-huawei>
In-Reply-To: <20210727125209.28248-1-tangbin@cmss.chinamobile.com>
References: <20210727125209.28248-1-tangbin@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 20:52:09 +0800
Tang Bin <tangbin@cmss.chinamobile.com> wrote:

> For the function of platform_get_irq(), the example in platform.c is
> *		int irq = platform_get_irq(pdev, 0);
> *		if (irq < 0)
> *			return irq;
> So the return value of zero is unnecessary to check. And move it
> up to a little bit can simplify the code jump.
> 
> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Hi,

Logically it is better to keep the irq handling all together, so 
I would prefer we didn't move it.

Also, platform_get_irq() is documented as never returning 0, so the current
code is not incorrect.  As such, this looks like noise unless there is
some plan to make use of the 0 return value?  What benefit do we get from
this change?

Thanks,

Jonathan

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 8cb51cf7a..d28976f21 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -320,6 +320,10 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq < 0)
> +		return priv->irq;
> +
>  	for (i = 0; i != 4; ++i) {
>  		if (!priv->vref[i])
>  			continue;
> @@ -336,14 +340,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  		goto err_vref_disable;
>  	}
>  
> -	priv->irq = platform_get_irq(pdev, 0);
> -	if (priv->irq <= 0) {
> -		ret = priv->irq;
> -		if (!ret)
> -			ret = -ENXIO;
> -		goto err_clk_unprepare;
> -	}
> -
>  	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
>  	if (ret) {
>  		dev_err(dev, "Failed requesting IRQ\n");

