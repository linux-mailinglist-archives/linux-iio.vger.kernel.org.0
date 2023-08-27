Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869B478A076
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjH0RQm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjH0RQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 13:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B612E
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 10:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C268161122
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 17:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDCEC433C7;
        Sun, 27 Aug 2023 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693156574;
        bh=a+kppEpKSWrqO7QpKZNsocyWWpiLpG6Y+C8FbSA3YUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SF2lI3XGwpGfTi8TOG0NcQzd4HIx/n5EX49xBulnZAMqEA2havkN6br81WE11vVsW
         Rqc8bPU9R0U5mzujUxNogAr5qAD4iWfNYZVGF3fmnqqgojv+jht4T4Qw3bHKJ2dn9l
         xmx7fjlKPMCiDHt21N2Ui0TqfMouT50egQxD3DMOrNpF1+G8nPh0tE5Qk318mokFI+
         IoG2AbWIP3qHcqHpkLuIAdlYX+1TihurLq9WJizAa1gPMISpnayQIkn4SwDfAH125u
         8+on2LBMciIL2ZhEpEZNm1kJ/5jonaHgN8zo46dyPxXcK4wZQbRmdghICy9XFK041H
         mtDmsCpzjEL6Q==
Date:   Sun, 27 Aug 2023 18:16:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <yangyingliang@huawei.com>, <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next v2 3/3] iio: adc: at91_adc: Simplify with
 dev_err_probe()
Message-ID: <20230827181633.605fa2d5@jic23-huawei>
In-Reply-To: <20230826022922.3457054-4-ruanjinjie@huawei.com>
References: <20230826022922.3457054-1-ruanjinjie@huawei.com>
        <20230826022922.3457054-4-ruanjinjie@huawei.com>
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

On Sat, 26 Aug 2023 10:29:22 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless error
> is printed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
As I've asked for other changes so there will probably be another version
anyway - a few trivial comments inline.  Mostly you've hit the right balance
on line breaks, but there are a few more I'd like to see with the aim of
not going any longer than 80 chars than is necessary.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 65 ++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 2ac1b64f0fb7..a49f7021c73f 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1013,28 +1013,25 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>  
> -	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> -		dev_err(&idev->dev, "Missing adc-channels-used property in the DT.\n");
> -		return -EINVAL;
> -	}
> +	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop))
> +		return dev_err_probe(&idev->dev, -EINVAL,
> +				     "Missing adc-channels-used property in the DT.\n");
>  	st->channels_mask = prop;
>  
>  	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
>  
> -	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
> -		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
> -		return -EINVAL;
> -	}
> +	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop))
> +		return dev_err_probe(&idev->dev, -EINVAL,
> +				     "Missing adc-startup-time property in the DT.\n");
>  	st->startup_time = prop;
>  
>  	prop = 0;
>  	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
>  	st->sample_hold_time = prop;
>  
> -	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
> -		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
> -		return -EINVAL;
> -	}
> +	if (of_property_read_u32(node, "atmel,adc-vref", &prop))
> +		return dev_err_probe(&idev->dev, -EINVAL,
> +				     "Missing adc-vref property in the DT.\n");
>  	st->vref_mv = prop;
>  
>  	st->res = st->caps->high_res_bits;
> @@ -1069,7 +1066,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(st->reg_base))
>  		return PTR_ERR(st->reg_base);
>  
> -
>  	/*
>  	 * Disable all IRQs before setting up the handler
>  	 */
> @@ -1084,26 +1080,18 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		ret = devm_request_irq(&pdev->dev, st->irq,
>  				       at91_adc_rl_interrupt, 0,
>  				       pdev->dev.driver->name, idev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to allocate IRQ.\n");
>  
>  	st->clk = devm_clk_get_enabled(&pdev->dev, "adc_clk");
> -	if (IS_ERR(st->clk)) {
> -		dev_err(&pdev->dev,
> -			"Could not prepare or enable the clock.\n");
> -		ret = PTR_ERR(st->clk);
> -		return ret;
> -	}
> +	if (IS_ERR(st->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(st->clk),
> +				     "Could not prepare or enable the clock.\n");
>  
>  	st->adc_clk = devm_clk_get_enabled(&pdev->dev, "adc_op_clk");
> -	if (IS_ERR(st->adc_clk)) {
> -		dev_err(&pdev->dev,
> -			"Could not prepare or enable the ADC clock.\n");
> -		ret = PTR_ERR(st->adc_clk);
> -		return ret;
> -	}
> +	if (IS_ERR(st->adc_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(st->adc_clk),
> +				     "Could not prepare or enable the ADC clock.\n");
>  
>  	/*
>  	 * Prescaler rate computation using the formula from the Atmel's
> @@ -1119,10 +1107,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	prsc = (mstrclk / (2 * adc_clk)) - 1;
>  
> -	if (!st->startup_time) {
> -		dev_err(&pdev->dev, "No startup time available.\n");
> -		return -EINVAL;
> -	}
> +	if (!st->startup_time)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "No startup time available.\n");

Add a line break before the "

>  	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
>  
>  	/*
> @@ -1147,10 +1133,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	/* Setup the ADC channels available on the board */
>  	ret = at91_adc_channel_init(idev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Couldn't initialize the channels.\n");

Line break before "

>  
>  	init_waitqueue_head(&st->wq_data_avail);
>  	mutex_init(&st->lock);
> @@ -1162,10 +1146,9 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	 */
>  	if (!st->touchscreen_type) {
>  		ret = at91_adc_buffer_init(idev);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
> -			return ret;
> -		}
> +		if (ret < 0)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Couldn't initialize the buffer.\n");
>  
>  		ret = at91_adc_trigger_init(idev);
>  		if (ret < 0) {

