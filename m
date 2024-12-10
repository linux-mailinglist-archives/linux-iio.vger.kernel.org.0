Return-Path: <linux-iio+bounces-13302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1C9EA882
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 07:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D706169E3D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 06:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A52422B590;
	Tue, 10 Dec 2024 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MWK8/Auv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD822ACF4;
	Tue, 10 Dec 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810750; cv=none; b=qe3W9s017TeibbTn5LD42+b5uVBfkcVe/cWgbMCocabLDGm7vxc0HmjidG2nPO1jzB4AB3cMC+oSXTb7C3CVmJBMjoVSOmAmoj/PhI6QOkAWVWIBwODN21rKolXIDx928ralwRgqbXECqDJC1XWCXe7eyob/rbK3iCS4fCPoGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810750; c=relaxed/simple;
	bh=xZMsiGPBr3KFig/eCS1hup6EpQX6vIIfRri5xQ6Mjd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OaKHmw/nNDEDJrAvUozpfTdBIB62PfcFH7LRmCCA9TAIbioyzUd+QIG1R/uxinKARdbwv6NUyWx+G9skwk9QwObePvP4s1/9mKvm02EK3KVqudsjFM2gzo4LJkO6kOYtNSxDfhM0TUj5zCP/fw6YcnynXWU0gcsl2uZnHBKzijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MWK8/Auv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HTibF020616;
	Tue, 10 Dec 2024 06:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MkWs26YblvhxfVtPRExuYqoHOIwLLa6mY+IhrSx6f48=; b=MWK8/AuvQy+1JffB
	FSoloKpyyciLhXV6kHj85TQ5SrLBMc4lgEqsDRbtEnTlpDb6KLX3q98MqNYJKxaP
	nZigo3WYkttIdac9L6ToYcnhzqxkodauyt2f8YHlQ5fEn16vtli5Z/Jkz0XPmAoO
	jTM+Q8SA6BtFQ6g3CicPKtlGIZlQJt7UEHuiCNTxU/tWZhm+RCs52raviJIUYSyY
	xCKPNyspC75XeKdwR8OQeOyeYuWcqQEYRTAbjSdAhLj7bwv9rQpviEBXWsYpqb+i
	pMRmeoUzbYQbEkegIpaTvjQC8FoWDcIDP9MZk55l/BwPTUC+8Err2A1JMCdgBMZ9
	Ppu8iw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgqbh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 06:05:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA65Smj032646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 06:05:28 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 22:05:20 -0800
Message-ID: <0aee9aeb-1e3e-4d86-8dd5-d134d33c4e11@quicinc.com>
Date: Tue, 10 Dec 2024 11:35:17 +0530
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
 <bb877daa-8cdb-4c52-a70a-2206e67d014e@quicinc.com>
 <7a078fd9-65b1-4f8b-a076-ff56c537e8ad@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <7a078fd9-65b1-4f8b-a076-ff56c537e8ad@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ozOahXidBJ_LG31NkPNbIDXgSSrbNuct
X-Proofpoint-ORIG-GUID: ozOahXidBJ_LG31NkPNbIDXgSSrbNuct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100043

Hi Krzysztof,

On 11/19/2024 2:32 PM, Krzysztof Kozlowski wrote:
> On 13/11/2024 15:05, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 10/31/2024 4:28 PM, Krzysztof Kozlowski wrote:
>>> On 30/10/2024 19:58, Jishnu Prakash wrote:
>>>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>>>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>>>
>>>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>>>> going through PBS(Programmable Boot Sequence) firmware through a single
>>>> register interface. This interface is implemented on an SDAM (Shared
>>>> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
>>>> than a dedicated ADC peripheral.
>>>>
>>>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>>>> channels and virtual channels (combination of ADC channel number and
>>>> PMIC SID number) per PMIC, to be used by clients of this device.
>>>>
>>>> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>>>> ---
>>>
>>> This has still test failures, so limited review follows.
>>>
>>>>  properties:
>>>>    compatible:
>>>> @@ -23,14 +27,20 @@ properties:
>>>>            - const: qcom,pms405-adc
>>>>            - const: qcom,spmi-adc-rev2
>>>>        - enum:
>>>> -          - qcom,spmi-vadc
>>>> -          - qcom,spmi-adc5
>>>>            - qcom,spmi-adc-rev2
>>>> +          - qcom,spmi-adc5
>>>> +          - qcom,spmi-adc5-gen3
>>>>            - qcom,spmi-adc7
>>>> +          - qcom,spmi-vadc
>>>>  
>>>>    reg:
>>>> -    description: VADC base address in the SPMI PMIC register map
>>>> -    maxItems: 1
>>>> +    description:
>>>> +      For compatible properties "qcom,spmi-vadc", "qcom,spmi-adc5", "qcom,spmi-adc-rev2"
>>>> +      and "qcom,spmi-adc7", reg is the VADC base address in the SPMI PMIC register map.
>>>> +      For compatible property "qcom,spmi-adc5-gen3", each reg corresponds to an SDAM
>>>> +      peripheral base address that is being used for ADC functionality.
>>>
>>> This description is not really needed. You need to provide constraints
>>> in schema.

...

>>>>        qcom,hw-settle-time:
>>>> @@ -135,9 +153,24 @@ patternProperties:
>>>>              from the ADC that is an average of multiple samples. The value
>>>>              selected is 2^(value).
>>>>  
>>>> +      qcom,adc-tm:
>>>> +        description:
>>>> +          Indicates if ADC_TM monitoring is done on this channel.
>>>
>>> What is "ADC_TM"? Why this would be property of a board? This does not
>>> look like suitable for DT, at least based on such very vague explanation.
>>>
>>>> +          Defined for compatible property "qcom,spmi-adc5-gen3".
>>>
>>> Drop redundant.
>>>
>>>> +          This is the same functionality as in the existing QCOM ADC_TM
>>>> +          device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
>>>
>>> What does it mean? How property can represent functionality of entire
>>> binding?
>>>
>>> BTW, use full paths when refering to files.
>>>
>>
>> To address all your above questions for ADC_TM:
>>
>> The file "Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml" describes
>> the Qualcomm ADC thermal monitoring device, which existed as a separate device on older
>> PMIC generations. ADC_TM refers to this functionality.
>>
>> In ADC5 Gen3, ADC_TM functionality is combined with the existing ADC read functionality
>> described in this file, under a single device.
>>
>> In the earlier ADC_TM DT nodes, each child node would describe one of the IIO ADC channels being
>> monitored by ADC_TM HW. In this ADC5 Gen3 device, setting the property 'qcom,adc-tm' for a channel
>> node means that it will also be monitored in HW exactly like an ADC_TM channel.
>>
>> It can be considered a hardware property as the monitoring is done by a sequence under
>> PBS (Programmable Boot Sequence, can be considered firmware), which periodically gets the
>> channel reading and checks it against upper/lower thresholds set by clients of this driver, 
>> for threshold violations.
> 
> So you want to configure channels in different way? Then specify it
> precisely - what is the nature of this feature/configuration. I have no
> clue what is ADC TM and you keep using it over and over.
> 

Yes, it is a different channel configuration, I'll update the explanation in the next patch.

For now, to explain the ADC_TM functionality:

ADC_TM is a *threshold monitoring* feature in HW which can be enabled on *any* ADC channel, to trigger an IRQ for threshold violation.
It was implemented in a separate device earlier, for which we had a separate ADC_TM driver.

In Gen3, this feature can be enabled in the same ADC device for any channel and threshold monitoring/IRQ triggering is handled in FW (PBS)
instead of having another dedicated HW block (old design).


> I still wait for answer why this is a property of a board.
> 

Setting this property on a channel indicates that HW is capable of monitoring that channel and this monitoring requirement would be based on board design.

>>
>>
>>>> +        type: boolean
>>>> +
>>>>      required:
>>>>        - reg
>>>>  
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - '#address-cells'
>>>> +  - '#size-cells'
>>>> +  - '#io-channel-cells'
>>>> +

...

>>>> +
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: qcom,spmi-adc5-gen3
>>>> +
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          minItems: 1
>>>
>>> Why this is flexible?
>>
>> I'm assuming you are asking why it can be either 1 or 2 instead of exactly 2.
>> Both configurations can be supported in HW and it varies between boards. Some of them
>> have exactly one SDAM peripheral assigned for ADC usage and some may have two.
> 
> That's odd. How this can vary between boards with the same, exactly the
> same PMIC? Do you program entirely different FW for different boards
> with the same hardware (PMIC)?

That is actually true, the FW can be different per SOC.

The number of PMIC SDAM peripherals allocated for ADC is not correlated with the PMIC used, 
it is programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.

The number of ADC SDAMs used on a given SOC with a given PMIC (like PMK8550) will be fixed, but it is possible for
the same PMIC to have 1 of its SDAMs allocated for ADC when used on one SOC and 2 SDAMs allocated for ADC when the PMIC is used on another SOC.  

All boards using a particular (SOC + PMIC) combination will have the same number of ADC SDAMs supported on that PMIC.

Thanks,
Jishnu


> 
> This is programming model, so any differences here must be obvious.
> 
> Best regards,
> Krzysztof
> 


