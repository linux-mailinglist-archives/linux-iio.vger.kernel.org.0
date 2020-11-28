Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA72C747B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgK1Vta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733181AbgK1TG1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:06:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4727F22280;
        Sat, 28 Nov 2020 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606563462;
        bh=dajrluPFv/MMnGz60kB91fo5W/wkirHOn7T3qG/8ZKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQG3BooRJ/Y5lkVO2Eca4Yef4KitY91DjUhFBYohTvEdVKoj7WrFsgPsBzkWw2m2V
         8VJPLC3pv0IdUdwjbysogvEJOZVnpuTsj0AEPjveXpwTYGnPCCnr2Hsia9oDhxRQUA
         WEvSES76avqD08I4k48rZ5g1GBrGXdQCs1jWdJBg=
Date:   Sat, 28 Nov 2020 11:37:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] iio: accel: yamaha-yas53x: Add DT bindings
Message-ID: <20201128113739.72697868@archlinux>
In-Reply-To: <20201128004038.883289-1-linus.walleij@linaro.org>
References: <20201128004038.883289-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 01:40:37 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds device tree bindings for the Yamaha YAS53x
> magnetometers/compass sensors.
> 
> Cc: devicetree@vger.kernel.org
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Restrict to cover the YAS53x variants, it turns out that
>   YAS529 is a very different component from the others so
>   keep that for a separate document when/if needed.
> - Rename the file and binding yamaha,53x.yaml

I'd rather see it named after a specific component.
As you probably noticed I'm not fond of wild cards in file names
as they have a habit of biting us years later.

> - Use - if: clauses to restrict some properties.
> - Fix some spelling mistakes.
> - Restrict the nodename to be "magnetometer@[0-9a-f]"
> ChangeLog v1->v2:
> - Add Yamaha to the vendor list, I was surprised to find
>   they were not yet listed.
> 
> I am still working on the actual driver for the magnetometer
> but why not send out the DT bindings for review, the
> hardware variants are easy to describe. This makes it possibe
> for people to include these magnetometers in device
> trees.

You probably want to drop that now :)

> ---
>  .../iio/magnetometer/yamaha,yas53x.yaml       | 116 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas53x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas53x.yaml b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas53x.yaml
> new file mode 100644
> index 000000000000..e14668a6388d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas53x.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/yamaha,yas53x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Yamaha YAS53x magnetometer sensors
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  The Yamaha YAS53x magnetometers is a line of 3-axis magnetometers
> +  first introduced by Yamaha in 2009 with the YAS530. They are successors
> +  of Yamaha's first magnetometer YAS529. Over the years this magnetometer
> +  has been miniaturized and appeared in a number of different variants.
> +
> +properties:
> +  $nodename:
> +    pattern: '^magnetometer@[0-9a-f]+$'
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - yamaha,yas530
> +          - yamaha,yas532
> +          - yamaha,yas533
> +          - yamaha,yas535
> +          - yamaha,yas536
> +          - yamaha,yas537
> +          - yamaha,yas539
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: The YAS530 sensor has a RSTN pin used to reset
> +      the logic inside the sensor. This GPIO line should connect
> +      to that pin and be marked as GPIO_ACTIVE_LOW.
> +
> +  interrupts:
> +    description: Interrupt for INT pin for interrupt generation.
> +      The polarity, whether the interrupt is active on the rising
> +      or the falling edge, is software-configurable in the hardware.
> +
> +  vdd-supply:
> +    description: An optional regulator providing core power supply
> +      on the VDD pin, typically 1.8 V or 3.0 V.
> +
> +  iovdd-supply:
> +    description: An optional regulator providing I/O power supply
> +      for the I2C interface on the IOVDD pin, typically 1.8 V.
> +
> +  mount-matrix:
> +    description: An optional 3x3 mounting rotation matrix.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            const: yamaha,yas530
> +    then:
> +      properties:
> +        reset-gpios:
> +          maxItems: 1
       else:
         properties:
            reset-gpios: false

You can probably also simplify this by moving the maxItems up to the
original block and making this a not:

> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - yamaha,yas530
> +            - yamaha,yas532
> +            - yamaha,yas533
> +            - yamaha,yas535
> +            - yamaha,yas536
> +            - yamaha,yas537
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1

Similar to the reset line one above.   You could flip this and explicity
state they others don't have an interrupt with whilst moving maxItems
up to the block where you first introduce interrupts.
i.e. not: and
interrupt: false


> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c-0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@2e {
> +          compatible = "yamaha,yas530";
> +          reg = <0x2e>;
> +          vdd-supply = <&ldo1_reg>;
> +          iovdd-supply = <&ldo2_reg>;
> +          reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
> +          interrupts = <&gpio6 13 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };
> +
> +    i2c-1 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@2e {
> +          compatible = "yamaha,yas539";
> +          reg = <0x2e>;
> +          vdd-supply = <&ldo1_reg>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 2735be1a8470..0340674c72bd 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1210,6 +1210,8 @@ patternProperties:
>      description: Shenzhen Xunlong Software CO.,Limited
>    "^xylon,.*":
>      description: Xylon
> +  "^yamaha,.*":
> +    description: Yamaha Corporation
>    "^ylm,.*":
>      description: Shenzhen Yangliming Electronic Technology Co., Ltd.
>    "^yna,.*":

