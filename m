Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0C22331
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfERK1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:27:11 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46408 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfERK1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 06:27:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 3CC159E813E;
        Sat, 18 May 2019 11:27:09 +0100 (BST)
Date:   Sat, 18 May 2019 11:27:07 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH][V3] dt-bindings: iio: accel: adxl345: switch to YAML
 bindings
Message-ID: <20190518112707.565525a6@archlinux>
In-Reply-To: <20190517154441.27080-1-ardeleanalex@gmail.com>
References: <20190516133609.10975-1-alexandru.ardelean@analog.com>
        <20190517154441.27080-1-ardeleanalex@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 May 2019 18:44:41 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> The ADX345 supports both I2C & SPI bindings.
> This change switches from old text bindings, to YAML bindings, and also
> tries to make use of the recent multiple-examples support.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * dropped interrupt-parent from DT, as suggested by Rob
> 
> Changelog v2 -> v3:
> * add Rob's Reviewed-by tag
> * add YAML file to MAINTAINERS - main reason for this V3
> 
>  .../bindings/iio/accel/adi,adxl345.yaml       | 72 +++++++++++++++++++
>  .../devicetree/bindings/iio/accel/adxl345.txt | 39 ----------
>  MAINTAINERS                                   |  1 +
>  3 files changed, 73 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> new file mode 100644
> index 000000000000..7ba167e2e1ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -0,0 +1,72 @@
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
> -		"adi,adxl345"
> -		"adi,adxl375"
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
> -	accelerometer@2a {
> -		compatible = "adi,adxl345";
> -		reg = <0x53>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -Example for a SPI device node:
> -
> -	accelerometer@0 {
> -		compatible = "adi,adxl345";
> -		reg = <0>;
> -		spi-max-frequency = <5000000>;
> -		spi-cpol;
> -		spi-cpha;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43a9cebb2c19..54c8e14fae98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -551,6 +551,7 @@ W:	http://wiki.analog.com/ADXL345
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/input/misc/adxl34x.c
> +F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
>  
>  ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>

