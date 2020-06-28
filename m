Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C318F20CB20
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jun 2020 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgF1Xum (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 19:50:42 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:38955 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgF1Xum (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jun 2020 19:50:42 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jun 2020 19:50:41 EDT
Received: (qmail 29094 invoked by uid 5089); 28 Jun 2020 23:43:59 -0000
Received: by simscan 1.2.0 ppid: 29014, pid: 29015, t: 0.0770s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.22?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 28 Jun 2020 23:43:58 -0000
Subject: Re: [PATCH 21/23] iio:adc:ti-tlc4541: Drop CONFIG_OF and of_match_ptr
 protections.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200628123654.32830-1-jic23@kernel.org>
 <20200628123654.32830-22-jic23@kernel.org>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <ba126f3c-b1f8-0d21-c95a-bda1573b047e@electromag.com.au>
Date:   Mon, 29 Jun 2020 07:43:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200628123654.32830-22-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 28/06/2020 20:36, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These stop us using ACPI PRP0001 to instantiate the device.
> I am slowly clearly out use of these in IIO to avoid this being coppied
> into new drivers.
> 
> Here I also included mod_devicetable.h as we are using of_match_id
> which is defined in there and hence it is best practice to include
> it directly.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Phil Reid <preid@electromag.com.au>

Reviewed-by: Phil Reid <preid@electromag.com.au>

> ---
>   drivers/iio/adc/ti-tlc4541.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
> index 432238246519..53359a2e5bea 100644
> --- a/drivers/iio/adc/ti-tlc4541.c
> +++ b/drivers/iio/adc/ti-tlc4541.c
> @@ -24,6 +24,7 @@
>   #include <linux/iio/triggered_buffer.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/spi/spi.h>
> @@ -235,14 +236,12 @@ static int tlc4541_remove(struct spi_device *spi)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_OF
>   static const struct of_device_id tlc4541_dt_ids[] = {
>   	{ .compatible = "ti,tlc3541", },
>   	{ .compatible = "ti,tlc4541", },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, tlc4541_dt_ids);
> -#endif
>   
>   static const struct spi_device_id tlc4541_id[] = {
>   	{"tlc3541", TLC3541},
> @@ -254,7 +253,7 @@ MODULE_DEVICE_TABLE(spi, tlc4541_id);
>   static struct spi_driver tlc4541_driver = {
>   	.driver = {
>   		.name   = "tlc4541",
> -		.of_match_table = of_match_ptr(tlc4541_dt_ids),
> +		.of_match_table = tlc4541_dt_ids,
>   	},
>   	.probe          = tlc4541_probe,
>   	.remove         = tlc4541_remove,
> 

