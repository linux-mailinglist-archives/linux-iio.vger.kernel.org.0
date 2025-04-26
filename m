Return-Path: <linux-iio+bounces-18716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FE4A9DD8F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 00:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F211B66318
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E31F875C;
	Sat, 26 Apr 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BNZzBz+y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C47494
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745706858; cv=none; b=W4JJM2rk3Ya+F754bCtuVkfcPP3tCKm+fUMSpEmRgKa9vvNCzmzKa6wYrFOLKjokzaSSvM4EGSBgLYlZuwLuFLnh3oqZqYG3fg7xwnjfstf9yD4LQJIuut74ZDjRWabDs2uiqHSDq0T78iksEh8v87t8iO0t4E409XVDpWsdgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745706858; c=relaxed/simple;
	bh=KFP/OMt+pVNyA5FsCHR48Mx5Hg0N9JcRJgmsN3DujQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evJ+/g093vRJdiSqhZ5S0MHRqNx94LXehIDRPt+mpjGSddSbCRDQ16rHaXzn1dcQn2ZBYWddru+qM2ep/AWLjsgJjp42jZElRegLspozfpKphQWwhJnMCoSTSi6b0RWsK1C59kKAC4CWs2OxC7sKk5PSRTpXUaJMtAR/hVwdND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BNZzBz+y; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fbc00143d6so3002225b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745706853; x=1746311653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYVVUGhcXIwOLu06TILyWFwu4mq3jXrLLzPklRAXR6Q=;
        b=BNZzBz+yhzpzg/M0/JeYdSA0M4sh+kTyxVvRWshrqxAjCrGijFMxrmGJJGdiW74xnv
         /+bJ7Ygwl9HIAv8l66EUPeuxtMQmPUQD2vvswyh7vBam5dJivvAkGiG2S3SYe8ZwRugp
         w2h/uLtkmMelldCyBxVpJ+zS1Nwirr3Ic4+Od+5iCE4lU2TVwNaLhG1EiIgJgTUlAgtx
         meDP+mAh05TbInY7fBOpapiKmvnaEudqyde6/IsXCABRvsznGCv425fVO0kYpahhNITH
         LzcJO1/4P03/98IKsdO6ymloRoefOjEJTk4V48OTxreyAtFtxTYK6t45mf1MUQ6UCuOv
         c6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745706853; x=1746311653;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYVVUGhcXIwOLu06TILyWFwu4mq3jXrLLzPklRAXR6Q=;
        b=b8/QiUDpED5HY/HBdtfiywKJioNwJO2Ok9puirHc0Dc7llDTkIvbP3+nXJxlCyB8Wt
         j4aY0p7uPO2Etejd3yGYiZAv7ZzsvzOMxXp51LbSWYK1au6/g9EyynThVGEz8tuIQmuv
         cI4MnFIRqMrYNUUwiAqbZ+O6de1e7NoaUF1v8ZV+1L9oqdFxoVYEAqvcbbjzsXO+8yjJ
         1yob2RePvDAQsIM+Q21u98ZeYA9R2v+nkYIgr5USFC8U56Dlu64RuaT5nuXtgEEPUPtR
         DS58OtKKbhEpSj00uZGbuPpwY2/Az2cJSqSZo3l9QLzq2VhlDhT60EawJFrxK4Q5fP6R
         1urw==
X-Forwarded-Encrypted: i=1; AJvYcCWNlCq/8KYTYGey9rA791GP4oleFJeh9zVwb8cij3HxsPFvfnz8VIAdBJUJBUWsIez/B/PekEUJfZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZtnfgvchr0viiX4642869yj0cj2+6vA2mTF04NeWC9W+Mw+Y
	6UNkbEex6JJbtAVRebwLcBiK8+P6BIQxxb4p7Xl669/jdbeC4UsiZK91FNcruPs=
X-Gm-Gg: ASbGncuwdhbZkenlXDAx/bD/xtawc68EfIg1WnSTr+nYXgWbeqbUwhZqVXnsj0FwLsx
	FKfCFT2fNn6d5R67dJLnVJNM/3Xkr3Lp52HLrjv7IG34e3753iCT7kzlY2x9g1F3mjPg5mU1jYx
	iyAGusiYvalRMOSSbHUuk/dzUlYBBcYBCmxMroMmjrWhMurbuV2H5lMFD8m6egwvwQ2vinVR3J1
	GYXBV/O/ALk9KucDfYXIPFp+UF7vw54kdpkmKlstyH37p7DrkKBQMNU27I4fxnGFwyKnETgxsml
	5X2+0SvTF5NixtZwKAo6K3IuLs9TFPFhoWhdCrJtfzLHg76UkShJN332I1ifNGqbyAK6ICsfRTZ
	5FzkJnEPuIFRpza7ZVA==
X-Google-Smtp-Source: AGHT+IEWcdgjh8/VjhINgT8GfioFVGPqEFDg87O6EIU4BE5z/R9+CNVDT1w95ttosllom+MZY3JBMQ==
X-Received: by 2002:a05:6808:338a:b0:3f9:3de3:c8de with SMTP id 5614622812f47-401f289161fmr3985703b6e.12.1745706853626;
        Sat, 26 Apr 2025 15:34:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96ff:7f79:37f3:5c67? ([2600:8803:e7e4:1d00:96ff:7f79:37f3:5c67])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec977dafsm1329187b6e.41.2025.04.26.15.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 15:34:13 -0700 (PDT)
Message-ID: <8a57a332-c2a6-4825-a5f7-d765ea15bd6f@baylibre.com>
Date: Sat, 26 Apr 2025 17:34:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
 <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>
 <20250426123509.0b04f0f9@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250426123509.0b04f0f9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/25 6:35 AM, Jonathan Cameron wrote:
> On Fri, 25 Apr 2025 16:08:43 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 

...

>> @@ -777,6 +779,42 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>>   * them safe for use with non-coherent DMA.
>>   */
>>  #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
>> +
>> +#define __IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
>> +	static_assert(count); \
> 
> Why do we care if count is 0?  Or is intent to check if is constant?
> If the thought is we don't care either way about 0 (as rather nonsensical)
> and this will fail to compile if not constant, then perhaps a comment would
> avoid future confusion?

I would be inclined to just leave out the check. But yes, it is just checking
that count is constant and we don't expect 0.

> 
>> +	type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64) / sizeof(type)]
>> +
>> +/**
>> + * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
>> + * @type: element type of the buffer
>> + * @name: identifier name of the buffer
>> + * @count: number of elements in the buffer
>> + *
>> + * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
>> + * addition to allocating enough space for @count elements of @type, it also
>> + * allocates space for a s64 timestamp at the end of the buffer and ensures
>> + * proper alignment of the timestamp.
>> + */
>> +#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
>> +	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
>> +
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
>> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
>> +	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
>> +
>> +static_assert(IIO_DMA_MINALIGN % sizeof(s64) == 0,
> That message isn't super helpful if seen in a compile log as we aren't reading the code here
> "IIO_DECLARE_DMA_BUFFER_WITH_TS() assumes that ...
> 
>> +	"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
>> +

Seems we actually have an arch (openrisc) that triggers this [1]. This arch
doesn't define ARCH_DMA_MINALIGN so it falls back to:

#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)

Apparently this is only of those 32-bit arches that only does 4 byte alignment.
From the official docs [2]:

	Current OR32 implementations (OR1200) do not implement 8 byte alignment,
	but do require 4 byte alignment. Therefore the Application Binary
	Interface (chapter 16) uses 4 byte alignment for 8 byte types. Future
	extensions such as ORVDX64 may require natural alignment.

[1]: https://lore.kernel.org/linux-iio/20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com/T/#m91e0332673438793ff76949037ff40a34765ca30
[2]: https://openrisc.io/or1k.html


It looks like this could work (it compiles for me):

	__aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))

If that is OK we could leave out the static_assert(), unless we think there
could be an arch with IIO_DMA_MINALIGN not a power of 2?!


