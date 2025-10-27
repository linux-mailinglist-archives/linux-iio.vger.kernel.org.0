Return-Path: <linux-iio+bounces-25537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD4C11490
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 268764F450B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F44A00;
	Mon, 27 Oct 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b="AIhtHnxf"
X-Original-To: linux-iio@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027E2DF13E;
	Mon, 27 Oct 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594851; cv=pass; b=XzEBRcQwo4oOWAVqhwVgFjnbNeIcNHUj4UGlLoIYKMPfaiRvvdAegtEcECjxW7s2Pe2RN2GqdHWpVtmL+2uCSG05vpgPneGcWP7EdzjF0shqLmyppzjpoI9qv0FzNkXExaQmbe2nC8e5i/NOLwqAYt0tKgb8YfkN3W201cRVozQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594851; c=relaxed/simple;
	bh=Qqsc2ILZgnL5sfeCIPODmSHlfhcETbR+pkldb5j5XQI=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=SH4QjMgMpW2qoLkHh+F8tiFy9LL1sNLmgZpXT+XN74ZAvV8f0nmVvfgnA47OENMc2NTP5sfzrfqUH5k9sZ03XO97A+3XD0jEnJ8OdZTZAHW3iLKZuGI6rMstSz+Z4fyLEGK7PtN9rSHPwlgntQFt3YTMiNoacgd6fOX1xW2/3DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com; spf=pass smtp.mailfrom=smankusors.com; dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b=AIhtHnxf; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B05D61E0916;
	Mon, 27 Oct 2025 19:54:01 +0000 (UTC)
Received: from fr-int-smtpout29.hostinger.io (100-121-54-118.trex-nlb.outbound.svc.cluster.local [100.121.54.118])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1389C1E1D76;
	Mon, 27 Oct 2025 19:53:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761594841; a=rsa-sha256;
	cv=none;
	b=b+DcVB5QkAswxcZ8nx7C2mHWcMmr+WgVwvsbknTDVVgfcB8lcVWJkaDyNBCKR48g7MIk8X
	WKOWQDDi5wGKUxmFxCEP0Qd5+dKOY+RMC79ED4depgBiDOnatJHLhPQCnxy/EhdAj5Bfzi
	iJtOcoAvEv6osMzdLapkxuh9LmmlIds6ACfyAeH9/KJxqc/w/sQ4lwMt7vgF/Z6xApaCw2
	zBIa91Zg24EicxlwiCb1WrAM/9NCHXV6DT1qU9SViVgyMCW/SFH+BnzuOWIsTHF3Ru8NM7
	V4qenG5KvpzI9OeVS7wjK4uXf7YR/SizNWD08bEHApcX/R6fVa8rzOpNYs67OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761594841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Fgu4haRJ3TjizkmXO7Ii38sA0+eFMmWygfP7GmFpSnc=;
	b=xqABxCNOmxJ5I4OL1ZOzNYOxwtl0R5yhHrd7y72fGs5FeLjbC3AyaP9Zaz1hfWU9q8QiNe
	v7Yh7TIWyFb135VPCEbDgQaEYSEqijmid1PzjYNCO5CfPTvrL9dveYq6SqWVtEERYklkgF
	Zjg2FjCUGecTcN6IQYNmRrhK6vQ3wS3xYUddPIBWHKRU97A83iWbrkpHDoz9clumJX5t0i
	nmRGigvC6Yj03TFA8jC3/j+XXkQq3/ynRv9nm+3thX0PWebgLCoNMNXa0rx7BqNN0g0FMy
	0XiUY2jV127q2kjDegmjxqSM3Gjw5tXiReaZ0deNSXxumLUey79aryJ4sQtj+g==
ARC-Authentication-Results: i=1;
	rspamd-9799b5d46-sl7bq;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-Bubble-Descriptive: 59c52fe65fd9ccd9_1761594841553_3886930417
X-MC-Loop-Signature: 1761594841553:1032203036
X-MC-Ingress-Time: 1761594841553
Received: from fr-int-smtpout29.hostinger.io (fr-int-smtpout29.hostinger.io
 [148.222.54.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.54.118 (trex/7.1.3);
	Mon, 27 Oct 2025 19:54:01 +0000
Received: from [IPV6:2001:448a:502c:2bb0:95e9:f097:b160:9749] (unknown [IPv6:2001:448a:502c:2bb0:95e9:f097:b160:9749])
	(Authenticated sender: linux@smankusors.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cwPMQ0zcGz30Mj;
	Mon, 27 Oct 2025 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
	s=hostingermail-a; t=1761594838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fgu4haRJ3TjizkmXO7Ii38sA0+eFMmWygfP7GmFpSnc=;
	b=AIhtHnxfGcefMfT8wgkf8Saqi+HpoAEqCw6uyIbDHNKo7pA6T5vZDfrF/r1R9YZ9P8amZ6
	nhsFScPgLGS8Bh66DeQZlGpE4dpkeFiWJknCMeQTEAz7Ofut+puWJdloPA90CBQUkE7W6K
	w1tgpXZfFgcELkyLdTiP3fUx675+QU7JT0AbhXuv8JpYMiFe0xe9B0P8J3+ft1D6vr5rpe
	zTfcYxLeVbT9DVoHPUQZq059SczorHnhu6h6TfN66tNXjoZeFfnpGw9AmMr9ueDJHMi5rc
	cC3AfZ8BCVRi6xxvpyRpumEcTrkkCf4Zgo2KLL0AvsFiGFIPg0OiUeecanc7Xw==
Message-ID: <003c5cf7-2498-4ff3-a8b4-2911941b1464@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@smankusors.com
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
 <0eea7e4c-ec3b-421c-8522-aa3f52b5cb13@baylibre.com>
Content-Language: en-US
From: Antony Kurniawan Soemardi <linux@smankusors.com>
In-Reply-To: <0eea7e4c-ec3b-421c-8522-aa3f52b5cb13@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Oct 2025 19:53:37 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=68ffcdd6 a=fmYAFP8Zw2ItDPOga5xpZw==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8 a=plTiqhbnNGnvf89LthUA:9 a=QEXdDO2ut3YA:10 a=QJY96suAAestDpCc5Gi9:22
X-CM-Envelope: MS4xfMj4kKk2rdN5zvtBl8/FisUPSCboOIm3a1VUJK7+nTrr0wc0+5UaDYTWfjEI/LVhQzcxuTbKL7ywjiLyJEroooHoj4YuMAia+5R9bIZStUyvhWbfdzu0 CYQ6wmt2sk/rpI8L3m6pmdPwgtkR7uftWJVOEigf7HVov4sbsWApJbX4m2xioYpKQ4n8GqCt+8o52Oq4e926LWHmnN65pq+ksLRxt391cxRTcr7bPzuZwhHM hDcAh8ANQhPI0XqFik9OJilzpPKyg0F0EBvpJ8KM+ooZ6Vf4RVWjWIhIv0/Fh6hyMUWJU1wAeWEauIxn7KP5zzTLccEDRm5ZzGdxc0aB10IEbWOOf9u1p58s gl3T0jHXyG4lvPzmtpkz8uN3fE1cN7qQVyAd7QykGhoK6dS53Tkxx/VwpwR3ePqj/2a5rJjRX7ZxkH4D4UfX/VN9anehh7mW6XY/UJkevpZd6XFzwW+RQ++E 3sRny/RdlOoLjOkVjQZNBzE72gwZF/bPtSZIex3g6boB5dkeTTpKRzpJsWpr48ti1JP2xY34vbSNP6mm
X-AuthUser: linux@smankusors.com

On 10/28/2025 1:35 AM, David Lechner wrote:
> On 10/27/25 12:29 PM, Antony Kurniawan Soemardi wrote:
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
> Mentioning downstream kernels is usually a red flag. :-)
>
> We can justify it here though by saying that there is no documentation
> available other than downstream source code, so we are just using it
> as a reference.
ah ok, rewording needed then
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
> Would be useful to mention which hardware you tested with in case
> it turns out that there is some other hardware that does require the
> SHIFT0/1 bits to be set.
I did mention Sony Xperia SP from cover letter, but I haven't
referenced it in this commit yet. Also I tried to search on Github for
SHIFT0/1 bits, but couldn't find any usage of them...
>> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
>>
> Since this is a fix, it should have a Fixes: tag. And it sounds like
> possibly two separate fixes. In that case, it should be two separate
> patches.
Fixes into 63c3ecd946d4ae2879ec0d8c6dcb90132a74d831?
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
>> +				 ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
> As a follow-up patch, it would be nice to update the driver to use FIELD_PREP().
>
> I.e. remove ADC_ARB_USRP_DIG_PARAM_DEC_RATE0, ADC_ARB_USRP_DIG_PARAM_DEC_RATE1
> and ADC_DIG_PARAM_DEC_SHIFT macros and replace them with one macro:
>
> #define ADC_ARB_USRP_DIG_PARAM_DEC_RATE		GENMASK(6, 5)
>
> Then use it like:
>
> 	ret = regmap_update_bits(adc->map,
> 				 ADC_ARB_USRP_DIG_PARAM,
> 				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE,
> 				 FIELD_PREP(ADC_ARB_USRP_DIG_PARAM_DEC_RATE,
> 					    ch->decimation));
>
> This should be done for all of the similar multi-bit fields.
as a follow up patch, you mean next version of this patch series, or
separate patch series?
>>   	if (ret)
>>   		goto unlock;
>>   
>> @@ -783,6 +784,7 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
>>   	ch->calibration = VADC_CALIB_ABSOLUTE;
>>   	/* Everyone seems to use default ("type 2") decimation */
>>   	ch->decimation = VADC_DEF_DECIMATION;
>> +	ch->amux_ip_rsv = hwchan->amux_ip_rsv;
>>   
>>   	if (!fwnode_property_read_u32(fwnode, "qcom,ratiometric", &rsv)) {
>>   		ch->calibration = VADC_CALIB_RATIOMETRIC;
>>


