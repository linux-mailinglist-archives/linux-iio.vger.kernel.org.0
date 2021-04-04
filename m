Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67AE353945
	for <lists+linux-iio@lfdr.de>; Sun,  4 Apr 2021 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhDDR5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Apr 2021 13:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhDDR47 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Apr 2021 13:56:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B34D611C0;
        Sun,  4 Apr 2021 17:56:51 +0000 (UTC)
Date:   Sun, 4 Apr 2021 18:57:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] iio: trigger: Replace explicit casting and wrong
 specifier with proper one
Message-ID: <20210404185705.2ab99d66@jic23-huawei>
In-Reply-To: <20210402174911.44408-1-andriy.shevchenko@linux.intel.com>
References: <20210402174911.44408-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  2 Apr 2021 20:49:10 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> By unknown reason device name is set with an index casted from int
> to unsigned long while at the same time with "%ld" specifier. Both parts
> seems wrong to me, thus replace replace explicit casting and wrong specifier
> with proper one, i.e. "%d".
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Series applied to the togreg branch of iio.git.

thanks,

Jonathan

> ---
> v2: used %d which is really correct one
>  drivers/iio/industrialio-trigger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 32ac1bec25e3..78e30f0f915c 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -75,8 +75,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
>  		return trig_info->id;
>  
>  	/* Set the name used for the sysfs directory etc */
> -	dev_set_name(&trig_info->dev, "trigger%ld",
> -		     (unsigned long) trig_info->id);
> +	dev_set_name(&trig_info->dev, "trigger%d", trig_info->id);
>  
>  	ret = device_add(&trig_info->dev);
>  	if (ret)

