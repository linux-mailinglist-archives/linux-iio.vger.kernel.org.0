Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7640B214790
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGDQxr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGDQxr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:53:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E9520674;
        Sat,  4 Jul 2020 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593881626;
        bh=1kMRQi5MiKMVFkU8uofuB8SStTAndZM+NSXWFy5txlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vIl0CDkbHadkhjLAYiV8pcmGhlOWTDutqAQCtcsHS9hHiEACBaVrgVflKYWilIKDb
         w86VIFI0QG8KFW/5WVlpj7/32pjOZU1SBcJERx5JZDtdmSkQjKr4NFaRu7moYIQoh+
         IAS2lF+H7rLDaxyJpHvSaJe7hmNscyAEzFBoukn8=
Date:   Sat, 4 Jul 2020 17:53:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 04/23] iio:adc:hi8435: Drop of_match_ptr protection.
Message-ID: <20200704175340.2587f4cc@archlinux>
In-Reply-To: <20200628123654.32830-5-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-5-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:35 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Allows use of ACPI with PRP0001 and is generally something we are
> trying to avoid having people cut and paste into new drivers without
> thinking about it.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hi8435.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 235374ec7bab..074c30970465 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -15,8 +15,7 @@
>  #include <linux/iio/triggered_event.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
>  #include <linux/gpio/consumer.h>
>  
> @@ -539,7 +538,7 @@ MODULE_DEVICE_TABLE(spi, hi8435_id);
>  static struct spi_driver hi8435_driver = {
>  	.driver	= {
>  		.name		= DRV_NAME,
> -		.of_match_table	= of_match_ptr(hi8435_dt_ids),
> +		.of_match_table	= hi8435_dt_ids,
>  	},
>  	.probe		= hi8435_probe,
>  	.id_table	= hi8435_id,

