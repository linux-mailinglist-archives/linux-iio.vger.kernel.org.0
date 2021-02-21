Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F3320BA1
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBUQGR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:06:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhBUQGR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:06:17 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC9064E43;
        Sun, 21 Feb 2021 16:05:34 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:05:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [RFC PATCH 1/7] iio:ABI docs: Fix up duplicate *_calibbias_*
 documentation for icm42600
Message-ID: <20210221160529.0012c931@archlinux>
In-Reply-To: <20210117153816.696693-2-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-2-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Jan 2021 15:38:10 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
@Jean-Baptiste.

Whilst this is 'fairly obviously' fine, could you take a quick glance at it.
I'm never keen to take my own patches without someone having agreed
I haven't done anything particularly silly ;)

Jonathan

> 
> This device has the unusual characteristic that the calibbias values
> have well defined units (more commonly they are tweaks to a DAC)
> Unfortunately the previous approach of having more specific documentation
> in sysfs-bus-iio-icm42600 results in warnings during the documentation
> build and random ordering in the resulting documentation.
> 
> To avoid this, add a note to the main documentation on this special
> characteristic for the icm42600.   The _available for calibbias was
> missing from the main sysfs-bus-iio docs so also add that, allowing
> us to drop the icm42600 specific file.
> 
> Fixes
> $ scripts/get_abi.pl validate warning:
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  ./Documentation/ABI/testing/sysfs-bus-iio:394
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  ./Documentation/ABI/testing/sysfs-bus-iio:395
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  ./Documentation/ABI/testing/sysfs-bus-iio:396
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  ./Documentation/ABI/testing/sysfs-bus-iio:397
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  ./Documentation/ABI/testing/sysfs-bus-iio:398
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  ./Documentation/ABI/testing/sysfs-bus-iio:399
> 
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio       | 13 ++++++++++++
>  .../ABI/testing/sysfs-bus-iio-icm42600        | 20 -------------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d957f5da5c04..d2dd9cc280f9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -408,6 +408,19 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Hardware applied calibration offset (assumed to fix production
>  		inaccuracies).
> +		icm42600: For this device values are real physical offsets
> +		expressed in SI units (m/s^2 for accelerometers and rad/s
> +		for gyroscope)/
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
> +KernelVersion:  5.8
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		Available values of calibbias. Maybe expressed as either of:
> +
> +		- a small discrete set of values like "0 2 4 6 8"
> +		- a range specified as "[min step max]"
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-icm42600 b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
> deleted file mode 100644
> index 0bf1fd4f5bf1..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-icm42600
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
> -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
> -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
> -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
> -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
> -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
> -KernelVersion:  5.8
> -Contact:        linux-iio@vger.kernel.org
> -Description:
> -		Hardware applied calibration offset (assumed to fix production
> -		inaccuracies). Values represent a real physical offset expressed
> -		in SI units (m/s^2 for accelerometer and rad/s for gyroscope).
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
> -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
> -KernelVersion:  5.8
> -Contact:        linux-iio@vger.kernel.org
> -Description:
> -		Range of available values for hardware offset. Values in SI
> -		units (m/s^2 for accelerometer and rad/s for gyroscope).

