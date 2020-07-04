Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5121A2147BF
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGDReD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDReD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:34:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E211D20748;
        Sat,  4 Jul 2020 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593884042;
        bh=XhKNerazatNpOx1zlXZqnrUIEaG0AScAkdWbWRH0raI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wMS8OaF0xhKI6OnZ5zHHdCua96N/hnjIeNt5lJrNmV/YlX/5Zb8zRtK5wCKMSmY8n
         XVaT+9Isc2Ybs/QQ6lj+p9UZahM+XZBpSnUqgeiyF5FZtsI0MDdGKobtb+vjtq3BPY
         cat0Zz8sa1pFvx+5T7FzCkt1HMVjABZ3If4KiLWQ=
Date:   Sat, 4 Jul 2020 18:33:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 23/23] iio:adc:ingenic: drop of_match_ptr protection and
 include mod_devicetable.h
Message-ID: <20200704183359.6d8417fd@archlinux>
In-Reply-To: <20200628123654.32830-24-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-24-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:54 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Whilst it's unlikely this device will ever be instantiated using
> ACPI, there is little advantage not assigning the of_device_id table in all
> cases and it avoids providing an example that might be coppied into new
> drivers.
> 
> Also include mod_devicetable.h whilst here as of_device_id is defined
> in there so including the header is best practice.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Artur Rojek <contact@artur-rojek.eu>
Applied thanks,

Jonathan

> ---
>  drivers/iio/adc/ingenic-adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 3ea097c9650e..fa7ae7f6677e 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -13,6 +13,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  
> @@ -497,7 +498,6 @@ static int ingenic_adc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id ingenic_adc_of_match[] = {
>  	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
>  	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
> @@ -505,12 +505,11 @@ static const struct of_device_id ingenic_adc_of_match[] = {
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ingenic_adc_of_match);
> -#endif
>  
>  static struct platform_driver ingenic_adc_driver = {
>  	.driver = {
>  		.name = "ingenic-adc",
> -		.of_match_table = of_match_ptr(ingenic_adc_of_match),
> +		.of_match_table = ingenic_adc_of_match,
>  	},
>  	.probe = ingenic_adc_probe,
>  };

