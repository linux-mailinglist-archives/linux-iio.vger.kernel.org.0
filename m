Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB52567FA19
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jan 2023 18:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjA1Rw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Jan 2023 12:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjA1Rw1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2023 12:52:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D80222E2
        for <linux-iio@vger.kernel.org>; Sat, 28 Jan 2023 09:52:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C453860BAA
        for <linux-iio@vger.kernel.org>; Sat, 28 Jan 2023 17:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DC0C433D2;
        Sat, 28 Jan 2023 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674928345;
        bh=LiPRNvuM6nGQoIDW0hw2/t2ZPb2a7HZ80AkyWeeDmJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YzlqCiFBPgXfW973Aye+r/GeVC/HZx/AdZtVf6lSN0GjyebnJ77JlSLsmXMPFu4AM
         mnU30XzpP8Ua24DBHjBL/xRz2lETYLDIhUID5xi4CIYOdbLlBD6CdRiibR0qfz0kNj
         HBSBFtnW5iA9ptnmtNr85kUHa3M/Mc4qJzxI2Q5bFH6ztj7xJnlMHdjvTpkk3+to32
         YuywJsVEFarHltxzc8LW5vjEFgoE0Nhbqi43iNYg3f13NgEXZalRnEVUhYz2lM/+LB
         03jxgckQFLzy1SeIlTy636LchcUiZJGVMBSZ6uvmJs1Mr7qVKgkPAyofHkMifxiZSN
         T36MQr5yqwrdQ==
Date:   Sat, 28 Jan 2023 18:06:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l: Use RUNTIME_PM_OPS() instead of SET_*
Message-ID: <20230128180618.727ae295@jic23-huawei>
In-Reply-To: <20220807190712.1039403-1-jic23@kernel.org>
References: <20220807190712.1039403-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Aug 2022 20:07:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Here we could use DEFINE_RUNTIME_DEV_PM_OPS() but that would have the
> side effect of providing suspend and resume support.  That would be
> harmless but also of little purpose as this driver does very simplistic
> power management with synchronous power up and down around individual
> channel reads.
> 
> In general these new PM macros avoid the need to mark functions
> __maybe_unused, whilst still allowing the compiler to remove them
> if they are unused.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>

+CC Prabhakar on basis of recent DT binding patch might have hardware
 to test changing this to DEFINE_RUNTIME_DEV_PM_OPS.

If not I'm tempted to just pick this one up on basis it does
no harm and we can revisit later.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rzg2l_adc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 0921ff2d9b3a..b859a2db6b13 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -547,7 +547,7 @@ static const struct of_device_id rzg2l_adc_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
>  
> -static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
> +static int rzg2l_adc_pm_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct rzg2l_adc *adc = iio_priv(indio_dev);
> @@ -559,7 +559,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
> +static int rzg2l_adc_pm_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct rzg2l_adc *adc = iio_priv(indio_dev);
> @@ -581,9 +581,9 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> -	SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> -			   rzg2l_adc_pm_runtime_resume,
> -			   NULL)
> +	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> +		       rzg2l_adc_pm_runtime_resume,
> +		       NULL)
>  };
>  
>  static struct platform_driver rzg2l_adc_driver = {
> @@ -591,7 +591,7 @@ static struct platform_driver rzg2l_adc_driver = {
>  	.driver		= {
>  		.name		= DRIVER_NAME,
>  		.of_match_table = rzg2l_adc_match,
> -		.pm		= &rzg2l_adc_pm_ops,
> +		.pm		= pm_ptr(&rzg2l_adc_pm_ops),
>  	},
>  };
>  

