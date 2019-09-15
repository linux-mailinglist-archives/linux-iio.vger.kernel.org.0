Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30433B2FA9
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfIOLH5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 07:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfIOLH5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 07:07:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2220420644;
        Sun, 15 Sep 2019 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568545675;
        bh=N60qCukOgdBtqv3amHswcJSBI5tn+hqgWfUlYagnbFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MIRXyZjBgbhkbQsCsZi4NJS/P8A1T946cDIiud6mrrhbuM8qlOT0fEQKSVBZ+y2qk
         TMXkFIcNyDBMBGoBpsD891wGMZjPokn6fvvoMs3oDt3AkNNixfGutNvi+P4vITa4dY
         QjST/vBGrbMTCNfmRj1Ge9sYeLksdEkIrBpuxvQQ=
Date:   Sun, 15 Sep 2019 12:07:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20190915120750.7a4d3bcd@archlinux>
In-Reply-To: <20190912173046.GA22533@bogus>
References: <20190909144550.164488-1-nuno.sa@analog.com>
        <20190909144550.164488-2-nuno.sa@analog.com>
        <20190912173046.GA22533@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 15:36:21 +0100
Rob Herring <robh@kernel.org> wrote:

> On Mon, Sep 09, 2019 at 04:45:50PM +0200, Nuno S=C3=A1 wrote:
> > Document the LTC2983 temperature sensor devicetree bindings.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> >  .../bindings/iio/temperature/adi,ltc2983.yaml | 442 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 443 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/a=
di,ltc2983.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2=
983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.ya=
ml
> > new file mode 100644
> > index 000000000000..2b468b3ed177
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > @@ -0,0 +1,442 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2983 Multi-sensor Temperature system
> > +
> > +maintainers:
> > +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> > +
> > +description: |
> > +  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement =
System
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
2983fc.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ltc2983
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  adi,temperature-celcius:
> > +    description:
> > +      If this property is present, the temperature is reported in Cels=
ius.
> > +    type: boolean
> > +    maxItems: 1 =20
>=20
> It's a boolean, not an array so 'maxItems' doesn't make sense.
>=20
> Running 'make dt_binding_check' should tell you this. You may need to=20
> update dt-schema install though.
>=20
> > +
> > +  adi,mux-delay-config:
> > +    description:
> > +      The LTC2983 performs 2 or 3 internal conversion cycles per tempe=
rature result.
> > +      Each conversion cycle is performed with different excitation and=
 input multiplexer
> > +      configurations. Prior to each conversion, these excitation circu=
its and input
> > +      switch configurations are changed and an internal 1ms delay ensu=
res settling prior
> > +      to the conversion cycle in most cases. An extra delay can be con=
figured using this
> > +      property. The value written here is multiplied by 100us.

Make this adi,mux-delay-config-us and state it is rounded to nearest 100us.

> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - maximum: 255
> > +        maxItems: 1 =20
>=20
> Drop this.
>=20
> > +
> > +  adi,filter-notch-freq:
> > +    description:
> > +      Set's the default setting of the digital filter. The default is =
simultaneous
> > +      50/60Hz rejection.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [0, 1, 2]
> > +    maxItems: 1 =20
>=20
> Drop this.
>=20
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^thermocouple@([1-9]|1[0-9]|20)$":
> > +    type: object
> > +    description: Represents a thermocouple sensor which is connected t=
o one of the device channels. =20
>=20
> Wrap lines at 80 char.
>=20
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number. It can be connected to one of the 20 cha=
nnels of the device.
> > +          Note that, for differential thermocouples, the minimum is 2.
> > +        minimum: 1
> > +        maximum: 20
> > +        maxItems: 1 =20
>=20
> Drop this and pretty much everywhere else that is never an array.
>=20
> > +
> > +      adi,sensor-type:
> > +        description: |
> > +           Identifies the type of thermocouple connected to the device.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [1 2 3 4 5 6 7 8] =20
>=20
> Missing commas which may not even parse. Maybe be consistent with=20
> elsewhere and use minimum and maximum.
>=20
> > +        maxItems: 1
> > +
> > +      adi,sensor-config:
> > +        description: |
> > +          Raw value which set's the sensor configuration. Look at tabl=
e 14 of the
> > +          datasheet for how to set this value for thermocouples.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - minimum: 1
> > +          - maximun: 15
> > +        maxItems: 1
> > +
> > +      adi,cold-junction-handle:
> > +        description: |
> > +          Phandle which points to a sensor object responsible for meas=
uring the
> > +          thermocouple cold junction temperature.
> > +        $ref: "/schemas/types.yaml#/definitions/phandle"
> > +        maxItems: 1
> > +
> > +      adi,custom-sensor:
> > +        description: |
> > +          This is a table, where each entry should be a pair of voltag=
e(mv)-temperature(K).
> > +          The entries must be given in nv and uK so that, the original=
 values must be
> > +          multiplied by 1000000. For more details look at table 69 and=
 70.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/int64-array
> > +        minItems: 6
> > +        maxItems: 128
> > +    required:
> > +      - reg
> > +      - adi,sensor-type
> > +
> > +patternProperties:
> > +  "^diode@([1-9]|1[0-9]|20)$":
> > +    type: object
> > +    description: Represents a diode sensor which is connected to one o=
f the device channels.
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          The channel number. It can be connected to one of the 20 cha=
nnels of the device.
> > +          Note that, for differential diodes, the minimum is 2.
> > +        minimum: 1
> > +        maximum: 20
> > +        maxItems: 1
> > +
> > +      adi,sensor-type:
> > +        description: |
> > +          Identifies the sensor as a diode.
> > +        const: 28
> > +        maxItems: 1
> > +
> > +      adi,sensor-config:
> > +        description: |
> > +          Raw value which set's the sensor configuration. Look at tabl=
e 17 of the
> > +          datasheet for how to set this value for diodes.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [0 1 2 3 4 5 6 7]
> > +        maxItems: 1
> > +
> > +      adi,excitation-current:
> > +        description: |
> > +          This property controls the magnitude of the excitation curre=
nt applied
> > +          to the diode. Look at table 19 of the datasheet for more inf=
o.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [0 1 2 3]
> > +        maxItems: 1
> > +
> > +      adi,ideal-factor-value:
> > +        description: |
> > +          This property sets the diode ideality factor. The real value=
 must be
> > +          multiplied by 1000000 to remove the fractional part. For mor=
e information
> > +          look at table 20 of the datasheet.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +        maxItems: 1
> > +
> > +    required:
> > +      - reg
> > +      - adi,sensor-type
> > +
> > +patternProperties:
> > +  "^rtd@([2-9]|1[0-9]|20)$":
> > +    type: object
> > +    description: Represents a rtd sensor which is connected to one of =
the device channels.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number. It can be connected to one of the 20 cha=
nnels of the device.
> > +        minimum: 2
> > +        maximum: 20
> > +        maxItems: 1 =20
>=20
> As this is pretty much the same for all child nodes, make a pattern that=
=20
> matches all child nodes and put this there rather than duplicating it.=20
> Then you only need 'minimum: 2' in the cases needing that.
>=20
> > +
> > +      adi,sensor-type:
> > +        description: |
> > +          Identifies the type of RTD connected to the device.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [10 11 12 13 14 15 16 17]
> > +        maxItems: 1
> > +
> > +      adi,rsense-handle:
> > +        description: |
> > +          Phandle pointing to a rsense object associated with this RTD.
> > +        $ref: "/schemas/types.yaml#/definitions/phandle"
> > +        maxItems: 1
> > +
> > +      adi,sensor-config:
> > +        description: |
> > +          Raw value which set's the sensor configuration. Look at tabl=
e 28 of the
> > +          datasheet for how to set this value for RTD's.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [0 1 4 5 8 9 10 12 13 14]
> > +        maxItems: 1
> > +
> > +      adi,excitation-current:
> > +        description: |
> > +          This property controls the magnitude of the excitation curre=
nt applied
> > +          to the RTD. Look at table 29 of the datasheet for more info.

Any way we can make this real units?  Can list valid value here.

> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [1 2 3 4 5 6 7 8]
> > +        maxItems: 1
> > +
> > +      adi,rtd-curve:
> > +        description: |
> > +          This property set the RTD curve used and the corresponding C=
allendar-Van
> > +          Dusen constants. Look at table 30 of the datasheet.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [0 1 2 3]
> > +        maxItems: 1
> > +
> > +      adi,custom-sensor:
> > +        description: |
> > +          This is a table, where each entry should be a pair of resist=
ance(ohm)-temperature(K).
> > +          The entries added here are in uohm and uK. For more details =
values look at table 74 and 75.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint64-array
> > +        minItems: 6
> > +        maxItems: 128
> > +    required:
> > +      - reg
> > +      - adi,sensor-type
> > +      - adi,rsense-handle
> > +
> > +patternProperties:
> > +  "^thermistor@([1-9]|1[0-9]|20)$":
> > +    type: object
> > +    description: Represents a thermistor sensor which is connected to =
one of the device channels.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number. It can be connected to one of the 20 cha=
nnels of the device.
> > +          Note that, for differential thermistors, the minimum is 2.
> > +        minimum: 1
> > +        maximum: 20
> > +        maxItems: 1
> > +
> > +      adi,sensor-type:
> > +        description: |
> > +          Identifies the type of thermistor connected to the device.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [19 20 21 22 23 24 25]
> > +        maxItems: 1
> > +
> > +      adi,rsense-handle:
> > +        description: |
> > +          Phandle pointing to a rsense object associated with this the=
rmistor.
> > +        $ref: "/schemas/types.yaml#/definitions/phandle"
> > +        maxItems: 1
> > +
> > +      adi,sensor-config:
> > +        description: |
> > +          Raw value which set's the sensor configuration. Look at tabl=
e 52 of the
> > +          datasheet for how to set this value for thermistors.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [0 1 2 4]
> > +        maxItems: 1
> > +
> > +      adi,excitation-current:
> > +        description: |
> > +          This property controls the magnitude of the excitation curre=
nt applied
> > +          to the thermistor. Look at table 53 of the datasheet for mor=
e info.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +          - enum: [1 2 3 4 5 6 7 8 9 10 11 12]
> > +        maxItems: 1
> > +
> > +      adi,custom-sensor:
> > +        description: |
> > +          This is a table, where each entry should be a pair of resist=
ance(ohm)-temperature(K).
> > +          The entries added here are in uohm and uK only for custom th=
ermistors.
> > +          For more details look at table 78 and 79.
> > +          Steinhart-Hart coefficients are also supported and can be pr=
ogrammed into the
> > +          device memory using this property. For Steinhart sensors, th=
is table has a constant
> > +          size of 6 entries (defining the coefficients) and the values=
 are given in the raw format.
> > +          Look at table 82 for more information.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint64-array
> > +        minItems: 6
> > +        maxItems: 128
> > +    required:
> > +      - reg
> > +      - adi,sensor-type
> > +      - adi,rsense-handle
> > +
> > +patternProperties:
> > +  "^adc@([1-9]|1[0-9]|20)$":
> > +    type: object
> > +    description: Represents a channel which is being used as a direct =
adc.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number. It can be connected to one of the 20 cha=
nnels of the device.
> > +          Note that, for differential adc's, the minimum is 2.
> > +        minimum: 1
> > +        maximum: 20
> > +        maxItems: 1
> > +
> > +      adi,sensor-type:
> > +        description: |
> > +          Identifies the sensor as a direct adc.
> > +        const: 30
> > +        maxItems: 1
> > +
> > +      adi,single-ended:
> > +        description: |
> > +          Boolean property which set's the adc as single-ended.
> > +        type: boolean
> > +
> > +    required:
> > +      - reg
> > +      - adi,sensor-type
> > +
> > +patternProperties:
> > +  "^rsense@([2-9]|1[0-9]|20)$":
> > +    type: object
> > +    description: |
> > +      Represents a rsense which is connected to one of the device chan=
nels.
> > +      Rsense are used by thermistors and RTD's.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number. It can be connected to one of the 20 cha=
nnels of the device.
> > +        minimum: 2
> > +        maximum: 20
> > +        maxItems: 1
> > +
> > +      adi,sensor-type:
> > +        description: |
> > +          Identifies the sensor as a rsense.
> > +        const: 29
> > +        maxItems: 1
> > +
> > +      adi,rsense-val-micro-ohms:
> > +        description: |
> > +          Sets the value of the sense resistor. Look at table 20 of th=
e datasheet
> > +          for information.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint64
> > +        maxItems: 1
> > +
> > +    required:
> > +      - reg
> > +      - adi,sensor-type
> > +      - adi, rsense-val
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        sensor_ltc2983: ltc2983@0 {
> > +                compatible =3D "adi,ltc2983";
> > +                reg =3D <0>;
> > +
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                adi,temperature-celcius;
> > +                interrupts =3D <20 IRQ_TYPE_EDGE_RISING>;
> > +                interrupt-parent =3D <&gpio>;
> > +
> > +                thermocouple@18 {
> > +                        reg =3D <18>;
> > +                        adi,sensor-type =3D <8>; //Type B
> > +                        adi,sensor-config =3D <1>; //Differential, ope=
n-circuit current
> > +                        adi,cold-junction-handle =3D <&diode5>;
> > +                };
> > +
> > +                diode5: diode@5 {
> > +                        reg =3D <5>;
> > +                        adi,sensor-type =3D <28>;
> > +                };
> > +
> > +                rsense2: rsense@2 {
> > +                        reg =3D <2>;
> > +                        adi,sensor-type =3D <29>;
> > +                        adi,rsense-val-micro-ohms =3D /bits/ 64 <12000=
00000>; //1.2Kohms
> > +                };
> > +
> > +                rtd@14 {
> > +                        reg =3D <14>;
> > +                        adi,sensor-type =3D <15>; //PT1000
> > +                        /*2-wire, internal gnd, no current rotation*/
> > +                        adi,sensor-config =3D <1>;
> > +                        adi,excitation-current =3D <7>; //500uA
> > +                        adi,rsense-handle =3D <&rsense2>;
> > +                };
> > +
> > +                adc@10 {
> > +                        reg =3D <10>;
> > +                        adi,sensor-type =3D <30>;
> > +                        adi,single-ended;
> > +                };
> > +
> > +                thermistor@12 {
> > +                        reg =3D <12>;
> > +                        adi,sensor-type =3D <26>; //Steinhart
> > +                        adi,rsense-handle =3D <&rsense2>;
> > +                        adi,custom-sensor =3D /bits/ 64 <0x00F371EC 0x=
12345678
> > +                                        0x2C0F8733 0x10018C66 0xA0FEAC=
CD
> > +                                        0x90021D99>; //6 entries
> > +                };
> > +
> > +                thermocouple@20 {
> > +                        reg =3D <20>;
> > +                        adi,sensor-type =3D <9>; //custom thermocouple
> > +                        adi,sensor-config =3D <8>; //single-ended
> > +                        adi,custom-sensor =3D /bits/ 64
> > +                                 <(-50220000) 0
> > +                                  (-30200000) 99100000
> > +                                  (-5300000) 135400000
> > +                                  0 273150000
> > +                                  40200000 361200000
> > +                                  55300000 522100000
> > +                                  88300000 720300000
> > +                                  132200000 811200000
> > +                                  188700000 922500000
> > +                                  460400000 1000000000>; //10 pairs
> > +               };
> > +
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 14a256e785ca..f747a9dc27f5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9497,6 +9497,7 @@ W:	http://ez.analog.com/community/linux-device-dr=
ivers
> >  L:	linux-iio@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/iio/temperature/ltc2983.c
> > +F:	Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > =20
> >  LTC4261 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> > --=20
> > 2.23.0
> >  =20
>=20

