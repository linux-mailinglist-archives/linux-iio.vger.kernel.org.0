Return-Path: <linux-iio+bounces-20472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E609EAD5CC4
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C4A7AB524
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9A20C463;
	Wed, 11 Jun 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GANdezrQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D1184E
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661234; cv=none; b=t+dEkI0OW3xTIcwG1j2g9chJyjOMm55rz0M/9ghlNaDWqOyFh2HBGmBHUzh5H6u0P49U2nk8y31uc6Eba92PNgsbVFYczGzzDfik5GVNWDqe94vndT1Gv2d6mH9dBO/5i8+00qBlzysUqLsiGvE26ke47xeDAfxBTgPdqMMH0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661234; c=relaxed/simple;
	bh=FIrW8Y9sBuIf71cPV8Xo60w7A800qP+75c2RlajoR3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKIrLDQ8PISrgjFvjs/4vrzJxLnsDHhd9N3CRHMx0rgq4CFVmR8pyP/1hHh5JIplX1lFRGjtC1dCwRW75R0FT8Hnc4cziYuNBHJp04YSkR8++BDJyGoHCT++AeKc+aL2qfLN8kMxGnixXqnvoHTnnvbD8ZYKjp3oBvLZgVlH46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GANdezrQ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73044329768so50523a34.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749661230; x=1750266030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vmahb5YSlfnS2uNFzhr+DnBe9o6m7o1G+AoiCjsOwJ4=;
        b=GANdezrQ+uRgmpcxWy36o5Lpug1bOD2Im72Y/JVrj67lFeJLztdZnz6hYyG6ame2F1
         imEvnriciGwbffyGgOYeCTA3FY1ngO2yop/odMmU5NbuJ1GUlv9FC2an4nf7TQzbTOrb
         S37kiF40BaGRGKul7Iu/JSo5srRL3mBZwPRHlu2uHovehE/nuN0l/rf0jWRObqXe82LC
         L6I/kSdZPkl+U0h4eaWqH9RBawMiibm2CJXrStD46/xi1IV2v8Fynef8ZeF+xSTMZdLm
         3ALTM5Vynx92RLFTcI83+jS6oYNK1Xd/OqdNZd4wahUlJbockueYUPHGT6/u2K/TZn+M
         /FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749661230; x=1750266030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmahb5YSlfnS2uNFzhr+DnBe9o6m7o1G+AoiCjsOwJ4=;
        b=bRnVLUn152wOD2A1EXPlhzmKPcitbX+f5aOfqyty2qrXfNAKDdTMPGooSYY7Cxzx1S
         2/qHV8dI5D5sMlGK92LUoXJHRz73V2YdF0gsCRUXBr9ymWE6cnptALXFhr7zhigOeemV
         zmFAs7MG7N1FnqGxtQ9poXFWM3wt104MkFiyDeCxl30n6bBMIej+YoGVrrfAu8Ao14Vf
         qy6tYqXEPEQq0nEvDxBc9fNua9TY6v0+dW3PdNZnBitrxk4fo0Y0qK/tHa7fwLhKF3Ue
         0T9yWhbmn8ACgv+dqldBo6QFJIS2GhEBdSCZqIcxBXgQ4UyyE+1yxmfOKylb0Z6dvTVN
         5rvw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Sn1wC+QgRJpRlTFSAyRamEHDZHvTMdHGIa+NKE0tkKpQ0tKnNb8nhTIc52oRL1ewJZZ3YRYwPwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEKLYM+hASRbhRjo0GLAW2NPIQTTTw8mYtP49Fmma/8P0p2V7
	SMn6f+jUUmduF3rPfa/IiusfetlPxejJvK3VAcGjvq/IGsaHrM3y2qFLXeOYtQStyhQ=
X-Gm-Gg: ASbGncvTDeTYdARD4id9xV1L5YxW4SpKhwDSAtqSygGolcqKZGOtWdjCG/XGXIiui9H
	IouzJEELXlfYzghURAEQl8CDZZ2ZCS1eDvLqOZSI6+KPgeTsH59hJujQT8QXGSqIAIMeSR6b1sY
	IQv/OKBUP+kFdoYtRW2UnrZOiRffqaFcm1BsEsr8QgExL+miCfiggrY+HjOC1S4QmKY5Rn1KWNh
	VdtCPobbnA9Wptwt9hLkCe1DMJ9R8jO874CkIIiNCAbZlTtjO5/xflGWZtegsPxn7h3tjx1sfr6
	V5F5Z1brGlv3lItN5FJbV6KSNWtkahDO6O6wJLB3mFAdMwLUyJP25uLFmBoZDa3teq2SZBXPddn
	DLIypqpmPkMlNS6Ka4pcumiLk/YPKpNGLoA0/ay4=
X-Google-Smtp-Source: AGHT+IGwCp4LOdjH942XeZsameCeS93elYjYdo1RMQX2WjgMj9zWKiPjyxooL+cU42xJ7qISBBZdKw==
X-Received: by 2002:a05:6830:3789:b0:735:ae39:952e with SMTP id 46e09a7af769-73a05c99d64mr3167512a34.26.1749661229839;
        Wed, 11 Jun 2025 10:00:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a06fe0b6dsm371402a34.24.2025.06.11.10.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 10:00:29 -0700 (PDT)
Message-ID: <1bbee6de-adac-4f28-9a96-fd6480691ac4@baylibre.com>
Date: Wed, 11 Jun 2025 12:00:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7949: use spi_is_bpw_supported()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Da Xue <da@libre.computer>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-iio-adc-ad7949-use-spi_is_bpw_supported-v1-1-c4e15bfd326e@baylibre.com>
 <aEmdhV0ATRuUeGaL@smile.fi.intel.com>
 <851b7d08-3e77-4344-97d1-9d60f1fb8762@baylibre.com>
 <20250611175506.01d11675@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250611175506.01d11675@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 11:55 AM, Jonathan Cameron wrote:
> On Wed, 11 Jun 2025 10:21:56 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 6/11/25 10:15 AM, Andy Shevchenko wrote:
>>> On Wed, Jun 11, 2025 at 10:04:58AM -0500, David Lechner wrote:  
>>>> Use spi_is_bpw_supported() instead of directly accessing spi->controller  
>>>> ->bits_per_word_mask. bits_per_word_mask may be 0, which implies that  
>>>> 8-bits-per-word is supported. spi_is_bpw_supported() takes this into
>>>> account while spi_ctrl_mask == SPI_BPW_MASK(8) does not.  
>>>   
>>>> Closes: https://lore.kernel.org/linux-spi/c8b8a963-6cef-4c9b-bfef-dab2b7bd0b0f@sirena.org.uk/  
>>>
>>> Reported-by yourself. I'm wondering if the Closes adds a value in this case.
>>> Otherwise I can do the same to maybe 10% of my patches, for instance. But
>>> I don't think I put Closes tag on whatever improvement potential bug fix
>>> I do report (read: notice) myself.  
>>
>> I included it so that Da Xue will know that this has been resolved and
>> doesn't need to do anything more. Normally I would have not included
>> it though.
> 
> If I followed the discussion correctly does this need a fixes tag?

I supposed it doesn't hurt. It could be possible that someone tries to
use an older stable kernel with a SPI controller that didn't set the
flags, in which case there could be a problem.

Fixes: 0b2a740b424e ("iio: adc: ad7949: enable use with non 14/16-bit controllers")

> 
>>
>>>   
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>  
>>>
>>> Code wise LGTM,
>>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>>>   
>>
> 


