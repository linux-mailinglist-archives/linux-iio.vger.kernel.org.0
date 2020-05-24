Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79E1E00AC
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgEXQpo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 12:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgEXQpo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 12:45:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC642065F;
        Sun, 24 May 2020 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590338743;
        bh=xS9Tm0fa5dDfLZvwDb8idhITeOc1qmIrV2bPHeRNfes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AFDM79yPeU2CVlvEZR087UO23/bQ2K6lVDad/T3kTS6awlRaB3t07f39kQJRcymxp
         pvMnL2kYzJRQdsCrL4y2mBKZOJkkeSHSxe9EnvgJoQ/F9IAgIHBZ9H+RqRw/WCKvwT
         HU59voZsSX1ssqxtJY+9v5WeXfU+U1haBL0PwkUo=
Date:   Sun, 24 May 2020 17:45:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 07/14] iio: core: add simple centralized mechanism
 for ioctl() handlers
Message-ID: <20200524174539.301026de@archlinux>
In-Reply-To: <20200508135348.15229-8-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
        <20200508135348.15229-8-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 May 2020 16:53:41 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The aim of this is to reduce the organization violation of ioctl() calls in
> IIO core. Currently, since the chardev is split across files, event ioctl()
> calls need to be called in buffer ioctl() calls.
> 
> The 'industrialio-core.c' file will provide a 'iio_device_ioctl()' which
> will iterate over a list of ioctls registered with the IIO device. These
> can be event ioctl() or buffer ioctl() calls, or something else.
> This is needed, since there is currently one chardev per IIO device and
> that is used for both event handling and reading from the buffer.
> 
> Each ioctl() will have to return a IIO_IOCTL_UNHANDLED code (which is
> positive 1), if the ioctl() did not handle the call in any. This eliminates
> any potential ambiguities; if we were to have used error codes it would
> have been uncertain whether they were actual errors, or whether
> the registered ioctl() doesn't service the command.
> 
> If any ioctl() returns 0, it was considered that it was serviced
> successfully and the loop will exit.
> 
> One assumption for all registered ioctl() handlers is that they are
> statically allocated, so the iio_device_unregister() which just remove all
> of them from the device's ioctl() handler list.
> 
> Also, something that is a bit hard to do [at this point] and may not be
> worth the effort of doing, is to check whether registered ioctl()
> calls/commands overlap. This should be unlikely to happen, and should get
> caught at review time. Though, new ioctl() calls would likely not be added
> too often.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

We seem to have dropped the locking in here.   What am I missing that
stops us racing a remove with the ioctl?  If there is a reason that
can't race, please add comments there so I don't wonders sometime in
the future.

The check on iio_dev->info means we won't start the ioctl if the
remove has been called, but if we switch immediately after that,
anything can happen before we start calling the ioctls.

J

> ---
>  drivers/iio/iio_core.h          | 14 ++++++++++++++
>  drivers/iio/industrialio-core.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  2 ++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index a527a66be9e5..34c3e19229d8 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -17,6 +17,20 @@ struct iio_dev;
>  
>  extern struct device_type iio_device_type;
>  
> +#define IIO_IOCTL_UNHANDLED	1
> +struct iio_ioctl_handler {
> +	struct list_head entry;
> +	long (*ioctl)(struct iio_dev *indio_dev, struct file *filp,
> +		      unsigned int cmd, unsigned long arg);
> +};
> +
> +long iio_device_ioctl(struct iio_dev *indio_dev, struct file *filp,
> +		      unsigned int cmd, unsigned long arg);
> +
> +void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
> +				       struct iio_ioctl_handler *h);
> +void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
> +
>  int __iio_add_chan_devattr(const char *postfix,
>  			   struct iio_chan_spec const *chan,
>  			   ssize_t (*func)(struct device *dev,
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 32e045c7f0c1..5df3af5e7dcb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1534,6 +1534,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  	}
>  	dev_set_name(&dev->dev, "iio:device%d", dev->id);
>  	INIT_LIST_HEAD(&dev->buffer_list);
> +	INIT_LIST_HEAD(&dev->ioctl_handlers);
>  
>  	return dev;
>  }
> @@ -1587,6 +1588,33 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
>  
> +void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
> +				       struct iio_ioctl_handler *h)
> +{
> +	/* this assumes that all ioctl() handlers are statically allocated */
> +	list_add_tail(&h->entry, &indio_dev->ioctl_handlers);
> +}
> +
> +long iio_device_ioctl(struct iio_dev *indio_dev, struct file *filp,
> +		      unsigned int cmd, unsigned long arg)
> +{
> +	struct iio_ioctl_handler *h;
> +	int ret;
> +
> +	if (!indio_dev->info)
> +		return -ENODEV;

The locking is gone?  
> +
> +	list_for_each_entry(h, &indio_dev->ioctl_handlers, entry) {
> +		ret = h->ioctl(indio_dev, filp, cmd, arg);
> +		if (ret == 0)
> +			return 0;
> +		if (ret != IIO_IOCTL_UNHANDLED)
> +			return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  {
>  	int i, j;
> @@ -1722,6 +1750,8 @@ EXPORT_SYMBOL(__iio_device_register);
>   **/
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
> +	struct iio_ioctl_handler *h, *t;
> +
>  	cdev_device_del(indio_dev->chrdev, &indio_dev->dev);
>  	iio_device_free_chrdev_id(&indio_dev->dev);
>  
> @@ -1731,6 +1761,9 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  
>  	iio_disable_all_buffers(indio_dev);
>  
> +	list_for_each_entry_safe(h, t, &indio_dev->ioctl_handlers, entry)
> +		list_del(&h->entry);
> +
>  	indio_dev->info = NULL;
>  
>  	iio_device_wakeup_eventset(indio_dev);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 52992be44e9e..b6ca8d85629e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -488,6 +488,7 @@ struct iio_buffer_setup_ops {
>   * @currentmode:	[DRIVER] current operating mode
>   * @dev:		[DRIVER] device structure, should be assigned a parent
>   *			and owner
> + * @ioctl_handlers:	[INTERN] list of registered ioctl handlers
>   * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
>   * @buffer:		[DRIVER] any buffer present
>   * @buffer_list:	[INTERN] list of all buffers currently attached
> @@ -529,6 +530,7 @@ struct iio_dev {
>  	int				modes;
>  	int				currentmode;
>  	struct device			dev;
> +	struct list_head		ioctl_handlers;
>  
>  	struct iio_event_interface	*event_interface;
>  

