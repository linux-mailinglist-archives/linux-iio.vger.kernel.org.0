Return-Path: <linux-iio+bounces-26524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFAFC8FEDA
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 19:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEDCE4E1E9E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6F2FF14F;
	Thu, 27 Nov 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rk3/1W3o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VDi5BGuX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556492D0625
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268732; cv=none; b=gn3ldUXW8at3JNvOeIdaONJ90oKp1ki7aSkUQDRnfF17v7cN9AihK0USrsdUDuQuaMSwphmoo7RJcaaZwPedZTD+ru2QGSDWwVIpDjKhj3qQOa7zl2CuU+f8o1aWz62RnkL3RozZikacCBOZpBV2zgCREA2F6rY/qzvmMOFR1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268732; c=relaxed/simple;
	bh=7EmGp5xuFOxZmnuoVrPri/jYzf6wmTAyHqk2MoUkLX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/sDV51NEaGLZ0hnJuPAnpxK6wQL9se2ZEAbGC3+F8Hn4J058zRzaFnjIXkIWG3IXRyxbuQOqB1TXiz4F6cBuhnUIdEMlJoYMSS7xE2uH3CN5S+ZIdKWOFbb603j/1jVq0xyfHVncqzox/Zt56PKKPa0qBcoosFC3vqY6kvoMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rk3/1W3o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VDi5BGuX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR9UWKP687855
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 18:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	POsVzQb4aG2qHpC/XN/o/lHwVRg8HSmGyoofXeaIgoE=; b=Rk3/1W3oFZheUG9S
	WjfTLI9vjFils251eCJlJhlpdUx/NNNNyg05C2sYmKvp2RjwrtFSTlhodelaWQu9
	JAN5DFvuALGPyooApESGLaJvyovMUcojBxIhETjmFJqjnopNUsI5lbFlfotIdHcU
	iWB3/LTsyWtxnZi4dKKTIcz4tgzopDowcQ8qcEcvDREvVqUy51um/Qen1UCzD+x2
	tDG+jWFgbz/4KsrKKQDIfop5zOn10x+ALMr0nXJjyqltWgLzU5FEkN0WvQEXKuKZ
	3DcqOQp74EHGsBplrmQnF1iY7VSmvl1rLufugPEeMrpdA8o5+9War9UoKWIoW7QQ
	RKBJUQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apm2rsaa0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 18:38:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed5ff5e770so1717701cf.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764268729; x=1764873529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POsVzQb4aG2qHpC/XN/o/lHwVRg8HSmGyoofXeaIgoE=;
        b=VDi5BGuXLGiYytERhH0Q9Lxsc6csf6Fsw8XtOGHb66aUq8iAym2pXTG0CXbDWzOJJl
         JyguW8kvcicBEWuRYuwZJrJqNX/aZSGf1VAPhlMYvlwdSf1O5rrN3nCpVgo0jiBZ35I8
         DMeLCfAEOgMpXA8T89yJ8aPo9Et8YLzJoYuv53aGkvv17JdP0egzv8kOZgFYT8evGQFb
         OBG5pQr0MNf6o6/pDOSwnVDTA41j6YUdN0RjcB12kYM/wY09mDSMlSS6alJbpISc/8eg
         MF3RBXjF+MWEtQLmy8ZNEKBLynz6u+Twb7YChImmBGiC0Kv9Hze5RXKDgv2ttSRfhzSd
         3B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764268729; x=1764873529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POsVzQb4aG2qHpC/XN/o/lHwVRg8HSmGyoofXeaIgoE=;
        b=PPxma5br/RYorQ1pJReIkhI7TAASVGnvhI/TcRsRemXv50YrF4YT2fy3lAqGP0Jrp4
         KLq8ZNKDAARlGoIxAsFsjQjRZGCZSxe1bb3W3K5IE+TS/4g2bncS8kF39dMrS2OVmvfB
         HiVq4betj/e9YbJ9DcxXrOqNH3mipST+iogrZe7G6RG5SroMoiRhQGIkA38afvJYvNJr
         DLoFyyOAAGWPjY/IRMEkAuuGj+IluLLt4eiiS5RVMNUlBcv6GHwdU3auiE1aNPuj+U55
         GL1KSRppmZVrXHJs/AIHJWBSYnGae1yZiIsxKV1SLL9sOoMuvROZ8YL+8H5FdryfN1Xm
         lurQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdpt5g1B8ZVpNdiHQCi8XPD2Mnn1s1QpmlFALtXksDhm7sw0rQN9l9RF41wrqRYlF1vGTbV7BdtL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2iZJHLg4RInMVm5yo9HM2LHUEpKFclephu45+gfn4rM9Yf1L
	caskgTyaptTRFpYigPavN3uB+N6P6WAjLx8eHG+JbUV9CKa7lJTaHhnzO65gJKLiIVChrY2THqk
	z78Xnktehf3YaCG3FGL+rW8e0BUHsHRPfozDMHpaookWJMoHYG1mf+wKQ1NZOdXA=
X-Gm-Gg: ASbGncut8KsLNneGcHzXXIvXE9I7lG1IoZLQxh8/QQ+4tacvm7J7gXa5fWYgtsWGcWU
	yL0ETUrZT7hndFM0iaFEak2jILPPmJYMI9rt7/6E8A6MHtVC4aeYW5Pkw8DUw0FYi33Z5l7ML3T
	gPLzhrnXNlImKgTC7QtofxNs9Lv5b29FwsMrsRundDwJ+9AiPTQ+hu7TeQH402YYSkuk8vLOkVV
	4YMYB5aqyZ2IT5WW6FoMIXa+hWuKuJNvUB3i/0TNfznY/YSngGTlxAGxrXJctESXjsIkLRQnVvR
	4R2ob6TVExaqVuwlvWV5jZIaL2wtZdk4AZ1c9u2D/GkiUTx5AhpmbfROZnZzQKhI5V/DLG0Dn4A
	cCAI9GZycxuBTaEYju3q3nn4dnWrHViwAF/LJiNgw0i8ftuoMNl0VKTXJBjnDNIKad0Q=
X-Received: by 2002:a05:622a:511:b0:4ee:2bff:2d5b with SMTP id d75a77b69052e-4ee5886636dmr251071621cf.5.1764268729466;
        Thu, 27 Nov 2025 10:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGvBBMNvoaJ0BxGYH3uHB+fqa5EASbvxtHrZuKupeWiooJoc8dPm+7pNnJzajl26gn0WLkiQ==
X-Received: by 2002:a05:622a:511:b0:4ee:2bff:2d5b with SMTP id d75a77b69052e-4ee5886636dmr251071261cf.5.1764268728981;
        Thu, 27 Nov 2025 10:38:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d31sm235196766b.9.2025.11.27.10.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 10:38:48 -0800 (PST)
Message-ID: <c627fc05-6980-44bd-bdde-4750b3bafe2d@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 19:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] iio: accel: Prevent NULL pointer dereference in
 interrupt setup
To: Rudraksha Gupta <guptarud@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
 <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
 <d3318386-2646-4f1c-ab4b-6ae3bc71e9bb@oss.qualcomm.com>
 <aSWPnRBRdPS8vnir@smile.fi.intel.com>
 <61e860e7-fc3b-49ad-bf6a-9745f205d52b@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <61e860e7-fc3b-49ad-bf6a-9745f205d52b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDE0MCBTYWx0ZWRfX/6MgBqOHGiQe
 YMG58hQmrFDdDVx69HYDsrGlV6w9u3iVB0yJQzx8Ri7tB1aDJxEIhv5kdW49Zcb8LIVIAnse8nB
 DKboGLM3WvC++XpgfXKk54aTRGEHeH37XMgA/fp3BuSk5DoieF7/HMef6kJj/trZShRXlOxgp8c
 L+AimRNBiAgrMXS2LTb8PAZ07Q0DBQ1R7yBeaMgPHCVGFHKcVIJ2tC7f1GY9DzJQ07j9/wuAF6W
 ub0ECnAP8jy7Bkv22BYvThedPOfO53aKVh8uoYh3I2iWiyAAphBIW5+qVUP7t/dMjJXD4LvXCN9
 3k4ou6oM70NNUGskROK1kuSDQdre2gY4HddSg2KZOPklwfFhifmJZNTGvkmCHSvR6NIRg6JV17R
 dTsRIgOdsiydMB3jVL4dL2cAMezITA==
X-Proofpoint-ORIG-GUID: l7ikrqiEQBHIPkZCNIidIuNoAsqmQVH3
X-Authority-Analysis: v=2.4 cv=W941lBWk c=1 sm=1 tr=0 ts=69289aba cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9AdMxfjQAAAA:20 a=P8M0t_FSf_X-oylKYQYA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: l7ikrqiEQBHIPkZCNIidIuNoAsqmQVH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511270140

On 11/25/25 10:23 PM, Rudraksha Gupta wrote:
> 
> On 11/25/25 03:14, Andy Shevchenko wrote:
>> On Tue, Nov 25, 2025 at 11:45:22AM +0100, Konrad Dybcio wrote:
>>> On 11/25/25 12:35 AM, Rudraksha Gupta via B4 Relay wrote:
>>>> The bmc150_accel_set_interrupt() function assumes that the interrupt
>>>> info is provided. However, when no IRQ is provided, the info pointer
>>>> remains NULL, leading to a kernel oops:
>>> Hm, are you sure your device really doesn't have a pin connected to
>>> the IC's interrupt line?
>> I don't know the actual case here, but in general such a design occurred
>> in real life. So, shouldn't be a surprise to see another polling only mode
>> connection like this.

[...]

> This seems to be confirmed upstream too, where one has an irq:
> 
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/st/ste-ux500-samsung-skomer.dts#L420
> 
> 
> and others don't:
> 
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts#L439
> 
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts#L506

Thanks for this investigation, it really seems like it's NC
> Happy to split this patch series into two, just let me know! :)

We won't be taking any non-urgent patches until rc1 drops (~3 weeks)
so if the IIO folks decide to pick it up in meantime, just send it as
one

Konrad

