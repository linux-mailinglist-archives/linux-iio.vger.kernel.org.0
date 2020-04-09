Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED91A379B
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDIP7k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 11:59:40 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36003 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgDIP7j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 11:59:39 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E02C2FF802;
        Thu,  9 Apr 2020 15:59:36 +0000 (UTC)
Date:   Thu, 9 Apr 2020 17:59:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Aishwarya R <aishwaryarj100@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Message-ID: <20200409155936.GV3628@piout.net>
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409151125.32677-1-aishwaryarj100@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 09/04/2020 20:41:23+0530, Aishwarya R wrote:
> Use the helper function that wraps the calls to
> platform_get_resource() and devm_ioremap_resource()
> together.
> 

Please elaborate the actual value of doing that.

> Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
> ---
>  drivers/iio/adc/at91_adc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index abe99856c823..0368b6dc6d60 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1152,7 +1152,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	int ret;
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
> -	struct resource *res;
>  	u32 reg;
>  
>  	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
> @@ -1182,9 +1181,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (st->irq < 0)
>  		return -ENODEV;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	st->reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(st->reg_base))
>  		return PTR_ERR(st->reg_base);
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
