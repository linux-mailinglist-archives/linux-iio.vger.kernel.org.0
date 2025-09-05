Return-Path: <linux-iio+bounces-23784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3BCB45C74
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6750118924FC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D139823BF96;
	Fri,  5 Sep 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ogLX0mUj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078431B837
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085910; cv=none; b=CRE3KLphUm4BevF/PPCmroSm2IzasvLANdHV0G6mDn5k/gNqTmrNnVzfD+RdbCMQ4AsjCTpfTSH0ZE4Y0dHrfvs+2aRB8fST5RyYClM/zEH/AUOTA5VeGnu8C9eqlOzoYjztvYozrTGPd4mC8xVjrBtF4k40RRoqmBACbJ6L5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085910; c=relaxed/simple;
	bh=pCssCAZOfH3pEc83kPgsxuJYzG6xdafoVP+lGf4sCEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEmKqXoIfzeogc+KItbvqQGM3IVGo5uZitAHQ9dKRQ7GMon1D+UCoJ53sXFtwSfH1nLrGArewFFzuAiNeY0mj4eHU8bVjMoPluliKjoJL9tWn1gMxWlKvWD7MMlKXwQLGLpUlq5lqAy7ii71X1Ypv55lsJmUtuDdoEY03cpQAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ogLX0mUj; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61bd4ba9fafso1106001eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757085907; x=1757690707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pohUBiCn9QjRHZYLkhaWb0quU2GyqpyHJzVGv2GHYcA=;
        b=ogLX0mUjwowMXrCzMi+WwIeF88F5mgEEtnHPqP/ioSCwpjBN1TEmwqFNmaOkymc8HI
         gCmU8uQMwQujUOOFWOj6Ut/gv04cw/f4h8Z2Zczgo73LXBczMlbWiiqc6CQ4RzAYRLUg
         QykGZYZgKr+PR8aBrWp2KUsaJ3wrY5ejJMksW4Pt3uHx1uf0NtoeOFZvVV0vh/N5cILw
         eJVu+9N8XcTbIUgJ8fnS9v0eet+koV3vLapt2owGggM/T2/gSAVYDw5y/22jCA7UaNEH
         gJI90q3a9qSJbiSXgdoA0xdYxfJImyEtLyrs3wAcKI8GpoQiCVhG7vDLzCTvMkRo4q7F
         zhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085907; x=1757690707;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pohUBiCn9QjRHZYLkhaWb0quU2GyqpyHJzVGv2GHYcA=;
        b=bqYZZgiX7LlmzQo5YVc9TjkRH4Hv7xHVA79jjAly3vkjDmnFymhGexqtk8rDy17Jvc
         iY7P7UN48wJPMe9dOO3kvLIzty/jxenRIdOfhDBI+QSzyKQjubyYO7hA7XT4z+bLZzkt
         ZlORCBgPo9HBmzn/junm3Bya60MBCjQk8z4eQ3yZwOImejb1WaAMoHevgsjE/Ic7wIx0
         UCoqESANyWu8KeEdqf23f3p76DJIkY+JGK4JYULkyAqeSmIOQEYYT8TlAhryScpvFqIK
         ZAnMBV+URfqJsK1GO7C32Vk53TEUMXpU8iyuLoZPkTsx9Heb53DK8nTOR24W2wVTs8GT
         WITA==
X-Gm-Message-State: AOJu0YwZXbdp7lCLqItXX06u1PXc/lb3Fv938iALWCw4bDDi7eXJqIor
	N6JW2sCFWVXWmCKoLifNrWxzVNszYvQQUQPtCoGhv962m39T3y943p+JIhCh5X3J3JjaXHiOvEd
	sTi1R
X-Gm-Gg: ASbGncuI86XSdgrkfHO5uMoRmz6H4WHnzkUkdDZInPn3pUe7xVL/lo5ehImcoxvgp1T
	RrtM+R8SajtB5VXPJTWNDvbzua0EIgJT7md4nYlB0Y5/n6fP20fF0EwHa2JWNU4la3VZJlmdE2k
	nemR9M6WjMz3Wm8OeIujkCRA2iiNm7vwwG4E9F/clfU1rNwiqXipCBK4+GSsCNPN68VeeSismrY
	Kn0jFi+OefZMxBAk502fOFdibEiuxh0W066KFo+0GNh3Z2ExZlLXnlNKl829f6RjTnwXH9Y4yAE
	YqZNPk4p/TP/3ky45I/Pz6UjHj5I7DyzrrSb3FseqYSmQcXFntaODFuSGqPq2s72tTLFzkU55iQ
	KWz36SeVUkuaLosSnIyBSo42BYpGsGFVvwNX2IrQLglPvgVMWH1KRDSdLOCDasvu72BLOokHbWY
	90UNITcsM=
X-Google-Smtp-Source: AGHT+IEECzwl36a34ODawpMXccaR6JC9vsf6ijMfXMcknrv5Cxp2H7YtBDDER3SuB4FaTQgxiA3cVw==
X-Received: by 2002:a05:6820:1ad5:b0:621:72dc:3df7 with SMTP id 006d021491bc7-62172dc404cmr617151eaf.0.1757085907222;
        Fri, 05 Sep 2025 08:25:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61e723d320asm1178110eaf.18.2025.09.05.08.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:25:06 -0700 (PDT)
Message-ID: <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
Date: Fri, 5 Sep 2025 10:25:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
 <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/25 4:44 AM, Daniel Lezcano wrote:
> On 04/09/2025 19:49, David Lechner wrote:
>> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
>>>
>>> Hi Nuno,
>>>
>>> On 03/09/2025 13:20, Nuno Sá wrote:
>>>> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
>>>>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>>>>
>>>>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>>>>> register (SAR) ADC. Two instances are available, each providing 8
>>>>> multiplexed input channels with 12-bit resolution. The conversion rate
>>>>> is up to 1 Msps depending on the configuration and sampling window.
>>>>>
>>>>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>>>>> in both single-shot and continuous conversion modes, with optional
>>>>> hardware triggering through the cross-trigger unit (CTU) or external
>>>>> events. An internal prescaler allows adjusting the sampling clock,
>>>>> while per-channel programmable sampling times provide fine-grained
>>>>> trade-offs between accuracy and latency. Automatic calibration is
>>>>> performed at probe time to minimize offset and gain errors.
>>>>>
>>>>> The driver is derived from the BSP implementation and has been partly
>>>>> rewritten to comply with upstream requirements. For this reason, all
>>>>> contributors are listed as co-developers, while the author refers to
>>>>> the initial BSP driver file creator.
>>>>>
>>>>> All modes have been validated on the S32G274-RDB2 platform using an
>>>>> externally generated square wave captured by the ADC. Tests covered
>>>>> buffered streaming via IIO, trigger synchronization, and accuracy
>>>>> verification against a precision laboratory signal source.
>>>>>
>>>>> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>>>> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>>>> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>>> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>>>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>>>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>>>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>
>>> [ ... ]
>>>
>>>> The above needs some discussion at the very least. Have you considered the IIO
>>>> DMA buffer interface? It should be extendable to accommodate any particularity
>>>> of your usecase (or we should at least discuss it).
>>>>
>>>> With it, you also gain a userspace interface where you can actually share DMA
>>>> buffers in a zero copy fashion. You can also share these buffers with USB
>>>> gadgets. For instance, with libiio, you would be able to fetch samples from your
>>>> host machine (through USB) in a very fast way (zero copy between IIO and USB).
>>>>
>>>> Setting up DMA to then "having" to push it to a SW buffer and needing a syscall
>>>> to retrieve the data seems counter-productive.
>>>
>>> I've read a bit about the DMA engine. It is unclear how to use it and there are very few examples in the different drivers to refer to.
>>>
>>> This proposed driver supports the RAW, BUFFER and TRIGGERED.
>>>
>>> Shall I create an IIO device with the modes:
>>>
>>> indio_dev->modes =
>>>      INDIO_DIRECT_MODE |
>>
>> Only INDIO_DIRECT_MODE needs to be set here.
>>
>>>      INDIO_BUFFER_HARDWARE |
>>>      INDIO_BUFFER_TRIGGERED
>>>
>>> And then use:
>>>
>>> devm_iio_triggered_buffer_setup()
>>
>> Yes, use this and it will add INDIO_BUFFER_TRIGGERED to the flags.
>>
>>>
>>> and
>>>
>>> devm_iio_dmaengine_buffer_setup_with_handle
>>
>> Likewise, this will add INDIO_BUFFER_HARDWARE.
>>
>> And you likely only need to call devm_iio_dmaengine_buffer_setup() which will
>> save some boilerplate code.
> 
> What is still unclear for me is the trigger and the dma modes.
> 
> If the dma engine is supported, I should use devm_iio_dmaengine_buffer_setup_with_handle(), but will the trigger mode be supported also automatically (I don't see a clear answer in the documentation neither in the drivers) ?
> 
> If not, shall I call devm_iio_triggered_buffer_setup() and devm_iio_dmaengine_buffer_setup_with_handle() ?
> 

Taking a step back, what sort of real-world uses cases do you need to support?
Or are you just trying to implement everything that the ADC can do? The latter
can be a bit risky because you might end making something where you can't do
a buffered read and a single channel read at the same time, but later find out
you have a real-world application that needs to do this.

It looks like it would be possible to implement buffered reads in lots of ways.
IIO devices can have more than one buffer per device so we can add more in the
future if we need to. So I would just drop the DMA part of the implementation
for now and implement the basic triggered buffer using MCR[NSTART] and ECH
(End of Chain) interrupt request and just reading data from the ICDR registers.

I would wait to have a real-world application that requires DMA to decide the
best way to implement that. There are lots of possibilities, like does it need
an external trigger or is continuous mode good enough? Does it need to be cyclic
(something the IIO subsystem doesn't really support yet) or not. Is exact sample
timing important or do we just need a big buffer? These questions we can't
really answer without a specific application to use it.


