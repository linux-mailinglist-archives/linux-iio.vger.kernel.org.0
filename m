Return-Path: <linux-iio+bounces-19239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E0AAE0D0
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B7F7A555E
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BD78F4F;
	Wed,  7 May 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w4NvAzdC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1A4B1E56
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624791; cv=none; b=ooH0hBubCpL+AjYi4SaWFfswfTISTBHX9I1UAfbhhNa/qar8gTdd7R35GJw5yqcYO3Mf3GHWVU5zTvDnJNwoUgt3mCSrogobWb3cnmVJcYM6RnA7kvmZcL0HBTMxhRskZiFsss0r4StQcf0mGi/whU3yUDdyzRqpHYPfBJ3JltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624791; c=relaxed/simple;
	bh=G/7ZctG7qSsqemrErg12KB/zrN7/XP5vD+I3LXxG5Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8oAc422HwVECdW9M/4giRFFNYfmPJhUNa9j72esjnGqNRgO1hjmj1YS8t69nzu8BDbG9WFVkhwQa6DMtWxd8gGN7WF0nnd4Xjx/eWHbShzlELH6v/Dmo6ZLkGLgfzRTiHyArU9is9Wl4n9q6KzWXiMHtV03C/AX+HHkrvErcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w4NvAzdC; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2da3b3bb560so4321636fac.3
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746624788; x=1747229588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zk5eTSR5rnrxNunlvkyBQ8p0h1NyhZGSDRFODw4kIWE=;
        b=w4NvAzdC+AkC1p/jtCuKkQYQL+U7QwsPxgLRSNfwiyCH+fbOo144d4H1D4zA6a0mhr
         l73TtkCfOI4XizFDCPRjNrr46rnIAotr3pxg8iyeIiRgprF8WLpfOIo9aWSRDZ4psVxu
         k9Gp7aOrl4M0cLN9AgzR6LmfldvdymGuKrMlV+zyk6zLHgfyS+y1omBxv7R7Uhuqfnjx
         qeS6+KtZP3FsyQbwaFmqoP5auNvkflf5pbzAI7muYaTLvHvdIsc4L2Fh3b8Dd9KX+wav
         tFvCVk3aOzCv9UgyhCXpYyScuyCYf/fwqzglzOJMNfLRpi2vbRe/nYZ9HTxMDaLwFNWQ
         Cp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624788; x=1747229588;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk5eTSR5rnrxNunlvkyBQ8p0h1NyhZGSDRFODw4kIWE=;
        b=F8kMH83bD65NUTxjaoy3Bg7aKgBO6ISnYnTN013V+37mQw9M29egVP4tKnRgYz8x51
         lpVhRTjKL/snFGCvKsGUnUxPGtuHMLSmgxG499QH4y/v4MZqhGv3lgYIxwRGgyGpsdVy
         fS7uXIxEn1uuwGnCI2IiKzWtktAvLryI1ZIZ2jN+T14LeKf+Q25Mi4YtPTSv4XXlCoTk
         zw85FscV6Zek9mtWE8HrociXauDxLJCcKBL7FM664ADXgQF5NZCxlMtebzECww0Obuw5
         d98dijFWyob57rf7s8SCE7rUyFxmQQgBch+zPxfolMo9W3k/LpEwfIgdpcK9oFaqEw1b
         jYcw==
X-Gm-Message-State: AOJu0YxngibmmBrsIwBpAw4wedbMQhhRkIVe+SB74nYNmIpCtEDh0qen
	rIT4soPQO/iWAIlslnHSxi1obyn+wfljMigxCenjP1f9oMQbVxwl9QOXj4G8Xe5kPDk8da+9IeE
	N
X-Gm-Gg: ASbGncuijJJOfFyU/a72sIaMWImQfjzCFb5cTp+om0QFdf5eIK71FI5yBGycT/J+fq/
	xJz2gBCX/Dm3VRZioXA/ik8+MeffoIZWK17nJStabY3+UaNx0P6jzqt8NbBzkTdp8h0zzrW5nZ7
	J3m9pe3oRjEafk3QAl16fHM91JpS0VzDVz+9F0L89+qmvOZQ34krYrP1WUbzs2raEq2PQghhdQ5
	twcRucGKd8GLGkEuWW1ozrBhkzzO/uQdD21AC78qwl5vuQtW+NcdLNAEo2IYPfxa0mlLDj8BcVA
	gAAVWTEVOVlNt38qhslCQ/Nh2IKc9G9l50OZBRiacw0zSRA35ozfhAkW3TufsixrhwglLu4aubd
	m3SUQz1jeBSi1UDM=
X-Google-Smtp-Source: AGHT+IEAtvGYLTufM2nQshAbcHENn1L9GPviMkdUy9Xs2Q5n0XmmEzjpQiZhJqb//mLB8HX91mycfA==
X-Received: by 2002:a05:6870:7181:b0:2c1:ac88:4a8d with SMTP id 586e51a60fabf-2db5c0b188amr1987196fac.30.1746624788229;
        Wed, 07 May 2025 06:33:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3356:f6f6:bf76:a32? ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5d05fa58sm589764fac.40.2025.05.07.06.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:33:07 -0700 (PDT)
Message-ID: <b85aa946-aa5f-40aa-8d22-19a9d916f5a0@baylibre.com>
Date: Wed, 7 May 2025 08:33:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
References: <aBoBR5D1UMjsSUfZ@stanley.mountain>
 <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>
 <aBpWXB8c8RSjYBtD@stanley.mountain>
 <FA0C8BC9-FD7F-44B7-A4A8-EA5E5BC6C8C7@jic23.retrosnub.co.uk>
 <aBsOqAI0efLHGbeA@stanley.mountain>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aBsOqAI0efLHGbeA@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 2:41 AM, Dan Carpenter wrote:
> On Wed, May 07, 2025 at 07:35:27AM +0100, Jonathan Cameron wrote:
>>
>>
>> On 6 May 2025 19:35:08 BST, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>> On Tue, May 06, 2025 at 09:25:00AM -0500, David Lechner wrote:
>>>> On 5/6/25 7:32 AM, Dan Carpenter wrote:
>>>>> Hello David Lechner,
>>>>>
>>>>> Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
>>>>> from Apr 22, 2025 (linux-next), leads to the following Smatch static
>>>>> checker warning:
>>>>>
>>>>> 	drivers/iio/pressure/bmp280-core.c:1280 bme280_trigger_handler()
>>>>> 	warn: check that 'buffer' doesn't leak information (struct has a hole after 'comp_humidity')
>>>>>
>>>>> drivers/iio/pressure/bmp280-core.c
>>>>>     1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
>>>>>     1226 {
>>>>>     1227         struct iio_poll_func *pf = p;
>>>>>     1228         struct iio_dev *indio_dev = pf->indio_dev;
>>>>>     1229         struct bmp280_data *data = iio_priv(indio_dev);
>>>>>     1230         u32 adc_temp, adc_press, adc_humidity;
>>>>>     1231         s32 t_fine;
>>>>>     1232         struct {
>>>>>     1233                 u32 comp_press;
>>>>>     1234                 s32 comp_temp;
>>>>>     1235                 u32 comp_humidity;
>>>>>     1236                 aligned_s64 timestamp;
>>>>>
>>>>> There is a 4 byte hole between comp_humidity and timestamp.
>>>>
>>>> Yes, this was the intention of this patch.
>>>>
>>>>>
>>>>>     1237         } buffer;
>>>>>     1238         int ret;
>>>>>     1239 
>>>>
>>>> ...
>>>>
>>>>>     1279 
>>>>> --> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
>>>>>                                                         ^^^^^^^^^^^^^^^^^^^^^^^
>>>>> So I believe it leads to an information leaks here.
>>>>
>>>> Aha, so we should e.g. do memset() to fill the hole first.
>>>>
>>>
>>> That works, or you could initialize it with = { }.
>>
>> I tried to track this down the other day.
>> What are compilers guaranteeing around
>> that vs { 0 }  and holes?  The c spec has only recently standardised on { }.
>>
>> I'd love to stop using memset for these.
> 
> The rule in the C standard is that if the initializer sets every struct
> member then it will NOT zero out struct holes.  But if there are any
> unset struct members then the holes are zeroed.  So = { } will always
> work.  You really have to try hard to invent a scenario where = { 0 }
> won't fill the struct holes (a one member struct with a weird alignment).
> 
> regards,
> dan carpenter
> 

I was curious about this too and came across a blog post [1] that claims that
with clang compiler and certain optimization levels, { } and { 0 } still aren't
good enough, which is why I went with the memset().

[1]: https://interrupt.memfault.com/blog/c-struct-padding-initialization


