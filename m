Return-Path: <linux-iio+bounces-18874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC01AA1B61
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 21:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C2E1B679CD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20920253F28;
	Tue, 29 Apr 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QC3IWbjc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8824C083
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955066; cv=none; b=jnVda3aFsPfbfGnh0HZfde5EXzwnP3D4WDyMrZPHE77J3D8PXb5MbHwkT3Ft7REpMKNc1LXZ3g8sZIPXqo3tFwFQyszi5DWj17CY9YWyfRJvGTA3sAuGpLRhHyYGgoHH0uprsjbwO2G8OIAo5TAf3Z753NNJgn8C6eBJMTBbmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955066; c=relaxed/simple;
	bh=F5u0T2bd9f9E1hJDBLndIIX0IL37h+00zGgcWxHjWgU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L9OV8/1DA8QLFWQuUuXFcB5z8xT61PuZZS8dWmg6VFQcRYl4hyFZn8kcEBoLr1oES/cpLyxOt+G7blPE+2+OvkHvUE1/uaJrD4Stk1b2vSVCaviK1k0FJddxF68u8B/JSMxfBdbCkQ1G5tT2+qihGOJOJk7auaXkzMpE02UzP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QC3IWbjc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c14235af3so4180427a34.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745955063; x=1746559863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IEA9coPSR+RXT/e6kG1IdF6r8oRJJfl6KimXKU4XDp0=;
        b=QC3IWbjc5ICniceVNhODfd+Z01/cXFbxwXw5jf44xK0a5SQgZawFIb+aI4Xpirif4s
         zew7UhV1UWg6A/ocFc93bp/JwnHp0Sjodbv/ilzJ9UCdH7O3ASxxQBoryImmed9IjGjZ
         ggn5HFjSilGYpa85+/5v1eXwgfwHQb+nLID6PeBOaVz+5oDlRawI2bmACEx67NTsMdCR
         937JSleIBXlQBLxv2wzAacin4OPW8luxbolNcxR4A/ohpmNDhNd17LexQxi0F858MkgD
         pzdvj8vHEUlA2udN93B8Rk23h49IZhSwNDXWTeCCT5P23po3XTpAstIHD7et/O8QOfcp
         HBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745955063; x=1746559863;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEA9coPSR+RXT/e6kG1IdF6r8oRJJfl6KimXKU4XDp0=;
        b=giJ8sKLSRcQ1WExNoB4h4a9NVyL2+cU+yIb0bwCGDSPMsdpnJVVO2uK2SdjTnGgXGr
         8Psts37Uyuc68rZXD/nnbrUx1d473YBw8PJXAliO9+y/2687ZQFeBq3K9DTL8xf51xPk
         yk3Rqh9In7ZqEzYBr36RJp3PuzcuPsfd+W0wGl2ikRV2IetIgCctU8n32cbbAn67ij4F
         tZh8nMoXFFHufU0a2TEEBLY6fCA/LaFmphi9PnATNr3NmO95x1gKa9wDs5cd3C5r4pNx
         9us4iJn8PGgamfGECo/fPr6oAv6O98q8SdFa+dBUnRqS+E5cUHdEeCKogF4X1qxg66WF
         VyNA==
X-Gm-Message-State: AOJu0Yy9qAT0N7ut+ez2cDUIjubLz+wBjZNAEaNXPSgjAIuazNUjSQgg
	RVfT9g3hKUt54vh7RDcOX8/MRs/Tjrbx4oGnNWln/jNautUyh8zg6CBpZco3GSw=
X-Gm-Gg: ASbGncu7nc5T6UPkTzoCdrr3M4yxv9osyK3fwpZK0NtKwB8+l6Wh/6QzEcbpPjjXd1H
	7VCXnWoFiQvZTLDACOk6Xw3IR8nMmEHRav1PAYfoiTxh/rJwk6eWVwk5BAn0EtZwm2NrElPOqHr
	eLyzInjb+6+9ATeSBNFH0BO/TE+pw/Wb6YJYAlLIzXtDgio9TdLGKwI4zXsl0DuV0wCImp9YCu4
	YFpwzItiBulfTIaZQwxTTHhk3K877M6wv3ZBDaew+a7zIPOhnLjy/t6E/2ncTaJFmIIKCQDhWlu
	J3wcT2+S+g7o+uTk1hgZujfUO7nK7+fqAYl9xHjROjAd9ViR2Ak2lQOy6lm/aD72LTg/QfqmYHn
	po36Ib98AiV/6duwubw==
X-Google-Smtp-Source: AGHT+IEaVlZVZe+jb2HlViK5TnZL0Nc4jro3bTaGV2+pNP/R765+0tJ8r0OzgrEjBUiZuFEMIPtr+g==
X-Received: by 2002:a05:6830:4420:b0:727:42aa:e888 with SMTP id 46e09a7af769-731c0ab2949mr234320a34.27.1745955063337;
        Tue, 29 Apr 2025 12:31:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b0f35b0sm444024a34.11.2025.04.29.12.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 12:31:02 -0700 (PDT)
Message-ID: <5c762653-b636-45bd-8800-e804ad8dfda5@baylibre.com>
Date: Tue, 29 Apr 2025 14:31:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
 <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-1-6f7f6126f1cb@baylibre.com>
 <1d90fae5-9c58-4a77-b81c-2946e7cc74d4@baylibre.com>
Content-Language: en-US
In-Reply-To: <1d90fae5-9c58-4a77-b81c-2946e7cc74d4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 9:12 PM, David Lechner wrote:
> On 4/28/25 3:23 PM, David Lechner wrote:
>> Add new macros to help with the common case of declaring a buffer that
>> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
>> to do correctly because of the alignment requirements of the timestamp.
>> This will make it easier for both authors and reviewers.
>>
>> To avoid double __align() attributes in cases where we also need DMA
>> alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
> 
> ...
> 
>> +/**
>> + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
>> + * @type: element type of the buffer
>> + * @name: identifier name of the buffer
>> + * @count: number of elements in the buffer
>> + *
>> + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
>> + * to ensure that the buffer doesn't share cachelines with anything that comes
>> + * before it in a struct. This should not be used for stack-allocated buffers
>> + * as stack memory cannot generally be used for DMA.
>> + */
>> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count)	\
>> +	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count)		\
>> +	/* IIO_DMA_MINALIGN may be 4 on some 32-bit arches. */	\
>> +	__aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))
> 
> I just realized my logic behind this is faulty. It assumes sizeof(s64) ==
> __alignof__(s64), but that isn't always true and that is what caused the builds
> to hit the static_assert() on v3.
> 
> We should be able to leave this as __aligned(IIO_DMA_MINALIGN)
> 
> And have this (with better error message):
> 
> static assert(IIO_DMA_MINALIGN % __alignof__(s64) == 0);

I was working late yesterday and should have saved that reply until morning
to think about it more!

We do want to align to to sizeof(s64) instead of __alignof__(s64) to avoid
issues with, e.g. 32-bit kernel and 64-bit userspace (same reason that
aligned_s64 exists and always uses 8-byte alignment).

So I think this patch is correct as-is after all.

