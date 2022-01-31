Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9554A51F6
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 23:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiAaWBN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jan 2022 17:01:13 -0500
Received: from first.geanix.com ([116.203.34.67]:37722 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbiAaWBM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Jan 2022 17:01:12 -0500
Received: from skn-laptop.hadsten (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id CBDDB126AF4;
        Mon, 31 Jan 2022 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1643666467; bh=5bUEg2lZMkj8cs0P5gvDLxG26wY7RiU4FDG8Te9ym9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=amgwsQw52yCzyBaV+0gY1ll4gnlVkEtOYB4mvJpKGri6gEB8bqwUxPcLcxXrk1vgM
         rB5PtRWZl13RFWLzzIzCqOsOVYKCSpTiRflDGmaoQ2FiY1FenzL9dZJX1mOkReBmcB
         VUPeDAGx28T7+IGtZQFSyveRp+keoNN/Nch8hc3K+yRJh3HgQkURb/NWpS/52+X4tO
         55ww647nOF2JTbpLVj9h6AWCKbXJj8YgYEalmwWtLukECHP+GCkNhNvMPBQLMflLtE
         u0lE9yT5JR2P0/e4exTUuik8gSWAneuHfP/6/vazEYDqqINCDTFktk2TL2dEmF7HfJ
         iO39UfURLouow==
Date:   Mon, 31 Jan 2022 23:01:05 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/13] iio:accel:fxl8962af: Move exports into
 IIO_FXL8962AF namespace
Message-ID: <20220131220105.l4dodcx2e53anvah@skn-laptop.hadsten>
References: <20220116180535.2367780-1-jic23@kernel.org>
 <20220116180535.2367780-12-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220116180535.2367780-12-jic23@kernel.org>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 16, 2022 at 06:05:33PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> To avoid unnecessary pollution of the global symbol namespace move the
> driver core exports into their own namespace and import that into the two
> bus modules.
> 
> For more info see https://lwn.net/Articles/760045/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>

Looks good :)

Reviewed-by: Sean Nyekjaer <sean@geanix.com>

> ---
>  drivers/iio/accel/fxls8962af-core.c | 6 +++---
>  drivers/iio/accel/fxls8962af-i2c.c  | 1 +
>  drivers/iio/accel/fxls8962af-spi.c  | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 32989d91b982..8e763dbf096b 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -178,7 +178,7 @@ const struct regmap_config fxls8962af_regmap_conf = {
>  	.val_bits = 8,
>  	.max_register = FXLS8962AF_MAX_REG,
>  };
> -EXPORT_SYMBOL_GPL(fxls8962af_regmap_conf);
> +EXPORT_SYMBOL_NS_GPL(fxls8962af_regmap_conf, IIO_FXLS8962AF);
>  
>  enum {
>  	fxls8962af_idx_x,
> @@ -1232,7 +1232,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> -EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
> +EXPORT_SYMBOL_NS_GPL(fxls8962af_core_probe, IIO_FXLS8962AF);
>  
>  static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
>  {
> @@ -1298,7 +1298,7 @@ const struct dev_pm_ops fxls8962af_pm_ops = {
>  	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
>  			   fxls8962af_runtime_resume, NULL)
>  };
> -EXPORT_SYMBOL_GPL(fxls8962af_pm_ops);
> +EXPORT_SYMBOL_NS_GPL(fxls8962af_pm_ops, IIO_FXLS8962AF);
>  
>  MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
>  MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index cfb004b20455..7e0ecd3bf0d9 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -55,3 +55,4 @@ module_i2c_driver(fxls8962af_driver);
>  MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
>  MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer i2c driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_FXLS8962AF);
> diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
> index 57108d3d480b..0357d54d47cc 100644
> --- a/drivers/iio/accel/fxls8962af-spi.c
> +++ b/drivers/iio/accel/fxls8962af-spi.c
> @@ -55,3 +55,4 @@ module_spi_driver(fxls8962af_driver);
>  MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
>  MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer spi driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_FXLS8962AF);
> -- 
> 2.34.1
> 
