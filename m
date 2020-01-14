Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4480213AE41
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgANQCc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 11:02:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgANQCc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 11:02:32 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFqmCb023389;
        Tue, 14 Jan 2020 17:01:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=iqcbAO7gn5oc2a+bEcf0WOjlJoRulApDnHTG5smDQ34=;
 b=DWk0khVZQxpCW7NxPaFvTtniHCfvkDLVAsv5oVI0FSt7q8G4/RtcRqOT+KOIsoNbTRSc
 l1VmZtujDMkOFgjxAaqefoqNxQb9G8WKVqcOBL1Ir+u6SW4NfagLfjZ0FQLwK9IC6oym
 YaCXXUL+ZJBODdlCll1CNR935UKHZmdOZKzFyhWSF8mTA1cTQl/r25KU1ZLcd44hQ2Tl
 TApcE4LAReDFVWKGkv+z0mr02RMokcLgCf4KhvfBKehWZxlJVMaJQSuUHdHtKRGo2lu6
 uRQvl5itEy/A7DfyZYMFJHfZmyx1HICO4oezIsP1KmppLA/qokU4li0N6II4gC9fy+Tw 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf7jpebd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 17:01:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2FB1100044;
        Tue, 14 Jan 2020 17:01:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AC7A2C38A2;
        Tue, 14 Jan 2020 17:01:54 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 17:01:53 +0100
Subject: Re: [PATCH v2] dt-bindings: iio: adc: stm32-adc: convert bindings to
 json-schema
To:     Rob Herring <robh@kernel.org>
CC:     <jic23@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1575649028-10909-1-git-send-email-fabrice.gasnier@st.com>
 <20191217234345.GA7738@bogus>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <cadc76a7-7e9d-1f0a-21fd-2d7942dbe5c9@st.com>
Date:   Tue, 14 Jan 2020 17:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191217234345.GA7738@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_04:2020-01-14,2020-01-14 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/18/19 12:43 AM, Rob Herring wrote:
> On Fri, Dec 06, 2019 at 05:17:08PM +0100, Fabrice Gasnier wrote:
>> Convert the STM32 ADC binding to DT schema format using json-schema
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Note: this applies on top of IIO tree currently (iio-for-5.5c).
>>
>> Changes in V2:
>> - Take almost all of Rob suggestions (removed reg generic description,
>>   added minItems, maxItems, st,max-clk-rate-hz range, drop some pipes,
>>   simplify clock-names, remove unneeded allOfs)
>> - For now, keep all in one file despite there are lots of if/thens in the
>>   bindings
>> ---
>>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -------
>>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 454 +++++++++++++++++++++
>>  2 files changed, 454 insertions(+), 149 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> 
> 


[snip]

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

[snip]

>> +
>> +    allOf:
>> +      - if:
>> +          properties:
>> +            compatible:
>> +              contains:
>> +                const: st,stm32f4-adc
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
>> +              enum: [6, 8, 10, 12]
>> +              default: 12
>> +
>> +            st,adc-channels:
>> +              minItems: 1
>> +              maxItems: 16
>> +              minimum: 0
>> +              maximum: 15
> 
> You are mixing array and scalar constraints here. You need:
> 
> minItems: 1
> maxItems:16
> items:
>   minimum: 0
>   maximum: 15
> 
> Update dtschema. It will now catch this. There's a few others too.

Hi Rob,

Sorry for the late reply. I updated dtschema. Now it catches it.

I've tried your suggestion, but when I test it, I don't get any error on
maxItems.

In the example: "st,adc-channels = <0>, <1>, ... more than 16 items;"

Is it possible I face some other issue with dtschema ?

I tried another way below... Not sure that's correct. But it catches
errors on maxItems:

            st,adc-channels:
              allOf:
                - minItems: 1
                  maxItems: 16
              items:
                minimum: 0
                maximum: 15

Error message is ... "is too long" with bad example above.

Please advise,
Regards,
Fabrice

> 
> 
>> +
>> +            st,adc-diff-channels: false
>> +
>> +            st,min-sample-time-nsecs:
>> +              minItems: 1
>> +              maxItems: 16
>> +              minimum: 80
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
>> +              enum: [8, 10, 12, 14, 16]
>> +              default: 16
>> +
>> +            st,adc-channels:
>> +              minItems: 1
>> +              maxItems: 20
>> +              minimum: 0
>> +              maximum: 19
>> +
>> +            st,min-sample-time-nsecs:
>> +              minItems: 1
>> +              maxItems: 20
>> +              minimum: 40
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
