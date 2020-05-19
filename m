Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7D1D9E30
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgESRuF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 13:50:05 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbgESRuF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 13:50:05 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 51E0D1E21315E27A0224;
        Tue, 19 May 2020 18:50:01 +0100 (IST)
Received: from localhost (10.47.86.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 19 May
 2020 18:50:00 +0100
Date:   Tue, 19 May 2020 18:49:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt
 format to yaml
Message-ID: <20200519184933.00003f00@Huawei.com>
In-Reply-To: <20200519075111.6356-2-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
        <20200519075111.6356-2-jonathan.albrieux@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.149]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 May 2020 09:50:57 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Converts documentation from txt format to yaml 
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
>  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> deleted file mode 100644
> index 900c169de00f..000000000000
> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
> -and externally connectable Magnetometer
> -
> -https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> -
> -Required properties:
> - - compatible : should be "bosch,bmi160"
> - - reg : the I2C address or SPI chip select number of the sensor
> - - spi-max-frequency : set maximum clock frequency (only for SPI)
> -
> -Optional properties:
> - - interrupts : interrupt mapping for IRQ
> - - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
> -   input, set to "INT2" if INT2 pin should be used instead
> - - drive-open-drain : set if the specified interrupt pin should be configured as
> -   open drain. If not set, defaults to push-pull.
> -
> -Examples:
> -
> -bmi160@68 {
> -	compatible = "bosch,bmi160";
> -	reg = <0x68>;
> -
> -	interrupt-parent = <&gpio4>;
> -	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> -	interrupt-names = "INT1";
> -};
> -
> -bmi160@0 {
> -	compatible = "bosch,bmi160";
> -	reg = <0>;
> -	spi-max-frequency = <10000000>;
> -
> -	interrupt-parent = <&gpio2>;
> -	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> -	interrupt-names = "INT2";
> -};
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> new file mode 100644
> index 000000000000..6b464ce5ed0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bmi160.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI160
> +
> +maintainers:
> +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>

Daniel is still active in the kernel, just not at Intel any more. +CC

> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope and externally
> +  connectable Magnetometer
> +  https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> +
> +properties:
> +  compatible:
> +    const: bosch,bmi160
> +
> +  reg:
> +    maxItems: 1
> +    description: the I2C address or SPI chip select number of the sensor

As standard for i2c and spi, usually no need to have a description line for
this element.

> +
> +  spi-max-frequency:
> +    maxItems: 1
> +    description: set maximum clock frequency (required only for SPI)

Standard spi binding.  Probably doesn't need to be included here.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt mapping for IRQ
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +    description: |
> +      set to "INT1" if INT1 pin should be used as interrupt input, set
> +      to "INT2" if INT2 pin should be used instead
> +
> +  drive-open-drain:
> +    description: |
> +      set if the specified interrupt pin should be configured as
> +      open drain. If not set, defaults to push-pull.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    // Example for I2C
> +    i2c@78b7000 {
> +        reg = <0x78b6000 0x600>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;

Take a look at some of the other binding examples.  We normally
just focus on the driver so don't supply details for the bus.

e.g. https://elixir.bootlin.com/linux/v5.7-rc6/source/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml#L39

> +
> +        bmi160@68 {
> +                compatible = "bosch,bmi160";
> +                reg = <0x68>;
> +                interrupt-parent = <&gpio4>;
> +                interrupts = <12 1>;
> +                interrupt-names = "INT1";
> +        };
> +  - |
> +    // Example for SPI
> +    spi@78b7000 {
> +        reg = <0x78b7000 0x600>,
> +              <0x7884000 0x23000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bmi160@0 {
> +                compatible = "bosch,bmi160";
> +                reg = <0>;
> +                spi-max-frequency = <10000000>;
> +                interrupt-parent = <&gpio2>;
> +                interrupts = <12 1>;
> +                interrupt-names = "INT2";
> +        };
> +    };


