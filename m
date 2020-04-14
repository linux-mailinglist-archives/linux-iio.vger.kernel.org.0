Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94F51A8897
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503395AbgDNSGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503394AbgDNSGd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:06:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E524420767;
        Tue, 14 Apr 2020 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586887592;
        bh=Q3OyjLxd6V7sXDninaj5vQ+tDQMP5JCucrq9XJnj4jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJfNNloyUkTzPZ08qkeZmoG7gff5nYyrP/RIHx7/sptpDcvD9nTRsZ4oEVeVnu8YB
         MMNtNNnKdzCIOmnFtia5gA+Qi3QnXnuLPbUYsMvLEqQST6UjoNJSaHD6HxEfPNaebP
         klNdk8pAn2fzqFWUmYySCKFo7m3qozbVVS6aNjf8=
Date:   Tue, 14 Apr 2020 19:06:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
Message-ID: <20200414190629.2d85759e@archlinux>
In-Reply-To: <20200414083656.7696-1-alexandru.ardelean@analog.com>
References: <20200414083656.7696-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 11:36:56 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The final intent is to localize all buffer ops into the
> industrialio-buffer.c file, to be able to add support for multiple buffers
> per IIO device.
> 
> We only need a chardev if we need to support buffers and/or events.
> 
> With this change, a chardev will be created:
> 1. if there is an IIO buffer attached OR
> 2. if there is an event_interface configured
> 
> Otherwise, no chardev will be created.
> Quite a lot of IIO devices don't really need a chardev, so this is a minor
> improvement to the IIO core, as the IIO device will take up fewer
> resources.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v1 -> v2:
> * split away from series 'iio: core,buffer: re-organize chardev creation';
>   i'm getting the feeling that this has some value on it's own;
>   no idea if it needs 'Fixes' tag; it is a bit fuzzy to point to a patch
>   which this would be fixed by this; i'm guessing it would be fine
>   without one

I'd argue it's an 'optimization' rather than a fix :)

Still looks good to me but I'd like it to sit for a little while to
see if anyone points out something we are both missing!

Thanks for tidying this up.

Jonathan

> 
>  drivers/iio/industrialio-core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f4daf19f2a3b..32e72d9fd1e9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1676,6 +1676,15 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
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
> @@ -1726,7 +1735,10 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->setup_ops == NULL)
>  		indio_dev->setup_ops = &noop_ring_setup_ops;
>  
> -	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	if (indio_dev->buffer)
> +		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	else if (indio_dev->event_interface)
> +		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
>  
>  	indio_dev->chrdev.owner = this_mod;
>  
> @@ -1754,7 +1766,8 @@ EXPORT_SYMBOL(__iio_device_register);
>   **/
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
> -	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> +	if (indio_dev->buffer || indio_dev->event_interface)
> +		cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>  
>  	mutex_lock(&indio_dev->info_exist_lock);
>  

