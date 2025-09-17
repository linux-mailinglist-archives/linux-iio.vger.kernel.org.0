Return-Path: <linux-iio+bounces-24226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7125B81AE4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 21:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3161C24921
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D84278779;
	Wed, 17 Sep 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GpD6o0Yw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0B2288D5
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138494; cv=none; b=eJZ92TRinItYRG+iReFaLbPlCj9GpGzQlcwVrkYiQ8CjOVkVjgBheTehYpmEO3um0TYDY6YsyP2K9Y0XClonfNYN+UvspJDKXT2/IlYk1GaYZVbQyOFZSdmDg28F/Q5weBWn7EgPAuIAp2bKbdjgvRqDagpIWvn6GErHf5uB+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138494; c=relaxed/simple;
	bh=gc4XDbpi/SHiw+dIuM7XRaag8prdni7GHABTYWIpL6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxN457VLRa7qM136m3PQ6bEhGIAkyUlJDQAatooEQojKC1lVM24PvBS/5RpV/RBvBJrOeKIm0O0UqGbA1PNrKZFFFQmgh7jnd0tVYtGaXSwUUtnuuFyzJBEg+6qwBqrC1RfYXIGZKBedD/voMN+q7Qz1RRFf8GWlavjpqzKBgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GpD6o0Yw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBL04W027037
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 19:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jGYCeRo2Nm2iHZbBrOloUMVIcfNZlQpAwgAkvYACT7Q=; b=GpD6o0YwTSxSy0Kp
	04CweAao7LR1ZHrx1wCp8sY5Upn/Pzu3m8eb59eHCO0wr16aN+J5Fzvw/1yJNn5z
	sttNHbvb8I39/pBW1nbVJ4ymqDFODZIhD7wL7Kq9WStjHIHYcNtU4fJRsKm+62Vs
	H9LVkhTmZc8JzRsMT5Hu1k+J/qjmQKsLfnSvKsflWug0TP7r8DFnYGKwQcK+Va8r
	TJtfNcm8wuNVEtlJuPzjj/wO+m7F2AUCaOFXHXmYogr36Mvpb7jlPMRIazSdFqM/
	jYNja76a7NWsTxxhO0cnlJ8iQMo6B65f3qFaWjQHxJZ4SrOK/Y9/5ijPTMmL39zi
	Uh/gmg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1j9j7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 19:48:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb18b5529so113273a91.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 12:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138490; x=1758743290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGYCeRo2Nm2iHZbBrOloUMVIcfNZlQpAwgAkvYACT7Q=;
        b=QSymCMuN+8MKgy+uktlC121G4E7jedDsNkFDWqReJpxq+fECQe6JYuLPrEjMk9CeAx
         IXHt3WLXra1H/NAjcXBFpyD7Q2zyrj2AGrcwqNZOY+XAndiG78+cmNTsOhlog63fd8ZZ
         pSW+207fpzBQKVIRNBNx/VXkopmikiUDGk18Outtmg5CSG3jeu78CkYJFAU2Ppopylp0
         wVgo5434RCbYMCCexhQpuDuNcI+jxDjVnv46Gkloko2CJsPy5o3XnxOyFkzMLAtzK5RM
         qZCNR+iRCvo3AGB8fHTxPr2p2jhroM8+z5Wv/6ZsvGfEsfLev15YAvDIts+3TaVt5SiT
         Np0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZgRnwI6QEJnouc4S4OSyA8kvQJyG+DfCe8CeLk6ruJG7AKKp5GAd5PK8eDWGdtH5DsjKKYE7OZJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrBLD4rr04+d1sjkCvFJLRhfiaCRHRk+wresFLQn/qpAkMRo7
	BB3s4ntPTskb+kpVIQ5TwFj/HsSDPdsdEkEfPL7y3BsWKKnaFBDMbP27FvFzWrWrETixsD3PfHl
	gLBNK4cLrEhp/9XFVhDJkaS4Ztm+9TxAHm6xZcIVH2lGnj2RkP5TqxOFRtGn3h/Y=
X-Gm-Gg: ASbGncsz8k/+AHeAjqd/321K3Ewb7V5LJBJtVmgLVO+HKUAjVedeFhEuNInSJ3XKql0
	3wgutor6Xh6UoCRuNbbRPHM9MfVZvZAg/tTrw0FhRy1pnn0SY7gsB1edIwZ7P2AV3MHCwWMJgAy
	ePgrM6BkavA/ul6KlUi9ZJMsqow7sW7G44+a/T8V1Uh9YgstSFyXwp36sJ99DD5LEkClo1FdEn6
	pYfV+pK2dHuvyT/yqkBS9JhSbhVfkMtMlzJIqqK7YjJH5NxGBEt7CmXWs4tov32I+OsfC3g+PdO
	YRWgaabapyTM/MJFeMJDnaAIGfv7eIQelpOL+KXmMiQPDF6rcXNqXNrMwx+N3pAuf1YQZJ0=
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr4546609a91.15.1758138490210;
        Wed, 17 Sep 2025 12:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUj9iiTkIiBdyuwHV1qhUP3oLhWgJBvCsq76MF3fHoniGNQ6FCUfXLye/WwI6WYVKAKakdA==
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr4546578a91.15.1758138489768;
        Wed, 17 Sep 2025 12:48:09 -0700 (PDT)
Received: from [10.216.40.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3f454sm199284b3a.75.2025.09.17.12.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:48:09 -0700 (PDT)
Message-ID: <47f7a917-3bb6-4331-8813-49f6646333e5@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 01:17:58 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
 <20250830185809.5bc010cb@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250830185809.5bc010cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XbAMyTeCUvIxc2S-8AVHpGHIz6wu8Tyj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX+BmABOXirWqu
 EUV+CsxDnKdxqHTEDPsL54IgVdkrah/KOg3Gn/qHrqggJGIrHfuBqXCrAl8YxidAomW76C2ttkX
 GJn2z6Umlt9RmLSuWBOQKkmDX3RaqiFqeNnbYIrLosrICeBKm7eXXKJR9IUFTbNeUXk2SMRyx0H
 OLBzADdHF6Fz6Zd8IaNWh4nsQUU5GhaGragiCkaHxREMC8gCjwZZZaKWOOmWIVxatDUk64R9eST
 PKb7CarT9IY4pJP2nGVQgUbVj/53y6HiuE9RCqF97vdBbkz+ckjugLShq7RmYvdZPOyViG8R0t+
 mga8TcbIg1YIVJnJhiEqhPfpz0oJFIoOvnb5HbLmBGyNA4UpV62pY8PlKwmIt/XWPptEOJafgXo
 8Dm89TVI
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cb107b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-qQjPGFekNv0xv3-IhUA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: XbAMyTeCUvIxc2S-8AVHpGHIz6wu8Tyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

Hi Jonathan,

On 8/30/2025 11:28 PM, Jonathan Cameron wrote:
> On Tue, 26 Aug 2025 14:06:57 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu,
> 
> A few comment inline from a fresh read
> 
> Jonathan
> 
> 

...

>> +
>> +	adc_tm5->dev = dev;
>> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
>> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
>> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
>> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
>> +	if (!adc_tm5->chan_props)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < adc_tm5->nchannels; i++) {
>> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
>> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
>> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
>> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
>> +		adc_tm5->chan_props[i].chip = adc_tm5;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, adc5_gen3_disable, adc_tm5);
> 
> I'd normally expect a pairing of a devm action with whatever it is undoing.
> If not add a comment for why that isn't the case here.

This is meant to disable all ADC_TM channels in case of a probe failure.

But thinking more on it, ADC_TM channels could be enabled only by the thermal
framework calling the .set_trip function and that could happen only after
this line at the end of the probe, for thermal framework registration:

        return adc_tm5_register_tzd(adc_tm5);

So I think it makes more sense to move this call to near the end of the probe
and to make it devm_add_action() instead of devm_add_action_or_reset(). I'll
also add a comment mentioning what it does.

I'll also address all your other comments in the next patch series.

Thanks,
Jishnu

> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
> 
>> +}
>> +
>> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
>> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
>> +	{}
> 
> For IIO drivers I'm trying to slowly standardize some formatting choices.
> For these I picked (for no particular reason)
> 	{ }
> 
>> +};


