Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C6321C41
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBVQFF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Feb 2021 11:05:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2593 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhBVQD6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Feb 2021 11:03:58 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DkmxL1gmqz67nV1;
        Mon, 22 Feb 2021 23:55:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Feb 2021 17:03:03 +0100
Received: from localhost (10.47.74.92) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 22 Feb
 2021 16:03:02 +0000
Date:   Mon, 22 Feb 2021 16:01:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 1/2] iio: core: use kfree_const in
 iio_free_chan_devattr_list() to free names
Message-ID: <20210222160157.0000391e@Huawei.com>
In-Reply-To: <20210219085826.46622-2-alexandru.ardelean@analog.com>
References: <20210219085826.46622-1-alexandru.ardelean@analog.com>
        <20210219085826.46622-2-alexandru.ardelean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.74.92]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Feb 2021 10:58:25 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> When the buffer attributes were wrapped in iio_dev_attr types, I forgot to
> duplicate the names, so that when iio_free_chan_devattr_list() gets called
> on cleanup, these get free'd.
> I stumbled over this while accidentally breaking a driver doing
> iio_device_register(), and then the issue appeared.
> 
> The fix can be just
> 1. Just use kstrdup() during iio_buffer_wrap_attr()
> 2. Just use kfree_const() during iio_free_chan_devattr_list
> 3. Use both kstrdup_const() & kfree_const() (in the places mentioned above)
> 
> Using kfree_const() should be sufficient, as the attribute names will
> either be allocated or be stored in rodata.
> 
> Fixes: a1a11142f66c ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Thinking more on this...  It's fine for the users today, but there is
nothing stopping a driver passing in names it allocated on the heap.  So
I think we should revisit this.  Perhaps we need 1 or 3.
> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

