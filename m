Return-Path: <linux-iio+bounces-8815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AB95FB25
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281941F2379D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912813B58F;
	Mon, 26 Aug 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/If90jS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0628DC1;
	Mon, 26 Aug 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706019; cv=none; b=HleiojYlSA48exKcf8ULJirHsAkbCn6blZbkf6duCPW0GIqAp0w/XOYYidn1/um0OZHlHZJgRpQ5i1YBZJLkcpe9tQlqnCSUU1ff4yo97/9OQEppTqUkxuLb3Te1WbfM1r65uk09vlw4ayrr9eES1vwuPGRsY+pwIKo9l6Z/F3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706019; c=relaxed/simple;
	bh=ae6nXL4zmv4vTDHXa1H5uLnPJYnLtqT7NVV6lyTLXrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGq9vfS7qJS+OZYmXFDmohRMSY5Ja8BR+51lmaZe30O9Fq8gwP8pZZayKTepwKaXwhOtARfk/tjEGJFt+WOMXfgBlK6fSzQYVL8si+sk0TVaNEsgKBSh7UNZAknoZqcnEQmq6JsLUIU5TWJRTQJxu508euw+PGWaHDW7ea+oC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/If90jS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42816ca782dso41562595e9.2;
        Mon, 26 Aug 2024 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724706016; x=1725310816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+K/X6YqDrxWE8WA9haO3ONaWPfQCU7jkPm8tQUrtw4=;
        b=O/If90jS3EzhYeiKYNF/vY93ZAPuFjwm6YFSxtqA48lr0Sv5DWPPdodHcGWxxM1tI3
         9pANE2aLjSdkR/SIvGrsNnMyYjpHk5fQvgyMywSZV/7dhbL40UseJIMPkeeAPd49txhE
         9XmFG6MrqxhnQz+tW16ybJen1o8u1QBqPYxyQDZy3iu/9uXMO3dAlUedImkH6b+tWmPN
         VstMtZQ06gf1Ekw+WOxLyCwMA3epOf6saHlLDEyc049giTfGk6ADIFADUHQp/C2BAhqS
         xcPy2WI7+dp6HYjxTOYY7i0VU75SJfADwiRyjcyXxZSapQMjfzmxDiB7VM1ZiA4MGBBD
         bnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706016; x=1725310816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+K/X6YqDrxWE8WA9haO3ONaWPfQCU7jkPm8tQUrtw4=;
        b=uVt0SQW5VuW07VFz/dr5ebjvl8zUcM/C7eqzq4Y/NO72xkp72aAnRGnpRVUnUOtCRN
         Tb95ej6C+mn3D2hkxe1aSwudihSTnmzT4uLsSA31uKPewJQ2GAFokQV6Xa0vpdQ8GRGe
         tuTjMmxMY1h4eZoI6dXLf4SzoLeaVIUcG/AJlzrAW97p3iXw37GCa7C6HoQ7JoCDFv3T
         FtFRZgGxC2ts5UwOphG4MEmHPHaGtCNLjkSFrD9l0IERyONEKKMrL7xNBhw1XtdG6Ext
         a2FG4MRptIEQxkIvJJxTlPRl7ETiq+ByVJfuUxChATrphjd+ruQSTNPTReWbY7HBcF0F
         5JeA==
X-Forwarded-Encrypted: i=1; AJvYcCVXVH1Vwp0YL98TPOyZJkq1vQjgw1n9esHZU1ZR3Ua0hJnr7QfQYMpcj9E2UgPBG2N21yilXNFTRrN0UJNj@vger.kernel.org, AJvYcCWuotr1oC22pQw3nQQzpQrqMC3EdMkdHItNdjI8M3VrsuoKinz7f2/JRGtjdtx7Sr+N1pSavq+A0/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwESmLWt9rg+dym6GOGK25oZCGPH0thhF09wyoDOdOX1QOIx7bh
	IUjOHgnCpRDpqA8MmNehkv686R0qlTYUU0ApX8l56Wi3gn574ra/Ohcfuvcu
X-Google-Smtp-Source: AGHT+IHvo4aNhV61UXRKNmGdlU/GneWr8ZeoPl4Pe6b7lg2FN9IOF450ZcfDSy6E3fdjSXfvaFiYiQ==
X-Received: by 2002:a5d:40c5:0:b0:368:4bc0:9210 with SMTP id ffacd0b85a97d-373118566d8mr6369089f8f.25.1724706015194;
        Mon, 26 Aug 2024 14:00:15 -0700 (PDT)
Received: from [192.168.1.127] ([151.95.157.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefd9cd1sm203379685e9.38.2024.08.26.14.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 14:00:14 -0700 (PDT)
Message-ID: <1a8adbc3-e8b3-4133-a2dd-449d584d8e8d@gmail.com>
Date: Mon, 26 Aug 2024 23:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] iio: bmi323: have the peripheral consume less
 power
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>,
 Jonathan LoBue <jlobue10@gmail.com>
References: <20240823192921.7df291f8@jic23-huawei>
 <20240824141122.334620-1-benato.denis96@gmail.com>
 <20240826114129.71f417c5@jic23-huawei>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20240826114129.71f417c5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/24 12:41, Jonathan Cameron wrote:
> On Sat, 24 Aug 2024 16:11:21 +0200
> Denis Benato <benato.denis96@gmail.com> wrote:
> 
>> The bmi323 chip is part of handhelds PCs that are run on battery.
>>
>> One of said PC is well-known for its short battery life, even in s2idle:
>> help mitigate that by putting the device in its lowest-consumption
>> state while the peripheral is unused.
>>
>> Have runtime-pm suspend callback save used configuration registers
>> and runtime-pm resume callback restore saved registers to restore
>> the previous state.
>>
> For future reference, don't send new versions of a patch series
> in reply to previous version. It's a good way to ensure your
> code does not get reviewed as busy maintainers and reviewers
> tend to start with latest threads and this style means
> your patch ends up way off the top of the screen!
> 
> I don't know if other subsystems specifically ask for this style
> of reply, but the ones that I interact with all specifically ask
> people to not do what you have here.
> 
> Jonathan
> 
Hello Jonathan,

Thanks for the heads up! I didn't know and now I do.

Thanks for your time, patience and guidance.

Best regards,
Denis

>> Changelog:
>> - V2: patch 1:
>> 	+ change patch commit message
>> 	+ drop removal callbacks and use devm_add_action_or_reset
>> 	+ split bmi323_init in two functions
>> 	+ separate regs to save and relative value
>> 	+ drop unhelpful consts ptr modifiers
>> 	+ add a comment to explain why BMI323_FIFO_CTRL_REG is
>> 	  being used in runtime resume
>> - V3: patch 1:
>>   + drop a struct array and replace with an array of
>>     unsigned int: u8 was too small and it would have resulted
>>     in overflow of register addresses
>>   + use single-line comments where possible
>>   + drop useless comments
>>   + remove intermediate variables
>>   + remove blank lines
>>
>> Previous patches obsoleted:
>> https://lore.kernel.org/all/20240811161202.19818-1-benato.denis96@gmail.com
>> https://lore.kernel.org/all/20240818150923.20387-1-benato.denis96@gmail.com
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>>
>> Denis Benato (1):
>>   iio: bmi323: peripheral in lowest power state on suspend
>>
>>  drivers/iio/imu/bmi323/bmi323_core.c | 155 ++++++++++++++++++++++++++-
>>  1 file changed, 153 insertions(+), 2 deletions(-)
>>
> 


