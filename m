Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62E7674F6
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jul 2023 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjG1SY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jul 2023 14:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjG1SY2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jul 2023 14:24:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD404491
        for <linux-iio@vger.kernel.org>; Fri, 28 Jul 2023 11:24:10 -0700 (PDT)
Received: from [185.230.175.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qPS7F-0000Zp-K4; Fri, 28 Jul 2023 20:23:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de,
        haibo.chen@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ktsai@capellamicro.com, risca@dalakolonin.se,
        christophe.jaillet@wanadoo.fr, dan.carpenter@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     ruanjinjie@huawei.com
Subject: Re: [PATCH -next] iio: adc: Remove redundant dev_err_probe()
Date:   Fri, 28 Jul 2023 20:23:04 +0200
Message-ID: <115418516.nniJfEyVGO@phil>
In-Reply-To: <20230727073912.4178659-1-ruanjinjie@huawei.com>
References: <20230727073912.4178659-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Donnerstag, 27. Juli 2023, 09:39:12 CEST schrieb Ruan Jinjie:
> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from either the platform_get_irq() or
> platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---

>  drivers/iio/adc/rockchip_saradc.c | 2 +-

For Rockchip:
Acked-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 4b011f7eddec..8270652244c2 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -467,7 +467,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> -		return dev_err_probe(&pdev->dev, irq, "failed to get irq\n");
> +		return irq;
>  
>  	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
>  			       0, dev_name(&pdev->dev), info);




