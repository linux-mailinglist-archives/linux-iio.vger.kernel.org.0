Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF914281F8
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhJJOq4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 10:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231990AbhJJOqx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Oct 2021 10:46:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A355D6109E;
        Sun, 10 Oct 2021 14:44:52 +0000 (UTC)
Date:   Sun, 10 Oct 2021 15:48:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Message-ID: <20211010154856.29f4fd11@jic23-huawei>
In-Reply-To: <20211008123909.1901-2-mihail.chindris@analog.com>
References: <20211008123909.1901-1-mihail.chindris@analog.com>
        <20211008123909.1901-2-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Oct 2021 12:39:08 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> Add documentation for ad3552r
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
Hi Mihael,

A few comments inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/dac/adi,ad3552r.yaml         | 199 ++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> new file mode 100644
> index 000000000000..1086e935d330
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -0,0 +1,199 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD2552R DAC device driver
> +
> +maintainers:
> +  - Mihail Chindris <mihail.chindris@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD3552R  DAC device. Datasheet can be

Extra space before DAC, and doesn't mention the other supported part.
One option to avoid a never ending list is "and similar."

> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf

Good to have datasheet for the other part as well as I don't think this is a shared
datasheet?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad3552r
> +      - adi,ad3542r

Alphabetical order preferred.

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 30000000
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description: |
> +      If a LDAC gpio is specified it will generate a LDAC pulse each time the
> +      trigger handler sends data to the chip.

Trigger handler is a linux concept. You need to write this more generically.
Something like.

"LDAC pin is used as a hardware trigger to update a set of DACs."


> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      The regulator to use as an external reference. If it does not exists the
> +      internal reference will be used. External reference must be 2.5V
> +
> +  adi,vref-out-en:
> +    description: Vref I/O driven by internal vref to 2.5V. If not set, Vref pin
> +      will be floating.
> +    type: boolean
> +
> +  adi,sdo-drive-strength:
> +    description: |
> +      Configure SDIO0 and SDIO1 strength levels:
> +        - 0: low SDO drive strength.
> +        - 1: medium low SDO drive strength.
> +        - 2: medium high SDO drive strength.
> +        - 3: high SDO drive strength
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +patternProperties:
> +  "^channel@([0-1])$":
> +    type: object
> +    description: Configurations of the DAC Channels
> +    properties:
> +      reg:
> +          description: Channel number
> +          enum: [0, 1]
> +
> +      custom-output-range-config:

Not a generic property so I think this needs an adi prefix.

> +        type: object
> +        description: Configuration of custom range when
> +          adi,output-range-microvolt is not present.
> +          The formulas for calculation the output voltages are
> +            Vout_fs = 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.03]
> +            Vout_zs = 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.03]
> +        properties:
> +          adi,gain-offset:
> +            description: Gain offset used in the above formula
> +            $ref: /schemas/types.yaml#/definitions/int32
> +            maximum: 511
> +            minimum: -511
> +          adi,gain-scaling-p:
> +            description: |
> +              Scaling p:
> +               0: 1.0
> +               1: 0.5
> +               2: 0.25
> +               3: 0.125

Given this is just a mapping to a simple set of values, could we just have
the values or express it as 1/(2^GainP) in the equation above and call it
adi,gain-scalling-inv-log2 or something like that?

If we can avoid a mapping table that is always a nice to have


> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +          adi,gain-scaling-n:
> +            description: |
> +              Scaling p:
> +               0: 1.0
> +               1: 0.5
> +               2: 0.25
> +               3: 0.125
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +          adi,rfb-ohms:
> +            description: Feedback Resistor
> +        required:
> +          - adi,gain-offset
> +          - adi,gain-sacling-p
> +          - adi,gain-sacling-n
> +          - adi,rfb-ohms
> +    required:
> +      - reg
> +
> +    oneOf:
> +      # If adi,output-range is missing, custom-output-range-config must be used

adi,output-range-microvolt is missing...

> +      - required:
> +        - adi,output-range-microvolt
> +      - required:
> +        - custom-output-range-config
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad3542r
> +    then:
> +      patternProperties:
> +        "^channel@([0-1])$":
> +          type: object
> +          properties:
> +            adi,output-range-microvolt:
> +              description: |
> +                Voltage output range of the channel as <minimum, maximum>
> +                Required connections:
> +                  Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
> +                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
> +              oneOf:
> +                - items:
> +                    - const: 0
> +                    - enum: [2500000, 3000000, 5000000, 10000000]
> +                - items:
> +                    - const: -2500000
> +                    - const: 7500000
> +                - items:
> +                    - const: -5000000
> +                    - const: 5000000
> +          required:
> +            - adi,output-range-microvolt
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad3552r
> +    then:
> +      patternProperties:
> +        "^channel@([0-1])$":
> +          type: object
> +          properties:
> +            adi,output-range-microvolt: |
> +                Voltage output range of the channel as <minimum, maximum>
> +                Required connections:
> +                  Rfb1x for: 0 to 2.5 V; 0 to 5 V;
> +                  Rfb2x for: 0 to 10 V; -5 to 5 V;
> +                  Rfb4x for: -10 to 10V
> +              oneOf:
> +                - items:
> +                    - const: 0
> +                    - enum: [2500000, 5000000, 10000000]
> +                - items:
> +                    - const: -5000000
> +                    - const: 5000000
> +                - items:
> +                    - const: -10000000
> +                    - const: 10000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ad3552r {
> +            compatible = "adi,ad3552r";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            channel@0 {
> +                    reg = <0>;
> +                    adi,output-range-microvolt = <0 10000000>;
> +            };
> +            channel@1 {
> +                    reg = <1>;
> +                    custom-output-range-config {
> +                            adi,gain-offset = <5>;
> +                            adi,gain-scaling-p = <1>;
> +                            adi,gain-scaling-n = <2>;
> +                            adi,rfb-ohms = <1>;
> +                    };
> +          };
> +      };
> +...

