Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2182A2196
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 21:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgKAUpC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 15:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgKAUpB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 15:45:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D76E21527;
        Sun,  1 Nov 2020 20:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604263501;
        bh=nEih1mCwNFlDPl76RHfHvCLViE41MwlBps56T5vrzLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDT5aPRgQsbSKwO/9ysEfeA05fSaETMDgHF72zD9LaEH8ooNdd1IqpsSpIv/Iotf3
         xv5RTcFnN5SeBR9G4nnXA5jsobJXlGxiOb5NVlrPGj5jY51B1YdQ3ROFvj/UYmzf/8
         xJNHUHGWZgPKDFaSfj8F4c9fGONjBwUYRafnW25M=
Date:   Sun, 1 Nov 2020 20:44:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: bmc150-accel: Add DT bindings
Message-ID: <20201101204456.2f15616a@archlinux>
In-Reply-To: <20201101122833.1111424-1-linus.walleij@linaro.org>
References: <20201101122833.1111424-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Nov 2020 13:28:31 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> These accelerometers have bindings used in the kernel and
> several device trees but no proper bindings documentation.
> Add it.
> 
> Also add a compatible for the BMA222 that I am right now
> adding support for in the driver.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Hi Linus,

A few minor things inline.

Great to be plugging some of the holes in binding docs.
Doing a complete check is on my todo list :)

Jonathan

> ---
>  .../bindings/iio/accel/bosch,bmc-bmi-bma.yaml | 72 +++++++++++++++++++

So far we only have a few bindings that aren't named after a supported part.
Give we have other devices that match these letters, I don't think we want to
do it here.  Just confused people!

Pick a part and name it after that.

>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml
> new file mode 100644
> index 000000000000..11b8b68aaf3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bosch,bmc-bmi-bma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMCxxx, BMIxxx and BMAxxx Accelerometers

Some of them...  see bma180.txt in the same directory.
I'd go with bma255 and similar (chose your favourite part number)
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  3 axis accelerometers with varying range and I2C or SPI
> +  3-wire interface.

Looks like 4-wire to me.  CSB, SPI-CLK, SDO, SDI.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bmc150
> +      - bosch,bmi055
> +      - bosch,bma255
> +      - bosch,bma250e
> +      - bosch,bma222
> +      - bosch,bma222e
> +      - bosch,bma280
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
> +  spi-max-frequency: true

Don't suppose these all share a common max?
I looked at a few and 10MHz was the value for those.
Always nice to pin things down a bit if we can!

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
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        accelerometer@8 {
> +            compatible = "bosch,bma222";
> +            reg = <0x08>;
> +            vddio-supply = <&vddio>;
> +            vdd-supply = <&vdd>;
> +            interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> +  - |
> +    # include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        accel@0 {
> +            compatible = "bosch,bma222";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +        };
> +    };
> +...

