Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056FF30903F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jan 2021 23:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhA2WoP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jan 2021 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhA2WoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jan 2021 17:44:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862EDC061573
        for <linux-iio@vger.kernel.org>; Fri, 29 Jan 2021 14:43:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s24so6520612pjp.5
        for <linux-iio@vger.kernel.org>; Fri, 29 Jan 2021 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0LItUTWfkjgk4iIY0tKXGys2w3V9AzcTKk9QlKRWcLM=;
        b=lfgGNP1e1nSQ/YypnrJEff1RdrZtoNco0M1eA4HGPAIUSjnxIoXbUphVSen7Bm8hVb
         4yFLyfn5JSnQ7x2gSasXKkZGSUiyTWfc7v1lR5FkG1nyn7m2jPwLuYxE6LIyTIAC6zn/
         ff1o9ZEYKi2VVQnZF0lxMyj0UJKArnC1SOLnHLtzPQ4mqsDm0jcUV3v9PVqVmz8+4+Cf
         sxjV0WFnYQFyiZSliwVNfLaO+pyPpUa2JimNrCdoe1//iBpbxafIKszr3jCE+CHU55aT
         JlRFdfC1TyD0J4GySrV8EJ8ycBRgQeYOHOBCFdeBtMvEHOTzCCbM05TfyK3DP7xPOfSn
         t+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0LItUTWfkjgk4iIY0tKXGys2w3V9AzcTKk9QlKRWcLM=;
        b=lZEYMZ3rElVFm1NbJbSCdkek+ammn3LHI1UogpeDemOfXiV49TanhsfRz/Syb9vKFH
         cr04vXei+EiHP5CGf/4MtyIiGzeVpc1MkGYsVGPECYnfEnqIs92CnqaFHQShMfhJDQ9L
         um1Vcce3IJx4cc+8TDaqxGMM0S0HiQZgMu/QJTYlQukzjaxC3vVeVUPKkhrY7FSuSpV6
         yNR+OhWetoo/KQkwHRYuHw0/7wFcRBwG1Kta7prQgJpoX8InknPV9+3LiA2hdVCWwrzH
         Zj65LuT6PUKwVqcyEUDZJ+uZ9QPdC8m7aaJL3YR0IrmiqHkyjdTo5Y5DGP3g+sg1VFn6
         0h2g==
X-Gm-Message-State: AOAM5317/L/vNpybQlzPbZcMQ4xpceZNUtzFBscuwTKGjhCYiST5tCZZ
        Y2NZoMvxfcJ4n/YmtY4Ndz5dqFbQ6CQVpXRVJ3NV3w==
X-Google-Smtp-Source: ABdhPJzHgb6Db38lceM7JwTmJCOU5jM8qOwWTuExYKbay+9MR4vSAw0pWj73thE6lBoNx/UczlqQ+1jj6YsIbABET9Y=
X-Received: by 2002:a17:902:ab90:b029:e0:17b:ae98 with SMTP id
 f16-20020a170902ab90b02900e0017bae98mr6538685plr.6.1611960205244; Fri, 29 Jan
 2021 14:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20210121232147.1849509-1-jbhayana@google.com> <20210121232147.1849509-2-jbhayana@google.com>
 <20210122133740.GB22231@e120937-lin>
In-Reply-To: <20210122133740.GB22231@e120937-lin>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Fri, 29 Jan 2021 14:43:13 -0800
Message-ID: <CA+=V6c37G5C=mWB1HDHOS7aEUsAc3TggF-sMebs4Eagm2c+STQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/1] iio/scmi: Adding support for IIO SCMI Based Sensors
To:     Cristian Marussi <cristian.marussi@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christian,

I have addressed your feedback in v4 of the patch. Please find below
the answers to some of your questions:
>    The initial  sensor_config ORed here is NOT initialized nor zeroed.

  There is no need to initialize as it is already initialized to 0 when def=
ined.

> being not so familiar with IIO, may I ask when and how much frequently
> these ops are called ? (given they include a register/unregister +
> enable/disable every time)

These are called whenever the sensor is enabled/disabled by writing
to buffer/enable sysfs node

>AFAIU this is called during IIO init and derives a modifier from the name
>of the sensors which are passed by the platform fw with sensor descriptors=
,
>so I would not trust them to be weell formed (:D) and try to be picky abou=
t
>*name as it was user-input to validate.

The SCMI specification has mentioned the naming convention for the
axis as below .
 "A NULL terminated UTF-8 format string with the sensor axis name, of
up to 16 bytes. It is recommended that the name ends with =E2=80=98_=E2=80=
=99 followed
by the axis of the sensor in uppercase. For example, the name for the
x-axis of a triaxial accelerometer could be =E2=80=9Cacc_X=E2=80=9D or =E2=
=80=9C_X=E2=80=9D

If there is any other better way to get the modifier, please let me know.

> why not a break to a final 'return ret;' (with ret properly set) ?

According to Jonathan, direct returns are preferred.

>Not familiar with IIO, but is it fine to setup ops and modes AFTER
>having attached the buffer to the scmi_iiodev ?
>Is is not 'racy-possible' that the buffer is already operational without
>any ops immediately after being attached ?

I have looked at other IIO drivers and they all do it this way.

Thanks,
Jyoti







On Fri, Jan 22, 2021 at 5:37 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Hi Jyoti,
>
> a few remarks below.
>
> On Thu, Jan 21, 2021 at 11:21:47PM +0000, Jyoti Bhayana wrote:
> > This change provides ARM SCMI Protocol based IIO device.
> > This driver provides support for Accelerometer and Gyroscope using
> > new SCMI Sensor Protocol defined by the upcoming SCMIv3.0
>
> I'd say:
>
> new SCMI Sensor Protocol extension added by the upcoming SCMIv3.0
>
> given that SCMI Sensor existed already in SCMIv2.0
>
> > ARM specification
> >
> > Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
> > ---
> >  MAINTAINERS                                |   6 +
> >  drivers/iio/common/Kconfig                 |   1 +
> >  drivers/iio/common/Makefile                |   1 +
> >  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
> >  drivers/iio/common/scmi_sensors/Makefile   |   5 +
> >  drivers/iio/common/scmi_sensors/scmi_iio.c | 736 +++++++++++++++++++++
> >  6 files changed, 767 insertions(+)
> >  create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
> >  create mode 100644 drivers/iio/common/scmi_sensors/Makefile
> >  create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b516bb34a8d5..ccf37d43ab41 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8567,6 +8567,12 @@ S:     Maintained
> >  F:   Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.=
txt
> >  F:   drivers/iio/multiplexer/iio-mux.c
> >
> > +IIO SCMI BASED DRIVER
> > +M:   Jyoti Bhayana <jbhayana@google.com>
> > +L:   linux-iio@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/iio/common/scmi_sensors/scmi_iio.c
> > +
> >  IIO SUBSYSTEM AND DRIVERS
> >  M:   Jonathan Cameron <jic23@kernel.org>
> >  R:   Lars-Peter Clausen <lars@metafoo.de>
> > diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
> > index 2b9ee9161abd..0334b4954773 100644
> > --- a/drivers/iio/common/Kconfig
> > +++ b/drivers/iio/common/Kconfig
> > @@ -6,5 +6,6 @@
> >  source "drivers/iio/common/cros_ec_sensors/Kconfig"
> >  source "drivers/iio/common/hid-sensors/Kconfig"
> >  source "drivers/iio/common/ms_sensors/Kconfig"
> > +source "drivers/iio/common/scmi_sensors/Kconfig"
> >  source "drivers/iio/common/ssp_sensors/Kconfig"
> >  source "drivers/iio/common/st_sensors/Kconfig"
> > diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
> > index 4bc30bb548e2..fad40e1e1718 100644
> > --- a/drivers/iio/common/Makefile
> > +++ b/drivers/iio/common/Makefile
> > @@ -11,5 +11,6 @@
> >  obj-y +=3D cros_ec_sensors/
> >  obj-y +=3D hid-sensors/
> >  obj-y +=3D ms_sensors/
> > +obj-y +=3D scmi_sensors/
> >  obj-y +=3D ssp_sensors/
> >  obj-y +=3D st_sensors/
> > diff --git a/drivers/iio/common/scmi_sensors/Kconfig b/drivers/iio/comm=
on/scmi_sensors/Kconfig
> > new file mode 100644
> > index 000000000000..67e084cbb1ab
> > --- /dev/null
> > +++ b/drivers/iio/common/scmi_sensors/Kconfig
> > @@ -0,0 +1,18 @@
> > +#
> > +# IIO over SCMI
> > +#
> > +# When adding new entries keep the list in alphabetical order
> > +
> > +menu "IIO SCMI Sensors"
> > +
> > +config IIO_SCMI
> > +     tristate "IIO SCMI"
> > +        depends on ARM_SCMI_PROTOCOL
> > +        select IIO_BUFFER
> > +        select IIO_KFIFO_BUF
> > +     help
> > +          Say yes here to build support for IIO SCMI Driver.
> > +          This provides ARM SCMI Protocol based IIO device.
> > +          This driver provides support for accelerometer and gyroscope
> > +          sensors available on SCMI based platforms.
> > +endmenu
> > diff --git a/drivers/iio/common/scmi_sensors/Makefile b/drivers/iio/com=
mon/scmi_sensors/Makefile
> > new file mode 100644
> > index 000000000000..f13140a2575a
> > --- /dev/null
> > +++ b/drivers/iio/common/scmi_sensors/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX - License - Identifier : GPL - 2.0 - only
> > +#
> > +# Makefile for the IIO over SCMI
> > +#
> > +obj-$(CONFIG_IIO_SCMI) +=3D scmi_iio.o
> > diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/c=
ommon/scmi_sensors/scmi_iio.c
> > new file mode 100644
> > index 000000000000..3b76cc54511c
> > --- /dev/null
> > +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > @@ -0,0 +1,736 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * System Control and Management Interface(SCMI) based IIO sensor driv=
er
> > + *
> > + * Copyright (C) 2020 Google LLC
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kthread.h>
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/time.h>
> > +#include <linux/types.h>
> > +
> > +#define ilog10(x) (ilog2(x) / const_ilog2(10))
> > +#define UHZ_PER_HZ 1000000UL
> > +#define ODR_EXPAND(odr, uodr) (((odr) * 1000000ULL) + (uodr))
> > +#define MAX_NUM_OF_CHANNELS 4
> > +#define H32(x) (((x) & 0xFFFFFFFF00000000LL) >> 32)
> > +#define L32(x) ((x) & 0xFFFFFFFFLL)
>
> Probaly you want to use GENMASK here to define the masks, and not sure
> but maybe there are already similar macros in linux to extract
> upper/lower 32 bits.
>
> > +
> > +struct scmi_iio_priv {
> > +     struct scmi_handle *handle;
> > +     const struct scmi_sensor_info *sensor_info;
> > +     struct iio_dev *indio_dev;
> > +     long long iio_buf[MAX_NUM_OF_CHANNELS];
> > +     struct notifier_block sensor_update_nb;
> > +     u32 *freq_avail;
> > +     /*
> > +      * range_avail =3D [minRange resolution maxRange]
> > +      * with IIO val type as IIO_VAL_FRACTIONAL.
> > +      * Hence, array of size 6.
> > +      */
> > +     int range_avail[6];
> > +};
> > +
> > +static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
> > +                                  unsigned long event, void *data)
> > +{
> > +     struct scmi_sensor_update_report *sensor_update =3D data;
> > +     struct iio_dev *scmi_iio_dev;
> > +     struct scmi_iio_priv *sensor;
> > +     s8 tstamp_scale;
> > +     u64 time, time_ns;
> > +     int i;
> > +
> > +     if (sensor_update->readings_count =3D=3D 0)
> > +             return NOTIFY_DONE;
> > +
> > +     sensor =3D container_of(nb, struct scmi_iio_priv, sensor_update_n=
b);
> > +
> > +     for (i =3D 0; i < sensor_update->readings_count; i++)
> > +             sensor->iio_buf[i] =3D sensor_update->readings[i].value;
> > +
> > +     if (!sensor->sensor_info->timestamped) {
> > +             time_ns =3D iio_get_time_ns(scmi_iio_dev);
>
> This scmi_iio_dev is on the stack and still NOT initialized here right ?
>
> Moreover, if this is meant to attach a timestamp of arrival also to
> NON-timestamped sensor notifications, note that, if you want, scmi_sensor=
_update_report
> contains a 'timestamp' (as all SCMI notif reports) ktime field (ns) which
> represents the time (ns from boot with ktime_get_boottime()) of reception
> of this notification taken by the SCMI core as soon as it arrives in the
> RX ISR. (so in the OSPM Linux world)
>
> If you grab the timestamp here with iio_get_time_ns() you are indeed
> getting a timestamp inside the notification callback so at the end of
> the notifications processing chain, i.e. in a deferred worker processing
> this queue of events and in turn calling this function, so potentially
> you're timestamping a lot later than when the event arrived really in
> the OSPM world (especially on a loaded system); it is more the time of
> arrival in IIO framework.
>
> On the other side timestamped events handled in the else-branch down
> below carry a timestamp set by the SCMI platform fw early on when the
> event has been detected by the sensor in the real world.
>
> Not sure how these values are used at the end, but just to let you know
> this detail if it was not apparent.
>
> > +     } else {
> > +             /*
> > +              * All the axes are supposed to have the same value for t=
imestamp.
> > +              *  We are just using the values from the Axis 0 here.
> > +              */
> > +             time =3D sensor_update->readings[0].timestamp;
> > +
> > +             /*
> > +              *  Timestamp returned by SCMI is in seconds and is equal=
 to
> > +              *  time * power-of-10 multiplier(tstamp_scale) seconds.
> > +              *  Converting the timestamp to nanoseconds below.
> > +              */
> > +             tstamp_scale =3D sensor->sensor_info->tstamp_scale +
> > +                               ilog10(NSEC_PER_SEC);
> > +             if (tstamp_scale < 0)
> > +                     time_ns =3D div64_u64(time,
> > +                                         int_pow(10, abs(tstamp_scale)=
));
> > +             else
> > +                     time_ns =3D time * int_pow(10, tstamp_scale);
> > +     }
> > +
> > +     scmi_iio_dev =3D sensor->indio_dev;
> > +     iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
> > +                                        time_ns);
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     u32 sensor_id =3D sensor->sensor_info->id;
> > +     u32 sensor_config;
> > +     int err;
> > +
> > +     if (sensor->sensor_info->timestamped)
> > +             sensor_config |=3D FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLE=
D_MASK,
> > +                                         SCMI_SENS_CFG_TSTAMP_ENABLE);
>
> The initial  sensor_config ORed here is NOT initialized nor zeroed.
> > +
> > +     sensor_config |=3D FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > +                                 SCMI_SENS_CFG_SENSOR_ENABLE);
> > +
> > +     err =3D sensor->handle->notify_ops->register_event_notifier(senso=
r->handle,
> > +                     SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > +                     &sensor_id, &sensor->sensor_update_nb);
> > +     if (err) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in registering sensor update notifier for =
sensor %s err %d",
> > +                     sensor->sensor_info->name, err);
> > +             return err;
> > +     }
> > +
> > +     err =3D sensor->handle->sensor_ops->config_set(sensor->handle,
> > +                     sensor->sensor_info->id, sensor_config);
> > +     if (err)
> > +             dev_err(&iio_dev->dev, "Error in enabling sensor %s err %=
d",
> > +                     sensor->sensor_info->name, err);
>
> Here you do not unregister the notification above here when you fail
> the config_set.
> If you happen to retry this code path again you'll end up registering
> the same notifier_block sensor_update_nb() in the same notification chain
> (same event samme sensor_id), which is broken and probably triggers a WAR=
N
> from the core kernel notification chains machinery too.
>
> In an upcoming series on SCMI core I'll introduce a devm_ variant for
> SCMI notification registration, but as of now you have to properly unregi=
ster
> on error paths.
>
> > +
> > +     return err;
> > +}
> > +
> > +static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     u32 sensor_id =3D sensor->sensor_info->id;
> > +     u32 sensor_config =3D 0;
> > +     int err;
> > +
> > +     sensor_config |=3D FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > +                                 SCMI_SENS_CFG_SENSOR_DISABLE);
> > +
> > +     err =3D sensor->handle->notify_ops->unregister_event_notifier(sen=
sor->handle,
> > +                     SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > +             &sensor_id, &sensor->sensor_update_nb);
>
> This alignment here is a bit awkaward.
>
> > +     if (err) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in unregistering sensor update notifier fo=
r sensor %s err %d",
> > +                     sensor->sensor_info->name, err);
> > +             return err;
> > +     }
> > +
> > +     err =3D sensor->handle->sensor_ops->config_set(sensor->handle, se=
nsor_id,
> > +                                                  sensor_config);
> > +     if (err)
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in disabling sensor %s with err %d",
> > +                     sensor->sensor_info->name, err);
> > +
> > +     return err;
> > +}
> > +
> > +static const struct iio_buffer_setup_ops scmi_iio_buffer_ops =3D {
> > +     .preenable =3D scmi_iio_buffer_preenable,
> > +     .postdisable =3D scmi_iio_buffer_postdisable,
> > +};
> > +
>
> Being not so familiar with IIO, may I ask when annd ho wmuch frequently
> these ops are called ? (given they include a register/unregister +
> enable/disable every time)
>
> > +static int scmi_iio_read_avail(struct iio_dev *iio_dev,
> > +                            struct iio_chan_spec const *chan,
> > +                            const int **vals, int *type, int *length,
> > +                            long mask)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             *vals =3D sensor->freq_avail;
> > +             *type =3D IIO_VAL_INT_PLUS_MICRO;
> > +             *length =3D sensor->sensor_info->intervals.count * 2;
> > +             if (sensor->sensor_info->intervals.segmented)
> > +                     return IIO_AVAIL_RANGE;
> > +             else
> > +                     return IIO_AVAIL_LIST;
> > +     case IIO_CHAN_INFO_RAW:
> > +             *vals =3D sensor->range_avail;
> > +             *type =3D IIO_VAL_FRACTIONAL;
> > +             *length =3D ARRAY_SIZE(sensor->range_avail);
> > +             return IIO_AVAIL_RANGE;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int =
val2)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     u64 sec, mult, uHz;
> > +     u32 sensor_config;
> > +
> > +     int err =3D sensor->handle->sensor_ops->config_get(sensor->handle=
,
> > +                     sensor->sensor_info->id, &sensor_config);
> > +     if (err) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in getting sensor config for sensor %s err=
 %d",
> > +                     sensor->sensor_info->name, err);
> > +             return err;
> > +     }
> > +
> > +     uHz =3D ODR_EXPAND(val, val2);
> > +
> > +     /*
> > +      * The seconds field in the sensor interval in SCMI is 16 bits lo=
ng
> > +      * Therefore seconds  =3D 1/Hz <=3D 0xFFFF. As floating point cal=
culations are
> > +      * discouraged in the kernel driver code, to calculate the scale =
factor (sf)
> > +      * (1* 1000000 * sf)/uHz <=3D 0xFFFF. Therefore, sf <=3D (uHz * 0=
xFFFF)/1000000
> > +      */
> > +     mult =3D ilog10(((u64)uHz * 0xFFFF) / UHZ_PER_HZ);
> > +
> > +     sec =3D div64_u64(int_pow(10, mult) * UHZ_PER_HZ, uHz);
> > +     if (sec =3D=3D 0) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Trying to set invalid sensor update value for se=
nsor %s",
> > +                     sensor->sensor_info->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     sensor_config &=3D ~SCMI_SENS_CFG_UPDATE_SECS_MASK;
> > +     sensor_config |=3D FIELD_PREP(SCMI_SENS_CFG_UPDATE_SECS_MASK, sec=
);
> > +     sensor_config &=3D ~SCMI_SENS_CFG_UPDATE_EXP_MASK;
> > +     sensor_config |=3D FIELD_PREP(SCMI_SENS_CFG_UPDATE_EXP_MASK, -mul=
t);
> > +
> > +     if (sensor->sensor_info->timestamped) {
> > +             sensor_config &=3D ~SCMI_SENS_CFG_TSTAMP_ENABLED_MASK;
> > +             sensor_config |=3D FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLE=
D_MASK,
> > +                                         SCMI_SENS_CFG_TSTAMP_ENABLE);
> > +     }
> > +
> > +     sensor_config &=3D ~SCMI_SENS_CFG_ROUND_MASK;
> > +     sensor_config |=3D
> > +             FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_=
AUTO);
> > +
> > +     err =3D sensor->handle->sensor_ops->config_set(sensor->handle,
> > +                     sensor->sensor_info->id, sensor_config);
> > +     if (err)
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in setting sensor update interval for sens=
or %s value %u err %d",
> > +                     sensor->sensor_info->name, sensor_config, err);
> > +
> > +     return err;
> > +}
> > +
> > +static int scmi_iio_write_raw(struct iio_dev *iio_dev,
> > +                           struct iio_chan_spec const *chan, int val,
> > +                           int val2, long mask)
> > +{
> > +     int err;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             mutex_lock(&iio_dev->mlock);
> > +             err =3D scmi_iio_set_odr_val(iio_dev, val, val2);
> > +             mutex_unlock(&iio_dev->mlock);
> > +             return err;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static u64 scmi_iio_convert_interval_to_ns(u32 val)
> > +{
> > +     u64 sensor_update_interval =3D
> > +             SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
> > +     u64 sensor_interval_mult;
> > +     int mult;
> > +
> > +     mult =3D SCMI_SENS_INTVL_GET_EXP(val);
> > +     if (mult < 0) {
> > +             sensor_interval_mult =3D int_pow(10, abs(mult));
> > +             sensor_update_interval =3D
> > +                     sensor_update_interval / sensor_interval_mult;
> > +     } else {
> > +             sensor_interval_mult =3D int_pow(10, mult);
> > +             sensor_update_interval =3D
> > +                     sensor_update_interval * sensor_interval_mult;
> > +     }
> > +     return sensor_update_interval;
> > +}
> > +
> > +static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
> > +{
> > +     u64 rem;
> > +
> > +     *hz =3D div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
> > +     *uhz =3D (rem * 1000000UL) / interval_ns;
> > +}
> > +
> > +static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int=
 *val2)
> > +{
> > +     u64 sensor_update_interval, sensor_interval_mult, hz, uhz;
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     u32 sensor_config;
> > +     int mult;
> > +
> > +     int err =3D sensor->handle->sensor_ops->config_get(sensor->handle=
,
> > +                     sensor->sensor_info->id, &sensor_config);
> > +     if (err) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in getting sensor config for sensor %s err=
 %d",
> > +                     sensor->sensor_info->name, err);
> > +             return err;
> > +     }
> > +
> > +     sensor_update_interval =3D
> > +             SCMI_SENS_CFG_GET_UPDATE_SECS(sensor_config) * NSEC_PER_S=
EC;
> > +
> > +     mult =3D SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
> > +     if (mult < 0) {
> > +             sensor_interval_mult =3D int_pow(10, abs(mult));
> > +             sensor_update_interval =3D
> > +                     sensor_update_interval / sensor_interval_mult;
> > +     } else {
> > +             sensor_interval_mult =3D int_pow(10, mult);
> > +             sensor_update_interval =3D
> > +                     sensor_update_interval * sensor_interval_mult;
> > +     }
> > +
> > +     convert_ns_to_freq(sensor_update_interval, &hz, &uhz);
> > +     *val =3D hz;
> > +     *val2 =3D uhz;
> > +     return 0;
> > +}
> > +
> > +static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> > +                          struct iio_chan_spec const *ch, int *val,
> > +                          int *val2, long mask)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     s8 scale;
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SCALE:
> > +             scale =3D sensor->sensor_info->axis[ch->scan_index].scale=
;
> > +             if (scale < 0) {
> > +                     *val =3D 1;
> > +                     *val2 =3D int_pow(10, abs(scale));
> > +                     return IIO_VAL_FRACTIONAL;
> > +             }
> > +             *val =3D int_pow(10, scale);
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             ret =3D scmi_iio_get_odr_val(iio_dev, val, val2);
> > +             return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info scmi_iio_info =3D {
> > +     .read_raw =3D scmi_iio_read_raw,
> > +     .read_avail =3D scmi_iio_read_avail,
> > +     .write_raw =3D scmi_iio_write_raw,
> > +};
> > +
> > +static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_c=
han,
> > +                                        int scan_index)
> > +{
> > +     iio_chan->type =3D IIO_TIMESTAMP;
> > +     iio_chan->channel =3D -1;
> > +     iio_chan->scan_index =3D scan_index;
> > +     iio_chan->scan_type.sign =3D 'u';
> > +     iio_chan->scan_type.realbits =3D 64;
> > +     iio_chan->scan_type.storagebits =3D 64;
> > +}
> > +
> > +static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
> > +                                   enum iio_chan_type type,
> > +                                   enum iio_modifier mod, int scan_ind=
ex)
> > +{
> > +     iio_chan->type =3D type;
> > +     iio_chan->modified =3D 1;
> > +     iio_chan->channel2 =3D mod;
> > +     iio_chan->info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE);
> > +     iio_chan->info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FRE=
Q);
> > +     iio_chan->info_mask_shared_by_type_available =3D
> > +             BIT(IIO_CHAN_INFO_SAMP_FREQ) | BIT(IIO_CHAN_INFO_RAW);
> > +     iio_chan->scan_index =3D scan_index;
> > +     iio_chan->scan_type.sign =3D 's';
> > +     iio_chan->scan_type.realbits =3D 64;
> > +     iio_chan->scan_type.storagebits =3D 64;
> > +     iio_chan->scan_type.endianness =3D IIO_LE;
> > +}
> > +
> > +static int scmi_iio_get_chan_modifier(const char *name,
> > +                                   enum iio_modifier *modifier)
> > +{
>
> AFAIU this is called during IIO init and derives a modifier from the name
> of the sensors which are passed by the platform fw with sensor descriptor=
s,
> so I would not trust them to be weell formed (:D) and try to be picky abo=
ut
> *name as it was user-input to validate.
>
> > +     char *pch;
> > +
> > +     pch =3D strrchr(name, '_');
>
> What happens if name is NULL ?
>
> > +     if (!pch)
> > +             return -EINVAL;
> > +
> > +     if (strcmp(pch + 1, "X") =3D=3D 0) {
> > +             *modifier =3D IIO_MOD_X;
> > +             return 0;
> > +     } else if (strcmp(pch + 1, "Y") =3D=3D 0) {
> > +             *modifier =3D IIO_MOD_Y;
> > +             return 0;
> > +     } else if (strcmp(pch + 1, "Z") =3D=3D 0) {
> > +             *modifier =3D IIO_MOD_Z;
> > +             return 0;
> > +     } else {
> > +             return -EINVAL;
> > +     }
>
> Moroever, being a single char compare cannot this be done with a switch ?
>
>         char mod =3D *(pch + 1);
>
>         switch(mod) {
>         case 'X':
>                 *modifier =3D IIO_MOD_X;
>                 break
>         ...
>
> > +}
> > +
> > +static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type *ii=
o_type)
> > +{
> > +     switch (scmi_type) {
> > +     case METERS_SEC_SQUARED:
> > +             *iio_type =3D IIO_ACCEL;
> > +             return 0;
> why not a break to a final 'return ret;' (with ret properly set) ?
>
> > +     case RADIANS_SEC:
> > +             *iio_type =3D IIO_ANGL_VEL;
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int scmi_iio_get_sensor_max_range(struct iio_dev *iio_dev, int =
*val,
> > +                                      int *val2)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     int max_range_high, max_range_low;
> > +     long long max_range;
> > +
> > +     /*
> > +      * All the axes are supposed to have the same value for max range=
.
> > +      * We are just using the values from the Axis 0 here.
> > +      */
> > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > +             max_range =3D sensor->sensor_info->axis[0].attrs.max_rang=
e;
> > +             max_range_high =3D H32(max_range);
> > +             max_range_low =3D L32(max_range);
> > +
> > +             /*
> > +              * As IIO Val types have no provision for 64 bit values,
> > +              * and currently there are no known sensors using 64 bit
> > +              * for the range, this driver only supports sensor with
> > +              * 32 bit range value.
> > +              */
> > +             if (max_range_high !=3D 0)
> > +                     return -EINVAL;
> > +
> > +             *val =3D max_range_low;
> > +             *val2 =3D 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static void scmi_iio_get_sensor_resolution(struct iio_dev *iio_dev, in=
t *val,
> > +                                        int *val2)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +
> > +     /*
> > +      * All the axes are supposed to have the same value for resolutio=
n
> > +      * and exponent. We are just using the values from the Axis 0 her=
e.
> > +      */
> > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > +             uint resolution =3D sensor->sensor_info->axis[0].resoluti=
on;
> > +             s8 exponent =3D sensor->sensor_info->axis[0].exponent;
> > +             s8 scale =3D sensor->sensor_info->axis[0].scale;
> > +
> > +             /*
> > +              * To provide the raw value for the resolution to the use=
rspace,
> > +              * need to divide the resolution exponent by the sensor s=
cale
> > +              */
> > +             exponent =3D exponent - scale;
> > +             if (exponent >=3D 0) {
> > +                     *val =3D resolution * int_pow(10, exponent);
> > +                     *val2 =3D 1;
> > +             } else {
> > +                     *val =3D resolution;
> > +                     *val2 =3D int_pow(10, abs(exponent));
> > +             }
> > +     }
> > +}
> > +
> > +static int scmi_iio_get_sensor_min_range(struct iio_dev *iio_dev, int =
*val,
> > +                                      int *val2)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     int min_range_high, min_range_low;
> > +     long long min_range;
> > +
> > +     /*
> > +      * All the axes are supposed to have the same value for min range=
.
> > +      * We are just using the values from the Axis 0 here.
> > +      */
> > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > +             min_range =3D sensor->sensor_info->axis[0].attrs.min_rang=
e;
> > +             min_range_high =3D H32(min_range);
> > +             min_range_low =3D L32(min_range);
> > +
> > +             /*
> > +              * As IIO Val types have no provision for 64 bit values,
> > +              * and currently there are no known sensors using 64 bit
> > +              * for the range, this driver only supports sensor with
> > +              * 32 bit range value.
> > +              */
> > +             if (min_range_high !=3D 0xFFFFFFFF)
> > +                     return -EINVAL;
> > +
> > +             *val =3D min_range_low;
> > +             *val2 =3D 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int scmi_iio_set_sensor_range_avail(struct iio_dev *iio_dev)
> > +{
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     int ret;
> > +
> > +     ret =3D scmi_iio_get_sensor_min_range(iio_dev, &sensor->range_ava=
il[0],
> > +                                         &sensor->range_avail[1]);
> > +     if (ret)
> > +             return ret;
> > +
> > +     scmi_iio_get_sensor_resolution(iio_dev, &sensor->range_avail[2],
> > +                                    &sensor->range_avail[3]);
> > +     ret =3D scmi_iio_get_sensor_max_range(iio_dev, &sensor->range_ava=
il[4],
> > +                                         &sensor->range_avail[5]);
> > +     return ret;
> > +}
> > +
> > +static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
> > +{
> > +     u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size=
_ns,
> > +             hz, uhz;
> > +     unsigned int cur_interval, low_interval, high_interval, step_size=
;
> > +     struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
> > +     int i;
> > +
> > +     sensor->freq_avail =3D devm_kzalloc(&iio_dev->dev,
> > +                                       sizeof(u32) * (sensor->sensor_i=
nfo->intervals.count * 2),
> > +                                       GFP_KERNEL);
> > +     if (!sensor->freq_avail)
> > +             return -ENOMEM;
> > +
> > +     if (sensor->sensor_info->intervals.segmented) {
> > +             low_interval =3D sensor->sensor_info->intervals
> > +                                    .desc[SCMI_SENS_INTVL_SEGMENT_LOW]=
;
> > +             low_interval_ns =3D scmi_iio_convert_interval_to_ns(low_i=
nterval);
> > +             convert_ns_to_freq(low_interval_ns, &hz, &uhz);
> > +             sensor->freq_avail[0] =3D hz;
> > +             sensor->freq_avail[1] =3D uhz;
> > +
> > +             step_size =3D sensor->sensor_info->intervals
> > +                                 .desc[SCMI_SENS_INTVL_SEGMENT_STEP];
> > +             step_size_ns =3D scmi_iio_convert_interval_to_ns(step_siz=
e);
> > +             convert_ns_to_freq(step_size_ns, &hz, &uhz);
> > +             sensor->freq_avail[2] =3D hz;
> > +             sensor->freq_avail[3] =3D uhz;
> > +
> > +             high_interval =3D sensor->sensor_info->intervals
> > +                                     .desc[SCMI_SENS_INTVL_SEGMENT_HIG=
H];
> > +             high_interval_ns =3D
> > +                     scmi_iio_convert_interval_to_ns(high_interval);
> > +             convert_ns_to_freq(high_interval_ns, &hz, &uhz);
> > +             sensor->freq_avail[4] =3D hz;
> > +             sensor->freq_avail[5] =3D uhz;
> > +     } else {
> > +             for (i =3D 0; i < sensor->sensor_info->intervals.count; i=
++) {
> > +                     cur_interval =3D sensor->sensor_info->intervals.d=
esc[i];
> > +                     cur_interval_ns =3D scmi_iio_convert_interval_to_=
ns(cur_interval);
> > +                     convert_ns_to_freq(cur_interval_ns, &hz, &uhz);
> > +                     sensor->freq_avail[i * 2] =3D hz;
> > +                     sensor->freq_avail[i * 2 + 1] =3D uhz;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> > +{
> > +     struct iio_buffer *buffer;
> > +
> > +     buffer =3D devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> > +     if (!buffer)
> > +             return -ENOMEM;
> > +
> > +     iio_device_attach_buffer(scmi_iiodev, buffer);
> > +     scmi_iiodev->modes |=3D INDIO_BUFFER_SOFTWARE;
> > +     scmi_iiodev->setup_ops =3D &scmi_iio_buffer_ops;
>
> Not familiar with IIO, but is it fine to setup ops and modes AFTER
> having attached the buffer to the scmi_iiodev ?
>
> Is is not 'racy-possible' that the buffer is already operational without
> any ops immediately after being attached ?
>
> > +     return 0;
> > +}
> > +
> > +static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle *h=
andle,
> > +                          const struct scmi_sensor_info *sensor_info,
> > +                          struct iio_dev **scmi_iio_dev)
> > +{
> > +     struct iio_chan_spec *iio_channels;
> > +     struct scmi_iio_priv *sensor;
> > +     enum iio_modifier modifier;
> > +     enum iio_chan_type type;
> > +     struct iio_dev *iiodev;
> > +     int i, ret;
> > +
> > +     iiodev =3D devm_iio_device_alloc(dev, sizeof(*sensor));
> > +     if (!iiodev)
> > +             return -ENOMEM;
> > +
> > +     iiodev->modes =3D INDIO_DIRECT_MODE;
> > +     iiodev->dev.parent =3D dev;
> > +     sensor =3D iio_priv(iiodev);
> > +     sensor->handle =3D handle;
> > +     sensor->sensor_info =3D sensor_info;
> > +     sensor->sensor_update_nb.notifier_call =3D scmi_iio_sensor_update=
_cb;
> > +     sensor->indio_dev =3D iiodev;
> > +
> > +     /* adding one additional channel for timestamp */
> > +     iiodev->num_channels =3D sensor_info->num_axis + 1;
> > +     iiodev->name =3D sensor_info->name;
> > +     iiodev->info =3D &scmi_iio_info;
> > +
> > +     iio_channels =3D
> > +             devm_kzalloc(dev,
> > +                          sizeof(*iio_channels) * (iiodev->num_channel=
s),
> > +                          GFP_KERNEL);
> > +     if (!iio_channels)
> > +             return -ENOMEM;
> > +
> > +     scmi_iio_set_sampling_freq_avail(iiodev);
> > +
> > +     ret =3D scmi_iio_set_sensor_range_avail(iiodev);
> > +     if (ret) {
> > +             dev_err(dev, "Error while setting the sensor %s range %d"=
,
> > +                     sensor_info->name, ret);
> > +             return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < sensor_info->num_axis; i++) {
> > +             ret =3D scmi_iio_get_chan_type(sensor_info->axis[i].type,=
 &type);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D scmi_iio_get_chan_modifier(sensor_info->axis[i].n=
ame,
> > +                                              &modifier);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             scmi_iio_set_data_channel(&iio_channels[i], type, modifie=
r,
> > +                                       sensor_info->axis[i].id);
> > +     }
> > +
> > +     scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> > +     iiodev->channels =3D iio_channels;
> > +     *scmi_iio_dev =3D iiodev;
> > +     return ret;
> > +}
> > +
> > +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> > +{
> > +     const struct scmi_sensor_info *sensor_info;
> > +     struct scmi_handle *handle =3D sdev->handle;
> > +     struct device *dev =3D &sdev->dev;
> > +     struct iio_dev *scmi_iio_dev;
> > +     u16 nr_sensors;
> > +     int err, i;
> > +
> > +     if (!handle || !handle->sensor_ops || !handle->sensor_ops->count_=
get ||
> > +         !handle->sensor_ops->info_get || !handle->sensor_ops->config_=
get ||
> > +         !handle->sensor_ops->config_set) {
>
> In all other SCMI driver we just check for:
>
>         !handle && !handle->sensor_ops
>
> it should be enough, since all the ops are defined if the stack you are
> using supports SCMIv3.0, if not this driver would not even compile since
> some SCMIv3.0 Sensor Extension sensor_ops would be missing as a whole
> inside the struct itself.
>
> Thanks
>
> Cristian
>
> > +             dev_err(dev, "SCMI device has no sensor interface\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     nr_sensors =3D handle->sensor_ops->count_get(handle);
> > +     if (!nr_sensors) {
> > +             dev_dbg(dev, "0 sensors found via SCMI bus\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     dev_dbg(dev, "%d sensors found via SCMI bus\n", nr_sensors);
> > +
> > +     for (i =3D 0; i < nr_sensors; i++) {
> > +             sensor_info =3D handle->sensor_ops->info_get(handle, i);
> > +             if (!sensor_info) {
> > +                     dev_err(dev, "SCMI sensor %d has missing info\n",=
 i);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /* Skipping scalar sensor,as this driver only supports ac=
cel and gyro */
> > +             if (sensor_info->num_axis =3D=3D 0)
> > +                     continue;
> > +
> > +             err =3D scmi_alloc_iiodev(dev, handle, sensor_info,
> > +                                     &scmi_iio_dev);
> > +             if (err < 0) {
> > +                     dev_err(dev,
> > +                             "failed to allocate IIO device for sensor=
 %s: %d\n",
> > +                             sensor_info->name, err);
> > +                     return err;
> > +             }
> > +
> > +             err =3D scmi_iio_buffers_setup(scmi_iio_dev);
> > +             if (err < 0) {
> > +                     dev_err(dev,
> > +                             "IIO buffer setup error at sensor %s: %d\=
n",
> > +                             sensor_info->name, err);
> > +                     return err;
> > +             }
> > +
> > +             err =3D devm_iio_device_register(dev, scmi_iio_dev);
> > +             if (err) {
> > +                     dev_err(dev,
> > +                             "IIO device registration failed at sensor=
 %s: %d\n",
> > +                             sensor_info->name, err);
> > +                     return err;
> > +             }
> > +     }
> > +     return err;
> > +}
> > +
> > +static const struct scmi_device_id scmi_id_table[] =3D {
> > +     { SCMI_PROTOCOL_SENSOR, "iiodev" },
> > +     {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > +
> > +static struct scmi_driver scmi_iiodev_driver =3D {
> > +     .name =3D "scmi-sensor-iiodev",
> > +     .probe =3D scmi_iio_dev_probe,
> > +     .id_table =3D scmi_id_table,
> > +};
> > +
> > +module_scmi_driver(scmi_iiodev_driver);
> > +
> > +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> > +MODULE_DESCRIPTION("SCMI IIO Driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
