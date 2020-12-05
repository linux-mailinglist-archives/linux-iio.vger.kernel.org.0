Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D855C2CFD41
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbgLES32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbgLES30 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:26 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 524872312D;
        Sat,  5 Dec 2020 15:49:41 +0000 (UTC)
Date:   Sat, 5 Dec 2020 15:49:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: st-sensors: Convert bindings to YAML
Message-ID: <20201205154938.636c07c1@archlinux>
In-Reply-To: <20201202211358.1517554-1-linus.walleij@linaro.org>
References: <20201202211358.1517554-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Dec 2020 22:13:58 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Convert this large binding to YAML. It is pretty simple
> in it's basic form but the devil is in the details.
> Some -if restrictions painstakingly created by reading through
> all the datasheets.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Subject to the fact you already picked up on the much less precise
binding doc conversion I did (was a conversion whereas this is
an improvement :)

Looks good to me.  One minor suggestion in line.

Unfortunate this hit just after I'd applied the lesser version :(

> ---
>  .../devicetree/bindings/iio/st-sensors.txt    |  82 -------
>  .../devicetree/bindings/iio/st-sensors.yaml   | 213 ++++++++++++++++++
>  2 files changed, 213 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/st-sensors.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> deleted file mode 100644
> index 3213599c5071..000000000000
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -STMicroelectronics MEMS sensors
> -
> -The STMicroelectronics sensor devices are pretty straight-forward I2C or
> -SPI devices, all sharing the same device tree descriptions no matter what
> -type of sensor it is.
> -
> -Required properties:
> -- compatible: see the list of valid compatible strings below
> -- reg: the I2C or SPI address the device will respond to
> -
> -Optional properties:
> -- vdd-supply: an optional regulator that needs to be on to provide VDD
> -  power to the sensor.
> -- vddio-supply: an optional regulator that needs to be on to provide the
> -  VDD IO power to the sensor.
> -- st,drdy-int-pin: the pin on the package that will be used to signal
> -  "data ready" (valid values: 1 or 2). This property is not configurable
> -  on all sensors.
> -- drive-open-drain: the interrupt/data ready line will be configured
> -  as open drain, which is useful if several sensors share the same
> -  interrupt line. (This binding is taken from pinctrl/pinctrl-bindings.txt)
> -  This is a boolean property.
> -
> -Sensors may also have applicable pin control settings, those use the
> -standard bindings from pinctrl/pinctrl-bindings.txt.
> -
> -Valid compatible strings:
> -
> -Accelerometers:
> -- st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
> -- st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
> -- st,lis3lv02dl-accel
> -- st,lsm303dlh-accel
> -- st,lsm303dlhc-accel
> -- st,lis3dh-accel
> -- st,lsm330d-accel
> -- st,lsm330dl-accel
> -- st,lsm330dlc-accel
> -- st,lis331dl-accel
> -- st,lis331dlh-accel
> -- st,lsm303dl-accel
> -- st,lsm303dlm-accel
> -- st,lsm330-accel
> -- st,lsm303agr-accel
> -- st,lis2dh12-accel
> -- st,h3lis331dl-accel
> -- st,lng2dm-accel
> -- st,lis3l02dq
> -- st,lis2dw12
> -- st,lis3dhh
> -- st,lis3de
> -- st,lis2de12
> -- st,lis2hh12
> -
> -Gyroscopes:
> -- st,l3g4200d-gyro
> -- st,lsm330d-gyro
> -- st,lsm330dl-gyro
> -- st,lsm330dlc-gyro
> -- st,l3gd20-gyro
> -- st,l3gd20h-gyro
> -- st,l3g4is-gyro
> -- st,lsm330-gyro
> -- st,lsm9ds0-gyro
> -
> -Magnetometers:
> -- st,lsm303agr-magn
> -- st,lsm303dlh-magn
> -- st,lsm303dlhc-magn
> -- st,lsm303dlm-magn
> -- st,lis3mdl-magn
> -- st,lis2mdl
> -- st,lsm9ds1-magn
> -
> -Pressure sensors:
> -- st,lps001wp-press
> -- st,lps25h-press
> -- st,lps331ap-press
> -- st,lps22hb-press
> -- st,lps33hw
> -- st,lps35hw
> -- st,lps22hh
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.yaml b/Documentation/devicetree/bindings/iio/st-sensors.yaml
> new file mode 100644
> index 000000000000..6435bbedfd9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.yaml
> @@ -0,0 +1,213 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/st-sensors.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics MEMS Sensors
> +
> +description: The STMicroelectronics sensor devices are pretty straight-forward
> +  I2C or SPI devices, all sharing the same device tree descriptions no matter
> +  what type of sensor it is.
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: STMicroelectronics Accelerometers
> +        enum:
> +          - st,h3lis331dl-accel
> +          - st,lis2de12
> +          - st,lis2dw12
> +          - st,lis2hh12
> +          - st,lis2dh12-accel
> +          - st,lis331dl-accel
> +          - st,lis331dlh-accel
> +          - st,lis3de
> +          - st,lis3dh-accel
> +          - st,lis3dhh
> +          - st,lis3l02dq
> +          - st,lis3lv02dl-accel
> +          - st,lng2dm-accel
> +          - st,lsm303agr-accel
> +          - st,lsm303dl-accel
> +          - st,lsm303dlh-accel
> +          - st,lsm303dlhc-accel
> +          - st,lsm303dlm-accel
> +          - st,lsm330-accel
> +          - st,lsm330d-accel
> +          - st,lsm330dl-accel
> +          - st,lsm330dlc-accel
> +      - description: STMicroelectronics Gyroscopes
> +        enum:
> +          - st,l3g4200d-gyro
> +          - st,l3g4is-gyro
> +          - st,l3gd20-gyro
> +          - st,l3gd20h-gyro
> +          - st,lsm330-gyro
> +          - st,lsm330d-gyro
> +          - st,lsm330dl-gyro
> +          - st,lsm330dlc-gyro
> +          - st,lsm9ds0-gyro
> +      - description: STMicroelectronics Magnetometers
> +        enum:
> +          - st,lis2mdl
> +          - st,lis3mdl-magn
> +          - st,lsm303agr-magn
> +          - st,lsm303dlh-magn
> +          - st,lsm303dlhc-magn
> +          - st,lsm303dlm-magn
> +          - st,lsm9ds1-magn
> +      - description: STMicroelectronics Pressure Sensors
> +        enum:
> +          - st,lps001wp-press
> +          - st,lps22hb-press
> +          - st,lps22hh
> +          - st,lps25h-press
> +          - st,lps331ap-press
> +          - st,lps33hw
> +          - st,lps35hw
> +      - description: Deprecated bindings
> +        enum:
> +          - st,lis302dl-spi
> +          - st,lis3lv02d
> +        deprecated: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: interrupt line(s) connected to the DRDY line(s) and/or the
> +      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
> +      three interrupts, and the DRDY must be the first one if it exists on
> +      the package. The trigger edge of the interrupts is sometimes software
> +      configurable in the hardware so the operating system should parse this
> +      flag and set up the trigger edge as indicated in the device tree.
> +    minItems: 1
> +    maxItems: 2
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +  st,drdy-int-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +    description: the pin on the package that will be used to signal
> +      "data ready" (valid values 1 or 2). This property is not configurable
> +      on all sensors.
> +    items:
> +      minimum: 1
> +      maximum: 2

Maybe enum [1, 2]?

> +
> +  drive-open-drain:
> +    type: boolean
> +    description: the interrupt/data ready line will be configured
> +      as open drain, which is useful if several sensors share the same
> +      interrupt line. (This binding is taken from pinctrl.)
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            # These have no interrupts
> +            - st,lps001wp
> +    then:
> +      properties:
> +        interrupts: false
> +        st,drdy-int-pin: false
> +        drive-open-drain: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            # These have only DRDY
> +            - st,lis2mdl
> +            - st,lis3l02dq
> +            - st,lis3lv02dl-accel
> +            - st,lps22hb-press
> +            - st,lps22hh
> +            - st,lps25h-press
> +            - st,lps33hw
> +            - st,lps35hw
> +            - st,lsm303agr-magn
> +            - st,lsm303dlh-magn
> +            - st,lsm303dlhc-magn
> +            - st,lsm303dlm-magn
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        st,drdy-int-pin: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            # Two intertial interrupts i.e. accelerometer/gyro interrupts
> +            - st,h3lis331dl-accel
> +            - st,l3g4200d-gyro
> +            - st,l3g4is-gyro
> +            - st,l3gd20-gyro
> +            - st,l3gd20h-gyro
> +            - st,lis2de12
> +            - st,lis2dw12
> +            - st,lis2hh12
> +            - st,lis2dh12-accel
> +            - st,lis331dl-accel
> +            - st,lis331dlh-accel
> +            - st,lis3de
> +            - st,lis3dh-accel
> +            - st,lis3dhh
> +            - st,lis3mdl-magn
> +            - st,lng2dm-accel
> +            - st,lps331ap-press
> +            - st,lsm303agr-accel
> +            - st,lsm303dlh-accel
> +            - st,lsm303dlhc-accel
> +            - st,lsm303dlm-accel
> +            - st,lsm330-accel
> +            - st,lsm330-gyro
> +            - st,lsm330d-accel
> +            - st,lsm330d-gyro
> +            - st,lsm330dl-accel
> +            - st,lsm330dl-gyro
> +            - st,lsm330dlc-accel
> +            - st,lsm330dlc-gyro
> +            - st,lsm9ds0-gyro
> +            - st,lsm9ds1-magn
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2
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
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      accelerometer@1c {
> +        compatible = "st,lis331dl-accel";
> +        reg = <0x1c>;
> +        st,drdy-int-pin = <1>;
> +        vdd-supply = <&ldo1>;
> +        vddio-supply = <&ldo2>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <18 IRQ_TYPE_EDGE_RISING>, <19 IRQ_TYPE_EDGE_RISING>;
> +      };
> +    };

