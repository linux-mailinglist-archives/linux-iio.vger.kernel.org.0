Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3694A48C4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiAaNyE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 31 Jan 2022 08:54:04 -0500
Received: from aposti.net ([89.234.176.197]:33582 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346094AbiAaNyE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Jan 2022 08:54:04 -0500
Date:   Mon, 31 Jan 2022 13:53:52 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/16] iio:adc:ad7091r: Move exports into IIO_AD7091R
 namespace.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <SLUK6R.LXAL8TY0VY432@crapouillou.net>
In-Reply-To: <20220130205701.334592-3-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
        <20220130205701.334592-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le dim., janv. 30 2022 at 20:56:47 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> In order to avoid unnecessary pollution of the global symbol namespace
> move the core/library functions into a specific namespace and import
> that into the various specific device drivers that use them.
> 
> For more information see https://lwn.net/Articles/760045/
> 
> An alternative here would be to conclude that we are unlikely to see
> support for the other ad7091r parts in the near future and just merge
> the two modules into one supporting just the i2c -5 variant.

Unlikely in the near future, yes. I wouldn't totally close the door but 
it's not in our short-term plans.

If you think it's better to merge the two modules into one in the 
meantime - fine with me.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Paul Cercueil <paul@crapouillou.net>

Otherwise:

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/iio/adc/ad7091r-base.c | 4 ++--
>  drivers/iio/adc/ad7091r5.c     | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c 
> b/drivers/iio/adc/ad7091r-base.c
> index 63b4d6ea4566..8e252cde735b 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -260,7 +260,7 @@ int ad7091r_probe(struct device *dev, const char 
> *name,
> 
>  	return devm_iio_device_register(dev, iio_dev);
>  }
> -EXPORT_SYMBOL_GPL(ad7091r_probe);
> +EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
> 
>  static bool ad7091r_writeable_reg(struct device *dev, unsigned int 
> reg)
>  {
> @@ -290,7 +290,7 @@ const struct regmap_config ad7091r_regmap_config 
> = {
>  	.writeable_reg = ad7091r_writeable_reg,
>  	.volatile_reg = ad7091r_volatile_reg,
>  };
> -EXPORT_SYMBOL_GPL(ad7091r_regmap_config);
> +EXPORT_SYMBOL_NS_GPL(ad7091r_regmap_config, IIO_AD7091R);
> 
>  MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel 
> converters");
> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> index 9665679c3ea6..47f5763023a4 100644
> --- a/drivers/iio/adc/ad7091r5.c
> +++ b/drivers/iio/adc/ad7091r5.c
> @@ -111,3 +111,4 @@ module_i2c_driver(ad7091r5_driver);
>  MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC 
> driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_AD7091R);
> --
> 2.35.1
> 


