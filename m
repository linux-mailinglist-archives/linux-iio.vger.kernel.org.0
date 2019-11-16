Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26FFECA3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKPOR1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 09:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfKPOR0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 09:17:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5EBA20700;
        Sat, 16 Nov 2019 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573913845;
        bh=IwWhjnQQurXGL6YaWJ0AL8wyJICBm4HdB8eUbNAyVw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QG4pt/ZUfWNKE4YhFasqayF0q8NpCHzddJitnzZ+D0zg2cKe0xS8sKAZ2etNa8wPM
         uZLaNW+MjC9RCn0XyKH3JmrI27oe/OwQNdC3iUWCYV62FfC8fFGaNiOWu/v0h3W9kS
         J26okFzLwNy33XaGDApX+lG+Kp7BDmjIxoWZt4pQ=
Date:   Sat, 16 Nov 2019 14:17:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add support for AD5940
Message-ID: <20191116141719.35a9208e@archlinux>
In-Reply-To: <c4f649be-de4f-1762-7748-88ebac6d0d53@gmail.com>
References: <20191108130946.14740-1-songqiang1304521@gmail.com>
        <CAL_JsqLZL3Tzzv7MQ4i_KeXgM2yu8LJ+B62aOVvKyAswswD25w@mail.gmail.com>
        <c4f649be-de4f-1762-7748-88ebac6d0d53@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Nov 2019 01:06:32 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> Thanks, I'll see how to use 'lable' to pass name of channels, other
> problems will be fixed in the next patch.
For a channel, it will be a new thing. We can introduce it in a
similar fashion to you did for channel-name but ultimately I think we
want to make it a standard part of the IIO core.

However, for either to happen the key thing is a documentation patch
describing it so that we can get the discussion going!

Thanks,

Jonathan

> 
> yours,
> Song Qiang
> 
> On 11/14/19 9:28 AM, Rob Herring wrote:
> > On Fri, Nov 8, 2019 at 7:09 AM Song Qiang <songqiang1304521@gmail.com> wrote:  
> >>
> >> Add yaml devicetree description file and a header file for
> >> helping configure positive and negtive input of AD5940.
> >>
> >> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> >> ---
> >>  .../bindings/iio/adc/adi,ad5940.yaml          | 240 ++++++++++++++++++
> >>  include/dt-bindings/iio/adc/adi,ad5940.h      |  52 ++++
> >>  2 files changed, 292 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
> >>  create mode 100644 include/dt-bindings/iio/adc/adi,ad5940.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
> >> new file mode 100644
> >> index 000000000000..f7f034fdd8ec
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
> >> @@ -0,0 +1,240 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright 2019 Analog Devices Inc.
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad5940.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Analog Devices AD5940 Device Tree Bindings
> >> +
> >> +maintainers:
> >> +  - Song Qiang <songqiang1304521@gmail.com>
> >> +
> >> +description: |
> >> +  Analog Devices AD5940 High Precision, Impedance, and Electrochemical Front End.
> >> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD5940.pdf
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - adi,ad5940
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  vref-supply:
> >> +    description:
> >> +      The regulator to be used to supply the reference voltage.
> >> +    maxItems: 1
> >> +
> >> +  adi,interrupt-io:
> >> +    description:
> >> +      Output GPIO index of interrupt controller of AD5940.
> >> +    maxItems: 1
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +      - enum: [0, 3, 6, 7]
> >> +
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 0
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts
> >> +  - adi,interrupt-io
> >> +
> >> +patternProperties:
> >> +  # 'channel@0-255'
> >> +  "^channel@([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$":
> >> +    type: object
> >> +    description: |
> >> +      Represents the external channels which are connected to the ADC.
> >> +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> >> +    properties:
> >> +      reg:
> >> +        description:
> >> +          Index of this channel, must be starting from 0.
> >> +        maxItems: 1  
> > 
> > Drop maxItems and do:
> > 
> > items:
> >   - minimum: 0
> >     maximum: 255
> >   
> >> +
> >> +      diff-channels:
> >> +        description:
> >> +          Positive input and negtive input of the ADC buffer of this channel.
> >> +          Input candidates are defined in include/dt-bindings/iio/adc/adi,ad5940.h.
> >> +        minItems: 2
> >> +        maxItems: 2
> >> +        items:
> >> +          - description: Positive input channel
> >> +          - enum:
> >> +            - AD5940_ADC_INPUTP_EXCITATION  
> > 
> > You can't have defines in the schema. minimum/maximum might work better here.
> >   
> >> +            - AD5940_ADC_INPUTP_FLOATING
> >> +            - AD5940_ADC_INPUTP_HSTIA
> >> +            - AD5940_ADC_INPUTP_LPTIA_LP
> >> +            - AD5940_ADC_INPUTP_AIN0
> >> +            - AD5940_ADC_INPUTP_AIN1
> >> +            - AD5940_ADC_INPUTP_AIN2
> >> +            - AD5940_ADC_INPUTP_AIN3
> >> +            - AD5940_ADC_INPUTP_AVDD_2
> >> +            - AD5940_ADC_INPUTP_DVDD_2
> >> +            - AD5940_ADC_INPUTP_AVDD_REG_2
> >> +            - AD5940_ADC_INPUTP_TEMP
> >> +            - AD5940_ADC_INPUTP_VBIAS_CAP
> >> +            - AD5940_ADC_INPUTP_DE0
> >> +            - AD5940_ADC_INPUTP_SE0
> >> +            - AD5940_ADC_INPUTP_VREF_2V5_2
> >> +            - AD5940_ADC_INPUTP_VREF_1V82
> >> +            - AD5940_ADC_INPUTP_P_TEMP_N
> >> +            - AD5940_ADC_INPUTP_AIN4
> >> +            - AD5940_ADC_INPUTP_AIN6
> >> +            - AD5940_ADC_INPUTP_VZERO
> >> +            - AD5940_ADC_INPUTP_VBIAS0
> >> +            - AD5940_ADC_INPUTP_VCE0
> >> +            - AD5940_ADC_INPUTP_VRE0
> >> +            - AD5940_ADC_INPUTP_VCE0_2
> >> +            - AD5940_ADC_INPUTP_LPTIA
> >> +            - AD5940_ADC_INPUTP_AGND_REF
> >> +
> >> +          - description: Negtive input channel
> >> +          - enum:
> >> +              # Negtive input candidates
> >> +              - AD5940_ADC_INPUTN_FLOATING
> >> +              - AD5940_ADC_INPUTN_HSTIA
> >> +              - AD5940_ADC_INPUTN_LPTIA
> >> +              - AD5940_ADC_INPUTN_AIN0
> >> +              - AD5940_ADC_INPUTN_AIN1
> >> +              - AD5940_ADC_INPUTN_AIN2
> >> +              - AD5940_ADC_INPUTN_AIN3
> >> +              - AD5940_ADC_INPUTN_VBIAS_CA8
> >> +              - AD5940_ADC_INPUTN_TEMP_N
> >> +              - AD5940_ADC_INPUTN_AIN4
> >> +              - AD5940_ADC_INPUTN_AIN6
> >> +              - AD5940_ADC_INPUTN_VZERO
> >> +              - AD5940_ADC_INPUTN_VBIAS0
> >> +              - AD5940_ADC_INPUTN_EXCITATION  
> > 
> > You've defined that diff-channels is 4 items. I don't think that's
> > what you want. Each enum and description should be under a single '-'.
> >   
> >> +
> >> +      channel-name:  
> > 
> > Perhaps standard property 'label' should be used here. Seems like a
> > common thing.
> >   
> >> +        description:
> >> +          Any string format name you would like to assign to this channel.
> >> +        maxItems: 1
> >> +
> >> +    required:
> >> +      - reg
> >> +      - diff-channels
> >> +      - channel-name
> >> +
> >> +examples:
> >> +  - |
> >> +    ad5940: ad5940@0 {
> >> +      compatible = "adi,ad5940";
> >> +      reg = <0>;
> >> +      spi-max-frequency = <16000000>;
> >> +      vref-supply = <&adc_vref>;
> >> +      interrupt-parent = <&gpio>;
> >> +      interrupts = <24 2>;
> >> +
> >> +      adi,interrupt-io = <0>;
> >> +
> >> +      #address-cells = <1>;
> >> +      #size-cells = <0>;
> >> +
> >> +      channel@0 {
> >> +        reg = <0>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_VCE0
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;  
> > 
> > You'll need the header included for this to build. Run 'make
> > dt_binding_check' on this.
> >   
> >> +        channel-name = "Vce-Vbias";
> >> +      };
> >> +
> >> +      channel@1 {
> >> +        reg = <1>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_VRE0
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "Vre-Vbias";
> >> +      };
> >> +
> >> +      channel@2 {
> >> +        reg = <2>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_SE0
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "Vse-Vbias";
> >> +      };
> >> +
> >> +      channel@3 {
> >> +        reg = <3>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_DE0
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "Vde-Vbias";
> >> +      };
> >> +
> >> +      channel@4 {
> >> +        reg = <4>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_AIN0
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "ain0-Vbias";
> >> +      };
> >> +
> >> +      channel@5 {
> >> +        reg = <5>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_AIN1
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "ain1-Vbias";
> >> +      };
> >> +
> >> +      channel@6 {
> >> +        reg = <6>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_AIN2
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "ain2-Vbias";
> >> +      };
> >> +
> >> +      channel@7 {
> >> +        reg = <7>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_AIN3
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "ain3-Vbias";
> >> +      };
> >> +
> >> +      channel@8 {
> >> +        reg = <8>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_AIN4
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "ain4-Vbias";
> >> +      };
> >> +
> >> +      channel@9 {
> >> +        reg = <9>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_AIN6
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "ain6-Vbias";
> >> +      };
> >> +
> >> +      channel@10 {
> >> +        reg = <10>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_LPTIA_LP
> >> +                         AD5940_ADC_INPUTN_LPTIA>;
> >> +        channel-name = "Low power TIA DC";
> >> +      };
> >> +
> >> +      channel@11 {
> >> +        reg = <11>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_LPTIA
> >> +                         AD5940_ADC_INPUTN_LPTIA>;
> >> +        channel-name = "Low power TIA AC";
> >> +      };
> >> +
> >> +      channel@12 {
> >> +        reg = <12>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_HSTIA
> >> +                         AD5940_ADC_INPUTN_HSTIA>;
> >> +        channel-name = "High Speed TIA";
> >> +      };
> >> +
> >> +      channel@13 {
> >> +        reg = <13>;
> >> +        diff-channels = <AD5940_ADC_INPUTP_TEMP
> >> +                         AD5940_ADC_INPUTN_VBIAS0>;
> >> +        channel-name = "Temperature";
> >> +      };
> >> +    };
> >> diff --git a/include/dt-bindings/iio/adc/adi,ad5940.h b/include/dt-bindings/iio/adc/adi,ad5940.h
> >> new file mode 100644
> >> index 000000000000..c17826f2f654
> >> --- /dev/null
> >> +++ b/include/dt-bindings/iio/adc/adi,ad5940.h
> >> @@ -0,0 +1,52 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * This header provides constants for configuring the AD5940 AFE
> >> + */
> >> +
> >> +#ifndef _DT_BINDINGS_IIO_ADC_AD5940_H
> >> +#define _DT_BINDINGS_IIO_ADC_AD5940_H
> >> +
> >> +#define AD5940_ADC_INPUTN_FLOATING     0
> >> +#define AD5940_ADC_INPUTN_HSTIA                1
> >> +#define AD5940_ADC_INPUTN_LPTIA                2
> >> +#define AD5940_ADC_INPUTN_AIN0         4
> >> +#define AD5940_ADC_INPUTN_AIN1         5
> >> +#define AD5940_ADC_INPUTN_AIN2         6
> >> +#define AD5940_ADC_INPUTN_AIN3         7
> >> +#define AD5940_ADC_INPUTN_VBIAS_CA8    10
> >> +#define AD5940_ADC_INPUTN_TEMP_N       11
> >> +#define AD5940_ADC_INPUTN_AIN4         12
> >> +#define AD5940_ADC_INPUTN_AIN6         14
> >> +#define AD5940_ADC_INPUTN_VZERO                16
> >> +#define AD5940_ADC_INPUTN_VBIAS0       17
> >> +#define AD5940_ADC_INPUTN_EXCITATION   20
> >> +
> >> +#define AD5940_ADC_INPUTP_FLOATING     0
> >> +#define AD5940_ADC_INPUTP_HSTIA                1
> >> +#define AD5940_ADC_INPUTP_LPTIA_LP     2
> >> +#define AD5940_ADC_INPUTP_AIN0         4
> >> +#define AD5940_ADC_INPUTP_AIN1         5
> >> +#define AD5940_ADC_INPUTP_AIN2         6
> >> +#define AD5940_ADC_INPUTP_AIN3         7
> >> +#define AD5940_ADC_INPUTP_AVDD_2       8
> >> +#define AD5940_ADC_INPUTP_DVDD_2       9
> >> +#define AD5940_ADC_INPUTP_AVDD_REG_2   10
> >> +#define AD5940_ADC_INPUTP_TEMP         11
> >> +#define AD5940_ADC_INPUTP_VBIAS_CAP    12
> >> +#define AD5940_ADC_INPUTP_DE0          13
> >> +#define AD5940_ADC_INPUTP_SE0          14
> >> +#define AD5940_ADC_INPUTP_VREF_2V5_2   16
> >> +#define AD5940_ADC_INPUTP_VREF_1V82    18
> >> +#define AD5940_ADC_INPUTP_P_TEMP_N     19
> >> +#define AD5940_ADC_INPUTP_AIN4         20
> >> +#define AD5940_ADC_INPUTP_AIN6         22
> >> +#define AD5940_ADC_INPUTP_VZERO                23
> >> +#define AD5940_ADC_INPUTP_VBIAS0       24
> >> +#define AD5940_ADC_INPUTP_VCE0         25
> >> +#define AD5940_ADC_INPUTP_VRE0         26
> >> +#define AD5940_ADC_INPUTP_VCE0_2       31
> >> +#define AD5940_ADC_INPUTP_LPTIA                33
> >> +#define AD5940_ADC_INPUTP_AGND_REF     35
> >> +#define AD5940_ADC_INPUTP_EXCITATION   36
> >> +
> >> +#endif /* _DT_BINDINGS_IIO_ADC_AD5940 */
> >> --
> >> 2.17.1
> >>  

