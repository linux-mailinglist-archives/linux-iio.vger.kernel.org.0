Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4230F975
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhBDRUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 12:20:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2498 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbhBDRTR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 12:19:17 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWlWh0l6mz67kJW;
        Fri,  5 Feb 2021 01:13:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 18:18:34 +0100
Received: from localhost (10.47.65.115) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 17:18:33 +0000
Date:   Thu, 4 Feb 2021 17:17:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 02/11] iio: core: register chardev only if needed
Message-ID: <20210204171748.00002316@Huawei.com>
In-Reply-To: <20210201145105.20459-3-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-3-alexandru.ardelean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.115]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Feb 2021 16:50:56 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> We only need a chardev if we need to support buffers and/or events.
> 
> With this change, a chardev will be created only if an IIO buffer is
> attached OR an event_interface is configured.
> 
> Otherwise, no chardev will be created, and the IIO device will get
> registered with the 'device_add()' call.
> 
> Quite a lot of IIO devices don't really need a chardev, so this is a minor
> improvement to the IIO core, as the IIO device will take up (slightly)
> fewer resources.
> 
> In order to not create a chardev, we mostly just need to not initialize the
> indio_dev->dev.devt field. If that is un-initialized, cdev_device_add()
> behaves like device_add().
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Perhaps add a note to this description that it's 'sort' of a breaking ABI
change, but we don't believe it will affect any userspace code as they
likely check there is some point in opening the file before trying to do
so.

If we are wrong we can revert it but I doubt we are - subject to the normal
small fixable scripts people might be using and are happy to fix.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 7db761afa578..0a6fd299a978 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1761,6 +1761,15 @@ static const struct file_operations iio_buffer_fileops = {
>  	.release = iio_chrdev_release,
>  };
>  
> +static const struct file_operations iio_event_fileops = {
> +	.owner = THIS_MODULE,
> +	.llseek = noop_llseek,
> +	.unlocked_ioctl = iio_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.open = iio_chrdev_open,
> +	.release = iio_chrdev_release,
> +};
> +
>  static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  {
>  	int i, j;
> @@ -1788,6 +1797,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	int ret;
>  
>  	if (!indio_dev->info)
> @@ -1805,9 +1815,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* configure elements for the chrdev */
> -	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> -
>  	iio_device_register_debugfs(indio_dev);
>  
>  	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
> @@ -1836,9 +1843,15 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->setup_ops == NULL)
>  		indio_dev->setup_ops = &noop_ring_setup_ops;
>  
> -	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	if (indio_dev->buffer)
> +		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +	else if (iio_dev_opaque->event_interface)
> +		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
>  
> -	indio_dev->chrdev.owner = this_mod;
> +	if (indio_dev->buffer || iio_dev_opaque->event_interface) {
> +		indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> +		indio_dev->chrdev.owner = this_mod;
> +	}
>  
>  	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
>  	if (ret < 0)

