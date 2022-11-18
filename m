Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687E762FECD
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKRU0m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Nov 2022 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKRU0k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 15:26:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15FB65875
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668803199; x=1700339199;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UgeD6vjLaeU0+BJqDReFS64CELl8ewOzEJsCdVOvZrI=;
  b=fyr3r4NXVtSwiFtJgzUu33ddzfQouZPlW0Q/fX4k5FuXYmKvbHZoCku9
   pEQI3Xn4WSXscu6zWadmXGF7TUYFRkbNLem6w3T5k3etNo0RwgZOIXuBE
   d7y7H1/UVfg6PfvZ8wyt8o7vVVUsWnQFGtx7qAxpl6aNDj8n8caCq8sXs
   lNiejB5ETj9MX42uSqN2ZH7putHvFu18WltyoZMbrqUVEK9iT+3SNu6QZ
   Hygu8XXKcuhBYi//kLKHeyl1WE/OxZ8T2sT6VmftKYUrR9AR0WS1BoBJ9
   NnPSxNmFoCSfHhAy6T+Z7hGWV0wzfnP2SVbFrytYu3ByQZZzToMlcINOB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="399514462"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="399514462"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:26:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="709155595"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="709155595"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:26:39 -0800
Message-ID: <960a1f37f63fc56364b5e3e5cf83c67fd7a06730.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/4] IIO: hid-sensor-prox: Use generic usage
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Fri, 18 Nov 2022 12:26:39 -0800
In-Reply-To: <20221117234824.6227-4-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
         <20221117234824.6227-1-p.jungkamp@gmx.net>
         <20221117234824.6227-4-p.jungkamp@gmx.net>
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
> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_PROX to
> allow this driver to drive the Lenvo custom proximity sensor, which
> is
> registered under a 'custom' usage and not HID_USAGE_SENSOR_PROX.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) human presence
> sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
> ---
> Lines are shorter and the switch statement for raw_len is cleaner.
Didn't understand why this change is required.

Thanks,
Srinivas

> 
>  drivers/iio/light/hid-sensor-prox.c | 37 ++++++++++++++++++---------
> --
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index f10fa2abfe72..a47591e1bad9 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -61,6 +61,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>                               long mask)
>  {
>         struct prox_state *prox_state = iio_priv(indio_dev);
> +       struct hid_sensor_hub_device *hsdev;
>         int report_id = -1;
>         u32 address;
>         int ret_type;
> @@ -75,6 +76,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>                         report_id = prox_state->prox_attr.report_id;
>                         min = prox_state->prox_attr.logical_minimum;
>                         address = HID_USAGE_SENSOR_HUMAN_PRESENCE;
> +                       hsdev = prox_state->common_attributes.hsdev;
>                         break;
>                 default:
>                         report_id = -1;
> @@ -84,11 +86,8 @@ static int prox_read_raw(struct iio_dev
> *indio_dev,
>                         hid_sensor_power_state(&prox_state-
> >common_attributes,
>                                                 true);
>                         *val = sensor_hub_input_attr_get_raw_value(
> -                               prox_state->common_attributes.hsdev,
> -                               HID_USAGE_SENSOR_PROX, address,
> -                               report_id,
> -                               SENSOR_HUB_SYNC,
> -                               min < 0);
> +                               hsdev, hsdev->usage, address,
> report_id,
> +                               SENSOR_HUB_SYNC, min < 0);
>                         hid_sensor_power_state(&prox_state-
> >common_attributes,
>                                                 false);
>                 } else {
> @@ -191,10 +190,16 @@ static int prox_capture_sample(struct
> hid_sensor_hub_device *hsdev,
> 
>         switch (usage_id) {
>         case HID_USAGE_SENSOR_HUMAN_PRESENCE:
> -               prox_state->human_presence = *(u32 *)raw_data;
> -               ret = 0;
> -               break;
> -       default:
> +               switch (raw_len) {
> +               case 1:
> +                       prox_state->human_presence = *(u8 *)raw_data;
> +                       return 0;
> +               case 4:
> +                       prox_state->human_presence = *(u32
> *)raw_data;
> +                       return 0;
> +               default:
> +                       break;
> +               }
>                 break;
>         }
> 
> @@ -244,7 +249,7 @@ static int hid_prox_probe(struct platform_device
> *pdev)
>         prox_state->common_attributes.hsdev = hsdev;
>         prox_state->common_attributes.pdev = pdev;
> 
> -       ret = hid_sensor_parse_common_attributes(hsdev,
> HID_USAGE_SENSOR_PROX,
> +       ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
>                                         &prox_state-
> >common_attributes,
>                                         prox_sensitivity_addresses,
>                                         ARRAY_SIZE(prox_sensitivity_a
> ddresses));
> @@ -262,7 +267,7 @@ static int hid_prox_probe(struct platform_device
> *pdev)
> 
>         ret = prox_parse_report(pdev, hsdev,
>                                 (struct iio_chan_spec *)indio_dev-
> >channels,
> -                               HID_USAGE_SENSOR_PROX, prox_state);
> +                               hsdev->usage, prox_state);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to setup attributes\n");
>                 return ret;
> @@ -291,8 +296,8 @@ static int hid_prox_probe(struct platform_device
> *pdev)
>         prox_state->callbacks.send_event = prox_proc_event;
>         prox_state->callbacks.capture_sample = prox_capture_sample;
>         prox_state->callbacks.pdev = pdev;
> -       ret = sensor_hub_register_callback(hsdev,
> HID_USAGE_SENSOR_PROX,
> -                                       &prox_state->callbacks);
> +       ret = sensor_hub_register_callback(hsdev, hsdev->usage,
> +                                          &prox_state->callbacks);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "callback reg failed\n");
>                 goto error_iio_unreg;
> @@ -314,7 +319,7 @@ static int hid_prox_remove(struct platform_device
> *pdev)
>         struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>         struct prox_state *prox_state = iio_priv(indio_dev);
> 
> -       sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
> +       sensor_hub_remove_callback(hsdev, hsdev->usage);
>         iio_device_unregister(indio_dev);
>         hid_sensor_remove_trigger(indio_dev, &prox_state-
> >common_attributes);
> 
> @@ -326,6 +331,10 @@ static const struct platform_device_id
> hid_prox_ids[] = {
>                 /* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>                 .name = "HID-SENSOR-200011",
>         },
> +       {
> +               /* Format: HID-SENSOR-tag-usage_id_in_hex_lowercase
> */
> +               .name = "HID-SENSOR-LISS-0226",
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, hid_prox_ids);
> --
> 2.38.1
> 


