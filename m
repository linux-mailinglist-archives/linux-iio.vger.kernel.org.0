Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4EE7887E0
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbjHYMzG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244990AbjHYMyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 08:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC01BE2
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 05:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E3C6448F
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 12:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8680DC433C8;
        Fri, 25 Aug 2023 12:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692968089;
        bh=FWQPg110TvgRc6tCfjwnV3BeJ2g4RKBITPitm6v1+Vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R/eKp0y/LlrvgJ7LLiNKjoL0vcRSwv/gytA5fqtgx1gDs523gUrtepyQw90Am8tR5
         c8ICNbA4HsODW5ldVMDUIt3Gm26P51dBk6fbDwcKymHWHIkRBHHvdsGQka9ulMv+Ra
         NRBAUsXlyXurHz5cnM/DkFHh1zCJtAGp0RrbOWb0Bycb4OlddnlU3uzMhrqvKepI/k
         qddY1uENgMVdD0ey0T5qkGynB3uYUArbazG3DOiZ3c3gOh7IShBREPp2D1rjkr+nxi
         t87TtaHV6pQ/5uGIxeo0ZqH9sI68Ps9PEdx6cwJqRvStvf3vu1ckwsvqP4yEupJakU
         zA6yNkY7LyHsw==
Date:   Fri, 25 Aug 2023 13:55:04 +0100
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
Subject: Re: [PATCH -next 3/4] iio: adc: spear_adc: Use
 devm_clk_get_enabled() helper function
Message-ID: <20230825135504.17b4464e@jic23-huawei>
In-Reply-To: <20230825105746.2999548-4-ruanjinjie@huawei.com>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
        <20230825105746.2999548-4-ruanjinjie@huawei.com>
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

On Fri, 25 Aug 2023 18:57:45 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Also switch to devm_iio_device_register() and drop the remove function.

Jonathan

> ---
>  drivers/iio/adc/spear_adc.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index ad54ef798109..cd7708aa95af 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -297,36 +297,27 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	st->adc_base_spear3xx =
>  		(struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
>  
> -	st->clk = devm_clk_get(dev, NULL);
> +	st->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(st->clk)) {
> -		dev_err(dev, "failed getting clock\n");
> -		return PTR_ERR(st->clk);
> -	}
> -
> -	ret = clk_prepare_enable(st->clk);
> -	if (ret) {
>  		dev_err(dev, "failed enabling clock\n");
> -		return ret;
> +		return PTR_ERR(st->clk);
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		ret = irq;
> -		goto errout2;
> -	}
> +	if (irq < 0)
> +		return irq;
>  
>  	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
>  			       st);
>  	if (ret < 0) {
>  		dev_err(dev, "failed requesting interrupt\n");
> -		goto errout2;
> +		return ret;
>  	}
>  
>  	if (of_property_read_u32(np, "sampling-frequency",
>  				 &st->sampling_freq)) {
>  		dev_err(dev, "sampling-frequency missing in DT\n");
> -		ret = -EINVAL;
> -		goto errout2;
> +		return -EINVAL;
>  	}
>  
>  	/*
> @@ -355,24 +346,17 @@ static int spear_adc_probe(struct platform_device *pdev)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto errout2;
> +		return ret;
>  
>  	dev_info(dev, "SPEAR ADC driver loaded, IRQ %d\n", irq);
>  
>  	return 0;
> -
> -errout2:
> -	clk_disable_unprepare(st->clk);
> -	return ret;
>  }
>  
>  static int spear_adc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct spear_adc_state *st = iio_priv(indio_dev);
> -
>  	iio_device_unregister(indio_dev);
> -	clk_disable_unprepare(st->clk);
>  
>  	return 0;
>  }

