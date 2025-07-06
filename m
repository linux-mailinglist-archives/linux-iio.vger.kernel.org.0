Return-Path: <linux-iio+bounces-21413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D62AFA6DE
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1290717A6D4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49595288C1A;
	Sun,  6 Jul 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rsLL81GE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5D19C54F
	for <linux-iio@vger.kernel.org>; Sun,  6 Jul 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823231; cv=none; b=Yh2oxOqyHtEowLg5MCuvWSBez9dX0TXQw2C2bKoAyIrC8pbCm01zne0EyRaz6RWwivdIUQfq1OKPdKZpwTasvkH31SBpJtjwdyC8nhxXNfTShXm+BnCtGLi3BxG2ibhNTWqVHkpCgmVQgC42tdSyYvEs+deIpCAfakz/MxYT5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823231; c=relaxed/simple;
	bh=Cf3yhv/26SqDxXicxC3HfCxus6Z0GxTvozJbfxCLYxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWpKBV/5VQzgtkWjWai7YlVFYhSZDj/YHoHmPkPCytjR4umPGceq4clXY8RU1Rf+YvsXH+2texqxOG7EZ4jSDTa6KlqaejBPTtslzwk3cNU550QQfpIxAOlE4gBuq4euMu2J4oZ7Fhh/PznCKHjngmcfOaER0asb24bsbRlL4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rsLL81GE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2efdd5c22dfso1732922fac.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Jul 2025 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751823227; x=1752428027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWYegh6L0RiKIRDn0gigKG9Sgo7nkwUjvpILFMl9qrA=;
        b=rsLL81GEbrN220e/nBsyOqX1iv6eV5AZrr0ci7op64lpyTUzBg4LThGPlOxpwqIkjF
         vE115efB+BTDjrY8xHC/eZSuphxGhZGuxawpBzwN9WI12k59QniJURiwEmapSV5KA8Ua
         cjH1zZyKt+XOswTEQR2D5ae80ELXVHvgUcoS3h//RplZ8NT1rlFWDCOAjPAp5NC6hBHr
         iCLFOXMfM1YL0Ec0h5APZMLGRuV+r5edYmmeNSvbTu8qU+DkvdglPIdB67dttr2J4kjF
         YJZ7B6exu5ocOqsL8m1xO5dJVPr79tbSVoySn3TzM8YxDXXLr/ATdGvW7BQ5ujRMyUPb
         tEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751823227; x=1752428027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWYegh6L0RiKIRDn0gigKG9Sgo7nkwUjvpILFMl9qrA=;
        b=oJCu6hPSJ+F/KudzPr7oo3OTTdN3TK0/UXi/RQ24m7LEc/1gnX6Ci8ryoh8kax3vmx
         GorvZrOtHyhO5Bo7/FN9JBQ8oqJa+LPufdjXxWdGSSGBFSxQozFi26a2h1GZcQX+h29e
         VgG/g1HfW1jjngag0qmKq+HpK2ZeaXmL15sahSTZbSnFVJrdM8dV1tlzw4oV68qvuwDB
         /32gjCM4wgmz0NbFidGApz69Tcoyu/jWV08r/yqFED5n7oMwKhxNH6gdISeCKd+M1hNr
         WqIuukP/3nW2aCpUsnAzaCbLhDeMu+2lk7mazMOkFfbrdHcUY0gce7LRPDN48zzHrdeT
         5vcw==
X-Forwarded-Encrypted: i=1; AJvYcCU+H99wO2gCNwUB5O+s3tyRxTyRAbEVEP1gaUDaXDvKfTsde2JLjFRxf1NU4k0Jwg3jXlakyt0MEfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSedRM9kCidDSNp1UgOcUKu7AxXKlfb3OYl+gkBjfuB8v4kDHu
	CyXrqiasCFdV1LWRTIca21zg+apkRRGQCC2GfO+g8btJmcoT6bT+6GCDnuJ5paRmb1c=
X-Gm-Gg: ASbGnctnXe9bIKfQWneRMUwX1HVlo3VR/FSNmZTLYGRJfcQh+D5MmahS2PG1iJqrk65
	h4Kd3HErEjV4wateLBVLOc4SggPvn0wbd0F8zws/MflU9TbO9OLxGHWE4a3Dkr3LLb+/j2uDd6U
	grbzMGHhjgP2JxIkZPEbDLKY2uC7PGSskcZ3nbt/qpNyf+gq6osOVzJZOsSPWYh99lazNwUeuEb
	yTItPJnvsJ/2qL4+B3ys2taAgH+IAu3FG9iCIdGSoMKj7hzpbEQ+pcQOK1INAzpcD9L/o1u6pgN
	rviehnIxqURB650lZUNfg4atxI+fjg2y0Nk/G/b0j5INMADw+Aja3zUABi0eP6mgnKLMwEXMAPV
	97VzzS1yR4wlRqUYSPeIGi6qkx1kfvKkIjA14
X-Google-Smtp-Source: AGHT+IGFXI6bzrMrPoRMAhYisjSnluuvr/OOSlltlBlWMiT0l650MkJrGoqM8KrAt/w/j0aJvDYy4g==
X-Received: by 2002:a05:6870:2406:b0:2d5:2191:c8b3 with SMTP id 586e51a60fabf-2f796dfcf5amr7238271fac.29.1751823227159;
        Sun, 06 Jul 2025 10:33:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29a:290f:4321:4624? ([2600:8803:e7e4:1d00:29a:290f:4321:4624])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f7901a7a23sm1754154fac.23.2025.07.06.10.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 10:33:46 -0700 (PDT)
Message-ID: <c3e6402c-7cfe-45c1-9f28-f131cd94aa05@baylibre.com>
Date: Sun, 6 Jul 2025 12:33:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7173: fix num_slots
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-iio-adc-ad7173-fix-num_slots-on-most-chips-v2-1-a74941609143@baylibre.com>
 <f023c92b-183c-4157-a6eb-ff722dfd716a@baylibre.com>
 <20250706111529.360a3095@jic23-huawei>
 <78342e10-7211-44de-8a92-40872a69b60d@baylibre.com>
 <20250706175725.39e79105@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250706175725.39e79105@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/25 11:57 AM, Jonathan Cameron wrote:
> On Sun, 6 Jul 2025 11:08:06 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/6/25 5:15 AM, Jonathan Cameron wrote:
>>> On Fri, 4 Jul 2025 12:04:04 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   
>>>> On 7/4/25 11:21 AM, David Lechner wrote:  
>>>>> Fix the num_slots value for most chips in the ad7173 driver. The correct
>>>>> value is the number of CHANNELx registers on the chip.
>>>>>
>>>>> In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
>>>>> ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
>>>>> to be static const data instead of being dynamically populated during
>>>>> driver probe. However, there was an existing bug in commit 76a1e6a42802
>>>>> ("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
>>>>> set to the number of CONFIGx registers instead of the number of
>>>>> CHANNELx registers. This bug was partially propagated to the refactored
>>>>> code in that the 16-channel chips were only given 8 slots instead of
>>>>> 16 although we did managed to fix the 8-channel chips and one of the
>>>>> 4-channel chips in that commit. However, we botched two of the 4-channel
>>>>> chips and ended up incorrectly giving them 8 slots during the
>>>>> refactoring.
>>>>>
>>>>> This patch fixes that mistake on the 4-channel chips and also
>>>>> corrects the 16-channel chips to have 16 slots.
>>>>>
>>>>> Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Improve commit message.
>>>>> - Link to v1: https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com
>>>>> ---
>>>>>  drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++++++++++----------
>>>>>  1 file changed, 27 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>>>>> index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..9c197cea11eb955becf4b9b97246379fa9c5da13 100644
>>>>> --- a/drivers/iio/adc/ad7173.c
>>>>> +++ b/drivers/iio/adc/ad7173.c
>>>>> @@ -771,10 +771,27 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
>>>>>  	.num_slots = 8,
>>>>>  };
>>>>>  
>>>>> +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
>>>>> +	.set_channel = ad7173_set_channel,
>>>>> +	.append_status = ad7173_append_status,
>>>>> +	.disable_all = ad7173_disable_all,
>>>>> +	.disable_one = ad7173_disable_one,
>>>>> +	.set_mode = ad7173_set_mode,
>>>>> +	.has_registers = true,
>>>>> +	.has_named_irqs = true,    
>>>>  
>>>>> +	.supports_spi_offload = true,    
>>>>
>>>> Well drat, I was too quick with the update and the bots [1] noticed that
>>>> this conflicts with the in-flight patch that added this field [2].
>>>>
>>>> I guess we can drop this one line, but then the other patch will wait
>>>> until this fix makes its way back into the togreg/testing branches.  
>>>
>>> I'm lost - what would you prefer we do here?  For now I have [2] on my
>>> tree but can drop just that one patch if it unwinds this complexity.  
>>
>> I was hoping you would tell me. :-p
>>
>> In any case, we should apply this patch, with the supports_spi_offload
>> line dropped, first so that it backports cleanly to the stable release(s).
>>
>> But where to apply this patch depends on if you are planning on doing
>> another fixes-togreg this release cycle or not. Or we could just opt
>> to take the slow path to avoid the dependency dance and just apply
>> both patches to iio/togreg and let it make it's way to stable after
>> the next merge cycle.
> 
> I'll almost certainly do another fixes pull, but it might not get into upstream
> of my togreg branch fast enough. 
> 
> For now is just dropping patch 12 from the main series enough to avoid the
> conflict?  If so send me a clean version of this and I'll apply that to the
> fixes-togreg branch and we can hopefully get a round trip to pick up patch 12
> on top of it.

Yes. Drop patch 12 and I will send a new version of both patches. This
one can be applied to fixes and the other can wait.

> 
> Thanks,
> 
> Jonathan
> 
>>
>>>>
>>>> [1]: https://lore.kernel.org/linux-iio/202507050018.iWEJiG04-lkp@intel.com/
>>>> [2]: https://lore.kernel.org/linux-iio/20250701-iio-adc-ad7173-add-spi-offload-support-v3-12-42abb83e3dac@baylibre.com/
>>>>  
>>>>> +	.addr_shift = 0,
>>>>> +	.read_mask = BIT(6),
>>>>> +	.status_ch_mask = GENMASK(3, 0),
>>>>> +	.data_reg = AD7173_REG_DATA,
>>>>> +	.num_resetclks = 64,
>>>>> +	.num_slots = 16,
>>>>> +};
>>>>> +    
>>>>  
>>>   
>>
> 


