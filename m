Return-Path: <linux-iio+bounces-16374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E0A4E8B1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF219C0F3D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96F2853F3;
	Tue,  4 Mar 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQDbMs8G"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F0254B14
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107595; cv=pass; b=mWBxWIJkww4ILJVYNBXb86wy4cvoroHdoQzr53InWHreZK2vYKgIApHW61A3PVob2X2jueV0GCyzVEXZtrjINeKIkmLxvak7Yr3GV/Wv0vuOq16BNFy1Rg1K/G9sUCYNmIutX2C2/bgPydUlNkbqQUHwz8QCTrcI2z8fNqnBEJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107595; c=relaxed/simple;
	bh=Oul6vhkXR4va+z/+WhoZ0xRll3TSdgvTz5RPoDjs9Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD5N1nTxIvOarqfhc6lFsfGMN+L0TPiX0+4h6sSANYi+Y1fQE0KixIYUBDOAbyIHV6NF7mxDKA16LibxFyPz5JZTEdBPcttaTPnXkCkL6NW8ourrlE0FdiG9SLabZ4NcwZmIddzWjaJxFC8Ed7wRc6yI2Yh0czYsbsoFEa8SAHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQDbMs8G; arc=none smtp.client-ip=205.220.180.131; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id D09E740CFB88
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 19:59:51 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fzR740TzG0nw
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 18:41:07 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 36C2142746; Tue,  4 Mar 2025 18:40:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQDbMs8G
X-Envelope-From: <linux-kernel+bounces-541861-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQDbMs8G
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 88B3C41CB7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:57:10 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 3C3C02DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:57:10 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8661689E7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17C2135A5;
	Mon,  3 Mar 2025 13:56:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55A212FB3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:56:52 +0000 (UTC)
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
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523B6x9K030846
	for <linux-kernel@vger.kernel.org>; Mon, 3 Mar 2025 13:56:51 GMT
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
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88w4df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 13:56:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22331df540aso135183825ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010210; x=1741615010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHuL7NNx8i87z9rx+SL91u+ZQbG95A3iELLmhhDeB5A=;
        b=hFsjZHfPL9X440nsUqTSVXoiz5p2MzlCPlaCgGLqAugh40MJ7DAzXU63Hno0CUEo+s
         bJpasj4KvHvFcEFYWHU4iZYEhpM1oPSjvYqwuXgpSK48pvSc7uSBhlA36zbWKrCaUw75
         FiywaXwMVDF1s7+AyVxAy77c5thv0VYjQJJ7HaHfASzHd5QolrOzKoJD865ENcool3DO
         lzGGoJGAd8SBZJDcr4QoqcI0PUXmhOMmfKADq6EBF1yxQbAafBRxcIIQU8M166AHD9mE
         Joeg+m3eypqdIoFxIRtJquQGU8KPklalG+QuGUJ1yz/oDipDKw6Gs8S/QowC+tcDyWtz
         qtAg==
X-Forwarded-Encrypted: i=1; AJvYcCXtN+qgcmVGfwFb0lIr9uLD1Ad23XRGDUnoCZBVreWzIgOw0ZBiStl71HegG2H7KqQHxOp4keNSFHF2BXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWszmVgKE+VhARvVAmcR25upto0k4CWJxoVZhJsDAPUj/4ilDg
	MTH9KZzokShlXjeGnGVLI3Crd6ipjKW8fqwcY4T6Jv2Q6AP2FmP8q4uimrQrY9dZQOHxJ8BIlt8
	iubHco72r8ad/cjdJcQo06RLAQIBxP0W4gljxfCyCucF3j7Mej+FhPJgZqbGXFF4=
X-Gm-Gg: ASbGncsXsGUNcSVF+6DFKJ147+OZXzv0HDJnxme92avRGw89TblxxrmirfpHsyCo7ZI
	ATIiJM0FJQ74mlD9nD6/BVHdem0e2GfXHcKBY1N8IkU9FrP2QABnEsXzeTJQazW+sjH/23yP5E+
	yRHQrA6IkqHcD+ZE/+A8whHVYlPG+95vcet2HSebj7NUbbICAUX08XtCa7zaAGBlBYL5lu5foOJ
	53oRdxdqS5/miE99Xj2wXqFeNZdIMv02GbybljESaMZH/I8whop/BVdlmwnNZgsNwkhl9gHEWyB
	BDqVbl0xMrJ8xlB2craxhIxL2D08GJOgHoKxhNKWAw==
X-Received: by 2002:a05:6a00:1895:b0:736:3be3:3d76 with SMTP id d2e1a72fcca58-7363be33e3emr9864320b3a.17.1741010208484;
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
X-Proofpoint-ORIG-GUID: NX1dR6-oc6tpjPo9egELKQAiOGfJge2p
X-Proofpoint-GUID: NX1dR6-oc6tpjPo9egELKQAiOGfJge2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=793 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030106
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fzR740TzG0nw
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712276.45651@XqUeVBb5UqdlbgXPQjFYcA
X-ITU-MailScanner-SpamCheck: not spam

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



