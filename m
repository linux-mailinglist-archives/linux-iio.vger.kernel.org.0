Return-Path: <linux-iio+bounces-12475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB29D5970
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 07:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D644282694
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 06:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5221632DC;
	Fri, 22 Nov 2024 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIfs+Zin"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD21161326;
	Fri, 22 Nov 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257637; cv=none; b=gUsOeYB5C2llhx63TVG+ntqdh/8WIjVYclyo5eaRf9FrtgwkfdQAWwYGA3ov7CdN3AEDPYfeLoeHgrJv72hXmX+zpORc9oyHlMP7dalIER+QGSACWBb0QBah6GJiKA+DM/e3Me5RzxWgSiwwPqV6rCapRY+hKmazSlfDX4SuKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257637; c=relaxed/simple;
	bh=BsO+LAToUDxCWi2NFrw3UpPFMojHW/5CU09E2A/jXJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6pvANRyk9MeD99AIT62Hwbkor4E3DtxQtHbEZxZPYVYYTwPf9AHk0xWDoFJQljCyqNkxUkAbz+cMR/FVOW/3Ufg72ccv/CFPD+bQBrL3nTaDENyF3usyupOfMu2WGmyKp0+j4quJPigcgfB67zFvD3M60X6IRNB3GzAfBwT01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIfs+Zin; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so15227435e9.2;
        Thu, 21 Nov 2024 22:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732257633; x=1732862433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVPRGiUo6/c2A8u5sXzy4yvVHTieIeC98R+z5/i0b+E=;
        b=MIfs+ZinUF7KCbIFYEqkTt/HWxIeKIrj8NVLIB5AXtK26cYu7D/o7R3tfwkSMZ45n5
         iaF+qeQQB2SO0Il+Rkb0CxXemxcHvjLXFxUMgckdsffKxbdbu33YTqBDG17nIzpLbcxE
         f6vNT5DVOcuxtCXgb3D9b0OJ/Ps1rcFLBkkYOdvtN4mniEW0jx8YyI1zBTXHul6zJMKK
         flfSPS4+xAc/xoqBq7wL5oMJlBYqBQcjCzmyktLegYfiN7oVMSmnlsnctJKjbwIAnlo/
         egH0R+qgY226V9lGHe8ocAUGkWIuhojaDuTpMvXVwGx8897H/IOlREFjpzc8d/abvY4E
         34WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732257633; x=1732862433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVPRGiUo6/c2A8u5sXzy4yvVHTieIeC98R+z5/i0b+E=;
        b=ExISO93Y0XuWFQu0F8/+APDNx0k588rU9JJ/L7iAdIA70+RwoNDlNILt4P2lcyicpp
         Nvo65tha51vT8wcGRX8o0pfud42Mk1OsLhD18T+vQD+rJFdCTCoO6k7WQPJCIbJy8lNl
         2AzTDTfDFjw2DC6g27iIsPPloXoIswKeyL4OnM+NbhxT7CffNcenzbdX+SYsx7PcyfIi
         5QBVcstObPjIs95dz5bMziGgbpCuK/Nl1Th4xqxmUkZWTuh5l2/AQ7Ue4BfAtVkpTn0m
         ggy619TdRWDahvGyu+t93eUmEETCBpr34kGzV/IhfSYSxplXitBiaBy1lJ/NiEO7lHUP
         cAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEaJ6YB8d4FIAaMjgXzNMuEqob0DzD6lN5nUPjsUELxlFT9+LLKG3RdNloRud7qVNMDByCvffiSMre7nyy@vger.kernel.org, AJvYcCVsjU/bWks9rQqEU4300XLGAu16Z8hfWNweLJmSBfZgEKgkTp9qvFf+ZZ6C6L3LoWy8vIqiTYX+c/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnllZ5nsD67o5WNg9F6kw0mjVjNsRegsNI6pZ2li4AS7/z6Va/
	YNm6H0Qk2tRwwDN11rca7TEVmr49hSTN18r5AZJ6Aqa8GySjD0v0Xq7vNg==
X-Gm-Gg: ASbGncvjcDV/AgSZZi2YP6TBgsSHCkpj3LiCXt7wkJ0L0hiWVQ5JmC70P+Pe7++essu
	OuF/tny/lZcpdFDRmwMX+OEXTcFs+D9SYb3CKcWsAgSP6mlkH0Mk6gezCcWrg0JRGpqbu22tP/J
	6Xd0WEEn6o6DLmuGwGVoGxFn9kooV6FHPH82yTKdcd76s5izah0jUelWiLDWBP8IZLoNHmgxCzk
	InOLXHjnvab2IUTaS/WDzS6OXdwldnpuytp3pd2icOb+ynhhMLLpUZ+6xetwzcWZZAnPUDfJ0n3
	nUwNiqsF1OUmYyEfY2xBAP/n977eqB4/JSLa7hMHPB6IX23uM0xYQdlp68vftzcv0jQsZMDue1C
	7LAczj5BdcNS60BFabh5hjw4eNtf5OiF/14dKnfH7YoU=
X-Google-Smtp-Source: AGHT+IE8u6h0bQC+DULWBH2NDjFpszCnW/vy3eGoKMRIVQwS4iMAhPT7u9pp6vnsTsRO/tEQiBTFnw==
X-Received: by 2002:a05:600d:2:b0:431:5d14:1cae with SMTP id 5b1f17b1804b1-433ce427ccdmr11712835e9.19.1732257633254;
        Thu, 21 Nov 2024 22:40:33 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:182b:b217:1455:c275? (2a02-8389-41cf-e200-182b-b217-1455-c275.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:182b:b217:1455:c275])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde06ed1sm16810415e9.6.2024.11.21.22.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 22:40:32 -0800 (PST)
Message-ID: <74c7ab43-3862-4d92-a86c-ef2546fbb68d@gmail.com>
Date: Fri, 22 Nov 2024 07:40:30 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: Use __cleanup for a few ROHM sensors
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732193263.git.mazziesaccount@gmail.com>
 <2f321215-2ca3-4249-a9f0-427004c95d70@gmail.com>
 <37bba4fa-34c6-4b7c-ae65-75929213a8f2@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <37bba4fa-34c6-4b7c-ae65-75929213a8f2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/11/2024 07:10, Matti Vaittinen wrote:
> Hi Javier,
> 
> On 21/11/2024 15:54, Javier Carrasco wrote:
>> On 21/11/2024 14:04, Matti Vaittinen wrote:
>>> Use __cleanup.
>>>
>>> The series converts the rest of the ROHM sensors (maintained by me) to
>>> use guard(mutex). This simplifies the error paths.
>>>
>>> As a note, kx022a accelerometer driver is handled in another series,
>>> which also adds support for two new accelerometers. I did also patch the
>>> driver for the BU27008 and BU27010 - but when I was testing the changes
>>> I found that the BU27008 status is set to "obsolete". I'll try to dig
>>> some information about the BU27010 and decide if having the driver
>>> in-tree is still worth the effort, or if I should just send out patches
>>> to drop it all. Hence patch to rohm-bu27008.c is not included in the
>>> series. If someone is actually using the BU27008 or BU27010 and wants
>>> to patch it - feel free to pick
>>> 131315de97ff ("iio: bu27008: simplify using guard(mutex)")
>>> from
>>> https://github.com/M-Vaittinen/linux/tree/bu27008-cleanup
>>>
>>> ---
>>>
>>> Matti Vaittinen (2):
>>>    iio: bu27034: simplify using guard(mutex)
>>>    iio: bm1390: simplify using guard(mutex)
>>>
>>>   drivers/iio/light/rohm-bu27034.c   | 73 ++++++++++------------------
>>>   drivers/iio/pressure/rohm-bm1390.c | 78 ++++++++++++------------------
>>>   2 files changed, 55 insertions(+), 96 deletions(-)
>>>
>>>
>>> base-commit: adc218676eef25575469234709c2d87185ca223a
>>
>> Hi Matti,
>>
>> Both patches look good to me, but I noticed that you kept a few
>> mutex_lock() + mutex_unlock() in both drivers, in particular in the
>> cases where a scoped_guard() could simplify the code. Did you leave
>> those cases untouched on purpose?
> 
> Thanks for taking a look at the patches. Much appreciated :)
> 
> I remember leaving couple of direct calls to mutex_lock() and
> mutex_unlock() - but I think I left them only to places where I saw no
> real improvement by the use of guard() or scoped_guard(). It is likely I
> considered the locking in these cases being trivial. (Probably only for
> a duration of one or couple of function calls, with no error handling
> when a lock is held). The direct mutex_lock()/mutex_unlock() has no real
> room for usual errors (like leaving the function while lock was taken)
> in such case.
> 
> For me,
> 
> mutex_lock();
> ret = foo();
> mutex_unlock();
> 
> is as clear as it gets. I don't think scoped_guard() has benefits there.
> On the contrary, for me the scoped_guard() would be more complex and
> less obvious :)
> 
> Yours,
>     -- Matti
> 

Yes, the cases I saw had very restricted scope. I just wanted to make
sure that you left them untouched on purpose. Often such refactoring of
mutex handling opts for removing all calls of mutex_lock/unlock to avoid
mixing both approaches in the same driver.

Personally, I like the scoped_guard() for short scopes too because it is
more robust if new code is added in that scope. But that is just a
preference :)

Best regards,
Javier Carrasco

