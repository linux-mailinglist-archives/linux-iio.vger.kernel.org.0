Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0BC2FD7
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 11:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfJAJQU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 05:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729864AbfJAJQU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Oct 2019 05:16:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A421720700;
        Tue,  1 Oct 2019 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569921378;
        bh=CR0Hfm+Tk3cWMojCH3jgwU204pzx0Ey94J1Y+MXUmWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b954Jl4jQEyWzDrpCzLKCr4l//JidUwPLWG1DsZUfulNhZkj3/3/kpgirpHph36NE
         2d4mwtNVzVGIkq4LFXZbJwZihNz5pfz07NRkmb3uQnxRySfDSA2oCsZdbDYrHr9Kl2
         PYTROuGhtFY5IoLJIs4LowBrRwMoDUC42iX77bx0=
Date:   Tue, 1 Oct 2019 10:16:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v2 2/2] dt-bindings: iio: Add ltc2983
 documentation
Message-ID: <20191001101613.50d825a9@archlinux>
In-Reply-To: <20190930104247.21519-2-nuno.sa@analog.com>
References: <20190930104247.21519-1-nuno.sa@analog.com>
        <20190930104247.21519-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Sep 2019 12:42:47 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Document the LTC2983 temperature sensor devicetree bindings.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Hi Nuno,

A few comments inline.  This is a complex one so I'll definitely be
looking for a review from Rob or Mark,

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
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 406 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 407 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi=
,ltc2983.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc298=
3.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> new file mode 100644
> index 000000000000..df68b8233e5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -0,0 +1,406 @@
> +# SPDX-License-Identifier: GPL-2.0
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
> +  adi,temperature-celcius:
> +    description:
> +      If this property is present, the temperature is reported in Celsiu=
s.
> +    type: boolean
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
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - maximum: 255
> +
> +  adi,filter-notch-freq:
> +    description:
> +      Set's the default setting of the digital filter. The default is
> +      simultaneous 50/60Hz rejection.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 2

This one is an oddity and you should define what the 3 values mean.
If the sensor had supported no notch rejection at all rather than just
50, 60, 50/60 I would have suggested two bools but as it stands I guess
this will just need to be an enum.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  ".*@([1-9]|1[0-9]|20)$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can be connected to one of the 20 chann=
els of
> +          the device.
> +        minimum: 1
> +        maximum: 20
> +
> +    required:
> +      - reg
> +
> +    patternProperties:
> +      "^thermocouple@.*":
> +        type: object
> +        description: |
> +          Represents a thermocouple sensor which is connected to one of =
the device
> +          channels.
> +
> +        properties:
> +          adi,sensor-type:
> +            description: |
> +              Identifies the type of thermocouple connected to the devic=
e.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 1
> +              - maximum: 8

Meaning of values should be defined...

> +
> +          adi,sensor-config:
> +            description: |
> +              Raw value which set's the sensor configuration. Look at ta=
ble 14
> +              of the datasheet for how to set this value for thermocoupl=
es.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 1
> +              - maximun: 15
Hmm.  Whilst there are quite a few things in here, it would be nice to brea=
k it up
into human readable elements.  It's only 3 things and there are a bunch of =
don't
care states it seems.

> +
> +          adi,cold-junction-handle:
> +            description: |
> +              Phandle which points to a sensor object responsible for me=
asuring
> +              the thermocouple cold junction temperature.
> +            $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +          adi,custom-sensor:
> +            description: |
> +              This is a table, where each entry should be a pair of
> +              voltage(mv)-temperature(K). The entries must be given in n=
v and uK
> +              so that, the original values must be multiplied by 1000000=
. For
> +              more details look at table 69 and 70.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/int64-array
> +              - minItems: 6
> +              - maxItems: 128
> +
> +        required:
> +          - adi,sensor-type
> +
> +      "^diode@.*":
> +        type: object
> +        description: |
> +          Represents a diode sensor which is connected to one of the dev=
ice
> +          channels.
> +
> +        properties:
> +          adi,sensor-type:
> +            description: Identifies the sensor as a diode.
> +            const: 28
> +
> +          adi,sensor-config:
> +            description: |
> +              Raw value which set's the sensor configuration. Look at ta=
ble 17
> +              of the datasheet for how to set this value for diodes.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 0
> +              - maximum: 7
Another one I'd like to see broken up.

> +
> +          adi,excitation-current-microamp:
> +            description: |
> +              This property controls the magnitude of the excitation cur=
rent
> +              applied to the diode. Depending on the number of conversio=
ns
> +              cycles, this property will assume different predefined val=
ues on
> +              each cycle. Just set the value of the first cycle (1l).
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - enum: [10, 20, 40, 80]
> +
> +          adi,ideal-factor-value:
> +            description: |
> +              This property sets the diode ideality factor. The real val=
ue must
> +              be multiplied by 1000000 to remove the fractional part. Fo=
r more
> +              information look at table 20 of the datasheet.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +        required:
> +          - adi,sensor-type
> +
> +      "^rtd@.*":
> +        type: object
> +        description: |
> +          Represents a rtd sensor which is connected to one of the devic=
e channels.
> +
> +        properties:
> +          reg:
> +            minimum: 2
> +
> +          adi,sensor-type:
> +            description: Identifies the type of RTD connected to the dev=
ice.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 10
> +              - maximum: 17
> +
> +          adi,rsense-handle:
> +            description: |
> +              Phandle pointing to a rsense object associated with this R=
TD.
> +            $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +          adi,sensor-config:
> +            description: |
> +              Raw value which set's the sensor configuration. Look at ta=
ble 28
> +              of the datasheet for how to set this value for RTD's.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - enum: [0, 1, 4, 5, 8, 9, 10, 12, 13, 14]

Another one to break up into it's parts, which would also get rid of the
enum with gaps element.

> +
> +          adi,excitation-current-microamp:
> +            description: |
> +              This property controls the magnitude of the excitation cur=
rent
> +              applied to the RTD.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - enum: [5, 10, 25, 50, 100, 250, 500, 1000]
> +
> +          adi,rtd-curve:
> +            description: |
> +              This property set the RTD curve used and the corresponding
> +              Callendar-VanDusen constants. Look at table 30 of the data=
sheet.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 0
> +              - maximum: 3
> +
> +          adi,custom-sensor:
> +            description: |
> +              This is a table, where each entry should be a pair of
> +              resistance(ohm)-temperature(K). The entries added here are=
 in uohm
> +              and uK. For more details values look at table 74 and 75.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint64-array
> +              - minItems: 6
> +              - maxItems: 128
> +
> +        required:
> +          - adi,sensor-type
> +          - adi,rsense-handle
> +
> +      "^thermistor@.*":
> +        type: object
> +        description: |
> +          Represents a thermistor sensor which is connected to one of th=
e device
> +          channels.
> +
> +        properties:
> +          adi,sensor-type:
> +            description: |
> +              Identifies the type of thermistor connected to the
> +              device.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 19
> +              - maximum: 25
> +
> +          adi,rsense-handle:
> +            description: |
> +              Phandle pointing to a rsense object associated with this
> +              thermistor.
> +            $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +          adi,sensor-config:
> +            description: |
> +              Raw value which set's the sensor configuration. Look at ta=
ble 52
> +              of the datasheet for how to set this value for thermistors.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - minimum: 0
> +              - maximum: 4
Nasty as value 3 is reserved.  So break this one up into it's parts as well.

> +
> +          adi,excitation-current-nanoamp:
> +            description: |
> +              This property controls the magnitude of the excitation cur=
rent
> +              applied to the thermistor. Value 0 set's the sensor in aut=
o-range
> +              mode.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32
> +              - enum: [0, 250, 500, 1000, 5000, 10000, 25000, 50000, 100=
000,
> +                       250000, 500000, 1000000]
> +
> +          adi,custom-sensor:
> +            description: |
> +              This is a table, where each entry should be a pair of
> +              resistance(ohm)-temperature(K). The entries added here are=
 in uohm
> +              and uK only for custom thermistors. For more details look =
at table
> +              78 and 79. Steinhart-Hart coefficients are also supported =
and can
> +              be programmed into the device memory using this property. =
For
> +              Steinhart sensors, this table has a constant size of 6 ent=
ries
> +              (defining the coefficients) and the values are given in th=
e raw
> +              format. Look at table 82 for more information.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint64-array
> +              - minItems: 6
> +              - maxItems: 128
> +
> +        required:
> +          - adi,sensor-type
> +          - adi,rsense-handle
> +
> +      "^adc@.*":
> +        type: object
> +        description: Represents a channel which is being used as a direc=
t adc.
> +
> +        properties:
> +          adi,sensor-type:
> +            description: Identifies the sensor as a direct adc.
> +            const: 30
> +
> +          adi,single-ended:
> +            description: Boolean property which set's the adc as single-=
ended.
> +            type: boolean
> +
> +        required:
> +          - adi,sensor-type
> +
> +      "^rsense@.*":
> +        type: object
> +        description: |
> +          Represents a rsense which is connected to one of the device ch=
annels.
> +          Rsense are used by thermistors and RTD's.
> +
> +        properties:
> +          reg:
> +            minimum: 2
> +
> +          adi,sensor-type:
> +            description: Identifies the sensor as a rsense.
> +            const: 29
> +
> +          adi,rsense-val-micro-ohms:
> +            description: |
> +              Sets the value of the sense resistor. Look at table 20 of =
the
> +              datasheet for information.
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint64
> +
> +        required:
> +          - adi,sensor-type
> +          - adi, rsense-val
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
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
> +                adi,temperature-celcius;
> +                interrupts =3D <20 IRQ_TYPE_EDGE_RISING>;
> +                interrupt-parent =3D <&gpio>;
> +
> +                thermocouple@18 {
> +                        reg =3D <18>;
> +                        adi,sensor-type =3D <8>; //Type B
> +                        adi,sensor-config =3D <1>; //Differential, open-=
circuit current
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
> +                        adi,rsense-val-micro-ohms =3D /bits/ 64 <1200000=
000>; //1.2Kohms
> +                };
> +
> +                rtd@14 {
> +                        reg =3D <14>;
> +                        adi,sensor-type =3D <15>; //PT1000
> +                        /*2-wire, internal gnd, no current rotation*/
> +                        adi,sensor-config =3D <1>;
> +                        adi,excitation-current =3D <7>; //500uA
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
> +                        adi,custom-sensor =3D /bits/ 64 <0x00F371EC 0x12=
345678
> +                                        0x2C0F8733 0x10018C66 0xA0FEACCD
> +                                        0x90021D99>; //6 entries
> +                };
> +
> +                thermocouple@20 {
> +                        reg =3D <20>;
> +                        adi,sensor-type =3D <9>; //custom thermocouple
> +                        adi,sensor-config =3D <8>; //single-ended
> +                        adi,custom-sensor =3D /bits/ 64
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

