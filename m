Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C714636346D
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhDRJVB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 18 Apr 2021 05:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhDRJVB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 05:21:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231C061245;
        Sun, 18 Apr 2021 09:20:30 +0000 (UTC)
Date:   Sun, 18 Apr 2021 10:21:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
Subject: Re: [PATCH v2 resend 1/2] iio: documentation: Document proximity
 sensor label use
Message-ID: <20210418102100.1a1ad4f3@jic23-huawei>
In-Reply-To: <78d53c41-35ab-d0aa-1c8b-a7f78bc481a0@redhat.com>
References: <20210405204224.18715-1-hdegoede@redhat.com>
        <20210405204224.18715-2-hdegoede@redhat.com>
        <fb8ada0ee326245bbf9c9db8a3bcfbbbccfed4a5.camel@hadess.net>
        <78d53c41-35ab-d0aa-1c8b-a7f78bc481a0@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Apr 2021 13:13:57 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 4/16/21 12:45 PM, Bastien Nocera wrote:
> > Hey,
> > 
> > On Mon, 2021-04-05 at 22:42 +0200, Hans de Goede wrote:  
> >> Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
> >> the new device label sysfs-attribute support.
> >>
> >> And document the standardized labels which may be used with proximity
> >> sensors to hint userspace about the intended use of the sensor.
> >>
> >> Using labels to differentiate between the multiple proximity sensors
> >> which a modern laptop/tablet may have was discussed in this thread:
> >> https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/
> >>
> >> As mentioned there the "proximity-wifi*" labels are already being
> >> used
> >> in this manner on some chromebooks, see e.g.:
> >> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> >> arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> >>
> >> And the "proximity-palmrest" and "proximity-lap" labels are intended
> >> to be used with the lap and palmrest sensors found in recent Lenovo
> >> ThinkPad models.
> >>
> >> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Cc: Mark Pearson <mpearson@lenovo.com>
> >> Cc: Bastien Nocera <hadess@hadess.net>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Changes in v2:
> >> - Drop the too generic:
> >>   What:           /sys/bus/iio/devices/iio:deviceX/in_*_label
> >>   What:           /sys/bus/iio/devices/iio:deviceX/out_*_label
> >>   lines from the newly added documentation, if/when we start
> >>   using channel-labels with proximity sensors then those should
> >>   get a separate in_proximityX_label documentation.
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-iio | 39
> >> +++++++++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> >> b/Documentation/ABI/testing/sysfs-bus-iio
> >> index d957f5da5c04..7379e40d862d 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-iio
> >> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> >> @@ -33,6 +33,45 @@ Description:
> >>                 Description of the physical chip / device for device
> >> X.
> >>                 Typically a part number.
> >>  
> >> +What:          /sys/bus/iio/devices/iio:deviceX/label
> >> +KernelVersion: 5.8
> >> +Contact:       linux-iio@vger.kernel.org
> >> +Description:
> >> +               Optional symbolic label for a device.
> >> +               This is useful for userspace to be able to better
> >> identify an
> >> +               individual device.
> >> +
> >> +               The contents of the label are free-form, but there
> >> are some
> >> +               standardized uses:
> >> +
> >> +               For proximity sensors which give the proximity (of a
> >> person) to
> >> +               a certain wlan or wwan antenna the following
> >> standardized labels
> >> +               are used:
> >> +
> >> +               * "proximity-wifi"
> >> +               * "proximity-lte"
> >> +               * "proximity-wifi-lte"
> >> +               * "proximity-wifi-left"
> >> +               * "proximity-wifi-right"  
> > 
> > Could we avoid having "lte" in the label names? Do we have a way to
> > communicate that some of those labels are deprecated and should be
> > avoided?
> > 
> > I would use "wwan" instead of "lte" here, and just mention "proximity-
> > wifi-lte" as a synonym for "proximity-wifi-wwan".  
> 
> the "lte" postfix is currently in use on ChromeOS, which is why
> I chose it here. I'm fine with adding some text that new drivers
> should use -wwan, although I wonder how this will work with
> separate mmwave and normal 5g antennas as such keeping lte for
> both 4g + regular 5g might actually be better and then the separate  
> mmwave antennas can use a -mmwave postfix.
> 
> Dmitry IIRC you brought up the use of these labels in a previous
> discussion. Do you have anything to add here ?  Is ChromeOS
> already doing anything wrt SAR for mmwave antennas?
> 
> >   
> >> +
> >> +               These are used to indicate to userspace that these
> >> proximity
> >> +               sensors may be used to tune transmit power to ensure
> >> that
> >> +               Specific Absorption Rate (SAR) limits are honored.
> >> +               The "-left" and "-right" labels are for devices with
> >> multiple
> >> +               antennas.
> >> +
> >> +               In some laptops/tablets the standardized proximity
> >> sensor labels
> >> +               instead indicate proximity to a specific part of the
> >> device:
> >> +
> >> +               * "proximity-palmrest" indicates proximity to the
> >> keyboard's palmrest
> >> +               * "proximity-palmrest-left" indicates proximity to
> >> the left part of the palmrest
> >> +               * "proximity-palmrest-right" indicates proximity to
> >> the right part of the palmrest
> >> +               * "proximity-lap" indicates the device is being used
> >> on someone's lap
> >> +
> >> +               Note "proximity-lap" is special in that its value may
> >> be
> >> +               calculated by firmware from other sensor readings,
> >> rather then
> >> +               being a raw sensor reading.  
> > 
> > I don't think that this is needed. I would expect that this sensor
> > would have a "0" minimum and "1" maximum value, which makes it clear
> > that the sensor value is synthesised.  
> 
> IIO typically exports real sensor readings, not these kind of
> synthesized values so IMHO it is good to mention this in the docs.

We do similar synthesized values in a few similar places.  The assumption
is there is a _scale that would map these to 'real world units'.  We might
not know what it is however.  So I'm not against adding them here.

Real readings of course preferred if they are available.
We can provide _available attributes for raw readings that
let userspace know it only has range 0..1 with a step size of 1.


> 
> > Maybe this special case should be mentioned (if that's needed), rather
> > than pointing out that this particular sensor might be special (they
> > could all be, depending on how the system is implemented after all).
> > 
> > Did you think about where you wanted the sensor's threshold to be
> > exported? Still in udev/hwdb?  
> 
> AFAIK the plan was for the driver to export this as a IIO sysfs
> attribute, Documentation/ABI/testing/sysfs-bus-iio
> already has:
> 
> What:           /sys/.../events/in_proximity0_thresh_falling_value
> What:           /sys/.../events/in_proximity0_thresh_rising_value
> 
> Those are intended for the trigger interface, but IIRC I think the

Event rather than trigger interface, but I get what you mean.

> plan was to also use these on a device without trigger support
> to advertise the recommended threshold to be used by userspace.

That is rather nasty as any standard userspace will map those to
actually generating iio events.

So if I follow correctly this is meta data that might of use to userspace
and we want some way to expose that?

If so I think I'd rather see new ABI to expose that. 
We might have some spec or testing defined notion of 'near' alongside an
actual threshold detector that can be controlled to be more paranoid for
example and hence need the above interface.

No idea on naming for a new ABI though :)  Could be something like
in_proximity0_raw_hintnear though I'm sure others will have better ideas
perhaps related to what this threshold is called in relevant specs etc.

> 
> Jonathan ?

I'll be honest I've lost track of where we were going with this so it's
more than possible I'll disagree with earlier me, let alone everyone else :)

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> > 
> > Cheers
> >   
> >> +
> >>  What:          /sys/bus/iio/devices/iio:deviceX/current_timestamp_cl
> >> ock
> >>  KernelVersion: 4.5
> >>  Contact:       linux-iio@vger.kernel.org  
> > 
> >   
> 

