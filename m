Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02792147B3
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGDRW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgGDRW5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:22:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1361420739;
        Sat,  4 Jul 2020 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883377;
        bh=IxHBuDKuJJt0QF1+ksMWtVOX4zm5RHwRZmPtEbGRL3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WCwMRRuWSyYScOART383NrevyKRUabMn+fz+q10zWaBY55P3U8O8k47b2O2cr/GMU
         mhpkmD+Zbq1X/YZ7T8jzhRqt4PsenDiDnOORhRRxzGuhjfC+RbnRUoGiXXc/S4v/ib
         J6jMV/W1nKDDQmFG8fAr57zXOWqut1lBpkLM0FWg=
Date:   Sat, 4 Jul 2020 18:22:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: Re: [PATCH 13/23] iio:adc:mcp3422: remove CONFIG_OF and
 of_match_ptr protections
Message-ID: <20200704182253.466c9e49@archlinux>
In-Reply-To: <20200628123654.32830-14-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-14-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> They stop the driver being used with ACPI PRP0001 and are something
> I want to avoid being cut and paste into new drivers.
> Also switch the include from of.h to mod_devicetable.h as we
> struct of_device_id is defined in there and we don't use anything
> actually in of.h.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 40e0d3ed05a5..ec9c79199ffb 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -16,9 +16,9 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/sysfs.h>
> -#include <linux/of.h>
>  #include <asm/unaligned.h>
>  
>  #include <linux/iio/iio.h>
> @@ -402,18 +402,16 @@ static const struct i2c_device_id mcp3422_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp3422_id);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id mcp3422_of_match[] = {
>  	{ .compatible = "mcp3422" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mcp3422_of_match);
> -#endif
>  
>  static struct i2c_driver mcp3422_driver = {
>  	.driver = {
>  		.name = "mcp3422",
> -		.of_match_table = of_match_ptr(mcp3422_of_match),
> +		.of_match_table = mcp3422_of_match,
>  	},
>  	.probe = mcp3422_probe,
>  	.id_table = mcp3422_id,

