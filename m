Return-Path: <linux-iio+bounces-22319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B0B1BFC9
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4378717C333
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B71E51F1;
	Wed,  6 Aug 2025 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS+gLFJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E8846C;
	Wed,  6 Aug 2025 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456924; cv=none; b=gFeOqZL2/9huDaN+L2jFm7pQF2w/h5CsuB50+a+/OH98L+yb8EQtHsMw7SWvrP8NWug8eWVYygVLcbSJRL/SqV/56KmePyQXx3bnv4hBtCyfqVqzaBoegDVcgHdTmTEW6gqRn0Slon8sXHIXmNztTFMrpTSXf/05VubJS8t37gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456924; c=relaxed/simple;
	bh=zdQmDo5x7dIrwdu91odM/1aN9uDF1DXX9XuxEFz1sJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkdtdUyu0QsFheMWfcu0F1urwiU9y09fTzWktJYcq1lkX6cZE8n8ZS0NFfTkN7gBmgjMg7B1QfYL2iXJHDGqN6TFuCJXp8Ns3iHYnlLI913PWAi7Es5biHjiXdiBF9P+iuiPR7DftxJqo4gi3dGgK/oJnxlfHc8QR5+wE/IlBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS+gLFJ0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b8248e77bso6635563e87.2;
        Tue, 05 Aug 2025 22:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754456921; x=1755061721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XranDMkHdgRl06a1MDDe2rLwTdyCPBP4AtWUlMxr+sA=;
        b=MS+gLFJ0T5ZrGdfNI+25GnizPDCiVYlAGbCfrfecIE2KYQfNiv5lWWIucnQHXGWZR5
         Ec8emruVye8xytRwn4BDdIujjpey8DS5DQR4LaQ5YzE2BM2mMCRf+wHVwq4TbsGkBrc3
         CEbSMJsGsc2qpGI0MNI+Y3YFmcfj74Nyk441E1rdIHq7hkTeoTwopDfencT1FruPseoX
         1hv5NZptmTCYluQD7t2pZdMz4ogbW7IyMlk7qbaZNTiCGfeKeQvoJfhQPCo+jz/HzcBg
         kAvbJc217oIupNnuhmLxjxPrgrWux4FjaHmQVp2LeXhbJHPK+XpsJ7xg259CZU5/Z5F0
         xDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456921; x=1755061721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XranDMkHdgRl06a1MDDe2rLwTdyCPBP4AtWUlMxr+sA=;
        b=FpprMp3v4JVmjk03o2ZGEkNmZFTYQbHW8lSHDHVNmZ2DnWtAtmsrwOa5we6YOPtqZj
         k6SYlX9j1mT803cL03UZ767COEZJgTFL1SKDys1DZok+9gdk/56UdKanTc82SALwipnd
         zHPDqT5nVprL1ZkdROSmfZz1/uV/baVy7EwzrVBCBv6WmOaufycLYIQdT+HeiM8RyTka
         u2Iof11JDIsd0duWbh7GLeNWO3b6QPNPShoe8ovImOSM9RlhcdVGuNiEVhjRmbzum1Sm
         VXmtSDxakqwCIBmFBGxQG8AoptcFxtef8AdI64FsGYoiVY9WXl3pbbxZq0E3/3Vw/r5V
         oZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUivDA55wV0Bq/RqWErjqMv1Et27c4hlF3ECiRj+9NB683OH7DmUvf60xfHdf0OheSh0vRYg1FJ/w8=@vger.kernel.org, AJvYcCXEwjIsKjR4KbD9M8YD62BHBmaBJx5AP7RfchRplR1yfPB9UhAF+jSng1nlEut4EEFQdZTDMfwUupw77TGD@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6uZ75+xt2LIlhgcQorCxT3AdkTJyNywn9Io/zreDXiqIX5L+
	3yZL7iBHLjOjxihmDk18/GguQAdPtAHJJUCNbkAgr/11MHd9/Z//ySES
X-Gm-Gg: ASbGncuFvaA41xGYUUkrE06laUKDz46NFIIhWOaDW5hGEevRP7jTOXJ0RiVStotVP8t
	3HJ2yjmY7TzlSaievlN88UkEmSnEtwIYL1XCZ4VFy1mdjgypE84M3y1/xW1sQlCT0RLePUT1mIR
	ukrZSjRa2/Pw3RfDLbz4eqFuwtOC1EJpacNluuMEOkUGga8rUmnzMpIDOOGBBKw1HVrMcmKKmNi
	a4Com8dI2qNzYQGxpQjTZIIceoWyONGo7ugKTOIbIWxdsNsNBMGMGZcZRgkAiHes6cHN+TvBVlZ
	qRi/MVKSA3hSozr13ZH8UcdPs4rwBd7pQqCQkQrSD9VL1HeBmr3eIEAyEjonnhF8cWcdzz8CoEX
	vmO+Aga4CGs8udOwMbXMP7/ZOJEglt21xEZrzDXUjfbwXcyPTBIC8YpE1gufTWJdCeO1zX7cExm
	3dagw=
X-Google-Smtp-Source: AGHT+IFrdETArHVPRGKzmKr6OL6K7gBJDb8X/1t22t6tgLT+HoEGkKwekh4QJln64YhOuBjYGYE06g==
X-Received: by 2002:a05:6512:238f:b0:55b:8e6e:b419 with SMTP id 2adb3069b0e04-55caf314fb3mr453767e87.16.1754456920501;
        Tue, 05 Aug 2025 22:08:40 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3f87sm2144736e87.138.2025.08.05.22.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 22:08:39 -0700 (PDT)
Message-ID: <5223b372-ec07-42e9-9c5f-c713d09a94ff@gmail.com>
Date: Wed, 6 Aug 2025 08:08:38 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] iio: adc: ad7476: Simplify scale handling
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
 <1492897c-fe2e-4ac7-8866-595cd8dfaaf0@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <1492897c-fe2e-4ac7-8866-595cd8dfaaf0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

Thanks for taking a look at this :)

On 05/08/2025 19:09, David Lechner wrote:
> On 8/1/25 5:07 AM, Matti Vaittinen wrote:
>> The ad7476 driver supports variants with different amount of supply
>> regulators. On some variants there is only VCC, which is used as a
>> reference voltage. Others have separate VREF regulator, and some rely on
>> internal VREF. Some have both internal VREF and option to connect
>> external one.
>>
> 
> ...
> 
>> +	if (!st->scale_mv)
>> +		st->scale_mv = st->chip_info->int_vref_uv / 100;
>> +
> 
> Shouldn't this be 1000 rather than 100 to go from microvolts to millivolts?

Yes, Thanks!

> Also, I would just change the chip info to `int_vref_mv` to avoid needing
> to do the division at all.

Yep. I'll do that.

Yours,
	-- Matti

