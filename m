Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2122883D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGUSaZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGUSaZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:30:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C7C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:30:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so11121352pfu.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Snkx6cmyZAV4gjTVC54MUU1lQkQpKMap8pcrGocF2xQ=;
        b=aUtIP7E5I1bvwescRkzSVPy1kf+SAj4AaU38NBps3slMjCgt2FiS61DpkGEk5tJJvJ
         I5jCPpmy56A4pnkkuWmAb6r2q95b2Wh6LfIng1AB19T8r3+2SJq1hQ++XqrigVSzrf53
         2aCsW+J9E4vPXjVFvwJb0GxFQI60cM0Hs8DWeBkobL7QBvddivIo/kpS0sg0+XLijs4K
         S4zQWaRnpDoRGoH1WG+M27BU556+vJjepGL3p0t9++K4EWec+uobUNMTIXD6eTcbNvCQ
         flvJcTLsrK+ur5UymWRKf2/hN+hxDYMe8+GMarktlcC9HLzZWsNRMrTy96UjIKiypH2o
         KbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Snkx6cmyZAV4gjTVC54MUU1lQkQpKMap8pcrGocF2xQ=;
        b=tZGnoZiRL+2c1J3BC6x+hzzsFi/IjYrYMvO4XRq+OC6fdYIHYOIUuUnISS+mMSeZen
         3AfENSi2TIw6ZXhY17dapmLqM7YLci3ooo+5AGbYfR67MI/UcFKHSaLcMxPj2S7yRhdP
         wNhkA9Tm0klCwtVCwQHpRbWuPEnyHyMJbRHrhMEQpucW4uO93eNGO7mCBTsiw2kkT0c4
         Ulc4p4yja4PrCgL1jMV9UWNgvSw8EN7eJaXpD3VPLQmqKOUr9VLlcVlUnUds9LrsJ+XT
         RkpHUHJSNSXGq9tMSGOilslOZwXTHv8TsWocOC6uIncfYxbHVq7Z4+GO4shlXiKb874x
         z7HA==
X-Gm-Message-State: AOAM532VCvtaRY66Gx8yG+ymMzvIp+xZ8HFFmEi46uSeYNXrYa1pKX32
        nB+WG/wOpkboYZncxAuu/U+udVC1jHXQUAYGHHo=
X-Google-Smtp-Source: ABdhPJx0yfobOdc5JshAD3q6GP8z6JVqLiHTNs+4PNohxSLxrGvyJAz1v3n5ZXlm5BKsP9tWRyNrFBzmPMOHviETatg=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr22979347pgn.4.1595356224743;
 Tue, 21 Jul 2020 11:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200721171444.825099-1-jic23@kernel.org> <20200721171444.825099-3-jic23@kernel.org>
In-Reply-To: <20200721171444.825099-3-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:30:08 +0300
Message-ID: <CAHp75VfPm0m=QwcYUx=iPLSmd2iK-dd5MswipAzqKDmYZBWO=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio:adc:ti-adc081c: Drop ACPI ids that seem very
 unlikely to be official.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> We have no known users of these in the wild.
> it seems very unlikely these are real IDS having the form ADCXXXX

IDS -> IDs

> as that ID is owned by Achnor Datacomm not TI.

After addressing above typo fix,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v1->v2
> New patch
>  drivers/iio/adc/ti-adc081c.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 9426f70a8005..8bc04cfae465 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -19,7 +19,6 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/acpi.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -153,17 +152,7 @@ static int adc081c_probe(struct i2c_client *client,
>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>                 return -EOPNOTSUPP;
>
> -       if (ACPI_COMPANION(&client->dev)) {
> -               const struct acpi_device_id *ad_id;
> -
> -               ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
> -                                         &client->dev);
> -               if (!ad_id)
> -                       return -ENODEV;
> -               model = &adcxx1c_models[ad_id->driver_data];
> -       } else {
> -               model = &adcxx1c_models[id->driver_data];
> -       }
> +       model = &adcxx1c_models[id->driver_data];
>
>         iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
>         if (!iio)
> @@ -238,21 +227,10 @@ static const struct of_device_id adc081c_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, adc081c_of_match);
>
> -#ifdef CONFIG_ACPI
> -static const struct acpi_device_id adc081c_acpi_match[] = {
> -       { "ADC081C", ADC081C },
> -       { "ADC101C", ADC101C },
> -       { "ADC121C", ADC121C },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
> -#endif
> -
>  static struct i2c_driver adc081c_driver = {
>         .driver = {
>                 .name = "adc081c",
>                 .of_match_table = adc081c_of_match,
> -               .acpi_match_table = ACPI_PTR(adc081c_acpi_match),
>         },
>         .probe = adc081c_probe,
>         .remove = adc081c_remove,
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
