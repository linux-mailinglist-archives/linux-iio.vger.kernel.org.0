Return-Path: <linux-iio+bounces-12722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2109DA000
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 01:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A567284AD4
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 00:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECC11C27;
	Wed, 27 Nov 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF6RzbQL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE4A23;
	Wed, 27 Nov 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732667443; cv=none; b=QhG3CzrR6I1ZquzXod16R+WDRD9PHOgbyl8yE6NtWgmpGlnPLK3x4qlKeBnzpAAeQXoti1WO/z3FyDqnEemu12n2W7bVGCj5nd8CLdGDCdZl9wkmlzfaZgyjQ/DtEKcIW5vCnZdBClT0blcqg6KwZkOx5J4UHT8MVZi9v6Xx9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732667443; c=relaxed/simple;
	bh=B/XP/5li46wEXl9jRgvnOXy0VBsDGFE+to1Hlxg9ikg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L4NEZ0+qrA/RnU6BJ6zj2HF1Qh8aOxcPa+78lNfRQpTzczxd/sR+2LvH/KlpH59CcePgm6PBlikOnOh06pc3gpu3tM8U+Ru3rFpBqXqkE3lk0SSE9K4ONsGAl3siIKAUDZUFX1ZJr2o+AwA1orB+WabP/9Ox8a35pwhNKdtXoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF6RzbQL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so57253705e9.0;
        Tue, 26 Nov 2024 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732667440; x=1733272240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ej8tv2A3HWZXC2wma35bhFGNWRxHqMQLJ4mpt4LT9Bk=;
        b=LF6RzbQLCA+04o86SXHcLkQgWF+u4D3YnafKkE5gaYAOlc4G/YA5jaoKz3gsTpHb19
         I/PYFRdwWQiSQ+k6Hi0wCXi/+NjmaO1qNto5JVBCOcuLt3hbT+gXjQS3689nlmvtObim
         ag43KcMupEI/xMrCfyrKEV+kQDyLK9V+r/j4TDVW2/PRLoISMF4/bGd4FZ+fUVCl8xuW
         FVFqalX6JSDF8EIatxIWwBrX9BWr4buEbAY21mxJo3XPtq6xFXHUwsjhEJpIOGAzTg23
         fK7PxSqshTNr/N5klzZazVZhQ0eoPDpuEbo80jmYZyRXhsxNKkbTUmqcBQWOlR9cNhB6
         247Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732667440; x=1733272240;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8tv2A3HWZXC2wma35bhFGNWRxHqMQLJ4mpt4LT9Bk=;
        b=qxSu9dCY1gfj/uP0ceuuRWrL5O1zaZAqskhNGqQlGr1m09Iv5sG+u9gaX/VdeE2vCj
         f7zuSh1M1U+MF1H7MojoniAHUfKPivGXjex2IeN0pocOh5O8TlOLI0FJtMK9NTFlqEJV
         DgrMu+8m4p20QlQSkXoO0b5xQ3BbXbNybn7cujrwi30uHi5MtvWsYf6xcV1y4oskUw4A
         xH6p67dRLvuYEIS26eupRE486P0lkvBfKLMKjZB3fZUql/LpyuX+2QY/newxJL7rEqJ1
         uWF0LbevJH59J8u/k6B1RYLBlojs7URzEN4zjJ+L8H0PHXIHyYwA7tsZxvJm8Ek00ZCe
         JxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfEX8Cplxj4HbTd/QUpWM4Ne/NWGTfDaYFx4uYdsUgZGp62ewU5+JkWqrDQcswAawa08ksTTT4uSg=@vger.kernel.org, AJvYcCWgH3OJtwc2c24LW9URN0UIPsDcRhG60Popvvr75ni4ZLsKmx4VNo0jGIAwsfR0BA0bqYgVyiDQ@vger.kernel.org, AJvYcCX94igKltFjvOgBc03K+0NxwIyQWNTlGyFiJMuMxfkGIzT/4XZT6cGlcLwBoZ/AYsd9LHL51gmH/yJcIucS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3wUCLFKpnELDRhlgnE6FwoJF8/qF4p2d5SB3rFa2LwX4hpwO
	wDRiB9UGbfnqr6oRbP07yqX95FsOPIchEIE4l/1qkn+rsMyJfWit
X-Gm-Gg: ASbGncvZXs+fU1jLXQOvyfBHmMH9Yz1TwNgnVZfAjsLPHcnu0oJHxM+TotV3XXEAbFj
	OabZetLuu5PXP683vihTZXntHBr45ch0FLRDqIZlsL27IXbDHb74gZc58P3mW0gaaJctlbTVZCJ
	psJ9/Lk4dsaUPGQG0jBvgiQMUQRKu2pQMbWZM8PthK8OyEytImUSRb5cicDYxzh1eDLwRQKyNMu
	xwYND8uTAMw+kSmJEqtSmjhVQd6G2vs7sdLQ0ZoqntB0i2Xm2o9ksK7ExC7tys9V+IWuUso6hn+
	sJv3f0lz3HexG/zhYQkxE2I/vIzuEUP/rV4T9KdQOirLrzyiHF/Kf/Ko7wm/xjxBN2thge9LIui
	ksDLxChrTIFZ37P3A7er/arZXbsmYfjc8SmDNC3bRY74=
X-Google-Smtp-Source: AGHT+IEPN/MJAsvPH/wHNl/SHEw0ZMIZ1SSH4y1SpB0BkcojvZudR4bbqDNjOWlU55rWqsIvScXncQ==
X-Received: by 2002:a05:600c:5253:b0:434:9e1d:7629 with SMTP id 5b1f17b1804b1-434a9e07911mr8451625e9.33.1732667439604;
        Tue, 26 Nov 2024 16:30:39 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:2880:ffb8:6aed:9f0d? (2a02-8389-41cf-e200-2880-ffb8-6aed-9f0d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2880:ffb8:6aed:9f0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf63sm14723779f8f.102.2024.11.26.16.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 16:30:38 -0800 (PST)
Message-ID: <98feceae-2146-478b-8296-d3a41401dbf9@gmail.com>
Date: Wed, 27 Nov 2024 01:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie <gregor.boirie@parrot.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, stable@vger.kernel.org
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
 <20241126085958.GA13577@francesco-nb>
 <59a4b096-101b-419d-8a19-1063d759b4e2@gmail.com>
 <20241126185211.385f82c4@jic23-huawei> <D5WG58I3QIEL.7Y7EGKOC7AS8@gmail.com>
Content-Language: en-US, de-AT
In-Reply-To: <D5WG58I3QIEL.7Y7EGKOC7AS8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 23:00, Javier Carrasco wrote:
> On Tue Nov 26, 2024 at 7:52 PM CET, Jonathan Cameron wrote:
>> On Tue, 26 Nov 2024 10:46:37 +0100
>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>>
>>> On 26/11/2024 09:59, Francesco Dolcini wrote:
>>>> On Mon, Nov 25, 2024 at 10:16:10PM +0100, Javier Carrasco wrote:
>>>>> The 'scan' local struct is used to push data to user space from a
>>>>> triggered buffer, but it has a hole between the sample (unsigned int)
>>>>> and the timestamp. This hole is never initialized.
>>>>>
>>>>> Initialize the struct to zero before using it to avoid pushing
>>>>> uninitialized information to userspace.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
>>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>>>> ---
>>>>>  drivers/iio/adc/ti-ads1119.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
>>>>> index e9d9d4d46d38..2615a275acb3 100644
>>>>> --- a/drivers/iio/adc/ti-ads1119.c
>>>>> +++ b/drivers/iio/adc/ti-ads1119.c
>>>>> @@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
>>>>>  	unsigned int index;
>>>>>  	int ret;
>>>>>
>>>>> +	memset(&scan, 0, sizeof(scan));
>>>>
>>>> Did you consider adding a reserved field after sample and just
>>>> initializing that one to zero?
>>>>
>>>> It seems a trivial optimization not adding much value, but I thought about
>>>> it, so I'd like to be sure you considered it.
>>>>
>>>> In any case, the change is fine.
>>>>
>>>> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>>
>>>> Thanks,
>>>> Francesco
>>>>
>>>
>>> Hi Francesco, thanks for your review.
>>>
>>> In this particular case where unsigned int is used for the sample, the
>>> padding would _in theory_ depend on the architecture. The size of the
>>> unsigned int is usually 4 bytes, but the standard only specifies that it
>>> must be able to contain values in the [0, 65535] range i.e. 2 bytes.
>>> That is indeed theory, and I don't know if there is a real case where a
>>> new version of Linux is able to run on an architecture that uses 2 bytes
>>> for an int. I guess there is not, but better safe than sorry.
>> Using an unsigned int here is a bug as well as we should present consistent
>> formatted data whatever the architecture.
> 
> Would you prefer that in the same patch as they are related issues? I
> could switch to u32 in v2 along with anything else that might arise in
> the reviews of the rest of the series.
> If you prefer a separate patch, that's fine too.
> 

Although now that I am looking into it, and according to the datasheet
and defined scan_type, the right size should be s16.

>>>
>>> We could be more specific with u32 for the sample and then add the
>>> reserved field, but I would still prefer a memset() for this small
>>> struct. Adding and initializing a reserved field looks a bit artificial
>>> to me, especially for such marginal gains.
>> Issue with reserved fields is we would have to be very very careful to spot them
>> all.  A memset avoids that care being needed.
>>
>> Jonathan
>>
>>>
>>> Moreover, the common practice (at least in IIO)is a plain memset() to
>>> initialize struct holes, and such common patterns are easier to maintain :)
>>>
>>> Best regards,
>>> Javier Carrasco
> 


