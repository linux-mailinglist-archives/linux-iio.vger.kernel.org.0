Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E93300E7
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCGMhN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhCGMhC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 07:37:02 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBDF650FA;
        Sun,  7 Mar 2021 12:37:01 +0000 (UTC)
Date:   Sun, 7 Mar 2021 12:36:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: fix use-after-free for attached_buffers
 array
Message-ID: <20210307123658.3bdc0016@archlinux>
In-Reply-To: <20210306164710.9944-1-ardeleanalex@gmail.com>
References: <20210306164710.9944-1-ardeleanalex@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  6 Mar 2021 18:47:10 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> Thanks to Lars for finding this.
> The free of the 'attached_buffers' array should be done as late as
> possible. This change moves it to iio_buffers_put(), which looks like
> the best place for it, since it takes place right before the IIO device
> data is free'd.

It feels a bit wrong to do direct freeing of stuff in a _put() call
given that kind of implies nothing will happen without some reference
count dropping to 0.  We could think about renaming the function to
something like

iio_buffers_put_and_free_array() but is a bit long winded.

Otherwise, I'm fine with this but want to let it sit on list a tiny bit
longer before I take it as it's not totally trivial unlike the previous
one.

Jonathan
> The free of this array will be handled by calling iio_device_free().
> 
> It looks like this issue was ocurring on the error path of
> iio_buffers_alloc_sysfs_and_mask() and in
> iio_buffers_free_sysfs_and_mask()
> 
> Added a comment in the doc-header of iio_device_attach_buffer() to
> mention how this will be free'd in case anyone is reading the code
> and becoming confused about it.
> 
> Fixes: 36f3118c414d ("iio: buffer: introduce support for attaching more IIO buffers")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---
>  drivers/iio/industrialio-buffer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 1a415e97174e..3d0712651d43 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -336,6 +336,8 @@ void iio_buffers_put(struct iio_dev *indio_dev)
>  		buffer = iio_dev_opaque->attached_buffers[i];
>  		iio_buffer_put(buffer);
>  	}
> +
> +	kfree(iio_dev_opaque->attached_buffers);
>  }
>  
>  static ssize_t iio_show_scan_index(struct device *dev,
> @@ -1764,7 +1766,6 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
>  		__iio_buffer_free_sysfs_and_mask(buffer);
>  	}
> -	kfree(iio_dev_opaque->attached_buffers);
>  	return ret;
>  }
>  
> @@ -1786,8 +1787,6 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  		buffer = iio_dev_opaque->attached_buffers[i];
>  		__iio_buffer_free_sysfs_and_mask(buffer);
>  	}
> -
> -	kfree(iio_dev_opaque->attached_buffers);
>  }
>  
>  /**
> @@ -2062,6 +2061,8 @@ static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma)
>   * This function attaches a buffer to a IIO device. The buffer stays attached to
>   * the device until the device is freed. For legacy reasons, the first attached
>   * buffer will also be assigned to 'indio_dev->buffer'.
> + * The array allocated here, will be free'd via the iio_buffers_put() call,
> + * which is handled by the iio_device_free().
>   */
>  int iio_device_attach_buffer(struct iio_dev *indio_dev,
>  			     struct iio_buffer *buffer)

