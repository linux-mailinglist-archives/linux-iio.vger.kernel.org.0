Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594062C7519
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbgK1Vt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732347AbgK1S7u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:59:50 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 796AF22242;
        Sat, 28 Nov 2020 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606566862;
        bh=UY0UQDCHmQeVnKnM15GpLKvUWPojFD/NVJmBuCerxhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dMeWEcRNuUmsVnNsy1YyY0EDMEwBPKnj1XJw3x3zcZ18uxUkv9OOq2Sf7AVQxOaJX
         nKbrMg026CSJaFt+TyjIOhO216jTzrIEcYqOgkUphESaqeuWidECSX7GvC6HpPKFhI
         uFS1c8X8om3SLVA9VNANpb+62VbG5pxNBVG/84vM=
Date:   Sat, 28 Nov 2020 12:34:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] bindings: iio: adc: Add documentation for ADS131E0x
 ADC driver
Message-ID: <20201128123417.7259ef13@archlinux>
In-Reply-To: <20201127194240.15060-3-tomislav.denis@avl.com>
References: <20201127194240.15060-1-tomislav.denis@avl.com>
        <20201127194240.15060-3-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Nov 2020 20:42:40 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> Add a device tree binding documentation for Texas Instruments
> ADS131E0x ADC family driver.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
Hi Tomislav,

A few comments inline.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 145 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> new file mode 100644
> index 0000000..92da193
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads131e08.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS131E0x 4-, 6-, and 8-Channel ADCs

Not currently supporting 6 channel variants?

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
> +      - ti,ads131e08
> +
> +  reg:
> +    description: |
> +      SPI chip select number

That is entirely standard so no real need to put a description of
reg for an spi device.

> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  clocks:
> +    description: |
> +      Device tree identifier to the clock source (2.048 MHz)
> +      Note: clock source is selected using CLKSEL pin
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: adc-clk
> +
> +  interrupts:
> +    description: |
> +      IRQ line for the ADC data ready
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: |
> +      Optional external voltage reference. Has to be supplied, if
> +      ti,vref-sel equals 2
> +
> +  ti,vref-sel:
> +    description: |
> +      Select the voltage reference source
> +      Valid values are:
> +      0: Internal reference 2.4V
> +      1: Internal reference 4V
> +      2: External reference source (vref-supply is required)

With optional external references we normally just use their presense
to indicate that they should be used.

You'll still need a parameter to pick the internal reference though.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 0
> +
> +  ti,datarate:
> +    description: |
> +      ADC data rate in kSPS
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64]
> +    default: 1

Why is this a devicetree element rather than runtime controllable?

> +
> +  ti,gain:
> +    description: |
> +      The gain value for the PGA function
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 12]
> +    default: 1

Isn't this per channel?  Also this explanation should mention
why it is a board related characteristic rather than a runtime
tuneable (I'm fine with having it here, but good to add a bit
of info on that to the description).

> +
> +  ti,adc-channels:
> +    description: |
> +      List of single-ended channels muxed for this ADC
> +      - 4 channels, numbered from 0 to 3 for ti,ads131e04
> +      - 8 channels, numbered from 0 to 7 for ti,ads131e08
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

We've fairly recently introduced a generic adc channel binding that I'd prefer
is used in drivers going forwards.

See Documentation/device-tree/bindings/iio/adc.txt (or yaml if I've applied that
patch before you get to this).

That adds a subnode per channel and gives us an easy way to then provide
per channel parameters.  It's heavier weight than what you have here, but
much more flexible.

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - ti,adc-channels
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads131e04
> +
> +  - then:
> +      properties:
> +        ti,adc-channels:
> +          minItems: 1
> +          maxItems: 4
> +          items:
> +            minimum: 0
> +            maximum: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads131e08
> +
> +  - then:
> +      properties:
> +        ti,adc-channels:
> +          minItems: 1
> +          maxItems: 8
> +          items:
> +            minimum: 0
> +            maximum: 7
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spidev@0 {
> +      compatible = "ti,ads131e08";
> +      reg = <0>;
> +      spi-max-frequency = <1000000>;
> +      spi-cpha;
> +      clocks = <&clk2048k>;
> +      clock-names = "adc-clk";
> +      interrupt-parent = <&gpio5>;
> +      interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
> +      vref-supply = <&vref_reg>;
> +      ti,vref-sel = <2>;
> +      ti,datarate = <1>;
> +      ti,gain = <1>;
> +      ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28bc5f9..0c351c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17224,6 +17224,7 @@ TI ADS131E0X ADC SERIES DRIVER
>  M:	Tomislav Denis <tomislav.denis@avl.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
>  F:	drivers/iio/adc/ti-ads131e08.c
>  
>  TI AM437X VPFE DRIVER

