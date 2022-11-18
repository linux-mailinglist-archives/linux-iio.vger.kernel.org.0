Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2635162FEB8
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 21:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiKRUXp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Nov 2022 15:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKRUXn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 15:23:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41AE205D4
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668803020; x=1700339020;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DIVHQugkgshoYzFGgUvDvyApwx9Usxhi51QbFgPk+nU=;
  b=k7f3pcq9DIpCESXMKx+UNWIkVyxufb1eXteSCx3yLJZs7L4QjbATeDC9
   TN4Qssbi75FbU9ZSZ1A+Bd5STZBTvJ4dUVBpLEQBXjjDYhtED+nL7r1by
   vol9lK11Ac4Z0cJqdxi5U5vQGmqNqrp0He9z+OiVA/k5EVJA2k8EHLIRM
   P91+qY6VX4PMETsX8OyOJVwtWFQRnNPYUZS+nBPyhfNmcslRW0Ff27KZm
   CSgcZWf5IL7tkJLl/I3nfs1kAnprY69HU0uZcnmNWys2dReF06sZsmM+M
   Kt/CvQTFlANNJl8b0nTz+hFHElvHKOArF/P81P4olw97ERP3LFqlnzH5a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375367450"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="375367450"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:23:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765283836"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="765283836"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:23:37 -0800
Message-ID: <499ca4a6bbebb458a1132e36462f97121ccb96d3.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/4] IIO: hid-sensor-als: Use generic usage
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Fri, 18 Nov 2022 12:23:36 -0800
In-Reply-To: <20221117234824.6227-3-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
         <20221117234824.6227-1-p.jungkamp@gmx.net>
         <20221117234824.6227-3-p.jungkamp@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-11-18 at 00:48 +0100, Philipp Jungkamp wrote:
> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_ALS to
> allow this driver to drive the Lenovo custom ambient light sensor,
> which is registered under a 'custom' usage and not
> HID_USAGE_SENSOR_ALS.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) ambient light sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> Less unnecessary line breaks in function calls.
> 
>  drivers/iio/light/hid-sensor-als.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c
> b/drivers/iio/light/hid-sensor-als.c
> index 5a1a625d8d16..eb1aedad7edc 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -86,6 +86,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
>                               long mask)
>  {
>         struct als_state *als_state = iio_priv(indio_dev);
> +       struct hid_sensor_hub_device *hsdev = als_state-
> >common_attributes.hsdev;
>         int report_id = -1;
>         u32 address;
>         int ret_type;
> @@ -110,11 +111,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
>                         hid_sensor_power_state(&als_state-
> >common_attributes,
>                                                 true);
>                         *val = sensor_hub_input_attr_get_raw_value(
> -                                       als_state-
> >common_attributes.hsdev,
> -                                       HID_USAGE_SENSOR_ALS, address,
> -                                       report_id,
> -                                       SENSOR_HUB_SYNC,
> -                                       min < 0);
> +                                       hsdev, hsdev->usage, address,
> report_id,
> +                                       SENSOR_HUB_SYNC, min < 0);
>                         hid_sensor_power_state(&als_state-
> >common_attributes,
>                                                 false);
>                 } else {
> @@ -259,9 +257,7 @@ static int als_parse_report(struct platform_device
> *pdev,
>         dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
>                         st->als_illum.report_id);
> 
> -       st->scale_precision = hid_sensor_format_scale(
> -                               HID_USAGE_SENSOR_ALS,
> -                               &st->als_illum,
> +       st->scale_precision = hid_sensor_format_scale(usage_id, &st-
> >als_illum,
>                                 &st->scale_pre_decml, &st-
> >scale_post_decml);
> 
>         return ret;
> @@ -285,7 +281,8 @@ static int hid_als_probe(struct platform_device
> *pdev)
>         als_state->common_attributes.hsdev = hsdev;
>         als_state->common_attributes.pdev = pdev;
> 
> -       ret = hid_sensor_parse_common_attributes(hsdev,
> HID_USAGE_SENSOR_ALS,
> +       ret = hid_sensor_parse_common_attributes(hsdev,
> +                                       hsdev->usage,
>                                         &als_state->common_attributes,
>                                         als_sensitivity_addresses,
>                                         ARRAY_SIZE(als_sensitivity_addr
> esses));
> @@ -303,7 +300,8 @@ static int hid_als_probe(struct platform_device
> *pdev)
> 
>         ret = als_parse_report(pdev, hsdev,
>                                (struct iio_chan_spec *)indio_dev-
> >channels,
> -                              HID_USAGE_SENSOR_ALS, als_state);
> +                              hsdev->usage,
> +                              als_state);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to setup attributes\n");
>                 return ret;
> @@ -333,8 +331,7 @@ static int hid_als_probe(struct platform_device
> *pdev)
>         als_state->callbacks.send_event = als_proc_event;
>         als_state->callbacks.capture_sample = als_capture_sample;
>         als_state->callbacks.pdev = pdev;
> -       ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
> -                                       &als_state->callbacks);
> +       ret = sensor_hub_register_callback(hsdev, hsdev->usage,
> &als_state->callbacks);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "callback reg failed\n");
>                 goto error_iio_unreg;
> @@ -356,7 +353,7 @@ static int hid_als_remove(struct platform_device
> *pdev)
>         struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>         struct als_state *als_state = iio_priv(indio_dev);
> 
> -       sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
> +       sensor_hub_remove_callback(hsdev, hsdev->usage);
>         iio_device_unregister(indio_dev);
>         hid_sensor_remove_trigger(indio_dev, &als_state-
> >common_attributes);
> 
> @@ -368,6 +365,10 @@ static const struct platform_device_id
> hid_als_ids[] = {
>                 /* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>                 .name = "HID-SENSOR-200041",
>         },
> +       {
> +               /* Format: HID-SENSOR-custom_sensor_tag-
> usage_id_in_hex_lowercase */
> +               .name = "HID-SENSOR-LISS-0041",
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, hid_als_ids);
> --
> 2.38.1
> 


