Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA517C9571
	for <lists+linux-iio@lfdr.de>; Sat, 14 Oct 2023 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjJNQrz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Oct 2023 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjJNQrx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Oct 2023 12:47:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB9B7;
        Sat, 14 Oct 2023 09:47:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839A1C433C7;
        Sat, 14 Oct 2023 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697302071;
        bh=p0QZPd55n1b0eM1vkHrUjjg0PeS6F3StvKDBfTZlgUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p/ElRRcbgr63Bpjq2zpqJ5ENJ8Kj2DkjogYdFJhaK22B2uRSvr4x9rZ9FBKC9zlUF
         hggpLv2w9VB3DCzyyKMwqVDRU+Bs3zDkkxoEQK/F79wKMODMB8+88NKdY7tV+97CHc
         bXbZQZLdA2x2Mz230b4biLhifdt9U59YM2KDEgLnjS1tGc05IxJDztt62V7XRJG+Xn
         uXW3IPbeDBinfeyNb2GHNbuVkPQYZ1sATPMdMn7QJ+nF/qQC9ZfvglpM+dxS/mj32W
         zzqbDNOHftZAJ8foBy8sy50tdxMDwKDriV9jbB3H1Z3fLmteL5x/3TTVpeg5Ipn/20
         IorFhNNWy1QMA==
Date:   Sat, 14 Oct 2023 17:48:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] iio: exynos-adc: request second interupt only when
 touchscreen mode is used
Message-ID: <20231014174807.353de76f@jic23-huawei>
In-Reply-To: <20231009101412.916922-1-m.szyprowski@samsung.com>
References: <CGME20231009101422eucas1p2c004097457990bbaf9b3cc5df9e246fd@eucas1p2.samsung.com>
        <20231009101412.916922-1-m.szyprowski@samsung.com>
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

On Mon,  9 Oct 2023 12:14:12 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Second interrupt is needed only when touchscreen mode is used, so don't
> request it unconditionally. This removes the following annoying warning
> during boot:
> 
> exynos-adc 14d10000.adc: error -ENXIO: IRQ index 1 not found
> 
> Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Timing wise, this might just end up going in during the merge window now.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/exynos_adc.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index eb7a2dd59517..614de9644800 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -826,16 +826,26 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/* leave out any TS related code if unreachable */
> +	if (IS_REACHABLE(CONFIG_INPUT)) {
> +		has_ts = of_property_read_bool(pdev->dev.of_node,
> +					       "has-touchscreen") || pdata;
> +	}
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
>  	info->irq = irq;
>  
> -	irq = platform_get_irq(pdev, 1);
> -	if (irq == -EPROBE_DEFER)
> -		return irq;
> +	if (has_ts) {
> +		irq = platform_get_irq(pdev, 1);
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
>  
> -	info->tsirq = irq;
> +		info->tsirq = irq;
> +	} else {
> +		info->tsirq = -1;
> +	}
>  
>  	info->dev = &pdev->dev;
>  
> @@ -900,12 +910,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	if (info->data->init_hw)
>  		info->data->init_hw(info);
>  
> -	/* leave out any TS related code if unreachable */
> -	if (IS_REACHABLE(CONFIG_INPUT)) {
> -		has_ts = of_property_read_bool(pdev->dev.of_node,
> -					       "has-touchscreen") || pdata;
> -	}
> -
>  	if (pdata)
>  		info->delay = pdata->delay;
>  	else

