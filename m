Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B227341DE9B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349332AbhI3QQg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 12:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349188AbhI3QQf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:16:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94ED613CD;
        Thu, 30 Sep 2021 16:14:49 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:18:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Iain Hunter <drhunter95@gmail.com>, lothar.felten@gmail.com,
        iain@hunterembedded.co.uk, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Message-ID: <20210930171844.0c67b0ff@jic23-huawei>
In-Reply-To: <87o88favd9.ffs@tglx>
References: <20210926171711.194901-1-drhunter95@gmail.com>
        <87o88favd9.ffs@tglx>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Sep 2021 23:18:42 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, Sep 26 2021 at 18:16, Iain Hunter wrote:
> > --- a/drivers/iio/adc/ina2xx-adc.c
> > +++ b/drivers/iio/adc/ina2xx-adc.c
> > @@ -817,10 +817,10 @@ static int ina2xx_capture_thread(void *data)
> >  		 */
> >  		do {
> >  			timespec64_add_ns(&next, 1000 * sampling_us);
> > -			delta = timespec64_sub(next, now);
> > -			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
> > -		} while (delay_us <= 0);
> > +		} while (timespec64_compare(&next, &now) < 0);
> >  
> > +		delta = timespec64_sub(next, now);
> > +		delay_us = div_s64(timespec64_to_ns(&delta), 1000);  
> 
> This whole timespec dance does not make any sense and can be completely
> avoided by using just scalar nanoseconds. Untested patch below.
> 
> Thanks,
> 
>         tglx

Thanks Thomas.

Iain could you test this approach?

Thanks,

Jonathan

> ---
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -775,7 +775,7 @@ static int ina2xx_capture_thread(void *d
>  	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>  	int sampling_us = SAMPLING_PERIOD(chip);
>  	int ret;
> -	struct timespec64 next, now, delta;
> +	ktime_t next, now, delta;
>  	s64 delay_us;
>  
>  	/*
> @@ -785,7 +785,7 @@ static int ina2xx_capture_thread(void *d
>  	if (!chip->allow_async_readout)
>  		sampling_us -= 200;
>  
> -	ktime_get_ts64(&next);
> +	next = ktime_get();
>  
>  	do {
>  		while (!chip->allow_async_readout) {
> @@ -798,7 +798,7 @@ static int ina2xx_capture_thread(void *d
>  			 * reset the reference timestamp.
>  			 */
>  			if (ret == 0)
> -				ktime_get_ts64(&next);
> +				next = ktime_get();
>  			else
>  				break;
>  		}
> @@ -807,7 +807,7 @@ static int ina2xx_capture_thread(void *d
>  		if (ret < 0)
>  			return ret;
>  
> -		ktime_get_ts64(&now);
> +		now = ktime_get();
>  
>  		/*
>  		 * Advance the timestamp for the next poll by one sampling
> @@ -816,11 +816,10 @@ static int ina2xx_capture_thread(void *d
>  		 * multiple times, i.e. samples are dropped.
>  		 */
>  		do {
> -			timespec64_add_ns(&next, 1000 * sampling_us);
> -			delta = timespec64_sub(next, now);
> -			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
> -		} while (delay_us <= 0);
> +			next = ktime_add_us(next, sampling_us);
> +		} while (next <= now);
>  
> +		delay_us = ktime_to_us(ktime_sub(next, now));
>  		usleep_range(delay_us, (delay_us * 3) >> 1);
>  
>  	} while (!kthread_should_stop());
> 
> 

