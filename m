Return-Path: <linux-iio+bounces-12394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F5C9D213E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 09:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B3A1F21D49
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 08:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A1194C9E;
	Tue, 19 Nov 2024 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bvPBy+y7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064A7F460;
	Tue, 19 Nov 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003619; cv=none; b=C/pWvyrhdZVdf90q1p9YB20rqU4CxgxBSNHgE65LlzIWRW2JvTorxKrGTbnIM9Xj1SFWXVIeCrtNBcgGd9a8kLjoO3HEBENEK8RR/cdhXP+ZrMlVH5E5Yo+Z2FrNp1/q58tAu1f/fsqIgCMKCUeKgOXa+6cNJ4Mo9xUJ2j/frDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003619; c=relaxed/simple;
	bh=wFlxyr540sGw+qiwLK6g9rlU4lxJjv8L3+0y5sLyvXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hr/kGVU+34Xh2YpHNRh/tAmNyoKgVDd7yNHnUTAlLkNwVRaek7joPvOSM1uw0hg9KpbdNpDzjFB8WvQTACWe5GXzUHznINrbv6CykWq1et6ok1cfI6n8HsFGUgbolZ9/vfSKSM2AuhOsZCpxPdTM/hdM8PwAPp+X2pIV7Fv5NAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bvPBy+y7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7w5X2010987;
	Tue, 19 Nov 2024 08:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	flrVsdi8JSfLXAcBm5qGsvDyGvzhN1gEh+kKt4mGOMg=; b=bvPBy+y7QD6BUdYk
	dD5ClKBv3woo47o+4nhlygleIasAha5edU4SHt2+2v4BO+5TwtHf9qWm2NubzLCU
	qYfaGEXW+6oPTBh7K7QZInqkbYuGCk3wIRJE0VlbQFuGuhTNz5PVo/iMXYGXZ1vk
	CibArbNEujbZAmMnCw4HLgShbs2Q8cQodJp/FhzbcaeoaUdJdnt0QxTEZUII/9oo
	mj8SP0xtjmMpUiZau556J+I5XABjhZVTAYXU2+hEq+J/XcE+BTTNWzBWjEGXxfPZ
	+akc8dynTy8hbQYk73VzAftq92IOi7RYZcysrHiPSQOGwq7FnDdgtdsjoWIH3Y8v
	D5QZYA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43091m9utf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 08:06:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ86bvB001214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 08:06:37 GMT
Received: from [10.110.70.207] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 00:06:29 -0800
Message-ID: <54c3fdd2-f701-4a06-bb3f-41f5a431687a@quicinc.com>
Date: Tue, 19 Nov 2024 13:36:25 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for MBG Thermal monitoring device
To: <neil.armstrong@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>
CC: Kamal Wadhwa <quic_kamalw@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
 <306baccf-0106-4253-b6b1-72eaee9c5911@linaro.org>
Content-Language: en-US
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <306baccf-0106-4253-b6b1-72eaee9c5911@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oWyolHT_JibPcMiY8cJfcQPfyNeAXljK
X-Proofpoint-GUID: oWyolHT_JibPcMiY8cJfcQPfyNeAXljK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190056


On 7/12/2024 8:09 PM, neil.armstrong@linaro.org wrote:
> Hi,
>
> On 12/07/2024 14:43, Satya Priya Kakitapalli wrote:
>> Add bindings, driver and DT for the Qualcomm's MBG thermal
>> monitoring device.
>>
>> Please note that this series is dependent on [1] which adds
>> ADC5-GEN3 support.
>>
>> [1] 
>> https://lore.kernel.org/linux-iio/20231231171237.3322376-1-quic_jprakash@quicinc.com/
>
> Since this dependency was sent almost 7 months ago, and had plenty of 
> changes requests,
> this patchset should've been either delayed until a proper support of 
> ADC5-GEN3
> was accepted or marked as RFC.
>

Sure, I'll re-base my patches on the recently posted version of 
ADC5-GEN3 patches and post my V2 as RFC.


>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>> Satya Priya Kakitapalli (5):
>>        dt-bindings: iio: adc: Add ADC5 GEN3 Channel info for pm8775 PMIC
>>        dt-bindings: thermal: qcom: Add MBG thermal monitor bindings
>>        thermal: qcom: Add support for MBG Temp monitor
>>        ARM: dts: qcom: Add vadc support for pm8775 pmic on SA8775P
>>        ARM: dts: qcom: Add support for MBG TM for pm8775 on SA8775P
>
> Those should be: "arm64: dts: qcom: sa8775p-pmics: ..."
>

Okay.


>>
>>   .../bindings/thermal/qcom-spmi-mbg-tm.yaml         |  63 +++++
>>   arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi        | 210 
>> ++++++++++++++++
>>   drivers/thermal/qcom/Kconfig                       |  11 +
>>   drivers/thermal/qcom/Makefile                      |   1 +
>>   drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 269 
>> +++++++++++++++++++++
>>   .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           |  42 ++++
>>   6 files changed, 596 insertions(+)
>> ---
>> base-commit: c27723304c1f6af79f7bece5edacace6a8d46167
>> change-id: 20240627-mbg-tm-support-7bbf25c246e1
>>
>> Best regards,
>
> Neil
>

