Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5055D428932
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhJKI4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 04:56:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3954 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhJKI4G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 04:56:06 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSXYG48KFz6887d;
        Mon, 11 Oct 2021 16:49:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 10:53:18 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 09:53:17 +0100
Date:   Mon, 11 Oct 2021 09:52:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Chindris, Mihail" <Mihail.Chindris@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Message-ID: <20211011095259.0000037b@Huawei.com>
In-Reply-To: <SJ0PR03MB5791AE72F7666812DFD726B299B59@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20211008123909.1901-1-mihail.chindris@analog.com>
        <20211008123909.1901-2-mihail.chindris@analog.com>
        <20211010154856.29f4fd11@jic23-huawei>
        <SJ0PR03MB5791AE72F7666812DFD726B299B59@SJ0PR03MB5791.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.204]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Mon, 11 Oct 2021 08:37:44 +0000
"Chindris, Mihail" <Mihail.Chindris@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, 10 October 2021 17:49
> > To: Chindris, Mihail <Mihail.Chindris@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > Sa, Nuno <Nuno.Sa@analog.com>; Bogdan, Dragos
> > <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com; Mark
> > Brown <broonie@kernel.org>
> > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
> > 
> > On Fri, 8 Oct 2021 12:39:08 +0000
> > Mihail Chindris <mihail.chindris@analog.com> wrote:
> >   
> > > Add documentation for ad3552r
> > >
> > > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>  
> > Hi Mihael,
> > 
> > A few comments inline.
> > 
> > Thanks,
> > 
> > Jonathan

Just realized this is missing cc for Rob + dt list which is a must for
any new binding doc.  Query for Rob inline.

Thanks,

Jonathan

> >   
> > > ---
> > >  .../bindings/iio/dac/adi,ad3552r.yaml         | 199 ++++++++++++++++++
> > >  1 file changed, 199 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > new file mode 100644
> > > index 000000000000..1086e935d330
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > @@ -0,0 +1,199 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2020
> > > +Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > > +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/dac/adi
> > >  
> > +,ad3552r.yaml*__;Iw!!A3Ni8CS0y2Y!pqvd1NyV8G8KXIcfAtV1erPpylxLUGXD
> > 1Tx5  
> > > +UoK2MMNNgQpv5RSyFb6NQDSL0sEuJOI$
> > > +$schema:
> > > +https://urldefense.com/v3/__http://devicetree.org/meta-  
> > schemas/core.y  
> > >  
> > +aml*__;Iw!!A3Ni8CS0y2Y!pqvd1NyV8G8KXIcfAtV1erPpylxLUGXD1Tx5UoK2
> > MMNNgQ  
> > > +pv5RSyFb6NQDSL3G5680U$
> > > +
> > > +title: Analog Devices AD2552R DAC device driver
> > > +
> > > +maintainers:
> > > +  - Mihail Chindris <mihail.chindris@analog.com>
> > > +
> > > +description: |
> > > +  Bindings for the Analog Devices AD3552R  DAC device. Datasheet can
> > > +be  
> > 
> > Extra space before DAC, and doesn't mention the other supported part.
> > One option to avoid a never ending list is "and similar."
> >   
> > > +  found here:
> > > +
> > > + https://www.analog.com/media/en/technical-documentation/data-  
> > sheets/  
> > > + ad3552r.pdf  
> > 
> > Good to have datasheet for the other part as well as I don't think this is a
> > shared datasheet?
> >   
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad3552r
> > > +      - adi,ad3542r  
> > 
> > Alphabetical order preferred.
> >   
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 30000000
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +
> > > +  ldac-gpios:
> > > +    description: |
> > > +      If a LDAC gpio is specified it will generate a LDAC pulse each time the
> > > +      trigger handler sends data to the chip.  
> > 
> > Trigger handler is a linux concept. You need to write this more generically.
> > Something like.
> > 
> > "LDAC pin is used as a hardware trigger to update a set of DACs."
> > 
> >   
> > > +    maxItems: 1
> > > +
> > > +  vref-supply:
> > > +    description:
> > > +      The regulator to use as an external reference. If it does not exists the
> > > +      internal reference will be used. External reference must be
> > > + 2.5V
> > > +
> > > +  adi,vref-out-en:
> > > +    description: Vref I/O driven by internal vref to 2.5V. If not set, Vref pin
> > > +      will be floating.
> > > +    type: boolean
> > > +
> > > +  adi,sdo-drive-strength:
> > > +    description: |
> > > +      Configure SDIO0 and SDIO1 strength levels:
> > > +        - 0: low SDO drive strength.
> > > +        - 1: medium low SDO drive strength.
> > > +        - 2: medium high SDO drive strength.
> > > +        - 3: high SDO drive strength
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2, 3]
> > > +
> > > +patternProperties:
> > > +  "^channel@([0-1])$":
> > > +    type: object
> > > +    description: Configurations of the DAC Channels
> > > +    properties:
> > > +      reg:
> > > +          description: Channel number
> > > +          enum: [0, 1]
> > > +
> > > +      custom-output-range-config:  
> > 
> > Not a generic property so I think this needs an adi prefix.  
> 
> I tried with adi prefix but I get weird errors while running dt_binding_check for properties with adi prefix and with type:object
> Do you have any suggestion for this issues?

@Rob

> 
> > > +        type: object
> > > +        description: Configuration of custom range when
> > > +          adi,output-range-microvolt is not present.
> > > +          The formulas for calculation the output voltages are
> > > +            Vout_fs = 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.03]
> > > +            Vout_zs = 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.03]
> > > +        properties:
> > > +          adi,gain-offset:
> > > +            description: Gain offset used in the above formula
> > > +            $ref: /schemas/types.yaml#/definitions/int32
> > > +            maximum: 511
> > > +            minimum: -511
> > > +          adi,gain-scaling-p:
> > > +            description: |
> > > +              Scaling p:
> > > +               0: 1.0
> > > +               1: 0.5
> > > +               2: 0.25
> > > +               3: 0.125  
> > 
> > Given this is just a mapping to a simple set of values, could we just have the
> > values or express it as 1/(2^GainP) in the equation above and call it
> > adi,gain-scalling-inv-log2 or something like that?
> > 
> > If we can avoid a mapping table that is always a nice to have
> > 
> >   
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > +            enum: [0, 1, 2, 3]
> > > +          adi,gain-scaling-n:
> > > +            description: |
> > > +              Scaling p:
> > > +               0: 1.0
> > > +               1: 0.5
> > > +               2: 0.25
> > > +               3: 0.125
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > +            enum: [0, 1, 2, 3]
> > > +          adi,rfb-ohms:
> > > +            description: Feedback Resistor
> > > +        required:
> > > +          - adi,gain-offset
> > > +          - adi,gain-sacling-p
> > > +          - adi,gain-sacling-n
> > > +          - adi,rfb-ohms
> > > +    required:
> > > +      - reg
> > > +
> > > +    oneOf:
> > > +      # If adi,output-range is missing, custom-output-range-config
> > > + must be used  
> > 
> > adi,output-range-microvolt is missing...
> >   
> > > +      - required:
> > > +        - adi,output-range-microvolt
> > > +      - required:
> > > +        - custom-output-range-config
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: adi,ad3542r
> > > +    then:
> > > +      patternProperties:
> > > +        "^channel@([0-1])$":
> > > +          type: object
> > > +          properties:
> > > +            adi,output-range-microvolt:
> > > +              description: |
> > > +                Voltage output range of the channel as <minimum, maximum>
> > > +                Required connections:
> > > +                  Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
> > > +                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
> > > +              oneOf:
> > > +                - items:
> > > +                    - const: 0
> > > +                    - enum: [2500000, 3000000, 5000000, 10000000]
> > > +                - items:
> > > +                    - const: -2500000
> > > +                    - const: 7500000
> > > +                - items:
> > > +                    - const: -5000000
> > > +                    - const: 5000000
> > > +          required:
> > > +            - adi,output-range-microvolt
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: adi,ad3552r
> > > +    then:
> > > +      patternProperties:
> > > +        "^channel@([0-1])$":
> > > +          type: object
> > > +          properties:
> > > +            adi,output-range-microvolt: |
> > > +                Voltage output range of the channel as <minimum, maximum>
> > > +                Required connections:
> > > +                  Rfb1x for: 0 to 2.5 V; 0 to 5 V;
> > > +                  Rfb2x for: 0 to 10 V; -5 to 5 V;
> > > +                  Rfb4x for: -10 to 10V
> > > +              oneOf:
> > > +                - items:
> > > +                    - const: 0
> > > +                    - enum: [2500000, 5000000, 10000000]
> > > +                - items:
> > > +                    - const: -5000000
> > > +                    - const: 5000000
> > > +                - items:
> > > +                    - const: -10000000
> > > +                    - const: 10000000
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - spi-max-frequency
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    ad3552r {
> > > +            compatible = "adi,ad3552r";
> > > +            reg = <0>;
> > > +            spi-max-frequency = <20000000>;
> > > +            channel@0 {
> > > +                    reg = <0>;
> > > +                    adi,output-range-microvolt = <0 10000000>;
> > > +            };
> > > +            channel@1 {
> > > +                    reg = <1>;
> > > +                    custom-output-range-config {
> > > +                            adi,gain-offset = <5>;
> > > +                            adi,gain-scaling-p = <1>;
> > > +                            adi,gain-scaling-n = <2>;
> > > +                            adi,rfb-ohms = <1>;
> > > +                    };
> > > +          };
> > > +      };
> > > +...  
> 

