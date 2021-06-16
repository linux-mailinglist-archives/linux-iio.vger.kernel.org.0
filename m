Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4C3A9526
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 10:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFPIjz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFPIjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jun 2021 04:39:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F24C061574
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 01:37:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s22so2689957ljg.5
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJAc8B1lD7Sm5QPOtcUYZkUpiddw4Ax/wj4Rau0Ixfg=;
        b=qvu43AOLgb3xHnM0yXAUrjFaCzKTcpte7hy9TbY39f5F7QzZ+wiTPUmavQMpx+Rt5R
         45g7i68kXrjq53DeA4k7zOhUGKPahmopZKU6RqXDfO+rcsj5B1xwLjwMpAHCkhu3eEby
         53qMKhYFGsFMJ/qHD/OyZ2e3+4xcFXjqL4f9uSlbQxC56dx18Lahm3U8atB60kgX6sif
         EqYAUsWW8YdBB38HoPBiiP7BhjvjZ8mWG34htxZzmS+FZ68Eze0+llgFpBggaJfGNLxm
         S9B78k6IYF+bpKFfw7mjvqJqrA0SdS7fd3H/EByu9Fs8yoTpFn1xPbTmeZ/qRocYSzK2
         L6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJAc8B1lD7Sm5QPOtcUYZkUpiddw4Ax/wj4Rau0Ixfg=;
        b=kNnNgo0oe0RkqrfN7eqFI+jS/LMhqNgQxuv7tJGJXZcTK19p1ZgS4BIKnekiuzWoI2
         F73OgT7fscAEU76UEuWk/4N8Fg5gxrqY3FtVxUKOtD3VbjDI1QYNh06CiIMQIrfKUzQ5
         1apbeZ5n1rBJWeUIzazygDqZXYkCySOz3Y2jFYCcDSac2nSNlh2nszT9Jtb81mmpsQXW
         AT6f7QUGbjhIDxFSeA3SxhKbfo649ee0Znb5MGXmuJAMog6wjeDeJnlaUvjVLEtauywe
         B5fp/pwQZ8YkJGWS1PIDs3BEuAoouUxja9kVnrqCd86xmJbjcSEzvdS7U4R0H5LasNso
         kq6g==
X-Gm-Message-State: AOAM530fI7tOvuLEqfDv5PC5/DToynBxNooakh71dZ06RUDorsQFPeHT
        zi/7nd4q1140C5d+S9UEy/aTP/7sp6uEpuHy3i+awQ==
X-Google-Smtp-Source: ABdhPJyGIIdMSJ7t5SYz1eX75j4utxyINk0hmhiwDZUkZw41Hdi0Yqko84xoZfLmn+D4f2IStcf6VQ88KZ/LjsmVKlE=
X-Received: by 2002:a2e:9483:: with SMTP id c3mr3514844ljh.273.1623832667026;
 Wed, 16 Jun 2021 01:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210614163150.7774-1-stephan@gerhold.net> <20210614163150.7774-2-stephan@gerhold.net>
In-Reply-To: <20210614163150.7774-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Jun 2021 10:37:36 +0200
Message-ID: <CACRpkdYPz4JOWgzynVzAmJXH1MWAXjvH16k_kwi0KqGE9_NnSQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: accel: bma255: Fix interrupt type
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 14, 2021 at 6:34 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Bosch accelerometers similar to BMA255 are initially configured to
> emit an active-high interrupt signal. This is currently not re-configured
> in the bmc150-accel driver so the interrupt should most certainly be
> IRQ_TYPE_EDGE_RISING (or potentially IRQ_TYPE_LEVEL_HIGH).
> (Unless there is some kind of inverter installed on the board...)
>
> At the moment the bmc150-accel driver forcefully requests the IRQ
> using IRQF_TRIGGER_RISING, which means that the IRQ type is currently
> ignored in all existing device trees.
>
> Fixes: 6259551 ("iio: accel: bmc150-accel: Add DT bindings")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> However:
>   1. We need to fix up several broken device trees first (I found
>      IRQ_TYPE_LEVEL_LOW in some device trees).

Oh this situation... Some are mine I bet (I can fix those,
just poke me with something sharp.)

>   2. Similarly, I'm not sure if this might break some ACPI devices
>      in case they have the wrong IRQ type listed?

I never figured this out but Andy and maybe Bastien Nocera
knows more about this.

> As a first step this patch just fixes the documentation.

Fair enough, it makes things better.

Yours,
Linus Walleij
