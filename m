Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D583E3AA8
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhHHNwE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 09:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhHHNwE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 09:52:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE0E060ED6;
        Sun,  8 Aug 2021 13:51:41 +0000 (UTC)
Date:   Sun, 8 Aug 2021 14:54:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH v2] iio: adc: fsl-imx25-gcq: fix the right check and
 simplify code
Message-ID: <20210808145431.5164b2d8@jic23-huawei>
In-Reply-To: <20210802120929.33760-1-tangbin@cmss.chinamobile.com>
References: <20210802120929.33760-1-tangbin@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Aug 2021 20:09:29 +0800
Tang Bin <tangbin@cmss.chinamobile.com> wrote:

> For the function of platform_get_irq(), the example in platform.c is
>  *	int irq = platform_get_irq(pdev, 0);
>  *	if (irq < 0)
>  *		return irq;
> the return value of zero is unnecessary to check, so make the right
> check and simplify code.
> 
> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Applied.  I tweaked the message an title to make it clear this isn't
a fix, but rather a little clean up with no functional affect.

Thanks,

Jonathan

> ---
> Changes from v1
>  - change the code to the original place and make it simple.
>  - change the commit message.
> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 8cb51cf7a..2cdf45aa8 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -336,14 +336,11 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  		goto err_vref_disable;
>  	}
>  
> -	priv->irq = platform_get_irq(pdev, 0);
> -	if (priv->irq <= 0) {
> -		ret = priv->irq;
> -		if (!ret)
> -			ret = -ENXIO;
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
>  		goto err_clk_unprepare;
> -	}
>  
> +	priv->irq = ret;
>  	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
>  	if (ret) {
>  		dev_err(dev, "Failed requesting IRQ\n");

