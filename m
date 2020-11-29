Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEBC2C7903
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 13:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgK2MB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 07:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgK2MB5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 07:01:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3622A206E3;
        Sun, 29 Nov 2020 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606651277;
        bh=BM1fJjvWFnC/h/MGGYVv0WCzCfMU5A/DDQ2MnbGTWUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mBhHWuHPAi1Q8XD4u+U7fvH5VL3vcSz90rkOwaR30nl2mFm+mF/OxqP1rg05z0lIO
         AQWXXkb5cdQFphQWAkJPvVDTdJQbzzlKo/Pbh5BA8eiGWJFm5eMQohol+p1kV0vEPg
         QIbFkOPO7+tO0T7U+Qv1BUaMO8t5rh8P1MpFvV0s=
Date:   Sun, 29 Nov 2020 12:01:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 04/10] dt-bindings:iio:adc:atmel,sama9260-adc:
 conversion to yaml from at91_adc.txt
Message-ID: <20201129120111.2ba047c9@archlinux>
In-Reply-To: <20201128222818.1910764-5-alexandre.belloni@bootlin.com>
References: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
        <20201128222818.1910764-5-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 23:28:12 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There are a few things we would do differently in an ADC binding if we
> were starting from scratch but we are stuck with what we have (which
> made sense back when this was written!)
> 
> We may be able to tighten up some elements of this binding in the future
> by careful checking of what values properties can actually take.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> [Alexandre Belloni: add sama5d3, remove atmel,adc-res and atmel,adc-res-names]
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

So this one is interesting from the question of what the right tag chain is.
I've signed-off on it again whilst applying but also added a note to make
it clear the two sign offs are actually for different things.

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/at91_adc.txt  |  78 --------
>  .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 167 ++++++++++++++++++
>  2 files changed, 167 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
> deleted file mode 100644
> index da393ac5c05f..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -* AT91's Analog to Digital Converter (ADC)
> -
> -Required properties:
> -  - compatible: Should be "atmel,<chip>-adc"
> -    <chip> can be "at91sam9260", "at91sam9g45", "at91sam9x5" or "sama5d3"
> -  - reg: Should contain ADC registers location and length
> -  - interrupts: Should contain the IRQ line for the ADC
> -  - clock-names: tuple listing input clock names.
> -	Required elements: "adc_clk", "adc_op_clk".
> -  - clocks: phandles to input clocks.
> -  - atmel,adc-channels-used: Bitmask of the channels muxed and enabled for this
> -    device
> -  - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
> -    defined in the datasheet
> -  - atmel,adc-vref: Reference voltage in millivolts for the conversions
> -
> -Optional properties:
> -  - atmel,adc-use-external-triggers: Boolean to enable the external triggers
> -  - atmel,adc-use-res: String selecting the resolution, can be "lowres" or
> -		       "highres". If not specified, the highest resolution will
> -		       be used.
> -  - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
> -  - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
> -  - atmel,adc-ts-wires: Number of touchscreen wires. Should be 4 or 5. If this
> -                        value is set, then the adc driver will enable touchscreen
> -                        support.
> -    NOTE: when adc touchscreen is enabled, the adc hardware trigger will be
> -          disabled. Since touchscreen will occupy the trigger register.
> -  - atmel,adc-ts-pressure-threshold: a pressure threshold for touchscreen. It
> -                                     makes touch detection more precise.
> -
> -Optional trigger Nodes:
> -  - Required properties:
> -    * trigger-name: Name of the trigger exposed to the user
> -    * trigger-value: Value to put in the Trigger register
> -      to activate this trigger
> -  - Optional properties:
> -    * trigger-external: Is the trigger an external trigger?
> -
> -Examples:
> -adc0: adc@fffb0000 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "atmel,at91sam9260-adc";
> -	reg = <0xfffb0000 0x100>;
> -	interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
> -	clocks = <&adc_clk>, <&adc_op_clk>;
> -	clock-names = "adc_clk", "adc_op_clk";
> -	atmel,adc-channels-used = <0xff>;
> -	atmel,adc-startup-time = <40>;
> -	atmel,adc-use-external-triggers;
> -	atmel,adc-vref = <3300>;
> -	atmel,adc-res = <8 10>;
> -	atmel,adc-res-names = "lowres", "highres";
> -	atmel,adc-use-res = "lowres";
> -
> -	trigger0 {
> -		trigger-name = "external-rising";
> -		trigger-value = <0x1>;
> -		trigger-external;
> -	};
> -	trigger1 {
> -		trigger-name = "external-falling";
> -		trigger-value = <0x2>;
> -		trigger-external;
> -	};
> -
> -	trigger2 {
> -		trigger-name = "external-any";
> -		trigger-value = <0x3>;
> -		trigger-external;
> -	};
> -
> -	trigger3 {
> -		trigger-name = "continuous";
> -		trigger-value = <0x6>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
> new file mode 100644
> index 000000000000..9b0ff59e75de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
> @@ -0,0 +1,167 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/atmel,sama9260-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AT91 sama9260 and similar Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9260-adc
> +      - atmel,at91sam9rl-adc
> +      - atmel,at91sam9g45-adc
> +      - atmel,at91sam9x5-adc
> +      - atmel,at91sama5d3-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: adc_clk
> +      - const: adc_op_clk
> +
> +  atmel,adc-channels-used:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Bitmask of the channels muxed and enabled for this device
> +
> +  atmel,adc-startup-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Startup Time of the ADC in microseconds as defined in the datasheet
> +
> +  atmel,adc-vref:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Reference voltage in millivolts for the conversions
> +
> +  atmel,adc-use-external-triggers:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enable the external triggers
> +
> +  atmel,adc-use-res:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      String corresponding to an identifier from atmel,adc-res-names property.
> +      If not specified, the highest resolution will be used.
> +    enum:
> +      - "lowres"
> +      - "highres"
> +
> +  atmel,adc-sleep-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enable sleep mode when no conversion
> +
> +  atmel,adc-sample-hold-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sample and Hold Time in microseconds
> +
> +  atmel,adc-ts-wires:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Number of touchscreen wires. Must be set to enable touchscreen.
> +      NOTE: when adc touchscreen is enabled, the adc hardware trigger will be
> +      disabled. Since touchscreen will occupy the trigger register.
> +    enum:
> +      - 4
> +      - 5
> +
> +  atmel,adc-ts-pressure-threshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Pressure threshold for touchscreen.
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - atmel,adc-channels-used
> +  - atmel,adc-startup-time
> +  - atmel,adc-vref
> +
> +patternProperties:
> +  "^(trigger)[0-9]$":
> +    type: object
> +    description: Child node to describe a trigger exposed to the user.
> +    properties:
> +      trigger-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Identifying name.
> +
> +      trigger-value:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Value to put in the Trigger register to activate this trigger
> +
> +      trigger-external:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: This trigger is provided from an external pin.
> +
> +    additionalProperties: false
> +    required:
> +      - trigger-name
> +      - trigger-value
> +
> +examples:
> +  - |
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        adc@fffb0000 {
> +            compatible = "atmel,at91sam9260-adc";
> +            reg = <0xfffb0000 0x100>;
> +            interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
> +            clocks = <&adc_clk>, <&adc_op_clk>;
> +            clock-names = "adc_clk", "adc_op_clk";
> +            atmel,adc-channels-used = <0xff>;
> +            atmel,adc-startup-time = <40>;
> +            atmel,adc-use-external-triggers;
> +            atmel,adc-vref = <3300>;
> +            atmel,adc-use-res = "lowres";
> +
> +            trigger0 {
> +                trigger-name = "external-rising";
> +                trigger-value = <0x1>;
> +                trigger-external;
> +            };
> +
> +            trigger1 {
> +                trigger-name = "external-falling";
> +                trigger-value = <0x2>;
> +                trigger-external;
> +            };
> +
> +            trigger2 {
> +                trigger-name = "external-any";
> +                trigger-value = <0x3>;
> +                trigger-external;
> +            };
> +
> +            trigger3 {
> +                trigger-name = "continuous";
> +                trigger-value = <0x6>;
> +            };
> +        };
> +    };
> +...

