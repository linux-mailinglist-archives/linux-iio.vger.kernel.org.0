Return-Path: <linux-iio+bounces-27628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA099D0F992
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 19:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB47B3038F55
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E3F34D3BF;
	Sun, 11 Jan 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b="jOOrb3sf"
X-Original-To: linux-iio@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B60217F27;
	Sun, 11 Jan 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768157320; cv=pass; b=n2UPJOvxEH8Okl+O+rXfh4n+lmGVrX+CXYsnpXWvF9NgfyU3K6Y9sqxhej2Mq6DLy6a7IfB6z0RhPJsxejgzr2ZTh0/TD/eH4+VNZMNkzB9K+4erynR0qeA2s8Oj0cdGL29kxVyvEmvHBGw7NCrArcNKQmNedE5/d/MtbyBoQCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768157320; c=relaxed/simple;
	bh=u6zoT6mcoOiHOlYHsosu4NvUikdW7TGAt5NvDqQsWJY=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=ou7knzEZjSdwHq1VSC90CPyU6datWsTMRvlXlds8NdCKI81k13qxYANgJmwcGcmhFnGDA/gCmVttObntyoBs5aUw2G1Oq7I1tdoA1191umddQ0ZtgOHaMZ2hnpzsaOvg/NW1vYYLgkQL63uNTo5Ee7ZvIADctSjmvhZfGvn0pho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com; spf=pass smtp.mailfrom=smankusors.com; dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b=jOOrb3sf; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D4848801061;
	Sun, 11 Jan 2026 17:31:51 +0000 (UTC)
Received: from de-fra-smtpout4.hostinger.io (trex-green-3.trex.outbound.svc.cluster.local [100.107.156.133])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8A8248014CD;
	Sun, 11 Jan 2026 17:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1768152711;
	b=tciuOG8XJ+fEyCeUqzl871bQbZihDygZIvzJk1AvLOcaPW7DLEVWSdNL/aNds1l0pRoDEW
	fIH4BUS6Y3ZTkNAZu/q/cm60Qgww/qrolaBv9cvLoaWgoVFHhAopcQpWmK1DzK9Su2gvN9
	skrnt+LEdQ+JmMjtPRFNy91z8h0yPy5AGAe9Jx/XXEsmDRTkbkZjW3VGorEeFSbE+46kWB
	C1EyY1Bu1Y8LRGpUJCH7XB2LsBHUyF0EAiZVG/Lv2UZNL1xsV5AQPAofTBUtqjsN1ELVXM
	SMq13+7MknTWE8nJd2g6XUQMB0ia0dhsXoP+nLXCkZd4iqtrkYO4ee5KELV3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1768152711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZwnL0mMeEsDKcxfHMMhqFsQ4HA2txm2FttjJCG3CTDg=;
	b=Baj/2lChxkB53meYn9VAPVNiBDcVwwJx6eCAP5jvJetWoRtnRuMyqUdmAF2mw75f4AD2VA
	0N0R2nk0HA4DBv77QU8/G/fVd9v01tFJT1CLeQP+ah/X6ZUFy+w3aeK0tJYwcunxB+ryaX
	lmreQMQC/F1ZZMgDa8rv7jpXXrrm2wAXQoMuLQLa0TdcuVGmn4XimR92f5KTm5CNhQmgbx
	7t6kAyG3x6cFqT53lxZSzP3mj2zY7iScFWMLMh4WYBjnUB1p9WYUGu1EYpItZzCMRbapih
	YMJ1jj96hOt+Bs2WqFrGWOE36yJsx2X3usgeLQRJuLH59XreQ0Ko5aNJvhrOQA==
ARC-Authentication-Results: i=1;
	rspamd-79549fd459-dwvns;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-Suffer-Broad: 0d312b844870b59c_1768152711474_3633387822
X-MC-Loop-Signature: 1768152711474:860441808
X-MC-Ingress-Time: 1768152711474
Received: from de-fra-smtpout4.hostinger.io (de-fra-smtpout4.hostinger.io
 [148.222.55.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.156.133 (trex/7.1.3);
	Sun, 11 Jan 2026 17:31:51 +0000
Received: from [IPV6:2001:448a:c020:e87:5d8f:81d4:5987:474c] (unknown [IPv6:2001:448a:c020:e87:5d8f:81d4:5987:474c])
	(Authenticated sender: linux@smankusors.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dq2cd6KNgz3xHN;
	Sun, 11 Jan 2026 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
	s=hostingermail-a; t=1768152707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwnL0mMeEsDKcxfHMMhqFsQ4HA2txm2FttjJCG3CTDg=;
	b=jOOrb3sfv4Y5VPAUdvdSQBIKmetQcBztbPjHKMALEy3kxeFpe8NH+qfkmqYKGGBsaHKBOr
	aKwykZ+4716N4a7kT60xemBvik9Anfsyh3WtJ6SuVvcPLW45pNk48gLO8Ndf3nUxp004BG
	+K2+kvSEVDvg7iZwSWHjh09yoV5MIf8uHlmAK4rHE6+fLIvckAfhRFANgfiU3KPOnZB0E7
	CSmCJFQawUuvD0S47r3zhA9p9FXY7enLyCiQx15YA4Xvmgn2sJyV0jMDNejpPVpxW7A54W
	kd+uvRAJQV7nzqd3vohJzjnS58/P6iNT7oonp6BGYvPxMJGvbcplvHeVovqW+A==
Message-ID: <60245ae3-c489-4dea-9252-3a200fb6f6e0@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
 <7558d070-762c-4c81-aed7-1b087d131483@oss.qualcomm.com>
 <6f68327c-73b2-4684-bc8a-156714b6e3fc@smankusors.com>
 <b4a86788-fe0e-483c-93ff-fe993edb3181@oss.qualcomm.com>
 <drqbd4yzvpcj5mauyees67a5vyfr4pt4lgm7npsye45smn2f3o@yyemg6qho7ut>
Content-Language: en-US
From: Antony Kurniawan Soemardi <linux@smankusors.com>
In-Reply-To: <drqbd4yzvpcj5mauyees67a5vyfr4pt4lgm7npsye45smn2f3o@yyemg6qho7ut>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date: Sun, 11 Jan 2026 17:31:45 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=6963de83 a=R9tOm6zz4fGttZMN6PWlEg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=OQN141zOAAAA:20 a=9AdMxfjQAAAA:20 a=wxLWbCv9AAAA:8 a=4i8b9kqHgAYvtWNp7gYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=QJY96suAAestDpCc5Gi9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-CM-Envelope: MS4xfNbKXuAh19KTrEltQIL2ob6hmmOOKlbfj2Js6lXBb5eyeegV+uhPbhkNACpp1Bc1c/btd1MmaKMHNZJ8Nd7frXwfNmrZeMgUYZ5xWmxQ5LC5ajwU8ALy 8hV7Zy8dm+12vfyplyxm7tt8D0c4tox5TRxMhbqtK1mPgJwiKB4jEDXYReiAPdFk4saYyH9UjyEkpPg/AGuavcNfly4xySiEo7UudF3BwxKnrhq0/UA/U2fr eUDCuZFj22o8e8mBNmSzfP0BZy/mybcVzcVMlEmHBDnoDCSpIJOuSgd97FQVB5c0lCp7ON17g42mW0ZL6hu982ZMvxuJUxhaoUN6LJ8tbq+bO1WrfM1kBRnP XIebMjyyzOOIjcvlvlnr2bydEBgiGUZbrUiO/DblI7SwLqZzwqJjfEchnPvpEhldyJlYmmOPKktok6i2w4dlw0FzVg/d2Y6JwdLJ1dG4O+qos1UmDN1ygMN8 l2FcC2KZtBLCwVc4tBMylLSX+fBh5W7nf3bX4+VjmVEkDm43b8BxLEiMQ9ikp+FJZWGdRXm4nxGIpnS4ymxvWuPr37sHZsZsKolFboPs3SwVfk6oJ5tSJNP0 dBE9dc7R7TKCJgo3KOekr0dK
X-AuthUser: linux@smankusors.com

On 11/1/2025 4:25 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 31, 2025 at 10:00:25AM +0100, Konrad Dybcio wrote:
>> On 10/30/25 5:57 PM, Antony Kurniawan Soemardi wrote:
>>> On 10/28/2025 4:44 PM, Konrad Dybcio wrote:
>>>> On 10/27/25 6:29 PM, Antony Kurniawan Soemardi wrote:
>>>>> On msm8960 phones, the XOADC driver was using incorrect calibration
>>>>> values:
>>>>> absolute calibration dx = 625000 uV, dy = 4 units
>>>>> ratiometric calibration dx = 1800, dy = -29041 units
>>>>>
>>>>> As a result, reading from the IIO bus returned unexpected results:
>>>>> in_voltage_7 (USB_VBUS): 0
>>>>> in_voltage_10 (125V): 0
>>>>>
>>>>> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
>>>>> from the predefined channels. Additionally, the downstream code always
>>>>> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
>>>>> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
>>>>> those bits caused calibration errors too, so they were removed.
>>>>>
>>>>> With these fixes, calibration now uses the correct values:
>>>>> absolute calibration dx = 625000 uV, dy = 6307 units
>>>>> ratiometric calibration dx = 1800, dy = 18249 units
>>>>>
>>>>> Reading from the IIO bus now returns expected results:
>>>>> in_voltage_7 (USB_VBUS): 4973836
>>>>> in_voltage_10 (125V): 1249405
>>>>>
>>>>> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
>>>>>
>>>>> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
>>>>> ---
>>>>>    drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
>>>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>>>> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
>>>>> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>>>> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
>>>>> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
>>>>>            goto unlock;
>>>>>          /* Decimation factor */
>>>>> -    ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
>>>>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
>>>>> -               ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
>>>>> -               ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
>>>>> +    ret = regmap_update_bits(adc->map,
>>>>> +                 ADC_ARB_USRP_DIG_PARAM,
>>>>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
>>>>> +                 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,
>>>> The PM8921 datasheet suggests a single valid value of BIT(5)=1, BIT(6)=0
>>>> for a "1K" (1/1024?) ratio, although a comment in this file suggests
>>>> BIT(5)|BIT(6) is also valid and corresponds to 1/4096.. I wouldn't be
>>>> surprised if that is the case
>>>>
>>>> The previously set bits are a field called DECI_SEL but are otherwise left
>>>> undescribed
>>> So, do you think we can leave the BIT(0) and BIT(1) as is? I have a feeling
>>> that if they aren't set, these changes might prevent the APQ8060 Dragonboard
>>> from reading the cm3605 sensor? or maybe not?
>>>
>>> I mean this one, since the driver was originally tested on that board
>>> https://github.com/torvalds/linux/blob/e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts#L67-L79
>> +Dmitry would you have that (or similar) board in your museum?
> I do, but I sadly I didn't test it lately (nor do I remember if I have
> sensors board or not). I can try testing it next week, if I have time.
>
Hi Dmitry, I wanted to follow up and ask whether you’ve had a chance to 
test the APQ8060 DragonBoard though?

(Also happy new year! Eh, it's 12 days late...)

Thanks,

