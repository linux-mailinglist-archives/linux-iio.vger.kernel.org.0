Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2068F1AF191
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDRP0B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 11:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDRP0A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 11:26:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE7F20732;
        Sat, 18 Apr 2020 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587223560;
        bh=Bsx+dDMGy1HPzN7fo/yLW6PVUv+11YvSb7UygiTobq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=myrou/+i7qw+laAzGraeX6Aio+kmcBH2Gm0ZG6iYIrAKBi+ClWzbVqn+JF7N7WaRg
         CC0huTRN8WNE/ooMvO11mgk7bU5VhApaY1pGN8LuqrgVBr6JwGAvkZBps/FIEgeLQR
         vcv4385XinA/UHHw12Zw3hx5hX54I4lXAqUkxQG8=
Date:   Sat, 18 Apr 2020 16:25:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: core: fail early in iio_device_alloc() if we can't
 get a device id
Message-ID: <20200418162555.4b6f4b8d@archlinux>
In-Reply-To: <20200416123331.68790-1-alexandru.ardelean@analog.com>
References: <20200416123331.68790-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 15:33:31 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change moves the 'ida_simple_get()' call to be the first one in
> iio_device_alloc(). It cleans up the error path a bit as we don't need to
> call any kfree(dev) anymore. We allocate an IIO device only if we have
> managed to obtain a device ID.

We just threw away an ID if the kzalloc then fails (or am I missing something?)
With that fixed I can't see this as being much of an improvement.
Either way one allocation needs to be tidied up.

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f4daf19f2a3b..7c1d8a3ab2f3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1494,6 +1494,14 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  {
>  	struct iio_dev *dev;
>  	size_t alloc_size;
> +	int id;
> +
> +	id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		/* cannot use a dev_err as the name isn't available */
> +		pr_err("failed to get device id\n");
> +		return NULL;
> +	}
>  
>  	alloc_size = sizeof(struct iio_dev);
>  	if (sizeof_priv) {
> @@ -1506,6 +1514,8 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  	dev = kzalloc(alloc_size, GFP_KERNEL);
>  
>  	if (dev) {
> +		dev->id = id;
> +		dev_set_name(&dev->dev, "iio:device%d", dev->id);
>  		dev->dev.groups = dev->groups;
>  		dev->dev.type = &iio_device_type;
>  		dev->dev.bus = &iio_bus_type;
> @@ -1514,15 +1524,6 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  		mutex_init(&dev->mlock);
>  		mutex_init(&dev->info_exist_lock);
>  		INIT_LIST_HEAD(&dev->channel_attr_list);
> -
> -		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> -		if (dev->id < 0) {
> -			/* cannot use a dev_err as the name isn't available */
> -			pr_err("failed to get device id\n");
> -			kfree(dev);
> -			return NULL;
> -		}
> -		dev_set_name(&dev->dev, "iio:device%d", dev->id);
>  		INIT_LIST_HEAD(&dev->buffer_list);
>  	}
>  

