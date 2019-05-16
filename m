Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF84E2082B
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEPN3W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 09:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfEPN3W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 09:29:22 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9442920815;
        Thu, 16 May 2019 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558013360;
        bh=Hl4HG1LTgP0kUdc0fnowH0wQepATuakWlP9UdDaSz2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P+5NuyJmvwM/00B4MYXfQxHYVYhFQzrimQN7+B0Nbtaq3T0mp/Eq270v47Vd8pd2U
         2msw5nuYmnmvJw51UwNzdn2Cgpk9MVib2Td4QWHVEgmLzVbA9S85uDpk4G1TA4thaZ
         6TjATKtabfWPDh4Xp5GmBx3WIp+KzVM5VtSufJok=
Received: by mail-qt1-f175.google.com with SMTP id y42so3840290qtk.6;
        Thu, 16 May 2019 06:29:20 -0700 (PDT)
X-Gm-Message-State: APjAAAWdkEdk0h/thjAkNAumkYc6K3Ik/NRCFhgNKdoZBYW7klPGppSn
        IVkBugm5FHbSkknYaTl5tw4XZPCasgOb7lMr5w==
X-Google-Smtp-Source: APXvYqwjIW/h+6qe3Z6w4/6CXYiZK9DXNUedQdNAsmingAGVHCB7FKDW2qcelU27s0fO/PpE9txe48VBr7h66V3rN8Q=
X-Received: by 2002:aed:2ca5:: with SMTP id g34mr8040318qtd.76.1558013359842;
 Thu, 16 May 2019 06:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190516121509.1441-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190516121509.1441-1-alexandru.ardelean@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 May 2019 08:29:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLEuCJWnD1G5iXdCNcJ+a_0zhoUH2a=4i6VBm8_B9r6w@mail.gmail.com>
Message-ID: <CAL_JsqJLEuCJWnD1G5iXdCNcJ+a_0zhoUH2a=4i6VBm8_B9r6w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: accel: adxl345: switch to YAML bindings
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 16, 2019 at 7:15 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The ADX345 supports both I2C & SPI bindings.
> This change switches from old text bindings, to YAML bindings, and also
> tries to make use of the recent multiple-examples support.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/accel/adi,adxl345.yaml       | 74 +++++++++++++++++++
>  .../devicetree/bindings/iio/accel/adxl345.txt | 39 ----------
>  2 files changed, 74 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> new file mode 100644
> index 000000000000..47cdfb3b8182
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl345.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers that supports
> +  both I2C & SPI interfaces.
> +    http://www.analog.com/en/products/mems/accelerometers/adxl345.html
> +    http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl345
> +      - adi,adxl375
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  interrupt-parent: true

You don't need to document interrupt-parent. It is implied. With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a I2C device node */
> +        accelerometer@2a {
> +            compatible = "adi,adxl345";
> +            reg = <0x53>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "adi,adxl345";
> +            reg = <0>;
> +            spi-max-frequency = <5000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
> deleted file mode 100644
> index f9525f6e3d43..000000000000
> --- a/Documentation/devicetree/bindings/iio/accel/adxl345.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
> -
> -http://www.analog.com/en/products/mems/accelerometers/adxl345.html
> -http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
> -
> -Required properties:
> - - compatible : should be one of
> -               "adi,adxl345"
> -               "adi,adxl375"
> - - reg : the I2C address or SPI chip select number of the sensor
> -
> -Required properties for SPI bus usage:
> - - spi-max-frequency : set maximum clock frequency, must be 5000000
> - - spi-cpol and spi-cpha : must be defined for adxl345 to enable SPI mode 3
> -
> -Optional properties:
> - - interrupts: interrupt mapping for IRQ as documented in
> -   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -
> -Example for a I2C device node:
> -
> -       accelerometer@2a {
> -               compatible = "adi,adxl345";
> -               reg = <0x53>;
> -               interrupt-parent = <&gpio1>;
> -               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> -       };
> -
> -Example for a SPI device node:
> -
> -       accelerometer@0 {
> -               compatible = "adi,adxl345";
> -               reg = <0>;
> -               spi-max-frequency = <5000000>;
> -               spi-cpol;
> -               spi-cpha;
> -               interrupt-parent = <&gpio1>;
> -               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> -       };
> --
> 2.17.1
>
