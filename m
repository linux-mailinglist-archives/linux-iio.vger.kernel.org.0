Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0878A073
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjH0RNQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjH0RNC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 13:13:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6212BF
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 10:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F8761183
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 17:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F45C433C7;
        Sun, 27 Aug 2023 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693156379;
        bh=E3Q7hhKHgDnKmN9any5ZO26biwbej76N3yAEwC5DU9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DDbHTkOqQZSQ5agvWbubhu2ApGwviO5Blx+xg8MlKfAc52MzUIgL0MrDLJwoEn3u1
         DXrw+Ir6tvCkUcGYVBfnQn9jESHxCo35tJIiaWXNJcEd9kce7fM4xOss9Szfd1tP0j
         EcJeHQmuDU7RHBgA2SELWEC5khgKKI1Gp6GV5zNGLl9BFAhcadii25RpGdtQw89smx
         RuOWyBlewzlg7yRbwQSMat8bvGdoqaU5LzXdVm5D8El2/Wxo7Ij2e6Ctax6u84pBwq
         /JkUPqfTz8zrLrcxebSJTHBN4iItVn0ojGMFfN1aGkj9xAcb2/O3dTxwnJOJJKX3LY
         5AlKYqat87oUg==
Date:   Sun, 27 Aug 2023 18:13:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <yangyingliang@huawei.com>, <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next v2 2/3] iio: adc: at91_adc: Use devm_request_irq()
 helper function
Message-ID: <20230827181317.10ea9aa7@jic23-huawei>
In-Reply-To: <20230826022922.3457054-3-ruanjinjie@huawei.com>
References: <20230826022922.3457054-1-ruanjinjie@huawei.com>
        <20230826022922.3457054-3-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Aug 2023 10:29:21 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use devm_request_irq() to request the interrupt, so we can
> avoid having to manually clean this up.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/iio/adc/at91_adc.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 318e33ce22fb..2ac1b64f0fb7 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1077,11 +1077,13 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	at91_adc_writel(st, AT91_ADC_IDR, 0xFFFFFFFF);
>  
>  	if (st->caps->has_tsmr)
> -		ret = request_irq(st->irq, at91_adc_9x5_interrupt, 0,
> -				  pdev->dev.driver->name, idev);
> +		ret = devm_request_irq(&pdev->dev, st->irq,
> +				       at91_adc_9x5_interrupt, 0,
> +				       pdev->dev.driver->name, idev);
>  	else
> -		ret = request_irq(st->irq, at91_adc_rl_interrupt, 0,
> -				  pdev->dev.driver->name, idev);
> +		ret = devm_request_irq(&pdev->dev, st->irq,
> +				       at91_adc_rl_interrupt, 0,
> +				       pdev->dev.driver->name, idev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
>  		return ret;
> @@ -1092,7 +1094,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"Could not prepare or enable the clock.\n");
>  		ret = PTR_ERR(st->clk);
> -		goto error_free_irq;
> +		return ret;
Whilst they go away in the next patch, this does look odd as you can clearly just
do
		return PTR_ERR(st->clk);

In the interests of easy step wise patch review, I'd prefer that you made that
change in this patch in all the places this pattern occurs.

>  	}
>  
>  	st->adc_clk = devm_clk_get_enabled(&pdev->dev, "adc_op_clk");
> @@ -1100,7 +1102,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"Could not prepare or enable the ADC clock.\n");
>  		ret = PTR_ERR(st->adc_clk);
> -		goto error_free_irq;
> +		return ret;
>  	}
>  
>  	/*
> @@ -1119,8 +1121,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	if (!st->startup_time) {
>  		dev_err(&pdev->dev, "No startup time available.\n");
> -		ret = -EINVAL;
> -		goto error_free_irq;
> +		return -EINVAL;
>  	}
>  	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
>  
> @@ -1148,7 +1149,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	ret = at91_adc_channel_init(idev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
> -		goto error_free_irq;
> +		return ret;
>  	}
>  
>  	init_waitqueue_head(&st->wq_data_avail);
> @@ -1163,19 +1164,19 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		ret = at91_adc_buffer_init(idev);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
> -			goto error_free_irq;
> +			return ret;
>  		}
>  
>  		ret = at91_adc_trigger_init(idev);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
>  			at91_adc_buffer_remove(idev);
> -			goto error_free_irq;
> +			return ret;
>  		}
>  	} else {
>  		ret = at91_ts_register(idev, pdev);
>  		if (ret)
> -			goto error_free_irq;
> +			return ret;
>  
>  		at91_ts_hw_init(idev, adc_clk_khz);
>  	}
> @@ -1195,8 +1196,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	} else {
>  		at91_ts_unregister(st);
>  	}
> -error_free_irq:
> -	free_irq(st->irq, idev);
>  	return ret;
>  }
>  
> @@ -1212,7 +1211,6 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	} else {
>  		at91_ts_unregister(st);
>  	}
> -	free_irq(st->irq, idev);
>  
>  	return 0;
>  }

