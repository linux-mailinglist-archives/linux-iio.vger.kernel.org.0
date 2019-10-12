Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B8D4F2C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 12:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJLK5v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 06:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfJLK5v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 06:57:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792782089C;
        Sat, 12 Oct 2019 10:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570877870;
        bh=U7OOVDQdiCvCLW5AJU6OCSX4UVrVo2KqQBD4MUbmhqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yYWEoOM5Z/UbYtTaNNUwH7uOOk9YkJo8WYhV/ggXPw/zUMp3zZppVYLaMHV8mgIMb
         xs6fXPZUu0+h4AT06TcPsMpRyoYSGCGmhnfMRhvwZxbV4CoP48QF/akJQUvTioUnLV
         A2OwNCDFuS2Loxbj1aPKnGE2mH4gHQVTu2ODCPUE=
Date:   Sat, 12 Oct 2019 11:57:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20191012115745.069119b0@archlinux>
In-Reply-To: <20191011084038.45829-2-nuno.sa@analog.com>
References: <20191011084038.45829-1-nuno.sa@analog.com>
        <20191011084038.45829-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 10:40:38 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Document the LTC2983 temperature sensor devicetree bindings.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

I'm happy with this, but will be waiting for Rob to have a chance
for a final look before applying.

Thanks,

Jonathan

> ---
> Changes in v2:
>  * Drop maxItems in non-array elements;
>  * Set adi,mux-delay-config-us instead of adi,mux-delay-config;
>  * Wrapped lines at 80 char;
>  * Added comas to enum elements;
>  * Use real units in adi,excitation-current;
>  * Moved some enums to minimum and maximum;
>  * Grouped patternProperties and moved reg property as a generic property.
>=20
> Changes in v3:
>  * Add meaning to adi,sensor-type values which are not const;
>  * Add meaning to adi,filter-notch-freq values;
>  * Break up adi,sensor-config into human readable elements;
>  * Set maxItems/minItems at the same identation as allOf in adi,custom-se=
nsor;
>  * Fixed the maximum value for adi,sensor-type for sensors with custom su=
pport;
>  * Changed license to GPL-2.0-only as it should be for new bindings;
>  * Changed spi0 to spi in the dts example;
>  * Updated the dts example to the new properties.
>=20
> Changes in v4:
>  * Set correct license for new bindings;
>  * Drop $ref for standard unit suffixes;
>  * Dropped adi,temperature-celcius;
>  * Drop '.*' in the patternProperties regex;
>  * Make min/man a single schema;
>  * Have rsense in milli ohms;
>  * Dropped '|' when no formatting is needed;
>  * Add matrixes for adi,custom-sensors;
>  * Rename adi,custom-sensor to a more appropriate and distinct name;
>  * Add adi,custom-stenheirt for thermistors.
>=20
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 478 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 479 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi=
,ltc2983.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc298=
3.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> new file mode 100644
> index 000000000000..b4946c6530c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -0,0 +1,478 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2983 Multi-sensor Temperature system
> +
> +maintainers:
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement Sy=
stem
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/29=
83fc.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2983
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  adi,mux-delay-config-us:
> +    description:
> +      The LTC2983 performs 2 or 3 internal conversion cycles per tempera=
ture
> +      result. Each conversion cycle is performed with different excitati=
on and
> +      input multiplexer configurations. Prior to each conversion, these
> +      excitation circuits and input switch configurations are changed an=
d an
> +      internal 1ms delay ensures settling prior to the conversion cycle =
in most
> +      cases. An extra delay can be configured using this property. The v=
alue is
> +      rounded to nearest 100us.
> +    maximum: 255
> +
> +  adi,filter-notch-freq:
> +    description:
> +      Set's the default setting of the digital filter. The default is
> +      simultaneous 50/60Hz rejection.
> +      0 - 50/60Hz rejection
> +      1 - 60Hz rejection
> +      2 - 50Hz rejection
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 2
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "@([1-9]|1[0-9]|20)$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. It can be connected to one of the 20 chann=
els of
> +          the device.
> +        minimum: 1
> +        maximum: 20
> +
> +      adi,sensor-type:
> +        description: Identifies the type of sensor connected to the devi=
ce.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    required:
> +      - reg
> +      - adi,sensor-type
> +
> +  "^thermocouple@":
> +    type: object
> +    description:
> +      Represents a thermocouple sensor which is connected to one of the =
device
> +      channels.
> +
> +    properties:
> +      adi,sensor-type:
> +        description: |
> +          1 - Type J Thermocouple
> +          2 - Type K Thermocouple
> +          3 - Type E Thermocouple
> +          4 - Type N Thermocouple
> +          5 - Type R Thermocouple
> +          6 - Type S Thermocouple
> +          7 - Type T Thermocouple
> +          8 - Type B Thermocouple
> +          9 - Custom Thermocouple
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 1
> +        maximum: 9
> +
> +      adi,single-ended:
> +        description:
> +          Boolean property which set's the thermocouple as single-ended.
> +        type: boolean
> +
> +      adi,sensor-oc-current-microamp:
> +        description:
> +          This property set's the pulsed current value applied during
> +          open-circuit detect.
> +        enum: [10, 100, 500, 1000]
> +
> +      adi,cold-junction-handle:
> +        description:
> +          Phandle which points to a sensor object responsible for measur=
ing
> +          the thermocouple cold junction temperature.
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +      adi,custom-thermocouple:
> +        description:
> +          This is a table, where each entry should be a pair of
> +          voltage(mv)-temperature(K). The entries must be given in nv an=
d uK
> +          so that, the original values must be multiplied by 1000000. For
> +          more details look at table 69 and 70.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/int64-matrix
> +        items:
> +          minItems: 3
> +          maxItems: 64
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +
> +  "^diode@":
> +    type: object
> +    description:
> +      Represents a diode sensor which is connected to one of the device
> +      channels.
> +
> +    properties:
> +      adi,sensor-type:
> +        description: Identifies the sensor as a diode.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        const: 28
> +
> +      adi,single-ended:
> +        description: Boolean property which set's the diode as single-en=
ded.
> +        type: boolean
> +
> +      adi,three-conversion-cycles:
> +        description:
> +          Boolean property which set's three conversion cycles removing
> +          parasitic resistance effects between the LTC2983 and the diode.
> +        type: boolean
> +
> +      adi,average-on:
> +        description:
> +          Boolean property which enables a running average of the diode
> +          temperature reading. This reduces the noise when the diode is =
used
> +          as a cold junction temperature element on an isothermal block
> +          where temperatures change slowly.
> +        type: boolean
> +
> +      adi,excitation-current-microamp:
> +        description:
> +          This property controls the magnitude of the excitation current
> +          applied to the diode. Depending on the number of conversions
> +          cycles, this property will assume different predefined values =
on
> +          each cycle. Just set the value of the first cycle (1l).
> +        enum: [10, 20, 40, 80]
> +
> +      adi,ideal-factor-value:
> +        description:
> +          This property sets the diode ideality factor. The real value m=
ust
> +          be multiplied by 1000000 to remove the fractional part. For mo=
re
> +          information look at table 20 of the datasheet.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  "^rtd@":
> +    type: object
> +    description:
> +      Represents a rtd sensor which is connected to one of the device ch=
annels.
> +
> +    properties:
> +      reg:
> +        minimum: 2
> +        maximum: 20
> +
> +      adi,sensor-type:
> +        description: |
> +          10 - RTD PT-10
> +          11 - RTD PT-50
> +          12 - RTD PT-100
> +          13 - RTD PT-200
> +          14 - RTD PT-500
> +          15 - RTD PT-1000
> +          16 - RTD PT-1000 (0.00375)
> +          17 - RTD NI-120
> +          18 - RTD Custom
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 10
> +        maximum: 18
> +
> +      adi,rsense-handle:
> +        description:
> +          Phandle pointing to a rsense object associated with this RTD.
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +      adi,number-of-wires:
> +        description:
> +          Identifies the number of wires used by the RTD. Setting this
> +          property to 5 means 4 wires with Kelvin Rsense.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [2, 3, 4, 5]
> +
> +      adi,rsense-share:
> +        description:
> +          Boolean property which enables Rsense sharing, where one sense
> +          resistor is used for multiple 2-, 3-, and/or 4-wire RTDs.
> +        type: boolean
> +
> +      adi,current-rotate:
> +        description:
> +          Boolean property which enables excitation current rotation to
> +          automatically remove parasitic thermocouple effects. Note that
> +          this property is not allowed for 2- and 3-wire RTDs.
> +        type: boolean
> +
> +      adi,excitation-current-microamp:
> +        description:
> +          This property controls the magnitude of the excitation current
> +          applied to the RTD.
> +        enum: [5, 10, 25, 50, 100, 250, 500, 1000]
> +
> +      adi,rtd-curve:
> +        description:
> +          This property set the RTD curve used and the corresponding
> +          Callendar-VanDusen constants. Look at table 30 of the datashee=
t.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 0
> +            maximum: 3
> +
> +      adi,custom-rtd:
> +        description:
> +          This is a table, where each entry should be a pair of
> +          resistance(ohm)-temperature(K). The entries added here are in =
uohm
> +          and uK. For more details values look at table 74 and 75.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint64-matrix
> +        items:
> +          minItems: 3
> +          maxItems: 64
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +
> +    required:
> +      - adi,rsense-handle
> +
> +    dependencies:
> +      adi,current-rotate: [ adi,rsense-share ]
> +
> +  "^thermistor@":
> +    type: object
> +    description:
> +      Represents a thermistor sensor which is connected to one of the de=
vice
> +      channels.
> +
> +    properties:
> +      adi,sensor-type:
> +        description:
> +          19 - Thermistor 44004/44033 2.252kohm at 25=C2=B0C
> +          20 - Thermistor 44005/44030 3kohm at 25=C2=B0C
> +          21 - Thermistor 44007/44034 5kohm at 25=C2=B0C
> +          22 - Thermistor 44006/44031 10kohm at 25=C2=B0C
> +          23 - Thermistor 44008/44032 30kohm at 25=C2=B0C
> +          24 - Thermistor YSI 400 2.252kohm at 25=C2=B0C
> +          25 - Thermistor Spectrum 1003k 1kohm
> +          26 - Thermistor Custom Steinhart-Hart
> +          27 - Custom Thermistor
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 19
> +        maximum: 27
> +
> +      adi,rsense-handle:
> +        description:
> +          Phandle pointing to a rsense object associated with this
> +          thermistor.
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +      adi,single-ended:
> +        description:
> +          Boolean property which set's the thermistor as single-ended.
> +        type: boolean
> +
> +      adi,rsense-share:
> +        description:
> +          Boolean property which enables Rsense sharing, where one sense
> +          resistor is used for multiple thermistors. Note that this prop=
erty
> +          is ignored if adi,single-ended is set.
> +        type: boolean
> +
> +      adi,current-rotate:
> +        description:
> +          Boolean property which enables excitation current rotation to
> +          automatically remove parasitic thermocouple effects.
> +        type: boolean
> +
> +      adi,excitation-current-nanoamp:
> +        description:
> +          This property controls the magnitude of the excitation current
> +          applied to the thermistor. Value 0 set's the sensor in auto-ra=
nge
> +          mode.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 250, 500, 1000, 5000, 10000, 25000, 50000, 100000,
> +                   250000, 500000, 1000000]
> +
> +      adi,custom-thermistor:
> +        description:
> +          This is a table, where each entry should be a pair of
> +          resistance(ohm)-temperature(K). The entries added here are in =
uohm
> +          and uK only for custom thermistors. For more details look at t=
able
> +          78 and 79.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint64-matrix
> +        items:
> +          minItems: 3
> +          maxItems: 64
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +
> +      adi,custom-steinhart:
> +        description:
> +          Steinhart-Hart coefficients are also supported and can
> +          be programmed into the device memory using this property. For
> +          Steinhart sensors the coefficients are given in the raw
> +          format. Look at table 82 for more information.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          minItems: 6
> +          maxItems: 6
> +
> +    required:
> +      - adi,rsense-handle
> +
> +    dependencies:
> +      adi,current-rotate: [ adi,rsense-share ]
> +
> +  "^adc@":
> +    type: object
> +    description: Represents a channel which is being used as a direct ad=
c.
> +
> +    properties:
> +      adi,sensor-type:
> +        description: Identifies the sensor as a direct adc.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        const: 30
> +
> +      adi,single-ended:
> +        description: Boolean property which set's the adc as single-ende=
d.
> +        type: boolean
> +
> +  "^rsense@":
> +    type: object
> +    description:
> +      Represents a rsense which is connected to one of the device channe=
ls.
> +      Rsense are used by thermistors and RTD's.
> +
> +    properties:
> +      reg:
> +        minimum: 2
> +        maximum: 20
> +
> +      adi,sensor-type:
> +        description: Identifies the sensor as a rsense.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        const: 29
> +
> +      adi,rsense-val-milli-ohms:
> +        description:
> +          Sets the value of the sense resistor. Look at table 20 of the
> +          datasheet for information.
> +
> +    required:
> +      - adi,rsense-val-milli-ohms
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        sensor_ltc2983: ltc2983@0 {
> +                compatible =3D "adi,ltc2983";
> +                reg =3D <0>;
> +
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                interrupts =3D <20 IRQ_TYPE_EDGE_RISING>;
> +                interrupt-parent =3D <&gpio>;
> +
> +                thermocouple@18 {
> +                        reg =3D <18>;
> +                        adi,sensor-type =3D <8>; //Type B
> +                        adi,sensor-oc-current-microamp =3D <10>;
> +                        adi,cold-junction-handle =3D <&diode5>;
> +                };
> +
> +                diode5: diode@5 {
> +                        reg =3D <5>;
> +                        adi,sensor-type =3D <28>;
> +                };
> +
> +                rsense2: rsense@2 {
> +                        reg =3D <2>;
> +                        adi,sensor-type =3D <29>;
> +                        adi,rsense-val-milli-ohms =3D <1200000>; //1.2Ko=
hms
> +                };
> +
> +                rtd@14 {
> +                        reg =3D <14>;
> +                        adi,sensor-type =3D <15>; //PT1000
> +                        /*2-wire, internal gnd, no current rotation*/
> +                        adi,number-of-wires =3D <2>;
> +                        adi,rsense-share;
> +                        adi,excitation-current-microamp =3D <500>;
> +                        adi,rsense-handle =3D <&rsense2>;
> +                };
> +
> +                adc@10 {
> +                        reg =3D <10>;
> +                        adi,sensor-type =3D <30>;
> +                        adi,single-ended;
> +                };
> +
> +                thermistor@12 {
> +                        reg =3D <12>;
> +                        adi,sensor-type =3D <26>; //Steinhart
> +                        adi,rsense-handle =3D <&rsense2>;
> +                        adi,custom-steinhart =3D <0x00F371EC 0x12345678
> +                                        0x2C0F8733 0x10018C66 0xA0FEACCD
> +                                        0x90021D99>; //6 entries
> +                };
> +
> +                thermocouple@20 {
> +                        reg =3D <20>;
> +                        adi,sensor-type =3D <9>; //custom thermocouple
> +                        adi,single-ended;
> +                        adi,custom-thermocouple =3D /bits/ 64
> +                                 <(-50220000) 0
> +                                  (-30200000) 99100000
> +                                  (-5300000) 135400000
> +                                  0 273150000
> +                                  40200000 361200000
> +                                  55300000 522100000
> +                                  88300000 720300000
> +                                  132200000 811200000
> +                                  188700000 922500000
> +                                  460400000 1000000000>; //10 pairs
> +               };
> +
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14a256e785ca..f747a9dc27f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9497,6 +9497,7 @@ W:	http://ez.analog.com/community/linux-device-driv=
ers
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/temperature/ltc2983.c
> +F:	Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> =20
>  LTC4261 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>

