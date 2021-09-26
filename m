Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00CA418B31
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 23:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhIZVUV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 17:20:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZVUU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 17:20:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632691123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VcmuOKzrUjN7BSyHUx3Kl4IuGv8Myu4o2HA/X/tmyAY=;
        b=3fuDyYdfWl8IfzOUj2rdpL7rM0jN8PNG68sp4a7l1/rWeyf4X+7Rmog4rgEiZVlZnRjRTZ
        KF7T+EwD/tTmn9fI39jqIies1FH5lzJBzetqZ4v6Njfbuj3m7+Bw5CHt0zy7CoQbqXeudJ
        jKjqlsJLtoi6Hs6XvHdekxilUoJGhJwbRhLyjfx8zYFETjBEFMITptEJzEdo3AAZPvSchd
        t9iaGBnrO/t6E+r/uOqDGNYLefDoQdbkMIwl/Ga2g6ch6OeROllwIYja1WgXlgJpYVM5SX
        8Y6rBHYryeP5S4aKc2bQj1liUp4liIiEnB97owYpoQ0UrJ+KAylW2i5vsy9Sug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632691123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VcmuOKzrUjN7BSyHUx3Kl4IuGv8Myu4o2HA/X/tmyAY=;
        b=7o9HB3vQzVICm2YlFJFtcYznAztjJr4EqIYYMkZAejnxHd9tVG5IdyN6jXXgIrJfbIWXTk
        4SsJYVD1/6KudvAw==
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] workaround regression in ina2xx introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
In-Reply-To: <20210926171711.194901-1-drhunter95@gmail.com>
References: <20210926171711.194901-1-drhunter95@gmail.com>
Date:   Sun, 26 Sep 2021 23:18:42 +0200
Message-ID: <87o88favd9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 26 2021 at 18:16, Iain Hunter wrote:
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -817,10 +817,10 @@ static int ina2xx_capture_thread(void *data)
>  		 */
>  		do {
>  			timespec64_add_ns(&next, 1000 * sampling_us);
> -			delta = timespec64_sub(next, now);
> -			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
> -		} while (delay_us <= 0);
> +		} while (timespec64_compare(&next, &now) < 0);
>  
> +		delta = timespec64_sub(next, now);
> +		delay_us = div_s64(timespec64_to_ns(&delta), 1000);

This whole timespec dance does not make any sense and can be completely
avoided by using just scalar nanoseconds. Untested patch below.

Thanks,

        tglx
---
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -775,7 +775,7 @@ static int ina2xx_capture_thread(void *d
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	int sampling_us = SAMPLING_PERIOD(chip);
 	int ret;
-	struct timespec64 next, now, delta;
+	ktime_t next, now, delta;
 	s64 delay_us;
 
 	/*
@@ -785,7 +785,7 @@ static int ina2xx_capture_thread(void *d
 	if (!chip->allow_async_readout)
 		sampling_us -= 200;
 
-	ktime_get_ts64(&next);
+	next = ktime_get();
 
 	do {
 		while (!chip->allow_async_readout) {
@@ -798,7 +798,7 @@ static int ina2xx_capture_thread(void *d
 			 * reset the reference timestamp.
 			 */
 			if (ret == 0)
-				ktime_get_ts64(&next);
+				next = ktime_get();
 			else
 				break;
 		}
@@ -807,7 +807,7 @@ static int ina2xx_capture_thread(void *d
 		if (ret < 0)
 			return ret;
 
-		ktime_get_ts64(&now);
+		now = ktime_get();
 
 		/*
 		 * Advance the timestamp for the next poll by one sampling
@@ -816,11 +816,10 @@ static int ina2xx_capture_thread(void *d
 		 * multiple times, i.e. samples are dropped.
 		 */
 		do {
-			timespec64_add_ns(&next, 1000 * sampling_us);
-			delta = timespec64_sub(next, now);
-			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
-		} while (delay_us <= 0);
+			next = ktime_add_us(next, sampling_us);
+		} while (next <= now);
 
+		delay_us = ktime_to_us(ktime_sub(next, now));
 		usleep_range(delay_us, (delay_us * 3) >> 1);
 
 	} while (!kthread_should_stop());


