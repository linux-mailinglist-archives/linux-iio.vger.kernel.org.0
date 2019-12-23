Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1641299C0
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 19:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfLWSGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 13:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWSGa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 13:06:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A55820409;
        Mon, 23 Dec 2019 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577124389;
        bh=osaBfMbJ1WxyGoo77kTDMFT202IxbNd0kIsQH4vp880=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V94WYgUA2xborWXXxVAt//W2E0NzNzfzmfzD9xCDRLj1ZWGDtnSld2vY6xHLtiIVV
         xWMtBKuH792oGzFLmL7iDgtak4gIQWesp2NOlCkbEAz8vyHMA75f+uudS0p6765xK2
         1GNgTRrYJIiYYHCwSpWuahbBbCZOBb+oa7FDt7k8=
Date:   Mon, 23 Dec 2019 18:06:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v1 1/2] iio: pressure: bmp280: Drop ACPI support
Message-ID: <20191223180625.121efefc@archlinux>
In-Reply-To: <20191209182805.56249-1-andriy.shevchenko@linux.intel.com>
References: <20191209182805.56249-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Dec 2019 20:28:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no evidence of officially registered ACPI IDs for these devices.
> Thus, revert ACPI support from the driver. All authors of the respective
> changes are being informed here:
> 
>   d5c94568cc1d ("iio: add bmp280 pressure and temperature driver")
>   6dba72eca7fb ("iio: pressure: bmp280: add support for BMP180")
>   14beaa8f5ab1 ("iio: pressure: bmp280: add humidity support")
> 
> Above seems a cargo cult without paying attention to how ACPI IDs
> are being allocated.
> 
> Cc: Vlad Dogaru <ddvlad@gmail.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Matt Ranostay <mranostay@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Good indeed to clean some of these out. I'm personally a lot more familiar
with the delights of ACPI than I was back then (and know the person
with the hisilicon list all too well ;)

Anyhow, applied to the togreg branch of iio.git and pushed out as
testing though I can't imagine how this would break.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-i2c.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 3109c8e2cc11..06f90853c141 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
>  
> @@ -38,15 +37,6 @@ static int bmp280_i2c_probe(struct i2c_client *client,
>  				   client->irq);
>  }
>  
> -static const struct acpi_device_id bmp280_acpi_i2c_match[] = {
> -	{"BMP0280", BMP280_CHIP_ID },
> -	{"BMP0180", BMP180_CHIP_ID },
> -	{"BMP0085", BMP180_CHIP_ID },
> -	{"BME0280", BME280_CHIP_ID },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, bmp280_acpi_i2c_match);
> -
>  #ifdef CONFIG_OF
>  static const struct of_device_id bmp280_of_i2c_match[] = {
>  	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
> @@ -72,7 +62,6 @@ MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
>  static struct i2c_driver bmp280_i2c_driver = {
>  	.driver = {
>  		.name	= "bmp280",
> -		.acpi_match_table = ACPI_PTR(bmp280_acpi_i2c_match),
>  		.of_match_table = of_match_ptr(bmp280_of_i2c_match),
>  		.pm = &bmp280_dev_pm_ops,
>  	},

