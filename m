Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5C1A689E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgDMPRP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:17:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60014 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgDMPRO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 11:17:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4064C2A0A02
Subject: Re: [PATCH] drivers: counter: Add Cros EC Sync counter
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, jic23@kernel.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200408053655.99957-1-gwendal@chromium.org>
 <20200411150032.GA9011@icarus>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d0a00268-ed54-1a5b-2c41-e1c058d36bea@collabora.com>
Date:   Mon, 13 Apr 2020 17:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200411150032.GA9011@icarus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal, William,

Thank you for the patch. Some few comments below.

On 11/4/20 17:00, William Breathitt Gray wrote:
> On Tue, Apr 07, 2020 at 10:36:55PM -0700, Gwendal Grignou wrote:
>> When the camera vsync pin is connected to the embedded controller (EC) of
>> a chromebook, the EC reports a sensor with a counter that increases
>> at each GPIO rising edge.
>>
>> The sensor is presented using the counter subsystem.
>> In addition, it is also presented via the IIO subsystem with a timestamp,
>> allowing synchronisation with sensors connected to the same EC, for
>> image stabilisation or augmented reality applications.
>>
>> To enable the counter:
>> via counter ABI:
>> echo "rising edge" > counterX/count0/signal_action
>> via iio ABI
>> echo 1 > iio:deviceY/en
>>
>> To disable the counter:
>> via counter ABI:
>> echo "none" > counterX/count0/signal_action
>> via iio ABI
>> echo 0 > iio:deviceY/en
>>
>> To read the current counter value:
>> via counter ABI:
>> cat counterX/count0/count
>> via iio ABI
>> cat iio:deviceY/in_count_raw
>> We can also read the value through the IIO buffer:
>> echo 1 > iio:deviceY/scan_elements/in_timestamp_en
>> echo 1 > iio:deviceY/scan_elements/in_count_en
>> echo 1 > iio:deviceY/buffer/enable
>>
>> and each time to counter increase, the following binary blob
>> will be appended to dev/iio:deviceY:
>> 000f 0000 0000 0000 dc66 816c 0071 0000
>>  \   <-- padding -> <-- timestamp ---->
>>   count
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> ---
>> An initial version of the driver was presented few month ago at
>> https://patchwork.kernel.org/patch/11037009/
>>
>>  drivers/counter/Kconfig                       |  11 +
>>  drivers/counter/Makefile                      |   1 +
>>  drivers/counter/cros_ec_sync.c                | 342 ++++++++++++++++++
>>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  15 +
>>  drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
>>  .../linux/iio/common/cros_ec_sensors_core.h   |   4 +-
>>  6 files changed, 375 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/counter/cros_ec_sync.c
> 
> Hi Gwendal,
> 
> I'm getting some conflicts when I try to merge this patch, so it looks
> like we're on different bases. Would you be able to rebase on the
> current testing branch of the IIO tree and resubmit this patch?
> 

I think this patch is based on latest patches from the chrome-platform tree,
those landed last week and are merged in current 5.7-rc1. I applies cleanly on
top of current 5.7-rc1 released yesterday.


> Thanks,
> 
> William Breathitt Gray
> 
>>
>> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
>> index c80fa76bb5311..18fde918ff40b 100644
>> --- a/drivers/counter/Kconfig
>> +++ b/drivers/counter/Kconfig
>> @@ -29,6 +29,17 @@ config 104_QUAD_8
>>  	  The base port addresses for the devices may be configured via the base
>>  	  array module parameter.
>>  
>> +config CROS_EC_SYNC
>> +	tristate "ChromeOS EC Counter driver"
>> +	depends on IIO_CROS_EC_SENSORS_CORE
>> +	help
>> +	  Module to handle synchronisation sensor presented by the ChromeOS EC
>> +	  Sensor hub.
>> +	  Synchronisation sensor sends event to the host when the camera
>> +	  take a picture. It allows synchronisation with other MEMS sensor,
>> +	  like gyroscope for image statbilization or augmented reality
>> +	  application (AR).
>> +
>>  config STM32_TIMER_CNT
>>  	tristate "STM32 Timer encoder counter driver"
>>  	depends on MFD_STM32_TIMERS || COMPILE_TEST
>> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
>> index 55142d1f4c436..98378fca50ad6 100644
>> --- a/drivers/counter/Makefile
>> +++ b/drivers/counter/Makefile
>> @@ -6,6 +6,7 @@
>>  obj-$(CONFIG_COUNTER) += counter.o
>>  
>>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>> +obj-$(CONFIG_CROS_EC_SYNC)	+= cros_ec_sync.o
>>  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
>>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
>>  obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
>> diff --git a/drivers/counter/cros_ec_sync.c b/drivers/counter/cros_ec_sync.c
>> new file mode 100644
>> index 0000000000000..94b3ababab4bd
>> --- /dev/null
>> +++ b/drivers/counter/cros_ec_sync.c
>> @@ -0,0 +1,342 @@
>> +// SPDX-License-Identifier: GPL-2.0

Following other ChromeOS drivers this should be GPL-2.0-only

>> +/*
>> + * Driver for synchronisation sensor behind CrOS EC.
>> + *
>> + * Copyright 2020 Google, Inc

Copyright 2020 Google LLC.

>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *

Remove the license boiler plate it is redundand and already specified in the
SPDX license tag.

>> + * This driver uses the cros-ec interface to communicate with the Chrome OS
>> + * EC about counter sensors. Counters are presented through
>> + * iio sysfs.
>> + */
>> +
>> +#include <linux/counter.h>
>> +#include <linux/device.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/common/cros_ec_sensors_core.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_data/cros_ec_commands.h>
>> +#include <linux/platform_data/cros_ec_proto.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +/*
>> + * One channel for counter, the other for timestamp.
>> + */
>> +#define MAX_CHANNELS (1 + 1)
>> +
>> +/**
>> + * struct cros_ec_sync_state - device structure
>> + *
>> + * @core: common structure for all cros_ec sensor.
>> + *        Must be at the beggining.
>> + * @channels: presented iio channels(2).
>> + * @counter: counter data structure.
>> + */
>> +struct cros_ec_sync_state {
>> +	struct cros_ec_sensors_core_state core;
>> +	struct iio_chan_spec channels[MAX_CHANNELS];
>> +	struct counter_device counter;
>> +};
>> +
>> +/**
>> + * cros_ec_sync_get_enable() - Check if the counter is enabled.
>> + *
>> + * @st:     core cros_ec sensor
>> + * @val:    status: 0: disabled, 1 enabled.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +static int cros_ec_sync_get_enable(struct cros_ec_sensors_core_state *st,
>> +				   int *val)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&st->cmd_lock);
>> +	st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
>> +	st->param.sensor_odr.data = EC_MOTION_SENSE_NO_VALUE;
>> +
>> +	ret = cros_ec_motion_send_host_cmd(st, 0);
>> +	mutex_unlock(&st->cmd_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = !!st->resp->sensor_odr.ret;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cros_ec_sync_set_enable() - Allow the counter to count.
>> + *
>> + * When enable, the counter will increase for each VSYNC rising edge
>> + * and will produce an event in the iio buffer, if enabled.
>> + *
>> + * @st:     core cros_ec sensor
>> + * @val:    0: disable, 1 enable.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +static int cros_ec_sync_set_enable(struct cros_ec_sensors_core_state *st,
>> +				   int val)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&st->cmd_lock);
>> +	st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
>> +	st->param.sensor_odr.data = val;
>> +	st->param.sensor_odr.roundup = 1;
>> +
>> +	ret = cros_ec_motion_send_host_cmd(st, 0);
>> +	mutex_unlock(&st->cmd_lock);
>> +	return ret;
>> +}
>> +
>> +static int cros_ec_sync_iio_read(struct iio_dev *indio_dev,
>> +				 struct iio_chan_spec const *chan,
>> +				 int *val, int *val2, long mask)
>> +{
>> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>> +	u16 data;
>> +	int ret;
>> +	int idx = chan->scan_index;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&st->cmd_lock);

I think you need to review the mutex locking logic.

>> +		ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx, &data);
>> +		mutex_unlock(&st->cmd_lock);
>> +		if (ret < 0)
>> +			break;
>> +		ret = IIO_VAL_INT;
>> +		*val = data;
>> +		break;
>> +	case IIO_CHAN_INFO_ENABLE:
>> +		ret = cros_ec_sync_get_enable(st, val);
>> +		if (ret < 0)
>> +			break;
>> +		ret = IIO_VAL_INT;
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +	mutex_unlock(&st->cmd_lock);

Where did you lock the mutex?

>> +	return ret;
>> +}
>> +
>> +static int cros_ec_sync_iio_write(struct iio_dev *indio_dev,
>> +				  struct iio_chan_spec const *chan,
>> +				  int val, int val2, long mask)
>> +{
>> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_ENABLE:
>> +		if (val < 0 || val > 1)
>> +			return -EINVAL;
>> +
>> +		return cros_ec_sync_set_enable(st, val);
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_info cros_ec_sync_info = {
>> +	.read_raw = &cros_ec_sync_iio_read,
>> +	.write_raw = &cros_ec_sync_iio_write,
>> +};
>> +
>> +/* The counter can only increase, so only one function present. */
>> +static enum counter_count_function cros_ec_sync_functions[] = {
>> +	COUNTER_COUNT_FUNCTION_INCREASE,
>> +};
>> +
>> +/* 2 synapse actions allowed: count for each rising edge, or not. */
>> +static enum counter_synapse_action cros_ec_sync_synapse_actions[] = {
>> +	COUNTER_SYNAPSE_ACTION_NONE,
>> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>> +};
>> +
>> +static int cros_ec_sync_read_count(struct counter_device *counter,
>> +				   struct counter_count *count,
>> +				   unsigned long *val)
>> +{
>> +	struct cros_ec_sensors_core_state *st = counter->priv;
>> +	u16 raw;
>> +	int ret;
>> +
>> +	mutex_lock(&st->cmd_lock);
>> +	ret = cros_ec_sensors_read_cmd(iio_priv_to_dev(st), 1, &raw);
>> +	mutex_unlock(&st->cmd_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = raw;
>> +	return 0;
>> +}
>> +
>> +static int cros_ec_sync_function_get(struct counter_device *counter,
>> +				     struct counter_count *count,
>> +				     size_t *function)
>> +{
>> +	*function = 0;
>> +	return 0;
>> +}
>> +
>> +static int cros_ec_sync_action_get(struct counter_device *counter,
>> +				   struct counter_count *count,
>> +				   struct counter_synapse *synapse,
>> +				   size_t *action)
>> +{
>> +	struct cros_ec_sensors_core_state *st = counter->priv;
>> +	int ret;
>> +	int raw;
>> +
>> +	ret = cros_ec_sync_get_enable(st, &raw);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*action = !!raw;
>> +	return 0;
>> +}
>> +
>> +static int cros_ec_sync_action_set(struct counter_device *counter,
>> +				   struct counter_count *count,
>> +				   struct counter_synapse *synapse,
>> +				   size_t action)
>> +{
>> +	struct cros_ec_sensors_core_state *st = counter->priv;
>> +
>> +	return cros_ec_sync_set_enable(st, action);
>> +}
>> +
>> +static const struct counter_ops cros_ec_sync_ops = {
>> +	.count_read = cros_ec_sync_read_count,
>> +	.function_get = cros_ec_sync_function_get,
>> +	.action_get = cros_ec_sync_action_get,
>> +	.action_set = cros_ec_sync_action_set,
>> +};
>> +
>> +static struct counter_signal cros_ec_sync_signals[] = {
>> +	{
>> +		.id = 0,
>> +		.name = "vsync"
>> +	}
>> +};
>> +
>> +static struct counter_synapse cros_ec_sync_synapses[] = {
>> +	{
>> +		.actions_list = cros_ec_sync_synapse_actions,
>> +		.num_actions = ARRAY_SIZE(cros_ec_sync_synapse_actions),
>> +		.signal = cros_ec_sync_signals
>> +	}
>> +};
>> +
>> +static struct counter_count cros_ec_sync_counts[] = {
>> +	{
>> +		.id = 0,
>> +		.name = "vsync",
>> +		.functions_list = cros_ec_sync_functions,
>> +		.num_functions = ARRAY_SIZE(cros_ec_sync_functions),
>> +		.synapses = cros_ec_sync_synapses,
>> +		.num_synapses = ARRAY_SIZE(cros_ec_sync_synapses),
>> +	}
>> +};
>> +
>> +static int cros_ec_sync_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct cros_ec_sync_state *state;
>> +	struct iio_chan_spec *channel;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
>> +					cros_ec_sensors_capture,
>> +					cros_ec_sensors_push_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	indio_dev->info = &cros_ec_sync_info;
>> +	state = iio_priv(indio_dev);
>> +
>> +	/* Initialize IIO device */
>> +	channel = state->channels;
>> +
>> +	/* Counter channel */
>> +	channel->type = IIO_COUNT;
>> +	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> +	channel->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_ENABLE);
>> +	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
>> +	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
>> +	channel->scan_type.shift = 0;
>> +	channel->scan_index = 0;
>> +	channel->ext_info = cros_ec_sensors_limited_info;
>> +	channel->scan_type.sign = 'u';
>> +
>> +	/* Timestamp channel */
>> +	channel++;
>> +	channel->type = IIO_TIMESTAMP;
>> +	channel->channel = -1;
>> +	channel->scan_index = 1;
>> +	channel->scan_type.sign = 's';
>> +	channel->scan_type.realbits = 64;
>> +	channel->scan_type.storagebits = 64;
>> +
>> +	indio_dev->channels = state->channels;
>> +	indio_dev->num_channels = MAX_CHANNELS;
>> +
>> +	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>> +
>> +	/* Initialize Counter device */
>> +	state->counter.name = dev_name(&pdev->dev);
>> +	state->counter.parent = &pdev->dev;
>> +	state->counter.ops = &cros_ec_sync_ops;
>> +	state->counter.counts = cros_ec_sync_counts;
>> +	state->counter.num_counts = ARRAY_SIZE(cros_ec_sync_counts);
>> +	state->counter.signals = cros_ec_sync_signals;
>> +	state->counter.num_signals = ARRAY_SIZE(cros_ec_sync_signals);
>> +	state->counter.priv = state;
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_counter_register(dev, &state->counter);
>> +}
>> +
>> +static const struct platform_device_id cros_ec_sync_ids[] = {
>> +	{
>> +		.name = "cros-ec-sync",
>> +	},
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, cros_ec_sync_ids);
>> +
>> +static struct platform_driver cros_ec_sync_platform_driver = {
>> +	.driver = {
>> +		.name	= "cros-ec-sync",
>> +	},
>> +	.probe		= cros_ec_sync_probe,
>> +	.id_table	= cros_ec_sync_ids,
>> +};
>> +module_platform_driver(cros_ec_sync_platform_driver);
>> +
>> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
>> +MODULE_DESCRIPTION("ChromeOS EC synchronisation sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> index c831915ca7e56..3a15094616710 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> @@ -31,6 +31,7 @@
>>  static char *cros_ec_loc[] = {
>>  	[MOTIONSENSE_LOC_BASE] = "base",
>>  	[MOTIONSENSE_LOC_LID] = "lid",
>> +	[MOTIONSENSE_LOC_CAMERA] = "camera",
>>  	[MOTIONSENSE_LOC_MAX] = "unknown",
>>  };
>>  
>> @@ -467,6 +468,20 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
>>  };
>>  EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
>>  
>> +const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] = {
>> +	{
>> +		.name = "id",
>> +		.shared = IIO_SHARED_BY_ALL,
>> +		.read = cros_ec_sensors_id
>> +	},
>> +	{
>> +		.name = "location",
>> +		.shared = IIO_SHARED_BY_ALL,
>> +		.read = cros_ec_sensors_loc
>> +	},
>> +	{ },
>> +};
>> +EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
>>  /**
>>   * cros_ec_sensors_idx_to_reg - convert index into offset in shared memory
>>   * @st:		pointer to state information for device
>> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
>> index b7f2c00db5e1e..e4ae0868d1e06 100644
>> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
>> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
>> @@ -106,6 +106,9 @@ static int cros_ec_sensorhub_register(struct device *dev,
>>  		case MOTIONSENSE_TYPE_ACTIVITY:
>>  			name = "cros-ec-activity";
>>  			break;
>> +		case MOTIONSENSE_TYPE_SYNC:
>> +			name = "cros-ec-sync";
>> +			break;
>>  		default:
>>  			dev_warn(dev, "unknown type %d\n",
>>  				 sensorhub->resp->info.type);
>> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
>> index 7bc961defa87e..e416b28cf24c7 100644
>> --- a/include/linux/iio/common/cros_ec_sensors_core.h
>> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
>> @@ -114,7 +114,9 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>>  			       struct iio_chan_spec const *chan,
>>  			       int val, int val2, long mask);
>>  
>> -/* List of extended channel specification for all sensors */
>> +/* List of extended channel specification for all sensors. */
>> +extern const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[];
>> +/* Add calibration to set above. */

This change is unrelated to this patch.

>>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
>>  extern const struct attribute *cros_ec_sensor_fifo_attributes[];
>>  
>> -- 
>> 2.26.0.110.g2183baf09c-goog
>>

Thanks,
 Enric
