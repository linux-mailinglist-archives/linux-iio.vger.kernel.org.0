Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0A62F35E
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 06:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfE3E2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 00:28:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43769 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfE3E2k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 May 2019 00:28:40 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so3886797ios.10
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2019 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwRO/TSythWb36X3ombHqwGg/YcZXc+W15nNG8w7o4Q=;
        b=FFcbyccx/SWgV2+YtKe0ieWLqAmbwmkBAvRgaQeP8RgdXFCdeFfldp2ZpdaTTavfl4
         XM+doA23/townPIUONGAJ14Fuz/ImS7zoFLqUm9R5gfie3Unfq2rRldAX36PGX5gBXNw
         3+g+4PuPrCGLHw+OwQiObuQFWTbbZTx5Z5tz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwRO/TSythWb36X3ombHqwGg/YcZXc+W15nNG8w7o4Q=;
        b=SziDwUwFhHuWy1HZXPBjm2zBGYSb0Y7wQFLVwCNJkasIsMnR7BTIYRGNIDWhIz5COK
         2FNmYMUMAYYtHwt7M4vJBen6/+II1Qh7CuC/aO5CJ4CvjBoLrwdRE/P/Y8uAjCdopY4V
         I0u0nGgKSEKOKybij/P1Zp9AMJWPfck62QJweC/8unr3qnFKcAyBQIS+UqfSCBdoY0yU
         nUmLgXIljja5sJnwI8Epx1ZYDwb23xOraqLmzJwJJbsj5YKhmpcZOYHspsBeNW08lqU6
         3HjOcVczOmOi7dOw/wxjGfTK9ipsYihsF6/tPC85+7xr9VRuiPxIy4drgPAQ1UjcvCTE
         v1iA==
X-Gm-Message-State: APjAAAUG0bblkyBog4Hj0FmUeqm+uu/9HCryr7qjwKMImc38IVMUflV4
        9lda354s3tX+ZtdTPC0LI0SH75Yo1v6ofPZ7D4zP5/K/dRo=
X-Google-Smtp-Source: APXvYqz847NSZfnq8RE2DIIj1HJhfcxpbujSFFz3azlx734cCjodfxuBKRL4ncgq8yCJ4Wzu70/MPnAZp/vMvzfC4nk=
X-Received: by 2002:a6b:8f93:: with SMTP id r141mr1223781iod.145.1559190520043;
 Wed, 29 May 2019 21:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556873525.git.fabien.lahoudere@collabora.com>
 <f30612908370460d61904450d6f7c5224082898e.1556873525.git.fabien.lahoudere@collabora.com>
 <20190505163647.4f961a0d@archlinux> <CAPUE2usHHhzzE4cRDxk3KBwRvaaUWQZ=M7j+thHxpCiYmkguFA@mail.gmail.com>
 <20190527101804.3dac8802@archlinux>
In-Reply-To: <20190527101804.3dac8802@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 29 May 2019 21:28:28 -0700
Message-ID: <CAPUE2us1qG2AcOhO54qmZ9Azx_97C2id2vgdJRx=715xuDxqpw@mail.gmail.com>
Subject: Re: [RFC 1/1] iio: common: cros_ec_sensors: add extra sensor API
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 27, 2019 at 2:18 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Fri, 24 May 2019 17:28:42 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > On Sun, May 5, 2019 at 8:36 AM Jonathan Cameron
> > <jic23@jic23.retrosnub.co.uk> wrote:
> > >
> > > On Fri,  3 May 2019 12:54:46 +0200
> > > Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> > >
> > > > From: Gwendal Grignou <gwendal@chromium.org>
> > > >
> > > > Version 3 of the EC protocol provides min and max frequencies and fifo
> > > > size for EC sensors.
> > > > The driver allows EC to set parameters for version 3 and set default values
> > > > for earlier versions.
> > > > The sysfs entries are read only and cannot be used to impact on values.
> > > >
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > Mostly changes in here will follow from comments on the cover letter
> > > but a few other things inline.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > > > ---
> > > >  .../ABI/testing/sysfs-bus-iio-cros-ec         |  24 ++++
> > > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 126 +++++++++++++++++-
> > > >  .../linux/iio/common/cros_ec_sensors_core.h   |   7 +
> > > >  include/linux/mfd/cros_ec_commands.h          |  21 +++
> > > >  4 files changed, 177 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > > index 0e95c2ca105c..85d266f4a57e 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > > @@ -26,3 +26,27 @@ Description:
> > > >               driver and represents the sensor ID as exposed by the EC. This
> > > >               ID is used by the Android sensor service hardware abstraction
> > > >               layer (sensor HAL) through the Android container on ChromeOS.
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/min_frequency
> > > > +Date:                April 2019
> > > > +KernelVersion:       5.0
> > > > +Contact:     linux-iio@vger.kernel.org
> > > > +Description:
> > > > +             This attribute is exposed by CrOS EC sensors. It defines the
> > > > +             minimum frequency used by the sensor.
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/max_frequency
> > > > +Date:                April 2019
> > > > +KernelVersion:       5.0
> > > > +Contact:     linux-iio@vger.kernel.org
> > > > +Description:
> > > > +             This attribute is exposed by CrOS EC sensors. It defines the
> > > > +             maximum frequency used by the sensor.
> > > > +
> > > See reply to the cover letter on these.  Bonus points if you implement them
> > > with the read_avail callback.
> > >
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/max_events
> > > > +Date:                April 2019
> > > > +KernelVersion:       5.0
> > > > +Contact:     linux-iio@vger.kernel.org
> > > > +Description:
> > > > +             This attribute is exposed by CrOS EC sensors. It defines the
> > > > +             maximum number of events in the fifo.
> > >
> > > Why does userspace care?
> > Is use to report the size of the hardware FIFO to Android, to enable
> > batching mode:
> > https://source.android.com/devices/sensors/batching.
> > It is reported in fifoReservedEventCount or fifoMaxEventCount in the
> > sensor_t structure described at
> > https://source.android.com/devices/sensors/hal-interface#sensor_t.
> > Having said that, batching is not terribly useful for tablet or
> > laptop, but is critical for wearable.
>
> Ok. So let me just check, in android terms, events are just readings
> from the sensor?
Yes [https://source.android.com/devices/sensors/hal-interface#sensors_event_t]
> These aren't events in the IIO sense of 'thresholds'
> being passed?
Correct.
>
> If so can we map this to hwfifo_watermark[_available] using the range
> descriptor? We have a bit of legacy around that with  hwfifo_watermark_max
> and hwfifo_watermark_min also defined, but should probably move towards
> the more standard _available form and deprecate the other two.
That make sense: hwfifo_watermark_available will be set to a single
value, which match hwfifo_watermak_max.
Cros EC has a limited support:
- the size can not be changed
- the EC will seldom fill the hwfifo, it fires interrupt to a hard
coded threshold to avoid losing samples
- the hwfifo is shared by all sensors
- sampling_frequency attribute is used to force the EC to generate
interrupt before the hwfifo is full.

Replacing max_events with hwfifo_watermark_max works for me.

Thanks,
Gwendal.
>
> Jonathan
>
>
