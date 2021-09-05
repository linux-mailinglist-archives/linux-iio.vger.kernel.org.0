Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389BD400F2C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhIEKu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 06:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhIEKu1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 06:50:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291386008E;
        Sun,  5 Sep 2021 10:49:21 +0000 (UTC)
Date:   Sun, 5 Sep 2021 11:52:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: ABI: docs: Document Senseair Sunrise ABI
Message-ID: <20210905115244.1fd960fb@jic23-huawei>
In-Reply-To: <20210903144828.497166-4-jacopo@jmondi.org>
References: <20210903144828.497166-1-jacopo@jmondi.org>
        <20210903144828.497166-4-jacopo@jmondi.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Sep 2021 16:48:28 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Add documentation for the sysfs attributes of the sunrise_co2 driver.
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Nice but please fill in the version numbers with 5.16

Thanks,

Jonathan

> ---
>  .../sysfs-bus-iio-chemical-sunrise-co2        | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
> new file mode 100644
> index 000000000000..bbdbf9dd4818
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
> @@ -0,0 +1,38 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_factory
> +Date:		August 2021
> +KernelVersion:
> +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> +Description:
> +		Writing '1' triggers a 'Factory' calibration cycle.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_background
> +Date:		August 2021
> +KernelVersion:
> +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> +Description:
> +		Writing '1' triggers a 'Background' calibration cycle.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/error_status_available
> +Date:		August 2021
> +KernelVersion:

Be an optimist and fill this in for v5!  I'll never remember to do it.
I'd be very surprised if we don't get this lined up for 5.16

> +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> +Description:
> +		Reading returns the list of possible chip error status.
> +		Available options are:
> +		- 'error_fatal': Analog front-end initialization error
> +		- 'error_i2c': Read/write to non-existing register
> +		- 'error_algorithm': Corrupted parameters
> +		- 'error_calibration': Calibration has failed
> +		- 'error_self_diagnostic': Internal interface failure
> +		- 'error_out_of_range': Measured concentration out of scale
> +		- 'error_memory': Error during memory operations
> +		- 'error_no_measurement': Cleared at first measurement
> +		- 'error_low_voltage': Sensor regulated voltage too low
> +		- 'error_measurement_timeout': Unable to complete measurement
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/error_status
> +Date:		August 2021
> +KernelVersion:
> +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> +Description:
> +		Reading returns the current chip error status.

