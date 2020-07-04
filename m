Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306712147AF
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgGDRU7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgGDRU7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:20:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E6820739;
        Sat,  4 Jul 2020 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883258;
        bh=m7rmPaWBXyiK/KqHEKCI81J+aRw3UsIhQKEsTnzHUs0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B3AdNZWBSZ0Frm50sPQST1Pwpkz8HJmJq9HektS6LFvTqvnPe0pxkjPLfChMmY8zJ
         vJ6/essRDHvBCjoFrQSlW4cuX3chhgS51UwKTU2FSMyIfF+dwPWmJ1t/v3acYA1R2V
         V1lxCEoFlT+m2+6M+fSY0/n6RVjxwlu4tsgvf444=
Date:   Sat, 4 Jul 2020 18:20:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 11/23] iio:adc:max1118: Drop CONFIG_OF / of_match_ptr
 protections
Message-ID: <20200704182054.50389e16@archlinux>
In-Reply-To: <20200628123654.32830-12-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-12-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:42 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These just stop the driver being used with ACPI PRP0001 and
> we are trying to clear them out of IIO to avoid them getting copied
> into new drivers.
> Also add the mod_devicetable.h include as we are using
> struct of_device_id which is defined in there.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1118.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
> index 273fbea2a515..01b20e420ac4 100644
> --- a/drivers/iio/adc/max1118.c
> +++ b/drivers/iio/adc/max1118.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -280,8 +281,6 @@ static const struct spi_device_id max1118_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, max1118_id);
>  
> -#ifdef CONFIG_OF
> -
>  static const struct of_device_id max1118_dt_ids[] = {
>  	{ .compatible = "maxim,max1117" },
>  	{ .compatible = "maxim,max1118" },
> @@ -290,12 +289,10 @@ static const struct of_device_id max1118_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, max1118_dt_ids);
>  
> -#endif
> -
>  static struct spi_driver max1118_spi_driver = {
>  	.driver = {
>  		.name = "max1118",
> -		.of_match_table = of_match_ptr(max1118_dt_ids),
> +		.of_match_table = max1118_dt_ids,
>  	},
>  	.probe = max1118_probe,
>  	.remove = max1118_remove,

