Return-Path: <linux-iio+bounces-12205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F39C72B7
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 15:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B251F21BF9
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA8204001;
	Wed, 13 Nov 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XnZ3B5qJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4073200C90;
	Wed, 13 Nov 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506843; cv=none; b=abB+WeLbp24qz9PT55cEEIilY1ncuZhb3YMOTUKKVJb/14AL+QRQKan2nXkDzU+XApWJVn5oJZloeVmGWOt8vbjPg9XpERv+0RTsZMSK2Aqyk65QN9HdQdMi+1JA+UUvDlBbukbJTIpQVgL18Iuua9nKFZXNrQ2Wk3AdV6pIgiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506843; c=relaxed/simple;
	bh=NRxPzJpinH1jfuKppp2zFAYs9SUW6J+mXrU9+h6NJkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tlFYawXXVYZQu1hzZaj1FdHEDS1FvqUMsEqItiooJ+hI5h6gnCRXZ2ogkCZzOFlVVVilqSh3i08fg2Od1Ju1fpH+h67DRuVOOfKtKOKQd92sGAmP1cgrcWK4++KXD9WFaBfiiEeLRRXhv6uPco3lSBJl6zXRGAw6sFzgGdjRnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XnZ3B5qJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9kWO9005098;
	Wed, 13 Nov 2024 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ZcCROgbFmPxLB5L6+pOHim4btXMvVw5gjIYdxZxVbE=; b=XnZ3B5qJpbn5vTzX
	bT6sq513+E30GMGKkUbdhbQ8TGUJI0ylmPoT3bMqVP1eejwxzxNty6COkC1pK5CL
	6eml03CsQMmp92HJLHzG5zATcU0JWrL5IdCJyu+xgracXOI2eb92goDYGTeJg0l5
	IgHXWqAf6CH2dVNPPP/Wx6JsFF0FHj3xk1gA+UcQg424cHqDJ3cF7+qzVQszZH+a
	1CjRrvM4a+LDX8EE3FPgjzt9BiHqKiPuNh4bZFRyc0QPnAoSnkn/j8kpR0x5H0/c
	tZIp2HP07MvMTok5nFceIPYGRVd+X4sa2VFALIRMQzBIMo9nj+kpksowEaIZrND6
	2deoAA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vr5y0wca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:07:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADE72f9014244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:07:02 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 06:06:54 -0800
Message-ID: <f440adf4-e7ee-4947-87e2-3f98da195be2@quicinc.com>
Date: Wed, 13 Nov 2024 19:36:52 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
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
 <20241030185854.4015348-5-quic_jprakash@quicinc.com>
 <8556e116-a8ac-404e-b0ba-2f35dd081dfe@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <8556e116-a8ac-404e-b0ba-2f35dd081dfe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6P5rMsuJwefp72DcLO-5ieodhucews_m
X-Proofpoint-GUID: 6P5rMsuJwefp72DcLO-5ieodhucews_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130120

Hi Krzysztof,

On 10/31/2024 4:30 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 19:58, Jishnu Prakash wrote:
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which
>> implements the threshold setting and interrupt generating
>> functionalities of QCOM ADC_TM drivers, used to support thermal
>> trip points.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>>  drivers/thermal/qcom/Kconfig                  |  11 +
>>  drivers/thermal/qcom/Makefile                 |   1 +
>>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 489 ++++++++++++++++++
>>  3 files changed, 501 insertions(+)
>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index 2c7f3f9a26eb..f9876fb8606d 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
>> @@ -21,6 +21,17 @@ config QCOM_SPMI_ADC_TM5
>>  	  Thermal client sets threshold temperature for both warm and cool and
>>  	  gets updated when a threshold is reached.
>>  
>> +config QCOM_SPMI_ADC_TM5_GEN3
>> +	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
>> +	depends on OF && SPMI && IIO && QCOM_SPMI_ADC5_GEN3
> 
> || COMPILE_TEST won't work?

Checking again, it looks like most of these dependencies are not needed and making it dependent on QCOM_SPMI_ADC5_GEN3 alone should be sufficient.
Will update this in the next patch version.

> 
>> +	select REGMAP_SPMI
>> +	select QCOM_VADC_COMMON
>> +	help
>> +	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
>> +	  monitoring device. It shows up as a thermal zone with multiple trip points.
>> +	  Thermal client sets threshold temperature for both warm and cool and
>> +	  gets updated when a threshold is reached.
>> +
> 
> 
> ...
> 
>> +
>> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
>> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
>> +	{},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
>> +
>> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
>> +	.adrv = {
>> +		.id_table = adctm5_auxiliary_id_table,
>> +		.probe = adc_tm5_probe,
>> +	},
>> +	.tm_event_notify = adctm_event_handler,
>> +};
>> +
>> +static int __init adctm5_init_module(void)
>> +{
>> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
>> +}
>> +
>> +static void __exit adctm5_exit_module(void)
>> +{
>> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
>> +}
>> +
>> +module_init(adctm5_init_module);
>> +module_exit(adctm5_exit_module);
> 
> Why not module_auxiliary_driver?

module_auxiliary_driver should work, will update it in next patch version.

Thanks,
Jishnu


> 
> 
> Best regards,
> Krzysztof
> 


