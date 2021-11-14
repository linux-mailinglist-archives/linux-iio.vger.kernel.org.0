Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E140044F8CF
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhKNPss (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 10:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236073AbhKNPsn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 10:48:43 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E9560E94;
        Sun, 14 Nov 2021 15:45:46 +0000 (UTC)
Date:   Sun, 14 Nov 2021 15:50:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <20211114155033.52056f69@jic23-huawei>
In-Reply-To: <20211105112930.122017-3-antoniu.miclaus@analog.com>
References: <20211105112930.122017-1-antoniu.miclaus@analog.com>
        <20211105112930.122017-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Nov 2021 13:29:29 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADMV1013 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

My high frequency theory etc is rather rusty being nearly 20 years since I last
looked at this stuff so I may have some interpretations below wrong...

My main concern here is that most of the powerdown entries prevent the device
doing anything useful so as far as I can tell would make no sense to ever set.

Jonathan

> ---
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> new file mode 100644
> index 000000000000..47993253a586
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> @@ -0,0 +1,119 @@
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

I mention elsewhere that this isn't exactly a clock in the normal sense
given we are modulating a signal onto it's frequency multiplied form but
meh I guess it might be fed by something looking clock like...

> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +
> +  clock-output-names:
> +    maxItems: 1

Does it actually make sense to handle the output as a clock? It has a multiple
GHz bandwidth.

> +
> +  vcm-supply:
> +    description:
> +      Analog voltage regulator.

> +
> +  adi,vga-powerdown:
> +    description:
> +      Power Down the Voltage Gain Amplifier Circuit available at
> +      BG_RBIAS2 pin.

Is that all it does?  Datasheet is a bit vague, but I'm guessing this
also leaves the device not doing anything useful so makes little sense
to expose.

> +    type: boolean
> +
> +  adi,mixer-powerdown:
> +    description:
> +      Power Down the Mixer Circuit. Enable to put the block in
> +      a power down state.
As below. Device doesn't do anything useful with the mixer disabled
so I don't think this is something for DT.
> +    type: boolean
> +
> +  adi,quad-powerdown:
> +    description:
> +      Power Down the Quadrupler. Enable to put the block in
> +      a power down state.

I'm struggling a bit with the affect of this when reading the datasheet, but
I think it means the device is pointless as we have no LO signal and hence no
output.  Hence I don't think we should have this in DT.

> +    type: boolean
> +
> +  adi,bg-powerdown:
> +    description:
> +      Power Down the Transmitter Band Gap. Enable to put the part in
> +      a power down state.
> +    type: boolean
Another one where I think disabling it in DT makes the device pointless.
These are absolutely things you might want to wire up in power management
callbacks, but not have in DT.

> +
> +  adi,mixer-if-enable:
> +    description:
> +      Enable the Intermediate Frequency Mode. Either IF Mode or I/Q Mode
> +      can be enabled at a time.
How do we enable IQ mode?   Is this better described as a choice of mode?
IQ vs IF?  If so make it an appropriate enum rather than this which kind
of suggests it's enabling the mixer which is not hte case.

> +    type: boolean
> +
> +  adi,detector-enable:
> +    description:
> +      Enable the Envelope Detector available at output pins VENV_P and
> +      VENV_N. Disable to reduce power consumption.

So the reason you'd turn this off is it isn't wired to anything.  What might
it be wired to?  My guess is it would be to an ADC, probably also wired to the
host processor?   If so this should be represented as a consumer node of the
ADC so that we can provide the envelope reading if it is wired up.  If it is
not wired up then we turn it off.

> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +      Set value 6 for Single-Ended Mode, Negative Side Disabled.
> +      Set value 9 for Single-Ended Mode, Positive Side Disabled.
> +      Set value 12 for Differential Mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [6, 9, 12]

Datasheet is rather unclear on this to my mind.  From the point of view
of how it is used it is about the LO inputs, not the quadrupler at all,
that just happens to be the first unit to care about this.
I'm also not keen on magic numbers where they can be avoided and these
are particularly 'magic'.

So maybe
adi,local-oscilator-mode
enum [diff, se-pos, se-neg] 

?
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
> +        adi,mixer-if-enable;
> +        adi,detector-enable;
> +      };
> +    };
> +...

