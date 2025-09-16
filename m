Return-Path: <linux-iio+bounces-24166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507AB59A58
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 16:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09A1525510
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CD324B19;
	Tue, 16 Sep 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TR9rpoOw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE54321F2A
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032912; cv=none; b=W4nbJEeOie/TafhwiI/n+/V9oXdIe0vHYM9uV2ZMJy6eIn2k+QIiU1aifA93ll82ZnWgv/U/0yrn7D4qhiyFjfArF0gFGDFbDbmMOEIwVIlC3C9vRbnB8FFv+8ChlxWyCFtKiRvFcepCLYAWZvT+NkkDQLWia1ezEqP6Sd18Zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032912; c=relaxed/simple;
	bh=TGwn+qZGfOX+MW0qfzMQE+Xk3Fp2SmWLOYAprwwIKmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3pDXX5vi3ToAQC5tsG0XU4SWtAcN/C67vaXxAUakOzKlGchGU8S8jVhsG0jvjnVYuOMWEzSQVJjs4epGknJlluIOvh/DVzj0LFbCdzLfUVsVE0DBdyuv6H209wP6zPxCXL+059tXc6IWmY9rmnv55zu6pcB81EbgFGWERmYBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TR9rpoOw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDGKMC004997
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ccCP+yCNIjixDrCZqrWb8pSS4BdGxszDeBOi4Pe3O4k=; b=TR9rpoOwhJV4dkrm
	7RWVU8L5SQmMyr2iyOZXyEsR8+q5IsPuR7jzSWiUnd67vJeWIrtR3/u48Vg2nj6Q
	9V8CZ4oGxThhtvMhZOeoSBajb0aGu59/dcOEU/jZcvWrs6W9MmTHGsbWAop+utvR
	KeNUaBResHNykpXG7wSSt9coLFTNYKOJy0EzMSTGJzmsynTxFi0ZOQXxjwlF84T/
	5qxuiWFjSz0HpJWwBQ+qAH9e7E0qSl5blRnQgp8qL6cqu+l86ynwEOPvO9mKJGsd
	rlmIQyIeUfytnPrT0GMOg87tcRAIzrQa8XazEuKY8goqz0n93DIFBUoSLmA536vS
	UpIy5g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr9eu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:28:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2665e11e120so26038725ad.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 07:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032908; x=1758637708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccCP+yCNIjixDrCZqrWb8pSS4BdGxszDeBOi4Pe3O4k=;
        b=DnyEhYOqGe3E6Lt4Fq/MTVNJ2pbK8hi1RaSYyczjRHaV1RJdwWpMBx0VmYnS1CXr98
         fWykgoNFsUglNKx7c+pXCQkydMp2Rhz9rJkHyW7hNe3dnw1i/A0LUC5Ra4STvnmaliCa
         s4FFKqOx/F5nrKieitw3bOeYNYFbUwD9cDyxfn/1waLBCRoWnSeTpaQKh71nscpcEp1t
         PAXMOoga3avCQwnzTLTpWvbWZ010DN+q74cLK8gArbC14ogk60i/2wMiNp6x3ZUuQmIv
         SZ5XKaL8Owsxzlx5Dq40JCKrzxJFZo5UtO4pONuMCZKBvbHs89m+lFi1hGftP+I5WCa0
         /Meg==
X-Forwarded-Encrypted: i=1; AJvYcCXkdWqMIKfEIgVOzHUNmzXOTSwJW9vtl6mabWqdelk6EAe9yX+iaUmezqUHq5AkYDfoAgTP3U8q46g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQa903VcsX30R9rJKmqIsL9kI+gGv3QPgZgTq+qgPU7wEvG7kO
	DPFXkEGXXQPOT/vzEIGAdUZvjjR3uRVfwil3lt9btkYpF0umhD82AqWB94iVUOYoePVxDaCCvzi
	/xBilNhWxc58wWUhkNheIruV0AfiO54uMUGwunjAZrX+zsaC4LD5P1uMMoGf2KXw=
X-Gm-Gg: ASbGncvBB78g3/u7rTVYgj+DQJxqpe5EMk3Hdqo/C/GYGxmQew6MWRHjCKbi5gwGTIq
	DX8p3drCz67VnmEWXmojnHTfO5yiw+h5B+t3nm8mT8e6UPRO46Z7IjVHvn2to87W6m5cEAZImR7
	/0WauL7Qx2zEGzzgNDLcDUVrx7D64rXOYlgpn5c09ymnJnXNHtRHYkH1mi26vaDUZdAeUXEYLKQ
	loMhzKm1KVqQPwYOOo0h+Q3zloBkYIVrj4sPngKX1+axCfBgiGnf78OydHrI4BggSbTnWdqBMsf
	qqublOcKiCPsWBHC8/gG975hgxDauS9QeTiyP08eWb9Z+Xk0UVtKQE8PWwpt+1qo6/8RVSCt
X-Received: by 2002:a17:903:230a:b0:267:e8a9:7e72 with SMTP id d9443c01a7336-267e8a98193mr20322015ad.12.1758032908038;
        Tue, 16 Sep 2025 07:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXZ/OLgiEOc7ZsA33aPYfpDR5hJxcewlrm4+2ZHd+0WezSt0QCPDrGqDniIYPdLk4UlZzVgg==
X-Received: by 2002:a17:903:230a:b0:267:e8a9:7e72 with SMTP id d9443c01a7336-267e8a98193mr20321365ad.12.1758032907504;
        Tue, 16 Sep 2025 07:28:27 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm73585485ad.45.2025.09.16.07.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:28:27 -0700 (PDT)
Message-ID: <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 19:58:18 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250829-classic-dynamic-clam-addbd8@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AZl6vkb_zK8p775S-DZrJf89o7itxg9i
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c9740d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=NBYwllkvtaGzK6LsQGIA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfX4kaFfeBh8p54
 6tm1LilkZgsEFuqqSF8Yz2Ah9mnr1fcSIU5AHDCD00fIzecRAVF/HDWtYJ3KWkv1GCBdCiv5yp7
 U657bGaK/Cq61MnD0lWXtHeFC3tga5zhZ/B4V6HdHVpKSW64xjQ/CLFzzqjjVwXhRaznYXVASqB
 UnbA6yBa7vAg1ZqTr3n2E+Yv23TzyIpnmVYbaw9ctX33NwEvcCuUsnYbnB0w4aDnB9KD5e0lLk2
 SxRH8ORIDFSTJiqRBlF7IKvkr9sQAUrBRBF16w8B0OA8dZeGpurOJClaXrlfBRerDHBTqU74wbZ
 hdjVBGTM/ieOSjl5sqNe+iOQUjsh+2k3BHY7wR+Rh+zw1gwmRM5JJB1O3J/T26ZfWVdq1KUTUv/
 vpBtGGSb
X-Proofpoint-GUID: AZl6vkb_zK8p775S-DZrJf89o7itxg9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

Hi Krzysztof,

On 8/29/2025 12:49 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 26, 2025 at 02:06:55PM +0530, Jishnu Prakash wrote:
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>
>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>> going through PBS(Programmable Boot Sequence) firmware through a single
>> register interface. This interface is implemented on SDAM (Shared
>> Direct Access Memory) peripherals on the master PMIC PMK8550 rather
>> than a dedicated ADC peripheral.
>>
>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>> channels and virtual channels (combination of ADC channel number and
>> PMIC SID number) per PMIC, to be used by clients of this device. Also
>> update SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode.
>>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>> Changes since v6:
>> - Updated SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode and
>>   copyright license in newly added files.
> 
> So you did not implement my requests/comments from v5? I did not request
> above, I had many, many other comments.
> 
> 

In my v6 patch, I had implemented all the changes you requested in
my v5 patch, that is what I had meant by the last part ('addressed other reviewer comments').
I will update the below section when pushing my next patch series
to list out all the changes explicitly.

> 
>>
>> Changes since v5:
>> - Added more details in binding description explaining how number
>>   of SDAM peripherals used for ADC is allocated per SoC.
>> - Renamed per-PMIC binding files listing ADC channel macro names 
>>   and addressed other reviewer comments.
>>
>> Changes since v4:
>> - Added ADC5 Gen3 documentation in a separate new file to avoid complicating
>>   existing VADC documentation file further to accomodate this device, as
>>   suggested by reviewer.
>>
>> Changes since v3:
>> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
>>   instead of adding separate file and updated top-level constraints in documentation
>>   file based on discussion with reviewers.
>> - Dropped default SID definitions.
>> - Addressed other reviewer comments.
>>
>> Changes since v2:
>> - Moved ADC5 Gen3 documentation into a separate new file.
>>

...

>> +
>> +  The interface is implemented on SDAM (Shared Direct Access Memory) peripherals
>> +  on the master PMIC rather than a dedicated ADC peripheral. The number of PMIC
>> +  SDAM peripherals allocated for ADC is not correlated with the PMIC used, it is
>> +  programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.
>> +  All boards using a particular (SOC + master PMIC) combination will have the
>> +  same number of ADC SDAMs supported on that PMIC.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,spmi-adc5-gen3
>> +
>> +  reg:
>> +    items:
>> +      - description: SDAM0 base address in the SPMI PMIC register map
>> +      - description: SDAM1 base address
>> +    minItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +  "#thermal-sensor-cells":
> 
> Nothing improved here, still mess with quotes.

I will fix this and check for any other things to fix
before pushing the next patch.

> 
> I am not going to check the rest of comments, because:
> 1. Your changelog is vague and claims you did not implement them,
> 2. b4 diff does not work, base-commit is unknown.
> 3. Main changelog is even more vague.
> 
> You make it difficult for us to review your patches, fine. You will get:
> 
> NAK (plus one more comment below)
> 
>> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> index ef07ecd4d585..b1b89e874316 100644
>> --- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> +++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> @@ -300,4 +300,83 @@
>>  #define ADC7_SBUx				0x94
>>  #define ADC7_VBAT_2S_MID			0x96
>>  
>> +/* ADC channels for PMIC5 Gen3 */
>> +
>> +#define ADC5_GEN3_REF_GND			0x00
>> +#define ADC5_GEN3_1P25VREF			0x01
>> +#define ADC5_GEN3_VREF_VADC			0x02
>> +#define ADC5_GEN3_DIE_TEMP			0x03
>> +
>> +#define ADC5_GEN3_AMUX1_THM			0x04
>> +#define ADC5_GEN3_AMUX2_THM			0x05
>> +#define ADC5_GEN3_AMUX3_THM			0x06
>> +#define ADC5_GEN3_AMUX4_THM			0x07
>> +#define ADC5_GEN3_AMUX5_THM			0x08
>> +#define ADC5_GEN3_AMUX6_THM			0x09
>> +#define ADC5_GEN3_AMUX1_GPIO			0x0a
>> +#define ADC5_GEN3_AMUX2_GPIO			0x0b
>> +#define ADC5_GEN3_AMUX3_GPIO			0x0c
>> +#define ADC5_GEN3_AMUX4_GPIO			0x0d
>> +
>> +#define ADC5_GEN3_CHG_TEMP			0x10
>> +#define ADC5_GEN3_USB_SNS_V_16			0x11
>> +#define ADC5_GEN3_VIN_DIV16_MUX			0x12
>> +#define ADC5_GEN3_VREF_BAT_THERM		0x15
> 
> You cannot have empty spaces in ID constants. These are abstract
> numbers.
> 
> Otherwise please point me to driver using this constant.

These constants are for ADC channel numbers, which are fixed in HW.

They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
which is added in patch 4 of this series.

They can be found in the array named adc5_gen3_chans_pmic[].

Thanks,
Jishnu

> 
> Best regards,
> Krzysztof
> 


