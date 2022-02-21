Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50E4BEB41
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 20:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiBUT34 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 14:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiBUT3z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 14:29:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E765FC
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 11:29:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A77360DB5
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 19:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4F9C340EC;
        Mon, 21 Feb 2022 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645471770;
        bh=nz94WHGQrxWaA9vGLIGBCV4VTUmErQLu3bVkm8u4YS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XwiF2DISuAD+zwcrlEGfYdfuHrjd46bQIfjjMP5w0s6b68Zuoyzrbi2PP14IR2JP1
         WjG2gL9Kk4qwvY6q2abUzjWMXP4EKdFkh8fEv7KuICTrQ3odRx3TJskRCw7oTy1Pbc
         RVKYRwq6Zcpm8K+u9GhuZQZQnHWfzL/XJp2ygm7/soPw9A6WLvOr0k4tfFPCGgiKT5
         7u8h1OGl3B+FQ9m1hUwqOB21auGuU/F8eCi0iBEnFBD1E/FxGn8qQ5mGcfskL0i9+o
         PZdHzM7uxp+0afic2ABlVFYbeWuJP9TcBcONWOIgf3zlNN5ypj9Fyoa2agFgnaz3Os
         TibqYaPLQrf2w==
Date:   Mon, 21 Feb 2022 19:36:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 43/50] iio:adc:ab8500: Switch from CONFIG_PM guards
 to pm_ptr() etc
Message-ID: <20220221193625.7bb5f8a9@jic23-huawei>
In-Reply-To: <20220130193147.279148-44-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
        <20220130193147.279148-44-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Sun, 30 Jan 2022 19:31:40 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> This case uses the new DEFINE_RUNTIME_DEV_PM_OPS() to reduce
> boilerplate.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/adc/ab8500-gpadc.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> index 4c46a201d4ef..78c2bd8bb91d 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -942,7 +942,6 @@ static const struct iio_info ab8500_gpadc_info = {
>  	.read_raw = ab8500_gpadc_read_raw,
>  };
>  
> -#ifdef CONFIG_PM
>  static int ab8500_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -965,7 +964,6 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
>  
>  	return ret;
>  }
> -#endif
>  
>  /**
>   * ab8500_gpadc_parse_channel() - process devicetree channel configuration
> @@ -1199,20 +1197,15 @@ static int ab8500_gpadc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops ab8500_gpadc_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> -	SET_RUNTIME_PM_OPS(ab8500_gpadc_runtime_suspend,
> -			   ab8500_gpadc_runtime_resume,
> -			   NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_runtime_suspend,
0-day actually managed to build this driver unlike my test setups.
Anyhow, I managed to lose the name of the dev_pm_ops structure.

I've fixed that up and tested by hacking out the dependencies in Kconfig.
At somepoint I'll check if we can actually add a COMPILE_TEST option
for this one or if there are some actual requirements that my really
quick test didn't pick up on.

Fresh testing branch pushed out.

> +				 ab8500_gpadc_runtime_resume, NULL);
>  
>  static struct platform_driver ab8500_gpadc_driver = {
>  	.probe = ab8500_gpadc_probe,
>  	.remove = ab8500_gpadc_remove,
>  	.driver = {
>  		.name = "ab8500-gpadc",
> -		.pm = &ab8500_gpadc_pm_ops,
> +		.pm = pm_ptr(&ab8500_gpadc_pm_ops),
>  	},
>  };
>  builtin_platform_driver(ab8500_gpadc_driver);

