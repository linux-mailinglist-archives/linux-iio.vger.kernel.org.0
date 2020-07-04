Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DC21478F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGDQw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDQw2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:52:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F7E20674;
        Sat,  4 Jul 2020 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593881548;
        bh=Iw7eLVKt/5SNIWTZQupnxPQnDssjIel938s8/G+Gv8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kePRrxH1Cfs6DcUIeECJz+0iYP5XIEmDNPHII5MAXCBdy1u0sIXgKQvtYV5o/OT9s
         nGqp9reS/8S+/HaI9QJ4F6EOhcvIeekYoRG221CuXeaEJT6sJFfDAtk+piSmBkUTgl
         fRysBe0gdud+ZP8SS1yoZZIgkVSM3fkYK9Xx6FtM=
Date:   Sat, 4 Jul 2020 17:52:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH 03/23] iio:adc:hi8435: Drop unused of_gpio.h header
Message-ID: <20200704175223.3fa6c79e@archlinux>
In-Reply-To: <20200628123654.32830-4-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-4-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I guess this is a left over from some earlier cleanup. Not used
> currently.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Applied to the togreg branch of iio.git and pushed out as testing
to see if I missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hi8435.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 127e78243233..235374ec7bab 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -17,7 +17,6 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/spi/spi.h>
>  #include <linux/gpio/consumer.h>
>  

