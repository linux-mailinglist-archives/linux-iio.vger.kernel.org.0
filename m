Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F32339F62
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 18:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhCMRLb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 12:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhCMRLP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 12:11:15 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86ADB64E45;
        Sat, 13 Mar 2021 17:11:11 +0000 (UTC)
Date:   Sat, 13 Mar 2021 17:11:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
        Ankit Arora <ankitarora@google.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210313171107.4c8215e7@archlinux>
In-Reply-To: <CA+=V6c0boA1Q+k4rM0NOcK4ek_FYU7omEWhvMowqACH_t44sAQ@mail.gmail.com>
References: <20210309231259.78050-1-jbhayana@google.com>
        <20210309231259.78050-2-jbhayana@google.com>
        <20210311210844.34371d8d@archlinux>
        <20210312121639.00001c31@Huawei.com>
        <20210312133101.GG30179@e120937-lin>
        <CA+=V6c0boA1Q+k4rM0NOcK4ek_FYU7omEWhvMowqACH_t44sAQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 09:54:12 -0800
Jyoti Bhayana <jbhayana@google.com> wrote:

> Hi Jonathan,
> 
> I also see what Cristian has observed that rc2 is still pointing to v6
> of the SCMI IIO driver patch and it also doesn't have the changes
> which you did in rc1 for changing long long to s64.
> 
> Thanks,
> Jyoti

Gah!  I must have grabbed wrong one somehow.

Anyhow, there is now a 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-scmi-5.12-rc2-take2

version which should looks to have the right dates an all.  Merge into
my togreg still the same as it was previously.

Thanks,

Jonathan

> 
> 
> On Fri, Mar 12, 2021 at 5:31 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Hi Jonathan,
> >
> > thanks for this, I was starting working on top of this new immutable
> > branch BUT I spotted a thing that I wanted to check.
> >
> > You latest immutable:
> >  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-scmi-5.12-rc2
> >
> > looking at the code in the SCMI IIO Jyoti driver
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=ib-iio-scmi-5.12-rc2&id=f937d8c1ef246d99d2174ed88c629f6e24823918
> >
> > this seems to me that still includes v6 of IIO Jyoti patch:
> >
> > https://lore.kernel.org/linux-iio/20210212172235.507028-2-jbhayana@google.com/
> >
> > (the offending one on the bot report related to div symbols on MIPS if I got it right),
> > in fact it has 710 insertions and still uses div64_u64 (and the Link tag leads to the v6)
> >
> > while the lastest v7
> >
> > https://lore.kernel.org/lkml/20210309231259.78050-2-jbhayana@google.com/
> >
> > has 715 insetions and uses do_div instead, but in fact this v7 has a Link:
> > tag still pointing to v6 (maybe this is the issue...?)
> >
> > Sorry for the noise if I missed something and everything is fine please
> > ignore me and I'll go ahead with this branch if you say so.
> >
> > Thanks
> >
> > Cristian
> >
> >
> >
> > On Fri, Mar 12, 2021 at 12:16:39PM +0000, Jonathan Cameron wrote:  
> > > On Thu, 11 Mar 2021 21:08:44 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >  
> > > > On Tue,  9 Mar 2021 23:12:59 +0000
> > > > Jyoti Bhayana <jbhayana@google.com> wrote:
> > > >  
> > > > > This change provides ARM SCMI Protocol based IIO device.
> > > > > This driver provides support for Accelerometer and Gyroscope using
> > > > > SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification
> > > > >
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
> > > > > Link: https://lore.kernel.org/r/20210212172235.507028-2-jbhayana@google.com
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-scmi-5.12-rc2
> > > >
> > > > New immutable branch.  I move to rc2 as the base as the rc1 tag
> > > > has been removed for well publicized reasons.
> > > >
> > > > Should have the 0-day results in tomorrow morning. I'll shout
> > > > if anything else shows up.  
> > > 0-day is happy, so this is now immutable and suitable for pulling in through
> > > whatever trees need it.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >  
> > > >
> > > > Also rebased the togreg branch for the same reason (hadn't pushed it
> > > > out as anything other than testing, so hopefully no one was basing
> > > > anything significant on top)
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >  
> > > > > ---
> > > > >  MAINTAINERS                                |   6 +
> > > > >  drivers/firmware/arm_scmi/driver.c         |   2 +-
> > > > >  drivers/iio/common/Kconfig                 |   1 +
> > > > >  drivers/iio/common/Makefile                |   1 +
> > > > >  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
> > > > >  drivers/iio/common/scmi_sensors/Makefile   |   5 +
> > > > >  drivers/iio/common/scmi_sensors/scmi_iio.c | 683 +++++++++++++++++++++
> > > > >  7 files changed, 715 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
> > > > >  create mode 100644 drivers/iio/common/scmi_sensors/Makefile
> > > > >  create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index d92f85ca831d..14227980f3d2 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -8692,6 +8692,12 @@ S: Maintained
> > > > >  F:       Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> > > > >  F:       drivers/iio/multiplexer/iio-mux.c
> > > > >
> > > > > +IIO SCMI BASED DRIVER
> > > > > +M:       Jyoti Bhayana <jbhayana@google.com>
> > > > > +L:       linux-iio@vger.kernel.org
> > > > > +S:       Maintained
> > > > > +F:       drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > +
> > > > >  IIO SUBSYSTEM AND DRIVERS
> > > > >  M:       Jonathan Cameron <jic23@kernel.org>
> > > > >  R:       Lars-Peter Clausen <lars@metafoo.de>
> > > > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > > > index cacdf1589b10..3e748e57deab 100644
> > > > > --- a/drivers/firmware/arm_scmi/driver.c
> > > > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > > > @@ -741,7 +741,7 @@ static struct scmi_prot_devnames devnames[] = {
> > > > >   { SCMI_PROTOCOL_SYSTEM, { "syspower" },},
> > > > >   { SCMI_PROTOCOL_PERF,   { "cpufreq" },},
> > > > >   { SCMI_PROTOCOL_CLOCK,  { "clocks" },},
> > > > > - { SCMI_PROTOCOL_SENSOR, { "hwmon" },},
> > > > > + { SCMI_PROTOCOL_SENSOR, { "hwmon", "iiodev" },},
> > > > >   { SCMI_PROTOCOL_RESET,  { "reset" },},
> > > > >   { SCMI_PROTOCOL_VOLTAGE,  { "regulator" },},
> > > > >  };
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
> > > > > diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
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
> > > > > diff --git a/drivers/iio/common/scmi_sensors/Kconfig b/drivers/iio/common/scmi_sensors/Kconfig
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
> > > > > + tristate "IIO SCMI"
> > > > > +        depends on ARM_SCMI_PROTOCOL
> > > > > +        select IIO_BUFFER
> > > > > +        select IIO_KFIFO_BUF
> > > > > + help
> > > > > +          Say yes here to build support for IIO SCMI Driver.
> > > > > +          This provides ARM SCMI Protocol based IIO device.
> > > > > +          This driver provides support for accelerometer and gyroscope
> > > > > +          sensors available on SCMI based platforms.
> > > > > +endmenu
> > > > > diff --git a/drivers/iio/common/scmi_sensors/Makefile b/drivers/iio/common/scmi_sensors/Makefile
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
> > > > > diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > new file mode 100644
> > > > > index 000000000000..872d87ca6256
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > > @@ -0,0 +1,683 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +/*
> > > > > + * System Control and Management Interface(SCMI) based IIO sensor driver
> > > > > + *
> > > > > + * Copyright (C) 2021 Google LLC
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
> > > > > +#define SCMI_IIO_NUM_OF_AXIS 3
> > > > > +
> > > > > +struct scmi_iio_priv {
> > > > > + struct scmi_handle *handle;
> > > > > + const struct scmi_sensor_info *sensor_info;
> > > > > + struct iio_dev *indio_dev;
> > > > > + /* adding one additional channel for timestamp */
> > > > > + s64 iio_buf[SCMI_IIO_NUM_OF_AXIS + 1];
> > > > > + struct notifier_block sensor_update_nb;
> > > > > + u32 *freq_avail;
> > > > > +};
> > > > > +
> > > > > +static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
> > > > > +                              unsigned long event, void *data)
> > > > > +{
> > > > > + struct scmi_sensor_update_report *sensor_update = data;
> > > > > + struct iio_dev *scmi_iio_dev;
> > > > > + struct scmi_iio_priv *sensor;
> > > > > + s8 tstamp_scale;
> > > > > + u64 time, time_ns;
> > > > > + int i;
> > > > > +
> > > > > + if (sensor_update->readings_count == 0)
> > > > > +         return NOTIFY_DONE;
> > > > > +
> > > > > + sensor = container_of(nb, struct scmi_iio_priv, sensor_update_nb);
> > > > > +
> > > > > + for (i = 0; i < sensor_update->readings_count; i++)
> > > > > +         sensor->iio_buf[i] = sensor_update->readings[i].value;
> > > > > +
> > > > > + if (!sensor->sensor_info->timestamped) {
> > > > > +         time_ns = ktime_to_ns(sensor_update->timestamp);
> > > > > + } else {
> > > > > +         /*
> > > > > +          *  All the axes are supposed to have the same value for timestamp.
> > > > > +          *  We are just using the values from the Axis 0 here.
> > > > > +          */
> > > > > +         time = sensor_update->readings[0].timestamp;
> > > > > +
> > > > > +         /*
> > > > > +          *  Timestamp returned by SCMI is in seconds and is equal to
> > > > > +          *  time * power-of-10 multiplier(tstamp_scale) seconds.
> > > > > +          *  Converting the timestamp to nanoseconds below.
> > > > > +          */
> > > > > +         tstamp_scale = sensor->sensor_info->tstamp_scale +
> > > > > +                        const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> > > > > +         if (tstamp_scale < 0) {
> > > > > +                 do_div(time, int_pow(10, abs(tstamp_scale)));
> > > > > +                 time_ns = time;
> > > > > +         } else {
> > > > > +                 time_ns = time * int_pow(10, tstamp_scale);
> > > > > +         }
> > > > > + }
> > > > > +
> > > > > + scmi_iio_dev = sensor->indio_dev;
> > > > > + iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
> > > > > +                                    time_ns);
> > > > > + return NOTIFY_OK;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> > > > > +{
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > + u32 sensor_id = sensor->sensor_info->id;
> > > > > + u32 sensor_config = 0;
> > > > > + int err;
> > > > > +
> > > > > + if (sensor->sensor_info->timestamped)
> > > > > +         sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
> > > > > +                                     SCMI_SENS_CFG_TSTAMP_ENABLE);
> > > > > +
> > > > > + sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > > > +                             SCMI_SENS_CFG_SENSOR_ENABLE);
> > > > > +
> > > > > + err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
> > > > > +                 SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > > +                 &sensor_id, &sensor->sensor_update_nb);
> > > > > + if (err) {
> > > > > +         dev_err(&iio_dev->dev,
> > > > > +                 "Error in registering sensor update notifier for sensor %s err %d",
> > > > > +                 sensor->sensor_info->name, err);
> > > > > +         return err;
> > > > > + }
> > > > > +
> > > > > + err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > > +                 sensor->sensor_info->id, sensor_config);
> > > > > + if (err) {
> > > > > +         sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > > > > +                         SCMI_PROTOCOL_SENSOR,
> > > > > +                         SCMI_EVENT_SENSOR_UPDATE, &sensor_id,
> > > > > +                         &sensor->sensor_update_nb);
> > > > > +         dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
> > > > > +                 sensor->sensor_info->name, err);
> > > > > + }
> > > > > +
> > > > > + return err;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
> > > > > +{
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > + u32 sensor_id = sensor->sensor_info->id;
> > > > > + u32 sensor_config = 0;
> > > > > + int err;
> > > > > +
> > > > > + sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > > > +                             SCMI_SENS_CFG_SENSOR_DISABLE);
> > > > > +
> > > > > + err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > > > > +                 SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > > +                 &sensor_id, &sensor->sensor_update_nb);
> > > > > + if (err) {
> > > > > +         dev_err(&iio_dev->dev,
> > > > > +                 "Error in unregistering sensor update notifier for sensor %s err %d",
> > > > > +                 sensor->sensor_info->name, err);
> > > > > +         return err;
> > > > > + }
> > > > > +
> > > > > + err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
> > > > > +                                              sensor_config);
> > > > > + if (err) {
> > > > > +         dev_err(&iio_dev->dev,
> > > > > +                 "Error in disabling sensor %s with err %d",
> > > > > +                 sensor->sensor_info->name, err);
> > > > > + }
> > > > > +
> > > > > + return err;
> > > > > +}
> > > > > +
> > > > > +static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
> > > > > + .preenable = scmi_iio_buffer_preenable,
> > > > > + .postdisable = scmi_iio_buffer_postdisable,
> > > > > +};
> > > > > +
> > > > > +static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> > > > > +{
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > + const unsigned long UHZ_PER_HZ = 1000000UL;
> > > > > + u64 sec, mult, uHz, sf;
> > > > > + u32 sensor_config;
> > > > > + char buf[32];
> > > > > +
> > > > > + int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> > > > > +                 sensor->sensor_info->id, &sensor_config);
> > > > > + if (err) {
> > > > > +         dev_err(&iio_dev->dev,
> > > > > +                 "Error in getting sensor config for sensor %s err %d",
> > > > > +                 sensor->sensor_info->name, err);
> > > > > +         return err;
> > > > > + }
> > > > > +
> > > > > + uHz = val * UHZ_PER_HZ + val2;
> > > > > +
> > > > > + /*
> > > > > +  * The seconds field in the sensor interval in SCMI is 16 bits long
> > > > > +  * Therefore seconds  = 1/Hz <= 0xFFFF. As floating point calculations are
> > > > > +  * discouraged in the kernel driver code, to calculate the scale factor (sf)
> > > > > +  * (1* 1000000 * sf)/uHz <= 0xFFFF. Therefore, sf <= (uHz * 0xFFFF)/1000000
> > > > > +  * To calculate the multiplier,we convert the sf into char string  and
> > > > > +  * count the number of characters
> > > > > +  */
> > > > > + sf = (u64)uHz * 0xFFFF;
> > > > > + do_div(sf,  UHZ_PER_HZ);
> > > > > + mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
> > > > > +
> > > > > + sec = int_pow(10, mult) * UHZ_PER_HZ;
> > > > > + do_div(sec, uHz);
> > > > > + if (sec == 0) {
> > > > > +         dev_err(&iio_dev->dev,
> > > > > +                 "Trying to set invalid sensor update value for sensor %s",
> > > > > +                 sensor->sensor_info->name);
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +
> > > > > + sensor_config &= ~SCMI_SENS_CFG_UPDATE_SECS_MASK;
> > > > > + sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_SECS_MASK, sec);
> > > > > + sensor_config &= ~SCMI_SENS_CFG_UPDATE_EXP_MASK;
> > > > > + sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_EXP_MASK, -mult);
> > > > > +
> > > > > + if (sensor->sensor_info->timestamped) {
> > > > > +         sensor_config &= ~SCMI_SENS_CFG_TSTAMP_ENABLED_MASK;
> > > > > +         sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
> > > > > +                                     SCMI_SENS_CFG_TSTAMP_ENABLE);
> > > > > + }
> > > > > +
> > > > > + sensor_config &= ~SCMI_SENS_CFG_ROUND_MASK;
> > > > > + sensor_config |=
> > > > > +         FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
> > > > > +
> > > > > + err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > > +                 sensor->sensor_info->id, sensor_config);
> > > > > + if (err)
> > > > > +         dev_err(&iio_dev->dev,
> > > > > +                 "Error in setting sensor update interval for sensor %s value %u err %d",
> > > > > +                 sensor->sensor_info->name, sensor_config, err);
> > > > > +
> > > > > + return err;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_write_raw(struct iio_dev *iio_dev,
> > > > > +                       struct iio_chan_spec const *chan, int val,
> > > > > +                       int val2, long mask)
> > > > > +{
> > > > > + int err;
> > > > > +
> > > > > + switch (mask) {
> > > > > + case IIO_CHAN_INFO_SAMP_FREQ:
> > > > > +         mutex_lock(&iio_dev->mlock);
> > > > > +         err = scmi_iio_set_odr_val(iio_dev, val, val2);
> > > > > +         mutex_unlock(&iio_dev->mlock);
> > > > > +         return err;
> > > > > + default:
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_read_avail(struct iio_dev *iio_dev,
> > > > > +                        struct iio_chan_spec const *chan,
> > > > > +                        const int **vals, int *type, int *length,
> > > > > +                        long mask)
> > > > > +{
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > +
> > > > > + switch (mask) {
> > > > > + case IIO_CHAN_INFO_SAMP_FREQ:
> > > > > +         *vals = sensor->freq_avail;
> > > > > +         *type = IIO_VAL_INT_PLUS_MICRO;
> > > > > +         *length = sensor->sensor_info->intervals.count * 2;
> > > > > +         if (sensor->sensor_info->intervals.segmented)
> > > > > +                 return IIO_AVAIL_RANGE;
> > > > > +         else
> > > > > +                 return IIO_AVAIL_LIST;
> > > > > + default:
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
> > > > > +{
> > > > > + u64 rem, freq;
> > > > > +
> > > > > + freq = NSEC_PER_SEC;
> > > > > + rem = do_div(freq, interval_ns);
> > > > > + *hz = freq;
> > > > > + *uhz = rem * 1000000UL;
> > > > > + do_div(*uhz, interval_ns);
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> > > > > +{
> > > > > + u64 sensor_update_interval, sensor_interval_mult, hz, uhz;
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > + u32 sensor_config;
> > > > > + int mult;
> > > > > +
> > > > > + int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> > > > > +                 sensor->sensor_info->id, &sensor_config);
> > > > > + if (err) {
> > > > > +         dev_err(&iio_dev->dev,
> > > > > +                 "Error in getting sensor config for sensor %s err %d",
> > > > > +                 sensor->sensor_info->name, err);
> > > > > +         return err;
> > > > > + }
> > > > > +
> > > > > + sensor_update_interval =
> > > > > +         SCMI_SENS_CFG_GET_UPDATE_SECS(sensor_config) * NSEC_PER_SEC;
> > > > > +
> > > > > + mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
> > > > > + if (mult < 0) {
> > > > > +         sensor_interval_mult = int_pow(10, abs(mult));
> > > > > +         do_div(sensor_update_interval, sensor_interval_mult);
> > > > > + } else {
> > > > > +         sensor_interval_mult = int_pow(10, mult);
> > > > > +         sensor_update_interval =
> > > > > +                 sensor_update_interval * sensor_interval_mult;
> > > > > + }
> > > > > +
> > > > > + convert_ns_to_freq(sensor_update_interval, &hz, &uhz);
> > > > > + *val = hz;
> > > > > + *val2 = uhz;
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> > > > > +                      struct iio_chan_spec const *ch, int *val,
> > > > > +                      int *val2, long mask)
> > > > > +{
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > + s8 scale;
> > > > > + int ret;
> > > > > +
> > > > > + switch (mask) {
> > > > > + case IIO_CHAN_INFO_SCALE:
> > > > > +         scale = sensor->sensor_info->axis[ch->scan_index].scale;
> > > > > +         if (scale < 0) {
> > > > > +                 *val = 1;
> > > > > +                 *val2 = int_pow(10, abs(scale));
> > > > > +                 return IIO_VAL_FRACTIONAL;
> > > > > +         }
> > > > > +         *val = int_pow(10, scale);
> > > > > +         return IIO_VAL_INT;
> > > > > + case IIO_CHAN_INFO_SAMP_FREQ:
> > > > > +         ret = scmi_iio_get_odr_val(iio_dev, val, val2);
> > > > > +         return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > > > > + default:
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +static const struct iio_info scmi_iio_info = {
> > > > > + .read_raw = scmi_iio_read_raw,
> > > > > + .read_avail = scmi_iio_read_avail,
> > > > > + .write_raw = scmi_iio_write_raw,
> > > > > +};
> > > > > +
> > > > > +static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
> > > > > +                                   uintptr_t private,
> > > > > +                                   const struct iio_chan_spec *chan,
> > > > > +                                   char *buf)
> > > > > +{
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > + u64 resolution, rem;
> > > > > + s64 min_range, max_range;
> > > > > + s8 exponent, scale;
> > > > > + int len = 0;
> > > > > +
> > > > > + /*
> > > > > +  * All the axes are supposed to have the same value for range and resolution.
> > > > > +  * We are just using the values from the Axis 0 here.
> > > > > +  */
> > > > > + if (sensor->sensor_info->axis[0].extended_attrs) {
> > > > > +         min_range = sensor->sensor_info->axis[0].attrs.min_range;
> > > > > +         max_range = sensor->sensor_info->axis[0].attrs.max_range;
> > > > > +         resolution = sensor->sensor_info->axis[0].resolution;
> > > > > +         exponent = sensor->sensor_info->axis[0].exponent;
> > > > > +         scale = sensor->sensor_info->axis[0].scale;
> > > > > +
> > > > > +         /*
> > > > > +          * To provide the raw value for the resolution to the userspace,
> > > > > +          * need to divide the resolution exponent by the sensor scale
> > > > > +          */
> > > > > +         exponent = exponent - scale;
> > > > > +         if (exponent < 0) {
> > > > > +                 rem = do_div(resolution,
> > > > > +                              int_pow(10, abs(exponent))
> > > > > +                              );
> > > > > +                 len = scnprintf(buf, PAGE_SIZE,
> > > > > +                                 "[%lld %llu.%llu %lld]\n", min_range,
> > > > > +                                 resolution, rem, max_range);
> > > > > +         } else {
> > > > > +                 resolution = resolution * int_pow(10, exponent);
> > > > > +                 len = scnprintf(buf, PAGE_SIZE, "[%lld %llu %lld]\n",
> > > > > +                                 min_range, resolution, max_range);
> > > > > +         }
> > > > > + }
> > > > > + return len;
> > > > > +}
> > > > > +
> > > > > +static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
> > > > > + {
> > > > > +         .name = "raw_available",
> > > > > +         .read = scmi_iio_get_raw_available,
> > > > > +         .shared = IIO_SHARED_BY_TYPE,
> > > > > + },
> > > > > + {},
> > > > > +};
> > > > > +
> > > > > +static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
> > > > > +                                    int scan_index)
> > > > > +{
> > > > > + iio_chan->type = IIO_TIMESTAMP;
> > > > > + iio_chan->channel = -1;
> > > > > + iio_chan->scan_index = scan_index;
> > > > > + iio_chan->scan_type.sign = 'u';
> > > > > + iio_chan->scan_type.realbits = 64;
> > > > > + iio_chan->scan_type.storagebits = 64;
> > > > > +}
> > > > > +
> > > > > +static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
> > > > > +                               enum iio_chan_type type,
> > > > > +                               enum iio_modifier mod, int scan_index)
> > > > > +{
> > > > > + iio_chan->type = type;
> > > > > + iio_chan->modified = 1;
> > > > > + iio_chan->channel2 = mod;
> > > > > + iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> > > > > + iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> > > > > + iio_chan->info_mask_shared_by_type_available =
> > > > > +         BIT(IIO_CHAN_INFO_SAMP_FREQ);
> > > > > + iio_chan->scan_index = scan_index;
> > > > > + iio_chan->scan_type.sign = 's';
> > > > > + iio_chan->scan_type.realbits = 64;
> > > > > + iio_chan->scan_type.storagebits = 64;
> > > > > + iio_chan->scan_type.endianness = IIO_LE;
> > > > > + iio_chan->ext_info = scmi_iio_ext_info;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_chan_modifier(const char *name,
> > > > > +                               enum iio_modifier *modifier)
> > > > > +{
> > > > > + char *pch, mod;
> > > > > +
> > > > > + if (!name)
> > > > > +         return -EINVAL;
> > > > > +
> > > > > + pch = strrchr(name, '_');
> > > > > + if (!pch)
> > > > > +         return -EINVAL;
> > > > > +
> > > > > + mod = *(pch + 1);
> > > > > + switch (mod) {
> > > > > + case 'X':
> > > > > +         *modifier = IIO_MOD_X;
> > > > > +         return 0;
> > > > > + case 'Y':
> > > > > +         *modifier = IIO_MOD_Y;
> > > > > +         return 0;
> > > > > + case 'Z':
> > > > > +         *modifier = IIO_MOD_Z;
> > > > > +         return 0;
> > > > > + default:
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type *iio_type)
> > > > > +{
> > > > > + switch (scmi_type) {
> > > > > + case METERS_SEC_SQUARED:
> > > > > +         *iio_type = IIO_ACCEL;
> > > > > +         return 0;
> > > > > + case RADIANS_SEC:
> > > > > +         *iio_type = IIO_ANGL_VEL;
> > > > > +         return 0;
> > > > > + default:
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +static u64 scmi_iio_convert_interval_to_ns(u32 val)
> > > > > +{
> > > > > + u64 sensor_update_interval =
> > > > > +         SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
> > > > > + u64 sensor_interval_mult;
> > > > > + int mult;
> > > > > +
> > > > > + mult = SCMI_SENS_INTVL_GET_EXP(val);
> > > > > + if (mult < 0) {
> > > > > +         sensor_interval_mult = int_pow(10, abs(mult));
> > > > > +         do_div(sensor_update_interval, sensor_interval_mult);
> > > > > + } else {
> > > > > +         sensor_interval_mult = int_pow(10, mult);
> > > > > +         sensor_update_interval =
> > > > > +                 sensor_update_interval * sensor_interval_mult;
> > > > > + }
> > > > > + return sensor_update_interval;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
> > > > > +{
> > > > > + u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns,
> > > > > +         hz, uhz;
> > > > > + unsigned int cur_interval, low_interval, high_interval, step_size;
> > > > > + struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > > + int i;
> > > > > +
> > > > > + sensor->freq_avail =
> > > > > +         devm_kzalloc(&iio_dev->dev,
> > > > > +                      sizeof(*sensor->freq_avail) *
> > > > > +                              (sensor->sensor_info->intervals.count * 2),
> > > > > +                      GFP_KERNEL);
> > > > > + if (!sensor->freq_avail)
> > > > > +         return -ENOMEM;
> > > > > +
> > > > > + if (sensor->sensor_info->intervals.segmented) {
> > > > > +         low_interval = sensor->sensor_info->intervals
> > > > > +                                .desc[SCMI_SENS_INTVL_SEGMENT_LOW];
> > > > > +         low_interval_ns = scmi_iio_convert_interval_to_ns(low_interval);
> > > > > +         convert_ns_to_freq(low_interval_ns, &hz, &uhz);
> > > > > +         sensor->freq_avail[0] = hz;
> > > > > +         sensor->freq_avail[1] = uhz;
> > > > > +
> > > > > +         step_size = sensor->sensor_info->intervals
> > > > > +                             .desc[SCMI_SENS_INTVL_SEGMENT_STEP];
> > > > > +         step_size_ns = scmi_iio_convert_interval_to_ns(step_size);
> > > > > +         convert_ns_to_freq(step_size_ns, &hz, &uhz);
> > > > > +         sensor->freq_avail[2] = hz;
> > > > > +         sensor->freq_avail[3] = uhz;
> > > > > +
> > > > > +         high_interval = sensor->sensor_info->intervals
> > > > > +                                 .desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
> > > > > +         high_interval_ns =
> > > > > +                 scmi_iio_convert_interval_to_ns(high_interval);
> > > > > +         convert_ns_to_freq(high_interval_ns, &hz, &uhz);
> > > > > +         sensor->freq_avail[4] = hz;
> > > > > +         sensor->freq_avail[5] = uhz;
> > > > > + } else {
> > > > > +         for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
> > > > > +                 cur_interval = sensor->sensor_info->intervals.desc[i];
> > > > > +                 cur_interval_ns =
> > > > > +                         scmi_iio_convert_interval_to_ns(cur_interval);
> > > > > +                 convert_ns_to_freq(cur_interval_ns, &hz, &uhz);
> > > > > +                 sensor->freq_avail[i * 2] = hz;
> > > > > +                 sensor->freq_avail[i * 2 + 1] = uhz;
> > > > > +         }
> > > > > + }
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> > > > > +{
> > > > > + struct iio_buffer *buffer;
> > > > > +
> > > > > + buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> > > > > + if (!buffer)
> > > > > +         return -ENOMEM;
> > > > > +
> > > > > + iio_device_attach_buffer(scmi_iiodev, buffer);
> > > > > + scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> > > > > + scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > +static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> > > > > +                                  struct scmi_handle *handle,
> > > > > +                                  const struct scmi_sensor_info *sensor_info)
> > > > > +{
> > > > > + struct iio_chan_spec *iio_channels;
> > > > > + struct scmi_iio_priv *sensor;
> > > > > + enum iio_modifier modifier;
> > > > > + enum iio_chan_type type;
> > > > > + struct iio_dev *iiodev;
> > > > > + int i, ret;
> > > > > +
> > > > > + iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> > > > > + if (!iiodev)
> > > > > +         return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > + iiodev->modes = INDIO_DIRECT_MODE;
> > > > > + iiodev->dev.parent = dev;
> > > > > + sensor = iio_priv(iiodev);
> > > > > + sensor->handle = handle;
> > > > > + sensor->sensor_info = sensor_info;
> > > > > + sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
> > > > > + sensor->indio_dev = iiodev;
> > > > > +
> > > > > + /* adding one additional channel for timestamp */
> > > > > + iiodev->num_channels = sensor_info->num_axis + 1;
> > > > > + iiodev->name = sensor_info->name;
> > > > > + iiodev->info = &scmi_iio_info;
> > > > > +
> > > > > + iio_channels =
> > > > > +         devm_kzalloc(dev,
> > > > > +                      sizeof(*iio_channels) * (iiodev->num_channels),
> > > > > +                      GFP_KERNEL);
> > > > > + if (!iio_channels)
> > > > > +         return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > + ret = scmi_iio_set_sampling_freq_avail(iiodev);
> > > > > + if (ret < 0)
> > > > > +         return ERR_PTR(ret);
> > > > > +
> > > > > + for (i = 0; i < sensor_info->num_axis; i++) {
> > > > > +         ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
> > > > > +         if (ret < 0)
> > > > > +                 return ERR_PTR(ret);
> > > > > +
> > > > > +         ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> > > > > +                                          &modifier);
> > > > > +         if (ret < 0)
> > > > > +                 return ERR_PTR(ret);
> > > > > +
> > > > > +         scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
> > > > > +                                   sensor_info->axis[i].id);
> > > > > + }
> > > > > +
> > > > > + scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> > > > > + iiodev->channels = iio_channels;
> > > > > + return iiodev;
> > > > > +}
> > > > > +
> > > > > +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> > > > > +{
> > > > > + const struct scmi_sensor_info *sensor_info;
> > > > > + struct scmi_handle *handle = sdev->handle;
> > > > > + struct device *dev = &sdev->dev;
> > > > > + struct iio_dev *scmi_iio_dev;
> > > > > + u16 nr_sensors;
> > > > > + int err = -ENODEV, i;
> > > > > +
> > > > > + if (!handle || !handle->sensor_ops) {
> > > > > +         dev_err(dev, "SCMI device has no sensor interface\n");
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +
> > > > > + nr_sensors = handle->sensor_ops->count_get(handle);
> > > > > + if (!nr_sensors) {
> > > > > +         dev_dbg(dev, "0 sensors found via SCMI bus\n");
> > > > > +         return -ENODEV;
> > > > > + }
> > > > > +
> > > > > + for (i = 0; i < nr_sensors; i++) {
> > > > > +         sensor_info = handle->sensor_ops->info_get(handle, i);
> > > > > +         if (!sensor_info) {
> > > > > +                 dev_err(dev, "SCMI sensor %d has missing info\n", i);
> > > > > +                 return -EINVAL;
> > > > > +         }
> > > > > +
> > > > > +         /* This driver only supports 3-axis accel and gyro, skipping other sensors */
> > > > > +         if (sensor_info->num_axis != SCMI_IIO_NUM_OF_AXIS)
> > > > > +                 continue;
> > > > > +
> > > > > +         /* This driver only supports 3-axis accel and gyro, skipping other sensors */
> > > > > +         if (sensor_info->axis[0].type != METERS_SEC_SQUARED &&
> > > > > +             sensor_info->axis[0].type != RADIANS_SEC)
> > > > > +                 continue;
> > > > > +
> > > > > +         scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
> > > > > +         if (IS_ERR(scmi_iio_dev)) {
> > > > > +                 dev_err(dev,
> > > > > +                         "failed to allocate IIO device for sensor %s: %ld\n",
> > > > > +                         sensor_info->name, PTR_ERR(scmi_iio_dev));
> > > > > +                 return PTR_ERR(scmi_iio_dev);
> > > > > +         }
> > > > > +
> > > > > +         err = scmi_iio_buffers_setup(scmi_iio_dev);
> > > > > +         if (err < 0) {
> > > > > +                 dev_err(dev,
> > > > > +                         "IIO buffer setup error at sensor %s: %d\n",
> > > > > +                         sensor_info->name, err);
> > > > > +                 return err;
> > > > > +         }
> > > > > +
> > > > > +         err = devm_iio_device_register(dev, scmi_iio_dev);
> > > > > +         if (err) {
> > > > > +                 dev_err(dev,
> > > > > +                         "IIO device registration failed at sensor %s: %d\n",
> > > > > +                         sensor_info->name, err);
> > > > > +                 return err;
> > > > > +         }
> > > > > + }
> > > > > + return err;
> > > > > +}
> > > > > +
> > > > > +static const struct scmi_device_id scmi_id_table[] = {
> > > > > + { SCMI_PROTOCOL_SENSOR, "iiodev" },
> > > > > + {},
> > > > > +};
> > > > > +
> > > > > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > > > > +
> > > > > +static struct scmi_driver scmi_iiodev_driver = {
> > > > > + .name = "scmi-sensor-iiodev",
> > > > > + .probe = scmi_iio_dev_probe,
> > > > > + .id_table = scmi_id_table,
> > > > > +};
> > > > > +
> > > > > +module_scmi_driver(scmi_iiodev_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> > > > > +MODULE_DESCRIPTION("SCMI IIO Driver");
> > > > > +MODULE_LICENSE("GPL v2");  
> > > >  
> > >  
> 

