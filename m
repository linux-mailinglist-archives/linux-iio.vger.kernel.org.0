Return-Path: <linux-iio+bounces-13301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDBD9EA87A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 07:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF6E289ACF
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 06:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC422B590;
	Tue, 10 Dec 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="auN4fxTo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB34226185;
	Tue, 10 Dec 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810717; cv=none; b=bqqkMmqoH/XERmymJry82FCTymDi53NUxM3ObUVEIcg+186hMQ5xJVvFV1q05fOwnflqTjYQjBt7VVTiskeWasnFsNr3RdGb60pEX4XGhc/eGn0CQcV71K1qXYJZ0qjIUQHOYRZP5VcDdeM5OSMNJpsMwW6BLUWaTKnU5XdXxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810717; c=relaxed/simple;
	bh=JWAv+oV4UpPbnkSoMAkg+gonAGAlJCo5/4GD46iDbkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MWDB445r3XPg2ajrha3Z8xelh11Ek7Kw9RxudsLdW5MLWYmACtXuXsy9hYbn3Sky+cDOlP3OFvIrhNdiL8dPzzuDBVW5NcHAYYriZlMbYgJsI3cX+z0v7idFyTTGOMV5ziDPVwEFki7cimaKMs1DqT7sbIOq3Iwmf2agpcHBGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=auN4fxTo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA44399019385;
	Tue, 10 Dec 2024 06:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F9I5X03zWu2wdE8Y2j/rTYjds2rycK7ouYV/Tv6i8ZY=; b=auN4fxTodfr8ykCZ
	kYVk/ucW8cW4njBNSGDC6T8DBYZOmacJNaAb6B2/L/OeURKNtZgsKyFQPnGn19Tn
	ASPKvIIxr+ZtagpFyb+TMVhF/gwvoOaH5KkT4kTcobQs187C2W86QM6wpi/p0dNf
	5XHDRcbEclp5zYvpGSHrScZihItC1zbZw9S3jfc8s1wtOAqKCrYmGH9ZvNBoVWCO
	JB65pN3HoRb7Cx8j04UeJpcRnEqsufSjOd5Ki4zMO5xR5mzAlcS3QLe5LeEMHCjV
	OmMETUPbITyC0Y2ylnHHu9CLKN/JZsAxdzSCevobPI3k1SPu74Z4EjdVUhuT0AOZ
	ggLlkQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e341a0qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 06:04:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA64pbl025876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 06:04:51 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 22:04:44 -0800
Message-ID: <a6ca16e7-d831-46ea-8aa5-5bb196bf8d18@quicinc.com>
Date: Tue, 10 Dec 2024 11:34:33 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "robh+dt@kernel.org >> Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <jic23@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <daniel.lezcano@linaro.org>,
        <sboyd@kernel.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_amelende@quicinc.com>,
        <quic_kamalw@quicinc.com>, <amitk@kernel.org>, <lee@kernel.org>,
        <rafael@kernel.org>, <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <lars@metafoo.de>, <quic_skakitap@quicinc.com>,
        <neil.armstrong@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-3-quic_jprakash@quicinc.com>
 <ag3wqsjdec7ujcba2jpvhzgcbbc5vnyjyes5ljyyf5b4edw7j3@rj23a25wvoyd>
 <ee8f0b70-77a2-4a5e-85c8-715fd02d4437@quicinc.com>
 <i7opxhkgukcshdcc7j6ai6jt62egag3jgfiqsghakjhgt2ikg6@eap7l64amcci>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <i7opxhkgukcshdcc7j6ai6jt62egag3jgfiqsghakjhgt2ikg6@eap7l64amcci>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GPeAaFMrVYs_gWsvm_HBa_0eGGCT_3tB
X-Proofpoint-ORIG-GUID: GPeAaFMrVYs_gWsvm_HBa_0eGGCT_3tB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100043

Hi Dmitry,

On 11/15/2024 10:14 PM, Dmitry Baryshkov wrote:
> On Wed, Nov 13, 2024 at 07:36:13PM +0530, Jishnu Prakash wrote:
>> Hi Dmitry,
>>
>> On 10/31/2024 11:27 PM, Dmitry Baryshkov wrote:
>>> On Thu, Oct 31, 2024 at 12:28:52AM +0530, Jishnu Prakash wrote:
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
>>>> Changes since v3:
>>>> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
>>>>   instead of adding separate file and updated top-level constraints in documentation
>>>>   file based on discussion with reviewers.
>>>
>>> I think it has been better, when it was a separate file. Krzysztof asked
>>> for rationale, not for merging it back. Two different things.
>>
>> Actually I made that change in a separate file due to a misunderstanding at that time - 
>> I thought a separate file was the only way to accommodate a change in the top-level 'reg' and 'interrupts'
>> constraints, but I realized later that they could be updated.
>>
>> From our side, we would prefer to add ADC5 Gen3 documentation in the same file, as it is
>> mostly the same functionality which reuses all the existing properties present in this file.
> 
> Export the existing properties and reuse them in the new file. Gen3 (in
> my opinion) changed the hardware too much. Having all the differences
> via conditionals bloats the schema and makes it significantly unreadable
> in my opinion.

I can do something like this - Krzysztof mentioned in my V3 documentation change that I should put duplicated properties in a common schema, so
I'm thinking of adding a new file named “qcom,spmi-vadc-common.yaml”, which would hold the common properties. This can be used as
a reference in this existing file (qcom,spmi-vadc.yaml) as well as in the new file I will add for Gen3 ADC(qcom,spmi-adc5-gen3.yaml).


> 
> But please refer to DT maintainers (Rob/Krzysztof/Conor) for the final
> opinion.
> 

Rob/Krzysztof/Conor - please let me know if you have any objections to the change mentioned above.
If there's no issue, I'll do this in the next patch series.


Thanks,
Jishnu




