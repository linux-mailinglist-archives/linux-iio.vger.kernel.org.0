Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E99461002
	for <lists+linux-iio@lfdr.de>; Mon, 29 Nov 2021 09:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbhK2I2G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Nov 2021 03:28:06 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:38795 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbhK2I0F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Nov 2021 03:26:05 -0500
Received: by mail-vk1-f173.google.com with SMTP id s17so10463738vka.5;
        Mon, 29 Nov 2021 00:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMG52Q67pGPYOq1nBleIjVZNUPk0ygNagAeG5Cgw18Q=;
        b=Co0qhlQ1QTKJjTy7MMeod3hH4Ha8+tmq1tR6eEftNpRNZBk2H+Lcth/YAZXkqqMUiS
         9xDVmImfwJUs3KkZSqWgIEo7AYIPW/DlgqtHJgtPmYaOTchcR1/CB3cmVD1XvS/8WJ3Y
         LM2HC8uFZWZaNkdIoE2OtRQfw+HbwCGyTsw6teVvEybBqanSsEbbWI+ET98gIBSx2lbf
         UX+HUXfvAYgfdVMcFIdg3GQ/5m3im6NvMMQ0GHqcFQ4qPbu7KAV23z9mzKIZKIju+RBd
         aVx4tA29YmyhZzqXUppNcveKeX86e49wtqOvV8p0CDno38uQDjmSDxHpWK8ZBOFD4fTp
         4REA==
X-Gm-Message-State: AOAM533BkAX2LPg2xxriaUTQlqMkKosBA8DEyLs8kouSq8HwHkvkbPnb
        ZWgmCfxQ46q9nb52PDQv5KkrGB1OJaXWuw==
X-Google-Smtp-Source: ABdhPJz8YNe0F3bJpoq5qnbaIgLS+s2/6NAX/Hp8wfGygMNkrSH1MWnf3vLtgv41UhFIc8SKGziI6w==
X-Received: by 2002:a1f:2b4a:: with SMTP id r71mr29181743vkr.37.1638174167142;
        Mon, 29 Nov 2021 00:22:47 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id n10sm8769775uaj.20.2021.11.29.00.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 00:22:46 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id i6so32267464uae.6;
        Mon, 29 Nov 2021 00:22:46 -0800 (PST)
X-Received: by 2002:a9f:248b:: with SMTP id 11mr47461078uar.14.1638174166538;
 Mon, 29 Nov 2021 00:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20211125152154.162780-1-geert@linux-m68k.org> <3fec093a-df46-6096-3f66-891734a5f140@canonical.com>
 <20211127174343.1b9dcabe@jic23-huawei>
In-Reply-To: <20211127174343.1b9dcabe@jic23-huawei>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Nov 2021 09:22:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWZEai-EYvoWc5eToSqK9N8KsXi6u0Ej6fQzQE77aNoA@mail.gmail.com>
Message-ID: <CAMuHMdVWZEai-EYvoWc5eToSqK9N8KsXi6u0Ej6fQzQE77aNoA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: exynos-adc: Fix node name in example
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Nov 27, 2021 at 6:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 25 Nov 2021 16:26:16 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> > On 25/11/2021 16:21, Geert Uytterhoeven wrote:
> > > "make dt_binding_check":
> > >
> > >     Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: ncp15wb473: $nodename:0: 'ncp15wb473' does not match '^thermistor(.*)?$'
> > >         From schema: Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > >  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >
> This doesn't particularly feel like we need to rush it in, so applied
> to the togreg branch of iio.git which will go in next merge window.
>
> Shout if I should pull it to a fixes branch.

Thank you, that's fine. We're still far from the point where we can start
enforcing "no errors" in "make dt_binding_check dtbs_check".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
