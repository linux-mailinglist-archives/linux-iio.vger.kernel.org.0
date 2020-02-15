Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B75A15FF26
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 17:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgBOQJn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 11:09:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgBOQJn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 11:09:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E5C2083B;
        Sat, 15 Feb 2020 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581782982;
        bh=eR4o3mzWLrdtrA2+xZWK//TTGWU7qeeuM5nQKq6KokE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UaPTvrmq8IF4hShtZLUp4Sk6KXgPMSPMYK2NAvbKNgqLqcZyR+fjBdG9061nzAD0r
         dpwJYluD+bs6Z9gzvx1fvdYLx81PwfuzbXFkvnjqSJ9aTpumiwCqzyZKNfPNu6RCvv
         ix59UZ6aVxOD38Tcd5GRxODPKG/T/gDyFQsxe0ik=
Date:   Sat, 15 Feb 2020 16:09:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: accel: adxl372: Update sysfs docs
Message-ID: <20200215160939.2eaa3c27@archlinux>
In-Reply-To: <20200214093223.24664-1-alexandru.tachici@analog.com>
References: <20200214092919.24351-1-alexandru.tachici@analog.com>
        <20200214093223.24664-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Feb 2020 11:32:23 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch adds entries in the syfs docs of ADXL372.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-accel-adxl372   | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372 b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> new file mode 100644
> index 000000000000..1d74fc2ea0ac
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> @@ -0,0 +1,40 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/peak_fifo_mode_enable
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows to configure the FIFO to store sample
> +		sets of impact event peak (x, y, z). As a precondition, all
> +		three channels (x, y, z) need to be enabled.
> +		Writing 1, peak fifo mode will be enabled, if cleared and
> +		all three channels are enabled, sample sets of concurrent
> +		3-axis data will be stored in the FIFO.
> +
Hmm. I wonder if we can make this more 'standard'.  I can't remember which
device it was, but we once had a similar one for which we discussed whether
this could be represented as a separate trigger.  The basis for that would
be that we only capture data when above the threshold which is effectively
the same as only triggering capture when above the threshold.

However, I'm not sure it really helps us compared to what you have here.
Conceptually we could add the ability to do similar filtering to this
in software and in that case it would definitely wouldn't make sense to have
it as a trigger.  So after arguing with myself I think the rough approach
you have here is the best we can do.

However, naming wise...   It's not actually a fifo attribute, it's an
attribute on 'input' to the fifo (I think).   It's not specific to a
a particular buffer (would also apply to any buffer_cb in use) so you
are correct to have it as a general parameter.
We can't use the term filter, as that's assumed to refer to the actual
data and it would be confusing.

So we could call it something like

buffer_peak_mode_enable

> +What:		/sys/bus/iio/devices/iio:deviceX/time_activity
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows to set the activity timer in ms,
> +		the minimum time measured acceleration needs to overcome
> +		the set threshold in order to detect activity.

I've been thinking about how this aligns with the existing ABI.  When we have
something that needs to be true for a while before an event happens we use the
term period and it's in seconds.    If it were simply an event this would
be
in_accel_thresh_x_rising_period

The only difference here is that the event is not just signalled but also
controls the state of the device.

So... How do we indicate this?  I think we should treat these as events
in general and use the standard interface, but have some additional ABI
to indicate that they are connected to the mode the device is running in...

Perhaps have 
events/in_accel_thresh_x_rising_period
events/in_accel_thresh_x_rising_value
events/in_accel_thresh_x_falling_period
events/in_accel_thresh_x_falling_value
activity_detect_event (which reads in_accel_thresh_x_rising always in this case)
inactivity_detect_event (which reads in_accel_thresh_x_falling always in this case).

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/time_inactivity
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows to set the inactivity timer in ms,
> +		the minimum time measured acceleration needs to be lower
> +		than set threshold in order to detect inactivity.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_threshold_activity
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows to set the activity threshold in 100 mg
> +		(0.1 m/s^2 SI).

Just mention the SI units.  That conversion is rather inaccurate anyway.  + should
match with base units which aren't 0.1 for acceleration.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_threshold_inactivity
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows to set the inactivity threshold in 100 mg
> +		(0.1 m/s^2 SI).

