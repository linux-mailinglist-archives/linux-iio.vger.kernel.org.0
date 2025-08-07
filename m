Return-Path: <linux-iio+bounces-22416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CEB1DEA8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DB27A4705
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F68B234964;
	Thu,  7 Aug 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nE2EqqIR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E11D6DDD
	for <linux-iio@vger.kernel.org>; Thu,  7 Aug 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601256; cv=none; b=jD+ltGQOyo62NL1eTYm2zUUPnZ953sPAMFXZKH9v4VbHwAoqfdGHEgn0nGeldFu0OdjXlRc4TNEmB0CLlHG3R1W5iytjaX5qcub8GxGnXWjDB2j6tuUmRmYeQtNW7VKDd1XV0mzWQsmwgZxX8BrgDRv5RkzyKX73bmj0cYj9zXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601256; c=relaxed/simple;
	bh=6Ayw09XT0CJz0Davh7kiq/R8BbFGczRapmLwMv6Khv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9/ZFUvRvpxuv2zB+oo1pIDJOWtrLwq+xX7QCn34ffzmVF1XRMAymDRlRrOwre0zG2ZECS1GGveUalQ0KCA8xGf+hfj6PfzZtiCmSxTddmKfzIU4mT7kSuxF2n0n7/vhlw90VjfbkrxQ4LsYRKNqCnVzLkBU7Ga7MiB+N734Ox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nE2EqqIR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30b8c77361eso356173fac.0
        for <linux-iio@vger.kernel.org>; Thu, 07 Aug 2025 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754601253; x=1755206053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DbhLy+bgAv/5STLGUWAxLuPMJo5W/Wh/oHq0DyHIT4=;
        b=nE2EqqIRaRRauw7KP8cFK2MrVBj+UoU/U3m4hGMl5sePIbpIbM04V5AiKDIOJmnS8P
         e2sLFnevRLmd2KM8RD+n76kqRHlElSbW8TM7tNDJfYWqXrOGNDkuXWfHlXXZqB7OTjgq
         NNFP4XGAVlZ40u60sUz8o/OTLfvx+IvV7KWSpjGWLQKMP7HROfdn2kHdhJ7p61xUx1aO
         G6KcnHbytHO7NHmCYFkV4urrRv7kAPuEmqH3Xan0PxZ6cl146eraU0+vTHlfkzXu2t7C
         qnfwdVhX9js1GSrvYjLUJcvlN3A9/QfrkUT2pvW58y3e1IhlL0JI8Ag6HR+s5hsShsuz
         DzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754601253; x=1755206053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DbhLy+bgAv/5STLGUWAxLuPMJo5W/Wh/oHq0DyHIT4=;
        b=r8lhCYPCq03KPEu9/N52MfeoFio0eKSIbZUqIJ7MN6I1sQ3tzuNJqDSzEhDRtNTttv
         TXT5D1UqLLg2TfBvwddKTaWywNlAm4khLcQsIt7CmRkRw+yZckaLGcVz15HjXIwOPVFm
         SCmLis9VTea1QtqAHSDNEIK9f6ftUZvfJ9gP/aAdd26SHttclqbe0WmSj20F4gpi0MUm
         Kd4gFy9xjjgf27HGXsQxtOGUWmXRzDH+2pJEo+tw4SWo7J/geIgvSlhYL6VVW2o4/6vU
         CDjkgJlf3gSHoN01HNefggNEwGAmDwzhnKa+YSSJnnGLN/kw2KbIILgB80J9/A63DVYU
         FT/g==
X-Forwarded-Encrypted: i=1; AJvYcCWtsrmSuO+oW2D0nfUZKbghgl1erYgKzTleLD5fD9egwa70oEVrdRwnstCYzev+yQlzAdE8JQ9oihE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1RZnH6L7yaW603DShaUkb7RR8Jei8tb7cGuolIwhNuef9cv6
	QTa2yPXz3ayhaJiomRDYTB3bPrtzzuqNcrMGNsavbnFO4DruJNhyj5AwzvpBkJqeogk=
X-Gm-Gg: ASbGncsKWHhglAsvtp9m72Q76DNctz8igWYSijqtnoHyB9GMKxpD/tI46rpDxAOwgPa
	rWGyzoWb1p6raWpNViiDnvFsXTjMYV9YwWCKl6/ZGj7RKJNF1u7ryzMnWWnu0DIUlByicZLFLwO
	AH2LXWGDtzz6wkiwUja9LX5koZ4xJqokwdddWrwctjUHdWzGwubKEFQ0ppSUVALlvQ9A5jgncny
	8DTDbpJZJfXMsAkzCLrHXbJBUzqBbOKpJXJJQAHWYxEew+3bPYsiBGSmgoL5U7bViWyoACFL/A3
	5ir2/QcuOEO/NpA2axj3CtZXRbzYXsCdZkb3KPkrCRn38VAM7nUIC2iQQgwtFv08hkYD/dtYEyq
	nGQ2vC4iqrcPAgwwnMOWXpzSbbKbbbn+9gaAcXZXIheHS5Qo6WfXZICDSLFJLqV2FbflFVVNoCY
	ACZ+sgDzQK8Q==
X-Google-Smtp-Source: AGHT+IFCDFI5gLxcHkj/bB1qPktW/LvlhD6IbJboJThqZ2SohEA5Ma0Ti6VC/8SoqWmaCS4NRH7TfA==
X-Received: by 2002:a05:6870:3d8f:b0:2ff:89c8:44f4 with SMTP id 586e51a60fabf-30c20f959ffmr468667fac.11.1754601252939;
        Thu, 07 Aug 2025 14:14:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ce54:d09f:5709:ac85? ([2600:8803:e7e4:1d00:ce54:d09f:5709:ac85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30b93b644d9sm3319195fac.30.2025.08.07.14.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 14:14:12 -0700 (PDT)
Message-ID: <c8189da5-f660-4500-b3b3-246913453ad5@baylibre.com>
Date: Thu, 7 Aug 2025 16:14:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJReTh-t5D45aZNV@pc>
 <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
 <CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
 <CAHp75VfEC3qUurUO4LKA1d6_Ot15AHY2zG9tk3wWrtYAgHrHgQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VfEC3qUurUO4LKA1d6_Ot15AHY2zG9tk3wWrtYAgHrHgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/25 4:02 PM, Andy Shevchenko wrote:
> On Thu, Aug 7, 2025 at 11:01 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Aug 7, 2025 at 6:03 PM David Lechner <dlechner@baylibre.com> wrote:
>>> On 8/7/25 3:05 AM, Salah Triki wrote:
> 
> ...
> 
>>>>       ret = __ad4170_read_sample(indio_dev, chan, val);
>>>>       if (ret) {
>>>> -             dev_err(dev, "failed to read sample: %d\n", ret);
>>>> +             dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(ret));
>>>>
>>>>               ret2 = ad4170_set_channel_enable(st, chan->address, false);
>>>>               if (ret2)
>>>> -                     dev_err(dev, "failed to disable channel: %d\n", ret2);
>>>> +                     dev_err(dev, "failed to disable channel: %pe\n", ERR_PTR(ret2));
>>>>
>>>>               return ret;
>>>>       }
>>>
>>> Interesting, I didn't know we had this format specifier. But I think
>>> this is something we would want to do kernel-wide or not at all to stay
>>> consistent.
>>
>> I'm sorry but I didn't follow. This is a kernel-wide format specifier.

I meant that it would be strange to make this change just in one
driver and not do the same everywhere else.

>>
>>> And if we are doing this in more places, it would make sense to have a new
>>> format specifier for integer error values instead of casting them to
>>> pointers.
>>
>> Will _very unlikely_ to happen. This has to be a C standard for that,
>> otherwise you are suggesting to always have a kernel warning for each
>> of these cases. The only way we can customize specifiers w/o
>> introducing a compiler warnings is to continue (and still carefully)
>> using %p extensions.

OK, makes sense.

> 
> And to be clear: I am not in favour of this change exactly due to a
> bit weird (for the reader) castings just for the sake of use of %pe.
> 
> 


