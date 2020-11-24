Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5C12C22EB
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgKXK2K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 05:28:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:3570 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgKXK2K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Nov 2020 05:28:10 -0500
IronPort-SDR: QFPsjRTlE4KCl/yOOfB7vjTmunra/sLJDcrLrnNd0w89ExHmFN2Nct5zKf8pt+duKDo+ghMkZ9
 9p1XhRq1hKbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172019752"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172019752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 02:28:08 -0800
IronPort-SDR: YETyT42Vw4Z7Jp3V6QcCG/Ig5ROqKjEiXEEf6Zo5iaTHs7NqO/bYarh5pCM8lCYdzyHAVjOoKB
 iFIznRanF4WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="536418947"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 24 Nov 2020 02:28:06 -0800
Date:   Tue, 24 Nov 2020 18:29:05 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] HID: hid-sensor-custom: Add custom sensor iio
 support
Message-ID: <20201124102905.GA29864@host>
References: <20201119100331.2594-1-xiang.ye@intel.com>
 <20201119100331.2594-2-xiang.ye@intel.com>
 <20201121172127.18bdd4bb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121172127.18bdd4bb@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 05:21:27PM +0000, Jonathan Cameron wrote:
> On Thu, 19 Nov 2020 18:03:28 +0800
> Ye Xiang <xiang.ye@intel.com> wrote:
> 
> > Currently custom sensors properties are not decoded and it is up to
> > user space to interpret.
> > 
> > Some manufacturers already standardized the meaning of some custom sensors.
> > They can be presented as a proper IIO sensor. We can identify these sensors
> > based on manufacturer and serial number property in the report.
> > 
> > This change is identifying hinge sensor when the manufacturer is "INTEL".
> > This creates a platform device so that a sensor driver can be loaded to
> > process these sensors.
> > 
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> 
> Hi Ye Xiang,
> 
> Various comments inline.
> 
> Thanks,
> 
> Jonathan
Thanks for review and comments

Xiang
> 
> > ---
> >  drivers/hid/hid-sensor-custom.c | 170 ++++++++++++++++++++++++++++++++
> >  include/linux/hid-sensor-ids.h  |  39 ++++++++
> >  2 files changed, 209 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> > index 4d25577a8573..bb96d9c09daf 100644
> > --- a/drivers/hid/hid-sensor-custom.c
> > +++ b/drivers/hid/hid-sensor-custom.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (c) 2015, Intel Corporation.
> >   */
> >  
> > +#include <linux/ctype.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > @@ -21,6 +22,7 @@
> >  #define HID_CUSTOM_TOTAL_ATTRS		(HID_CUSTOM_MAX_CORE_ATTRS + 1)
> >  #define HID_CUSTOM_FIFO_SIZE		4096
> >  #define HID_CUSTOM_MAX_FEATURE_BYTES	64
> > +#define HID_SENSOR_USAGE_LENGTH (4 + 1)
> >  
> >  struct hid_sensor_custom_field {
> >  	int report_id;
> > @@ -50,6 +52,8 @@ struct hid_sensor_custom {
> >  	struct kfifo data_fifo;
> >  	unsigned long misc_opened;
> >  	wait_queue_head_t wait;
> > +	struct platform_device *custom_pdev;
> > +	bool custom_pdev_exposed;
> >  };
> >  
> >  /* Header for each sample to user space via dev interface */
> > @@ -746,11 +750,159 @@ static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
> >  
> >  }
> >  
> > +/*
> > + * use sensors luid which is defined in FW, such as ISH,
> > + * to identify sensor.
> > + */
> 
> const?
yes, it shoud be const.
> 
> > +static char *known_sensor_luid[] = { "020B000000000000" };
> > +
> > +static int get_luid_table_index(unsigned char *usage_str)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
> > +		if (!strncmp(usage_str, known_sensor_luid[i],
> > +			     strlen(known_sensor_luid[i])))
> > +			return i;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
> > +{
> > +	struct hid_sensor_hub_attribute_info sensor_manufacturer = { 0 };
> > +	struct hid_sensor_hub_attribute_info sensor_luid_info = { 0 };
> > +	int report_size;
> > +	int ret;
> > +	u16 *w_buf;
> > +	int w_buf_len;
> > +	char *buf;
> > +	int buf_len;
> > +	int i;
> > +	int index;
> > +
> > +	w_buf_len = sizeof(u16) * HID_CUSTOM_MAX_FEATURE_BYTES;
> > +	buf_len = sizeof(char) * HID_CUSTOM_MAX_FEATURE_BYTES;
> Given these are compile time values, these two could just go
> directly above with no loss of readability.
> 
> int w_buf_len = siezof(u16)...
got it
> 
> > +	w_buf = kzalloc(w_buf_len, GFP_KERNEL);
> > +	if (!w_buf)
> > +		return -1;
> 
> Better to return meaningful error values and if the error
> isn't just 'didn't find it' - probably -ENODEV and we should check that
> was the cause of the problem at the call site for this function.
> If it was a memory allocation error we should quit out instead of trying
> something else.
agree, will use -ENODEV, when "didn't find it"; use -ENOMEM when alloc failed.
> 
> > +
> > +	buf = kzalloc(buf_len, GFP_KERNEL);
> > +	if (!buf) {
> > +		kfree(w_buf);
> Given we have error handling for this below, better to be consistent
> and use a goto + an additional error label for htis case.
ok, will add additional error label to make it consistent.
> 
> > +		return -1;
> > +	}
> > +
> > +	/* get manufacturer info */
> > +	ret = sensor_hub_input_get_attribute_info(
> > +		hsdev, HID_FEATURE_REPORT, hsdev->usage,
> > +		HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
> > +	if (ret < 0)
> 
> From HID point of view, is that allowed to fail?  Probably best to add
> a comment to say if it is or isn't.
> I'd like to be able to read this code and know which of these error paths
> just means we don't have a matching sensor.
This is error checking of sensor_hub_input_get_attribute_info. If error, will
return the return value of sensor_hub_input_get_attribute_info in next version
patch.

> 
> > +		goto err_out;
> > +
> > +	report_size =
> > +		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
> > +				       sensor_manufacturer.index, w_buf_len,
> > +				       w_buf);
> > +	if (report_size <= 0) {
> > +		hid_err(hsdev->hdev,
> > +			"Failed to get sensor manufacturer info %d\n",
> > +			report_size);
> > +		goto err_out;
> > +	}
> > +
> > +	/* convert from wide char to char */
> > +	for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
> > +		buf[i] = (char)w_buf[i];
> > +
> > +	/* ensure it's ISH sensor */
> > +	if (strncmp(buf, "INTEL", strlen("INTEL")))
> > +		goto err_out;
> > +
> > +	memset(w_buf, 0, w_buf_len);
> > +	memset(buf, 0, buf_len);
> > +
> > +	/* get real usage id */
> > +	ret = sensor_hub_input_get_attribute_info(
> > +		hsdev, HID_FEATURE_REPORT, hsdev->usage,
> > +		HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
> > +	if (ret < 0)
> > +		goto err_out;
> > +
> > +	report_size = sensor_hub_get_feature(hsdev, sensor_luid_info.report_id,
> > +					     sensor_luid_info.index, w_buf_len,
> > +					     w_buf);
> > +	if (report_size <= 0) {
> > +		hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
> > +			report_size);
> > +		goto err_out;
> > +	}
> > +
> > +	/* convert from wide char to char */
> > +	for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
> > +		buf[i] = (char)w_buf[i];
> > +
> > +	if (strlen(buf) != strlen(known_sensor_luid[0]) + 5) {
> > +		hid_err(hsdev->hdev,
> > +			"%s luid length not match %zu != (%zu + 5)\n", __func__,
> > +			strlen(buf), strlen(known_sensor_luid[0]));
> > +		goto err_out;
> > +	}
> > +
> > +	/* get table index with luid (not matching 'LUID: ' in luid) */
> > +	index = get_luid_table_index(&buf[5]);
> 
> Nicer to share the code block here with the error / unwind path below.
> Particular as index might be -1 and hence an error.
ok, will try to share it with error out.
> 
> > +	kfree(w_buf);
> > +	kfree(buf);
> > +	return index;
> > +
> > +err_out:
> > +	kfree(w_buf);
> > +	kfree(buf);
> > +	return -1;
> > +}
> > +
> > +static struct platform_device *
> > +register_platform_device(struct platform_device *pdev,
> 
> Function needs a prefix as that sounds very generic.
> When I saw it below, I assumed it was a generic call not
> one in this file.
got it.
> 
> > +			 struct hid_sensor_hub_device *hsdev, int index)
> > +{
> > +	char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
> > +	struct platform_device *custom_pdev;
> > +	const char *dev_name;
> > +	char *c;
> > +	int ret;
> > +
> > +	/* copy real usage id */
> > +	memcpy(real_usage, known_sensor_luid[index], 4);
> > +
> > +	/* usage id are all lowcase */
> > +	for (c = real_usage; *c != '\0'; c++)
> > +		*c = tolower(*c);
> > +
> > +	/* HID-SENSOR-INT-REAL_USAGE_ID */
> > +	dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
> > +	if (!dev_name)
> > +		return NULL;
> > +
> > +	custom_pdev = platform_device_register_data(pdev->dev.parent, dev_name,
> > +					     PLATFORM_DEVID_NONE, hsdev,
> > +					     sizeof(*hsdev));
> > +	kfree(dev_name);
> > +	ret = PTR_ERR_OR_ZERO(custom_pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "platform_device_register_data failed ret:%d\n", ret);
> > +		return NULL;
> > +	}
> > +
> > +	return custom_pdev;
> > +}
> > +
> >  static int hid_sensor_custom_probe(struct platform_device *pdev)
> >  {
> >  	struct hid_sensor_custom *sensor_inst;
> >  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> >  	int ret;
> > +	int index;
> >  
> >  	sensor_inst = devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
> >  				   GFP_KERNEL);
> > @@ -764,6 +916,19 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
> >  	sensor_inst->pdev = pdev;
> >  	mutex_init(&sensor_inst->mutex);
> >  	platform_set_drvdata(pdev, sensor_inst);
> > +
> > +	index = get_known_custom_sensor_index(hsdev);
> > +	if (index >= 0) {
> > +		sensor_inst->custom_pdev =
> > +			register_platform_device(pdev, hsdev, index);
> > +		if (sensor_inst->custom_pdev) {
> > +			sensor_inst->custom_pdev_exposed = true;
> > +			return 0;
> > +		}
> > +
> > +		dev_err(&pdev->dev, "register_platform_device failed\n");
> 
> This feels like somewhat odd logic. We aren't looking at a fallback for
> something that is expected to fail so it doesn't make sense to carry
> on.
agree, will change to: if register platform failed, then return error code.
> 
> 
> > +	}
> > +
> >  	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
> >  					   &sensor_inst->callbacks);
> >  	if (ret < 0) {
> > @@ -802,6 +967,11 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
> >  	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
> >  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> >  
> > +	if (sensor_inst->custom_pdev_exposed) {
> > +		platform_device_unregister(sensor_inst->custom_pdev);
> > +		return 0;
> > +	}
> > +
> >  	hid_sensor_custom_dev_if_remove(sensor_inst);
> >  	hid_sensor_custom_remove_attributes(sensor_inst);
> >  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> > index 530c09f3e64a..46db3056f04b 100644
> > --- a/include/linux/hid-sensor-ids.h
> > +++ b/include/linux/hid-sensor-ids.h
> > @@ -128,6 +128,10 @@
> >  #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
> >  
> >  /* Common selectors */
> > +#define HID_USAGE_SENSOR_PROP_DESC				0x200300
> > +#define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
> > +#define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
> > +#define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
> >  #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
> >  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
> >  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
> > @@ -159,4 +163,39 @@
> >  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM	0x200840
> >  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x200841
> >  
> > +/* Custom Sensor (2000e1) */
> > +#define HID_USAGE_SENSOR_HINGE				        0x20020B
> > +#define HID_USAGE_SENSOR_DATA_FIELD_LOCATION			0x200400
> > +#define HID_USAGE_SENSOR_DATA_FIELE_TIME_SINCE_SYS_BOOT		0x20052B
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_USAGE		0x200541
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE		0x200543
> Given these are all defined in a block could we use a macro?
> HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                     0x200543 + (x)
> 
> perhaps?
> 
> I'm not sure what the preferred convention is in this file.
If using HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x), we should give a range to x, like (1<x<28).
How to ensure the x is in the range? It can be an issue when someone using x out of the range.

Thanks
Xiang
> 
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1		0x200544
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_2		0x200545
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_3		0x200546
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_4		0x200547
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_5		0x200548
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_6		0x200549
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_7		0x20054A
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_8		0x20054B
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_9		0x20054C
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_10		0x20054D
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_11		0x20054E
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_12		0x20054F
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_13		0x200550
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_14		0x200551
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_15		0x200552
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_16		0x200553
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_17		0x200554
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_18		0x200555
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_19		0x200556
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_20		0x200557
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_21		0x200558
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_22		0x200559
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_23		0x20055A
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_24		0x20055B
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_25		0x20055C
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_26		0x20055D
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_27		0x20055E
> > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_28		0x20055F
> > +
> >  #endif
> 
