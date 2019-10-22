Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D7DFF75
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 10:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfJVIcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 04:32:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbfJVIcs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 04:32:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E420F28CF33
Subject: Re: [PATCH v2 03/18] platform: cros_ec: Add cros_ec_sensor_hub driver
To:     Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Nick Crews <ncrews@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
 <20191021055403.67849-4-gwendal@chromium.org>
 <20191021165911.22011c08@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <44ff8e33-3300-4753-ea40-fa26d21cdd46@collabora.com>
Date:   Tue, 22 Oct 2019 10:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021165911.22011c08@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Complementing the Jonathan's review, few bits more.

On 21/10/19 17:59, Jonathan Cameron wrote:
> On Sun, 20 Oct 2019 22:53:48 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
>> Similar to HID sensor stack, the new driver sits between cros_ec_dev
>> and the iio device drivers:
>>
>> EC based iio device topology would be:
>> iio:device1 ->
>> ...0/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.6.auto/
>>                                          cros-ec-sensorhub.7.auto/
>>                                          cros-ec-accel.15.auto/
>>                                          iio:device1
>>
>> It will be expanded to control EC sensor FIFO.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> 
> A few bits and pieces inline.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> ---
>> Changes in v2:
>> - Remove unerelated changes.
>> - Fix spelling.
>> - Use !x instead of x == NULL
>> - Use platform_ API directly to register IIO sensors from
>>   cros_ec_sensorhub.
>>
>>  drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
>>  drivers/platform/chrome/Kconfig               |  12 ++
>>  drivers/platform/chrome/Makefile              |   1 +
>>  drivers/platform/chrome/cros_ec_sensorhub.c   | 202 ++++++++++++++++++
>>  .../linux/platform_data/cros_ec_sensorhub.h   |  21 ++
>>  5 files changed, 237 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
>>  create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
>> index cdbb29cfb9076..fefad95727907 100644
>> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
>> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
>> @@ -4,7 +4,7 @@
>>  #
>>  config IIO_CROS_EC_SENSORS_CORE
>>  	tristate "ChromeOS EC Sensors Core"
>> -	depends on SYSFS && CROS_EC
>> +	depends on SYSFS && CROS_EC_SENSORHUB
>>  	select IIO_BUFFER
>>  	select IIO_TRIGGERED_BUFFER
>>  	help
>> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
>> index ee5f08ea57b6c..56a25317a6bee 100644
>> --- a/drivers/platform/chrome/Kconfig
>> +++ b/drivers/platform/chrome/Kconfig
>> @@ -190,6 +190,18 @@ config CROS_EC_DEBUGFS
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called cros_ec_debugfs.
>>  
>> +config CROS_EC_SENSORHUB
>> +	tristate "ChromeOS EC MEMS Sensor Hub"
>> +	depends on CROS_EC && IIO
>> +	help
>> +	  Allow loading IIO sensors. This driver is loaded by MFD and will in
>> +	  turn query the EC and register the sensors.
>> +	  It also spreads the sensor data coming from the EC to the IIO sensor
>> +	  object.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called cros_ec_sensorhub.
>> +
>>  config CROS_EC_SYSFS
>>  	tristate "ChromeOS EC control and information through sysfs"
>>  	depends on MFD_CROS_EC_DEV && SYSFS
>> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
>> index 477ec3d1d1c98..a164c40dc0996 100644
>> --- a/drivers/platform/chrome/Makefile
>> +++ b/drivers/platform/chrome/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
>>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
>>  obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
>>  obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
>> +obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
>>  obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
>>  obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
>>  obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
>> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
>> new file mode 100644
>> index 0000000000000..5fea4c28c5c95
>> --- /dev/null
>> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
>> @@ -0,0 +1,202 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SensorHub: driver that discover sensors behind
>> + * a ChromeOS Embedded controller.
>> + *
>> + * Copyright 2019 Google LLC
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/fs.h>
>> +#include <linux/miscdevice.h>

The two includes above are not needed.

>> +#include <linux/module.h>
>> +#include <linux/mfd/cros_ec.h>
>> +#include <linux/platform_data/cros_ec_commands.h>
>> +#include <linux/platform_data/cros_ec_proto.h>
>> +#include <linux/platform_device.h>

>> +#include <linux/poll.h>

Not needed.

>> +#include <linux/slab.h>

>> +#include <linux/types.h>
>> +#include <linux/uaccess.h>

Also, these two are not needed.

>> +
>> +#include <linux/platform_data/cros_ec_sensorhub.h>
>> +
>> +#define DRV_NAME		"cros-ec-sensorhub"
>> +
>> +

Please don't use multiple blank lines

For new files introduced in chrome/platform I'd like if you can fix the issues
reported by checkpatch with the --strict option for v3. I'm not going to report
these issues below (also, is my preference but optional)

>> +static struct device_type cros_ec_sensorhub_dev_type = {
>> +	.name	= "cros_ec_iio_sensor",
>> +};
>> +
>> +static int cros_ec_sensorhub_allocate_single_sensor(
>> +		struct device *parent,
>> +		char *sensor_name,
>> +		int sensor_num)
>> +{
>> +	struct platform_device *pdev;
>> +	struct cros_ec_sensor_platform sensor_platforms = {
>> +		.sensor_num = sensor_num,
>> +	};
>> +	int ret;
>> +
>> +	pdev = platform_device_alloc(sensor_name, PLATFORM_DEVID_AUTO);
>> +	if (!pdev)
>> +		return -ENOMEM;
>> +
>> +	pdev->dev.parent = parent;
>> +	pdev->dev.type = &cros_ec_sensorhub_dev_type;
>> +
>> +	ret = platform_device_add_data(pdev, &sensor_platforms,
>> +			sizeof(sensor_platforms));
>> +	if (ret)
>> +		goto fail_device;
>> +
>> +	ret = platform_device_add(pdev);
>> +	if (ret)
>> +		goto fail_device;
>> +
>> +	return 0;
>> +
>> +fail_device:
>> +	platform_device_put(pdev);
>> +	return ret;

Instead of doing alloc, add_data, device_add, can we just do a single step with
platform_device_register_data ? Similar to what we did in
drivers/platform/chrome/wilco_ec/core.c should work I guess (cc'ing Nick)

Also, we need to store the created devices and free on remove. I think this is
not implemented.


>> +}
>> +
>> +static int cros_ec_sensorhub_register(struct device *dev,
>> +		struct cros_ec_dev *ec)
>> +{
>> +	int ret, i, id, sensor_num;
>> +	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
>> +	struct ec_params_motion_sense *params;
>> +	struct ec_response_motion_sense *resp;
>> +	struct cros_ec_command *msg;
>> +	char *name;
>> +
>> +	sensor_num = cros_ec_get_sensor_count(ec);
>> +	if (sensor_num < 0) {
>> +		dev_err(dev,
>> +			"Unable to retrieve sensor information (err:%d)\n",
>> +			sensor_num);
>> +		return sensor_num;
>> +	}
>> +
>> +	if (sensor_num == 0) {
>> +		dev_err(dev, "Zero sensors reported.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Prepare a message to send INFO command to each sensor. */
>> +	msg = kzalloc(sizeof(struct cros_ec_command) +
>> +		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
>> +	if (!msg) {
>> +		ret = -ENOMEM;
>> +		goto error;
> 
> If you get here, the kzalloc failed, so there is nothing to free.
> Hence should just be a return -ENOMEM I think.
> 
>> +	}
>> +
>> +	msg->version = 1;
>> +	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>> +	msg->outsize = sizeof(*params);
>> +	msg->insize = sizeof(*resp);
>> +	params = (struct ec_params_motion_sense *)msg->data;
>> +	resp = (struct ec_response_motion_sense *)msg->data;
>> +
>> +	id = 0;
>> +	for (i = 0; i < sensor_num; i++) {
>> +		params->cmd = MOTIONSENSE_CMD_INFO;
>> +		params->info.sensor_num = i;
>> +		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>> +		if (ret < 0) {
>> +			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
>> +				 i, ret, msg->result);
>> +			continue;
>> +		}
>> +		switch (resp->info.type) {
>> +		case MOTIONSENSE_TYPE_ACCEL:
>> +			name = "cros-ec-accel";
>> +			break;
>> +		case MOTIONSENSE_TYPE_BARO:
>> +			name = "cros-ec-baro";
>> +			break;
>> +		case MOTIONSENSE_TYPE_GYRO:
>> +			name = "cros-ec-gyro";
>> +			break;
>> +		case MOTIONSENSE_TYPE_MAG:
>> +			name = "cros-ec-mag";
>> +			break;
>> +		case MOTIONSENSE_TYPE_PROX:
>> +			name = "cros-ec-prox";
>> +			break;
>> +		case MOTIONSENSE_TYPE_LIGHT:
>> +			name = "cros-ec-light";
>> +			break;
>> +		case MOTIONSENSE_TYPE_ACTIVITY:
>> +			name = "cros-ec-activity";
>> +			break;
>> +		default:
>> +			dev_warn(dev, "unknown type %d\n", resp->info.type);
>> +			continue;
>> +		}
>> +		ret = cros_ec_sensorhub_allocate_single_sensor(dev, name, i);
>> +		if (ret)
>> +			goto error;
>> +
>> +		sensor_type[resp->info.type]++;
>> +	}
>> +
>> +	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
>> +		ec->has_kb_wake_angle = true;
>> +
>> +	if (cros_ec_check_features(ec,
>> +				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
>> +		ret = cros_ec_sensorhub_allocate_single_sensor(
>> +				dev, "cros-ec-lid-angle", 0);
>> +	}
>> +
>> +error:
>> +	kfree(msg);
>> +	return ret;
>> +}
>> +
>> +static int cros_ec_sensorhub_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
>> +	int ret;
>> +	struct cros_ec_sensorhub *data =
>> +		kzalloc(sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
>> +
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->ec = ec;
>> +	dev_set_drvdata(dev, data);
> 
> Superficially this doesn't seem to be used.
> 
>> +
>> +	/* Check whether this EC is a sensor hub. */
>> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
>> +		ret = cros_ec_sensorhub_register(dev, ec);
>> +	} else {
>> +		ret = cros_ec_sensorhub_allocate_single_sensor(
>> +				dev, "cros-ec-accel-legacy", 0);
>> +		ret |= cros_ec_sensorhub_allocate_single_sensor(
>> +				dev, "cros-ec-accel-legacy", 1);
> 
> Doing an |= with a return value is a good way to get some really
> odd bugs in the future.  Please report only the first error and
> cleanly.  If the first one failed we are going to fail to probe
> anyway so don't call the second.
> 
> 
>> +	}
>> +	if (ret)
>> +		dev_err(dev, "failed to add EC sensors: error %d\n", ret);
> 
> Is this particular error useful?  I'd be more tempted to report
> and error for each of the two types of registration above with
> more information on what actually failed.
> 
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver cros_ec_sensorhub_driver = {
>> +	.driver = {
>> +		.name = DRV_NAME,
>> +	},
>> +	.probe = cros_ec_sensorhub_probe,

        .remove?

>> +};
>> +
>> +module_platform_driver(cros_ec_sensorhub_driver);
>> +
>> +MODULE_ALIAS("platform:" DRV_NAME);
>> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
>> +MODULE_DESCRIPTION("ChromeOS EC MEMS Sensor Hub Driver");
>> +MODULE_LICENSE("GPL");
>> +
>> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
>> new file mode 100644
>> index 0000000000000..7737685591ad3
>> --- /dev/null
>> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * cros_ec_sensorhub- Chrome OS EC MEMS Sensor Hub driver.

Remove the cros_ec_sensorhub prefix. If for some weird reason the file changes
his name is easy to forget to update the 'cros_ec_sensorhub-' text. So just
remove as doesn't really apport anything.

>> + *
>> + * Copyright (C) 2019 Google, Inc

I think that actually current copyright used by Google is
   'Copyright 2019 Google LLC'

>> + */
>> +
>> +#ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>> +#define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>> +
>> +#include <linux/platform_data/cros_ec_commands.h>
>> +
>> +/*
>> + * struct cros_ec_sensorhub - Sensor Hub device data.
>> + */

Can we document this in kernel-doc format?

>> +struct cros_ec_sensorhub {
>> +	/* Embedded Controller where the hub is located. */
>> +	struct cros_ec_dev *ec;
>> +};
>> +
>> +#endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
> 
