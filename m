Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAB36348E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 12:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhDRKJQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 06:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhDRKJD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 06:09:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2763A61090;
        Sun, 18 Apr 2021 10:08:27 +0000 (UTC)
Date:   Sun, 18 Apr 2021 11:09:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
Message-ID: <20210418110901.76cd1abd@jic23-huawei>
In-Reply-To: <20210412122331.1631643-1-linus.walleij@linaro.org>
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 14:23:31 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> This adjusts the ST Sensor bindings with the more fine-grained
> syntax checks that were proposed late in the last kernel cycle
> and colliding with parallel work.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Use enum for the st,drdy-int-pin property.
> - Drop GPIO DT include.
> - Add an SPI example.
> ---
>  .../bindings/iio/st,st-sensors.yaml           | 261 ++++++++++++------
>  1 file changed, 183 insertions(+), 78 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> index 7e98f47987dc..497cb97042e0 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -6,7 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: STMicroelectronics MEMS sensors
>  
> -description: |
> +description: The STMicroelectronics sensor devices are pretty straight-forward
> +  I2C or SPI devices, all sharing the same device tree descriptions no matter
> +  what type of sensor it is.
>    Note that whilst this covers many STMicro MEMs sensors, some more complex
>    IMUs need their own bindings.
>    The STMicroelectronics sensor devices are pretty straight-forward I2C or
> @@ -15,90 +17,178 @@ description: |
>  
>  maintainers:
>    - Denis Ciocca <denis.ciocca@st.com>
> +  - Linus Walleij <linus.walleij@linaro.org>
>  
>  properties:
>    compatible:
> -    description: |
> -      Some values are deprecated.
> -      st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
> -      st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
> -    enum:
> -        # Accelerometers
> -      - st,lis3lv02d
> -      - st,lis302dl-spi
> -      - st,lis3lv02dl-accel
> -      - st,lsm303dlh-accel
> -      - st,lsm303dlhc-accel
> -      - st,lis3dh-accel
> -      - st,lsm330d-accel
> -      - st,lsm330dl-accel
> -      - st,lsm330dlc-accel
> -      - st,lis331dl-accel
> -      - st,lis331dlh-accel
> -      - st,lsm303dl-accel
> -      - st,lsm303dlm-accel
> -      - st,lsm330-accel
> -      - st,lsm303agr-accel
> -      - st,lis2dh12-accel
> -      - st,h3lis331dl-accel
> -      - st,lng2dm-accel
> -      - st,lis3l02dq
> -      - st,lis2dw12
> -      - st,lis3dhh
> -      - st,lis3de
> -      - st,lis2de12
> -      - st,lis2hh12
> -        # Gyroscopes
> -      - st,l3g4200d-gyro
> -      - st,lsm330d-gyro
> -      - st,lsm330dl-gyro
> -      - st,lsm330dlc-gyro
> -      - st,l3gd20-gyro
> -      - st,l3gd20h-gyro
> -      - st,l3g4is-gyro
> -      - st,lsm330-gyro
> -      - st,lsm9ds0-gyro
> -        # Magnetometers
> -      - st,lsm303agr-magn
> -      - st,lsm303dlh-magn
> -      - st,lsm303dlhc-magn
> -      - st,lsm303dlm-magn
> -      - st,lis3mdl-magn
> -      - st,lis2mdl
> -      - st,lsm9ds1-magn
> -      - st,iis2mdc
> -        # Pressure sensors
> -      - st,lps001wp-press
> -      - st,lps25h-press
> -      - st,lps331ap-press
> -      - st,lps22hb-press
> -      - st,lps33hw
> -      - st,lps35hw
> -      - st,lps22hh
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
>  
>    reg:
>      maxItems: 1
>  
>    interrupts:
> +    description: interrupt line(s) connected to the DRDY line(s) and/or the
> +      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
> +      three interrupts, and the DRDY must be the first one if it exists on
> +      the package. The trigger edge of the interrupts is sometimes software
> +      configurable in the hardware so the operating system should parse this
> +      flag and set up the trigger edge as indicated in the device tree.
>      minItems: 1
> +    maxItems: 2
>  
>    vdd-supply: true
>    vddio-supply: true
>  
>    st,drdy-int-pin:
> +    description: the pin on the package that will be used to signal
> +      "data ready" (valid values 1 or 2). This property is not configurable
> +      on all sensors.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    description:
> -      Some sensors have multiple possible pins via which they can provide
> -      a data ready interrupt.  This selects which one.
> -    enum:
> -      - 1
> -      - 2
> +    enum: [1, 2]
>  
>    drive-open-drain:
>      $ref: /schemas/types.yaml#/definitions/flag
> -    description: |
> -      The interrupt/data ready line will be configured as open drain, which
> -      is useful if several sensors share the same interrupt line.
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
>  
>  required:
>    - compatible
> @@ -110,15 +200,30 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
>      i2c {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -        accelerometer@1d {
> -            compatible = "st,lis3lv02dl-accel";
> -            reg = <0x1d>;
> -            interrupt-parent = <&gpio2>;
> -            interrupts = <18 IRQ_TYPE_EDGE_RISING>;
> -            pinctrl-0 = <&lis3lv02dl_nhk_mode>;
> -            pinctrl-names = "default";
> -        };
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
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      num-cs = <1>;
> +
> +      l3g4200d: gyroscope@0 {
> +        compatible = "st,l3g4200d-gyro";
> +        st,drdy-int-pin = <2>;
> +        reg = <0>;
> +        vdd-supply = <&vcc_io>;
> +        vddio-supply = <&vcc_io>;
> +      };
>      };
> -...
> +
I tweaked this but otherwise applied to the togreg branch of iio.git and pushed
out as testing.  Thanks,

Jonathan

