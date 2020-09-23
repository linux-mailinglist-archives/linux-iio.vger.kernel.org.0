Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1886927628C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWUwb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIWUwb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:52:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331EC214F1;
        Wed, 23 Sep 2020 20:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600894350;
        bh=Q06p8Et9US/NfgUeEtjZnh3mkPhqpZz0306QBf0WJPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RM+T9ohJJqm2UxXudwE51CP564QadUXTGiUXONJqMn3Hc94O2xnXlDbroE6uOaHaz
         YqrzHaRhJEkPu1qY/5Wcn3TubfoxstyN/Btz2zdBN/K6SoDLKvtCV7jcuX5Fq+pnfB
         p/qsWoX5SraJZXlEC5GLvkb3vuOOYAa5VbgpCCe8=
Date:   Wed, 23 Sep 2020 21:52:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <Jonathan.Cameron@huawei.com>, <eugen.hristev@microchip.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] iio: adc: at91-sama5d2_adc: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20200923215158.1d3d73fc@archlinux>
In-Reply-To: <20200918082837.32610-1-bobo.shaobowang@huawei.com>
References: <20200918082837.32610-1-bobo.shaobowang@huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 16:28:37 +0800
Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:

> Make use of devm_platform_get_and_ioremap_resource() provided by
> driver core platform instead of duplicated analogue.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

Hi,

Thanks.  As far as I can see this boilerplate removal with no
side effects, so applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index de9583d6cddd..ad7d9819f83c 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1764,17 +1764,13 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	mutex_init(&st->lock);
>  	INIT_WORK(&st->touch_st.workq, at91_adc_workq_handler);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -EINVAL;
> +	st->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(st->base))
> +		return PTR_ERR(st->base);
>  
>  	/* if we plan to use DMA, we need the physical address of the regs */
>  	st->dma_st.phys_addr = res->start;
>  
> -	st->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(st->base))
> -		return PTR_ERR(st->base);
> -
>  	st->irq = platform_get_irq(pdev, 0);
>  	if (st->irq <= 0) {
>  		if (!st->irq)

