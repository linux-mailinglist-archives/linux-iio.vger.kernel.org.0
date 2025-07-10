Return-Path: <linux-iio+bounces-21532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1450B00263
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 14:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343A8541C17
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 12:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A125BEF2;
	Thu, 10 Jul 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLdcH+M6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C911CA0
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151775; cv=none; b=VF7HW1wXZGsATgOrxXnCFKIt5ZpuW8fQWzWq8dEJSNImd39EcgZSSJjFk5cEKmy9phNvIrPGXt/ZQRy3Z85HUSjSdUcDKP6I3vAtXywoyDScs2EXpvxHC3RW/pjX5y0ibCZ8hrVqmPL/Fh9kzKHJwepZstsMGz+U3vSKlwav2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151775; c=relaxed/simple;
	bh=93g6fWXFtPY3ctctjRZIkU5J1yopubHNG43C/SvFEKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agT3JK3kvpxBS9ki18XSNTMqrhKVGx2Ex/EVgeJyX50aKX//9ByfmT55Aev7/dRj/hguraiiBXtaOkDZr4FVl+qAYsqlwSWAxpnCdR6/gPbaVVfIuk1bGVH1sBVaozyHA2Ml0ygSP2I5P1ZGOVqIDeHe80F7fqOAMqLDgTkBLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLdcH+M6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A6GcGG022586
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 12:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LedMUwDjkPamexuNUMtdPjxDpvYa1llz9E9EWYXjJks=; b=cLdcH+M6x7n0bHVi
	cJWjwzSjprUsvw3vkcfxEBniWZVfJYWo1I9V4vyH5mx2FVYVbHh0uc2G1hT7X2AH
	Vx/EaF10mCdLRgN8Q9e4ZBRuCwwisvqrgh+z14ifqJkfsDlDzj54hsLI3eP1gJJx
	3QIAXoK76lb0acgDagJAV+3gybD/zBo55oe4YtT8q6uea/enaSqQ5rf6+k2wplVY
	AU/cdLjfhaYC3N94QkbpYLN4JlrPwSKHSnoAvY1CvSyW8mxpNyzmWPJi6kw8fJOC
	j6tS1yNfvrOJaFrpAv+fFeCyWWdfqWC0lR+47sO+yKPVhfyO3cSE3LZlygIthTAt
	BcdFww==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u17qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 12:49:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d09b74dc4bso23745185a.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 05:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151772; x=1752756572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LedMUwDjkPamexuNUMtdPjxDpvYa1llz9E9EWYXjJks=;
        b=vnKSAtV25y/1hciUMjt7ovWNZdEEcFX6arz2c4CNI9M0b7nQs07QK4xIyaWx2V6FKr
         dEiGzph6SYu8hYx/uXueC8ILr1Cgl1lmmeuNWB/jyy3kvaKVbPPP8v1zZGR6c4N2rpG8
         FRrPGMpWe7BXvswdGytHb/o4G/CimoSTHC6PUFPke6sqNJf89HTlphzytoOYXwqtlUOv
         ngaO7jxHYrximIteVKpFyutT2wg1FXLj5o5+JMaFGmX6M1qlWhV9Nu+y93cDtumrnpff
         gEBvIxa3wpy3uw4Q+v00j4iUZ7QWOiWsvnxB8zgvzzeB6l4xFIv3fnNZ/I0npnDXQpDU
         fdjw==
X-Forwarded-Encrypted: i=1; AJvYcCVuSJzZOqxRpNJ7ID1UGhUHhQ3IEj6K3uOWtxCDgzE4SYt4f6qgxIceI97Bx2f5mJaTw58LbdSSHG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOc2HXBCugIf0tWUMENowJr8MyAtsXtp3lx5kpZ3EAXPAjgKx
	xs6agdSaS1EU9iC0m+3NrUl0QAnf5D/Jy8IeIP1hdg0/Peg39Foq9Bhvr0AHnO+bxCfo4asLa2J
	iyvqhRNonhqS9vNpViAs0smnh2QN32KiLSzQGNHaJc8UVK54UZilas8fFRluFLRE=
X-Gm-Gg: ASbGncsP6qUxLbH4tudiLpHn7hYIZWQg8e3jp2VOn8EJXj5v3VinNHvmmD/i+qohheZ
	uT5dakVJ7go4VSInzIQstjsKHHPR4xkDmThbLFmosUzcHTBArXCmRuGZr+0wtnO+6Q1jhI/6anc
	Vwiy2y/TTWzIDIh6e479mKVPsY4NwYwJwGhg5sp5WPju6PzgziLa/l4Zuz6kEdvwcrDhfEoHr8D
	QhDHOotqPJm0lOsUOozyeVy4jd6CpwXQ/w68vqSrS+ryBUQ/Ssv41qFRAtmCfXUjGxpi3DxXNoa
	NX8+xFFcs3+3IzQNRnWBLnNOwmWSjnTKCAMmk/BPdKE/yLBNrhd+4xWQFZNqS6cPk1xaC18dWwY
	32e4=
X-Received: by 2002:a05:620a:2948:b0:7d4:589d:5cf1 with SMTP id af79cd13be357-7db87e0ff2bmr357279585a.2.1752151771720;
        Thu, 10 Jul 2025 05:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6MnMPHjfEvJ/d0p7Ft5taGsl78PlkmiIcddZTWSH7lx8js1TCtoXP6qMlLfgyrHVTt+MfQA==
X-Received: by 2002:a05:620a:2948:b0:7d4:589d:5cf1 with SMTP id af79cd13be357-7db87e0ff2bmr357276485a.2.1752151771216;
        Thu, 10 Jul 2025 05:49:31 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9735311sm822975a12.39.2025.07.10.05.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:49:30 -0700 (PDT)
Message-ID: <0d0d42fd-06e1-4584-b82c-965f4fb5fa74@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:49:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
 <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
 <20250511140418.33171ca3@jic23-huawei>
 <ff19780e-5bbd-4074-9db3-b4f27922a093@oss.qualcomm.com>
 <20250628173112.63d9334e@jic23-huawei>
 <5b55acbf-065d-4383-a816-82561bf91273@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5b55acbf-065d-4383-a816-82561bf91273@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: V-i_7H01B3O1hDYMv7I577tGJO0HEr2S
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=686fb6dd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KJYxXw4eQHc87HR-wQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwOSBTYWx0ZWRfX85859EeHAIks
 CTCnEiWhJQOgYg8MSs1mOvUj8cnyDsLBnDhylhv6JKpUAMYth/AwV6ONNdyOqT46ZOK2OFBG+RX
 TouhW7mHB2l1uiDD2CpIhl9WDGPCyQczXzVjTawILUhl2K9Qc0P/+GtjZP5irzs6JKZrq8rlfBF
 aGhZZBYs0d5ReSAtPJhJuYdgaZshTQ07egPYI6eTx9U3O5q7FFwsSdJ0nmjayx+oieNYyoscUJw
 D2Zir2BGkBWZygl7YK/R27J3tYVbbZcm0WhnhsvxYtDyR19kIffj6QClxcjJGJvOwOZzXfokZdl
 vr03HeGA+ZoWfKlu9ES3NT3JcqqlJjI075s4YOOJL98yBUO4iLIjddHTGvrL/O2H/7AFadysqbx
 fKGNeCGdiPQUfdLO0BWrrbNUCYtVIKcu32vxcxURkBT6R4Ddi3OEI/Fn8dc053smRf1pplz9
X-Proofpoint-GUID: V-i_7H01B3O1hDYMv7I577tGJO0HEr2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=804 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100109

On 7/10/25 8:44 AM, Jishnu Prakash wrote:
> Hi Jonathan,
> 
> On 6/28/2025 10:01 PM, Jonathan Cameron wrote:
>>
>>
>>>>> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>>>>> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
>>>>> +				  1000, 2000, 4000, 8000, 16000, 32000,
>>>>> +				  64000, 128000 },  
>>>> Andy often points this out, but I'll do it this time. Fixed numbers (typically power of 2)
>>>> elements per line make it much easier to see which element is which in these arrays.
>>>> Reduce the indent a little to allow that here.  
> 
> ...
> 
>>>>
>>>> It was never worth bothering with release until we had devm managed form but
>>>> now we do the code complexity cost is low enough to make it reasonable.
>>>>   
>>>>> +	indio_dev->name = pdev->name;  
>>>>
>>>> Just to check.  Does that end up as a part number or similar?  
>>>
>>> I printed this name and it appeared like this:
>>>
>>> indio_dev->name: c426000.spmi:pmic@0:adc@9000
>>>
>>> It only gets the DT node names, which are generic, there are 
>>> no part numbers in this name.
>> I thought it might be something along those lines.
>>
>> indio_dev->name should be the part number so hard code it rather than
>> getting it from the pdev->name
>>
> 
> Actually there would be more than one PMIC which can function as the master PMIC
> for Gen3 ADC functionality, so I don't think I can simply hard code a name here
> based on PMK8550, if we want to keep the part number correct.
> 
> Since we can't get the part number directly from the DT node names, we
> could try one of the following ways to add it:
> 
> 1. Add a devicetree property for the part number
>    This would be simple, but I'm not sure if this is the best way, 
>    if the below method looks good.
> 
> 2. Add a string in the compatible property for the part number.
>    This means updating the compatible from "qcom,spmi-adc5-gen3"
>    to something like this for PMK8550:
> 
>    compatible = "qcom,pmk8550-adc5-gen3", "qcom,spmi-adc5-gen3";
> 
>    and then extracting the part number from the first string.
> 
> Please let me know which method you would prefer.
> 
> In addition, does the below string look fine, to assign to
> indio_dev->name for PMK8550?
> 
> pmk8550_adc

I don't know if it's a good idea to intertwine the two, but we
happen to already have a mechanism to retrieve the name of the
part at runtime in drivers/soc/qcom/socinfo.c, namely
qcom_show_pmic_model()

Konrad

