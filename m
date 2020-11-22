Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF92BC7A6
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 19:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgKVSHn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 13:07:43 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39854 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgKVSHn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 13:07:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5C6219E004E;
        Sun, 22 Nov 2020 18:07:37 +0000 (GMT)
Date:   Sun, 22 Nov 2020 18:07:36 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: Re: [PATCH 28/46] dt-bindings:iio:adc:atmel,sama5d2-adc: txt to
 yaml conversion
Message-ID: <20201122180736.48c10077@archlinux>
In-Reply-To: <20201031184854.745828-29-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-29-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 18:48:36 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Whilst this binding has a lot of elements they are all fairly standard.
> Hence pretty much direct txt to yaml line by line conversion.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
Applied with -hz and -ms $ref dropped as per Rob's suggestion.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/at91-sama5d2_adc.txt     |  50 ---------
>  .../bindings/iio/adc/atmel,sama5d2-adc.yaml   | 104 ++++++++++++++++++
>  2 files changed, 104 insertions(+), 50 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> deleted file mode 100644
> index 07c59f301b31..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* AT91 SAMA5D2 Analog to Digital Converter (ADC)
> -
> -Required properties:
> -  - compatible: Should be "atmel,sama5d2-adc" or "microchip,sam9x60-adc".
> -  - reg: Should contain ADC registers location and length.
> -  - interrupts: Should contain the IRQ line for the ADC.
> -  - clocks: phandle to device clock.
> -  - clock-names: Must be "adc_clk".
> -  - vref-supply: Supply used as reference for conversions.
> -  - vddana-supply: Supply for the adc device.
> -  - atmel,min-sample-rate-hz: Minimum sampling rate, it depends on SoC.
> -  - atmel,max-sample-rate-hz: Maximum sampling rate, it depends on SoC.
> -  - atmel,startup-time-ms: Startup time expressed in ms, it depends on SoC.
> -  - atmel,trigger-edge-type: One of possible edge types for the ADTRG hardware
> -  trigger pin. When the specific edge type is detected, the conversion will
> -  start. Possible values are rising, falling, or both.
> -  This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
> -  IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
> -
> -Optional properties:
> -  - dmas: Phandle to dma channel for the ADC.
> -  - dma-names: Must be "rx" when dmas property is being used.
> -  See ../../dma/dma.txt for details.
> -  - #io-channel-cells: in case consumer drivers are attached, this must be 1.
> -  See <Documentation/devicetree/bindings/iio/iio-bindings.txt> for details.
> -
> -Properties for consumer drivers:
> -  - Consumer drivers can be connected to this producer device, as specified
> -  in <Documentation/devicetree/bindings/iio/iio-bindings.txt>
> -  - Channels exposed are specified in:
> -  <dt-bindings/iio/adc/at91-sama5d2_adc.txt>
> -
> -Example:
> -
> -adc: adc@fc030000 {
> -	compatible = "atmel,sama5d2-adc";
> -	reg = <0xfc030000 0x100>;
> -	interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
> -	clocks = <&adc_clk>;
> -	clock-names = "adc_clk";
> -	atmel,min-sample-rate-hz = <200000>;
> -	atmel,max-sample-rate-hz = <20000000>;
> -	atmel,startup-time-ms = <4>;
> -	vddana-supply = <&vdd_3v3_lp_reg>;
> -	vref-supply = <&vdd_3v3_lp_reg>;
> -	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
> -	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
> -	dma-names = "rx";
> -	#io-channel-cells = <1>;
> -}
> diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> new file mode 100644
> index 000000000000..9b282c3ee8fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/atmel,sama5d2-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AT91 SAMA5D2 Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Ludovic Desroches <ludovic.desroches@atmel.com>
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,sama5d2-adc
> +      - microchip,sam9x60-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: adc_clk
> +
> +  vref-supply: true
> +  vddana-supply: true
> +
> +  atmel,min-sample-rate-hz:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Minimum sampling rate, it depends on SoC.
> +
> +  atmel,max-sample-rate-hz:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Maximum sampling rate, it depends on SoC.
> +
> +  atmel,startup-time-ms:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Startup time expressed in ms, it depends on SoC.
> +
> +  atmel,trigger-edge-type:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      One of possible edge types for the ADTRG hardware trigger pin.
> +      When the specific edge type is detected, the conversion will
> +      start. Should be one of IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING
> +      or IRQ_TYPE_EDGE_BOTH.
> +    enum: [1, 2, 3]
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
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
> +  - vref-supply
> +  - vddana-supply
> +  - atmel,min-sample-rate-hz
> +  - atmel,max-sample-rate-hz
> +  - atmel,startup-time-ms
> +  - atmel,trigger-edge-type
> +
> +examples:
> +  - |
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        adc@fc030000 {
> +            compatible = "atmel,sama5d2-adc";
> +            reg = <0xfc030000 0x100>;
> +            interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
> +            clocks = <&adc_clk>;
> +            clock-names = "adc_clk";
> +            atmel,min-sample-rate-hz = <200000>;
> +            atmel,max-sample-rate-hz = <20000000>;
> +            atmel,startup-time-ms = <4>;
> +            vddana-supply = <&vdd_3v3_lp_reg>;
> +            vref-supply = <&vdd_3v3_lp_reg>;
> +            atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
> +            dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
> +            dma-names = "rx";
> +            #io-channel-cells = <1>;
> +        };
> +    };
> +...

