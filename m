Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD573CD64E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbhGSN06 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 09:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbhGSN05 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 09:26:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D115C061762
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 06:32:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 8so30345714lfp.9
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25cuJaEBEKHPxKW9Wmn/DayWwdlSxOuvv4yKkUjXcs8=;
        b=e2FLHrOdToHUJfZlKL3B999htauSQadk3NqZcZbfoeqC9ZdNN15B8KfldSQPMKoI90
         reNm5xvYU1C2DsIbD3dkNabpkAKuqFLn3srRP3LDyOikUhGR6m8Nv6NhpFr2XXSR5myi
         fWNSzb2pEH75wNxzSktBzyBFOYzemi4c2tai8EbJji+ld1iWDR7gWT3BDw73NnXkLztG
         icV2mFpNmzvOThZ4e+TuK4d5hxmQNieuN4VGAFxOqffoNeZG1IgzrJuZyjActMm8Cgym
         rEaGw13mSnfjbktRW+H+lxgnjjz5Ta0Q5k7uJFQb1kNVsq7IRrJT9GC9eEEmX2/05DwB
         wCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25cuJaEBEKHPxKW9Wmn/DayWwdlSxOuvv4yKkUjXcs8=;
        b=MM4XMY/TU2TXvGo1ru6AEj/SQ6d5PlTENw81jZ0pSV4bpr4EfuvjxnaOL49RRnTura
         LJaEd9txmoIEPRxixubMWhPj+CyPlWFriyXSQGtB+9WqXNCoA30iHSJcxuCcOyWkgqVv
         mp9mKcvP6j2Wzld0tzafeXG6GLugw2miBjLcDYmg2yPEwbjkrNzpWgzp3/gjwgM70tYP
         76XNmbGky5M+FIzEpEhpK0j4svw6abjFrwLXpW+TgRO35anVUwnBLBCavgE6c11Pr6vz
         NyCTYHJqBTJ17bwuBpEP0sqfqkm9sQ+mPU+VlvgTrT8QR7ocxsM1moGvRFi8F1V5qT9V
         qh/g==
X-Gm-Message-State: AOAM532BOnvNprcHBfSWDZ79bnwsGC5mk2YV6cfpzToowh5CE0Q1s89X
        RwABt2wOdPPvagK59SnVcBmTqpRpubfeLwEiJGScOw==
X-Google-Smtp-Source: ABdhPJzdo7jRp560SrBmxJS3LSZeaaMDmvJXBtJtl4EfPDLfqpxiIj0MLt6MVLQuVcWgpgL2vzU667KZ0+AmvfLC9SM=
X-Received: by 2002:a05:6512:1508:: with SMTP id bq8mr18756713lfb.529.1626703654078;
 Mon, 19 Jul 2021 07:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210719112156.27087-1-stephan@gerhold.net> <20210719112156.27087-4-stephan@gerhold.net>
In-Reply-To: <20210719112156.27087-4-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Jul 2021 16:07:23 +0200
Message-ID: <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: accel: bmc150: Make it possible to configure
 INT2 instead of INT1
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Some Bosch accelerometers have two interrupt pins (INT1 and INT2).
> At the moment, the driver uses only the first one, which is fine for
> most situations. However, some boards might only have INT2 connected
> for some reason.
>
> Add the necessary bits and configuration to set up INT2. Then try
> to detect this situation at least for device tree setups by checking
> if the first interrupt (the one picked by the I2C/SPI core) is actually
> named "INT2" using the interrupt-names property.
>
> of_irq_get_byname() returns either 0 or some error code in case
> the driver probed without device tree, so in all other cases we fall
> back to configuring INT1 as before.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

>  #include <linux/acpi.h>
> +#include <linux/of_irq.h>
(...)
> +       irq_info = bmc150_accel_interrupts_int1;
> +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> +               irq_info = bmc150_accel_interrupts_int2;

This looks a bit DT-specific, but I don't see that ACPI has
named IRQs so I don't know what to do about it either.
What does platform_get_irq_byname() do on ACPI systems?

If there is no obvious fix I would leave it like this until the
first ACPI used needing this comes along, but I think maybe
Andy has suggestions.

Yours,
Linus Walleij
