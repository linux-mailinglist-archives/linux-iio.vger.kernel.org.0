Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1623D4862
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGXPAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 11:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXO77 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 10:59:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F7360EAF;
        Sat, 24 Jul 2021 15:40:29 +0000 (UTC)
Date:   Sat, 24 Jul 2021 16:43:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        denis.ciocca@st.com
Subject: Re: [PATCH 1/4] iio: pressure: st_pressure: use
 devm_iio_triggered_buffer_setup() for buffer
Message-ID: <20210724164301.54008712@jic23-huawei>
In-Reply-To: <20210720074642.223293-1-aardelean@deviqon.com>
References: <20210720074642.223293-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Jul 2021 10:46:39 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> The st_press_allocate_ring() function calls iio_triggered_buffer_setup() to
> allocate a triggered buffer.
> 
> But the same can be done with devm_iio_triggered_buffer_setup() and then
> the st_press_common_remove() no longer needs to manually deallocate it.
> 
> We know that the parent of the IIO device is used to manage other instances
> of the devm unwind, so it can be used in the st_press_allocate_ring() as
> well.

This raises an interesting point.  This driver mixes and matches between
hanging devm off the parent and off the iio_dev->dev.

That's probably not a good thing to do as it could lead to an odd unwind
order.  I'm pretty sure the changes here are fine, but we should take
a closer look...

Series applied to the togreg branch of iio.git and pushed out as testing.

You can do the same thing with the trigger with only slightly more complex
patch, but I'd like to discuss whether there are races because of the current
dev mix and match before that.

Thanks,

Jonathan


> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/iio/pressure/st_pressure.h        | 5 -----
>  drivers/iio/pressure/st_pressure_buffer.c | 9 ++-------
>  drivers/iio/pressure/st_pressure_core.c   | 6 +-----
>  3 files changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
> index 9417b3bd7513..156e6a72dc5c 100644
> --- a/drivers/iio/pressure/st_pressure.h
> +++ b/drivers/iio/pressure/st_pressure.h
> @@ -43,7 +43,6 @@ static __maybe_unused const struct st_sensors_platform_data default_press_pdata
>  
>  #ifdef CONFIG_IIO_BUFFER
>  int st_press_allocate_ring(struct iio_dev *indio_dev);
> -void st_press_deallocate_ring(struct iio_dev *indio_dev);
>  int st_press_trig_set_state(struct iio_trigger *trig, bool state);
>  #define ST_PRESS_TRIGGER_SET_STATE (&st_press_trig_set_state)
>  #else /* CONFIG_IIO_BUFFER */
> @@ -51,10 +50,6 @@ static inline int st_press_allocate_ring(struct iio_dev *indio_dev)
>  {
>  	return 0;
>  }
> -
> -static inline void st_press_deallocate_ring(struct iio_dev *indio_dev)
> -{
> -}
>  #define ST_PRESS_TRIGGER_SET_STATE NULL
>  #endif /* CONFIG_IIO_BUFFER */
>  
> diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
> index b651e7c31e90..25dbd5476b26 100644
> --- a/drivers/iio/pressure/st_pressure_buffer.c
> +++ b/drivers/iio/pressure/st_pressure_buffer.c
> @@ -41,13 +41,8 @@ static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
>  
>  int st_press_allocate_ring(struct iio_dev *indio_dev)
>  {
> -	return iio_triggered_buffer_setup(indio_dev, NULL,
> -		&st_sensors_trigger_handler, &st_press_buffer_setup_ops);
> -}
> -
> -void st_press_deallocate_ring(struct iio_dev *indio_dev)
> -{
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +		NULL, &st_sensors_trigger_handler, &st_press_buffer_setup_ops);
>  }
>  
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 4ff6d40e3670..ab1c17fac807 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -718,7 +718,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  		err = st_sensors_allocate_trigger(indio_dev,
>  						  ST_PRESS_TRIGGER_OPS);
>  		if (err < 0)
> -			goto st_press_probe_trigger_error;
> +			return err;
>  	}
>  
>  	err = iio_device_register(indio_dev);
> @@ -733,8 +733,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  st_press_device_register_error:
>  	if (press_data->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
> -st_press_probe_trigger_error:
> -	st_press_deallocate_ring(indio_dev);
>  	return err;
>  }
>  EXPORT_SYMBOL(st_press_common_probe);
> @@ -746,8 +744,6 @@ void st_press_common_remove(struct iio_dev *indio_dev)
>  	iio_device_unregister(indio_dev);
>  	if (press_data->irq > 0)
>  		st_sensors_deallocate_trigger(indio_dev);
> -
> -	st_press_deallocate_ring(indio_dev);
>  }
>  EXPORT_SYMBOL(st_press_common_remove);
>  

