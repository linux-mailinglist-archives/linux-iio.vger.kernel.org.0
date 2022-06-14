Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB954B558
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352025AbiFNQGv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356754AbiFNQGq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 12:06:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754E427C4;
        Tue, 14 Jun 2022 09:06:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 25so12290810edw.8;
        Tue, 14 Jun 2022 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hw+i+kkx4YIxq0kn0rdkeRwVFdr7fzk+p8UNtwWrSlI=;
        b=QHODOl+ss9AAFbX1TVDtCtnZerdUPGPp/ulIHRySFiMi8M/0bURko553esXFs42Rps
         qI1ZEPjfEy5F5gQa84e5QF2rsHcavHvA7SiVI2XaQMOjiEowLFU7KoNZU4nhA3GocAS+
         E6GVYvPD3BvjTo9q1dDYS+lDCdj6fJLUkezxZhH8vaquozcd8X5Kk7dbzljxRprLakAL
         uhwpiLylQua4wiQzal5Kzoi327xKR5kTPdAptvTgCgjziDi71cplvFNvbqtq779t8r5J
         jCe40rxtcXOnn3fjn7sAFe92L3QfajVP3utkY9nYUkuxkaJ2gUGIBPx4OyTiS+NwogrN
         dqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hw+i+kkx4YIxq0kn0rdkeRwVFdr7fzk+p8UNtwWrSlI=;
        b=Oiz9ckTqgKxWNnTpxebk8OvqaX35G+7qPVhlVJ8d6mgYNNTfHTfHPGDGsUkdZ2MCNT
         TfMpBhA35++Tm4KQP2wNDse0DOIxFRrtGyYYHCv0/8XMTPWZ3Y/qw+Upeunte0UgP/Lx
         UXHewy3g9b5PryKe41wr1oR6/fX8Xo3eT4YZ77d3X80DP2+l912Mx1nXOeFjF92/SUBA
         AhY7NOroiSgXEPwm1XIcWF/CES1jLfYkDIrq4NSB/fE9/qh70TJJ6hgA7nNylGCUmOjT
         aEF3WVXL1B79cemQLYpAW+1uzLmDmuIk854BzL+zoJRuLyZ7MzRzGnyzfj58rnA1fZRV
         lWSg==
X-Gm-Message-State: AJIora9HqyZgkNVS2Yf1UnbGOjc7CPgJO30ClbBHfvUhqN7WhOkrPFtt
        qLJWRAqbmEQYuAt0Wlz5VYkRQoXkkpdP3Nuvqf9fZGDdgFAxfe1M
X-Google-Smtp-Source: ABdhPJzTgt145r18ST/hOWsiuIbdVEFBVIzw+2edJvkTxo7t553iQB2t6/Zpb/14bIuilDjAMB/SFwiDMrAK0i0N+zo=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr6871504edq.54.1655222789972; Tue, 14
 Jun 2022 09:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220614151722.2194936-1-sravanhome@gmail.com> <20220614151722.2194936-3-sravanhome@gmail.com>
In-Reply-To: <20220614151722.2194936-3-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 18:05:52 +0200
Message-ID: <CAHp75VcaU-KkCGZ0tczM6JKaVdGC6icGt0pbpC5sTf+0+ePamQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] mfd: mp2629: Add support for mps mp2733 battery charger
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 14, 2022 at 5:17 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> mp2733 is updated version of mp2629 battery charge management
> device for single-cell Li-ion or Li-polymer battery. Additionally
> supports usb fast-charge and higher range of input voltage.

...

> +#include <linux/of_device.h>

What the original code misses is the mod_devicetable.h, and also see below.

...

> +static const struct of_device_id mp2629_of_match[] = {
> +       { .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },
> +       { .compatible = "mps,mp2733", .data = (void *)CHIP_ID_MP2733 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, mp2629_of_match);

No need to move, see below.

...

> +static int mp2629_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)

Why out of a sudden you moved from ->probe_new() to ->probe()?

> +       enum mp2xx_chip_id chip_id;
> +       const struct of_device_id *of_id;
>         int ret;
>
> +       if (client->dev.of_node) {
> +               of_id = of_match_device(mp2629_of_match, &client->dev);
> +               if (!of_id) {
> +                       dev_err(&client->dev, "Failed to match device\n");
> +                       return -ENODEV;
> +               }
> +               chip_id = (enum mp2xx_chip_id)of_id->data;
> +       }

This all is a single LoC only + property.h:

#include <linux/property.h>

     enum mp2xx_chip_id chip_id;

     chip_id = (uintptr_t)device_get_match_data(&client->dev);

-- 
With Best Regards,
Andy Shevchenko
