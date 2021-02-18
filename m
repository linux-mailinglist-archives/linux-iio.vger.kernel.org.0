Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0931EB93
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhBRP3Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhBRNn2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 08:43:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B314F64E33;
        Thu, 18 Feb 2021 13:42:43 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:42:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 2/5] iio: Add output buffer support
Message-ID: <20210218134240.2dd1feb2@archlinux>
In-Reply-To: <20210217083438.37865-3-alexandru.ardelean@analog.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
        <20210217083438.37865-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Feb 2021 10:34:35 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Currently IIO only supports buffer mode for capture devices like ADCs. Add
> support for buffered mode for output devices like DACs.
> 
> The output buffer implementation is analogous to the input buffer
> implementation. Instead of using read() to get data from the buffer write()
> is used to copy data into the buffer.
> 
> poll() with POLLOUT will wakeup if there is space available for more or
> equal to the configured watermark of samples.
> 
> Drivers can remove data from a buffer using iio_buffer_remove_sample(), the
> function can e.g. called from a trigger handler to write the data to
> hardware.
> 
> A buffer can only be either a output buffer or an input, but not both. So,
> for a device that has an ADC and DAC path, this will mean 2 IIO buffers
> (one for each direction).
> 
> The direction of the buffer is decided by the new direction field of the
> iio_buffer struct and should be set after allocating and before registering
> it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Just one question on this, otherwise looks good to me.

Jonathan

> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5d641f8adfbd..b9970c68005d 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -162,6 +162,69 @@ static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
>  	return ret;
>  }
>  
...

>  /**
>   * iio_buffer_poll() - poll the buffer to find out if it has data
>   * @filp:	File structure pointer for device access
> @@ -182,8 +245,19 @@ static __poll_t iio_buffer_poll(struct file *filp,
>  		return 0;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> -		return EPOLLIN | EPOLLRDNORM;
> +
> +	switch (rb->direction) {
> +	case IIO_BUFFER_DIRECTION_IN:
> +		if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> +			return EPOLLIN | EPOLLRDNORM;
> +		break;
> +	case IIO_BUFFER_DIRECTION_OUT:
> +		if (iio_buffer_space_available(rb) >= rb->watermark)
> +			return EPOLLOUT | EPOLLWRNORM;
> +		break;
> +	}
> +
> +	/* need a way of knowing if there may be enough data... */

Curious on what this comment is referring to?

>  	return 0;
>  }
>  
> @@ -232,6 +306,16 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
>  	}
>  }
...
