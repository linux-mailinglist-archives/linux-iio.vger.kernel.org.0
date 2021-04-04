Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22641353948
	for <lists+linux-iio@lfdr.de>; Sun,  4 Apr 2021 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhDDR7h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Apr 2021 13:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhDDR7g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Apr 2021 13:59:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C2361103;
        Sun,  4 Apr 2021 17:59:29 +0000 (UTC)
Date:   Sun, 4 Apr 2021 18:59:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iio: buffer: use sysfs_attr_init() on allocated attrs
Message-ID: <20210404185943.63496d87@jic23-huawei>
In-Reply-To: <20210402174226.630346-1-aardelean@deviqon.com>
References: <20210402174226.630346-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  2 Apr 2021 20:42:26 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> When dynamically allocating sysfs attributes, it's a good idea to call
> sysfs_attr_init() on them to initialize lock_class_keys.
> This change does that.
> 
> The lock_class_keys are set when the CONFIG_DEBUG_LOCK_ALLOC symbol is
> enabled. Which is [likely] one reason why I did not see this during
> development.
> 
> I also am not able to see this even with CONFIG_DEBUG_LOCK_ALLOC enabled,
> so this may [likely] be reproduce-able on some system configurations.
> 
> This was reported via:
>   https://lore.kernel.org/linux-iio/CA+U=DsrsvGgXEF30-vXuXS_k=-mjSjiBwEEzwKb1hJVn1P98OA@mail.gmail.com/T/#u
> 
> Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
> 
> @Marek: could you maybe test this on your setup?
> 
> I haven't been able to reproduce this on mine.

I'm fairly sure this is the right fix, and 'should' resolve the issue Marek
saw so I'm going to queue it up.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it and see if we missed anything.

Thanks,

Jonathan

> 
> Thanks
> Alex
> 
>  drivers/iio/industrialio-buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index ee5aab9d4a23..06b2ea087408 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1309,6 +1309,7 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
>  	iio_attr->buffer = buffer;
>  	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
>  	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
> +	sysfs_attr_init(&iio_attr->dev_attr.attr);
>  
>  	list_add(&iio_attr->l, &buffer->buffer_attr_list);
>  

