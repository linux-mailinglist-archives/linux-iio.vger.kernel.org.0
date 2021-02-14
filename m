Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913E031B133
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 17:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBNQYa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 11:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhBNQYa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 11:24:30 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09B564E26;
        Sun, 14 Feb 2021 16:23:48 +0000 (UTC)
Date:   Sun, 14 Feb 2021 16:23:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [RFC PATCH 2/5] iio: kfifo-buffer: Add output buffer support
Message-ID: <20210214162345.6f8f9ef0@archlinux>
In-Reply-To: <20210212102021.47276-3-alexandru.ardelean@analog.com>
References: <20210212102021.47276-1-alexandru.ardelean@analog.com>
        <20210212102021.47276-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 12:20:18 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Add output buffer support to the kfifo buffer implementation.
> 
> The implementation is straight forward and mostly just wraps the kfifo
> API to provide the required operations.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Nice.  For some reason I thought it would be more complex than this :)

Jonathan

> ---
>  drivers/iio/buffer/kfifo_buf.c | 50 ++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index 1359abed3b31..6e055176f969 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -138,10 +138,60 @@ static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
>  	kfree(kf);
>  }
>  
> +static size_t iio_kfifo_buf_space_available(struct iio_buffer *r)
> +{
> +	struct iio_kfifo *kf = iio_to_kfifo(r);
> +	size_t avail;
> +
> +	mutex_lock(&kf->user_lock);
> +	avail = kfifo_avail(&kf->kf);
> +	mutex_unlock(&kf->user_lock);
> +
> +	return avail;
> +}
> +
> +static int iio_kfifo_remove_from(struct iio_buffer *r, void *data)
> +{
> +	int ret;
> +	struct iio_kfifo *kf = iio_to_kfifo(r);
> +
> +	if (kfifo_size(&kf->kf) < r->bytes_per_datum)
> +		return -EBUSY;
> +
> +	ret = kfifo_out(&kf->kf, data, r->bytes_per_datum);
> +	if (ret != r->bytes_per_datum)
> +		return -EBUSY;
> +
> +	wake_up_interruptible_poll(&r->pollq, POLLOUT | POLLWRNORM);
> +
> +	return 0;
> +}
> +
> +static int iio_kfifo_write(struct iio_buffer *r, size_t n,
> +	const char __user *buf)
> +{
> +	struct iio_kfifo *kf = iio_to_kfifo(r);
> +	int ret, copied;
> +
> +	mutex_lock(&kf->user_lock);
> +	if (!kfifo_initialized(&kf->kf) || n < kfifo_esize(&kf->kf))
> +		ret = -EINVAL;
> +	else
> +		ret = kfifo_from_user(&kf->kf, buf, n, &copied);
> +	mutex_unlock(&kf->user_lock);
> +	if (ret)
> +		return ret;
> +
> +	return copied;
> +}
> +
>  static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  	.store_to = &iio_store_to_kfifo,
>  	.read = &iio_read_kfifo,
>  	.data_available = iio_kfifo_buf_data_available,
> +	.remove_from = &iio_kfifo_remove_from,
> +	.write = &iio_kfifo_write,
> +	.space_available = &iio_kfifo_buf_space_available,
>  	.request_update = &iio_request_update_kfifo,
>  	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
>  	.set_length = &iio_set_length_kfifo,

