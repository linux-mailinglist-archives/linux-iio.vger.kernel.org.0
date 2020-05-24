Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741051DFF2A
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEXNmA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 09:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEXNmA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 09:42:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C77C206D5;
        Sun, 24 May 2020 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590327719;
        bh=8eQG/BYGAjic6GRVvVa9VAujJMvySuULM0CvvRUSoWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ofrsYUDJy3fWUH87qiM1P8x3MXh32cNQ6zQQwdSyOnr9jOiGu4ykW5tMpdX7kL5nZ
         qvuWGZ930N/SAZxVnAdkqhG+mPqmauFslc2qjiefLZJphIcqEpcStPBjLERNmzeB2D
         H0DVUjOBJ+jCSltHoPSEOiIoPwSPrgXRsGLeOUME=
Date:   Sun, 24 May 2020 14:41:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <lorenzo.bianconi83@gmail.com>, <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] iio: Move attach/detach of the poll func to the
 core
Message-ID: <20200524144154.76fdfbdc@archlinux>
In-Reply-To: <20200522104632.517470-1-alexandru.ardelean@analog.com>
References: <20200522104632.517470-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 13:46:30 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> All devices using a triggered buffer need to attach and detach the trigger
> to the device in order to properly work. Instead of doing this in each and
> every driver by hand move this into the core.
> 
> At this point in time, all drivers should have been resolved to
> attach/detach the poll-function in the same order.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Looks good to me.

Jonathan


> ---
>  .../buffer/industrialio-triggered-buffer.c    | 10 +--------
>  drivers/iio/iio_core_trigger.h                | 17 ++++++++++++++
>  drivers/iio/industrialio-buffer.c             | 13 +++++++++++
>  drivers/iio/industrialio-trigger.c            | 22 ++++---------------
>  include/linux/iio/trigger_consumer.h          |  7 ------
>  5 files changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index e8046c1ecd6b..6c20a83f887e 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -13,11 +13,6 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> -static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -};
> -
>  /**
>   * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
>   * @indio_dev:		IIO device structure
> @@ -67,10 +62,7 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
>  	}
>  
>  	/* Ring buffer functions - here trigger setup related */
> -	if (setup_ops)
> -		indio_dev->setup_ops = setup_ops;
> -	else
> -		indio_dev->setup_ops = &iio_triggered_buffer_setup_ops;
> +	indio_dev->setup_ops = setup_ops;
>  
>  	/* Flag that polled ring buffering is possible */
>  	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
> index e59fe2f36bbb..9d1a92cc6480 100644
> --- a/drivers/iio/iio_core_trigger.h
> +++ b/drivers/iio/iio_core_trigger.h
> @@ -18,6 +18,12 @@ void iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
>   **/
>  void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
>  
> +
> +int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> +				 struct iio_poll_func *pf);
> +int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> +				 struct iio_poll_func *pf);
> +
>  #else
>  
>  /**
> @@ -37,4 +43,15 @@ static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
>  {
>  }
>  
> +static inline int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> +					       struct iio_poll_func *pf)
> +{
> +	return 0;
> +}
> +static inline int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> +					       struct iio_poll_func *pf)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_TRIGGER_CONSUMER */
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index ec4f531994fa..88d756107fb2 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
> +#include "iio_core_trigger.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
> @@ -972,6 +973,13 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  		}
>  	}
>  
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		ret = iio_trigger_attach_poll_func(indio_dev->trig,
> +						   indio_dev->pollfunc);
> +		if (ret)
> +			goto err_disable_buffers;
> +	}
> +
>  	return 0;
>  
>  err_disable_buffers:
> @@ -998,6 +1006,11 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  	if (list_empty(&indio_dev->buffer_list))
>  		return 0;
>  
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		iio_trigger_detach_poll_func(indio_dev->trig,
> +					     indio_dev->pollfunc);
> +	}
> +
>  	/*
>  	 * If things go wrong at some step in disable we still need to continue
>  	 * to perform the other steps, otherwise we leave the device in a
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 53d1931f6be8..6f16357fd732 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -239,8 +239,8 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
>   * the relevant function is in there may be the best option.
>   */
>  /* Worth protecting against double additions? */
> -static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> -					struct iio_poll_func *pf)
> +int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> +				 struct iio_poll_func *pf)
>  {
>  	int ret = 0;
>  	bool notinuse
> @@ -290,8 +290,8 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	return ret;
>  }
>  
> -static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> -					 struct iio_poll_func *pf)
> +int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> +				 struct iio_poll_func *pf)
>  {
>  	int ret = 0;
>  	bool no_other_users
> @@ -705,17 +705,3 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
>  	if (indio_dev->trig)
>  		iio_trigger_put(indio_dev->trig);
>  }
> -
> -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
> -{
> -	return iio_trigger_attach_poll_func(indio_dev->trig,
> -					    indio_dev->pollfunc);
> -}
> -EXPORT_SYMBOL(iio_triggered_buffer_postenable);
> -
> -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
> -{
> -	return iio_trigger_detach_poll_func(indio_dev->trig,
> -					     indio_dev->pollfunc);
> -}
> -EXPORT_SYMBOL(iio_triggered_buffer_predisable);
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index c3c6ba5ec423..3aa2f132dd67 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -50,11 +50,4 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
>  
>  void iio_trigger_notify_done(struct iio_trigger *trig);
>  
> -/*
> - * Two functions for common case where all that happens is a pollfunc
> - * is attached and detached from a trigger
> - */
> -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
> -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
> -
>  #endif

