Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50757DF318
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJUQ1g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 12:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJUQ1f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 12:27:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D88205ED;
        Mon, 21 Oct 2019 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571675253;
        bh=FSzSpNJhrqBkGweiDPephMH6Z+No/vjFAKehP5knue0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDl/02ahbiEs/62KPXZgYXCANG/2p62d0eKK2jimxMu3/gmqk0sxoqykSILROmlfx
         J8fTpifD0ZEvCNZAndEWkp4WlAwtm6FpstiVizPlUWyQRve4hbxqp4jRE+BZVsO592
         +SZk3PQO5x00mhLezYKPrAik0RaKSiwtbgEwFbPA=
Date:   Mon, 21 Oct 2019 17:27:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 10/18] platform: chrome: sensorhub: Add FIFO support
Message-ID: <20191021172727.0fa9918e@archlinux>
In-Reply-To: <20191021055403.67849-11-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
        <20191021055403.67849-11-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 22:53:55 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> cros_ec_sensorhub registers a listener and query motion sense FIFO,
> spread to iio sensors registers.
> 
> To test, we can use libiio:
> iiod&
> iio_readdev -u ip:localhost -T 10000 -s 25 -b 16 cros-ec-gyro | od -x
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

A few new bits inline.  I'm not an expert in power management, but
using prepare as done here doesn't immediately seem the right choice
to me (I'd not come across it before so had to read the docs ;)

Thanks,

Jonathan


> ---
> Changes sunce v2:
> - Do not register a .remove routinge in plaform_driver. A
>   devm_action_add is added later patch IIO driver register their
> callback.
> - Remove double lines, add lines before return calls.
> - Handle FLUSH flag from EC.
> - Use ktime_t for most timestamp measurements.
> - Add doxygen comments
> - Cleanup timestamp collection when processing FIFO.
> - Rename fifo_toggle to fifo_enable
> 
>  drivers/platform/chrome/Makefile              |   3 +-
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 123 ++++--
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 412 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_sensorhub.h   |  77 ++++
>  4 files changed, 583 insertions(+), 32 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c
> 
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index a164c40dc0996..cb709048c003e 100644
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
> index 5fea4c28c5c95..87308dadc32c5 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -24,7 +24,6 @@
>  
>  #define DRV_NAME		"cros-ec-sensorhub"
>  
> -
>  static struct device_type cros_ec_sensorhub_dev_type = {
>  	.name	= "cros_ec_iio_sensor",
>  };
> @@ -64,14 +63,13 @@ static int cros_ec_sensorhub_allocate_single_sensor(
>  }
>  
>  static int cros_ec_sensorhub_register(struct device *dev,
> -		struct cros_ec_dev *ec)
> +		struct cros_ec_sensorhub *sensorhub)
>  {
>  	int ret, i, id, sensor_num;
>  	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
> -	struct ec_params_motion_sense *params;
> -	struct ec_response_motion_sense *resp;
> -	struct cros_ec_command *msg;
>  	char *name;
> +	struct cros_ec_command *msg = sensorhub->msg;
> +	struct cros_ec_dev *ec = sensorhub->ec;
>  
>  	sensor_num = cros_ec_get_sensor_count(ec);
>  	if (sensor_num < 0) {
> @@ -86,32 +84,21 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	/* Prepare a message to send INFO command to each sensor. */
> -	msg = kzalloc(sizeof(struct cros_ec_command) +
> -		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> -	if (!msg) {
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
> @@ -134,14 +121,15 @@ static int cros_ec_sensorhub_register(struct device *dev,
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
> @@ -152,9 +140,6 @@ static int cros_ec_sensorhub_register(struct device *dev,
>  		ret = cros_ec_sensorhub_allocate_single_sensor(
>  				dev, "cros-ec-lid-angle", 0);
>  	}
> -
> -error:
> -	kfree(msg);
>  	return ret;
>  }
>  
> @@ -163,34 +148,110 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
>  	int ret;
> -	struct cros_ec_sensorhub *data =
> -		kzalloc(sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
> +	struct cros_ec_sensorhub *data;
> +	struct cros_ec_command *msg;
>  
> +	msg = devm_kzalloc(dev, sizeof(struct cros_ec_command) +
> +			max((u16)sizeof(struct ec_params_motion_sense),
> +			    ec->ec_dev->max_response), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
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
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
> -		ret = cros_ec_sensorhub_register(dev, ec);
> +		ret = cros_ec_sensorhub_register(dev, data);
>  	} else {
>  		ret = cros_ec_sensorhub_allocate_single_sensor(
>  				dev, "cros-ec-accel-legacy", 0);
>  		ret |= cros_ec_sensorhub_allocate_single_sensor(
>  				dev, "cros-ec-accel-legacy", 1);
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

Given the docs for prepare are all about stopping registration of children
etc, is this the right callback to use?

> + */
> +static int __maybe_unused cros_ec_ring_prepare(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
> +		return cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
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
> +		cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
> +}
> +
> +#if CONFIG_PM_SLEEP

I'm not sure that leaving the functions outside of the ifdef section
really helps.  The purpose of not using ifdef fun for them was that
it is easy to break. If we keep it here, the same is true.

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
> index 0000000000000..caf4b02d5e345
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -0,0 +1,412 @@
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
> +	if (sample->flag & MOTIONSENSE_SENSOR_FLAG_FLUSH)
> +		return 0;
> +
> +	return cb(indio_dev, sample->vector, sample->timestamp);
> +}
> +
> +/**
> + * Function to register the callback to the sensor hub.
> + * The callback cb will be used by cros_ec_sensorhub_ring to distribute events
> + * from the EC.
> + * @sensor_hub : Sensor Hub object
> + * @sensor_num : The sensor the caller is interested in.
> + * @indio_dev : The iio device to use when a sample arrives.
> + * @cb : The callback to call when a sample arrives.
> + */
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
> +
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
> +/**
> + * Enable or disable interrupt generation for FIFO events.
> + * To be called before sleeping or when noone is listening.

I'll stop commenting on these.  Make sure you run the kernel-doc
script and fix all the warnings and errors.

> + * @sensor_hub : Sensor Hub object
> + * @on : true when events are requested.
> + */
> +int cros_ec_sensorhub_ring_fifo_enable(
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
Drop the ret 'fiddling' out of the mutex.  Then you can return directly
> +	mutex_unlock(&sensorhub->cmd_lock);

if (ret < 0)
	return ret;

return 0;

> +
> +	return ret;
> +}
> +
> +/**
> + * cros_ec_ring_process_event: process one EC FIFO event
> + *
> + * Process one EC event, add it in the ring if necessary.
As in earlier patch.  I'm fairly sure the detailed explanation comes
after the parameters.
> + *
> + * @sensorhub: Sensorhub object.
> + * @fifo_info: fifo information from the EC (includes b point, EC timebase).
> + * @fifo_timestamp: EC IRQ, kernel timebase (aka c)
> + * @current_timestamp: calculated event timestamp, kernel timebase (aka a')
> + * @in: incoming FIFO event from EC (includes a point, EC timebase)
> + * @out: outgoing event to user space (includes a')
> + *
> + * Return true if out event has been populated.
> + */
> +static bool cros_ec_ring_process_event(
> +				struct cros_ec_sensorhub *sensorhub,
> +				const struct cros_ec_fifo_info *fifo_info,
> +				const ktime_t fifo_timestamp,
> +				ktime_t *current_timestamp,
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
> +	out->flag = in->flags;
> +	for (axis = 0; axis < 3; axis++)
> +		out->vector[axis] = in->data[axis];
> +
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
> +		if (cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg) < 0) {
> +			mutex_unlock(&sensorhub->cmd_lock);
> +			return;
> +		}
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
> +		mutex_unlock(&sensorhub->cmd_lock);
> +		return;
> +	}
> +
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
> +			break;
> +		}
> +		if (out + number_data >
> +		    sensorhub->ring + fifo_info->info.count) {
> +			dev_warn(sensorhub->dev,
> +				 "Too many samples: %d (%zd data) to %d entries for expected %d entries",
> +				 i, out - sensorhub->ring, i + number_data,
> +				 fifo_info->info.count);
> +			break;
> +		}
> +
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
> +				dev_warn_ratelimited(sensorhub->dev,
> +					"Sensor %d: lost: %d out of %d\n", i,
> +					lost, fifo_info->info.total_lost);
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
> +	sensorhub->fifo_timestamp[CROS_EC_SENSOR_NEW_TS] =
> +		ec_dev->last_event_time;
> +	cros_ec_sensorhub_ring_handler(sensorhub);
> +
> +	return NOTIFY_OK;
> +}
> +
> +/**
> + * Add/Remove the fifo functionality if the EC supports it.

This isn't kernel-doc.  Make it correct or drop the /**

> + * @sensor_hub : Sensor Hub object
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
> +			sizeof(*sensorhub->ring), GFP_KERNEL);
> +	if (!sensorhub->ring)
> +		return -ENOMEM;
> +
> +	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
> +		cros_ec_get_time_ns();

Hmm. Is the IIO standard timestamp selection attribute being exposed?
If so this is going to be confusing as we aren't obeying the selection
of clock from that..

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
> +	/* Start collection samples. */
> +	return cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
> +}
> +
> +int cros_ec_sensorhub_ring_remove(struct cros_ec_sensorhub *sensorhub)
> +{
> +	struct cros_ec_device *ec_dev = sensorhub->ec->ec_dev;
> +
> +	/* Disable the ring, prevent EC interrupt to the AP for nothing. */
> +	cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
> +	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
> +					   &sensorhub->notifier);
> +
> +	return 0;
> +}
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> index c18fba660bb62..595d010b58d95 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -8,6 +8,7 @@
>  #ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>  #define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
>  
> +#include <linux/iio/iio.h>
You could use a forwards def of 
struct iio_dev;

Instead and drop the include.
Perhaps it's not worth bothering though.


>  #include <linux/platform_data/cros_ec_commands.h>
>  
>  /**
> @@ -18,12 +19,88 @@ struct cros_ec_sensor_platform {
>  	u8 sensor_num;
>  };
>  
> +/**
> + * Callback function to send datum to specific sensors.
> + * @indio_dev: The IIO device that will process the sample.
> + * @data: vector array of the ring sample.
> + * @timestamp: Timestamp in host timespace when the sample was acquired by
> + *             the EC.
> + */
> +typedef int (*cros_ec_sensorhub_push_data_cb_t)(
> +		struct iio_dev *indio_dev,
> +		s16 *data,
> +		s64 timestamp);
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
>  /*
>   * struct cros_ec_sensorhub - Sensor Hub device data.
>   */
>  struct cros_ec_sensorhub {
> +	/* Device object, mostly used for logging. */
> +	struct device *dev;
> +
>  	/* Embedded Controller where the hub is located. */
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
> +	ktime_t fifo_timestamp[CROS_EC_SENSOR_ALL_TS];
> +	struct cros_ec_fifo_info fifo_info;
> +	int    fifo_size;
> +
> +	/*
> +	 * Dynamic array to be able to spread datum to iio sensor objects.
> +	 */
> +	struct cros_ec_sensorhub_sensor_push_data push_data[CROS_EC_SENSOR_MAX];
>  };
>  
> +int cros_ec_sensorhub_register_push_data(
> +		struct cros_ec_sensorhub *sensor_hub,
> +		u8 sensor_num,
> +		struct iio_dev *indio_dev,
> +		cros_ec_sensorhub_push_data_cb_t cb);
> +void cros_ec_sensorhub_unregister_push_data(
> +		struct cros_ec_sensorhub *sensor_hub,
> +		u8 sensor_num);
> +
> +int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensor_hub);
> +int cros_ec_sensorhub_ring_remove(struct cros_ec_sensorhub *sensor_hub);
> +int cros_ec_sensorhub_ring_fifo_enable(
> +		struct cros_ec_sensorhub *sensorhub,
> +		bool on);
> +
>  #endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */

