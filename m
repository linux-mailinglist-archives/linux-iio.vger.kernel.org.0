Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA63E2C1E71
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 07:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgKXGmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 01:42:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:8276 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgKXGmg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Nov 2020 01:42:36 -0500
IronPort-SDR: V/jtkrkSqUbjncdDl4SEEpYobPIbEyKz53UIlAqLHaUb5F0f7kPyvZvYOZKrLrj9V+3BWk5R/c
 66pDJd81bF+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="159666288"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="159666288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:42:35 -0800
IronPort-SDR: GoTYPkIb+AhNNrsLKZIFomoT5lTFYM70XVBjJxxmvD0Ab06CexXAl86YyZLRLOwW+nd37Y2ENc
 jm0h9DEM4Gxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="546717974"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2020 22:42:33 -0800
Date:   Tue, 24 Nov 2020 14:43:32 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: hid-sensors: Add hinge sensor driver
Message-ID: <20201124064332.GA21403@host>
References: <20201119100331.2594-1-xiang.ye@intel.com>
 <20201119100331.2594-5-xiang.ye@intel.com>
 <20201121175629.057031af@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121175629.057031af@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 05:56:29PM +0000, Jonathan Cameron wrote:
> On Thu, 19 Nov 2020 18:03:31 +0800
> Ye Xiang <xiang.ye@intel.com> wrote:
> 
> > The Hinge sensor is a common custom sensor on laptops. It calculates
> > the angle between the lid (screen) and the base (keyboard). In addition,
> > it also exposes screen and the keyboard angels with respect to the
> > ground. Applications can easily get laptop's status in space through
> > this sensor, in order to display appropriate user interface.
> 
> I'm a little unclear on why the 3 axes aren't treated as a single sensor.
> You seem to always grab the 3 together or am I missing something?
> 
> That will greatly simplify things and get rid of the need to have
> a shared trigger with the problems that causes in the previous
> patch.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> > ---
> >  .../hid-sensors/hid-sensor-attributes.c       |   2 +
> >  drivers/iio/position/Kconfig                  |  16 +
> >  drivers/iio/position/Makefile                 |   3 +
> >  .../iio/position/hid-sensor-custom-hinge.c    | 412 ++++++++++++++++++
> 
> Given it's custom probably needs a more specific name.  I guess
> hid-sensor-custom-intel-hinge.c might be safe?
> 
> Same for other places we need names in here.
agree, will change the name to hid-sensor-custom-intel-hinge.c
> 
> >  4 files changed, 433 insertions(+)
> >  create mode 100644 drivers/iio/position/hid-sensor-custom-hinge.c
> > 
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index 442ff787f7af..5b822a4298a0 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -71,6 +71,8 @@ static struct {
> >  	{HID_USAGE_SENSOR_TEMPERATURE, HID_USAGE_SENSOR_UNITS_DEGREES, 1000, 0},
> >  
> >  	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
> > +	{HID_USAGE_SENSOR_HINGE, 0, 0, 17453293},
> > +	{HID_USAGE_SENSOR_HINGE, HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},
> >  };
> >  
> >  static void simple_div(int dividend, int divisor, int *whole,
> > diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> > index eda67f008c5b..0346f6f2b422 100644
> > --- a/drivers/iio/position/Kconfig
> > +++ b/drivers/iio/position/Kconfig
> > @@ -16,4 +16,20 @@ config IQS624_POS
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called iqs624-pos.
> >  
> > +config HID_SENSOR_CUSTOM_HINGE
> > +	depends on HID_SENSOR_HUB
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	select HID_SENSOR_IIO_COMMON
> > +	select HID_SENSOR_IIO_TRIGGER
> > +	tristate "HID Hinge"
> > +	help
> > +	  This sensor present three angles, hinge angel, screen angles
> > +	  and keyboard angle respect to horizon (ground).
> > +	  Say yes here to build support for the HID SENSOR CUSTOM
> > +	  HINGE.
> 
> Capitalization is a bit odd looking. I'd drop it.
ok, will use lowercase.
> 
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called hid-sensor-custom-hinge.
> > +
> >  endmenu
> > diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> > index 3cbe7a734352..7a6225977a01 100644
> > --- a/drivers/iio/position/Makefile
> > +++ b/drivers/iio/position/Makefile
> > @@ -5,3 +5,6 @@
> >  # When adding new entries keep the list in alphabetical order
> >  
> >  obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
> > +
> > +obj-$(CONFIG_HID_SENSOR_CUSTOM_HINGE) += hid-sensor-custom-hinge.o
> 
> Alphabetical order preferred.
> 
> > +ccflags-y	+= -I$(srctree)/drivers/iio/common/hid-sensors
> 
> Why?
hinge driver need to include #include "hid-sensor-trigger.h", if not using this cflag-y
it should be #include "../common/hid-sensors/hid-sensor-trigger.h"

> 
> > diff --git a/drivers/iio/position/hid-sensor-custom-hinge.c b/drivers/iio/position/hid-sensor-custom-hinge.c
> > new file mode 100644
> > index 000000000000..a91b333f36fa
> > --- /dev/null
> > +++ b/drivers/iio/position/hid-sensor-custom-hinge.c
> > @@ -0,0 +1,412 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * HID Sensors Driver
> > + * Copyright (c) 2020, Intel Corporation.
> > + */
> > +#include <linux/hid-sensor-hub.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "hid-sensor-trigger.h"
> > +
> > +/* Channel definitions */
> > +static const struct iio_chan_spec hinge_channels[] = {
> > +	{ .type = IIO_ANGL,
> > +	  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	  .info_mask_shared_by_type =
> > +		  BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE) |
> > +		  BIT(IIO_CHAN_INFO_SAMP_FREQ) | BIT(IIO_CHAN_INFO_HYSTERESIS),
> > +	  .scan_type.realbits = 16,
> > +	  .scan_type.storagebits = 32,
> 
> It a bit odd to see a single channel that is 16 bits inside a 32 bit with
> no shift or similar.  Why not just pack it into 16 bits?
As it's said in last email, will use one iio device with three labeled channel
then will not hard code the realbits and storagebits.

> 
> > +	  .scan_type.sign = 's',
> > +	  .scan_index = 0 },
> > +
> > +	IIO_CHAN_SOFT_TIMESTAMP(1)
> > +};
> > +
> > +struct hinge_state {
> > +	struct iio_dev *indio_dev;
> > +	struct hid_sensor_hub_attribute_info hinge;
> > +	/* Reserve for 1 channel + pading + timestamp */
> > +	u32 hinge_val[1 + 3];
> 
> __aligned(8)
> 
> see below for requirements on this.
> Perhaps better to use
> 
> 	struct hinge_scan {
> 		u32 val;
> 		s64 timestamp __aligned(8); // Note this is needed for x86_32
> 	} scan;
>
This patch use hard code pading for align(8)
I think your method this is a good choice, will use it thanks.

> > +	int scale_pre_decml;
> > +	int scale_post_decml;
> > +	int scale_precision;
> > +	int value_offset;
> > +	int64_t timestamp;
> > +	u32 hinge_address;
> > +};
> > +
> > +#define IIO_DEV_NUM 3
> 
> That needs a prefix to make it clear it's not a generic constant
> but is specific to this driver.
Will use one iio device, so this macro will be abandon.

> 
> > +
> > +struct hinge_group {
> > +	struct hinge_state *hg_states[IIO_DEV_NUM];
> > +	struct hid_sensor_hub_callbacks callbacks;
> > +	struct hid_sensor_common common_attributes;
> > +};
> > +
> > +static struct hinge_group *hg_group;
> 
> We shouldn't see globals like this. Please figure out how to avoid it.
ditto
> 
> > +
> > +/* Channel read_raw handler */
> > +static int hinge_read_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan, int *val, int *val2,
> > +			  long mask)
> > +{
> > +	struct hinge_state *hg_state = iio_priv(indio_dev);
> > +	struct hid_sensor_hub_device *hsdev;
> > +	int report_id = -1;
> > +	int ret_type;
> > +	s32 min;
> > +
> > +	hsdev = hg_group->common_attributes.hsdev;
> > +
> > +	*val = 0;
> > +	*val2 = 0;
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		hid_sensor_power_state(&hg_group->common_attributes, true);
> > +		report_id = hg_state->hinge.report_id;
> > +		min = hg_state->hinge.logical_minimum;
> > +		if (report_id < 0) {
> > +			*val = 0;
> > +			hid_sensor_power_state(&hg_group->common_attributes,
> > +					       false);
> > +			return -EINVAL;
> > +		}
> > +
> > +		*val = sensor_hub_input_attr_get_raw_value(
> > +			hg_group->common_attributes.hsdev, hsdev->usage,
> > +			hg_state->hinge_address, report_id, SENSOR_HUB_SYNC,
> > +			min < 0);
> > +
> > +		hid_sensor_power_state(&hg_group->common_attributes, false);
> > +		ret_type = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = hg_state->scale_pre_decml;
> > +		*val2 = hg_state->scale_post_decml;
> > +		ret_type = hg_state->scale_precision;
> > +		break;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*val = hg_state->value_offset;
> > +		ret_type = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		ret_type = hid_sensor_read_samp_freq_value(
> > +			&hg_group->common_attributes, val, val2);
> > +		break;
> > +	case IIO_CHAN_INFO_HYSTERESIS:
> > +		ret_type = hid_sensor_read_raw_hyst_value(
> > +			&hg_group->common_attributes, val, val2);
> > +		break;
> > +	default:
> > +		ret_type = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret_type;
> > +}
> > +
> > +/* Channel write_raw handler */
> > +static int hinge_write_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan, int val, int val2,
> > +			   long mask)
> > +{
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		ret = hid_sensor_write_samp_freq_value(
> > +			&hg_group->common_attributes, val, val2);
> > +		break;
> > +	case IIO_CHAN_INFO_HYSTERESIS:
> > +		ret = hid_sensor_write_raw_hyst_value(
> > +			&hg_group->common_attributes, val, val2);
> > +
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info hinge_info = {
> > +	.read_raw = &hinge_read_raw,
> > +	.write_raw = &hinge_write_raw,
> > +};
> > +
> > +/*
> > + * Function to push data to buffer;
> > + * wrapper added for symmetry with other hid-sensor drivers
> > + */
> > +static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data, int len,
> 
> This doesn't seem to be generic, so don't name it as such.
got it.
> 
> > +				 int64_t timestamp)
> > +{
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> I hope that data buffer obeys the various rules needed by (and admittedly
> not that well documented) iio_push_to_buffers_with_timestamp()
> 
> 1. Needs to be 8 byte aligned.
> 2. Needs to have space for an aligned 8 byte timestamp at the end.
yes, it use a padding to make it align to 8byte. As is said before
, will use your recommend method instead.
> 
> > +}
> > +
> > +/*
> > + * Callback handler to send event after all samples are received
> > + * and captured.
> > + */
> > +static int hinge_proc_event(struct hid_sensor_hub_device *hsdev,
> > +			    unsigned int usage_id, void *priv)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < IIO_DEV_NUM; ++i) {
> If we push for all sensors together, better to have
> this as a single iio_device with 3 channels.
> 
> Use the channel labels (just added to IIO) to identify which is which.
Will try to use channel labels

> 
> > +		struct hinge_state *hg_state;
> > +		struct iio_dev *indio_dev;
> > +
> > +		hg_state = hg_group->hg_states[i];
> > +		indio_dev = hg_state->indio_dev;
> > +
> > +		dev_dbg(&indio_dev->dev, "%s timestamp:%llu scan_bytes:%d\n",
> > +			__func__, hg_state->timestamp, indio_dev->scan_bytes);
> > +
> > +		if (!hg_state->timestamp)
> > +			hg_state->timestamp = iio_get_time_ns(indio_dev);
> > +
> > +		hid_sensor_push_data(indio_dev, hg_state->hinge_val,
> > +				     sizeof(hg_state->hinge_val),
> > +				     hg_state->timestamp);
> > +
> > +		hg_state->timestamp = 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Capture samples in local storage */
> > +static int hinge_capture_sample(struct hid_sensor_hub_device *hsdev,
> > +				unsigned int usage_id, size_t raw_len,
> > +				char *raw_data, void *priv)
> > +{
> > +	struct hinge_state *hg_state;
> > +	int offset;
> > +	int ret = -EINVAL;
> > +	int i;
> > +
> > +	if (usage_id == HID_USAGE_SENSOR_TIME_TIMESTAMP) {
> > +		for (i = 0; i < IIO_DEV_NUM; i++)
> > +			hg_group->hg_states[i]->timestamp =
> 
> This rather implies all the data is captured together... If so single
> iio_device may make more sense.
will use one iio device with three channel.
> 
> > +				hid_sensor_convert_timestamp(
> > +					&hg_group->common_attributes,
> > +					*(int64_t *)raw_data);
> > +		return 0;
> > +	}
> > +
> > +	switch (usage_id) {
> > +	case HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1:
> > +	case HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_2:
> > +	case HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_3:
> > +		offset = usage_id - HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1;
> > +		hg_state = hg_group->hg_states[offset];
> > +		hg_state->hinge_val[0] = *(u32 *)raw_data;
> > +		ret = 0;
> 
> 		return 0;
> 
> > +		break;
> > +	default:
> 		return -EINVAL;
ok, but i think it's the same..

> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/* Parse report which is specific to an usage id */
> > +static int hinge_parse_report(struct platform_device *pdev,
> > +			      struct hid_sensor_hub_device *hsdev,
> > +			      unsigned int usage_id, unsigned int attr_usage_id,
> > +			      struct hinge_state *st)
> > +{
> > +	int ret;
> > +
> > +	ret = sensor_hub_input_get_attribute_info(
> > +		hsdev, HID_INPUT_REPORT, usage_id, attr_usage_id, &st->hinge);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	st->hinge_address = attr_usage_id;
> > +	st->scale_precision =
> > +		hid_sensor_format_scale(HID_USAGE_SENSOR_HINGE, &st->hinge,
> > +					&st->scale_pre_decml,
> > +					&st->scale_post_decml);
> > +
> > +	/* Set Sensitivity field ids, when there is no individual modifier */
> > +	if (hg_group->common_attributes.sensitivity.index < 0) {
> > +		sensor_hub_input_get_attribute_info(
> > +			hsdev, HID_FEATURE_REPORT, usage_id,
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> > +				HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1,
> > +			&hg_group->common_attributes.sensitivity);
> > +		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
> > +			hg_group->common_attributes.sensitivity.index,
> > +			hg_group->common_attributes.sensitivity.report_id);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/* Function to initialize the processing for usage id */
> > +static int hinge_add_iio_device(struct platform_device *pdev, int index,
> > +				const char *name, struct hinge_state **st)
> > +{
> > +	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> > +	struct hinge_state *hg_state;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev =
> > +		devm_iio_device_alloc(&pdev->dev, sizeof(struct hinge_state));
> 
> sizeof (*hg_state) preferred.
got it.
> 
> > +	if (indio_dev == NULL)
> > +		return -ENOMEM;
> > +
> > +	hg_state = iio_priv(indio_dev);
> > +	hg_state->indio_dev = indio_dev;
> > +
> > +	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
> > +	indio_dev->channels =
> > +		kmemdup(hinge_channels, sizeof(hinge_channels), GFP_KERNEL);
> 
> I don't immediately see anything that is modifying channels. As such you
> should be able have it shared by all the instances.
will try to use one iio device.
> 
> > +	if (!indio_dev->channels)
> > +		return -ENOMEM;
> > +
> > +	ret = hinge_parse_report(
> > +		pdev, hsdev, hsdev->usage,
> > +		HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1 + index, hg_state);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to setup attributes\n");
> > +		goto error_free_dev_mem;
> > +	}
> > +
> > +	indio_dev->dev.parent = &pdev->dev;
> > +	indio_dev->info = &hinge_info;
> > +	indio_dev->name = name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = hid_sensor_setup_trigger(indio_dev, name,
> > +				       &hg_group->common_attributes);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "trigger setup failed\n");
> > +		goto error_free_dev_mem;
> > +	}
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "device register failed\n");
> > +		goto error_remove_trigger;
> > +	}
> > +
> > +	*st = hg_state;
> > +
> > +	return ret;
> > +
> > +error_remove_trigger:
> > +	hid_sensor_remove_trigger(indio_dev, &hg_group->common_attributes);
> > +error_free_dev_mem:
> > +	kfree(indio_dev->channels);
> > +	return ret;
> > +}
> > +
> > +/* Function to deinitialize the processing for usage id */
> > +static int hinge_remove_iio_device(struct platform_device *pdev, int index)
> > +{
> > +	struct hinge_state *hg_state = hg_group->hg_states[index];
> > +	struct iio_dev *indio_dev = hg_state->indio_dev;
> > +
> > +	iio_device_unregister(indio_dev);
> > +	hid_sensor_remove_trigger(indio_dev, &hg_group->common_attributes);
> > +	kfree(indio_dev->channels);
> > +
> > +	return 0;
> > +}
> > +
> > +static int hid_hinge_probe(struct platform_device *pdev)
> > +{
> > +	struct hinge_state *hg_state;
> > +	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> > +	static const char *const names[] = { "hinge", "screen", "keyboard" };
> > +	int ret;
> > +	int i;
> > +
> > +	hg_group = devm_kzalloc(&pdev->dev, sizeof(struct hinge_group),
> > +				GFP_KERNEL);
> 
> As mentioned above, I'd really not expect to see a global like this.
> Technically nothing stops there being more than one instance of this
> device on a platform (even if that would be a bit odd) + it's almost
> always cleaner to not use a global in the first place.
using one iio device can avoid using the global variable.

> 
> > +	if (!hg_group)
> > +		return -ENOMEM;
> > +
> > +	hg_group->common_attributes.hsdev = hsdev;
> > +	hg_group->common_attributes.pdev = pdev;
> > +
> > +	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
> > +						 &hg_group->common_attributes);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to setup common attributes\n");
> > +		return ret;
> > +	}
> > +
> > +	atomic_set(&hg_group->common_attributes.data_ready, 0);
> > +	for (i = 0; i < IIO_DEV_NUM; i++) {
> > +		ret = hinge_add_iio_device(pdev, i, names[i], &hg_state);
> > +		if (ret)
> > +			goto err_probe;
> > +
> > +		hg_group->hg_states[i] = hg_state;
> > +	}
> > +
> > +	/* use the first iio device to do the PM */
> > +	platform_set_drvdata(pdev, hg_group->hg_states[0]->indio_dev);
> > +
> > +	hg_group->callbacks.send_event = hinge_proc_event;
> > +	hg_group->callbacks.capture_sample = hinge_capture_sample;
> > +	hg_group->callbacks.pdev = pdev;
> > +	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
> > +					   &hg_group->callbacks);
> > +	if (ret < 0)
> > +		dev_err(&pdev->dev, "callback reg failed\n");
> > +
> > +	return ret;
> > +
> > +err_probe:
> > +	for (i--; i >= 0; i--)
> > +		hinge_remove_iio_device(pdev, i);
> > +
> > +	return ret;
> > +}
> > +
> > +/* Function to deinitialize the processing for usage id */
> > +static int hid_hinge_remove(struct platform_device *pdev)
> > +{
> > +	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> > +	int i;
> > +
> > +	sensor_hub_remove_callback(hsdev, hsdev->usage);
> > +
> > +	for (i = 0; i < IIO_DEV_NUM; i++)
> > +		hinge_remove_iio_device(pdev, i);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct platform_device_id hid_hinge_ids[] = {
> > +	{
> > +		/* Format: HID-SENSOR-INT-usage_id_in_hex_lowercase */
> > +		.name = "HID-SENSOR-INT-020b",
> > +	},
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, hid_hinge_ids);
> > +
> > +static struct platform_driver hid_hinge_platform_driver = {
> > +	.id_table = hid_hinge_ids,
> > +	.driver = {
> > +		.name	= KBUILD_MODNAME,
> > +		.pm	= &hid_sensor_pm_ops,
> > +	},
> > +	.probe		= hid_hinge_probe,
> > +	.remove		= hid_hinge_remove,
> > +};
> > +module_platform_driver(hid_hinge_platform_driver);
> > +
> > +MODULE_DESCRIPTION("HID Sensor Custom Hinge");
> > +MODULE_AUTHOR("Ye Xiang <xiang.ye@intel.com>");
> > +MODULE_LICENSE("GPL");
> 
