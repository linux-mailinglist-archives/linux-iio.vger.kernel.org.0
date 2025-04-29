Return-Path: <linux-iio+bounces-18876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2FBAA1B77
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE16A4C56CF
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7725A2BA;
	Tue, 29 Apr 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gdesoaGn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27A22A7ED
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956066; cv=none; b=febCW7GRtboedgy8KVfso956rbwuznfglsrx8t76rW+fP4pYvpR4Thg2aB9LPjqc0zvG7nau82zp2Lhyx6L6/q6V9XiveT4ZS9rd7nBdasjrKccvzw7V/ichmqnen8x44oM/6XUtMV9xpQzYWYqbxDhVpIeEqp6gYlW+D97U0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956066; c=relaxed/simple;
	bh=ugjyf/jMyKKt/zcQVDlLaFsLZEJxdrKZne7xK3f5sUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pd7qhwr5ZlTLFdVgCVHp5/QMHhaNTsYWO9uHEEVuOmQ0lkz22zdKBLhwu4mh3O4YmmYn7FxZ60E20pGjckgpAMBPJtVU9Qs8VdVru2/fexYrQytuwJ/3GCB6CyEnepkJz5c0SjFs2LjF2BAgLt7nuxf5dP+tNDufJYz/AZ32cSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gdesoaGn; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72b82c8230aso1702025a34.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745956063; x=1746560863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNMUgH5uNY4IqYIYRqaJEMyg/HY2VEe42NNCO90DOAc=;
        b=gdesoaGnaIjkBQMOEMiWnQSmtkpyMRn3qpZSwNEDsPhqZ7kppm7tIXCviOdpJqlVQv
         bACpzRAZwNkkBNj8TBN2JAiHLCdSqgMP89TnRrlq57hGtL8ntn6kAVCAheqP+ncIzEX9
         AnSf/NsZ5SR284jJW4QVa21xCDe11O4t4nAWfxiCE/hy/uyZllX2vjhd+BTFrKNLS6cq
         ya6pZw3FESzLyNkRDvz7yfMi28DdgwpzSUIQ11nrvIesdcgMA1OPsgQeOSNc/jj8SB9N
         Woq1xyuJvDX9GgSttyVU+oKWirh7x7ben88mKeuXzZwnmdmxt2+7/pO3CvqWC45RM5Wb
         lA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745956063; x=1746560863;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNMUgH5uNY4IqYIYRqaJEMyg/HY2VEe42NNCO90DOAc=;
        b=GHd/iVw+QwgbqlDRPQdF2Er30THdch8gHfN7k2lO9niteyerR2Micw3kXKFch0P9yW
         8xAeW9R+fWCWkuXv7obAJgm7Wsm9fL33T337etfUlDCxMf2capdb/qfe2/L2Cd1Oq8Xi
         dOBZQlfZl54lSnrFO1j+Af4YeydTDkeIq5cGyhKUV8ZQot50zuOHV38OGholXk40E8gc
         6R/kjjZqCLv89oQDMnhkc29snGVSfO2Vu8iftQRyYMXquSRC5tE+mxJ4ZzMfK1otk7vt
         WJcsRNuZqJeUkBQLhXPbBBFQuOhABiA/CKdrV61/SUcLCpHpV1pAG2fCwQ+5kfAtdkrj
         3jRg==
X-Forwarded-Encrypted: i=1; AJvYcCX1notOhwXkJ55eDWMqp+Zs20iIAPR6XP22NtQnuBd3f2l95tPGS4gdC4bJpwVlaeNbgayZH+G7SW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8uQhnriNrdCyVQA/EgY6Z0qJXhH8aDMOox7koO6DaGXtHuIn
	CflwrMwRAw9quBhVqE46LStJSQN+GRvQaKFxv1VTRFJXJULXGD+dRyWz4SiPmVQ=
X-Gm-Gg: ASbGnctFxfhJaBBS6N0CeiKVTd/6tH87Mc7bAzI+sCu4dNQjZHYdv/hiIM00nOPz0Vu
	dZ3IzP04JII/RzSK9UGC9R68U1PKkKwQ/dpKG2kRRn9PlOc6TX+tNVQInMRpgrpjpTyTLU7NMvV
	pyR6Camc8QIKkuG++x4EqOq2Woxctl+ycH0BZXCZ+JtoBCOtog4lZ8MOeqI1ScjaKWUS/+vRhRV
	ylzio7+tdOH9n3lJ+3dx0Mp/UL53cPIU2D2eMeU5IUOnQivNJyaqUMl9n8rKPF5jzk174oMz6NP
	+LNkclNvGCHR2WGF28RlFMu/LoD5gf8jXDdQk97NPOQLodS6O+8v8FDu77hGvLgW1m09R6CtO7v
	B3/nWnv0Hl9+NmonhESuBX1ZXrFQW
X-Google-Smtp-Source: AGHT+IF2u4BGVcklS8e42c3uNUIrh7aRuex4nRoeOZeNBykrvHleyFegxvqc61saZCq3sjivYkKrMA==
X-Received: by 2002:a05:6871:358f:b0:2d0:3078:e72f with SMTP id 586e51a60fabf-2da6a2b0b6fmr225244fac.26.1745956063148;
        Tue, 29 Apr 2025 12:47:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d973c18da5sm2955704fac.47.2025.04.29.12.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 12:47:42 -0700 (PDT)
Message-ID: <38e243b0-e81b-4d4d-97fe-91ea2bec6270@baylibre.com>
Date: Tue, 29 Apr 2025 14:47:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
 <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-1-6f7f6126f1cb@baylibre.com>
 <1d90fae5-9c58-4a77-b81c-2946e7cc74d4@baylibre.com>
 <5c762653-b636-45bd-8800-e804ad8dfda5@baylibre.com>
 <CAHp75VfcmvLhBDjbu6x46wGyzG+i7=rVypzSm11qzWN9Qq_rew@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75VfcmvLhBDjbu6x46wGyzG+i7=rVypzSm11qzWN9Qq_rew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/29/25 2:36 PM, Andy Shevchenko wrote:
> On Tue, Apr 29, 2025 at 10:31 PM David Lechner <dlechner@baylibre.com> wrote:
>> On 4/28/25 9:12 PM, David Lechner wrote:
>>> On 4/28/25 3:23 PM, David Lechner wrote:
>>>> Add new macros to help with the common case of declaring a buffer that
>>>> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
>>>> to do correctly because of the alignment requirements of the timestamp.
>>>> This will make it easier for both authors and reviewers.
>>>>
>>>> To avoid double __align() attributes in cases where we also need DMA
>>>> alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().
> 
> ...
> 
>>>> +/**
>>>> + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
>>>> + * @type: element type of the buffer
>>>> + * @name: identifier name of the buffer
>>>> + * @count: number of elements in the buffer
>>>> + *
>>>> + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
>>>> + * to ensure that the buffer doesn't share cachelines with anything that comes
>>>> + * before it in a struct. This should not be used for stack-allocated buffers
>>>> + * as stack memory cannot generally be used for DMA.
>>>> + */
>>>> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count)   \
>>>> +    __IIO_DECLARE_BUFFER_WITH_TS(type, name, count)         \
>>>> +    /* IIO_DMA_MINALIGN may be 4 on some 32-bit arches. */  \
>>>> +    __aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))
>>>
>>> I just realized my logic behind this is faulty. It assumes sizeof(s64) ==
>>> __alignof__(s64), but that isn't always true and that is what caused the builds
>>> to hit the static_assert() on v3.
>>>
>>> We should be able to leave this as __aligned(IIO_DMA_MINALIGN)
>>>
>>> And have this (with better error message):
>>>
>>> static assert(IIO_DMA_MINALIGN % __alignof__(s64) == 0);
>>
>> I was working late yesterday and should have saved that reply until morning
>> to think about it more!
>>
>> We do want to align to to sizeof(s64) instead of __alignof__(s64) to avoid
>> issues with, e.g. 32-bit kernel and 64-bit userspace (same reason that
>> aligned_s64 exists and always uses 8-byte alignment).
>>
>> So I think this patch is correct as-is after all.
> 
> I'm wondering, shouldn't it be better just to make sure that
> IIO_DMA_MINALIGN is always bigger or equal to sizeof(s64)?
> 

Sounds reasonable to me. From what I have seen while working on this is that
there are quite a few drivers using IIO_DMA_MINALIGN expecting it to be
sufficient for timestamp alignment, which as it seems is not always the case.

I'll wait for Jonathan to weigh in though before spinning up a new patch.

