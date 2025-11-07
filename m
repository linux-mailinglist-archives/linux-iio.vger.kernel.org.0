Return-Path: <linux-iio+bounces-26017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55346C3FC04
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 12:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB96718923DC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790222D24BF;
	Fri,  7 Nov 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMK24NHU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0E287508
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515380; cv=none; b=nQ/ByfXdou+lCQxX8dOODu/ECe8b8XNGqi5ceZzxAbyoPsIH+PJhJfUXRw+AgKvracgQFgk2ZfnAQjs3UgVh9cNw8ULq0+LaHUdfNko+I5Sc6O6b3aVu/LDcu6Eiq2T8xmNoH0Rvvypnv4WMwPWD945HZ/qOHlHWfYc7C8I8W4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515380; c=relaxed/simple;
	bh=zc7EQnNjmRr1XU6lGykGKLz8scv8SLWTjQFPhZxkdgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKF+e7zJgH+wdL4kRr87WZXheuo2RMSNfo4aq7rs5MIszPROQT86gfI7dvmFeAU8bGkpM5nRMNQu/zjoimU9ni1W8xWAJ2WKN2wWi97HBRT+xc8GYxsHfNlZA1LXSceQZj5rmvdwUrXsB45Dds9xC9JWAVftrKnyCDDv441HFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hMK24NHU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429b72691b4so522851f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 03:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762515376; x=1763120176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JTGRP3Os3ULo6Z7owLq7b27T5LEh91I3qkDXn2bT8s=;
        b=hMK24NHU9ASeLfzpQwXI3mQ8ZPbx7MZzgknsb9/jUcllKOnHSJMpNqq1Gutemwp9DL
         IjTBCWNdyASJ+ZPC5Il0NrujHNNdbHBvUaI2DpY7scAH5L/GrH1H3P9mYQjocu49JrLK
         rfYAsKcMGleMOQVdueBwIlwybFNIwHRzKFSD381oJHW9BEOqPnCEX4V22YOkPSY8+r/o
         j8R932bX3JTTMvFJcbvOV72tDp/JwnhDp3ozgWthc6o81SyfIfvkdmIVc9XvoxPR6dIw
         CEHa5yGtkSgDYxj2TV0qoiJ+7ngzujYV5NoH9cjeZdiDCrElDZK0YSlqA0/R2qSzws7V
         TbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515376; x=1763120176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JTGRP3Os3ULo6Z7owLq7b27T5LEh91I3qkDXn2bT8s=;
        b=DYhBhkeGqbB60R9jL9rki1YUtrLPF1ZEYNi9j3qeAPcqW4rvdVqnOdX/TmLjlxoXU/
         zQTRaVhPkdzPvyrWWLsvnKUct+lK08YWyfK/yyo9Cw7ETqS8X5UanBOsYkV9fwYBEpvC
         H8kbTsWCz9Gu32OgcE4q5txCc8duxpSW/joopxops0FEeczBuSra3OSK235/S60lG/N5
         8Ga9ROFuLU3L90FRkWqF843agHVVuDMbi6G/Bck+MLbVeZ2ZLGfXOlNbAKF2PjENJcij
         bCyrAbuAzyv06U/WLOwEB+XZIuN53lODAfYt64svOs2AN9UMQcO+Mu9zX6W5b6BlCSQF
         /TXA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Fm9raBO4fF9DTYU3BpOtsckUxoQUT8JJIaBnlFrQJtm1KGGbdNStEeihdAy99lwWi7ZnrpVvScs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxy8q4cnL4eHa5vg0zlLGpo+MUTbfzU35+JR8efGRHGdldXZOd
	BbhEBE3Nnl5FHzLTT9MgvLmVv5YRl9s/hZIuoJai4OyzbUIzXJIWlSBGpWWX8eomIHU=
X-Gm-Gg: ASbGncs+D7X7hD4VG5H/7L6arxc2TWxTROnskViWLJ+75cL58wQU7tnafNo5fKqHVqJ
	5RS1h8PhEPzzfxp/arIcEp2ACw7ZCiSSEUcuRwgohWlepu2PFcVQgqpka3hYgEkwQxzNB/OYY1a
	TKcxbTQNKqWVDtyQEy++6qndb2gp8PsLorBw4Xgfy93AXuDCGCpwyrHDAhKDPE0VUA0Dvm/N+/c
	Lf2RmlTyyYnA/q2mn6c4+dmyMiP5ozDF1i2ukBOYJkaBRyuRHWvgr3hR52WTWq9W+AfjIGKY8J2
	/XKffzMOHnYOaxrU8GY3rD7UxG6S/meIxLZ3Vgoq2NARctDPJXcHuHaVOFjLvYx+V5AAK8WmtrM
	wpBwES2JGEqcB9KZXMOqkX3slOnYcTpGUA4xXgs/TY4tkFWsnz7Jk01+iRxYgzBY5gF2WUlgIth
	BrUvkgkoay6XwgzJra8sRu/zKgYur51KcNncC+
X-Google-Smtp-Source: AGHT+IG2dUCqDcfLmg6GQ5lAlXBIqxs9KWH+YNv4QsB30IZJTtg9NVCN7IdyFXcfIOHqLU7l2omYAg==
X-Received: by 2002:a05:6000:184e:b0:429:f0a4:22e with SMTP id ffacd0b85a97d-42ae5ae9b17mr2326856f8f.54.1762515376522;
        Fri, 07 Nov 2025 03:36:16 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm5661874f8f.44.2025.11.07.03.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 03:36:16 -0800 (PST)
Message-ID: <d783184f-6598-479a-99f3-e142e83bbb81@linaro.org>
Date: Fri, 7 Nov 2025 12:36:14 +0100
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
 ghennadi.procopciuc@oss.nxp.com
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
> 

I'll use the new callback function dma_async_tx_callback_result() which 
should prevent that and allows to remove the spinlock at the same time


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

