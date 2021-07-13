Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467783C73BD
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 18:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhGMQEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbhGMQEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 12:04:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C1C0613DD;
        Tue, 13 Jul 2021 09:01:18 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t186so16662933ybf.2;
        Tue, 13 Jul 2021 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pI4RPfY9eVbzV1g21E0J8xnG/6971RwWcmcSRgD8qas=;
        b=ECLG56FTNSEUk/dTB7qjqqafkfqnwqmGrJngc8Pph00N//e3UQTdUaxJFrus+duZoJ
         DBYA0KAYM3fgeuibhJkVmlq8vi09H8iRxFMJm045nAi5ygrcVHewBp6Zaaa9eHQ2yCGw
         xTS1//f9G0y37VS8XpzsJy4NZ5dlh4xvnRaZzd3UIMQKXrhps9KJ8kb99cxGfYLvg/wp
         7WZKbgIuywoAXeozfErk3SqOtTlfiDDokjiA4/5ZmNzeamWZ/mH7MyzhluZ4oMN+leQd
         eJjVXd2PbJbGdG+RWbDFAGHnHbtt8UcMLRPDoHgUefE5T3asAAfDN8y+FXGKwCpaZF4+
         HCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pI4RPfY9eVbzV1g21E0J8xnG/6971RwWcmcSRgD8qas=;
        b=c5JbJnT9ihtb5JpntaBpVFoTuNOLkQENqqgmDVXCed5geIy2gH41bJOzQLLn860ylR
         3l8cYL43LdcEg+jhlNKamnC8ELJphs+P8gpbqRgPeVMcJ4kOlP354Blzdc/j4IMko/QO
         OnyTGm5mXU+jVSRdJHa7XEbjUtAKPYMB+zrfVVhuviQsCyOfIWQcbH1ptxM/lE5f/5Ij
         p4tdcP5Da/4352DLqSKvXKBE/i3OwnE5cezc3pPWD8C2QbeeHZ5ZohNkaovxYgonALxa
         XQ1qD9IjAUaWKXGku5PwziLIXBbJXPDJ/X4dgeIrWHomClfmXDqYvzeM9kYM68JYvi60
         hZQA==
X-Gm-Message-State: AOAM531u0MI/SybVDptGTOMoBOQJn5o9ocIqqSu5p8Ex/0sgFUNuqaeM
        vneQ38Qyxi2cNO/mhQazshzUhOOhrXtro2kYu5A=
X-Google-Smtp-Source: ABdhPJzU6A+WDcuFuCKd+RGdJLZfaF4N/XGkrr8f7q07mPaAF3563mdVKs88YjLCm/lkLbjHuDeKfoiTd06wZKwvldk=
X-Received: by 2002:a25:d491:: with SMTP id m139mr6723388ybf.156.1626192078100;
 Tue, 13 Jul 2021 09:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210701202141.GA2859816@robh.at.kernel.org>
In-Reply-To: <20210701202141.GA2859816@robh.at.kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 13 Jul 2021 17:00:52 +0100
Message-ID: <CA+V-a8sAvEQesjdKX8WzPZvPtt70pfm7qk-AGdy5QFrwXSKZrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for
 Renesas RZ/G2L A/D converter
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>,
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

Hi Rob,

Thank you for the review.

On Thu, Jul 1, 2021 at 9:21 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jun 29, 2021 at 11:03:27PM +0100, Lad Prabhakar wrote:
> > Add binding documentation for Renesas RZ/G2L A/D converter block.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
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
>
> You can drop oneOf here.
>
Dropping oneOf from here dt_binding_check complains with below report,
Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml:
properties:compatible: [{'items': [{'enum':
['renesas,r9a07g044-adc']}, {'const': 'renesas,rzg2l-adc'}]}] is not
of type 'object', 'boolean'
from schema $id: http://json-schema.org/draft-07/schema#

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
> > +    default: 0
> > +
> > +  gpios:
>
> A named gpio is preferred. trigger-gpios?
>
Agreed.

Cheers,
Prabhakar

> > +    description:
> > +      ADC_TRG trigger input pin
> > +    maxItems: 1
> > +
> > +  renesas-rzg2l,adc-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    description: Input channels available on platform
> > +    uniqueItems: true
> > +    minItems: 1
> > +    maxItems: 8
> > +    items:
> > +      enum: [0, 1, 2, 3, 4, 5, 6, 7]
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
> > --
> > 2.17.1
> >
> >
