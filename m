Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC73C80FE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhGNJPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbhGNJPI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 05:15:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C3C06175F;
        Wed, 14 Jul 2021 02:12:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id t186so2083596ybf.2;
        Wed, 14 Jul 2021 02:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bVeuBZ+uHS+T9NWs1tv6fdQJ/mndrZqGXpNYSa9tmk=;
        b=uVcvspPXg73FKHPV9TYzvChNQGmZdqkTUJgyeDrzILGhINZ2zyxU65hRwI9qO76s4G
         j75r9wJZ+qaH1qMcFCqxnFD8lRU3BAFjkhbvydLx9rpwQ5sgVWd6QD3z17LeCYhsGVI5
         sDfW0eK0STu5/UN4UouEIXKTAWWdHvm4+2KVHnQ6akyDBvwyaReYJLKZAxPqWhDGhJ2n
         GbXaQgqwHUFpwKhhw6Y5aFmMp8o8x1xORN/ZmT7TcxnUm5FX0ijS5uQlIaNkP0446w/l
         rJCLwCwK+wbdnF7zli5Maj6sVvDQNWoI2NhnYQab76bZjBmHI5qwCpXRI4YTNgYvV5Hm
         uuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bVeuBZ+uHS+T9NWs1tv6fdQJ/mndrZqGXpNYSa9tmk=;
        b=KAWtKueBWvX6pQQmt0Oz0x+4FUlizotAt1/boisvs4x1MVBR/GQsyQ4ymmDY7fPxHR
         dLE5qTvjrM+ioA2gGiKRD77MQgHN8VioXJXuMHFI1m5gLhNln3XbOhtoNq2kAacf2LZP
         hGY1v0iIqO6N2MRHvxOtpJymX9EOIYQubksuak8Ln8gi6i80egPKHICcO9x7oWKTbxeU
         6HnKHz0vs9fb7Cd2O1Y0MNWtGMt8hbJxc7GCyk4XjocjA3MuxJAJbb0rv70CW3kd2G8+
         dobqCQa1ZZIySLPhMmKjPllWYclmjhWsOLpRDqTP0WwbdFMfU3f1GykFbKiU9vrPm/u2
         cOqw==
X-Gm-Message-State: AOAM532rxsutpkjxy3YUuPzRjhP67X+FOtUlOIYQCzcXDi1ryNVd2+Ir
        0dyv8YtSWkv9+9S2n4CPEI5vJrzfbC4asuJZbT8=
X-Google-Smtp-Source: ABdhPJxcXETfZJ/SkV++NyHUkyxlbQsDb9qwARZX4FM46+dm3V5fCSR4PCCVCheWLLTzk3qYhMpXksW+qX4NRob4ZWc=
X-Received: by 2002:a25:7e86:: with SMTP id z128mr11955572ybc.222.1626253935652;
 Wed, 14 Jul 2021 02:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210703181937.510ec0fa@jic23-huawei>
In-Reply-To: <20210703181937.510ec0fa@jic23-huawei>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 14 Jul 2021 10:11:49 +0100
Message-ID: <CA+V-a8uzeepfd+8Wfd2n2EXeXQ9QJZhR+X8j29Y7DGNu8+aH+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for
 Renesas RZ/G2L A/D converter
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for the review.

On Sat, Jul 3, 2021 at 6:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 29 Jun 2021 23:03:27 +0100
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > Add binding documentation for Renesas RZ/G2L A/D converter block.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Hi,
>
> See inline
>
> Jonathan
>
> > ---
> >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > new file mode 100644
> > index 000000000000..db935d6d59eb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L ADC
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description: |
> > +  A/D Converter block is a successive approximation analog-to-digital converter
> > +  with a 12-bit accuracy. Up to eight analog input channels can be selected.
> > +  Conversions can be performed in single or repeat mode. Result of the ADC is
> > +  stored in a 32-bit data register corresponding to each channel.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a07g044-adc   # RZ/G2{L,LC}
> > +          - const: renesas,rzg2l-adc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: converter clock
> > +      - description: peripheral clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: adclk
> > +      - const: pclk
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 2
> > +
> > +  reset-names:
> > +    items:
> > +      - const: presetn
> > +      - const: adrst-n
> > +
> > +  renesas-rzg2l,adc-trigger-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description: Trigger mode for A/D converter
> > +    enum:
> > +      - 0 # Software trigger mode (Defaults)
> > +      - 1 # Asynchronous trigger using ADC_TRG trigger input pin
> > +      - 2 # Synchronous trigger (Trigger from MTU3a/GPT)
>
> Is this a function of the board in some fashion?  If not it sounds like
> something that should be in control of userspace.  Normally we'd
> do that by having the driver register some iio_triggers and depending
> on which one is selected do the equivalent of what you have here.
>
Agreed for Asynchronous and Synchronous triggers. WRT Software trigger
should this be registered as a  iio_triggers too or read_raw()
callback (with IIO_CHAN_INFO_RAW case)  should be treated as Software
trigger?

> > +    default: 0
> > +
> > +  gpios:
> > +    description:
> > +      ADC_TRG trigger input pin
> > +    maxItems: 1
> Why is this mode useful?  I'm assuming the gpio write would take a register
> write and the software trigger mode also requires a register write.
>
Yes gpio write would take a register write.

> Normally the reason for a pin like this is to support synchronising with
> external hardware.   If that's the case, we should call that out here.
> often the pin isn't even connected to a gpio in our control.
> (i.e. it's a trigger signal from some other device.)
>
So just setting the GPIO pin as input should do the trick.

> > +
> > +  renesas-rzg2l,adc-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    description: Input channels available on platform
> > +    uniqueItems: true
> > +    minItems: 1
> > +    maxItems: 8
> > +    items:
> > +      enum: [0, 1, 2, 3, 4, 5, 6, 7]
>
> Is this a function of different devices (should have different compatibles)
> or of what is wired up.  If it's what is wired up, then how do you know which
Its channels which are wired, for example if channels 0-5 are wired up
the board dts would include the property "renesas-rzg2l,adc-channels =
/bits/ 8 <0 1 2 3 4 5>;"

> subset of channels are connected?  We have the generic adc channel binding
> in iio/adc/adc.yaml for the case where we only want to expose those channels
> that are wired up.  It uses a node per channel.
>
Agreed will do that and drop the custom "renesas-rzg2l,adc-channels"

Cheers,
Prabhakar
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - resets
> > +  - reset-names
> > +  - renesas-rzg2l,adc-channels
> > +  - "#io-channel-cells"
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        renesas-rzg2l,adc-trigger-mode:
> > +          const: 1
> > +    then:
> > +      required:
> > +        - gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    adc: adc@10059000 {
> > +      compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
> > +      reg = <0x10059000 0x400>;
> > +      interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
> > +      clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
> > +               <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
> > +      clock-names = "adclk", "pclk";
> > +      power-domains = <&cpg>;
> > +      resets = <&cpg R9A07G044_ADC_PRESETN>,
> > +               <&cpg R9A07G044_ADC_ADRST_N>;
> > +      reset-names = "presetn", "adrst-n";
> > +      #io-channel-cells = <1>;
> > +      renesas-rzg2l,adc-trigger-mode = /bits/ 8 <0>;
> > +      renesas-rzg2l,adc-channels = /bits/ 8 <0 1 2 3 4 5 6>;
> > +    };
>
