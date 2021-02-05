Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2F310B21
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhBEMfd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 07:35:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2506 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhBEMda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 07:33:30 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DXF7D2Nl3z67kgh;
        Fri,  5 Feb 2021 20:27:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 13:32:36 +0100
Received: from localhost (10.47.29.206) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Feb 2021
 12:32:35 +0000
Date:   Fri, 5 Feb 2021 12:31:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jyoti Bhayana <jbhayana@google.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>
Subject: Re: [RFC PATCH v4 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210205123149.00005bf7@Huawei.com>
In-Reply-To: <CA+=V6c0_km3o5gdftePfjoHZimZtOU041fbguNSyXN0wu-hd6A@mail.gmail.com>
References: <20210129221818.3540620-1-jbhayana@google.com>
        <20210129221818.3540620-2-jbhayana@google.com>
        <20210131131141.468f1cc2@archlinux>
        <CA+=V6c27bGnba-c5wNd8Nwt7dBCgcozKOHKJzZ+EkOLmNf2L2Q@mail.gmail.com>
        <20210204165940.00005fc3@Huawei.com>
        <CA+=V6c0_km3o5gdftePfjoHZimZtOU041fbguNSyXN0wu-hd6A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.29.206]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Feb 2021 10:20:43 -0800
Jyoti Bhayana <jbhayana@google.com> wrote:

> Hi Jonathan,
> 
> Thanks for the clarification. One last question:
> 
> > Instead of using the read_avail callback (which I'd normally much prefer)
> >you can just do what lots of drivers in IIO do (predate the callback) and
> >provide your own implementation of the attribute.  
> 
> Regarding your comment above to provide our own implementation of the
> attribute, I had the following attributes defined in V1 of the patch for
> max_range and resolution.
> 
> +static IIO_DEVICE_ATTR(sensor_max_range, 0444,
> scmi_iio_get_sensor_max_range,
> +                      NULL, 0);
> +static IIO_DEVICE_ATTR(sensor_resolution, 0444,
> scmi_iio_get_sensor_resolution,
> +                      NULL, 0);
> 
> So do you mean that it is ok to put these two attributes back? 
No that would definite ABI that doesn't already exist and doesn't
fit with the general way the ABI works.  You can however do something like

static IIO_DEVICE_ATTR(in_accel_raw_avail, 0444, NULL, 0);

That should result in an element int he standard ABI but let you define
your own implementation.

> Also, in v1
> of the implementation sensor_resolution has the scale already applied as it
> is using a different exponent than sensor scale as discussed before. And
> sensor_range is raw value and user space needs to apply the sensor scale.

There is only one scale that is exposed to userspace.  The ABI doesn't allow
for any other so if you do add a second one no userspace space software will use
it.  Hence you need to do the maths inside the driver to present the value such
that when the userspace scale is applied you get the right number irrespective
of what is peing provided from SCMI.

> Is it ok to keep sensor_resolution like that or I would need to do the
> calculation to divide the sensor_resolution by sensor scale and provide the
> raw value for resolution instead?

Exactly - you will need to do that calculation.  It makes no sense to have
a userspace interface that allows for these to be in different units.


> Also sensor resolution will be
> float/double and sensor max range will be long long (int64) as no floating
> point is needed for that. 

You are printing a string from the attr, so it shouldn't matter.
[131313 1.312344 224456677] (with appropriate numbers and potentially a lot
more digits) should be fine.  We don't have many users of _raw_avail yet
(and I think they are all DACs).  Not min might well be negative depending on
sensor type and offsets etc.

As a side note, the real values the sensor is providing have to be expressed
as an integer (be it a 64 bit one potentially) * a fixed scale.
As all values have to fit that, logically the resolution when converted to
these units must also be an integer whether or not the specification technically
requires that.  As I understand it, it represents a step between neighbouring
values and those must both be represented as 64 bit integers or they can't
be passed through the interface.
   

> Let me know if that will be fine. I do not have
> sensor min range exposed as an attribute as that is not currently needed in
> our use case. So I am assuming it will be fine to just have these two
> attributes mentioned above for max range and resolution?

No, whilst we can extend the ABI (with a cost given that means you have userspace
that doesn't recognise new stuff) we need to remain inline with the ABI
in order to maintain consistency across different sensors.
Doing that is most of what makes a Linux subsystem work rather than just being
a collection of drivers, each with their own magic.

Sorry this discussion has taken so many rounds.  Unfortunately that
SCMI spec does some things that make no sense whatsoever for any situation with
direct interaction with a sensor.

The way resolution is expressed still has me more than a little bemused.

Jonathan

> 
> 
> Thanks,
> Jyoti
> 
> On Thu, Feb 4, 2021 at 9:00 AM Jonathan Cameron <Jonathan.Cameron@huawei.com>
> wrote:
> 
> > On Mon, 1 Feb 2021 22:53:18 -0800
> > Jyoti Bhayana <jbhayana@google.com> wrote:
> >  
> > > Hi Jonathan,
> > >
> > > I wanted to clarify a few things before I upload the next version of
> > > the patch. Can you please help provide some more details regarding the
> > > following questions?
> > >
> > > 1) You mentioned that  
> > >       > perhaps we just need to do the maths in here rather than rely  
> > > on core handling of IIO_VAL_FRACTIONAL.  
> > >        > That would give us a greater potential range"  
> > >
> > >         Can you please clarify with some examples of how I can use
> > > IIO_VAL_INT_PLUS_MICRO to represent a range which is larger than 32
> > > bits without changing the sensor scale?  
> >
> > Sorry I wasn't clear on what I meant here.
> > Instead of using the read_avail callback (which I'd normally much prefer)
> > you can just do what lots of drivers in IIO do (predate the callback) and
> > provide your own implementation of the attribute.  Then you can do
> > whatever precision of maths you like to generate the string that is
> > printed.   Any userspace code reading more decimal places than they
> > expect to see (using 32 bit float perhaps rather than a double) will
> > just round it I think.
> >  
> > >
> > > 2)  > #define ilog10(x) (ilog2(x) / const_ilog2(10))  
> > >      > That feels like it's probably not great for precision"  
> > >  I am only using this calculation to get the power of 10 multiplier
> > > used when setting the scmi sensor update interval, so the exact
> > > precision after the decimal point is not necessary.  I am only using
> > > at one place in the code, so either I can remove the #define and
> > > directly use it in the function or change the name of the #define.
> > > Please let me know what you think  
> > Put it inline as we probably don't want an ilog10 macro.
> > Sooner or later someone will add one to a generic header with resulting
> > confusion.
> >  
> > >
> > > 3)  
> > > > +#define UHZ_PER_HZ 1000000UL
> > > > +#define ODR_EXPAND(odr, uodr) (((odr) * 1000000ULL) + (uodr))  
> > >  
> > > >Prefix these if driver specific.
> > > >For those that aren't perhaps we can think about putting them in
> > > >generic headers  
> > >
> > > UHZ_PER_HZ is generic and not driver specific. Either I can use
> > > USEC_PER_SEC which is already defined in include/linux/time64.h or we
> > > can put UHZ_PER_HZ in a generic header instead. Please let me know
> > > your preference and also which header file you think it needs to be
> > > added in case of generic header.  
> >
> > It's only used in two places, I'd be tempted to just use the numeric
> > value.  Or perhaps define it locally to them.
> >  
> > > ODR_EXPAND is only used in one place in the code, and I can remove the
> > > #define and use it directly in the function. Let me know if that will
> > > be fine with you,  
> > That's fine.  
> > >
> > > Thanks,
> > > Jyoti
> > >
> > >
> > >
> > >
> > >
> > >
> > > On Sun, Jan 31, 2021 at 5:11 AM Jonathan Cameron <jic23@kernel.org>  
> > wrote:  
> > > >
> > > > On Fri, 29 Jan 2021 22:18:18 +0000
> > > > Jyoti Bhayana <jbhayana@google.com> wrote:
> > > >  
> > > > > This change provides ARM SCMI Protocol based IIO device.
> > > > > This driver provides support for Accelerometer and Gyroscope using
> > > > > SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM  
> > specification  
> > > > >
> > > > > Signed-off-by: Jyoti Bhayana <jbhayana@google.com>  
> > > >
> > > > A few minor things noticed on a fresh read through, but mostly I think
> > > > we are down to figuring out how to deal with the range (as discussed
> > > > in the thread continuing on v3).
> > > >
> > > > On another note, probably time to drop the RFC or give a bit more  
> > detail  
> > > > on why you think this isn't ready to be applied.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >  
> > > > > ---
> > > > >  MAINTAINERS                                |   6 +
> > > > >  drivers/iio/common/Kconfig                 |   1 +
> > > > >  drivers/iio/common/Makefile                |   1 +
> > > > >  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
> > > > >  drivers/iio/common/scmi_sensors/Makefile   |   5 +
> > > > >  drivers/iio/common/scmi_sensors/scmi_iio.c | 742  
> > +++++++++++++++++++++  
> > > > >  6 files changed, 773 insertions(+)
> > > > >  create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
> > > > >  create mode 100644 drivers/iio/common/scmi_sensors/Makefile
> > > > >  create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index b516bb34a8d5..ccf37d43ab41 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -8567,6 +8567,12 @@ S:     Maintained
> > > > >  F:  
> >  Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt  
> > > > >  F:   drivers/iio/multiplexer/iio-mux.c
> > > > >
> > > > > +IIO SCMI BASED DRIVER
> > > > > +M:   Jyoti Bhayana <jbhayana@google.com>
> > > > > +L:   linux-iio@vger.kernel.org
> > > > > +S:   Maintained
> > > > > +F:   drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > +
> > > > >  IIO SUBSYSTEM AND DRIVERS
> > > > >  M:   Jonathan Cameron <jic23@kernel.org>
> > > > >  R:   Lars-Peter Clausen <lars@metafoo.de>
> > > > > diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
> > > > > index 2b9ee9161abd..0334b4954773 100644
> > > > > --- a/drivers/iio/common/Kconfig
> > > > > +++ b/drivers/iio/common/Kconfig
> > > > > @@ -6,5 +6,6 @@
> > > > >  source "drivers/iio/common/cros_ec_sensors/Kconfig"
> > > > >  source "drivers/iio/common/hid-sensors/Kconfig"
> > > > >  source "drivers/iio/common/ms_sensors/Kconfig"
> > > > > +source "drivers/iio/common/scmi_sensors/Kconfig"
> > > > >  source "drivers/iio/common/ssp_sensors/Kconfig"
> > > > >  source "drivers/iio/common/st_sensors/Kconfig"
> > > > > diff --git a/drivers/iio/common/Makefile  
> > b/drivers/iio/common/Makefile  
> > > > > index 4bc30bb548e2..fad40e1e1718 100644
> > > > > --- a/drivers/iio/common/Makefile
> > > > > +++ b/drivers/iio/common/Makefile
> > > > > @@ -11,5 +11,6 @@
> > > > >  obj-y += cros_ec_sensors/
> > > > >  obj-y += hid-sensors/
> > > > >  obj-y += ms_sensors/
> > > > > +obj-y += scmi_sensors/
> > > > >  obj-y += ssp_sensors/
> > > > >  obj-y += st_sensors/
> > > > > diff --git a/drivers/iio/common/scmi_sensors/Kconfig  
> > b/drivers/iio/common/scmi_sensors/Kconfig  
> > > > > new file mode 100644
> > > > > index 000000000000..67e084cbb1ab
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/common/scmi_sensors/Kconfig
> > > > > @@ -0,0 +1,18 @@
> > > > > +#
> > > > > +# IIO over SCMI
> > > > > +#
> > > > > +# When adding new entries keep the list in alphabetical order
> > > > > +
> > > > > +menu "IIO SCMI Sensors"
> > > > > +
> > > > > +config IIO_SCMI
> > > > > +     tristate "IIO SCMI"
> > > > > +        depends on ARM_SCMI_PROTOCOL
> > > > > +        select IIO_BUFFER
> > > > > +        select IIO_KFIFO_BUF
> > > > > +     help
> > > > > +          Say yes here to build support for IIO SCMI Driver.
> > > > > +          This provides ARM SCMI Protocol based IIO device.
> > > > > +          This driver provides support for accelerometer and  
> > gyroscope  
> > > > > +          sensors available on SCMI based platforms.
> > > > > +endmenu
> > > > > diff --git a/drivers/iio/common/scmi_sensors/Makefile  
> > b/drivers/iio/common/scmi_sensors/Makefile  
> > > > > new file mode 100644
> > > > > index 000000000000..f13140a2575a
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/common/scmi_sensors/Makefile
> > > > > @@ -0,0 +1,5 @@
> > > > > +# SPDX - License - Identifier : GPL - 2.0 - only
> > > > > +#
> > > > > +# Makefile for the IIO over SCMI
> > > > > +#
> > > > > +obj-$(CONFIG_IIO_SCMI) += scmi_iio.o
> > > > > diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c  
> > b/drivers/iio/common/scmi_sensors/scmi_iio.c  
> > > > > new file mode 100644
> > > > > index 000000000000..331ffaffd06f
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > @@ -0,0 +1,742 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +/*
> > > > > + * System Control and Management Interface(SCMI) based IIO sensor  
> > driver  
> > > > > + *
> > > > > + * Copyright (C) 2020 Google LLC  
> > > > Probably want to include 2021 given you are still making substantial  
> > changes ;)  
> > > >  
> > > > > + */
> > > > > +
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/iio/buffer.h>
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/iio/kfifo_buf.h>
> > > > > +#include <linux/iio/sysfs.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/kthread.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/scmi_protocol.h>
> > > > > +#include <linux/time.h>
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +#define ilog10(x) (ilog2(x) / const_ilog2(10))  
> > > >
> > > > That feels like it's probably not great for precision.
> > > >  
> > > > > +#define UHZ_PER_HZ 1000000UL
> > > > > +#define ODR_EXPAND(odr, uodr) (((odr) * 1000000ULL) + (uodr))  
> > > >
> > > > Prefix these if driver specific.
> > > > For those that aren't perhaps we can think about putting them in
> > > > generic headers.
> > > >
> > > >  
> > > > > +#define MAX_NUM_OF_CHANNELS 4
> > > > > +#define H32(x) (FIELD_GET(GENMASK_ULL(63, 32), (x)))
> > > > > +#define L32(x) (FIELD_GET(GENMASK_ULL(31, 0), (x)))  
> > > >
> > > > Can we use upper_32_bits() etc in stead of these?
> > > >  
> > > > > +
> > > > > +struct scmi_iio_priv {
> > > > > +     struct scmi_handle *handle;
> > > > > +     const struct scmi_sensor_info *sensor_info;
> > > > > +     struct iio_dev *indio_dev;
> > > > > +     long long iio_buf[MAX_NUM_OF_CHANNELS];
> > > > > +     struct notifier_block sensor_update_nb;
> > > > > +     u32 *freq_avail;
> > > > > +     /*
> > > > > +      * range_avail = [minRange resolution maxRange]
> > > > > +      * with IIO val type as IIO_VAL_FRACTIONAL.
> > > > > +      * Hence, array of size 6.
> > > > > +      */
> > > > > +     int range_avail[6];
> > > > > +};
> > > > > +
> > > > > +static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
> > > > > +                                  unsigned long event, void *data)
> > > > > +{
> > > > > +     struct scmi_sensor_update_report *sensor_update = data;
> > > > > +     struct iio_dev *scmi_iio_dev;
> > > > > +     struct scmi_iio_priv *sensor;
> > > > > +     s8 tstamp_scale;
> > > > > +     u64 time, time_ns;
> > > > > +     int i;
> > > > > +
> > > > > +     if (sensor_update->readings_count == 0)
> > > > > +             return NOTIFY_DONE;
> > > > > +
> > > > > +     sensor = container_of(nb, struct scmi_iio_priv,  
> > sensor_update_nb);  
> > > > > +
> > > > > +     for (i = 0; i < sensor_update->readings_count; i++)
> > > > > +             sensor->iio_buf[i] = sensor_update->readings[i].value;
> > > > > +
> > > > > +     if (!sensor->sensor_info->timestamped) {
> > > > > +             time_ns = sensor_update->timestamp;
> > > > > +     } else {
> > > > > +             /*
> > > > > +              * All the axes are supposed to have the same value  
> > for timestamp.  
> > > > > +              *  We are just using the values from the Axis 0  
> > here.  
> > > >
> > > > Slightly odd indenting of comment here.
> > > >  
> > > > > +              */
> > > > > +             time = sensor_update->readings[0].timestamp;
> > > > > +
> > > > > +             /*
> > > > > +              *  Timestamp returned by SCMI is in seconds and is  
> > equal to  
> > > > > +              *  time * power-of-10 multiplier(tstamp_scale)  
> > seconds.  
> > > > > +              *  Converting the timestamp to nanoseconds below.
> > > > > +              */
> > > > > +             tstamp_scale = sensor->sensor_info->tstamp_scale +
> > > > > +                               ilog10(NSEC_PER_SEC);
> > > > > +             if (tstamp_scale < 0)
> > > > > +                     time_ns = div64_u64(time,
> > > > > +                                         int_pow(10,  
> > abs(tstamp_scale)));  
> > > > > +             else
> > > > > +                     time_ns = time * int_pow(10, tstamp_scale);
> > > > > +     }
> > > > > +
> > > > > +     scmi_iio_dev = sensor->indio_dev;
> > > > > +     iio_push_to_buffers_with_timestamp(scmi_iio_dev,  
> > sensor->iio_buf,  
> > > > > +                                        time_ns);
> > > > > +     return NOTIFY_OK;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     u32 sensor_id = sensor->sensor_info->id;
> > > > > +     u32 sensor_config;
> > > > > +     int err;
> > > > > +
> > > > > +     if (sensor->sensor_info->timestamped)
> > > > > +             sensor_config |=  
> > FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,  
> > > > > +  
> >  SCMI_SENS_CFG_TSTAMP_ENABLE);  
> > > > > +
> > > > > +     sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > > > +                                 SCMI_SENS_CFG_SENSOR_ENABLE);
> > > > > +
> > > > > +     err =  
> > sensor->handle->notify_ops->register_event_notifier(sensor->handle,  
> > > > > +                     SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > > +                     &sensor_id, &sensor->sensor_update_nb);
> > > > > +     if (err) {
> > > > > +             dev_err(&iio_dev->dev,
> > > > > +                     "Error in registering sensor update notifier  
> > for sensor %s err %d",  
> > > > > +                     sensor->sensor_info->name, err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > > +                     sensor->sensor_info->id, sensor_config);
> > > > > +     if (err) {
> > > > > +  
> >  sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,  
> > > > > +                     SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > > +                     &sensor_id, &sensor->sensor_update_nb);
> > > > > +             dev_err(&iio_dev->dev, "Error in enabling sensor %s  
> > err %d",  
> > > > > +                     sensor->sensor_info->name, err);
> > > > > +     }
> > > > > +
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     u32 sensor_id = sensor->sensor_info->id;
> > > > > +     u32 sensor_config = 0;
> > > > > +     int err;
> > > > > +
> > > > > +     sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > > > +                                 SCMI_SENS_CFG_SENSOR_DISABLE);
> > > > > +
> > > > > +     err =  
> > sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,  
> > > > > +                     SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > > +                     &sensor_id, &sensor->sensor_update_nb);
> > > > > +     if (err) {
> > > > > +             dev_err(&iio_dev->dev,
> > > > > +                     "Error in unregistering sensor update notifier  
> > for sensor %s err %d",  
> > > > > +                     sensor->sensor_info->name, err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     err = sensor->handle->sensor_ops->config_set(sensor->handle,  
> > sensor_id,  
> > > > > +                                                  sensor_config);
> > > > > +     if (err) {
> > > > > +             dev_err(&iio_dev->dev,
> > > > > +                     "Error in disabling sensor %s with err %d",
> > > > > +                     sensor->sensor_info->name, err);
> > > > > +     }
> > > > > +
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
> > > > > +     .preenable = scmi_iio_buffer_preenable,
> > > > > +     .postdisable = scmi_iio_buffer_postdisable,
> > > > > +};
> > > > > +
> > > > > +static int scmi_iio_read_avail(struct iio_dev *iio_dev,
> > > > > +                            struct iio_chan_spec const *chan,
> > > > > +                            const int **vals, int *type, int  
> > *length,  
> > > > > +                            long mask)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +
> > > > > +     switch (mask) {
> > > > > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > > > > +             *vals = sensor->freq_avail;
> > > > > +             *type = IIO_VAL_INT_PLUS_MICRO;
> > > > > +             *length = sensor->sensor_info->intervals.count * 2;
> > > > > +             if (sensor->sensor_info->intervals.segmented)
> > > > > +                     return IIO_AVAIL_RANGE;
> > > > > +             else
> > > > > +                     return IIO_AVAIL_LIST;
> > > > > +     case IIO_CHAN_INFO_RAW:
> > > > > +             *vals = sensor->range_avail;
> > > > > +             *type = IIO_VAL_FRACTIONAL;
> > > > > +             *length = ARRAY_SIZE(sensor->range_avail);
> > > > > +             return IIO_AVAIL_RANGE;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val,  
> > int val2)  
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     u64 sec, mult, uHz;
> > > > > +     u32 sensor_config;
> > > > > +
> > > > > +     int err =  
> > sensor->handle->sensor_ops->config_get(sensor->handle,  
> > > > > +                     sensor->sensor_info->id, &sensor_config);
> > > > > +     if (err) {
> > > > > +             dev_err(&iio_dev->dev,
> > > > > +                     "Error in getting sensor config for sensor %s  
> > err %d",  
> > > > > +                     sensor->sensor_info->name, err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     uHz = ODR_EXPAND(val, val2);
> > > > > +
> > > > > +     /*
> > > > > +      * The seconds field in the sensor interval in SCMI is 16 bits  
> > long  
> > > > > +      * Therefore seconds  = 1/Hz <= 0xFFFF. As floating point  
> > calculations are  
> > > > > +      * discouraged in the kernel driver code, to calculate the  
> > scale factor (sf)  
> > > > > +      * (1* 1000000 * sf)/uHz <= 0xFFFF. Therefore, sf <= (uHz *  
> > 0xFFFF)/1000000  
> > > > > +      */
> > > > > +     mult = ilog10(((u64)uHz * 0xFFFF) / UHZ_PER_HZ);
> > > > > +
> > > > > +     sec = div64_u64(int_pow(10, mult) * UHZ_PER_HZ, uHz);
> > > > > +     if (sec == 0) {
> > > > > +             dev_err(&iio_dev->dev,
> > > > > +                     "Trying to set invalid sensor update value for  
> > sensor %s",  
> > > > > +                     sensor->sensor_info->name);
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     sensor_config &= ~SCMI_SENS_CFG_UPDATE_SECS_MASK;
> > > > > +     sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_SECS_MASK,  
> > sec);  
> > > > > +     sensor_config &= ~SCMI_SENS_CFG_UPDATE_EXP_MASK;
> > > > > +     sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_EXP_MASK,  
> > -mult);  
> > > > > +
> > > > > +     if (sensor->sensor_info->timestamped) {
> > > > > +             sensor_config &= ~SCMI_SENS_CFG_TSTAMP_ENABLED_MASK;
> > > > > +             sensor_config |=  
> > FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,  
> > > > > +  
> >  SCMI_SENS_CFG_TSTAMP_ENABLE);  
> > > > > +     }
> > > > > +
> > > > > +     sensor_config &= ~SCMI_SENS_CFG_ROUND_MASK;
> > > > > +     sensor_config |=
> > > > > +             FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK,  
> > SCMI_SENS_CFG_ROUND_AUTO);  
> > > > > +
> > > > > +     err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > > +                     sensor->sensor_info->id, sensor_config);
> > > > > +     if (err)
> > > > > +             dev_err(&iio_dev->dev,
> > > > > +                     "Error in setting sensor update interval for  
> > sensor %s value %u err %d",  
> > > > > +                     sensor->sensor_info->name, sensor_config, err);
> > > > > +
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_write_raw(struct iio_dev *iio_dev,
> > > > > +                           struct iio_chan_spec const *chan, int  
> > val,  
> > > > > +                           int val2, long mask)
> > > > > +{
> > > > > +     int err;
> > > > > +
> > > > > +     switch (mask) {
> > > > > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > > > > +             mutex_lock(&iio_dev->mlock);
> > > > > +             err = scmi_iio_set_odr_val(iio_dev, val, val2);
> > > > > +             mutex_unlock(&iio_dev->mlock);
> > > > > +             return err;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static u64 scmi_iio_convert_interval_to_ns(u32 val)
> > > > > +{
> > > > > +     u64 sensor_update_interval =
> > > > > +             SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
> > > > > +     u64 sensor_interval_mult;
> > > > > +     int mult;
> > > > > +
> > > > > +     mult = SCMI_SENS_INTVL_GET_EXP(val);
> > > > > +     if (mult < 0) {
> > > > > +             sensor_interval_mult = int_pow(10, abs(mult));
> > > > > +             sensor_update_interval =
> > > > > +                     sensor_update_interval / sensor_interval_mult;
> > > > > +     } else {
> > > > > +             sensor_interval_mult = int_pow(10, mult);
> > > > > +             sensor_update_interval =
> > > > > +                     sensor_update_interval * sensor_interval_mult;
> > > > > +     }
> > > > > +     return sensor_update_interval;
> > > > > +}
> > > > > +
> > > > > +static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
> > > > > +{
> > > > > +     u64 rem;
> > > > > +
> > > > > +     *hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
> > > > > +     *uhz = (rem * 1000000UL) / interval_ns;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val,  
> > int *val2)  
> > > > > +{
> > > > > +     u64 sensor_update_interval, sensor_interval_mult, hz, uhz;
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     u32 sensor_config;
> > > > > +     int mult;
> > > > > +
> > > > > +     int err =  
> > sensor->handle->sensor_ops->config_get(sensor->handle,  
> > > > > +                     sensor->sensor_info->id, &sensor_config);
> > > > > +     if (err) {
> > > > > +             dev_err(&iio_dev->dev,
> > > > > +                     "Error in getting sensor config for sensor %s  
> > err %d",  
> > > > > +                     sensor->sensor_info->name, err);
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     sensor_update_interval =
> > > > > +             SCMI_SENS_CFG_GET_UPDATE_SECS(sensor_config) *  
> > NSEC_PER_SEC;  
> > > > > +
> > > > > +     mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
> > > > > +     if (mult < 0) {
> > > > > +             sensor_interval_mult = int_pow(10, abs(mult));
> > > > > +             sensor_update_interval =
> > > > > +                     sensor_update_interval / sensor_interval_mult;
> > > > > +     } else {
> > > > > +             sensor_interval_mult = int_pow(10, mult);
> > > > > +             sensor_update_interval =
> > > > > +                     sensor_update_interval * sensor_interval_mult;
> > > > > +     }
> > > > > +
> > > > > +     convert_ns_to_freq(sensor_update_interval, &hz, &uhz);
> > > > > +     *val = hz;
> > > > > +     *val2 = uhz;
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> > > > > +                          struct iio_chan_spec const *ch, int *val,
> > > > > +                          int *val2, long mask)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     s8 scale;
> > > > > +     int ret;
> > > > > +
> > > > > +     switch (mask) {
> > > > > +     case IIO_CHAN_INFO_SCALE:
> > > > > +             scale =  
> > sensor->sensor_info->axis[ch->scan_index].scale;  
> > > > > +             if (scale < 0) {
> > > > > +                     *val = 1;
> > > > > +                     *val2 = int_pow(10, abs(scale));
> > > > > +                     return IIO_VAL_FRACTIONAL;
> > > > > +             }
> > > > > +             *val = int_pow(10, scale);
> > > > > +             return IIO_VAL_INT;
> > > > > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > > > > +             ret = scmi_iio_get_odr_val(iio_dev, val, val2);
> > > > > +             return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static const struct iio_info scmi_iio_info = {
> > > > > +     .read_raw = scmi_iio_read_raw,
> > > > > +     .read_avail = scmi_iio_read_avail,
> > > > > +     .write_raw = scmi_iio_write_raw,
> > > > > +};
> > > > > +
> > > > > +static void scmi_iio_set_timestamp_channel(struct iio_chan_spec  
> > *iio_chan,  
> > > > > +                                        int scan_index)
> > > > > +{
> > > > > +     iio_chan->type = IIO_TIMESTAMP;
> > > > > +     iio_chan->channel = -1;
> > > > > +     iio_chan->scan_index = scan_index;
> > > > > +     iio_chan->scan_type.sign = 'u';
> > > > > +     iio_chan->scan_type.realbits = 64;
> > > > > +     iio_chan->scan_type.storagebits = 64;
> > > > > +}
> > > > > +
> > > > > +static void scmi_iio_set_data_channel(struct iio_chan_spec  
> > *iio_chan,  
> > > > > +                                   enum iio_chan_type type,
> > > > > +                                   enum iio_modifier mod, int  
> > scan_index)  
> > > > > +{
> > > > > +     iio_chan->type = type;
> > > > > +     iio_chan->modified = 1;
> > > > > +     iio_chan->channel2 = mod;
> > > > > +     iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> > > > > +     iio_chan->info_mask_shared_by_type =  
> > BIT(IIO_CHAN_INFO_SAMP_FREQ);  
> > > > > +     iio_chan->info_mask_shared_by_type_available =
> > > > > +             BIT(IIO_CHAN_INFO_SAMP_FREQ) | BIT(IIO_CHAN_INFO_RAW);
> > > > > +     iio_chan->scan_index = scan_index;
> > > > > +     iio_chan->scan_type.sign = 's';
> > > > > +     iio_chan->scan_type.realbits = 64;
> > > > > +     iio_chan->scan_type.storagebits = 64;
> > > > > +     iio_chan->scan_type.endianness = IIO_LE;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_chan_modifier(const char *name,
> > > > > +                                   enum iio_modifier *modifier)
> > > > > +{
> > > > > +     char *pch, mod;
> > > > > +
> > > > > +     if (!name)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     pch = strrchr(name, '_');
> > > > > +     if (!pch)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     mod = *(pch + 1);
> > > > > +     switch (mod) {
> > > > > +     case 'X':
> > > > > +             *modifier = IIO_MOD_X;
> > > > > +             return 0;
> > > > > +     case 'Y':
> > > > > +             *modifier = IIO_MOD_Y;
> > > > > +             return 0;
> > > > > +     case 'Z':
> > > > > +             *modifier = IIO_MOD_Z;
> > > > > +             return 0;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type  
> > *iio_type)  
> > > > > +{
> > > > > +     switch (scmi_type) {
> > > > > +     case METERS_SEC_SQUARED:
> > > > > +             *iio_type = IIO_ACCEL;
> > > > > +             return 0;
> > > > > +     case RADIANS_SEC:
> > > > > +             *iio_type = IIO_ANGL_VEL;
> > > > > +             return 0;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_sensor_max_range(struct iio_dev *iio_dev,  
> > int *val,  
> > > > > +                                      int *val2)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     int max_range_high, max_range_low;
> > > > > +     long long max_range;
> > > > > +
> > > > > +     /*
> > > > > +      * All the axes are supposed to have the same value for max  
> > range.  
> > > > > +      * We are just using the values from the Axis 0 here.
> > > > > +      */
> > > > > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > > > > +             max_range =  
> > sensor->sensor_info->axis[0].attrs.max_range;  
> > > > > +             max_range_high = H32(max_range);
> > > > > +             max_range_low = L32(max_range);
> > > > > +
> > > > > +             /*
> > > > > +              * As IIO Val types have no provision for 64 bit  
> > values,  
> > > > > +              * this driver only supports sensors whose maximum  
> > range  
> > > > > +              * reported by the SCMI Platform fits within lower 32  
> > bits  
> > > > > +              */
> > > > > +             if (max_range_high != 0)
> > > > > +                     return -EINVAL;
> > > > > +
> > > > > +             *val = max_range_low;
> > > > > +             *val2 = 1;
> > > > > +     }
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static void scmi_iio_get_sensor_resolution(struct iio_dev *iio_dev,  
> > int *val,  
> > > > > +                                        int *val2)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +
> > > > > +     /*
> > > > > +      * All the axes are supposed to have the same value for  
> > resolution  
> > > > > +      * and exponent. We are just using the values from the Axis 0  
> > here.  
> > > > > +      */
> > > > > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > > > > +             uint resolution =  
> > sensor->sensor_info->axis[0].resolution;  
> > > > > +             s8 exponent = sensor->sensor_info->axis[0].exponent;
> > > > > +             s8 scale = sensor->sensor_info->axis[0].scale;
> > > > > +
> > > > > +             /*
> > > > > +              * To provide the raw value for the resolution to the  
> > userspace,  
> > > > > +              * need to divide the resolution exponent by the  
> > sensor scale  
> > > > > +              */
> > > > > +             exponent = exponent - scale;
> > > > > +             if (exponent >= 0) {
> > > > > +                     *val = resolution * int_pow(10, exponent);
> > > > > +                     *val2 = 1;
> > > > > +             } else {
> > > > > +                     *val = resolution;
> > > > > +                     *val2 = int_pow(10, abs(exponent));
> > > > > +             }
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_sensor_min_range(struct iio_dev *iio_dev,  
> > int *val,  
> > > > > +                                      int *val2)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     int min_range_high, min_range_low;
> > > > > +     long long min_range;
> > > > > +
> > > > > +     /*
> > > > > +      * All the axes are supposed to have the same value for min  
> > range.  
> > > > > +      * We are just using the values from the Axis 0 here.
> > > > > +      */
> > > > > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > > > > +             min_range =  
> > sensor->sensor_info->axis[0].attrs.min_range;  
> > > > > +             min_range_high = H32(min_range);
> > > > > +             min_range_low = L32(min_range);
> > > > > +
> > > > > +             /*
> > > > > +              * As IIO Val types have no provision for 64 bit  
> > values,  
> > > > > +              * this driver only supports sensors whose minimum  
> > range  
> > > > > +              * reported by SCMI Platform fits within lower 32 bits
> > > > > +              */  
> > > >
> > > > As discussed in previous thread (after you sent this!) perhaps we just
> > > > need to do the maths in here rather than rely on core handling of  
> > IIO_VAL_FRACTIONAL.  
> > > > That would give us a greater potential range.  There may still be  
> > values  
> > > > we can't represent, but it should be less restrictive that this
> > > > assumption. (pity as this was neater!)
> > > >  
> > > > > +             if (min_range_high != 0xFFFFFFFF)
> > > > > +                     return -EINVAL;
> > > > > +
> > > > > +             *val = min_range_low;
> > > > > +             *val2 = 1;
> > > > > +     }
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_set_sensor_range_avail(struct iio_dev *iio_dev)
> > > > > +{
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = scmi_iio_get_sensor_min_range(iio_dev,  
> > &sensor->range_avail[0],  
> > > > > +                                         &sensor->range_avail[1]);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     scmi_iio_get_sensor_resolution(iio_dev,  
> > &sensor->range_avail[2],  
> > > > > +                                    &sensor->range_avail[3]);
> > > > > +     ret = scmi_iio_get_sensor_max_range(iio_dev,  
> > &sensor->range_avail[4],  
> > > > > +                                         &sensor->range_avail[5]);
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
> > > > > +{
> > > > > +     u64 cur_interval_ns, low_interval_ns, high_interval_ns,  
> > step_size_ns,  
> > > > > +             hz, uhz;
> > > > > +     unsigned int cur_interval, low_interval, high_interval,  
> > step_size;  
> > > > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +     int i;
> > > > > +
> > > > > +     sensor->freq_avail = devm_kzalloc(&iio_dev->dev,
> > > > > +                                       sizeof(u32) *  
> > (sensor->sensor_info->intervals.count * 2),  
> > > >
> > > > Slight preference for sizeof(*sensor->freq_avail) *...
> > > > as saves reviewer having to go check types match up.
> > > >  
> > > > > +                                       GFP_KERNEL);
> > > > > +     if (!sensor->freq_avail)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     if (sensor->sensor_info->intervals.segmented) {
> > > > > +             low_interval = sensor->sensor_info->intervals
> > > > > +  
> > .desc[SCMI_SENS_INTVL_SEGMENT_LOW];  
> > > > > +             low_interval_ns =  
> > scmi_iio_convert_interval_to_ns(low_interval);  
> > > > > +             convert_ns_to_freq(low_interval_ns, &hz, &uhz);
> > > > > +             sensor->freq_avail[0] = hz;
> > > > > +             sensor->freq_avail[1] = uhz;
> > > > > +
> > > > > +             step_size = sensor->sensor_info->intervals
> > > > > +  
> >  .desc[SCMI_SENS_INTVL_SEGMENT_STEP];  
> > > > > +             step_size_ns =  
> > scmi_iio_convert_interval_to_ns(step_size);  
> > > > > +             convert_ns_to_freq(step_size_ns, &hz, &uhz);
> > > > > +             sensor->freq_avail[2] = hz;
> > > > > +             sensor->freq_avail[3] = uhz;
> > > > > +
> > > > > +             high_interval = sensor->sensor_info->intervals
> > > > > +  
> >  .desc[SCMI_SENS_INTVL_SEGMENT_HIGH];  
> > > > > +             high_interval_ns =
> > > > > +                     scmi_iio_convert_interval_to_ns(high_interval);
> > > > > +             convert_ns_to_freq(high_interval_ns, &hz, &uhz);
> > > > > +             sensor->freq_avail[4] = hz;
> > > > > +             sensor->freq_avail[5] = uhz;
> > > > > +     } else {
> > > > > +             for (i = 0; i < sensor->sensor_info->intervals.count;  
> > i++) {  
> > > > > +                     cur_interval =  
> > sensor->sensor_info->intervals.desc[i];  
> > > > > +                     cur_interval_ns =  
> > scmi_iio_convert_interval_to_ns(cur_interval);  
> > > > > +                     convert_ns_to_freq(cur_interval_ns, &hz, &uhz);
> > > > > +                     sensor->freq_avail[i * 2] = hz;
> > > > > +                     sensor->freq_avail[i * 2 + 1] = uhz;
> > > > > +             }
> > > > > +     }
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> > > > > +{
> > > > > +     struct iio_buffer *buffer;
> > > > > +
> > > > > +     buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> > > > > +     if (!buffer)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     iio_device_attach_buffer(scmi_iiodev, buffer);
> > > > > +     scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> > > > > +     scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle  
> > *handle,  
> > > > > +                          const struct scmi_sensor_info  
> > *sensor_info,  
> > > > > +                          struct iio_dev **scmi_iio_dev)  
> > > >
> > > > Perhaps it would be nice to use PTR_ERR etc and have this function  
> > just return  
> > > > the struct iio_dev.   That would fit with more common form for  
> > allocation functions.  
> > > >  
> > > > > +{
> > > > > +     struct iio_chan_spec *iio_channels;
> > > > > +     struct scmi_iio_priv *sensor;
> > > > > +     enum iio_modifier modifier;
> > > > > +     enum iio_chan_type type;
> > > > > +     struct iio_dev *iiodev;
> > > > > +     int i, ret;
> > > > > +
> > > > > +     iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> > > > > +     if (!iiodev)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     iiodev->modes = INDIO_DIRECT_MODE;
> > > > > +     iiodev->dev.parent = dev;
> > > > > +     sensor = iio_priv(iiodev);
> > > > > +     sensor->handle = handle;
> > > > > +     sensor->sensor_info = sensor_info;
> > > > > +     sensor->sensor_update_nb.notifier_call =  
> > scmi_iio_sensor_update_cb;  
> > > > > +     sensor->indio_dev = iiodev;
> > > > > +
> > > > > +     /* adding one additional channel for timestamp */
> > > > > +     iiodev->num_channels = sensor_info->num_axis + 1;
> > > > > +     iiodev->name = sensor_info->name;
> > > > > +     iiodev->info = &scmi_iio_info;
> > > > > +
> > > > > +     iio_channels =
> > > > > +             devm_kzalloc(dev,
> > > > > +                          sizeof(*iio_channels) *  
> > (iiodev->num_channels),  
> > > > > +                          GFP_KERNEL);
> > > > > +     if (!iio_channels)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     scmi_iio_set_sampling_freq_avail(iiodev);
> > > > > +
> > > > > +     ret = scmi_iio_set_sensor_range_avail(iiodev);
> > > > > +     if (ret) {
> > > > > +             dev_err(dev, "Error while setting the sensor %s range  
> > %d",  
> > > > > +                     sensor_info->name, ret);
> > > > > +             return ret;
> > > > > +     }
> > > > > +
> > > > > +     for (i = 0; i < sensor_info->num_axis; i++) {
> > > > > +             ret =  
> > scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);  
> > > > > +             if (ret < 0)
> > > > > +                     return ret;
> > > > > +
> > > > > +             ret =  
> > scmi_iio_get_chan_modifier(sensor_info->axis[i].name,  
> > > > > +                                              &modifier);
> > > > > +             if (ret < 0)
> > > > > +                     return ret;
> > > > > +
> > > > > +             scmi_iio_set_data_channel(&iio_channels[i], type,  
> > modifier,  
> > > > > +                                       sensor_info->axis[i].id);
> > > > > +     }
> > > > > +
> > > > > +     scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> > > > > +     iiodev->channels = iio_channels;
> > > > > +     *scmi_iio_dev = iiodev;
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> > > > > +{
> > > > > +     const struct scmi_sensor_info *sensor_info;
> > > > > +     struct scmi_handle *handle = sdev->handle;
> > > > > +     struct device *dev = &sdev->dev;
> > > > > +     struct iio_dev *scmi_iio_dev;
> > > > > +     u16 nr_sensors;
> > > > > +     int err, i;
> > > > > +
> > > > > +     if (!handle || !handle->sensor_ops) {
> > > > > +             dev_err(dev, "SCMI device has no sensor  
> > interface\n");  
> > > > I'm going to guess we can't actually get here because the registration
> > > > would't have happened if either of those are true?
> > > > If so perhaps drop the error message.
> > > >  
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     nr_sensors = handle->sensor_ops->count_get(handle);
> > > > > +     if (!nr_sensors) {
> > > > > +             dev_dbg(dev, "0 sensors found via SCMI bus\n");  
> > > > -ENODEV maybe?  
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     dev_dbg(dev, "%d sensors found via SCMI bus\n", nr_sensors);  
> > > >
> > > > Clear out any debug prints out that don't provide info that can't be  
> > obtained  
> > > > farily easily from elsewhere.  In this case they will either be  
> > registered  
> > > > or not and we'll get error messages.
> > > > These sort of prints bitrot over time so we want to limit them to the  
> > truely  
> > > > useful.
> > > >  
> > > > > +
> > > > > +     for (i = 0; i < nr_sensors; i++) {
> > > > > +             sensor_info = handle->sensor_ops->info_get(handle, i);
> > > > > +             if (!sensor_info) {
> > > > > +                     dev_err(dev, "SCMI sensor %d has missing  
> > info\n", i);  
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > > +
> > > > > +             /* Skipping scalar sensor,as this driver only supports  
> > accel and gyro */  
> > > > > +             if (sensor_info->num_axis == 0)
> > > > > +                     continue;  
> > > >
> > > > So there is a situation where this driver never creates anything?  In  
> > that path I'd  
> > > > like to see an -ENODEV error return.
> > > >  
> > > > > +
> > > > > +             err = scmi_alloc_iiodev(dev, handle, sensor_info,
> > > > > +                                     &scmi_iio_dev);
> > > > > +             if (err < 0) {
> > > > > +                     dev_err(dev,
> > > > > +                             "failed to allocate IIO device for  
> > sensor %s: %d\n",  
> > > > > +                             sensor_info->name, err);
> > > > > +                     return err;
> > > > > +             }
> > > > > +
> > > > > +             err = scmi_iio_buffers_setup(scmi_iio_dev);
> > > > > +             if (err < 0) {
> > > > > +                     dev_err(dev,
> > > > > +                             "IIO buffer setup error at sensor %s:  
> > %d\n",  
> > > > > +                             sensor_info->name, err);
> > > > > +                     return err;
> > > > > +             }
> > > > > +
> > > > > +             err = devm_iio_device_register(dev, scmi_iio_dev);
> > > > > +             if (err) {
> > > > > +                     dev_err(dev,
> > > > > +                             "IIO device registration failed at  
> > sensor %s: %d\n",  
> > > > > +                             sensor_info->name, err);
> > > > > +                     return err;
> > > > > +             }
> > > > > +     }
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static const struct scmi_device_id scmi_id_table[] = {
> > > > > +     { SCMI_PROTOCOL_SENSOR, "iiodev" },  
> > > >
> > > > I'm curious on this.  What actually causes a match on that
> > > > iiodev?  From digging around the scmi core am I right in thinking
> > > > that this iiodev id needs to be explicitly listed?
> > > >
> > > > It would be good to include any changes needed there in this
> > > > series.
> > > >  
> > > > > +     {},
> > > > > +};
> > > > > +
> > > > > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > > > > +
> > > > > +static struct scmi_driver scmi_iiodev_driver = {
> > > > > +     .name = "scmi-sensor-iiodev",
> > > > > +     .probe = scmi_iio_dev_probe,
> > > > > +     .id_table = scmi_id_table,
> > > > > +};
> > > > > +
> > > > > +module_scmi_driver(scmi_iiodev_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> > > > > +MODULE_DESCRIPTION("SCMI IIO Driver");
> > > > > +MODULE_LICENSE("GPL v2");  
> > > >  
> >
> >  
> 

