Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61C723F8B2
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHHUEJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgHHUEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 16:04:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166CDC061756;
        Sat,  8 Aug 2020 13:04:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x6so2719750pgx.12;
        Sat, 08 Aug 2020 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kaFskQX4jv261WJ0dMiojEODEOzOS9WcUbMFgOABX4=;
        b=D2YxFP2z5akXj2+rs+S69xUwGV4GrvXKczoL2VTsRmf6spTAr8Vjpx6RpSUjqb0L9F
         bnUJ6FAy9qmfEabI22yHnbtP1p1EhpKrLwli+LkqgzOYYXfvxs1yi+/5ieuz9XQOagbS
         +wLbXvJShUJF+ibZA3ECDAtOEZXWCMH81IZootn8NPTV504PSHnIijQOstnYdj6HrvZ4
         M/Eqqxhqwq7RXNX4A4ibeDeaEfXJCim8ygHaDl69o3T2mmhdpku3HAPsuKVWUs+jvOAL
         5mlJ3Fbr6aKaY3IvN8ckMiV1TolXNGOxZEUho+NQu3++1SGAx25Dw7QjJziCD6e/yg2K
         yPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kaFskQX4jv261WJ0dMiojEODEOzOS9WcUbMFgOABX4=;
        b=GGPi3oux+S1NBzSkdhQXnADD4c1a41aUDi1xg5OojbjBa5LLTZqGwOvhtU5c0R0Cf3
         q2KgFy9AYPzeXxsawed8X/HOsBrj7IuuZP+Uz065U//QIh7ImD5SinlvaByjPSl4e/lQ
         obb830o/KDI7r8RmtJZKFG3sX7Y0YU4znMf2G/cAfLbF/4lCsNjBexakKTlekbiOzglz
         h7Op6irozPYO7hwxvevixAdfTfbnegGcN4plluvKJfLN8xZHmrs0I4xHml6ROxjuFYNv
         LxcD6UfxnqfKtcabwqligBzIO+7vKORNT6Y1lxPXkiZpeIejiG+gesdUJYn4aZaq+NiT
         8BoA==
X-Gm-Message-State: AOAM530HcrevpbnjWc3pwIeEN9bZC6YWveoYt/kzzWtlL6ZsxRq4t2x+
        srxksmJsXm4CBx9WRNY1Xa5XYaDgsrb8Rlco4x4=
X-Google-Smtp-Source: ABdhPJymODXLHSHdwr7rIwjvj54xWcj6Ahm0bGeNzfOuXfA3RLi/iJBabx+b+T7bcEW5Ov6cIcppOvnvTHIgMvhD61Q=
X-Received: by 2002:a63:ec18:: with SMTP id j24mr11604170pgh.74.1596917048307;
 Sat, 08 Aug 2020 13:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com> <20200808121026.1300375-3-cmo@melexis.com>
In-Reply-To: <20200808121026.1300375-3-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 23:03:51 +0300
Message-ID: <CAHp75VfWk7pCy4Osv0uY0UH4yFS=PRGbE1CNCakuRFTE33SDJg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio:temperature:mlx90632: Adding extended
 calibration option
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 8, 2020 at 3:11 PM Crt Mori <cmo@melexis.com> wrote:
>
> For some time the market wants medical grade accuracy in medical range,
> while still retaining the declared accuracy outside of the medical range
> within the same sensor. That is why we created extended calibration
> which is automatically switched to when object temperature is too high.
>
> This patch also introduces the object_ambient_temperature variable which
> is needed for more accurate calculation of the object infra-red
> footprint as sensor's ambient temperature might be totally different
> than what the ambient temperature is at object and that is why we can
> have some more errors which can be eliminated. Currently this temperature
> is fixed at 25, but the interface to adjust it by user (with external
> sensor or just IR measurement of the other object which acts as ambient),
> will be introduced in another commit.

The kernel doc patch should go before this patch.

...

> +       *ambient_new_raw = (s16)read_tmp;

> +       *ambient_old_raw = (s16)read_tmp;

Sorry, did I miss your answer about these castings all over the patch?

...

> +       ret = regmap_read(regmap, MLX90632_RAM_1(17), &read_tmp);
> +       ret = regmap_read(regmap, MLX90632_RAM_2(17), &read_tmp);
> +       ret = regmap_read(regmap, MLX90632_RAM_1(18), &read_tmp);
> +       ret = regmap_read(regmap, MLX90632_RAM_2(18), &read_tmp);
> +       ret = regmap_read(regmap, MLX90632_RAM_1(19), &read_tmp);
> +       ret = regmap_read(regmap, MLX90632_RAM_2(19), &read_tmp);

What so special about these magic 17, 18, 19? Can you provide definitions?

...

> +       int tries = 4;

> +       while (tries-- > 0) {
> +               ret = mlx90632_perform_measurement(data);
> +               if (ret < 0)
> +                       goto read_unlock;
> +
> +               if (ret == 19)
> +                       break;
> +       }
> +       if (tries < 0) {
> +               ret = -ETIMEDOUT;
> +               goto read_unlock;
> +       }

Please avoid ping-pong type of changes in the same series (similar way
as for kernel doc), which means don't introduce something you are
going to change later on. Patch to move to do {} while () should go
before this one.

-- 
With Best Regards,
Andy Shevchenko
