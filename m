Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7346141887A
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhIZMEY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 08:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZMEX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 08:04:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99AAC60E73;
        Sun, 26 Sep 2021 12:02:45 +0000 (UTC)
Date:   Sun, 26 Sep 2021 13:06:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Message-ID: <20210926130634.012eb555@jic23-huawei>
In-Reply-To: <20210923082319.1510936-1-drhunter95@gmail.com>
References: <20210923082319.1510936-1-drhunter95@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Sep 2021 09:23:16 +0100
Iain Hunter <drhunter95@gmail.com> wrote:

> From: Iain Hunter <iain@hunterembedded.co.uk>
> 
> That change adds an error check to avoid saturation during multiplication
> to calculate nano seconds in timespec64_to_ns(). This function was changed
> in kernel 5.4.
> In ina2xx_capture_thread() a timespec64 structure is used to calculate
> the delta time until the next sample time. This delta can be negative if
> the next sample time was in the past. In the -1 case timespec64_to_ns()
> now clamps the -1 second value to KTIME_MAX. This essentially puts ina2xx
> thread to sleep forever.
> Proposed patch is to split the functionality in the loop into two parts:
> - do while loop only does the test to see if the next sample time is in 
> the future or in the past and so will be skipped and the sample time 
> incremented until it is in the future. This comparision can be done with 
> timespec64_compare() as we are only interested in the sign being positive
> or negative.
> The variable skip_next_sample is only used for clarity.
> - after do while loop we know that next is later than now and so delta is
> guaranteed to be positive. This means timespec64_to_ns() can be safely
> used.
> 
> Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>
> 
> Fixes: regression introduced by
>  cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")

Please check how to format a fixes tag.  As they are used in automated tooling
it must be exactly what is documented in 
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

Approach looks sound but I think we can simplify things a little.
 
> ---
>  drivers/iio/adc/ina2xx-adc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index a4b2ff9e0..e30012d0d 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -777,6 +777,7 @@ static int ina2xx_capture_thread(void *data)
>  	int ret;
>  	struct timespec64 next, now, delta;
>  	s64 delay_us;
> +	int skip_next_sample;
>  
>  	/*
>  	 * Poll a bit faster than the chip internal Fs, in case
> @@ -817,10 +818,15 @@ static int ina2xx_capture_thread(void *data)
>  		 */
>  		do {
>  			timespec64_add_ns(&next, 1000 * sampling_us);
> -			delta = timespec64_sub(next, now);
> -			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
> -		} while (delay_us <= 0);
>  
> +			if (timespec64_compare(&next, &now) < 0)
> +				skip_next_sample = 1;
> +			else
> +				skip_next_sample = 0;
> +		} while (skip_next_sample);
the local variable doesn't add much and should be a boolean given it can only take
true or false.


		do {
 			timespec64_add_ns(&next, 1000 * sampling_us);
		} while (timespec64_compare(&next, &now) < 0);

Is probably the neatest option.

> +
> +		delta = timespec64_sub(next, now);
> +		delay_us = div_s64(timespec64_to_ns(&delta), 1000);
>  		usleep_range(delay_us, (delay_us * 3) >> 1);
>  
>  	} while (!kthread_should_stop());

