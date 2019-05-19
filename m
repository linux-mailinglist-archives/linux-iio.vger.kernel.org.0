Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A10227A4
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfESRWX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfESRWW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:22:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1F0217F4;
        Sun, 19 May 2019 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558265064;
        bh=JCr63lX///u8XKMNJmGMKqINHcVAQTw2lJQSqfPH06E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lYQr2+bTvKfhLsvg7+mByE3826DEtER8vAS42B1hpAsmRzolTWOMtMRvXDGCssWFO
         8HjqjkbgKsOb6DW1PjUIqQ9kZdBXkYkM/cbxey7T6XQBfX7q7aui54FyvQjUaxVyTU
         jnJlEP1tHZpKY7AAdyHvgod/gIwez/VNu5MDK2bM=
Date:   Sun, 19 May 2019 12:24:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: accel: adxl372: switch to YAML
 bindings
Message-ID: <20190519122418.7722641b@archlinux>
In-Reply-To: <20190518215542.25140-1-lucasseikioshiro@gmail.com>
References: <20190518215542.25140-1-lucasseikioshiro@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 18:55:42 -0300
Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:

> Convert the old device tree documentation to yaml format.
> 
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> Co-developed-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> ---
> 
> Hello,
> We've added Stefan Popa as maintainer of the yaml documentation of this driver
> because we found through git that he was the author of the older documentation.

Definitely going to need an Ack from Stefan for that ;)

I've not really gotten yaml formats into my head yet, but from a quick
look I think this is fine.  I will however be looking for review from others
on these. 

Thanks,

Jonathan

> 
>  .../bindings/iio/accel/adi,adxl372.yaml       | 66 +++++++++++++++++++
>  .../devicetree/bindings/iio/accel/adxl372.txt | 33 ----------
>  2 files changed, 66 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> new file mode 100644
> index 000000000000..a6e2893d2ab1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl372.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> +
> +maintainers:
> +  - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> +  Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
> +  both I2C & SPI interfaces
> +    https://www.analog.com/en/products/adxl372.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl372
> +
> +  reg:
> +    description: the I2C address or SPI chip select number for the device
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ as documented in
> +      Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +        #include <dt-bindings/gpio/gpio.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        i2c0 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* Example for a I2C device node */
> +                accelerometer@53 {
> +                        compatible = "adi,adxl372";
> +                        reg = <0x53>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +                };
> +        };
> +  - |
> +        #include <dt-bindings/gpio/gpio.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        spi0 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                accelerometer@0 {
> +                        compatible = "adi,adxl372";
> +                        reg = <0>;
> +                        spi-max-frequency = <1000000>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +                };
> +        };
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> deleted file mode 100644
> index a289964756a7..000000000000
> --- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> -
> -http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
> -
> -Required properties:
> - - compatible : should be "adi,adxl372"
> - - reg: the I2C address or SPI chip select number for the device
> -
> -Required properties for SPI bus usage:
> - - spi-max-frequency: Max SPI frequency to use
> -
> -Optional properties:
> - - interrupts: interrupt mapping for IRQ as documented in
> -   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -
> -Example for a I2C device node:
> -
> -	accelerometer@53 {
> -		compatible = "adi,adxl372";
> -		reg = <0x53>;
> -		interrupt-parent = <&gpio>;
> -		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> -	};
> -
> -Example for a SPI device node:
> -
> -	accelerometer@0 {
> -		compatible = "adi,adxl372";
> -		reg = <0>;
> -		spi-max-frequency = <1000000>;
> -		interrupt-parent = <&gpio>;
> -		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> -	};

