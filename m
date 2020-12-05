Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6B2CFC9F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLEQvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 11:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgLEQoq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 11:44:46 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA0CF23333;
        Sat,  5 Dec 2020 16:27:19 +0000 (UTC)
Date:   Sat, 5 Dec 2020 16:27:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: hid-sensors: Add hinge sensor driver
Message-ID: <20201205162716.54e3374e@archlinux>
In-Reply-To: <20201203035352.13918-3-xiang.ye@intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
        <20201203035352.13918-3-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Dec 2020 11:53:51 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> The Hinge sensor is a common custom sensor on laptops. It calculates
> the angle between the lid (screen) and the base (keyboard). In addition,
> it also exposes screen and the keyboard angles with respect to the
> ground. Applications can easily get laptop's status in space through
> this sensor, in order to display appropriate user interface.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

A few new comments inline.  This is coming together nicely now.

No great rush btw as IIO is effectively closed for this cycle
(merge window opens in about a week and everything needs some time
in linux-next).

We should be good to line this up early in the next cycle.

Thanks,

Jonathan

> ---
>  .../hid-sensors/hid-sensor-attributes.c       |   2 +
>  drivers/iio/position/Kconfig                  |  16 +
>  drivers/iio/position/Makefile                 |   1 +
>  .../position/hid-sensor-custom-intel-hinge.c  | 393 ++++++++++++++++++
>  4 files changed, 412 insertions(+)
>  create mode 100644 drivers/iio/position/hid-sensor-custom-intel-hinge.c
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 442ff787f7af..5b822a4298a0 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -71,6 +71,8 @@ static struct {
>  	{HID_USAGE_SENSOR_TEMPERATURE, HID_USAGE_SENSOR_UNITS_DEGREES, 1000, 0},
>  
>  	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
> +	{HID_USAGE_SENSOR_HINGE, 0, 0, 17453293},
> +	{HID_USAGE_SENSOR_HINGE, HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},
>  };
>  
>  static void simple_div(int dividend, int divisor, int *whole,
> diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> index eda67f008c5b..1576a6380b53 100644
> --- a/drivers/iio/position/Kconfig
> +++ b/drivers/iio/position/Kconfig
> @@ -16,4 +16,20 @@ config IQS624_POS
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called iqs624-pos.
>  
> +config HID_SENSOR_CUSTOM_INTEL_HINGE
> +	depends on HID_SENSOR_HUB
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select HID_SENSOR_IIO_COMMON
> +	select HID_SENSOR_IIO_TRIGGER
> +	tristate "HID Hinge"
> +	help
> +	  This sensor present three angles, hinge angel, screen angles
> +	  and keyboard angle respect to horizon (ground).
> +	  Say yes here to build support for the HID custom
> +	  intel hinge sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-sensor-custom-hinge.
> +
>  endmenu
> diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> index 3cbe7a734352..d70902f2979d 100644
> --- a/drivers/iio/position/Makefile
> +++ b/drivers/iio/position/Makefile
> @@ -4,4 +4,5 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  
> +obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
>  obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> new file mode 100644
> index 000000000000..7145e96ef6e0
> --- /dev/null
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HID Sensors Driver
> + * Copyright (c) 2020, Intel Corporation.
> + */
> +#include <linux/hid-sensor-hub.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/platform_device.h>
> +
> +#include "../common/hid-sensors/hid-sensor-trigger.h"
> +
> +enum hinge_channel {
> +	CHANNEL_SCAN_INDEX_HINGE_ANGLE,
> +	CHANNEL_SCAN_INDEX_SCREEN_ANGLE,
> +	CHANNEL_SCAN_INDEX_KEYBOARD_ANGLE,
> +	CHANNEL_SCAN_INDEX_MAX,
> +};
> +
> +#define CHANNEL_SCAN_INDEX_TIMESTAMP CHANNEL_SCAN_INDEX_MAX
> +
> +static const u32 hinge_addresses[CHANNEL_SCAN_INDEX_MAX] = {
> +	HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(1),
> +	HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(2),
> +	HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(3)
> +};
> +
> +struct hinge_state {
> +	struct iio_dev *indio_dev;
> +	struct hid_sensor_hub_attribute_info hinge[CHANNEL_SCAN_INDEX_MAX];
> +	struct hid_sensor_hub_callbacks callbacks;
> +	struct hid_sensor_common common_attributes;
> +	const char *labels[CHANNEL_SCAN_INDEX_MAX];
> +	struct {
> +		u32 hinge_val[3];
> +		u64 timestamp __aligned(8);
> +	} scan;
> +
> +	int scale_pre_decml;
> +	int scale_post_decml;
> +	int scale_precision;
> +	int value_offset;
> +	u64 timestamp;
> +};
> +
> +/* Channel definitions */
> +static const struct iio_chan_spec hinge_channels[] = {
> +	{ .type = IIO_ANGL,
Probably better to indent this a bit more (and don't worry too much about line length
	{
		.indexed = 1,
...

	}, {
	}
> +	  .indexed = 1,
> +	  .channel = 0,
> +	  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	  .info_mask_shared_by_type =
> +		  BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE) |
> +		  BIT(IIO_CHAN_INFO_SAMP_FREQ) | BIT(IIO_CHAN_INFO_HYSTERESIS),
> +
> +	  .scan_index = CHANNEL_SCAN_INDEX_HINGE_ANGLE },
> +	{ .type = IIO_ANGL,
> +	  .indexed = 1,
> +	  .channel = 1,
> +	  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	  .info_mask_shared_by_type =
> +		  BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE) |
> +		  BIT(IIO_CHAN_INFO_SAMP_FREQ) | BIT(IIO_CHAN_INFO_HYSTERESIS),
> +	  .scan_index = CHANNEL_SCAN_INDEX_SCREEN_ANGLE },
> +	{ .type = IIO_ANGL,
> +	  .indexed = 1,
> +	  .channel = 2,
> +	  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	  .info_mask_shared_by_type =
> +		  BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE) |
> +		  BIT(IIO_CHAN_INFO_SAMP_FREQ) | BIT(IIO_CHAN_INFO_HYSTERESIS),
> +	  .scan_index = CHANNEL_SCAN_INDEX_KEYBOARD_ANGLE },
> +
> +	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> +};
> +
> +/* Adjust channel real bits based on report descriptor */
> +static void hinge_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					  int channel, int size)
> +{
> +	channels[channel].scan_type.sign = 's';
> +	/* Real storage bits will change based on the report desc. */
> +	channels[channel].scan_type.realbits = size * 8;
> +	/* Maximum size of a sample to capture is u32 */
> +	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
Why are we 'adjusting' this or the sign marker above?  They appear
to be fixed. From this code I'd expect this function to only be
changing realbits.  The rest should be in the channel array template
you have above.

> +}
> +
> +/* Channel read_raw handler */
> +static int hinge_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val, int *val2,
> +			  long mask)
> +{
> +	struct hinge_state *st = iio_priv(indio_dev);
> +	struct hid_sensor_hub_device *hsdev;
> +	int report_id = -1;

Is there a path in which this is used where it isn't set before use?

> +	int ret_type;
> +	s32 min;
> +
> +	hsdev = st->common_attributes.hsdev;
> +
> +	*val = 0;
> +	*val2 = 0;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		hid_sensor_power_state(&st->common_attributes, true);
> +		report_id = st->hinge[chan->scan_index].report_id;
> +		min = st->hinge[chan->scan_index].logical_minimum;
> +		if (report_id < 0) {
> +			*val = 0;

If you return an error code the *val won't be used for anything so no
need to clear it.

Likewise, if you set type to IIO_VAL_INT, *val2 is not used by the core
so no need to ensure that is 0 either.

> +			hid_sensor_power_state(&st->common_attributes, false);
> +			return -EINVAL;
> +		}
> +
> +		*val = sensor_hub_input_attr_get_raw_value(
> +			st->common_attributes.hsdev, hsdev->usage,
> +			hinge_addresses[chan->scan_index], report_id,
> +			SENSOR_HUB_SYNC, min < 0);
> +
> +		hid_sensor_power_state(&st->common_attributes, false);
> +		ret_type = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->scale_pre_decml;
> +		*val2 = st->scale_post_decml;
> +		ret_type = st->scale_precision;
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = st->value_offset;
> +		ret_type = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret_type = hid_sensor_read_samp_freq_value(
> +			&st->common_attributes, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		ret_type = hid_sensor_read_raw_hyst_value(
> +			&st->common_attributes, val, val2);
> +		break;
> +	default:
> +		ret_type = -EINVAL;
> +		break;
> +	}
> +
> +	return ret_type;

Use returns in the switch statement.  Shorter more readable code.
(slightly!)

> +}
> +
> +/* Channel write_raw handler */
> +static int hinge_write_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int val, int val2,
> +			   long mask)
> +{
> +	struct hinge_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = hid_sensor_write_samp_freq_value(&st->common_attributes,
> +						       val, val2);
> +		break;
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		ret = hid_sensor_write_raw_hyst_value(&st->common_attributes,
> +						      val, val2);
> +
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;

Might as well use direct returns in the switch statement. Saves a
few lines of code and isn't any harder to read.
> +}
> +
> +static int hinge_read_label(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, char *label)
> +{
> +	struct hinge_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(label, "%s\n", st->labels[chan->channel]);
> +}
> +
> +static const struct iio_info hinge_info = {
> +	.read_raw = hinge_read_raw,
> +	.write_raw = hinge_write_raw,
> +	.read_label = hinge_read_label,
> +};
> +
> +/*
> + * Callback handler to send event after all samples are received
> + * and captured.
> + */
> +static int hinge_proc_event(struct hid_sensor_hub_device *hsdev,
> +			    unsigned int usage_id, void *priv)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(priv);
> +	struct hinge_state *st = iio_priv(indio_dev);
> +
> +	dev_dbg(&indio_dev->dev, "%s timestamp:%llu scan_bytes:%d\n", __func__,
> +		st->timestamp, indio_dev->scan_bytes);

This feels like left over debug that won't make a huge amount of
sense in a production driver. I'd drop it.

> +
> +	if (atomic_read(&st->common_attributes.data_ready)) {
> +		if (!st->timestamp)
> +			st->timestamp = iio_get_time_ns(indio_dev);
> +
> +		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
> +						   st->timestamp);
> +
> +		st->timestamp = 0;
> +	}
> +	return 0;
> +}
> +
> +/* Capture samples in local storage */
> +static int hinge_capture_sample(struct hid_sensor_hub_device *hsdev,
> +				unsigned int usage_id, size_t raw_len,
> +				char *raw_data, void *priv)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(priv);
> +	struct hinge_state *st = iio_priv(indio_dev);
> +	int offset;
> +
> +	switch (usage_id) {
> +	case HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(1):
> +	case HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(2):
> +	case HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(3):
> +		offset = usage_id - HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(1);
> +		st->scan.hinge_val[offset] = *(u32 *)raw_data;
> +		return 0;
> +	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
> +		st->timestamp = hid_sensor_convert_timestamp(
> +			&st->common_attributes, *(int64_t *)raw_data);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Can't get here that I can see so drop this final return.

> +}
> +
> +/* Parse report which is specific to an usage id */
> +static int hinge_parse_report(struct platform_device *pdev,
> +			      struct hid_sensor_hub_device *hsdev,
> +			      struct iio_chan_spec *channels,
> +			      unsigned int usage_id, struct hinge_state *st)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < CHANNEL_SCAN_INDEX_MAX; ++i) {
> +		ret = sensor_hub_input_get_attribute_info(
> +			hsdev, HID_INPUT_REPORT, usage_id, hinge_addresses[i],
> +			&st->hinge[i]);
> +		if (ret < 0)
> +			return ret;
> +
> +		hinge_adjust_channel_bit_mask(channels, i, st->hinge[i].size);
Superficially doesn't seem to be anything to do with a bit_mask?  Perhaps rename.
> +	}
> +
> +	st->scale_precision = hid_sensor_format_scale(
> +		HID_USAGE_SENSOR_HINGE,
> +		&st->hinge[CHANNEL_SCAN_INDEX_HINGE_ANGLE],
> +		&st->scale_pre_decml, &st->scale_post_decml);
> +
> +	/* Set Sensitivity field ids, when there is no individual modifier */
> +	if (st->common_attributes.sensitivity.index < 0) {
> +		sensor_hub_input_get_attribute_info(
> +			hsdev, HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +				HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(1),
> +			&st->common_attributes.sensitivity);
> +		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
> +			st->common_attributes.sensitivity.index,
> +			st->common_attributes.sensitivity.report_id);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Function to initialize the processing for usage id */
> +static int hid_hinge_probe(struct platform_device *pdev)
> +{
> +	struct hinge_state *st;
> +	struct iio_dev *indio_dev;
> +	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	st = iio_priv(indio_dev);
> +	st->common_attributes.hsdev = hsdev;
> +	st->common_attributes.pdev = pdev;
> +	st->indio_dev = indio_dev;
> +	st->labels[0] = "hinge";
> +	st->labels[1] = "screen";
> +	st->labels[2] = "keyboard";

As these are const, you should be fine I think to put them in a
static const array and just assign a pointer here.

> +
> +	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
> +						 &st->common_attributes);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to setup common attributes\n");
> +		return ret;
> +	}
> +
> +	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
> +	indio_dev->channels =
> +		kmemdup(hinge_channels, sizeof(hinge_channels), GFP_KERNEL);

devm_kmemdup - see below.

> +
> +	ret = hinge_parse_report(pdev, hsdev,
> +				 (struct iio_chan_spec *)indio_dev->channels,
> +				 hsdev->usage, st);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to setup attributes\n");
> +		goto error_out;

With devm_kmemdup will be able to return directly here.

> +	}
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &hinge_info;
> +	indio_dev->name = "hinge";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	atomic_set(&st->common_attributes.data_ready, 0);
> +	ret = hid_sensor_setup_trigger(indio_dev, indio_dev->name,
> +				       &st->common_attributes);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "trigger setup failed\n");
> +		goto error_out;

return directly with change as suggested above.

> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device register failed\n");
> +		goto error_remove_trigger;
> +	}
> +
> +	st->callbacks.send_event = hinge_proc_event;
> +	st->callbacks.capture_sample = hinge_capture_sample;
> +	st->callbacks.pdev = pdev;
> +	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &st->callbacks);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "callback reg failed\n");
> +		goto error_iio_unreg;
> +	}
> +	return ret;
> +
> +error_iio_unreg:
> +	iio_device_unregister(indio_dev);
> +error_remove_trigger:
> +	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
> +error_out:
> +	kfree(indio_dev->channels);
As mentioned below, use devm_kmemdup
> +	return ret;
> +}
> +
> +/* Function to deinitialize the processing for usage id */
> +static int hid_hinge_remove(struct platform_device *pdev)
> +{
> +	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct hinge_state *st = iio_priv(indio_dev);
> +
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
> +	iio_device_unregister(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
> +	kfree(indio_dev->channels);

As this is last, we could have ended up with the same order using
a devm_kmemdup for indio_dev->channels and had same result
with slightly simpler error handling etc.

> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id hid_hinge_ids[] = {
> +	{
> +		/* Format: HID-SENSOR-INT-usage_id_in_hex_lowercase */
> +		.name = "HID-SENSOR-INT-020b",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, hid_hinge_ids);
> +
> +static struct platform_driver hid_hinge_platform_driver = {
> +	.id_table = hid_hinge_ids,
> +	.driver = {
> +		.name	= KBUILD_MODNAME,
> +		.pm	= &hid_sensor_pm_ops,
> +	},
> +	.probe		= hid_hinge_probe,
> +	.remove		= hid_hinge_remove,
> +};
> +module_platform_driver(hid_hinge_platform_driver);
> +
> +MODULE_DESCRIPTION("HID Sensor Hinge");
> +MODULE_AUTHOR("Ye Xiang <xiang.ye@intel.com>");
> +MODULE_LICENSE("GPL");

