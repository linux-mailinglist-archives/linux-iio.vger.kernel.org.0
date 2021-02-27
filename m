Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0421326E7F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 18:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhB0Rxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 12:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhB0Rui (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 12:50:38 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF8F64E46;
        Sat, 27 Feb 2021 17:49:55 +0000 (UTC)
Date:   Sat, 27 Feb 2021 17:49:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2] iio: core: use kstrdup_const/kfree_const for buffer
 attributes
Message-ID: <20210227174952.06f45503@archlinux>
In-Reply-To: <20210223072926.79590-1-alexandru.ardelean@analog.com>
References: <20210219085826.46622-2-alexandru.ardelean@analog.com>
        <20210223072926.79590-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Feb 2021 09:29:26 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> When the buffer attributes were wrapped in iio_dev_attr types, I forgot to
> duplicate the names, so that when iio_free_chan_devattr_list() gets called
> on cleanup, these get free'd.
> I stumbled over this while accidentally breaking a driver doing
> iio_device_register(), and then the issue appeared.
> 
> Some ways to fix this are:
> 1. Just use kstrdup() during iio_buffer_wrap_attr()
> 2. Just use kfree_const() during iio_free_chan_devattr_list
> 3. Use both kstrdup_const() & kfree_const() (in the places mentioned above)
> 
> This implements the third option, as it allows some users/drivers to
> specify some attributes allocated on the heap.
> 
> Fixes: a1a11142f66c ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 1 +
>  drivers/iio/industrialio-core.c   | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5d641f8adfbd..ac882e60c419 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1306,6 +1306,7 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
>  		return NULL;
>  
>  	iio_attr->buffer = buffer;
> +	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
>  	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));

Doesn't this wipe out the duplicated string?  I swapped the two lines above
which I think should avoid that.

Merged into original patch

Jonathan


>  
>  	list_add(&iio_attr->l, &buffer->buffer_attr_list);
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0d8c6e88d993..cb2735d2ae4b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1358,7 +1358,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
>  	struct iio_dev_attr *p, *n;
>  
>  	list_for_each_entry_safe(p, n, attr_list, l) {
> -		kfree(p->dev_attr.attr.name);
> +		kfree_const(p->dev_attr.attr.name);
>  		list_del(&p->l);
>  		kfree(p);
>  	}

