Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353371E00A2
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgEXQko (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 12:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgEXQko (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 12:40:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030DF20787;
        Sun, 24 May 2020 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590338443;
        bh=vccSXEaHfRL+UwNBweWaA0wqxU43n1ZHmahZIMV99LM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wf9ywyog6rPq0mLcfqzIvtv67NWYl+HSsM228j2gzjgEItASiBt54ma/mfbdmImk+
         TInTpoGzhZVcFoXUhwTbV6YDWo+n9/gVTOG2usBg/Y6jsgZJsMAq7pKqfW3npQNlAp
         YtiRk3ARpfVeidlaGY+nXqbQfjzaN/RPLus9yeZk=
Date:   Sun, 24 May 2020 17:40:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 05/14] iio: core: register chardev only if needed
Message-ID: <20200524174039.45867247@archlinux>
In-Reply-To: <20200508135348.15229-6-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
        <20200508135348.15229-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 May 2020 16:53:39 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The final intent is to localize all buffer ops into the
> industrialio-buffer.c file, to be able to add support for multiple buffers
> per IIO device.
> 
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
> What's important to remember, is that removing a chardev also requires that
> 'indio_dev->dev.devt' to be initialized. If it is, a '/dev/iio:deviceX'
> file will be created by the kernel, regardless of whether it has a chardev
> attached to it or not.
> If that field is not initialized, cdev_device_{add,del}() behave{s} like
> device_{add,del}().
> 
> Also, since we plan to add more chardevs for IIO buffers, we need to
> consider now a separate IDA object just for chardevs.
> Currently, the only benefit is that chardev IDs will be continuous.
> However, when adding a chardev per IIO buffer, the IDs for the chardev
> could outpace the IDs for IIO devices, so these should be decoupled.

Given we are still discussing the need for more chardevs I guess
we can't look at patches after this one 'yet'.  Up until here they
were all fine independent of the rest of the series.

I was wondering if I could pick up the first part as it is useful
whatever path we take with the rest of the series!

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 58 +++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 32c489139cd2..d74279efeca4 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -35,6 +35,9 @@
>  /* IDA to assign each registered device a unique id */
>  static DEFINE_IDA(iio_ida);
>  
> +/* IDA to assign each registered character device a unique id */
> +static DEFINE_IDA(iio_chrdev_ida);
> +
>  static dev_t iio_devt;
>  
>  #define IIO_DEV_MAX 256
> @@ -1680,8 +1683,40 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static int iio_device_alloc_chrdev_id(struct device *dev)
> +{
> +	int id;
> +
> +	id = ida_simple_get(&iio_chrdev_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		/* cannot use a dev_err as the name isn't available */
> +		dev_err(dev, "failed to get device id\n");
> +		return id;
> +	}
> +
> +	dev->devt = MKDEV(MAJOR(iio_devt), id);
> +
> +	return 0;
> +}
> +
> +static void iio_device_free_chrdev_id(struct device *dev)
> +{
> +	if (!dev->devt)
> +		return;
> +	ida_simple_remove(&iio_chrdev_ida, MINOR(dev->devt));
> +}
> +
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
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
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	int ret;
> @@ -1701,9 +1736,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* configure elements for the chrdev */
> -	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> -
>  	iio_device_register_debugfs(indio_dev);
>  
>  	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
> @@ -1732,16 +1764,27 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->setup_ops == NULL)
>  		indio_dev->setup_ops = &noop_ring_setup_ops;
>  
> -	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	if (indio_dev->buffer)
> +		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	else if (indio_dev->event_interface)
> +		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
>  
> -	indio_dev->chrdev.owner = this_mod;
> +	if (indio_dev->buffer || indio_dev->event_interface) {
> +		indio_dev->chrdev.owner = this_mod;
> +
> +		ret = iio_device_alloc_chrdev_id(&indio_dev->dev);
> +		if (ret)
> +			goto error_unreg_eventset;
> +	}
>  
>  	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> -	if (ret < 0)
> -		goto error_unreg_eventset;
> +	if (ret)
> +		goto error_free_chrdev_id;
>  
>  	return 0;
>  
> +error_free_chrdev_id:
> +	iio_device_free_chrdev_id(&indio_dev->dev);
>  error_unreg_eventset:
>  	iio_device_unregister_eventset(indio_dev);
>  error_free_sysfs:
> @@ -1761,6 +1804,7 @@ EXPORT_SYMBOL(__iio_device_register);
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
>  	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> +	iio_device_free_chrdev_id(&indio_dev->dev);
>  
>  	mutex_lock(&indio_dev->info_exist_lock);
>  

