Return-Path: <linux-iio+bounces-19352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D42AB0578
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 23:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869CB7BF052
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B85223DE7;
	Thu,  8 May 2025 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XY9OZrvV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0D2222C5
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740662; cv=none; b=bwBfLRTf77wLjiLuasBJbi3UgJ/O/4RVCd1Ru1VKX0Zgf+DZPMVCiuazwl5Ds1yh9xrEVNVd7linUR7cRLIXNZxBPWnj2/ZQlE07hQxLkwS136sagz/IUAbvb5BXflmXK5jjTswNfz5HTm2nnYELmTKAe6rKCBQeuxWVzWg6wy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740662; c=relaxed/simple;
	bh=aQSC+E0Fahye6dbTTPMAX+cp14yGUn51SmoB/H8LWhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdCTJfl1YYXwnLKOR25KDjs3mSFLCFBBgG5akB4IxotTBUN+Ys4Jgksfvl3LJjDdBX0Rl/UFwijfuBrSAyDj1JhD6YTER5uC3g/2WmFXf1CpkcJ1Dllte+MwnrnOyKjT1ZhdgF+il4vEkAW9jYoY6Xxfp6i4BVW0loQnK8IRZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XY9OZrvV; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c1425fbfcso1325066a34.3
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746740659; x=1747345459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4rrgleRHs8E8J9lRvZx/vc/Mrq/nsr1SKG+kIWRs0Y=;
        b=XY9OZrvVhJ5RnUKGOAKMhJln9Wf+2Ent5Ugrs6jrd/N/CkyDFqvpWoeKC9p83TcBMs
         N2PL1eFYDsnoDqX4Lh5nUwQ80+4Fv7MV3nwQ7R0p9tnQ7KYofK34+BpIngEiDp94jvvg
         s2nMZfrZShOvgPpStWlwZhvRKqYcugmwISPgsR6P2tF5AIo61x18E1G6ccawGGtDkdCf
         Ngei1DP4P31Lj5nIFolFZKowX/ehWnL8SxqgggV15cS2Qg0udiMf7lRB1QppHADDD05U
         coMxow0F9jVoB5ZWpXUrA6j3R6Bjz1nKxXF+6J5P2/EOnqYR4pAI1dvYYtXd0Gs3Je4w
         AYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746740659; x=1747345459;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4rrgleRHs8E8J9lRvZx/vc/Mrq/nsr1SKG+kIWRs0Y=;
        b=VsR4RuaEFM0hs42L7Z2InVwj8EENlZs9csnVWcrBgzsb7zYmwF0Oj5hJsszQh06Qvs
         vLWnZ5AiE2++O2/4nMon4LMEwux9EsiquLiEwjzG2nGrDg8fgTICvK7w02OURPQhlDdt
         Lu7m8tyhUwgNBnouOTOahrKpepkg+jiy3jm4DOTq41NqSdNFgR86Y35vEGBLH7xbYGqs
         1PHCWST42A6x1/RcW0CukeOB0HmCwyHQxLdx4ne2lHcoOhb+3lzxpFOczef48aw63zRb
         UWHCTTNaEYoV0F+xVh7VqCb7rp/YULjTJxtRfzDYQFQUmIhR3/TZtHklh4+69CI4IYaH
         7NSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZpdlLPVvX8GsOv89hUsHV1BQuFSf8F1RCLfuAeHLuMYpTO4Oj7+QIVgnR5OuuZf4P54dvv757Xf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QHIu8saIQ6frmDMAlxJky3HPtPQONwdYAQBdMuiI4sofXbZ4
	PhjXCRsTPLkt/2FSocxaI2PR9yw9D2SSY1awMkFEqWu47rlH3zZPC1W65V5KfAI=
X-Gm-Gg: ASbGnctutu8sD1Q2GO6Rx/Oiv7LeIzgKvMjOqVwYT23sbA/keShtFWsG6z1a7sIJLed
	S1sXdb/Ge3WJNx0Abx3CcA5JT05TeZfIR2WfSQR4BkA8sGsVQdPKOY5zP6FS8JTUOFqi5+FLgbj
	IZq9AEBBkg5wA6Wkll9f/1RK1vN0kxp8h4sV2rdjlj8EHdPYkrchGJVjGRwoR0/9RW0TisVoKYZ
	5JDBZnujiqczXoFqb+hHQ/0402cpOP/7vN/+2KfxSLpR4S4DWtwx22+WE9Sre5RwhKsfeRMkYV+
	gpMLTVQO9LOabKx90kq3zeQoz8GgMnNpR1hxB05FlJcXl5sQSvKTVwvVDlNZ/9XBJ9w121hiD4g
	ekD9OqssYJ0XK/k1Kdw==
X-Google-Smtp-Source: AGHT+IEWxrdM7guJzCtW5zB5Io/5M/nAEqa1rWAlUXg+L9OfIUY/bZAREYTnD85qHAKnzpkD1d9V+g==
X-Received: by 2002:a05:6830:380c:b0:72a:45bf:18d6 with SMTP id 46e09a7af769-73226ab0459mr938322a34.18.1746740659405;
        Thu, 08 May 2025 14:44:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264b479asm273544a34.27.2025.05.08.14.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 14:44:19 -0700 (PDT)
Message-ID: <43fd5216-9577-4773-86c3-e3035f3934b7@baylibre.com>
Date: Thu, 8 May 2025 16:44:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] iio: make IIO_DMA_MINALIGN minimum of 8 bytes
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
 <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-1-814b72b1cae3@baylibre.com>
 <20250508223959.70e909d2@pumpkin>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508223959.70e909d2@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 4:39 PM, David Laight wrote:
> On Mon, 05 May 2025 11:31:42 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add a condition to ensure that IIO_DMA_MINALIGN is at least 8 bytes.
>> On some 32-bit architectures, IIO_DMA_MINALIGN is 4. In many cases,
>> drivers are using this alignment for buffers that include a 64-bit
>> timestamp that is used with iio_push_to_buffers_with_ts(), which expects
>> the timestamp to be aligned to 8 bytes. To handle this, we can just make
>> IIO_DMA_MINALIGN at least 8 bytes.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  include/linux/iio/iio.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..7e1e3739328d103262071bd34ba5f6631163c122 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -775,8 +775,18 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>>   * to in turn include IIO_DMA_MINALIGN'd elements such as buffers which
>>   * must not share  cachelines with the rest of the structure, thus making
>>   * them safe for use with non-coherent DMA.
>> + *
>> + * A number of drivers also use this on buffers that include a 64-bit timestamp
>> + * that is used with iio_push_to_buffer_with_ts(). Therefore, in the case where
>> + * DMA alignment is not sufficient for proper timestamp alignment, we align to
>> + * 8 bytes instead.
>>   */
>> +#if ARCH_DMA_MINALIGN < sizeof(s64)
>> +#define IIO_DMA_MINALIGN sizeof(s64)
>> +#else
>>  #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
>> +#endif
> 
> Did you actually test this?
> You can't use sizeof() in a pre-processor conditional.

Pretty sure I did, but maybe I was asleep at the wheel. Anyway, this got caught
by a build bot and I realized the mistake.

> 
> 	David
> 
>> +
>>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
>>  
>>  /* The information at the returned address is guaranteed to be cacheline aligned */
>>
> 


