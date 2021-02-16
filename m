Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E008F31C8AF
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 11:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBPKWh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 05:22:37 -0500
Received: from foss.arm.com ([217.140.110.172]:59872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhBPKV7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Feb 2021 05:21:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915D81FB;
        Tue, 16 Feb 2021 02:21:08 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86EC43F73B;
        Tue, 16 Feb 2021 02:21:05 -0800 (PST)
Date:   Tue, 16 Feb 2021 10:20:59 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>
Subject: Re: [PATCH v5 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210216102045.GC29356@e120937-lin>
References: <20210208211918.1280588-1-jbhayana@google.com>
 <20210208211918.1280588-2-jbhayana@google.com>
 <20210209115639.GC6873@e120937-lin>
 <CA+=V6c12nRxLCxM2DPst8RV=i+1WatPyHcQQZp4xAzuoN0vKaw@mail.gmail.com>
 <20210210214619.GD6873@e120937-lin>
 <20210212191850.0748ccdb@archlinux>
 <20210215092526.GA29356@e120937-lin>
 <20210215110756.28567df8@archlinux>
 <20210215144737.GB29356@e120937-lin>
 <CA+=V6c3xmidg9BCZuEoigwcbDwW-sTCZWnVCkPhj4KMCzYCehg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=V6c3xmidg9BCZuEoigwcbDwW-sTCZWnVCkPhj4KMCzYCehg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jyoti,

On Mon, Feb 15, 2021 at 04:14:57PM -0800, Jyoti Bhayana wrote:
> Hi Jonathan/Cristian,
> 
> I have uploaded v6 of the IIO SCMI patch. Not sure if you got a chance to
> review that version and if any further changes are needed.

Seen that, for the SCMI part seemed fine to me, I'll just have still to
reply.

> My IIO SCMI patch is independent of Cristian series mentioned at
> https://lore.kernel.org/linux-arm-kernel/20210202221555.41167-1-cristian.marussi@arm.com/
> right?

Yes, that's true, your patch is independent and goes in as it is now, and I'll
rebase my series on yours on a dedicated branch and make all the needed
(small) interface changes.

> and it can be merged without the Cristian Series right? Are there plans to
> merge my v6 of the IIO SCMI patch and Cristian latest series in the same
> linux tree version?

Yes absolutely, your driver can be merged as it is without my series, but due
to the timing they ended up targeting the same Linux version 5.13 at the
end, so they will be merged both in v5.13, yours first as it is now, mine
immediately rebased on top of it aftewards: the end result will be both
series in the same v5.13 but as distinct patches. (so you can still backport
yours on v5.4 as you're doing now.)

Thanks

Cristian

> 
> Thanks,
> Jyoti
> 
> On Mon, Feb 15, 2021 at 6:48 AM Cristian Marussi <cristian.marussi@arm.com>
> wrote:
> 
> > On Mon, Feb 15, 2021 at 11:07:56AM +0000, Jonathan Cameron wrote:
> > > On Mon, 15 Feb 2021 09:25:26 +0000
> > > Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > > On Fri, Feb 12, 2021 at 07:18:58PM +0000, Jonathan Cameron wrote:
> > > > > On Wed, 10 Feb 2021 21:46:19 +0000
> > > > > Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > > >
> > > > > > Hi Jyoti,
> > > > > >
> > > > > > On Wed, Feb 10, 2021 at 11:19:35AM -0800, Jyoti Bhayana wrote:
> > > > > > > Hi Cristian,
> > > > > > >
> > > > > > > Thanks for the feedback. Regarding registering callbacks at the
> > probe time
> > > > > > > instead of .preenable, I have tried it before but I think due to
> > some
> > > > > > > issues(don't remember it now maybe on the platform side)  I kept
> > it at the
> > > > > > > .preenable level.
> > > > > > >
> > > > > > > But you are right, that it will be nice to move it at the probe
> > level
> > > > > > > instead. I will try again and test if it works and would move it
> > at the
> > > > > > > probe level. Regarding the unregistering of the notifier, is it
> > required at
> > > > > > > the remove of iio driver or scmi driver will take care of it?
> > > > > > > Because if I add unregister at the iio driver remove level, I
> > would have to
> > > > > > > iterate all the sensors again and unregister them.
> > > > > >
> > > > > > Yes you are right if you move callbacks registration once for all
> > to the
> > > > > > .probe step you'll have to unregister them all in a .remove.
> > > > > >
> > > > > > BUT I think instead you should stick with your current solution
> > given
> > > > > > it's working fine anyway and it's supported by the notification
> > > > > > framework and also for another reason I'm going to explain down
> > below
> > > > > > (which is also the reason why I asked you this at first :D)
> > > > > >
> > > > > > As you may remember I'm refactoring all the SCMI internals in a
> > separate
> > > > > > series to ease modularization and vendor protocols support, and
> > that will
> > > > > > lead also to some changes in the SCMI driver interface that you
> > use:
> > > > > > amongst other things one interesting addition will be a new devres
> > managed
> > > > > > notification registration method, something like:
> > > > > >
> > > > > > handle->notify_ops->devm_register_notifier(sdev, ...);
> > > > > >
> > > > > > With such method you could just move your registration to the
> > .probe
> > > > > > step and just forget about it, without the need to add any
> > unregistration
> > > > > > in the .remove step, since the core will take care to remove all
> > the
> > > > > > callbacks at driver unloading time.
> > > > > >
> > > > > > Now, this series, which is here if you want to have a look:
> > > > > >
> > > > > >
> > https://lore.kernel.org/linux-arm-kernel/20210202221555.41167-1-cristian.marussi@arm.com/
> > > > > >
> > > > > > is already taking care to port any existent SCMI driver to the new
> > interface,
> > > > > > so when your IIODEV SCMI driver will be finally queued somewhere
> > for merge, I
> > > > > > can in turn rebase my series on yours and take care to port your
> > driver too to
> > > > > > the new interface applying the changes above in the context of my
> > series.
> > > > > > (and ask you to review of course :D)
> > > > >
> > > > > I'm guessing you probably want this driver in an immutable branch
> > then
> > > > > rather than having to wait another cycle for it to tick through to a
> > > > > a sensible upstream?
> > > > >
> > > >
> > > > Hi Jonathan
> > > >
> > > > the above series (still pending a final review from Sudeep) is targeted
> > > > at 5.13 at this point and usually it'd be queued via Sudeep
> > for-next/scmi
> > > > which in turn goes via the ARM soc branch.
> > > >
> > > > Having said that, I'm not really familiar enough with this sort of
> > clashes
> > > > to know how they should be properly handled, so I'll stick to what you
> > > > and Sudeep would think it's better :D (..and I'm pinging him to have a
> > say)
> > > >
> > > > Thanks
> > > >
> > > > Cristian
> > > Hi Cristian,
> > >
> > > So this driver will also be 5.13 material now (merge window for IIO
> > effectively
> > > closes 1-2 weeks before Linus opens the main one).
> > >
> > > The way we normally handle cases like this where we likely to have
> > dependencies
> > > on a patch set from two separate directions is to do what is known as an
> > > immutable branch.  This is a branch that would probably be based on
> > 5.12-rc1
> > > containing just this driver.
> > >
> > > Then both trees, in this case IIO and scmi merge that branch.  The magic
> > > of git then means that when Linus gets the eventual pull requests for
> > > the two trees, the git IDs and content will be the same and the history
> > > of that particular set of files will be cleanly maintained.
> > >
> > > This happens quite a lot for certain parts of the kernel because there
> > are
> > > a lot of cross dependencies.
> > >
> > Hi Jonathan
> >
> > thanks for clarifying.
> >
> > Cristian
> >
> > > @Sudeep, that work for you?  Have to wait for 5.12-rc1 though to give
> > > us a sensible base.
> > >
> > > Jonathan
> > >
> > > >
> > > > > Jonathan
> > > > >
> > > > > >
> > > > > > I'm saying that is better if you keep your series as it is for now
> > > > > > (old interface + .preenable/.postdisable regs/unregs) because, as
> > said,
> > > > > > with the new interface the devm_ methods will ease the registration
> > > > > > @probe time, and also especially because the new interface is not
> > (and
> > > > > > most probably won't) be part of the v5.4 backport that you are
> > testing
> > > > > > against: so if you stick with your current solution you'll have a
> > > > > > working patch easily backportable now, and once queued I'll port
> > it to
> > > > > > the interface using devm_ (so simplifying it)
> > > > > >
> > > > > > In this context, it would be indeed important to know if in
> > general moving
> > > > > > registration to the probe phase (which should be fine by the spec)
> > poses
> > > > > > any kind of problem. (and that's reason why asked it)
> > > > > >
> > > > > > Hope to have been clear despite the flood of words :D
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > Cristian
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Jyoti
> > > > > > >
> > > > > > > On Tue, Feb 9, 2021 at 3:56 AM Cristian Marussi <
> > cristian.marussi@arm.com>
> > > > > > > wrote:
> > > > > > >
> > > > > > > > Hi Jyoti
> > > > > > > >
> > > > > > > > some minor things down below.
> > > > > > > >
> > > > > > > > Other than that, FWIW about the SCMI side of this:
> > > > > > > >
> > > > > > > > Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > Cristian
> > > > > > > >
> > > > > > > > On Mon, Feb 08, 2021 at 09:19:18PM +0000, Jyoti Bhayana
> > wrote:
> > > > > > > > > This change provides ARM SCMI Protocol based IIO device.
> > > > > > > > > This driver provides support for Accelerometer and Gyroscope
> > using
> > > > > > > > > SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM
> > specification
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
> > > > > > > > > ---
> > > > > > > > >  MAINTAINERS                                |   6 +
> > > > > > > > >  drivers/firmware/arm_scmi/driver.c         |   2 +-
> > > > > > > > >  drivers/iio/common/Kconfig                 |   1 +
> > > > > > > > >  drivers/iio/common/Makefile                |   1 +
> > > > > > > > >  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
> > > > > > > > >  drivers/iio/common/scmi_sensors/Makefile   |   5 +
> > > > > > > > >  drivers/iio/common/scmi_sensors/scmi_iio.c | 673
> > +++++++++++++++++++++
> > > > > > > > >  7 files changed, 705 insertions(+), 1 deletion(-)
> > > > > > > > >  create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
> > > > > > > > >  create mode 100644 drivers/iio/common/scmi_sensors/Makefile
> > > > > > > > >  create mode 100644
> > drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > > > > >
> > > > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > > > index b516bb34a8d5..ccf37d43ab41 100644
> > > > > > > > > --- a/MAINTAINERS
> > > > > > > > > +++ b/MAINTAINERS
> > > > > > > > > @@ -8567,6 +8567,12 @@ S:     Maintained
> > > > > > > > >  F:
> > > > > > > >
> > Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> > > > > > > > >  F:   drivers/iio/multiplexer/iio-mux.c
> > > > > > > > >
> > > > > > > > > +IIO SCMI BASED DRIVER
> > > > > > > > > +M:   Jyoti Bhayana <jbhayana@google.com>
> > > > > > > > > +L:   linux-iio@vger.kernel.org
> > > > > > > > > +S:   Maintained
> > > > > > > > > +F:   drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > > > > > +
> > > > > > > > >  IIO SUBSYSTEM AND DRIVERS
> > > > > > > > >  M:   Jonathan Cameron <jic23@kernel.org>
> > > > > > > > >  R:   Lars-Peter Clausen <lars@metafoo.de>
> > > > > > > > > diff --git a/drivers/firmware/arm_scmi/driver.c
> > > > > > > > b/drivers/firmware/arm_scmi/driver.c
> > > > > > > > > index 5392e1fc6b4e..248313bbd473 100644
> > > > > > > > > --- a/drivers/firmware/arm_scmi/driver.c
> > > > > > > > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > > > > > > > @@ -741,7 +741,7 @@ static struct scmi_prot_devnames
> > devnames[] = {
> > > > > > > > >       { SCMI_PROTOCOL_SYSTEM, { "syspower" },},
> > > > > > > > >       { SCMI_PROTOCOL_PERF,   { "cpufreq" },},
> > > > > > > > >       { SCMI_PROTOCOL_CLOCK,  { "clocks" },},
> > > > > > > > > -     { SCMI_PROTOCOL_SENSOR, { "hwmon" },},
> > > > > > > > > +     { SCMI_PROTOCOL_SENSOR, { "hwmon", "iiodev" },},
> > > > > > > > >       { SCMI_PROTOCOL_RESET,  { "reset" },},
> > > > > > > > >       { SCMI_PROTOCOL_VOLTAGE,  { "regulator" },},
> > > > > > > > >  };
> > > > > > > > > diff --git a/drivers/iio/common/Kconfig
> > b/drivers/iio/common/Kconfig
> > > > > > > > > index 2b9ee9161abd..0334b4954773 100644
> > > > > > > > > --- a/drivers/iio/common/Kconfig
> > > > > > > > > +++ b/drivers/iio/common/Kconfig
> > > > > > > > > @@ -6,5 +6,6 @@
> > > > > > > > >  source "drivers/iio/common/cros_ec_sensors/Kconfig"
> > > > > > > > >  source "drivers/iio/common/hid-sensors/Kconfig"
> > > > > > > > >  source "drivers/iio/common/ms_sensors/Kconfig"
> > > > > > > > > +source "drivers/iio/common/scmi_sensors/Kconfig"
> > > > > > > > >  source "drivers/iio/common/ssp_sensors/Kconfig"
> > > > > > > > >  source "drivers/iio/common/st_sensors/Kconfig"
> > > > > > > > > diff --git a/drivers/iio/common/Makefile
> > b/drivers/iio/common/Makefile
> > > > > > > > > index 4bc30bb548e2..fad40e1e1718 100644
> > > > > > > > > --- a/drivers/iio/common/Makefile
> > > > > > > > > +++ b/drivers/iio/common/Makefile
> > > > > > > > > @@ -11,5 +11,6 @@
> > > > > > > > >  obj-y += cros_ec_sensors/
> > > > > > > > >  obj-y += hid-sensors/
> > > > > > > > >  obj-y += ms_sensors/
> > > > > > > > > +obj-y += scmi_sensors/
> > > > > > > > >  obj-y += ssp_sensors/
> > > > > > > > >  obj-y += st_sensors/
> > > > > > > > > diff --git a/drivers/iio/common/scmi_sensors/Kconfig
> > > > > > > > b/drivers/iio/common/scmi_sensors/Kconfig
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..67e084cbb1ab
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/drivers/iio/common/scmi_sensors/Kconfig
> > > > > > > > > @@ -0,0 +1,18 @@
> > > > > > > > > +#
> > > > > > > > > +# IIO over SCMI
> > > > > > > > > +#
> > > > > > > > > +# When adding new entries keep the list in alphabetical
> > order
> > > > > > > > > +
> > > > > > > > > +menu "IIO SCMI Sensors"
> > > > > > > > > +
> > > > > > > > > +config IIO_SCMI
> > > > > > > > > +     tristate "IIO SCMI"
> > > > > > > > > +        depends on ARM_SCMI_PROTOCOL
> > > > > > > > > +        select IIO_BUFFER
> > > > > > > > > +        select IIO_KFIFO_BUF
> > > > > > > > > +     help
> > > > > > > > > +          Say yes here to build support for IIO SCMI Driver.
> > > > > > > > > +          This provides ARM SCMI Protocol based IIO device.
> > > > > > > > > +          This driver provides support for accelerometer
> > and gyroscope
> > > > > > > > > +          sensors available on SCMI based platforms.
> > > > > > > > > +endmenu
> > > > > > > > > diff --git a/drivers/iio/common/scmi_sensors/Makefile
> > > > > > > > b/drivers/iio/common/scmi_sensors/Makefile
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..f13140a2575a
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/drivers/iio/common/scmi_sensors/Makefile
> > > > > > > > > @@ -0,0 +1,5 @@
> > > > > > > > > +# SPDX - License - Identifier : GPL - 2.0 - only
> > > > > > > > > +#
> > > > > > > > > +# Makefile for the IIO over SCMI
> > > > > > > > > +#
> > > > > > > > > +obj-$(CONFIG_IIO_SCMI) += scmi_iio.o
> > > > > > > > > diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > > > > b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..093b1fc24e27
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > > > > > @@ -0,0 +1,673 @@
> > > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > + * System Control and Management Interface(SCMI) based IIO
> > sensor driver
> > > > > > > > > + *
> > > > > > > > > + * Copyright (C) 2021 Google LLC
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +#include <linux/delay.h>
> > > > > > > > > +#include <linux/err.h>
> > > > > > > > > +#include <linux/iio/buffer.h>
> > > > > > > > > +#include <linux/iio/iio.h>
> > > > > > > > > +#include <linux/iio/kfifo_buf.h>
> > > > > > > > > +#include <linux/iio/sysfs.h>
> > > > > > > > > +#include <linux/kernel.h>
> > > > > > > > > +#include <linux/kthread.h>
> > > > > > > > > +#include <linux/module.h>
> > > > > > > > > +#include <linux/scmi_protocol.h>
> > > > > > > > > +#include <linux/time.h>
> > > > > > > > > +#include <linux/types.h>
> > > > > > > > > +
> > > > > > > > > +#define SCMI_IIO_NUM_OF_AXIS 3
> > > > > > > > > +
> > > > > > > > > +struct scmi_iio_priv {
> > > > > > > > > +     struct scmi_handle *handle;
> > > > > > > > > +     const struct scmi_sensor_info *sensor_info;
> > > > > > > > > +     struct iio_dev *indio_dev;
> > > > > > > > > +     /* adding one additional channel for timestamp */
> > > > > > > > > +     long long iio_buf[SCMI_IIO_NUM_OF_AXIS + 1];
> > > > > > > > > +     struct notifier_block sensor_update_nb;
> > > > > > > > > +     u32 *freq_avail;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +static int scmi_iio_sensor_update_cb(struct notifier_block
> > *nb,
> > > > > > > > > +                                  unsigned long event, void
> > *data)
> > > > > > > > > +{
> > > > > > > > > +     struct scmi_sensor_update_report *sensor_update = data;
> > > > > > > > > +     struct iio_dev *scmi_iio_dev;
> > > > > > > > > +     struct scmi_iio_priv *sensor;
> > > > > > > > > +     s8 tstamp_scale;
> > > > > > > > > +     u64 time, time_ns;
> > > > > > > > > +     int i;
> > > > > > > > > +
> > > > > > > > > +     if (sensor_update->readings_count == 0)
> > > > > > > > > +             return NOTIFY_DONE;
> > > > > > > > > +
> > > > > > > > > +     sensor = container_of(nb, struct scmi_iio_priv,
> > sensor_update_nb);
> > > > > > > > > +
> > > > > > > > > +     for (i = 0; i < sensor_update->readings_count; i++)
> > > > > > > > > +             sensor->iio_buf[i] =
> > sensor_update->readings[i].value;
> > > > > > > > > +
> > > > > > > > > +     if (!sensor->sensor_info->timestamped) {
> > > > > > > > > +             time_ns =
> > ktime_to_ns(sensor_update->timestamp);
> > > > > > > > > +     } else {
> > > > > > > > > +             /*
> > > > > > > > > +              *  All the axes are supposed to have the same
> > value for
> > > > > > > > timestamp.
> > > > > > > > > +              *  We are just using the values from the Axis
> > 0 here.
> > > > > > > > > +              */
> > > > > > > > > +             time = sensor_update->readings[0].timestamp;
> > > > > > > > > +
> > > > > > > > > +             /*
> > > > > > > > > +              *  Timestamp returned by SCMI is in seconds
> > and is equal
> > > > > > > > to
> > > > > > > > > +              *  time * power-of-10
> > multiplier(tstamp_scale) seconds.
> > > > > > > > > +              *  Converting the timestamp to nanoseconds
> > below.
> > > > > > > > > +              */
> > > > > > > > > +             tstamp_scale =
> > sensor->sensor_info->tstamp_scale +
> > > > > > > > > +                            const_ilog2(NSEC_PER_SEC) /
> > const_ilog2(10);
> > > > > > > > > +             if (tstamp_scale < 0)
> > > > > > > > > +                     time_ns =
> > > > > > > > > +                             div64_u64(time, int_pow(10,
> > > > > > > > abs(tstamp_scale)));
> > > > > > > > > +             else
> > > > > > > > > +                     time_ns = time * int_pow(10,
> > tstamp_scale);
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     scmi_iio_dev = sensor->indio_dev;
> > > > > > > > > +     iio_push_to_buffers_with_timestamp(scmi_iio_dev,
> > sensor->iio_buf,
> > > > > > > > > +                                        time_ns);
> > > > > > > > > +     return NOTIFY_OK;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int scmi_iio_buffer_preenable(struct iio_dev
> > *iio_dev)
> > > > > > > > > +{
> > > > > > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > > > > > +     u32 sensor_id = sensor->sensor_info->id;
> > > > > > > > > +     u32 sensor_config = 0;
> > > > > > > > > +     int err;
> > > > > > > > > +
> > > > > > > > > +     if (sensor->sensor_info->timestamped)
> > > > > > > > > +             sensor_config |=
> > > > > > > > FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
> > > > > > > > > +
> >  SCMI_SENS_CFG_TSTAMP_ENABLE);
> > > > > > > > > +
> > > > > > > > > +     sensor_config |=
> > FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > > > > > > > +
> >  SCMI_SENS_CFG_SENSOR_ENABLE);
> > > > > > > > > +
> > > > > > > > > +     err =
> > > > > > > >
> > sensor->handle->notify_ops->register_event_notifier(sensor->handle,
> > > > > > > > > +                     SCMI_PROTOCOL_SENSOR,
> > SCMI_EVENT_SENSOR_UPDATE,
> > > > > > > > > +                     &sensor_id, &sensor->sensor_update_nb);
> > > > > > > > > +     if (err) {
> > > > > > > > > +             dev_err(&iio_dev->dev,
> > > > > > > > > +                     "Error in registering sensor update
> > notifier for
> > > > > > > > sensor %s err %d",
> > > > > > > > > +                     sensor->sensor_info->name, err);
> > > > > > > > > +             return err;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     err =
> > sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > > > > > > +                     sensor->sensor_info->id,
> > sensor_config);
> > > > > > > > > +     if (err) {
> > > > > > > > > +
> > > > > > > >
> > sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > > > > > > > > +                             SCMI_PROTOCOL_SENSOR,
> > > > > > > > > +                             SCMI_EVENT_SENSOR_UPDATE,
> > &sensor_id,
> > > > > > > > > +                             &sensor->sensor_update_nb);
> > > > > > > > > +             dev_err(&iio_dev->dev, "Error in enabling
> > sensor %s err
> > > > > > > > %d",
> > > > > > > > > +                     sensor->sensor_info->name, err);
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     return err;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int scmi_iio_buffer_postdisable(struct iio_dev
> > *iio_dev)
> > > > > > > > > +{
> > > > > > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > > > > > +     u32 sensor_id = sensor->sensor_info->id;
> > > > > > > > > +     u32 sensor_config = 0;
> > > > > > > > > +     int err;
> > > > > > > > > +
> > > > > > > > > +     sensor_config |=
> > FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > > > > > > > +
> >  SCMI_SENS_CFG_SENSOR_DISABLE);
> > > > > > > > > +
> > > > > > > > > +     err =
> > > > > > > >
> > sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > > > > > > > > +                     SCMI_PROTOCOL_SENSOR,
> > SCMI_EVENT_SENSOR_UPDATE,
> > > > > > > > > +                     &sensor_id, &sensor->sensor_update_nb);
> > > > > > > > > +     if (err) {
> > > > > > > > > +             dev_err(&iio_dev->dev,
> > > > > > > > > +                     "Error in unregistering sensor update
> > notifier for
> > > > > > > > sensor %s err %d",
> > > > > > > > > +                     sensor->sensor_info->name, err);
> > > > > > > > > +             return err;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     err =
> > sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > > > > > sensor_id,
> > > > > > > > > +
> > sensor_config);
> > > > > > > > > +     if (err) {
> > > > > > > > > +             dev_err(&iio_dev->dev,
> > > > > > > > > +                     "Error in disabling sensor %s with err
> > %d",
> > > > > > > > > +                     sensor->sensor_info->name, err);
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     return err;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static const struct iio_buffer_setup_ops
> > scmi_iio_buffer_ops = {
> > > > > > > > > +     .preenable = scmi_iio_buffer_preenable,
> > > > > > > > > +     .postdisable = scmi_iio_buffer_postdisable,
> > > > > > > > > +};
> > > > > > > >
> > > > > > > > This is just a question, I'm not suggesting to change anything
> > here at
> > > > > > > > this point to be clear, since it works just fine as it is.
> > > > > > > >
> > > > > > > > Following up a previous email, given these are called on
> > enable/disable
> > > > > > > > by sysfs, is there a specific reason why you configure here,
> > inside
> > > > > > > > these ops, also timestamping and callbacks  i.e. each time the
> > sensor is
> > > > > > > > turned on/off by sysfs ? ... instead of just, as an example,
> > enabling
> > > > > > > > in _preenable the sensor while registering callbacks and
> > enabling
> > > > > > > > timestamping once for all earlier during probe phase ?
> > > > > > > > (likewise for _postdisable -> remove)
> > > > > > > >
> > > > > > > > AFAIU the spec says notifications are emitted for sensors
> > which has
> > > > > > > > requested them (via SENSOR_CONTINUOUS_UPDATE_NOTIFY) BUT only
> > if the
> > > > > > > > sensor is enabled as a whole (via proper CONFIG_SET as you
> > do), so
> > > > > > > > that enabling/disabling the sensor as a whole should result in
> > starting/
> > > > > > > > stopping the notification flow without the need of
> > unregistering the
> > > > > > > > callbacks everytime. (same goes with the timestamping)
> > > > > > > >
> > > > > > > > In other words, I would expect the sensor to maintain its
> > state (on the
> > > > > > > > platform side) even when going through enable/disable cycles,
> > so that
> > > > > > > > it 'remembers' that timestamping/notifications were enabled
> > across an
> > > > > > > > on/off.
> > > > > > > >
> > > > > > > > This would reduce the number of SCMI messages exchanges
> > between the
> > > > > > > > kernel and the platform and should be supported by both, but
> > as said,
> > > > > > > > it's more of a question for the future, not necessarily for
> > this series.
> > > > > > > >
> > > > > > > > > +
> > > > > > > >
> > > > > > > > [snip]
> > > > > > > >
> > > > > > > > > +static int scmi_iio_set_sampling_freq_avail(struct iio_dev
> > *iio_dev)
> > > > > > > > > +{
> > > > > > > > > +     u64 cur_interval_ns, low_interval_ns,
> > high_interval_ns,
> > > > > > > > step_size_ns,
> > > > > > > > > +             hz, uhz;
> > > > > > > > > +     unsigned int cur_interval, low_interval,
> > high_interval, step_size;
> > > > > > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > > > > > +     int i;
> > > > > > > > > +
> > > > > > > > > +     sensor->freq_avail =
> > > > > > > > > +             devm_kzalloc(&iio_dev->dev,
> > > > > > > > > +                          sizeof(*sensor->freq_avail) *
> > > > > > > > > +
> > (sensor->sensor_info->intervals.count
> > > > > > > > * 2),
> > > > > > > > > +                          GFP_KERNEL);
> > > > > > > > > +     if (!sensor->freq_avail)
> > > > > > > > > +             return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +     if (sensor->sensor_info->intervals.segmented) {
> > > > > > > > > +             low_interval = sensor->sensor_info->intervals
> > > > > > > > > +
> > .desc[SCMI_SENS_INTVL_SEGMENT_LOW];
> > > > > > > > > +             low_interval_ns =
> > > > > > > > scmi_iio_convert_interval_to_ns(low_interval);
> > > > > > > > > +             convert_ns_to_freq(low_interval_ns, &hz, &uhz);
> > > > > > > > > +             sensor->freq_avail[0] = hz;
> > > > > > > > > +             sensor->freq_avail[1] = uhz;
> > > > > > > > > +
> > > > > > > > > +             step_size = sensor->sensor_info->intervals
> > > > > > > > > +
> >  .desc[SCMI_SENS_INTVL_SEGMENT_STEP];
> > > > > > > > > +             step_size_ns =
> > scmi_iio_convert_interval_to_ns(step_size);
> > > > > > > > > +             convert_ns_to_freq(step_size_ns, &hz, &uhz);
> > > > > > > > > +             sensor->freq_avail[2] = hz;
> > > > > > > > > +             sensor->freq_avail[3] = uhz;
> > > > > > > > > +
> > > > > > > > > +             high_interval = sensor->sensor_info->intervals
> > > > > > > > > +
> > > > > > > >  .desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
> > > > > > > > > +             high_interval_ns =
> > > > > > > > > +
> >  scmi_iio_convert_interval_to_ns(high_interval);
> > > > > > > > > +             convert_ns_to_freq(high_interval_ns, &hz,
> > &uhz);
> > > > > > > > > +             sensor->freq_avail[4] = hz;
> > > > > > > > > +             sensor->freq_avail[5] = uhz;
> > > > > > > > > +     } else {
> > > > > > > > > +             for (i = 0; i <
> > sensor->sensor_info->intervals.count; i++)
> > > > > > > > {
> > > > > > > > > +                     cur_interval =
> > > > > > > > sensor->sensor_info->intervals.desc[i];
> > > > > > > > > +                     cur_interval_ns =
> > > > > > > > > +
> > > > > > > >  scmi_iio_convert_interval_to_ns(cur_interval);
> > > > > > > > > +                     convert_ns_to_freq(cur_interval_ns,
> > &hz, &uhz);
> > > > > > > > > +                     sensor->freq_avail[i * 2] = hz;
> > > > > > > > > +                     sensor->freq_avail[i * 2 + 1] = uhz;
> > > > > > > > > +             }
> > > > > > > > > +     }
> > > > > > > > > +     return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int scmi_iio_buffers_setup(struct iio_dev
> > *scmi_iiodev)
> > > > > > > > > +{
> > > > > > > > > +     struct iio_buffer *buffer;
> > > > > > > > > +
> > > > > > > > > +     buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> > > > > > > > > +     if (!buffer)
> > > > > > > > > +             return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +     iio_device_attach_buffer(scmi_iiodev, buffer);
> > > > > > > > > +     scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> > > > > > > > > +     scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
> > > > > > > > > +     return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> > > > > > > > > +                               struct scmi_handle *handle,
> > > > > > > > > +                               const struct
> > scmi_sensor_info
> > > > > > > > *sensor_info)
> > > > > > > > > +{
> > > > > > > > > +     struct iio_chan_spec *iio_channels;
> > > > > > > > > +     struct scmi_iio_priv *sensor;
> > > > > > > > > +     enum iio_modifier modifier;
> > > > > > > > > +     enum iio_chan_type type;
> > > > > > > > > +     struct iio_dev *iiodev;
> > > > > > > > > +     int i, ret;
> > > > > > > > > +
> > > > > > > > > +     iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> > > > > > > > > +     if (!iiodev)
> > > > > > > > > +             return ERR_PTR(-ENOMEM);
> > > > > > > > > +
> > > > > > > > > +     iiodev->modes = INDIO_DIRECT_MODE;
> > > > > > > > > +     iiodev->dev.parent = dev;
> > > > > > > > > +     sensor = iio_priv(iiodev);
> > > > > > > > > +     sensor->handle = handle;
> > > > > > > > > +     sensor->sensor_info = sensor_info;
> > > > > > > > > +     sensor->sensor_update_nb.notifier_call =
> > scmi_iio_sensor_update_cb;
> > > > > > > > > +     sensor->indio_dev = iiodev;
> > > > > > > > > +
> > > > > > > > > +     /* adding one additional channel for timestamp */
> > > > > > > > > +     iiodev->num_channels = sensor_info->num_axis + 1;
> > > > > > > > > +     iiodev->name = sensor_info->name;
> > > > > > > > > +     iiodev->info = &scmi_iio_info;
> > > > > > > > > +
> > > > > > > > > +     iio_channels =
> > > > > > > > > +             devm_kzalloc(dev,
> > > > > > > > > +                          sizeof(*iio_channels) *
> > > > > > > > (iiodev->num_channels),
> > > > > > > > > +                          GFP_KERNEL);
> > > > > > > > > +     if (!iio_channels)
> > > > > > > > > +             return ERR_PTR(-ENOMEM);
> > > > > > > > > +
> > > > > > > > > +     scmi_iio_set_sampling_freq_avail(iiodev);
> > > > > > > >
> > > > > > > > You don't check this for retval, and it could fail with
> > -ENOMEM.
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +     for (i = 0; i < sensor_info->num_axis; i++) {
> > > > > > > > > +             ret =
> > scmi_iio_get_chan_type(sensor_info->axis[i].type,
> > > > > > > > &type);
> > > > > > > > > +             if (ret < 0)
> > > > > > > > > +                     return ERR_PTR(ret);
> > > > > > > > > +
> > > > > > > > > +             ret =
> > scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> > > > > > > > > +                                              &modifier);
> > > > > > > > > +             if (ret < 0)
> > > > > > > > > +                     return ERR_PTR(ret);
> > > > > > > > > +
> > > > > > > > > +             scmi_iio_set_data_channel(&iio_channels[i],
> > type, modifier,
> > > > > > > > > +
> >  sensor_info->axis[i].id);
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> > > > > > > > > +     iiodev->channels = iio_channels;
> > > > > > > > > +     return iiodev;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > >
> > > > >
> > >
> >
