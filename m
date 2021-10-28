Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C12843DF9A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhJ1LCJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 07:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhJ1LCJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 07:02:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6E5610FC;
        Thu, 28 Oct 2021 10:59:38 +0000 (UTC)
Date:   Thu, 28 Oct 2021 12:04:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 06/10] iio: document bno055 private sysfs attributes
Message-ID: <20211028120405.6ffb01d1@jic23-huawei>
In-Reply-To: <20211028101840.24632-7-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-7-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:36 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch adds ABI documentation for bno055 driver private sysfs
> attributes.

Hohum. As normal I dislike custom attributes but reality is these
don't map to anything 'standard' and I don't want them getting adopted
in places where the 'standard' approach works.

So thinking a bit more on this, I wonder if we can fit it into standard
ABI.

We can't use the normal range specification method of
_scale because it's internal to the device and the output reading is
unaffected.  The range specification via _raw_available would let us know
the range, but it is not writeable so..

A control that changes the internal scaling of the sensor in a fashion
that is not visible to the outside world maps to calibscale.  Whilst
that was intended for little tweaks to the input signal (often front
end amplifier gain tweak) it works here.  It doesn't map through to
anything userspace is expected to apply.  That combined with
_raw_available to let us know what the result is should work?

What do you think of that approach?  It's obviously a little more complex
to handle in the driver, but it does map to existing ABI and avoids
custom attributes etc.

> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  .../ABI/testing/sysfs-bus-iio-bno055          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-bno055 b/Documentation/ABI/testing/sysfs-bus-iio-bno055
> new file mode 100644
> index 000000000000..930a70c5a858
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
> @@ -0,0 +1,84 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_range
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Range for acceleration readings in G. Note that this does not
> +		affects the scale (which should be used when changing the
> +		maximum and minimum readable value affects also the reading
> +		scaling factor).

Having this in G but the sensor output in m/s^2 seems inconsistent.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_range
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Range for angular velocity readings in dps. Note that this does
> +		not affects the scale (which should be used when changing the
> +		maximum	and minimum readable value affects also the reading
> +		scaling	factor).

Again, units need to match or this is going to be really confusing.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_range_available
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of allowed values for in_accel_range attribute
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_range_available
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of allowed values for in_anglvel_range attribute
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fast_magnetometer_calibration_enable
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be 1 or 0. Enables/disables the "Fast Magnetometer
> +		Calibration" HW function.

Naming needs to be consistent with the ABI.  This is a channel type specific function
and to match existing calibration related ABI naming it would be.

in_magn_calibration_fast_enable

Some of the others need renaming in a similar way.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
> +		NDOF) HW function.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_calibration_data
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reports the binary calibration data blob for the IMU sensors.

Why in_ ?  What channels does this apply to?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_accel
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
> +		Report the autocalibration status for the accelerometer sensor.

For interfaces that really don't have any chance of generalising this one is terrible.
Any hope at all of mapping this to something numeric?

in_accel_calibration_auto_status


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_gyro
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
> +		Reports the autocalibration status for the gyroscope sensor.

in_angvel_calibration_auto_status
etc.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_magn
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
> +		Reports the autocalibration status for the magnetometer sensor.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_sys
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
> +		Reports the status for the IMU overall autocalibration.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/unique_id

Hmm. So normally we just dump these in the kernel log.  I guess you need it
here to associate a calibration blob with a particular sensor?

We could put it in label, but that would stop us using that for things like
positioning of the sensor.  So perhaps this is something that we should add
to the main ABI doc.  Probably as serial_number rather than unique ID though.

> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		16-bytes, 2-digits-per-byte, HEX-string representing the sensor
> +		unique ID number.

