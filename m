Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133AC3CC3C7
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhGQOWX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 10:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhGQOWX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 10:22:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A041613BA;
        Sat, 17 Jul 2021 14:19:24 +0000 (UTC)
Date:   Sat, 17 Jul 2021 15:21:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Message-ID: <20210717152147.01f0cae9@jic23-huawei>
In-Reply-To: <20210716114210.141560-2-antoniu.miclaus@analog.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
        <20210716114210.141560-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Jul 2021 14:42:10 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADRF6780 Upconverter.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

oops. Would have ideally gotten to taking a close look at this before v6 :(  
Sorry about that!  I don't suppose we have any other reviewers whose knowledge of
this sort of hardware is fresher and deeper than mine?  I'd like more eyes on
the next version of this if possible!

Jonathan

> ---
> no changes in v6
>  .../bindings/iio/frequency/adi,adrf6780.yaml  | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> new file mode 100644
> index 000000000000..65cb3bee4aca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adrf6780.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADRF6780 Microwave Upconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave upconverter optimized for point to point microwave
> +   radio designs operating in the 5.9 GHz to 23.6 GHz frequency range.
> +
> +   https://www.analog.com/en/products/adrf6780.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adrf6780
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
> +  adi,vga-buff-en:
> +    description:
> +      VGA Buffer Enable.

Ideally I'd like any acronyms spelt out in the descriptions.
(I assume this is variable gain amplifier?) The fun question from looking at
this in the datasheet is where is it in the functional diagram?  I'm not actually
sure where it might be.  Perhaps in the VVA, so on the VAAT input?

If you have a convenient path to point out to your datasheet people that it is
undocumented, that might be good to clean up :)
My guess is this is needed if the precision reference on the example circuit needs
a high impedance input, but I'm only guessing.


> +    type: boolean
> +
> +  adi,lo-buff-en:
> +    description:
> +      LO Buffer Enable.

What is LO and why might it need a buffer? (or is it always a good idea to turn this on
when using the device?)

> +    type: boolean
> +
> +  adi,if-mode-en:
> +    description:
> +      IF Mode Enable.
IF stands for what? Intermediate Frequency...

> +    type: boolean
> +
> +  adi,iq-mode-en:
> +    description:
> +      IQ Mode Enable.
> +    type: boolean

I struggled to figure this out from the datasheet, but is there a circumstance under which
if and iq mode might both be enabled? Nothing stops you setting the registers that way, but
it seems to be documented as one or the other...

For that matter, why probably want to describe this as "baseband IQ mode" given datasheet
refers to as baseband in most places other than the register definition.

> +
> +  adi,lo-x2-en:
> +    description:
> +      LO x2 Enable.
> +    type: boolean
> +
> +  adi,lo-ppf-en:
> +    description:
> +      LO x1 Enable.

This is curious. I agree that the register write documents it as x1 enable, but it seems
to be be enabling polyphase filters - what exactly their relationship is to x1 is not that
clear to me.  Perhaps one to query with the hardware people if possible!

> +    type: boolean
> +
> +  adi,lo-en:
> +    description:
> +      LO Enable.
> +    type: boolean

Would you ever have this off whilst running?  It's possible I'm missing something, but
I think you need that frequency path to be enabled to get anything at all to
happen.

> +
> +  adi,uc-bias-en:
> +    description:
> +      UC Bias Enable.
> +    type: boolean

This being completely undocumented apart from the register setting, I have 0 idea what
it actually is.   Any chance we can get some more details?

> +
> +  adi,lo-sideband:
> +    description:
> +      Switch to the Other LO Sideband.

Switch what to the other LO sideband?

> +    type: boolean
> +
> +  adi,vdet-out-en:

So my reading of the datasheet on this one didn't lead me to a completely clear answer.
Does turning this one effectively stop you using the internal ADC to measure the power
whilst exposing the signal on an external pin?

> +    description:
> +      VDET Output Select Enable.
> +    type: boolean
> +
> +  '#clock-cells':
> +    const: 0
> +
> +dependencies:
> +  adi,lo-x2-en: [ "adi,lo-en" ]
> +  adi,lo-ppf-en: [ "adi,lo-en" ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      adrf6780@0 {
> +        compatible = "adi,adrf6780";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        clocks = <&adrf6780_lo>;
> +        clock-names = "lo_in";
> +      };
> +    };
> +...

