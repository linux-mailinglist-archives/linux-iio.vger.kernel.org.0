Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13DF228851
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgGUScX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbgGUScU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:32:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41198C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:32:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc15so1744981pjb.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VW28mxbLLqZQ5vQi7qNE17zGy07wpw2UPhzFLH5zplc=;
        b=IGBKQTQDfZ2dLTkMloFuGRGTRKdOJNdjfM5nL2bkRCp4etjHAj2k9cTtVZpE+P0EpR
         7Fc1HNRA/yGf1ZuYXNh+bDQt28PeaQBB9eECJnHaEvcrLncLTP5v0hp9miXCG22fJ1Jq
         LPUgnH2hPWZj1f+Nci2DxDIr66MO4lAAAfYgRhYXbIFnQF4m/qAtKU2sU+L+4cE0F59h
         q7je4PQ1vga3EEqJPuNwRjUXgRiNzvwbPq6Y+Fl/+IUdpmqmsoZM3tDPI2szMBpD8N1y
         Mvn5dFYxYRLZEsnFqI1weDW3kGO6z2KDR0+qfbmqms3dGc5ViV6PzufphVLrNdE67coA
         RiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VW28mxbLLqZQ5vQi7qNE17zGy07wpw2UPhzFLH5zplc=;
        b=KW2wegMLDVKWvYsQwrBAnAh/UfqOrIxVjrxA0gv0aCohBX47nq940CFXOGHadpuD1Z
         wLRujUw8mCCMglM+rNMPlCDMS+KnILdbaRNhMjGbsmzu741+cD5sw1zjHDFzu2fm8bh2
         OOaJQImlOyGyQwZWkop1wsNDMAuuIT3frhvAlo7Dd7a0IQ8/ZhfnFH2DFHcUZ0JAFAes
         HPSH7s4iXuqTh3jbnFM/O7cKEZ5SgUKoFPq35E35K1qwDA2r4IWKUf8D0E3X4k4u9bim
         bC5V1Lo15j7+IFu85Mw/zt4cirVEcX7Kwklb8oPr3vDm78ZZUmweleX0SPMQvrHLFBT/
         xNpw==
X-Gm-Message-State: AOAM5308H041UfNBmQv69EJkXyp4Kv1JY1TeGzMaBhF1t1YEYzdHR5NS
        K569IVWOmtzjAjBDnn3EEozUNe7ECJSLB3CWPUg=
X-Google-Smtp-Source: ABdhPJyXe+72uz5n1kumlRyfOwhoffH8XdX1MS1viWimoFIHUD/SHigjtMBE+4O32tCkm8RVFQRZJzU8BrchWVbfSRc=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr6060163pjb.181.1595356339800;
 Tue, 21 Jul 2020 11:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200721171444.825099-1-jic23@kernel.org> <20200721171444.825099-5-jic23@kernel.org>
In-Reply-To: <20200721171444.825099-5-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:32:03 +0300
Message-ID: <CAHp75Vfh5PjaMLkAL_N6UCVFttSe+qF_pZ75bqo8jinSDXmqug@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio:adc:ti-adc128s052: drop of_match_ptr protection
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> There is no real advantage in having these protections and
> for parts that do not have an explicit ACPI ID, it prevents the
> use of PRP0001. I'm trying to clear this out of IIO in general
> to avoid copying in new drivers.
>
> Include mod_devicetable.h as we are using of_device_id in here so
> including that header is best practice.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>  v1->v2
>  * Mention that some parts of valid IDs, so we are interesting in
>    enabling PRP0001 option for those that don't.
>
>  drivers/iio/adc/ti-adc128s052.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index e86f55ce093f..3143f35a6509 100644
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
