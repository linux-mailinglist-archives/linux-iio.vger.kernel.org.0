Return-Path: <linux-iio+bounces-25565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA28C13E61
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80894E390B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41007301004;
	Tue, 28 Oct 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iExINopB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9C239567
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644661; cv=none; b=DH1cn+nB0Lgj9sj6cG0eJn7NLLJztcTnPZuXCcPELhoOnAIf2cSm1z3TlIojN+C6pEsdhX5zsA6lIjpfXosNRn/LNg/W+mN4TnOivbDA4GhJgPqwfsLqefJl3LxbKVS4EtwEoUDlGy8PO7LzFkhved3y7U+WmnXphELYIEmCTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644661; c=relaxed/simple;
	bh=7QdSCc3ghckTTATUxUHS06CaambC2oJeybgZ5vYyCds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9teZhdFYUEv/9PEfr/cWWslxaJ27VqDLTF38iwcnsTKDjxXnnKJxVwoe2BBoUIbJO/fT60DiEOe7AdwMf/zoYWYOj6m3P3uvIyZkHYKIkYRmEplt3yLMrtzg/c63dHAk2qrRFWAzW7R0LPwoEc36DULGi32HP+fVVCzDxXG36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iExINopB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7cB052752124
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XaeEsRLrplO4MaerwlgBvJVzq65FTCNVJ8CSSdZ4EPU=; b=iExINopBfH1xC/zj
	zi4nh4V/E/V4wImPUNlT/ZBgHgbxX8rgL9frFbQ56+TDqTqE4se8w/ymE5Vq8dv/
	l+9srRYT5tjfxU/XWEVC2ee2cXqTt4YgeVEIyaXznFXpvWRt1ULNb+GDHG6hy2fn
	TAVc3vMTCWRNqE19aDNMaidRUIKZtkf0bDx6ITkyUzIpOeR2KGQUzHbikw/MUTdY
	Mr8qs4l3Uapyr7ElB1/ZW5xDmszdyLEE8RuyXlpNVrM7/o/dcyUsmnGYnwQP5yjc
	c/HyvAn4mKVwUcG3QJEhUFM+/l/3JZSDafX46v3JSqEwDqD/XV4zaHWTOfrqXkec
	dcNl8g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28nsuh76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:44:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7f5798303b3so14762716d6.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 02:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644658; x=1762249458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaeEsRLrplO4MaerwlgBvJVzq65FTCNVJ8CSSdZ4EPU=;
        b=Ta8t+IPUOIt2AbJJ/16GUAeD83aJq8hMkNT3rgrTm79bReCTtTgjshI9yVytcZKrA3
         Kxa3fcr1spV/0rr1r+VIl3wdfkVyY0L9n2pD9ii7d8QAppl2SbUi+y2v/pX8wbVqPVtc
         Toj7IuNEOVrFQXSp1KQ1nMub0i2iKFLCKWmFlgPXqfm3Q6xe4yyyLKTg81BAhd9cFdyU
         Mhjxp5lUN8ZpnIy48utBzULMRq5miDDqjdYzze7bXh9gLK24ir3fVgaPexpMZ+lmWQD4
         jOOKH3cvXD0adxaoHup4ykDFBMAImS1OmZFilwmQHC9v/+56sct2eSvXKYO5kBaPnQoE
         kvyA==
X-Forwarded-Encrypted: i=1; AJvYcCXqW21xyTFuRkSBBCFNxR4c3jNvk9hivh/mwhZ9h2Bn0gTR6Q6Q3XEXDM3yKmWTMwLdBj2oqZjXTnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4OhBwvpn+VwkP7l4gj4qwXeOgrY1GcMW96Xp+Fgo+yi2rEYD
	1RTYz1vUh9jMDg/3b+sOMrRWgM1jvsF7yO2+9hbhKuWhZGQ9TztVXviXK7vyIDdiCEAx6uFOpNo
	9TNq23IQKJEGg7TwPue8OOmWCCoeYOLyhdNHQezO69MVk6a1TgW5/T9E+f1ouRmU=
X-Gm-Gg: ASbGncsL7oG+LQ8sIC/nI45IKLpY22F9jXZmpW4qHSvsNbGYBEa2wEku2daT1T9kg/z
	HibV+5hU+8FuDOwI37pw5MoE2ZipXEwulFTaJdYY8gPoYsmrYTlvS4rAit06fD9vx5DXYQcWthB
	gDl93yvpfNEc5tWBy1Z/Ykm9LogoK2ENL9NWUyfmtcJaNtgLgKj2kP8HeBGdv9HKHU7z7Q0WT21
	C7SrV6Wf2fppUQcgfNbFY/FY2jyw/hAcfli4ab/GclBAygKm7iDOaXvR4pNv10Pp9BxfAGTSXrX
	CUbtof2akercws0Eq2+7Lua10IS0kKW4vUVw/6arNLSuGi9jtE1yjtOFVr7T26mkA+rXjOTQpUR
	Q6T3Vr8dZz2GNMAWBAMVSPmN4+G/QqphsK0ViX5Q2MUaySJcQezWqGr47
X-Received: by 2002:a05:6214:1c8c:b0:774:48fb:f8f2 with SMTP id 6a1803df08f44-87ffaed6fafmr22851516d6.0.1761644657669;
        Tue, 28 Oct 2025 02:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Qv7PHcmjyjQmOMGkJTFeywIqgyCGA5tiYOWaXPw2UiIkmKnkUlROizozxRcfdt+yrAEQfQ==
X-Received: by 2002:a05:6214:1c8c:b0:774:48fb:f8f2 with SMTP id 6a1803df08f44-87ffaed6fafmr22851386d6.0.1761644657197;
        Tue, 28 Oct 2025 02:44:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6bfd7sm8287323a12.4.2025.10.28.02.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:44:16 -0700 (PDT)
Message-ID: <7558d070-762c-4c81-aed7-1b087d131483@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:44:14 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4MiBTYWx0ZWRfXwzSNfw1Ho06P
 UP0AoZNy1+z5geeRmHbXnrUga8yQXknaDqp6AoZPjw+EERYiRsVh/29lSsF8wJc82LYU5WQVPrg
 VZo+2BYaiGRmJm5OskMHOTNr5R5Q/fTzctMtggFKdesDHgN3U5lNHRuI9slZYOgVTwVQHCOwvQJ
 Q6vuwHea0T9syv2WdjZqR6HjAOR0gj9siPxfYob7PA+Gg2rWujvYh6LjMLxxgkUsIf91ZA9FoVC
 VhfDHc+mgXYNi3CIISB+AuhREeJCOKQzM6COFBM/zqGr3oTw8ghwXKmGYoBntXTlMBc811s6VfM
 OYeV76GqmcZUlcGudSaNvKjGjc7sn2xrlODoFRNF/0Vi6uovafJXeqtIx/0C2mUgd76xbSSHG13
 vews5XJ6+gUiPXtaxScQa0G2ucweIQ==
X-Authority-Analysis: v=2.4 cv=RIW+3oi+ c=1 sm=1 tr=0 ts=69009072 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8 a=QdeQeJuzzvJw2AYENUoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-ORIG-GUID: tAtZ6RHEvD4li_F4yrl1q8Mg3Xfa17Dt
X-Proofpoint-GUID: tAtZ6RHEvD4li_F4yrl1q8Mg3Xfa17Dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280082

On 10/27/25 6:29 PM, Antony Kurniawan Soemardi wrote:
> On msm8960 phones, the XOADC driver was using incorrect calibration
> values:
> absolute calibration dx = 625000 uV, dy = 4 units
> ratiometric calibration dx = 1800, dy = -29041 units
> 
> As a result, reading from the IIO bus returned unexpected results:
> in_voltage_7 (USB_VBUS): 0
> in_voltage_10 (125V): 0
> 
> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
> from the predefined channels. Additionally, the downstream code always
> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
> those bits caused calibration errors too, so they were removed.
> 
> With these fixes, calibration now uses the correct values:
> absolute calibration dx = 625000 uV, dy = 6307 units
> ratiometric calibration dx = 1800, dy = 18249 units
> 
> Reading from the IIO bus now returns expected results:
> in_voltage_7 (USB_VBUS): 4973836
> in_voltage_10 (125V): 1249405
> 
> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
>  		goto unlock;
>  
>  	/* Decimation factor */
> -	ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
> -			   ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
> +	ret = regmap_update_bits(adc->map,
> +				 ADC_ARB_USRP_DIG_PARAM,
> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,

The PM8921 datasheet suggests a single valid value of BIT(5)=1, BIT(6)=0
for a "1K" (1/1024?) ratio, although a comment in this file suggests
BIT(5)|BIT(6) is also valid and corresponds to 1/4096.. I wouldn't be
surprised if that is the case

The previously set bits are a field called DECI_SEL but are otherwise left
undescribed

Hope this is useful

Konrad

