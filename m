Return-Path: <linux-iio+bounces-12206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60B9C72D6
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59461F22B02
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC4205AB0;
	Wed, 13 Nov 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="keAlPRLI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600AE205130;
	Wed, 13 Nov 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506859; cv=none; b=eKlcAUyFrytnbptqDIlFsMoV+Tc45QLsS38/PFQfsTO0iRw3jpZB3ukhsVYYTWZkGTe4AUTZJGJcEGa2g76LfPhpzGmuZXFEnM9uqb6S2dbsVf4TK+Ewk4lzpRnsUM+w35We1wAHW9anCiraD2ACMsR1D0+c9a1p68SQUd2Z8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506859; c=relaxed/simple;
	bh=zNnPGjj8cVDATyaY+qPd4p2wYuwO7ZSvRgQMEaNOhxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ir1btqfagVt5po0NRUxdpR9OROvtKo8bKedfxxTAhgwtFz0ndk45lYyLoNcsBJxlHDdpDVcdEFBn2CcJMqg8NpRVroYeoksJQ/Z9JBVkeGkbdyU2D340ofAlzUFQ8sGMJUfo7O+bD6/Y83ref22dNjxLGfyTGZg0leKtLsGB/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=keAlPRLI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADA1sFa026688;
	Wed, 13 Nov 2024 14:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bTlZbcBXZZhV1CT3iV9mhmexOPh/n6dgXGtQsEn4Qn0=; b=keAlPRLIUkSpWSXd
	MVOkhwxLnvwP1dvX7s/3GkcTOK2sPwq8WtEq+VnsNLdpvHXr3Z33pgeXM0GrmpD0
	giOG9RTtGefAn8rS/poj7wNxRmfkjpWL7Td6sCoJ7ysYGprNqxTf5s7Qwn94/cML
	q9BazWn9j4MIi5cRaIPFseKLFoAvq4uyS+dB/2ZdgUB/Iu6IBU3rwkwGU5GhzQ4f
	T6lwRag8jAdjo+EvPXaDPSP0dU0JzlUnQUIb/PxFl4Da/VzcI9f5iLQPDHZzsZEr
	yyuqn+ixu72O26NWAl6Xj1s7wegt0cVn2jb9R2+qSsZ5Ib7ykeI63xyAnqYagwbI
	G0ANVA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vgqqt1xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:07:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADE7ECF004309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:07:14 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 06:07:06 -0800
Message-ID: <c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com>
Date: Wed, 13 Nov 2024 19:37:06 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/4] Add support for QCOM SPMI PMIC5 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <daniel.lezcano@linaro.org>, <sboyd@kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <amitk@kernel.org>, <lee@kernel.org>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <lars@metafoo.de>,
        <quic_skakitap@quicinc.com>, <neil.armstrong@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <f2c2zxxmsk74rbgbhus7nyrxppwdeq2esgifigt7c326zzlmla@6vdb2rmbjptl>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <f2c2zxxmsk74rbgbhus7nyrxppwdeq2esgifigt7c326zzlmla@6vdb2rmbjptl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: itwyVWykGu2ojvEzb8yL5r7dt_sfmDfY
X-Proofpoint-GUID: itwyVWykGu2ojvEzb8yL5r7dt_sfmDfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130120

Hi Krzysztof,

On 10/31/2024 1:06 PM, Krzysztof Kozlowski wrote:
> On Thu, Oct 31, 2024 at 12:28:50AM +0530, Jishnu Prakash wrote:
>> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS. The major difference is
>> that the register interface used here is that of an SDAM present on
>> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
>> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
>> be used for either immediate reads (same functionality as previous PMIC5 and
>> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
>> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
>> combined into the same driver.
>>
>> Patch 1 is a cleanup, to move the QCOM ADC dt-bindings files from
>> dt-bindings/iio to dt-bindings/iio/adc folder, as they are
>> specifically for ADC devices. It also fixes all compilation errors
>> with this change in driver and devicetree files and similar errors
>> in documentation for dtbinding check.
>>
>> Patch 2 adds bindings for ADC5 Gen3 peripheral.
>>
>> Patch 3 adds the main driver for ADC5 Gen3.
>>
>> Patch 4 adds the auxiliary thermal driver which supports the ADC_TM
>> functionality of ADC5 Gen3.
>>
>> Changes since v3:
>> - Updated files affected by adc file path change in /arch/arm folder,
>>   which were missed earlier.
> 
> I don't think this was tested afterwards...

If you are referring to the error found by the bot in my V4 patches 1 and 2, I think the error is invalid.
In both cases, this is the error:

    fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory

But this file is added in patch 1, through a renaming:

    rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)

I have replied to Rob on the patch 1 mail pointing this out, but I did not get any reply yet.
I have also tried updating dtschema and running 'make dt_binding_check' again myself and I did not get this error.

If this was some rare error on the bot's side, which may not always happen, I'm thinking of pushing the same patch
again in the next patch series, as I think there is nothing to fix from my side. Please let me know if you have any other suggestions.

Thanks,
Jishnu


> 
> Best regards,
> Krzysztof
> 


