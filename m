Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87B550CF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfFYNxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 09:53:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57368 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFYNxL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 09:53:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 92F9C28A3E6
Subject: Re: [PATCH v7 2/2] iio: cros_ec: Add lid angle driver
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190517233856.155793-1-gwendal@chromium.org>
 <20190517233856.155793-3-gwendal@chromium.org>
 <20190518105350.1a863bfd@archlinux>
 <CAPUE2uvONxJN7MdUKU-tCx59kd+x+pbYqPH8fLKbSp4_cvSzJg@mail.gmail.com>
 <CAFqH_53orAG1d3k11517_qP5fC=V1RR14yZHK6VUgcvS-2wgEg@mail.gmail.com>
 <20190621163112.00005914@huawei.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d8881c53-8c84-edf4-1f43-d188ca00454d@collabora.com>
Date:   Tue, 25 Jun 2019 15:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621163112.00005914@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 21/6/19 17:31, Jonathan Cameron wrote:
> On Wed, 19 Jun 2019 22:49:04 +0200
> Enric Balletbo Serra <eballetbo@gmail.com> wrote:
> 
>> Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dv., 14 de
>> juny 2019 a les 23:56:
>>>
>>> On Sat, May 18, 2019 at 2:53 AM Jonathan Cameron <jic23@kernel.org> wrote:  
>>>>
>>>> On Fri, 17 May 2019 16:38:56 -0700
>>>> Gwendal Grignou <gwendal@chromium.org> wrote:
>>>>  
>>>>> Add a IIO driver that reports the angle between the lid and the base for
>>>>> ChromeOS convertible device.
>>>>>
>>>>> Tested on eve with ToT EC firmware.
>>>>> Check driver is loaded and lid angle is correct.
>>>>>
>>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
>>>> Hi Gwendal.
>>>>
>>>> Please do list dependencies in patches.  I think this one is still
>>>> dependent on the larger set of MFD changes.
>>>>
>>>> For my reference
>>>>
>>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>
>>>> Please do poke if this seems to have gotten lost once the precursors
>>>> are upstream.  
>>> The large set of MFD changes for update cros_ec_commands.h has landed
>>> in a immutable branch:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git branch
>>> ib-mfd-cros-5.3.
>>>  
>>
>> Jonathan, if you don't want to deal with the big patchset that this
>> depends and the immutable branch, I can pick the patch and can go
>> through the chrome-platform tree. I think it is unlikely have merge
>> conflicts, as these patches only touch cros-ec iio parts and, anyway,
>> I'll need to deal with the immutable branch because other patches also
>> depends on the ib.
> 
> That would be great thanks.
> 

Ok, applied for 5.3 via chrome-platform tree

Thanks,
~ Enric

> I'll almost always take the option that involves me doing less work ;)
> 
> Jonathan
> 
>>
>> Thanks,
>> ~ Enric
>>
>>> Thanks,
>>> Gwendal.
>>>
>>>  
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>>  
>>>>> ---
>>>>> Changes in v7:
>>>>> - Split patch in two: This is the IIO section.
>>>>>
>>>>> Changes in v6:
>>>>> - Fix lock held in an error path error.
>>>>>
>>>>> Changes in v5:
>>>>> - Remove unnecessary define.
>>>>> - v4 was the wrong patch file
>>>>>
>>>>> Changes in v3:
>>>>> - Use static channel array, simplify code because index is always 0.
>>>>>
>>>>> Changes in v2:
>>>>> - Fix license, remove driver_module field.
>>>>>
>>>>>  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
>>>>>  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
>>>>>  .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
>>>>>  3 files changed, 149 insertions(+)
>>>>>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
>>>>>
>>>>> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
>>>>> index 135f6825903f..aacc2ab9c34f 100644
>>>>> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
>>>>> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
>>>>> @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
>>>>>         Accelerometers, Gyroscope and Magnetometer that are
>>>>>         presented by the ChromeOS EC Sensor hub.
>>>>>         Creates an IIO device for each functions.
>>>>> +
>>>>> +config IIO_CROS_EC_SENSORS_LID_ANGLE
>>>>> +     tristate "ChromeOS EC Sensor for lid angle"
>>>>> +     depends on IIO_CROS_EC_SENSORS_CORE
>>>>> +     help
>>>>> +       Module to report the angle between lid and base for some
>>>>> +       convertible devices.
>>>>> +       This module is loaded when the EC can calculate the angle between the base
>>>>> +       and the lid.
>>>>> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
>>>>> index ec716ff2a775..a35ee232ac07 100644
>>>>> --- a/drivers/iio/common/cros_ec_sensors/Makefile
>>>>> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
>>>>> @@ -4,3 +4,4 @@
>>>>>
>>>>>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
>>>>>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
>>>>> +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
>>>>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
>>>>> new file mode 100644
>>>>> index 000000000000..876dfd176b0e
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
>>>>> @@ -0,0 +1,139 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +/*
>>>>> + * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
>>>>> + *
>>>>> + * Copyright 2018 Google, Inc
>>>>> + *
>>>>> + * This driver uses the cros-ec interface to communicate with the Chrome OS
>>>>> + * EC about counter sensors. Counters are presented through
>>>>> + * iio sysfs.
>>>>> + */
>>>>> +
>>>>> +#include <linux/delay.h>
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/iio/buffer.h>
>>>>> +#include <linux/iio/common/cros_ec_sensors_core.h>
>>>>> +#include <linux/iio/iio.h>
>>>>> +#include <linux/iio/kfifo_buf.h>
>>>>> +#include <linux/iio/trigger.h>
>>>>> +#include <linux/iio/triggered_buffer.h>
>>>>> +#include <linux/iio/trigger_consumer.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/mfd/cros_ec.h>
>>>>> +#include <linux/mfd/cros_ec_commands.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +#define DRV_NAME "cros-ec-lid-angle"
>>>>> +
>>>>> +/*
>>>>> + * One channel for the lid angle, the other for timestamp.
>>>>> + */
>>>>> +static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
>>>>> +     {
>>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>> +             .scan_type.realbits = CROS_EC_SENSOR_BITS,
>>>>> +             .scan_type.storagebits = CROS_EC_SENSOR_BITS,
>>>>> +             .scan_type.sign = 'u',
>>>>> +             .type = IIO_ANGL
>>>>> +     },
>>>>> +     IIO_CHAN_SOFT_TIMESTAMP(1)
>>>>> +};
>>>>> +
>>>>> +/* State data for ec_sensors iio driver. */
>>>>> +struct cros_ec_lid_angle_state {
>>>>> +     /* Shared by all sensors */
>>>>> +     struct cros_ec_sensors_core_state core;
>>>>> +};
>>>>> +
>>>>> +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
>>>>> +                                       unsigned long scan_mask, s16 *data)
>>>>> +{
>>>>> +     struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>>>>> +     int ret;
>>>>> +
>>>>> +     st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
>>>>> +     ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
>>>>> +     if (ret) {
>>>>> +             dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
>>>>> +             return ret;
>>>>> +     }
>>>>> +
>>>>> +     *data = st->resp->lid_angle.value;
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
>>>>> +                                 struct iio_chan_spec const *chan,
>>>>> +                                 int *val, int *val2, long mask)
>>>>> +{
>>>>> +     struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
>>>>> +     s16 data;
>>>>> +     int ret;
>>>>> +
>>>>> +     mutex_lock(&st->core.cmd_lock);
>>>>> +     ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
>>>>> +     if (ret == 0) {
>>>>> +             *val = data;
>>>>> +             ret = IIO_VAL_INT;
>>>>> +     }
>>>>> +     mutex_unlock(&st->core.cmd_lock);
>>>>> +     return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct iio_info cros_ec_lid_angle_info = {
>>>>> +     .read_raw = &cros_ec_lid_angle_read,
>>>>> +};
>>>>> +
>>>>> +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +     struct device *dev = &pdev->dev;
>>>>> +     struct iio_dev *indio_dev;
>>>>> +     struct cros_ec_lid_angle_state *state;
>>>>> +     int ret;
>>>>> +
>>>>> +     indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>>>>> +     if (!indio_dev)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     indio_dev->info = &cros_ec_lid_angle_info;
>>>>> +     state = iio_priv(indio_dev);
>>>>> +     indio_dev->channels = cros_ec_lid_angle_channels;
>>>>> +     indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
>>>>> +
>>>>> +     state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
>>>>> +
>>>>> +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>>>>> +                     cros_ec_sensors_capture, NULL);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     return devm_iio_device_register(dev, indio_dev);
>>>>> +}
>>>>> +
>>>>> +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
>>>>> +     {
>>>>> +             .name = DRV_NAME,
>>>>> +     },
>>>>> +     { /* sentinel */ }
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
>>>>> +
>>>>> +static struct platform_driver cros_ec_lid_angle_platform_driver = {
>>>>> +     .driver = {
>>>>> +             .name   = DRV_NAME,
>>>>> +             .pm     = &cros_ec_sensors_pm_ops,
>>>>> +     },
>>>>> +     .probe          = cros_ec_lid_angle_probe,
>>>>> +     .id_table       = cros_ec_lid_angle_ids,
>>>>> +};
>>>>> +module_platform_driver(cros_ec_lid_angle_platform_driver);
>>>>> +
>>>>> +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
>>>>> +MODULE_LICENSE("GPL v2");  
>>>>  
> 
> 
