Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE11B8EC4
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDZKNZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 06:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgDZKNY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 06:13:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885D92071C;
        Sun, 26 Apr 2020 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587896004;
        bh=1cWDQP0s2+fYYrSZYVp+68bqnDG0dyqqgx1rErB5KIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fc4a8QKBNnrkxTlItHyYEAV72HA/seikZrQxNpEgWKBYqpuTLgVHDQP+OzaD5hJGu
         s8pGO7uwi+O1MjDqR+DNIisAkfxeWlgshLiYbVCRtbJyKPf3Q9xjfsnTxwP9Ye7qIn
         zwcl5pSLS22Ut5L/bLd+wiAykm70pu0Pn49N5CsQ=
Date:   Sun, 26 Apr 2020 11:13:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 6/6] iio: core: use new common ioctl() mechanism
Message-ID: <20200426111320.50d3a0df@archlinux>
In-Reply-To: <20200426073817.33307-7-alexandru.ardelean@analog.com>
References: <20200426073817.33307-1-alexandru.ardelean@analog.com>
        <20200426073817.33307-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Apr 2020 10:38:17 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change makes use of the new centralized ioctl() mechanism. The event
> interface registers it's ioctl() handler to IIO device.
> Both the buffer & event interface call 'iio_device_ioctl()', which should
> take care of all of indio_dev's ioctl() calls.
> 
> Later, we may add per-buffer ioctl() calls, and since each buffer will get
> it's own chardev, the buffer ioctl() handler will need a bit of tweaking
> for the first/legacy buffer (i.e. indio_dev->buffer).
> Also, those per-buffer ioctl() calls will not be registered with this
> mechanism.

Seems sensible to me.

J
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/iio_core.h            |  3 ---
>  drivers/iio/industrialio-buffer.c |  2 +-
>  drivers/iio/industrialio-event.c  | 14 ++++++++------
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 34c3e19229d8..f68de4af2738 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -54,9 +54,6 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
>  #ifdef CONFIG_IIO_BUFFER
>  struct poll_table_struct;
>  
> -long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
> -			    unsigned int cmd, unsigned long arg);
> -
>  void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev);
>  
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index f5a975079bf4..43281c77ca22 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1179,7 +1179,7 @@ static long iio_buffer_ioctl(struct file *filep, unsigned int cmd,
>  	if (!buffer || !buffer->access)
>  		return -ENODEV;
>  
> -	return iio_device_event_ioctl(buffer->indio_dev, filep, cmd, arg);
> +	return iio_device_ioctl(buffer->indio_dev, filep, cmd, arg);
>  }
>  
>  static ssize_t iio_buffer_store_enable(struct device *dev,
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 0674b2117c98..1961c1d19370 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -32,6 +32,7 @@
>   * @read_lock:		lock to protect kfifo read operations
>   * @chrdev:		associated chardev for this event
>   * @indio_dev:		IIO device to which this event interface belongs to
> + * @ioctl_handler:	handler for event ioctl() calls
>   */
>  struct iio_event_interface {
>  	wait_queue_head_t	wait;
> @@ -44,6 +45,7 @@ struct iio_event_interface {
>  
>  	struct cdev		chrdev;
>  	struct iio_dev		*indio_dev;
> +	struct iio_ioctl_handler	ioctl_handler;
>  };
>  
>  bool iio_event_enabled(const struct iio_event_interface *ev_int)
> @@ -261,15 +263,12 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
> +static long iio_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
>  			    unsigned int cmd, unsigned long arg)
>  {
>  	int __user *ip = (int __user *)arg;
>  	int fd;
>  
> -	if (!indio_dev->info)
> -		return -ENODEV;
> -
>  	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
>  		fd = iio_event_getfd(indio_dev);
>  		if (fd < 0)
> @@ -278,7 +277,7 @@ long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
>  			return -EFAULT;
>  		return 0;
>  	}
> -	return -EINVAL;
> +	return IIO_IOCTL_UNHANDLED;
>  }
>  
>  static long iio_event_ioctl_wrapper(struct file *filp, unsigned int cmd,
> @@ -286,7 +285,7 @@ static long iio_event_ioctl_wrapper(struct file *filp, unsigned int cmd,
>  {
>  	struct iio_event_interface *ev = filp->private_data;
>  
> -	return iio_device_event_ioctl(ev->indio_dev, filp, cmd, arg);
> +	return iio_device_ioctl(ev->indio_dev, filp, cmd, arg);
>  }
>  
>  static const struct file_operations iio_event_fileops = {
> @@ -308,7 +307,10 @@ void iio_device_event_attach_chrdev(struct iio_dev *indio_dev)
>  	cdev_init(&ev->chrdev, &iio_event_fileops);
>  
>  	ev->indio_dev = indio_dev;
> +	ev->ioctl_handler.ioctl = iio_event_ioctl;
>  	indio_dev->chrdev = &ev->chrdev;
> +
> +	iio_device_ioctl_handler_register(indio_dev, &ev->ioctl_handler);
>  }
>  
>  static const char * const iio_ev_type_text[] = {

