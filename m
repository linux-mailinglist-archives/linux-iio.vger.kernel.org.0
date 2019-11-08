Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45833F5A86
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 23:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfKHWEJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 17:04:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35460 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKHWEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 17:04:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id n4so3561567qte.2;
        Fri, 08 Nov 2019 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0vwRgqyr9uL56xIsnlyB0vtc78SAThHMfFo6yoXABw=;
        b=aY938u19Cog49SRqtWybDUsW1XMtuSO82o7l20hA26CEolf1ISqAQMs1NEVUB4lVsL
         VGjGrA5YmWGMThB4p9u/xqGHPYDlyYnuyceNgZKTkl14+pzwxGFdb9xrvM79VOua/wlF
         ElViveuXnspF2VfaOL1KPVrCT/bLd7yZ1z/EH/cWluIRs6v2gPa5BVp3ve4O2taCjsNZ
         VGzws7NHAJDKhw6jDiCPwHnxmzcHR+eDIODGs9X3mx7g69eRSJT0AIt2Z2FkoiAPFXd7
         gkgmJl4709lZnKp5yMPkd1B6p+Y53TLoMU4nmx+aPhlMjyGPTvohpF4Y/iQXiygtpaEI
         s55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0vwRgqyr9uL56xIsnlyB0vtc78SAThHMfFo6yoXABw=;
        b=ssowCHyACvmBp4YkSprTogm9RrHWtOxGiDT3g1URJzlbmM1ViYr5QmOWovDITh9KN/
         TZVJvNVpGMUiRNn92pm27rDZWhrx428udvz/tbdzemSM4CJbmjANVIpgN/uQqV7SI1Qq
         pYptJZVZK1JIFDZFfZEZK6pevaqtn3J8XolWg3ci67KKDm/Nf662sYdQY1ZYY3YWU4jA
         IqEMUuEL7dAPWcTBjSeiM31jHYrVxbqkaz27+eEzst0c7tfcbo83qjyA22c3IVFLmhLK
         Lx2E9OgQ5iqQYHJvmzgcO50gOUJWji8f4rXBJa5QDDXKsPxD11qR1FETboQ2jmdS7U6B
         vbfg==
X-Gm-Message-State: APjAAAVBYarD/9QQp6rCmUTsTP6oRMNJwj90CqDdR35OqL0JCQox3a2U
        3Hyoua8S6eP1ChA19sYD5EKdxeejXquvS/k8j0o=
X-Google-Smtp-Source: APXvYqwyLGX0JXK/pBKVeyXYqkFz0n1e5tfoNMxZ4ztu7D4qnyTTQas1W1VReCjSoPCTx3tUVuBMjeNFxPLGjB9kMSU=
X-Received: by 2002:ac8:3787:: with SMTP id d7mr12914060qtc.160.1573250647838;
 Fri, 08 Nov 2019 14:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20191105222652.70226-1-gwendal@chromium.org> <20191105222652.70226-2-gwendal@chromium.org>
In-Reply-To: <20191105222652.70226-2-gwendal@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 8 Nov 2019 23:03:56 +0100
Message-ID: <CAFqH_50q7y-sL0SyA3BDkZ9_YBX_FL90smtXt7v0Z+BW8nrw3A@mail.gmail.com>
Subject: Re: [PATCH v4 01/17] mfd: cros_ec: Add sensor_count and make
 check_features public
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dt., 5 de
nov. 2019 a les 23:28:
>
> Add a new function to return the number of MEMS sensors available in a
> ChromeOS Embedded Controller.
> It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> registers to find out.
>
> Also, make check_features public as it can be useful for other drivers
> to know what the Embedded Controller supports.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Version 3 was acked and I think we can maintain his ack, so:

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Also,

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Lee, how you would like to handle this? I think will be safe for
patches 1/2/3 go through the platform-chrome tree without an immutable
branch. Patch 3 thought still needs and Ack from you if is fine.

Thanks,
 Enric


> ---
> Changes in v4:
>   Check patch with --strict option
>     Use sizeof(*obj) instead of sizeof(struct ...obj)
>     Alignement
>     Remove useless ().
> Changes in v3:
>   Fix doxygen comments.
> Changes in v2:
>   Fix spelling in commit message.
>   Cleanup the case where DUMP command is not supported.
>   Move code from mfd to platform/chrome/
>
>  drivers/mfd/cros_ec_dev.c                   |  32 ------
>  drivers/platform/chrome/cros_ec_proto.c     | 117 ++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |   5 +
>  3 files changed, 122 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6e6dfd6c1871..a35104e35cb4 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -112,38 +112,6 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
>         { .name = "cros-ec-vbc", }
>  };
>
> -static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> -{
> -       struct cros_ec_command *msg;
> -       int ret;
> -
> -       if (ec->features[0] == -1U && ec->features[1] == -1U) {
> -               /* features bitmap not read yet */
> -               msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> -               if (!msg)
> -                       return -ENOMEM;
> -
> -               msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
> -               msg->insize = sizeof(ec->features);
> -
> -               ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> -               if (ret < 0) {
> -                       dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
> -                                ret, msg->result);
> -                       memset(ec->features, 0, sizeof(ec->features));
> -               } else {
> -                       memcpy(ec->features, msg->data, sizeof(ec->features));
> -               }
> -
> -               dev_dbg(ec->dev, "EC features %08x %08x\n",
> -                       ec->features[0], ec->features[1]);
> -
> -               kfree(msg);
> -       }
> -
> -       return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> -}
> -
>  static void cros_ec_class_release(struct device *dev)
>  {
>         kfree(to_cros_ec_dev(dev));
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 7db58771ec77..b502933e911b 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -717,3 +717,120 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>         return host_event;
>  }
>  EXPORT_SYMBOL(cros_ec_get_host_event);
> +
> +/**
> + * cros_ec_check_features - Test for the presence of EC features
> + *
> + * @ec: EC device, does not have to be connected directly to the AP,
> + *      can be daisy chained through another device.
> + * @feature: One of ec_feature_code bit.
> + *
> + * Call this function to test whether the ChromeOS EC supports a feature.
> + *
> + * Return: 1 if supported, 0 if not
> + */
> +int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> +{
> +       struct cros_ec_command *msg;
> +       int ret;
> +
> +       if (ec->features[0] == -1U && ec->features[1] == -1U) {
> +               /* features bitmap not read yet */
> +               msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> +               if (!msg)
> +                       return -ENOMEM;
> +
> +               msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
> +               msg->insize = sizeof(ec->features);
> +
> +               ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +               if (ret < 0) {
> +                       dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
> +                                ret, msg->result);
> +                       memset(ec->features, 0, sizeof(ec->features));
> +               } else {
> +                       memcpy(ec->features, msg->data, sizeof(ec->features));
> +               }
> +
> +               dev_dbg(ec->dev, "EC features %08x %08x\n",
> +                       ec->features[0], ec->features[1]);
> +
> +               kfree(msg);
> +       }
> +
> +       return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_check_features);
> +
> +/**
> + * cros_ec_get_sensor_count - Return the number of MEMS sensors supported.
> + *
> + * @ec: EC device, does not have to be connected directly to the AP,
> + *      can be daisy chained through another device.
> + * Return: < 0 in case of error.
> + */
> +int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> +{
> +       /*
> +        * Issue a command to get the number of sensor reported.
> +        * If not supported, check for legacy mode.
> +        */
> +       int ret, sensor_count;
> +       struct ec_params_motion_sense *params;
> +       struct ec_response_motion_sense *resp;
> +       struct cros_ec_command *msg;
> +       struct cros_ec_device *ec_dev = ec->ec_dev;
> +       u8 status;
> +
> +       msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
> +                     GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       msg->version = 1;
> +       msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> +       msg->outsize = sizeof(*params);
> +       msg->insize = sizeof(*resp);
> +
> +       params = (struct ec_params_motion_sense *)msg->data;
> +       params->cmd = MOTIONSENSE_CMD_DUMP;
> +
> +       ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
> +       if (ret < 0) {
> +               sensor_count = ret;
> +       } else if (msg->result != EC_RES_SUCCESS) {
> +               sensor_count = -EPROTO;
> +       } else {
> +               resp = (struct ec_response_motion_sense *)msg->data;
> +               sensor_count = resp->dump.sensor_count;
> +       }
> +       kfree(msg);
> +
> +       /*
> +        * Check legacy mode: Let's find out if sensors are accessible
> +        * via LPC interface.
> +        */
> +       if (sensor_count == -EPROTO &&
> +           ec->cmd_offset == 0 &&
> +           ec_dev->cmd_readmem) {
> +               ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
> +                               1, &status);
> +               if (ret >= 0 &&
> +                   (status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> +                       /*
> +                        * We have 2 sensors, one in the lid, one in the base.
> +                        */
> +                       sensor_count = 2;
> +               } else {
> +                       /*
> +                        * EC uses LPC interface and no sensors are presented.
> +                        */
> +                       sensor_count = 0;
> +               }
> +       } else if (sensor_count == -EPROTO) {
> +               /* EC responded, but does not understand DUMP command. */
> +               sensor_count = 0;
> +       }
> +       return sensor_count;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 0d4e4aaed37a..f3de0662135d 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -12,6 +12,7 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>
> +#include <linux/mfd/cros_ec.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>
>  #define CROS_EC_DEV_NAME       "cros_ec"
> @@ -213,4 +214,8 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
>
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>
> +int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> +
> +int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> +
>  #endif /* __LINUX_CROS_EC_PROTO_H */
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
