Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E74C3175
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfJAKcD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 06:32:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38760 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAKcD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 06:32:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8896D28E304
Subject: Re: [PATCH 02/13] platform: cros_ec: Add cros_ec_sensor_hub driver
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20190922175021.53449-1-gwendal@chromium.org>
 <20190922175021.53449-3-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5448d9a0-aac8-07f4-4b32-9c4200255675@collabora.com>
Date:   Tue, 1 Oct 2019 12:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190922175021.53449-3-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Some comments below.

On 22/9/19 19:50, Gwendal Grignou wrote:
> Similar to HID sensor stack, the new driver sits between cros_ec_dev
> and the iio device drivers:
> 
> EC based iio device topology would be:
> iio:device1 ->
> ...0/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.6.auto/
>                                          cros-ec-sensorhub.7.auto/
>                                          cros-ec-accel.15.auto/
>                                          iio:device1
> 
> It will be expanded to control EC sensor FIFO.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
>  drivers/platform/chrome/Kconfig               |  18 +-
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 211 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_sensorhub.h   |  21 ++
>  5 files changed, 249 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
>  create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> index cdbb29cfb907..fefad9572790 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config IIO_CROS_EC_SENSORS_CORE
>  	tristate "ChromeOS EC Sensors Core"
> -	depends on SYSFS && CROS_EC
> +	depends on SYSFS && CROS_EC_SENSORHUB
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index ee5f08ea57b6..add967236cfb 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -132,9 +132,9 @@ config CROS_EC_LPC
>  	  module will be called cros_ec_lpcs.
>  
>  config CROS_EC_PROTO
> -        bool
> -        help
> -          ChromeOS EC communication protocol helpers.
> +	bool
> +	help
> +	  ChromeOS EC communication protocol helpers.
>  

That change is unrelated to the patch.

>  config CROS_KBD_LED_BACKLIGHT
>  	tristate "Backlight LED support for Chrome OS keyboards"
> @@ -190,6 +190,18 @@ config CROS_EC_DEBUGFS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_debugfs.
>  
> +config CROS_EC_SENSORHUB
> +	tristate "ChromeOS EC MEMS Senosr Hub"

Typo: s/Senosr/Sensor/

> +	depends on CROS_EC && IIO
> +	help
> +	  Allow loading IIO sensors. This driver is loaded by MFD and will in
> +	  turn query the EC and register the sensors.
> +	  It also spreads the sensor data coming from the EC to the IIO sensorr

Typo : s/sensorr/Sensor

> +	  object.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_sensorhub.
> +
>  config CROS_EC_SYSFS
>  	tristate "ChromeOS EC control and information through sysfs"
>  	depends on MFD_CROS_EC_DEV && SYSFS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 477ec3d1d1c9..a164c40dc099 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
>  obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
>  obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
> +obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
>  obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> new file mode 100644
> index 000000000000..80688018ef66
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SensorHub: driver that discover sensors behind
> + * a ChromeOS Embedded controller.
> + *
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/poll.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/platform_data/cros_ec_sensorhub.h>
> +
> +#define DRV_NAME		"cros-ec-sensorhub"
> +
> +static int cros_ec_sensors_register(struct device *dev,
> +		struct cros_ec_dev *ec)
> +{
> +	int ret, i, id, sensor_num;
> +	struct mfd_cell *sensor_cells;
> +	struct cros_ec_sensor_platform *sensor_platforms;
> +	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
> +	struct ec_params_motion_sense *params;
> +	struct ec_response_motion_sense *resp;
> +	struct cros_ec_command *msg;
> +
> +	sensor_num = cros_ec_get_sensor_count(ec);
> +	if (sensor_num < 0) {
> +		dev_err(dev,
> +			"Unable to retrieve sensor information (err:%d)\n",
> +			sensor_num);
> +		return sensor_num;
> +	}
> +
> +	if (sensor_num == 0) {
> +		dev_err(dev, "Zero sensors reported.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Build an array of sensors driver and register them all.
> +	 */
> +	msg = kzalloc(sizeof(struct cros_ec_command) +
> +		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> +	if (msg == NULL) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	msg->version = 1;
> +	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> +	msg->outsize = sizeof(*params);
> +	msg->insize = sizeof(*resp);
> +	params = (struct ec_params_motion_sense *)msg->data;
> +	resp = (struct ec_response_motion_sense *)msg->data;
> +
> +	/*
> +	 * Allocate 1 extra sensor if lid angle sensor is needed.
> +	 */
> +	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> +			       GFP_KERNEL);
> +	if (sensor_cells == NULL) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	sensor_platforms = kcalloc(sensor_num,
> +				   sizeof(struct cros_ec_sensor_platform),
> +				   GFP_KERNEL);
> +	if (sensor_platforms == NULL) {
> +		ret = -ENOMEM;
> +		goto error_platforms;
> +	}
> +
> +	id = 0;
> +	for (i = 0; i < sensor_num; i++) {
> +		params->cmd = MOTIONSENSE_CMD_INFO;
> +		params->info.sensor_num = i;
> +		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +		if (ret < 0) {
> +			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
> +				 i, ret, msg->result);
> +			continue;
> +		}
> +		switch (resp->info.type) {
> +		case MOTIONSENSE_TYPE_ACCEL:
> +			sensor_cells[id].name = "cros-ec-accel";
> +			break;
> +		case MOTIONSENSE_TYPE_BARO:
> +			sensor_cells[id].name = "cros-ec-baro";
> +			break;
> +		case MOTIONSENSE_TYPE_GYRO:
> +			sensor_cells[id].name = "cros-ec-gyro";
> +			break;
> +		case MOTIONSENSE_TYPE_MAG:
> +			sensor_cells[id].name = "cros-ec-mag";
> +			break;
> +		case MOTIONSENSE_TYPE_PROX:
> +			sensor_cells[id].name = "cros-ec-prox";
> +			break;
> +		case MOTIONSENSE_TYPE_LIGHT:
> +			sensor_cells[id].name = "cros-ec-light";
> +			break;
> +		case MOTIONSENSE_TYPE_ACTIVITY:
> +			sensor_cells[id].name = "cros-ec-activity";
> +			break;
> +		default:
> +			dev_warn(dev, "unknown type %d\n", resp->info.type);
> +			continue;
> +		}
> +		sensor_platforms[id].sensor_num = i;
> +		sensor_cells[id].platform_data = &sensor_platforms[id];
> +		sensor_cells[id].pdata_size =
> +			sizeof(struct cros_ec_sensor_platform);
> +
> +		sensor_type[resp->info.type]++;
> +		id++;
> +	}
> +
> +	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
> +		ec->has_kb_wake_angle = true;
> +
> +	if (cros_ec_check_features(ec,
> +				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> +		sensor_cells[id].name = "cros-ec-lid-angle";
> +		id++;
> +	}
> +
> +	ret = mfd_add_hotplug_devices(dev, sensor_cells, id);

That's problematic.

In general using mfd_* in a !MFD driver is considered a hack. I know that the
Intel Sensor Hub and few other drivers does this but it's not correct and I know
Lee won't be happy with this change.

I think we should be using the platform_device_add() API here.

Thanks,
 Enric

> +	kfree(sensor_platforms);
> +error_platforms:
> +	kfree(sensor_cells);
> +error:
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static struct cros_ec_sensor_platform sensor_platforms[] = {
> +	{ .sensor_num = 0 },
> +	{ .sensor_num = 1 }
> +};
> +
> +static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
> +	{
> +		.name = "cros-ec-accel-legacy",
> +		.platform_data = &sensor_platforms[0],
> +		.pdata_size = sizeof(struct cros_ec_sensor_platform),
> +	},
> +	{
> +		.name = "cros-ec-accel-legacy",
> +		.platform_data = &sensor_platforms[1],
> +		.pdata_size = sizeof(struct cros_ec_sensor_platform),
> +	}
> +};
> +
> +
> +
> +static int cros_ec_sensorhub_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
> +	int ret;
> +	struct cros_ec_sensorhub *data =
> +		kzalloc(sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
> +
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ec = ec;
> +	dev_set_drvdata(dev, data);
> +
> +	/* check whether this EC is a sensor hub. */
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
> +		ret = cros_ec_sensors_register(dev, ec);
> +	} else {
> +		/* Workaroud for older EC firmware */
> +		ret = mfd_add_hotplug_devices(dev,
> +				cros_ec_accel_legacy_cells,
> +				ARRAY_SIZE(cros_ec_accel_legacy_cells));
> +	}
> +	if (ret)
> +		dev_err(dev, "failed to add EC sensors: error %d\n", ret);
> +	return ret;
> +}
> +
> +static struct platform_driver cros_ec_sensorhub_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +	.probe = cros_ec_sensorhub_probe,
> +};
> +
> +module_platform_driver(cros_ec_sensorhub_driver);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
> +MODULE_DESCRIPTION("ChromeOS EC MEMS Sensor Hub Driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> new file mode 100644
> index 000000000000..a8b64ecf5b9b
> --- /dev/null
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * cros_ec_sensorhub- Chrome OS EC MEMS Sensor Hub driver.
> + *
> + * Copyright (C) 2019 Google, Inc
> + *
> + */
> +
> +#ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
> +#define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
> +
> +#include <linux/platform_data/cros_ec_commands.h>
> +
> +/**
> + * struct cros_ec_sensorhub - Sensor Hub device data.
> + */
> +struct cros_ec_sensorhub {
> +	struct cros_ec_dev *ec;
> +};
> +
> +#endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
> 
