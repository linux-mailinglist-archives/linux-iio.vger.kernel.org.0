Return-Path: <linux-iio+bounces-24290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69FB8A118
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3941BC5BF9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0A25A353;
	Fri, 19 Sep 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TSoOv53s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8481487E9
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293278; cv=none; b=XwQunEq0OknJNuD8pFRklfljnIjkNSB1Mc0E/3hKLDK2/PTIK0ZcHdUkSCtevdSJWigyAvmUeN0fEThYOPiGLsGodkGUfKLU01rGv72o1QAxC2W/rau2O8W0992dtgj+ftcRu37kbR71akAtqXj+j8gvncyOi0fSqIRWAuSHuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293278; c=relaxed/simple;
	bh=Fl5lFtsaSa0aoM45do82bT/2mdUhsFtwUajVfM1OfJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKpZpSBoCpJRVtdExWgaJC5Nb9ZjmTIIdJYT1oNcMaFgTMvzcIuQeUU2sW1xR3secWqLQCBqMXOH7QGRNapGgsBnfaN7KprD7oEuNNWkssS0Z4tLZugq/LpZ1cDt0hALfihpDUOPWhskb64WKQDyc7+zt04d43u6fzhZCoZb0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TSoOv53s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9kCoR007297
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 14:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pK2jgFklNvRIcwSxKwSrC3IauNiUyVaZo9Kihcuf/aM=; b=TSoOv53s95HnPGUZ
	G9ZPE3fkYDb8rK+oDBaGytclIOY9/aj7djbQYx61LabICSlgXRLu5IFUqPXd1sYk
	27ZTtmYgEb2NmFDfhZYvP3VV9n72wDA9bs5pVcvxAlPi4R0vslN3/Xp7x9qJ12L0
	fUE0B/kNyhlh/QOncVdMmdYAnRaM/sLCSmcyeTWd7vCgzJ7Dsqmdi69NQsC95cHc
	4mE23Fs0bav6Rq0Lzi+167lhCMrOxWoC6x9l4s3uo9I1aPy+8OjyRHIJzVFRoltv
	Cl7NGrxSjcTSqVA8jI+ohs6hAztWrVTfVb7/8U73MvARARgiWR1Ih/j3pB2lAzZj
	sGGIJg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebew8rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 14:47:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso2396731b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 07:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293275; x=1758898075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pK2jgFklNvRIcwSxKwSrC3IauNiUyVaZo9Kihcuf/aM=;
        b=QAAx+LDJErU+WJ5hUTIyCBP6GxOoSDqROrn667tVPRI7VF14afL9qM3pLJp3gDpPi8
         tkwV/4XvpMdT/cDF8BB5MJClOHvwVVQ2SKq73Ce1ehtCqWsUInIdcVDKEIov0iAHkNF3
         h0+zQW84nbn9VsiZvplNutYD29xNqK4mqoO5zjuv4UPCs+/IG0cawou9O8yl/ss4zhWE
         DGT6bu9H3guAqWRY7/SZsZ81BKYRa4GrHAPO2ollJY0xeDICe0D7ItKBTTZnkLt8W07c
         tf7MejXpl8vUIwARnxTwcv5y/fjYOqXU5vsdhGdL2Q8UUEVAO7AzMGRkj8TiyaYGakjX
         4BCA==
X-Forwarded-Encrypted: i=1; AJvYcCXKxyqg2/M+GrNCbiVaVREjeYuDW8fgwBVB5ITuaJ2XB3prqPj6jPH2/0T8HSqOEeI/QbTmc+P2laI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlirywyGHWvl8aQZtxdEvmrsIvQTajuW+KSltJQHNLS01Jthcv
	aFxcgb2V+VJcNqXP8/1YfYdV2+D3FxJtMBPgxlruSL0S4ITR7qYbfAuBjYHpuT37eDgAVKUbQQQ
	jG3DtyVVVevT3AKhwqwShz7WhB64GXk//f/v1+D7HxXqrurpfxFNfAJJh75OnYwY=
X-Gm-Gg: ASbGncs+oV+Im7DnmZA87WBXz62+bPH/EpX+GZ2D5AYq79j3tC74k/S8Mlei2MXPRSr
	q5kUz3CKsbVPd3Te6LUigTZ6x7ZqSixoWI/64oTDLa2a+vZ/1XWvc9gpWHHtiUQjjpBbOnKOWZ9
	tBZno0kCQsOTq/j+nK728ZDlCUVv4lDieIGaj3s0AgQes1UPYIybqVPq95imSXOAnRnsyjxhjKF
	odHMi68mE0CcpsEIYjQWXWbOPYb7l0BjIEnZY1E7FwIFvJLDxNM35yY3QvQlXtDKitGvW3JDmBw
	ucKg0bJCi6u3xF5MHi29a1KuteAORKxkKRQYztnF0GDRucVPXHYGJYEVGaEHSpVC1ihG1mgG
X-Received: by 2002:a05:6a00:bd13:b0:771:e5f3:8840 with SMTP id d2e1a72fcca58-77e36935457mr4738802b3a.13.1758293275479;
        Fri, 19 Sep 2025 07:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDki/w/fEHcXQU3dq0la/SG+rDFch45lCNFYev7lQ2LKW5H7+gmQs1YUohBh/js4fBRzZI7g==
X-Received: by 2002:a05:6a00:bd13:b0:771:e5f3:8840 with SMTP id d2e1a72fcca58-77e36935457mr4738768b3a.13.1758293274969;
        Fri, 19 Sep 2025 07:47:54 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f097b60e7sm1386902b3a.1.2025.09.19.07.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:47:54 -0700 (PDT)
Message-ID: <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 20:17:43 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
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
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
 <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: D1XYXw3YccqnQRhdQHpOaod9aZ9kBjW1
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cd6d1c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=zIrsKRvHLvAX-MREBNgA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: D1XYXw3YccqnQRhdQHpOaod9aZ9kBjW1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX06gGFHgCAyNZ
 e9HpPRuCGysjVtXDRFSVtjDAoGCpS7bR/51FYFI1GGGoxZ+Mv5uxSuA/cuEKWMC09ri7q4VG/Y3
 zGTywRYReOP9IIiyUld5/IPrUZs66J0opihPcSs4XU8f8Lf5iG21ZP3UEy84vrXpT/byz7nTP51
 QcGWUYMiXw3q+cOUVHtG2WjhcitWAnywdwaVSbfm2RxC/t+Eh+ALyzBrX07ZEFCCF2aidlaB/1V
 XKyqqKF6Y9lW4NUUnSIVTcgkWs/iBjUuVsySCf0LbVmmKmByUkwdtCEoBbisrbNhV+753KF2OV4
 EP/lKHbp0UlvI2n6b99H9m6Bci92NmRUgRlcE2GnCFWtGFO1zMmFhpn8tfEDOpLBb51yV/k58rp
 GiXadsh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Hi Krzysztof,

On 9/18/2025 5:45 AM, Krzysztof Kozlowski wrote:
> On 18/09/2025 04:47, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
>>> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>>>> You cannot have empty spaces in ID constants. These are abstract
>>>>> numbers.
>>>>>
>>>>> Otherwise please point me to driver using this constant.
>>>>
>>>> These constants are for ADC channel numbers, which are fixed in HW.
>>>>
>>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>>>> which is added in patch 4 of this series.
>>>>
>>>> They can be found in the array named adc5_gen3_chans_pmic[].
>>>
>>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
>>>
>>
>> We may not be using all of these channels right now - we can add them
>> later based on requirements coming up. For now, I'll remove the channels
>> not used in adc5_gen3_chans_pmic[].
> 
> You are not implementing the feedback then. Please read it carefully.
> 

Sorry, I misunderstood - so you actually meant I should remove the
empty spaces in the definitions, like this?

-#define ADC5_GEN3_VREF_BAT_THERM               0x15
+#define ADC5_GEN3_VREF_BAT_THERM 0x15

I thought this at first, but I somehow doubted this later, as I saw some
other recently added files with empty spaces in #define lines, like:

include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
include/dt-bindings/regulator/st,stm32mp15-regulator.h

I can make this change, if you prefer this. Please let me know
if I'm still missing something.

Also please let me know if you want me to remove the unused
channels - I would prefer to keep them if there's no issue,
as we might need them later.

Thanks,
Jishnu

> Best regards,
> Krzysztof


