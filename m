Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1D430A4E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbhJQPuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 11:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237507AbhJQPuh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 11:50:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E40461038;
        Sun, 17 Oct 2021 15:48:26 +0000 (UTC)
Date:   Sun, 17 Oct 2021 16:52:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] iio: core: check return value when calling
 dev_set_name()
Message-ID: <20211017165240.56fdc296@jic23-huawei>
In-Reply-To: <20211012063624.3167460-1-yangyingliang@huawei.com>
References: <20211012063624.3167460-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Oct 2021 14:36:24 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> I got a null-ptr-deref report when doing fault injection test:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:strlen+0x0/0x20
> Call Trace:
>  start_creating+0x199/0x2f0
>  debugfs_create_dir+0x25/0x430
>  __iio_device_register+0x4da/0x1b40 [industrialio]
>  __devm_iio_device_register+0x22/0x80 [industrialio]
>  max1027_probe+0x639/0x860 [max1027]
>  spi_probe+0x183/0x210
>  really_probe+0x285/0xc30
> 
> If dev_set_name() fails, the dev_name() is null, check the return
> value of dev_set_name() to avoid the null-ptr-deref.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e553f182d55b ("staging: iio: core: Introduce debugfs support...")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Hi Yang Yingliang,

I've been delaying replying to these for a few days because you have
identified a more significant issue whilst working in this area and I wanted
to take a deeper look at it.

After we call device_initialize() a few lines above this all the cleanup
on error should be done via a put_device() call, not by cleaning it up manually.

However, that's clearly a much more substantial change so I'm going to apply this
for now and deal with that cleanup at a later date.

Thanks,

Jonathan


> ---
>  drivers/iio/industrialio-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2dc837db50f7..3e1e86d987cc 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1665,7 +1665,13 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  		kfree(iio_dev_opaque);
>  		return NULL;
>  	}
> -	dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id);
> +
> +	if (dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id)) {
> +		ida_simple_remove(&iio_ida, iio_dev_opaque->id);
> +		kfree(iio_dev_opaque);
> +		return NULL;
> +	}
> +
>  	INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
>  	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
>  

