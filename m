Return-Path: <linux-iio+bounces-10483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE499B2D3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2151F22422
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17581531D2;
	Sat, 12 Oct 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRUEo7jh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730B9479;
	Sat, 12 Oct 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727727; cv=none; b=LLmkTW17ynN3n5zzdAbHe83pch57G6xOvh68ujmS9kg0RIvcYoCWZidrXFthy0//1aP7b3DlUhAW08JY+LXaZKCF++mpwuhiz9OvVjA0/TbMm/fvOrtdFWd1zaNcUnGx05pbmGkABlkZJeLRLcE5Ec6Japt1JH72bKDuiZqFIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727727; c=relaxed/simple;
	bh=VejCG9SK11GPW4Puok5PFtfOa088c0k2EBQLahUazAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2p202u/LK9N6PaYncS7o08/WJxjoIPrg5Jf9Gxb6M0Ts6AFsQuYY2GXp+WbAswn9QsQiIc5a4P2E8hd//IScMtGTMQsbtDpnDDpUkOhPTeiBO/bwZruuFBo7wnqT/KVHcc2BCSUN7LzgZHQVf1OweggQM9KR6TFDiyM87aLL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRUEo7jh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4311fd48032so8973245e9.0;
        Sat, 12 Oct 2024 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728727724; x=1729332524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kX5mriekr5Ocrm8tWdj2wKvGlcuqBXp83tQmMuAVRsg=;
        b=PRUEo7jh+j863pBKFTHhCbGZWnXHyJq0bAWZpz1ZDPLexgklLrg7LFt0pJVPs8YzoM
         UxLElS6oCRf4N7k3Jqmg4saRvO3kgV+bJv5ekJC2clWNp1vFy97vqSVQPbtLEt2nCooJ
         jsL5cPfwRQvK6xDY8MZgP5OIF/et+lqrgM3d4vaMei4T8KZwuQN24d6Z9R7AI+TDgUkx
         +e4a/SPr6EuoFuFJXsx4Gx1BOoaL/8GiH+3p7PFJnCbZMdT7inYXhpX50A+mQZEJx7fr
         QrC7NFeKIKKw7/VQujbrKV8I/smJ9ZJMHQ3GJBhd9Wjl5cJD/hLC8ekcp4vGOvtjQe2x
         /eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728727724; x=1729332524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kX5mriekr5Ocrm8tWdj2wKvGlcuqBXp83tQmMuAVRsg=;
        b=JQSqm1feKsstCQIeq/nwsPCu37RjwvRbaelqbrj0wHoSTmmZck5+QazDjFujdOplt2
         BwibtxKlF5V9tEX95OfpButOqzWkDTo2dD8SmTvjyr5KnBuyeF5wsZGzuZcM6gXqDGNR
         z6t2AmF86Vof44ZhiojWtiIsR+A77G67Fd/3z/AHToplJnc0KLBFsIYZemI1oqM3SNdA
         CmNZnCkU+eE3V4nEP6yLJ0HX7z6aNLfvRg7FcAgphCQSe7W4ppysiVhqskfBAgMquXh9
         c8OGodmcaN408SEK6AXLEbwbZDijTISO/p63qIMh2pWT2V6/ywBVtTAiiw+b6RTHW69U
         t7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR0f+QkbcaA7kGFpR3cxcNE3f9qoFUUqSDoTJd0PmFLeP+HaD+SBzZHSeP9GRDNLbSQvkTcTVAE17VYnJt1lg=@vger.kernel.org, AJvYcCVwbf/FMyFiAl+hDHylZ371ov1Plwvm0hMCQ4+sxA5eBA8JO0bB6udsC496Rp0HqCYHuyuAQ/LJuOYH@vger.kernel.org, AJvYcCWnBZjgv24RlCMlXheqxxF+Ln9loHMzcDJxlZCf0DYXgYZTzmnxaE7l+in0pd5fycbt32rASDMIEKg1klua@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbol2JZdwVMHSo5c7nDQXXuhAFzzFX8XET18a19OWmuMXxD7S
	a22ZnGuCzwj4ntaprlJo+mcn8bRAHG659GomCYYpa4wPlw3V0HqFmAM1enBX
X-Google-Smtp-Source: AGHT+IEoTX29G0T+6mJ+CjZxCK4Y7mxjDZiy7ui8UQrpuf2+n2Os0JzsumpY0HDp6EIPHwreFfBdYA==
X-Received: by 2002:a05:600c:474a:b0:42c:a72a:e8f4 with SMTP id 5b1f17b1804b1-4311ded55e9mr44633365e9.14.1728727723755;
        Sat, 12 Oct 2024 03:08:43 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:143a:73ee:53ce:7dea? (2a02-8389-41cf-e200-143a-73ee-53ce-7dea.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:143a:73ee:53ce:7dea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf43da8sm96053475e9.11.2024.10.12.03.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:08:42 -0700 (PDT)
Message-ID: <e210f9c6-9070-4b6d-b938-9a35b7a16380@gmail.com>
Date: Sat, 12 Oct 2024 12:08:39 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: bmi323: mark bmi323_ext_reg_savestate as maybe
 unused
To: Julia Lawall <julia.lawall@inria.fr>, Su Hui <suhui@nfschina.com>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, lars@metafoo.de,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, benato.denis96@gmail.com,
 Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org
References: <20241012083701.2189663-1-suhui@nfschina.com>
 <alpine.DEB.2.22.394.2410121110540.8471@hadrien>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2410121110540.8471@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/2024 11:11, Julia Lawall wrote:
> 
> 
> On Sat, 12 Oct 2024, Su Hui wrote:
> 
>> When running 'make CC=clang drivers/iio/imu/bmi323/bmi323_core.o', there
>> is a clang warning as follows:
>>
>> drivers/iio/imu/bmi323/bmi323_core.c:133:27: error:
>> variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted
>> [-Werror,-Wunneeded-internal-declaration]
>>   133 | static const unsigned int bmi323_ext_reg_savestate[] = {
>>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> Mark bmi323_ext_reg_savestate as __maybe_unused to silent this warning.
> 
> Why might it be unused?
> 
> julia
> 
>>
>> Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>  drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
>> index beda8d2de53f..1167984809c5 100644
>> --- a/drivers/iio/imu/bmi323/bmi323_core.c
>> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
>> @@ -130,7 +130,7 @@ static const unsigned int bmi323_reg_savestate[] = {
>>  	BMI323_FIFO_CONF_REG
>>  };
>>
>> -static const unsigned int bmi323_ext_reg_savestate[] = {
>> +static const unsigned int bmi323_ext_reg_savestate[] __maybe_unused = {
>>  	BMI323_GEN_SET1_REG,
>>  	BMI323_TAP1_REG,
>>  	BMI323_TAP2_REG,
>> --
>> 2.30.2
>>
>>
>>
> 

This issue has already been found and discussed here:

https://lore.kernel.org/linux-iio/AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com/

where I got lectured by Nathan Chancellor about such warnings.

The fix was not marking the array as unused, because it should have been
used. The proper fix can be found in iio/fixes-togreg.

Best regards,
Javier Carrasco

