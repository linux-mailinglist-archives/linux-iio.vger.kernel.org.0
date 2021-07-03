Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7583BA9B8
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhGCRTx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 13:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCRTx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 13:19:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B36C6192B;
        Sat,  3 Jul 2021 17:17:15 +0000 (UTC)
Date:   Sat, 3 Jul 2021 18:19:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation
 for Renesas RZ/G2L A/D converter
Message-ID: <20210703181937.510ec0fa@jic23-huawei>
In-Reply-To: <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Jun 2021 23:03:27 +0100
Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Add binding documentation for Renesas RZ/G2L A/D converter block.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Hi,

See inline

Jonathan

> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> new file mode 100644
> index 000000000000..db935d6d59eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L ADC
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description: |
> +  A/D Converter block is a successive approximation analog-to-digital converter
> +  with a 12-bit accuracy. Up to eight analog input channels can be selected.
> +  Conversions can be performed in single or repeat mode. Result of the ADC is
> +  stored in a 32-bit data register corresponding to each channel.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-adc   # RZ/G2{L,LC}
> +          - const: renesas,rzg2l-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: converter clock
> +      - description: peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: adclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: presetn
> +      - const: adrst-n
> +
> +  renesas-rzg2l,adc-trigger-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: Trigger mode for A/D converter
> +    enum:
> +      - 0 # Software trigger mode (Defaults)
> +      - 1 # Asynchronous trigger using ADC_TRG trigger input pin
> +      - 2 # Synchronous trigger (Trigger from MTU3a/GPT)

Is this a function of the board in some fashion?  If not it sounds like
something that should be in control of userspace.  Normally we'd
do that by having the driver register some iio_triggers and depending
on which one is selected do the equivalent of what you have here.

> +    default: 0
> +
> +  gpios:
> +    description:
> +      ADC_TRG trigger input pin
> +    maxItems: 1
Why is this mode useful?  I'm assuming the gpio write would take a register
write and the software trigger mode also requires a register write.

Normally the reason for a pin like this is to support synchronising with
external hardware.   If that's the case, we should call that out here.
often the pin isn't even connected to a gpio in our control.
(i.e. it's a trigger signal from some other device.)

> +
> +  renesas-rzg2l,adc-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Input channels available on platform
> +    uniqueItems: true
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      enum: [0, 1, 2, 3, 4, 5, 6, 7]

Is this a function of different devices (should have different compatibles)
or of what is wired up.  If it's what is wired up, then how do you know which
subset of channels are connected?  We have the generic adc channel binding
in iio/adc/adc.yaml for the case where we only want to expose those channels
that are wired up.  It uses a node per channel.

> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - renesas-rzg2l,adc-channels
> +  - "#io-channel-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        renesas-rzg2l,adc-trigger-mode:
> +          const: 1
> +    then:
> +      required:
> +        - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    adc: adc@10059000 {
> +      compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
> +      reg = <0x10059000 0x400>;
> +      interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
> +      clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
> +               <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
> +      clock-names = "adclk", "pclk";
> +      power-domains = <&cpg>;
> +      resets = <&cpg R9A07G044_ADC_PRESETN>,
> +               <&cpg R9A07G044_ADC_ADRST_N>;
> +      reset-names = "presetn", "adrst-n";
> +      #io-channel-cells = <1>;
> +      renesas-rzg2l,adc-trigger-mode = /bits/ 8 <0>;
> +      renesas-rzg2l,adc-channels = /bits/ 8 <0 1 2 3 4 5 6>;
> +    };

