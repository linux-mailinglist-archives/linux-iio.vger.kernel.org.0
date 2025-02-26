Return-Path: <linux-iio+bounces-16081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D24A458E3
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1DD3AAD55
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3722423E;
	Wed, 26 Feb 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OqFulvZX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F11E1DF6
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559913; cv=none; b=q/SpaEwFhCbOy/1TZple2mUDt9o5HKJqLkZrpIdYH/a7iMEdqroI1A9LVAerIYExGdDUNoaae4nSRnItSgv6rQSoGe8zUUF4OgREqnf7nTQzI3VQJAeeE13WV8Cv0w9U1XrWmXvYmuLElzv52abQy6rk1dofNecohVTqYETp1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559913; c=relaxed/simple;
	bh=PcnVewobUpwY3B+m47Hrd10VFOnXZ9Q89zU4OD+jf4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOMURx5OgqaO6wdseFxkZS8HJVAy9hgYBjPNjFZJk1lb/7iVemomyVnEicL/h5fFpVBEodTloh8gPQ7BErYDAPFppCyU18Kxhv0VLzY1tLtADYoQ4MsyPOU0enJx2vEjGn/HkzyNQ5vvNwNrJxxUYeXmvpQK3+Rhmpym9Euxk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OqFulvZX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMj2mw019202
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f61W1T6BxEosfDwDp2JyXTSqOjQ8+exE/jNPghP5WhY=; b=OqFulvZXkua2LXkD
	4tsQAwIRSlpKAkqHlBHCT6XMf1ATp6F51zPG9JqGOvmumGikYdKPH8QxQFStM6TR
	woCIIlUVUfUWRnKitLvATMwLEX3TOX3RkSbZSozdGiukWvIKAW5UcBd2/CgmagEK
	kPOJxGqHMtUkvWVgqrDk9D8nyx5odCUlQDLAhAyCPdrpAb9aaJxXYYtdfybMLlTc
	8mPXt8xYC3hy1Gd8jzedEqC0Or17hR8VlBF+Rfk92bUltfLYMTCu8+juxOAGC+b1
	r3SlESI8g10Sjq9/SaEhGmTzsJbtKz+ktF3bJRB/e6tdveoALsBubFsnEujKtjlL
	8YNO8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451px41aqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:51:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc4fc93262so14141025a91.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 00:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559909; x=1741164709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f61W1T6BxEosfDwDp2JyXTSqOjQ8+exE/jNPghP5WhY=;
        b=j0pB7GJcBer/lWuSuNNna4Br9t6tXgeU6Z7wXBeLZyoanXJB7QdiNtcUAtMO+5yafN
         P/bIpVOs94+PoIGAPaBb9IdkvohqmxjzGbq/M9Gu9ScqD0QX7Xbw8tr2FjIuzSQEN6mn
         K4M9f3Pk3PuxdPXK5d+R9LlthtqG1MMMH8Io3DjBu7MqNSB/6/biWJQyYoICWjxXYvH1
         JVGYoLJa6v+ro3VRBlPBb0jSWRV+pfnyD2h1jogyx5KIzoCqJiUgpp0jdTYPN1tkOZzA
         wpSu+grKifstpNkGJ8RCBU6bjgABbJbKsTDWnkALI2/3Q/EtqX1YUS3CKVFeDS17QS18
         0oFg==
X-Forwarded-Encrypted: i=1; AJvYcCXThP+QNZO2mBbB1/MmRLJLNi12d4ug3zmBoQqbEi9fI11GGQefwKSJABZTCj+LU30lWL4/sPkpTuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/f6BMTwmryp+fOvDekHpWzqMPEWqA7FCqBwSCWwf4xlgUhyNI
	XgAwG/Uqb8p8DKAQYWp+uy8VmRELEiuUDKOugu6NubdFzOj/KB7hqSk3h2B+U9ZkG9xucs/XegP
	BOAvtkNf3fkQABhxq96Y54tM417XdE0WQsAggcTwVEdWCAnzmyD2gjOMOulE=
X-Gm-Gg: ASbGncuWGY50WwIYz39rhTuI2d3q3IIajEAdYUIoql+dDmBHyJYh3kp+w8SRDIooriR
	LlSatYxo+rXnRXG06xov9tkSSiAvbHyHtwty9v3VopYqeUEzvHGeJL/14eeI9J8MTx+Gvh5ld5t
	/dA2EI+sw41IRjxsdQs3TcghsTAD78FU4gJIOoBXcRZoa9pG2MzX/56TpXClR06EyTXinR3eVXv
	YVtglVlMhqxlUHPklwC7PJ8kHRbT0Bm9G46O4jnMEidjhOcBQugiNIvJE7vdjmRRkY/DOR0BFur
	zqBUBvJZL8QGvwspmE5wjiq3LurNYytLzXctDeSAhy0o
X-Received: by 2002:a05:6a20:12c9:b0:1ee:ae1f:aa78 with SMTP id adf61e73a8af0-1f10ad3358cmr3794769637.10.1740559908895;
        Wed, 26 Feb 2025 00:51:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEd+mtFLk3agLV3ESrw8tsxdPL30zx7UBWKyD2XbpfQ2vOUFbim50LZCFhkYDenL6bApU2VA==
X-Received: by 2002:a05:6a20:12c9:b0:1ee:ae1f:aa78 with SMTP id adf61e73a8af0-1f10ad3358cmr3794726637.10.1740559908441;
        Wed, 26 Feb 2025 00:51:48 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aedaab2ea10sm2615675a12.65.2025.02.26.00.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 00:51:48 -0800 (PST)
Message-ID: <b5707f37-cc5d-47fb-a8d6-a1da8a9a7ff1@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 14:21:40 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>
 <20250202-pragmatic-sparkling-spider-ccd90b@krzk-bin>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250202-pragmatic-sparkling-spider-ccd90b@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T3R3HIK3CEjRpmPjMKXH3MrXqvZSnZWD
X-Proofpoint-ORIG-GUID: T3R3HIK3CEjRpmPjMKXH3MrXqvZSnZWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260070

Hi Krzysztof,

On 2/2/2025 7:08 PM, Krzysztof Kozlowski wrote:
> On Sat, Feb 01, 2025 at 12:02:40AM +0530, Jishnu Prakash wrote:
>  
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>> new file mode 100644
>> index 000000000000..d6f2d18623d4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>> @@ -0,0 +1,157 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm's SPMI PMIC ADC5 Gen3
>> +
>> +maintainers:
>> +  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> +
>> +description: |
>> +  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to
>> +  clients to read voltage. It is a 16-bit sigma-delta ADC.
>> +  It also performs the same thermal monitoring function as
>> +  the existing ADC_TM devices.
> 
> Don't wrap at 61, but at 80. See Coding style.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,spmi-adc5-gen3
>> +
>> +  reg:
>> +    items:
>> +      - description: SDAM0 base address in the SPMI PMIC register map
>> +      - description: SDAM1 base address
>> +    minItems: 1
> 
> Why is this flexible?
> 
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: SDAM0 end of conversion (EOC) interrupt
>> +      - description: SDAM1 EOC interrupt
>> +    minItems: 1
> 
> Same question.

To explain why "reg" and "interrupts" are flexible:

We need to add one item under each of these properties, per ADC SDAM. The number of PMIC SDAM peripherals allocated for ADC is not correlated with the PMIC used, 
it is programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.

The number of ADC SDAMs used on a given SOC with a given PMIC (like PMK8550) will be fixed, but it is possible for
the same PMIC to have 1 of its SDAMs allocated for ADC when used on one SOC and 2 SDAMs allocated for ADC when used on another SOC.  

All boards using a particular (SOC + PMIC) combination will have the same number of ADC SDAMs supported on that PMIC.


> 
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: sdam0
>> +      - const: sdam1
>> +    minItems: 1
> 
> So basically interrupt 0 and 1, just drop the names property entirely.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - '#io-channel-cells'
>> +  - interrupts
>> +  - interrupt-names
>> +
>> +patternProperties:
> 
> required block always goes after all properties, not in the middle.
> 
>> +  "^channel@[0-9a-f]+$":
>> +    type: object
>> +    unevaluatedProperties: false
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      Represents the external channels which are connected to the ADC.
>> +    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
>> +
>> +    properties:
>> +      qcom,decimation:
>> +        enum: [ 85, 340, 1360 ]
>> +        default: 1360
>> +
>> +      qcom,hw-settle-time:
>> +        enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
>> +                8000, 16000, 32000, 64000, 128000 ]
>> +        default: 15
>> +
>> +      qcom,avg-samples:
>> +        enum: [ 1, 2, 4, 8, 16 ]
>> +        default: 1
>> +
>> +      qcom,adc-tm:
>> +        description:
>> +          ADC_TM is a threshold monitoring feature in HW which can be enabled on any
>> +          ADC channel, to trigger an IRQ for threshold violation. In earlier ADC
>> +          generations, it was implemented in a separate device (documented in
>> +          Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.)
>> +          In Gen3, this feature can be enabled in the same ADC device for any channel
>> +          and threshold monitoring and IRQ triggering are handled in FW (PBS) instead of
>> +          another dedicated HW block.
>> +          This property indicates ADC_TM monitoring is done on this channel.
>> +        type: boolean
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h>
>> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h>
>> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h>
>> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pmic {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      adc@9000 {
>> +        compatible = "qcom,spmi-adc5-gen3";
>> +        reg = <0x9000>, <0x9100>;
>> +        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
>> +                      <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "sdam0", "sdam1";
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        #io-channel-cells = <1>;
>> +        #thermal-sensor-cells = <1>;
>> +
>> +        /* PMK8550 Channel nodes */
>> +        channel@3 {
>> +          reg = <PMK8550_ADC5_GEN3_DIE_TEMP(0)>;
>> +          label = "pmk8550_die_temp";
>> +          qcom,pre-scaling = <1 1>;
>> +        };
>> +
>> +        channel@44 {
>> +          reg = <PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU(0)>;
>> +          label = "pmk8550_xo_therm";
>> +          qcom,pre-scaling = <1 1>;
>> +          qcom,ratiometric;
>> +          qcom,hw-settle-time = <200>;
>> +          qcom,adc-tm;
>> +        };
>> +
>> +        /* PM8550 Channel nodes */
>> +        channel@103 {
>> +          reg = <PM8550_ADC5_GEN3_DIE_TEMP(1)>;
>> +          label = "pm8550_die_temp";
>> +          qcom,pre-scaling = <1 1>;
>> +        };
>> +
>> +        /* PM8550B Channel nodes */
>> +        channel@78f {
>> +          reg = <PM8550B_ADC5_GEN3_VBAT_SNS_QBG(7)>;
>> +          label = "pm8550b_vbat_sns_qbg";
>> +          qcom,pre-scaling = <1 3>;
>> +        };
>> +
>> +        /* PM8550VS_C Channel nodes */
>> +        channel@203 {
>> +          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
>> +          label = "pm8550vs_c_die_temp";
>> +          qcom,pre-scaling = <1 1>;
>> +        };
>> +      };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
>> index cd087911ee88..1531153e6ea8 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
>> @@ -17,8 +17,8 @@ properties:
>>      description:
>>        ADC channel number.
>>        See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> -      For PMIC7 ADC, the channel numbers are specified separately per PMIC
>> -      in the PMIC-specific files in include/dt-bindings/iio/adc.
>> +      For PMIC7 ADC and PMIC5 Gen3 ADC, the channel numbers are specified
>> +      separately per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
>>      maxItems: 1
>>  
>>    label:
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> index b0ccad00c1a6..b77af38440fe 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> @@ -15,6 +15,8 @@ description: |
>>    voltage. The VADC is a 15-bit sigma-delta ADC.
>>    SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>>    voltage. The VADC is a 16-bit sigma-delta ADC.
>> +  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
>> +  it can be considered like PMIC5 Gen2.
>>  
>>  properties:
>>    compatible:
>> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
>> new file mode 100644
>> index 000000000000..9940715683b4
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
> 
> 
> Which is the name/model of the device? PM8550? If so, then this must
> follow standard compatible naming, so qcom,pm8550-foo-bar. Unless device
> name is somehow different.
> 
> Also drop redundant pieces here - can it be anything else than SPMI?
> Like I2C?

OK, I'll update this file's name to qcom,pm8550-adc5-gen3.h and update the other file names similarly.
I'll also address your other comments in the next patch series.

Thanks,
Jishnu

> 
> Best regards,
> Krzysztof
> 


