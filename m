Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2322147B9
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGDR3G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDR3G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:29:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672BD20748;
        Sat,  4 Jul 2020 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883745;
        bh=s7XU9zjuSfSnV6KxUUQODDlNPefdYx3KWOFlAnm1vtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PGPhVc66q8zBs9RwLxHuIuBiCbEjXY38l5rb92gVZbesNi54UgIDZ3S4lEo6hqVNi
         OD6iE7E0KWMa7nFMn9ltlDMqDxbatvBv4FTqA0U7avcIiiTIEE2UC9Ix0ur7PjNXZy
         nztgR/lMZx3WA0ta844l1PS3PwKCQUQiyyZDaE8w=
Date:   Sat, 4 Jul 2020 18:29:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 16/23] iio:adc:ti-adc0832: drop CONFIG_OF and
 of_match_ptr protections
Message-ID: <20200704182901.4f1607b3@archlinux>
In-Reply-To: <20200628123654.32830-17-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-17-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:47 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These just prevent the driver being used with ACPI PRP0001.
> 
> I am also trying to remove these from IIO in general to avoid
> them being coppied into new drivers.
> 
> Also include the mod_devicetable.h header as we are using
> of_device_id which is defined in there.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
Applied thanks

J
> ---
>  drivers/iio/adc/ti-adc0832.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
> index 3eb3ba5fb610..05061dc05b32 100644
> --- a/drivers/iio/adc/ti-adc0832.c
> +++ b/drivers/iio/adc/ti-adc0832.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> @@ -313,8 +314,6 @@ static int adc0832_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -
>  static const struct of_device_id adc0832_dt_ids[] = {
>  	{ .compatible = "ti,adc0831", },
>  	{ .compatible = "ti,adc0832", },
> @@ -324,8 +323,6 @@ static const struct of_device_id adc0832_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, adc0832_dt_ids);
>  
> -#endif
> -
>  static const struct spi_device_id adc0832_id[] = {
>  	{ "adc0831", adc0831 },
>  	{ "adc0832", adc0832 },
> @@ -338,7 +335,7 @@ MODULE_DEVICE_TABLE(spi, adc0832_id);
>  static struct spi_driver adc0832_driver = {
>  	.driver = {
>  		.name = "adc0832",
> -		.of_match_table = of_match_ptr(adc0832_dt_ids),
> +		.of_match_table = adc0832_dt_ids,
>  	},
>  	.probe = adc0832_probe,
>  	.remove = adc0832_remove,

