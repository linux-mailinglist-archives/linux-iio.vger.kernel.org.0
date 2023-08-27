Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0CC78A06A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 19:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjH0REz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjH0RE3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 13:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199712D
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 10:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B6C622C0
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 17:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB693C433C7;
        Sun, 27 Aug 2023 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693155866;
        bh=6aXqca9aJ4SOiNqS7e42m4SxQgXNNrsBHkAKSCoOM3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gg6dc0aUjRGm0hGENBVNQ3XQJu2qTADqjEtmtHpoUJoO7PrmGwZhWVE5QaIV+Sjfu
         p0xnJuNJazau+JpRj5poHJVBN492ObPkmQ/D6foLyTEWRfkG1cds0V4pqHfzzuuOXu
         5X0GHUaptSVvdhiZsCs1tSakw8ri8dzLr9LeJANWpJsLkxT9I4EYE7ccv6a45q9fgZ
         9LL3Mrrpx8+jlQnxA200lVqE5BE1Uqw/SAGUIgkeX5XsvAhAj1PKV44PZhgokoYWu+
         ik+XGUf+507I1wCltENm+ekTRC1jgwDB4Tn4tVajkOtIfK2uQCgnQxNzrk7nUf/1/b
         1cxe9cKOH6dgA==
Date:   Sun, 27 Aug 2023 18:04:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH -next 2/2] iio: adc: mt6577_auxadc: Simplify with device
 managed function
Message-ID: <20230827180446.7b6720eb@jic23-huawei>
In-Reply-To: <20230826035402.3512033-3-ruanjinjie@huawei.com>
References: <20230826035402.3512033-1-ruanjinjie@huawei.com>
        <20230826035402.3512033-3-ruanjinjie@huawei.com>
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

On Sat, 26 Aug 2023 11:54:02 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Add a device managed hook, via devm_add_action_or_reset() and
> mt6577_power_off(), to power off on device detach.
> 
> Replace iio_device_register() by devm_iio_device_register() and remove
> the mt6577_auxadc_remove() function used to unregister the device and
> power off the device.
> 
> Remove platform_set_drvdata() from the probe function, since
> platform_get_drvdata() is not used anymore.
> 
> Remove mt6577_auxadc_mod_reg() call from the probe function error path.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/mt6577_auxadc.c | 40 +++++++++++++--------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 935cf560e238..c8f7bfa59146 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -246,6 +246,14 @@ static int mt6577_auxadc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> +static void mt6577_power_off(void *data)
> +{
> +	struct mt6577_auxadc_device *adc_dev = data;
> +
> +	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> +			      0, MT6577_AUXADC_PDN_EN);
> +}
> +
>  static int mt6577_auxadc_probe(struct platform_device *pdev)
>  {
>  	struct mt6577_auxadc_device *adc_dev;
> @@ -286,31 +294,14 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  			      MT6577_AUXADC_PDN_EN, 0);
>  	mdelay(MT6577_AUXADC_POWER_READY_MS);
>  
> -	platform_set_drvdata(pdev, indio_dev);
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to register iio device\n");
> -		goto err_power_off;
> -	}
> -
> -	return 0;
> +	ret = devm_add_action_or_reset(&pdev->dev, mt6577_power_off, adc_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to add action to managed power off: %d\n", ret);
The return code is already printed when dev_err_probe() formats the line, so I've
dropped that last bit whilst applying.

The way these two patches were separated is a little odd as you ignore
a few dev_err() cases in patch 1 because they don't make sense until patch 2.
I think this would have made more sense with the two patches reversed.

Still that's a very small thing (and I might be wrong as I didn't try it ;)
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
etc to play with this.  I'll be rebasing on rc1 and it won't hit linux-next
until after that.

Thanks,

Jonathan

>  
> -err_power_off:
> -	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> -			      0, MT6577_AUXADC_PDN_EN);
> -	return ret;
> -}
> -
> -static int mt6577_auxadc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> -			      0, MT6577_AUXADC_PDN_EN);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register iio device\n");
>  
>  	return 0;
>  }
> @@ -337,7 +328,6 @@ static struct platform_driver mt6577_auxadc_driver = {
>  		.pm = pm_sleep_ptr(&mt6577_auxadc_pm_ops),
>  	},
>  	.probe	= mt6577_auxadc_probe,
> -	.remove	= mt6577_auxadc_remove,
>  };
>  module_platform_driver(mt6577_auxadc_driver);
>  

