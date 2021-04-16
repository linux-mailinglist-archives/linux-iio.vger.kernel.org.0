Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF98A361E9B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 13:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhDPL12 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 07:27:28 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36747 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbhDPL12 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 07:27:28 -0400
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id DC87A200007;
        Fri, 16 Apr 2021 11:27:01 +0000 (UTC)
Message-ID: <8e7408e028a006f9fe276fda1f1e79cde59e9aa8.camel@hadess.net>
Subject: Re: [PATCH v2 resend 1/2] iio: documentation: Document proximity
 sensor label use
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
Date:   Fri, 16 Apr 2021 13:27:01 +0200
In-Reply-To: <78d53c41-35ab-d0aa-1c8b-a7f78bc481a0@redhat.com>
References: <20210405204224.18715-1-hdegoede@redhat.com>
         <20210405204224.18715-2-hdegoede@redhat.com>
         <fb8ada0ee326245bbf9c9db8a3bcfbbbccfed4a5.camel@hadess.net>
         <78d53c41-35ab-d0aa-1c8b-a7f78bc481a0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-04-16 at 13:13 +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/16/21 12:45 PM, Bastien Nocera wrote:
> > Hey,
> > 
> > On Mon, 2021-04-05 at 22:42 +0200, Hans de Goede wrote:
> > > Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
> > > the new device label sysfs-attribute support.
> > > 
> > > And document the standardized labels which may be used with
> > > proximity
> > > sensors to hint userspace about the intended use of the sensor.
> > > 
> > > Using labels to differentiate between the multiple proximity
> > > sensors
> > > which a modern laptop/tablet may have was discussed in this
> > > thread:
> > > https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/
> > > 
> > > As mentioned there the "proximity-wifi*" labels are already being
> > > used
> > > in this manner on some chromebooks, see e.g.:
> > > arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > > arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> > > 
> > > And the "proximity-palmrest" and "proximity-lap" labels are
> > > intended
> > > to be used with the lap and palmrest sensors found in recent
> > > Lenovo
> > > ThinkPad models.
> > > 
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Mark Pearson <mpearson@lenovo.com>
> > > Cc: Bastien Nocera <hadess@hadess.net>
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > > Changes in v2:
> > > - Drop the too generic:
> > >   What:           /sys/bus/iio/devices/iio:deviceX/in_*_label
> > >   What:           /sys/bus/iio/devices/iio:deviceX/out_*_label
> > >   lines from the newly added documentation, if/when we start
> > >   using channel-labels with proximity sensors then those should
> > >   get a separate in_proximityX_label documentation.
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 39
> > > +++++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> > > b/Documentation/ABI/testing/sysfs-bus-iio
> > > index d957f5da5c04..7379e40d862d 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -33,6 +33,45 @@ Description:
> > >                 Description of the physical chip / device for
> > > device
> > > X.
> > >                 Typically a part number.
> > >  
> > > +What:          /sys/bus/iio/devices/iio:deviceX/label
> > > +KernelVersion: 5.8
> > > +Contact:       linux-iio@vger.kernel.org
> > > +Description:
> > > +               Optional symbolic label for a device.
> > > +               This is useful for userspace to be able to better
> > > identify an
> > > +               individual device.
> > > +
> > > +               The contents of the label are free-form, but
> > > there
> > > are some
> > > +               standardized uses:
> > > +
> > > +               For proximity sensors which give the proximity
> > > (of a
> > > person) to
> > > +               a certain wlan or wwan antenna the following
> > > standardized labels
> > > +               are used:
> > > +
> > > +               * "proximity-wifi"
> > > +               * "proximity-lte"
> > > +               * "proximity-wifi-lte"
> > > +               * "proximity-wifi-left"
> > > +               * "proximity-wifi-right"
> > 
> > Could we avoid having "lte" in the label names? Do we have a way to
> > communicate that some of those labels are deprecated and should be
> > avoided?
> > 
> > I would use "wwan" instead of "lte" here, and just mention
> > "proximity-
> > wifi-lte" as a synonym for "proximity-wifi-wwan".
> 
> the "lte" postfix is currently in use on ChromeOS, which is why
> I chose it here. I'm fine with adding some text that new drivers
> should use -wwan, although I wonder how this will work with
> separate mmwave and normal 5g antennas as such keeping lte for
> both 4g + regular 5g might actually be better and then the separate  
> mmwave antennas can use a -mmwave postfix.

LTE isn't 4G or 5G, so it's already a misnomer. I also doubt that any
end-user cares what actual technology is being used in the antennas, I
just wanted to avoid us having to add another name to the list when
folks realise that LTE support is long gone from their devices.

> 
> Dmitry IIRC you brought up the use of these labels in a previous
> discussion. Do you have anything to add here ?  Is ChromeOS
> already doing anything wrt SAR for mmwave antennas?
> 
> > 
> > > +
> > > +               These are used to indicate to userspace that
> > > these
> > > proximity
> > > +               sensors may be used to tune transmit power to
> > > ensure
> > > that
> > > +               Specific Absorption Rate (SAR) limits are
> > > honored.
> > > +               The "-left" and "-right" labels are for devices
> > > with
> > > multiple
> > > +               antennas.
> > > +
> > > +               In some laptops/tablets the standardized
> > > proximity
> > > sensor labels
> > > +               instead indicate proximity to a specific part of
> > > the
> > > device:
> > > +
> > > +               * "proximity-palmrest" indicates proximity to the
> > > keyboard's palmrest
> > > +               * "proximity-palmrest-left" indicates proximity
> > > to
> > > the left part of the palmrest
> > > +               * "proximity-palmrest-right" indicates proximity
> > > to
> > > the right part of the palmrest
> > > +               * "proximity-lap" indicates the device is being
> > > used
> > > on someone's lap
> > > +
> > > +               Note "proximity-lap" is special in that its value
> > > may
> > > be
> > > +               calculated by firmware from other sensor
> > > readings,
> > > rather then
> > > +               being a raw sensor reading.
> > 
> > I don't think that this is needed. I would expect that this sensor
> > would have a "0" minimum and "1" maximum value, which makes it
> > clear
> > that the sensor value is synthesised.
> 
> IIO typically exports real sensor readings, not these kind of
> synthesized values so IMHO it is good to mention this in the docs.
> 
> > Maybe this special case should be mentioned (if that's needed),
> > rather
> > than pointing out that this particular sensor might be special
> > (they
> > could all be, depending on how the system is implemented after
> > all).
> > 
> > Did you think about where you wanted the sensor's threshold to be
> > exported? Still in udev/hwdb?
> 
> AFAIK the plan was for the driver to export this as a IIO sysfs
> attribute, Documentation/ABI/testing/sysfs-bus-iio
> already has:
> 
> What:           /sys/.../events/in_proximity0_thresh_falling_value
> What:           /sys/.../events/in_proximity0_thresh_rising_value
> 
> Those are intended for the trigger interface, but IIRC I think the
> plan was to also use these on a device without trigger support
> to advertise the recommended threshold to be used by userspace.
> 
> Jonathan ?
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
> > > +
> > >  What:          /sys/bus/iio/devices/iio:deviceX/current_timestam
> > > p_cl
> > > ock
> > >  KernelVersion: 4.5
> > >  Contact:       linux-iio@vger.kernel.org
> > 
> > 
> 


