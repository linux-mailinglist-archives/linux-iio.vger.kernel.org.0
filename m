Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEC25EEF0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgIFP5I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgIFP5E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:57:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9138D20708;
        Sun,  6 Sep 2020 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599407823;
        bh=Okunv6b+/606a+A8ZAmEGHtldZ+63z9BdQaUL7PtcVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lq+a5aI/b5DAtuD2N6eFxkTJ1BL5ZxFOVctlajiKBIIKgerr+6fXpGikr1waUwkJu
         08N7OryIt/WzK6HJtzvgQFvtfhe0h2PmnfJYUND9vJ5K4DWO6WaivUuhTaAEFWDP5L
         E91QGAF1kjdFfAovZEAQhkiQEFVV0ULKWPH2ajRY=
Date:   Sun, 6 Sep 2020 16:56:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Yuval Peress <peress@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] docs: abi: iio: Add event when offset changes
Message-ID: <20200906165659.2e32d29f@archlinux>
In-Reply-To: <CAPUE2uuhXFN2MbrxRP2ojMaqT8+kG+ODMegd2BV4zV0xGc5afA@mail.gmail.com>
References: <20200828233156.2264689-1-gwendal@chromium.org>
        <20200828233156.2264689-3-gwendal@chromium.org>
        <20200830141140.3a360928@archlinux>
        <CAPUE2uuhXFN2MbrxRP2ojMaqT8+kG+ODMegd2BV4zV0xGc5afA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 20:00:43 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sun, Aug 30, 2020 at 6:11 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 28 Aug 2020 16:31:56 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >  
> > > Some sensors/sensorhubs can calculate drift or hard iron offsets to
> > > apply to raw data to get the true measure data.
> > > These offsets are applied by the user space application.
> > > When these offsets change, events are raised to tell the application
> > > to update the cached offset values.
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> > Hi Gwendal
> >
> > This strikes me as rather prone to races.  I guess if the updates
> > tend to be fairly minor we will just have slightly less accurate data
> > until the update gets picked up by userspace.  
> In case of hard iron for instance, the sensorhub needs several samples
> to find out the current offset are now invalid. So it is likely the
> measurement of the geomagnetic field was incorrect for a while.
> For accelerometer online calibration, we don't expect vast changes
> when new offsets are available.
> >
> > We have had some discussions about how to handle meta data updates
> > in the past.  One option was to provide a metadata index channel
> > that could be used to indicate there was an update to something
> > sat in a separate fifo.  
> An extra sounds like a waste of space, as it will mostly be 0 most of
> the time, and edge to 1 once in a while. An event looks more
> appropriate.

Agreed for this case.
It would be a much more general interface with a lot of other
usecases. It is overkill here.  There isn't a huge burden in adding
support for your case in the meantime, even if we eventually end up
finding a better way of doing metadata in general.

> >  
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 33 +++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index 47df16c87862d..40da602e7a555 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -1716,3 +1716,36 @@ Description:
> > >               Mass concentration reading of particulate matter in ug / m3.
> > >               pmX consists of particles with aerodynamic diameter less or
> > >               equal to X micrometers.
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_offset
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_offset
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_offset
> > > +KernelVersion:       x.y
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Gyroscope drift calculated by the sensor. In addition to factory
> > > +             calibration, sensor or sensorhub can
> > > +             detect gyroscope drift and report it to userspace.  
> >
> > This looks like standard ABI that should probably already be documented,
> > unrelated to the controversial part of this patch. I would split it out into
> > it's own patch a I can pick that up much faster.  
> Done in v2.
> >
> >  
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_magn_x_offset
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_magn_y_offset
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_magn_z_offset
> > > +KernelVersion:       x.y
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Hard Iron bias calculated by the sensor or sensorhub. To be applied by
> > > +             user space application to the raw data to obtain the geomagnetic field.  
> >
> > Same as above.  
> Done in v2.
> >  
> > > +
> > > +What:                /sys/.../iio:deviceX/events/in_accel_offset_change_en
> > > +What:                /sys/.../iio:deviceX/events/in_magn_offset_change_en
> > > +What:                /sys/.../iio:deviceX/events/in_magn_scale_change_en
> > > +What:                /sys/.../iio:deviceX/events/in_anglvel_offset_change_en
> > > +KernelVersion:       x.y
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Some sensors internally calculate offset to apply to remove bias (for
> > > +             instance, hard/soft-iron bias for magnetometer, online calibration bias for
> > > +             gyroscope or accelerometer).
> > > +             When the sensor computes a new set of offset values, it generates an
> > > +             event for the userspace application to refresh the offsets to apply to raw
> > > +             data.  
> >
> > I'm not totally sold on this idea, though would like inputs from other people before
> > ruling it out.
> >
> > One minor change I'd make would be to have a single event to indicate that something
> > userspace might care about in the way of metadata for this channel has changed.
> > I guess something like  
> Make sense, scale and offset should be checked together if they both exists.
> Using vents/in_<type>_metadata_en in v2.
> >
> > in_accel_metachange_en etc with a single new event code.  For events, it's the event
> > code mapping that normally matters more than sysfs binding as that is much more
> > tightly restricted.
> >
> > Jonathan
> >  

