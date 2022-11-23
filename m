Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C726366D0
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiKWRRx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbiKWRRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:17:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BEDA459
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 09:17:39 -0800 (PST)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHSVl44Fhz67kVR;
        Thu, 24 Nov 2022 01:17:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:17:38 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:17:37 +0000
Date:   Wed, 23 Nov 2022 17:17:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] IIO: hid-sensor-prox: Use generic usage
Message-ID: <20221123171736.00000e2c@Huawei.com>
In-Reply-To: <20221117234824.6227-4-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
        <20221117234824.6227-1-p.jungkamp@gmx.net>
        <20221117234824.6227-4-p.jungkamp@gmx.net>
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

On Fri, 18 Nov 2022 00:48:24 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_PROX to
> allow this driver to drive the Lenvo custom proximity sensor, which is
> registered under a 'custom' usage and not HID_USAGE_SENSOR_PROX.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) human presence sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
Not sure if this is going via HID or IIO trees, so for now

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Lines are shorter and the switch statement for raw_len is cleaner.
> 
>  drivers/iio/light/hid-sensor-prox.c | 37 ++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index f10fa2abfe72..a47591e1bad9 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -61,6 +61,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  			      long mask)
>  {
>  	struct prox_state *prox_state = iio_priv(indio_dev);
> +	struct hid_sensor_hub_device *hsdev;
>  	int report_id = -1;
>  	u32 address;
>  	int ret_type;
> @@ -75,6 +76,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  			report_id = prox_state->prox_attr.report_id;
>  			min = prox_state->prox_attr.logical_minimum;
>  			address = HID_USAGE_SENSOR_HUMAN_PRESENCE;
> +			hsdev = prox_state->common_attributes.hsdev;
>  			break;
>  		default:
>  			report_id = -1;
> @@ -84,11 +86,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  			hid_sensor_power_state(&prox_state->common_attributes,
>  						true);
>  			*val = sensor_hub_input_attr_get_raw_value(
> -				prox_state->common_attributes.hsdev,
> -				HID_USAGE_SENSOR_PROX, address,
> -				report_id,
> -				SENSOR_HUB_SYNC,
> -				min < 0);
> +				hsdev, hsdev->usage, address, report_id,
> +				SENSOR_HUB_SYNC, min < 0);
>  			hid_sensor_power_state(&prox_state->common_attributes,
>  						false);
>  		} else {
> @@ -191,10 +190,16 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
> 
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_HUMAN_PRESENCE:
> -		prox_state->human_presence = *(u32 *)raw_data;
> -		ret = 0;
> -		break;
> -	default:
> +		switch (raw_len) {
> +		case 1:
> +			prox_state->human_presence = *(u8 *)raw_data;
> +			return 0;
> +		case 4:
> +			prox_state->human_presence = *(u32 *)raw_data;
> +			return 0;
> +		default:
> +			break;
> +		}
>  		break;
>  	}
> 
> @@ -244,7 +249,7 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	prox_state->common_attributes.hsdev = hsdev;
>  	prox_state->common_attributes.pdev = pdev;
> 
> -	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_PROX,
> +	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
>  					&prox_state->common_attributes,
>  					prox_sensitivity_addresses,
>  					ARRAY_SIZE(prox_sensitivity_addresses));
> @@ -262,7 +267,7 @@ static int hid_prox_probe(struct platform_device *pdev)
> 
>  	ret = prox_parse_report(pdev, hsdev,
>  				(struct iio_chan_spec *)indio_dev->channels,
> -				HID_USAGE_SENSOR_PROX, prox_state);
> +				hsdev->usage, prox_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
> @@ -291,8 +296,8 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	prox_state->callbacks.send_event = prox_proc_event;
>  	prox_state->callbacks.capture_sample = prox_capture_sample;
>  	prox_state->callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PROX,
> -					&prox_state->callbacks);
> +	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
> +					   &prox_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
>  		goto error_iio_unreg;
> @@ -314,7 +319,7 @@ static int hid_prox_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct prox_state *prox_state = iio_priv(indio_dev);
> 
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
> 
> @@ -326,6 +331,10 @@ static const struct platform_device_id hid_prox_ids[] = {
>  		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>  		.name = "HID-SENSOR-200011",
>  	},
> +	{
> +		/* Format: HID-SENSOR-tag-usage_id_in_hex_lowercase */
> +		.name = "HID-SENSOR-LISS-0226",
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, hid_prox_ids);
> --
> 2.38.1
> 

