Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF66D11492E
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2019 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfLEWYY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Dec 2019 17:24:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38994 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfLEWYY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Dec 2019 17:24:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so4088156oty.6;
        Thu, 05 Dec 2019 14:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+ntObkjRpAa/oOIcrXOi6B2bOSJNJ8qawZSdjlonVM=;
        b=QEBnD4IsmHX6hafNovR1VZeKthExfQQ3yBxiLYuuxqzg18RT+yPcn6Qcp8Njta8Buc
         CMKGl6WoOS5GaDpXcQU5+RDTSw0CT/EITtUqCs8Jaw+PrY9Hn4vrG9lHO61EvkbJE8NH
         Ptl6SjAQU+OOJu9C8omexuVzeENh5Vwz9hc1EzOoKt0vkXuIO+ve7X4oWjAP01ej3NlM
         qDH5k8PNtJqAMda7xAXglk1oXk7Qcp6r4KZoj+7FcekcQdzKf5yILqPB9Fc2NqHEvQKJ
         /HkTc2cgdW5L0niwtkLk5WT0zgRZArxprnBwyZHGD79xDXO2wCKEqCP2CZAcicW0d/yt
         epaQ==
X-Gm-Message-State: APjAAAUWiPXefMtTPFpuyW/nj0lng49OQ3M+M7A5iqIHaFMGR9QsNMTw
        1rSvpWBMywU+yPVJxFpPVg==
X-Google-Smtp-Source: APXvYqzwgOnIep4g2tpFIV3s/3gibmbz5buTcOGPMtyrZVZBEnUJrTuNJw11+0nE6brk2O2rA2p/LQ==
X-Received: by 2002:a9d:7305:: with SMTP id e5mr8346342otk.64.1575584662374;
        Thu, 05 Dec 2019 14:24:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r24sm3868153ota.61.2019.12.05.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 14:24:21 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:24:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     jic23@kernel.org, alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-adc: convert bindings to
 json-schema
Message-ID: <20191205222421.GA312@bogus>
References: <1574873325-9916-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574873325-9916-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 27, 2019 at 05:48:45PM +0100, Fabrice Gasnier wrote:
> Convert the STM32 ADC binding to DT schema format using json-schema
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Note: this applies on top of IIO tree currently (iio-for-5.5c).
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -------
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 448 +++++++++++++++++++++
>  2 files changed, 448 insertions(+), 149 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml


> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> new file mode 100644
> index 00000000..2ebc2e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> @@ -0,0 +1,448 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/bindings/iio/adc/st,stm32-adc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: STMicroelectronics STM32 ADC bindings
> +
> +description: |
> +  STM32 ADC is a successive approximation analog-to-digital converter.
> +  It has several multiplexed input channels. Conversions can be performed
> +  in single, continuous, scan or discontinuous mode. Result of the ADC is
> +  stored in a left-aligned or right-aligned 32-bit data register.
> +  Conversions can be launched in software or using hardware triggers.
> +
> +  The analog watchdog feature allows the application to detect if the input
> +  voltage goes beyond the user-defined, higher or lower thresholds.
> +
> +  Each STM32 ADC block can have up to 3 ADC instances.
> +
> +maintainers:
> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stm32f4-adc-core
> +      - st,stm32h7-adc-core
> +      - st,stm32mp1-adc-core
> +
> +  reg:
> +    description: Offset and length of the ADC block register set

Don't need generic description of a standard property.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      One or more interrupts for ADC block, depending on part used:
> +        - stm32f4 and stm32h7 share a common ADC interrupt line.
> +        - stm32mp1 has two separate interrupt lines, one for each ADC within
> +          ADC block.

You can put minItems: 1, maxItems: 2 here.

> +
> +  clocks:
> +    description: |
> +      Core can use up to two clocks, depending on part used:
> +        - "adc" clock: for the analog circuitry, common to all ADCs.
> +          It's required on stm32f4.
> +          It's optional on stm32h7 and stm32mp1.
> +        - "bus" clock: for registers access, common to all ADCs.
> +          It's not present on stm32f4.
> +          It's required on stm32h7 and stm32mp1.
> +
> +  clock-names: true
> +
> +  st,max-clk-rate-hz:
> +    description: |
> +      Allow to specify desired max clock rate used by analog circuitry.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

*-hz already has a type, so you can drop this.

No range you can specify?

> +
> +  vdda-supply:
> +    description: Phandle to the vdda input analog voltage.
> +
> +  vref-supply:
> +    description: Phandle to the vref input analog reference voltage.
> +
> +  booster-supply:
> +    description: |

There's not any formatting here, so '|' can be dropped.

> +      Phandle to the embedded booster regulator that can be used to supply ADC
> +      analog input switches on stm32h7 and stm32mp1.
> +
> +  vdd-supply:
> +    description: |
> +      Phandle to the vdd input voltage. It can be used to supply ADC analog
> +      input switches on stm32mp1.
> +
> +  st,syscfg:
> +    description: |
> +      Phandle to system configuration controller. It can be used to control the
> +      analog circuitry on stm32mp1.
> +    allOf:
> +      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32f4-adc-core
> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          items:
> +            const: adc
> +          maxItems: 1

You can simplify to:

clock-names:
  const: adc

Note that if you did have 'items' it should be a list (i.e. have '-').

> +
> +        interrupts:
> +          items:
> +            - description: interrupt line common for all ADCs
> +
> +        booster-supply: false
> +
> +        vdd-supply: false
> +
> +        st,syscfg: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32h7-adc-core
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: adc
> +          minItems: 1
> +          maxItems: 2
> +
> +        interrupts:
> +          items:
> +            - description: interrupt line common for all ADCs
> +
> +        vdd-supply: false
> +
> +        st,syscfg: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-adc-core
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: adc
> +          minItems: 1
> +          maxItems: 2
> +
> +        interrupts:
> +          items:
> +            - description: interrupt line for ADC1
> +            - description: interrupt line for ADC2
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - vdda-supply
> +  - vref-supply
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +patternProperties:
> +  "^adc@[0-9]+$":
> +    type: object
> +    description: |
> +      An ADC block node should contain at least one subnode, representing an
> +      ADC instance available on the machine.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - st,stm32f4-adc
> +          - st,stm32h7-adc
> +          - st,stm32mp1-adc
> +
> +      reg:
> +        description: |
> +          Offset of ADC instance in ADC block. Valid values are:
> +            - 0x0:   ADC1
> +            - 0x100: ADC2
> +            - 0x200: ADC3 (stm32f4 only)
> +        maxItems: 1
> +
> +      '#io-channel-cells':
> +        const: 1
> +
> +      interrupts:
> +        description: |
> +          IRQ Line for the ADC instance. Valid values are:
> +            - 0 for adc@0
> +            - 1 for adc@100
> +            - 2 for adc@200 (stm32f4 only)
> +        maxItems: 1
> +
> +      clocks:
> +        description: |
> +          Input clock private to this ADC instance. It's required only on
> +          stm32f4, that has per instance clock input for registers access.
> +        maxItems: 1
> +
> +      dmas:
> +        description: RX DMA Channel
> +        maxItems: 1
> +
> +      dma-names:
> +        const: rx
> +
> +      assigned-resolution-bits:
> +        description: |
> +          Resolution (bits) to use for conversions:
> +            - can be 6, 8, 10 or 12 on stm32f4
> +            - can be 8, 10, 12, 14 or 16 on stm32h7 and stm32mp1
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      st,adc-channels:
> +        description: |
> +          List of single-ended channels muxed for this ADC. It can have up to:
> +            - 16 channels, numbered from 0 to 15 (for in0..in15) on stm32f4
> +            - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
> +              stm32mp1.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +      st,adc-diff-channels:
> +        description: |
> +          List of differential channels muxed for this ADC. Some channels can
> +          be configured as differential instead of single-ended on stm32h7 and
> +          on stm32mp1. Positive and negative inputs pairs are listed:
> +          <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered from 0 to 19.
> +
> +          Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is
> +          required. Both properties can be used together. Some channels can be
> +          used as single-ended and some other ones as differential (mixed). But
> +          channels can't be configured both as single-ended and differential.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +          - items:
> +              items:
> +                - description: |
> +                    "vinp" indicates positive input number
> +                  minimum: 0
> +                  maximum: 19
> +                - description: |
> +                    "vinn" indicates negative input number
> +                  minimum: 0
> +                  maximum: 19
> +
> +      st,min-sample-time-nsecs:
> +        description: |
> +          Minimum sampling time in nanoseconds. Depending on hardware (board)
> +          e.g. high/low analog input source impedance, fine tune of ADC
> +          sampling time may be recommended. This can be either one value or an
> +          array that matches "st,adc-channels" and/or "st,adc-diff-channels"
> +          list, to set sample time resp. for all channels, or independently for
> +          each channel.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: st,stm32f4-adc

There's a lot of if/thens in this binding. I wonder if splitting this 
into 2 files might be cleaner. 

> +
> +        then:
> +          properties:
> +            reg:
> +              enum:
> +                - 0x0
> +                - 0x100
> +                - 0x200
> +
> +            interrupts:
> +              minimum: 0
> +              maximum: 2
> +
> +            assigned-resolution-bits:
> +              allOf:
> +                - enum: [6, 8, 10, 12]
> +                - default: 12
> +
> +            st,adc-channels:
> +              allOf:
> +                - maxItems: 16
> +                  items:
> +                    minimum: 0
> +                    maximum: 15
> +
> +            st,adc-diff-channels: false
> +
> +            st,min-sample-time-nsecs:
> +              allOf:
> +                - maxItems: 16
> +                  items:
> +                    minimum: 80
> +
> +          required:
> +            - clocks
> +
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - st,stm32h7-adc
> +                  - st,stm32mp1-adc
> +
> +        then:
> +          properties:
> +            reg:
> +              enum:
> +                - 0x0
> +                - 0x100
> +
> +            interrupts:
> +              minimum: 0
> +              maximum: 1
> +
> +            assigned-resolution-bits:
> +              allOf:

Shouldn't need the allOf here.

> +                - enum: [8, 10, 12, 14, 16]
> +                - default: 16
> +
> +            st,adc-channels:
> +              allOf:

Shouldn't need the allOf here.

> +                - maxItems: 20
> +                  items:
> +                    minimum: 0
> +                    maximum: 19
> +
> +            st,min-sample-time-nsecs:
> +              allOf:

Shouldn't need the allOf here.

> +                - maxItems: 20
> +                  items:
> +                    minimum: 40
> +
> +    additionalProperties: false
> +
> +    anyOf:
> +      - required:
> +          - st,adc-channels
> +      - required:
> +          - st,adc-diff-channels
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - '#io-channel-cells'
> +
> +examples:
> +  - |
> +    // Example 1: with stm32f429
> +      adc123: adc@40012000 {
> +        compatible = "st,stm32f4-adc-core";
> +        reg = <0x40012000 0x400>;
> +        interrupts = <18>;
> +        clocks = <&rcc 0 168>;
> +        clock-names = "adc";
> +        st,max-clk-rate-hz = <36000000>;
> +        vdda-supply = <&vdda>;
> +        vref-supply = <&vref>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc@0 {
> +          compatible = "st,stm32f4-adc";
> +          #io-channel-cells = <1>;
> +          reg = <0x0>;
> +          clocks = <&rcc 0 168>;
> +          interrupt-parent = <&adc123>;
> +          interrupts = <0>;
> +          st,adc-channels = <8>;
> +          dmas = <&dma2 0 0 0x400 0x0>;
> +          dma-names = "rx";
> +          assigned-resolution-bits = <8>;
> +        };
> +        // ...
> +        // other adc child nodes follow...
> +      };
> +
> +  - |
> +    // Example 2: with stm32mp157c to setup ADC1 with:
> +    // - channel 1 as single-ended
> +    // - channels 2 & 3 as differential (with resp. 6 & 7 negative inputs)
> +      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +      #include <dt-bindings/clock/stm32mp1-clks.h>
> +      adc12: adc@48003000 {
> +        compatible = "st,stm32mp1-adc-core";
> +        reg = <0x48003000 0x400>;
> +        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&rcc ADC12>, <&rcc ADC12_K>;
> +        clock-names = "bus", "adc";
> +        booster-supply = <&booster>;
> +        vdd-supply = <&vdd>;
> +        vdda-supply = <&vdda>;
> +        vref-supply = <&vref>;
> +        st,syscfg = <&syscfg>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc@0 {
> +          compatible = "st,stm32mp1-adc";
> +          #io-channel-cells = <1>;
> +          reg = <0x0>;
> +          interrupt-parent = <&adc12>;
> +          interrupts = <0>;
> +          st,adc-channels = <1>;
> +          st,adc-diff-channels = <2 6>, <3 7>;
> +          st,min-sample-time-nsecs = <5000>;
> +          dmas = <&dmamux1 9 0x400 0x05>;
> +          dma-names = "rx";
> +        };
> +        // ...
> +        // other adc child node follow...
> +      };
> +
> +...
> -- 
> 2.7.4
> 
