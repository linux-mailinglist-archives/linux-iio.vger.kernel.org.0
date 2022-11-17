Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27862DEFB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 16:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiKQPFP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 10:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiKQPFO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 10:05:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA371140A6
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 07:05:12 -0800 (PST)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCjnv6jrgz6H7Ht;
        Thu, 17 Nov 2022 23:02:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:05:09 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 15:05:09 +0000
Date:   Thu, 17 Nov 2022 15:05:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] HID: hid-sensor-custom: More custom iio sensors
Message-ID: <20221117150508.00002704@Huawei.com>
In-Reply-To: <20221116231947.18031-1-p.jungkamp@gmx.net>
References: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
        <20221116231947.18031-1-p.jungkamp@gmx.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Nov 2022 00:19:45 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> The known LUID table for established/known custom HID sensors was
> limited to sensors with "INTEL" as manufacturer. But some vendors such
> as Lenovo also include fairly standard iio sensors (e.g. ambient light)
> in their custom sensors.
> 
> Expand the known custom sensors table by a tag used for the platform
> device name and match sensors based on the LUID as well as optionally
> on model and manufacturer properties.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>

Hi Philipp,

A few trivial things inline. This looks good to me in general.
I dread to think how many of these we will eventually end up with
but such is life...

Jonathan

> ---
>  drivers/hid/hid-sensor-custom.c | 225 +++++++++++++++++++++++---------
>  include/linux/hid-sensor-ids.h  |   1 +
>  2 files changed, 161 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 32c2306e240d..cb21f9178830 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -5,6 +5,7 @@
>   */
> 
>  #include <linux/ctype.h>
> +#include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -750,114 +751,208 @@ static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
> 
>  }
> 
> -/* luid defined in FW (e.g. ISH).  Maybe used to identify sensor. */
> -static const char *const known_sensor_luid[] = { "020B000000000000" };
> +/*
> + * Match a known custom sensor.
> + * tag and luid is mandatory.
> + */
> +struct hid_sensor_custom_match {
> +	const char *tag;
> +	const char *luid;
> +	const char *model;
> +	const char *manufacturer;
> +	bool check_dmi;
> +	struct dmi_system_id dmi;
> +};
> 
> -static int get_luid_table_index(unsigned char *usage_str)
> -{
> -	int i;
> +/*
> + * Custom sensor properties used for matching.
> + */
> +struct hid_sensor_custom_properties {
> +	u16 serial_num[HID_CUSTOM_MAX_FEATURE_BYTES];
> +	u16 model[HID_CUSTOM_MAX_FEATURE_BYTES];
> +	u16 manufacturer[HID_CUSTOM_MAX_FEATURE_BYTES];
> +};
> 
> -	for (i = 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
> -		if (!strncmp(usage_str, known_sensor_luid[i],
> -			     strlen(known_sensor_luid[i])))
> -			return i;
> +static const struct hid_sensor_custom_match hid_sensor_custom_known_table[] = {
> +	/*
> +	 * Intel Integrated Sensor Hub (ISH)
> +	 */
> +	{	/* Intel ISH hinge */
> +		.tag = "INT",
> +		.luid = "020B000000000000",
> +		.manufacturer = "INTEL",
> +	},
> +	{}
> +};
> +
> +static int hid_sensor_custom_prop_match_str(const u16 *prop, const char *match,
> +					    size_t max_count)
> +{
> +	while (max_count-- && *prop && *match) {
> +		if (*prop & 0xFF00 ||
> +		    *match != (char) *prop)
> +			return 0;
> +		prop++;
> +		match++;
>  	}
> 
> -	return -ENODEV;
> +	return 1;

As you are handling it like a bool, perhaps just use a bool for the return type.

>  }
> 
> -static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
> +static int hid_sensor_custom_get_prop(struct hid_sensor_hub_device *hsdev,
> +				      u32 prop_usage_id, size_t prop_size,
> +				      u16 *prop)
>  {
> -	struct hid_sensor_hub_attribute_info sensor_manufacturer = { 0 };
> -	struct hid_sensor_hub_attribute_info sensor_luid_info = { 0 };
> +	struct hid_sensor_hub_attribute_info prop_attr = { 0 };
>  	int report_size;
>  	int ret;
> -	static u16 w_buf[HID_CUSTOM_MAX_FEATURE_BYTES];
> -	static char buf[HID_CUSTOM_MAX_FEATURE_BYTES];
> -	int i;
> 
> -	memset(w_buf, 0, sizeof(w_buf));
> -	memset(buf, 0, sizeof(buf));
> +	memset(prop, 0, prop_size);
> 
> -	/* get manufacturer info */
> +	/* get property info */
>  	ret = sensor_hub_input_get_attribute_info(hsdev,
> -			HID_FEATURE_REPORT, hsdev->usage,
> -			HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
> +						  HID_FEATURE_REPORT,
> +						  hsdev->usage,
> +						  prop_usage_id,
> +						  &prop_attr);
> +	/* property does not exist */
>  	if (ret < 0)
> -		return ret;
> +		return -ENODATA;

Hmm. Doing this to indicate a reason for this function returning is
prone to changes in the errors returned by sensor_hub_input_get_attribute_info()
in the future.  Perhaps use an extra parameter to convey this info instead.
Unless we are sure that ENODATA will always mean the same thing.

Whilst we are here I note that sensor_hub_input_get_attribute_info()
returns 0 or -1 so isn't returning a kernel error code anyway..
So this will return -EPERM right now which is probably not what is desired.

We should fix that independent of this set.

> 
>  	report_size =
> -		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
> -				       sensor_manufacturer.index, sizeof(w_buf),
> -				       w_buf);
> +		sensor_hub_get_feature(hsdev, prop_attr.report_id,
> +				       prop_attr.index, prop_size,
> +				       prop);
>  	if (report_size <= 0) {
>  		hid_err(hsdev->hdev,
> -			"Failed to get sensor manufacturer info %d\n",
> +			"Failed to get sensor property %08x %d\n",
> +			prop_usage_id,
>  			report_size);
>  		return -ENODEV;
>  	}
> 
> -	/* convert from wide char to char */
> -	for (i = 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
> -		buf[i] = (char)w_buf[i];
> +	return 0;
> +}
> 
> -	/* ensure it's ISH sensor */
> -	if (strncmp(buf, "INTEL", strlen("INTEL")))
> -		return -ENODEV;
> +static int
> +hid_sensor_custom_do_match(struct hid_sensor_hub_device *hsdev,
> +			   const struct hid_sensor_custom_match *match,
> +			   const struct hid_sensor_custom_properties *prop)
> +{
> +	struct dmi_system_id dmi[] = { match->dmi, { 0 } };
> 
> -	memset(w_buf, 0, sizeof(w_buf));
> -	memset(buf, 0, sizeof(buf));
> +	/*
> +	 * Match the LUID property.
> +	 */

Comment seems unnecessary given the code makes this clear. So in interests
of not having comments that might get out of sync I would drop it
and any similar ones as not adding sufficient value.

> +	if (!hid_sensor_custom_prop_match_str(prop->serial_num, "LUID:", 5) ||
> +	    !hid_sensor_custom_prop_match_str(prop->serial_num + 5,
> +					      match->luid,
> +					      HID_CUSTOM_MAX_FEATURE_BYTES - 5))
> +		return 0;
> 
> -	/* get real usage id */
> -	ret = sensor_hub_input_get_attribute_info(hsdev,
> -			HID_FEATURE_REPORT, hsdev->usage,
> -			HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
> +	/*
> +	 * Match the model property. (optional)
> +	 */
> +	if (match->model &&
> +	    !hid_sensor_custom_prop_match_str(prop->model,
> +					      match->model,
> +					      HID_CUSTOM_MAX_FEATURE_BYTES))
> +		return 0;
> +
> +	/*
> +	 * Match the manufacturer property. (optional)
> +	 */
> +	if (match->manufacturer &&
> +	    !hid_sensor_custom_prop_match_str(prop->manufacturer,
> +					      match->manufacturer,
> +					      HID_CUSTOM_MAX_FEATURE_BYTES))
> +		return 0;
> +
> +	/*
> +	 * Match DMI. (optional)
> +	 */
> +	if (match->check_dmi && !dmi_check_system(dmi))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int
> +hid_sensor_custom_properties_get(struct hid_sensor_hub_device *hsdev,
> +				 struct hid_sensor_custom_properties *prop)
> +{
> +	int ret;
> +
> +	ret = hid_sensor_custom_get_prop(hsdev,
> +					 HID_USAGE_SENSOR_PROP_SERIAL_NUM,
> +					 HID_CUSTOM_MAX_FEATURE_BYTES,
> +					 prop->serial_num);
>  	if (ret < 0)
>  		return ret;
> 
> -	report_size = sensor_hub_get_feature(hsdev, sensor_luid_info.report_id,
> -					     sensor_luid_info.index, sizeof(w_buf),
> -					     w_buf);
> -	if (report_size <= 0) {
> -		hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
> -			report_size);
> -		return -ENODEV;
> -	}
> +	ret = hid_sensor_custom_get_prop(hsdev,
> +					 HID_USAGE_SENSOR_PROP_MODEL,
> +					 HID_CUSTOM_MAX_FEATURE_BYTES,
> +					 prop->model);
> +	if (ret < 0 && ret != -ENODATA)
> +		return ret;
> 
> -	/* convert from wide char to char */
> -	for (i = 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
> -		buf[i] = (char)w_buf[i];
> +	ret = hid_sensor_custom_get_prop(hsdev,
> +					 HID_USAGE_SENSOR_PROP_MANUFACTURER,
> +					 HID_CUSTOM_MAX_FEATURE_BYTES,
> +					 prop->manufacturer);
> +	if (ret < 0 && ret != -ENODATA)
> +		return ret;
> 
> -	if (strlen(buf) != strlen(known_sensor_luid[0]) + 5) {
> -		hid_err(hsdev->hdev,
> -			"%s luid length not match %zu != (%zu + 5)\n", __func__,
> -			strlen(buf), strlen(known_sensor_luid[0]));
> +	return 0;
> +}
> +

I haven't checked local style, but in general one blank line is enough
between functions...

> +
> +static int
> +hid_sensor_custom_get_known(struct hid_sensor_hub_device *hsdev,
> +			    const struct hid_sensor_custom_match **known)
> +{
> +	int ret;
> +	const struct hid_sensor_custom_match *match =
> +		hid_sensor_custom_known_table;
> +	struct hid_sensor_custom_properties prop;
> +
> +	ret = hid_sensor_custom_properties_get(hsdev, &prop);
> +	if (ret < 0)
>  		return -ENODEV;
> +
> +	while (match->tag) {
> +		if (hid_sensor_custom_do_match(hsdev, match, &prop)) {
> +			*known = match;
> +			return 0;
> +		}
> +		match++;
>  	}
> 
> -	/* get table index with luid (not matching 'LUID: ' in luid) */
> -	return get_luid_table_index(&buf[5]);
> +	return -ENODEV;
>  }
> 
>  static struct platform_device *
>  hid_sensor_register_platform_device(struct platform_device *pdev,
>  				    struct hid_sensor_hub_device *hsdev,
> -				    int index)
> +				    const struct hid_sensor_custom_match *match)
>  {
> -	char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
> +	char real_usage[HID_SENSOR_USAGE_LENGTH];
>  	struct platform_device *custom_pdev;
>  	const char *dev_name;
>  	char *c;
> 
>  	/* copy real usage id */
> -	memcpy(real_usage, known_sensor_luid[index], 4);
> +	memcpy(real_usage, match->luid, 4);
> +	real_usage[4] = '\0';
> 
> -	/* usage id are all lowcase */
> +	/* usage ids are all lowcase */
>  	for (c = real_usage; *c != '\0'; c++)
>  		*c = tolower(*c);
> 
> -	/* HID-SENSOR-INT-REAL_USAGE_ID */
> -	dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
> +	/* HID-SENSOR-tag-real_usage */
> +	dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
> +			     match->tag, real_usage);
>  	if (!dev_name)
>  		return ERR_PTR(-ENOMEM);
> 
> @@ -873,7 +968,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
>  	struct hid_sensor_custom *sensor_inst;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	int ret;
> -	int index;
> +	const struct hid_sensor_custom_match *match = NULL;
> 
>  	sensor_inst = devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
>  				   GFP_KERNEL);
> @@ -888,10 +983,10 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
>  	mutex_init(&sensor_inst->mutex);
>  	platform_set_drvdata(pdev, sensor_inst);
> 
> -	index = get_known_custom_sensor_index(hsdev);
> -	if (index >= 0 && index < ARRAY_SIZE(known_sensor_luid)) {
> +	ret = hid_sensor_custom_get_known(hsdev, &match);
> +	if (!ret && match) {
>  		sensor_inst->custom_pdev =
> -			hid_sensor_register_platform_device(pdev, hsdev, index);
> +			hid_sensor_register_platform_device(pdev, hsdev, match);
> 
>  		ret = PTR_ERR_OR_ZERO(sensor_inst->custom_pdev);
>  		if (ret) {
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index ac631159403a..13b1e65fbdcc 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -132,6 +132,7 @@
>  #define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
>  #define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
>  #define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
> +#define HID_USAGE_SENSOR_PROP_MODEL				0x200306
>  #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
>  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
>  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
> --
> 2.38.1
> 

