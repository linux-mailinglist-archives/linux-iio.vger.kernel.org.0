Return-Path: <linux-iio+bounces-16290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8AAA4C284
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D2F3AA871
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005F21324C;
	Mon,  3 Mar 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hbrzhn49"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D3212D66
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010182; cv=none; b=dsrlIkfbklCTgkEVsE6vl7cc9tVaTasGrNauQhiD7kFDugyTKaQSUcxG6WF6Mb90C5UgvEFvG6L/qKzjuRz0jrFopR0uRuoUP3VcUk6Mq6Et2sT8K//jz8/Ilwb3ohdRDREtlqLMvT5eiDNzyXQGRjzaQEqw5DRBvKCMOSpe3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010182; c=relaxed/simple;
	bh=E1xOBAVFlgs9j5gJVrOlXBK11cCTzI/e/8Q4n9db54s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTA+V9nXOKaj4SrZM8xF+wtdLOiH8yeO25c00xxXg3HruDxaCuqIIXDCach2/gEdzCF9+i15n8e7W++GF64uG5Xm5KUULJ4LkB9nwqCkHBAmMlNGqa3ixixQnHmtNQk7yR/z47L7SArjtR+0UT8Qhz0wcZdcgf2W2wvjkwhopJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hbrzhn49; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AVmVt008787
	for <linux-iio@vger.kernel.org>; Mon, 3 Mar 2025 13:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTQYhiV7A/gSrCUW3UIc/0TICLatkTmwJ5T2ivNqO7E=; b=Hbrzhn49gVZnNPwT
	fQWdDQBOm4hpTiVLxcT4Q07A8MAc9TediHFnwwVrbxjGeeFTHzHc81PhP6hru/4I
	VX3Qiwcy6DLgY7EpRgVZjPs0mSuaFtYd/s+ZAJwuBRvwehqzn68oVfXmeJH2DLr+
	SOrUGXdV3Tii4lVd14kdQSiraPJELATCrIw52fzZ/Pv5bvTbvOLKwhxJOWvcoCgz
	SsOhD5vwGSyBi3vtcumtp9D2OU4XcV3JzbqpcWTSstuqTuk+wXtf0XPyqie8K1K3
	B1F28yh0gCGjD4/ge8aXB5vVfPUXHPaeODa3KyDoadbE9O0VGyZQz2k6kdLEbunK
	xfkR0A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0mx1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 13:56:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22367f4e9b9so56787035ad.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 05:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010177; x=1741614977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTQYhiV7A/gSrCUW3UIc/0TICLatkTmwJ5T2ivNqO7E=;
        b=IlGKdMSI6GXNS7M3jxFjccEudL8ucEGb+e9q5dU0Ll6wnddoVIYpHX73hRuOi9bHfD
         KlR2gEq3rOGOidmTu/VEe7q1RRTRuTFW1q7TZGlHLOnLTUlYEB9X5wyXywse7Mvk0Y6U
         3ZZNeOLahfcJ3MfdteVZqdVBAHGkdHR4lISQUNws6e15UQXgLVfSGb9iZoXJgm4T7iGs
         G6as6PlNPTriislEKOa3PkE25SC0ulagBEMeX8gkQ03Rz7pnIs6eWd0hpCweVDdrKKeU
         vtiA2tGx3xfMIfTuMJ+CUv4vbNNvG/pOUeHgJCcoLnj8rlrkX9MoesbgXppMS8yNUqBE
         THZg==
X-Forwarded-Encrypted: i=1; AJvYcCWKj87vliH5NPnPQxFEsNN3GNdyR9h28cjsGt5StkT6g2hkAuuMgofXCOqZ/u4hjxNohCVHHk+syRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4EWiYV0KKGRcsK9R3tIcq3Hj20dH8jlVBfQcGW1r2+VXb2D6
	p8QWPNcoMKk4AHhYBR0LiKUgY68nN0jz5u0q9XCY8DNcuFPrZr7cZ9AludGT9kpDZtOmmJo9cRx
	C9pvC9xSMFThbXAXU169miXxrBEotc8kwE3ch/Nz4m0qli/dQEQzFrUbkyDE=
X-Gm-Gg: ASbGncu5U0LInPTjj3fLIRmUAK2uUpmaeMqG0WdWkWH5EbT/eeinITFfp1xNrCnVNoy
	X5L+OXuaWl5zqNN4UYs8zt79tKesG0h5XmYZBpWErq97tJvoH41Y5qNInJB9kDqy2LbSGR8t7Fc
	wCyyNu9vQRECH40O1CqbERSPBwX+LalX/OtqCPipL8Qoi8HkoQl3/VztDl9qeJk5SX4W2Y1pNih
	EAleb+oP2uUaQEAvP4LBngt/l1AdOl+Dkyb89aeXDXMyEVPF4n4AqhkN7mHkKnKmucpZ1jQFFrY
	xVRwDG1ZAMulNBUMMOiv5qLp9DM/wWm1I1mBtwH8Nw==
X-Received: by 2002:a17:902:ef46:b0:223:66bb:8995 with SMTP id d9443c01a7336-22368fa9026mr216179465ad.20.1741010177197;
        Mon, 03 Mar 2025 05:56:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbSlgFrISgvoe5OLtQWuyCUh/aMNHtXhJk50H1lG1jgX8pVYLXg263ffFlRpYKzlf8B3uh7w==
X-Received: by 2002:a17:902:ef46:b0:223:66bb:8995 with SMTP id d9443c01a7336-22368fa9026mr216178635ad.20.1741010176426;
        Mon, 03 Mar 2025 05:56:16 -0800 (PST)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d3eaasm78068995ad.33.2025.03.03.05.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 05:56:16 -0800 (PST)
Message-ID: <08be051d-6c76-4513-84fd-3ebd0808f695@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 19:26:07 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "Rob Herring (Arm)"
 <robh@kernel.org>
Cc: jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
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
 <20250131183242.3653595-2-jishnu.prakash@oss.qualcomm.com>
 <20250202-convivial-stingray-of-promotion-1123b8@krzk-bin>
 <cc328ade-a05e-4b1d-a8f0-55b18b4a0873@oss.qualcomm.com>
 <690befae-335d-4d35-aa32-abd537dfc4ef@kernel.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <690befae-335d-4d35-aa32-abd537dfc4ef@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2S99jRUn04nzq9MWCjE06QfTPVovdwrF
X-Proofpoint-ORIG-GUID: 2S99jRUn04nzq9MWCjE06QfTPVovdwrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030106

Hi Krzysztof,

On 2/26/2025 2:41 PM, Krzysztof Kozlowski wrote:
> On 26/02/2025 09:51, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 2/2/2025 6:59 PM, Krzysztof Kozlowski wrote:
>>> On Sat, Feb 01, 2025 at 12:02:38AM +0530, Jishnu Prakash wrote:
>>>> There are several files containing QCOM ADC macros for channel names
>>>> right now in the include/dt-bindings/iio folder. Since all of these
>>>> are specifically for adc, move the files to the
>>>> include/dt-bindings/iio/adc folder.
>>>>
>>>> Also update all affected devicetree and driver files to fix compilation
>>>> errors seen with this move and update documentation files to fix
>>>> dtbinding check errors for the same.
>>>>
>>>> Acked-by: Lee Jones <lee@kernel.org>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>>> ---
>>>> Changes since v4:
>>>> - Updated some more devicetree files requiring this change.
>>>
>>> I don't get why this fails building and nothing here nor in cover letter
>>> helps me to understand that.
>>>
>>
>> I have tried checking multiple ways for anything missing in my build setup, but I'm not getting this error when building in my local workspace. But the error itself looks invalid to me.
> 
> So probably false positive / automation issue.
> 
> Maybe describe just in case in the changelog that you run full
> dt_binding_check and no errors were reported.
> 

I can do that, but do you mean I should just push this same patch again
with only that update in the changelog? 

I'm asking because I suspect this patch will get the same error again. I
remember that this patch 1 got the exact same invalid error (qcom,spmi-vadc.h missing)
in my V4 patch series. At that time, I thought this may be some rare corner
case error which might not always happen, but that seems wrong now.

Please let me know, is it better to keep this single patch for the binding file
movement and reviewers can overlook the invalid error from the bot, or should I split
this patch, like I suggested in my previous mail ?

Thanks,
Jishnu

> BTW, please wrap your emails.
> 
> Best regards,
> Krzysztof


