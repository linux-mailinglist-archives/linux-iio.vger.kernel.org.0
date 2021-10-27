Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4330D43CF4C
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhJ0RDY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 13:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233416AbhJ0RDY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 13:03:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542B360FBF;
        Wed, 27 Oct 2021 17:00:57 +0000 (UTC)
Date:   Wed, 27 Oct 2021 18:05:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <20211027180522.016735f9@jic23-huawei>
In-Reply-To: <20211027092333.5270-2-antoniu.miclaus@analog.com>
References: <20211027092333.5270-1-antoniu.miclaus@analog.com>
        <20211027092333.5270-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 Oct 2021 12:23:33 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADMV1013 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu,

There are quite a few properties in here that don't feel to me
like they should be in the device tree.  However, I don't know that
much about this type of device, so perhaps they just need more
documentation to reflect how they are describing characteristics
of the circuits around the device rather than runtime decisions...

Jonathan

> ---
> no changes in v2.
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> new file mode 100644
> index 000000000000..7c22202e1ffd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv1013.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV1013 Microwave Upconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave upconverter optimized for point to point microwave
> +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> +
> +   https://www.analog.com/en/products/admv1013.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv1013
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    description:
> +      Definition of the external clock.
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  vcm-supply:
> +    description:
> +      Analog voltage regulator.
> +
> +  adi,vga-pd:
> +    description:
This lot all sound like things we should be adjusting at runtime
as a matter of policy rather than setting in device tree. 

If not, how are they related to how the device is wired up?

> +      Power Down the Voltage Gain Amplifier Circuit.
> +    type: boolean
> +
> +  adi,mixer-pd:
> +    description:
> +      Power Down the Mixer Circuit.
> +    type: boolean
> +
> +  adi,quad-pd:
> +    description:
> +      Power Down the Quadrupler.

pd is not clear, if we do want these in dt then spell it out

> +    type: boolean
> +
> +  adi,bg-pd:
> +    description:
> +      Power Down the Transmitter Band Gap.
> +    type: boolean
> +
> +  adi,mixer-if-en:
> +    description:
> +      Enable the Intermediate Frequency Mode.
> +    type: boolean
> +
> +  adi,det-en:
> +    description:
> +      Enable the Envelope Detector.
> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [6, 9, 12]

Why these values?  The description sounds boolean...

> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vcm-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv1013@0{
> +        compatible = "adi,admv1013";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        clocks = <&admv1013_lo>;
> +        clock-names = "lo_in";
> +        vcm-supply = <&vcm>;
> +        adi,quad-se-mode = <12>;
> +        adi,mixer-if-en;
> +        adi,det-en;
> +      };
> +    };
> +...

