Return-Path: <linux-iio+bounces-12204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99D9C729B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 15:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3B01F221C2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0381FB8AC;
	Wed, 13 Nov 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WzBbO2VI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86331FBF63;
	Wed, 13 Nov 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506822; cv=none; b=ThcLl1G7rfexP9sbddK/O0Xkqm165kjbADk1V37viaDbBCNK9YwZCeHup6JdDmeRXMxk9fFgg8qFe8q0bTDhfnk6EKROSPCTWVi2p7hZU9lakso44vKmrN1GZLH+W9bya4gfTtzeYlkJhTAyEPtKEq69BB3TMRHaA0jtgfqBmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506822; c=relaxed/simple;
	bh=81gVhZLDeH12ryvB6MW4Q+Z4Vn7jfe/J6OxxynrZgeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DkEnE2a1RUhAM3AwPtYU+hZkf7p50mMLHXndjOggMYtMB8UVzVeJ9QlM3ctSV1VfWDLDMQIyWqVbXJWHiggstdLnXyDT5yhN7irc9r3IeH9jh3DppWqVCCVtP1Bjpu4OGvrd4++BbFO8nS96t+iRB/8NQ1uJD//PG1a6BnMEd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WzBbO2VI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD7us1G030530;
	Wed, 13 Nov 2024 14:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BnMAQG37qz6zwBUEbI4q4FGmrgT6ktJqYQFwfZwePPs=; b=WzBbO2VIHS4txfE6
	aW112Myw4ZcnBhifbFwlPLJo4PJ4U9TFktzTcw5nF58Pn9E8nzsCVy8djYvh4iwP
	+AGfuLyTRfpdhug+pqOwGdLZeDHXed7UY9fYoCHtlLltwIkpgGUnCypoibazrlvP
	EYN+BDHNSMRBjDyKv+o6p+PxESOhUsNnCv6hSJiOzNH2mqqb5Bei+Nix8PP3Kwz1
	6Dxg25IZ2XU4tEKyEZni4pi0aN/5pAtLStFLQpbedofSlKfsj/yNn9zr6YZ0rDcG
	Ncg8CcOFbyp4IgPnHa5JhiIlx5ZK7yxrTPAOkLJaj6+PAC7azt2+tHHz22Bk0zAm
	LWttbg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vr5y0wb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:06:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADE6eRi015303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:06:40 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 06:06:32 -0800
Message-ID: <aab228cf-d209-48a8-8daf-99df75f8b460@quicinc.com>
Date: Wed, 13 Nov 2024 19:36:29 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
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
 <20241030185854.4015348-4-quic_jprakash@quicinc.com>
 <d0511a78-8eca-4342-949b-9dea293e064f@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <d0511a78-8eca-4342-949b-9dea293e064f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sygkL2jZDiEXDNkAJWesywvqBVYpHxIb
X-Proofpoint-GUID: sygkL2jZDiEXDNkAJWesywvqBVYpHxIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130120

Hi Krzysztof,

On 10/31/2024 4:33 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 19:58, Jishnu Prakash wrote:
>> +
>> +static int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
>> +			  u16 offset, u8 *data, int len)
>> +{
>> +	return regmap_bulk_read(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
>> +}
>> +
>> +static int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
>> +			   u16 offset, u8 *data, int len)
>> +{
>> +	return regmap_bulk_write(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
>> +}
>> +
>> +/*
>> + * Worst case delay from PBS in readying handshake bit
>> + * can be up to 15ms, when PBS is busy running other
>> + * simultaneous transactions, while in the best case, it is
>> + * already ready at this point. Assigning polling delay and
>> + * retry count accordingly.
>> + */
>> +
>> +#define ADC5_GEN3_HS_DELAY_MIN_US		100
>> +#define ADC5_GEN3_HS_DELAY_MAX_US		110
>> +#define ADC5_GEN3_HS_RETRY_COUNT		150
>> +
>> +static int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
>> +				  unsigned int sdam_index)
>> +{
>> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
>> +	int ret, count;
>> +	u8 status = 0;
>> +
>> +	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
>> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (status == ADC5_GEN3_HS_READY) {
>> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
>> +					     &conv_req, 1);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (!conv_req)
>> +				return 0;
>> +		}
>> +
>> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US, ADC5_GEN3_HS_DELAY_MAX_US);
>> +	}
>> +
>> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n", sdam_index, status);
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
>> +{
>> +	/* Update calibration select and decimation ratio select */
>> +	*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
>> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
>> +	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
>> +}
>> +
>> +static int adc5_gen3_status_clear(struct adc5_device_data *adc,
>> +				  int sdam_index, u16 offset, u8 *val, int len)
>> +{
> 
> Wait, what? Why are you defining functions in header causing multiple
> copies of them? And even if: why this is not inline? But regardless:
> this is a strong NAK from me.

This was meant to hold macros and some helper functions used in both main and auxiliary driver files.
I see what you mean - I'll move the function definitions into a new .c file and mark them inline.

Thanks,
Jishnu



> 
> Best regards,
> Krzysztof
> 


