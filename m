Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A441A6916
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgDMPrc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgDMPrb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 11:47:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB9120735;
        Mon, 13 Apr 2020 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586792850;
        bh=1kbI+L/FOBvyQlWHtEOqRSUxbelREV3uN+qV916OMhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EerhglLhkdcjrdNPG/aRGrsuRAIcQzU36TvUnEMoA/BZZ0R78JdNUtCyeEe5BHFDc
         yCIml7K8Nb+vjzIA8Rn+u2D0g97+FT4V7lOMS1rVvs3o8QGtyO08/3aZuT6gra4HK7
         3XDwpUWTX1rfvmnrm+3gZ/tQuMoZrP3p2x2W62JA=
Date:   Mon, 13 Apr 2020 16:47:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v3 1/5] iio: core: register buffer fileops only if
 buffer present
Message-ID: <20200413164726.5e5e2efd@archlinux>
In-Reply-To: <20200410141729.82834-2-alexandru.ardelean@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
        <20200410141729.82834-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Apr 2020 17:17:25 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The intent is to localize all buffer ops into the industrialio-buffer.c
> file, to be able to add support for multiple buffers per IIO device.
> 
> We still need to allocate a chardev in __iio_device_register() to be able
> to pass event ioctl commands. So, if the IIO device has no buffer, we
> create the legacy chardev for the event ioctl() command.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Whilst we are here, can we avoid allocating the chardev at all if
we have neither buffer support, nor events?  So don't add the chrdev to the device.

That covers quite a wide range of slow devices and is a nice incidental
improvement (to be honest I'd forgotten we actually created a chardev
in those circumstance :(

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 157d95a24faa..c8c074602709 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1707,6 +1707,15 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
> +static const struct file_operations iio_event_fileops = {
> +	.release = iio_chrdev_release,
> +	.open = iio_chrdev_open,
> +	.owner = THIS_MODULE,
> +	.llseek = noop_llseek,
> +	.unlocked_ioctl = iio_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
> +};
> +
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	int ret;
> @@ -1757,7 +1766,10 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->setup_ops == NULL)
>  		indio_dev->setup_ops = &noop_ring_setup_ops;
>  
> -	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	if (indio_dev->buffer)
> +		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	else
> +		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
>  
>  	indio_dev->chrdev.owner = this_mod;
>  

