Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7301A6920
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgDMPs6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgDMPs5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 11:48:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF7E20732;
        Mon, 13 Apr 2020 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586792937;
        bh=GI8oUQTqeNL5OEaUer7XME0CVXB5RVlYqpbqKc7RGoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=odQgk7rrpMBK3dX2Pu0fZnpKtYmEmnMH2DWVx3d2STWi4G8I6dN5oOEi74O6yxzAT
         XWhsyvc6uFNtWL4iGIKqTb7sHQVIhJfo9X5N9ww5JaUCWl2055yVylJzR/0114hWW8
         8iVaZhN2nqyL3BiIF3kVxpq3Im0RJOA7MAQ4O8Eo=
Date:   Mon, 13 Apr 2020 16:48:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v3 2/5] iio: buffer: add back-ref from iio_buffer to
 iio_dev
Message-ID: <20200413164853.3bd73d25@archlinux>
In-Reply-To: <20200410141729.82834-3-alexandru.ardelean@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
        <20200410141729.82834-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Apr 2020 17:17:26 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> An IIO device will have multiple buffers, but it shouldn't be allowed that
> an IIO buffer should belong to more than 1 IIO device.
> 
> Once things get moved more from IIO device to the IIO buffer, and an IIO
> device will be able to have more than 1 buffer attached, there will be a
> need for a back-ref to the IIO device [from the IIO buffer].
> 
> This change adds that.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Much as I hate circular references, I can't see a way around this one...

> ---
>  drivers/iio/industrialio-buffer.c | 2 ++
>  include/linux/iio/buffer_impl.h   | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e6fa1a4e135d..f9ffc7762f6c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1478,5 +1478,7 @@ void iio_device_attach_buffer(struct iio_dev *indio_dev,
>  			      struct iio_buffer *buffer)
>  {
>  	indio_dev->buffer = iio_buffer_get(buffer);
> +
> +	indio_dev->buffer->indio_dev = indio_dev;
>  }
>  EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 1e7edf6bed96..8fb92250a190 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -69,6 +69,9 @@ struct iio_buffer_access_funcs {
>   * those writing new buffer implementations.
>   */
>  struct iio_buffer {
> +	/** @indio_dev: IIO device to which this buffer belongs to. */
> +	struct iio_dev *indio_dev;
> +
>  	/** @length: Number of datums in buffer. */
>  	unsigned int length;
>  

