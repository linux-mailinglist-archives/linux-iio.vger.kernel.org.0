Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0119E214796
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGDQ4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGDQ4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 12:56:41 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F995C061794
        for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2020 09:56:41 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2C0E19E00E1;
        Sat,  4 Jul 2020 17:56:38 +0100 (BST)
Date:   Sat, 4 Jul 2020 17:56:36 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>
Subject: Re: [PATCH 06/23] iio:adc:max1027: drop of_match_ptr and CONFIG_OF
 protections
Message-ID: <20200704175636.73eb8508@archlinux>
In-Reply-To: <20200628123654.32830-7-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-7-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:37 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These just prevent the driver being used with ACPI PRP0001
> and provide no major benefits.
> 
> Part of clearing these out in general in IIO to avoid cut and paste
> repetition in new drivers.  Also include mod_devicetable.h as we
> directly make use of of_device_id which is defined in there.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Philippe Reynes <tremyfr@yahoo.fr>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 9e993ccd14de..ca1dff3924ff 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
>  #include <linux/delay.h>
>  
> @@ -79,7 +80,6 @@ static const struct spi_device_id max1027_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, max1027_id);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id max1027_adc_dt_ids[] = {
>  	{ .compatible = "maxim,max1027" },
>  	{ .compatible = "maxim,max1029" },
> @@ -90,7 +90,6 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
> -#endif
>  
>  #define MAX1027_V_CHAN(index, depth)					\
>  	{								\
> @@ -518,7 +517,7 @@ static int max1027_probe(struct spi_device *spi)
>  static struct spi_driver max1027_driver = {
>  	.driver = {
>  		.name	= "max1027",
> -		.of_match_table = of_match_ptr(max1027_adc_dt_ids),
> +		.of_match_table = max1027_adc_dt_ids,
>  	},
>  	.probe		= max1027_probe,
>  	.id_table	= max1027_id,

