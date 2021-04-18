Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3754D363490
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhDRKLq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 06:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhDRKLp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 06:11:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA5861090;
        Sun, 18 Apr 2021 10:11:14 +0000 (UTC)
Date:   Sun, 18 Apr 2021 11:11:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/1] iio: adc: ad7298: Enable on Intel Galileo Gen 1
Message-ID: <20210418111146.38e9d35d@jic23-huawei>
In-Reply-To: <20210412131835.70212-1-andriy.shevchenko@linux.intel.com>
References: <20210412131835.70212-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 16:18:35 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Enable ADC on Intel Galileo Gen 1 board.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to hopefully not notice we did anything ;)

Jonathan

> ---
> v2: fixed typo in ID
>  drivers/iio/adc/ad7298.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 689ecd5dd563..e7e866433090 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -13,6 +13,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/bitops.h>
> @@ -352,6 +353,12 @@ static int ad7298_probe(struct spi_device *spi)
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> +static const struct acpi_device_id ad7298_acpi_ids[] = {
> +	{ "INT3494", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, ad7298_acpi_ids);
> +
>  static const struct spi_device_id ad7298_id[] = {
>  	{"ad7298", 0},
>  	{}
> @@ -361,6 +368,7 @@ MODULE_DEVICE_TABLE(spi, ad7298_id);
>  static struct spi_driver ad7298_driver = {
>  	.driver = {
>  		.name	= "ad7298",
> +		.acpi_match_table = ad7298_acpi_ids,
>  	},
>  	.probe		= ad7298_probe,
>  	.id_table	= ad7298_id,

