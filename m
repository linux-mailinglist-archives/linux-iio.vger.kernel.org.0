Return-Path: <linux-iio+bounces-12241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331899C8697
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDACC1F23DF0
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A21F9A8F;
	Thu, 14 Nov 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f93QS6cM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE71F943F;
	Thu, 14 Nov 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578081; cv=none; b=WuXYcjvFCAqBuH8bb2dlyJzLwWE8Fgf0obwwHQmxojHEj8v3D1ypaS6/D9/pllUoVNVGIXFh0/S+FS53C3Bb8U/D/Chj2eUzpr9s6LIIhZxUR76XH6mlvNLnJmp76tM7sb04SP2k3+wwclg0NqY1gfstQWdoVAISZed5CyssAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578081; c=relaxed/simple;
	bh=IPpQBdmprs58cfaC6Ih1JMqBBM85BFaBkp/bsB43ZyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAiixdEQpR8jU0ZCtApadDp+u9XKwX+mcSMROPXiIDnnYkThexX28E4yeCkjlsmLoxebtkCgX/9lhym6dfnfgdqKMFdGTXdb+NUDbp/+sR+sc6CF8GdihevYyXDWBhQdGUQ4X2S6jQ55W83OVYX94y6QCz2nyT7l4ins3kfm/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f93QS6cM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f6e1f756so353578e87.0;
        Thu, 14 Nov 2024 01:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731578078; x=1732182878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbjwQvSI09oTn8d8bmV+CXjrqfJSg3x056AtcnIu3IY=;
        b=f93QS6cMVs05wgJVS66j8fKqXTv6V9JoOkqmQ7SASXA8LdOKXZU0/5y9OZRXRGX2Iy
         KlvTactwLJJWTr1rsI8Qipn47JJ/PVMoOIrl/lFBa6/cktoyBU3MukYvL9Xuv6zlShcZ
         lGoCj37WgSdfm/5+kKdY4UVfRgt2Vn4YeP8PWezQz8gMsMWQo5saBypqHR+fQLgMmbel
         jNVarK85c/y6ZbLnKWYihd8alOaz9qthHT/ga00fIkqA2aq9Jkdg92WwbBKNdjckWUQ3
         s+TJn/xW00aIT9kst/osuXmhZCmrUfyqu60StZvCa7zgkauc9Ltkx036S4kf2V6GHlAF
         bztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578078; x=1732182878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbjwQvSI09oTn8d8bmV+CXjrqfJSg3x056AtcnIu3IY=;
        b=j+rqj8dJly7pZwWIudTjzkvdIbyAEwokfrbqJyxkJgGSfiAD9CY/kTB8EKuHmg/LlJ
         eQoHStEGlrY4Vz6Bihytl3f7I89w3DAsWxRqo/Lu8Ybg6BfcHIxHFFE33gh8H0fXBd5c
         s6JjzxonOA1HU7jKZ3kWLg3ciKc62HY6Wg26YK5PfyN4GxxOIf6ywWGbq5gMG98DRc/x
         xP8kysUSIlTBRHQGqpbuuHaRHjWYX2n6/qj7o5zHlo/1/LcUV1AtwuSO7GWSXGV4nua7
         byW9MMtWkDYiYOLYEIUK5CvWPoMJFC3afcQpGeqllpuQtICdwUX/sOY0UME0VuMuFdhM
         t0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBqiF78/R5F8MFXSQW4hlei4UwRyP1QImeImuy3zMENBCoKVP2DymVlnfqkHlt2eui5/8+z1GThKM=@vger.kernel.org, AJvYcCXPAfLjpeLtH1YmVs8B4zot96WdyBuF88Qyk4XheSMo6F1Egj2ibzdr3j0qylbMeFxGU8AxYZJef++o2ZBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPR6fOYzN/G+tPDQ6qunNVHOLFDMHRQXvW9qOWBaJffK96Mm62
	R/p9YgyHdLCz/PSjtPzEkqQabs9dBXrz2J9YXz7EhOW7AGTdy0Fn5VIb2xq7
X-Google-Smtp-Source: AGHT+IHMdywmHI/GwsItlI9NB0/xI9K8gaW1U1K4dwX3pO+CHnZH9c5vhIhfADM+Rn9IB8K3vwjDBg==
X-Received: by 2002:a05:6512:3b83:b0:53d:a86e:42d7 with SMTP id 2adb3069b0e04-53da86e430cmr439825e87.49.1731578077362;
        Thu, 14 Nov 2024 01:54:37 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6531042sm126472e87.153.2024.11.14.01.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:54:35 -0800 (PST)
Message-ID: <f4cf3437-87ea-4d0f-8dab-890d89f85605@gmail.com>
Date: Thu, 14 Nov 2024 11:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: kx022a: Improve reset delay
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZzWfXbjaDkFnu_Jg@mva-rohm>
 <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/2024 11:43, Nuno Sá wrote:
> On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
>> All the sensors supported by kx022a driver seemed to require some delay
>> after software reset to be operational again. More or less a random
>> msleep(1) was added to cause the driver to go to sleep so the sensor has
>> time to become operational again.
>>
>> Now we have official docuumentation available:
>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>
>> stating the required time is 2 ms.
>>
>> Due to the nature of the current msleep implementation, the msleep(1) is
>> likely to be sleeping more than 2ms already - but the value "1" is
>> misleading in case someone needs to optimize the start time and change
>> the msleep to a more accurate delay. Hence it is better for
>> "documentation" purposes to use value which actually reflects the
>> specified 2ms wait time.
>>
>> Change the value of delay after software reset to match the
>> specifications and add links to the power-on procedure specifications.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Sorry for not including this to the KX134ACR-LBZ series I sent
>> yesterday. It was only half an hour after I had sent the KX134ACR-LBZ
>> support when I was notified about the existence of the KX022ACR-Z
>> start-up procedure specification... Hence this lone patch to code which
>> I just sent a miscallaneous series for before.
>>
>>   drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-
>> kx022a.c
>> index 32387819995d..ccabe2e3b130 100644
>> --- a/drivers/iio/accel/kionix-kx022a.c
>> +++ b/drivers/iio/accel/kionix-kx022a.c
>> @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct kx022a_data *data)
>>   		return ret;
>>   
>>   	/*
>> -	 * I've seen I2C read failures if we poll too fast after the sensor
>> -	 * reset. Slight delay gives I2C block the time to recover.
>> +	 * According to the power-on procedure documents, there is (at least)
>> +	 * 2ms delay required after the software reset. This should be same
>> for
>> +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and KX134ACR-LBZ.
>> +	 *
>> +	 *
>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>> +	 *
>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>> +	 *
>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>   	 */
>> -	msleep(1);
>> +	msleep(2);
> 
> msleep() is not advisable for something lower than 20ms. Maybe take the
> opportunity and change it to fsleep()?

Thank you for the suggestion Nuno. I did originally consider using the 
usleep_range() since the checkpatch knows to warn about msleep with 
small times.

However, there should be no rush to power-on the sensor at startup. It 
usually does not matter if the sleep is 2 or 20 milli seconds, as long 
as it is long enough. I wonder if interrupting the system with hrtimers 
for _all_ smallish delays (when the longer delay would not really hurt) 
is a the best design choice. Hence I'd rather keep the msleep when we 
don't need to guarantee delay to be short instead of defaulting to 
hrtimers or even busy-loop when it is not required.

Do you think I am mistaken?

Yours,
	-- Matti

