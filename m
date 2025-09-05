Return-Path: <linux-iio+bounces-23764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66706B453A7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B89BA46416
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5410283FC5;
	Fri,  5 Sep 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiTfp4+Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5627C17F
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065488; cv=none; b=isthpg47ukSSH7k+GJWvgM7nP9u8gMXvAgcmSF8xq/uqOCSr4N5lRMh2EYgVY+cld18+0aFGmXP5E49oiZqQ6+4NTjt1Wu/evytMKOSTm7aKIte1/IE/l46uBq2WdcxAa+YQyRMZWhNoY/cBAfZw52Cxpal6qXGPbem3WP0Q5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065488; c=relaxed/simple;
	bh=6rMxYhDmqs/v7kj6WGuLgYVPHayU1LenJFACJct8AbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bkj509QPPYPb4PgjhILTnAOB7buRQ3YtZYN0vzdohbZQ6PHK2usW8At3ODOHufbESYiuIdBbm5PL9pvYIkYB0F3FqJeybV94xTfX/mv28f2IHwV/PgOINEfEkq3KV45Mp3MJMKbuEVyVNpUv2zDU5ENBtxfX0mfup7gLS8n1Q/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xiTfp4+Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e46fac8421so241215f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757065485; x=1757670285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vg+TuI+bOQ+/K0B+1sySJ2VK4abRlS/VZd6mZadbe2g=;
        b=xiTfp4+YeasCu5odA010ly5KiKT9EEKcqYRTXMkgiaKb/FCblnUNXhZ0JhJ68h2n6a
         auuNVTjrRc/Ml9aIGBk+/Vkdwe3czPSBbuLJvBsAKrqqcK2sT8Vduyb5CIiWMfWCXR3H
         60SkkMbFQguQbuwydon7K7ZSTRQeigsdfwXkLPxGyQWrZe2tBdzE+IoBGTJLoTyT7czm
         J11wjX7fs4eu4QYyFNnyEPAShVwEwMpddAdN6eY0SJ+TORjvA8BKzXuQEO2taS8IATjN
         g7DdrKYdOrhCzcNh6H8JCxAIaKpl/VtjGeZviTetgBWQOyzLTerjXQTTZC/Ju2J7dVsi
         3DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065485; x=1757670285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg+TuI+bOQ+/K0B+1sySJ2VK4abRlS/VZd6mZadbe2g=;
        b=kqtgrHWVwvs1X9nF7qv6Bm38H4U8q1XBVtZEL+Cr9w/042EuXKR2PE/Ydzw+s+ENPV
         9OTgldrJzVzOkU6P5CpgetdhGq1PdVuzUOgTXosRBrsgt0CBzJ4nchOwi7V4ITlHPI1k
         r0lJIgE+UBPSir+4J2H36KkTUe0ig3cMqAs1jPBUI6cnFS7qkl5exYB2yHvTyX6WLXOg
         kQkwRAdgIS7aSV9VNVpNUKOwsNicerOmnekTYkE5m1/2FUCvrjZKWj8BL/aTLObDg2yG
         8oGG79BzupwZFSrJZEX9x8jSR/FOD8O51Bfz4kqq98K8XGv5/RG4JZ8knractoes7rHm
         yUhQ==
X-Gm-Message-State: AOJu0YwfNw7ey8Ke3A+qYFAkujnycaBVgqOZ1dJbLVj+6kguvfKprNm7
	ANyvRW8sHDic26pgn7hVQP0A55nO2q6BXmaQoK0V2MZqkw3MROd9TTHSqvsT1YCcHrE=
X-Gm-Gg: ASbGncvg9ze5UN0ql+PwxH2LgJTkuDRoiXN2eybBMLiq+DV710bKd5SW0xxYUhDqagM
	2Go0aadjyU534TD1/ML1txy3EEerK29utVYZt5EJ7d78CJkbLUAlnX5Y78QYT2sNAMLpgIrsynV
	g9AERnmUtUFKac0ld9k48/vEVaP2pVIlxi1ev0IP321Vo1r7obWX0lm3SRMAPyQdSusvH2j7VUr
	odxKJe3ziS9jJJ1CQeoey2Y2hcKIfTCLiBbYU9yuytXEpbKGoCfp3IF0KB/2EwHRUitRDzAuGPY
	sjfFTyB/HP4HpXpgoQBzn3DEGb50QsQ67qPaLCb1rOOGiHyBCgGs/zh/zgW5SPxxrW3je8CNCEf
	AKqyhXT26D0ngmnvxmhWxY6T1d8lvpYxRtiPCHyJf8iWz/0R7cFDjwb8xt1TvVytFpoqkeCxmrh
	h9on0BKuYSPVpt
X-Google-Smtp-Source: AGHT+IFodgj442lDLbVLMi4njhpRzF0c5s/MBO2AX5hxfzUKZQkDG+LP5IKBwiCAYGAM+uTD1n1Odw==
X-Received: by 2002:a05:6000:250d:b0:3d6:b35b:153b with SMTP id ffacd0b85a97d-3d6b35b2262mr15384906f8f.26.1757065485080;
        Fri, 05 Sep 2025 02:44:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:43b0:7b3b:e0d9:6992? ([2a05:6e02:1041:c10:43b0:7b3b:e0d9:6992])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e2f6af9791sm2928315f8f.26.2025.09.05.02.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 02:44:44 -0700 (PDT)
Message-ID: <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
Date: Fri, 5 Sep 2025 11:44:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2025 19:49, David Lechner wrote:
> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
>>
>> Hi Nuno,
>>
>> On 03/09/2025 13:20, Nuno Sá wrote:
>>> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
>>>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>>>
>>>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>>>> register (SAR) ADC. Two instances are available, each providing 8
>>>> multiplexed input channels with 12-bit resolution. The conversion rate
>>>> is up to 1 Msps depending on the configuration and sampling window.
>>>>
>>>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>>>> in both single-shot and continuous conversion modes, with optional
>>>> hardware triggering through the cross-trigger unit (CTU) or external
>>>> events. An internal prescaler allows adjusting the sampling clock,
>>>> while per-channel programmable sampling times provide fine-grained
>>>> trade-offs between accuracy and latency. Automatic calibration is
>>>> performed at probe time to minimize offset and gain errors.
>>>>
>>>> The driver is derived from the BSP implementation and has been partly
>>>> rewritten to comply with upstream requirements. For this reason, all
>>>> contributors are listed as co-developers, while the author refers to
>>>> the initial BSP driver file creator.
>>>>
>>>> All modes have been validated on the S32G274-RDB2 platform using an
>>>> externally generated square wave captured by the ADC. Tests covered
>>>> buffered streaming via IIO, trigger synchronization, and accuracy
>>>> verification against a precision laboratory signal source.
>>>>
>>>> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>>> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>>> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>
>> [ ... ]
>>
>>> The above needs some discussion at the very least. Have you considered the IIO
>>> DMA buffer interface? It should be extendable to accommodate any particularity
>>> of your usecase (or we should at least discuss it).
>>>
>>> With it, you also gain a userspace interface where you can actually share DMA
>>> buffers in a zero copy fashion. You can also share these buffers with USB
>>> gadgets. For instance, with libiio, you would be able to fetch samples from your
>>> host machine (through USB) in a very fast way (zero copy between IIO and USB).
>>>
>>> Setting up DMA to then "having" to push it to a SW buffer and needing a syscall
>>> to retrieve the data seems counter-productive.
>>
>> I've read a bit about the DMA engine. It is unclear how to use it and there are very few examples in the different drivers to refer to.
>>
>> This proposed driver supports the RAW, BUFFER and TRIGGERED.
>>
>> Shall I create an IIO device with the modes:
>>
>> indio_dev->modes =
>>      INDIO_DIRECT_MODE |
> 
> Only INDIO_DIRECT_MODE needs to be set here.
> 
>>      INDIO_BUFFER_HARDWARE |
>>      INDIO_BUFFER_TRIGGERED
>>
>> And then use:
>>
>> devm_iio_triggered_buffer_setup()
> 
> Yes, use this and it will add INDIO_BUFFER_TRIGGERED to the flags.
> 
>>
>> and
>>
>> devm_iio_dmaengine_buffer_setup_with_handle
> 
> Likewise, this will add INDIO_BUFFER_HARDWARE.
> 
> And you likely only need to call devm_iio_dmaengine_buffer_setup() which will
> save some boilerplate code.

What is still unclear for me is the trigger and the dma modes.

If the dma engine is supported, I should use 
devm_iio_dmaengine_buffer_setup_with_handle(), but will the trigger mode 
be supported also automatically (I don't see a clear answer in the 
documentation neither in the drivers) ?

If not, shall I call devm_iio_triggered_buffer_setup() and 
devm_iio_dmaengine_buffer_setup_with_handle() ?






-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

