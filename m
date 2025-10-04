Return-Path: <linux-iio+bounces-24697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0503BB8894
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 700EF4F0A28
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 02:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC721A459;
	Sat,  4 Oct 2025 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ft3a855I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7D121C9F9
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545724; cv=none; b=Fqg4/3u6FLVb2MmLGHexbcIywle376lHEjao8Jp1ktH0aqEBRv8lcnTjhlgc49VdPjx0o680XnKqorxTj5kSMSPZtBloliT7o+I+PuAoVETBTen01lBW4gjqF964FRBKUZ+8ROs9GtcYnF855PcePxWCkeJgZYjgLcX0CW/YEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545724; c=relaxed/simple;
	bh=GrG+sZoFKRUNsfWBm/ynu78GdpzwzH9S+BPs1TW4kbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkWujZ9KvRhzm4Z5t8aOZg/pRLZucWdHOHK0R4h+BZ2K+W2e8k3xrFB0ltph77/i0Qj2n7Lpbw6u5R+V5pp8gv333zluL5VviqkrQ9D5xlOP33znkx3/uSGAN6/2RpALbzGOzkkeEmg5mZDnc/9lp4aqaltRHBqa4ykW79qEVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ft3a855I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593Ag8Td024967
	for <linux-iio@vger.kernel.org>; Sat, 4 Oct 2025 02:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8LKTW72ANVRWqbBbs1orSLC8F5L2PbgtH5ZHTOYbBuc=; b=ft3a855IBg2OWRMS
	nbEgEinUC+Q4mu3cLXd85jjLj7n8OO+Ucb94YSBzV9M5iSWwKetL3Jsq4a017sm3
	cUwHRP5HjLnh0yHLysMi0QaZz40BiJsG+tY4MKyYaSkGLwsw1bDzdS/CGipJqsiY
	7L2gTQb0941neWt3rAVYORT29ZMYfGyPGsjyNAQdgDcOkbEVECBxvw8eeUiRALnq
	ei11ZUNXHGrhrTpevLeGySZ6xGBdvFGGSt/+RjFwqSjvI+U2NTgOodJBAHW9HoQe
	hFrKTcGbHL+aukMz9E71YIsi5Bo7uj2gsJ6GVc9qFoi8h6MsRCr0B67/lsDkNLi1
	WxBtvg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e97848cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 04 Oct 2025 02:42:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so2098184b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Oct 2025 19:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759545720; x=1760150520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LKTW72ANVRWqbBbs1orSLC8F5L2PbgtH5ZHTOYbBuc=;
        b=FPGogC/IOWu96qo286JbTudmheoURg3zS73OTUlSB/2uJCQ/NM4byVNRIrAOLQomLb
         E/5KkuekF+WeOiwVnGpnBNZtcm9G0K5tj1UqUMpRRXBXOJ9uGr3hfZ/jiVF9CstLi7pG
         UNPSD/NmSDCoMzk+ZlmnpzJDlCUHrVAIJrHr/b9xZwHhz9mB1cOjG7qVdNpgPLSQcFOn
         q8fL5DHbqjRrNNOz+cVJhtpT9x6EPSheNJvbpzdJbfVS3ywvbXJAgowBC+A6O36k6yvK
         8iYMWB/Td/fWCPn/heZvI+kq0xAjYfsLRDmvRrDS/uN86DU8uOzyQnVttmlwaG7VzpCu
         SgPw==
X-Forwarded-Encrypted: i=1; AJvYcCW0+FkF5qAkhWjiqO5BIXv8ianZ6RF46H6LndIj04/6hjnOzzxJkZS78k4h9HdeqlgkGdCp7KuIAmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+MjZmkIEDtPUgKXqwXI7TXK1uKzoDwUys7q7q/cCdr8BnSY4
	ohsMGZ7p8QGKOO9PgNyYUjSJiV8f2iKxATP/EEtSOEK+Xz8Bf2BeFaZu9G4ttt15k+EYZHYc74N
	HKbEomtMZgtMxojRanL7mGpRDF9mtUuFO4JkN4OmATNQR4uiE0JM8PTqJgGfsJ6w=
X-Gm-Gg: ASbGncsDQ6XfDxQWeZl6VAXIJGpLWp1ZFhxPeGLGYD6QlODIZZBPn8zzPAuS7lwDRp6
	c49JyphT4oV1LtoobYX8Iv37hzZprp11uG/f3bLBhBvgVTNgq2EQErz52ga0r79KMRr/IxDZX1N
	XK+jX972arsXrneB5T79zmN7KJ3Z2+YgT//34go/PJhjK5HRnxanj9D0yeo2+RKs21cLY+glulX
	kZp7hoRamzlZ4UYWjbnVWdZOcUWbE5u7/sVUXDyfU8aVSk3Z0dBzvDQK41ZcA1fq/vCxiNe7SV6
	U5n0O/qNtf6UzI4d31DQkSoAl6Jo86qTFHwftuaaq8zXABY/xbZrypcWP2e0MWPd+g3SwHe90ZC
	rgw==
X-Received: by 2002:a05:6a00:8c6:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-78c98d5cb4cmr5364067b3a.10.1759545720386;
        Fri, 03 Oct 2025 19:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoqhjBr0QjJZhFy4pINP5TXEFjwtPrvEKpTZgZJvp0XgVHp0FpeliOUWBrj6cq1uLbRLNrvA==
X-Received: by 2002:a05:6a00:8c6:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-78c98d5cb4cmr5364023b3a.10.1759545719824;
        Fri, 03 Oct 2025 19:41:59 -0700 (PDT)
Received: from [10.216.33.177] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a2b9sm6189511b3a.19.2025.10.03.19.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 19:41:59 -0700 (PDT)
Message-ID: <a3158843-dfac-4adc-838a-35bb4b0cbea4@oss.qualcomm.com>
Date: Sat, 4 Oct 2025 08:11:48 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
 <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
 <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
 <20250927144757.4d36d5c8@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250927144757.4d36d5c8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9uwbRzH9PzQBUdBYrZWpmssKK3z_8Wq8
X-Proofpoint-ORIG-GUID: 9uwbRzH9PzQBUdBYrZWpmssKK3z_8Wq8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXyPy2V+IBSk97
 HlzRUYc5psjB869ZsNGmD7ThgMEVL9BwsB/oHhGuIcmSnvdFbUmZ/RW5SC69rixjZy38iCf6yiH
 eGHoUXyBMaCI/G7Xhs8WAmVHSDKzHv3UIimBz8BMZGS3Cw+n+LfKoTH4XyCkuSVut23jq3cTzvo
 jl1LhtEGJFfnQmvotfoFzIpKPIxlqhKR05fi5RZJO2AlhgohTtT4KOReE72tmRdcZr0XJ+PiDi0
 pDOKEafUVzSVkFJtmD5QqCpx/5H5wPymtEzjscfvQ/bR8vZv/yC81Xn8ZTxPD794ynW5+yYXbj6
 cgSI+mlpGlBrmLZ70UFt90t0AU6/lOQD8kbbNTfDUMD49Ndvhi/srp6sSvqZbKZHfOzdZLtQEs5
 4YIg5U28bP1D9EA38B3qrq3rtaEe+w==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68e08979 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=u19HPSzwk6W4tZ9FH_gA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

Hi Jonathan,

On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 20:17:43 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Krzysztof,
>>
>> On 9/18/2025 5:45 AM, Krzysztof Kozlowski wrote:
>>> On 18/09/2025 04:47, Jishnu Prakash wrote:  
>>>> Hi Krzysztof,
>>>>
>>>> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:  
>>>>> On 16/09/2025 16:28, Jishnu Prakash wrote:  
>>>>>>> You cannot have empty spaces in ID constants. These are abstract
>>>>>>> numbers.
>>>>>>>
>>>>>>> Otherwise please point me to driver using this constant.  
>>>>>>
>>>>>> These constants are for ADC channel numbers, which are fixed in HW.
>>>>>>
>>>>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>>>>>> which is added in patch 4 of this series.
>>>>>>
>>>>>> They can be found in the array named adc5_gen3_chans_pmic[].  
>>>>>
>>>>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
>>>>>  
>>>>
>>>> We may not be using all of these channels right now - we can add them
>>>> later based on requirements coming up. For now, I'll remove the channels
>>>> not used in adc5_gen3_chans_pmic[].  
>>>
>>> You are not implementing the feedback then. Please read it carefully.
>>>   
>>
>> Sorry, I misunderstood - so you actually meant I should remove the
>> empty spaces in the definitions, like this?
>>
>> -#define ADC5_GEN3_VREF_BAT_THERM               0x15
>> +#define ADC5_GEN3_VREF_BAT_THERM 0x15
>>
>> I thought this at first, but I somehow doubted this later, as I saw some
>> other recently added files with empty spaces in #define lines, like:
>>
>> include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
>> include/dt-bindings/regulator/st,stm32mp15-regulator.h
>>
>> I can make this change, if you prefer this. Please let me know
>> if I'm still missing something.
>>
>> Also please let me know if you want me to remove the unused
>> channels - I would prefer to keep them if there's no issue,
>> as we might need them later.
>>
> He is referring to 0x14 and below not being defined values.  So what
> do they mean if they turn up in the DT?
> 

Thanks for your clarification. To address your first point above, the macros
added here only represent the ADC channel numbers which are supported for
ADC5 Gen3 devices. If there are numbers missing in between (like 0x14),
that is because there exist no valid ADC channels in HW matching those
channel numbers.

For your question above, if any of the undefined channels are used in the DT,
they should ideally be treated as invalid when parsed in the driver probe and
lead to an error. When I checked the code again, I saw we do not have such an
explicit check right now, so I will add that in the next patch series.

And to be clear on which channel numbers are supported, I think it may be
best if, for now, we only add support for the channel numbers referenced in
the array adc5_gen3_chans_pmic[] in drivers/iio/adc/qcom-spmi-adc5-gen3.c.

There are only 18 channel numbers used in this array and I would remove
all channels except for these from the binding files. During parsing, we
would use this array to confirm if an ADC channel added in DT is supported.

In case we need to add support for any more channels later, we could add
their macros in the binding file and update the array correspondingly at
that time.

Does all this sound fine? Please let me know if you have any more concerns
or queries.

Thanks,
Jishnu

> Hence the request for context on how this define is being used so that
> you can get some feedback on how it should be done.
> 
> J
>> Thanks,
>> Jishnu
>>
>>> Best regards,
>>> Krzysztof  
>>
> 


