Return-Path: <linux-iio+bounces-11889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57699BB0E5
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 11:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93AE1C21508
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E11B0F1C;
	Mon,  4 Nov 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RDWvKhHz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C018C020;
	Mon,  4 Nov 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715739; cv=none; b=LliKT2JKw6mPNsmvVVMQubj460c2SXC5/iKCYzdSLVP3uIDnD20r+h3P7msaL+OmB/UcWbVWkSNoULMTpAtcrsWcha+wWRhpf62XyB3kJ9OoY14W0izLrXWyJeBrPShDDumlSmAUXqQz6T0dK/HYBdYcnZhy0AxpZtd8au95S+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715739; c=relaxed/simple;
	bh=kh5QtwjbRWBwwF0Hou4I7K9sJhsih+FO7clvh+maj8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ab2uNGEJIe88DXklutj2zD7bKwhj9+q51Tm+FfagAMjGlw7K0zWktcX7LA02iJWFoHmQVecLOTOSHHZPjyXJJG/8dRhUQ6yT9ddwt013Z4ofgLLtqPVP/U+1Yi5MffLQmbqGI4rHBsEMRn1fGOu5jy3MSXrT9wHqMixTod9Obqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RDWvKhHz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Mo2Uu031707;
	Mon, 4 Nov 2024 10:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Nn0WorU6l2jJYLx45HO5FWgM6QDg3c9c5+U561I2mE=; b=RDWvKhHzcdxfC29i
	u7+n1kB9lTQb9a3ubtALdFWRuNooLB6iEUyG+/ypJTobXgxaZ0Ix4bF6ZdFKByg8
	0JrgxdWg8MJ7vePfg4XCYeDT6eKWURruL86VUA4mCklIikZGXldvbx6ZN/C9pj5o
	6Sg1eqzTalNGfikgXXRKlbmYUAQQEHzK5Sls9TwpWlNba4HRN3kl/5dsZ80ur1Na
	6D+38TPhKCu7NDv3ogFUu/WJ9MkKAVzQwdMn779iWcL7MwXf7M6+F7bOdh9FdKB8
	Fu3WZjEG+Xh1iumKW3Ldfs6xVg222LKzHH75BbaxPKBthKKkOmAxFTxydRL4lrci
	9B3v+g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd1fkudw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 10:21:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4ALro9001503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 10:21:53 GMT
Received: from [10.217.217.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 02:21:45 -0800
Message-ID: <16aaae04-4fe8-4227-9374-0919960a4ca2@quicinc.com>
Date: Mon, 4 Nov 2024 15:51:36 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/4] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <quic_skakitap@quicinc.com>, <daniel.lezcano@linaro.org>,
        <andersson@kernel.org>, <lee@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <robh+dt@kernel.org>, <quic_subbaram@quicinc.com>,
        <rafael@kernel.org>, <quic_kamalw@quicinc.com>, <agross@kernel.org>,
        <amitk@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_amelende@quicinc.com>, <neil.armstrong@linaro.org>,
        <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <quic_collinsd@quicinc.com>,
        <konrad.dybcio@linaro.org>, <jic23@kernel.org>,
        <devicetree@vger.kernel.org>, <lukasz.luba@arm.com>,
        <rui.zhang@intel.com>, <sboyd@kernel.org>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-2-quic_jprakash@quicinc.com>
 <173031962644.1844672.11198879616520852521.robh@kernel.org>
Content-Language: en-US
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <173031962644.1844672.11198879616520852521.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nwFSCJpt7OlT4ZFwLopJb1OaMawAdfgn
X-Proofpoint-ORIG-GUID: nwFSCJpt7OlT4ZFwLopJb1OaMawAdfgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040092

Hi Rob,

On 10/31/2024 1:50 AM, Rob Herring (Arm) wrote:
> 
> On Thu, 31 Oct 2024 00:28:51 +0530, Jishnu Prakash wrote:
>> There are several files containing QCOM ADC macros for channel names
>> right now in the include/dt-bindings/iio folder. Since all of these
>> are specifically for adc, move the files to the
>> include/dt-bindings/iio/adc folder.
>>
>> Also update all affected devicetree and driver files to fix compilation
>> errors seen with this move and update documentation files to fix
>> dtbinding check errors for the same.
>>
>> Acked-by: Lee Jones <lee@kernel.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>> Changes since v3:
>> - Updated files affected by adc file path change in /arch/arm, which
>>   were missed earlier. Updated some more new devicetree files requiring
>>   this change in /arch/arm64.
>>


>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> In file included from Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:80:
> ./scripts/dtc/include-prefixes/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h:13:10: fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
>    13 | #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I think there must be some mistake here because my patch does add the file include/dt-bindings/iio/adc/qcom,spmi-vadc.h, through a rename. This is seen at the very end of my patch:

> diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> similarity index 100%
> rename from include/dt-bindings/iio/qcom,spmi-vadc.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-vadc.h

This patch moves our ADC-related header files from 'include/dt-bindings/iio/' folder to 'include/dt-bindings/iio/adc' folder
and fixes this path change in all affected files in the same patch....I think this should be expected to pass compilation.

Is it possible something went wrong from your end in this case? I see that both the files mentioned in the above error, qcom,spmi-adc7-pmk8350.h and qcom,spmi-vadc.h
are moved from 'include/dt-bindings/iio/' folder to 'include/dt-bindings/iio/adc' folder in my patch, could the tool be confused due to qcom,spmi-adc7-pmk8350.h
containing the updated path of qcom,spmi-vadc.h?


> compilation terminated.
> make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241030185854.4015348-2-quic_jprakash@quicinc.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 

I have also followed the above instructions to update dt-schema and run 'make dt_binding_check' again and I did not see the above error.
I'm also not getting any errors when building with this patch applied.

Thanks,
Jishnu

> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


