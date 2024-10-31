Return-Path: <linux-iio+bounces-11687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB189B7933
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435871F2589A
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399F4199FD7;
	Thu, 31 Oct 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzKQ0jA3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925C199EBB
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372313; cv=none; b=VyffN4Qlztx6Ua3NJYl4LuNjJv3nwHiN6oTGlpwmHPTwUK6HxHpzSr1bvXftiHkUWOct0oy/pwZ6zZkIYuOAqqejr4V0oMptW640XiehYmXMCeSjDBs/n+Wyc5XvPwyHATGwiu14DWhRYeeBF7scOLq+FoG7VxdZaM0FhNUdh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372313; c=relaxed/simple;
	bh=bfOfHojxd+DS+uO+0NiH49kE0XS1cWBsQ0Jkau1iuBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAZrUBrfFIwamQQ2NjsjXekttS/iJISg5az63xMGEgT5SZG4mQB8UCAMW77ZnaRO393WS7B6+s3PNjOkwLE0oy+V8BRFqJVRlWyktJwiMkIxWrpgBDCkl5TDAeZ+qVuBZr0nvLJmCM42I+MYH9xTCNl7uQYRV1jekHjX+U1QqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HzKQ0jA3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43159469053so897395e9.2
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730372308; x=1730977108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5uloUCtajTWqeXsTlCEgyg+k7SvpEJDLJv2PzPAA1U0=;
        b=HzKQ0jA3iVSeFdLRvmHrzEpQi70QmPz+TOWCQ41U8HkdAiXpAmmFgUJVo3O5vRC9qy
         4nkgPcPMFyBHr7uc5PI3Ofox3Qbw8fB/aZMbC2FW/IPtFozS6nSXk3IF3fXb2s1U0I8N
         sizVy3PzT6HyoH7uXVBUyzNqca3zG9sjkgLl/O1Kn9GVV6rwuw92CebtpTl14ZOsnBdA
         iQH/UfEm/qCaq0ur/PaBJ86GmUJVMBOphA5qKyV5bYwPOWqx8gxZMp4fBr/IvqBLa5ch
         E9yoUvqBdOlipkKHcqzK6U998PooNsjnHa+gAYIrYg1LEgyJvYEf8UmV3QoJ2u/wmWUe
         u8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372308; x=1730977108;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uloUCtajTWqeXsTlCEgyg+k7SvpEJDLJv2PzPAA1U0=;
        b=mrhJT77fGDXS5MfXUC7MzmJguG1w61fs6i+KsZa2DPwq3TQhpSBcpMypahURrVm9bO
         KwrgGh0VR0UkrdPuSbm3TJxJGR4denfgIOSVBA4SDSmpfVzY+d2WS81JNUtvwwpk7ore
         wH1fyezzxrVQJmE/Nv9I61g0LauDNYpeJLgQu/eML/RTSLA0/aMH9QlERTpAEqu5JgQp
         Eh5yZNXTNIa4snOjCfj9bDgJIIQ0m9Q0P3Qc1JYlQATOA9aAZ1MRmK2dwmFf034szvsQ
         CuEYjYOBP0c0rQUycU7UTAWV54zPT91Nbh2H6W+06jB7iJFSGangrpCtJNCN5cQZG2cj
         2Ntw==
X-Forwarded-Encrypted: i=1; AJvYcCV2MQ1goWWmqa6QAtTyvYC60IbqpGsq7knebr5yzz401z4B3esOC+R9u3Qube2QmNWLg4QvDFXIN/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydf6RTjf/exW0BPZ1SC+8FJvZjrZWFhxhiha7QbtM9ZOceaZI2
	lVqXxUHsIYpoktE6VZu/sG+iBzNe9fyW/tB7E0rmv3kOZj4qn1JL9/qqfKDdn5U=
X-Google-Smtp-Source: AGHT+IFN8GAhtwC5u9nGhsLRzqJuD+JbfHKmRd05w+Hp8Wt8hvX1b/p4ngqQDN1H3073nE2rTZnWPQ==
X-Received: by 2002:a05:600c:450f:b0:42c:baba:13cb with SMTP id 5b1f17b1804b1-4319ac72da8mr73793865e9.2.1730372308023;
        Thu, 31 Oct 2024 03:58:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910357sm53981465e9.11.2024.10.31.03.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:58:27 -0700 (PDT)
Message-ID: <6daaee01-36a0-4dc5-86c7-106aabbfff4e@linaro.org>
Date: Thu, 31 Oct 2024 11:58:24 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241030185854.4015348-3-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 19:58, Jishnu Prakash wrote:
> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> 
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS(Programmable Boot Sequence) firmware through a single
> register interface. This interface is implemented on an SDAM (Shared
> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
> than a dedicated ADC peripheral.
> 
> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
> channels and virtual channels (combination of ADC channel number and
> PMIC SID number) per PMIC, to be used by clients of this device.
> 
> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---

This has still test failures, so limited review follows.

>  properties:
>    compatible:
> @@ -23,14 +27,20 @@ properties:
>            - const: qcom,pms405-adc
>            - const: qcom,spmi-adc-rev2
>        - enum:
> -          - qcom,spmi-vadc
> -          - qcom,spmi-adc5
>            - qcom,spmi-adc-rev2
> +          - qcom,spmi-adc5
> +          - qcom,spmi-adc5-gen3
>            - qcom,spmi-adc7
> +          - qcom,spmi-vadc
>  
>    reg:
> -    description: VADC base address in the SPMI PMIC register map
> -    maxItems: 1
> +    description:
> +      For compatible properties "qcom,spmi-vadc", "qcom,spmi-adc5", "qcom,spmi-adc-rev2"
> +      and "qcom,spmi-adc7", reg is the VADC base address in the SPMI PMIC register map.
> +      For compatible property "qcom,spmi-adc5-gen3", each reg corresponds to an SDAM
> +      peripheral base address that is being used for ADC functionality.

This description is not really needed. You need to provide constraints
in schema.

> +    minItems: 1
> +    maxItems: 2
>  
>    '#address-cells':
>      const: 1
> @@ -38,20 +48,28 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description:
> +      Number of cells required to uniquely identify the thermal sensors.

Drop, redundant.

> +      For compatible property "qcom,spmi-adc5-gen3", this property is
> +      required for if any channels under it are used for ADC_TM.
> +      Since we have multiple sensors this is set to 1.

Drop sentence, redundant.

> +
>    '#io-channel-cells':
>      const: 1
>  
>    interrupts:
> -    maxItems: 1
>      description:
>        End of conversion interrupt.
> +      For compatible property "qcom,spmi-adc5-gen3", interrupts are defined
> +      for each SDAM being used.

Drop descriptions and instead rather list and describe items. You keep
repeating schema in free form text. That's not the point.

> +    minItems: 1
> +    maxItems: 2
>  
> -required:
> -  - compatible
> -  - reg
> -  - '#address-cells'
> -  - '#size-cells'
> -  - '#io-channel-cells'
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
>  
>  patternProperties:
>    "^channel@[0-9a-f]+$":
> @@ -71,8 +89,8 @@ patternProperties:
>          description: |
>            ADC channel number.
>            See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> -          For PMIC7 ADC, the channel numbers are specified separately per PMIC
> -          in the PMIC-specific files in include/dt-bindings/iio/adc.
> +          For PMIC7 and PMIC5 Gen3 ADC, the channel numbers are specified separately
> +          per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
>  
>        label:
>          description: |
> @@ -113,11 +131,11 @@ patternProperties:
>                channel calibration. If property is not found, channel will be
>                calibrated with 0.625V and 1.25V reference channels, also
>                known as absolute calibration.
> -            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
> -              "qcom,spmi-adc-rev2", if this property is specified VADC will use
> -              the VDD reference (1.875V) and GND for channel calibration. If
> -              property is not found, channel will be calibrated with 0V and 1.25V
> -              reference channels, also known as absolute calibration.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7",
> +              "qcom,spmi-adc-rev2" and "qcom,spmi-adc5-gen3", if this property is
> +              specified VADC will use the VDD reference (1.875V) and GND for channel
> +              calibration. If property is not found, channel will be calibrated with
> +              0V and 1.25V reference channels, also known as absolute calibration.
>          type: boolean
>  
>        qcom,hw-settle-time:
> @@ -135,9 +153,24 @@ patternProperties:
>              from the ADC that is an average of multiple samples. The value
>              selected is 2^(value).
>  
> +      qcom,adc-tm:
> +        description:
> +          Indicates if ADC_TM monitoring is done on this channel.

What is "ADC_TM"? Why this would be property of a board? This does not
look like suitable for DT, at least based on such very vague explanation.

> +          Defined for compatible property "qcom,spmi-adc5-gen3".

Drop redundant.

> +          This is the same functionality as in the existing QCOM ADC_TM
> +          device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.

What does it mean? How property can represent functionality of entire
binding?

BTW, use full paths when refering to files.

> +        type: boolean
> +
>      required:
>        - reg
>  
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#io-channel-cells'
> +
>  allOf:
>    - if:
>        properties:
> @@ -146,6 +179,15 @@ allOf:
>              const: qcom,spmi-vadc
>  
>      then:
> +      properties:
> +        reg:
> +          minItems: 1

min is redundant.

> +          maxItems: 1
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1

So here you list and describe items instead.

> +        "#thermal-sensor-cells": false
> +        interrupt-names: false

Keep things properly ordered. xxx-names is always next to xxx.

>        patternProperties:
>          "^channel@[0-9a-f]+$":
>            properties:
> @@ -162,6 +204,8 @@ allOf:
>                enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 ]
>                default: 1
>  
> +            qcom,adc-tm: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -169,6 +213,15 @@ allOf:
>              const: qcom,spmi-adc-rev2
>  
>      then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 1
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +        "#thermal-sensor-cells": false
> +        interrupt-names: false
>        patternProperties:
>          "^channel@[0-9a-f]+$":
>            properties:
> @@ -185,6 +238,8 @@ allOf:
>                enum: [ 1, 2, 4, 8, 16 ]
>                default: 1
>  
> +            qcom,adc-tm: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -192,6 +247,15 @@ allOf:
>              const: qcom,spmi-adc5
>  
>      then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 1
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +        "#thermal-sensor-cells": false
> +        interrupt-names: false
>        patternProperties:
>          "^channel@[0-9a-f]+$":
>            properties:
> @@ -208,6 +272,8 @@ allOf:
>                enum: [ 1, 2, 4, 8, 16 ]
>                default: 1
>  
> +            qcom,adc-tm: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -215,6 +281,59 @@ allOf:
>              const: qcom,spmi-adc7
>  
>      then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 1
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +        "#thermal-sensor-cells": false
> +        interrupt-names: false
> +      patternProperties:
> +        "^channel@[0-9a-f]+$":
> +          properties:
> +            qcom,decimation:
> +              enum: [ 85, 340, 1360 ]
> +              default: 1360
> +
> +            qcom,hw-settle-time:
> +              enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
> +                      8000, 16000, 32000, 64000, 128000 ]
> +              default: 15
> +
> +            qcom,avg-samples:
> +              enum: [ 1, 2, 4, 8, 16 ]
> +              default: 1
> +
> +            qcom,adc-tm: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc5-gen3
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1

Why this is flexible?

> +          items:
> +            - description: SDAM0 base address in the SPMI PMIC register map
> +            - description: SDAM1 base address
> +        interrupts:
> +          minItems: 1


Why this is flexible?


> +          items:
> +            - description: SDAM0 end of conversion (EOC) interrupt
> +            - description: SDAM1 EOC interrupt
> +        interrupt-names:
> +          minItems: 1
> +          items:
> +            - const: adc-sdam0

sdam0

> +            - const: adc-sdam1

sdam1

> +      required:
> +        - interrupts
> +        - interrupt-names
>        patternProperties:
>          "^channel@[0-9a-f]+$":
>            properties:
> @@ -307,3 +426,64 @@ examples:



Best regards,
Krzysztof


