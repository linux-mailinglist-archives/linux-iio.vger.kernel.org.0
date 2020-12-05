Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D180B2CFE44
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLETTy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 14:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgLETTZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 14:19:25 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A3723329;
        Sat,  5 Dec 2020 16:00:49 +0000 (UTC)
Date:   Sat, 5 Dec 2020 16:00:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-custom: Add custom sensor iio
 support
Message-ID: <20201205160046.357244a2@archlinux>
In-Reply-To: <20201203035352.13918-2-xiang.ye@intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
        <20201203035352.13918-2-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Dec 2020 11:53:50 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Currently custom sensors properties are not decoded and it is up to
> user space to interpret.
> 
> Some manufacturers already standardized the meaning of some custom sensors.
> They can be presented as a proper IIO sensor. We can identify these sensors
> based on manufacturer and serial number property in the report.
> 
> This change is identifying hinge sensor when the manufacturer is "INTEL".
> This creates a platform device so that a sensor driver can be loaded to
> process these sensors.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
Hi,

A few little comments inline.

Others are much more familiar with this code than I am though so I'm sure
they will give a more in depth review!

> ---
>  drivers/hid/hid-sensor-custom.c | 181 ++++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-ids.h  |  14 +++
>  2 files changed, 195 insertions(+)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 4d25577a8573..b8e59021c6a8 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2015, Intel Corporation.
>   */
>  
> +#include <linux/ctype.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -21,6 +22,7 @@
>  #define HID_CUSTOM_TOTAL_ATTRS		(HID_CUSTOM_MAX_CORE_ATTRS + 1)
>  #define HID_CUSTOM_FIFO_SIZE		4096
>  #define HID_CUSTOM_MAX_FEATURE_BYTES	64
> +#define HID_SENSOR_USAGE_LENGTH (4 + 1)
>  
>  struct hid_sensor_custom_field {
>  	int report_id;
> @@ -50,6 +52,8 @@ struct hid_sensor_custom {
>  	struct kfifo data_fifo;
>  	unsigned long misc_opened;
>  	wait_queue_head_t wait;
> +	struct platform_device *custom_pdev;
> +	bool custom_pdev_exposed;

Note on this below.  I'm not sure the boolean brings us any advantages.

>  };
>  
>  /* Header for each sample to user space via dev interface */
> @@ -746,11 +750,164 @@ static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
>  
>  }
>  
> +/*
> + * use sensors luid which is defined in FW, such as ISH,
> + * to identify sensor.
Perhaps rephrase as

luid defined in FW (e.g. ISH).  May be used to identify sensor.
 
> + */
> +static const char *const known_sensor_luid[] = { "020B000000000000" };
> +
> +static int get_luid_table_index(unsigned char *usage_str)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
> +		if (!strncmp(usage_str, known_sensor_luid[i],
> +			     strlen(known_sensor_luid[i])))
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
> +{
> +	struct hid_sensor_hub_attribute_info sensor_manufacturer = { 0 };
> +	struct hid_sensor_hub_attribute_info sensor_luid_info = { 0 };
> +	int report_size;
> +	int ret;
> +	u16 *w_buf;
> +	char *buf;
> +	int w_buf_len = sizeof(u16) * HID_CUSTOM_MAX_FEATURE_BYTES;
> +	int buf_len = sizeof(char) * HID_CUSTOM_MAX_FEATURE_BYTES;
> +	int i;
> +	int index;
> +
> +	w_buf = kzalloc(w_buf_len, GFP_KERNEL);
> +	if (!w_buf) {
> +		ret = -ENOMEM;
> +		goto error_out2;
> +	}
> +
> +	buf = kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto error_out1;
> +	}
> +	/* get manufacturer info */
> +	ret = sensor_hub_input_get_attribute_info(
> +		hsdev, HID_FEATURE_REPORT, hsdev->usage,
> +		HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
> +	if (ret < 0) {
> +		ret = -ENODEV;
> +		goto error_out;
> +	}
> +
> +	report_size =
> +		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
> +				       sensor_manufacturer.index, w_buf_len,
> +				       w_buf);
> +	if (report_size <= 0) {
> +		hid_err(hsdev->hdev,
> +			"Failed to get sensor manufacturer info %d\n",
> +			report_size);
> +		ret = -ENODEV;
> +		goto error_out;
> +	}
> +
> +	/* convert from wide char to char */
> +	for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
> +		buf[i] = (char)w_buf[i];
> +
> +	/* ensure it's ISH sensor */
> +	if (strncmp(buf, "INTEL", strlen("INTEL"))) {
> +		ret = -ENODEV;
> +		goto error_out;
> +	}
> +
> +	memset(w_buf, 0, w_buf_len);
> +	memset(buf, 0, buf_len);
> +
> +	/* get real usage id */
> +	ret = sensor_hub_input_get_attribute_info(
> +		hsdev, HID_FEATURE_REPORT, hsdev->usage,
> +		HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
> +	if (ret < 0) {
> +		ret = -ENODEV;
> +		goto error_out;
> +	}
> +
> +	report_size = sensor_hub_get_feature(hsdev, sensor_luid_info.report_id,
> +					     sensor_luid_info.index, w_buf_len,
> +					     w_buf);
> +	if (report_size <= 0) {
> +		hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
> +			report_size);
> +		ret = -ENODEV;
> +		goto error_out;
> +	}
> +
> +	/* convert from wide char to char */
> +	for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
> +		buf[i] = (char)w_buf[i];
> +
> +	if (strlen(buf) != strlen(known_sensor_luid[0]) + 5) {
> +		hid_err(hsdev->hdev,
> +			"%s luid length not match %zu != (%zu + 5)\n", __func__,
> +			strlen(buf), strlen(known_sensor_luid[0]));
> +		ret = -ENODEV;
> +		goto error_out;
> +	}
> +
> +	/* get table index with luid (not matching 'LUID: ' in luid) */
> +	index = get_luid_table_index(&buf[5]);
> +	if (index >= 0)
> +		ret = index;
> +	else
> +		ret = -ENODEV;
> +
> +error_out:
> +	kfree(buf);
> +error_out1:
> +	kfree(w_buf);
> +error_out2:
> +	return ret;
> +}
> +
> +static struct platform_device *
> +hid_sensor_register_platform_device(struct platform_device *pdev,
> +				    struct hid_sensor_hub_device *hsdev,
> +				    int index)
> +{
> +	char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
> +	struct platform_device *custom_pdev;
> +	const char *dev_name;
> +	char *c;
> +
> +	/* copy real usage id */
> +	memcpy(real_usage, known_sensor_luid[index], 4);
> +
> +	/* usage id are all lowcase */
> +	for (c = real_usage; *c != '\0'; c++)
> +		*c = tolower(*c);
> +
> +	/* HID-SENSOR-INT-REAL_USAGE_ID */
> +	dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
> +	if (!dev_name)
> +		return NULL;
> +
> +	custom_pdev = platform_device_register_data(pdev->dev.parent, dev_name,
> +						    PLATFORM_DEVID_NONE, hsdev,
> +						    sizeof(*hsdev));
> +	kfree(dev_name);
> +	return custom_pdev;
> +}
> +
>  static int hid_sensor_custom_probe(struct platform_device *pdev)
>  {
>  	struct hid_sensor_custom *sensor_inst;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	int ret;
> +	int index;
>  
>  	sensor_inst = devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
>  				   GFP_KERNEL);
> @@ -764,6 +921,25 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
>  	sensor_inst->pdev = pdev;
>  	mutex_init(&sensor_inst->mutex);
>  	platform_set_drvdata(pdev, sensor_inst);
> +
> +	index = get_known_custom_sensor_index(hsdev);
> +	if (index >= 0 && index < ARRAY_SIZE(known_sensor_luid)) {
> +		sensor_inst->custom_pdev =
> +			hid_sensor_register_platform_device(pdev, hsdev, index);
> +
> +		ret = PTR_ERR_OR_ZERO(sensor_inst->custom_pdev);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"register_platform_device failed\n");
> +			return ret;
> +		}
> +
> +		sensor_inst->custom_pdev_exposed = true;

Do we need an additional boolean or can we just use the existence of
custom_pdev?

> +		return 0;
> +	} else if (index < 0 && index != -ENODEV) {
> +		return index;
> +	}
> +
>  	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
>  					   &sensor_inst->callbacks);
>  	if (ret < 0) {
> @@ -802,6 +978,11 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
>  	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  
> +	if (sensor_inst->custom_pdev_exposed) {
> +		platform_device_unregister(sensor_inst->custom_pdev);
> +		return 0;
> +	}
> +
>  	hid_sensor_custom_dev_if_remove(sensor_inst);
>  	hid_sensor_custom_remove_attributes(sensor_inst);
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 530c09f3e64a..ac631159403a 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -128,6 +128,10 @@
>  #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
>  
>  /* Common selectors */
> +#define HID_USAGE_SENSOR_PROP_DESC				0x200300
> +#define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
> +#define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
> +#define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
>  #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
>  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
>  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
> @@ -159,4 +163,14 @@
>  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM	0x200840
>  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x200841
>  
> +/* Custom Sensor (2000e1) */
> +#define HID_USAGE_SENSOR_HINGE				        0x20020B
> +#define HID_USAGE_SENSOR_DATA_FIELD_LOCATION			0x200400
> +#define HID_USAGE_SENSOR_DATA_FIELE_TIME_SINCE_SYS_BOOT		0x20052B
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_USAGE		0x200541
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE           0x200543
> +/* Custom Sensor data 28=>x>=0 */
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                            \
> +	(HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE + (x))
> +
>  #endif

