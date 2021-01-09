Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28CA2F0386
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 21:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAIUku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 15:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbhAIUku (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 15:40:50 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E8123B01;
        Sat,  9 Jan 2021 20:40:07 +0000 (UTC)
Date:   Sat, 9 Jan 2021 20:40:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] bindings: iio: adc: Add documentation for
 ADS131E0x ADC driver
Message-ID: <20210109204002.5d3c3ff2@archlinux>
In-Reply-To: <20210105110839.5436-3-tomislav.denis@avl.com>
References: <20210105110839.5436-1-tomislav.denis@avl.com>
        <20210105110839.5436-3-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Jan 2021 12:08:39 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> Add a device tree binding documentation for Texas Instruments
> ADS131E0x ADC family driver.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>

One trivial thing inline.  If that is all that comes up I can fix
whilst applying.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 181 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> new file mode 100644
> index 0000000..c84eadd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> @@ -0,0 +1,181 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads131e08.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS131E0x 4-, 6- and 8-Channel ADCs
> +
> +maintainers:
> +  - Tomislav Denis <tomislav.denis@avl.com>
> +
> +description: |
> +  The ADS131E0x are a family of multichannel, simultaneous sampling,
> +  24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
> +  built-in programmable gain amplifier (PGA), internal reference
> +  and an onboard oscillator.
> +  The communication with ADC chip is via the SPI bus (mode 1).
> +
> +  https://www.ti.com/lit/ds/symlink/ads131e08.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads131e04
> +      - ti,ads131e06
> +      - ti,ads131e08
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  spi-cpha: true
> +
> +  clocks:
> +    description: |
> +      Device tree identifier to the clock source (2.048 MHz).
> +      Note: clock source is selected using CLKSEL pin.
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: adc-clk
> +
> +  interrupts:
> +    description: |
> +      IRQ line for the ADC data ready.
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: |
> +      Optional external voltage reference. If not supplied, internal voltage
> +      reference is used.
> +
> +  ti,vref-internal:
> +    description: |
> +      Select the internal voltage reference value.
> +      0: 2.4V
> +      1: 4.0V
> +      If this field is left empty, 2.4V is selected.
> +      Note: internal voltage reference is used only if vref-supply is not supplied.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    default: 0
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +patternProperties:
> +  "^channel@([0-7])$":
> +    $ref: "adc.yaml"
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +          Up to 4 channels, numbered from 0 to 3 for ti,ads131e04.
> +          Up to 6 channels, numbered from 0 to 5 for ti,ads131e06.
> +          Up to 8 channels, numbered from 0 to 7 for ti,ads131e08.
> +        items:
> +          minimum: 0
> +          maximum: 8

7?

> +
> +      ti,gain:
> +        description: |
> +          The PGA gain value for the channel.
> +          If this field is left empty, PGA gain 1 is used.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [1, 2, 4, 8, 12]
> +        default: 1
> +
> +      ti,mux:
> +        description: |
> +          Channel input selection(muliplexer).
> +          0: Normal input.
> +          1: Input shorted to (VREFP + VREFN) / 2 (for offset or noise measurements).
> +          3: MVDD (for supply measurement)
> +          4: Temperature sensor
> +          If this field is left empty, normal input is selected.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 3, 4]
> +        default: 0
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +        compatible = "ti,ads131e08";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        spi-cpha;
> +        clocks = <&clk2048k>;
> +        clock-names = "adc-clk";
> +        interrupt-parent = <&gpio5>;
> +        interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
> +        vref-supply = <&adc_vref>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +          reg = <0>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +          ti,gain = <2>;
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +        };
> +
> +        channel@4 {
> +          reg = <4>;
> +        };
> +
> +        channel@5 {
> +          reg = <5>;
> +        };
> +
> +        channel@6 {
> +          reg = <6>;
> +        };
> +
> +        channel@7 {
> +          reg = <7>;
> +          ti,mux = <4>;
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 167aabf..f6c5e47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17371,6 +17371,7 @@ TI ADS131E0X ADC SERIES DRIVER
>  M:	Tomislav Denis <tomislav.denis@avl.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
>  F:	drivers/iio/adc/ti-ads131e08.c
>  
>  TI AM437X VPFE DRIVER

