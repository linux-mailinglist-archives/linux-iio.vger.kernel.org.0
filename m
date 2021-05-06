Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA50F37558F
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhEFOZK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhEFOZK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 10:25:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438EFC061574;
        Thu,  6 May 2021 07:24:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so2923037pjk.0;
        Thu, 06 May 2021 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4glvnlaFWn01xnV1JtCJ2JwFkwp5srepoGHpfN8ZxeM=;
        b=slTGTTGfU1Fc5HFY3pMpvELCBOEsT/K5DVnm6MXQkW+DiDwGw5B4fLBxqYJ/k0EC+/
         a9DWTMLlsJFVuFtUeKPV1eRpTKMDeeSI33k2/4g6Zdaq3kouRlkxvzGIT5BAvXC4ne4y
         dr3BzefObjl+8XIdTZ4e3aPRaqwL4C3p98A0yimj7E4QukD9AfSOGNWvwRVSJg0jx/0S
         ZUOgE6VN6DvW4d4uKcl+voPMFrw1qjRqncjnm90ZqA99X+WUsURSEWscfrdPBt9XNOCI
         G3rF1lw33yqdyVaL37+R16OvYNZ5XO+byI077ALQNjA6dNTAM8T3ap14bG5WPBRQVeCW
         3HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4glvnlaFWn01xnV1JtCJ2JwFkwp5srepoGHpfN8ZxeM=;
        b=b5aM2jiBZB4lDag7b3LNwmNrfGjlLjk1bM93FToPFtGTEIdiCDvPIesNkYhgmlOXR3
         +Dxk5/JyhCmKVE1MR99iZoeDjvTZMNkL5sYqlS7RKwVphemlNfZyoQO+cTtRiJwsX7BM
         CR4JzkKTnt7zNoewzAJdtu7WfhHmhQ+SqpYh8G50L389oTvav4dBPQfryr8GmWcOd75B
         EbYJ6OPYFXBkcshmkS74MX6BoNWn1lrMakq2UKfeAKbTFSqt7uzVd9ycTKqDcaDfrx4a
         jZPrOkTQAdy+RtumzNeTrGqYq7HNG3Q8yMdkYakH73YQ3fKy/bvb5WyFXCaD5RBS6Hfz
         3aAw==
X-Gm-Message-State: AOAM532kU2HbX18i81s4xYuUL2EtqJBYMw40KBv967xNMNCqmKl0p0Nr
        pgN4yIHo3z6O8s7hvbEBlv3jLkuszGmt/7Hz8NI=
X-Google-Smtp-Source: ABdhPJw+reSNZtl9CN6kUTlQBS8RYpAYnENBOPmcpuoJox5lgSMGm082tl4ZLXJO0svA79fbUqlo+ywmgeP27M+cqjU=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr18762947pjr.181.1620311051365;
 Thu, 06 May 2021 07:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210506133145.2266604-1-linux@roeck-us.net>
In-Reply-To: <20210506133145.2266604-1-linux@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 17:23:55 +0300
Message-ID: <CAHp75VeJTZcq-gTrd5s7Ovbyg7TQUoGC35T6p7ZO1XeEePSuMA@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_spi: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 6, 2021 at 4:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> BME0680 is not an official ACPI ID, so let's remove it before someone
> starts using it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/iio/chemical/bme680_spi.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> index 6f56ad48cc40..cc579a7ac5ce 100644
> --- a/drivers/iio/chemical/bme680_spi.c
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
>   */
> -#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> @@ -145,12 +144,6 @@ static const struct spi_device_id bme680_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, bme680_spi_id);
>
> -static const struct acpi_device_id bme680_acpi_match[] = {
> -       {"BME0680", 0},
> -       {},
> -};
> -MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> -
>  static const struct of_device_id bme680_of_spi_match[] = {
>         { .compatible = "bosch,bme680", },
>         {},
> @@ -160,7 +153,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
>  static struct spi_driver bme680_spi_driver = {
>         .driver = {
>                 .name                   = "bme680_spi",
> -               .acpi_match_table       = ACPI_PTR(bme680_acpi_match),
>                 .of_match_table         = bme680_of_spi_match,
>         },
>         .probe = bme680_spi_probe,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
