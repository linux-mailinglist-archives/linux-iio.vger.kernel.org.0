Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6E6366A2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiKWRJk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiKWRJU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:09:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64111C3D
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 09:08:54 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHSFh3H9Rz6H780;
        Thu, 24 Nov 2022 01:06:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:08:50 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:08:50 +0000
Date:   Wed, 23 Nov 2022 17:08:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] HID: hid-sensor-custom: Allow more custom iio
 sensors
Message-ID: <20221123170849.00001f0a@Huawei.com>
In-Reply-To: <20221117234824.6227-1-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
        <20221117234824.6227-1-p.jungkamp@gmx.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Fri, 18 Nov 2022 00:48:21 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> The known LUID table for established/known custom HID sensors was
> limited to sensors with "INTEL" as manufacturer. But some vendors such
> as Lenovo also include fairly standard iio sensors (e.g. ambient light)
> in their custom sensors.
> 
> Expand the known custom sensors table by a tag used for the platform
> device name and match sensors based on the LUID as well as optionally
> on model and manufacturer properties.
> Introduce sensors from Lenovo's "Intelligent Sensing Solution" on the
> Lenovo Yoga 9 14IAP7 as an example.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>

Hi Philipp,

A few process things.
1) Don't send a new version in reply to an old one.  After a while the threads
get really confused (it's definitely happening on this one).
2) Put a over letter on any non trivial series
  git format-patch --cover-letter ... 
  Provides a useful place for general comments / background info etc and
  helpfully somewhere for series wide comments / tags.


A few additional comments inline from reading this version.

Jonathan


> -static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
> +static bool hid_sensor_custom_get_prop(struct hid_sensor_hub_device *hsdev,
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
> -	ret = sensor_hub_input_get_attribute_info(hsdev,
> -			HID_FEATURE_REPORT, hsdev->usage,
> -			HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
> +	ret = sensor_hub_input_get_attribute_info(hsdev, HID_FEATURE_REPORT,
> +						  hsdev->usage, prop_usage_id,
> +						  &prop_attr);
>  	if (ret < 0)
> -		return ret;
> +		return 0;

If eating an error and returning, always good to add a comment on why.
For a 'get' function' like this I'd normally expect the function to return an
error code and the higher level code to decide to ignore it or not.

> 
> -	report_size =
> -		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
> -				       sensor_manufacturer.index, sizeof(w_buf),
> -				       w_buf);
> +	report_size = sensor_hub_get_feature(hsdev, prop_attr.report_id,
> +					     prop_attr.index, prop_size, prop);
>  	if (report_size <= 0) {
>  		hid_err(hsdev->hdev,
> -			"Failed to get sensor manufacturer info %d\n",
> +			"Failed to get sensor property %08x %d\n",
> +			prop_usage_id,
>  			report_size);
> -		return -ENODEV;
> +		return report_size;
>  	}
> 
> -	/* convert from wide char to char */
> -	for (i = 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
> -		buf[i] = (char)w_buf[i];
> +	return 0;
> +}
> +


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
> +		return ret;
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
> +	*known = NULL;

I'd expect this to be side effect free. That is, if nothing found it leaves 
*known untouched.

> +	return 0;

returning -EINVAL or similar from here probably makes sense (and then ignore the returned
value as suggested below.  The only reason to return anything at all from here
is that it's a generic function that might later get used for cases where we
do care about the error.

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
> -	/* copy real usage id */
> -	memcpy(real_usage, known_sensor_luid[index], 4);
> +	memcpy(real_usage, match->luid, 4);
> +	real_usage[4] = '\0';

Why the change in approach for setting the NULL character?
Doesn't seem relevant to main purpose of this patch.

> 
> -	/* usage id are all lowcase */

Why drop this comment. If it's wrong, then I'd prefer to see that
as a separate patch with explanation of why.

>  	for (c = real_usage; *c != '\0'; c++)
>  		*c = tolower(*c);
> 
> -	/* HID-SENSOR-INT-REAL_USAGE_ID */
> -	dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
> +	dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
> +			     match->tag, real_usage);
>  	if (!dev_name)
>  		return ERR_PTR(-ENOMEM);
> 
> @@ -873,7 +944,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
>  	struct hid_sensor_custom *sensor_inst;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	int ret;
> -	int index;
> +	const struct hid_sensor_custom_match *match = NULL;
> 
>  	sensor_inst = devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
>  				   GFP_KERNEL);
> @@ -888,10 +959,10 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
>  	mutex_init(&sensor_inst->mutex);
>  	platform_set_drvdata(pdev, sensor_inst);
> 
> -	index = get_known_custom_sensor_index(hsdev);
> -	if (index >= 0 && index < ARRAY_SIZE(known_sensor_luid)) {
> +	ret = hid_sensor_custom_get_known(hsdev, &match);
> +	if (!ret && match) {

Match must be left NULL on error (if not it should be)
and we are otherwise ignoring ret, so why not just have the following?

	hid_sensor_custom_get_known(hsdev, &match);
	if (match) {
...


>  		sensor_inst->custom_pdev =
> -			hid_sensor_register_platform_device(pdev, hsdev, index);
> +			hid_sensor_register_platform_device(pdev, hsdev, match);
> 
>  		ret = PTR_ERR_OR_ZERO(sensor_inst->custom_pdev);
>  		if (ret) {
