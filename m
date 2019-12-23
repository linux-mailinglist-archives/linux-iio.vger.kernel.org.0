Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522541299A4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLWR4S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfLWR4S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:56:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF45220663;
        Mon, 23 Dec 2019 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577123776;
        bh=yrQnMjShbopg0bLw5sDOwNvBonKTjf3DqAeb/kRtbtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eE5DdpiMQyDypDav6CdCAqezqo0OBGlQdgXd+4FtUFHEwUYeOlA31cmqdION7EAtr
         BSvb5OdPmrfwCewCQprKDzGJ6qQeLZriw4gZsQvL6BnRNmS6HeogjGhgXN3xh1DqmX
         4oF3v1GsKynLvIQUK5iJ43LGoy/ZWGZi1lHFqKKs=
Date:   Mon, 23 Dec 2019 17:56:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: rename 'read_first_n' callback to 'read'
Message-ID: <20191223175612.19d300fb@archlinux>
In-Reply-To: <20191211104300.14113-1-alexandru.ardelean@analog.com>
References: <20191211104300.14113-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 12:43:00 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> It is implied that 'read' will read the first n bytes and not e.g. bytes
> only from offsets within the buffer that are a prime number.
> 
> This change is non-functional, mostly just a rename.
> A secondary intent with this patch is to make room later to add a write
> callback.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I spent a while trying to remember what the history behind this naming was.
Oh well, far too long ago :)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c       |  2 +-
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 +-
>  drivers/iio/buffer/kfifo_buf.c                     |  5 ++---
>  drivers/iio/iio_core.h                             |  8 ++++----
>  drivers/iio/industrialio-buffer.c                  | 10 +++++-----
>  drivers/iio/industrialio-core.c                    |  2 +-
>  include/linux/iio/buffer_impl.h                    |  6 ++----
>  7 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index 90cf6e586b10..a74bd9c0587c 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -476,7 +476,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
>   * @n: Number of bytes to read
>   * @user_buffer: Userspace buffer to copy the data to
>   *
> - * Should be used as the read_first_n callback for iio_buffer_access_ops
> + * Should be used as the read callback for iio_buffer_access_ops
>   * struct for DMA buffers.
>   */
>  int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index e0b92f3dec0e..7d298aaff1f0 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -108,7 +108,7 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
>  }
>  
>  static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
> -	.read_first_n = iio_dma_buffer_read,
> +	.read = iio_dma_buffer_read,
>  	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
>  	.set_length = iio_dma_buffer_set_length,
>  	.request_update = iio_dma_buffer_request_update,
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index e78fc0834e6b..3150f8ab984b 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -98,8 +98,7 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>  	return 0;
>  }
>  
> -static int iio_read_first_n_kfifo(struct iio_buffer *r,
> -			   size_t n, char __user *buf)
> +static int iio_read_kfifo(struct iio_buffer *r, size_t n, char __user *buf)
>  {
>  	int ret, copied;
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
> @@ -141,7 +140,7 @@ static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
>  
>  static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  	.store_to = &iio_store_to_kfifo,
> -	.read_first_n = &iio_read_first_n_kfifo,
> +	.read = &iio_read_kfifo,
>  	.data_available = iio_kfifo_buf_data_available,
>  	.request_update = &iio_request_update_kfifo,
>  	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 159ea3f8c02b..fd9a5f1d5e51 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -42,14 +42,14 @@ struct poll_table_struct;
>  
>  __poll_t iio_buffer_poll(struct file *filp,
>  			     struct poll_table_struct *wait);
> -ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
> -				      size_t n, loff_t *f_ps);
> +ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
> +			      size_t n, loff_t *f_ps);
>  
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
>  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
>  
>  #define iio_buffer_poll_addr (&iio_buffer_poll)
> -#define iio_buffer_read_first_n_outer_addr (&iio_buffer_read_first_n_outer)
> +#define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
>  
>  void iio_disable_all_buffers(struct iio_dev *indio_dev);
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> @@ -57,7 +57,7 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
>  #else
>  
>  #define iio_buffer_poll_addr NULL
> -#define iio_buffer_read_first_n_outer_addr NULL
> +#define iio_buffer_read_outer_addr NULL
>  
>  static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index c193d64e5217..dbbf0cf4cac9 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -87,7 +87,7 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>  }
>  
>  /**
> - * iio_buffer_read_first_n_outer() - chrdev read for buffer access
> + * iio_buffer_read_outer() - chrdev read for buffer access
>   * @filp:	File structure pointer for the char device
>   * @buf:	Destination buffer for iio buffer read
>   * @n:		First n bytes to read
> @@ -99,8 +99,8 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>   * Return: negative values corresponding to error codes or ret != 0
>   *	   for ending the reading activity
>   **/
> -ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
> -				      size_t n, loff_t *f_ps)
> +ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
> +			      size_t n, loff_t *f_ps)
>  {
>  	struct iio_dev *indio_dev = filp->private_data;
>  	struct iio_buffer *rb = indio_dev->buffer;
> @@ -112,7 +112,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  	if (!indio_dev->info)
>  		return -ENODEV;
>  
> -	if (!rb || !rb->access->read_first_n)
> +	if (!rb || !rb->access->read)
>  		return -EINVAL;
>  
>  	datum_size = rb->bytes_per_datum;
> @@ -147,7 +147,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  			continue;
>  		}
>  
> -		ret = rb->access->read_first_n(rb, n, buf);
> +		ret = rb->access->read(rb, n, buf);
>  		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
>  			ret = -EAGAIN;
>  	} while (ret == 0);
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f72c2dc5f703..5fd33644df1f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1617,7 +1617,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  }
>  
>  static const struct file_operations iio_buffer_fileops = {
> -	.read = iio_buffer_read_first_n_outer_addr,
> +	.read = iio_buffer_read_outer_addr,
>  	.release = iio_chrdev_release,
>  	.open = iio_chrdev_open,
>  	.poll = iio_buffer_poll_addr,
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index d1171db23742..a4d2d8061ef6 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -18,7 +18,7 @@ struct iio_buffer;
>  /**
>   * struct iio_buffer_access_funcs - access functions for buffers.
>   * @store_to:		actually store stuff to the buffer
> - * @read_first_n:	try to get a specified number of bytes (must exist)
> + * @read:		try to get a specified number of bytes (must exist)
>   * @data_available:	indicates how much data is available for reading from
>   *			the buffer.
>   * @request_update:	if a parameter change has been marked, update underlying
> @@ -45,9 +45,7 @@ struct iio_buffer;
>   **/
>  struct iio_buffer_access_funcs {
>  	int (*store_to)(struct iio_buffer *buffer, const void *data);
> -	int (*read_first_n)(struct iio_buffer *buffer,
> -			    size_t n,
> -			    char __user *buf);
> +	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
>  	size_t (*data_available)(struct iio_buffer *buffer);
>  
>  	int (*request_update)(struct iio_buffer *buffer);

