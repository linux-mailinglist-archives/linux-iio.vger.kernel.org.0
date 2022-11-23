Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB66366C3
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiKWRQi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiKWRQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:16:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7B43AE2
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 09:16:36 -0800 (PST)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHSQQ3GKgz6HJVK;
        Thu, 24 Nov 2022 01:13:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:16:34 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:16:34 +0000
Date:   Wed, 23 Nov 2022 17:16:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] IIO: hid-sensor-als: Use generic usage
Message-ID: <20221123171633.000075c7@Huawei.com>
In-Reply-To: <20221117234824.6227-3-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
        <20221117234824.6227-1-p.jungkamp@gmx.net>
        <20221117234824.6227-3-p.jungkamp@gmx.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 18 Nov 2022 00:48:23 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_ALS to
> allow this driver to drive the Lenovo custom ambient light sensor,
> which is registered under a 'custom' usage and not HID_USAGE_SENSOR_ALS.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) ambient light sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>

One comment on the existing code inline. Not something that needs cleaning
up in this series, but would be nice if someone has time to deal with
it separately.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Less unnecessary line breaks in function calls.
> 
>  drivers/iio/light/hid-sensor-als.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 5a1a625d8d16..eb1aedad7edc 100644
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
> @@ -110,11 +111,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  			hid_sensor_power_state(&als_state->common_attributes,
>  						true);
>  			*val = sensor_hub_input_attr_get_raw_value(
> -					als_state->common_attributes.hsdev,
> -					HID_USAGE_SENSOR_ALS, address,
> -					report_id,
> -					SENSOR_HUB_SYNC,
> -					min < 0);
> +					hsdev, hsdev->usage, address, report_id,
> +					SENSOR_HUB_SYNC, min < 0);
>  			hid_sensor_power_state(&als_state->common_attributes,
>  						false);
>  		} else {
> @@ -259,9 +257,7 @@ static int als_parse_report(struct platform_device *pdev,
>  	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
>  			st->als_illum.report_id);
> 
> -	st->scale_precision = hid_sensor_format_scale(
> -				HID_USAGE_SENSOR_ALS,
> -				&st->als_illum,
> +	st->scale_precision = hid_sensor_format_scale(usage_id, &st->als_illum,
>  				&st->scale_pre_decml, &st->scale_post_decml);
> 
>  	return ret;
> @@ -285,7 +281,8 @@ static int hid_als_probe(struct platform_device *pdev)
>  	als_state->common_attributes.hsdev = hsdev;
>  	als_state->common_attributes.pdev = pdev;
> 
> -	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_ALS,
> +	ret = hid_sensor_parse_common_attributes(hsdev,
> +					hsdev->usage,
>  					&als_state->common_attributes,
>  					als_sensitivity_addresses,
>  					ARRAY_SIZE(als_sensitivity_addresses));
> @@ -303,7 +300,8 @@ static int hid_als_probe(struct platform_device *pdev)
> 
>  	ret = als_parse_report(pdev, hsdev,
>  			       (struct iio_chan_spec *)indio_dev->channels,

Side comment so shouldn't affect this series, but this is nasty.

Channels should not be modified by casting away the const (type is
struct iio_chan_spec const *)

Much better to use a local copy of the pointer, modify the content and only assign
it to indio_dev once it is const.

> -			       HID_USAGE_SENSOR_ALS, als_state);
> +			       hsdev->usage,
> +			       als_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
> @@ -333,8 +331,7 @@ static int hid_als_probe(struct platform_device *pdev)
>  	als_state->callbacks.send_event = als_proc_event;
>  	als_state->callbacks.capture_sample = als_capture_sample;
>  	als_state->callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
> -					&als_state->callbacks);
> +	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
>  		goto error_iio_unreg;
> @@ -356,7 +353,7 @@ static int hid_als_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct als_state *als_state = iio_priv(indio_dev);
> 
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
> 
> @@ -368,6 +365,10 @@ static const struct platform_device_id hid_als_ids[] = {
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

