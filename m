Return-Path: <linux-iio+bounces-17922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DDFA84A91
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A1D16B93A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F41F03F3;
	Thu, 10 Apr 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnzZaNqD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD31E9B14;
	Thu, 10 Apr 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304309; cv=none; b=rKYXAH2gYeQUY+qByHn0YMcs3ql0feP+3DGxeYMm0I6bu33xS5UvXtwomBilWjWRqY0xNZRelcI1Gsb7G+nG1a24HkBi7KiOLy7h5yt3kx+kVFx1GniYa8vr8UR6yTkZbA8b6NvGdwrPz1MMnALWh3f3dJm++B9bLJa+8AFpHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304309; c=relaxed/simple;
	bh=QSrLQbtKHzNu7BnbMHKydpM2WZqiXvwGP3dlepduIZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkkokOJ9bRUeLEvRdzx41ZIDjKlD0l0kblkAQZ9YoulaEReLzV7oXXVK3JUkyDpedZo/MmOCNpYcpF0pBjsDtxV2ARiAUwg9CdVX1UGmtZT0TF+DOuWmenSnvSShQL86z0poZv7oT4c+FAlGrOW9wShIwJt71BYYFMXoZ341PzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnzZaNqD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso1123658b3a.2;
        Thu, 10 Apr 2025 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744304307; x=1744909107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fb4ywqjWz2GIsG+JDj8glrtq3YuAKw64ngABr/SVSQY=;
        b=HnzZaNqDJFm8O3uQ4kczWO+1QxUNPrGQ7fBiQO6VU63Qf1E+A+xpytbBnwEsm6aPDG
         3AiW6GhNENqD2VuqJ1El1ETi4GnRLSerJpzP3rTSloOLpk8QO1RLsVaplBSONKMYI/5T
         2y1uNfaI43W+xUu2Iw8j1bZmsfcdxipEwvu4l5x41/Ox8Kww0CDqezaCkOD9bedwWvAP
         hjasGsncuFTZYR9I7tygpQ/3vKrVyFSvaX2Qgqj/ChBW59bzlVaUAhB60oWJ/E8eBk/j
         e2F0F1WRmqJY2zO49VPRL4zfhqbW8ardyrHNcYZ0jZ5m7EpRg9b443m82akFuwR9Keff
         WwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744304307; x=1744909107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb4ywqjWz2GIsG+JDj8glrtq3YuAKw64ngABr/SVSQY=;
        b=cDPg+vXZAP5UW5gvz/vVURaQLdVPUkwcSG/yZLsmEO/7+n68kr2lEugRI/okG5WPpt
         otsrcWQURtmwCT2nlmrzuMyRE9rFDNTiVnQHnEnUUmPWEUFUWpq7mMDuxGHC1woUYoyd
         EafehhkkSSSpN6PpJB3PJ3eBWuvRFdlFYOZhm8nbd7uS7IvvzRW5UTeQgwzhfGlVwdwd
         QnYgUNe1/qrszpGaYB9v6ljkawcbsi7HclN7wRS/5Udz2eaNB0SOGa4xRIQy8+0CZxxe
         8hBC8xDFu4o0B+v1l8UYwdedwSZgNeJD9yHfizAMxgDGLBEl4CUrpkXIsZU19p6V1UQr
         ZnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJG1DfYhs4BT7UWo8dq4M2QN6RS9M7LeyRrJu+hBXppUSZ+yoUkyOnOyBIJ8mQnUPQzA7lnBNhWggFqBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vk1Fl32oIHdJZRp0Z6igh5hdM7GeSj0RhRSwTV8XEw3zJi69
	Jbxr7SjDM08D9l/mU2nrVIUDQAeQCXCTEn5cOP0WMqNEq4RWtZI5JbFMbs2s
X-Gm-Gg: ASbGnctk8R7nQ05Oeuq1AWeNLunjWqX4FeuEFsXmmHmEiJBe9KR/ZfIIF7m8NkpcA7s
	0mFgx8gSSeyf35FHCT9SmdCX9ivv3Ro+yq28T6p5MeVblziwM7gaRNqOAX5K4YnD5/Gn2gOnWv4
	lzIqhNJX/Crk7NOv3kbSrOcqnYAUAihXJvfwYUduwnTyDAbqEcPYW78G7YbV6aLN6pXAXbTkgl+
	A4nW7dx/75y40cjSyjkgv9Knh+hgWl+ejEW4ylm6qybPRoMscQ/PWgzCXhytCwudPoA9CgpwKIT
	UgYtWghM/YfsVILZj10MgfUXGIRVOyW4ZZlOMEpXoTx4fEDCinv/FlcZRbzPVNEegcKHxHafJFp
	FTPLXo12k6cIdVL+RZw==
X-Google-Smtp-Source: AGHT+IG0e8qIqAIM5EIct+y0ySqTLEOJKSzlXpmPtTuYYh2lvIRJSPXsoYZJ+u7VgR1oUo1i/OLpow==
X-Received: by 2002:a05:6a00:2185:b0:736:5dc6:a14b with SMTP id d2e1a72fcca58-73bbee82aa0mr4935340b3a.13.1744304307109;
        Thu, 10 Apr 2025 09:58:27 -0700 (PDT)
Received: from ?IPV6:2409:4080:204:a537:70f5:9c3d:61d0:62b9? ([2409:4080:204:a537:70f5:9c3d:61d0:62b9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d6ae7dsm3532778b3a.82.2025.04.10.09.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 09:58:26 -0700 (PDT)
Message-ID: <c3ad805b-4ccf-4218-8b81-66a8977e2928@gmail.com>
Date: Thu, 10 Apr 2025 22:28:20 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: Fix use of uninitialized
 variable status_pos
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409200151.201327-1-purvayeshi550@gmail.com>
 <3ed7564cf2749ee207da8ddc5ef06b54d8aea881.camel@gmail.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <3ed7564cf2749ee207da8ddc5ef06b54d8aea881.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/25 16:39, Nuno Sá wrote:
> Hi Purva,
> 
> Thanks for your patch... See below
> On Thu, 2025-04-10 at 01:31 +0530, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> drivers/iio/adc/ad_sigma_delta.c:604 ad_sd_trigger_handler() error:
>> uninitialized symbol 'status_pos'.
>>
>> The variable `status_pos` was only initialized in specific switch cases
>> (1, 2, 3, 4), which could leave it uninitialized if `reg_size` had an
>> unexpected value.
>>
>> Fix by validating `reg_size` before the switch block. If it’s not
>> one of the expected values, return early and log an error. This ensures
>> `status_pos` is always initialized before use and prevents undefined
>> behavior.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   drivers/iio/adc/ad_sigma_delta.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad_sigma_delta.c
>> b/drivers/iio/adc/ad_sigma_delta.c
>> index 6c37f8e21120..d3b59d90b728 100644
>> --- a/drivers/iio/adc/ad_sigma_delta.c
>> +++ b/drivers/iio/adc/ad_sigma_delta.c
>> @@ -568,6 +568,11 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void
>> *p)
>>   	else
>>   		transfer_size = reg_size;
>>   
>> +	if (reg_size != 1 && reg_size != 2 && reg_size != 3 && reg_size != 4)
>> {
>> +		dev_err(&indio_dev->dev, "Unsupported reg_size: %u\n",
>> reg_size);
>> +		return IRQ_HANDLED;
>> +	}
>> +
> 
> Use the switch case for this. Add a default branch for the invalid case. You
> should also use dev_err_ratelimited() and instead of 'return IRQ_HANDLED', do
> 'goto irq_handled'.
> 
> Thx!
> - Nuno Sá

Hi Nuno,

Thank you for the review and guidance.

I’ve updated the patch to address your suggestions and will send the 
next version shortly.

Best regards,
Purva

> 
>>   	switch (reg_size) {
>>   	case 4:
>>   	case 2:


