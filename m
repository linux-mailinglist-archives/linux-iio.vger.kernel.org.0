Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484FA3772CC
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhEHPwi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhEHPwg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 11:52:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6196101A;
        Sat,  8 May 2021 15:51:33 +0000 (UTC)
Date:   Sat, 8 May 2021 16:52:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] iio: bme680_spi: Remove ACPI support
Message-ID: <20210508165231.162fdccd@jic23-huawei>
In-Reply-To: <20210506133145.2266604-1-linux@roeck-us.net>
References: <20210506133145.2266604-1-linux@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 May 2021 06:31:45 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> BME0680 is not an official ACPI ID, so let's remove it before someone
> starts using it.
> 
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied with message tweaked for PRP0001 and title changed to make
it clear this isn't removing ACPI support, just one means of doing it.

Jonathan

> ---
>  drivers/iio/chemical/bme680_spi.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> index 6f56ad48cc40..cc579a7ac5ce 100644
> --- a/drivers/iio/chemical/bme680_spi.c
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
>   */
> -#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> @@ -145,12 +144,6 @@ static const struct spi_device_id bme680_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, bme680_spi_id);
>  
> -static const struct acpi_device_id bme680_acpi_match[] = {
> -	{"BME0680", 0},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> -
>  static const struct of_device_id bme680_of_spi_match[] = {
>  	{ .compatible = "bosch,bme680", },
>  	{},
> @@ -160,7 +153,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
>  static struct spi_driver bme680_spi_driver = {
>  	.driver = {
>  		.name			= "bme680_spi",
> -		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
>  		.of_match_table		= bme680_of_spi_match,
>  	},
>  	.probe = bme680_spi_probe,

