Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6358C70C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiHHLA5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiHHLAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:00:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518F95F48
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 04:00:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i14so15887356ejg.6
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=sDgE00TSYImsrZ8eUvhvRLyRwa/CwuKhww/PvBiXyo0=;
        b=ezCd+qosLR/Jc6oUu5JRl2ht1Aj2dHh9IzM7OpMvphFEVNo0ModfeMaXR8Tnw2Zsqn
         nfq5CfL2u9nE0vpfXFUGVypqNLobO6oZzKO/V6UsBogadHCt4RbPi2s9HoHvDRofKjGo
         VRej3lM0t12sXhFYnqCbfiAQg2rO+BaxDhUix7yw5f0c459aiU7qov/SDMRY8kRu6pJK
         Jt30x8XZBYTp8vgHIK1BWiXJJ1gV7+cghF90t5kRvv8MK1PjT7EyaE3M3hlmdSWyEdWB
         6nMPPDcaCGUCD2On+We+mc91hUd1VMnhW9GHVzyQNss+x12DmnUPv+hhE7V2K+BXP+gY
         Np+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sDgE00TSYImsrZ8eUvhvRLyRwa/CwuKhww/PvBiXyo0=;
        b=leQCbUFplEY6vxLjOlygpe4ZTEp6EZwPbzLFsjKA8YZVEqQZhg+6xxbLw+jqFpRUFy
         hbyU/lnGXH2S5PcGQ6kMdWV4qAFg4xJuMeQd8FOEX9j3yc6SM9RaEtTc6YwbWDVHwPzj
         ibGIlwdjkC4hSAKFPpwdpiIPMZSWOC4Idc3nTXH5YnzqqMTyj+wVIeIVZveJFRaWATv0
         MrFYAuZffzZCJnO1XRCbrpIR3VI7Sbgniai2tWdsBCYyVazv0Aj3c9YChnW2mjRLnpac
         7617uYRvM1CLgvwWF713XTniBbiEQzqUTvHzhh1bb+G476txPW2llXZqEbdobNxU2wAj
         lvyQ==
X-Gm-Message-State: ACgBeo0roTrqyWRYSPNFG8IIyW7A+2AU9PZ4kI/Ta21gyg3mxuIdCALl
        B6yPw2VmyTgUnJcqy9ek3p96xA==
X-Google-Smtp-Source: AA6agR72d6ukddY5qJeAVt8KsDUBKUZegBbwzlVc/8G27Nj3mmNrQQImfvzoag/bC6kBlOUTsYNX5w==
X-Received: by 2002:a17:907:9712:b0:731:67db:1b48 with SMTP id jg18-20020a170907971200b0073167db1b48mr2120070ejc.754.1659956444802;
        Mon, 08 Aug 2022 04:00:44 -0700 (PDT)
Received: from arch-thunder (a109-49-33-111.cpe.netcabo.pt. [109.49.33.111])
        by smtp.gmail.com with ESMTPSA id d3-20020aa7ce03000000b0043e67f9028esm4415297edv.20.2022.08.08.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:00:44 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:00:42 +0100
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/5] iio: gyro: fxas210002c: Move exports to
 IIO_FXAS210002C namespace.
Message-ID: <20220808110042.wc6x6z4pmphha5in@arch-thunder>
References: <20220807192038.1039771-1-jic23@kernel.org>
 <20220807192038.1039771-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807192038.1039771-4-jic23@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Jonathan,
On Sun, Aug 07, 2022 at 08:20:36PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that
> brings by allowing the compiler to remove unused struct dev_pm_ops
> and callbacks without needing explicit __maybe_unused markings.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>

This looks a sane and good improvement, thanks.

Acked-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
     Rui

> ---
>  drivers/iio/gyro/fxas21002c_core.c | 21 +++++++++------------
>  drivers/iio/gyro/fxas21002c_i2c.c  |  3 ++-
>  drivers/iio/gyro/fxas21002c_spi.c  |  3 ++-
>  3 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index a36d71d9e3ea..9aee9096363f 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -998,7 +998,7 @@ int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(fxas21002c_core_probe);
> +EXPORT_SYMBOL_NS_GPL(fxas21002c_core_probe, IIO_FXAS21002C);
>  
>  void fxas21002c_core_remove(struct device *dev)
>  {
> @@ -1009,9 +1009,9 @@ void fxas21002c_core_remove(struct device *dev)
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
>  }
> -EXPORT_SYMBOL_GPL(fxas21002c_core_remove);
> +EXPORT_SYMBOL_NS_GPL(fxas21002c_core_remove, IIO_FXAS21002C);
>  
> -static int __maybe_unused fxas21002c_suspend(struct device *dev)
> +static int fxas21002c_suspend(struct device *dev)
>  {
>  	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
>  
> @@ -1021,7 +1021,7 @@ static int __maybe_unused fxas21002c_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused fxas21002c_resume(struct device *dev)
> +static int fxas21002c_resume(struct device *dev)
>  {
>  	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
>  	int ret;
> @@ -1033,26 +1033,23 @@ static int __maybe_unused fxas21002c_resume(struct device *dev)
>  	return fxas21002c_mode_set(data, data->prev_mode);
>  }
>  
> -static int __maybe_unused fxas21002c_runtime_suspend(struct device *dev)
> +static int fxas21002c_runtime_suspend(struct device *dev)
>  {
>  	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
>  
>  	return fxas21002c_mode_set(data, FXAS21002C_MODE_READY);
>  }
>  
> -static int __maybe_unused fxas21002c_runtime_resume(struct device *dev)
> +static int fxas21002c_runtime_resume(struct device *dev)
>  {
>  	struct fxas21002c_data *data = iio_priv(dev_get_drvdata(dev));
>  
>  	return fxas21002c_mode_set(data, FXAS21002C_MODE_ACTIVE);
>  }
>  
> -const struct dev_pm_ops fxas21002c_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(fxas21002c_suspend, fxas21002c_resume)
> -	SET_RUNTIME_PM_OPS(fxas21002c_runtime_suspend,
> -			   fxas21002c_runtime_resume, NULL)
> -};
> -EXPORT_SYMBOL_GPL(fxas21002c_pm_ops);
> +EXPORT_NS_GPL_DEV_PM_OPS(fxas21002c_pm_ops, fxas21002c_suspend,
> +			 fxas21002c_resume, fxas21002c_runtime_suspend,
> +			 fxas21002c_runtime_resume, NULL, IIO_FXAS21002C);
>  
>  MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
> index a7807fd97483..241401a9dfea 100644
> --- a/drivers/iio/gyro/fxas21002c_i2c.c
> +++ b/drivers/iio/gyro/fxas21002c_i2c.c
> @@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, fxas21002c_i2c_of_match);
>  static struct i2c_driver fxas21002c_i2c_driver = {
>  	.driver = {
>  		.name = "fxas21002c_i2c",
> -		.pm = &fxas21002c_pm_ops,
> +		.pm = pm_ptr(&fxas21002c_pm_ops),
>  		.of_match_table = fxas21002c_i2c_of_match,
>  	},
>  	.probe_new	= fxas21002c_i2c_probe,
> @@ -67,3 +67,4 @@ module_i2c_driver(fxas21002c_i2c_driver);
>  MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("FXAS21002C I2C Gyro driver");
> +MODULE_IMPORT_NS(IIO_FXAS21002C);
> diff --git a/drivers/iio/gyro/fxas21002c_spi.c b/drivers/iio/gyro/fxas21002c_spi.c
> index c3ac169facf9..4f633826547c 100644
> --- a/drivers/iio/gyro/fxas21002c_spi.c
> +++ b/drivers/iio/gyro/fxas21002c_spi.c
> @@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, fxas21002c_spi_of_match);
>  static struct spi_driver fxas21002c_spi_driver = {
>  	.driver = {
>  		.name = "fxas21002c_spi",
> -		.pm = &fxas21002c_pm_ops,
> +		.pm = pm_ptr(&fxas21002c_pm_ops),
>  		.of_match_table = fxas21002c_spi_of_match,
>  	},
>  	.probe		= fxas21002c_spi_probe,
> @@ -66,3 +66,4 @@ module_spi_driver(fxas21002c_spi_driver);
>  MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("FXAS21002C SPI Gyro driver");
> +MODULE_IMPORT_NS(IIO_FXAS21002C);
> -- 
> 2.37.1
> 
