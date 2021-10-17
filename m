Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1036343096B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhJQNrC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 09:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237530AbhJQNrB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 09:47:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A3A60FD8;
        Sun, 17 Oct 2021 13:44:50 +0000 (UTC)
Date:   Sun, 17 Oct 2021 14:49:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     <lars@metafoo.de>, <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
Subject: Re: [PATCH -next] iio: buffer: Check the return value of
 kstrdup_const()
Message-ID: <20211017144903.59ee0f59@jic23-huawei>
In-Reply-To: <20211011125846.66553-1-wangwensheng4@huawei.com>
References: <20211011125846.66553-1-wangwensheng4@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Oct 2021 12:58:46 +0000
Wang Wensheng <wangwensheng4@huawei.com> wrote:

> We should check the duplication of attr.name properly in
> iio_buffer_wrap_attr() or a null-pointer-dereference would
> occur on destroying the related sysfs file.
> This issue is found by fault-injection.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> RIP: 0010:strlen+0x0/0x20
> Call Trace:
>  kernfs_name_hash+0x1c/0xb0
>  kernfs_find_ns+0xc6/0x160
>  kernfs_remove_by_name_ns+0x5c/0xb0
>  remove_files.isra.1+0x42/0x90
>  internal_create_group+0x42f/0x460
>  internal_create_groups+0x49/0xc0
>  device_add+0xb5b/0xbe0
>  ? kobject_get+0x90/0xa0
>  cdev_device_add+0x2b/0x90
>  __iio_device_register+0xa56/0xb40
> 
> Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> Reported-by: Hulk Robot<hulkci@huawei.com>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
This version seems to be a duplicate with the version Yang Yingliang
sent a few days later, but that version has the free of the iio_attr which
is missing here.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index c648e9553edd..f4011c477bac 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1312,6 +1312,8 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
>  	iio_attr->buffer = buffer;
>  	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
>  	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
> +	if (!iio_attr->dev_attr.attr.name)
> +		return NULL;
>  	sysfs_attr_init(&iio_attr->dev_attr.attr);
>  
>  	list_add(&iio_attr->l, &buffer->buffer_attr_list);

