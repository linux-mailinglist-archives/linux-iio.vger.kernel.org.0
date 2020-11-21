Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF04F2BC068
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKUQCC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKUQCC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 11:02:02 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 413D7221FE;
        Sat, 21 Nov 2020 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605974521;
        bh=CVqXC4OjPnHXii9zDQpZBX7hMR9t5WEAwNB9FUhz1OY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r40Fsk0CX+rLxEiL6OYrx/aQd/lFw6bYV2DtuqLpQeLio9lrk7lWoCVlVciebUUnI
         BJuXnzszJWUW+wGvqHujRvulXjYBwViXYubN9D/ZmTUZNJInDK1m505l6Dsn7e96zr
         gKnUKSYiUJGV6F8t3SMGHjoWeiVhSHtQhH97rdjA=
Date:   Sat, 21 Nov 2020 16:01:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: yamaha-yas: Add DT bindings
Message-ID: <20201121160156.3d9d32c1@archlinux>
In-Reply-To: <20201117121810.830743-1-linus.walleij@linaro.org>
References: <20201117121810.830743-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 13:18:10 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds device tree bindings for the Yamaha YAS5xx
> magnetometers/compass sensors.
> 
> Cc: devicetree@vger.kernel.org
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Hi Linus,

A few minor things inline.  Looking forward to the driver :)

Jonathan

> ---
> ChangeLog v1->v2:
> - Add Yamaha to the vendor list, I was surprised to find
>   they were not yet listed.
> 
> I am still working on the actual driver for the magnetometer
> but why not send out the DT bindings for review, the
> hardware variants are easy to describe. This makes it possibe
> for people to include these magnetometers in device
> trees.
> ---
>  .../bindings/iio/magnetometer/yamaha,yas.yaml | 80 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml
> new file mode 100644
> index 000000000000..6fc4cfe4a417
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/yamaha,yas.yaml#

Hmm. Is the generic name safe?   Might we get some future devices
that this binding doesn't cover?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Yamaha YAS5xx magnetometer sensors
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  The Yamaha YAS5xx magnetometers is a line of 3-axis magnetometers
> +  first introduced by Yamaha in 2006 with the YAS529. Over the years
> +  this magnetometer has been minatyrized and appeared in a number of
> +  different variants.

Run a spell checker over this.  miniaturised

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - yamaha,yas529
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
> +    maxItems: 1
> +    description: The YAS5xx sensors has a RSTN pin used to reset
> +      the logic inside the sensor. This GPIO line should connect
> +      to that pin and be marked as GPIO_ACTIVE_LOW.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Interrupt for INT pin for variants that support
> +      interrupt generation. This polarity, whether the interrupt
> +      is active on the rising or the falling edge, is configurable
> +      in the hardware.

Worth adding the if magic to check this isn't provide for variants
that don't have an interrupt pin?
I guess it's fairly unlikely anyone would have a dt file that claims
there is an interrupt that doesn't exist, but nice to keep the
bindings as restrictive as can be easily done.

> +
> +  vdd-supply:
> +    description: An optional regulator providing core power supply
> +      on the VDD pin, typically 1.8 V or 3.0 V.
> +
> +  iovdd-supply:
> +    description: An optional regulator providing I/O power supply
> +      for the I2C interface on the IOVDD pin, typically 1.8 V.
> +      This is not present on all variants of the component, some
> +      have only the VDD voltage.

Likewise, can we restrict this to the right variants.

> +
> +  mount-matrix:
> +    description: An optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@2e {
> +          compatible = "yamaha,yas530";
> +          reg = <0x2e>;
> +          vdd-supply = <&ldo1_reg>;
> +          iovdd-supply = <&ldo2_reg>;
> +          reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
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

