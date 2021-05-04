Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B5B372D26
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhEDPmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhEDPmO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 11:42:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B0CC061574;
        Tue,  4 May 2021 08:41:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m12so7428759pgr.9;
        Tue, 04 May 2021 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcUxvaCbAOLh4AlyCzmhyfXKWCTwPYDbe5Zz5zCH/D8=;
        b=t9WVU9252cu7KcDpbozPrwzOpZDLAQwn0nzyAkfQwR30LRsOlIh105vndYvE2ADuhx
         TNB3rwB09OzqR4lRGw7kT87Z3bnJaC22Ditx85BF8OwDuuZ6f2W+1G9hxakdR9OgnYlS
         fFYEBOuB2Q8Iluo+dYMd/Wd/z3CK7uSp+08+XEvFX+T/iPfNzCR7QcLSa9Ufj4obI1NV
         zK1SsiGqj/ZOi93YPnSCVR0gw80pmQdKiXuLrPK9eimDVXgjbpiD8ovXiZt1H/1PfCEX
         1mpSCn/4HuLkFld2aHuag/8vN9cRBSPKSNPEjPQz7KjPStmcIjGR4bwmp8dn+VD7tc1S
         ZBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcUxvaCbAOLh4AlyCzmhyfXKWCTwPYDbe5Zz5zCH/D8=;
        b=HxSUVmXew6QpMOlP49/6BKkCQSH1rocGJxePuIGlNDeYpH7EGjPhj3GZ3QEjOE6ghX
         SkounXWQBI7s6/2RoZ0zkhgwVYchKM6Pu3z1af1svR9MDjLuVBQlTdgS7vUMR29GB53A
         B9PJkDdHLmuXga7dQUwwiGparEIZvt3TeR+GW71kE/9ZFaWcwbdpKm7JCTdlrkRSV5JR
         6o4Vj9XgYnMWPFDKYP/1HkhhmCI6JX/VHKFY88OWCZIm5dmNY+kPG2E2IPV71LKTFM3y
         A8Ix8RqDOtDj6vWOKHrZvp8NGRLRX2sBamdT07Iw3qzaOXR0fxpBbRBvN4hAbDL/YUFG
         1SHQ==
X-Gm-Message-State: AOAM533RPqlID16YixV7NHYmR97Szyz9zs0tTTMyL/VN5nMFc1AVpfOy
        OovKPN1kZjxLFKftbezvY6TM2cm3RzCRrVUM+0o=
X-Google-Smtp-Source: ABdhPJwgR/PkoUd+maCDKleOQtjvme79ufD/7Z0q8u8RQNDo/Sqpb+8N+sG2KMLd27vPzx1PWO5oyzKJa2lPG5XniFI=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr5979262pjv.129.1620142878358;
 Tue, 04 May 2021 08:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210504153746.2129428-1-linux@roeck-us.net>
In-Reply-To: <20210504153746.2129428-1-linux@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 18:41:02 +0300
Message-ID: <CAHp75VfJ=7B3UBMns1fm7apDmCC4eakeumw4dJYdRXd5wEGkpQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: am2315: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 4, 2021 at 6:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With CONFIG_ACPI=n and -Werror, 0-day reports:
>
> drivers/iio/humidity/am2315.c:259:36: error:
>         'am2315_acpi_id' defined but not used
>
> According to Andy Shevchenko, the ACPI ID used in this driver is fake
> and does not really exist. Remove it and with it ACPI support from
> the driver.

As I have found zarro evidences, I agree with removal. We must not
create fake ACPI IDs on our owns. If anybody will find a device that
is using this broken ID for real, then we may add it back.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Instead of making am2315_acpi_id depend on CONFIG_ACPI,
>     remove ACPI support entirely.
>
>  drivers/iio/humidity/am2315.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index 23bc9c784ef4..8d7ec2f5acf8 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -7,7 +7,6 @@
>   * 7-bit I2C address: 0x5C.
>   */
>
> -#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> @@ -256,17 +255,9 @@ static const struct i2c_device_id am2315_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
>
> -static const struct acpi_device_id am2315_acpi_id[] = {
> -       {"AOS2315", 0},
> -       {}
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
> -
>  static struct i2c_driver am2315_driver = {
>         .driver = {
>                 .name = "am2315",
> -               .acpi_match_table = ACPI_PTR(am2315_acpi_id),
>         },
>         .probe =            am2315_probe,
>         .id_table =         am2315_i2c_id,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
