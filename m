Return-Path: <linux-iio+bounces-8374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9394D38C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35245B22993
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C821946B4;
	Fri,  9 Aug 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gGw7MgYP"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-216.smtpout.orange.fr [193.252.23.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02787194C62;
	Fri,  9 Aug 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217723; cv=none; b=KqUSbH+/YFGutnxZow9UGf6EhvtlYGfZY67vl0F8sw6q06/+846VU9G/j1o7nCwHTWVWclL8QPRl0kMwGwEIVuTxsThl70dnKhaMGC4HEvSUIYqXVhoY2e8jMn97PevR6nKl0H5Al4eE9xRsgfA+bZL7mWw6yiCecYwvZN8lfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217723; c=relaxed/simple;
	bh=alMx3FaLXvrCcOpHNI1Kce8yS54FHkxPds+xnj7xf1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVRNX3h2nCLNdjMckJU1q/e5KPjSZq199uvZMMq7KkQKPS+i5Qle9ZY8u7cISzCtMBki57GNfLF0K8Hz8WcOo4hT/aIkPTWxsb20ce2dhJ/d/6HGmaXgqoSvuTTqV5JHavBok/1zoZaMgW+1vkj+x/wZeEbbiiZv6o9Lld2dzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gGw7MgYP; arc=none smtp.client-ip=193.252.23.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id cRczsUVfkOGeacRd0szeSZ; Fri, 09 Aug 2024 17:34:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723217646;
	bh=dL3EWOnxHrCX3LwQQ8rHJjJ1VknbUrGetrFnEmJangs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gGw7MgYPDqd8W1f+UOz84kw8NFAwI8nM2/Q1JbFdERkyVhhjb0+RYusfwvuXqYLvF
	 rxnJld+WgECx3XAKuFfDMGEG/FDpR456opo4tzMP3oPo7a+kA7eYsyT0JggSb1H53R
	 QMIIE5RcFHR3CkNAMTeTfhqSTqtnhj4SPb6TMRnO5L/bdwKHqhv5H3S47HRLEm3qie
	 Y/IsPM8+qYP3uTRWk+iZe6dF8a9ktVeHNosluzHLUb+RE5ngzJ9Z4qYDlXw89ezevi
	 1Pt6NWuXHgwSCZU/tEIO+ZJq1hcL6JhOam4OtyOywisRVhued72JYsXye/kxmFdqmB
	 hpf0rIBS8y1Tw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 09 Aug 2024 17:34:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8a048baa-d9a7-4285-9242-7a32a594f226@wanadoo.fr>
Date: Fri, 9 Aug 2024 17:34:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for ad4113
To: mitrutzceclan@gmail.com
Cc: Michael.Hennerich@analog.com, christophe.jaillet@wanadoo.fr,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 devnull+dumitru.ceclan.analog.com@kernel.org, dumitru.ceclan@analog.com,
 jic23@kernel.org, krzk+dt@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
 <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
 <37357b8a-1995-473d-a6fb-168fc38e0641@wanadoo.fr>
 <93d79fbd-8d1c-4a80-bf65-d4e597247573@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <93d79fbd-8d1c-4a80-bf65-d4e597247573@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/08/2024 à 16:40, Ceclan, Dumitru a écrit :
> On 09/08/2024 17:30, Christophe JAILLET wrote:
>> Le 09/08/2024 à 12:33, Dumitru Ceclan via B4 Relay a écrit :
>>> From: Dumitru Ceclan <dumitru.ceclan-OyLXuOCK7orQT0dZR+AlfA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>>
>>> This commit adds support for the AD4113 ADC.
>>> The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
>>> converter (ADC) that integrates an analog front end (AFE) for four
>>> fully differential or eight single-ended inputs.
>>>
>>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan-OyLXuOCK7orQT0dZR+AlfA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>> ---
>>>    drivers/iio/adc/ad7173.c | 36 +++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>>> index a854f2d30174..3ac09d326472 100644
>>> --- a/drivers/iio/adc/ad7173.c
>>> +++ b/drivers/iio/adc/ad7173.c
>>> @@ -3,7 +3,7 @@
>>>     * AD717x and AD411x family SPI ADC driver
>>>     *
>>>     * Supported devices:
>>> - *  AD4111/AD4112/AD4114/AD4115/AD4116
>>> + *  AD4111/AD4112/AD4113/AD4114/AD4115/AD4116
>>>     *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
>>>     *  AD7175-8/AD7176-2/AD7177-2
>>>     *
>>> @@ -84,6 +84,7 @@
>>>    #define AD4111_ID            AD7173_ID
>>>    #define AD4112_ID            AD7173_ID
>>>    #define AD4114_ID            AD7173_ID
>>> +#define AD4113_ID            0x31D0
>>
>> Nitpick: others are in lowercase --> 0x31d0
>>
>>>    #define AD4116_ID            0x34d0
>>>    #define AD4115_ID            0x38d0
>>>    #define AD7175_8_ID            0x3cd0
>>
>> Other than that, is there any reason to have this "random" order for these defines?
>>
>> CJ
>>
> 
> It's not random, it was requested to order these defines by the ID value:
> https://lore.kernel.org/all/CAHp75VcjcgnLkQWim1AVnyeRGFwwKpaWSCvrmqdv41Lx87hMKw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
> 

Ok,

I thought about it, but it is not sorted either. (a few lines above the 
place you added the new #define):

#define AD7175_ID			0x0cd0
#define AD7176_ID			0x0c90

Maybe, it should be part of another patch to keep the logic by ID value?

CJ

