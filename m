Return-Path: <linux-iio+bounces-26818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2EECA9E92
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 03:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E908306434D
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B432253F13;
	Sat,  6 Dec 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGeZYZPk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ikGlajTt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAA21CC79
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987879; cv=none; b=XNqZp9s3fFGYHiYZZxJSCcvk6LporQd9T+xHprtDgvX1zxz3qjB++sxtskPMWvJxlxAt9cBlmfnLToLSP7AUXbkGarPMHfwMPJUAzgN+dze/UdZUWHx/xLqILd+uVkX0aQ/t8Zmym+g5dN4Ey/U/IvZjzPpwkZlTfePRcinemnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987879; c=relaxed/simple;
	bh=Md2wxJaE6NmpFtfqGItt8dt8vfyfqad/9YEKrIHIhOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSpRyevXZh00EGR4FxA6Ynm8nxKLdeS/njLsZEuvQVGqwQyarjkWCNP47Oyg44JAScrxKLjkZ2HtBhbLeK3u7tu1X+2ihxsL7N2rMJBQuHAVGLuPRqinECtCAHgGuCL3/r5R5LvEj4ZAKSQT+odu48TjqmrF8jVIlhVXvOIkpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hGeZYZPk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ikGlajTt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5FBKwi4177166
	for <linux-iio@vger.kernel.org>; Sat, 6 Dec 2025 02:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v/zhftcKNNcr24O58mb1mPNA
	jEcPQjCBUeSoJmSs8kg=; b=hGeZYZPk6qR9SN6B8x69MngTEcZtBzNitGvT5Myb
	jr+tCgX/2IbgkFsPXv7IIBQS+ebID772nwvtIFJj/nhvdQ7oiz3MLG/9Sdq5Crxz
	5u/li/TpNGjHdIR5EJhs263Mi8PhXhZAYnI8GQ3xG76jHq3SN92vc3b5BW9+0B1b
	0RUgJg1Q5kKtiuUPOZfX3i4NQBVODGgCMMDYAIgdP7HBVbafNAyosCp5/0EHafFh
	md+zlqO8fMxnHwBrcW2RfoTKDfSDzh4w4iMM2355Om/cuI6cqeNrXaM56fAYuGWU
	iK319VA//f3pjQIUDlMV1+6ZgjoREpJGmCeJib3p+478pw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auwm5aank-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 06 Dec 2025 02:24:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2dbd36752so549023285a.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 18:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764987875; x=1765592675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/zhftcKNNcr24O58mb1mPNAjEcPQjCBUeSoJmSs8kg=;
        b=ikGlajTtrNnKbTO2hQOeR41dy67eMTd+8B/hFRtY+avHj+RbFBrYwBnC2S2PSZcblM
         /pqbxpIsGMsekQOgupPqWl+Oq0HIsDdvmifbfZGVyOYjuuWTrBRpIzyoyTZSyO0hEhXM
         TZcYARQIoWRdVQ1+TSaX9Hhmcpz36TJ4oNbeive6gsWagaMDbB4Sp6OKsJNfWrv+Vfcu
         lzWXN3UNspZqSQhzzMMXEhhgP51HQPQRP8vWqEXeumUZLF9alZDwcNbXGXXuYvoluDKh
         lnZmAbUhYB5sHz0OLiVDjf9NVUjlNCvyzq7DRIYkWYpiheZKCXGW8aBoWNL7H/kJnA/8
         OwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764987875; x=1765592675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/zhftcKNNcr24O58mb1mPNAjEcPQjCBUeSoJmSs8kg=;
        b=OVRRtTGCKgXjPB+yCLlJavvjWsFQuMbU7HL8uEWAe4S8WRB7F+hreOd4RFsZ/zwicU
         Nm5AHRoSXRSmnTqsIWn0cNKadBypCxVn+rbL2iahtKFyxVEvr/9tGq3RNqQtHKZ6r0j9
         yTFFFE/F2hOsWUAloQDIo3rsVyEz9kegEcOlI8U3gpC8dBZoFe2gEfyFYAGjL/syM+tz
         ic+qWcAg1fr27XXWt0qNLAc1+uE8+S3KA9qILYGJlwS46eyvYkqyTu2MP4QsB/GXt5S4
         fjzPoS3/KTxjjwIKlVtJN97aoy4a/BhM8HKo37l2od08jPlxkMoxIXVi+SKGVSNCbEbE
         5GIg==
X-Forwarded-Encrypted: i=1; AJvYcCXMEmW0NGjSvfZMIVv9EPIp1vtc/BGWx9lKku7HLJADotzxrKf7kkzGSjNkVjwEhq+1dH9ak5G23qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtnKZdsPWSpi1vOcEBzOCYpbBh3xOL1r04zM/4NAIEeqL2p7P
	ofoBn8R9NXIpZC76sWxx1jWrlMnAEhciyqqiXY0s8V1Vep5mDFTY0WUuKYFQV/bVZDFDQ0mHchf
	rTTrAGHOcoQ8GMi6byWGJ2RnmNJAfYMD/TTteX7S8uIsYaduV5fCkfpVUMvxvHNU=
X-Gm-Gg: ASbGncsvoCGIbDTVbemXrFyUlwtOSRmpWm6Pw7bBXfx3N/T6gLHX/xhHljdtP0NF7UR
	fvqyrUNPZ0n+Ud09LNRp4KTl/NHonSFZARtc5NjoxMOvvSe38VraQZGUVaqThuD+n5EfWEYW/Oc
	2Q7Ef4jt1MTfYRM7Q7uhxNtz96/6CyOB9YHmtp8QleoxdhzP/wwo1RO+cgFV6vCpoLcjUH9auDh
	tOOq0PRJmkADFWyKwty1oVvu4yjSBDV1SK7/hZu36czCPHNmjSUmNF0rhqZnchffzwykQ/mjVTz
	Hk8VFui6edmi/8VoX+B4wkw1sflLMnHyM6gEZcb9sPoz8WxqXf1APojYrPqAlmwwGFgjOShnFcQ
	J6hjagL9AfHbO5Bg0zm96dwN5/PGEF4sjCf6JLUGJt1Qlv5Zk42T9cf1rXG94o6CFYvA05Nznrl
	mD8UiCoUcF75kF9Qyo/i4Tnm8=
X-Received: by 2002:a05:620a:1a06:b0:8b2:e418:81b3 with SMTP id af79cd13be357-8b6a2503ac5mr203345885a.22.1764987875448;
        Fri, 05 Dec 2025 18:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXnjiNthSZXfCmac5+5YiOfR4n/MPt+SiZjQ7HMsn736xzcLT4R/Lyha0cpV9v+6ng9mozPg==
X-Received: by 2002:a05:620a:1a06:b0:8b2:e418:81b3 with SMTP id af79cd13be357-8b6a2503ac5mr203341085a.22.1764987874944;
        Fri, 05 Dec 2025 18:24:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b1a866sm2000502e87.2.2025.12.05.18.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 18:24:34 -0800 (PST)
Date: Sat, 6 Dec 2025 04:24:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V8 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <zzhzsc25f64tx6vrexshmm5uqi7saaff5teart6vvexlj4tcpo@czyhdfsk3khx>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-5-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127134036.209905-5-jishnu.prakash@oss.qualcomm.com>
X-Proofpoint-GUID: wDntrINdOvZH5F9iGm77FkvY3iQnLYeL
X-Proofpoint-ORIG-GUID: wDntrINdOvZH5F9iGm77FkvY3iQnLYeL
X-Authority-Analysis: v=2.4 cv=XeOEDY55 c=1 sm=1 tr=0 ts=693393e4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WB5Fl5Y1WLvlCXfG3rMA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNyBTYWx0ZWRfXxEXVYeadqwNh
 D5cx1iiWgOPGyjCX22i9EsrgjK6oz9j/zGj48nTy7AElRr+wHgzjRqApv321wpUgM9Poswg6iPa
 o3kEKj3VmE1gq85aXCxd388yR9QSFfQfNvxjbtFFy9io9H4NS7I7lITjH/pnaRXKXHF4yaZyhvS
 iIqqGRwHoRv04he7EJnKsW4m2OvRRZQJpzc7sSlbMFVRJOUPflmaMy3EfWsQTfxWcP0uhruQfQx
 9JHKwvnymqg7lqnq+7NoPA9ymGuHxxibZixTvE7hCK07xrYKSLhjwW/dwddp02uWTKaxlF50JSB
 oufJDTLhbmki9vK91XubunacU8Cz/sfC7sGp0mRKV50STCeygdjhfOVro8NDKqfOD3Glp8cXobc
 ka+YFm+cagxv1gheUTCSjiTe+M7xzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_09,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512060017

On Thu, Nov 27, 2025 at 07:10:36PM +0530, Jishnu Prakash wrote:
> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v7:
> - Addressed following comments from Jonathan:
>   - Replaced {0} with { } in tm_handler_work()
>   - Simplified logic for setting upper_set and lower_set into
>     a single line each, in tm_handler_work()
>   - Cleaned up local variable declarations and high/low threshold
>     check in adc_tm5_gen3_configure()
>   - Moved cleanup action to disable all ADC_TM channels to probe
>     end and added comment to describe it.
>   - Fixed { } formatting in adctm5_auxiliary_id_table[].
> 
> Changes since v6:
> - Addressed following comments from Jonathan:
>   - Added error check for devm_thermal_add_hwmon_sysfs() call.
>   - Used local variable `dev` in multiple places in adc_tm5_probe().
>     in place of `&aux_dev->dev` and `adc_tm5->dev`.
>   - Added a comment to explain cleanup action calling adc5_gen3_clear_work()
>     near probe end.
>   - Fixed return statement at probe end to return last called API's
>     return value directly.
> 
> Changes since v5:
> - Addressed following comments from Jonathan:
>   - Corrected all files to follow kernel-doc formatting fully.
>   - Cleaned up formatting in struct definitions.
>   - Used sizeof() to specify length in register read/write calls
>     instead of using integers directly.
>   - Added comments in adc_tm5_probe() for skipping first SDAM for
>     IRQ request and for usage of auxiliary_set_drvdata().
>   - Corrected line wrap length driver file.
>   - Moved INIT_WORK() and auxiliary_set_drvdata() to earlier
>     locations to ensure they are ready when needed.
> 
> Changes since v4:
> - Fixed a compilation error and updated dependencies in config as suggested
>   by Krzysztof.
> 
>  drivers/thermal/qcom/Kconfig                  |   9 +
>  drivers/thermal/qcom/Makefile                 |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 530 ++++++++++++++++++
>  3 files changed, 540 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index a6bb01082ec6..1acb11e4ac80 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -21,6 +21,15 @@ config QCOM_SPMI_ADC_TM5
>  	  Thermal client sets threshold temperature for both warm and cool and
>  	  gets updated when a threshold is reached.
>  
> +config QCOM_SPMI_ADC_TM5_GEN3
> +	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
> +	depends on QCOM_SPMI_ADC5_GEN3

This module depends directly on the Gen3 ADC driver. I think you can
drop a separate "common" submodule.

> +	help
> +	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
> +	  monitoring device. It shows up as a thermal zone with multiple trip points.
> +	  Thermal client sets threshold temperature for both warm and cool and
> +	  gets updated when a threshold is reached.
> +
>  config QCOM_SPMI_TEMP_ALARM
>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>  	depends on OF && SPMI && IIO


> +
> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
> +	.adrv = {
> +		.id_table = adctm5_auxiliary_id_table,
> +		.probe = adc_tm5_probe,
> +	},
> +	.tm_event_notify = adctm_event_handler,
> +};
> +
> +static int __init adctm5_init_module(void)
> +{
> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +static void __exit adctm5_exit_module(void)
> +{
> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +module_init(adctm5_init_module);
> +module_exit(adctm5_exit_module);

We really need to make this work with module_auxiliary_driver-like
macro.

> +
> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

