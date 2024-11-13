Return-Path: <linux-iio+bounces-12203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48559C72DE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24C1B3006C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E053202652;
	Wed, 13 Nov 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="itJcF2Mj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772120262B;
	Wed, 13 Nov 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506805; cv=none; b=h2aGjJa5e0BGUfCfDfi+QjG9YqiCzpYGcc1L/GDjP25IQ7zHAkrq6TZBgGAWG2xWD09N63pqfSFoZbHmab15c0BEcXoAqN3/y33kNTMEpBtoj5WHLfETEIfkafGY1TewkxmqrH063iUcoDCe5UjLf4WlmwenA3YsvRMw9cM38Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506805; c=relaxed/simple;
	bh=Frta3fJ1ZWp+VmY7WXNQ2d8ZwuFSfiDqTLtKlhI6ens=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nTxVWj54E54c64nD2O4Kj5lte+aHBjBxcVQgENeNUxWrrQhwEoxU1oIzZyqll+Mvnt2FOkqy1D4HGaIvqJn0tkS5o3bQG2qyoVZ4rOCm6sbN6sWjLqAvyBhnIkCg+ZzdSwxO7DicerkksvvzUXpOcsWyWgJGtwiV3VDkqjByaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=itJcF2Mj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADAKSZM019315;
	Wed, 13 Nov 2024 14:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i2nRK6FOLNpo2nx26Zhc4QSZ3mfjnIgpJxv3Zq6bCA8=; b=itJcF2MjhCZ14CZ4
	vtfk/WJ/eIXBx33TlDvTHJvdKiwI2NMxMuct5mKRq4PKvovGjCRrzIlY0R1+Cs3N
	9a2FmifOCqpzXqqNjJikLawW+sBzESXXCNsGRWfcTd7kpKnotLuLDXNkfV5iYemq
	4K9VeLgz4pvDmLdprY84RHDzHlJCkERUVWrj2ff3E7zvedk0Nr27YkM/ftRZsLqy
	w3djH75/W+4rR9yPvNqJ+FmppxQ6ji0vFUdwi07+vm+CWb/3dxtI4Mxqz6tnnu4T
	fQAjfJ+mT0iN0EdfrnNiautx41WV9KAMQD0Vfne87rw0xkQHY4fBz5EQpWK2NNzB
	IhZKfA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v4kqv60q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:06:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADE6NIO013491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:06:23 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 06:06:15 -0800
Message-ID: <ee8f0b70-77a2-4a5e-85c8-715fd02d4437@quicinc.com>
Date: Wed, 13 Nov 2024 19:36:13 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
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
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <ag3wqsjdec7ujcba2jpvhzgcbbc5vnyjyes5ljyyf5b4edw7j3@rj23a25wvoyd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kJwqjNK4fjIEH6mxNxIoo6CnbDtBt678
X-Proofpoint-GUID: kJwqjNK4fjIEH6mxNxIoo6CnbDtBt678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130120

Hi Dmitry,

On 10/31/2024 11:27 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 31, 2024 at 12:28:52AM +0530, Jishnu Prakash wrote:
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
>> Changes since v3:
>> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
>>   instead of adding separate file and updated top-level constraints in documentation
>>   file based on discussion with reviewers.
> 
> I think it has been better, when it was a separate file. Krzysztof asked
> for rationale, not for merging it back. Two different things.

Actually I made that change in a separate file due to a misunderstanding at that time - 
I thought a separate file was the only way to accommodate a change in the top-level 'reg' and 'interrupts'
constraints, but I realized later that they could be updated.

From our side, we would prefer to add ADC5 Gen3 documentation in the same file, as it is
mostly the same functionality which reuses all the existing properties present in this file.

Thanks,
Jishnu

> 
>> - Dropped default SID definitions.
>> - Addressed other reviewer comments.
>>
>> Changes since v2:
>> - Moved ADC5 Gen3 documentation into a separate new file.
>>
>> Changes since v1:
>> - Updated properties separately for all compatibles to clarify usage
>>   of new properties and updates in usage of old properties for ADC5 Gen3.
>> - Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
>>   mentioning this convention.
>> - Used predefined channel IDs in individual PMIC channel definitions
>>   instead of numeric IDs.
>> - Addressed other comments from reviewers.
>>
> 


