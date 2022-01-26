Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAD49CD27
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jan 2022 15:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbiAZO7j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jan 2022 09:59:39 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:35645 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiAZO7i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jan 2022 09:59:38 -0500
Received: by mail-ua1-f54.google.com with SMTP id m90so43446568uam.2;
        Wed, 26 Jan 2022 06:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RR2pY1rV0ULsrCqGU+BKO9MJav/kGNPSRvgU4pqlTg=;
        b=gIvfHvzhaGXQGh9qThqblmU+cANa7NwAATnRpJAZQD78AOa78yqW2hBzgNkFiEq0wv
         Dhpa8SKh5DblFyX5/ltgF6nGmiAlAkYoOI+MdkQHQecF304u+qfJG/4awNVuEIU8vVdj
         b8tVwjB/mi3mAEKldqc975HQGt1ytXc1Es/YUFQ+o9QLFY+l4YLnNyntpsHKFTqX8JvB
         TZNoeHVUmUQM0Dj90b4yc3fEvTQKfjz87sqfyuv2rOJWYBduhgvGxA5O2RWAEc/7j29q
         O14eoC6QBYba6qL/0wU72VAUh84ZxwnDShaSZuLn9DNNqJt60/KBxFxjvMS7ZdOt0BW9
         Iy3w==
X-Gm-Message-State: AOAM5339VXCw2BLGFcWNHwVM5WxlaI/a3Qtttqn+aPToTA8KfzH44gBj
        b4e5e7E2qMRY/vWbrAhkmWh0zK48SE5Aw1zx
X-Google-Smtp-Source: ABdhPJxIF9c3BCQaXRUqSruYt1xa2eVsEhYzzcRbhcaoNwjn53VBPe07RM3JYTFY9anJ4aCQijI2Fw==
X-Received: by 2002:a67:ca9d:: with SMTP id a29mr2409934vsl.45.1643209177997;
        Wed, 26 Jan 2022 06:59:37 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 63sm3946985vkz.19.2022.01.26.06.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:59:37 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id l196so12111589vki.5;
        Wed, 26 Jan 2022 06:59:37 -0800 (PST)
X-Received: by 2002:a1f:384b:: with SMTP id f72mr10172278vka.0.1643209177403;
 Wed, 26 Jan 2022 06:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
In-Reply-To: <20210412122331.1631643-1-linus.walleij@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 15:59:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYOxKECcF+aM3+pTpgp-412YbL5vMDZpmEqJmLigpdVw@mail.gmail.com>
Message-ID: <CAMuHMdUYOxKECcF+aM3+pTpgp-412YbL5vMDZpmEqJmLigpdVw@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

On Mon, Apr 12, 2021 at 2:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> This adjusts the ST Sensor bindings with the more fine-grained
> syntax checks that were proposed late in the last kernel cycle
> and colliding with parallel work.
>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for your patch, which is now commit 0cd71145803dc2b8
("iio: st-sensors: Update ST Sensor bindings") in v5.14.

> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml

>    interrupts:
> +    description: interrupt line(s) connected to the DRDY line(s) and/or the
> +      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
> +      three interrupts, and the DRDY must be the first one if it exists on

So this says three (the LSM9DS0 datasheet agrees)...

> +      the package. The trigger edge of the interrupts is sometimes software
> +      configurable in the hardware so the operating system should parse this
> +      flag and set up the trigger edge as indicated in the device tree.
>      minItems: 1
> +    maxItems: 2

... while this says two?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
