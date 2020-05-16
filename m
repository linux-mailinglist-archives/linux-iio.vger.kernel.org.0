Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3472C1D630D
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 19:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgEPR3A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 13:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgEPR3A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 13:29:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E3F2065C;
        Sat, 16 May 2020 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589650139;
        bh=FREwCly6qAzOw81QKThCltYxhhLED8N4pFnBMguHrOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bNZYYZLBEZcQV7hnY7LN3GyH9FSsAxIlXEZ1dTEfe07tuQkJXViqkumDFV9W4Lyu4
         AiyKueCixjnhzEFpKQpms9D15qBCAiOzrCvS5p2AZ6CWpJYoO0KRYtssgRSBMVLKlp
         0Wl5vPBc4+sfMUMIhwI6ZXRh7R/LJiNc7YVgFl3Q=
Date:   Sat, 16 May 2020 18:28:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>
Subject: Re: [PATCH v2 6/8] iio: core: wrap IIO device into an
 iio_dev_opaque object
Message-ID: <20200516182854.3c5aa285@archlinux>
In-Reply-To: <20200514131710.84201-7-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
        <20200514131710.84201-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 16:17:08 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> There are plenty of bad designs we want to discourage or not have to review
> manually usually about accessing private (marked as [INTERN]) fields of
> 'struct iio_dev'.
> 
> Sometimes users copy drivers that are not always the best examples.
> 
> A better idea is to hide those fields into the framework.
> For 'struct iio_dev' this is a 'struct iio_dev_opaque' which wraps a public
> 'struct iio_dev' object.
> 
> In the next series, some fields will be moved to this new struct, each with
> it's own rework.
> 
> This rework will not be complete-able for a while, as many fields need some
> drivers to be reworked in order to finalize them (e.g. 'indio_dev->mlock').
> 
> But some fields can already be moved, and in time, all of them may get
> there (in the 'struct iio_dev_opaque' object).

Hopefully!  This is very nice.  One trivial comment inline.

> 
> Since a lot of drivers also call 'iio_priv()', in order to preserve
> fast-paths (where this matters), the public iio_dev object will have a
> 'priv' field that will have the pointer to the private information already
> computed. The reference returned by this field should be guaranteed to be
> cacheline aligned.
> 
> As for the 'iio_priv_to_dev()' helper, this needs to be hidden away. There
> aren't many users of this helper, and arguably drivers shouldn't need to
> use it in any fast-paths, as they can maintain a reference to the IIO
> device.
> 
> The opaque parts will be moved into the 'include/linux/iio/iio-opaque.h'
> header. Should the hidden information be required for some debugging or
> some special needs, it can be made available via this header.
> Otherwise, only the IIO core files should include this file.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 27 ++++++++++++++++++++++-----
>  include/linux/iio/iio-opaque.h  | 17 +++++++++++++++++
>  include/linux/iio/iio.h         | 11 +++++------
>  3 files changed, 44 insertions(+), 11 deletions(-)
>  create mode 100644 include/linux/iio/iio-opaque.h
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 462d3e810013..a1b29e0f8fd6 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -25,6 +25,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/mutex.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/iio-opaque.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
>  #include <linux/iio/sysfs.h>
> @@ -164,6 +165,15 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
>  };
>  
> +struct iio_dev *iio_priv_to_dev(void *priv)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque =
> +		(struct iio_dev_opaque *)((char *)priv -
> +				  ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN));
> +	return &iio_dev_opaque->indio_dev;
> +}
> +EXPORT_SYMBOL_GPL(iio_priv_to_dev);
> +
>  /**
>   * iio_find_channel_from_si() - get channel from its scan index
>   * @indio_dev:		device
> @@ -1476,6 +1486,8 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
>  static void iio_dev_release(struct device *device)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(device);
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
>  	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
>  		iio_device_unregister_trigger_consumer(indio_dev);
>  	iio_device_unregister_eventset(indio_dev);
> @@ -1484,7 +1496,7 @@ static void iio_dev_release(struct device *device)
>  	iio_buffer_put(indio_dev->buffer);
>  
>  	ida_simple_remove(&iio_ida, indio_dev->id);
> -	kfree(indio_dev);
> +	kfree(iio_dev_opaque);
>  }
>  
>  struct device_type iio_device_type = {
> @@ -1498,10 +1510,11 @@ struct device_type iio_device_type = {
>   **/
>  struct iio_dev *iio_device_alloc(int sizeof_priv)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque;
>  	struct iio_dev *dev;
>  	size_t alloc_size;
>  
> -	alloc_size = sizeof(struct iio_dev);
> +	alloc_size = sizeof(struct iio_dev_opaque);
>  	if (sizeof_priv) {
>  		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
>  		alloc_size += sizeof_priv;
> @@ -1509,10 +1522,14 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  	/* ensure 32-byte alignment of whole construct ? */
>  	alloc_size += IIO_ALIGN - 1;
>  
> -	dev = kzalloc(alloc_size, GFP_KERNEL);
> -	if (!dev)
> +	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!iio_dev_opaque)
>  		return NULL;
>  
> +	dev = &iio_dev_opaque->indio_dev;
> +	dev->priv = (char *)iio_dev_opaque +
> +		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
> +
>  	dev->dev.groups = dev->groups;
>  	dev->dev.type = &iio_device_type;
>  	dev->dev.bus = &iio_bus_type;
> @@ -1526,7 +1543,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  	if (dev->id < 0) {
>  		/* cannot use a dev_err as the name isn't available */
>  		pr_err("failed to get device id\n");
> -		kfree(dev);
> +		kfree(iio_dev_opaque);
>  		return NULL;
>  	}
>  	dev_set_name(&dev->dev, "iio:device%d", dev->id);
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> new file mode 100644
> index 000000000000..1375674f14cd
> --- /dev/null
> +++ b/include/linux/iio/iio-opaque.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _INDUSTRIAL_IO_OPAQUE_H_
> +#define _INDUSTRIAL_IO_OPAQUE_H_
> +
> +/**
> + * struct iio_dev_opaque - industrial I/O device opaque information
> + * @indio_dev:			public industrial I/O device information
> + */
> +struct iio_dev_opaque {
> +	struct iio_dev			indio_dev;
> +};
> +
> +#define to_iio_dev_opaque(indio_dev)		\
> +	container_of(indio_dev, struct iio_dev_opaque, indio_dev)
> +
> +#endif
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 5f9f439a4f01..e82693db6578 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -522,6 +522,7 @@ struct iio_buffer_setup_ops {
>   * @flags:		[INTERN] file ops related flags including busy flag.
>   * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
>   * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
> + * @priv:		[DRIVER] reference to driver's private information
Add a note to this to say it should be accessed only through the
iio_priv() route.  Whilst it's not opaque we might in theory change
what it does sometime in the future - just like we are doing here :)

>   */
>  struct iio_dev {
>  	int				id;
> @@ -571,6 +572,7 @@ struct iio_dev {
>  	char				read_buf[20];
>  	unsigned int			read_buf_len;
>  #endif
> +	void				*priv;
>  };
>  
>  const struct iio_chan_spec
> @@ -678,16 +680,13 @@ static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
>  #define IIO_ALIGN L1_CACHE_BYTES
>  struct iio_dev *iio_device_alloc(int sizeof_priv);
>  
> +/* The information at this reference is guaranteed to be cacheline aligned */
>  static inline void *iio_priv(const struct iio_dev *indio_dev)
>  {
> -	return (char *)indio_dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
> +	return indio_dev->priv;
>  }
>  
> -static inline struct iio_dev *iio_priv_to_dev(void *priv)
> -{
> -	return (struct iio_dev *)((char *)priv -
> -				  ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
> -}
> +struct iio_dev *iio_priv_to_dev(void *priv);
>  
>  void iio_device_free(struct iio_dev *indio_dev);
>  struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);

