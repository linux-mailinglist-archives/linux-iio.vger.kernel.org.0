Return-Path: <linux-iio+bounces-13113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7F9E5193
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 10:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105F918809C8
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4461D5CC2;
	Thu,  5 Dec 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWB6B8aD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193611D47A2;
	Thu,  5 Dec 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391747; cv=none; b=J6+i8iRK0Ntb03Rpbuk8yFL4z+A8znm6OvtQSb0cfLaKQchhjMDBTIMIlK+T2QD5zTIK4pfARykRyaNigOKp9YEgVEkfIY0h6Oyijg04wPwXiEufcY1lFsOCJqH86eUsZetw3+7pocBo0HBICB9kDJEqR19nZ+FHDp5VFoMWKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391747; c=relaxed/simple;
	bh=uMfTwaW+z1uixy5zgQAaP5OlpK7VhcX7/nfcxPE3qYE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fn0/hhW50bKf6c5S+OCoSzinnuDpbiso63wABC9FuvZje4rABhQKuoMR+2LoZU5iiLcBaY45Elc2GAqJLu9kMP+kw/Sh5gvwHTFeVbkJTB3gjwS82zrdHCa9g1/dT3BomQJSsuBmOd/Bkt9W9tiHtgSS43gaYlG0vms2XSwnZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWB6B8aD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so784112e87.1;
        Thu, 05 Dec 2024 01:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733391744; x=1733996544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6QUY0v5q5a5aeJy9BcvmDe3ZKrjse/FVqfzz1Ow9ERM=;
        b=jWB6B8aDWurrYFb/foKON8WdsSLpPUioPMmCSNCobwILVt12Idi209uMN4TVRWKttX
         kooDgzly42hJ6A53jA/HQ068rEJ1jHuD+E4xjAXuy6p097N0/kP6Zv3/JbgdFVaXxwKu
         pK8VQCqy2ICOcXyAnCrb+y1Oze5x78D7v2jFyjpt9Z01e3KmifFE7bRzCv65CyLxW58f
         YCffwY4XuNx4em8zJHC5hxbxNnG/z8Y7HXcJAymg3EDQCazsFZp/Nx/CRoj398QPG9Fu
         inln3ikAy0SDUcrUUMI4Nr+RUXpXXRSUyzV/Kb2pq+DeToetZlH3/0BVjN+wwisvNucz
         oQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391744; x=1733996544;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QUY0v5q5a5aeJy9BcvmDe3ZKrjse/FVqfzz1Ow9ERM=;
        b=jPKXYzgvxkpDP88Z0XSxxAY1TeFzxbwfyfCUB2dlRikJeOxJ0rgiu/s+IX8EF+IvGr
         u5oU33tKttIz7bcitBxylHZRkxL9CE+rUB8o1e+TANVLh6mZoF7Zz5Pcd7dqHlsECHoN
         m1EFQYDJoy+eVkXILUkvI1sgb3gVDVRvq+k9Oh1qK8gUWcJW8Tp8RMCu911ebLa3u/wm
         T1YF/qu+hCZarRF9tDBduYq8yjKlI3gD4Kqk3ybBdG67fPRoeA5Ms8sOJu+eNVcn0ISc
         lEfbVE7Fu3nCvDUV7F5nQ+GRnXYQkHmmnfK2zrBOeoriNyhKdZtQxEL3dTyBWF10Gh/6
         SzZw==
X-Forwarded-Encrypted: i=1; AJvYcCV3IKv2nHpGOhkSDkgt+zuAMtruUn4Y3TuDi1H5aGKZSntSi5isfvXshx7iCc6OtIB9bLX4s5ZiRbDEmyP7@vger.kernel.org, AJvYcCViIDRAxJ1UpnvoTOKAZUSkGHS1kusavzm0uOD0ThsKWFNEaVLWbKe+fnYy9p4CvSUva9FlBR5oBb4o@vger.kernel.org, AJvYcCWHNbQjirX3kg7QBm9IBH4fsYQ9NBMSWYmIRL7fdxq89WP+P5alCgeXl9nL1kPVpOOOFciB2GvNxw7U@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLAZk9UqpC/v7PfB5XMiBhVlfSk3FEamGOT3NtYMk+OCwztlQ
	KrUOsqeBwVaq5zvbop/0rd4sP4QbwS1oq5UJmSTMKlGHNj9AQAp+
X-Gm-Gg: ASbGncuNW7Hxt5/yKTm2YjMnqwuHnVS2SK3INmWIwIXL2+AHSYHLQfmxOcVIki7rP1+
	Oaw1JaJrG0vV8Z3Sb9TlRZQYM7LVBMYdlE6SkBbCzHaN4OrZKbs/VtXu9eoeUd2xV0NGrapp6Zx
	YKRxvWTaPhAHRI9oUvfcxiKFjVOlVVaE6Xemu+NPMUaK4sswOcD5RHySs+noUoYeF5JYunMmGxn
	E8dvWT4fD05fxZ4RbwNMuyP4clblvPFCbIgJbPbuP4hvxlZgAAJ9O/nPpSph2B2IZ275T45W5VG
	2AHePVSNsmEnsQPOckts6GqAIQwbC04=
X-Google-Smtp-Source: AGHT+IEfSRZ7J9WsY8VKTHBNKbsM71xhiPnLOEwNnwRYWWpfDNYDHMn8qsh4P9CGnvF0ibeS8Nxx0g==
X-Received: by 2002:a05:6512:118e:b0:53d:e544:3fda with SMTP id 2adb3069b0e04-53e12a31939mr5282564e87.55.1733391743946;
        Thu, 05 Dec 2024 01:42:23 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2294792csm181423e87.1.2024.12.05.01.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:42:23 -0800 (PST)
Message-ID: <7194cce7-5082-4df5-8599-186c2e39c599@gmail.com>
Date: Thu, 5 Dec 2024 11:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Cc: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
 <20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
 <20241124211545.194a9f87@jic23-huawei> <Z0eY+1X1ZSkNui9U@uva.nl>
 <20241201132054.0c063a11@jic23-huawei>
 <9d810e5c-c7a5-41e5-8073-b703717faf3d@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <9d810e5c-c7a5-41e5-8073-b703717faf3d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/12/2024 10:22, Matti Vaittinen wrote:
> Hi Jonathan & Mikael,
> 
> On 01/12/2024 15:20, Jonathan Cameron wrote:
>>
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, apds9160_of_match);
>>>>> +
>>>>> +static struct i2c_driver apds9160_driver = {
>>>>> +    .driver      = {
>>>>> +        .name    = APDS9160_DRIVER_NAME,
>>>>> +        .owner = THIS_MODULE,
>>>>> +        .of_match_table = apds9160_of_match,
>>>>> +    },
>>>>> +    .probe    = apds9160_probe,
>>>>> +    .remove      = apds9160_remove,
>>>>> +    .id_table = apds9160_id,
>>>>> +};
>>> First, regarding the integration time/gain/scale parameters. I took a 
>>> look at the datasheet again as there is a table
>>> provided to get lux/count (scale?) for the ALS sensor depending on 
>>> gain and integration time.
>>>
>>> It looks like the correlation in the table is almost linear but it's 
>>> not as there is a loss of precision.
>>> For example, at 1x gain with integration time 100ms the lux/count is 
>>> 0.819 but at 3x the table is stating 0.269 instead of exepected 0.273.
>>>
>>> Is it still possible to use the gts helpers in that case?
>>
>> Ah. Probably not if it goes non linear.  Matti? (+CC)
> 
> Disclaimer - I didn't go through the patch and I just respond from the 
> top of my head :) So, please take my words with a pinch of salt.
> 
> AFAIR, it is not required that the impact of integration time is 
> _linear_ through the range. The "multiplication factor" can be set for 
> each integration time separately. So, it is perfectly Ok to say:
> 
> time 1 => multiply by 1
> time 2 => multiply by 2
> time 10 => multiply by 9 <= not linear, as linear would be 10.
> time 15 => multiply by 15
> 
> ...
> 
> The notable limitation of _current_ implementation is that the 
> "multiplication factor" needs to be integer. So, this may result loss of 
> accuracy.

// Snip.

I ended up re-reading this mail as a result of running some of my 
public-inbox scripts...

...and I noticed that the non linear correlation was not about 
integration time, but about gain. Eg, if I now read you right, the 
integration time is kept constant 100mS, and gain is changed from 1x => 
3x, which actually did not bring 3x gain to the lux/count values.

If this is the case, then the GTS helpers aren't likely to help you 
much. Sorry.


Yours,
	-- Matti

