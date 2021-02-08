Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F23134E5
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBHOTF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 09:19:05 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50181 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhBHORe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 09:17:34 -0500
X-Originating-IP: 78.199.60.242
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6F5731BF206;
        Mon,  8 Feb 2021 14:16:46 +0000 (UTC)
Message-ID: <8c07c3f3515088b1c5a8ef6c45574233ca371590.camel@hadess.net>
Subject: Re: [PATCH 1/2] iio: documentation: Document proximity sensor label
 use
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
Date:   Mon, 08 Feb 2021 15:16:45 +0100
In-Reply-To: <676c9b71-ffc6-343e-f4ef-b0ec73fdb906@redhat.com>
References: <20210207123720.8357-1-hdegoede@redhat.com>
         <2b7a0374f4af5e2113c1d209246b506d7f42ae29.camel@hadess.net>
         <676c9b71-ffc6-343e-f4ef-b0ec73fdb906@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2021-02-08 at 14:50 +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/8/21 2:40 PM, Bastien Nocera wrote:
> > On Sun, 2021-02-07 at 13:37 +0100, Hans de Goede wrote:
> > > Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
> > > the new device and channel label sysfs-attribute support.
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
> > > As mentioned the "proximity-wifi*" labels are already being used
> > > in
> > > this manner on some chromebooks, see e.g.:
> > > arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > > arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> > > 
> > > And the "proximity-palmrest" and "proximity-lap" labels are
> > > intended
> > > to be used with the lap and palmrest sensors found in recent
> > > Lenovo
> > > ThinkPad models.
> > 
> > Both patches in the series look fine to me.
> 
> Thank you for checking.
> 
> > Is IIO the interface you plan on using to implement the lap
> > detection
> > for the thinkpad_acpi driver?
> 
> ATM both the lap detection and the palmrest proximity detection are
> already available using thinkpad_acpi specific sysfs attributes:
> 
> [hans@x1 linux]$ cat
> /sys/bus/platform/devices/thinkpad_acpi/dytc_lapmode 
> 0
> [hans@x1 linux]$ cat
> /sys/bus/platform/devices/thinkpad_acpi/palmsensor 
> 1
> 
> Which I think you are already aware of ?

I didn't know those actually landed upstream (or I didn't remember), I
was waiting on the SW_LAP_PROXIMITY input device method to land:
https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/42

That's abandoned, right?

>   These will not be going
> anywhere since dropping these would be a userspace ABI break.
> 
> With that said, yes the plan is to extend the thinkpad_acpi driver
> to also report lap / palmrest proximity through IIO using these
> labels.

OK, good to know.

I've filed:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/issues/321
so we can eventually export more than a single proximity sensor through
the D-Bus interface in the future.

Cheers

