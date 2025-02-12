Return-Path: <linux-iio+bounces-15395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2311EA31EB8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFED1166D50
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EFC1FDE22;
	Wed, 12 Feb 2025 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PalzXJ9Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B461FCD0F;
	Wed, 12 Feb 2025 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341528; cv=none; b=WcHsF/F37gn6x9iGZh6AU3/CMKK+X9WyzrKHn/L3NKTkX7jsGm5yrjLKG1xxZv+gWkwiD5Y5VIE/F7DepBkRyw+8iFelzf8/ETEujioqP/vyX9ZVE6asUFMFYpglg67nq5Pmd9344Np8ggBw00hhuThsxeotW0nDcH5LmNsKPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341528; c=relaxed/simple;
	bh=3KVKWftS4v9GkHuIDUYvEWJA8wL+ta7vL74qDteO7js=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gpfhuntcXJq3/YIxule7c0zM3BQV1t7C/EgeZwY8RWWCHRUEw2Qn5rijqWIiPUVLYSCCY5pFawH9qQoqmRtcqJb2CjRR+4rLJPdBQIXxTgJqEzpJ7T0DrvZNEY+xZmtV8MC/RMH9UU6TPwxvoMJoU3HIAlz32jYMVGygo9NecPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PalzXJ9Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BKXtGR024202;
	Wed, 12 Feb 2025 06:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	obAcn0wLmydAzYC4ajDkNvD0xynlCwHkkiRAYv1Vxec=; b=PalzXJ9Y97SyU5Yg
	0EjzK/0EqHEvCeCZ32H+vfSvUasPWifm+GF1RnuZwVFsDjd7+1IStT7NpWYHhik5
	8gQC3VR3ZHo1SyJ5rzPCoHZtS9FpbqMIPfSE+iycCTkzfjwGxmhojkqDkqic5yUc
	0U1mIPCiHG/xqHYNwsjhfTD4r7mwF/9hc8S7CpEWYeZxMstMIz01p7r7V8bbWBGc
	julwEpuESY8aKGRTPE/ZgcvpSOFKNHetgiIwiboV5VchFuUk1nIlV87Iy4viNEQM
	4mqebk4oO9D3d3us+zPSQfVJqGTMtK8sWJWe0wGQ4/zuZIXHV0lmoYsE946e4tAH
	3EtKsw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0gv24wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 06:24:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51C6Owik026154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 06:24:58 GMT
Received: from [10.110.45.95] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Feb
 2025 22:24:50 -0800
Message-ID: <aec622a8-bc3f-4ecb-a020-72f1634b7bed@quicinc.com>
Date: Wed, 12 Feb 2025 11:54:45 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones
	<lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria
	<amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jprakash@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
 <ojukpywkhu72cimujmijzidf26654g5vkjaj477imcf4suz2o6@cmow62jcqsfz>
 <7a5db383-914c-4c1e-846e-5d68cc6a7765@quicinc.com>
 <fcd718be-fe8a-466f-bd2b-7b75d5f8dd6c@kernel.org>
 <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>
Content-Language: en-US
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tLL0HZPILgFGv8Z41KvAkM3OKCPn4gyD
X-Proofpoint-GUID: tLL0HZPILgFGv8Z41KvAkM3OKCPn4gyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120048


On 2/11/2025 5:20 PM, Krzysztof Kozlowski wrote:
> On 11/02/2025 12:46, Krzysztof Kozlowski wrote:
>> On 11/02/2025 12:15, Satya Priya Kakitapalli wrote:
>>> On 12/13/2024 2:08 PM, Krzysztof Kozlowski wrote:
>>>> On Thu, Dec 12, 2024 at 09:41:20PM +0530, Satya Priya Kakitapalli wrote:
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - interrupts
>>>>> +  - io-channels
>>>>> +  - io-channel-names
>>>> Binding looks ok, but this wasn't tested due to unneeded dependency.
>>>> Please decouple from dependency, so automation can properly test it.
>>>
>>> The dependency is needed because this mbg peripheral is present on only
>>> targets which have GEN3 ADC5, for which the bindings support is added in
>>> the series [1]
>>>
>>>
>>> [1]
>>> https://lore.kernel.org/linux-arm-msm/c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com/
>> Sure. Then this cannot be merged due to resulting test failure.
>>
>> Please don't post new versions before this can be actually tested and
>> applied.
> Heh, you responded *after two months*, to an old email so even previous
> discussion is gone from my inbox.


Sorry about that, I initially misunderstood it was regarding the b4 deps 
I created. I wanted to confirm before posting new version yesterday, 
hence clarified about the dependency.


> Best regards,
> Krzysztof

