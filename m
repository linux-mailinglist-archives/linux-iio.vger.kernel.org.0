Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA3174D14
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCAMHp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 07:07:45 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60354 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgCAMHp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 07:07:45 -0500
Received: from p508fc8e5.dip0.t-ipconnect.de ([80.143.200.229] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8NNf-0006xB-Fx; Sun, 01 Mar 2020 13:07:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: input: Add docs for ADC driven joystick.
Date:   Sun, 01 Mar 2020 13:07:34 +0100
Message-ID: <1918609.63UDFxFJt6@phil>
In-Reply-To: <20200126161236.63631-4-contact@artur-rojek.eu>
References: <20200126161236.63631-1-contact@artur-rojek.eu> <20200126161236.63631-4-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Am Sonntag, 26. Januar 2020, 17:12:35 CET schrieb Artur Rojek:
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>

this seems to be stuck for a month now.
And it would be really cool to get this landed, as the Odroid Go Advance
also profits a lot from it ;-)

As for the reported syntax error due to the missing header, maybe you
can just replace the constants in the example with numbers, as they don't
really matter for the example anyway - maybe that will make everyone
happy ;-) .

E.g. on the Go Advance the joystick is just connected to two generic
saradc channels.


Thanks
Heiko

> ---
> 
>  Changes:
> 
>  v2: - Add `reg` property to axis subnode in order to enumerate the axes,
>      - rename `linux,abs-code` property to `linux,code`,
>      - drop `linux,` prefix from the remaining properties of axis subnode
> 
>  .../bindings/input/adc-joystick.yaml          | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> new file mode 100644
> index 000000000000..91fc87dcbddb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019-2020 Artur Rojek
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/bindings/input/adc-joystick.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: ADC attached joystick
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +
> +description: |
> +  Bindings for joystick devices connected to ADC controllers supporting
> +  the Industrial I/O subsystem.
> +
> +properties:
> +  compatible:
> +    const: adc-joystick
> +
> +  io-channels:
> +    description: |
> +      List of phandle and IIO specifier pairs.
> +      Each pair defines one ADC channel to which a joystick axis is connected.
> +      See Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^axis@([0-9])$":
> +    type: object
> +    description: |
> +      Represents a joystick axis bound to the given ADC channel.
> +      For each entry in the io-channels list, one axis subnode with a matching
> +      reg property must be specified.
> +
> +    properties:
> +      reg:
> +        items:
> +          description: Index of an io-channels list entry bound to this axis.
> +
> +      linux,code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: EV_ABS specific event code generated by the axis.
> +
> +      abs-range:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          - description: minimum value
> +          - description: maximum value
> +        description: |
> +          Minimum and maximum values produced by the axis.
> +          For an ABS_X axis this will be the left-most and right-most
> +          inclination of the joystick. If min > max, it is left to userspace to
> +          treat the axis as inverted.
> +          This property is interpreted as two signed 32 bit values.
> +
> +      abs-fuzz:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Amount of noise in the input value.
> +          Omitting this property indicates the axis is precise.
> +
> +      abs-flat:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Axial "deadzone", or area around the center position, where the axis
> +          is considered to be at rest.
> +          Omitting this property indicates the axis always returns to exactly
> +          the center position.
> +
> +    required:
> +      - reg
> +      - linux,code
> +      - abs-range
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/ingenic,adc.h>
> +    #include <dt-bindings/input/input.h>
> +
> +    joystick: adc-joystick {
> +      compatible = "adc-joystick";
> +      io-channels = <&adc INGENIC_ADC_TOUCH_XP>,
> +                    <&adc INGENIC_ADC_TOUCH_YP>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      axis@0 {
> +              reg = <0>;
> +              linux,code = <ABS_X>;
> +              abs-range = <3300 0>;
> +              abs-fuzz = <4>;
> +              abs-flat = <200>;
> +      };
> +      axis@1 {
> +              reg = <1>;
> +              linux,code = <ABS_Y>;
> +              abs-range = <0 3300>;
> +              abs-fuzz = <4>;
> +              abs-flat = <200>;
> +      };
> +    };
> 




