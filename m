Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9937D2B133
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 11:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfE0JSL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 05:18:11 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39868 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0JSL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2019 05:18:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id C76B79E8F24;
        Mon, 27 May 2019 10:18:08 +0100 (BST)
Date:   Mon, 27 May 2019 10:18:04 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio@vger.kernel.org
Subject: Re: [RFC 1/1] iio: common: cros_ec_sensors: add extra sensor API
Message-ID: <20190527101804.3dac8802@archlinux>
In-Reply-To: <CAPUE2usHHhzzE4cRDxk3KBwRvaaUWQZ=M7j+thHxpCiYmkguFA@mail.gmail.com>
References: <cover.1556873525.git.fabien.lahoudere@collabora.com>
        <f30612908370460d61904450d6f7c5224082898e.1556873525.git.fabien.lahoudere@collabora.com>
        <20190505163647.4f961a0d@archlinux>
        <CAPUE2usHHhzzE4cRDxk3KBwRvaaUWQZ=M7j+thHxpCiYmkguFA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 May 2019 17:28:42 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sun, May 5, 2019 at 8:36 AM Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> > On Fri,  3 May 2019 12:54:46 +0200
> > Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> >  
> > > From: Gwendal Grignou <gwendal@chromium.org>
> > >
> > > Version 3 of the EC protocol provides min and max frequencies and fifo
> > > size for EC sensors.
> > > The driver allows EC to set parameters for version 3 and set default values
> > > for earlier versions.
> > > The sysfs entries are read only and cannot be used to impact on values.
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>  
> > Mostly changes in here will follow from comments on the cover letter
> > but a few other things inline.
> >
> > Thanks,
> >
> > Jonathan  
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-cros-ec         |  24 ++++
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 126 +++++++++++++++++-
> > >  .../linux/iio/common/cros_ec_sensors_core.h   |   7 +
> > >  include/linux/mfd/cros_ec_commands.h          |  21 +++
> > >  4 files changed, 177 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > index 0e95c2ca105c..85d266f4a57e 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > @@ -26,3 +26,27 @@ Description:
> > >               driver and represents the sensor ID as exposed by the EC. This
> > >               ID is used by the Android sensor service hardware abstraction
> > >               layer (sensor HAL) through the Android container on ChromeOS.
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/min_frequency
> > > +Date:                April 2019
> > > +KernelVersion:       5.0
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             This attribute is exposed by CrOS EC sensors. It defines the
> > > +             minimum frequency used by the sensor.
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/max_frequency
> > > +Date:                April 2019
> > > +KernelVersion:       5.0
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             This attribute is exposed by CrOS EC sensors. It defines the
> > > +             maximum frequency used by the sensor.
> > > +  
> > See reply to the cover letter on these.  Bonus points if you implement them
> > with the read_avail callback.
> >  
> > > +What:                /sys/bus/iio/devices/iio:deviceX/max_events
> > > +Date:                April 2019
> > > +KernelVersion:       5.0
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             This attribute is exposed by CrOS EC sensors. It defines the
> > > +             maximum number of events in the fifo.  
> >
> > Why does userspace care?  
> Is use to report the size of the hardware FIFO to Android, to enable
> batching mode:
> https://source.android.com/devices/sensors/batching.
> It is reported in fifoReservedEventCount or fifoMaxEventCount in the
> sensor_t structure described at
> https://source.android.com/devices/sensors/hal-interface#sensor_t.
> Having said that, batching is not terribly useful for tablet or
> laptop, but is critical for wearable.

Ok. So let me just check, in android terms, events are just readings
from the sensor?  These aren't events in the IIO sense of 'thresholds'
being passed?

If so can we map this to hwfifo_watermark[_available] using the range
descriptor? We have a bit of legacy around that with  hwfifo_watermark_max
and hwfifo_watermark_min also defined, but should probably move towards
the more standard _available form and deprecate the other two.

Jonathan


