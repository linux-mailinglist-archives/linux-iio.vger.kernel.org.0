Return-Path: <linux-iio+bounces-25725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB6C23F9E
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DA1A6516B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608C32D7E6;
	Fri, 31 Oct 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fbPRSq25";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/90Esjo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A92E2DD4
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901234; cv=none; b=CEXD994nhde00b+wps9XvLTx1pMKVLJUjTfx8g1541h+OsScgX0sR2wlEsdAXfy7rWG8SJiuRUgkUF6y99IJDvRnwGNbQFM+mODFJtY3FHVIyUDR9yqC/I2gkaBsA1j3bHKcXl2yxzJ5toJw6HiZJqV+n1GeL7uvUxc11bTxukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901234; c=relaxed/simple;
	bh=3Nqyo0lm23KKHy/yRGd1tfKCqpvRuaRhkfrwBtXRfvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5jjeIS76TJz45aSdFqebInCgSgrKcoYqWqNEoShraX8o2HnqOUcufMUQWMaMk6oVSp7tRE9sd4b7NU7/4wwyLep4UcKa7gJns2m3dc1R6rHJcPBVe9a3KMd5kS4m+1hOszWyzMZAYa2PZXotgc17xvmhHN5mGPinbOoNIIJO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fbPRSq25; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G/90Esjo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1mk9q1571588
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 09:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	51KxsmTUlKetVoa7snk55iZwO//Znw/8nsnKLTwJvYQ=; b=fbPRSq25IGipg4E6
	/VkiMce1fELBZtibgEllNim3q2c77sYolnq+li+ZLBOVtP3zlwXdD7YfefreQSmC
	lEQT/16IZNQEXDGKPzmCv3pQdRImE9n1zudx4imN0FAG/7RezvA6r0wDfTN7aKXh
	2j7xbnqYPn5QGaood2AlThg3xwUBE4aloRjR7BK07+FWlx9N91nLQebLrzN5R8u0
	TQ9BeZWim3gaBweFG62oCvIqkZY/WIVCCGgr5FUdCsVmjb5VLlOuEjAfhwoJYNSq
	Qj7O2kNxQG+Gy+akFdYOOhqnvu1BWmJjm0+lQU7ofgJ+gOrf7//OUbr2OyNgFSBb
	EIFmPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc1012-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 09:00:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eb9cfa1b72so6536931cf.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761901230; x=1762506030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51KxsmTUlKetVoa7snk55iZwO//Znw/8nsnKLTwJvYQ=;
        b=G/90EsjoZ/0W82/8DWUFN2dQsfYaG1NbPTlqbNDe4Nqc18WSoE6Xa9GkWtiRkrF81O
         ICgUl3jTYik1T65d4Q0WYBHXpcuBJH8eIdb5mOMu9WRpNP+AFJyimr8CFMuljxQH4uMl
         X0T6DzXY0j6xi+YlmyKntvpIUUOpkGfw41PLmlSujTbdZhxe7nB0Nxy8g568Irv/ui4J
         EQBUVHEKbep31CWGt4vPydYh7sRGyov3WOtL9OGqnbxXd69sNNeVKC3w+BJtzmbZ922Q
         A13f2J9vUSzfeMZC7N0IxbDe2yEfnVz7pgCLiKhvj2rXQUnj4MR8YhOE7Cv6suAEso3Z
         RJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901230; x=1762506030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51KxsmTUlKetVoa7snk55iZwO//Znw/8nsnKLTwJvYQ=;
        b=YO5zi0L9KT61zUiOb4WtTD4RYY3zhwWZtwKqVyDdVGVFpRZXmZzIV7MajMsODhCv0t
         sdr1OUKIknpbJdC/Zsn2Qao1BOtUA8WByezVOdjwwImC75Y6v3eYssPLo5ktYCFomhUO
         8KpdBH+Py2nd5hduADgns1pRAxn5rtxHuD7v0eOxDvSPHBbC/jP+GYRYIF03xPybzlPF
         Ps5Dxn7+BZ8xktWtIAFcvV4nyL/M4WnmbATrDHjMTEq5o2R5wP1iih/5EG/aNvBpb92Y
         Xny3SqvsgbsBdva9r1JU5TrzoPBLwQWqz7uqSC1/vdgwLsVxdWkzTOoxneIHOfJn2fcB
         glNg==
X-Forwarded-Encrypted: i=1; AJvYcCUlBaId3959Wbi6/7O/uyjypc/ZlM+wXw9qlJ95P6qKVL56KkeuxQrga8kNxDVOg+DMmFFnbaZ8Nqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZC7EmZzfhC3iIVWa+SqckHQaUJZm1vR28P4ovgR03TITFVCan
	/yNMehdHTJVlc4hozGJVw8tCeeIiY0vbbLwuG+u4kwuxsNMwY3a3dIBIfOg8RiGlX2qJgjYTzxW
	GJNxCeYwjYkcRlMwvlksCx4zRy8Tr5qgzE5/pDT9a5j0STQSk4LKj8EGjGBVJKuU=
X-Gm-Gg: ASbGnctnIYESySMCXTp6Hh659EMsDSKnF9DaTxypzrpVT+uCGOMznHGUSohdlpsVB6J
	NKsEKmmJtsPvEDcMr3U+kMOBgwHFDeiO0asyYHNcmC6mqySoG5RG7u0ZHhgrncSkUJJchT7oe+m
	b+jdYNeW5BX6u5r7G8YWdtwkZC2khFMsXNTWKLHkJ71w8VE2BcpMuwHRTp6Sl4DqFU23gzMS4l7
	l+HEMf5J5lfFWameQOxYHILnv4Mf7lx8jxjIy6zjftsvjO/GQOuItEzLzDOyFMzMaAHWtXqI3DF
	el/8WtGIntvWV5K8KJzthCqafqveLwkB48I0O6GCztMOFBoQYry/+0SOIaeWvqQQgww31D1NI1i
	leSacr+5MkEx0C4NAhVLLqS0n5A318Sqf17RIcoIxWICqcyEkoBudCu79
X-Received: by 2002:ac8:5749:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4ed30dcaad4mr21525491cf.4.1761901229636;
        Fri, 31 Oct 2025 02:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY3YnzS1GfkHDDFPzYKp5lWuSQxcoirGYCUMxBG2rM3MMEMYWs4Z0j773x521VXm95NlUAZw==
X-Received: by 2002:ac8:5749:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4ed30dcaad4mr21525131cf.4.1761901229036;
        Fri, 31 Oct 2025 02:00:29 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c9dc34sm120572466b.55.2025.10.31.02.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:00:28 -0700 (PDT)
Message-ID: <b4a86788-fe0e-483c-93ff-fe993edb3181@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:00:25 +0100
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
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
 <7558d070-762c-4c81-aed7-1b087d131483@oss.qualcomm.com>
 <6f68327c-73b2-4684-bc8a-156714b6e3fc@smankusors.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6f68327c-73b2-4684-bc8a-156714b6e3fc@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4MCBTYWx0ZWRfXw+a5+uVcpVco
 QC68yrPr/kE/gd39ZuurZzz6KXaW2YlwlGDyk6l0hQEJmHE9T1DyFNqGbvIEhNwwq7g/mIDcwTE
 5aRTG6ckF6tsq/+yI0QB+m/4l8MWF/SZMlPKbO6HJI3pNdaJBsTVfEB/vfXtQTNINQ25+tBRxqG
 xr7ulvQ0w/zR3SeNi+0z9yz7eqcyn5t4TjoleqvkoNFJTtpk0hEUJjeT6K9wJt2sjaYeTgr14a4
 riSAXlqU4eu6dUpkEZcYiiYWJF6IPE+hhf93kLE/NEfdBTt2clpAFdMpo6S2Wv0ZvDeBrcSvZIp
 R+fsFddbMPtS52zQsLtnspAss2R/QkiDGkdApzABz972nS/x1bo18EDsXDzsDwOrcRMMi0tWLEg
 0B46L6wttVFcT3UAM4JFueABVJSmgw==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69047aaf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8
 a=GSQsxLvvc7Q80mA-0Z8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-ORIG-GUID: 5pX9jCnwVEogsUMCNlzly_nJuS3TBD6O
X-Proofpoint-GUID: 5pX9jCnwVEogsUMCNlzly_nJuS3TBD6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310080

On 10/30/25 5:57 PM, Antony Kurniawan Soemardi wrote:
> On 10/28/2025 4:44 PM, Konrad Dybcio wrote:
>> On 10/27/25 6:29 PM, Antony Kurniawan Soemardi wrote:
>>> On msm8960 phones, the XOADC driver was using incorrect calibration
>>> values:
>>> absolute calibration dx = 625000 uV, dy = 4 units
>>> ratiometric calibration dx = 1800, dy = -29041 units
>>>
>>> As a result, reading from the IIO bus returned unexpected results:
>>> in_voltage_7 (USB_VBUS): 0
>>> in_voltage_10 (125V): 0
>>>
>>> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
>>> from the predefined channels. Additionally, the downstream code always
>>> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
>>> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
>>> those bits caused calibration errors too, so they were removed.
>>>
>>> With these fixes, calibration now uses the correct values:
>>> absolute calibration dx = 625000 uV, dy = 6307 units
>>> ratiometric calibration dx = 1800, dy = 18249 units
>>>
>>> Reading from the IIO bus now returns expected results:
>>> in_voltage_7 (USB_VBUS): 4973836
>>> in_voltage_10 (125V): 1249405
>>>
>>> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
>>>
>>> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
>>> ---
>>>   drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
>>> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
>>>           goto unlock;
>>>         /* Decimation factor */
>>> -    ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
>>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
>>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
>>> -               ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
>>> +    ret = regmap_update_bits(adc->map,
>>> +                 ADC_ARB_USRP_DIG_PARAM,
>>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
>>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,
>> The PM8921 datasheet suggests a single valid value of BIT(5)=1, BIT(6)=0
>> for a "1K" (1/1024?) ratio, although a comment in this file suggests
>> BIT(5)|BIT(6) is also valid and corresponds to 1/4096.. I wouldn't be
>> surprised if that is the case
>>
>> The previously set bits are a field called DECI_SEL but are otherwise left
>> undescribed
> 
> So, do you think we can leave the BIT(0) and BIT(1) as is? I have a feeling
> that if they aren't set, these changes might prevent the APQ8060 Dragonboard
> from reading the cm3605 sensor? or maybe not?
> 
> I mean this one, since the driver was originally tested on that board
> https://github.com/torvalds/linux/blob/e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts#L67-L79

+Dmitry would you have that (or similar) board in your museum?

Konrad

