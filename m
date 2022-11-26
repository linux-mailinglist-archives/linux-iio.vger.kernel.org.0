Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B486397AE
	for <lists+linux-iio@lfdr.de>; Sat, 26 Nov 2022 19:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiKZSwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Nov 2022 13:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiKZSwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2022 13:52:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73269592
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 10:52:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79B5360B94
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 18:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E108C433D6;
        Sat, 26 Nov 2022 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669488761;
        bh=X/0hVrQ/WePzHE5znxhrHb+bAt1Qf8yBNwSFS9iciag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GF+CznDhFxs7+3zt8yLWJUK14AVdHdm2Q6/7wusigCSr9wzghZpn/YE8wZg2PPQDK
         7GIpyHG8BAscxSq3P/YwC0dli4GVsh88iianB9PjOXSMN2oXlNoFePoZfPeBaZk6as
         dwoly/C4UkMWMXPRFfHaLJlmlAFvHqH+0KVNj4KVOks/2fCanj+ryu633MH0RIqDyY
         mwsQc8Y2eqXKS+xz8EaxE6n0qhocoKXTw9yuiPJB4eD8lUpRmv6EltX87g22LjCRk8
         /lMnjdm4qb9f1w51r4dHkpvEFfwyxohUpIfe4xzj2FpUCpMg97aEnoXGW+Nv1YMzYA
         N8qhDyUgXuE8A==
Date:   Sat, 26 Nov 2022 19:05:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/4] IIO: hid-sensor-als: Use generic usage
Message-ID: <20221126190519.0f804316@jic23-huawei>
In-Reply-To: <20221124233841.3103-4-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
        <20221124233841.3103-4-p.jungkamp@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Nov 2022 00:38:40 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_ALS to
> allow this driver to drive the Lenovo custom ambient light sensor,
> which is registered under a 'custom' usage and not HID_USAGE_SENSOR_ALS.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) ambient light sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
Again, please pick up tags given when posting new versions.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> v2:
> - Remove some unnecessary newlines in function calls.
> 
> v3:
> - No change.
> 
> v4:
> - No change.
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

