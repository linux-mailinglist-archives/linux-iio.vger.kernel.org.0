Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC034A48D3
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 14:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379210AbiAaNz2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 31 Jan 2022 08:55:28 -0500
Received: from aposti.net ([89.234.176.197]:33720 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379225AbiAaNz1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Jan 2022 08:55:27 -0500
Date:   Mon, 31 Jan 2022 13:55:17 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 06/16] iio:dac:ad5592r: Move exports into IIO_AD5592R
 namespace
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <5OUK6R.W55AG38W1NAH1@crapouillou.net>
In-Reply-To: <20220130205701.334592-7-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
        <20220130205701.334592-7-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le dim., janv. 30 2022 at 20:56:51 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> In order to avoid unnecessary pollution of the global symbol namespace
> move the common/library functions into a specific namespace and import
> that into the various specific device drivers that use them.
> 
> For more information see https://lwn.net/Articles/760045/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/iio/dac/ad5592r-base.c | 4 ++--
>  drivers/iio/dac/ad5592r.c      | 1 +
>  drivers/iio/dac/ad5593r.c      | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c 
> b/drivers/iio/dac/ad5592r-base.c
> index 2fcc59728fd6..ec2937b8d768 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -661,7 +661,7 @@ int ad5592r_probe(struct device *dev, const char 
> *name,
> 
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(ad5592r_probe);
> +EXPORT_SYMBOL_NS_GPL(ad5592r_probe, IIO_AD5592R);
> 
>  void ad5592r_remove(struct device *dev)
>  {
> @@ -675,7 +675,7 @@ void ad5592r_remove(struct device *dev)
>  	if (st->reg)
>  		regulator_disable(st->reg);
>  }
> -EXPORT_SYMBOL_GPL(ad5592r_remove);
> +EXPORT_SYMBOL_NS_GPL(ad5592r_remove, IIO_AD5592R);
> 
>  MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel 
> converters");
> diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
> index 6bfd7951e18c..1572279b04bb 100644
> --- a/drivers/iio/dac/ad5592r.c
> +++ b/drivers/iio/dac/ad5592r.c
> @@ -170,3 +170,4 @@ module_spi_driver(ad5592r_spi_driver);
>  MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel 
> converters");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_AD5592R);
> diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
> index 64dd7a0bddf7..34e1319a9712 100644
> --- a/drivers/iio/dac/ad5593r.c
> +++ b/drivers/iio/dac/ad5593r.c
> @@ -137,3 +137,4 @@ module_i2c_driver(ad5593r_driver);
>  MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD5593R multi-channel 
> converters");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_AD5592R);
> --
> 2.35.1
> 


