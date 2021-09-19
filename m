Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9A410CB0
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhISRce (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 13:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhISRcd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 13:32:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1502F6101C;
        Sun, 19 Sep 2021 17:31:05 +0000 (UTC)
Date:   Sun, 19 Sep 2021 18:34:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210919183447.33adf804@jic23-huawei>
In-Reply-To: <20210908105631.1474-1-caihuoqing@baidu.com>
References: <20210908105631.1474-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Sep 2021 18:56:30 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Hi Cai,

Applied to the togreg branch of iio.git and pushed out as testing for 0-day to
see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rockchip_saradc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index a237fe469a30..a56a0d7337ca 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -319,7 +319,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	struct rockchip_saradc *info = NULL;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct iio_dev *indio_dev = NULL;
> -	struct resource	*mem;
>  	const struct of_device_id *match;
>  	int ret;
>  	int irq;
> @@ -348,8 +347,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	info->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(info->regs))
>  		return PTR_ERR(info->regs);
>  

