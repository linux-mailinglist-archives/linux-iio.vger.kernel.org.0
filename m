Return-Path: <linux-iio+bounces-24224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD8B81AC0
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 21:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C21517BACF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 19:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F251C2288D5;
	Wed, 17 Sep 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nB8MtTh8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5234BA33
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138455; cv=none; b=jC+fOohqC8i++J9ckSDITb2JYhlBJ8mxQ3IP66IbEvDXkzaVxOlM1UBeRO4wdvp76wgW0O3MxQD8aLra4vWV/SXIncTJADRmWqm6+gcXpqx6xyCkH7T04xU08NuOZMr/biTTpLE5XCDSBMphl9EH/S9GDzZzt+zuDmzbfD+3TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138455; c=relaxed/simple;
	bh=eCc3DvwwOCzNRdsPiK+c2P8cgXzJw5kUNDcvbfkn/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs0L5hbSLbn6doEEtsZ+EqIdRL0dRGfATGy3Wq+tdD1n+FvhM2HDdoo53FjRA13Ft0lreYPHmYoLh/+6ltUBP4AgT/Qm+cClMHRSkrlNd8Goau3jpeZ3Uyys7+YqDhIkbZ1sr490GdgZgkNAw8xQC34ifGfi8lqSppD6bVfJu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nB8MtTh8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGAT2K032434
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 19:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGOPpw3iuumSmHxje5vaDZCPavdx4WY1HpZ7Jmti/9A=; b=nB8MtTh8RSzbgZcm
	bqBFCcYv78eXzm9cR2KffIDxHEvRgL74+UwlbZmH1pURqJ7CJb6VT2Z+9/FM7GL+
	zAVqqY7I2Ad/xXWyoM7M61JCHyE26hHNa6ETqLWlF69pvas0bh1WAhMMJFwgaoPP
	gsUnSCzFToar+jGc7Dw3hfbHkBoxjlWQ4unbU8F2DvGnviHXLBbawDwwx9/yzB6C
	CIGHxVd9jPJCbR3gpWGhJVK/b8rf8k87/+Brx3bAyKjWVqk77mkfgWZl7GAmfpEP
	itIslCrFZ0eonyvd89OPxGsQg3/QcZr07INd+Nupj9xO3ImsEt2gH2EG8T8OkRIt
	7BZIIw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxykp80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 19:47:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77260b29516so330093b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 12:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138452; x=1758743252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGOPpw3iuumSmHxje5vaDZCPavdx4WY1HpZ7Jmti/9A=;
        b=vuzy+9dtY1IPeJDFNnwzY3iQmYOkDdyZXcDy3zjKJwEyL5RGYoj6VKyFzB+L9PDBNv
         ib7PdjCE2hTuToZqXH90kmorj7qt932MxspVt0cG/xYb8IiAlSqN+fdZ3eaAiujw+GMh
         rHRtgSfaQG+naG40wXxspbtRrfgsDGtcxUQ/BMnoB6yTxFIQbJCKhw142Sca6fyBIcdp
         HM7Djov1ZNTSrojHxnv0E7VCoaFh7ActIeYRSaJcW6TVY1SSyhTEfbr8m1VX5N2QFknq
         tLC85bpEgUr1uRSdt/vrfIACvm/8xOeZyqDbzr8lDqctQ6u7SAFVX6+9jShBtTsoAoVN
         ZtVw==
X-Forwarded-Encrypted: i=1; AJvYcCXUOxqTr3MkqKGobVjNMAhHK5yohE5hVm9JY8ekzgzG66HXCmKFvEb9tR9ktrgahXLWkANcPHOIqNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkjafW9Fab9J+9Msk7S1Lsq7/ywKxNNOc59NAbu6NK3Ee/HZw
	k8JrRmACvLXl7KBn2D5va9FPIZ6IfHzg3rILZwTbW6ZNz98upHRfrrnvHMiS3kDrsdrNo0r99KJ
	Vy4AnfyDYErmSo82olOTOgfCRFBZ4WoyHu6WOway2a0ElYDq0dLRajvwmoqOzlqg=
X-Gm-Gg: ASbGncvo28pQbrtddfaBXKG4m9aZ/0lPHIhLG63yBNf6/wOomV8vbLYd1kWWJslPU/1
	aU+WS9sKqcxrjxxRuBFSZTr3tbSD6rwQ1L9bH8AtxCy06bJ/t34v88qRgpYVqYWDIBzINBR34AC
	Wvj+WEz4SW9K5NGND07az8i1lm8jtFxLUlsJmmiPxKzqTd7Giz4cFANQcADDUYOZQgLednliG7V
	GLCtlGUtHXTU/Uo4t+SP1C/p2Ph46Dg8p6abusidqEurMmbsqiHIYwqj/2pqMv/E2/Zizz3C0Wy
	3Fm8lmbd5cCicWhsXrE+NMugoFCiHAComMhGV3iga681YzYbfdXpmgdVTZO/knQr1pAqPb8=
X-Received: by 2002:a05:6a00:2405:b0:772:934:3e75 with SMTP id d2e1a72fcca58-77bf72cb228mr4006558b3a.11.1758138452414;
        Wed, 17 Sep 2025 12:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1hWyfo8vXPdXPEvd94MNzd2+BYNOV1vlcuwDNTBjCR38g8b9XRkJWcMjCwmG6wxBK4HRxrQ==
X-Received: by 2002:a05:6a00:2405:b0:772:934:3e75 with SMTP id d2e1a72fcca58-77bf72cb228mr4006514b3a.11.1758138451980;
        Wed, 17 Sep 2025 12:47:31 -0700 (PDT)
Received: from [10.216.40.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24b4f6sm215021b3a.37.2025.09.17.12.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:47:31 -0700 (PDT)
Message-ID: <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 01:17:19 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cb1055 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=9_5l9IA32bTo_oBAx1EA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: AuioXudEBBW1uRFDaLRHBPdg5YksVYfn
X-Proofpoint-ORIG-GUID: AuioXudEBBW1uRFDaLRHBPdg5YksVYfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0OFZ9lyIq0r4
 56eGifq4BG66xkPIGf13mvduAyKyXkLtKqddvy0lJCjk2ijAAcckb7F+s4IRi/CKrKDLf/64Ghh
 PTyiapPWwSAejHEqoaXWvXjPslescmsy8HIBeG28wMwlt6Z2z9g28JV/yK0Eput1DIof3PUdhUY
 l4CWgY5h3pSgE/3slvLMF3aXhP2ymIGw/tbf4b+aixp4fSj0vCFKiOAZDfd9P9Scz/PN7qS4CQp
 DMnvCzXGQeWrt7mx3x9kFFsWZn/w+vJ2EIxTXsZ3J6jZZ+Ab5XTR3KHLR3FT6hk34AqdKTi+UpK
 6gLxaukEtQxnNSWkl9veNvAs97INKkGHC/1OB/RW/jqZeBgCLm8sNYQ72zPq/1xlv+Dpru6F5Kk
 yVEcD12G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Krzysztof,

On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>> You cannot have empty spaces in ID constants. These are abstract
>>> numbers.
>>>
>>> Otherwise please point me to driver using this constant.
>>
>> These constants are for ADC channel numbers, which are fixed in HW.
>>
>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>> which is added in patch 4 of this series.
>>
>> They can be found in the array named adc5_gen3_chans_pmic[].
> 
> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
> 

We may not be using all of these channels right now - we can add them
later based on requirements coming up. For now, I'll remove the channels
not used in adc5_gen3_chans_pmic[].

Thanks,
Jishnu

> You responded three weeks after review, this patch goes nowhere and way
> you handle upstream work makes it difficult for us and probably for you.
> 
> NAK
> 
>>
>> Thanks,
>> Jishnu
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 
> 
> Best regards,
> Krzysztof


