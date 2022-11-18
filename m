Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6462FE9A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 21:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiKRUMK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Nov 2022 15:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiKRUMG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 15:12:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E824BD3
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668802322; x=1700338322;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ge125/4IRFdPCxJ9w12WIb7hkKKS3W92lPFbepGdClk=;
  b=PeY13Tw8qM8xowWchWgZmsz0L/hEz6BG9JtnOrjhCfus18zuFCdnNmHT
   fLKWiWiUtfWNB7aJjDsXT1Ct13XU4m2lHXeyzx4+5VUmy9QUigx3NeEp0
   0UR+gjNrfj/B+glymPE9U7OEJukTO3q9BSGktJeZyR6XF6PK/6kjhMTJF
   7MlvrwGMZ2DEoRJq6gHNRbQibBFPhwoV4/j+7dOug0rJ3CFJxqMuHHlOo
   MectMIkqf15sMHHwRGn3T+i1kPaWtsZ5IANT0cnQhnu6W/o0NHZ1uqghH
   X7M5KkdSawcVCPmAUO3NlS1wJeE7i3Zu0h4jyOVI8/Ri464XTPfN/KDpW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="296585625"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="296585625"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:11:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="634543071"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="634543071"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:11:44 -0800
Message-ID: <ab3dec07603f4edd2e77db3e3278fd204aa279ab.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/4] HID: hid-sensor-custom: Allow more custom iio
 sensors
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Fri, 18 Nov 2022 12:11:44 -0800
In-Reply-To: <20221117234302.3875-1-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
         <20221117234302.3875-1-p.jungkamp@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-11-18 at 00:42 +0100, Philipp Jungkamp wrote:
> The known LUID table for established/known custom HID sensors was
> limited to sensors with "INTEL" as manufacturer. But some vendors
> such
> as Lenovo also include fairly standard iio sensors (e.g. ambient
> light)
> in their custom sensors.
> 
> Expand the known custom sensors table by a tag used for the platform
> device name and match sensors based on the LUID as well as optionally
> on model and manufacturer properties.
> Introduce sensors from Lenovo's "Intelligent Sensing Solution" on the
> Lenovo Yoga 9 14IAP7 as an example.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
> ---
> Hello,
> 
> here's a short summary of changes compared to v1:
> 
>  Added an additional commit which adds the LISS entries to the known
>  custom sensors.
> 
>  Removed all unnecessary linebreaks from modified function calls and
> stayed
>  below the 80 columns.
> 
>  Revisited the matching logic and removed the explicit error codes
>  in favor of bools and forwarding the inner error.
> 
>  I noticed that the strange ENODATA return code was already redundant
> with
>  the **known out parameter. So I removed it.
> 
> Regards,
> Philipp Jungkamp
> 
>  drivers/hid/hid-sensor-custom.c | 211 +++++++++++++++++++++---------
> --
>  include/linux/hid-sensor-ids.h  |   1 +
>  2 files changed, 142 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 32c2306e240d..89e56913c92e 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -5,6 +5,7 @@
>   */
> 
>  #include <linux/ctype.h>
> +#include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -750,114 +751,184 @@ static void
> hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
> 
>  }
> 
> -/* luid defined in FW (e.g. ISH).  Maybe used to identify sensor. */
> -static const char *const known_sensor_luid[] = { "020B000000000000"
> };
> +/*
> + * Match a known custom sensor.
> + * tag and luid is mandatory.
> + */
> +struct hid_sensor_custom_match {
> +       const char *tag;
> +       const char *luid;
> +       const char *model;
> +       const char *manufacturer;
> +       bool check_dmi;
> +       struct dmi_system_id dmi;
> +};
> 
> -static int get_luid_table_index(unsigned char *usage_str)
> -{
> -       int i;
> +/*
> + * Custom sensor properties used for matching.
> + */
> +struct hid_sensor_custom_properties {
> +       u16 serial_num[HID_CUSTOM_MAX_FEATURE_BYTES];
> +       u16 model[HID_CUSTOM_MAX_FEATURE_BYTES];
> +       u16 manufacturer[HID_CUSTOM_MAX_FEATURE_BYTES];
> +};
> +
> +static const struct hid_sensor_custom_match
> hid_sensor_custom_known_table[] = {
> +       /*
> +        * Intel Integrated Sensor Hub (ISH)
> +        */
> +       {       /* Intel ISH hinge */
> +               .tag = "INT",
> +               .luid = "020B000000000000",
> +               .manufacturer = "INTEL",
> +       },
> +       {}
> +};
> 
> -       for (i = 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
> -               if (!strncmp(usage_str, known_sensor_luid[i],
> -                            strlen(known_sensor_luid[i])))
> -                       return i;
> +static bool hid_sensor_custom_prop_match_str(const u16 *prop, const
> char *match,
> +                                            size_t count)
> +{
> +       while (count-- && *prop && *match) {
> +               if (*prop & 0xFF00 ||
> +                   *match != (char) *prop)
> +                       return false;
> +               prop++;
> +               match++;
>         }
> 
> -       return -ENODEV;
> +       return (count == -1) || *prop == (u16)*match;
>  }
> 
> -static int get_known_custom_sensor_index(struct
> hid_sensor_hub_device *hsdev)
> +static bool hid_sensor_custom_get_prop(struct hid_sensor_hub_device
> *hsdev,
> +                                     u32 prop_usage_id, size_t
> prop_size,
> +                                     u16 *prop)
>  {
> -       struct hid_sensor_hub_attribute_info sensor_manufacturer = {
> 0 };
> -       struct hid_sensor_hub_attribute_info sensor_luid_info = { 0
> };
> +       struct hid_sensor_hub_attribute_info prop_attr = { 0 };
>         int report_size;
>         int ret;
> -       static u16 w_buf[HID_CUSTOM_MAX_FEATURE_BYTES];
> -       static char buf[HID_CUSTOM_MAX_FEATURE_BYTES];
> -       int i;
> 
> -       memset(w_buf, 0, sizeof(w_buf));
> -       memset(buf, 0, sizeof(buf));
> +       memset(prop, 0, prop_size);
> 
> -       /* get manufacturer info */
> -       ret = sensor_hub_input_get_attribute_info(hsdev,
> -                       HID_FEATURE_REPORT, hsdev->usage,
> -                       HID_USAGE_SENSOR_PROP_MANUFACTURER,
> &sensor_manufacturer);
> +       ret = sensor_hub_input_get_attribute_info(hsdev,
> HID_FEATURE_REPORT,
> +                                                 hsdev->usage,
> prop_usage_id,
> +                                                 &prop_attr);
>         if (ret < 0)
> -               return ret;
> +               return 0;
> 
> -       report_size =
> -               sensor_hub_get_feature(hsdev,
> sensor_manufacturer.report_id,
> -                                      sensor_manufacturer.index,
> sizeof(w_buf),
> -                                      w_buf);
> +       report_size = sensor_hub_get_feature(hsdev,
> prop_attr.report_id,
> +                                            prop_attr.index,
> prop_size, prop);
>         if (report_size <= 0) {
>                 hid_err(hsdev->hdev,
> -                       "Failed to get sensor manufacturer info
> %d\n",
> +                       "Failed to get sensor property %08x %d\n",
> +                       prop_usage_id,
>                         report_size);
> -               return -ENODEV;
> +               return report_size;
>         }
> 
> -       /* convert from wide char to char */
> -       for (i = 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
> -               buf[i] = (char)w_buf[i];
> +       return 0;
> +}
> +
> +static bool
> +hid_sensor_custom_do_match(struct hid_sensor_hub_device *hsdev,
> +                          const struct hid_sensor_custom_match
> *match,
> +                          const struct hid_sensor_custom_properties
> *prop)
> +{
> +       struct dmi_system_id dmi[] = { match->dmi, { 0 } };
> +
> +       if (!hid_sensor_custom_prop_match_str(prop->serial_num,
> "LUID:", 5) ||
> +           !hid_sensor_custom_prop_match_str(prop->serial_num + 5,
> match->luid,
> +                                            
> HID_CUSTOM_MAX_FEATURE_BYTES - 5))
> +               return false;
> +
> +       if (match->model &&
> +           !hid_sensor_custom_prop_match_str(prop->model, match-
> >model,
> +                                            
> HID_CUSTOM_MAX_FEATURE_BYTES))
> +               return false;
> 
> -       /* ensure it's ISH sensor */
> -       if (strncmp(buf, "INTEL", strlen("INTEL")))
> -               return -ENODEV;
> +       if (match->manufacturer &&
> +           !hid_sensor_custom_prop_match_str(prop->manufacturer,
> match->manufacturer,
> +                                            
> HID_CUSTOM_MAX_FEATURE_BYTES))
> +               return false;
> 
> -       memset(w_buf, 0, sizeof(w_buf));
> -       memset(buf, 0, sizeof(buf));
> +       if (match->check_dmi && !dmi_check_system(dmi))
> +               return false;
> 
> -       /* get real usage id */
> -       ret = sensor_hub_input_get_attribute_info(hsdev,
> -                       HID_FEATURE_REPORT, hsdev->usage,
> -                       HID_USAGE_SENSOR_PROP_SERIAL_NUM,
> &sensor_luid_info);
> +       return true;
> +}
> +
> +static int
> +hid_sensor_custom_properties_get(struct hid_sensor_hub_device
> *hsdev,
> +                                struct hid_sensor_custom_properties
> *prop)
> +{
> +       int ret;
> +
> +       ret = hid_sensor_custom_get_prop(hsdev,
> +                                       
> HID_USAGE_SENSOR_PROP_SERIAL_NUM,
> +                                       
> HID_CUSTOM_MAX_FEATURE_BYTES,
> +                                        prop->serial_num);
>         if (ret < 0)
>                 return ret;
> 
> -       report_size = sensor_hub_get_feature(hsdev,
> sensor_luid_info.report_id,
> -                                            sensor_luid_info.index,
> sizeof(w_buf),
> -                                            w_buf);
> -       if (report_size <= 0) {
> -               hid_err(hsdev->hdev, "Failed to get real usage info
> %d\n",
> -                       report_size);
> -               return -ENODEV;
> -       }
> +       ret = hid_sensor_custom_get_prop(hsdev,
> +                                        HID_USAGE_SENSOR_PROP_MODEL,
> +                                       
> HID_CUSTOM_MAX_FEATURE_BYTES,
> +                                        prop->model);
> +       if (ret < 0)
> +               return ret;
> 
> -       /* convert from wide char to char */
> -       for (i = 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
> -               buf[i] = (char)w_buf[i];
> +       ret = hid_sensor_custom_get_prop(hsdev,
> +                                       
> HID_USAGE_SENSOR_PROP_MANUFACTURER,
> +                                       
> HID_CUSTOM_MAX_FEATURE_BYTES,
> +                                        prop->manufacturer);
> +       if (ret < 0)
> +               return ret;
> 
> -       if (strlen(buf) != strlen(known_sensor_luid[0]) + 5) {
> -               hid_err(hsdev->hdev,
> -                       "%s luid length not match %zu != (%zu +
> 5)\n", __func__,
> -                       strlen(buf), strlen(known_sensor_luid[0]));
> -               return -ENODEV;
> +       return 0;
> +}
> +
> +static int
> +hid_sensor_custom_get_known(struct hid_sensor_hub_device *hsdev,
> +                           const struct hid_sensor_custom_match
> **known)
> +{
> +       int ret;
> +       const struct hid_sensor_custom_match *match =
> +               hid_sensor_custom_known_table;
> +       struct hid_sensor_custom_properties prop;
> +
> +       ret = hid_sensor_custom_properties_get(hsdev, &prop);
> +       if (ret < 0)
> +               return ret;
> +
> +       while (match->tag) {
> +               if (hid_sensor_custom_do_match(hsdev, match, &prop))
> {
> +                       *known = match;
> +                       return 0;
> +               }
> +               match++;
>         }
> 
> -       /* get table index with luid (not matching 'LUID: ' in luid)
> */
> -       return get_luid_table_index(&buf[5]);
> +       *known = NULL;
> +       return 0;

The function returns 0, means success. The caller needn't look at some
other param to check if there was some known sensor exists.

return -ENODATA;

 The caller will be simplified also. He doesn't have to check "match"
address.

>  }
> 
>  static struct platform_device *
>  hid_sensor_register_platform_device(struct platform_device *pdev,
>                                     struct hid_sensor_hub_device
> *hsdev,
> -                                   int index)
> +                                   const struct
> hid_sensor_custom_match *match)
>  {
> -       char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
> +       char real_usage[HID_SENSOR_USAGE_LENGTH];
>         struct platform_device *custom_pdev;
>         const char *dev_name;
>         char *c;
> 
> -       /* copy real usage id */
> -       memcpy(real_usage, known_sensor_luid[index], 4);
> +       memcpy(real_usage, match->luid, 4);
> +       real_usage[4] = '\0';
You already did init whole array above. Do you need this?

> 
> -       /* usage id are all lowcase */
>         for (c = real_usage; *c != '\0'; c++)
>                 *c = tolower(*c);
> 
> -       /* HID-SENSOR-INT-REAL_USAGE_ID */
> -       dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s",
> real_usage);
> +       dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
> +                            match->tag, real_usage);
>         if (!dev_name)
>                 return ERR_PTR(-ENOMEM);
> 
> @@ -873,7 +944,7 @@ static int hid_sensor_custom_probe(struct
> platform_device *pdev)
>         struct hid_sensor_custom *sensor_inst;
>         struct hid_sensor_hub_device *hsdev = pdev-
> >dev.platform_data;
>         int ret;
> -       int index;
> +       const struct hid_sensor_custom_match *match = NULL;
Not necessary to initialize, if you follow above advise to return error
for hid_sensor_custom_get_known()

> 
>         sensor_inst = devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
>                                    GFP_KERNEL);
> @@ -888,10 +959,10 @@ static int hid_sensor_custom_probe(struct
> platform_device *pdev)
>         mutex_init(&sensor_inst->mutex);
>         platform_set_drvdata(pdev, sensor_inst);
> 
> -       index = get_known_custom_sensor_index(hsdev);
> -       if (index >= 0 && index < ARRAY_SIZE(known_sensor_luid)) {
> +       ret = hid_sensor_custom_get_known(hsdev, &match);
If hid_sensor_custom_get_known() returns error you don't need to check
validity of "match" in below if.

Thanks,
Srinivas

> +       if (!ret && match) {
>                 sensor_inst->custom_pdev =
> -                       hid_sensor_register_platform_device(pdev,
> hsdev, index);
> +                       hid_sensor_register_platform_device(pdev,
> hsdev, match);
> 
>                 ret = PTR_ERR_OR_ZERO(sensor_inst->custom_pdev);
>                 if (ret) {
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
> sensor-ids.h
> index ac631159403a..13b1e65fbdcc 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -132,6 +132,7 @@
>  #define
> HID_USAGE_SENSOR_PROP_FRIENDLY_NAME                    0x200301
>  #define
> HID_USAGE_SENSOR_PROP_SERIAL_NUM                       0x200307
>  #define
> HID_USAGE_SENSOR_PROP_MANUFACTURER                     0x200305
> +#define
> HID_USAGE_SENSOR_PROP_MODEL                            0x200306
>  #define
> HID_USAGE_SENSOR_PROP_REPORT_INTERVAL                  0x20030E
>  #define
> HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS                  0x20030F
>  #define
> HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT            0x200310
> --
> 2.38.1
> 


