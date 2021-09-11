Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD53407823
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhIKNXQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 09:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237521AbhIKNVO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 09:21:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42E861152;
        Sat, 11 Sep 2021 13:19:55 +0000 (UTC)
Date:   Sat, 11 Sep 2021 14:23:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Message-ID: <20210911142326.4acd95a1@jic23-huawei>
In-Reply-To: <20210911113645.2547272-1-drhunter95@gmail.com>
References: <20210911113645.2547272-1-drhunter95@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 Sep 2021 12:36:23 +0100
Iain Hunter <drhunter95@gmail.com> wrote:

> From: Iain Hunter <iain@hunterembedded.co.uk>
> 
> That change adds an error check to avoid saturation during multiplication
> to calculate nano seconds in timespec64_to_ns().
> In ina2xx_capture_thread() a timespec64 structure is used to calculate
> the delta time until the next sample time. This delta can be negative if
> the next sample time was in the past. In the -1 case timespec64_to_ns()
> now clamps the -1 second value to KTIME_MAX. This essentially puts ina2xx
> thread to sleep forever.
> Proposed patch is to replace the call to timespec64_to_ns() with the
> contents of that function without the overflow test introduced by the
> commit (ie revert to pre kernel 5.4 behaviour)
> 
> Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>

Needs a fixes tag with the patch you mention above that added the check
so that we can tell how far back this needs to be backported.



> ---
>  drivers/iio/adc/ina2xx-adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index a4b2ff9e0..ba3e98fde 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -777,6 +777,7 @@ static int ina2xx_capture_thread(void *data)
>  	int ret;
>  	struct timespec64 next, now, delta;
>  	s64 delay_us;
> +	s64 delta_ns;
>  
>  	/*
>  	 * Poll a bit faster than the chip internal Fs, in case
> @@ -818,7 +819,8 @@ static int ina2xx_capture_thread(void *data)
>  		do {
>  			timespec64_add_ns(&next, 1000 * sampling_us);
>  			delta = timespec64_sub(next, now);
> -			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
> +			delta_ns = (((s64)delta.tv_sec) * NSEC_PER_SEC)+delta.tv_nsec;

spaces around the +

> +			delay_us = div_s64(delta_ns, 1000);

Hmm. The negative timestamp is a bit of a mess anyway.  Perhaps we can do something
neater using the standard functions by checking the validity of the timestamp
using timespec64_valid_strict() in the while loop and dropping the div_s64 out
of the loop.

What do you think?  Would need a comment to explain why we the check on
it being valid though.

Jonathan


>  		} while (delay_us <= 0);
>  
>  		usleep_range(delay_us, (delay_us * 3) >> 1);

