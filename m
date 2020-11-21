Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7F42BC109
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 18:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgKURVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 12:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgKURVe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 12:21:34 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B67E221FC;
        Sat, 21 Nov 2020 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605979292;
        bh=Rbo8jQczxzuDS5P4qzpZpKjNXZ3+kmhhAMg/Tw29/yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PYpM1AB6ze6NA8aFBQlDX1yF/u29T2GqnWnbBGJF5K3jAwTyHifmqs9R5xP8h/vaV
         yY9q3eEXb0r+053eSIgEom0O9QUsszZhGiMOk17D8mB300nCUafDVSUP4vNVijghfa
         vEK7AXTQplL9SdknCRMghvjnqAHoIDmrrCbxnLI4=
Date:   Sat, 21 Nov 2020 17:21:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] HID: hid-sensor-custom: Add custom sensor iio
 support
Message-ID: <20201121172127.18bdd4bb@archlinux>
In-Reply-To: <20201119100331.2594-2-xiang.ye@intel.com>
References: <20201119100331.2594-1-xiang.ye@intel.com>
        <20201119100331.2594-2-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 18:03:28 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Currently custom sensors properties are not decoded and it is up to
> user space to interpret.
>=20
> Some manufacturers already standardized the meaning of some custom sensor=
s.
> They can be presented as a proper IIO sensor. We can identify these senso=
rs
> based on manufacturer and serial number property in the report.
>=20
> This change is identifying hinge sensor when the manufacturer is "INTEL".
> This creates a platform device so that a sensor driver can be loaded to
> process these sensors.
>=20
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Hi Ye Xiang,

Various comments inline.

Thanks,

Jonathan

> ---
>  drivers/hid/hid-sensor-custom.c | 170 ++++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-ids.h  |  39 ++++++++
>  2 files changed, 209 insertions(+)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index 4d25577a8573..bb96d9c09daf 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2015, Intel Corporation.
>   */
> =20
> +#include <linux/ctype.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -21,6 +22,7 @@
>  #define HID_CUSTOM_TOTAL_ATTRS		(HID_CUSTOM_MAX_CORE_ATTRS + 1)
>  #define HID_CUSTOM_FIFO_SIZE		4096
>  #define HID_CUSTOM_MAX_FEATURE_BYTES	64
> +#define HID_SENSOR_USAGE_LENGTH (4 + 1)
> =20
>  struct hid_sensor_custom_field {
>  	int report_id;
> @@ -50,6 +52,8 @@ struct hid_sensor_custom {
>  	struct kfifo data_fifo;
>  	unsigned long misc_opened;
>  	wait_queue_head_t wait;
> +	struct platform_device *custom_pdev;
> +	bool custom_pdev_exposed;
>  };
> =20
>  /* Header for each sample to user space via dev interface */
> @@ -746,11 +750,159 @@ static void hid_sensor_custom_dev_if_remove(struct=
 hid_sensor_custom
> =20
>  }
> =20
> +/*
> + * use sensors luid which is defined in FW, such as ISH,
> + * to identify sensor.
> + */

const?

> +static char *known_sensor_luid[] =3D { "020B000000000000" };
> +
> +static int get_luid_table_index(unsigned char *usage_str)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
> +		if (!strncmp(usage_str, known_sensor_luid[i],
> +			     strlen(known_sensor_luid[i])))
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static int get_known_custom_sensor_index(struct hid_sensor_hub_device *h=
sdev)
> +{
> +	struct hid_sensor_hub_attribute_info sensor_manufacturer =3D { 0 };
> +	struct hid_sensor_hub_attribute_info sensor_luid_info =3D { 0 };
> +	int report_size;
> +	int ret;
> +	u16 *w_buf;
> +	int w_buf_len;
> +	char *buf;
> +	int buf_len;
> +	int i;
> +	int index;
> +
> +	w_buf_len =3D sizeof(u16) * HID_CUSTOM_MAX_FEATURE_BYTES;
> +	buf_len =3D sizeof(char) * HID_CUSTOM_MAX_FEATURE_BYTES;
Given these are compile time values, these two could just go
directly above with no loss of readability.

int w_buf_len =3D siezof(u16)...

> +	w_buf =3D kzalloc(w_buf_len, GFP_KERNEL);
> +	if (!w_buf)
> +		return -1;

Better to return meaningful error values and if the error
isn't just 'didn't find it' - probably -ENODEV and we should check that
was the cause of the problem at the call site for this function.
If it was a memory allocation error we should quit out instead of trying
something else.

> +
> +	buf =3D kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf) {
> +		kfree(w_buf);
Given we have error handling for this below, better to be consistent
and use a goto + an additional error label for htis case.

> +		return -1;
> +	}
> +
> +	/* get manufacturer info */
> +	ret =3D sensor_hub_input_get_attribute_info(
> +		hsdev, HID_FEATURE_REPORT, hsdev->usage,
> +		HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
> +	if (ret < 0)

=46rom HID point of view, is that allowed to fail?  Probably best to add
a comment to say if it is or isn't.
I'd like to be able to read this code and know which of these error paths
just means we don't have a matching sensor.

> +		goto err_out;
> +
> +	report_size =3D
> +		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
> +				       sensor_manufacturer.index, w_buf_len,
> +				       w_buf);
> +	if (report_size <=3D 0) {
> +		hid_err(hsdev->hdev,
> +			"Failed to get sensor manufacturer info %d\n",
> +			report_size);
> +		goto err_out;
> +	}
> +
> +	/* convert from wide char to char */
> +	for (i =3D 0; i < buf_len - 1 && w_buf[i]; i++)
> +		buf[i] =3D (char)w_buf[i];
> +
> +	/* ensure it's ISH sensor */
> +	if (strncmp(buf, "INTEL", strlen("INTEL")))
> +		goto err_out;
> +
> +	memset(w_buf, 0, w_buf_len);
> +	memset(buf, 0, buf_len);
> +
> +	/* get real usage id */
> +	ret =3D sensor_hub_input_get_attribute_info(
> +		hsdev, HID_FEATURE_REPORT, hsdev->usage,
> +		HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	report_size =3D sensor_hub_get_feature(hsdev, sensor_luid_info.report_i=
d,
> +					     sensor_luid_info.index, w_buf_len,
> +					     w_buf);
> +	if (report_size <=3D 0) {
> +		hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
> +			report_size);
> +		goto err_out;
> +	}
> +
> +	/* convert from wide char to char */
> +	for (i =3D 0; i < buf_len - 1 && w_buf[i]; i++)
> +		buf[i] =3D (char)w_buf[i];
> +
> +	if (strlen(buf) !=3D strlen(known_sensor_luid[0]) + 5) {
> +		hid_err(hsdev->hdev,
> +			"%s luid length not match %zu !=3D (%zu + 5)\n", __func__,
> +			strlen(buf), strlen(known_sensor_luid[0]));
> +		goto err_out;
> +	}
> +
> +	/* get table index with luid (not matching 'LUID: ' in luid) */
> +	index =3D get_luid_table_index(&buf[5]);

Nicer to share the code block here with the error / unwind path below.
Particular as index might be -1 and hence an error.

> +	kfree(w_buf);
> +	kfree(buf);
> +	return index;
> +
> +err_out:
> +	kfree(w_buf);
> +	kfree(buf);
> +	return -1;
> +}
> +
> +static struct platform_device *
> +register_platform_device(struct platform_device *pdev,

Function needs a prefix as that sounds very generic.
When I saw it below, I assumed it was a generic call not
one in this file.

> +			 struct hid_sensor_hub_device *hsdev, int index)
> +{
> +	char real_usage[HID_SENSOR_USAGE_LENGTH] =3D { 0 };
> +	struct platform_device *custom_pdev;
> +	const char *dev_name;
> +	char *c;
> +	int ret;
> +
> +	/* copy real usage id */
> +	memcpy(real_usage, known_sensor_luid[index], 4);
> +
> +	/* usage id are all lowcase */
> +	for (c =3D real_usage; *c !=3D '\0'; c++)
> +		*c =3D tolower(*c);
> +
> +	/* HID-SENSOR-INT-REAL_USAGE_ID */
> +	dev_name =3D kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
> +	if (!dev_name)
> +		return NULL;
> +
> +	custom_pdev =3D platform_device_register_data(pdev->dev.parent, dev_nam=
e,
> +					     PLATFORM_DEVID_NONE, hsdev,
> +					     sizeof(*hsdev));
> +	kfree(dev_name);
> +	ret =3D PTR_ERR_OR_ZERO(custom_pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "platform_device_register_data failed ret:%d\n", r=
et);
> +		return NULL;
> +	}
> +
> +	return custom_pdev;
> +}
> +
>  static int hid_sensor_custom_probe(struct platform_device *pdev)
>  {
>  	struct hid_sensor_custom *sensor_inst;
>  	struct hid_sensor_hub_device *hsdev =3D pdev->dev.platform_data;
>  	int ret;
> +	int index;
> =20
>  	sensor_inst =3D devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
>  				   GFP_KERNEL);
> @@ -764,6 +916,19 @@ static int hid_sensor_custom_probe(struct platform_d=
evice *pdev)
>  	sensor_inst->pdev =3D pdev;
>  	mutex_init(&sensor_inst->mutex);
>  	platform_set_drvdata(pdev, sensor_inst);
> +
> +	index =3D get_known_custom_sensor_index(hsdev);
> +	if (index >=3D 0) {
> +		sensor_inst->custom_pdev =3D
> +			register_platform_device(pdev, hsdev, index);
> +		if (sensor_inst->custom_pdev) {
> +			sensor_inst->custom_pdev_exposed =3D true;
> +			return 0;
> +		}
> +
> +		dev_err(&pdev->dev, "register_platform_device failed\n");

This feels like somewhat odd logic. We aren't looking at a fallback for
something that is expected to fail so it doesn't make sense to carry
on.


> +	}
> +
>  	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage,
>  					   &sensor_inst->callbacks);
>  	if (ret < 0) {
> @@ -802,6 +967,11 @@ static int hid_sensor_custom_remove(struct platform_=
device *pdev)
>  	struct hid_sensor_custom *sensor_inst =3D platform_get_drvdata(pdev);
>  	struct hid_sensor_hub_device *hsdev =3D pdev->dev.platform_data;
> =20
> +	if (sensor_inst->custom_pdev_exposed) {
> +		platform_device_unregister(sensor_inst->custom_pdev);
> +		return 0;
> +	}
> +
>  	hid_sensor_custom_dev_if_remove(sensor_inst);
>  	hid_sensor_custom_remove_attributes(sensor_inst);
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-id=
s.h
> index 530c09f3e64a..46db3056f04b 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -128,6 +128,10 @@
>  #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
> =20
>  /* Common selectors */
> +#define HID_USAGE_SENSOR_PROP_DESC				0x200300
> +#define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
> +#define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
> +#define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
>  #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
>  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
>  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
> @@ -159,4 +163,39 @@
>  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM	0x200840
>  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x200841
> =20
> +/* Custom Sensor (2000e1) */
> +#define HID_USAGE_SENSOR_HINGE				        0x20020B
> +#define HID_USAGE_SENSOR_DATA_FIELD_LOCATION			0x200400
> +#define HID_USAGE_SENSOR_DATA_FIELE_TIME_SINCE_SYS_BOOT		0x20052B
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_USAGE		0x200541
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE		0x200543
Given these are all defined in a block could we use a macro?
HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                     0x200543 + =
(x)

perhaps?

I'm not sure what the preferred convention is in this file.

> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1		0x200544
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_2		0x200545
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_3		0x200546
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_4		0x200547
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_5		0x200548
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_6		0x200549
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_7		0x20054A
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_8		0x20054B
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_9		0x20054C
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_10		0x20054D
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_11		0x20054E
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_12		0x20054F
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_13		0x200550
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_14		0x200551
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_15		0x200552
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_16		0x200553
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_17		0x200554
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_18		0x200555
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_19		0x200556
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_20		0x200557
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_21		0x200558
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_22		0x200559
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_23		0x20055A
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_24		0x20055B
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_25		0x20055C
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_26		0x20055D
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_27		0x20055E
> +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_28		0x20055F
> +
>  #endif

