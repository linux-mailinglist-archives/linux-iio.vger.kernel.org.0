Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5F3C8ACB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbhGNS1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 14:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGNS1r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 14:27:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FBC06175F;
        Wed, 14 Jul 2021 11:24:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b13so4747859ybk.4;
        Wed, 14 Jul 2021 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpV3sdV7S61O3qNeeFQZMA7ea5X7W/pFyadl8Eq+KQ4=;
        b=Yf1vfjVnjzTb1407lZHnKE5HI+V8NDvjRxPeKNpGU+wnNSrafYRbNxXZDy3WZtc3I4
         wYe6TIbPRC3pUjGegPlIi0QWHHAcBbmNxTILyZoBenjRmVtvLhIJ5sybqgHCvBYndfJx
         Hb9eLF7efYdGcndabbr3oXQNahopLiFeotBec7U8Kl3PfslG7sFX8H/hxmF0yZu68fIR
         +gxKUvNZfblS5dfw2KBJfHt6gYPPOIg6kL3G2meRfXPct/FwKKzVCvMprn8fRJ/T/tYD
         CcN4aSi3FM06aCPMDpowrE8Va52Nlt+T6YresPcaQ3HbU49w/+NFGQVxnkidYoi5GWqd
         ZVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpV3sdV7S61O3qNeeFQZMA7ea5X7W/pFyadl8Eq+KQ4=;
        b=I38DRIe/QSgcFwVYB5Eihqu1atN21ITdg34xC3lts0SptOxLY2J7baTK3X/H2KwRbH
         ZwURDgDbbtiHjiBHv2VtGbTtQFDcutv3d1OGIRuhgnA08faOaC/OavBncXW5Mzdz5hIU
         0jiAAxFVwjEEyfcKOS2JQK6xUfRIe/SFPxn3mD0dklTQkrKaEJS3MLZYFTyAemZy0DdC
         lOUx8rgzz7wVnhBTKzWDzTsZpyBxOen2/JBTZzvT2OCNxYH49XMvyL9eUMEO3AEGjfQw
         XSw61F2jQnR0cyohGqQP4a9Q4sVuygUZdYsJKO1O8kJYgaRx2SoZm73vDZExk8Ixg6Ts
         b7wQ==
X-Gm-Message-State: AOAM5306uU1lZz0BSAycMxH3qyZaF1YXMu5sYc5CZsnLD/4mzRoU9gU7
        489Xfmz0+Lv1nHs1GjiomXiD/mW7bIzaS8nUe4I=
X-Google-Smtp-Source: ABdhPJwrMwFZBPMMkaZNNlL1aP5tzNI1sbcJHuA6d+49HpHXX/bolHkkyxYQXKvGwR2A9k+Z72Sx4Y53yem9VDWaxy4=
X-Received: by 2002:a25:694f:: with SMTP id e76mr14297138ybc.119.1626287094010;
 Wed, 14 Jul 2021 11:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210703181937.510ec0fa@jic23-huawei> <CA+V-a8uzeepfd+8Wfd2n2EXeXQ9QJZhR+X8j29Y7DGNu8+aH+g@mail.gmail.com>
 <20210714133913.000075a6@Huawei.com>
In-Reply-To: <20210714133913.000075a6@Huawei.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 14 Jul 2021 19:24:27 +0100
Message-ID: <CA+V-a8spDa5PiGzp6-4mHTEMfQYJ5NnQ44vwgdtu_sfVG5OO5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for
 Renesas RZ/G2L A/D converter
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Wed, Jul 14, 2021 at 1:39 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 14 Jul 2021 10:11:49 +0100
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > Thank you for the review.
> >
> > On Sat, Jul 3, 2021 at 6:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Tue, 29 Jun 2021 23:03:27 +0100
> > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > > Add binding documentation for Renesas RZ/G2L A/D converter block.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Hi,
> > >
> > > See inline
> > >
> > > Jonathan
> > >
> > > > ---
> > > >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
> > > >  1 file changed, 121 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > new file mode 100644
> > > > index 000000000000..db935d6d59eb
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > @@ -0,0 +1,121 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Renesas RZ/G2L ADC
> > > > +
> > > > +maintainers:
> > > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > +
> > > > +description: |
> > > > +  A/D Converter block is a successive approximation analog-to-digital converter
> > > > +  with a 12-bit accuracy. Up to eight analog input channels can be selected.
> > > > +  Conversions can be performed in single or repeat mode. Result of the ADC is
> > > > +  stored in a 32-bit data register corresponding to each channel.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - renesas,r9a07g044-adc   # RZ/G2{L,LC}
> > > > +          - const: renesas,rzg2l-adc
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: converter clock
> > > > +      - description: peripheral clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: adclk
> > > > +      - const: pclk
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  resets:
> > > > +    maxItems: 2
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: presetn
> > > > +      - const: adrst-n
> > > > +
> > > > +  renesas-rzg2l,adc-trigger-mode:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > +    description: Trigger mode for A/D converter
> > > > +    enum:
> > > > +      - 0 # Software trigger mode (Defaults)
> > > > +      - 1 # Asynchronous trigger using ADC_TRG trigger input pin
> > > > +      - 2 # Synchronous trigger (Trigger from MTU3a/GPT)
> > >
> > > Is this a function of the board in some fashion?  If not it sounds like
> > > something that should be in control of userspace.  Normally we'd
> > > do that by having the driver register some iio_triggers and depending
> > > on which one is selected do the equivalent of what you have here.
> > >
> > Agreed for Asynchronous and Synchronous triggers. WRT Software trigger
> > should this be registered as a  iio_triggers too or read_raw()
> > callback (with IIO_CHAN_INFO_RAW case)  should be treated as Software
> > trigger?
> >
>
> Normally we'd use an external trigger to provide the software trigger
> (plus as you say sysfs reads will map to this functionality).
>
> Something like the sysfs trigger or the hrtimer one would get used, though
> also fine to use the dataready trigger from a different device (if you want
> approximately synced dta.
>
We can live with syfs reads for now for SW triggers. Coming back to HW
triggers I responded too quickly!. I am now trying to implement a gpio
based HW trigger i.e. to kick adc conversion start but I couldn't find
any drivers doing that. I looked at iio-trig-interrupt.c which
registers irq based triggers, so something similar needs to be
implemented in the adc driver? If that is the case the gpio has to be
passed via to DT and use gpio_to_irq to register the handler. Or is it
that I am missing something here ?

Cheers,
Prabhakar

> > > > +    default: 0
> > > > +
> > > > +  gpios:
> > > > +    description:
> > > > +      ADC_TRG trigger input pin
> > > > +    maxItems: 1
> > > Why is this mode useful?  I'm assuming the gpio write would take a register
> > > write and the software trigger mode also requires a register write.
> > >
> > Yes gpio write would take a register write.
> >
> > > Normally the reason for a pin like this is to support synchronising with
> > > external hardware.   If that's the case, we should call that out here.
> > > often the pin isn't even connected to a gpio in our control.
> > > (i.e. it's a trigger signal from some other device.)
> > >
> > So just setting the GPIO pin as input should do the trick.
>
> Probably the best plan if you actually care about people writing some
> trigger up to it that is otherwise invisible to the system.
>
> >
> > > > +
> > > > +  renesas-rzg2l,adc-channels:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > > > +    description: Input channels available on platform
> > > > +    uniqueItems: true
> > > > +    minItems: 1
> > > > +    maxItems: 8
> > > > +    items:
> > > > +      enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > >
> > > Is this a function of different devices (should have different compatibles)
> > > or of what is wired up.  If it's what is wired up, then how do you know which
> > Its channels which are wired, for example if channels 0-5 are wired up
> > the board dts would include the property "renesas-rzg2l,adc-channels =
> > /bits/ 8 <0 1 2 3 4 5>;"
> >
> > > subset of channels are connected?  We have the generic adc channel binding
> > > in iio/adc/adc.yaml for the case where we only want to expose those channels
> > > that are wired up.  It uses a node per channel.
> > >
> > Agreed will do that and drop the custom "renesas-rzg2l,adc-channels"
>
> Great,
>
> Jonathan
>
> >
> > Cheers,
> > Prabhakar
> > > > +
> > > > +  "#io-channel-cells":
> > > > +    const: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - clocks
> > > > +  - clock-names
> > > > +  - power-domains
> > > > +  - resets
> > > > +  - reset-names
> > > > +  - renesas-rzg2l,adc-channels
> > > > +  - "#io-channel-cells"
> > > > +
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        renesas-rzg2l,adc-trigger-mode:
> > > > +          const: 1
> > > > +    then:
> > > > +      required:
> > > > +        - gpios
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    adc: adc@10059000 {
> > > > +      compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
> > > > +      reg = <0x10059000 0x400>;
> > > > +      interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
> > > > +      clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
> > > > +               <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
> > > > +      clock-names = "adclk", "pclk";
> > > > +      power-domains = <&cpg>;
> > > > +      resets = <&cpg R9A07G044_ADC_PRESETN>,
> > > > +               <&cpg R9A07G044_ADC_ADRST_N>;
> > > > +      reset-names = "presetn", "adrst-n";
> > > > +      #io-channel-cells = <1>;
> > > > +      renesas-rzg2l,adc-trigger-mode = /bits/ 8 <0>;
> > > > +      renesas-rzg2l,adc-channels = /bits/ 8 <0 1 2 3 4 5 6>;
> > > > +    };
> > >
>
