Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEC3FB490
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 13:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhH3LaC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 07:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhH3LaC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 07:30:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894EF6112D;
        Mon, 30 Aug 2021 11:29:07 +0000 (UTC)
Date:   Mon, 30 Aug 2021 12:32:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: twl6030-gpadc: Use the defined variable to
 clean code
Message-ID: <20210830123220.55980d62@jic23-huawei>
In-Reply-To: <20210823095921.16828-1-tangbin@cmss.chinamobile.com>
References: <20210823095921.16828-1-tangbin@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Aug 2021 17:59:21 +0800
Tang Bin <tangbin@cmss.chinamobile.com> wrote:

> Use the defined variable "dev" to make the code cleaner.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Applied.

Thanks,

> ---
>  drivers/iio/adc/twl6030-gpadc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 0859f3f7d..5e4fbb033 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -897,7 +897,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  
>  	ret = pdata->calibrate(gpadc);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to read calibration registers\n");
> +		dev_err(dev, "failed to read calibration registers\n");
>  		return ret;
>  	}
>  
> @@ -911,14 +911,14 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  
>  	ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to enable GPADC interrupt\n");
> +		dev_err(dev, "failed to enable GPADC interrupt\n");
>  		return ret;
>  	}
>  
>  	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
>  					TWL6030_REG_TOGGLE1);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to enable GPADC module\n");
> +		dev_err(dev, "failed to enable GPADC module\n");
>  		return ret;
>  	}
>  

