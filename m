Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1803A375184
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhEFJa7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhEFJa7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 05:30:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14AAC061574;
        Thu,  6 May 2021 02:30:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q15so64263pgg.12;
        Thu, 06 May 2021 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3qQi9rPMrrCMaNFdkW+WUvitmYJ9H2Mywx5LqV07Z4=;
        b=E1AvYrcwo9pOAgmV+vOdPoLhjaaHuTQLOAW2+33xKqKZX4zFMwJNQb0eMl7eg7XpCq
         No+gg1cfkmAGYXB/Y+mRs8pFQ8bHpUaC+Ts0fOQJZXVPX9dTocbUtmvZoMgBPUT3+HbU
         HRvBBToJI/1y6jjU8J5OnBGmngdj0TFPIs4/qLxtUR59CQUDA3KMYtaPjNou/ZfN7L+n
         yxM3Ei1NFZEYkPqISYTgFPHfv9stRE5h5dSHUWjm2MSyGI+JVC0YhQyW6ynd5WmfdbRD
         FEAPBOq4LmWXm0ysARpJBvxunlN1OAVUdq/oyP/TljqLkBLQrcq9ZLtVOut8DvrhVdMn
         uR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3qQi9rPMrrCMaNFdkW+WUvitmYJ9H2Mywx5LqV07Z4=;
        b=f3hhUPC9q2gfQxrPLXODZsLP6KKX/jPofhFcles3mGdAgm9MWYMW5GHIa47orUuQW7
         WWYTY/HBpmRgoo65LECFjhtI63CH8tGrxXp7My0S//zcdon4fnxPvES9nr8c77RamELZ
         qW3iNuZEZDIa/G9SXpzohv7j+KGdUtehhTtQ5v4tr6fKtfUpYNdY4XrDE0Ww00DgwWhh
         TcH1b70RkZCY8YzKrJRyDm3OiFCDYsIjWozsDPMokl2Ru0TmQkAFgdEjM58IUTV+RivM
         8M6+UckaBZP/DuAL9GahdS5i7CVPA+wxqDSy9RPabM+Jtow0xa3GF3TcnrBNG9rqsvpy
         qyTg==
X-Gm-Message-State: AOAM533HNM+gDVvMjskmn+696aKzDw5gwBDeaQK2ob+hYOEgGBDogZOa
        8QXio6EiyZB57Llb7DhsO7gLnCdWqRzKaqfwdEA=
X-Google-Smtp-Source: ABdhPJzlbMtx3Ea8eWyf0Dds4VHudl6KuN1qzQ4W3LfLI8PgAD6IGSqi/G23AeRhvWquIkj0W6UZGKzKtxWNtf/a9f4=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr3449329pfb.7.1620293400352; Thu, 06
 May 2021 02:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210506035659.765109-1-linux@roeck-us.net>
In-Reply-To: <20210506035659.765109-1-linux@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 12:29:44 +0300
Message-ID: <CAHp75VdkQmrfpwj6tmEpNYcL0soRcGrhoOghiqJpVezyxZ68LQ@mail.gmail.com>
Subject: Re: [PATCH] iio:accel:stk8312: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 6, 2021 at 6:57 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With CONFIG_ACPI=n, W=1 and -Werror, 0-day reports:
>
> drivers/iio/accel/stk8312.c:644:36: error:
>         'stk8312_acpi_id' defined but not used
>
> Apparently STK8312 is not a valid ACPI ID. Remove it and with it
> ACPI support from the stk8312 driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

For the record, point finger on me in case somebody complains about
any of such patches.

> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> There is another patch pending which makes whitespace changes in struct
> acpi_device_id stk8312_acpi_id. This will result in a conflict if this
> patch is applied. In that patch, it is claimed that the driver would
> possibly only be used based on its ACPI ID (even though that ACPI device
> ID is not official).
> Link: https://patchwork.kernel.org/project/linux-iio/patch/20210401144226.225928-1-jic23@kernel.org/
> I can not determine if that claim has any truth in it. Still, it appears
> that the device ID is not an official device ID.
>
>  drivers/iio/accel/stk8312.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 157d8faefb9e..2fc30cfe1457 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -7,7 +7,6 @@
>   * IIO driver for STK8312; 7-bit I2C address: 0x3D.
>   */
>
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -640,18 +639,10 @@ static const struct i2c_device_id stk8312_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
>
> -static const struct acpi_device_id stk8312_acpi_id[] = {
> -       {"STK8312", 0},
> -       {}
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);
> -
>  static struct i2c_driver stk8312_driver = {
>         .driver = {
>                 .name = STK8312_DRIVER_NAME,
>                 .pm = STK8312_PM_OPS,
> -               .acpi_match_table = ACPI_PTR(stk8312_acpi_id),
>         },
>         .probe =            stk8312_probe,
>         .remove =           stk8312_remove,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
