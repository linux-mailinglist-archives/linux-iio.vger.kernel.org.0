Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1440F36300F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Apr 2021 15:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhDQMwG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Apr 2021 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhDQMwF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Apr 2021 08:52:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70740C061574;
        Sat, 17 Apr 2021 05:51:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j7so11596318pgi.3;
        Sat, 17 Apr 2021 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CK9W0sv6eRHdyCB5RWUgu3S7S7hJ78bLj/lTgSuLMhU=;
        b=YEKvlLpxuA4qNW5N1A3VDiigeTuCGS9cKk174L9rxmXIobdMp0C7YWpk5yoDt9X2sT
         gSS+4b/VwsW+PdGgUnCHq6JHcVgHXA5MrwfN5X5J6Sp3g7xxLGrG1AnK5KEVZxIj7aTA
         V/am8e5y8NUfoE/md1jvr0CBPGpOmIU2aX3tKum/9FEYW/S7O7WCsmxS0tgAhjRYN9R1
         KAHrYRBINWhNmZz8mjrEvtYl4qnzw0ZvoBEW57uAfkHOerOhl3UWiTtg2UOk8RfdDacC
         ea7xcV3T+OtVWJUru2i52pgTgNsGKTbVezg4nxNXyl879Ipp/Vxe5Pz2JJm+mVpmZig8
         2Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CK9W0sv6eRHdyCB5RWUgu3S7S7hJ78bLj/lTgSuLMhU=;
        b=spAoOgYmTp3gOto+DBEsm2hpAtJjE28XBfVgTCJ/Z2k9dLWQ1HQG23b6hpIZ/hcVfA
         ++HGlb7JHWhelN9uyjZhUZIBNN/MCqiCOUNnEIXQ691t0jg/EvfKSu8iIE9kbsrcoRzF
         vPnGqrkMoTSt94fAR1ztcz2B5w9t2t6ujkihPWx2PN8UBvRekcVLAyGbRBAXpNSl3WJc
         m6Bmc9/QEslx7ay115zWanA0p/vKxmA/fH7cYSwS2nI9y7UwXjUNOc9PHykjunJbhM2a
         8qVAyv1M6qaToio+moEUe9AtmCnVTNxWJAXydhRBiHb7qDR+eucNnSQ4EqV8XttFpUcb
         2OOw==
X-Gm-Message-State: AOAM533s0VR++MoIbsSk46MxCbcgIMiLSblwHm/JopM01h53H+rL/Sqo
        f2aaErRy0F5phZ2x4my9uAwkw9ogMhqZdsPShaU=
X-Google-Smtp-Source: ABdhPJxFHrHOcaWMtBTuY6BBbacMdvwL1IWqXrKMpxOU4xUMo/q+cRsXMxUNBu76aAXBLwIkZj84WH+ulygofKf479Q=
X-Received: by 2002:a63:cb44:: with SMTP id m4mr3432862pgi.4.1618663898587;
 Sat, 17 Apr 2021 05:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210416174902.9036-1-joe.g.sandom@gmail.com> <20210416174902.9036-2-joe.g.sandom@gmail.com>
In-Reply-To: <20210416174902.9036-2-joe.g.sandom@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Apr 2021 15:51:22 +0300
Message-ID: <CAHp75Ve6qFizMF2-vWv+o2fKX3P8nH=tWNum6PTvtDjFh94MPA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] Added AMS tsl2591 device tree binding
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 16, 2021 at 8:49 PM Joe Sandom <joe.g.sandom@gmail.com> wrote:
>
> Device tree binding for AMS/TAOS tsl2591 ambient light sensor.
>
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
>
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.

With subject line fixed (other comments up to you)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v8:
> - No changes
>
> Notes:
> - Re-submitted to align the version with part 1 of the patch series
>
>  .../bindings/iio/light/amstaos,tsl2591.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> new file mode 100644
> index 000000000000..596a3bc770f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/amstaos,tsl2591.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS/TAOS TSL2591 Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Joe Sandom <joe.g.sandom@gmail.com>
> +
> +description: |
> +  AMS/TAOS TSL2591 is a very-high sensitivity
> +  light-to-digital converter that transforms light intensity into a digital
> +  signal.
> +
> +properties:
> +  compatible:
> +    const: amstaos,tsl2591
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt (INT:Pin 2) Active low. Should be set to IRQ_TYPE_EDGE_FALLING.
> +      interrupt is used to detect if the light intensity has fallen below
> +      or reached above the configured threshold values.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tsl2591@29 {
> +            compatible = "amstaos,tsl2591";
> +            reg = <0x29>;
> +            interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> +       };
> +    };
> +...
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
