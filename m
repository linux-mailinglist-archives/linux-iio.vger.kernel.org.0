Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1CF36CA6A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhD0Rfm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0Rfm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 13:35:42 -0400
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D30C061574;
        Tue, 27 Apr 2021 10:34:58 -0700 (PDT)
Received: from [81.101.6.87] (port=33702 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1lbRbt-00016k-1h; Tue, 27 Apr 2021 18:34:57 +0100
Date:   Tue, 27 Apr 2021 18:35:42 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 4/7] iio:ABI docs: Fix issue around repeated
 definition of out_currentY_raw
Message-ID: <20210427183524.364ce96e@jic23-huawei>
In-Reply-To: <20210117153816.696693-5-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-5-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Jan 2021 15:38:13 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This one is challenging as both the places this appears in specific drivers
> are making 'unusual' uses of what looks like a simple output current
> channel.
> As a side note, this was particular bit of ABI occurs in other drivers
> where the use is much more straight forward e.g. dac/ad5421
> 
> This patch attempts to make a best effort of adding it to the main docs but
> retaining enough information. Both of these drivers probably need
> specific documents being written to describe their unusual interfaces, but
> those should be in the main documentation, not under Documentation/ABI.
> That is a non trivial job so left for another time.
> 
> Fixes:
> $ scripts/get_abi.pl validate
> Warning: /sys/bus/iio/devices/iio:deviceX/out_currentY_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als:43  ./Documentation/ABI/testing/sysfs-bus-iio-health-afe440x:38
> 
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Another one I think I can't have gotten wrong. Hence whilst I like to know
they've had eyes on them, I'll take this one anyway.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio               | 11 +++++++++++
>  .../ABI/testing/sysfs-bus-iio-health-afe440x          | 10 ++--------
>  .../ABI/testing/sysfs-bus-iio-light-lm3533-als        | 11 +++--------
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 9b5ceb22363d..ed50f4b21dcc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -631,6 +631,17 @@ Description:
>  		specified and unique if the output corresponds to a single
>  		channel.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw
> +Date:		May 2012
> +KernelVersion:	3.5
> +Contact:	Johan Hovold <jhovold@gmail.com>
> +Description:
> +		Set/get output current for channel Y. Units after application
> +		of scale and offset are milliamps.
> +		For some devices current channels are used to specify
> +		current supplied to elements used in taking a measurement
> +		of a different type. E.g. LED currents.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/events
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-health-afe440x b/Documentation/ABI/testing/sysfs-bus-iio-health-afe440x
> index 66b621f10223..a8e04b41d9ff 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-health-afe440x
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-health-afe440x
> @@ -18,6 +18,8 @@ Description:
>  		respectively which simply helper channels containing the
>  		calculated difference in the value of stage 1 - 2 and 3 - 4.
>  		The values are expressed in 24-bit twos complement.
> +		The LED current for the stage is controlled via
> +		out_currentY_raw.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensityY_offset
>  Date:		May 2016
> @@ -35,11 +37,3 @@ Contact:	Andrew F. Davis <afd@ti.com>
>  Description:
>  		Get and set the resistance and the capacitance settings for the
>  		Transimpedance Amplifier during the associated stage.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw
> -Date:		May 2016
> -KernelVersion:
> -Contact:	Andrew F. Davis <afd@ti.com>
> -Description:
> -		Get and set the LED current for the specified LED active during
> -		this stage. Y is the specific stage number.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als b/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
> index 22c5ea670971..c476d48d0f82 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
> @@ -41,14 +41,6 @@ Description:
>  		Get the current light zone (0..4) as defined by the
>  		in_illuminance0_threshY_{falling,rising} thresholds.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw
> -Date:		May 2012
> -KernelVersion:	3.5
> -Contact:	Johan Hovold <jhovold@gmail.com>
> -Description:
> -		Get output current for channel Y (0..255), that is,
> -		out_currentY_currentZ_raw, where Z is the current zone.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_currentZ_raw
>  Date:		May 2012
>  KernelVersion:	3.5
> @@ -59,3 +51,6 @@ Description:
>  
>  		These values correspond to the ALS-mapper target registers for
>  		ALS-mapper Y + 1.
> +
> +		Note that out_currentY_raw provides the current for the
> +		current zone.

