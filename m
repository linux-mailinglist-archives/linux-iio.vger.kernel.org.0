Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A120EF31
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgF3HVK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgF3HVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:21:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D02C061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:21:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so8123992pls.5
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKBc8F7pzib0qgQVrEMyNPOB1XFlz//vY176GkRJ7Pg=;
        b=cJ+DVdv4ktgh3FS/6khJi0h5ygKG4945kanx5O9FIzilqKCooIAQ0zJ6kJhYkvXv6S
         sGg8TWX6QFMjtck37w4ykoXtkTxOpWydVS2j8h+47EZ3RkFdSKBYPidlkFI4TCM4XK+u
         l8v+mKR6TQZTjEo3cf+nyUic0OmgzzOmzv3PFUnyIdNEPjsrHl5c+DTHZeuuxlfsY+Ci
         GbMRhj06yiTLDlKCywqedDDff+Oq+RpfUy7Swx9JiAUeGnSVh4iVFyIc847lFxG8/45+
         /BrcQhMkrmnbvS08FTVqc0D4MnEDtM7pZGc1GVosEoKXwII+/bvQ8BxILufmuYESEa2r
         OXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKBc8F7pzib0qgQVrEMyNPOB1XFlz//vY176GkRJ7Pg=;
        b=tEQkSHKtqFXKN/bWcowNm0vp7hFkDE7wHxcZYCfXmYHJhj+3Os8MdAoU2ytJT5xjag
         BaxER3Ek/IIitQV4fe4D005gWT00Wh6LAuZoMIn3AiiZvYlpkr09aLYMbgTKOFjy6a2V
         3e9LOCIpuULP9wBDkEEKm/LvfBxMOK2fOlSjSEm/yeQmBpS4oyLySt7VbYRA0O1nlo4z
         NIwjs+Pil+F+mdffk5BgT2lO7hPBd/sxH24WefH8anYc1KFb/Ct7RF5nKAx3iVAy8Y2j
         OvUiWjQiOMOFYVAtGOcy205JOoE4zUVImeIKUcca6zDBMCuBzSSTjbl6FyWkSB7rFXoS
         qJGg==
X-Gm-Message-State: AOAM5334dx1L56oxYswLkWegleXUejiXF7ju1/FHgjpODLhyR7L1O8eL
        TbqBv0jCwDNJ3Iial1jmCKUAy1IF1ISjcj372VI=
X-Google-Smtp-Source: ABdhPJwS2ppW1HPpXd/I6L+BwG4iw3UuSoNn7xTXlBaa9vAjxlxQnMe0bAeon43oMwzar96C800A4lc9ThqmJEMqNqE=
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr16695412pll.255.1593501669403;
 Tue, 30 Jun 2020 00:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-19-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-19-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jun 2020 10:20:55 +0300
Message-ID: <CAHp75VeUqMHpF29RYwpRFACcs73pmtvpBt+nQL7V+J-_BJD0Tg@mail.gmail.com>
Subject: Re: [PATCH 18/23] iio:adc:ti-adc108s102: Drop CONFIG_OF and
 of_match_ptr protections
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Although this driver has an explicit ACPI binding it is good to also
> allow for PRP0001 use of the of_match_id table.
>
> I'm also trying to clean this (now) anti-pattern out of IIO to avoid
> cut and paste into new drivers.
>
> Also add an include of mod_devicetable.h as the driver directly uses
> struct of_device_id which is defined in there.
>

I think this is not needed. At least the commit message in this case
is misleading.
We have only one ID and ACPI already has it. So, there is no need for
this patch from that perspective.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/iio/adc/ti-adc108s102.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> index 9b9b27415c93..183b2245e89b 100644
> --- a/drivers/iio/adc/ti-adc108s102.c
> +++ b/drivers/iio/adc/ti-adc108s102.c
> @@ -20,6 +20,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> @@ -299,13 +300,11 @@ static int adc108s102_remove(struct spi_device *spi)
>         return 0;
>  }
>
> -#ifdef CONFIG_OF
>  static const struct of_device_id adc108s102_of_match[] = {
>         { .compatible = "ti,adc108s102" },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, adc108s102_of_match);
> -#endif
>
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id adc108s102_acpi_ids[] = {
> @@ -324,7 +323,7 @@ MODULE_DEVICE_TABLE(spi, adc108s102_id);
>  static struct spi_driver adc108s102_driver = {
>         .driver = {
>                 .name   = "adc108s102",
> -               .of_match_table = of_match_ptr(adc108s102_of_match),
> +               .of_match_table = adc108s102_of_match,
>                 .acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
>         },
>         .probe          = adc108s102_probe,
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
