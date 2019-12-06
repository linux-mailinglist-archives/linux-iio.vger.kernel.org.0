Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74EF1154FE
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFQTe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 11:19:34 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1498 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbfLFQTe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Dec 2019 11:19:34 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6GCP35016908;
        Fri, 6 Dec 2019 17:19:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=m8ILNDUmulf74noX3U7KMcJ6H97/5Vze+DviYfWHnc0=;
 b=pyvaEVhvfeNT099s3QrR4mDhvR+d/1Clp/r1lUtYAhg6tuP1DeyAsHzfE0oAblZW/TNn
 f5SS+klk/QBS56tK7IU+iEVYDEPos5GbkFHv4TTwJfYeZSWd98PUTiz85ZR1F93pitFT
 2OlO01+T0JaUtoGt/2nxsqOZRUihro0mh2SIJNIOW3VFMUL6Ye9AK+yRd2kG480e7Crs
 nvGvnRlzoanZBxKvnmuGDcwhA+Ya/myKRVa8XeIQ+owd9uDvBCNf7Bu8ZwD8qgy5lStk
 Z4GgaiDc7143xWwJDLzjwb9my0z07aEONOjHy38OJbiO/lfB5Twhh2hBl6yhrK5FKIjS PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkeeahj4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Dec 2019 17:19:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8C8710002A;
        Fri,  6 Dec 2019 17:18:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 733B12B5459;
        Fri,  6 Dec 2019 17:18:41 +0100 (CET)
Received: from [10.48.0.192] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 17:18:40 +0100
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-adc: convert bindings to
 json-schema
To:     Rob Herring <robh@kernel.org>
CC:     <jic23@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1574873325-9916-1-git-send-email-fabrice.gasnier@st.com>
 <20191205222421.GA312@bogus>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <108aaaef-e7b6-15b2-02ec-eba6074d5029@st.com>
Date:   Fri, 6 Dec 2019 17:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205222421.GA312@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_05:2019-12-05,2019-12-06 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/5/19 11:24 PM, Rob Herring wrote:
> On Wed, Nov 27, 2019 at 05:48:45PM +0100, Fabrice Gasnier wrote:
>> Convert the STM32 ADC binding to DT schema format using json-schema
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Note: this applies on top of IIO tree currently (iio-for-5.5c).
>> ---
>>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -------
>>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 448 +++++++++++++++++++++
>>  2 files changed, 448 insertions(+), 149 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> 
> 
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
>> new file mode 100644
>> index 00000000..2ebc2e6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
>> @@ -0,0 +1,448 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/bindings/iio/adc/st,stm32-adc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: STMicroelectronics STM32 ADC bindings
>> +
>> +description: |
>> +  STM32 ADC is a successive approximation analog-to-digital converter.
>> +  It has several multiplexed input channels. Conversions can be performed
>> +  in single, continuous, scan or discontinuous mode. Result of the ADC is
>> +  stored in a left-aligned or right-aligned 32-bit data register.
>> +  Conversions can be launched in software or using hardware triggers.
>> +
>> +  The analog watchdog feature allows the application to detect if the input
>> +  voltage goes beyond the user-defined, higher or lower thresholds.
>> +
>> +  Each STM32 ADC block can have up to 3 ADC instances.
>> +
>> +maintainers:
>> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - st,stm32f4-adc-core
>> +      - st,stm32h7-adc-core
>> +      - st,stm32mp1-adc-core
>> +
>> +  reg:
>> +    description: Offset and length of the ADC block register set
> 
> Don't need generic description of a standard property.

Hi Rob,

ok

> 
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description: |
>> +      One or more interrupts for ADC block, depending on part used:
>> +        - stm32f4 and stm32h7 share a common ADC interrupt line.
>> +        - stm32mp1 has two separate interrupt lines, one for each ADC within
>> +          ADC block.
> 
> You can put minItems: 1, maxItems: 2 here.

ok

> 
>> +
>> +  clocks:
>> +    description: |
>> +      Core can use up to two clocks, depending on part used:
>> +        - "adc" clock: for the analog circuitry, common to all ADCs.
>> +          It's required on stm32f4.
>> +          It's optional on stm32h7 and stm32mp1.
>> +        - "bus" clock: for registers access, common to all ADCs.
>> +          It's not present on stm32f4.
>> +          It's required on stm32h7 and stm32mp1.
>> +
>> +  clock-names: true
>> +
>> +  st,max-clk-rate-hz:
>> +    description: |
>> +      Allow to specify desired max clock rate used by analog circuitry.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> 
> *-hz already has a type, so you can drop this.
> 
> No range you can specify?

Yes, I'll add it in V2 under the if sections bellow as it depends on the
STM32 device (compatible).

> 
>> +
>> +  vdda-supply:
>> +    description: Phandle to the vdda input analog voltage.
>> +
>> +  vref-supply:
>> +    description: Phandle to the vref input analog reference voltage.
>> +
>> +  booster-supply:
>> +    description: |
> 
> There's not any formatting here, so '|' can be dropped.

ok, I'll remove it also at few places

> 
>> +      Phandle to the embedded booster regulator that can be used to supply ADC
>> +      analog input switches on stm32h7 and stm32mp1.
>> +
>> +  vdd-supply:
>> +    description: |
>> +      Phandle to the vdd input voltage. It can be used to supply ADC analog
>> +      input switches on stm32mp1.
>> +
>> +  st,syscfg:
>> +    description: |
>> +      Phandle to system configuration controller. It can be used to control the
>> +      analog circuitry on stm32mp1.
>> +    allOf:
>> +      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
>> +
>> +  interrupt-controller: true
>> +
>> +  '#interrupt-cells':
>> +    const: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32f4-adc-core
>> +
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 1
>> +
>> +        clock-names:
>> +          items:
>> +            const: adc
>> +          maxItems: 1
> 
> You can simplify to:
> 
> clock-names:
>   const: adc
> 
> Note that if you did have 'items' it should be a list (i.e. have '-').

ok

> 
>> +
>> +        interrupts:
>> +          items:
>> +            - description: interrupt line common for all ADCs
>> +
>> +        booster-supply: false
>> +
>> +        vdd-supply: false
>> +
>> +        st,syscfg: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32h7-adc-core
>> +
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 1
>> +          maxItems: 2
>> +
>> +        clock-names:
>> +          items:
>> +            - const: bus
>> +            - const: adc
>> +          minItems: 1
>> +          maxItems: 2
>> +
>> +        interrupts:
>> +          items:
>> +            - description: interrupt line common for all ADCs
>> +
>> +        vdd-supply: false
>> +
>> +        st,syscfg: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp1-adc-core
>> +
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 1
>> +          maxItems: 2
>> +
>> +        clock-names:
>> +          items:
>> +            - const: bus
>> +            - const: adc
>> +          minItems: 1
>> +          maxItems: 2
>> +
>> +        interrupts:
>> +          items:
>> +            - description: interrupt line for ADC1
>> +            - description: interrupt line for ADC2
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - vdda-supply
>> +  - vref-supply
>> +  - interrupt-controller
>> +  - '#interrupt-cells'
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +
>> +patternProperties:
>> +  "^adc@[0-9]+$":
>> +    type: object
>> +    description: |
>> +      An ADC block node should contain at least one subnode, representing an
>> +      ADC instance available on the machine.
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - st,stm32f4-adc
>> +          - st,stm32h7-adc
>> +          - st,stm32mp1-adc
>> +
>> +      reg:
>> +        description: |
>> +          Offset of ADC instance in ADC block. Valid values are:
>> +            - 0x0:   ADC1
>> +            - 0x100: ADC2
>> +            - 0x200: ADC3 (stm32f4 only)
>> +        maxItems: 1
>> +
>> +      '#io-channel-cells':
>> +        const: 1
>> +
>> +      interrupts:
>> +        description: |
>> +          IRQ Line for the ADC instance. Valid values are:
>> +            - 0 for adc@0
>> +            - 1 for adc@100
>> +            - 2 for adc@200 (stm32f4 only)
>> +        maxItems: 1
>> +
>> +      clocks:
>> +        description: |
>> +          Input clock private to this ADC instance. It's required only on
>> +          stm32f4, that has per instance clock input for registers access.
>> +        maxItems: 1
>> +
>> +      dmas:
>> +        description: RX DMA Channel
>> +        maxItems: 1
>> +
>> +      dma-names:
>> +        const: rx
>> +
>> +      assigned-resolution-bits:
>> +        description: |
>> +          Resolution (bits) to use for conversions:
>> +            - can be 6, 8, 10 or 12 on stm32f4
>> +            - can be 8, 10, 12, 14 or 16 on stm32h7 and stm32mp1
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +      st,adc-channels:
>> +        description: |
>> +          List of single-ended channels muxed for this ADC. It can have up to:
>> +            - 16 channels, numbered from 0 to 15 (for in0..in15) on stm32f4
>> +            - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
>> +              stm32mp1.
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +      st,adc-diff-channels:
>> +        description: |
>> +          List of differential channels muxed for this ADC. Some channels can
>> +          be configured as differential instead of single-ended on stm32h7 and
>> +          on stm32mp1. Positive and negative inputs pairs are listed:
>> +          <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered from 0 to 19.
>> +
>> +          Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is
>> +          required. Both properties can be used together. Some channels can be
>> +          used as single-ended and some other ones as differential (mixed). But
>> +          channels can't be configured both as single-ended and differential.
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +          - items:
>> +              items:
>> +                - description: |
>> +                    "vinp" indicates positive input number
>> +                  minimum: 0
>> +                  maximum: 19
>> +                - description: |
>> +                    "vinn" indicates negative input number
>> +                  minimum: 0
>> +                  maximum: 19
>> +
>> +      st,min-sample-time-nsecs:
>> +        description: |
>> +          Minimum sampling time in nanoseconds. Depending on hardware (board)
>> +          e.g. high/low analog input source impedance, fine tune of ADC
>> +          sampling time may be recommended. This can be either one value or an
>> +          array that matches "st,adc-channels" and/or "st,adc-diff-channels"
>> +          list, to set sample time resp. for all channels, or independently for
>> +          each channel.
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +    allOf:
>> +      - if:
>> +          properties:
>> +            compatible:
>> +              contains:
>> +                const: st,stm32f4-adc
> 
> There's a lot of if/thens in this binding. I wonder if splitting this 
> into 2 files might be cleaner. 

Indeed there are a lot of these... But there is also several common
descriptions (the core remains similar).
Do you mind if I keep it that way ?

Let's discuss that in V2 otherwise.
In case we're going to split this:
- I think the most similar ADCs are STM32H7 and STM32MP1
- The STM32F4 ADC bindings should then be apart.

> 
>> +
>> +        then:
>> +          properties:
>> +            reg:
>> +              enum:
>> +                - 0x0
>> +                - 0x100
>> +                - 0x200
>> +
>> +            interrupts:
>> +              minimum: 0
>> +              maximum: 2
>> +
>> +            assigned-resolution-bits:
>> +              allOf:
>> +                - enum: [6, 8, 10, 12]
>> +                - default: 12
>> +
>> +            st,adc-channels:
>> +              allOf:
>> +                - maxItems: 16
>> +                  items:
>> +                    minimum: 0
>> +                    maximum: 15
>> +
>> +            st,adc-diff-channels: false
>> +
>> +            st,min-sample-time-nsecs:
>> +              allOf:
>> +                - maxItems: 16
>> +                  items:
>> +                    minimum: 80
>> +
>> +          required:
>> +            - clocks
>> +
>> +      - if:
>> +          properties:
>> +            compatible:
>> +              contains:
>> +                enum:
>> +                  - st,stm32h7-adc
>> +                  - st,stm32mp1-adc
>> +
>> +        then:
>> +          properties:
>> +            reg:
>> +              enum:
>> +                - 0x0
>> +                - 0x100
>> +
>> +            interrupts:
>> +              minimum: 0
>> +              maximum: 1
>> +
>> +            assigned-resolution-bits:
>> +              allOf:
> 
> Shouldn't need the allOf here.

ok

> 
>> +                - enum: [8, 10, 12, 14, 16]
>> +                - default: 16
>> +
>> +            st,adc-channels:
>> +              allOf:
> 
> Shouldn't need the allOf here.

ok

> 
>> +                - maxItems: 20
>> +                  items:
>> +                    minimum: 0
>> +                    maximum: 19
>> +
>> +            st,min-sample-time-nsecs:
>> +              allOf:
> 
> Shouldn't need the allOf here.

ok

> 
>> +                - maxItems: 20
>> +                  items:
>> +                    minimum: 40
>> +
>> +    additionalProperties: false
>> +
>> +    anyOf:
>> +      - required:
>> +          - st,adc-channels
>> +      - required:
>> +          - st,adc-diff-channels
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +      - interrupts
>> +      - '#io-channel-cells'
>> +
>> +examples:
>> +  - |
>> +    // Example 1: with stm32f429
>> +      adc123: adc@40012000 {
>> +        compatible = "st,stm32f4-adc-core";
>> +        reg = <0x40012000 0x400>;
>> +        interrupts = <18>;
>> +        clocks = <&rcc 0 168>;
>> +        clock-names = "adc";
>> +        st,max-clk-rate-hz = <36000000>;
>> +        vdda-supply = <&vdda>;
>> +        vref-supply = <&vref>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        adc@0 {
>> +          compatible = "st,stm32f4-adc";
>> +          #io-channel-cells = <1>;
>> +          reg = <0x0>;
>> +          clocks = <&rcc 0 168>;
>> +          interrupt-parent = <&adc123>;
>> +          interrupts = <0>;
>> +          st,adc-channels = <8>;
>> +          dmas = <&dma2 0 0 0x400 0x0>;
>> +          dma-names = "rx";
>> +          assigned-resolution-bits = <8>;
>> +        };
>> +        // ...
>> +        // other adc child nodes follow...
>> +      };
>> +
>> +  - |
>> +    // Example 2: with stm32mp157c to setup ADC1 with:
>> +    // - channel 1 as single-ended
>> +    // - channels 2 & 3 as differential (with resp. 6 & 7 negative inputs)
>> +      #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +      #include <dt-bindings/clock/stm32mp1-clks.h>
>> +      adc12: adc@48003000 {
>> +        compatible = "st,stm32mp1-adc-core";
>> +        reg = <0x48003000 0x400>;
>> +        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&rcc ADC12>, <&rcc ADC12_K>;
>> +        clock-names = "bus", "adc";
>> +        booster-supply = <&booster>;
>> +        vdd-supply = <&vdd>;
>> +        vdda-supply = <&vdda>;
>> +        vref-supply = <&vref>;
>> +        st,syscfg = <&syscfg>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        adc@0 {
>> +          compatible = "st,stm32mp1-adc";
>> +          #io-channel-cells = <1>;
>> +          reg = <0x0>;
>> +          interrupt-parent = <&adc12>;
>> +          interrupts = <0>;
>> +          st,adc-channels = <1>;
>> +          st,adc-diff-channels = <2 6>, <3 7>;
>> +          st,min-sample-time-nsecs = <5000>;
>> +          dmas = <&dmamux1 9 0x400 0x05>;
>> +          dma-names = "rx";
>> +        };
>> +        // ...
>> +        // other adc child node follow...
>> +      };
>> +
>> +...
>> -- 
>> 2.7.4
>>
