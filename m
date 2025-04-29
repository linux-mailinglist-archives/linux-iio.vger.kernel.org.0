Return-Path: <linux-iio+bounces-18801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2DDA9FF7F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842CC3BEBCB
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13317253B51;
	Tue, 29 Apr 2025 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XyfEX/mz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E1153836
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745892774; cv=none; b=eFh65jUpbV0u4PoRVV66T9/7nG3QxsCE2u7ksTWrjTwlEoXjFyPdXMhtnKJAhJbAADkN14nGaoSS4n1wli8fKljNeYPepSg3JaM4XD9tU7+EoYmrdbY0z6j4gcimnRX04+K7HIpymzx14dH0JfcstAfPFlrUhpugUw3uCTWgWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745892774; c=relaxed/simple;
	bh=pkqVCpFlFxkl36FV0Cieo0EG7h5YuC+3VDYKhhZAHDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2fBDeNBdjQdE2YJHGiz1n3GE8nEP4K+L05dkdCfpHv7ZLeCRQ0zx7Zjz8jdALJSUpwqiV9GAr8b8hYWi4WaX1NfCTyfa0c/58Q0LolrjZ7wfbfPHL6k115CgQGnNNkeK9U4Z5qbQux2iU+1jDTGnbhbsmOFuY2knkrjQEOpTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XyfEX/mz; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6065796762fso936550eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 19:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745892770; x=1746497570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6S4GKpAtROTwbGLe6u4eJsWSI5xTeTy32z267OBAd5w=;
        b=XyfEX/mzyCxZu00M7QYLkDERlKp3Yjp6zf4+HJUtjK9QnVQz3TdKMO6NoYiq/zJykP
         LbDDz1rRq21wOaUfnGbaW4Ou8fFjrvJjoO2Ai5fFU3Oe7rXcaSUDDXVnSyR+xNEEE8oD
         wl+VMsu1wYR/HkEDJhI8ytGVoDVf/i7mDiRSpEat2x+DB9rS9MUue5p4y5pfQrXlGZj4
         bzx9gUYJjZ8fdYybOL40jNoB7OBcEuC6g5NQK81gzWvExug9JjH+EeLyZN6Ie9kJGv7O
         xWeurs3yWls0g/4ocC54oJP+mKeGlLWpiuCFPBsQPNC9eVjMkRBQzmW5FMSLTqdDf9Ut
         CCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745892770; x=1746497570;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S4GKpAtROTwbGLe6u4eJsWSI5xTeTy32z267OBAd5w=;
        b=BlSz8Q+Y01GS5d3NZ1kpsnqd0UMiiohbwH8imCN+7d2Kg2ZCarACYbLNOH2QlHIefo
         +THk3UGO/CgNZVp3HGTGfVpCZCot0ndTq1E+QxnQviyr40SAzAvNjrZRo19ojDzsB6+u
         y6bYy9oZfC5Rx1oVOAAlajXSKJTEx4KXO/ruQrbRx1SESa9dsXC4e96979NJqJAcEdDU
         9ewC1yZK7y3tYVSF+eBa2UNuPUxeb8l6M2y9UXWaFmwlqUkHDOeAw2Xa+eYpZ89GZrHd
         0BTCLBO7+Pgr7kQ9JsxdfUZNc4cn/D3qMbTZVjF4RpJ6JqvH0Huhs5DeDLjKYWLu14DQ
         iP2A==
X-Gm-Message-State: AOJu0Ywm6ZJlXe+8J0fFGL6N7LUu7cGAlZahww68iYkAQ7iZdDnD3onb
	UtRq4Kqu5kB3INa/qveBepr853N+gFQTeC9fS2qtssiFqY07Pipl2V8JEzuOm2c=
X-Gm-Gg: ASbGncsmqCrHYCEA45z21v1wHvLICv05DR4ec842TOvor3nPcyzUvi8uPpVRBH3GB7d
	WAX02KA3fKvjzbzIR4Z27yoiJXnJgDxDAF5TyaQ5Ww19ffjMD1bu+vx+5dH/TZnDL5F3g4pBCpW
	Hdj5xHXvHpcyyMsomHCxmHZITJf+p8RKDwCFGc7TXwsHA+2BPWSZ78YC2VVqCsZDGt6L8+kfVhD
	iGe3GO02HLaEWr3rIzRTfMtGmB4yO9xMtTHMjTVu1U0IBIGutOedE8CgVuCrNEFWz/kFRqOnAfJ
	+79xbWBl/JQO3j3FxsF5ngfr4O2pTMB+fkufxzB6kIKUdDi0P85oPmH2XAngjGG6+erkv6XRXXU
	i1AKTn156GSWTW9M1TA==
X-Google-Smtp-Source: AGHT+IE6FyjOxAKnVS0+MaJeSBNlFo7Z99elkvia9LCPi2NOJelDK6TnHtRbBBkq8ITYn9LPKBUkkg==
X-Received: by 2002:a05:6870:718e:b0:29e:43ce:a172 with SMTP id 586e51a60fabf-2d9be84dc03mr6759663fac.28.1745892770447;
        Mon, 28 Apr 2025 19:12:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9? ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d973c196e8sm2551773fac.46.2025.04.28.19.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 19:12:49 -0700 (PDT)
Message-ID: <1d90fae5-9c58-4a77-b81c-2946e7cc74d4@baylibre.com>
Date: Mon, 28 Apr 2025 21:12:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
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
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-1-6f7f6126f1cb@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 3:23 PM, David Lechner wrote:
> Add new macros to help with the common case of declaring a buffer that
> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
> to do correctly because of the alignment requirements of the timestamp.
> This will make it easier for both authors and reviewers.
> 
> To avoid double __align() attributes in cases where we also need DMA
> alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

...

> +/**
> + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
> + * @type: element type of the buffer
> + * @name: identifier name of the buffer
> + * @count: number of elements in the buffer
> + *
> + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
> + * to ensure that the buffer doesn't share cachelines with anything that comes
> + * before it in a struct. This should not be used for stack-allocated buffers
> + * as stack memory cannot generally be used for DMA.
> + */
> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count)	\
> +	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count)		\
> +	/* IIO_DMA_MINALIGN may be 4 on some 32-bit arches. */	\
> +	__aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))

I just realized my logic behind this is faulty. It assumes sizeof(s64) ==
__alignof__(s64), but that isn't always true and that is what caused the builds
to hit the static_assert() on v3.

We should be able to leave this as __aligned(IIO_DMA_MINALIGN)

And have this (with better error message):

static assert(IIO_DMA_MINALIGN % __alignof__(s64) == 0);

