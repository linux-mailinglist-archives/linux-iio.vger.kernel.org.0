Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4C7887C7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbjHYMuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbjHYMuC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 08:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CDD3
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 05:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA0C679F4
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 12:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4550C433C7;
        Fri, 25 Aug 2023 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692967799;
        bh=1haDrisz44iUrE3NxI7V4IWD23n0aYus9i3F3Q97qc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XPwLfyCDaVrEKBOCVP6MzmrnQNu27Y7tKiQU6D4dBNU9L54U4D8neb9RyN2RAefrX
         3I8klXtRtYlG+cl5Zr7WeErV1PYNVDPmkNNsSd5o61Fj7bMZnqQN6ohdz2Eottu+8M
         PluhjB2Ge+YioGpSjVy/xRGCAWa0xBtuLUTKyeReN1wAYOtpjb9wN+0+bLFslI4YIk
         umr92og3ymlPoUKZwxS0ePN6gYqSiH0R9fHLyoM4+byvD5PeiU2rmYBF+Sq8neuVJa
         9yAv5/ow9AP0o4Fs8BakztEffmEJrl0Rblwk/gjs21v5mdkc0XHszV0zNJ72P7TwTY
         zKtcV5EirDx/g==
Date:   Fri, 25 Aug 2023 13:50:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Michael.Hennerich@analog.com>, <heiko@sntech.de>,
        <yangyingliang@huawei.com>, <robh@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH -next 1/4] iio: adc: at91_adc: Use
 devm_clk_get_enabled() helper function
Message-ID: <20230825135015.481d0aff@jic23-huawei>
In-Reply-To: <20230825105746.2999548-2-ruanjinjie@huawei.com>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
        <20230825105746.2999548-2-ruanjinjie@huawei.com>
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

On Fri, 25 Aug 2023 18:57:43 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

This looks good, but should ideally be proceeded by a separate patch moving to
devm_request_irq() as then the exit paths will become much simpler and you
can also move to return dev_err_probe() save a few pointless lines of code
and give the benefit of debug info for deferred return codes.




> ---
>  drivers/iio/adc/at91_adc.c | 38 ++++++++++----------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index de6650f9c4b1..318e33ce22fb 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1087,32 +1087,20 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	st->clk = devm_clk_get(&pdev->dev, "adc_clk");
> +	st->clk = devm_clk_get_enabled(&pdev->dev, "adc_clk");
>  	if (IS_ERR(st->clk)) {
> -		dev_err(&pdev->dev, "Failed to get the clock.\n");
> -		ret = PTR_ERR(st->clk);
> -		goto error_free_irq;
> -	}
> -
> -	ret = clk_prepare_enable(st->clk);
> -	if (ret) {
>  		dev_err(&pdev->dev,
>  			"Could not prepare or enable the clock.\n");
> +		ret = PTR_ERR(st->clk);
>  		goto error_free_irq;
>  	}
>  
> -	st->adc_clk = devm_clk_get(&pdev->dev, "adc_op_clk");
> +	st->adc_clk = devm_clk_get_enabled(&pdev->dev, "adc_op_clk");
>  	if (IS_ERR(st->adc_clk)) {
> -		dev_err(&pdev->dev, "Failed to get the ADC clock.\n");
> -		ret = PTR_ERR(st->adc_clk);
> -		goto error_disable_clk;
> -	}
> -
> -	ret = clk_prepare_enable(st->adc_clk);
> -	if (ret) {
>  		dev_err(&pdev->dev,
>  			"Could not prepare or enable the ADC clock.\n");
> -		goto error_disable_clk;
> +		ret = PTR_ERR(st->adc_clk);
> +		goto error_free_irq;
>  	}
>  
>  	/*
> @@ -1132,7 +1120,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (!st->startup_time) {
>  		dev_err(&pdev->dev, "No startup time available.\n");
>  		ret = -EINVAL;
> -		goto error_disable_adc_clk;
> +		goto error_free_irq;
>  	}
>  	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
>  
> @@ -1160,7 +1148,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	ret = at91_adc_channel_init(idev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
> -		goto error_disable_adc_clk;
> +		goto error_free_irq;
>  	}
>  
>  	init_waitqueue_head(&st->wq_data_avail);
> @@ -1175,19 +1163,19 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		ret = at91_adc_buffer_init(idev);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
> -			goto error_disable_adc_clk;
> +			goto error_free_irq;
>  		}
>  
>  		ret = at91_adc_trigger_init(idev);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
>  			at91_adc_buffer_remove(idev);
> -			goto error_disable_adc_clk;
> +			goto error_free_irq;
>  		}
>  	} else {
>  		ret = at91_ts_register(idev, pdev);
>  		if (ret)
> -			goto error_disable_adc_clk;
> +			goto error_free_irq;
>  
>  		at91_ts_hw_init(idev, adc_clk_khz);
>  	}
> @@ -1207,10 +1195,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	} else {
>  		at91_ts_unregister(st);
>  	}
> -error_disable_adc_clk:
> -	clk_disable_unprepare(st->adc_clk);
> -error_disable_clk:
> -	clk_disable_unprepare(st->clk);
>  error_free_irq:
>  	free_irq(st->irq, idev);
>  	return ret;
> @@ -1228,8 +1212,6 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	} else {
>  		at91_ts_unregister(st);
>  	}
> -	clk_disable_unprepare(st->adc_clk);
> -	clk_disable_unprepare(st->clk);
>  	free_irq(st->irq, idev);
>  
>  	return 0;

