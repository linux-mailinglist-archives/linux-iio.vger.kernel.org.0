Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2010717E
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 12:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfKVLfi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 06:35:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32800 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfKVLfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 06:35:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 42B2C291E57
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v5 09/18] platform: chrome: sensorhub: Add FIFO support
To:     Gwendal Grignou <gwendal@chromium.org>, dmitry.torokhov@gmail.com,
        groeck@chromium.org, briannorris@chromium.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org, dianders@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191115093412.144922-1-gwendal@chromium.org>
 <20191115093412.144922-10-gwendal@chromium.org>
Message-ID: <f120afd8-4ce8-4d1f-8c87-1a5bbd3ce422@collabora.com>
Date:   Fri, 22 Nov 2019 12:35:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115093412.144922-10-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Some comments below.

On 15/11/19 10:34, Gwendal Grignou wrote:
> cros_ec_sensorhub registers a listener and query motion sense FIFO,
> spread to iio sensors registers.
> 
> To test, we can use libiio:
> iiod&
> iio_readdev -u ip:localhost -T 10000 -s 25 -b 16 cros-ec-gyro | od -x
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v5:
> - Use a goto in cros_ec_sensorhub_ring_handler to centralize error
>   handling
> - Use devm_add_action_or_reset to not need a .remove entry point for
>   cros_sensor_hub.
> - Fix logic error in cros_ec_sensorhub_register_push_data.
> - Update kernel_doc documentation.
> - Remve the need for comments in variable declaration section.
> Changes in v4:
> - Keep defining cros_ec_sensorhub in kernel-doc format
> - Fix logic error when checking if sensor index outside array.
> - Check patch with --strict option
>     Use sizeof(*obj) instead of sizeof(struct ...obj)
>     Alignement
>     Use uX instead of uintX_t
>     Use !ptr instead of ptr != NULL
> Changes in v3:
> - Do not use ret !=
> - Simplfy errpr handling by removing a goto
> - Fix doxygen comments
> - Replace suspend/resume entry points with regular driver entry point;
>   There was an issue in the past where the sensor stack was preventing
>   device to suspend, but the proper fix has been implemented in cros_ec
>   code (6ad16b78a039b "platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup")
> - Reduce mutex scope by checking return code outside of it.
> Changes in v2:
> - Do not register a .remove routinge in plaform_driver. A
>   devm_action_add is added later patch IIO driver register their
> callback.
> - Remove double lines, add lines before return calls.
> - Handle FLUSH flag from EC.
> 
> - Use ktime_t for most timestamp measurements.
> - Add doxygen comments
> - Cleanup timestamp collection when processing FIFO.
> - Rename fifo_toggle to fifo_enable
> 
>  drivers/platform/chrome/Makefile              |   3 +-
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 108 +++--
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 427 ++++++++++++++++++

If you join the files will be around 500 lines, not too much, there is any
strong reason to have a separate files?

>  .../linux/platform_data/cros_ec_sensorhub.h   |  91 ++++
>  4 files changed, 600 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
> 
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

In case you decided to not join sensorhub and ring files ...

This will create a completely new module not tied to the config symbol, which is
fine but I'd prefer have something like this instead:

obj-$(CONFIG_CROS_EC_SENSORHUB)                += cros-ec-sensorhub.o
cros-ec-sensorhub-objs                 := cros_ec_sensorhub.o
cros-ec-sensorhub-objs                 += cros_ec_sensorhub_ring.o

>  obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> index 85e3d3f25786..04fd60f747c0 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -51,10 +51,8 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  	int ret, i, id, sensor_num;
>  	struct cros_ec_dev *ec = sensorhub->ec;
>  	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
> -	struct ec_params_motion_sense *params;
> -	struct ec_response_motion_sense *resp;
> -	struct cros_ec_command *msg;
>  	char *name;
> +	struct cros_ec_command *msg = sensorhub->msg;
>  
>  	sensor_num = cros_ec_get_sensor_count(ec);
>  	if (sensor_num < 0) {
> @@ -69,30 +67,21 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	/* Prepare a message to send INFO command to each sensor. */
> -	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
> -		      GFP_KERNEL);
> -	if (!msg)
> -		return -ENOMEM;
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
>  			name = "cros-ec-accel";
>  			break;
> @@ -115,14 +104,15 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  			name = "cros-ec-activity";
>  			break;
>  		default:
> -			dev_warn(dev, "unknown type %d\n", resp->info.type);
> +			dev_warn(dev, "unknown type %d\n",
> +				 sensorhub->resp->info.type);
>  			continue;
>  		}
>  		ret = cros_ec_sensorhub_allocate_single_sensor(dev, name, i);
>  		if (ret)
> -			goto error;
> +			return ret;
>  
> -		sensor_type[resp->info.type]++;
> +		sensor_type[sensorhub->resp->info.type]++;
>  	}
>  
>  	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
> @@ -133,14 +123,9 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  		ret = cros_ec_sensorhub_allocate_single_sensor(dev,
>  							"cros-ec-lid-angle", 0);
>  		if (ret)
> -			goto error;
> +			return ret;
>  	}
> -	kfree(msg);
>  	return 0;
> -
> -error:
> -	kfree(msg);
> -	return ret;
>  }
>  
>  static int cros_ec_sensorhub_probe(struct platform_device *sensorhub_pdev)
> @@ -148,13 +133,29 @@ static int cros_ec_sensorhub_probe(struct platform_device *sensorhub_pdev)
>  	struct device *dev = &sensorhub_pdev->dev;
>  	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
>  	int ret, i;
> -	struct cros_ec_sensorhub *data =
> -		devm_kzalloc(dev, sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
> +	struct cros_ec_sensorhub *data;
> +	struct cros_ec_command *msg;
>  
> +	msg = devm_kzalloc(dev, sizeof(struct cros_ec_command) +
> +			max((u16)sizeof(struct ec_params_motion_sense),

Is this u16 cast needed? I think you can remove it.

> +			    ec->ec_dev->max_response), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> +
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
> @@ -179,12 +180,63 @@ static int cros_ec_sensorhub_probe(struct platform_device *sensorhub_pdev)
>  		}
>  	}
>  
> +	/*
> +	 * If the EC does not have a FIFO, the sensors will query their data
> +	 * themselves via sysfs or a software trigger.
> +	 */
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> +		ret = cros_ec_sensorhub_ring_add(data);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * The msg and its data is not under the control of the ring
> +		 * handler.
> +		 */
> +		return devm_add_action_or_reset(dev,
> +						cros_ec_sensorhub_ring_remove,
> +						data);
> +	}
> +
> +	return 0;
> +}
> +
> +#if CONFIG_PM_SLEEP

That should be #ifdef

> +/*
> + * When the EC is suspending, we must stop sending interrupt,
> + * we may use the same interrupt line for waking up the device.
> + * Tell the EC to stop sending non-interrupt event on the iio ring.
> + */
> +static int cros_ec_ring_suspend(struct device *dev)

Not only here, but this name dance makes me more difficult to follow the code.
Could we follow a name rule?

aka cros_ec_sensorhub_suspend

> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
> +		return cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
>  	return 0;
>  }
>  
> +static int cros_ec_ring_resume(struct device *dev)

cros_ec_sensorhub_resume

> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
> +		return cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_sensorhub_ring_pm_ops,

cros_ec_sensorhub_pm_ops

> +		cros_ec_ring_suspend,
> +		cros_ec_ring_resume);

s/cros_ec_ring/cros_ec_sensorhub/

> +
>  static struct platform_driver cros_ec_sensorhub_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
> +		.pm = &cros_ec_sensorhub_ring_pm_ops,

cros_ec_sensorhub_pm_ops

>  	},
>  	.probe = cros_ec_sensorhub_probe,
>  };
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> new file mode 100644
> index 000000000000..32333f67e26a
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c

Could we consider if makes sense have this in a separate file.

> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cros_ec_sensorhub_ring - Driver for Chrome OS EC Sensor hub FIFO.
> + *

Remove the file name, is easy to forget to update that file name if at some
point we rename the file for some reason, so just remove it, doesn't adds extra
info.

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
> +static inline int cros_sensorhub_send_sample(

static inline int
cros_sensorhub_send_sample(struct cros_ec_sensorhub *sensorhub,


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
> +	if (sample->flag & MOTIONSENSE_SENSOR_FLAG_FLUSH)
> +		return 0;
> +
> +	return cb(indio_dev, sample->vector, sample->timestamp);
> +}
> +
> +/**
> + * cros_ec_sensorhub_register_push_data() - register the callback to the hub.
> + *
> + * @sensorhub : Sensor Hub object
> + * @sensor_num : The sensor the caller is interested in.
> + * @indio_dev : The iio device to use when a sample arrives.
> + * @cb : The callback to call when a sample arrives.
> + *
> + * The callback cb will be used by cros_ec_sensorhub_ring to distribute events
> + * from the EC.
> + *
> + * Return: 0 when callback is registered.

and error otherwise?

> + */
> +int cros_ec_sensorhub_register_push_data(struct cros_ec_sensorhub *sensorhub,
> +					 u8 sensor_num,
> +					 struct iio_dev *indio_dev,
> +					 cros_ec_sensorhub_push_data_cb_t cb)
> +{
> +	if (sensor_num >= CROS_EC_SENSOR_PDEV_MAX)
> +		return -EINVAL;
> +	if (sensorhub->push_data[sensor_num].indio_dev)
> +		return -EINVAL;
> +
> +	sensorhub->push_data[sensor_num].indio_dev = indio_dev;
> +	sensorhub->push_data[sensor_num].push_data_cb = cb;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensorhub_register_push_data);
> +
> +void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
> +					    u8 sensor_num)
> +{
> +	sensorhub->push_data[sensor_num].indio_dev = NULL;
> +	sensorhub->push_data[sensor_num].push_data_cb = NULL;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
> +
> +/**
> + * cros_ec_sensorhub_ring_fifo_enable() - Enable or disable interrupt generation
> + *  for FIFO events.
> + * @sensorhub : Sensor Hub object
> + * @on : true when events are requested.
> + *
> + * To be called before sleeping or when noone is listening.
> + * Return: 0 on success.

and error otherwise

> + */
> +int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
> +				       bool on)

Again there is a name dance here, sometimes you use cros_ec_sensorhub_ring,
others cros_ec_ring. If you decide to join the files use cros_ec_sensorhub_xxx

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
> +	mutex_unlock(&sensorhub->cmd_lock);
> +
> +	/* We expect to receive a payload of 4 bytes, ignore. */
> +	if (ret > 0)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +/**
> + * cros_ec_ring_process_event() - process one EC FIFO event
> + *
> + * @sensorhub: Sensorhub object.
> + * @fifo_info: fifo information from the EC (includes b point, EC timebase).
> + * @fifo_timestamp: EC IRQ, kernel timebase (aka c)
> + * @current_timestamp: calculated event timestamp, kernel timebase (aka a')
> + * @in: incoming FIFO event from EC (includes a point, EC timebase)
> + * @out: outgoing event to user space (includes a')
> + *
> + * Process one EC event, add it in the ring if necessary.
> + *
> + * Return: true if out event has been populated.
> + */
> +static bool cros_ec_ring_process_event(struct cros_ec_sensorhub *sensorhub,
> +				const struct cros_ec_fifo_info *fifo_info,
> +				const ktime_t fifo_timestamp,
> +				ktime_t *current_timestamp,
> +				struct ec_response_motion_sensor_data *in,
> +				struct cros_ec_sensors_ring_sample *out)
> +{
> +	int axis, async_flags;
> +	const s64 now = cros_ec_get_time_ns();
> +
> +	/* Do not populate the filter based on asynchronous events. */
> +	async_flags = in->flags &
> +		(MOTIONSENSE_SENSOR_FLAG_ODR | MOTIONSENSE_SENSOR_FLAG_FLUSH);
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

Are a,b,c really needed? They are not used anymore. For me the formula makes a
bit of more sense using the variable names.

> +
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
> +
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
> +

The brackets are not needed here

> +	out->flag = in->flags;
> +	for (axis = 0; axis < 3; axis++)
> +		out->vector[axis] = in->data[axis];
> +
> +	return true;
> +}
> +
> +/**
> + * cros_ec_sensorhub_ring_handler() - the trigger handler function
> + *
> + * @sensorhub: device information.
> + *
> + * Called by the notifier, process the EC sensor FIFO queue.
> + */
> +static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
> +{
> +	struct cros_ec_fifo_info *fifo_info = &sensorhub->fifo_info;
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +	ktime_t fifo_timestamp, current_timestamp;
> +	int i, j, number_data, ret;
> +	unsigned long sensor_mask = 0;
> +	struct ec_response_motion_sensor_data *in;
> +	struct cros_ec_sensors_ring_sample *out, *last_out;
> +
> +	mutex_lock(&sensorhub->cmd_lock);
> +
> +	/* Get FIFO information if there are lost vectors. */
> +	if (fifo_info->info.total_lost) {
> +		/* Need to retrieve the number of lost vectors per sensor */
> +		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
> +		sensorhub->msg->outsize = 1;
> +		sensorhub->msg->insize =
> +			sizeof(struct ec_response_motion_sense_fifo_info) +
> +			sizeof(u16) * CROS_EC_SENSOR_MAX;
> +
> +		if (cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg) < 0)
> +			goto error;
> +
> +		memcpy(fifo_info, &sensorhub->resp->fifo_info,
> +		       sizeof(*fifo_info));
> +
> +		/*
> +		 * Update collection time, will not be as precise as the
> +		 * non-error case.
> +		 */
> +		fifo_timestamp = cros_ec_get_time_ns();
> +	} else {
> +		fifo_timestamp = sensorhub->fifo_timestamp[
> +			CROS_EC_SENSOR_NEW_TS];
> +	}
> +
> +	if (fifo_info->info.count > sensorhub->fifo_size ||
> +	    fifo_info->info.size != sensorhub->fifo_size) {
> +		dev_warn(sensorhub->dev,
> +			 "Mismatch EC data: count %d, size %d - expected %d",
> +			 fifo_info->info.count, fifo_info->info.size,
> +			 sensorhub->fifo_size);
> +		goto error;
> +	}
> +
> +	/* Copy elements in the main fifo */
> +	current_timestamp = sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS];
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

This warning is not needed, we will get an error if the command fails that is
enough.

> +			break;
> +		}
> +		number_data = sensorhub->resp->fifo_read.number_data;
> +		if (number_data == 0) {
> +			dev_dbg(sensorhub->dev, "Unexpected empty FIFO\n");
> +			break;
> +		}
> +		if (number_data > fifo_info->info.count - i) {
> +			dev_warn(sensorhub->dev,
> +				 "Invalid EC data: too many entry received: %d, expected %d",
> +				 number_data, fifo_info->info.count - i);

Is a dev_warn but is ignored, so can we downgrade this to dev_dbg? Lets use
dev_warn for something that really needs to be warned.

> +			break;
> +		}
> +		if (out + number_data >
> +		    sensorhub->ring + fifo_info->info.count) {
> +			dev_warn(sensorhub->dev,
> +				 "Too many samples: %d (%zd data) to %d entries for expected %d entries",
> +				 i, out - sensorhub->ring, i + number_data,
> +				 fifo_info->info.count);

Same here, dev_dbg?

> +			break;
> +		}
> +
> +		for (in = sensorhub->resp->fifo_read.data, j = 0;
> +		     j < number_data; j++, in++) {
> +			if (cros_ec_ring_process_event(sensorhub, fifo_info,
> +						       fifo_timestamp,
> +						       &current_timestamp,
> +						       in, out)) {
> +				sensor_mask |= (1 << in->sensor_num);

Use the BIT macro here, BIT(in->sensor_num)

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
> +	if ((last_out - 1)->timestamp == current_timestamp)
> +		current_timestamp = fifo_timestamp;
> +
> +	/* Warn on lost samples. */
> +	for_each_set_bit(i, &sensor_mask, BITS_PER_LONG) {
> +		int total_lost = fifo_info->info.total_lost;
> +
> +		if (total_lost) {
> +			int lost = fifo_info->lost[i];
> +
> +			if (lost) {
> +				dev_warn_ratelimited(sensorhub->dev,
> +						     "Sensor %d: lost: %d out of %d\n",
> +						     i, lost, total_lost);

Same, maybe instead of have dev_warn_ratelimited we can use dev_dbg (and
ratelimited) if it really appears too often.

> +			}
> +		}
> +	}
> +
> +	/* push the event into the kfifo */
> +	for (out = sensorhub->ring; out < last_out; out++)
> +		cros_sensorhub_send_sample(sensorhub, out);
> +
> +ring_handler_end:
> +	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
> +	return;
> +
> +error:
> +	mutex_unlock(&sensorhub->cmd_lock);
> +	return;
> +}
> +
> +static int cros_ec_sensorhub_event(struct notifier_block *nb,
> +				   unsigned long queued_during_suspend,
> +				   void *_notify)
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
> +	sensorhub->fifo_timestamp[CROS_EC_SENSOR_NEW_TS] =
> +		ec_dev->last_event_time;
> +	cros_ec_sensorhub_ring_handler(sensorhub);
> +
> +	return NOTIFY_OK;
> +}
> +
> +/**
> + * cros_ec_sensorhub_ring_add() - Add/Remove the fifo functionality if the EC
> + *  supports it.
> + *
> + * @sensorhub : Sensor Hub object
> + *
> + * Return: 0 on success.
> + */
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
> +				       sizeof(*sensorhub->ring), GFP_KERNEL);
> +	if (!sensorhub->ring)
> +		return -ENOMEM;
> +
> +	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
> +		cros_ec_get_time_ns();
> +
> +	/* register the notifier that will act as a top half interrupt. */
> +	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
> +	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
> +					       &sensorhub->notifier);
> +	if (ret < 0) {
> +		dev_warn(sensorhub->dev, "failed to register notifier\n");

Currently blocking_notifier_chain_register always returns 0. I'm fine to check
the result just in case at some point that changes but the comment is not needed.

> +		return ret;
> +	}
> +
> +	/* Start collection samples. */
> +	return cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
> +}
> +
> +void cros_ec_sensorhub_ring_remove(void *arg)
> +{
> +	struct cros_ec_sensorhub *sensorhub = arg;
> +	struct cros_ec_device *ec_dev = sensorhub->ec->ec_dev;
> +
> +	/* Disable the ring, prevent EC interrupt to the AP for nothing. */
> +	cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
> +	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
> +					   &sensorhub->notifier);
> +}
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> index 7421c956246f..5aaaa6cb012a 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -8,8 +8,20 @@
>  #ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>  #define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>  
> +#include <linux/ktime.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  
> +/* Maximal number of sensors supported by the EC. */
> +#define CROS_EC_SENSOR_MAX 16
> +
> +/*
> + * Maximal number of sensors supported by the hub:
> + * We add one for the lid angle inclinometer sensor.
> + */
> +#define CROS_EC_SENSOR_PDEV_MAX (CROS_EC_SENSOR_MAX + 1)
> +
>  /**
>   * struct cros_ec_sensor_platform - ChromeOS EC sensor platform information.
>   * @sensor_num: Id of the sensor, as reported by the EC.
> @@ -18,13 +30,92 @@ struct cros_ec_sensor_platform {
>  	u8 sensor_num;
>  };
>  
> +struct iio_dev;
> +
> +/**
> + * typedef cros_ec_sensorhub_push_data_cb_t - Callback function to send datum
> + *     to specific sensors
> + *
> + * @indio_dev: The IIO device that will process the sample.
> + * @data: vector array of the ring sample.
> + * @timestamp: Timestamp in host timespace when the sample was acquired by
> + *             the EC.
> + */
> +typedef int (*cros_ec_sensorhub_push_data_cb_t)(struct iio_dev *indio_dev,
> +						s16 *data,
> +						s64 timestamp);
> +
> +struct cros_ec_sensorhub_sensor_push_data {
> +	struct iio_dev *indio_dev;
> +	cros_ec_sensorhub_push_data_cb_t push_data_cb;
> +};
> +
> +enum {
> +	CROS_EC_SENSOR_LAST_TS,
> +	CROS_EC_SENSOR_NEW_TS,
> +	CROS_EC_SENSOR_ALL_TS
> +};
> +
> +struct __ec_todo_packed cros_ec_fifo_info {
> +	struct ec_response_motion_sense_fifo_info info;
> +	u16    lost[CROS_EC_SENSOR_MAX];
> +};
> +
> +struct cros_ec_sensors_ring_sample {
> +	u8  sensor_id;
> +	u8  flag;
> +	s16 vector[3];
> +	s64 timestamp;
> +} __packed;
> +
>  /**
>   * struct cros_ec_sensorhub - Sensor Hub device data.
>   *
> + * @dev:          Device object, mostly used for logging.
>   * @ec:           Embedded Controller where the hub is located.
> + * @msg: Structure to send FIFO requests.
> + * @params: pointer to parameters in msg.
> + * @resp: pointer to responses in msg.
> + * @cmd_lock : lock for sending msg.
> + * @notifier: Notifier to kick the FIFO interrupt.
> + * @ring: Preprocessed ring to store events.
> + * @fifo_timestamp: array for event timestamp and spreading.
> + * @fifo_info: copy of FIFO information coming from the EC.
> + * @fifo_size: size of the ring.
> + * @push_data: array of callback to send datums to iio sensor object.
>   */
>  struct cros_ec_sensorhub {
> +	struct device *dev;
>  	struct cros_ec_dev *ec;
> +
> +	struct cros_ec_command *msg;
> +	struct ec_params_motion_sense *params;
> +	struct ec_response_motion_sense *resp;
> +	struct mutex cmd_lock;
> +
> +	struct notifier_block notifier;
> +
> +	struct cros_ec_sensors_ring_sample *ring;
> +
> +	ktime_t fifo_timestamp[CROS_EC_SENSOR_ALL_TS];
> +	struct cros_ec_fifo_info fifo_info;
> +	int    fifo_size;
> +
> +	struct cros_ec_sensorhub_sensor_push_data push_data[
> +		CROS_EC_SENSOR_PDEV_MAX];
>  };
>  
> +int cros_ec_sensorhub_register_push_data(struct cros_ec_sensorhub *sensorhub,
> +					 u8 sensor_num,
> +					 struct iio_dev *indio_dev,
> +					 cros_ec_sensorhub_push_data_cb_t cb);
> +
> +void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
> +					    u8 sensor_num);
> +
> +int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub);
> +void cros_ec_sensorhub_ring_remove(void *arg);
> +int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
> +				       bool on);
> +
>  #endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
> 
