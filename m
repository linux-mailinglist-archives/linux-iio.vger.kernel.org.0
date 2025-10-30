Return-Path: <linux-iio+bounces-25692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF9C215E2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 18:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A740D1A225E4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E435970B;
	Thu, 30 Oct 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b="FxQcLMjS"
X-Original-To: linux-iio@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D71C8616;
	Thu, 30 Oct 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843933; cv=pass; b=IN2xyW4+RUb2r6cf1c9te7Lfx+2ztZnpcPpvHRh/106g3XlZnpoiugM9+Ud/v8vYUx44oa8Dl58knmdoaYMONdNythe4SjrmwZX0bYLSLZNx1xAwlupdR+Pq2vEhzzPYTRJyl5PtZXnu1iNeFuj+M7LPRIgsYPj93hHZ0OVgJ2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843933; c=relaxed/simple;
	bh=hg/95hEUFBThe3H+ibVwxlOjMXwtSvokvXgvdVPz/ac=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=LeWOBVO35SeM8iqxcbVJcRBb7/fGW3HsaBuZij4LT0uop9tw/zMsF424CQK0l4/zgCkUuYwhuYi8CiIsxNRfyWcKlIHLHlbBLVR3tNukquyHJMte0UHHzyhetWi0Ojo5ERdDuyXsRvI/juJE8tp/gHriYERR7rvq1rIp+nJPaPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com; spf=pass smtp.mailfrom=smankusors.com; dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b=FxQcLMjS; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EBB016C2DA8;
	Thu, 30 Oct 2025 16:57:49 +0000 (UTC)
Received: from fr-int-smtpout21.hostinger.io (trex-green-2.trex.outbound.svc.cluster.local [100.124.159.62])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5243B6C278E;
	Thu, 30 Oct 2025 16:57:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761843466; a=rsa-sha256;
	cv=none;
	b=Z0UCplVB+eSdVGhtkzD65nFS5cI7vE7/Za3LWPTC0LG9rGaYu3W3U+dcUlh64gIXP8yQBk
	gtNkMbmbDLlG2lmOnEi631NMINLXsnvcjrXndxTB64rTNt2cwxajlGh3kUKjq+vO9Zw0a5
	Tb8jbwOkrRg/auaqkTyx+QJU8m4x0fpVXp4EvyByu4CbMC1CvpVPnwrylj4CH47TDpFRP4
	eGlpKr1HPuXBAOzyRxr2x/7+Cg5dPX0DINS1BrtlWJ8yyW5BK/aPEbk2TUZKbsBIgpzFYn
	bjDPEsd8wK8KejxuP43LQAdVrYarcM84gbnMQvkHJwS/ShQCwfeqzQ8xm0qGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761843466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=llSNrpdxHG9NnwU1enTHpQTssCJw0Xi5+BHkeVKaDQ0=;
	b=WjBqSHD07j7aAfjf+c1V7cBAgbe4/5Vs2g4mxaYNwgRwCYgdZXKy98CzP8PSC4q52Edy2j
	D+QQpaO+kOAoS/ToM1eCcGC6nSoz6AIY7bZCdDwj5qW+VFuqueO9XD+fA+8xNv5GHP7UsS
	DpholT/jYiQQsQBEOtyI58/mfHeNk5JMyQ94NNz6Bt4zIp7e0CanBA54LBecabUt2RWlLJ
	DJ/wbfpWS7k+mu5qbH0yAnNPF/F9mzb2dkP4/BFdOawy6eTFTWcSqCgBKcRtdOs8udq4v6
	+Fs4vD62kUC4oNfGW1VEJ/fJdpxBA7aUHGveEK45ynkQNYhvKAaD3ryS6d00kw==
ARC-Authentication-Results: i=1;
	rspamd-77bb85d8d5-cbz7w;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-Spot-Occur: 203d5329002b97d4_1761843468479_438798023
X-MC-Loop-Signature: 1761843468479:3186618478
X-MC-Ingress-Time: 1761843468479
Received: from fr-int-smtpout21.hostinger.io (fr-int-smtpout21.hostinger.io
 [148.222.54.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.159.62 (trex/7.1.3);
	Thu, 30 Oct 2025 16:57:48 +0000
Received: from [192.168.1.100] (unknown [36.79.115.179])
	(Authenticated sender: linux@smankusors.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cy9K04ZZzz1xq1;
	Thu, 30 Oct 2025 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
	s=hostingermail-a; t=1761843462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llSNrpdxHG9NnwU1enTHpQTssCJw0Xi5+BHkeVKaDQ0=;
	b=FxQcLMjSW1FrrAdMnBYOxrLNbUUlSUIJJMxzucJGsa2aYUGuqN/l76CBecQmD7AQPsctm+
	atynGvxhfq8S6Vj6XS6bjdhplJRHitn74PX6Lri3khh12byEz/U7CyqHGzZRevlGY43Zmd
	iKg09uOk7y/drjogSWr2hqzy3bpIdmJVh9hczCKRaMziTJV50/kJyeykNLiYYd/sDAE9IP
	rz2ZFatUSZLfu8vEzWTCPIr/urJ6U8KThjtjn7jZdgqsAIMqE1YGht8zI1HAsSbEh4q1J/
	WiXaFrPffAMyjI1OdO+Ew5TDPrbFzNaPwF4mdFChfnWXttO6GsWTaKBw0vDGgA==
Message-ID: <6f68327c-73b2-4684-bc8a-156714b6e3fc@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
 <7558d070-762c-4c81-aed7-1b087d131483@oss.qualcomm.com>
Content-Language: en-US
From: Antony Kurniawan Soemardi <linux@smankusors.com>
In-Reply-To: <7558d070-762c-4c81-aed7-1b087d131483@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Oct 2025 16:57:40 +0000 (UTC)
X-CM-Envelope: MS4xfLHiMq5rjbjKJw5ofKWoM2Dkx4FtDaY4k08WQvmYqHQZLK8o87JlAoyAhrZS8sReutLKp63IqrA2L7ww+KJSjYUbChaSYEOomUKisyMKQv28VjmLmMrJ Gu/CVu9SyRZovqsNZAn+ILFHUv51x0CGBYShyPIOpKfLoaPxH6CBoPqadpCdR3lOL0D8ko0aEFyWH3I+OpTZpHb9TYFzIqyrFLj/D42vdXejDG3MPFb62P/r a0uMwtpLfoZtGoxmFojqEy8dACm+6ywcNFd3lr0GT89s8mz6nkkBJ5Sbwi+VeTpUPcA7KkD9CvLFnaFG4eG7/OioCcWsiReEByDQalc2QepORA8WEw68bs2i R2rXtlxBu3+rvUQeUpEYkLgvsRmmtx33relSpRCKHRXjg8F/4I/JG31nT68V+D3nZJfyg5VQCMwMfurHCEizX/4VLdVH2A==
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=69039906 a=zvY53+tUHMHsMQrS9yrnQg==:117 a=zvY53+tUHMHsMQrS9yrnQg==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8 a=tahBNpKbuAaPwjICECgA:9 a=QEXdDO2ut3YA:10 a=QJY96suAAestDpCc5Gi9:22
X-AuthUser: linux@smankusors.com

On 10/28/2025 4:44 PM, Konrad Dybcio wrote:
> On 10/27/25 6:29 PM, Antony Kurniawan Soemardi wrote:
>> On msm8960 phones, the XOADC driver was using incorrect calibration
>> values:
>> absolute calibration dx = 625000 uV, dy = 4 units
>> ratiometric calibration dx = 1800, dy = -29041 units
>>
>> As a result, reading from the IIO bus returned unexpected results:
>> in_voltage_7 (USB_VBUS): 0
>> in_voltage_10 (125V): 0
>>
>> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
>> from the predefined channels. Additionally, the downstream code always
>> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
>> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
>> those bits caused calibration errors too, so they were removed.
>>
>> With these fixes, calibration now uses the correct values:
>> absolute calibration dx = 625000 uV, dy = 6307 units
>> ratiometric calibration dx = 1800, dy = 18249 units
>>
>> Reading from the IIO bus now returns expected results:
>> in_voltage_7 (USB_VBUS): 4973836
>> in_voltage_10 (125V): 1249405
>>
>> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
>>
>> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
>> ---
>>   drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
>> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
>>   		goto unlock;
>>   
>>   	/* Decimation factor */
>> -	ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
>> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
>> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
>> -			   ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
>> +	ret = regmap_update_bits(adc->map,
>> +				 ADC_ARB_USRP_DIG_PARAM,
>> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
>> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,
> The PM8921 datasheet suggests a single valid value of BIT(5)=1, BIT(6)=0
> for a "1K" (1/1024?) ratio, although a comment in this file suggests
> BIT(5)|BIT(6) is also valid and corresponds to 1/4096.. I wouldn't be
> surprised if that is the case
>
> The previously set bits are a field called DECI_SEL but are otherwise left
> undescribed

So, do you think we can leave the BIT(0) and BIT(1) as is? I have a feeling
that if they aren't set, these changes might prevent the APQ8060 Dragonboard
from reading the cm3605 sensor? or maybe not?

I mean this one, since the driver was originally tested on that board
https://github.com/torvalds/linux/blob/e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts#L67-L79

> Hope this is useful
>
> Konrad

Thanks,
Antony K. S.

