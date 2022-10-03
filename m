Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8515F2E81
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJCJvf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJCJvM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 05:51:12 -0400
X-Greylist: delayed 371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 02:50:28 PDT
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1E9FF9
        for <linux-iio@vger.kernel.org>; Mon,  3 Oct 2022 02:50:28 -0700 (PDT)
Received: from Seans-MBP.hadsten (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id EDEF764118E;
        Mon,  3 Oct 2022 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1664790254; bh=EG9RqZ0GL+qbaW5KZAjqGQQsDq+PqAhKsPtpohP9eCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ICnPjVQIc2V1pv/Dl1rJAIbGpH7wtxCNFfS233ACB+gT1wj6JdFKf+zNDL29bNR6P
         9VB+6MFkr2BE5OglOkQ2La6UdJQU+OF+io60zpg2E0jGldvB/919vxUeXdulMTwgrl
         BOCb/+urRtKg8qVB1qnMUn53vbTWwNR6KK+UrPVKvQoPU3hluEtuWfqdIlk9L/nUK2
         S7muqjxeSdl/QCew7Pq4t9iLa4rABZFp2x/L92+igV/2hjH7j5Bc0MfdYHW7/rjgFi
         PQ1TFOGekgGYfJD9k+xtbVUXpKgU+VzMfjWLNGvC114HSHufZpXkvPpIu8OmtHlI2C
         YKaAnDQZ6Tuog==
Date:   Mon, 3 Oct 2022 11:44:13 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/5] iio: accel: fxls8962af: Use new
 EXPORT_NS_GPL_DEV_PM_OPS()
Message-ID: <20221003094413.ficelvch64vln5bw@Seans-MBP.hadsten>
References: <20220925155719.3316280-1-jic23@kernel.org>
 <20220925155719.3316280-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220925155719.3316280-3-jic23@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 25, 2022 at 04:57:16PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using this macro allows the compiler to remove unused
> structures and callbacks if we are not building with
> CONFIG_PM* without needing __maybe_unused markings.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>
> 

Acked-by: Sean Nyekjaer <sean@geanix.com>

> --
> Switched to Paul Cercueil's more flexible implementation fo the macro.
> Dropped Sean's Ack given new form of macro being used.

Re-added my Ack :)

> ---
>  drivers/iio/accel/fxls8962af-core.c | 16 +++++++---------
>  drivers/iio/accel/fxls8962af-i2c.c  |  2 +-
>  drivers/iio/accel/fxls8962af-spi.c  |  2 +-
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 8874d6d61725..bf259db281f5 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -1241,7 +1241,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  }
>  EXPORT_SYMBOL_NS_GPL(fxls8962af_core_probe, IIO_FXLS8962AF);
>  
> -static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
> +static int fxls8962af_runtime_suspend(struct device *dev)
>  {
>  	struct fxls8962af_data *data = iio_priv(dev_get_drvdata(dev));
>  	int ret;
> @@ -1255,14 +1255,14 @@ static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
> +static int fxls8962af_runtime_resume(struct device *dev)
>  {
>  	struct fxls8962af_data *data = iio_priv(dev_get_drvdata(dev));
>  
>  	return fxls8962af_active(data);
>  }
>  
> -static int __maybe_unused fxls8962af_suspend(struct device *dev)
> +static int fxls8962af_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct fxls8962af_data *data = iio_priv(indio_dev);
> @@ -1283,7 +1283,7 @@ static int __maybe_unused fxls8962af_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused fxls8962af_resume(struct device *dev)
> +static int fxls8962af_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct fxls8962af_data *data = iio_priv(indio_dev);
> @@ -1300,12 +1300,10 @@ static int __maybe_unused fxls8962af_resume(struct device *dev)
>  	return 0;
>  }
>  
> -const struct dev_pm_ops fxls8962af_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
> -	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
> -			   fxls8962af_runtime_resume, NULL)
> +EXPORT_NS_GPL_DEV_PM_OPS(fxls8962af_pm_ops, IIO_FXLS8962AF) = {
> +	SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
> +	RUNTIME_PM_OPS(fxls8962af_runtime_suspend, fxls8962af_runtime_resume, NULL)
>  };
> -EXPORT_SYMBOL_NS_GPL(fxls8962af_pm_ops, IIO_FXLS8962AF);
>  
>  MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
>  MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index 8fbadfea1620..22640eaebac7 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -45,7 +45,7 @@ static struct i2c_driver fxls8962af_driver = {
>  	.driver = {
>  		   .name = "fxls8962af_i2c",
>  		   .of_match_table = fxls8962af_of_match,
> -		   .pm = &fxls8962af_pm_ops,
> +		   .pm = pm_ptr(&fxls8962af_pm_ops),
>  		   },
>  	.probe_new = fxls8962af_probe,
>  	.id_table = fxls8962af_id,
> diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
> index 885b3ab7fcb5..a0d192211839 100644
> --- a/drivers/iio/accel/fxls8962af-spi.c
> +++ b/drivers/iio/accel/fxls8962af-spi.c
> @@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(spi, fxls8962af_spi_id_table);
>  static struct spi_driver fxls8962af_driver = {
>  	.driver = {
>  		   .name = "fxls8962af_spi",
> -		   .pm = &fxls8962af_pm_ops,
> +		   .pm = pm_ptr(&fxls8962af_pm_ops),
>  		   .of_match_table = fxls8962af_spi_of_match,
>  		   },
>  	.probe = fxls8962af_probe,
> -- 
> 2.37.2
> 

-- 
Best regards
Sean Nyekjær
Embedded Linux Consultant

+45 42427326
sean@geanix.com

Geanix ApS
https://geanix.com
DK39600706
