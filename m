Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762D410C6C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhISQtS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 12:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhISQtR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 12:49:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0834B60EFF;
        Sun, 19 Sep 2021 16:47:49 +0000 (UTC)
Date:   Sun, 19 Sep 2021 17:51:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: documentation: Document scd4x calibration
 use
Message-ID: <20210919175130.410d4ac2@jic23-huawei>
In-Reply-To: <20210913080020.1265027-5-roan@protonic.nl>
References: <20210913080020.1265027-1-roan@protonic.nl>
        <20210913080020.1265027-5-roan@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 10:00:20 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> Add entries from Documentation/ABI/testing/sysfs-bus-iio-scd30
> to Documentation/ABI/testing/sysfs-bus-iio. The attributes of the scd4x
> and scd30 are common.
> 
> Remove Documentation/ABI/testing/sysfs-bus-iio-scd30.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
Hi Roan,

Great to move these, but there is a bit too much 'specific' detail in here
reflecting the scd30.  We either need to make the descriptions more generic
or state some parts are only true for that device.

Some suggestions inline.  Make sure they also apply to your new driver.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio       | 35 +++++++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-scd30 | 34 ------------------
>  2 files changed, 35 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6ad47a67521c..56492c564f72 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1957,3 +1957,38 @@ Description:
>  		Specify the percent for light sensor relative to the channel
>  		absolute value that a data field should change before an event
>  		is generated. Units are a percentage of the prior reading.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/calibration_auto_enable
> +Date:		June 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Contaminants build-up in the measurement chamber or optical
> +		elements deterioration leads to sensor drift.

Given this is a top level ABI doc, we don't know it is sensor with a measurement
chamber or that it's optical.  This might be an ADC.

We could make this an example.

		Some sensors have the ability to apply auto calibration at
		runtime.  For example, it may be necessary to compensate for
		contaminant build-up in a measurement chamber or optical
		element deterioration that would otherwise lead to sensor drift.

		Writing 1 or 0 to this attribute will respectively activate or
		deactivate this auto calibration function.

		Upon reading, the current status is returned.
> +
> +		One can compensate for sensor drift by using automatic self
> +		calibration procedure (asc).
> +
> +		Writing 1 or 0 to this attribute will respectively activate or
> +		deactivate asc.
> +
> +		Upon reading current asc status is returned.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/calibration_forced_value
> +Date:		June 2020
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Contaminants build-up in the measurement chamber or optical
> +		elements deterioration leads to sensor drift.
> +
> +		One can compensate for sensor drift by using forced
> +		recalibration (frc). This is useful in case there's known
> +		co2 reference available nearby the sensor.

Remove the c02 specific references from here and have something like

		Some sensors have the ability to apply a manual calibration using
		a known measurement value, perhaps obtained from an external
		reference device. 

		Writing a value to this function will force such a calibration
		change. For the scd30 the value should be from the range
		[400 1 2000].

		Note that a valid value may only be obtained once it is has been
		written.  Until then any read back of this value should be ignored.

Hmm. That last bit is rather ugly.  I'd rather we returned an error code if the
value had not yet been forced.  We should clean that up at some stage and also
add an appropriate _available so we don't need to document the range in this file.

		
> +
> +		Picking value from the range [400 1 2000] and writing it to the
> +		sensor will set frc.
> +
> +		Upon reading current frc value is returned. Note that after
> +		power cycling default value (i.e 400) is returned even though
> +		internally sensor had recalibrated itself.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-scd30 b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> deleted file mode 100644
> index b9712f390bec..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-scd30
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/calibration_auto_enable
> -Date:		June 2020
> -KernelVersion:	5.8
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Contaminants build-up in the measurement chamber or optical
> -		elements deterioration leads to sensor drift.
> -
> -		One can compensate for sensor drift by using automatic self
> -		calibration procedure (asc).
> -
> -		Writing 1 or 0 to this attribute will respectively activate or
> -		deactivate asc.
> -
> -		Upon reading current asc status is returned.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/calibration_forced_value
> -Date:		June 2020
> -KernelVersion:	5.8
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Contaminants build-up in the measurement chamber or optical
> -		elements deterioration leads to sensor drift.
> -
> -		One can compensate for sensor drift by using forced
> -		recalibration (frc). This is useful in case there's known
> -		co2 reference available nearby the sensor.
> -
> -		Picking value from the range [400 1 2000] and writing it to the
> -		sensor will set frc.
> -
> -		Upon reading current frc value is returned. Note that after
> -		power cycling default value (i.e 400) is returned even though
> -		internally sensor had recalibrated itself.

