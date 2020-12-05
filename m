Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF02CFDD6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgLESpF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgLEQtb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 11:49:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5649523341;
        Sat,  5 Dec 2020 16:36:21 +0000 (UTC)
Date:   Sat, 5 Dec 2020 16:36:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: dummy: convert all simple allocation devm_
 variants
Message-ID: <20201205163618.3b26334f@archlinux>
In-Reply-To: <20201203095005.72252-1-alexandru.ardelean@analog.com>
References: <20201203095005.72252-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Dec 2020 11:50:03 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since a main requirement for an IIO device is to have a parent device
> object, it makes sense to attach more of the IIO device's objects to the
> lifetime of the parent object, to clean up the code.
> The idea is to also provide a base example that is more up-to-date with
> what's going on lately with most IIO drivers.

To some degree maybe, it's also very very handy for testing odd corner
cases with.  I'd definitely not recommend it as a reference driver
because it inherently has some odd corners because we need to
fake various things that don't exist without hardware.

> 
> This change tackles the simple allocations, to convert them to
> device-managed calls, and tie them to the parent device.

I'm confused or maybe I missrecall how this works.

IIRC there isn't a parent device...

Maybe we could create one via a bit of smoke and magic.


> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 29 ++++++++--------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index c0b7ef900735..2a2e62f780a1 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -574,11 +574,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	 * parent = &client->dev;
>  	 */
>  
> -	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
> -	if (!swd) {
> -		ret = -ENOMEM;
> -		goto error_kzalloc;
> -	}
> +	swd = devm_kzalloc(parent, sizeof(*swd), GFP_KERNEL);
> +	if (!swd)
> +		return ERR_PTR(-ENOMEM);
>  	/*
>  	 * Allocate an IIO device.
>  	 *
> @@ -587,11 +585,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	 * It also has a region (accessed by iio_priv()
>  	 * for chip specific state information.
>  	 */
> -	indio_dev = iio_device_alloc(parent, sizeof(*st));
> -	if (!indio_dev) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(parent, sizeof(*st));
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);
>  
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
> @@ -615,7 +611,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	 *    indio_dev->name = id->name;
>  	 *    indio_dev->name = spi_get_device_id(spi)->name;
>  	 */
> -	indio_dev->name = kstrdup(name, GFP_KERNEL);
> +	indio_dev->name = devm_kstrdup(parent, name, GFP_KERNEL);
>  
>  	/* Provide description of available channels */
>  	indio_dev->channels = iio_dummy_channels;
> @@ -632,7 +628,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  
>  	ret = iio_simple_dummy_events_register(indio_dev);
>  	if (ret < 0)
> -		goto error_free_device;
> +		return ERR_PTR(ret);
>  
>  	ret = iio_simple_dummy_configure_buffer(indio_dev);
>  	if (ret < 0)
> @@ -649,11 +645,6 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	iio_simple_dummy_unconfigure_buffer(indio_dev);
>  error_unregister_events:
>  	iio_simple_dummy_events_unregister(indio_dev);
> -error_free_device:
> -	iio_device_free(indio_dev);
> -error_ret:
> -	kfree(swd);
> -error_kzalloc:
>  	return ERR_PTR(ret);
>  }
>  
> @@ -683,10 +674,6 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
>  
>  	iio_simple_dummy_events_unregister(indio_dev);
>  
> -	/* Free all structures */
> -	kfree(indio_dev->name);
> -	iio_device_free(indio_dev);
> -
>  	return 0;
>  }
>  

