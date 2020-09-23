Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9959F275404
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 11:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgIWJH2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIWJH1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2020 05:07:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ACEC0613D1
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2020 02:07:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c2so16559098ljj.12
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2020 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oxfqN+/oFq6f8zrQC/M5ig8ijRiZLXyefj4fwEV8+DY=;
        b=kAJE3GOD2vJpQ7aXFpD7xZpacWnJ+tWlt4k6eb4f5ao88/RQvx9wqvk/ebR6ZqhTTn
         5Py6T+kevtOj+S8vA4PTA5eygM0sOHC1/FP9KdZVwlu0Oq3/44qodvghr+43QoHnh8x8
         5CeWVD2IjSUHbIHbrAQ7kGd2QIrb8U079ygRjFkfN/Ywk/8Jrge8p9BXYzrluAY8UJ2n
         nvM7Hpy0u4TFvdCA452stR9Ka/o059qUfVnVUvuyJ/7rNkwXW6Yvm09W9hWHlSib5sse
         6fm/Y3mqsAQ/qtmkhTdlqildrALk8/aejkg8NeldoKzmgWO0UY41ZxhVXRjCrwHJdb12
         YIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oxfqN+/oFq6f8zrQC/M5ig8ijRiZLXyefj4fwEV8+DY=;
        b=q4iRYEayZmJtJCINn+NCWeNjCI81QtLnZdfebVPFwwMn1A0cqzhu+f4+f1BmmW88hE
         Pz+BLRSBPbzOvLhdTWGYnKK6SeKS3Ov5pkGl5S5NqfE8s+jBoHzpp3f/JHHcCYn/RqBG
         omvDw2fFw0wOX0WXYBcggJhoRMcjbCfJXLOygM0iXR7I4Eae/QsTO7iA3+tl+XUf+SOi
         619d1NFGJJ53ABh1erUzMiS0E1ZQNCc+m6eJhwlNQdDt/f4u2a/0pg6RbO7LDPF8FWOQ
         L3Q70v1OpLT2tKHsWMryHPtQ/GacOfgoeTuM8fA0pID9IRjlRfw5UeiOp3/CzItRWK1G
         JCyg==
X-Gm-Message-State: AOAM53019SGHIXolOl0Z1bKUots7CmW/XX5HLKA3fVTrlH7D9Zj6p6li
        Gx9gLJj+hkqeoOAymnmRmOq95g==
X-Google-Smtp-Source: ABdhPJyoCA3uPuZCxSHL6yFBRN8e+6DemT9CbJsGA4nrCdkQQLUMdOxpTNjah6CWsGURB+sl+Zwn0g==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr2761724ljj.184.1600852045836;
        Wed, 23 Sep 2020 02:07:25 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.186])
        by smtp.gmail.com with ESMTPSA id o8sm4572927lfa.44.2020.09.23.02.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 02:07:25 -0700 (PDT)
Subject: Re: [PATCH v5 1/9] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
 <20200914154809.192174-2-dmitry.baryshkov@linaro.org>
 <20200922234025.GA3476652@bogus>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <55d3f181-b9e6-4963-9d0c-cefee875058c@linaro.org>
Date:   Wed, 23 Sep 2020 12:07:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922234025.GA3476652@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/09/2020 02:40, Rob Herring wrote:
> On Mon, Sep 14, 2020 at 06:48:01PM +0300, Dmitry Baryshkov wrote:
>> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
>> close counterpart of VADC part of those PMICs.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 151 ++++++++++++++++++
>>   1 file changed, 151 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
>> new file mode 100644
>> index 000000000000..432a65839b89
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
>> @@ -0,0 +1,151 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm's SPMI PMIC ADC Thermal Monitoring
>> +maintainers:
>> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,spmi-adc-tm5
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 1
>> +    description:
>> +      Number of cells required to uniquely identify the thermal sensors. Since
>> +      we have multiple sensors this is set to 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +  qcom,avg-samples:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Number of samples to be used for measurement.
>> +    enum:
>> +      - 1
>> +      - 2
>> +      - 4
>> +      - 8
>> +      - 16
>> +    default: 1
>> +
>> +  qcom,decimation:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: This parameter is used to decrease ADC sampling rate.
>> +            Quicker measurements can be made by reducing decimation ratio.
>> +    enum:
>> +      - 250
>> +      - 420
>> +      - 840
>> +    default: 840
>> +
>> +patternProperties:
>> +  "^([-a-z0-9]*)@[0-9]+$":
> 
> Less than 10 as unit-addresses are hex?

8 channels at max currently. I'll fix to use hex though.

> 
>> +    type: object
>> +    description:
>> +      Represent one thermal sensor.
>> +
>> +    properties:
>> +      reg:
>> +        description: Specify the sensor channel.
>> +        maxItems: 1
> 
> You need a range of values here.

ok.

> 
>> +
>> +      io-channels:
>> +        description:
>> +          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
>> +
>> +      qcom,adc-channel:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: Corresponding ADC channel ID.
> 
> Why is this not a cell in io-channels?


Do you mean parsing a cell from io-channels rather than specifying it 
again? Sounds like a good idea.

> 
>> +
>> +      qcom,ratiometric:
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description:
>> +          Channel calibration type.
>> +          If this property is specified VADC will use the VDD reference
>> +          (1.875V) and GND for channel calibration. If property is not found,
>> +          channel will be calibrated with 0V and 1.25V reference channels,
>> +          also known as absolute calibration.
>> +
>> +      qcom,hw-settle-time:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: Time between AMUX getting configured and the ADC starting conversion.
> 
> Time values should have a unit suffix. Seems like a commmon ADC
> property...

Could you please be more specific here? Would you like for me to just 
specify the unit in the description?

> 
>> +
>> +      qcom,pre-scaling:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description: Used for scaling the channel input signal before the
>> +          signal is fed to VADC. See qcom,spi-vadc specification for the list
>> +          of possible values.
> 
> I'd rather not. Need the values here to validate a DT.

OK

> 
>> +        minItems: 2
>> +        maxItems: 2
>> +
>> +    required:
>> +      - reg
>> +      - qcom,adc-channel
>> +
>> +    additionalProperties:
>> +      false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - "#thermal-sensor-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/iio/qcom,spmi-vadc.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    spmi_bus {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        pm8150b_adc: adc@3100 {
>> +            reg = <0x3100>;
>> +            compatible = "qcom,spmi-adc5";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            #io-channel-cells = <1>;
>> +            io-channel-ranges;
>> +
>> +            /* Other propreties are omitted */
>> +            conn-therm@4f {
>> +                reg = <ADC5_AMUX_THM3_100K_PU>;
>> +                qcom,ratiometric;
>> +                qcom,hw-settle-time = <200>;
>> +            };
>> +        };
>> +
>> +        pm8150b_adc_tm: adc-tm@3500 {
>> +            compatible = "qcom,spmi-adc-tm5";
>> +            reg = <0x3500>;
>> +            interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
>> +            #thermal-sensor-cells = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            conn-therm@0 {
>> +                reg = <0>;
>> +                io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
>> +                qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
>> +                qcom,ratiometric;
>> +                qcom,hw-settle-time = <200>;
>> +            };
>> +        };
>> +    };
>> +...
>> -- 
>> 2.28.0
>>


-- 
With best wishes
Dmitry
