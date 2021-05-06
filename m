Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F97375181
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhEFJ3z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 05:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhEFJ3y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 05:29:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0758BC061574;
        Thu,  6 May 2021 02:28:56 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id i14so4315480pgk.5;
        Thu, 06 May 2021 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2OxY0itqW/K9RuckxThZQ0745sax8UHdbGDHkDYmfo=;
        b=MDNrXbQ1/0TuGKKpElrU49/V0Kva6Z2rutmeHLYJfAobmnNA0gQ8eBfRebRWmSHShB
         cilHjkymOxSfXdAshiscKIIWiHe+bF0kS+YC3GXvX+2VTU5kxIiMXi0u4UszGaIQ4Hrd
         wtDo0Z8IO+D5V0j2r1EIH0ZDL3WWr/Xg1z9i74npRxxXSfrg86H4sgBS368dO07NPTEU
         Li5Xae+Mz2LVXfiiIk1+DpRGqo1T9TSxeGCR/mZg+Q1wXLoyih6v5Di4qa0dkqLm7DwM
         ILrbH+hPxQmqewXnsso2bOu4TW7aA+qOx9qwl8Og/so5NiZKjz0aQOTjaBMT0HZTW3JZ
         uMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2OxY0itqW/K9RuckxThZQ0745sax8UHdbGDHkDYmfo=;
        b=BNA+5aMj4l8buNji9DGWkxWmY0RpaYkFODatuUaLKa5d0WNbOY2K7P34gxVLxNVtNF
         ZZ9uG5BBYBNSq/2SUa6y5VvXCpGV3AQih4Xqp8YJGEUoR4FjpW0j+AT/2tDKEDNZI73h
         N5Cx6EwlMOAk/KUaO4vl/CVbdhLibKhgFUCIOguYDAHoGQ6zhaSeFV/5mO/Q0XnUzKJl
         T8gDtPm3hzAaW2KWyfQiKeiI8NvQkHwUDF4vdDbRaFr3peDpnVAC04wVFJJza6v4Q/RK
         TT7Dxbh0ZJ1n2VwoYZ1LjlBv2Zk562Rz307x0CLEJffhHkp4sgeGg1j8bdITM2MrFKMl
         pHCg==
X-Gm-Message-State: AOAM530zRfPAcsMHSzfDaUUYjuUhnqjtcO5cZNzxyewXV5D3DO/ic/uK
        ecKTnVwzVM6jmzMSbDKJUjgfoqvX668ZqIt76A8=
X-Google-Smtp-Source: ABdhPJy+h7UjAI7SetjkxiP6oCkauAuEGCVpnM8KbqBguhRSM4CUXlO8f6c8gOplqSWLCYiX5+91wl4ktxA1pJccd2w=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr3404821pgs.4.1620293336317;
 Thu, 06 May 2021 02:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210506034332.752263-1-linux@roeck-us.net>
In-Reply-To: <20210506034332.752263-1-linux@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 12:28:40 +0300
Message-ID: <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
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

On Thu, May 6, 2021 at 6:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With CONFIG_ACPI=n and -Werror, 0-day reports:
>
> drivers/iio/chemical/bme680_i2c.c:46:36: error:
>         'bme680_acpi_match' defined but not used
>
> Apparently BME0680 is not a valid ACPI ID. Remove it and with it
> ACPI support from the bme680_i2c driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

with the SPI part amended in the same way.

Thanks!

> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Instead of making bme680_acpi_match conditional,
>     remove ACPI support entirely since the ACPI ID is
>     not valid.
>
>  drivers/iio/chemical/bme680_i2c.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> index 29c0dfa4702b..74cf89c82c0a 100644
> --- a/drivers/iio/chemical/bme680_i2c.c
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -11,7 +11,6 @@
>   * Note: SDO pin cannot be left floating otherwise I2C address
>   *      will be undefined.
>   */
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> @@ -42,12 +41,6 @@ static const struct i2c_device_id bme680_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
>
> -static const struct acpi_device_id bme680_acpi_match[] = {
> -       {"BME0680", 0},
> -       {},
> -};
> -MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> -
>  static const struct of_device_id bme680_of_i2c_match[] = {
>         { .compatible = "bosch,bme680", },
>         {},
> @@ -57,7 +50,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
>  static struct i2c_driver bme680_i2c_driver = {
>         .driver = {
>                 .name                   = "bme680_i2c",
> -               .acpi_match_table       = ACPI_PTR(bme680_acpi_match),
>                 .of_match_table         = bme680_of_i2c_match,
>         },
>         .probe = bme680_i2c_probe,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
