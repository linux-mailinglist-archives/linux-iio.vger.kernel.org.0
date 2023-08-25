Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE587887D6
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbjHYMyB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244920AbjHYMxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 08:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976D1BE2
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 05:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66E462AEF
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 12:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5652C433C9;
        Fri, 25 Aug 2023 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692968027;
        bh=/r5CsgRS5UvoczCwjOl/UTZs70OHQ7YG+g3IOurPEAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DZlI7RhXA6MKcsl6KVJFEXUWkXZLwLvdMtKDCIqg88k3SY9K3LhJSv6m/WjbWZ/zn
         JXYj8+S8fBFWNNW25qHj9XU3ew7T/BONHe51gSpnzm2JAc4X/pNcQ7dTHtigOTMJ6f
         4InYKWcbkxIh7W1FI5eBMEbPrQIkXKBUFyiMHsW96JG8P2t6uxhg8SULFbwm1AxziT
         t5/6NRVaSo+I4iSgHCwWrnAO6Cc7yvfNFQQmQEr3p5HmC9qUVE8JbRN/vRqnX1tOkS
         xLVjkoH2gZZ2OIbTMelm01rSeZBocambJGx+YbNSHi5lZOZ8Dr4GaEebcOxqRKdxTI
         FsSHi4iuVO97w==
Date:   Fri, 25 Aug 2023 13:54:02 +0100
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
Subject: Re: [PATCH -next 2/4] iio: adc: mt6577_auxadc: Use
 devm_clk_get_enabled() helper function
Message-ID: <20230825135402.5eef68f6@jic23-huawei>
In-Reply-To: <20230825105746.2999548-3-ruanjinjie@huawei.com>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
        <20230825105746.2999548-3-ruanjinjie@huawei.com>
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

On Fri, 25 Aug 2023 18:57:44 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Applied.  This is another case that would benefit from use of dev_err_probe()
for all error messages in the probe routine.  Should also be easy to convert
to fully devm managed with one devm_add_action_or_reset() and appropriate
callback.

Jonathan

> ---
>  drivers/iio/adc/mt6577_auxadc.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 0e134777bdd2..ea42fd7a8c99 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -270,23 +270,16 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  		return PTR_ERR(adc_dev->reg_base);
>  	}
>  
> -	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
> +	adc_dev->adc_clk = devm_clk_get_enabled(&pdev->dev, "main");
>  	if (IS_ERR(adc_dev->adc_clk)) {
> -		dev_err(&pdev->dev, "failed to get auxadc clock\n");
> -		return PTR_ERR(adc_dev->adc_clk);
> -	}
> -
> -	ret = clk_prepare_enable(adc_dev->adc_clk);
> -	if (ret) {
>  		dev_err(&pdev->dev, "failed to enable auxadc clock\n");
> -		return ret;
> +		return PTR_ERR(adc_dev->adc_clk);
>  	}
>  
>  	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
>  	if (!adc_clk_rate) {
> -		ret = -EINVAL;
>  		dev_err(&pdev->dev, "null clock rate\n");
> -		goto err_disable_clk;
> +		return -EINVAL;
>  	}
>  
>  	adc_dev->dev_comp = device_get_match_data(&pdev->dev);
> @@ -310,8 +303,6 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  err_power_off:
>  	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>  			      0, MT6577_AUXADC_PDN_EN);
> -err_disable_clk:
> -	clk_disable_unprepare(adc_dev->adc_clk);
>  	return ret;
>  }
>  
> @@ -325,8 +316,6 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
>  	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
>  			      0, MT6577_AUXADC_PDN_EN);
>  
> -	clk_disable_unprepare(adc_dev->adc_clk);
> -
>  	return 0;
>  }
>  

