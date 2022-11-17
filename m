Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7BD62DF7E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbiKQPUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 10:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbiKQPUD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 10:20:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827778D65
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 07:14:34 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCk0j5vNKz6HJLs;
        Thu, 17 Nov 2022 23:12:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:14:32 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 15:14:32 +0000
Date:   Thu, 17 Nov 2022 15:14:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
CC:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] IIO: hid-sensor-prox: Use generic usage
Message-ID: <20221117151431.00001bab@Huawei.com>
In-Reply-To: <20221116231947.18031-3-p.jungkamp@gmx.net>
References: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
        <20221116231947.18031-1-p.jungkamp@gmx.net>
        <20221116231947.18031-3-p.jungkamp@gmx.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Thu, 17 Nov 2022 00:19:47 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_PROX to
> allow this driver to drive the Lenvo custom proximity sensor, which is
> registered under a 'custom' usage and not HID_USAGE_SENSOR_PROX.
> 
> Check for raw_len to accomodate the ReportSize(8) field used on the
> Lenovo Yoga 9 14IAP7.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) human presence sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
As with previous - prefer this split into a noop patch then one that
adds the new use case.

It's small enough I'm not that bothered though if you'd rather not.

A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/hid/hid-sensor-custom.c     | 10 ++++++++
>  drivers/iio/light/hid-sensor-prox.c | 39 +++++++++++++++++++++--------
>  2 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 124493b8abaf..ec49dc80f074 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -795,6 +795,16 @@ static const struct hid_sensor_custom_match hid_sensor_custom_known_table[] = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>  		}
>  	},
> +	{	/* human presence */
> +		.tag = "LISS",
> +		.luid = "0226000171AC0081",
> +		.model = "VL53L1_HOD Sensor",
> +		.manufacturer = "ST_MICRO",
> +		.check_dmi = true,
> +		.dmi.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		}
> +	},
>  	{}
>  };
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index f10fa2abfe72..cca6b75c44d5 100644
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
> @@ -84,8 +86,9 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  			hid_sensor_power_state(&prox_state->common_attributes,
>  						true);
>  			*val = sensor_hub_input_attr_get_raw_value(
> -				prox_state->common_attributes.hsdev,
> -				HID_USAGE_SENSOR_PROX, address,
> +				hsdev,
> +				hsdev->usage,
> +				address,
Wrapping is already odd here but this patch can avoid making it worse
by trying to get multiple params on one line < 80 chars.

>  				report_id,
>  				SENSOR_HUB_SYNC,
>  				min < 0);
> @@ -191,10 +194,16 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
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
> +			ret = 0;

No obvious reason not to use direct returns here as they will be slightly
more readable as well as shortening the code a little.

			return 0;

> +			break;
> +		case 4:
> +			prox_state->human_presence = *(u32 *)raw_data;
> +			ret = 0;
> +			break;

Likely to generate warnings if a compiler can't see far enough to tell this
only ever gets 1 or 4 in raw_len.

Avoid that by adding a default.

> +		}
>  		break;
>  	}
> 
> @@ -244,7 +253,8 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	prox_state->common_attributes.hsdev = hsdev;
>  	prox_state->common_attributes.pdev = pdev;
> 
> -	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_PROX,
> +	ret = hid_sensor_parse_common_attributes(hsdev,
> +					hsdev->usage,
>  					&prox_state->common_attributes,
>  					prox_sensitivity_addresses,
>  					ARRAY_SIZE(prox_sensitivity_addresses));
> @@ -262,7 +272,8 @@ static int hid_prox_probe(struct platform_device *pdev)
> 
>  	ret = prox_parse_report(pdev, hsdev,
>  				(struct iio_chan_spec *)indio_dev->channels,
> -				HID_USAGE_SENSOR_PROX, prox_state);
> +				hsdev->usage,
> +				prox_state);
As below.

>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
> @@ -291,8 +302,9 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	prox_state->callbacks.send_event = prox_proc_event;
>  	prox_state->callbacks.capture_sample = prox_capture_sample;
>  	prox_state->callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PROX,
> -					&prox_state->callbacks);
> +	ret = sensor_hub_register_callback(hsdev,
> +					   hsdev->usage,
> +					   &prox_state->callbacks);
As below.

>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
>  		goto error_iio_unreg;
> @@ -314,7 +326,8 @@ static int hid_prox_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct prox_state *prox_state = iio_priv(indio_dev);
> 
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
> +	sensor_hub_remove_callback(hsdev,
> +				   hsdev->usage);

Similar to previous patch.  Line wrap is too short.

>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
> 
> @@ -326,6 +339,10 @@ static const struct platform_device_id hid_prox_ids[] = {
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

