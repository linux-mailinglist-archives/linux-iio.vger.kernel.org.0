Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0372BC14C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgKUSCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgKUSCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 13:02:51 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3819022201;
        Sat, 21 Nov 2020 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605981770;
        bh=ZnvJ6O/llDrOwGdBy79JQvWupbbyMukQLD21Xwe8+aE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vit/CzavitK+in26XVdXwSyOfZkrxiWyRHL5003mHEX0iyiKIYN/j69zsMsZfMzZ/
         oVJ3zuiBIemMjwTbM0BZC7raGvMZmY0liVdZQBCR89IAN/ppW7gioyp3mrVrFiljvV
         JX2iaDhQxErUinOqemyKDWwtxzCDD1jiEZ07ouE4=
Date:   Sat, 21 Nov 2020 18:02:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 01/12] iio: core: register chardev only if needed
Message-ID: <20201121180246.772ad299@archlinux>
In-Reply-To: <20201117162340.43924-2-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
        <20201117162340.43924-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 18:23:29 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> We only need a chardev if we need to support buffers and/or events.
> 
> With this change, a chardev will be created only if an IIO buffer is
> attached OR an event_interface is configured.
> 
> Otherwise, no chardev will be created, and the IIO device will get
> registered with the 'device_add()' call.
> 
> Quite a lot of IIO devices don't really need a chardev, so this is a minor
> improvement to the IIO core, as the IIO device will take up (slightly)
> fewer resources.
> 
> In order to not create a chardev, we mostly just need to not initialize the
> indio_dev->dev.devt field. If that is un-initialized, cdev_device_add()
> behaves like device_add().
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I'll be honest. I have no idea why I didn't do this in first place!

I 'think' we are safe dropping this but I suppose it's possible some
odd code checks for the chrdev presence?

Hopefully not though.

Jonathan
 
> ---
>  drivers/iio/industrialio-core.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 419d6f8acc13..ca8b11541477 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1763,6 +1763,15 @@ static const struct file_operations iio_buffer_fileops = {
>  	.compat_ioctl = compat_ptr_ioctl,
>  };
>  
> +static const struct file_operations iio_event_fileops = {
> +	.owner = THIS_MODULE,
> +	.llseek = noop_llseek,
> +	.unlocked_ioctl = iio_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.open = iio_chrdev_open,
> +	.release = iio_chrdev_release,
> +};
> +
>  static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  {
>  	int i, j;
> @@ -1790,6 +1799,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	int ret;
>  
>  	if (!indio_dev->info)
> @@ -1807,9 +1817,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* configure elements for the chrdev */
> -	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> -
>  	iio_device_register_debugfs(indio_dev);
>  
>  	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
> @@ -1838,9 +1845,15 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->setup_ops == NULL)
>  		indio_dev->setup_ops = &noop_ring_setup_ops;
>  
> -	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	if (indio_dev->buffer)
> +		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	else if (iio_dev_opaque->event_interface)
> +		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
>  
> -	indio_dev->chrdev.owner = this_mod;
> +	if (indio_dev->buffer || iio_dev_opaque->event_interface) {
> +		indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> +		indio_dev->chrdev.owner = this_mod;
> +	}
>  
>  	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
>  	if (ret < 0)

