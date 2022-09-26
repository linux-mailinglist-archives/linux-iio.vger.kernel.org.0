Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259335EA8F3
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiIZOtN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiIZOsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 10:48:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A523868F
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 06:14:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n15so10183064wrq.5
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zmOMLIf0qNCKKLpY8/rkDv2C4P471zhSLenSkDiqEtM=;
        b=fYDKQ3atGXLHr/X0hT1fw4O2qHpVZZ67+xMvqMbyXJYkgtVARlzLocoOfHAyelD/1t
         ojTVXJ5A82LFud4h4y1C9vnNGeBglT3wZFxevLgHeC5A/+6nY/Dwn4W++9XZp/I9Gnlf
         gKQgd4GsZQ3I9Pem0Yztyz1tIvq67KayXfuTPnQJPOOXkgQO41tCZbovtxM9dLyOiC4p
         ucuwcYhPwq3GdlECggIgkUcaLOToiJHn8XBLLqizYsIzo2mXzGvNLo2sOdcFBVn6rT6K
         CrB1mpw55JYnLawfatmxv/0Lk6+YetvJkvNhQP+JMmAqW4IV00wRuMoI421DyujgsEV2
         okKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zmOMLIf0qNCKKLpY8/rkDv2C4P471zhSLenSkDiqEtM=;
        b=D7RSgBE1QGmWTyiqRiaaoBwuxC8wPN5FtIwzEkhYS4WKUccRUIGcDlIHWXjmYT+ZHY
         FjGOAHgBBMvUBTcnXuNo4DYCgDJLtUhy/OgHJS1GRcmKCTcNzRXOQPNpM43EXdZ5EnTk
         /cZ9852uPdUmG2ui1O5mShz5lFdsg7xdWF+4tGQgz5rVC6RxNx+JJqdmeaUxzMgojbp9
         o5gB2kqPb8vXZLC+0jkcYw80oN15IiACAUxFbUViQHrb6ODkMCQ0ftBag/ULlWdwy5jM
         dZoCKzPPwny5mHGFTawDEi/YADttUtWeQgLBs2f62ht50pyfrgyxhhzLg2amYYL9LJXj
         1I4w==
X-Gm-Message-State: ACrzQf0tx68Ve1YbC7x5xvrWTF2EvrGLC7wJGIlpQAuy9Ta7Jn+j1y3i
        RDEi3tRmtCB45AsVP0YYxCOZoQ==
X-Google-Smtp-Source: AMsMyM5Q53D78AC+gd83km9UrUJfNr7A+4TPr9Of2Die3OZ8VL4eGG+Em24hbhJSb99xelsutjGepQ==
X-Received: by 2002:adf:fac9:0:b0:228:652b:a33e with SMTP id a9-20020adffac9000000b00228652ba33emr13323868wrs.61.1664198089457;
        Mon, 26 Sep 2022 06:14:49 -0700 (PDT)
Received: from arch-thunder (a109-49-33-111.cpe.netcabo.pt. [109.49.33.111])
        by smtp.gmail.com with ESMTPSA id u9-20020a056000038900b002252884cc91sm14330030wrf.43.2022.09.26.06.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:14:49 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:14:46 +0100
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/5] iio: gyro: fxas210002c: Move exports to
 IIO_FXAS210002C namespace.
Message-ID: <20220926131446.wcvaabsks533jw7z@arch-thunder>
References: <20220925155719.3316280-1-jic23@kernel.org>
 <20220925155719.3316280-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925155719.3316280-4-jic23@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Jonathan,
On Sun, Sep 25, 2022 at 04:57:17PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that
> brings by allowing the compiler to remove unused struct dev_pm_ops
> and callbacks without needing explicit __maybe_unused markings.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Again, many thanks for making this changes.
LGTM.

Acked-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
  Rui

> 
> --
> v2: Switch to Paul's more flexible approach to EXPORT_NS_GPL_DEV_PM_OPS()
> Dropped Rui's tag on basis this is rather different from v1 due to
> the different macro implementation.
> ---
>  drivers/iio/gyro/fxas21002c_core.c | 21 ++++++++++-----------
>  drivers/iio/gyro/fxas21002c_i2c.c  |  3 ++-
>  drivers/iio/gyro/fxas21002c_spi.c  |  3 ++-
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index a36d71d9e3ea..3ea1d4613080 100644
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
> @@ -1033,26 +1033,25 @@ static int __maybe_unused fxas21002c_resume(struct device *dev)
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
> +EXPORT_NS_GPL_DEV_PM_OPS(fxas21002c_pm_ops, IIO_FXAS21002C) = {
> +	SYSTEM_SLEEP_PM_OPS(fxas21002c_suspend, fxas21002c_resume)
> +	RUNTIME_PM_OPS(fxas21002c_runtime_suspend, fxas21002c_runtime_resume,
> +		       NULL)
>  };
> -EXPORT_SYMBOL_GPL(fxas21002c_pm_ops);
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
> 2.37.2
> 
