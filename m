Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BC2457F62
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 17:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhKTQNQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 11:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhKTQNQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 11:13:16 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BCD160EBC;
        Sat, 20 Nov 2021 16:10:11 +0000 (UTC)
Date:   Sat, 20 Nov 2021 16:15:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Message-ID: <20211120161504.6923f718@jic23-huawei>
In-Reply-To: <20211119114011.75406-1-cristian.pop@analog.com>
References: <20211119114011.75406-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Nov 2021 13:40:10 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> new file mode 100644
> index 000000000000..69f1b4a41c5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv4420.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV4420 K Band Downconverter
> +
> +maintainers:
> +- Cristian Pop <cristian.pop@analog.com>

Rob's scripted checks picked this up so I'll assume you'll add the 2 spaces.

> +
> +description: |
> +    The ADMV4420 is a highly integrated, double balanced, active
> +    mixer with an integrated fractional-N synthesizer, ideally suited
> +    for next generation K band satellite communications
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv4420
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  adi,ref_single_ended:

- rather than _ through out.

I 'think' this picking between a crystal and a clock.  We have other parts
doing this and IIRC one approach to handling this was to have an optional clock
source. If it isn't provided we know this is a crystal and can pick on that basis.
example is adc/microchip/mcp3911.yaml



> +    description: Reference clock type.
> +    type: boolean
> +
> +  adi,ref_freq_hz:
> +    description: Reference clock frequency.
> +    $ref: /schemas/types.yaml#/definitions/uint32

with -hz this will be covered by standard units suffixes so 
you won't need the $ref.

I'm curious on this. Datasheet seems to say the only valid frequency for
this is 50MHz either from a crystal or a reference clock.


> +
> +  adi,ref_doubler_en:
> +    description: Reference multiplied by 2.
> +    type: boolean
> +
> +  adi,ref_divide_by_2_en:
> +    description: Reference divided by 2.
> +    type: boolean
> +
> +  adi,ref_divider:
> +    description: Reference divider value.
> +    $ref: /schemas/types.yaml#/definitions/uint32

This lot correspond to clock signal doubling/ halving and
count based division.  Can we lift something standard from the
clk dt-bindings to describe this?

> +
> +  adi,N_counter_int_val:
> +    description: N counted int val.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  adi,N_counter_frac_val:
> +    description: N counted frac val.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  adi,N_counter_mod_val:
> +    description: N counted mod val.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Sigh, my 20 year old memories of demodulation aren't coming back enough to
remember enough to describe these clearly - but we definitely need more information
here and I'm not sure these are things that should be in dt at all..

Are they characteristics of the wiring, or more closely related to what the input
is we are down converting?  All this stuff is about generating a very precise tuned
frequency given the PLL filter that we have no visibility of (and lets not try 
to describe that in the binding as that would be a nightmark).

So honestly I have no idea how to describe this.  Maybe more info would help?

> +
> +  adi,mux_sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 4, 5, 8]
> +    description: |
> +      Multiplexer output allows access to various internal signals:
> +      0: Output Logic Low
> +      1: Digital Lock Detect
> +      4: RDiv-by-2 to Mux Out, Frequency = REFIN/(2 x R)
> +      5: NDiv-by-2 to Mux Out, Frequency = VCO/(2 x N)
> +      8: Output Logic High.

Hmm. So low and high are just using this as a gpio.  We 'could' support that
but I'd be highly surprised if that is ever used except for circuit debug so
I'd just drop those.

The digital lock is probably something that could be optionally wired to a gpio
to allow detection of lock.

The two frequency signals are probably for debug, but those might make sense
to describe in this fashion in DT.  I'd be tempted to not bother though as I'm not
sure what use they would be except during circuit debug.

So I'd just support the lock detect as an optional gpio connected signal.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv4420@0 {
> +        compatible = "adi,admv4420";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +
> +        /* reference block config */
> +        adi,ref_freq_hz = <50000000>;
> +        adi,ref_single_ended = <0>;

Rob's scripts point out this isn't a boolean value.

> +        adi,ref_divider = <1>;
> +
> +        /* N counter config*/
> +        adi,N_counter_int_val = <0xA7>;
> +        adi,N_counter_frac_val = <0x02>;
> +        adi,N_counter_mod_val = <0x04>;
> +
> +        adi,mux_sel = <1>;
> +      };
> +    };
> +...

