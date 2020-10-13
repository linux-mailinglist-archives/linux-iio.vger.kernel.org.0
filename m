Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4A28D152
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 17:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgJMPef (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 11:34:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2977 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727355AbgJMPee (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Oct 2020 11:34:34 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9152B7A43B786E4B75EE;
        Tue, 13 Oct 2020 16:34:32 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 13 Oct
 2020 16:34:32 +0100
Date:   Tue, 13 Oct 2020 16:34:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Rui Miguel Silva <rui.silva@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: Re: [PATCH] dt-bindings: fxas21002c: convert bindings to yaml
Message-ID: <20201013153431.000052c9@huawei.com>
In-Reply-To: <20201013131545.503434-1-rmfrfs@gmail.com>
References: <20201013131545.503434-1-rmfrfs@gmail.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Oct 2020 14:15:45 +0100
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> Convert fxas21002c gyroscope sensor bindings documentation to
> yaml schema and remove the textual bindings document.
> 
> Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>

Hi Rui,

Always good to see a yaml conversion.

Comments inline...

> ---
>  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 --------
>  .../iio/gyroscope/nxp,fxas21002c.yaml         | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 78 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> deleted file mode 100644
> index 465e104bbf14..000000000000
> --- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* NXP FXAS21002C Gyroscope device tree bindings
> -
> -http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> -
> -Required properties:
> -  - compatible : should be "nxp,fxas21002c"
> -  - reg : the I2C address of the sensor or SPI chip select number for the
> -          device.
> -  - vdd-supply: phandle to the regulator that provides power to the sensor.
> -  - vddio-supply: phandle to the regulator that provides power to the bus.
> -
> -Optional properties:
> -  - reset-gpios : gpio used to reset the device, see gpio/gpio.txt
> -  - interrupts : device support 2 interrupts, INT1 and INT2,
> -                 the interrupts can be triggered on rising or falling edges.
> -                 See interrupt-controller/interrupts.txt
> -  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
> -                     line in use.
> -  - drive-open-drain: the interrupt/data ready line will be configured
> -                      as open drain, which is useful if several sensors share
> -                      the same interrupt line. This is a boolean property.
> -                      (This binding is taken from pinctrl/pinctrl-bindings.txt)
> -
> -Example:
> -
> -gyroscope@20 {
> -	compatible = "nxp,fxas21002c";
> -	reg = <0x20>;
> -	vdd-supply = <&reg_peri_3p15v>;
> -	vddio-supply = <&reg_peri_3p15v>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> new file mode 100644
> index 000000000000..7680e97cf1d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/gyroscope/nxp,fxas21002c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP FXAS21002C Gyroscope Unit

Why Unit? Gyroscope seems fine to me.

> +
> +maintainers:
> +  - Rui Miguel Silva <rmfrfs@gmail.com>
> +
> +description: |
> +  3 axis digital gyroscope device with an I2C and SPI interface.

Can we document the SPI binding as well?  With an example.

> +  http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,fxas21002c

Unless we think it likely this binding is going to shortly include other options,
       const: nxp... 
(doesn't matter that much though!)

> +
> +  reg:
> +    maxItems: 1
> +    description: base address of the device

No it isn't. It is the i2c address. Also this is standard so no description needed.


> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to reset
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: device support 2 interrupts,
I'd argue that's obvious from the maxItems. So no need to repeat it.


 INT1 and INT2,
This part is clear form interrupt-names so again, I wouldn't say it again.

 the interrupts can
> +                 be triggered on rising or falling edges.
This last bit is useful so I would have just this or something like

Either interrupt may be triggered on rising or falling edges.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +    description: gyroscope interrupt line in use.

Singular with 2 interrupts.  Personally I'd just drop the description as not
adding anything.

> +
> +  drive-open-drain:
> +    type: boolean
> +    description: the interrupt/data ready line will be configured as open drain,
> +                 which is useful if several sensors share the same interrupt
> +                 line.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply

Why required?  If it's hard wired on will a stub regulator not work fine
with this device.  Do we need to read it's voltage or similar?

> +  - vddio-supply
> +
> +unevaluatedProperties: false

Why unevalutatedProperties rather than additionalProperties?
I'll confess I don't really understand when to use unevaluatedProperties.
I'm guessing issue here is we don't have the SPI bindings stuff?

> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        gyroscope@20 {
> +          compatible = "nxp,fxas21002c";
> +          reg = <0x20>;
> +
> +          vdd-supply = <&reg_peri_3p15v>;
> +          vddio-supply = <&reg_peri_3p15v>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6594f0966716..2e85e114c9c3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12469,7 +12469,7 @@ NXP FXAS21002C DRIVER
>  M:	Rui Miguel Silva <rmfrfs@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> +F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
>  F:	drivers/iio/gyro/fxas21002c.h
>  F:	drivers/iio/gyro/fxas21002c_core.c
>  F:	drivers/iio/gyro/fxas21002c_i2c.c

