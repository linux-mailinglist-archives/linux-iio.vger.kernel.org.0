Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD23F4BDE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhHWNvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWNvA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 09:51:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC2C061575;
        Mon, 23 Aug 2021 06:50:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u1so10622111wmm.0;
        Mon, 23 Aug 2021 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5JF0lritc5Wnxvs3QUU/+T6qW2pQ6R1WLXh8VafXvC4=;
        b=H0Cll/BM1boUOzeFyc9824QmbIuzGdmzzWullg90hrMst3WaLmD+xkOu/1lel24TjQ
         Jgkac6DoXZOFaAaIU+qqv70YGtO1b5EdjS8aEUaO/4MG1Fo+hI/3qA59e/VdCQ/MJip6
         aFlerxiey7/yYdR33LHdD4xTYlTZvGDGxMCHZc6V37EaWJFm4UZkDvwf/otiGGOXffiv
         H+027AiBI/uKmeaF2wEewZP7GA8gxmvRkZu5ZBVErS2uwpwviXReYAQbxFB7/OBTrDDb
         xviyfam1MpkLOdiONcZgumlwteWqfxEfGZkzHPwbNNSzSM7ChAleSQuyJRlxiY53fvUn
         wepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5JF0lritc5Wnxvs3QUU/+T6qW2pQ6R1WLXh8VafXvC4=;
        b=iNcaD4J1ixvOm9xacXF/fTJY782xokZPnsQDdT5SPN+2EnHeXED8TwT/iI+UY2SQTy
         1+yNR1/nYcmTXXQSTsOaon3PzzMRaFxsE6g4mZ9y9g+X/RJzUUPc8LQqOiFlH0GhV/Ia
         nlkuJS+KcujLwPps2U/H+QH6TKzJdn1nriaH0A7VeJff0vgnBOf3BVcqFOUZnwB43oAM
         av7T5eF+UWuYA3jWGitSDfvMpRL8IET9/w0F3wrY3YhS1cTjNZNUjzrv3zxIqSOEcj8D
         dmTO8AeQZIMXZUV+ezEISFd+LbpkBUJGQxFiUfm1fBNxKJXzKSQ7FP/vBE6AzIL6PQPV
         awdQ==
X-Gm-Message-State: AOAM533kXCA0pv/icBNpKD8HTm1P1MLaRvWA4piadkwNxSfacUzXCJZW
        93WYUJotDbmD7DuI2Rb8EE0=
X-Google-Smtp-Source: ABdhPJy4UKdgF53uteNC0TxGzCSZnpxSZvDuLjwPANf9ikvliOuWZY5gJSBWPxVeb6q/J56Rl40x+g==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr2177767wmh.66.1629726616620;
        Mon, 23 Aug 2021 06:50:16 -0700 (PDT)
Received: from nunojsa-N551JK ([2001:a61:2531:cb01:1061:e4b5:709f:d9ad])
        by smtp.googlemail.com with ESMTPSA id b4sm4407899wrp.33.2021.08.23.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:50:16 -0700 (PDT)
Message-ID: <2a67cb8ee77cb96bc899d82348cb0eb0bf44925c.camel@gmail.com>
Subject: Re: [PATCH v4 1/6] iio: Add output buffer support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Mihail Chindris <mihail.chindris@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com
Date:   Mon, 23 Aug 2021 15:50:14 +0200
In-Reply-To: <20210820165927.4524-2-mihail.chindris@analog.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
         <20210820165927.4524-2-mihail.chindris@analog.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-08-20 at 16:59 +0000, Mihail Chindris wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Currently IIO only supports buffer mode for capture devices like
> ADCs. Add
> support for buffered mode for output devices like DACs.
> 
> The output buffer implementation is analogous to the input buffer
> implementation. Instead of using read() to get data from the buffer
> write()
> is used to copy data into the buffer.
> 
> poll() with POLLOUT will wakeup if there is space available for more
> or
> equal to the configured watermark of samples.
> 
> Drivers can remove data from a buffer using
> iio_buffer_remove_sample(), the
> function can e.g. called from a trigger handler to write the data to
> hardware.
> 
> A buffer can only be either a output buffer or an input, but not
> both. So,
> for a device that has an ADC and DAC path, this will mean 2 IIO
> buffers
> (one for each direction).
> 
> The direction of the buffer is decided by the new direction field of
> the
> iio_buffer struct and should be set after allocating and before
> registering
> it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  drivers/iio/iio_core.h            |   4 +
>  drivers/iio/industrialio-buffer.c | 133
> +++++++++++++++++++++++++++++-
>  drivers/iio/industrialio-core.c   |   1 +
>  include/linux/iio/buffer.h        |   7 ++
>  include/linux/iio/buffer_impl.h   |  11 +++
>  5 files changed, 154 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 8f4a9b264962..61e318431de9 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file
> *filp,
>  				 struct poll_table_struct *wait);
>  ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
>  				size_t n, loff_t *f_ps);
> +ssize_t iio_buffer_write_wrapper(struct file *filp, const char
> __user *buf,
> +				 size_t n, loff_t *f_ps);
>  
>  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
>  void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
>  
>  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
>  #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
>  
>  void iio_disable_all_buffers(struct iio_dev *indio_dev);
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> @@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev
> *indio_dev);
>  
>  #define iio_buffer_poll_addr NULL
>  #define iio_buffer_read_outer_addr NULL
> +#define iio_buffer_write_outer_addr NULL
>  
>  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> *indio_dev)
>  {
> diff --git a/drivers/iio/industrialio-buffer.c
> b/drivers/iio/industrialio-buffer.c
> index a95cc2da56be..73d4451a0572 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -161,6 +161,69 @@ static ssize_t iio_buffer_read(struct file
> *filp, char __user *buf,
>  	return ret;
>  }
>  
> +static size_t iio_buffer_space_available(struct iio_buffer *buf)
> +{
> +	if (buf->access->space_available)
> +		return buf->access->space_available(buf);
> +
> +	return SIZE_MAX;
> +}
> +
> +static ssize_t iio_buffer_write(struct file *filp, const char __user
> *buf,
> +				size_t n, loff_t *f_ps)
> +{
> +	struct iio_dev_buffer_pair *ib = filp->private_data;
> +	struct iio_buffer *rb = ib->buffer;
> +	struct iio_dev *indio_dev = ib->indio_dev;
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +	size_t datum_size;
> +	size_t to_wait;
> +	int ret;
> +

Even though I do not agree that this is suficient, we should have the
same check as we have for input buffer:


if (!indio_dev->info)
	return -ENODEV;

> +	if (!rb || !rb->access->write)
> +		return -EINVAL;
> +
> +	datum_size = rb->bytes_per_datum;
> +
> +	/*
> +	 * If datum_size is 0 there will never be anything to read from
> the
> +	 * buffer, so signal end of file now.
> +	 */
> +	if (!datum_size)
> +		return 0;
> +
> +	if (filp->f_flags & O_NONBLOCK)
> +		to_wait = 0;
> +	else
> +		to_wait = min_t(size_t, n / datum_size, rb->watermark);
> +

I had a bit of a crazy thought... Typically, output devices do not
really have a typical trigger as we are used to have in input devices.
Hence, typically we just use a hrtimer (maybe a pwm-trigger can also be
added) trigger where we kind of poll the buffer for new data to send to
the device. So, I was wondering if we could just optionally bypass the
kbuf path in output devices (via some optional buffer option)? At this
point, we pretty much already know that we have data to consume :).
This would be kind of a synchronous interface. One issue I see with
this is that we cannot really have a deterministic (or close) sampling
frequency as we have for example with a pwm based trigger.

Anyways, just me throwing some ideas. This is not the most important
thing for now...

- Nuno Sá 
> 

