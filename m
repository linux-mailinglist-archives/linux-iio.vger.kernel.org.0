Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64165D4F17
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfJLKoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 06:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfJLKmC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 06:42:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADC52089F;
        Sat, 12 Oct 2019 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570876919;
        bh=uTkK5l8Fz/hNLewIKUcb5RPMu5+fPxrbKcmqH9EVaJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CpyzdTghUgYmK1uh3/GGSzDTvZm6w50mtjPYm8+UMtFghcwE+5K0ixgnxf/KVOxb6
         t/5WTEG/IK8JRTWwyqXS3Ikkh9ifdK2zHyB5UU/PIYoJ9Si8bCPjBeSpLQSkriffoo
         cf0oFAc0PWY2J1wGxxoyRgDlsdNLS1d024fCoi4o=
Date:   Sat, 12 Oct 2019 11:41:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20191012114154.185a4b09@archlinux>
In-Reply-To: <27ff86f12b6f0e667c75014dfa0ce8f87087ba4e.camel@analog.com>
References: <20191004135519.191657-1-nuno.sa@analog.com>
        <20191004135519.191657-2-nuno.sa@analog.com>
        <CAL_Jsq+a7t5ZGf+7=LD2BnGRexJb6wpbBvvSFncgBKV-h3-7MA@mail.gmail.com>
        <27ff86f12b6f0e667c75014dfa0ce8f87087ba4e.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 16:17:02 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> On Mon, 2019-10-07 at 09:45 -0500, Rob Herring wrote:
> > On Fri, Oct 4, 2019 at 8:55 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:=
 =20
> > > Document the LTC2983 temperature sensor devicetree bindings.
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > > Changes in v2:
> > >  * Drop maxItems in non-array elements;
> > >  * Set adi,mux-delay-config-us instead of adi,mux-delay-config;
> > >  * Wrapped lines at 80 char;
> > >  * Added comas to enum elements;
> > >  * Use real units in adi,excitation-current;
> > >  * Moved some enums to minimum and maximum;
> > >  * Grouped patternProperties and moved reg property as a generic
> > > property.
> > >=20
> > > Changes in v3:
> > >  * Add meaning to adi,sensor-type values which are not const;
> > >  * Add meaning to adi,filter-notch-freq values;
> > >  * Break up adi,sensor-config into human readable elements;
> > >  * Set maxItems/minItems at the same identation as allOf in
> > > adi,custom-sensor;
> > >  * Fixed the maximum value for adi,sensor-type for sensors with
> > > custom support;
> > >  * Changed license to GPL-2.0-only as it should be for new
> > > bindings;
> > >  * Changed spi0 to spi in the dts example;
> > >  * Updated the dts example to the new properties.
> > >=20
> > >  .../bindings/iio/temperature/adi,ltc2983.yaml | 479
> > > ++++++++++++++++++
> > >  MAINTAINERS                                   |   1 +
> > >  2 files changed, 480 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > new file mode 100644
> > > index 000000000000..b7101a0e84db
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > @@ -0,0 +1,479 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only =20
> >=20
> > (GPL-2.0-only OR BSD-2-Clause) for new bindings please. =20
>=20
> ack.
>=20
> > > +%YAML 1.2
> > > +---
> > > +$id:=20
> > > http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices LTC2983 Multi-sensor Temperature system
> > > +
> > > +maintainers:
> > > +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> > > +
> > > +description: |
> > > +  Analog Devices LTC2983 Multi-Sensor Digital Temperature
> > > Measurement System
> > > + =20
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/2=
983fc.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ltc2983
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  adi,temperature-celcius: =20
> >=20
> > -celsius. However, that suffix is reserved for properties whose value
> > is in Celsius, so you'll have to come up with something else.
> >=20
> > How does one decide how to set this? Seems like the driver should
> > just
> > decide based on what it needs to present to the user. =20
>=20
> The device can report temperature in Celsius or Fahrenheit and that
> should be decided once. Hmm but now that I think about this, the iio
> standard attributes expect the value to be reported in milli degrees
> Celsius so I guess I should just drop this and don't report in
> Fahrenheit. Would this be ok Jonathan?

Guessing you've already done this, but yes I'm fine with just not
supporting Fahrenheit at all.


>=20
> > > +    description:
> > > +      If this property is present, the temperature is reported in
> > > Celsius.
> > > +    type: boolean
> > > +
> > > +  adi,mux-delay-config-us:
> > > +    description:
> > > +      The LTC2983 performs 2 or 3 internal conversion cycles per
> > > temperature
> > > +      result. Each conversion cycle is performed with different
> > > excitation and
> > > +      input multiplexer configurations. Prior to each conversion,
> > > these
> > > +      excitation circuits and input switch configurations are
> > > changed and an
> > > +      internal 1ms delay ensures settling prior to the conversion
> > > cycle in most
> > > +      cases. An extra delay can be configured using this property.
> > > The value is
> > > +      rounded to nearest 100us.
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - maximum: 255 =20
> >=20
> > Standard unit suffixes already have a type, so just:
> >=20
> > maximum: 255 =20
>=20
> got it.
>=20
> > > +
> > > +  adi,filter-notch-freq:
> > > +    description:
> > > +      Set's the default setting of the digital filter. The default
> > > is
> > > +      simultaneous 50/60Hz rejection.
> > > +      0 - 50/60Hz rejection
> > > +      1 - 60Hz rejection
> > > +      2 - 50Hz rejection
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 2 =20
> >=20
> > Drop the '-' on the last entry (making the min/max a single schema). =20
>=20
> got it.
>=20
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  ".*@([1-9]|1[0-9]|20)$": =20
> >=20
> > '.*' can be dropped.
> >  =20
> > > +    type: object
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: |
> > > +          The channel number. It can be connected to one of the 20
> > > channels of
> > > +          the device.
> > > +        minimum: 1
> > > +        maximum: 20
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +    patternProperties:
> > > +      "^thermocouple@.*": =20
> >=20
> > You've made this node a child of '.*@([1-9]|1[0-9]|20)$'. This needs
> > to be at the same level. =20
>=20
> You mean dropping "patternProperties" and having "^thermocouple@.*": on
> the same indent as ".*@([1-9]|1[0-9]|20)$":? It seems to be only one
> working. I understood and tried something like:
>=20
> patternProperties:
>   "@([1-9]|1[0-9]|20)$":
>    (...)
>   =20
>    patternProperties:
>      "^thermocouple@.*"
>      description: "..."
>      type: object
>      properties:
>      (...)
>=20
> But this throws "'^thermocouple@' is not one of ['$ref',
> 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const',
> 'contains', 'default', 'dependencies', 'deprecated', 'description',
> 'else', 'enum', 'items', 'if', 'minItems', 'minimum', 'maxItems',
> 'maximum', 'not', 'oneOf', 'pattern', 'patternProperties',
> 'properties', 'required', 'then', 'type', 'typeSize']"
>=20
> Also, should I also drop the ".*" in "^thermocouple@.*"?
> > > +        type: object
> > > +        description: | =20
> >=20
> > You can drop the '|' where you don't need any formatting. =20
>=20
> got it.
>=20
> > > +          Represents a thermocouple sensor which is connected to
> > > one of the device
> > > +          channels.
> > > +
> > > +        properties:
> > > +          adi,sensor-type:
> > > +            description: |
> > > +              Identifies the type of thermocouple connected to the
> > > device.
> > > +              1 - Type J Thermocouple
> > > +              2 - Type K Thermocouple
> > > +              3 - Type E Thermocouple
> > > +              4 - Type N Thermocouple
> > > +              5 - Type R Thermocouple
> > > +              6 - Type S Thermocouple
> > > +              7 - Type T Thermocouple
> > > +              8 - Type B Thermocouple
> > > +              9 - Custom Thermocouple
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32 =20
> >=20
> > You can move the type definition under ".*@([1-9]|1[0-9]|20)$" and
> > then just have the min/max here. =20
>=20
> And how could I add meaning to the values. Could I add all in the
> "parent" node?
>=20
> > > +              - minimum: 1
> > > +              - maximum: 9
> > > +
> > > +          adi,single-ended:
> > > +            description: |
> > > +              Boolean property which set's the thermocouple as
> > > single-ended.
> > > +            type: boolean
> > > +
> > > +          adi,sensor-oc-current-microamp:
> > > +            description: |
> > > +              This property set's the pulsed current value applied
> > > during
> > > +              open-circuit detect.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +              - enum: [10, 100, 500, 1000]
> > > +
> > > +          adi,cold-junction-handle:
> > > +            description: |
> > > +              Phandle which points to a sensor object responsible
> > > for measuring
> > > +              the thermocouple cold junction temperature.
> > > +            $ref: "/schemas/types.yaml#/definitions/phandle"
> > > +
> > > +          adi,custom-sensor:
> > > +            description: |
> > > +              This is a table, where each entry should be a pair
> > > of
> > > +              voltage(mv)-temperature(K). The entries must be
> > > given in nv and uK
> > > +              so that, the original values must be multiplied by
> > > 1000000. For =20
> >=20
> > We normally do things in microVolts. It seems strange to need 64-bits
> > of range for voltage and temperature. =20
>=20
> This device support very high resolutions (so we have fractional
> values). That is why I'm multiplying by 1000000 and using nV. And even
> so, I already loose some bits. The 64bits are needed mainly because of
> the Temperature and again the resolution I want to maximize. Doing
> int(max(temp)) * 1000000, we need 64bits.
>=20
> >  =20
> > > +              more details look at table 69 and 70.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/int64-array =
=20
> >=20
> > Fails on 'make dt_binding_check':
> >=20
> > Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml:
> > Unresolvable JSON pointer: 'definitions/int64-array' =20
>=20
> I was aware of this but I do not know how to proceed so I was waiting
> for your comment. I do have negative values, so uint does not apply.
> What can I use here?
>=20
> > If this is pairs of values, it should really be defined as a matrix:
> >=20
> > minItems: 3
> > maxItems: 64
> > items:
> >   minItems: 2
> >   maxItems: 2
> >=20
> > Though I'll need to add uint64-matrix as a type (assuming this really
> > needs to be 64-bit). =20
>=20
> I reinforce that I do need signed values here.
>=20
> >  =20
> > > +            minItems: 6
> > > +            maxItems: 128
> > > +
> > > +        required:
> > > +          - adi,sensor-type
> > > +
> > > +      "^diode@.*":
> > > +        type: object
> > > +        description: |
> > > +          Represents a diode sensor which is connected to one of
> > > the device
> > > +          channels.
> > > +
> > > +        properties:
> > > +          adi,sensor-type:
> > > +            description: Identifies the sensor as a diode.
> > > +            const: 28
> > > +
> > > +          adi,single-ended:
> > > +            description: Boolean property which set's the diode as
> > > single-ended.
> > > +            type: boolean
> > > +
> > > +          adi,three-conversion-cycles:
> > > +            description: |
> > > +              Boolean property which set's three conversion cycles
> > > removing
> > > +              parasitic resistance effects between the LTC2983 and
> > > the diode.
> > > +            type: boolean
> > > +
> > > +          adi,average-on:
> > > +            description: |
> > > +              Boolean property which enables a running average of
> > > the diode
> > > +              temperature reading. This reduces the noise when the
> > > diode is used
> > > +              as a cold junction temperature element on an
> > > isothermal block
> > > +              where temperatures change slowly.
> > > +            type: boolean
> > > +
> > > +          adi,excitation-current-microamp:
> > > +            description: |
> > > +              This property controls the magnitude of the
> > > excitation current
> > > +              applied to the diode. Depending on the number of
> > > conversions
> > > +              cycles, this property will assume different
> > > predefined values on
> > > +              each cycle. Just set the value of the first cycle
> > > (1l).
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +              - enum: [10, 20, 40, 80]
> > > +
> > > +          adi,ideal-factor-value:
> > > +            description: |
> > > +              This property sets the diode ideality factor. The
> > > real value must
> > > +              be multiplied by 1000000 to remove the fractional
> > > part. For more
> > > +              information look at table 20 of the datasheet.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +        required:
> > > +          - adi,sensor-type
> > > +
> > > +      "^rtd@.*":
> > > +        type: object
> > > +        description: |
> > > +          Represents a rtd sensor which is connected to one of the
> > > device channels.
> > > +
> > > +        properties:
> > > +          reg:
> > > +            minimum: 2
> > > +
> > > +          adi,sensor-type:
> > > +            description: |
> > > +              Identifies the type of RTD connected to the device.
> > > +              10 - RTD PT-10
> > > +              11 - RTD PT-50
> > > +              12 - RTD PT-100
> > > +              13 - RTD PT-200
> > > +              14 - RTD PT-500
> > > +              15 - RTD PT-1000
> > > +              16 - RTD PT-1000 (0.00375)
> > > +              17 - RTD NI-120
> > > +              18 - RTD Custom
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +              - minimum: 10
> > > +              - maximum: 18
> > > +
> > > +          adi,rsense-handle:
> > > +            description: |
> > > +              Phandle pointing to a rsense object associated with
> > > this RTD.
> > > +            $ref: "/schemas/types.yaml#/definitions/phandle"
> > > +
> > > +          adi,number-of-wires:
> > > +            description: |
> > > +              Identifies the number of wires used by the RTD.
> > > Setting this
> > > +              property to 5 means 4 wires with Kelvin Rsense.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +              - enum: [2, 3, 4, 5]
> > > +
> > > +          adi,rsense-share:
> > > +            description: |
> > > +              Boolean property which enables Rsense sharing, where
> > > one sense
> > > +              resistor is used for multiple 2-, 3-, and/or 4-wire
> > > RTDs.
> > > +            type: boolean
> > > +
> > > +          adi,current-rotate:
> > > +            description: |
> > > +              Boolean property which enables excitation current
> > > rotation to
> > > +              automatically remove parasitic thermocouple effects.
> > > Note that
> > > +              this property is not allowed for 2- and 3-wire RTDs.
> > > +            type: boolean
> > > +
> > > +          adi,excitation-current-microamp:
> > > +            description: |
> > > +              This property controls the magnitude of the
> > > excitation current
> > > +              applied to the RTD.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32 =20
> >=20
> > You can drop the type here too. =20
>=20
> got it.
>=20
> > > +              - enum: [5, 10, 25, 50, 100, 250, 500, 1000]
> > > +
> > > +          adi,rtd-curve:
> > > +            description: |
> > > +              This property set the RTD curve used and the
> > > corresponding
> > > +              Callendar-VanDusen constants. Look at table 30 of
> > > the datasheet.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +              - minimum: 0
> > > +              - maximum: 3
> > > +
> > > +          adi,custom-sensor:
> > > +            description: |
> > > +              This is a table, where each entry should be a pair
> > > of
> > > +              resistance(ohm)-temperature(K). The entries added
> > > here are in uohm
> > > +              and uK. For more details values look at table 74 and
> > > 75. =20
> >=20
> > It's not great to make one property name have different meanings. =20
>=20
> Would you prefer to have something like "custom-rtd", "custom-
> thermoucouple" and so on? I would have to adapt the code but I don't
> think it would need to much of a change.
>=20
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint64-
> > > array
> > > +            minItems: 6
> > > +            maxItems: 128
> > > +
> > > +        required:
> > > +          - adi,sensor-type
> > > +          - adi,rsense-handle
> > > +
> > > +        dependencies:
> > > +          adi,current-rotate: [ adi,rsense-share ]
> > > +
> > > +      "^thermistor@.*":
> > > +        type: object
> > > +        description: |
> > > +          Represents a thermistor sensor which is connected to one
> > > of the device
> > > +          channels.
> > > +
> > > +        properties:
> > > +          adi,sensor-type:
> > > +            description: |
> > > +              Identifies the type of thermistor connected to the
> > > +              device.
> > > +              19 - Thermistor 44004/44033 2.252kohm at 25=C2=B0C
> > > +              20 - Thermistor 44005/44030 3kohm at 25=C2=B0C
> > > +              21 - Thermistor 44007/44034 5kohm at 25=C2=B0C
> > > +              22 - Thermistor 44006/44031 10kohm at 25=C2=B0C
> > > +              23 - Thermistor 44008/44032 30kohm at 25=C2=B0C
> > > +              24 - Thermistor YSI 400 2.252kohm at 25=C2=B0C
> > > +              25 - Thermistor Spectrum 1003k 1kohm
> > > +              26 - Thermistor Custom Steinhart-Hart
> > > +              27 - Custom Thermistor
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +              - minimum: 19
> > > +              - maximum: 27
> > > +
> > > +          adi,rsense-handle:
> > > +            description: |
> > > +              Phandle pointing to a rsense object associated with
> > > this
> > > +              thermistor.
> > > +            $ref: "/schemas/types.yaml#/definitions/phandle"
> > > +
> > > +          adi,single-ended:
> > > +            description: |
> > > +              Boolean property which set's the thermistor as
> > > single-ended.
> > > +            type: boolean
> > > +
> > > +          adi,rsense-share:
> > > +            description: |
> > > +              Boolean property which enables Rsense sharing, where
> > > one sense
> > > +              resistor is used for multiple thermistors. Note that
> > > this property
> > > +              is ignored if adi,single-ended is set.
> > > +            type: boolean
> > > +
> > > +          adi,current-rotate:
> > > +            description: |
> > > +              Boolean property which enables excitation current
> > > rotation to
> > > +              automatically remove parasitic thermocouple effects.
> > > +            type: boolean
> > > +
> > > +          adi,excitation-current-nanoamp:
> > > +            description: |
> > > +              This property controls the magnitude of the
> > > excitation current
> > > +              applied to the thermistor. Value 0 set's the sensor
> > > in auto-range
> > > +              mode.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32
> > > +              - enum: [0, 250, 500, 1000, 5000, 10000, 25000,
> > > 50000, 100000,
> > > +                       250000, 500000, 1000000]
> > > +
> > > +          adi,custom-sensor:
> > > +            description: |
> > > +              This is a table, where each entry should be a pair
> > > of
> > > +              resistance(ohm)-temperature(K). The entries added
> > > here are in uohm
> > > +              and uK only for custom thermistors. For more details
> > > look at table
> > > +              78 and 79. Steinhart-Hart coefficients are also
> > > supported and can
> > > +              be programmed into the device memory using this
> > > property. For
> > > +              Steinhart sensors, this table has a constant size of
> > > 6 entries
> > > +              (defining the coefficients) and the values are given
> > > in the raw
> > > +              format. Look at table 82 for more information.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint64-
> > > array
> > > +            minItems: 6
> > > +            maxItems: 128
> > > + =20
>=20
> If I'm to replace this property as proposed before, would it make sense
> also to split this in custom-thermistor and custom-steinhart or just
> steinhart?
>=20
> > > +        required:
> > > +          - adi,sensor-type
> > > +          - adi,rsense-handle
> > > +
> > > +        dependencies:
> > > +          adi,current-rotate: [ adi,rsense-share ]
> > > +
> > > +      "^adc@.*":
> > > +        type: object
> > > +        description: Represents a channel which is being used as a
> > > direct adc.
> > > +
> > > +        properties:
> > > +          adi,sensor-type:
> > > +            description: Identifies the sensor as a direct adc.
> > > +            const: 30
> > > +
> > > +          adi,single-ended:
> > > +            description: Boolean property which set's the adc as
> > > single-ended.
> > > +            type: boolean
> > > +
> > > +        required:
> > > +          - adi,sensor-type
> > > +
> > > +      "^rsense@.*":
> > > +        type: object
> > > +        description: |
> > > +          Represents a rsense which is connected to one of the
> > > device channels.
> > > +          Rsense are used by thermistors and RTD's.
> > > +
> > > +        properties:
> > > +          reg:
> > > +            minimum: 2
> > > +
> > > +          adi,sensor-type:
> > > +            description: Identifies the sensor as a rsense.
> > > +            const: 29
> > > +
> > > +          adi,rsense-val-micro-ohms:
> > > +            description: |
> > > +              Sets the value of the sense resistor. Look at table
> > > 20 of the
> > > +              datasheet for information.
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint64 =20
> >=20
> > -micro-ohms is already defined to be 32-bit. =20
> =20
> I do need a 64-bit variable here. Should I still remove the $ref or how
> can I proceed?
>=20
> > > +
> > > +        required:
> > > +          - adi,sensor-type
> > > +          - adi, rsense-val =20
> >=20
> > spurious space. =20
>=20
> got it.
>=20
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    spi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        sensor_ltc2983: ltc2983@0 {
> > > +                compatible =3D "adi,ltc2983";
> > > +                reg =3D <0>;
> > > +
> > > +                #address-cells =3D <1>;
> > > +                #size-cells =3D <0>;
> > > +
> > > +                adi,temperature-celcius;
> > > +                interrupts =3D <20 IRQ_TYPE_EDGE_RISING>;
> > > +                interrupt-parent =3D <&gpio>;
> > > +
> > > +                thermocouple@18 {
> > > +                        reg =3D <18>;
> > > +                        adi,sensor-type =3D <8>; //Type B
> > > +                        adi,sensor-oc-current-microamp =3D <10>;
> > > +                        adi,cold-junction-handle =3D <&diode5>;
> > > +                };
> > > +
> > > +                diode5: diode@5 {
> > > +                        reg =3D <5>;
> > > +                        adi,sensor-type =3D <28>;
> > > +                };
> > > +
> > > +                rsense2: rsense@2 {
> > > +                        reg =3D <2>;
> > > +                        adi,sensor-type =3D <29>;
> > > +                        adi,rsense-val-micro-ohms =3D /bits/ 64
> > > <1200000000>; //1.2Kohms
> > > +                };
> > > +
> > > +                rtd@14 {
> > > +                        reg =3D <14>;
> > > +                        adi,sensor-type =3D <15>; //PT1000
> > > +                        /*2-wire, internal gnd, no current
> > > rotation*/
> > > +                        adi,number-of-wires =3D <2>;
> > > +                        adi,rsense-share;
> > > +                        adi,excitation-current-microamp =3D <500>;
> > > +                        adi,rsense-handle =3D <&rsense2>;
> > > +                };
> > > +
> > > +                adc@10 {
> > > +                        reg =3D <10>;
> > > +                        adi,sensor-type =3D <30>;
> > > +                        adi,single-ended;
> > > +                };
> > > +
> > > +                thermistor@12 {
> > > +                        reg =3D <12>;
> > > +                        adi,sensor-type =3D <26>; //Steinhart
> > > +                        adi,rsense-handle =3D <&rsense2>;
> > > +                        adi,custom-sensor =3D /bits/ 64 <0x00F371EC
> > > 0x12345678
> > > +                                        0x2C0F8733 0x10018C66
> > > 0xA0FEACCD
> > > +                                        0x90021D99>; //6 entries
> > > +                };
> > > +
> > > +                thermocouple@20 {
> > > +                        reg =3D <20>;
> > > +                        adi,sensor-type =3D <9>; //custom
> > > thermocouple
> > > +                        adi,single-ended;
> > > +                        adi,custom-sensor =3D /bits/ 64
> > > +                                 <(-50220000) 0
> > > +                                  (-30200000) 99100000
> > > +                                  (-5300000) 135400000
> > > +                                  0 273150000
> > > +                                  40200000 361200000
> > > +                                  55300000 522100000
> > > +                                  88300000 720300000
> > > +                                  132200000 811200000
> > > +                                  188700000 922500000
> > > +                                  460400000 1000000000>; //10
> > > pairs
> > > +               };
> > > +
> > > +        };
> > > +    };
> > > +...
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 14a256e785ca..f747a9dc27f5 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9497,6 +9497,7 @@ W:       =20
> > > http://ez.analog.com/community/linux-device-drivers
> > >  L:     linux-iio@vger.kernel.org
> > >  S:     Supported
> > >  F:     drivers/iio/temperature/ltc2983.c
> > > +F:     Documentation/devicetree/bindings/iio/temperature/adi,ltc29
> > > 83.yaml
> > >=20
> > >  LTC4261 HARDWARE MONITOR DRIVER
> > >  M:     Guenter Roeck <linux@roeck-us.net>
> > > --
> > > 2.23.0
> > >  =20
>=20

