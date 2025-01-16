Return-Path: <linux-iio+bounces-14387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39FA134A7
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 09:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E497A13D9
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0171993B9;
	Thu, 16 Jan 2025 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NT3wG8zu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7B381AA;
	Thu, 16 Jan 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014756; cv=none; b=EJ44wfY6Qg2DHExQjJCJgDSoL6G9X5uRiiu3ZmbCio8KfQWqCW6LnpBFpYooASxd2ToO8LKPLzJydQRgcSLBahVRoH/9NJZ8N9m/ePfFbWGGkuxlokS27DAxmswF/AAUFv/aYAwMW0JazezJDsB2Nd7bAX5xUAy5Gr/phSn3F/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014756; c=relaxed/simple;
	bh=5rd12jR+ruZpQr+zcf+f2VHKx265Ozuy8y6gxIm+YW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=no96MNgo1Qg6O8FmiuJNNsAoyiI5FD2x2U7h5N3mMYVACPwlISzZVvpwj8T7wl/SCFH9ASCATDgKzHgQQ7dc/4FT0RznzKeW97JYQYVKLr+aMMLJk73L7t1/JbxUCoLIqvmImaN/C3/X/ZWligyPnq4/osn4OzFk92sl4q3RGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NT3wG8zu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G4nmO1030734;
	Thu, 16 Jan 2025 08:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5rd12jR+ruZpQr+zcf+f2VHKx265Ozuy8y6gxIm+YW4=; b=NT3wG8zulBWYxQcZ
	pYTsUIpwcj2Nyb6HsToUyg555KlgNrIs72EIr+UBkmgWUVRvoThly8YU6jGMLGJi
	3Xzi37Lgr4DzE8xF4cVa81Hd+BwSOkGEE8SHsFL87F2Vb+6wyoosUTcbVW+glPTg
	9fnbxPJlLf9WXfj8ipXTWUuhtmOqZ1S0qC0+Y8J9JPQNhv/Lbr8oX6ZJQEJTWD5d
	gHqp0RyYiOuybarTuAeZNLkKN6XfuvDa7Q/l+CVb+WZBXOZhmLQyNOpmHbmf9ryl
	Z79ocHAJm3DhdCoE+akKXSrTHgYVrF/Sqv4W3tq12eqH7j4GdhVPD1c5QmzN8sEw
	ADwL+Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446ue8gdsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 08:05:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50G85Wgj004387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 08:05:32 GMT
Received: from [10.110.84.216] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 Jan
 2025 00:05:24 -0800
Message-ID: <eef55e66-629a-46c4-822b-bce41cff51a2@quicinc.com>
Date: Thu, 16 Jan 2025 13:35:20 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] thermal: qcom: Add support for MBG thermal
 monitoring
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter
 Clausen" <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Stephen Boyd
	<sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jprakash@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-3-3249a4339b6e@quicinc.com>
 <cf2f2510-9d27-4473-bf50-45b14725f4c5@oss.qualcomm.com>
 <c5079172-e127-4dfc-826a-b32489d852f8@quicinc.com>
 <ba764e00-2968-447f-99d1-5925e7782491@oss.qualcomm.com>
Content-Language: en-US
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <ba764e00-2968-447f-99d1-5925e7782491@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BbVQTR9sHQ_quzWQ50wcNfxnBKqnP-cS
X-Proofpoint-ORIG-GUID: BbVQTR9sHQ_quzWQ50wcNfxnBKqnP-cS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160058


On 12/30/2024 7:36 PM, Konrad Dybcio wrote:
> On 30.12.2024 10:45 AM, Satya Priya Kakitapalli wrote:
>> On 12/13/2024 9:18 PM, Konrad Dybcio wrote:
>>> On 12.12.2024 5:11 PM, Satya Priya Kakitapalli wrote:
>>>> Add driver for the MBG thermal monitoring device. It monitors
>>>> the die temperature, and when there is a level 1 upper threshold
>>>> violation, it receives an interrupt over spmi. The driver reads
>>>> the fault status register and notifies thermal accordingly.
>>>>
>>>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>>> ---
>>> [...]
>>>
>>>> +static const struct mbg_map_table map_table[] = {
>>> Is this peripheral/pmic-specific?
>>
>> Yes, peripheral specific.
> Okay, I asked a question that I don't recall what I meant by.
>
> To be clear, is this table specific to all instances of MBG on
> different kinds of PMIC7, or does it only apply to PM8775
> specifically?


No it is not specific to PM8775 pmic, it is specific to MBG peripheral.


>>>> +    /* minT    vtemp0    tc */
>>>> +    { -60000, 4337, 1967 },
>>>> +    { -40000, 4731, 1964 },
>>>> +    { -20000, 5124, 1957  },
>>>> +    { 0,      5515, 1949 },
>>>> +    { 20000,  5905, 1940 },
>>>> +    { 40000,  6293, 1930 },
>>>> +    { 60000,  6679, 1921 },
>>>> +    { 80000,  7064, 1910 },
>>>> +    { 100000, 7446, 1896 },
>>>> +    { 120000, 7825, 1878 },
>>>> +    { 140000, 8201, 1859 },
>>>> +};
> Konrad

