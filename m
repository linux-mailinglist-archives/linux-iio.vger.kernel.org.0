Return-Path: <linux-iio+bounces-12396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317429D220F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41CF2838AB
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D519CD1E;
	Tue, 19 Nov 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcIQMoiY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4011925B3
	for <linux-iio@vger.kernel.org>; Tue, 19 Nov 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006941; cv=none; b=pes0OpQVgbewTd+Efw9z8sIDdHS+wwiYix+y/gyds7oXhIkPir8JD8bjf0SgyeW9iUy3NxoOJ+Vd9xoHc1qGWxX5votxGtm+zKPUDpnAbM0/VxCBNK4NSnTVRk5hJL2zEeImUVzNUKLtSsTzp7LgVAkD1Xz/JfaNAg1yBvL+1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006941; c=relaxed/simple;
	bh=7i+4vicmpvdvXCc4vKH9ARs9QvjvPpWrGVehq6Zfqos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwpKTVctTsOpzKAx4/3l7EyVJk/x1cGnOr9lgUyVr4uqYrfXbfi/RbDnC5V4Y4xqVZm9E4LLQwWj6QjN+PLtQ3Dhqc06eXsqEJ4o/jKtlWqmuAN14adulhYbKaabtNhCrLbvqGHj6pBjR7//HGALXRruCwPKV57TmGJ2BE70lrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FcIQMoiY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38231f84d8fso227786f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Nov 2024 01:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732006938; x=1732611738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PWT9jbzuwuMDBlzD8+v50VUHF7SndtEw79T5t/vLiW4=;
        b=FcIQMoiYjXmch560MCykatoM47jCwDrJJts0IMVgTov4Ou6ueYiYaE+AsOxavb31Z8
         34/QiJtutHcU+5WMSIp+QYb7ZqfdSxR2K9XWnKc+dfzcN0zVAk/4R2ujMEA8v3PBYvEs
         I7Ur7NuO8LTu/0As+DNf/4LIlGvOpUyEzqwkMunAfLXfwb7wKDVJaMDuMsVEy+w3R733
         FL2J018rxLB486o29JRD3sGNbrVaXLQbbrZwbhjr80Hn/LJkVLgfcf34PzHEb3IX63i8
         OUpXLeAyEcRR2UGTEGqdCUkxayE2UvikPbN5NibESMYuS1SMRRU7as8BlskChGWw5Lsf
         vDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732006938; x=1732611738;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWT9jbzuwuMDBlzD8+v50VUHF7SndtEw79T5t/vLiW4=;
        b=UasEs7q1W8BthgXOvbKP/HNB6U5dKU7NXzg4J7qgG2Hl6pHcy2i2ax1ybGJvxNmGtu
         L6b+oayccGwzSA149wjOV7/deQvTVzBYLgcY8VlG/JPRBofpmrLi4KDhAZr2Z+rYR8H2
         Ehk7TeI8Tvit8j54RKiZQoX3sXs0Zno05/KaEGoE4omBET1G7tbVAP5CmSSYwERcijKK
         eDnKDTO6t4xNwHn/lDxp/fG55ANcieQbb7A60elY3STqhKFBQa+BdIm/klE1Id5FMog2
         vM/Q+vT7UHlHZYosffd2unXXSSRe5zMTDTvXwdR6PdVYFKk5by5lwFBOCwn97qKgvd1i
         jMyA==
X-Forwarded-Encrypted: i=1; AJvYcCUwpMoigSchkTXaW6RHF85+EHAFToldAugVIo7Y86Plw9FXZ2pZIu5eF0JxRrCX0KenMcVbvXDQ+jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqO/YxhUMqQlrbp/QCp8ZBCOfq2KWIM3FhZuzAKSvCWl7t9Be
	2nRdyouZg5adyopHZfzy0GERbWa8AyNN1alhRiqAboqxxou+Y98KJjZXQRL97gI=
X-Gm-Gg: ASbGncvuTVVTKjq/CnFvC9nqaLZmtrl9wxPjvVmvjDA1s5iYzFZWl5rRCn69NwOvfk9
	Xz6SZtI4bdVSZ0MWCQw+T6CXe4LNtTxBJI0KQ8UI8LPxJBOUzw00zEm8seCfNuv3ExwjoYmlYXJ
	KRJTyWXzpqwF/EZ3+pLUX3EvVm6PYj5jqBayoqJuh6bogPIl1XAATrVMF5oj1lKMVTC0iJO3XR/
	j2E8ZCbZflYNJmal9kwY2Um8buHS9T++8+TGtFBLwonHT5MXJShUMPQa2n2jm0zAItCHA==
X-Google-Smtp-Source: AGHT+IGIOHSmYD20IuSF+bq/VVWIiUD2Ng832a921xP7HytR5xBQhyn3tkesw7rln86jK5YeufSH2Q==
X-Received: by 2002:a5d:6da6:0:b0:374:ca43:ac00 with SMTP id ffacd0b85a97d-3822590fa79mr5198387f8f.4.1732006937536;
        Tue, 19 Nov 2024 01:02:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823ade6c73sm9025061f8f.30.2024.11.19.01.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 01:02:16 -0800 (PST)
Message-ID: <7a078fd9-65b1-4f8b-a076-ff56c537e8ad@linaro.org>
Date: Tue, 19 Nov 2024 10:02:14 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
 konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
 quic_amelende@quicinc.com, quic_kamalw@quicinc.com, amitk@kernel.org
Cc: lee@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, lars@metafoo.de, quic_skakitap@quicinc.com,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-3-quic_jprakash@quicinc.com>
 <6daaee01-36a0-4dc5-86c7-106aabbfff4e@linaro.org>
 <bb877daa-8cdb-4c52-a70a-2206e67d014e@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <bb877daa-8cdb-4c52-a70a-2206e67d014e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 15:05, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 10/31/2024 4:28 PM, Krzysztof Kozlowski wrote:
>> On 30/10/2024 19:58, Jishnu Prakash wrote:
>>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>>
>>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>>> going through PBS(Programmable Boot Sequence) firmware through a single
>>> register interface. This interface is implemented on an SDAM (Shared
>>> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
>>> than a dedicated ADC peripheral.
>>>
>>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>>> channels and virtual channels (combination of ADC channel number and
>>> PMIC SID number) per PMIC, to be used by clients of this device.
>>>
>>> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>>> ---
>>
>> This has still test failures, so limited review follows.
>>
>>>  properties:
>>>    compatible:
>>> @@ -23,14 +27,20 @@ properties:
>>>            - const: qcom,pms405-adc
>>>            - const: qcom,spmi-adc-rev2
>>>        - enum:
>>> -          - qcom,spmi-vadc
>>> -          - qcom,spmi-adc5
>>>            - qcom,spmi-adc-rev2
>>> +          - qcom,spmi-adc5
>>> +          - qcom,spmi-adc5-gen3
>>>            - qcom,spmi-adc7
>>> +          - qcom,spmi-vadc
>>>  
>>>    reg:
>>> -    description: VADC base address in the SPMI PMIC register map
>>> -    maxItems: 1
>>> +    description:
>>> +      For compatible properties "qcom,spmi-vadc", "qcom,spmi-adc5", "qcom,spmi-adc-rev2"
>>> +      and "qcom,spmi-adc7", reg is the VADC base address in the SPMI PMIC register map.
>>> +      For compatible property "qcom,spmi-adc5-gen3", each reg corresponds to an SDAM
>>> +      peripheral base address that is being used for ADC functionality.
>>
>> This description is not really needed. You need to provide constraints
>> in schema.
>>
>>> +    minItems: 1
>>> +    maxItems: 2
>>>  
>>>    '#address-cells':
>>>      const: 1
>>> @@ -38,20 +48,28 @@ properties:
>>>    '#size-cells':
>>>      const: 0
>>>  
>>> +  "#thermal-sensor-cells":
>>> +    const: 1
>>> +    description:
>>> +      Number of cells required to uniquely identify the thermal sensors.
>>
>> Drop, redundant.
>>
>>> +      For compatible property "qcom,spmi-adc5-gen3", this property is
>>> +      required for if any channels under it are used for ADC_TM.
>>> +      Since we have multiple sensors this is set to 1.
>>
>> Drop sentence, redundant.
>>
>>> +
>>>    '#io-channel-cells':
>>>      const: 1
>>>  
>>>    interrupts:
>>> -    maxItems: 1
>>>      description:
>>>        End of conversion interrupt.
>>> +      For compatible property "qcom,spmi-adc5-gen3", interrupts are defined
>>> +      for each SDAM being used.
>>
>> Drop descriptions and instead rather list and describe items. You keep
>> repeating schema in free form text. That's not the point.
>>
>>> +    minItems: 1
>>> +    maxItems: 2
>>>  
>>> -required:
>>> -  - compatible
>>> -  - reg
>>> -  - '#address-cells'
>>> -  - '#size-cells'
>>> -  - '#io-channel-cells'
>>> +  interrupt-names:
>>> +    minItems: 1
>>> +    maxItems: 2
>>>  
>>>  patternProperties:
>>>    "^channel@[0-9a-f]+$":
>>> @@ -71,8 +89,8 @@ patternProperties:
>>>          description: |
>>>            ADC channel number.
>>>            See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>>> -          For PMIC7 ADC, the channel numbers are specified separately per PMIC
>>> -          in the PMIC-specific files in include/dt-bindings/iio/adc.
>>> +          For PMIC7 and PMIC5 Gen3 ADC, the channel numbers are specified separately
>>> +          per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
>>>  
>>>        label:
>>>          description: |
>>> @@ -113,11 +131,11 @@ patternProperties:
>>>                channel calibration. If property is not found, channel will be
>>>                calibrated with 0.625V and 1.25V reference channels, also
>>>                known as absolute calibration.
>>> -            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
>>> -              "qcom,spmi-adc-rev2", if this property is specified VADC will use
>>> -              the VDD reference (1.875V) and GND for channel calibration. If
>>> -              property is not found, channel will be calibrated with 0V and 1.25V
>>> -              reference channels, also known as absolute calibration.
>>> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7",
>>> +              "qcom,spmi-adc-rev2" and "qcom,spmi-adc5-gen3", if this property is
>>> +              specified VADC will use the VDD reference (1.875V) and GND for channel
>>> +              calibration. If property is not found, channel will be calibrated with
>>> +              0V and 1.25V reference channels, also known as absolute calibration.
>>>          type: boolean
>>>  
>>>        qcom,hw-settle-time:
>>> @@ -135,9 +153,24 @@ patternProperties:
>>>              from the ADC that is an average of multiple samples. The value
>>>              selected is 2^(value).
>>>  
>>> +      qcom,adc-tm:
>>> +        description:
>>> +          Indicates if ADC_TM monitoring is done on this channel.
>>
>> What is "ADC_TM"? Why this would be property of a board? This does not
>> look like suitable for DT, at least based on such very vague explanation.
>>
>>> +          Defined for compatible property "qcom,spmi-adc5-gen3".
>>
>> Drop redundant.
>>
>>> +          This is the same functionality as in the existing QCOM ADC_TM
>>> +          device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
>>
>> What does it mean? How property can represent functionality of entire
>> binding?
>>
>> BTW, use full paths when refering to files.
>>
> 
> To address all your above questions for ADC_TM:
> 
> The file "Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml" describes
> the Qualcomm ADC thermal monitoring device, which existed as a separate device on older
> PMIC generations. ADC_TM refers to this functionality.
> 
> In ADC5 Gen3, ADC_TM functionality is combined with the existing ADC read functionality
> described in this file, under a single device.
> 
> In the earlier ADC_TM DT nodes, each child node would describe one of the IIO ADC channels being
> monitored by ADC_TM HW. In this ADC5 Gen3 device, setting the property 'qcom,adc-tm' for a channel
> node means that it will also be monitored in HW exactly like an ADC_TM channel.
> 
> It can be considered a hardware property as the monitoring is done by a sequence under
> PBS (Programmable Boot Sequence, can be considered firmware), which periodically gets the
> channel reading and checks it against upper/lower thresholds set by clients of this driver, 
> for threshold violations.

So you want to configure channels in different way? Then specify it
precisely - what is the nature of this feature/configuration. I have no
clue what is ADC TM and you keep using it over and over.

I still wait for answer why this is a property of a board.

> 
> 
>>> +        type: boolean
>>> +
>>>      required:
>>>        - reg
>>>  
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - '#address-cells'
>>> +  - '#size-cells'
>>> +  - '#io-channel-cells'
>>> +
>>>  allOf:
>>>    - if:
>>>        properties:
>>> @@ -146,6 +179,15 @@ allOf:
>>>              const: qcom,spmi-vadc
>>>  
>>>      then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 1
>>
>> min is redundant.
>>
>>> +          maxItems: 1
>>> +        interrupts:
>>> +          minItems: 1
>>> +          maxItems: 1
>>
>> So here you list and describe items instead.
> 
> Do you mean interrupts should be updated to something like this?
> 
>         interrupts:
>           maxItems: 1
> 	  description: 
>             End of conversion interrupt.
> 
> Does this look right?


No, you need to list the items. Look at qcom clocks.

> 
>>
>>> +        "#thermal-sensor-cells": false
>>> +        interrupt-names: false
>>
>> Keep things properly ordered. xxx-names is always next to xxx.
>>
>>>        patternProperties:
>>>          "^channel@[0-9a-f]+$":
>>>            properties:
>>> @@ -162,6 +204,8 @@ allOf:
>>>                enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 ]
>>>                default: 1
>>>  
>>> +            qcom,adc-tm: false
>>> +
>>>    - if:
>>>        properties:
>>>          compatible:
>>> @@ -169,6 +213,15 @@ allOf:
>>>              const: qcom,spmi-adc-rev2
>>>  
>>>      then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 1
>>> +          maxItems: 1
>>> +        interrupts:
>>> +          minItems: 1
>>> +          maxItems: 1
>>> +        "#thermal-sensor-cells": false
>>> +        interrupt-names: false
>>>        patternProperties:
>>>          "^channel@[0-9a-f]+$":
>>>            properties:
>>> @@ -185,6 +238,8 @@ allOf:
>>>                enum: [ 1, 2, 4, 8, 16 ]
>>>                default: 1
>>>  
>>> +            qcom,adc-tm: false
>>> +
>>>    - if:
>>>        properties:
>>>          compatible:
>>> @@ -192,6 +247,15 @@ allOf:
>>>              const: qcom,spmi-adc5
>>>  
>>>      then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 1
>>> +          maxItems: 1
>>> +        interrupts:
>>> +          minItems: 1
>>> +          maxItems: 1
>>> +        "#thermal-sensor-cells": false
>>> +        interrupt-names: false
>>>        patternProperties:
>>>          "^channel@[0-9a-f]+$":
>>>            properties:
>>> @@ -208,6 +272,8 @@ allOf:
>>>                enum: [ 1, 2, 4, 8, 16 ]
>>>                default: 1
>>>  
>>> +            qcom,adc-tm: false
>>> +
>>>    - if:
>>>        properties:
>>>          compatible:
>>> @@ -215,6 +281,59 @@ allOf:
>>>              const: qcom,spmi-adc7
>>>  
>>>      then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 1
>>> +          maxItems: 1
>>> +        interrupts:
>>> +          minItems: 1
>>> +          maxItems: 1
>>> +        "#thermal-sensor-cells": false
>>> +        interrupt-names: false
>>> +      patternProperties:
>>> +        "^channel@[0-9a-f]+$":
>>> +          properties:
>>> +            qcom,decimation:
>>> +              enum: [ 85, 340, 1360 ]
>>> +              default: 1360
>>> +
>>> +            qcom,hw-settle-time:
>>> +              enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
>>> +                      8000, 16000, 32000, 64000, 128000 ]
>>> +              default: 15
>>> +
>>> +            qcom,avg-samples:
>>> +              enum: [ 1, 2, 4, 8, 16 ]
>>> +              default: 1
>>> +
>>> +            qcom,adc-tm: false
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: qcom,spmi-adc5-gen3
>>> +
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 1
>>
>> Why this is flexible?
> 
> I'm assuming you are asking why it can be either 1 or 2 instead of exactly 2.
> Both configurations can be supported in HW and it varies between boards. Some of them
> have exactly one SDAM peripheral assigned for ADC usage and some may have two.

That's odd. How this can vary between boards with the same, exactly the
same PMIC? Do you program entirely different FW for different boards
with the same hardware (PMIC)?

This is programming model, so any differences here must be obvious.

Best regards,
Krzysztof


