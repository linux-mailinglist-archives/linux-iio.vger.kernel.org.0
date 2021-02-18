Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D531EB8F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhBRP1S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:27:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBRNcK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 08:32:10 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF3964DA8;
        Thu, 18 Feb 2021 13:31:16 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:31:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Subject: Re: [PATCH v2 1/2] iio: documentation: Document proximity sensor
 label use
Message-ID: <20210218133109.608b4ee7@archlinux>
In-Reply-To: <20210215191003.698888-1-hdegoede@redhat.com>
References: <20210215191003.698888-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 20:10:02 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
> the new device label sysfs-attribute support.
> 
> And document the standardized labels which may be used with proximity
> sensors to hint userspace about the intended use of the sensor.
> 
> Using labels to differentiate between the multiple proximity sensors
> which a modern laptop/tablet may have was discussed in this thread:
> https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/
> 
> As mentioned there the "proximity-wifi*" labels are already being used
> in this manner on some chromebooks, see e.g.:
> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> 
> And the "proximity-palmrest" and "proximity-lap" labels are intended
> to be used with the lap and palmrest sensors found in recent Lenovo
> ThinkPad models.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mark Pearson <mpearson@lenovo.com>
> Cc: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Great thanks.

Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore.

Jonathan

> ---
> Changes in v2:
> - Drop the too generic:
>   What:           /sys/bus/iio/devices/iio:deviceX/in_*_label
>   What:           /sys/bus/iio/devices/iio:deviceX/out_*_label
>   lines from the newly added documentation, if/when we start
>   using channel-labels with proximity sensors then those should
>   get a separate in_proximityX_label documentation.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 39 +++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 35289d47d6cb..364f842350ab 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -33,6 +33,45 @@ Description:
>  		Description of the physical chip / device for device X.
>  		Typically a part number.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/label
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Optional symbolic label for a device.
> +		This is useful for userspace to be able to better identify an
> +		individual device.
> +
> +		The contents of the label are free-form, but there are some
> +		standardized uses:
> +
> +		For proximity sensors which give the proximity (of a person) to
> +		a certain wlan or wwan antenna the following standardized labels
> +		are used:
> +
> +		* "proximity-wifi"
> +		* "proximity-lte"
> +		* "proximity-wifi-lte"
> +		* "proximity-wifi-left"
> +		* "proximity-wifi-right"
> +
> +		These are used to indicate to userspace that these proximity
> +		sensors may be used to tune transmit power to ensure that
> +		Specific Absorption Rate (SAR) limits are honored.
> +		The "-left" and "-right" labels are for devices with multiple
> +		antennas.
> +
> +		In some laptops/tablets the standardized proximity sensor labels
> +		instead	indicate proximity to a specific part of the device:
> +
> +		* "proximity-palmrest" indicates proximity to the keyboard's palmrest
> +		* "proximity-palmrest-left" indicates proximity to the left part of the palmrest
> +		* "proximity-palmrest-right" indicates proximity to the right part of the palmrest
> +		* "proximity-lap" indicates the device is being used on someone's lap
> +
> +		Note "proximity-lap" is special in that its value may be
> +		calculated by firmware from other sensor readings, rather then
> +		being a raw sensor reading.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
>  KernelVersion:	4.5
>  Contact:	linux-iio@vger.kernel.org

