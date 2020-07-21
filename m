Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D09228840
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGUSby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGUSby (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:31:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34227C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:31:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so11128433pfm.4
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXuwns9ioti6CoAUw2FdEnfQyrrSlyqdRQu2yuBEteQ=;
        b=nD0eAAvWh8u2M5Oznm3fxdusUiAEW4dblRObvrB97LQDpWzCnG/eohPpYweBRnXlCR
         M98ez7U4E9rn6/i/xPTsroh+h0sU/FN73Vw+nmh6pr7yoHObgkFjazFywH9+3GUyB3BP
         qWN3gb7PNr+D3AbyYgAu14xVTyn78VbXoidsltMI4gvdmqKijwO3eqaiiHZ7f+WKBHm6
         YgitupSvcabwpPrR1erTmFmCmyW6mtadg/HAg2t/pcKEmZ4vimo073bzjZafF8cn70zh
         0B4+i9o9vX9qZC0JsSUBjs7OJ5fHtpRyOQ7u3iHGml8IeaL25XaNTlgmx7nuajm4uUFe
         46tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXuwns9ioti6CoAUw2FdEnfQyrrSlyqdRQu2yuBEteQ=;
        b=H+5QLZsm8dJX/4gco0jCSRdeEBm9LQ7BC+WbcjsAmUBGbdNgeHf4ygWoCpJHoA4Uit
         BbO+vCjtg8yxmAAkRxwVdhsOW5acQaGfh8/Ys02jM3L4SFFfzU1CZWK6T0joVvG8Qc7I
         YOmYel7Da1cW76wDpmgBBomgYYH2HSP60MpFlkIWI3KkHEA4UapgIiitXXNhJlgPGQxd
         sRSKMalGl7USwcPxBwRzbFAqldDIL8RnpJf18z5VaChyqrntFFxQXduXghLaoNq3kBzY
         HWtv94yqWMAbBNs5xYHgQFOgdtFx05DDH5fzTlnYVODICGcJJQmz25sOG47vcnkV7Iir
         XvhQ==
X-Gm-Message-State: AOAM533RQawcnj7CO/mPJmM7zciTAUn1YP9sPiBk+ztRPAzzuxJ4Y0Dq
        +MTaIUo0SZnJU/bf14KWVt+7JYJubXGwg/Ope4M=
X-Google-Smtp-Source: ABdhPJyyI5lxkNFy7M54EVGgNyyWXthVCQJCqj0tKypmUlB9DKyF6rCu7x8BzNacKPDq89IAT3QS1vLf8ifubj2z1aI=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr22983997pgn.4.1595356313716;
 Tue, 21 Jul 2020 11:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200721171444.825099-1-jic23@kernel.org> <20200721171444.825099-4-jic23@kernel.org>
In-Reply-To: <20200721171444.825099-4-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:31:36 +0300
Message-ID: <CAHp75VcTQP=rX5Rg8LgUozi-xS4mSqisYawA1PHHL4BCZEhH5A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio:adc:ti-adc108s102: Drop CONFIG_OF and
 of_match_ptr protections
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I'm trying to clean this (now) anti-pattern out of IIO to avoid
> cut and paste into new drivers.
>
> Also add an include of mod_devicetable.h as the driver directly uses
> struct of_device_id which is defined in there.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> v1->v2
> * Drop reference to PRP0001 etc in this one as it has valid ACPI
>   IDs.
>
> drivers/iio/adc/ti-adc108s102.c | 5 ++---
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
