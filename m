Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616C4B224B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbfIMOgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 10:36:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35514 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbfIMOgZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 10:36:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so2830937oii.2;
        Fri, 13 Sep 2019 07:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gtIOueh3Qj+tvoj/XY90gI6jrWfVT6lRfdJ7RNwaLbs=;
        b=Yh1o5xSOyHd9bQtxVqLWzmYd1Q0ha7A4lMjQZie5s+WJS+TGtjHTqyOdqntiQzWbQK
         +mmyoDs8PhqDK4Yl7nA4o4hZkLbuF15Unbu6AO6nQARxidGO1QVK1RECv9IHWv/EAxlh
         N39CWQ6lqQUKk1BLgNPXGtNppCAuwFevDgxSbmzFuzY8EhdUssc0f4ORu6bf/kw6PYMZ
         JHW6uBewwV/8INeiSNpqwq5vODKRACuwyXmEhYdtbVEbQAxwUH3cRD+cZzxvXfnJY9FL
         haGRYqQtynn9e50gC24/gN2DE/+pivP0Qk9J+NOlaOqb697Q0ie4Lc+6hEMtAprhKyzR
         RpIw==
X-Gm-Message-State: APjAAAUgpv9EZglamfQ1CBPhc5K/K4vdjtpFMA+h4zWgLjQTtGF82Adg
        5IYimeLNq2MzJmc5VqQIHOBys64=
X-Google-Smtp-Source: APXvYqxyM58CFhGdX5XjjSAkoSYu8bWd8GY4McJ17MTJhwSwoMG/Ioe1GXqoWUurQmeheDGc61rpZA==
X-Received: by 2002:a05:6808:3b2:: with SMTP id n18mr3419237oie.134.1568385383115;
        Fri, 13 Sep 2019 07:36:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l47sm9612616ota.56.2019.09.13.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:22 -0700 (PDT)
Date:   Fri, 13 Sep 2019 15:36:21 +0100
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20190912173046.GA22533@bogus>
References: <20190909144550.164488-1-nuno.sa@analog.com>
 <20190909144550.164488-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909144550.164488-2-nuno.sa@analog.com>
X-Mutt-References: <20190909144550.164488-2-nuno.sa@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 09, 2019 at 04:45:50PM +0200, Nuno Sá wrote:
> Document the LTC2983 temperature sensor devicetree bindings.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 442 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 443 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> new file mode 100644
> index 000000000000..2b468b3ed177
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -0,0 +1,442 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2983 Multi-sensor Temperature system
> +
> +maintainers:
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
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
> +      If this property is present, the temperature is reported in Celsius.
> +    type: boolean
> +    maxItems: 1

It's a boolean, not an array so 'maxItems' doesn't make sense.

Running 'make dt_binding_check' should tell you this. You may need to 
update dt-schema install though.

> +
> +  adi,mux-delay-config:
> +    description:
> +      The LTC2983 performs 2 or 3 internal conversion cycles per temperature result.
> +      Each conversion cycle is performed with different excitation and input multiplexer
> +      configurations. Prior to each conversion, these excitation circuits and input
> +      switch configurations are changed and an internal 1ms delay ensures settling prior
> +      to the conversion cycle in most cases. An extra delay can be configured using this
> +      property. The value written here is multiplied by 100us.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - maximum: 255
> +        maxItems: 1

Drop this.

> +
> +  adi,filter-notch-freq:
> +    description:
> +      Set's the default setting of the digital filter. The default is simultaneous
> +      50/60Hz rejection.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2]
> +    maxItems: 1

Drop this.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^thermocouple@([1-9]|1[0-9]|20)$":
> +    type: object
> +    description: Represents a thermocouple sensor which is connected to one of the device channels.

Wrap lines at 80 char.

> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can be connected to one of the 20 channels of the device.
> +          Note that, for differential thermocouples, the minimum is 2.
> +        minimum: 1
> +        maximum: 20
> +        maxItems: 1

Drop this and pretty much everywhere else that is never an array.

> +
> +      adi,sensor-type:
> +        description: |
> +           Identifies the type of thermocouple connected to the device.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [1 2 3 4 5 6 7 8]

Missing commas which may not even parse. Maybe be consistent with 
elsewhere and use minimum and maximum.

> +        maxItems: 1
> +
> +      adi,sensor-config:
> +        description: |
> +          Raw value which set's the sensor configuration. Look at table 14 of the
> +          datasheet for how to set this value for thermocouples.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 1
> +          - maximun: 15
> +        maxItems: 1
> +
> +      adi,cold-junction-handle:
> +        description: |
> +          Phandle which points to a sensor object responsible for measuring the
> +          thermocouple cold junction temperature.
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +        maxItems: 1
> +
> +      adi,custom-sensor:
> +        description: |
> +          This is a table, where each entry should be a pair of voltage(mv)-temperature(K).
> +          The entries must be given in nv and uK so that, the original values must be
> +          multiplied by 1000000. For more details look at table 69 and 70.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/int64-array
> +        minItems: 6
> +        maxItems: 128
> +    required:
> +      - reg
> +      - adi,sensor-type
> +
> +patternProperties:
> +  "^diode@([1-9]|1[0-9]|20)$":
> +    type: object
> +    description: Represents a diode sensor which is connected to one of the device channels.
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. It can be connected to one of the 20 channels of the device.
> +          Note that, for differential diodes, the minimum is 2.
> +        minimum: 1
> +        maximum: 20
> +        maxItems: 1
> +
> +      adi,sensor-type:
> +        description: |
> +          Identifies the sensor as a diode.
> +        const: 28
> +        maxItems: 1
> +
> +      adi,sensor-config:
> +        description: |
> +          Raw value which set's the sensor configuration. Look at table 17 of the
> +          datasheet for how to set this value for diodes.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0 1 2 3 4 5 6 7]
> +        maxItems: 1
> +
> +      adi,excitation-current:
> +        description: |
> +          This property controls the magnitude of the excitation current applied
> +          to the diode. Look at table 19 of the datasheet for more info.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0 1 2 3]
> +        maxItems: 1
> +
> +      adi,ideal-factor-value:
> +        description: |
> +          This property sets the diode ideality factor. The real value must be
> +          multiplied by 1000000 to remove the fractional part. For more information
> +          look at table 20 of the datasheet.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - adi,sensor-type
> +
> +patternProperties:
> +  "^rtd@([2-9]|1[0-9]|20)$":
> +    type: object
> +    description: Represents a rtd sensor which is connected to one of the device channels.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can be connected to one of the 20 channels of the device.
> +        minimum: 2
> +        maximum: 20
> +        maxItems: 1

As this is pretty much the same for all child nodes, make a pattern that 
matches all child nodes and put this there rather than duplicating it. 
Then you only need 'minimum: 2' in the cases needing that.

> +
> +      adi,sensor-type:
> +        description: |
> +          Identifies the type of RTD connected to the device.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [10 11 12 13 14 15 16 17]
> +        maxItems: 1
> +
> +      adi,rsense-handle:
> +        description: |
> +          Phandle pointing to a rsense object associated with this RTD.
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +        maxItems: 1
> +
> +      adi,sensor-config:
> +        description: |
> +          Raw value which set's the sensor configuration. Look at table 28 of the
> +          datasheet for how to set this value for RTD's.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0 1 4 5 8 9 10 12 13 14]
> +        maxItems: 1
> +
> +      adi,excitation-current:
> +        description: |
> +          This property controls the magnitude of the excitation current applied
> +          to the RTD. Look at table 29 of the datasheet for more info.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [1 2 3 4 5 6 7 8]
> +        maxItems: 1
> +
> +      adi,rtd-curve:
> +        description: |
> +          This property set the RTD curve used and the corresponding Callendar-Van
> +          Dusen constants. Look at table 30 of the datasheet.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0 1 2 3]
> +        maxItems: 1
> +
> +      adi,custom-sensor:
> +        description: |
> +          This is a table, where each entry should be a pair of resistance(ohm)-temperature(K).
> +          The entries added here are in uohm and uK. For more details values look at table 74 and 75.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint64-array
> +        minItems: 6
> +        maxItems: 128
> +    required:
> +      - reg
> +      - adi,sensor-type
> +      - adi,rsense-handle
> +
> +patternProperties:
> +  "^thermistor@([1-9]|1[0-9]|20)$":
> +    type: object
> +    description: Represents a thermistor sensor which is connected to one of the device channels.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can be connected to one of the 20 channels of the device.
> +          Note that, for differential thermistors, the minimum is 2.
> +        minimum: 1
> +        maximum: 20
> +        maxItems: 1
> +
> +      adi,sensor-type:
> +        description: |
> +          Identifies the type of thermistor connected to the device.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [19 20 21 22 23 24 25]
> +        maxItems: 1
> +
> +      adi,rsense-handle:
> +        description: |
> +          Phandle pointing to a rsense object associated with this thermistor.
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +        maxItems: 1
> +
> +      adi,sensor-config:
> +        description: |
> +          Raw value which set's the sensor configuration. Look at table 52 of the
> +          datasheet for how to set this value for thermistors.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0 1 2 4]
> +        maxItems: 1
> +
> +      adi,excitation-current:
> +        description: |
> +          This property controls the magnitude of the excitation current applied
> +          to the thermistor. Look at table 53 of the datasheet for more info.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +          - enum: [1 2 3 4 5 6 7 8 9 10 11 12]
> +        maxItems: 1
> +
> +      adi,custom-sensor:
> +        description: |
> +          This is a table, where each entry should be a pair of resistance(ohm)-temperature(K).
> +          The entries added here are in uohm and uK only for custom thermistors.
> +          For more details look at table 78 and 79.
> +          Steinhart-Hart coefficients are also supported and can be programmed into the
> +          device memory using this property. For Steinhart sensors, this table has a constant
> +          size of 6 entries (defining the coefficients) and the values are given in the raw format.
> +          Look at table 82 for more information.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint64-array
> +        minItems: 6
> +        maxItems: 128
> +    required:
> +      - reg
> +      - adi,sensor-type
> +      - adi,rsense-handle
> +
> +patternProperties:
> +  "^adc@([1-9]|1[0-9]|20)$":
> +    type: object
> +    description: Represents a channel which is being used as a direct adc.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can be connected to one of the 20 channels of the device.
> +          Note that, for differential adc's, the minimum is 2.
> +        minimum: 1
> +        maximum: 20
> +        maxItems: 1
> +
> +      adi,sensor-type:
> +        description: |
> +          Identifies the sensor as a direct adc.
> +        const: 30
> +        maxItems: 1
> +
> +      adi,single-ended:
> +        description: |
> +          Boolean property which set's the adc as single-ended.
> +        type: boolean
> +
> +    required:
> +      - reg
> +      - adi,sensor-type
> +
> +patternProperties:
> +  "^rsense@([2-9]|1[0-9]|20)$":
> +    type: object
> +    description: |
> +      Represents a rsense which is connected to one of the device channels.
> +      Rsense are used by thermistors and RTD's.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can be connected to one of the 20 channels of the device.
> +        minimum: 2
> +        maximum: 20
> +        maxItems: 1
> +
> +      adi,sensor-type:
> +        description: |
> +          Identifies the sensor as a rsense.
> +        const: 29
> +        maxItems: 1
> +
> +      adi,rsense-val-micro-ohms:
> +        description: |
> +          Sets the value of the sense resistor. Look at table 20 of the datasheet
> +          for information.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint64
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - adi,sensor-type
> +      - adi, rsense-val
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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor_ltc2983: ltc2983@0 {
> +                compatible = "adi,ltc2983";
> +                reg = <0>;
> +
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                adi,temperature-celcius;
> +                interrupts = <20 IRQ_TYPE_EDGE_RISING>;
> +                interrupt-parent = <&gpio>;
> +
> +                thermocouple@18 {
> +                        reg = <18>;
> +                        adi,sensor-type = <8>; //Type B
> +                        adi,sensor-config = <1>; //Differential, open-circuit current
> +                        adi,cold-junction-handle = <&diode5>;
> +                };
> +
> +                diode5: diode@5 {
> +                        reg = <5>;
> +                        adi,sensor-type = <28>;
> +                };
> +
> +                rsense2: rsense@2 {
> +                        reg = <2>;
> +                        adi,sensor-type = <29>;
> +                        adi,rsense-val-micro-ohms = /bits/ 64 <1200000000>; //1.2Kohms
> +                };
> +
> +                rtd@14 {
> +                        reg = <14>;
> +                        adi,sensor-type = <15>; //PT1000
> +                        /*2-wire, internal gnd, no current rotation*/
> +                        adi,sensor-config = <1>;
> +                        adi,excitation-current = <7>; //500uA
> +                        adi,rsense-handle = <&rsense2>;
> +                };
> +
> +                adc@10 {
> +                        reg = <10>;
> +                        adi,sensor-type = <30>;
> +                        adi,single-ended;
> +                };
> +
> +                thermistor@12 {
> +                        reg = <12>;
> +                        adi,sensor-type = <26>; //Steinhart
> +                        adi,rsense-handle = <&rsense2>;
> +                        adi,custom-sensor = /bits/ 64 <0x00F371EC 0x12345678
> +                                        0x2C0F8733 0x10018C66 0xA0FEACCD
> +                                        0x90021D99>; //6 entries
> +                };
> +
> +                thermocouple@20 {
> +                        reg = <20>;
> +                        adi,sensor-type = <9>; //custom thermocouple
> +                        adi,sensor-config = <8>; //single-ended
> +                        adi,custom-sensor = /bits/ 64
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
> @@ -9497,6 +9497,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/temperature/ltc2983.c
> +F:	Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>  
>  LTC4261 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
> -- 
> 2.23.0
> 

