Return-Path: <linux-iio+bounces-16291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0592DA4C288
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7063A9A5A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF49213221;
	Mon,  3 Mar 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQDbMs8G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C384212FB2
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010214; cv=none; b=rjUtt5D61v7K7jD5pYLLJ7yGuUSOECtbqS5G2r5c58NhjDz4Cm3lELyG2nVfzrs9+pip+J/f2ntgkVzNJ5qKhhGVcGRDSluRT+Pi3GFo+imRXWjZDny0NlwcZb27B8q7cNjq69U6qLVUZD5zQSe+l7Ah8V3CXaJCJSpgP2dcPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010214; c=relaxed/simple;
	bh=Oul6vhkXR4va+z/+WhoZ0xRll3TSdgvTz5RPoDjs9Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6UwhjttP03X/m0cbOEZB9e47i645Vf8McJxKoQPS1Alx4bU7UXefz1vwvNPJp7leip9g9LpSo/ZokNWmk0yxv9aCcX8Fbdffe0XhIbl3ZSkLqGmsqboaZTcyi3CSMvzUEfXFSWrR0Ww5bHsqUx7xh2pZIzQ6mrGjUgeblqZdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQDbMs8G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AmX7K016530
	for <linux-iio@vger.kernel.org>; Mon, 3 Mar 2025 13:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UHuL7NNx8i87z9rx+SL91u+ZQbG95A3iELLmhhDeB5A=; b=fQDbMs8Gkr0StbCH
	j1Vag3AkItreSFPe4uNsUjhVeTQNecsBYKieSpUdfKaVQd0PtZlw/1Jr4lUh5IGo
	OXNvHUGqFOHmD1xQ21JYyWhHwf3MFf0YkT7003hJp1kLqYQilF8sT+lbOQeQTVlo
	1naZwUkfKUwvySmxwzRfhQWLMF4TqfdRfpmVSaKvEtIuG1EP7EccxRmWr7FYoHDB
	KZH/PXXKzrMYykw3oFScaSuVWxjmerdjZyqArdsB1ajSpWNHp+mNJVDtLCiKOAi6
	weFw8aXgWhGh64SNsR3uq+/EUC1FbpfokcZoTWo+sSz8BjuMgZIsDmTp7k5WIQuj
	TrZadw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hw2rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 13:56:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2235667c974so115760415ad.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 05:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010210; x=1741615010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHuL7NNx8i87z9rx+SL91u+ZQbG95A3iELLmhhDeB5A=;
        b=lSVW2bWU6u7q7tNZ8OEi0VRH6+42TuKijQ24hrm5hi26VP8Ng1mQS3xZLhMz/UWcVf
         Hni9HDWL8EnYGyk90a1PFJWujuLlBzoCN3IYlvqHCK9bfIrrQng3fHZ7JuavzQS7yqnU
         Qq62W3/+MsMuw61Gorm1rUtK3F4XTy+LWNJZrH9kgxZLprRi7eiVkRyeZKBoynFeMYl+
         ddfLqJ2fO8mzcuAv9tV+xk5fZxKrT1LJ1eueRNyokoI1STWDjP4JoRQZYk1oo316rtBu
         znbCGu0XSHt3IvglVAEBtuDBxfX87SIp8kIJU4ZpM/mR5fXuEEIlKO9RK6fG48WMyR8O
         sy0g==
X-Forwarded-Encrypted: i=1; AJvYcCW46385DniarlNVdVPM0eAkvAipQM7OEiqgxeBpthmjjvmibbWRLO71xCsXGFHfJq9wYX6GE61T86g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvg6TKwKCRkEZUDLcxObtHPfKcOWbO8PHwVZ94tIZ+O5tr2vhQ
	9o6UiJL3eVswbQoTG28ohXzyPTs9887xtxSg1x6wygt3nCym1N7nm/1oGEKEMQbWw5t38EdPJHu
	Cf41ns/C44O3kB7iNzj+e4Y4GmKmLX+O2tQoqqbuly6zcH7sHodnG8OQahrA=
X-Gm-Gg: ASbGncuFMJFlBPEEZVBNvmLTMBsnOdalJi8yIbio1c1E0Pr6cKVFTubwiE+FGOB1S6h
	afyyMsLwAhVgIxBSNs5HE6/wRFqjOwXxAKqn/wQOGPJatVd0zkxn4LEW1SIiR+I0QLYueaQnAdQ
	PZ3ZdzGGPHw9/qnrS6oGqAotgkRO5H4sCksuhEJ3mZ79ndZSPgS0jGo982yYvHyXdZWBMjOyAUt
	BEH3/ZIApMEvG5vXxRGArmQYb8+Fccrc+6Teis/15zlW6yhRlhqOBpyo8HfexAToW4tjqp8TC21
	GdRckbQZJeb644pSW94eeSmiV2GxWwZe5jobbxUXlQ==
X-Received: by 2002:a05:6a00:1895:b0:736:3be3:3d76 with SMTP id d2e1a72fcca58-7363be33e3emr9864332b3a.17.1741010208496;
        Mon, 03 Mar 2025 05:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUiUadUO0TJSNEbJpg+ohvZHRFRRVAl7dtA6ZreELy4A3DZdvPJ97GRjZfVWJgUCtgDVhYkw==
X-Received: by 2002:a05:6a00:1895:b0:736:3be3:3d76 with SMTP id d2e1a72fcca58-7363be33e3emr9864180b3a.17.1741010206632;
        Mon, 03 Mar 2025 05:56:46 -0800 (PST)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363d010101sm4064636b3a.115.2025.03.03.05.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 05:56:46 -0800 (PST)
Message-ID: <449712bb-961e-4ccf-bf74-50dd55315abc@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 19:26:37 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>
 <20250201121134.53040aae@jic23-huawei>
 <9e14f58f-e345-4bae-b14e-de25fc28d9a8@oss.qualcomm.com>
 <20250301032519.16e77288@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250301032519.16e77288@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: viT_gDO8YaE6BXZkfbVp4e2Ro7kIp2t8
X-Proofpoint-ORIG-GUID: viT_gDO8YaE6BXZkfbVp4e2Ro7kIp2t8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=793 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030106

Hi Jonathan,

On 3/1/2025 8:55 AM, Jonathan Cameron wrote:
> On Wed, 26 Feb 2025 14:22:05 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
...
>>>> +void adc5_take_mutex_lock(struct device *dev, bool lock)
>>>> +{
>>>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>>>> +	struct adc5_chip *adc = iio_priv(indio_dev);
>>>> +
>>>> +	if (lock)
>>>> +		mutex_lock(&adc->lock);
>>>> +	else
>>>> +		mutex_unlock(&adc->lock);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(adc5_take_mutex_lock, "QCOM_SPMI_ADC5_GEN3");  
>>>
>>> This is potentially going to make a mess for sparse.  Might be better to split
>>> it in two so you can had __acquires and __releases markings.
>>>
>>> If you don't get any warnings with sparse then I guess we are fine.
>>>   
>>
>> I had tried building with sparse in my local workspace and I did not get any errors in this file. Do you think I can keep this unchanged?
>> Also, would any kernel bots run sparse later on this patch, if it's not already done?
> 
> Problems around this tend to turn up a bit late in build tests as requires
> particular combinations of features.  Here you may not see problems because
> sparse can't see far enough to understand the locking.
> 
> I would still split this into lock / unlock as that matches better
> with common syntax for locks.  We can then add markings
> as necessary later.
> 

OK, I can split this into separate lock and unlock functions.
And for markings, you mean I should add these:

    __acquires(&adc->lock)
    __releases(&adc->lock)

under the lock and unlock functions respectively?

Thanks,
Jishnu

>>>> +/*  
>>>
>>> Looks like valid kernel doc, so /** and check it builds fine
>>> with the kernel-doc script.
>>>   


