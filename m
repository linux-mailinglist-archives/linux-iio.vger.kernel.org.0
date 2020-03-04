Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DA179591
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 17:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbgCDQoY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 11:44:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44515 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCDQoY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 11:44:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id v22so2629529otq.11;
        Wed, 04 Mar 2020 08:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xb+WTf9GeDLciLGuzbzOFdnxs2bgaxMAq58iwewkmSE=;
        b=Xx29nz8+FCROu86dxEE5FtksgKCb8RkJGQCzJQ03cgKOBzFVrpUz74/FQ80x3F71CG
         /cMr3B2AN6du10BCoRV3CZrrQTSToXGWMcnw2DuY7nASGIiRwA9gEJqqhqFs9Vty+RQD
         qxY6jlM7Vm9OQHwGQxzlYK34Nk9JBCd5FKywWSlhnCtJ9acKPIRuxKQVOrXt9y6xTFeb
         tQOyZjs+B9DMKvxzPzw+EM2y5clyQzE3+vDfwZlBSmeZAdyQzntQ1QTuHxCFJ1m5GY5p
         jIi1XvZoo22PlwNvuL1kG3W3yaNKacjbYzghdfknBqccL8DieH5pmwAcblw1WUtpcefg
         aNxA==
X-Gm-Message-State: ANhLgQ1l6GUkrTjnsx5jUVFBzmFzXI8pZ5JSfjasljLHvVSyROYcKFhP
        +ASTHKrYDCOQlVnL4mrBaHNyA9c=
X-Google-Smtp-Source: ADFU+vuiT7+LIdq6B0NAZpXtbUdD2n1oG/8PxkA2cyOy3nnwJtiJJ8AQrkFJJ2jsopkDmkVnwxRlIg==
X-Received: by 2002:a9d:3f8:: with SMTP id f111mr3146428otf.204.1583340263091;
        Wed, 04 Mar 2020 08:44:23 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n25sm9021954oic.6.2020.03.04.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:44:22 -0800 (PST)
Received: (nullmailer pid 1900 invoked by uid 1000);
        Wed, 04 Mar 2020 16:44:21 -0000
Date:   Wed, 4 Mar 2020 10:44:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: input: Add docs for ADC driven
 joystick.
Message-ID: <20200304164421.GA22591@bogus>
References: <20200301150920.55993-1-contact@artur-rojek.eu>
 <20200301150920.55993-4-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301150920.55993-4-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 01, 2020 at 04:09:19PM +0100, Artur Rojek wrote:
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
>  Changes:
> 
>  v2: - Add `reg` property to axis subnode in order to enumerate the axes,
>      - rename `linux,abs-code` property to `linux,code`,
>      - drop `linux,` prefix from the remaining properties of axis subnode
> 
>  v3: no change
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

Drop 'bindings'.

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

How many?

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

Up to 10 axis?

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

reg:
  enum: [ 0, 1 ]

Or use minimum/maximum

> +
> +      linux,code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: EV_ABS specific event code generated by the axis.
> +
> +      abs-range:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array

Needs to be under an 'allOf'.

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
> -- 
> 2.25.1
> 
