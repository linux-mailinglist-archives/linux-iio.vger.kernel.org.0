Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4944F439
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 17:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhKMQ4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 11:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234568AbhKMQ4K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 11:56:10 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5626660FDA;
        Sat, 13 Nov 2021 16:53:15 +0000 (UTC)
Date:   Sat, 13 Nov 2021 16:58:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: add AD74413R
Message-ID: <20211113165801.02fec399@jic23-huawei>
In-Reply-To: <20211105143550.1783528-3-demonsingur@gmail.com>
References: <20211105143550.1783528-1-demonsingur@gmail.com>
        <20211105143550.1783528-3-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  5 Nov 2021 16:35:49 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> Add device tree bindings for AD74413R.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Hi Cosmin,

Other than the unnecessary $ref that Rob's scripts already pointed out
this looks good to me.

Thanks,

Jonathan


> ---
>  .../bindings/iio/addac/adi,ad74413r.yaml      | 153 ++++++++++++++++++
>  include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> new file mode 100644
> index 000000000000..a1add5a2bce2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/addac/adi,ad74413r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD74413R/AD74412R device
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +
> +description: |
> +  The AD74413R and AD74412R are quad-channel software configurable input/output
> +  solutions for building and process control applications. They contain
> +  functionality for analog output, analog input, digital input, resistance
> +  temperature detector, and thermocouple measurements integrated
> +  into a single chip solution with an SPI interface.
> +  The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
> +  four configurable input/output channels and a suite of diagnostic functions.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad74412r
> +      - adi,ad74413r
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  spi-cpol: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  refin-supply: true
> +
> +  adi,rsense-resistance-ohms:
> +    $ref: /schemas/types.yaml#/definitions/uint32

As Rob's scripts pointed out: Now you have the ending specifying the units
there is not need to also have $ref.  The dt-schema special cases a bunch of
unit types for us.

> +    description:
> +      RSense resistance values in Ohms.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +  - refin-supply
> +  - adi,rsense-resistance-ohm
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    type: object
> +    description: Represents the external channels which are connected to the device.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 4 channels numbered from 0 to 3.
> +        minimum: 0
> +        maximum: 3
> +
> +      adi,ch-func:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Channel function.
> +          HART functions are not supported on AD74412R.
> +          0 - CH_FUNC_HIGH_IMPEDANCE
> +          1 - CH_FUNC_VOLTAGE_OUTPUT
> +          2 - CH_FUNC_CURRENT_OUTPUT
> +          3 - CH_FUNC_VOLTAGE_INPUT
> +          4 - CH_FUNC_CURRENT_INPUT_EXT_POWER
> +          5 - CH_FUNC_CURRENT_INPUT_LOOP_POWER
> +          6 - CH_FUNC_RESISTANCE_INPUT
> +          7 - CH_FUNC_DIGITAL_INPUT_LOGIC
> +          8 - CH_FUNC_DIGITAL_INPUT_LOOP_POWER
> +          9 - CH_FUNC_CURRENT_INPUT_EXT_POWER_HART
> +          10 - CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
> +        minimum: 0
> +        maximum: 10
> +        default: 0
> +
> +      adi,gpo-comparator:
> +        type: boolean
> +        description: |
> +          Whether to configure GPO as a comparator or not.
> +          When not configured as a comparator, the GPO will be treated as an
> +          output-only GPIO.
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    spi0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
> +      status = "okay";
> +
> +      ad74413r@0 {
> +        compatible = "adi,ad74413r";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        spi-cpol;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        interrupt-parent = <&gpio>;
> +        interrupts = <26 0>;
> +
> +        refin-supply = <&ad74413r_refin>;
> +        adi,rsense-resistance-ohm = <100>;
> +
> +        channel@0 {
> +          reg = <0>;
> +
> +          adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +
> +          adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +
> +          adi,ch-func = <CH_FUNC_DIGITAL_INPUT_LOGIC>;
> +          adi,gpo-comparator;
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +
> +          adi,ch-func = <CH_FUNC_CURRENT_INPUT_EXT_POWER>;
> +        };
> +      };
> +    };
> +...
> diff --git a/include/dt-bindings/iio/addac/adi,ad74413r.h b/include/dt-bindings/iio/addac/adi,ad74413r.h
> new file mode 100644
> index 000000000000..a43b010f974f
> --- /dev/null
> +++ b/include/dt-bindings/iio/addac/adi,ad74413r.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DT_BINDINGS_ADI_AD74413R_H
> +#define _DT_BINDINGS_ADI_AD74413R_H
> +
> +#define CH_FUNC_HIGH_IMPEDANCE					0x0
> +#define CH_FUNC_VOLTAGE_OUTPUT					0x1
> +#define CH_FUNC_CURRENT_OUTPUT					0x2
> +#define CH_FUNC_VOLTAGE_INPUT					0x3
> +#define CH_FUNC_CURRENT_INPUT_EXT_POWER			0x4
> +#define CH_FUNC_CURRENT_INPUT_LOOP_POWER		0x5
> +#define CH_FUNC_RESISTANCE_INPUT				0x6
> +#define CH_FUNC_DIGITAL_INPUT_LOGIC				0x7
> +#define CH_FUNC_DIGITAL_INPUT_LOOP_POWER		0x8
> +#define CH_FUNC_CURRENT_INPUT_EXT_POWER_HART	0x9
> +#define CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART	0xA
> +
> +#define CH_FUNC_MIN		CH_FUNC_HIGH_IMPEDANCE
> +#define CH_FUNC_MAX		CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
> +
> +#endif /* _DT_BINDINGS_ADI_AD74413R_H */

