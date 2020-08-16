Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2E24570C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgHPJUG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgHPJUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:20:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA412067C;
        Sun, 16 Aug 2020 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597569604;
        bh=WBmP4wVBoF6Wgy+kmDHHQXrEUgXHLh6fbfHlsyLxDOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/ZkK4TmKtUCoLkw3WBQV1g60pg99MWU8AXPJPMpunvbGgZeEPp0TsOcnhmesqQMe
         9DPMOvOdMN1dZtncURJCiQ0RRD6l62ir7dxNxO4S3UhQbU3K/8qvnE4Goh2yTqHy4n
         g55lre7p23o3Hnyo1n5zJM9tOZ+kklLN0VpjU2k4=
Date:   Sun, 16 Aug 2020 10:19:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: documentation: light: Add as73211 sysfs
 documentation
Message-ID: <20200816101959.10154727@archlinux>
In-Reply-To: <20200810052447.12381-1-ceggers@arri.de>
References: <20200809123000.5131effd@archlinux>
        <20200810052447.12381-1-ceggers@arri.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Aug 2020 07:24:47 +0200
Christian Eggers <ceggers@arri.de> wrote:

> The driver for the as73211 light sensor provides the following not yet
> documented sysfs entries:
> - in_intensity_(x|y|z)_raw
> - in_intensity_(x|y|z)_scale
> - in_intensity_sampling_frequency(_available)
> - in_intensity_hardwaregain(_available)
> - in_intensity_integration_time
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
Applied.

Thanks,

Jonathan

> ---
> Jonathan Cameron:
> > If it is shared across 'ALL' channels then it will be just integration_time
> > If it is shared across all channels of a given type, it will be <type>_integration_time.  
> changed.
> 
> Best regards
> Christian Eggers
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 26 ++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d3e53a6d8331..388560149875 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -40,6 +40,7 @@ Description:
>  		buffered samples and events for device X.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency
>  What:		/sys/bus/iio/devices/iio:deviceX/buffer/sampling_frequency
>  What:		/sys/bus/iio/devices/triggerX/sampling_frequency
>  KernelVersion:	2.6.35
> @@ -55,6 +56,7 @@ Description:
>  		then it is to be found in the base device directory.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
>  What:		/sys/.../iio:deviceX/buffer/sampling_frequency_available
>  What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
> @@ -374,6 +376,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_countY_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_angl_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_x_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_y_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_z_scale
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -484,6 +489,7 @@ Description:
>  		are listed in this attribute.
>  
>  What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
> @@ -494,6 +500,13 @@ Description:
>  		Hardware applied gain factor. If shared across all channels,
>  		<type>_hardwaregain is used.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain_available
> +KernelVersion:	5.10
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lists all available hardware applied gain factors. Shared across all
> +		channels.
> +
>  What:		/sys/.../in_accel_filter_low_pass_3db_frequency
>  What:		/sys/.../in_magn_filter_low_pass_3db_frequency
>  What:		/sys/.../in_anglvel_filter_low_pass_3db_frequency
> @@ -1333,6 +1346,7 @@ Description:
>  		standardised CIE Erythemal Action Spectrum. UV index values range
>  		from 0 (low) to >=11 (extreme).
>  
> +What:		/sys/.../iio:deviceX/in_intensity_integration_time
>  What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
>  What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
>  What:		/sys/.../iio:deviceX/in_intensity_blue_integration_time
> @@ -1342,7 +1356,8 @@ KernelVersion:	3.12
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		This attribute is used to get/set the integration time in
> -		seconds.
> +		seconds. If shared across all channels of a given type,
> +		<type>_integration_time is used.
>  
>  What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_integration_time
>  KernelVersion:	4.0
> @@ -1739,3 +1754,12 @@ KernelVersion:	5.5
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		One of the following thermocouple types: B, E, J, K, N, R, S, T.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_y_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_z_raw
> +KernelVersion:	5.10
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Unscaled light intensity according to CIE 1931/DIN 5033 color space.
> +		Units after application of scale are nano nanowatts per square meter.

