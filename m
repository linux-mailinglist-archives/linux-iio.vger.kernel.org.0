Return-Path: <linux-iio+bounces-20056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF5AC955A
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915A717503A
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08994264F9C;
	Fri, 30 May 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UzFaXL9t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21B25DD12
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627824; cv=none; b=SOqiHnG/r4WvhAy5xWvwhJFNKL9EWBJTcXJQhXCFyS+WAkICm+UWH09Zxi0MI1jRUWcHPzSKoW+dlQr03oNE8G2TDxMi0tPbGLGtysltQf8E2wG6FaTRoOic/a2CczxaVjoGA9wM0R/oD50xq12F7I+cwwBQGCUAVtAyNtqhyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627824; c=relaxed/simple;
	bh=nm9X/o0rnIPx+UiF+N8RenENBKrI6eSudR1LE2HsIS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWROYeCFipeRxh2sO0wp0KRlfieKpCATmbQMfq+m+AepWsxhlq1lL0XthBSzf8C5ILYrPrgMmHpZeWHgJkmGFK96v9xExGNpULdzAuViyGgBBch0/XpSIFH7XMGosG6ik+gA4sl9ULptCYnXgfqmPVMBOjeq2L+1ux6VNUyy9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UzFaXL9t; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f6aa4b3a7fso805645b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748627821; x=1749232621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeZnYkfCVMff3UHyU0Pr3VD4cGSKzPYxsrEG6mLaXt0=;
        b=UzFaXL9tc2CvtuinYhfpUkYmy7FUevGBFBqRXDCekPSbZSoxg38cdEAoipwsAzxvUh
         5h++Ig9D2UHfwg+Ak+VcPu35lFspVHiJiarKAwcIju+dCytaK2hgLjMlSL2GGfIBlSOA
         4vxQMoNZl93vrMSlCaSEBlC2ii7nRyeIY3hMUVZKcJhBrE3G3gXhNytHYX7aSxX9YPCr
         4ZtH0SHUUzSxzp6EDwuFzCPutIF6cRo6fgtO+p6Q6BoEsjyLpahXtVl8p169i9za7gh4
         4saHZGNPrBlWj9MxpRi6t4t+rYt4WiiFOmuMUyQTf9otXFyAm25l+aMVIcMaaj5vI55K
         645A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748627821; x=1749232621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeZnYkfCVMff3UHyU0Pr3VD4cGSKzPYxsrEG6mLaXt0=;
        b=EKqII6SBlUIeO37zzzdi/Py7eix50OtSnMsY4OaYo6LR9QIiSUFN1gB7/w7/UFSO6M
         lraT2dap9m2ootSjtigO5Mkq/0CENp+pmfkQOlCcYGqOCuqiihI96LmP4rkroEBIG2KP
         WmcOHmys0UR+obNWJOInwZye3hVeBFCvNVr31u1fRTDqvc3VckBGwkG91AZukNzXq1LE
         yDKFEG+TEzkxPl7PrA9Eqv8jU2C4K9igJs9ypYegu16QgR8Db+XhSaiyrLys1bIu3W8D
         mVTXspJjazW8NOyPy3pMIhRjBWGPPsZjpureGjwKF9QAcvmurEdPjOR5SM5YJYN68DpC
         KVwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyKe7ifhloTa5ssE3XNmTTHt9d9hzlb+Ia9tvmH5RAMEu/HgS29xMhOICNWmFKoXeXlHXGa4AodTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Uwjk1MmUiq76WbMW4u+FwxrDTym8FglEs9BGMgnNvuP0pjjK
	G5tL12wAwzwt2v+uE+dg/r7j4r+QMHgs1lRjb0jevUWV8CL0HfvjV70kCBhbFMlfqNQ=
X-Gm-Gg: ASbGncvJANasRzDTsLmfHUzmwsLFe16fTc82w2zePs+KszqWgwlSnONQQkV6P8+emMM
	nWrqKnny6sr4UCM6Mx1GVoU40KSNj7QUUoUeHI1MkVj5QNDpiiR6Lnbpdf1hCLc/o0mH2gM03O4
	B7s3BRcDH9ozVT/vVvkrN44YiFdbCy2iQ+caeahXVG00H9Hz0Qo9XJClxSavBw+SBMAPG8LDppI
	OBHJxgZclAiOw1zlnZrSijwf6vjXko9pDx95VutXKe8udw6JxSp+S5IrtwqdsULUnwfuzsiItFC
	7b/JzUpMveVHZDc4iBxe/T45dWVbtMHccykoEeykt7vJc/adZFJWbeGd9LpIP3GQh+IhiCEtOw8
	uyYnCMqLFVk9GIRc3nUUFi9j528Nj
X-Google-Smtp-Source: AGHT+IFeZges+t7xbl1VwiaLWGoDo7alb7u+ilJSAME1U6eD/uMKl4m8/mgL+Q3wzRQTnPYPMB9OHA==
X-Received: by 2002:a05:6808:81c3:b0:402:1016:e9cf with SMTP id 5614622812f47-4067974cd95mr2499573b6e.34.1748627821322;
        Fri, 30 May 2025 10:57:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777? ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af8522a9sm658347a34.18.2025.05.30.10.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 10:57:00 -0700 (PDT)
Message-ID: <6825fc30-d8ef-4a10-98ec-79ed303dd145@baylibre.com>
Date: Fri, 30 May 2025 12:57:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
 <ed40509d-9627-43ce-b209-ca07674988ff@baylibre.com>
 <CAHp75VeAOFXuxsiAEwJ=dMJ8NZsyA7E-h4L=2ZgpprdUXU2EUA@mail.gmail.com>
 <67c33f11-0196-44f4-9cdd-762618cb88be@baylibre.com>
 <aDnwMDGDf3-KUb3J@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aDnwMDGDf3-KUb3J@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/30/25 12:51 PM, Andy Shevchenko wrote:
> On Thu, May 29, 2025 at 01:49:16PM -0500, David Lechner wrote:
>> On 5/29/25 1:16 PM, Andy Shevchenko wrote:
>>> On Thu, May 29, 2025 at 7:02 PM David Lechner <dlechner@baylibre.com> wrote:
>>>> On 5/24/25 5:34 AM, Sean Nyekjaer wrote:
> 
> ...
> 
>>>> fxls8962af_suspend() calls enable_irq_wake(data->irq); before disabling the
>>>> interrupt by calling fxls8962af_buffer_predisable(indio_dev);
>>>>
>>>> It seems like the order should be reversed.
>>>
>>> AFAIU the wake capability of IRQ line is orthogonal to the interrupt
>>> controller enabling (unmasking) / disabling (masking) the line itself.
>>> Or did you mean something else?
>>
>> I don't know enough about how suspend/wake stuff works to say for sure.
>>
>> I just saw the comment:
>>
>> 	/*
>> 	 * Disable buffer, as the buffer is so small the device will wake
>> 	 * almost immediately.
>> 	 */
>>
>> so I assumed someone had observed something like this happening already.
>> If an interrupt occurs between enable_irq_wake() and actually
>> going into a low power mode, what effect does it have? I ask because I
>> don't know.
> 
> To be a "wake source" means to be capable of signaling to the system that wake
> is needed. If an event comes after enabling an IRQ line to be a wake source,
> that should wakeup the system (independently if that IRQ line is disabled or
> not on the IRQ controller side).
> 

OK, more clear now. So I should have been more specific with my previous
comment. When I said, "before disabling the interrupt", I didn't mean
calling disable_irq(). I meant disabling the actual output pin on the
accelerometer chip.

