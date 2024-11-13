Return-Path: <linux-iio+bounces-12202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1275C9C74CD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20916B2F421
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59F201007;
	Wed, 13 Nov 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XW4gku+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D729CE6;
	Wed, 13 Nov 2024 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506792; cv=none; b=o5zVru4DqavHhIfukWQjNUy9LLBVxjQdPsLGR200dlEBktEAL9C1lkFKnpj/wkXVhZqiLt2AubuVbAY5rn0zNadLYcmPk/CD0niuVsyNpZYGyLxjZufDxQczwJe8vYElCMpvrO5PLWjGkQzTu2Glvz+Mfqv0YUaVykk3d/xzzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506792; c=relaxed/simple;
	bh=5bHs1tZ4zvavXZZXTniPAMvY0eWHaUVmXLGYaTF48Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jdc/94WN/5ZL+CPf8EvnLxQGGgLtH9hQhnTxHCvCqL9wsy1CnYlsXmEnXoSxI/w4QGclVebllttdfIi97OfQE1SyqTvDwSfkG99daZ6Kqhv9Joifa41vGrwIl3tNdTVIJ3hv81mfrjYW64iVMmSkEPOJrqZEdM49hAKEfgbwvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XW4gku+4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADAq8qZ005717;
	Wed, 13 Nov 2024 14:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dcm8gjD/V9/9S5iEtqPW12oiGCOzF/jQslhvWgedT5I=; b=XW4gku+4WHgLe5Xt
	jbUzwZJumIpmF9BnK08LQ7/etshGnf4aZqIs2m710R+ZjMmouggdMxoIv136nJqm
	FvmowyWRH/ckAp6VW9NRr5jbpSwajjy8Xd2S3njWDQAVt8JYJQ/S3T+KmzCoRmAZ
	WlyFb2G2COksWxJ11+V6xJzmD9cj40gfvf5ir5kmoXJVxDJk6Gnc4O9RCH+nP4lk
	JlYMovC5y5RvOdjGnMii0kx4FoqyDdmtUcjbnPKkdw2eSMCt/CW/+Xa3u8v68Ved
	dB7vplRLwhnFWYuw0xM5rmoB7mXYUbAYga+5ERARksMh4LvDitsjFMxYz2tifn+8
	UXg7BQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vtqwrffs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:06:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADE67W1027036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:06:07 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 06:05:58 -0800
Message-ID: <bb877daa-8cdb-4c52-a70a-2206e67d014e@quicinc.com>
Date: Wed, 13 Nov 2024 19:35:40 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <daniel.lezcano@linaro.org>, <sboyd@kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <amitk@kernel.org>
CC: <lee@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <lars@metafoo.de>, <quic_skakitap@quicinc.com>,
        <neil.armstrong@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-3-quic_jprakash@quicinc.com>
 <6daaee01-36a0-4dc5-86c7-106aabbfff4e@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <6daaee01-36a0-4dc5-86c7-106aabbfff4e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fASjElTKqZOKUNMtvxbLCT20sDki-zYb
X-Proofpoint-ORIG-GUID: fASjElTKqZOKUNMtvxbLCT20sDki-zYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130120

Hi Krzysztof,

On 10/31/2024 4:28 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 19:58, Jishnu Prakash wrote:
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>
>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>> going through PBS(Programmable Boot Sequence) firmware through a single
>> register interface. This interface is implemented on an SDAM (Shared
>> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
>> than a dedicated ADC peripheral.
>>
>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>> channels and virtual channels (combination of ADC channel number and
>> PMIC SID number) per PMIC, to be used by clients of this device.
>>
>> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
> 
> This has still test failures, so limited review follows.
> 
>>  properties:
>>    compatible:
>> @@ -23,14 +27,20 @@ properties:
>>            - const: qcom,pms405-adc
>>            - const: qcom,spmi-adc-rev2
>>        - enum:
>> -          - qcom,spmi-vadc
>> -          - qcom,spmi-adc5
>>            - qcom,spmi-adc-rev2
>> +          - qcom,spmi-adc5
>> +          - qcom,spmi-adc5-gen3
>>            - qcom,spmi-adc7
>> +          - qcom,spmi-vadc
>>  
>>    reg:
>> -    description: VADC base address in the SPMI PMIC register map
>> -    maxItems: 1
>> +    description:
>> +      For compatible properties "qcom,spmi-vadc", "qcom,spmi-adc5", "qcom,spmi-adc-rev2"
>> +      and "qcom,spmi-adc7", reg is the VADC base address in the SPMI PMIC register map.
>> +      For compatible property "qcom,spmi-adc5-gen3", each reg corresponds to an SDAM
>> +      peripheral base address that is being used for ADC functionality.
> 
> This description is not really needed. You need to provide constraints
> in schema.
> 
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>    '#address-cells':
>>      const: 1
>> @@ -38,20 +48,28 @@ properties:
>>    '#size-cells':
>>      const: 0
>>  
>> +  "#thermal-sensor-cells":
>> +    const: 1
>> +    description:
>> +      Number of cells required to uniquely identify the thermal sensors.
> 
> Drop, redundant.
> 
>> +      For compatible property "qcom,spmi-adc5-gen3", this property is
>> +      required for if any channels under it are used for ADC_TM.
>> +      Since we have multiple sensors this is set to 1.
> 
> Drop sentence, redundant.
> 
>> +
>>    '#io-channel-cells':
>>      const: 1
>>  
>>    interrupts:
>> -    maxItems: 1
>>      description:
>>        End of conversion interrupt.
>> +      For compatible property "qcom,spmi-adc5-gen3", interrupts are defined
>> +      for each SDAM being used.
> 
> Drop descriptions and instead rather list and describe items. You keep
> repeating schema in free form text. That's not the point.
> 
>> +    minItems: 1
>> +    maxItems: 2
>>  
>> -required:
>> -  - compatible
>> -  - reg
>> -  - '#address-cells'
>> -  - '#size-cells'
>> -  - '#io-channel-cells'
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>  patternProperties:
>>    "^channel@[0-9a-f]+$":
>> @@ -71,8 +89,8 @@ patternProperties:
>>          description: |
>>            ADC channel number.
>>            See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> -          For PMIC7 ADC, the channel numbers are specified separately per PMIC
>> -          in the PMIC-specific files in include/dt-bindings/iio/adc.
>> +          For PMIC7 and PMIC5 Gen3 ADC, the channel numbers are specified separately
>> +          per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
>>  
>>        label:
>>          description: |
>> @@ -113,11 +131,11 @@ patternProperties:
>>                channel calibration. If property is not found, channel will be
>>                calibrated with 0.625V and 1.25V reference channels, also
>>                known as absolute calibration.
>> -            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
>> -              "qcom,spmi-adc-rev2", if this property is specified VADC will use
>> -              the VDD reference (1.875V) and GND for channel calibration. If
>> -              property is not found, channel will be calibrated with 0V and 1.25V
>> -              reference channels, also known as absolute calibration.
>> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7",
>> +              "qcom,spmi-adc-rev2" and "qcom,spmi-adc5-gen3", if this property is
>> +              specified VADC will use the VDD reference (1.875V) and GND for channel
>> +              calibration. If property is not found, channel will be calibrated with
>> +              0V and 1.25V reference channels, also known as absolute calibration.
>>          type: boolean
>>  
>>        qcom,hw-settle-time:
>> @@ -135,9 +153,24 @@ patternProperties:
>>              from the ADC that is an average of multiple samples. The value
>>              selected is 2^(value).
>>  
>> +      qcom,adc-tm:
>> +        description:
>> +          Indicates if ADC_TM monitoring is done on this channel.
> 
> What is "ADC_TM"? Why this would be property of a board? This does not
> look like suitable for DT, at least based on such very vague explanation.
> 
>> +          Defined for compatible property "qcom,spmi-adc5-gen3".
> 
> Drop redundant.
> 
>> +          This is the same functionality as in the existing QCOM ADC_TM
>> +          device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
> 
> What does it mean? How property can represent functionality of entire
> binding?
> 
> BTW, use full paths when refering to files.
> 

To address all your above questions for ADC_TM:

The file "Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml" describes
the Qualcomm ADC thermal monitoring device, which existed as a separate device on older
PMIC generations. ADC_TM refers to this functionality.

In ADC5 Gen3, ADC_TM functionality is combined with the existing ADC read functionality
described in this file, under a single device.

In the earlier ADC_TM DT nodes, each child node would describe one of the IIO ADC channels being
monitored by ADC_TM HW. In this ADC5 Gen3 device, setting the property 'qcom,adc-tm' for a channel
node means that it will also be monitored in HW exactly like an ADC_TM channel.

It can be considered a hardware property as the monitoring is done by a sequence under
PBS (Programmable Boot Sequence, can be considered firmware), which periodically gets the
channel reading and checks it against upper/lower thresholds set by clients of this driver, 
for threshold violations.


>> +        type: boolean
>> +
>>      required:
>>        - reg
>>  
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - '#io-channel-cells'
>> +
>>  allOf:
>>    - if:
>>        properties:
>> @@ -146,6 +179,15 @@ allOf:
>>              const: qcom,spmi-vadc
>>  
>>      then:
>> +      properties:
>> +        reg:
>> +          minItems: 1
> 
> min is redundant.
> 
>> +          maxItems: 1
>> +        interrupts:
>> +          minItems: 1
>> +          maxItems: 1
> 
> So here you list and describe items instead.

Do you mean interrupts should be updated to something like this?

        interrupts:
          maxItems: 1
	  description: 
            End of conversion interrupt.

Does this look right?

> 
>> +        "#thermal-sensor-cells": false
>> +        interrupt-names: false
> 
> Keep things properly ordered. xxx-names is always next to xxx.
> 
>>        patternProperties:
>>          "^channel@[0-9a-f]+$":
>>            properties:
>> @@ -162,6 +204,8 @@ allOf:
>>                enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 ]
>>                default: 1
>>  
>> +            qcom,adc-tm: false
>> +
>>    - if:
>>        properties:
>>          compatible:
>> @@ -169,6 +213,15 @@ allOf:
>>              const: qcom,spmi-adc-rev2
>>  
>>      then:
>> +      properties:
>> +        reg:
>> +          minItems: 1
>> +          maxItems: 1
>> +        interrupts:
>> +          minItems: 1
>> +          maxItems: 1
>> +        "#thermal-sensor-cells": false
>> +        interrupt-names: false
>>        patternProperties:
>>          "^channel@[0-9a-f]+$":
>>            properties:
>> @@ -185,6 +238,8 @@ allOf:
>>                enum: [ 1, 2, 4, 8, 16 ]
>>                default: 1
>>  
>> +            qcom,adc-tm: false
>> +
>>    - if:
>>        properties:
>>          compatible:
>> @@ -192,6 +247,15 @@ allOf:
>>              const: qcom,spmi-adc5
>>  
>>      then:
>> +      properties:
>> +        reg:
>> +          minItems: 1
>> +          maxItems: 1
>> +        interrupts:
>> +          minItems: 1
>> +          maxItems: 1
>> +        "#thermal-sensor-cells": false
>> +        interrupt-names: false
>>        patternProperties:
>>          "^channel@[0-9a-f]+$":
>>            properties:
>> @@ -208,6 +272,8 @@ allOf:
>>                enum: [ 1, 2, 4, 8, 16 ]
>>                default: 1
>>  
>> +            qcom,adc-tm: false
>> +
>>    - if:
>>        properties:
>>          compatible:
>> @@ -215,6 +281,59 @@ allOf:
>>              const: qcom,spmi-adc7
>>  
>>      then:
>> +      properties:
>> +        reg:
>> +          minItems: 1
>> +          maxItems: 1
>> +        interrupts:
>> +          minItems: 1
>> +          maxItems: 1
>> +        "#thermal-sensor-cells": false
>> +        interrupt-names: false
>> +      patternProperties:
>> +        "^channel@[0-9a-f]+$":
>> +          properties:
>> +            qcom,decimation:
>> +              enum: [ 85, 340, 1360 ]
>> +              default: 1360
>> +
>> +            qcom,hw-settle-time:
>> +              enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
>> +                      8000, 16000, 32000, 64000, 128000 ]
>> +              default: 15
>> +
>> +            qcom,avg-samples:
>> +              enum: [ 1, 2, 4, 8, 16 ]
>> +              default: 1
>> +
>> +            qcom,adc-tm: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,spmi-adc5-gen3
>> +
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 1
> 
> Why this is flexible?

I'm assuming you are asking why it can be either 1 or 2 instead of exactly 2.
Both configurations can be supported in HW and it varies between boards. Some of them
have exactly one SDAM peripheral assigned for ADC usage and some may have two.


> 
>> +          items:
>> +            - description: SDAM0 base address in the SPMI PMIC register map
>> +            - description: SDAM1 base address
>> +        interrupts:
>> +          minItems: 1
> 
> 
> Why this is flexible?

reg, interrupts and interrupt-names are all added per SDAM, so they can all be
either 1 or 2.

Will address all your other comments in the next patch version.

Thanks,
Jishnu

> 
> 
>> +          items:
>> +            - description: SDAM0 end of conversion (EOC) interrupt
>> +            - description: SDAM1 EOC interrupt
>> +        interrupt-names:
>> +          minItems: 1
>> +          items:
>> +            - const: adc-sdam0
> 
> sdam0
> 
>> +            - const: adc-sdam1
> 
> sdam1
> 
>> +      required:
>> +        - interrupts
>> +        - interrupt-names
>>        patternProperties:
>>          "^channel@[0-9a-f]+$":
>>            properties:
>> @@ -307,3 +426,64 @@ examples:
> 
> 
> 
> Best regards,
> Krzysztof
> 


