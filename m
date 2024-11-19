Return-Path: <linux-iio+bounces-12392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B69D210F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 08:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284F5B21325
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4615748F;
	Tue, 19 Nov 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DVKKSfVB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED06E2BE;
	Tue, 19 Nov 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003072; cv=none; b=lMda/Eebxz3FMcbRH8cQdSi+BGbMAcULrtMnt6bHCAjWXXzyUK1dsQtWiNVZfUjU8bqQwfxxPBaC2w5xf/zVhzdc1XgUnrftie7v0CNLTW1CKNnThiPl8gfgOAee6teGWUtRsDHgFA4XNV4h4Nwz6Ah+bFy5E8gC23bbGWDcXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003072; c=relaxed/simple;
	bh=gnQZhYVvdavHNLP+7fclXgbClouzlL7npTK1Sc6tpAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d9Z0T1f+dmua9Xl3lAoVty8giSWj+LBjdEx13Xjpnj84LNG1hMiqQKVSu3mXZs23cQIJ4VhseNfzVjsI807yFXzWtARMXVzAcfi7pso5cNS6F2GhdzxEZzCZHmOXZlEwj6s9bVfgAuHuJP7gGAjRHvuVWD+ygCP6FAI2JW0YR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DVKKSfVB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7kjud028423;
	Tue, 19 Nov 2024 07:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6OTmAHmFVN0NQjzADhz4W6KThxkdI5yUGKV8VNNpV5M=; b=DVKKSfVBfnrEb635
	dFpePthHC0FjkaZVdeVEoy0HtThmIFmM5wb0QxqRydqzsez8cHKneUI0UOdxdldD
	irTi53M8duujJ4plIa0u1hWl8Q+tvg+au04xLZFU9+7yTZhWBHB2G23wFzEPRxZn
	ULIxmksNFrHN6zyx2S6PEvDg4RmWh6/MVJf5vXWDyWV0ychb2lFRrmkUTUfyORBF
	IcJ+qISNRPViB9ayOEbiorFLWrFcFkwmMZg/1hTKCiK4DWzhmO1PNoc29X1EDYZ1
	18SsXeJAa1SXJPwUUMZivdcgL1gBhJ4i+fCmqO/1lWJQVmLVouLzLEkC2N+g4R5r
	zfPEHA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y5su52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 07:57:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ7vUJS022829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 07:57:30 GMT
Received: from [10.110.70.207] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 23:57:21 -0800
Message-ID: <5993cade-153e-4b91-9f30-e1690376615f@quicinc.com>
Date: Tue, 19 Nov 2024 13:27:18 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: thermal: qcom: Add MBG thermal monitor
 bindings
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Thara
 Gopinath" <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kamal Wadhwa
	<quic_kamalw@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jishnu Prakash
	<quic_jprakash@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
 <20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com>
 <haqojsbi3ain6rvht5a3ytcmjwq64tswgrpj2azqrztrvlcvag@3u476p7t57dx>
Content-Language: en-US
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <haqojsbi3ain6rvht5a3ytcmjwq64tswgrpj2azqrztrvlcvag@3u476p7t57dx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oDsTgUVo3PLgdUW6jynK1gi4Gfm1aRRF
X-Proofpoint-ORIG-GUID: oDsTgUVo3PLgdUW6jynK1gi4Gfm1aRRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190055


On 7/13/2024 9:44 PM, Dmitry Baryshkov wrote:
> On Fri, Jul 12, 2024 at 06:13:29PM GMT, Satya Priya Kakitapalli wrote:
>> Add bindings support for the MBG Temp alarm peripheral found on
>> pm8775 pmics.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 63 ++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
>> new file mode 100644
>> index 000000000000..9b6d1bc34a11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-mbg-tm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. SPMI PMIC MBG Thermal Monitoring
>> +
>> +maintainers:
>> +  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm's thermal driver for the MBG thermal monitoring device.
> I was hoping for the binding to tell me, what is MBG. But they don't.
> Could you please fix that?


Sure, I'll add the description and post v2 patches.


>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,spmi-mbg-tm

