Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A07887F6
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbjHYM6R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245002AbjHYM5x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 08:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3A22139
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 05:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16DAE61AF0
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 12:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB3C433C8;
        Fri, 25 Aug 2023 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692968242;
        bh=oK+UJY0bkF8Ywx3I5L1JxmoE98xeSKEIW/uQI5EQvXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VAb/zMY57q/KcVtBg1bQpEutdDpiY5joNNw1Q8ZIMbSi4L1LoYPFifzUfyQpIsKE/
         x8ms+6osxL3VbzupfAc8w1/SLSEUc+wdlcs4XOvoviRo59A/V2tx0YOKaJKfkhIyV1
         vfS5XsP+X3iFp/3sQfXq2HcGcdbaDHw/8ZFkYEzwQ3hVSV0mTMhlh62nOZT3cYAlex
         Es4URJ40lO7+mTLGthpB/jZwFIiqw5xLMRn3LNVmLDN3zHSasw0XhGD+NWSw2vnHsD
         r4QJc/ts1mnLDsVMSVmFjrU7B3iW/EcfZwo6D7Q8sgKGiMvZ/1odkYjRTOfzmPRERV
         EyBGbfaHNI/TA==
Date:   Fri, 25 Aug 2023 13:57:40 +0100
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
Subject: Re: [PATCH -next 4/4] iio: frequency: adf4350: Use
 devm_clk_get_enabled() helper function
Message-ID: <20230825135740.50c9643a@jic23-huawei>
In-Reply-To: <20230825105746.2999548-5-ruanjinjie@huawei.com>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
        <20230825105746.2999548-5-ruanjinjie@huawei.com>
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

On Fri, 25 Aug 2023 18:57:46 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

I'm fairly sure st->reg is never used except for disable. As such you can finish
the job here by moving to equivalent devm_regulator enabled call and devm_iio_device_register()
That should avoid any potential ordering issues which are a bit un obvious with just
this patch

Jonathan

> ---
>  drivers/iio/frequency/adf4350.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 85e289700c3c..22330d1768ff 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -491,20 +491,14 @@ static int adf4350_probe(struct spi_device *spi)
>  	}
>  
>  	if (!pdata->clkin) {
> -		clk = devm_clk_get(&spi->dev, "clkin");
> +		clk = devm_clk_get_enabled(&spi->dev, "clkin");
>  		if (IS_ERR(clk))
> -			return -EPROBE_DEFER;
> -
> -		ret = clk_prepare_enable(clk);
> -		if (ret < 0)
> -			return ret;
> +			return PTR_ERR(clk);
>  	}
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret =  -ENOMEM;
> -		goto error_disable_clk;
> -	}
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> @@ -512,7 +506,7 @@ static int adf4350_probe(struct spi_device *spi)
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> -			goto error_disable_clk;
> +			return ret;
>  	}
>  
>  	spi_set_drvdata(spi, indio_dev);
> @@ -564,8 +558,6 @@ static int adf4350_probe(struct spi_device *spi)
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -error_disable_clk:
> -	clk_disable_unprepare(clk);
>  
>  	return ret;
>  }
> @@ -581,8 +573,6 @@ static void adf4350_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	clk_disable_unprepare(st->clk);
> -
>  	if (!IS_ERR(reg))
>  		regulator_disable(reg);
>  }

