Return-Path: <linux-iio+bounces-21400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B5AFA64D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35A23B53D5
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671612877CD;
	Sun,  6 Jul 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q156y9wE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4152CCC0
	for <linux-iio@vger.kernel.org>; Sun,  6 Jul 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818092; cv=none; b=QFo7xpxWKDg4PJ7yhV0M5j8YVpZuIxyZ1VRLMPlmex6KPJMt0mx7xu9EGLYo6iofgzNEqmHak3v6aj7ta0Xc4IiFAssb3gHru3Ewx4JvVyfsJ9u0aX/Wypld9ErXhdIAhmQI9OQUsG1sqjW62GvT2sWqkzk7uMCm9e6/J4E8NDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818092; c=relaxed/simple;
	bh=m2P05b7f+RnhHST+hGm5MW1rRAKUBxgpynsySS/Ybzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtlsWDbluHbQq+hR7WLZ2Vys860K2fVctNTBS2xSfH2cuzLCKcx5vHgVOSp/e8RGZnDYK13pcu6TGye51BXoVe0Rmsu/ZVrl7TLi+s4VEORsva5O0fQ6Ats/yZFz8WcBSjpqX6aYAuBWAs+R1do7fhzg4b/uag7P1jJXXTwIavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q156y9wE; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6113e68da82so1262890eaf.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Jul 2025 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751818088; x=1752422888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHGQkqiwnQSHiVoFPqj0gMTlpD+iiYU94AHxqO2NnS0=;
        b=q156y9wEfoPYI88j+YQjIIpxHtWADk/Ka5b44eNm6onCJK3J8g0LdsJigCh3QnORuP
         6NyoJfIQxyEMiMOgPGd7vp91IYh/omtjf8G3ipGGNo4h1oA3OK6kLdcaMCQDIStOkh47
         7ocb+u/O2022esOYpCM0pIebr/13lRk3nDJ848DJnlYAAkHdBFA5P3NUsTZ2YMjSTqqp
         Kg/bNkAT4cm7nnPQ2VnncBN2/oKTxkGb97vZvf48Bn0shy+DQlabiUWuknKliw+Vsp0b
         OZuqZrK4yPZiqXU/c7ktLGRp5PsCCmtJVGNrnQ9xloQ5cFKA7R7QuxdlR9IAVQ7ryVNO
         k1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751818088; x=1752422888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHGQkqiwnQSHiVoFPqj0gMTlpD+iiYU94AHxqO2NnS0=;
        b=BWw0zeKncwO0Y7adHN47uq777Vw+ZhNAQf4fbdRXFO3+tkJ2XqU5NdqvNt5QVLVcOc
         n7vQrMLPi0tY4Tm9Nwckfz6K5KQh2F1tge2EyFaygaPjuXiu1JaEtJovnOM+ty1Ol/Xp
         kDNYIuM0IP/LwNFprV6HQ6y8lgcdtUTFDTznFXDRVxJt/xPMvpVdQ+10UHqbvHG1Wixk
         UCpH1z5zvoqEW63ZFzxGyAtHabqrAeGPXLl7Muz9TlCUFQKFTf5RCBUi1LheB1PtPbRY
         CcV58EAqqyXNGPyFzWIMVRNOooPNq1xsiXByY+72WP9qnj05EMXPNMhnXTj6rA//tjXf
         KBpA==
X-Forwarded-Encrypted: i=1; AJvYcCVMnkMIaCECVygZ7IjzJ7KIyfz4TQo0UV+D3AKm39zJp0vvmkfkEkQIX3Kw/xoS/B1OuHkPUD5yMTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHe946LFyjz/iiwthBzQ+ofygMho44pOCQD4631HC2jkwEA8kg
	BukAvB/SHYDsev+QG5uiQKmKSCpV40VhAP9FLTqVAGiWyJxiBEPu65No8l6frZJKEJ4=
X-Gm-Gg: ASbGncv+az8UBpcELsaDhGW6DfJqEaotTdWMqzZVNF3qAo5VSxxOIWo3L2tLATc42Hi
	CuhPqhNw63zZNofbracLgE3wvj8qzmAU9KPRak04DxL09h2m6oSDQJ96v5SC0FLhCM/YZaNqDzL
	jwWyODNrg2LPYOyN4aJnRCCzzQEDcmsIimux679rSyzqpW9JVZUVkTceto2FgZwV7map2CtlKzS
	5eQI8rLL+/9NTYgdCM+fjrP3dkA1MNWGeyFuVZRTYG/mEx7eX7alSuG+lzgPNQqYfA0zLz/sK+p
	AchNdQL4nR3pLoOQGtvwmf2y4p2pSIvXcEykv+XLNsxe1mL6QNQE7Qgys3ngO1ha9OODNPm8K8o
	7nQwSUMmOWABby69EwJtx5NzxqLPdviluTVg+
X-Google-Smtp-Source: AGHT+IFibN5etCJU6rb1ylqBk8XweggyERdFs8RllNgfLgWJSWehX2tdvKIukg3/0VvTTCkslckDQw==
X-Received: by 2002:a05:6820:1e06:b0:611:bbad:7b62 with SMTP id 006d021491bc7-613a007a7aamr4697019eaf.3.1751818088301;
        Sun, 06 Jul 2025 09:08:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29a:290f:4321:4624? ([2600:8803:e7e4:1d00:29a:290f:4321:4624])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6138e5ab33dsm1019817eaf.28.2025.07.06.09.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 09:08:06 -0700 (PDT)
Message-ID: <78342e10-7211-44de-8a92-40872a69b60d@baylibre.com>
Date: Sun, 6 Jul 2025 11:08:06 -0500
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250706111529.360a3095@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/25 5:15 AM, Jonathan Cameron wrote:
> On Fri, 4 Jul 2025 12:04:04 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/4/25 11:21 AM, David Lechner wrote:
>>> Fix the num_slots value for most chips in the ad7173 driver. The correct
>>> value is the number of CHANNELx registers on the chip.
>>>
>>> In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
>>> ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
>>> to be static const data instead of being dynamically populated during
>>> driver probe. However, there was an existing bug in commit 76a1e6a42802
>>> ("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
>>> set to the number of CONFIGx registers instead of the number of
>>> CHANNELx registers. This bug was partially propagated to the refactored
>>> code in that the 16-channel chips were only given 8 slots instead of
>>> 16 although we did managed to fix the 8-channel chips and one of the
>>> 4-channel chips in that commit. However, we botched two of the 4-channel
>>> chips and ended up incorrectly giving them 8 slots during the
>>> refactoring.
>>>
>>> This patch fixes that mistake on the 4-channel chips and also
>>> corrects the 16-channel chips to have 16 slots.
>>>
>>> Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>> Changes in v2:
>>> - Improve commit message.
>>> - Link to v1: https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com
>>> ---
>>>  drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++++++++++----------
>>>  1 file changed, 27 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>>> index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..9c197cea11eb955becf4b9b97246379fa9c5da13 100644
>>> --- a/drivers/iio/adc/ad7173.c
>>> +++ b/drivers/iio/adc/ad7173.c
>>> @@ -771,10 +771,27 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
>>>  	.num_slots = 8,
>>>  };
>>>  
>>> +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
>>> +	.set_channel = ad7173_set_channel,
>>> +	.append_status = ad7173_append_status,
>>> +	.disable_all = ad7173_disable_all,
>>> +	.disable_one = ad7173_disable_one,
>>> +	.set_mode = ad7173_set_mode,
>>> +	.has_registers = true,
>>> +	.has_named_irqs = true,  
>>
>>> +	.supports_spi_offload = true,  
>>
>> Well drat, I was too quick with the update and the bots [1] noticed that
>> this conflicts with the in-flight patch that added this field [2].
>>
>> I guess we can drop this one line, but then the other patch will wait
>> until this fix makes its way back into the togreg/testing branches.
> 
> I'm lost - what would you prefer we do here?  For now I have [2] on my
> tree but can drop just that one patch if it unwinds this complexity.

I was hoping you would tell me. :-p

In any case, we should apply this patch, with the supports_spi_offload
line dropped, first so that it backports cleanly to the stable release(s).

But where to apply this patch depends on if you are planning on doing
another fixes-togreg this release cycle or not. Or we could just opt
to take the slow path to avoid the dependency dance and just apply
both patches to iio/togreg and let it make it's way to stable after
the next merge cycle.

>>
>> [1]: https://lore.kernel.org/linux-iio/202507050018.iWEJiG04-lkp@intel.com/
>> [2]: https://lore.kernel.org/linux-iio/20250701-iio-adc-ad7173-add-spi-offload-support-v3-12-42abb83e3dac@baylibre.com/
>>
>>> +	.addr_shift = 0,
>>> +	.read_mask = BIT(6),
>>> +	.status_ch_mask = GENMASK(3, 0),
>>> +	.data_reg = AD7173_REG_DATA,
>>> +	.num_resetclks = 64,
>>> +	.num_slots = 16,
>>> +};
>>> +  
>>
> 


