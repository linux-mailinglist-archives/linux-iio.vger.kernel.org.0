Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0320EF39
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgF3HW7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbgF3HW6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:22:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F36C061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:22:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f6so5047929pjq.5
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkAygGk9sLF27DBEZK3Fdc8H/U1qb6qadAzpwH8vXb8=;
        b=Covkci/TmKl6h1sMxoe2jk+na7heFStjRwCwhC8xdqm7y6/3852ir6WqY097IxZP/D
         yN9THinxKwxcjmIZmGRQqWvMxyux/hANjo8wOZP+oNOzVTDoSb+m8btAGOW/lIvZKAvv
         to2FFSf7c+fhSzPLLJMGM98oI5r0Xer2bh+bn6HzcB6NguR9wV6/1MlGCnSWPpuxenXi
         +aObPLys6fMerTYKw4+5iVNxfLbWg4MZm9sdLNMthXthBDXDiinM16dJ9RPTpMIEDnkS
         AHaOpHvCQpmCmbsMy3edE1uhVsZuP0cUQAP1hU2D6jY4dL4haacYcbkQcGCNvEzBorY+
         dmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkAygGk9sLF27DBEZK3Fdc8H/U1qb6qadAzpwH8vXb8=;
        b=KIp+aDmpMBOOBPWSMKp/BiMhjjkymFNrcdG4N6t7PkJstzWNOgYYW0hX8MwoRdOhJu
         wDp8dY/eNnolY21xpHtThAQw0zfgocM9r2DrSrz5mGKSqPgIIofJk0DZM29i1ic3BWa5
         /ySjHPDvquaT9ZScPLz3rjQFu8pwRp8o+/OUGuI8v6bc5zKCgp6Z9HS6XvKsO1HTQ+QM
         HLjuyR/GsrKUCSoE30I7vSLuhcdtD1jOB6b871BC3wOsBi1VJoaxzl/zD27Di81uFRkk
         cyp2xZtpXMOnec8gtWVPlVtT/cpUxFAs+4xbO8lHX697QzJ+NlfA1amYiNG+YFJvHM3h
         QsFw==
X-Gm-Message-State: AOAM530TSbwMa1UlAfsWyj2TaiwkoHlwgq2V/e8h6q4FmtA9JTkTiHQe
        LgN1r2R82ChtbzclDr17TVm+obyb05fsjckv+NA=
X-Google-Smtp-Source: ABdhPJw9bYhLz6lr6P1IuCMywpONVvK4sLw1YUAV+DpK5ba2OIKopsqbCqgoPYm1APgMdy02fCPdGyj6BGPLCTr2PRQ=
X-Received: by 2002:a17:90a:d712:: with SMTP id y18mr236601pju.228.1593501778449;
 Tue, 30 Jun 2020 00:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-20-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-20-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jun 2020 10:22:45 +0300
Message-ID: <CAHp75Vfba8cJkhZVpRyspc7CgrmYy0BjvuBjb4==BFMsa-tCyg@mail.gmail.com>
Subject: Re: [PATCH 19/23] iio:adc:ti-adc128s052: drop of_match_ptr protection
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> There is no real advantage in this and it prevents use of
> ACPI PRP0001. I'm also trying to clear this out of IIO in general
> to avoid copying in new drivers.
>
> Include mod_devicetable.h as we are using of_device_id in here so
> including that header is best practice.

Similar comment as per previous patch. ACPI has an official ID at
least for one component. So, we encourage vendors to provide proper
ID.
That said, the commit message is misleading a bit here (it might be
useful for the components which are not supported by existing ACPI ID.


> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index c1552b0fee04..cc3fb2d1686a 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
> @@ -220,7 +221,7 @@ MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
>  static struct spi_driver adc128_driver = {
>         .driver = {
>                 .name = "adc128s052",
> -               .of_match_table = of_match_ptr(adc128_of_match),
> +               .of_match_table = adc128_of_match,
>                 .acpi_match_table = ACPI_PTR(adc128_acpi_match),
>         },
>         .probe = adc128_probe,
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
