Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE28278A051
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 18:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjH0Q6m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjH0Q6Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 12:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB306106
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 09:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1336109A
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 16:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9D1C433C8;
        Sun, 27 Aug 2023 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693155502;
        bh=Z+cE7+gAHqJGe8NItGJLieEqxdYjp2p6vkeJ3RZJRes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q3zj6k8XagjHSzGDWtjzzcOav/qWyeTZki7s0WUUy4KDb8sS3jJSYEGDT9HBT0hFr
         tYQYv0nfGarbkFXG7rm0O4ICZM73oFZ+ojYX3lOoycdOI6efihNrAotVMU7LtmtDqA
         xDaLAjF16SECwvog4iu3PYnc3iQf/4WiXnOa/3O+mJjAGZ/k2s4TYb9tWzDsk3Vz8U
         bGPmyWToJdQB2JCjdmxeoqQe/R9cgEtqTS1+HMQL/ty/YzviQXqeIdeQskA+Gnoymy
         HT60216NGsZV+j2n3YJu7+iyZxloiOR/YA2ZL9qsv77DoEUSjd4ZWJba7M28+1cNge
         bkqcsrh15VeiQ==
Date:   Sun, 27 Aug 2023 17:58:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next v2 2/2] iio: adc: spear_adc: Use dev_err_probe()
Message-ID: <20230827175843.6e74d7cc@jic23-huawei>
In-Reply-To: <20230826062733.3714169-3-ruanjinjie@huawei.com>
References: <20230826062733.3714169-1-ruanjinjie@huawei.com>
        <20230826062733.3714169-3-ruanjinjie@huawei.com>
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

On Sat, 26 Aug 2023 14:27:32 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless error
> is printed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/iio/adc/spear_adc.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index d24adacfdf53..0ccda1cd0add 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -274,10 +274,8 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	int irq;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
> -	if (!indio_dev) {
> -		dev_err(dev, "failed allocating iio device\n");
> -		return -ENOMEM;
> -	}
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM, "failed allocating iio device\n");

Whilst 100 chars tends to be allowed if it helps readability, in cases
like this one, where it makes very little difference to how easy the code is
to read, keep to max 80 chars.

I've added some line breaks whilst applying.

Series applied to the togreg branch of iio.git and pushed out as testing.
I'll be rebasing on rc1 once available so I won't push this out for linux-next
to pick up until I've done that in a few weeks time.

Nice cleanup.

Thanks,

Jonathan

>  
>  	st = iio_priv(indio_dev);
>  
> @@ -298,10 +296,8 @@ static int spear_adc_probe(struct platform_device *pdev)
>  		(struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
>  
>  	st->clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(st->clk)) {
> -		dev_err(dev, "failed enabling clock\n");
> -		return PTR_ERR(st->clk);
> -	}
> +	if (IS_ERR(st->clk))
> +		return dev_err_probe(dev, PTR_ERR(st->clk), "failed enabling clock\n");
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -309,16 +305,12 @@ static int spear_adc_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
>  			       st);
> -	if (ret < 0) {
> -		dev_err(dev, "failed requesting interrupt\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed requesting interrupt\n");
>  
>  	if (of_property_read_u32(np, "sampling-frequency",
> -				 &st->sampling_freq)) {
> -		dev_err(dev, "sampling-frequency missing in DT\n");
> -		return -EINVAL;
> -	}
> +				 &st->sampling_freq))
> +		return dev_err_probe(dev, -EINVAL, "sampling-frequency missing in DT\n");
>  
>  	/*
>  	 * Optional avg_samples defaults to 0, resulting in single data

