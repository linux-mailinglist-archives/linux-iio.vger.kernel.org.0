Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3087681B1E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 21:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjA3ULU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 15:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjA3ULU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 15:11:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0EE2FCDB
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 12:11:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m13so959957plx.13
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 12:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bFfygit2/djU4Sgktq8LJVrl/BRm+5FSbJN/rakY4c4=;
        b=p7oNRiP283vG+6yba9wHN3lVVUIwk82wOl6ocsis4b/UrlLjzNGJyTxW0iYcQCTtdY
         xxGKLQCPjojanu8X5QS2QGJwJemLzUf6iRve+2hNObE0B+Vkhro7TUMM1wRixyulZEzO
         VjLT6upJOkvDLtp5SOpFS27ySYMxSN398/u0hersa+zvg/W1/lEpNB5l7RFqpPcfVrxk
         8B6EGVgS9puJVaAyuvqu8ZwrBUhVGq2vCu7qt/4mKnN7mYrClrl7/HgsC6uD71l4h2Pf
         aVMM7TUvOR4nj1AxmnunlAgOpgjnGa5M6AWzksF31VVbKt7efSO+hbvsmNalQOvduW9+
         mOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFfygit2/djU4Sgktq8LJVrl/BRm+5FSbJN/rakY4c4=;
        b=qM5Tt8JiU/PQTku8xB0YiujxEcxDo7yDeuIBxCIHEFcoy3RUvcfZqNVhnRPBksAvbA
         XuZKRx1pnHWZDhxar8Pg5klQmlW8VWwNerTwJPfTu9w4PP4hS+kY9fmm8KvU1VmaZW2F
         UMFtA3pAKxupPyOS9tZ92xTb1320gs9umaulC6UlxHEbVHhWM5MCc3GwPORyLuXGaefU
         YTAJqct1Hk6m+SKIxitv4oT30CPvZ1/EO9URH8tpWH3RSPOKBSa7MpYohvXYMpCJ7RSF
         7yfXnXzh4gWyLI+cE9X3vwoo+EHXiVV35u20o5CgX9oHkydKYpo/y+ebjNvf7ENwL7/T
         qyPw==
X-Gm-Message-State: AFqh2krlboU/yd68O8wZJAbOEJLQ6ZHjL+rCRuyf+qZSy7cVOlj/AXKo
        ZVYNAUy5L7mPA94k+1j8axVpZgM0co4T+kjEfds=
X-Google-Smtp-Source: AMrXdXtFJ3B7z1HMUrAzCweCW18efqTcCn/WcdYA4yNqg4nywPwaoZstvFw5ijprfiP1duNzWaIyaygx+1NueaR5FzE=
X-Received: by 2002:a17:90a:138a:b0:22b:ba09:cb1a with SMTP id
 i10-20020a17090a138a00b0022bba09cb1amr5025670pja.188.1675109478653; Mon, 30
 Jan 2023 12:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20230130201018.981024-1-jic23@kernel.org> <20230130201018.981024-3-jic23@kernel.org>
In-Reply-To: <20230130201018.981024-3-jic23@kernel.org>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Mon, 30 Jan 2023 20:11:07 +0000
Message-ID: <CAMxBKG2+XOvXs-89hakTcxH_FPnTjSBkbbuuCjGwVSObLPBFkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Here's the device info:

** Model information
sys_vendor: LENOVO
product_name: 82AT
product_version: IdeaPad Duet 3 10IGL5
chassis_vendor: LENOVO
chassis_version: IdeaPad Duet 3 10IGL5
bios_vendor: LENOVO
bios_version: EQCN35WW
board_vendor: LENOVO
board_name: LNVNB161216
board_version: SDK0R32802 WIN

I'll try to adapt the full patches to my Debian 6.1 source for
testing, and report back to you.

Darrell

On Mon, 30 Jan 2023 at 19:56, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> DSDT ROTM method seen in the wild with SMO8B30 _HID.
> Making assumption it is similar to that used for bmc150 plus
> information from Darrell that the rotation is out by 90 degrees at boot.
>
> Method (ROTM, 0, NotSerialized)
> {
>     Name (RBUF, Package (0x03)
>     {
>         "0 -1 0",
>         "1 0 0",
>         "0 0 1"
>     })
>     Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.ROTM.RBUF */
> }
>
> Reported-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> Untested.  Fingers crossed.
>
> We could factor this out if it keeps turning up.  The bmc150 varient
> is more complex as multiple method IDs exist depending on the configuration.
>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 65 +++++++++++++++++++-
>  1 file changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 3f6060c64f32..3c2d67f8d9b7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -56,6 +56,7 @@
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> @@ -2602,6 +2603,61 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
>         return 0;
>  }
>
> +static bool lsm6dsx_get_acpi_mount_matrix(struct device *dev,
> +                                         struct iio_mount_matrix *orientation)
> +{
> +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +       union acpi_object *obj, *elements;
> +       acpi_status status;
> +       int i, j, val[3];
> +       char *str;
> +
> +       if (!has_acpi_companion(dev))
> +               return -EINVAL;
> +
> +       if (!acpi_has_method(adev->handle, "ROTM"))
> +               return -EINVAL;
> +
> +       status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
> +               return -EINVAL;
> +       }
> +
> +       obj = buffer.pointer;
> +       if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
> +               goto unknown_format;
> +
> +       elements = obj->package.elements;
> +       for (i = 0; i < 3; i++) {
> +               if (elements[i].type != ACPI_TYPE_STRING)
> +                       goto unknown_format;
> +
> +               str = elements[i].string.pointer;
> +               if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
> +                       goto unknown_format;
> +
> +               for (j = 0; j < 3; j++) {
> +                       switch (val[j]) {
> +                       case -1: str = "-1"; break;
> +                       case 0:  str = "0";  break;
> +                       case 1:  str = "1";  break;
> +                       default: goto unknown_format;
> +                       }
> +                       orientation->rotation[i * 3 + j] = str;
> +               }
> +       }
> +
> +       kfree(buffer.pointer);
> +       return 0;
> +
> +unknown_format:
> +       dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
> +       kfree(buffer.pointer);
> +       return -EINVAL;
> +}
> +
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>                      struct regmap *regmap)
>  {
> @@ -2676,9 +2732,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>                         return err;
>         }
>
> -       err = iio_read_mount_matrix(hw->dev, &hw->orientation);
> -       if (err)
> -               return err;
> +       err = lsm6dsx_get_acpi_mount_matrix(hw->dev, &hw->orientation);
> +       if (err) {
> +               err = iio_read_mount_matrix(hw->dev, &hw->orientation);
> +               if (err)
> +                       return err;
> +       }
>
>         for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>                 if (!hw->iio_devs[i])
> --
> 2.39.1
>
