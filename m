Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F7A35B549
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhDKNrE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 09:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236245AbhDKNqK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 09:46:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C655061027;
        Sun, 11 Apr 2021 13:45:52 +0000 (UTC)
Date:   Sun, 11 Apr 2021 14:46:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: staging: iio: cdc: ad7746: add binding
 documentation for AD7746
Message-ID: <20210411144613.249c4d2f@jic23-huawei>
In-Reply-To: <4be8e3e40794474d8622192c6a5ea0fb4af527e1.1617993776.git.lucas.p.stankus@gmail.com>
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
        <4be8e3e40794474d8622192c6a5ea0fb4af527e1.1617993776.git.lucas.p.stankus@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Apr 2021 15:50:10 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> Add device tree binding documentation for AD7746 cdc in YAML format.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>

Hi Lucas,

Good to see progress on this one after all these years :)

I think we can do a bit better though by making the attributes
easy to comprehend without needing to refer to the documentation.
Always good to avoid magic numbers if we can.

Suggestions inline.

Jonathan

> ---
>  .../bindings/iio/cdc/adi,ad7746.yaml          | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> new file mode 100644
> index 000000000000..5de86f4374e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/cdc/adi,ad7746.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
> +
> +  Specifications about the part can be found at:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7745
> +      - adi,ad7746
> +      - adi,ad7747
> +
> +  reg:
> +    description: |
> +      Physiscal address of the EXC set-up register.

reg in this case would be the i2c address.

> +    maxItems: 1
> +
> +  adi,excitation-voltage-level:

This isn't a level as such, it's a scale factor, or something like
that and the naming should reflect that + the values
should be real in some sense (multipliers so
perhaps something like adi,excitation-vdd-milicent ?
schema/property-units.yaml includes -percent but that doesn't
have enough precision.

enum [125, 250, 375, 500] 

> +    description: |
> +      Select the reference excitation voltage level used by the device.
> +      With VDD being the power supply voltage, valid values are:
> +      0: +-VDD / 8
> +      1: +-VDD / 4
> +      2: +-VDD * 3 / 8
> +      3: +-VDD / 2
> +      If left empty option 3 is selected.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  adi,exca-output:
> +    description: |
> +      Sets the excitation output in the exca pin.
> +      Valid values are:
> +      0: Disables output in the EXCA pin.
> +      1: Enables EXCA pin as the excitation output.
> +      2: Enables EXCA pin as the inverted excitation output.

Hmm. Various ways we could do this and avoid the need for
a enum representing several different things.  Perhaps

adi,exa-output-en
adi,exa-output-invert

(appropriate checks so we can only have invert of the channel
is enabled as otherwise it is less than meaningful)

> +      If left empty the output is disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +  adi,excb-output:
> +    description: |
> +      Analoguos to the adi,exca-output for the EXCB pin.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ad7746: cdc@0 {
> +        compatible = "adi,ad7746";
> +        reg = <0>;

That's very unlikely as an i2c address.

> +        adi,excitation-voltage-level = <3>;
> +        adi,exca-output = <0>;
> +        adi,excb-output = <0>;
> +      };
> +    };
> +...

