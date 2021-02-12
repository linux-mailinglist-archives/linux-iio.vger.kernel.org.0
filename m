Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797C31A4B1
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 19:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhBLSrD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 13:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhBLSrA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Feb 2021 13:47:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1E8601FF;
        Fri, 12 Feb 2021 18:46:17 +0000 (UTC)
Date:   Fri, 12 Feb 2021 18:46:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] iio: documentation: Document proximity sensor label
 use
Message-ID: <20210212184617.5bad8172@archlinux>
In-Reply-To: <20210207123720.8357-1-hdegoede@redhat.com>
References: <20210207123720.8357-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Feb 2021 13:37:19 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
> the new device and channel label sysfs-attribute support.
> 
> And document the standardized labels which may be used with proximity
> sensors to hint userspace about the intended use of the sensor.
> 
> Using labels to differentiate between the multiple proximity sensors
> which a modern laptop/tablet may have was discussed in this thread:
> https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/
> 
> As mentioned the "proximity-wifi*" labels are already being used in
> this manner on some chromebooks, see e.g.:
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
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 41 +++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 35289d47d6cb..f2f090f8bd2f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -33,6 +33,47 @@ Description:
>  		Description of the physical chip / device for device X.
>  		Typically a part number.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_*_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_*_label

I was a bit in two minds about this from an organizational point of view.
1) Whether to separate the general label where position tends to make sense
   from the channel labels.  May be something we want to do in future but we can probably
   let that go for now.
2) Whether to allow such broad wild cards for the channels.
   Whilst in theory any channel can have a label we normally only document ABI
   that actually exists (mostly to know what we might break if we change anything :)
   Still I can't see any way we can change this without breakage so in this
   one case let's let the broad wild card go in.

This comes unstuck on the fact it overlaps with existing more specific Docs.

So can you pull the channel part out of here for v2.
/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
/sys/bus/iio/devices/iio:deviceX/in_anglY_label

The reason to keep these separate is that they will often contain a bit more
info about specific driver ABI (because of the issues with duplicating
ABI documentation in multiple files) so I'd rather we didn't end up with this
one item having many pages of info.

Jonathan



Jonathan
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Optional symbolic label for a device or a channel.
> +		This is useful for userspace to be able to better identify an
> +		individual device or channel.
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

