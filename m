Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D161B4AB3
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgDVQkT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 12:40:19 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:56404 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVQkS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 12:40:18 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 3F478E01CB; Wed, 22 Apr 2020 18:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1587573617; bh=McsTMxwzAFpLpU1JXIxR7mSymPut3YX7nBAYc8yLJBw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=I4EUWzd0zUhHuWZGbheNH6bJICyGifB/ISIONWZiCSVzEJCyoEtuHKBeNqUy9htv9
         +7bJf/ONQTjhUoFi39a5WF9hh+xzYg8aHqhJdT88XzGmKxP6hkCzTtpklFhKOVl8j4
         JhA5ThSvY0rsJ/i0kbuqbNc0hE+wmOeCAQ4vXs+8=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 2C28CE01A3;
        Wed, 22 Apr 2020 18:40:17 +0200 (CEST)
Date:   Wed, 22 Apr 2020 18:40:17 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org
Subject: Re: [PATCH 4/6] Documentation: ABI: testing: scd30: document iio
 attributes
In-Reply-To: <20200422141135.86419-5-tomasz.duszynski@octakon.com>
Message-ID: <alpine.DEB.2.21.2004221818490.26800@vps.pmeerw.net>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com> <20200422141135.86419-5-tomasz.duszynski@octakon.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020, Tomasz Duszynski wrote:

> Add documentation for sensor specific iio attributes.

minor comments below
 
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-scd30 | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-scd30 b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> new file mode 100644
> index 000000000000..0431a718447d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> @@ -0,0 +1,97 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Given that sensor's CO2 measurement chamber has fixed volume
> +		pressure changes will affect concentration readings. Writing
> +		current ambient pressure here will allow senor to make necessary

sensor

> +		adjustments. Upon reading previously set value is returned.
> +		Units are millibars.

unit for pressure in IIO is kilopascal (e.g. 
/sys/bus/iio/devices/iio:deviceX/in_pressure_raw)

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp_available
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The range of available values in millibars represented as the
> +		minimum value, the step and the maximum value, all enclosed in
> +		square brackets.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/meas_interval
> +Date:		January 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Amount of time between subsequent measurements. Writing this
> +		attribute will change measurement interval. Upon reading
> +		current measurement interval is returned. Units are seconds.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/meas_interval_available
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The range of available values in seconds represented as the
> +		minimum value, the step and the maximum value, all enclosed in
> +		square brackets.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/asc
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Writing 1 or 0 to this attribute will respectively activate or
> +		deactivate automatic self calibration procedure. Upon reading 1

deactivate automatic self calibration (asc) procedure

> +		is returned if asc is ongoing, 0 otherwise.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/frc
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Forced recalibration is used to compensate for sensor drifts
> +		when a reference value of CO2 concentration in close proximity
> +		to the sensor is available. Writing attribute will set frc
> +		value. Upon reading current frc is returned. Units are
> +		millibars.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/frc_available
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The range of available values in millibars represented as the
> +		minimum value, the step and the maximum value, all enclosed in
> +		square brackets.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/temp_offset
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Sensor readings may be affected by ambient temperature.
> +		Writing temperature offset will compensate for unwanted changes.
> +		Note that written offset gets multiplied by a factor of 100
> +		by a sensor internally.
> +
> +		For example, writing 10 here will correspond to 0.1 degree
> +		Celsius.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/temp_offset_available
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The range of available values in degrees Celsius represented as
> +		the minimum value, the step and the maximum value, all enclosed
> +		in square brackets.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/reset
> +Date:		April 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Software reset mechanism forces sensor into the same state
> +		as after powering up without the need for removing power supply.
> +		Writing any value will reset sensor.
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
