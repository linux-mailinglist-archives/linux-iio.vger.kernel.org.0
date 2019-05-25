Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95E82A220
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2019 02:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEYA2y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 20:28:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40785 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfEYA2x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2019 20:28:53 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so16258531itf.5
        for <linux-iio@vger.kernel.org>; Fri, 24 May 2019 17:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJl2y/2VeXoRp5nqdS1Giklh1RcU9ZirEcrKjJT5+I0=;
        b=FR+11UmKdJ3V3Ee8HFOSIFSoJrx8FkKmvNI+1FbfAKZq/87wn6C3HN/6cOAOovg787
         Yw5WbnxtX0gwQmR0x23LqFvFkEUGnALzSU5CG/lF6LYABvF5vkNLPIl56c0EOvCsOQYN
         Q5nv+HRncndknW7IKVQU9lAeqWnLVcY1/A49g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJl2y/2VeXoRp5nqdS1Giklh1RcU9ZirEcrKjJT5+I0=;
        b=eus8j7cJGpCmRj+cUXeOJd0L+CaMPTL69Je6v06B3ITDgnM4qRZG+g31rg2LyxGNjz
         SKEm3Z8s96ske6d4iP0RwnnzxtIvp6u6Ihs4jax1EdK6FarhxakyOdZDuQ9cXQDdryup
         PAKdCi9HyKD/MdzibjE1fkm89jPkV/mcl+InlVHf+j/M4hxNLcCWb6TLhWXxt3tVaQrR
         ew7si3n5TioXOZnQn1q1YSV8CvKKsUGP24JClrvvr04UHvJHUJ6ksiWfZmlKymA+MwOv
         Gx1Y9hoxDu74EIxAcOzkSBitQKGpkVqZWMFWmq09p4pbgGAqpg1mL1W6i6lxs8/2ELHP
         mhAw==
X-Gm-Message-State: APjAAAV54gtPVFtQsmKvPpUYZ4DgA8OxvGIgav2qEeVTBx8Y36CaT+Nw
        MUWI/P/+dcR284FGhDnTgSL2xS48ghvrgryOvdYwH1zRvc1MBg==
X-Google-Smtp-Source: APXvYqyiDDv0VSrCW6eUY79D0aOtxfZAhDwdUn8lyr3b+k5NhLU5h4nmNUyYvzihAihNtw1cviOr4IQbiBTrIpYXxI4=
X-Received: by 2002:a24:1185:: with SMTP id 127mr18846962itf.106.1558744132968;
 Fri, 24 May 2019 17:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556873525.git.fabien.lahoudere@collabora.com>
 <f30612908370460d61904450d6f7c5224082898e.1556873525.git.fabien.lahoudere@collabora.com>
 <20190505163647.4f961a0d@archlinux>
In-Reply-To: <20190505163647.4f961a0d@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 24 May 2019 17:28:42 -0700
Message-ID: <CAPUE2usHHhzzE4cRDxk3KBwRvaaUWQZ=M7j+thHxpCiYmkguFA@mail.gmail.com>
Subject: Re: [RFC 1/1] iio: common: cros_ec_sensors: add extra sensor API
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 5, 2019 at 8:36 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Fri,  3 May 2019 12:54:46 +0200
> Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
>
> > From: Gwendal Grignou <gwendal@chromium.org>
> >
> > Version 3 of the EC protocol provides min and max frequencies and fifo
> > size for EC sensors.
> > The driver allows EC to set parameters for version 3 and set default values
> > for earlier versions.
> > The sysfs entries are read only and cannot be used to impact on values.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> Mostly changes in here will follow from comments on the cover letter
> but a few other things inline.
>
> Thanks,
>
> Jonathan
> > ---
> >  .../ABI/testing/sysfs-bus-iio-cros-ec         |  24 ++++
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 126 +++++++++++++++++-
> >  .../linux/iio/common/cros_ec_sensors_core.h   |   7 +
> >  include/linux/mfd/cros_ec_commands.h          |  21 +++
> >  4 files changed, 177 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > index 0e95c2ca105c..85d266f4a57e 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > @@ -26,3 +26,27 @@ Description:
> >               driver and represents the sensor ID as exposed by the EC. This
> >               ID is used by the Android sensor service hardware abstraction
> >               layer (sensor HAL) through the Android container on ChromeOS.
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/min_frequency
> > +Date:                April 2019
> > +KernelVersion:       5.0
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             This attribute is exposed by CrOS EC sensors. It defines the
> > +             minimum frequency used by the sensor.
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/max_frequency
> > +Date:                April 2019
> > +KernelVersion:       5.0
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             This attribute is exposed by CrOS EC sensors. It defines the
> > +             maximum frequency used by the sensor.
> > +
> See reply to the cover letter on these.  Bonus points if you implement them
> with the read_avail callback.
>
> > +What:                /sys/bus/iio/devices/iio:deviceX/max_events
> > +Date:                April 2019
> > +KernelVersion:       5.0
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             This attribute is exposed by CrOS EC sensors. It defines the
> > +             maximum number of events in the fifo.
>
> Why does userspace care?
Is use to report the size of the hardware FIFO to Android, to enable
batching mode:
https://source.android.com/devices/sensors/batching.
It is reported in fifoReservedEventCount or fifoMaxEventCount in the
sensor_t structure described at
https://source.android.com/devices/sensors/hal-interface#sensor_t.
Having said that, batching is not terribly useful for tablet or
laptop, but is critical for wearable.
