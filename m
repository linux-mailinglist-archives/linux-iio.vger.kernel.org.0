Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0042A256864
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH2OqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 10:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2OqC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 10:46:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE5320791;
        Sat, 29 Aug 2020 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598712361;
        bh=9jm6M64eKnDJlaKw6F335zqzhrdYwo8+rrKz9CJz6xw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RaCcb8SMBFF3O7p41buodrrI12HTVXmjj9mwB1mmIloelgmwKqqVm4oODCq39D+cs
         1cOTkmSmufvmrdWoF9SWmBvJIOZe8E19CevAnhCH9+kVwJY8uF0e1Ly+HEIQS7AmaS
         BBLUf3mFEiCVwqlChNKdA2agXLPzhp7PUZ9zusSI=
Date:   Sat, 29 Aug 2020 15:45:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, peress@chromium.org, enric.balletbo@collabora.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: abi: iio: Use What: consistently
Message-ID: <20200829154558.36a09e47@archlinux>
In-Reply-To: <20200828233156.2264689-2-gwendal@chromium.org>
References: <20200828233156.2264689-1-gwendal@chromium.org>
        <20200828233156.2264689-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Aug 2020 16:31:55 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Change "[w|W]hat[:| ]" to What: for consistency.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Hi Gwendal,

This patch stands fine on its own so I'll apply this whilst we are discussing
patch 2.

Applied with a bit of fuzz to the togreg branch of iio.git and pushed out
as testing to be completely ignored by the autobuilders.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 48 ++++++++++++-------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index c3767d4d01a6f..47df16c87862d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -401,21 +401,21 @@ Description:
>  		Hardware applied calibration offset (assumed to fix production
>  		inaccuracies).
>  
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
> -what		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
> -what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
> @@ -483,7 +483,7 @@ Description:
>  		If a discrete set of scale values is available, they
>  		are listed in this attribute.
>  
> -What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
> @@ -750,9 +750,9 @@ What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
>  What:		/sys/.../events/in_tempY_raw_thresh_rising_value
>  What:		/sys/.../events/in_tempY_raw_thresh_falling_value
>  What:		/sys/.../events/in_illuminance0_thresh_falling_value
> -what:		/sys/.../events/in_illuminance0_thresh_rising_value
> -what:		/sys/.../events/in_proximity0_thresh_falling_value
> -what:		/sys/.../events/in_proximity0_thresh_rising_value
> +What:		/sys/.../events/in_illuminance0_thresh_rising_value
> +What:		/sys/.../events/in_proximity0_thresh_falling_value
> +What:		/sys/.../events/in_proximity0_thresh_rising_value
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -830,11 +830,11 @@ What:		/sys/.../events/in_tempY_thresh_rising_hysteresis
>  What:		/sys/.../events/in_tempY_thresh_falling_hysteresis
>  What:		/sys/.../events/in_tempY_thresh_either_hysteresis
>  What:		/sys/.../events/in_illuminance0_thresh_falling_hysteresis
> -what:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
> -what:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
> -what:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
> -what:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
> -what:		/sys/.../events/in_proximity0_thresh_either_hysteresis
> +What:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
> +What:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
> +What:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
> +What:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
> +What:		/sys/.../events/in_proximity0_thresh_either_hysteresis
>  KernelVersion:	3.13
>  Contact:	linux-iio@vger.kernel.org
>  Description:

