Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB81299BF
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWSGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 13:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWSGQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 13:06:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86DD020409;
        Mon, 23 Dec 2019 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577124375;
        bh=2Esg7MHh9Dh+mguswQtBMu1J7onbEDoQvAkr6URhc/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kInCus6w8sQ1IuLanvFFIoAmZK3fa8mLXTEOiENCbV4SpE81sSNWIvSmIPQsDUUrS
         f6i53nPg1bQ7f8rTRyqjhees7aEUHTmeEIuC0x2q7noaXp5xep4aXUikOx0vx2EzLF
         VyX8GW+jIuwRvZLWtSgh1DHaQ95Jdug1beVxEUnM=
Date:   Mon, 23 Dec 2019 18:06:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/2] iio: pressure: bmp280: Allow device to be
 enumerated from ACPI
Message-ID: <20191223180611.6bd58c44@archlinux>
In-Reply-To: <20191209182805.56249-2-andriy.shevchenko@linux.intel.com>
References: <20191209182805.56249-1-andriy.shevchenko@linux.intel.com>
        <20191209182805.56249-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Dec 2019 20:28:05 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no need to limit the driver use by OF/platform code.
> In this case we simple remove redundant OF parts from the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-i2c.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 06f90853c141..8b03ea15c0d0 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/of.h>
>  #include <linux/regmap.h>
>  
>  #include "bmp280.h"
> @@ -37,7 +36,6 @@ static int bmp280_i2c_probe(struct i2c_client *client,
>  				   client->irq);
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id bmp280_of_i2c_match[] = {
>  	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
>  	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
> @@ -46,9 +44,6 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
> -#else
> -#define bmp280_of_i2c_match NULL
> -#endif
>  
>  static const struct i2c_device_id bmp280_i2c_id[] = {
>  	{"bmp280", BMP280_CHIP_ID },
> @@ -62,7 +57,7 @@ MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
>  static struct i2c_driver bmp280_i2c_driver = {
>  	.driver = {
>  		.name	= "bmp280",
> -		.of_match_table = of_match_ptr(bmp280_of_i2c_match),
> +		.of_match_table = bmp280_of_i2c_match,
>  		.pm = &bmp280_dev_pm_ops,
>  	},
>  	.probe		= bmp280_i2c_probe,

