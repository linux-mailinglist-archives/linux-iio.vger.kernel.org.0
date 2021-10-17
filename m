Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FB430A5A
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhJQQHJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 12:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241905AbhJQQHJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 12:07:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6864161040;
        Sun, 17 Oct 2021 16:04:58 +0000 (UTC)
Date:   Sun, 17 Oct 2021 17:09:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gavinli@thegavinli.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gavin Li <gavin@matician.com>
Subject: Re: [PATCH] iio: trigger: fix iio_trigger reference leak
Message-ID: <20211017170912.6ef4a8cb@jic23-huawei>
In-Reply-To: <20211008083220.3713926-1-gavinli@thegavinli.com>
References: <20211008083220.3713926-1-gavinli@thegavinli.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 Oct 2021 01:32:20 -0700
gavinli@thegavinli.com wrote:

> From: Gavin Li <gavin@matician.com>
> 
> viio_trigger_alloc() includes a get_device() call added in commit
> 5f9c035cae back in 2011. While I wasn't able to ascertain why it was
> added, I've noticed that it does cause a memory leak, especially when
> rmmod'ing iio modules. Here is a simple module that replicates this
> issue:
> 
>     #include <linux/module.h>
>     #include <linux/iio/iio.h>
>     #include <linux/iio/trigger.h>
> 
>     int my_init(void) {
>         struct iio_trigger *trig = iio_trigger_alloc("leak-trig");
>         if (!trig)
>             return -ENOMEM;
> 
>         printk("iio-leak: %u uses at A\n", kref_read(&trig->dev.kobj.kref));
>         iio_trigger_free(trig);
>         printk("iio-leak: %u uses at B\n", kref_read(&trig->dev.kobj.kref));
> 
>         return 0;
>     }
> 
>     void my_exit(void) {}
> 
>     module_init(my_init);
>     module_exit(my_exit);
>     MODULE_LICENSE("GPL v2");
> 
> It prints the following in the kernel log:
> 
>     iio-leak: 2 uses at A
>     iio-leak: 1 uses at B
> 
> This patch removes the get_device() call. This shouldn't break
> subirqs with iio_trigger_attach_poll_func() because a reference should
> already exist via indio_dev->trig.

Agreed, it is most mysterious...  I can't apply this patch though without a
Signed-off-by: ...

as even though it's trivial we need a developer certificate of origin.
(represented by the Signed-off-by line)

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-trigger.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index b23caa2f2aa1f..93990ff1dfe39 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -556,7 +556,6 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  		irq_modify_status(trig->subirq_base + i,
>  				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
>  	}
> -	get_device(&trig->dev);
>  
>  	return trig;
>  

