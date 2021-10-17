Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0349430970
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbhJQNtt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 09:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236636AbhJQNts (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 09:49:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B905160FD8;
        Sun, 17 Oct 2021 13:47:37 +0000 (UTC)
Date:   Sun, 17 Oct 2021 14:51:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <ardeleanalex@gmail.com>
Subject: Re: [PATCH] iio: buffer: check return value of kstrdup_const()
Message-ID: <20211017145152.4a174093@jic23-huawei>
In-Reply-To: <20211013040438.1689277-1-yangyingliang@huawei.com>
References: <20211013040438.1689277-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Oct 2021 12:04:38 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> Check return value of kstrdup_const() in iio_buffer_wrap_attr(),
> or it will cause null-ptr-deref in kernfs_name_hash() when calling
> device_add() as follows:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:strlen+0x0/0x20
> Call Trace:
>  kernfs_name_hash+0x22/0x110
>  kernfs_find_ns+0x11d/0x390
>  kernfs_remove_by_name_ns+0x3b/0xb0
>  remove_files.isra.1+0x7b/0x190
>  internal_create_group+0x7f1/0xbb0
>  internal_create_groups+0xa3/0x150
>  device_add+0x8f0/0x2020
>  cdev_device_add+0xc3/0x160
>  __iio_device_register+0x1427/0x1b40 [industrialio]
>  __devm_iio_device_register+0x22/0x80 [industrialio]
>  adjd_s311_probe+0x195/0x200 [adjd_s311]
>  i2c_device_probe+0xa07/0xbb0
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Wang Wensheng sent another fix for this patch, but as that was missing the iio_attr free
I have picked up this one.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5f4bd0b73d03..547a92d469ae 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1312,6 +1312,11 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
>  	iio_attr->buffer = buffer;
>  	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
>  	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
> +	if (!iio_attr->dev_attr.attr.name) {
> +		kfree(iio_attr);
> +		return NULL;
> +	}
> +
>  	sysfs_attr_init(&iio_attr->dev_attr.attr);
>  
>  	list_add(&iio_attr->l, &buffer->buffer_attr_list);

