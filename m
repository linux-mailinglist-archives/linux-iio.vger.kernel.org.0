Return-Path: <linux-iio+bounces-26287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F010DC69CE6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E319B2B725
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2F35CB80;
	Tue, 18 Nov 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GC/MRswZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4035C1BB
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474266; cv=none; b=PVIeyUGVs0/EwLk645QKQbHBhn4x5eZ4fsh99mni44QruWLROeK0wtGnxfSyG+sZa/TlBH0ua0HGVdPcCo6smIpBw9fhsRPDAReUfwX8fNkhNeLmzGd00DmUuT/l++qiR3atisxuUYowztAZGLIpcB2040fVDbUyInqqt3kmttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474266; c=relaxed/simple;
	bh=mfMgEPem+bHdCW32SziEJw133LN6fYuGSmC870ikt8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nottOQQp8UGbQ/smetCAdyIO9MnYWFjOFcstBlTj9+CF2tQ3bHYFiSoRWpMwoS8DmAomquSLZcb2yk/Qo4MxzPlwkGldD6+VFd7xh46wYKRRdgJmQaYAd1N8tuXZkcFQPuQcTmqNXc9koLnN/duyukSusXrZ5yqSNgcfLV7qhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GC/MRswZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47796a837c7so20891925e9.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763474262; x=1764079062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUDZ4lylaMkBQy9BPqNgegQrO9kWuZYea7qf7A3b2LY=;
        b=GC/MRswZcBaqLBUZI42NmlIMRt8m1+kqjMzSYRp/vGIwLdk4VT9YAhhFki3sgYhm+W
         7MQVjmuUJQ1ez34bK5mLygiDm7A8dwn+hVGnbO2YjIAcFPlU7+W8xgQFPW7rjaMDaNkU
         r+Sk6lzg/k1I4q9jygJNZWo20NQvvNK/bhMHPNMg5KjBCzBUzinQnzlrmTHOluMtAiPh
         NOmzC/oRCgpT/56bJ7zDSDFpOMUaU2Ix2yn0C6+2pV70QGS+pFT7biLv+lICiEgdDAnT
         DTD4scazP+3d/b181e4SikN9AQAfjJpSQPTKLLLDqR6hEppqFZxJheA851yByUyrYQwz
         soAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474262; x=1764079062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUDZ4lylaMkBQy9BPqNgegQrO9kWuZYea7qf7A3b2LY=;
        b=Il4C2gh7n9ZkKTMQnc69o1d3f1w52n1WBhZWypMEbsTE8DCdDofUL1HgXz04RmYVk0
         PAxD5vpUBcIrHn3vsLAJzIxC4Z/8tkEBCndurFdQkK4Teg74Bw53LkHvW6x9uALN5xKU
         0RNAS47o54L5slK4s1mg3mIBQA6XPVFlwmQPMudkps7QQ8hWpszt7scSV3oAsYplD8hz
         AXeFDEM6+fBiyd57ruRBdrT9Y1jFHw5dsFo0H/hzd+vwFtWCZG3GbQmvmOTlvts8ijpi
         2EZphTANHjCSXstxB/zdicsXgQsjc1Oy68DbS9EEmiXQaQvQXlO3E3bimUXgn2gU3v8B
         RFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJQ3z0QC7nDSEzXszIvxWv3oEL62luNMAc3T7UjqXfQeyT+gOWBuNnFL8LCRiHFN8IWhYH6HwTqtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXe+vHA2LUKleqlEmoNAIQFe4YgZ68fspHKbT2dSl+ta3C0VA
	6bS1xTQyJE4vrUka9tScnXS6v5YkIM+ja+P04vT1uE7LFB66gnpJV3rfvJggQy5dwM0=
X-Gm-Gg: ASbGncvluuqLJJWkocvuVwI2f6zWBS0ZvOz654FgAdbk4JAuinzA8SSB0BUUnIsw6RY
	56UYp+ocQV+BvlC8jiw+pi07jwFK45p65ufMYjIjQa1UWMRtsBMr4uptBYWFVdIPRhVYgKvuciK
	9c3JkRXWC2K6GF/4CJJrOBaonQCop+lYnz4eXjY3/TnyHJmywpkKgsbZ7H2fgIpTcQKD6xlMEme
	zPkV2oN6m36f0M+m8jU2mniLO2NdQqvOL9OnMfFg5TNm23RS6oAX3fheeHYWZvSuvGdRQ5RIt9I
	OigyKvdL/6GEc18G20MD+12RsD4uN4hHkptwNuMzlvCGnHz8ro8zWKsH0UjC27ZZS9kkpH3kr/X
	M8CPmNzz4z+te09qrE3mr37wFKIsgO0LIZgCZIq/AOP0X5+t9w2NkZGwnau66ZRxK87ckdPOUmD
	3z/QpxKxiyXmOvqD1AhG50HEMgqhCDXLR87cJaGbm9lM4h6GHF5Gbk4N5B7MYfN8SsWg==
X-Google-Smtp-Source: AGHT+IG9vP9ywNhwcCVn9uZYhtMtnoVY99ke6nSnOYKsVre1wo2fJQ2gXlVy6Kn/osQqy7PyWirVeQ==
X-Received: by 2002:a05:600c:4585:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4778feaa7f5mr130859165e9.25.1763474262494;
        Tue, 18 Nov 2025 05:57:42 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:3006:e9fd:4de4:66f6? ([2a05:6e02:1041:c10:3006:e9fd:4de4:66f6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47787e36ca3sm393988575e9.5.2025.11.18.05.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 05:57:42 -0800 (PST)
Message-ID: <bb985484-dc67-42ba-bbc4-94bab89f72b1@linaro.org>
Date: Tue, 18 Nov 2025 14:57:41 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, Vinod Koul <vinod.koul@linaro.org>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
 <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
 <aQMvqHGN7r6babgw@smile.fi.intel.com>
 <c4c14051-2ba2-4d80-a22d-4deb3709f727@linaro.org>
 <aQSvZT73NBWZFVfk@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aQSvZT73NBWZFVfk@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Andy,

On 10/31/25 13:45, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 12:32:03PM +0100, Daniel Lezcano wrote:
>> On 10/30/25 10:28, Andy Shevchenko wrote:
>>> On Thu, Oct 30, 2025 at 09:27:21AM +0100, Daniel Lezcano wrote:
>>>> On 10/18/25 22:12, Andy Shevchenko wrote:
>>>>> On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:
> 
> [ ... ]
> 
>>>>>> +	dma_samples = (u32 *)dma_buf->buf;
>>>>>
>>>>> Is it aligned properly for this type of casting?
>>>>
>>>> TBH, I don't know the answer :/
>>>>
>>>> How can I check that ?
>>>
>>> Is buf defined as a pointer to u32 / int or bigger? or is it just byte buffer?
>>> If the latter, how does the address of it being formed? Does it come from a heap
>>> (memory allocator)? If yes, we are fine, as this is usually the case for all
>>> (k)malloc'ed memory.
>>
>> buf is a byte buffer allocated with dmam_alloc_coherent(..., GFP_KERNEL)
> 
> We are fine :-)
> 
> ...
> 
>>>>>> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
>>>>>
>>>>> No return value check?
>>>>
>>>> The return value is not necessary here because the caller of the callback
>>>> will check with dma_submit_error() in case of error which covers the
>>>> DMA_ERROR case and the other cases are not useful because the residue is
>>>> taken into account right after.
>>>
>>> In some cases it might return DMA_PAUSE (and actually this is the correct way
>>> to get residue, one needs to pause the channel to read it, otherwise it will
>>> give outdated / incorrect information).
>>
>> But if the residue is checked in the callback routine without checking
>> DMA_PAUSED, the result is the same no ?
> 
> DMA in some corner cases might have already be charged for the next transfer.
> Do you have a synchronisation between DMA start and residue check?
> 
> I.o.w. this may work for your case, but in general it's not guaranteed. The proper
> read of residue is to: pause DMA --> read residue --> resume DMA.

I discussed with Vinod about this change and he suggested to use the 
callback_result() to get the residue as a parameter so the 
dmaengine_txstatus() call won't be needed anymore.

Unfortunately, it does not work. I had a look in the DMA driver and the 
internals but my knowledge is limited in this area so I was unable to 
find out what is going on. Moreover there are no so many driver using 
this API I can use as an example. The best I was able to do was 
propagating the residue to the result in the vchan_complete() but it 
does not work.

Then I stepped back by not using the callback_result() and used 
dmaengine_pause(), read the residue, dmaengine_resume() but there are no 
result after these calls. I don't know why.

The issue you are mentioning above should be handled in other drivers 
doing the same kind of acquisition but the routine is similar to the one 
proposed here (eg. stm32).

The NXP SAR acquisition routine is running since several years in 
production AFAICT.

I investigated the different solutions without success, while I can run 
the acquisition routine without problem here with my hardware. A signal 
generator captured by the ADC, plotted and compared with the 
oscilloscope display.

The circ buffer is working well here and no bug was spotted with the 
current routine. I think I did my best to make the driver better from 
its initial submission. The best is the enemy of the good, and I would 
like to make some progress here in the driver acceptance. Changing the 
entire driver for the sake of replacing the circ_buffer by the kfifo and 
change the code for a scenario which is not happening is not really 
worth. Especially that the DMA engine is being modified to take into the 
cyclic DMA in its API, thus the circ_buffer and the routine will go away 
once the driver is changed to take into account this new API.

IOW, can we keep this routine as it is for now as it works fine and go 
forward for a v6 ?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

