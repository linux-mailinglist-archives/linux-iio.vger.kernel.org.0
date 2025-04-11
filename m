Return-Path: <linux-iio+bounces-17927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8BA85793
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E261BC0FE0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026F298981;
	Fri, 11 Apr 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1NNplFM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD52989AB;
	Fri, 11 Apr 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362568; cv=none; b=llmm9UvtZGYoP0Bu7axcGna0O3SdGnxWiBX72CHPGGE3V+Qs7xmuaOL5jkA+2JPvjh9Y217c7WEgn4x6UwY3eoffbls8eRarDmySWpxmmcR5OkOHXIkQtzyBiZZU4iFR9e8HP4fbXZthkQUsahmKMKtJ0ufRGnb14zRQgDQmNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362568; c=relaxed/simple;
	bh=W/vlXTogukYIMqGucQgxSpa3OU7C5zcxR6yw4Etq0uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEOoGMo1vVBu+qg2EdIlF1gVBJn+mVkzo46VccQ5ifqmN1XmlAhGwUlaDghFaEeoV8ABzXsqE+sHnDgFdsnh/OdzB4Riuk34J42+9bMR5p9uL5Hfw1X8UgnlELNMk6FUmRAdS2G6UHj2wFZIOgHY6qShTOU0KjQylC+y5H217Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1NNplFM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so17077185ad.2;
        Fri, 11 Apr 2025 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744362565; x=1744967365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qkZaiZefBY7DE1FBVZ+30CgUBG1uQo6QEc/89hTkrQ=;
        b=Z1NNplFM/mthYJc/MK6+mhFirzXsns9ujuQw8C8ewnCFZJO0aw2wuUoJlMoHHfS7bk
         KcH1Hz9WUAqTpEm8ocIou8eIj93+tmACDpuU1nIj3Pm6Cb7aQRv2nR0nQgL74Gk++aBr
         N54PnpnxbVnqSPO0dj4cUAG1SB1cdwslI0+haV6qkdzvSrvqpi3UJljyo5jRUqXSoG6W
         +fTUb/vX0v/upr3wMSsekTiMagdcJ1jiwLlbSkcZs2ER7ecS93rKcgicAJEUrDqY8bkx
         YEg5WqKpo7VxjD73jFRx9vcKEZTarHG9ItD27DSjKZAkz0ooEF47MTqnOAikd7SSMbsi
         jYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744362565; x=1744967365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qkZaiZefBY7DE1FBVZ+30CgUBG1uQo6QEc/89hTkrQ=;
        b=mqOlNsyGvOX/iVqMMASYMRIjsFdHmg7sstksPkrdqzuIBym1rOcVLRhBPHrQc8Ea93
         6xdqhnw2M+gDTrDEzJCAdk3nm0ZxpHd4kNteXq/tluNTNxjWVRdDWcQw+WSFy8pOoU39
         +RTmzY7JUaYMl/VGnhSwytfS3VxV2sSFT2WK8ZtG+7nU/R/HU6cOMQVEgNgDr9dJOl7m
         sMVA7zah1Uun2NuOCU1yH0DkOVMoTFSXzWj74j7flAME9mDhd9jJ1tKzeM31EZZ0V3zR
         INzk6ok5JjuVrIh3UyZHwMphLcdGi2dmiEeL5Tl6kBWx1F2DkUGas2n361/3p4yZEEk0
         isEw==
X-Forwarded-Encrypted: i=1; AJvYcCUTQ7bYtdTHtQhMcToF0mnRbWycI7rM9roAo2AxQyutN1+NHKopmxtoq+NoDzqRcS/Uv7R9tO/ucjVLfWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTk0AiFli69XG5U6B2IckBKqg1L98I59Uacy/pz8B8erOte1EG
	9Xwgdc0SwtNLXemjjEhDYh3ZA1HpjHCniPutpKRE9Yl5qJ/sqL9n7X0q+put
X-Gm-Gg: ASbGncsvpDIO7wV7YDBV0CqtdwjOcgZoE4YqseDaDK7vjTUOLOLmBlo5WAq1gyyxGI5
	T2hVLIbnbNP2Z+eR/Hvm6OELn8Q8KEBxQdzcpzwFabZGASntEKu4TQav3PqZnpfooW+g61Z9tDC
	bMCNfxQxM3XaF4+Et0kkp8ga5y0fDms4pPMtunpvNHzO60w8BLigGl3HVPk8aDAyj+cGIh382+/
	pdAMZCAu42tvIz7yYgVpu+wXsTEQprOfkPBZusxMth0kGY14aImZ67uZciCeAXf/qNsZa9z7Sst
	23P+9R8b7Ir9Bu5fiydoiWpsnghUVgXDcg4Mb5fzqD1x6jXskA==
X-Google-Smtp-Source: AGHT+IE7f8SwT2ziwus6ysaPI3EcDlswgvWAm+VtNFdfW2C7aMg3BVJk+qEoIMRAIg6U5h7S/1RgIg==
X-Received: by 2002:a17:903:2308:b0:221:331:1d46 with SMTP id d9443c01a7336-22bea495302mr28233035ad.2.1744362565455;
        Fri, 11 Apr 2025 02:09:25 -0700 (PDT)
Received: from [192.168.0.161] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b65496sm44315205ad.42.2025.04.11.02.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 02:09:25 -0700 (PDT)
Message-ID: <f5f40475-fae5-487f-b5ce-dc6c5dfe3600@gmail.com>
Date: Fri, 11 Apr 2025 14:39:18 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: addac: ad74115: Fix use of uninitialized variable
 rate
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>, cosmin.tanislav@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409202945.205088-1-purvayeshi550@gmail.com>
 <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
 <10a9dd5cdf55b6a9845fb9543cdef5f2251ffa6a.camel@gmail.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <10a9dd5cdf55b6a9845fb9543cdef5f2251ffa6a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/25 11:19, Nuno Sá wrote:
> On Thu, 2025-04-10 at 09:51 -0500, David Lechner wrote:
>> On 4/9/25 3:29 PM, Purva Yeshi wrote:
>>> Fix Smatch-detected error:
>>> drivers/iio/addac/ad74115.c:823 _ad74115_get_adc_code() error:
>>> uninitialized symbol 'rate'.
>>>
>>> The variable rate was declared but not given any value before being used
>>> in a division. If the code reached that point without setting rate, it
>>> would cause unpredictable behavior.
>>>
>>> Declare and initialize 'rate' to zero inside the 'else' block where it is
>>> used. This ensures 'rate' is always initialized before being passed to
>>> DIV_ROUND_CLOSEST.
>>>
>>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>>> ---
>>>   drivers/iio/addac/ad74115.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
>>> index a7e480f2472d..26770c68e5fa 100644
>>> --- a/drivers/iio/addac/ad74115.c
>>> +++ b/drivers/iio/addac/ad74115.c
>>> @@ -814,7 +814,7 @@ static int _ad74115_get_adc_code(struct ad74115_state *st,
>>>   			return -ETIMEDOUT;
>>>   	} else {
>>>   		unsigned int regval, wait_time;
>>> -		int rate;
>>> +		int rate = 0;
>>>   
>>>   		ret = ad74115_get_adc_rate(st, channel, &rate);
>>>   		if (ret < 0)
>>
>> I don't see how rate could be used uninitialized since we are
>> returning the error if ad74115_get_adc_rate() fails.
>>
>> Also, initializing to 0 would then cause a divide by 0 error
>> if that value was actually used later in the code.
>>
> 
> Agreed... A better check could actually be (in ad74115_get_adc_rate()):
> 
> 
> if (i >= ARRAY_SIZE(ad74115_get_adc_rate))
>      return -EIO;
> 
> Kind of a paranoid check but just making sure a faulty chip does not lead to an out
> of bounds access.
> 
> - Nuno Sá

Hi Nuno,

Thank you for your suggestion regarding the paranoid check.

However, ad74115_get_adc_rate is a function, not an array, pointer, or 
vector. Therefore, using ARRAY_SIZE on it results in a compilation error.

I believe the intended check was:

if (i >= ARRAY_SIZE(ad74115_adc_conv_rate_tbl))
     return -EIO;


This ensures that the index i does not exceed the bounds of the 
ad74115_adc_conv_rate_tbl array, preventing potential out-of-bounds access.

This check prevents potential out-of-bounds access, it does not address 
the Smatch warning about the uninitialized variable 'rate'. Smatch may 
still flag 'rate' as potentially uninitialized if it cannot determine 
that ad74115_get_adc_rate() always initializes it before use.

Best regards,
Purva

