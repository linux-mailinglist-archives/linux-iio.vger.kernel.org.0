Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED87BFE5B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Oct 2023 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJJNsc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Oct 2023 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjJJNsb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 09:48:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B06DFB;
        Tue, 10 Oct 2023 06:48:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06288C433C7;
        Tue, 10 Oct 2023 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696945710;
        bh=j/rOh1p2lFzKctXSKqmI3CUT75jOUZE9xdZFghyAX5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YRglmqNZ8tw+mqI4v9HiNLZPBZmjxqNz6BH8FEePeu3SfZEk+vCfoU7MNWmoOaJd+
         YFxE4bc1L6ByAD5d8mVls981NLYN4OAKkGOAqpiiPsSzsxRu0QQocT/+sPLZyP521B
         pwAV1EoV6L/HGf5LtuY7aRPug79IXc3Ff+qhr8D95U+9H2rO/Lxg2LxA7Wu9Di1TvL
         HQjRnaWHFCqWakyBUezDB5DAOjp36BeBEWpd6GbAjXabvHij9O59xnxbK5w1+lMTkS
         e4JKYsva6SIXdS3bj7iW5ysW147PinVC5HL4lDOEsVLwxxW1vgpPc9bw8ZBACzd+Qe
         RgmnRUliwd0Tw==
Date:   Tue, 10 Oct 2023 14:48:39 +0100
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
Message-ID: <20231010144839.11f7c977@jic23-huawei>
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
Seems reasonable to me but I'll leave on list a few days for other people
to take a look.

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

