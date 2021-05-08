Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72673772CA
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEHPvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhEHPvY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 11:51:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74869610C9;
        Sat,  8 May 2021 15:50:21 +0000 (UTC)
Date:   Sat, 8 May 2021 16:51:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
Message-ID: <20210508165119.69ca980c@jic23-huawei>
In-Reply-To: <20210506034332.752263-1-linux@roeck-us.net>
References: <20210506034332.752263-1-linux@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 May 2021 20:43:32 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> With CONFIG_ACPI=n and -Werror, 0-day reports:
> 
> drivers/iio/chemical/bme680_i2c.c:46:36: error:
> 	'bme680_acpi_match' defined but not used
> 
> Apparently BME0680 is not a valid ACPI ID. Remove it and with it
> ACPI support from the bme680_i2c driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message tweaked to reflect PRP0001 route which should work just fine
with ACPI and this driver.

Jonathan

> ---
> v2: Instead of making bme680_acpi_match conditional,
>     remove ACPI support entirely since the ACPI ID is
>     not valid.
> 
>  drivers/iio/chemical/bme680_i2c.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> index 29c0dfa4702b..74cf89c82c0a 100644
> --- a/drivers/iio/chemical/bme680_i2c.c
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -11,7 +11,6 @@
>   * Note: SDO pin cannot be left floating otherwise I2C address
>   *	 will be undefined.
>   */
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> @@ -42,12 +41,6 @@ static const struct i2c_device_id bme680_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
>  
> -static const struct acpi_device_id bme680_acpi_match[] = {
> -	{"BME0680", 0},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> -
>  static const struct of_device_id bme680_of_i2c_match[] = {
>  	{ .compatible = "bosch,bme680", },
>  	{},
> @@ -57,7 +50,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
>  static struct i2c_driver bme680_i2c_driver = {
>  	.driver = {
>  		.name			= "bme680_i2c",
> -		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
>  		.of_match_table		= bme680_of_i2c_match,
>  	},
>  	.probe = bme680_i2c_probe,

