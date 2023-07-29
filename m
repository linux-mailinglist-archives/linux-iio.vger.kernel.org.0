Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC44C768059
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jul 2023 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjG2PYc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Jul 2023 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjG2PYb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jul 2023 11:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718362D64
        for <linux-iio@vger.kernel.org>; Sat, 29 Jul 2023 08:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E51A60C6D
        for <linux-iio@vger.kernel.org>; Sat, 29 Jul 2023 15:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99A4C433C8;
        Sat, 29 Jul 2023 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690644269;
        bh=hKEFqZwbeqN1jWVTICiTdix0xi9S3l3WhmAf3G/bhw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DXIuVi0lnqRhkPrO7HEhjVV7w4vUZJUJc2bfqFd/hImxHTjYPoqL6ZhRDsO0FVgI8
         9iaMs3y/WORFZZxKljp0adeX46AXj5yvUIScZr6pJywg4SOMkCJFozW3LUFZZmeAlw
         JPxr2UKrs9GsBiOYM3mAB7UcD3zNzMMP9XkW3Vp35NJp5B2A2TcghasOKJI0Pd4aD3
         mX7OvMPijg+eDcH4VpLEpNvtq+9s6cnhAUDpMXuSHNeH6gFTEZZu0cIek3Ndm8siii
         GnupThh7jVwcm9/dcW5OonHR2sTsjuQYFClLjf1xWwL+ed1uuSCKHVdsZ1R4zeiPVA
         14zpMiOH4Vgxg==
Date:   Sat, 29 Jul 2023 16:24:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <vz@mleia.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <nuno.sa@analog.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH -next] iio: adc: fix the return value handle for
 platform_get_irq()
Message-ID: <20230729162430.4f858e08@jic23-huawei>
In-Reply-To: <20230727131607.2897937-1-ruanjinjie@huawei.com>
References: <20230727131607.2897937-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Jul 2023 21:16:07 +0800
Ruan Jinjie <ruanjinjie@huawei.com> wrote:

> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
>  drivers/iio/adc/lpc32xx_adc.c   | 4 ++--
>  drivers/iio/adc/npcm_adc.c      | 4 ++--
>  drivers/iio/adc/spear_adc.c     | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 44e1e53ada72..0d6885413a7e 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -540,8 +540,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	adc_priv->irqno = platform_get_irq(pdev, 0);
> -	if (adc_priv->irqno <= 0)
> -		return -ENODEV;
> +	if (adc_priv->irqno < 0)
> +		return adc_priv->irqno;
>  
>  	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
>  				IPROC_ADC_AUXIN_SCAN_ENA, 0);
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 732c924a976d..e34ed7dacd89 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -176,8 +176,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0)
> -		return -ENXIO;
> +	if (irq < 0)
> +		return irq;
>  
>  	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>  				  LPC32XXAD_NAME, st);
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index ba4cd8f49f66..3d9207c160eb 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -244,8 +244,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		ret = -EINVAL;
> +	if (irq < 0) {
> +		ret = irq;
>  		goto err_disable_clk;
>  	}
>  
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index d93e580b3dc5..ad54ef798109 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -310,8 +310,8 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		ret = -EINVAL;
> +	if (irq < 0) {
> +		ret = irq;
>  		goto errout2;
>  	}
>  

