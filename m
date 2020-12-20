Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21FE2DF89A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 06:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgLUFRX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 00:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgLUFRX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2020 00:17:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3332BC061248
        for <linux-iio@vger.kernel.org>; Sun, 20 Dec 2020 21:16:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so5646717pgl.10
        for <linux-iio@vger.kernel.org>; Sun, 20 Dec 2020 21:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFwj2LZf4TLQNNH65N7opFkGsQwhxBKDS8aHDIPcOm8=;
        b=Nx1V9KdO5Yrw/1AStKJgg12eyjQZaE/VM2l4IUPDMCSpTpVMKRmXM0iFPUktL57Pe/
         I3mGg6dBvaiJTbJtwP7lrCK0+R19rnLx+61KDrFPv5E8wQEabMMoJwJoFBC/KPZXem/g
         E2ekJgj5EI4SJ4fdSSzm4kPBp+h7+IVYOwoFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFwj2LZf4TLQNNH65N7opFkGsQwhxBKDS8aHDIPcOm8=;
        b=WlhGGP2AceFzMCTv+oYc0YISIwugpjJEGRV8BKK5N8k6VZW7xJ2PR8eO4v8fCbQkGC
         i/RFAYbeVuUf+Xm67uHf9JPZThDwD9Do0Wf3U+4t3jhEuOgYf14OxeViwzVjMTKu/3YN
         LzjtARIVbDhTbKyZ1hgRrnaYAPDEbtTu1YBezxZijzQ1tkdVyMQxc3kx8YbgWgkBziRX
         7kXbZHGOr1diEf15DDOIiYugx6cavPC3r7SVkBuxn6FRycWMtKgbJEpe8vhJDCKv+Vnz
         Ld7W/o08wEUuyD9D0i4041c0lnepLq5RQrGuYMpQGM9ryWuiXYCEav4tWNU6J3susYfG
         LZmQ==
X-Gm-Message-State: AOAM532fQuPPiv+Xb7+eSUBhVCJcOxoU9FnRAZ41at2igbesCkR58A/I
        JTghqZiLCsf2jrzhHONOHLxRGvezCPdICAouT6SEjxcOtFw=
X-Google-Smtp-Source: ABdhPJw4EvQ8YAcdeno25kx2F7wcU4ii766MTfu6d3ULxpmbq85YOz8LMcEk6T+b8ZRQRDbyOIdk9NUQmpGglZn606I=
X-Received: by 2002:a05:6e02:102f:: with SMTP id o15mr13978956ilj.142.1608501928572;
 Sun, 20 Dec 2020 14:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20201220015057.107246-1-maxwell.leiter@gmail.com>
In-Reply-To: <20201220015057.107246-1-maxwell.leiter@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 20 Dec 2020 14:05:17 -0800
Message-ID: <CAJCx=gm2hbfRePezjEh14a=DENX2dj8gc+SW8T-1NDWQY4eSTg@mail.gmail.com>
Subject: Re: [PATCH] iio:light:apds9960 add detection for MSHW0184 ACPI device
 in apds9960 driver
To:     Max Leiter <maxwell.leiter@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        blaz@mxxn.io, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 19, 2020 at 5:51 PM Max Leiter <maxwell.leiter@gmail.com> wrote:
>
> The device is used in the Microsoft Surface Book 3 and Surface Pro 7
>
> Signed-off-by: Max Leiter <maxwell.leiter@gmail.com>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/light/apds9960.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 9afb3fcc74e6..20719141c03a 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -8,6 +8,7 @@
>   * TODO: gesture + proximity calib offsets
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -1113,6 +1114,12 @@ static const struct i2c_device_id apds9960_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, apds9960_id);
>
> +static const struct acpi_device_id apds9960_acpi_match[] = {
> +       { "MSHW0184" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, apds9960_acpi_match);
> +
>  static const struct of_device_id apds9960_of_match[] = {
>         { .compatible = "avago,apds9960" },
>         { }
> @@ -1124,6 +1131,7 @@ static struct i2c_driver apds9960_driver = {
>                 .name   = APDS9960_DRV_NAME,
>                 .of_match_table = apds9960_of_match,
>                 .pm     = &apds9960_pm_ops,
> +               .acpi_match_table = apds9960_acpi_match,
>         },
>         .probe          = apds9960_probe,
>         .remove         = apds9960_remove,
> --
> 2.29.2
>
