Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF3CCAF4
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfJEQIu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 12:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfJEQIu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 12:08:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464A0222C0;
        Sat,  5 Oct 2019 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570291727;
        bh=X4NVAOzJ7CnbDplyj46f7u4PXRdeW/SCzScsg8vGMUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oqqSMlfUpFNUCAfgUeMX+WrTNIY50dnNTFGwHcMx/0tK8cqsTy54FnYBDAU/ecMz6
         4RfDtw4qE/6ydBFgEkBE9lz8aTrmyxtyxSSTKfZZpfcgg7d8nuJ4stUbbZSHAifAwN
         QMLVqtPcvk5MPbyHB/ojEjASw14Dw5Ea5ht9x934=
Date:   Sat, 5 Oct 2019 17:08:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/13] platform: chrome: sensorhub: Add FIFO support
Message-ID: <20191005170841.043abb85@archlinux>
In-Reply-To: <20190922175021.53449-8-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-8-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:15 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> cros_ec_sensorhub registers a listener and query motion sense FIFO,
> spread to iio sensors registers.
> 
> To test, we can use libiio:
> iiod&
> iio_readdev -u ip:localhost -T 10000 -s 25 -b 16 cros-ec-gyro | od -x
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
I haven't fully gotten my head around this but it looks more or less correct
to me.  I'm in a fussy mode though so various nitpicks inline.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c      |   1 +
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   1 +
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  13 +
>  drivers/iio/light/cros_ec_light_prox.c        |   1 +
>  drivers/iio/pressure/cros_ec_baro.c           |   1 +
>  drivers/platform/chrome/Makefile              |   3 +-
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 130 ++++--
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 374 ++++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   |   3 +
>  .../linux/platform_data/cros_ec_sensorhub.h   |  79 ++++
>  10 files changed, 569 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index c9af6fa0670d..591c0d962c44 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -212,6 +212,7 @@ static struct platform_driver cros_ec_accel_platform_driver = {
>  		.name	= DRV_NAME,
>  	},
>  	.probe		= cros_ec_accel_legacy_probe,
> +	.remove		= cros_ec_sensors_core_clean,
>  };
>  module_platform_driver(cros_ec_accel_platform_driver);
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 5bd6f54afc42..a88dd8deade9 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -329,6 +329,7 @@ static struct platform_driver cros_ec_sensors_platform_driver = {
>  		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_sensors_probe,
> +	.remove		= cros_ec_sensors_core_clean,
>  	.id_table	= cros_ec_sensors_ids,
>  };
>  module_platform_driver(cros_ec_sensors_platform_driver);
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 81a7f692de2f..43eb1d42820e 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -160,6 +160,19 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
>  
> +int cros_ec_sensors_core_clean(struct platform_device *pdev)
> +{
> +	struct cros_ec_sensorhub *sensor_hub =
> +		dev_get_drvdata(pdev->dev.parent);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	u8 sensor_num = st->param.info.sensor_num;
> +
> +	cros_ec_sensorhub_unregister_push_data(sensor_hub, sensor_num);

blank line here.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_core_clean);
> +
>  int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  				 u16 opt_length)
>  {
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 205effc1f404..c431e4d1482d 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -270,6 +270,7 @@ static struct platform_driver cros_ec_light_prox_platform_driver = {
>  		.pm	= &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		= cros_ec_light_prox_probe,
> +	.remove		= cros_ec_sensors_core_clean,
>  	.id_table	= cros_ec_light_prox_ids,
>  };
>  module_platform_driver(cros_ec_light_prox_platform_driver);
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 2354302375de..2f4d6d3ab41d 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -201,6 +201,7 @@ static struct platform_driver cros_ec_baro_platform_driver = {
>  		.name	= "cros-ec-baro",
>  	},
>  	.probe		= cros_ec_baro_probe,
> +	.remove		= cros_ec_sensors_core_clean,
>  	.id_table	= cros_ec_baro_ids,
>  };
>  module_platform_driver(cros_ec_baro_platform_driver);
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index a164c40dc099..cb709048c003 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -17,7 +17,8 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
>  obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
>  obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
> -obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
> +cros_ec_sensorsupport-objs			:= cros_ec_sensorhub_ring.o cros_ec_sensorhub.o
> +obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorsupport.o
>  obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> index 01f11ed611fb..cf93120719c4 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -26,15 +26,14 @@
>  #define DRV_NAME		"cros-ec-sensorhub"
>  
>  static int cros_ec_sensors_register(struct device *dev,
> -		struct cros_ec_dev *ec)
> +		struct cros_ec_sensorhub *sensorhub)
>  {
>  	int ret, i, id, sensor_num;
>  	struct mfd_cell *sensor_cells;
>  	struct cros_ec_sensor_platform *sensor_platforms;
>  	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
> -	struct ec_params_motion_sense *params;
> -	struct ec_response_motion_sense *resp;
> -	struct cros_ec_command *msg;
> +	struct cros_ec_command *msg = sensorhub->msg;
> +	struct cros_ec_dev *ec = sensorhub->ec;
>  
>  	sensor_num = cros_ec_get_sensor_count(ec);
>  	if (sensor_num < 0) {
> @@ -49,32 +48,17 @@ static int cros_ec_sensors_register(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	/*
> -	 * Build an array of sensors driver and register them all.
> -	 */
> -	msg = kzalloc(sizeof(struct cros_ec_command) +
> -		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> -	if (msg == NULL) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -
>  	msg->version = 1;
> -	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> -	msg->outsize = sizeof(*params);
> -	msg->insize = sizeof(*resp);
> -	params = (struct ec_params_motion_sense *)msg->data;
> -	resp = (struct ec_response_motion_sense *)msg->data;
> +	msg->insize = sizeof(struct ec_response_motion_sense);
> +	msg->outsize = sizeof(struct ec_params_motion_sense);
>  
>  	/*
>  	 * Allocate 1 extra sensor if lid angle sensor is needed.
>  	 */
>  	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
>  			       GFP_KERNEL);
> -	if (sensor_cells == NULL) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> +	if (sensor_cells == NULL)
> +		return -ENOMEM;
>  
>  	sensor_platforms = kcalloc(sensor_num,
>  				   sizeof(struct cros_ec_sensor_platform),
> @@ -86,15 +70,15 @@ static int cros_ec_sensors_register(struct device *dev,
>  
>  	id = 0;
>  	for (i = 0; i < sensor_num; i++) {
> -		params->cmd = MOTIONSENSE_CMD_INFO;
> -		params->info.sensor_num = i;
> +		sensorhub->params->cmd = MOTIONSENSE_CMD_INFO;
> +		sensorhub->params->info.sensor_num = i;
>  		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>  		if (ret < 0) {
>  			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
>  				 i, ret, msg->result);
>  			continue;
>  		}
> -		switch (resp->info.type) {
> +		switch (sensorhub->resp->info.type) {
>  		case MOTIONSENSE_TYPE_ACCEL:
>  			sensor_cells[id].name = "cros-ec-accel";
>  			break;
> @@ -117,7 +101,8 @@ static int cros_ec_sensors_register(struct device *dev,
>  			sensor_cells[id].name = "cros-ec-activity";
>  			break;
>  		default:
> -			dev_warn(dev, "unknown type %d\n", resp->info.type);
> +			dev_warn(dev, "unknown type %d\n",
> +				 sensorhub->resp->info.type);
>  			continue;
>  		}
>  		sensor_platforms[id].sensor_num = i;
> @@ -125,7 +110,7 @@ static int cros_ec_sensors_register(struct device *dev,
>  		sensor_cells[id].pdata_size =
>  			sizeof(struct cros_ec_sensor_platform);
>  
> -		sensor_type[resp->info.type]++;
> +		sensor_type[sensorhub->resp->info.type]++;
>  		id++;
>  	}
>  
> @@ -142,8 +127,6 @@ static int cros_ec_sensors_register(struct device *dev,
>  	kfree(sensor_platforms);
>  error_platforms:
>  	kfree(sensor_cells);
> -error:
> -	kfree(msg);
>  	return ret;
>  }
>  
> @@ -165,41 +148,116 @@ static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
>  	}
>  };
>  
> -
> -
>  static int cros_ec_sensorhub_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
>  	int ret;
> -	struct cros_ec_sensorhub *data =
> -		kzalloc(sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
> +	struct cros_ec_sensorhub *data;
> +	struct cros_ec_command *msg;
> +
> +	msg = devm_kzalloc(dev, sizeof(struct cros_ec_command) +
> +			max((u16)sizeof(struct ec_params_motion_sense),
> +			    ec->ec_dev->max_response), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>  
> +	data = devm_kzalloc(dev, sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> +	data->dev = dev;
>  	data->ec = ec;
> +
> +	mutex_init(&data->cmd_lock);
> +	data->msg = msg;
> +	data->params = (struct ec_params_motion_sense *)msg->data;
> +	data->resp = (struct ec_response_motion_sense *)msg->data;
> +
>  	dev_set_drvdata(dev, data);
>  
>  	/* Check whether this EC is a sensor hub. */
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
> -		ret = cros_ec_sensors_register(dev, ec);
> +		ret = cros_ec_sensors_register(dev, data);
>  	} else {
>  		/* Workaroud for older EC firmware */
> +		ec->has_kb_wake_angle = true;
>  		ret = mfd_add_hotplug_devices(dev,
>  				cros_ec_accel_legacy_cells,
>  				ARRAY_SIZE(cros_ec_accel_legacy_cells));
>  	}
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "failed to add EC sensors: error %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * If the EC does not have a FIFO, the sensors will query their data
> +	 * themselves via sysfs or a software trigger.
> +	 */
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> +		ret = cros_ec_sensorhub_ring_add(data);
> +		/*
> +		 * The msg and its data is not under the control of the ring
> +		 * handler.
> +		 */
> +	}
>  	return ret;
>  }
>  
> +static int cros_ec_sensorhub_remove(struct platform_device *pdev)
> +{
> +	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
> +		cros_ec_sensorhub_ring_remove(sensorhub);
> +	return 0;
> +}
> +
> +/*
> + * When the EC is suspending, we must stop sending interrupt,
> + * we may use the same interrupt line for waking up the device.
> + * Tell the EC to stop sending non-interrupt event on the iio ring.
> + */
> +static int __maybe_unused cros_ec_ring_prepare(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
> +		return cros_ec_sensorhub_ring_fifo_toggle(sensorhub, false);
> +	return 0;
> +}
> +
> +static void __maybe_unused cros_ec_ring_complete(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
> +		cros_ec_sensorhub_ring_fifo_toggle(sensorhub, true);
> +}
> +
> +#if CONFIG_PM_SLEEP
> +static const struct dev_pm_ops cros_ec_sensorhub_ring_pm_ops = {
> +	.prepare = cros_ec_ring_prepare,
> +	.complete = cros_ec_ring_complete
> +};
> +#else
> +static const struct dev_pm_ops cros_ec_sensorhub_ring_pm_ops = { };
> +#endif
> +
>  static struct platform_driver cros_ec_sensorhub_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
> +		.pm = &cros_ec_sensorhub_ring_pm_ops,
>  	},
>  	.probe = cros_ec_sensorhub_probe,
> +	.remove = cros_ec_sensorhub_remove,
>  };
>  
>  module_platform_driver(cros_ec_sensorhub_driver);
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> new file mode 100644
> index 000000000000..8cd533d5542e
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cros_ec_sensorhub_ring - Driver for Chrome OS EC Sensor hub FIFO.
> + *
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
> +#include <linux/platform_device.h>
> +#include <linux/sort.h>
> +#include <linux/slab.h>
> +

One blank line almost always enough. 

> +
> +static inline int cros_sensorhub_send_sample(
> +		struct cros_ec_sensorhub *sensorhub,
> +		struct cros_ec_sensors_ring_sample *sample)
> +{
> +	int id = sample->sensor_id;
> +	cros_ec_sensorhub_push_data_cb_t cb;
> +	struct iio_dev *indio_dev;
> +
> +	if (id > CROS_EC_SENSOR_MAX)
> +		return -EINVAL;
> +
> +	cb = sensorhub->push_data[id].push_data_cb;
> +	if (!cb)
> +		return 0;
> +
> +	indio_dev = sensorhub->push_data[id].indio_dev;
> +
> +	return cb(indio_dev, sample->vector, sample->timestamp);
> +}
> +
> +int cros_ec_sensorhub_register_push_data(
> +		struct cros_ec_sensorhub *sensorhub,
> +		u8 sensor_num,
> +		struct iio_dev *indio_dev,
> +		cros_ec_sensorhub_push_data_cb_t cb)
> +{
> +	if (sensor_num > CROS_EC_SENSOR_MAX)
> +		return -EINVAL;
> +	if (sensorhub->push_data[sensor_num].indio_dev != NULL)
> +		return -EINVAL;
> +
> +	sensorhub->push_data[sensor_num].indio_dev = indio_dev;
> +	sensorhub->push_data[sensor_num].push_data_cb = cb;

I always like a blank line before a simple return. Looks nice and
helps me sport the end of the function.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensorhub_register_push_data);
> +
> +void cros_ec_sensorhub_unregister_push_data(
> +		struct cros_ec_sensorhub *sensorhub,
> +		u8 sensor_num)
> +{
> +	sensorhub->push_data[sensor_num].indio_dev = NULL;
> +	sensorhub->push_data[sensor_num].push_data_cb = NULL;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
> +
> +int cros_ec_sensorhub_ring_fifo_toggle(
> +		struct cros_ec_sensorhub *sensorhub,
> +		bool on)
> +{
> +	int ret;
> +
> +	mutex_lock(&sensorhub->cmd_lock);
> +	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INT_ENABLE;
> +	sensorhub->params->fifo_int_enable.enable = on;
> +
> +	sensorhub->msg->outsize = sizeof(struct ec_params_motion_sense);
> +	sensorhub->msg->insize = sizeof(struct ec_response_motion_sense);
> +
> +	ret = cros_ec_cmd_xfer_status(sensorhub->ec->ec_dev, sensorhub->msg);
> +	/* We expect to receive a payload of 4 bytes, ignore. */
> +	if (ret > 0)
> +		ret = 0;
> +	mutex_unlock(&sensorhub->cmd_lock);
> +	return ret;
> +}
> +
> +/*
> + * cros_ec_ring_process_event: process one EC FIFO event
> + *
> + * Process one EC event, add it in the ring if necessary.
> + *
> + * Return true if out event has been populated.
> + *
> + * fifo_info: fifo information from the EC (includes b point, EC timebase).
> + * fifo_timestamp: EC IRQ, kernel timebase (aka c)
> + * current_timestamp: calculated event timestamp, kernel timebase (aka a')
> + * in: incoming FIFO event from EC (includes a point, EC timebase)
> + * out: outgoing event to user space (includes a')
Almost kernel-doc.  Nice to make it compliant.
> + */
> +static bool cros_ec_ring_process_event(
> +				struct cros_ec_sensorhub *sensorhub,
> +				const struct cros_ec_fifo_info *fifo_info,
> +				const s64 fifo_timestamp,
> +				s64 *current_timestamp,
> +				struct ec_response_motion_sensor_data *in,
> +				struct cros_ec_sensors_ring_sample *out)
> +{
> +	int axis;
> +	/* Do not populate the filter based on asynchronous events. */
> +	const int async_flags = in->flags &
> +		(MOTIONSENSE_SENSOR_FLAG_ODR | MOTIONSENSE_SENSOR_FLAG_FLUSH);
> +	const s64 now = cros_ec_get_time_ns();
> +
> +	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP && !async_flags) {
> +		s64 a = in->timestamp;
> +		s64 b = fifo_info->info.timestamp;
> +		s64 c = fifo_timestamp;
> +		s64 new_timestamp;
> +
> +		/*
> +		 * disable filtering since we might add more jitter
> +		 * if b is in a random point in time
> +		 */
> +		new_timestamp = c - b * 1000 + a * 1000;

White space is cheap. Add a line here to make it easier
for the eye to parse.

> +		/*
> +		 * The timestamp can be stale if we had to use the fifo
> +		 * info timestamp.
> +		 */
> +		if (new_timestamp - *current_timestamp > 0)
> +			*current_timestamp = new_timestamp;
> +	}
> +
> +	if (in->flags & MOTIONSENSE_SENSOR_FLAG_FLUSH) {
> +		out->sensor_id = in->sensor_num;
> +		out->timestamp = *current_timestamp;
> +		out->flag = in->flags;
> +		/*
> +		 * No other payload information provided with
> +		 * flush ack.
> +		 */
> +		return true;
> +	}
> +	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP)
> +		/* If we just have a timestamp, skip this entry. */
> +		return false;
> +
> +	/* Regular sample */
> +	out->sensor_id = in->sensor_num;
> +	if (*current_timestamp - now > 0) {
> +		/* If the timestamp is in the future. */
> +		out->timestamp = now;
> +	} else {
> +		out->timestamp = *current_timestamp;
> +	}

Blank line here breaks up logic blocks.

> +	out->flag = in->flags;
> +	for (axis = 0; axis < 3; axis++)
> +		out->vector[axis] = in->data[axis];

blank line here helps me to read it.

> +	return true;
> +}
> +
> +/*
> + * cros_ec_sensorhub_ring_handler - the trigger handler function
> + *
> + * @sensorhub: device information.
> + *
> + * Called by the notifier, process the EC sensor FIFO queue.
> + */
> +static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
> +{
> +	struct cros_ec_fifo_info *fifo_info = &sensorhub->fifo_info;
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +	s64    fifo_timestamp, current_timestamp;

Tabs here are ugly and not consistent with surrounding lines.

> +	int    i, j, number_data, ret;
> +	unsigned long sensor_mask = 0;
> +	struct ec_response_motion_sensor_data *in;
> +	struct cros_ec_sensors_ring_sample *out, *last_out;
> +
> +	mutex_lock(&sensorhub->cmd_lock);
> +	/* Get FIFO information */

This comment seems to be wrong.. It is just reading a timestamp.

> +	fifo_timestamp = sensorhub->fifo_timestamp[NEW_TS];
> +	/* Copy elements in the main fifo */
> +	if (fifo_info->info.total_lost) {
> +		/* Need to retrieve the number of lost vectors per sensor */
> +		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
> +		sensorhub->msg->outsize = 1;
> +		sensorhub->msg->insize =
> +			sizeof(struct ec_response_motion_sense_fifo_info) +
> +			sizeof(u16) * CROS_EC_SENSOR_MAX;
> +
> +		if (cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg) < 0) {
> +			mutex_unlock(&sensorhub->cmd_lock);
> +			return;
> +		}
> +		memcpy(fifo_info, &sensorhub->resp->fifo_info,
> +		       sizeof(*fifo_info));
> +		fifo_timestamp = cros_ec_get_time_ns();
> +	}
> +	if (fifo_info->info.count > sensorhub->fifo_size ||
> +	    fifo_info->info.size != sensorhub->fifo_size) {
> +		dev_warn(sensorhub->dev,
> +			 "Mismatch EC data: count %d, size %d - expected %d",
> +			 fifo_info->info.count, fifo_info->info.size,
> +			 sensorhub->fifo_size);
> +		mutex_unlock(&sensorhub->cmd_lock);
> +		return;
> +	}
> +
> +	current_timestamp = sensorhub->fifo_timestamp[LAST_TS];
> +	out = sensorhub->ring;
> +	for (i = 0; i < fifo_info->info.count; i += number_data) {
> +		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_READ;
> +		sensorhub->params->fifo_read.max_data_vector =
> +			fifo_info->info.count - i;
> +		sensorhub->msg->outsize =
> +			sizeof(struct ec_params_motion_sense);
> +		sensorhub->msg->insize =
> +			sizeof(sensorhub->resp->fifo_read) +
> +			sensorhub->params->fifo_read.max_data_vector *
> +			  sizeof(struct ec_response_motion_sensor_data);
> +		ret = cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg);
> +		if (ret < 0) {
> +			dev_warn(sensorhub->dev, "Fifo error: %d\n", ret);
> +			break;
> +		}
> +		number_data = sensorhub->resp->fifo_read.number_data;
> +		if (number_data == 0) {
> +			dev_dbg(sensorhub->dev, "Unexpected empty FIFO\n");
> +			break;

Given you break from here, might as well drop the else in the next line.

> +		} else if (number_data > fifo_info->info.count - i) {
> +			dev_warn(sensorhub->dev,
> +				 "Invalid EC data: too many entry received: %d, expected %d",
> +				 number_data, fifo_info->info.count - i);
> +			break;

Same as above. The else is a bit pointless as flow won't go beyond here if the
earlier statements have broken out.

> +		} else if (out + number_data >
> +			   sensorhub->ring + fifo_info->info.count) {
> +			dev_warn(sensorhub->dev,
> +				 "Too many samples: %d (%zd data) to %d entries for expected %d entries",
> +				 i, out - sensorhub->ring, i + number_data,
> +				 fifo_info->info.count);
> +			break;
> +		}

Blank line here to separate the error cases from where we go next.

> +		for (in = sensorhub->resp->fifo_read.data, j = 0;
> +		     j < number_data; j++, in++) {
> +			if (cros_ec_ring_process_event(
> +					sensorhub, fifo_info, fifo_timestamp,
> +					&current_timestamp, in, out)) {
> +				sensor_mask |= (1 << in->sensor_num);
> +				out++;
> +			}
> +		}
> +	}
> +	mutex_unlock(&sensorhub->cmd_lock);
> +	last_out = out;
> +
> +	if (out == sensorhub->ring)
> +		/* Unexpected empty FIFO. */
> +		goto ring_handler_end;
> +
> +	/*
> +	 * Check if current_timestamp is ahead of the last sample.
> +	 * Normally, the EC appends a timestamp after the last sample, but if
> +	 * the AP is slow to respond to the IRQ, the EC may have added new
> +	 * samples. Use the FIFO info timestamp as last timestamp then.
> +	 */
> +	if ((last_out-1)->timestamp == current_timestamp)
> +		current_timestamp = fifo_timestamp;
> +
> +	/* Warn on lost samples. */
> +	for_each_set_bit(i, &sensor_mask, BITS_PER_LONG) {
> +		if (fifo_info->info.total_lost) {
> +			int lost = fifo_info->lost[i];
> +
> +			if (lost) {
> +				dev_warn(sensorhub->dev,
> +					"Sensor %d: lost: %d out of %d\n", i,
> +					lost, fifo_info->info.total_lost);

Is there potential to fill the log with this? I'm not sure if dev_warn
is rate limited.

> +			}
> +		}
> +	}
> +
> +	/* push the event into the kfifo */
> +	for (out = sensorhub->ring; out < last_out; out++)
> +		cros_sensorhub_send_sample(sensorhub, out);
> +
> +ring_handler_end:
> +	sensorhub->fifo_timestamp[LAST_TS] = current_timestamp;
> +}
> +
> +static int cros_ec_sensorhub_event(struct notifier_block *nb,
> +	unsigned long queued_during_suspend, void *_notify)
> +{
> +	struct cros_ec_sensorhub *sensorhub;
> +	struct cros_ec_device *ec_dev;
> +
> +	sensorhub = container_of(nb, struct cros_ec_sensorhub, notifier);
> +	ec_dev = sensorhub->ec->ec_dev;
> +
> +	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_SENSOR_FIFO)
> +		return NOTIFY_DONE;
> +
> +	if (ec_dev->event_size != sizeof(ec_dev->event_data.data.sensor_fifo)) {
> +		dev_warn(ec_dev->dev, "Invalid fifo info size\n");
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (queued_during_suspend)
> +		return NOTIFY_OK;
> +
> +	sensorhub->fifo_info.info = ec_dev->event_data.data.sensor_fifo.info;
> +	sensorhub->fifo_timestamp[NEW_TS] = ec_dev->last_event_time;
> +	cros_ec_sensorhub_ring_handler(sensorhub);
> +	return NOTIFY_OK;
> +}
> +
> +int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
> +{
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +	int ret;
> +
> +	/* Retrieve FIFO information */
> +	sensorhub->msg->version = 2;
> +	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
> +	sensorhub->msg->outsize = 1;
> +	sensorhub->msg->insize =
> +		sizeof(struct ec_response_motion_sense_fifo_info) +
> +		sizeof(u16) * CROS_EC_SENSOR_MAX;
> +
> +	ret = cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Allocate the full fifo.
> +	 * We need to copy the whole FIFO to set timestamps properly *
> +	 */
> +	sensorhub->fifo_size = sensorhub->resp->fifo_info.size;
> +	sensorhub->ring = devm_kcalloc(sensorhub->dev, sensorhub->fifo_size,
> +			sizeof(*sensorhub->ring), GFP_KERNEL);
> +	if (!sensorhub->ring)
> +		return -ENOMEM;
> +
> +	sensorhub->fifo_timestamp[LAST_TS] = cros_ec_get_time_ns();
> +
> +	/* register the notifier that will act as a top half interrupt. */
> +	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
> +	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
> +					       &sensorhub->notifier);
> +	if (ret < 0) {
> +		dev_warn(sensorhub->dev, "failed to register notifier\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Start collection samples.

Single line comment. Also with appropriate rename of that function will
be fairly obvious.

> +	 */
> +	ret = cros_ec_sensorhub_ring_fifo_toggle(sensorhub, true);
> +	return ret;
	return cros_ec_sensorhub...

> +}
> +
> +int cros_ec_sensorhub_ring_remove(struct cros_ec_sensorhub *sensorhub)
> +{
> +	struct cros_ec_device *ec_dev = sensorhub->ec->ec_dev;
> +
> +	/*
> +	 * Disable the ring, prevent EC interrupt to the AP for nothing.

If will fit on a single line, stick to a single line.

> +	 */
> +	cros_ec_sensorhub_ring_fifo_toggle(sensorhub, false);

Odd name for an enable disable function.  I'd expect 'toggle' to take no
parameter but to flip from which ever state we are in to the other one.
That's not what is happening here.

> +	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
> +					   &sensorhub->notifier);
> +	return 0;
> +}
> +
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index bb331e6356a9..abef66d0e884 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -116,6 +116,9 @@ struct platform_device;
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev, bool physical_device);
>  
> +/* To remove association of physical device to cros_ec_sensorhub. */
> +int cros_ec_sensors_core_clean(struct platform_device *pdev);
> +
>  /**
>   * cros_ec_sensors_capture() - the trigger handler function
>   * @irq:	the interrupt number.
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> index 9295eabb16f6..18cda568c58a 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -9,6 +9,7 @@
>  #ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>  #define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>  
> +#include <linux/iio/iio.h>

Comment below. I wouldn't expect to see this include here.

>  #include <linux/platform_data/cros_ec_commands.h>
>  
>  /**
> @@ -19,11 +20,89 @@ struct cros_ec_sensor_platform {
>  	u8 sensor_num;
>  };
>  
> +/**
> + * Callback function to send datum to specific sensors.

It's not kernel-doc.

> + */
> +typedef int (*cros_ec_sensorhub_push_data_cb_t)(
> +		struct iio_dev *indio_dev,

I would add a forwards def of struct iio_dev and not
include the iio header.

> +		s16 *data,
> +		s64 timestamp);
> +
> +struct cros_ec_sensorhub_sensor_push_data {
> +	struct iio_dev *indio_dev;
> +	cros_ec_sensorhub_push_data_cb_t push_data_cb;
> +};
> +
> +enum {
> +	LAST_TS,
> +	NEW_TS,
> +	ALL_TS
> +};
> +
> +#define CROS_EC_SENSOR_MAX 16
> +
> +struct __ec_todo_packed cros_ec_fifo_info {
> +	struct ec_response_motion_sense_fifo_info info;
> +	uint16_t lost[CROS_EC_SENSOR_MAX];
> +};
> +
> +struct cros_ec_sensors_ring_sample {
> +	uint8_t sensor_id;
> +	uint8_t flag;
> +	int16_t  vector[3];
> +	s64      timestamp;
> +} __packed;
> +
>  /**
>   * struct cros_ec_sensorhub - Sensor Hub device data.
>   */
>  struct cros_ec_sensorhub {
> +	struct device *dev;
>  	struct cros_ec_dev *ec;
> +
> +	/* Structure to send FIFO requests. */
> +	struct cros_ec_command *msg;
> +	struct ec_params_motion_sense *params;
> +	struct ec_response_motion_sense *resp;
> +	struct mutex cmd_lock;
> +
> +	/* Notifier to kick the FIFO interrupt */
> +	struct notifier_block notifier;
> +
> +	/* Preprocessed ring to send to kfifos */
> +	struct cros_ec_sensors_ring_sample *ring;
> +
> +	s64    fifo_timestamp[ALL_TS];
> +	struct cros_ec_fifo_info fifo_info;
> +	int    fifo_size;
> +
> +	/*
> +	 * Dynamic array to be able to spread datum to iio sensor objects.
> +	 */
> +	struct cros_ec_sensorhub_sensor_push_data push_data[CROS_EC_SENSOR_MAX];
>  };
>  
> +/**
> + * Function to register the callback to the sensor hub.
> + * The callback cb will be used by cros_ec_sensorhub_ring to distribute events
> + * from the EC.

Looks like kernel-doc but isn't. + should be with the code, not in the header
where it will tend to rot.

> + */
> +int cros_ec_sensorhub_register_push_data(
> +		struct cros_ec_sensorhub *sensor_hub,
> +		u8 sensor_num,
> +		struct iio_dev *indio_dev,
> +		cros_ec_sensorhub_push_data_cb_t cb);
> +void cros_ec_sensorhub_unregister_push_data(
> +		struct cros_ec_sensorhub *sensor_hub,
> +		u8 sensor_num);
> +
> +/**

/* otherwise it's kernel-doc...

> + * Add/Remove the fifo functionality if the EC supports it.
> + */
> +int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensor_hub);
> +int cros_ec_sensorhub_ring_remove(struct cros_ec_sensorhub *sensor_hub);
> +int cros_ec_sensorhub_ring_fifo_toggle(
> +		struct cros_ec_sensorhub *sensorhub,
> +		bool on);
> +
>  #endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */

