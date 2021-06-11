Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B33A4628
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFKQKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 12:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhFKQKG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 12:10:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49BB613F9;
        Fri, 11 Jun 2021 16:08:06 +0000 (UTC)
Date:   Fri, 11 Jun 2021 17:09:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/7] staging:iio:resolver:ad2s1210: Cleanup includes
Message-ID: <20210611170955.7c9a8a26@jic23-huawei>
In-Reply-To: <20210611152614.109361-8-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
        <20210611152614.109361-8-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 16:26:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Based on consideration of the output of the include-what-you-use tool.
> Drop unused includes and add some that should be there.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 74adb82f37c3..99dec73144ba 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -4,15 +4,16 @@
>   *
>   * Copyright (c) 2010-2010 Analog Devices Inc.
>   */
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/delay.h>

Let's pretend I didn't remove this one by accident as it is needed.
I don't want to resend the whole set for that however so will 
leave it for now.

>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

