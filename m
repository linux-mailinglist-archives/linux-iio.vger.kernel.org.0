Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662F862DF68
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbiKQPOJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 10:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiKQPNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 10:13:49 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146447FC0A
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 07:09:57 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCjvN2Nr3z6HJTR;
        Thu, 17 Nov 2022 23:07:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:09:55 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 15:09:54 +0000
Date:   Thu, 17 Nov 2022 15:09:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] IIO: hid-sensor-als: Use generic usage
Message-ID: <20221117150954.00004a2a@Huawei.com>
In-Reply-To: <20221116231947.18031-2-p.jungkamp@gmx.net>
References: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
        <20221116231947.18031-1-p.jungkamp@gmx.net>
        <20221116231947.18031-2-p.jungkamp@gmx.net>
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

On Thu, 17 Nov 2022 00:19:46 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_ALS to
> allow this driver to drive the Lenvo custom ambient light sensor,

Lenovo

> which is registered under a 'custom' usage and not HID_USAGE_SENSOR_ALS.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) ambient light sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>

It's a small patch, but in the ideal world, first patch should be a noop
patch that makes the hid-sensor-als stuff able to use a provided
usage ID.  Second patch then adds the new one.

> ---
>  drivers/hid/hid-sensor-custom.c    | 13 +++++++++++++
>  drivers/iio/light/hid-sensor-als.c | 24 +++++++++++++++++-------
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index cb21f9178830..124493b8abaf 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -782,6 +782,19 @@ static const struct hid_sensor_custom_match hid_sensor_custom_known_table[] = {
>  		.luid = "020B000000000000",
>  		.manufacturer = "INTEL",
>  	},
> +	/*
> +	 * Lenovo Intelligent Sensing Solution (LISS)
> +	 */
> +	{	/* ambient light */
> +		.tag = "LISS",
> +		.luid = "0041010200000082",
> +		.model = "STK3X3X Sensor",
> +		.manufacturer = "Vendor 258",

They should definitely rebrand their laptops as this :)


> +		.check_dmi = true,
> +		.dmi.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		}
> +	},
>  	{}
>  };
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 5a1a625d8d16..0ada158582a9 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -86,6 +86,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  			      long mask)
>  {
>  	struct als_state *als_state = iio_priv(indio_dev);
> +	struct hid_sensor_hub_device *hsdev = als_state->common_attributes.hsdev;
>  	int report_id = -1;
>  	u32 address;
>  	int ret_type;
> @@ -110,8 +111,9 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  			hid_sensor_power_state(&als_state->common_attributes,
>  						true);
>  			*val = sensor_hub_input_attr_get_raw_value(
> -					als_state->common_attributes.hsdev,
> -					HID_USAGE_SENSOR_ALS, address,
> +					hsdev,
> +					hsdev->usage,
> +					address,
>  					report_id,
>  					SENSOR_HUB_SYNC,
>  					min < 0);
> @@ -260,7 +262,7 @@ static int als_parse_report(struct platform_device *pdev,
>  			st->als_illum.report_id);
> 
>  	st->scale_precision = hid_sensor_format_scale(
> -				HID_USAGE_SENSOR_ALS,
> +				usage_id,
>  				&st->als_illum,
>  				&st->scale_pre_decml, &st->scale_post_decml);
> 
> @@ -285,7 +287,8 @@ static int hid_als_probe(struct platform_device *pdev)
>  	als_state->common_attributes.hsdev = hsdev;
>  	als_state->common_attributes.pdev = pdev;
> 
> -	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_ALS,
> +	ret = hid_sensor_parse_common_attributes(hsdev,
> +					hsdev->usage,
>  					&als_state->common_attributes,
>  					als_sensitivity_addresses,
>  					ARRAY_SIZE(als_sensitivity_addresses));
> @@ -303,7 +306,8 @@ static int hid_als_probe(struct platform_device *pdev)
> 
>  	ret = als_parse_report(pdev, hsdev,
>  			       (struct iio_chan_spec *)indio_dev->channels,
> -			       HID_USAGE_SENSOR_ALS, als_state);
> +			       hsdev->usage,
> +			       als_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
> @@ -333,7 +337,8 @@ static int hid_als_probe(struct platform_device *pdev)
>  	als_state->callbacks.send_event = als_proc_event;
>  	als_state->callbacks.capture_sample = als_capture_sample;
>  	als_state->callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
> +	ret = sensor_hub_register_callback(hsdev,
> +					hsdev->usage,
>  					&als_state->callbacks);

Where possible, put multiple params on a line up to the 80 chars limit.
If it improves readability for some reason to go a bit beyond 80 chars,
that is fine too.

>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> @@ -356,7 +361,8 @@ static int hid_als_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct als_state *als_state = iio_priv(indio_dev);
> 
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
> +	sensor_hub_remove_callback(hsdev,
> +				hsdev->usage);

Oddly short line wrap.

>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
> 
> @@ -368,6 +374,10 @@ static const struct platform_device_id hid_als_ids[] = {
>  		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>  		.name = "HID-SENSOR-200041",
>  	},
> +	{
> +		/* Format: HID-SENSOR-custom_sensor_tag-usage_id_in_hex_lowercase */
> +		.name = "HID-SENSOR-LISS-0041",
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, hid_als_ids);
> --
> 2.38.1
> 

