Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533663D4852
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGXOoo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 10:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXOon (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 10:44:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C879A6056C;
        Sat, 24 Jul 2021 15:25:10 +0000 (UTC)
Date:   Sat, 24 Jul 2021 16:27:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        broonie@kernel.org, lgirdwood@gmail.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: Use the defined variable to
 clean code
Message-ID: <20210724162741.15a8b8b6@jic23-huawei>
In-Reply-To: <20210720125945.11548-1-tangbin@cmss.chinamobile.com>
References: <20210720125945.11548-1-tangbin@cmss.chinamobile.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Jul 2021 20:59:45 +0800
Tang Bin <tangbin@cmss.chinamobile.com> wrote:

> Use the defined variable "dev" to make the code cleaner.
> 
> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index d28976f21..01fe5b137 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -192,11 +192,11 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  	 */
>  	priv->vref[MX25_ADC_REFP_INT] = NULL;
>  	priv->vref[MX25_ADC_REFP_EXT] =
> -		devm_regulator_get_optional(&pdev->dev, "vref-ext");
> +		devm_regulator_get_optional(dev, "vref-ext");
>  	priv->vref[MX25_ADC_REFP_XP] =
> -		devm_regulator_get_optional(&pdev->dev, "vref-xp");
> +		devm_regulator_get_optional(dev, "vref-xp");
>  	priv->vref[MX25_ADC_REFP_YP] =
> -		devm_regulator_get_optional(&pdev->dev, "vref-yp");
> +		devm_regulator_get_optional(dev, "vref-yp");
>  
>  	for_each_child_of_node(np, child) {
>  		u32 reg;
> @@ -298,7 +298,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  	int ret;
>  	int i;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  

